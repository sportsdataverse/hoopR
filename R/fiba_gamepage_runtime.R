# fiba_gamepage_runtime.R -- the fiba.basketball game pages: URL, RSC payload, refusals, parsers.
#
# R mirror of the game-page half of sdv-py sportsdataverse/basketball/fiba_hub/fiba_runtime.py and
# of fiba_gamepage_parsers.py. A game page (fiba.basketball/en/history/<histId>-<histSlug>/<comp>/
# games/<gameId>-<A>-<B>) requested with `RSC: 1` answers a text/x-component Next.js flight payload
# holding the box score, play-by-play and shots, which GDAP does not serve. The URL is resolved from
# GDAP (the competition's marketing name gives the slug, its schedule the two team codes); the
# game / playByPlay / gameDetails / playersTeamA / playersTeamB objects are cut out of the payload
# and their flight tokens resolved (any other `$` token fails closed).
#
# Refusals: hoopR_no_data for a game GDAP does not know, a listed game without its two teams (not
# drawn yet; a null teamA / teamB object counts), a page with no box score (before about 2006 or not
# played yet). hoopR_asset_fetch for a game of another edition than `comp` (wrong scope, refused
# before any page request), a page that is not text/x-component, the HTTP 200 not-found shell (a
# wrong slug, team-code order or competition: no game header for the asked id), an unresolvable
# flight token, a page of another game or competition, a game still live.
#
# Transport: sdv-py uses curl_cffi with Chrome TLS (plain `requests` gets HTTP 403); libcurl with a
# browser User-Agent is served (checked live 2026-10-18). 4 attempts, 429 / 502 / 503 / 504 retried.

.FIBA_BCL_URL <- "https://www.championsleague.basketball"
.FIBA_PAGE_KEYS <- c("game", "playByPlay", "gameDetails", "playersTeamA", "playersTeamB")
.FIBA_ANCHORS <- c(
  game = '"game":(?=\\{"gameId":)',
  playByPlay = '"playByPlay":(?=\\{"items":)',
  gameDetails = '"gameDetails":(?=\\{)',
  playersTeamA = '"playersTeamA":(?=\\[)',
  playersTeamB = '"playersTeamB":(?=\\[)'
)
.FIBA_PAGE_ATTEMPTS <- 4

# ---------------------------------------------------------------------------
# The flight payload
# ---------------------------------------------------------------------------

#' End (character index) of the JSON object or array that opens at `start` in `cp` (the text's
#' code points), or `NA` when it never closes. Strings and escapes are honoured.
#' @noRd
.fiba_json_end <- function(cp, start) {
  sp <- which(cp %in% c(34L, 92L, 123L, 125L, 91L, 93L))
  sp <- sp[sp >= start]
  depth <- 0L
  in_str <- FALSE
  skip <- -1L
  for (p in sp) {
    if (p == skip) next
    ch <- cp[[p]]
    if (in_str) {
      if (ch == 92L) skip <- p + 1L else if (ch == 34L) in_str <- FALSE
    } else if (ch == 34L) {
      in_str <- TRUE
    } else if (ch == 123L || ch == 91L) {
      depth <- depth + 1L
    } else if (ch == 125L || ch == 93L) {
      depth <- depth - 1L
      if (depth == 0L) return(p)
    }
  }
  NA_integer_
}

#' Replace the React flight tokens of `obj`; any token it does not know raises (fail closed).
#'
#' `$undefined` -> NULL; `$$x` -> `$x`; `$D<iso>` -> the ISO string;
#' `$<chunk>:props:<object>:<path>` -> a copy of that value inside the extracted objects.
#' @noRd
.fiba_resolve <- function(obj, roots, depth = 0L, call = rlang::caller_env()) {
  if (depth > 50L) .abort_asset_fetch("fiba.basketball game page: a flight reference chain is too deep.", call = call)
  if (is.list(obj)) return(lapply(obj, .fiba_resolve, roots = roots, depth = depth, call = call))
  if (!is.character(obj) || length(obj) != 1L || !startsWith(obj, "$")) return(obj)
  if (obj == "$undefined") return(NULL)
  if (startsWith(obj, "$$")) return(substring(obj, 2L))
  if (startsWith(obj, "$D")) return(substring(obj, 3L))
  m <- regmatches(obj, regexec("^\\$([0-9a-fA-F]+):(.+)$", obj))[[1]]
  segs <- if (length(m) == 3L) strsplit(m[[3]], ":", fixed = TRUE)[[1]] else character()
  if (length(segs) >= 2L && segs[[1]] == "props" && segs[[2]] %in% names(roots)) {
    target <- roots[[segs[[2]]]]
    for (seg in segs[-(1:2)]) {
      if (.fiba_is_arr(target) && grepl("^[0-9]+$", seg) && as.numeric(seg) < length(target)) {
        target <- target[[as.integer(seg) + 1L]]
      } else if (.fiba_is_obj(target) && seg %in% names(target)) {
        target <- target[[seg]]
      } else {
        .abort_asset_fetch("fiba.basketball game page: a dangling flight reference {.val {obj}}.", call = call)
      }
    }
    return(.fiba_resolve(target, roots, depth + 1L, call = call))
  }
  shown <- substr(obj, 1, 40)
  .abort_asset_fetch("fiba.basketball game page: an unhandled flight token {.val {shown}}.", call = call)
}

#' The game objects of a text/x-component payload, flight tokens resolved (sdv-py `_extract_page`).
#'
#' Each anchor's first value that parses wins; for `game`, the first whose `gameId` is `game_id`
#' (type-strict). No `game` header for `game_id` is the not-found shell (class
#' `hoopR_fiba_shell`, a `hoopR_asset_fetch`).
#' @noRd
.fiba_extract_page <- function(text, game_id, where, call = rlang::caller_env()) {
  cp <- utf8ToInt(enc2utf8(text))
  raw <- list()
  for (key in names(.FIBA_ANCHORS)) {
    hits <- gregexpr(.FIBA_ANCHORS[[key]], text, perl = TRUE)[[1]]
    if (hits[[1]] == -1L) next
    for (h in seq_along(hits)) {
      start <- hits[[h]] + attr(hits, "match.length")[[h]]
      end <- .fiba_json_end(cp, start)
      if (is.na(end)) next
      value <- tryCatch(jsonlite::parse_json(intToUtf8(cp[start:end]), simplifyVector = FALSE),
                        error = function(e) NULL)
      if (is.null(value)) next
      if (key == "game" && !.fiba_strict(.fiba_dig(value, "gameId"), game_id)) next
      raw[key] <- list(value)
      break
    }
  }
  if (is.null(raw[["game"]])) {
    n <- nchar(text)
    cli::cli_abort(
      c("{where}: this is the not-found shell, not game {game_id} ({n} chars):",
        "a wrong slug, team-code order or competition gives HTTP 200 with no game header."),
      class = c("hoopR_fiba_shell", "hoopR_asset_fetch", "hoopR_error"), transient = FALSE, call = call
    )
  }
  body <- .fiba_resolve(raw, raw, call = call)
  body[intersect(.FIBA_PAGE_KEYS, names(body))]
}

# ---------------------------------------------------------------------------
# The page URL
# ---------------------------------------------------------------------------

#' fiba.basketball's history slug: lower-case, apostrophes dropped, other non-alphanumeric runs -> `-`.
#' @noRd
.fiba_slugify <- function(name) {
  x <- gsub("['\u2019]", "", tolower(name))
  x <- gsub("[^a-z0-9]+", "-", x)
  gsub("^-+|-+$", "", x)
}

#' `list(family = <id>, name = <marketing name>)` of a competition from getGdapCompetitionById
#' (cached per session), or `NULL` when GDAP gives none.
#' @noRd
.fiba_competition_family <- function(comp, call = rlang::caller_env()) {
  key <- paste0("family_", comp)
  if (!is.null(.fiba_cache[[key]])) return(.fiba_cache[[key]])
  body <- .fiba_gdap("getGdapCompetitionById", list(gdapCompetitionId = comp), call = call)
  name <- .fiba_dig(body, c("competitionMarketingName", "marketingName"))
  fam <- .fiba_dig(body, c("competitionMarketingName", "competitionMarketingNameId"))
  out <- if (is.character(name) && length(name) == 1L && .fiba_is_int(fam)) list(family = fam, name = name) else NA
  .fiba_cache[[key]] <- out
  if (identical(out, NA)) NULL else out
}

#' `<histId>-<histSlug>` of the competition's family (its marketing name).
#' @noRd
.fiba_competition_slug <- function(comp, call = rlang::caller_env()) {
  fam <- .fiba_competition_family(comp, call = call)
  if (is.null(fam)) {
    .abort_asset_fetch("competition {comp}: GDAP gives no marketing name, so the game page URL cannot be built.",
                       call = call)
  }
  paste0(fam[["family"]], "-", .fiba_slugify(fam[["name"]]))
}

#' `c(teamA code, teamB code)` of a game from its competition's schedule (cached per competition).
#'
#' A game the schedule lists without two codes (a null team object included) is `hoopR_no_data`; a
#' game it does not list is looked up in GDAP: unknown is `hoopR_no_data`, a real game of another
#' edition `hoopR_asset_fetch` (wrong scope).
#' @noRd
.fiba_team_codes <- function(comp, game_id, call = rlang::caller_env()) {
  key <- paste0("codes_", comp)
  for (fresh in c(FALSE, TRUE)) { # a game the cached schedule lacks may have been added since
    if (fresh || is.null(.fiba_cache[[key]])) {
      rows <- .fiba_gdap("getgdapgamesbycompetitionid", list(gdapCompetitionId = comp), call = call)
      codes <- list()
      for (r in rows) {
        if (!.fiba_is_int(r[["gameId"]])) next
        a <- .fiba_dict(r[["teamA"]])[["code"]]
        b <- .fiba_dict(r[["teamB"]])[["code"]]
        both <- !is.null(a) && !is.null(b) && nzchar(a) && nzchar(b)
        codes[as.character(r[["gameId"]])] <- list(if (both) toupper(c(as.character(a), as.character(b))) else NA)
      }
      .fiba_cache[[key]] <- codes
    }
    got <- .fiba_cache[[key]][[as.character(game_id)]]
    if (!is.null(got) && !identical(got, NA)) return(got)
  }
  if (as.character(game_id) %in% names(.fiba_cache[[key]])) {
    .abort_no_data("competition {comp} lists game {game_id} without its two team codes (not drawn yet).", call = call)
  }
  tryCatch(
    .fiba_gdap("getgdapgamebyid", list(gdapGameId = game_id), call = call),
    hoopR_no_data = function(e) {
      .abort_no_data("FIBA has no game {game_id} (competition {comp} does not list it).", call = call)
    }
  )
  .abort_asset_fetch(paste0("game {game_id} is not a game of competition {comp}: it belongs to another edition ",
                            "(wrong scope); pass the comp that lists it."), call = call)
}

# ---------------------------------------------------------------------------
# The page request
# ---------------------------------------------------------------------------

#' The final response of a game-page request: throttled per host, 429 / 502 / 503 / 504 retried.
#' @noRd
.fiba_fetch_page <- function(url, headers = list(), follow = TRUE, call = rlang::caller_env()) {
  req <- .intl_request(url, headers = c(list(`User-Agent` = .FIBA_UA), headers), timeout = 60,
                       follow_redirects = follow)
  .intl_perform(req, retry_500 = FALSE, max_tries = .FIBA_PAGE_ATTEMPTS, call = call)
}

#' One game-page URL -> its extracted objects; the not-found shell raises `hoopR_fiba_shell`.
#' @noRd
.fiba_fetch_game_page <- function(url, game_id, call = rlang::caller_env()) {
  where <- .intl_where(url)
  resp <- .fiba_fetch_page(url, list(RSC = "1"), call = call)
  .intl_check_status(resp, where = where, call = call)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("x-component", ctype, fixed = TRUE)) {
    shown <- if (nzchar(ctype)) ctype else "no content type"
    .abort_asset_fetch("{where} answered {shown}, not a text/x-component flight payload.", call = call)
  }
  .fiba_extract_page(.intl_body_text(resp), game_id, where, call = call)
}

#' The `eventSlug` of a competition that has an event page: its history URL answers 3xx to it.
#' @noRd
.fiba_event_slug <- function(comp, call = rlang::caller_env()) {
  probe <- paste0(.FIBA_SITE_URL, "/en/history/", .fiba_competition_slug(comp, call = call), "/", comp)
  resp <- .fiba_fetch_page(probe, follow = FALSE, call = call)
  if (!httr2::resp_status(resp) %in% c(301L, 302L, 307L, 308L)) return(NULL)
  loc <- httr2::resp_header(resp, "location", default = "")
  m <- regmatches(loc, regexec("/en/events/([A-Za-z0-9._~%-]+)", loc))[[1]]
  if (length(m) == 2L) m[[2]] else NULL
}

#' The checked game-page objects of `game_id` in competition `comp` (sdv-py `_page`).
#'
#' The archive (history) URL first; on the not-found shell the competition's event page URL (when
#' it has one), then the Champions League host.
#' @noRd
.fiba_page <- function(game_id, comp, call = rlang::caller_env()) {
  if (is.null(comp)) {
    .abort_bad_request("{.arg comp} (the GDAP competition id of the game) is required to build the game page URL.",
                       call = call)
  }
  codes <- .fiba_team_codes(comp, game_id, call = call)
  tail <- paste0("/games/", game_id, "-", codes[[1]], "-", codes[[2]])
  real <- paste0(.FIBA_SITE_URL, "/en/history/", .fiba_competition_slug(comp, call = call), "/", comp, tail)
  where <- .intl_where(real)
  page <- tryCatch(.fiba_fetch_game_page(real, game_id, call = call), hoopR_fiba_shell = function(e) e)
  if (inherits(page, "hoopR_fiba_shell")) {
    shell <- page
    slug <- .fiba_event_slug(comp, call = call)
    # Note: the Champions League host serves only its current season (unverified live, as in sdv-py)
    alternates <- c(if (!is.null(slug)) paste0(.FIBA_SITE_URL, "/en/events/", slug, tail),
                    paste0(.FIBA_BCL_URL, "/en", tail))
    for (alt in alternates) {
      page <- tryCatch(.fiba_fetch_game_page(alt, game_id, call = call), hoopR_fiba_shell = function(e) e)
      if (!inherits(page, "hoopR_fiba_shell")) break
    }
    if (inherits(page, "hoopR_fiba_shell")) stop(shell)
  }
  got <- .fiba_dig(page, c("game", "competition", "competitionId"))
  if (!.fiba_strict(got, comp)) {
    shown <- format(got %||% "NULL")
    .abort_asset_fetch("{where}: the page is for competition {shown}, asked {comp}.", call = call)
  }
  details <- page[["gameDetails"]]
  if (!.fiba_is_obj(details)) {
    .abort_no_data("{where}: game {game_id} has no box score (header only: before about 2006 or not played yet).",
                   call = call)
  }
  if (!.fiba_strict(details[["id"]], game_id)) {
    shown <- format(details[["id"]] %||% "NULL")
    .abort_asset_fetch("{where}: the box score is for game {shown}, asked {game_id}.", call = call)
  }
  if (isTRUE(page[["game"]][["isLive"]])) {
    .abort_asset_fetch("{where}: game {game_id} is still live; its box score is not final.", call = call)
  }
  .fiba_scrub(page)
}

# ---------------------------------------------------------------------------
# Parsers (sdv-py fiba_gamepage_parsers.py). Teams are named by ORGANISATION id (T_64, pbp oId);
# every frame carries organisation_id and team_side (A / B). player_id is the global person id.
# statistic_system is OVR (World Cup, Olympics) or FLS (club competitions). Shot x/y are pixels on
# a half-court image (scale unverified); free throws are 0, 0 with has_location FALSE.
# ---------------------------------------------------------------------------

.FIBA_SHOT_CODES <- c(P2 = "2PT", P3 = "3PT", FT = "FT")
.FIBA_STATS <- c(
  PTS = "points", FGM = "fg_made", FGA = "fg_attempted", FGP = "fg_pct", FG2M = "fg2_made",
  FG2A = "fg2_attempted", FG2P = "fg2_pct", FG3M = "fg3_made", FG3A = "fg3_attempted", FG3P = "fg3_pct",
  FTM = "ft_made", FTA = "ft_attempted", FTP = "ft_pct", OR = "reb_offensive", DR = "reb_defensive",
  REB = "reb_total", AS = "assists", ST = "steals", BS = "blocks", BSR = "blocks_received", TO = "turnovers",
  PF = "fouls", FD = "fouls_drawn", FGIM = "paint_fg_made", FGIA = "paint_fg_attempted",
  FGIP = "paint_fg_pct", EFF = "efficiency"
)
.FIBA_TEAM_STATS <- c(
  A_BL = "biggest_lead", A_BLS = "biggest_lead_score", A_BR = "biggest_run", A_BRS = "biggest_run_score",
  A_FBP = "fast_break_points", A_PAT = "points_off_turnovers", A_PFB = "bench_points",
  A_PIP = "points_in_paint", A_SCP = "second_chance_points", A_ACT = "a_act", A_FOUL = "a_foul",
  A_TOD = "a_tod", A_TOT = "a_tot", T_OR = "team_reb_offensive", T_DR = "team_reb_defensive",
  T_REB = "team_reb_total", T_PF = "team_fouls", T_TO = "team_turnovers", T_PFB = "team_bench_points_flag",
  T_TL = "time_led"
)
.FIBA_SHOT_KEEP <- c("game_id", "competition_id", "statistic_system", "period", "period_number", "action_id",
                     "order", "clock", "clock_seconds", "action_code", "organisation_id", "team_side",
                     "player_id", "shot_type", "points_attempted", "made", "shot_x", "shot_y", "has_location")

#' `m:ss` -> seconds (`'9:28'` -> 568); `NULL` for anything else.
#' @noRd
.fiba_seconds <- function(clock) {
  if (!is.character(clock) || length(clock) != 1L) return(NULL)
  m <- regmatches(clock, regexec("^\\s*([0-9]+):([0-9]{1,2})\\s*$", clock))[[1]]
  if (length(m) == 3L) as.integer(m[[2]]) * 60L + as.integer(m[[3]]) else NULL
}

#' The first non-NULL of two ids (sdv-py `a or b` over ids).
#' @noRd
.fiba_or <- function(a, b) if (is.null(a) || identical(a, 0L)) b else a

#' The ids every row of a page carries: game, competition, statistic system and the two teams.
#' @noRd
.fiba_game_info <- function(page) {
  page <- .fiba_dict(page)
  game <- .fiba_dict(page[["game"]])
  details <- .fiba_dict(page[["gameDetails"]])
  org <- list(
    A = .fiba_or(.fiba_id(.fiba_dict(details[["teamA"]])[["Id"]]), .fiba_id(.fiba_dict(game[["teamA"]])[["organisationId"]])),
    B = .fiba_or(.fiba_id(.fiba_dict(details[["teamB"]])[["Id"]]), .fiba_id(.fiba_dict(game[["teamB"]])[["organisationId"]]))
  )
  side_of <- character()
  for (s in names(org)) if (!is.null(org[[s]])) side_of[as.character(org[[s]])] <- s
  list(
    head = list(game_id = .fiba_or(.fiba_id(game[["gameId"]]), .fiba_id(details[["id"]])),
                competition_id = .fiba_id(.fiba_dict(game[["competition"]])[["competitionId"]])),
    system = game[["statisticSystem"]],
    org = org,
    side = function(x) {
      key <- .fiba_id(x)
      if (is.null(key) || is.na(side_of[as.character(key)])) NULL else side_of[[as.character(key)]]
    }
  )
}

#' The stat columns of `table` read from `stats`.
#' @noRd
.fiba_stat_cols <- function(stats, table) {
  out <- lapply(names(table), function(code) stats[[code]])
  names(out) <- unname(table)
  out
}

#' player_id -> lineup-card fields from playersTeamA / playersTeamB.
#' @noRd
.fiba_people <- function(page) {
  out <- list()
  for (key in c("playersTeamA", "playersTeamB")) {
    for (p in .fiba_list(page[[key]])) {
      pid <- .fiba_id(.fiba_dict(p)[["personId"]])
      if (!is.null(pid)) out[[as.character(pid)]] <- .fiba_dict(p)
    }
  }
  out
}

#' Play-by-play rows (sdv-py `_pbp_rows`).
#' @noRd
.fiba_pbp_rows <- function(page) {
  page <- .fiba_dict(page)
  info <- .fiba_game_info(page)
  periods <- .fiba_dict(.fiba_dict(page[["playByPlay"]])[["items"]])
  rows <- list()
  for (number in seq_along(periods)) {
    period <- .fiba_dict(periods[[number]])
    pname <- period[["name"]]
    pname <- if (is.null(pname) || identical(pname, "") || identical(pname, FALSE)) names(periods)[[number]] else pname
    for (item in .fiba_list(period[["items"]])) {
      a <- .fiba_dict(item)
      code <- a[["ac"]]
      org <- .fiba_id(a[["oId"]])
      is_shot <- is.character(code) && length(code) == 1L && code %in% names(.FIBA_SHOT_CODES)
      rows[[length(rows) + 1L]] <- c(info[["head"]], list(
        statistic_system = info[["system"]],
        period = as.character(pname),
        period_number = number,
        action_id = if (is.null(a[["Id"]])) NULL else as.character(a[["Id"]]),
        order = a[["order"]],
        clock = a[["Time"]],
        clock_seconds = .fiba_seconds(a[["Time"]]),
        wall_time_ms = a[["GT"]],
        score_a = a[["SA"]],
        score_b = a[["SB"]],
        action_code = code,
        action_family = a[["act"]],
        description = a[["txt"]],
        organisation_id = org,
        team_side = info[["side"]](org),
        player_id = .fiba_id(a[["pId"]]),
        player2_id = .fiba_id(a[["p2Id"]]),
        sub_direction = a[["in"]],
        made = a[["made"]],
        points_attempted = a[["pts"]],
        shot_type = if (is_shot) .FIBA_SHOT_CODES[[code]] else NULL,
        shot_x = a[["x"]],
        shot_y = a[["y"]],
        has_location = if (is_shot) ("x" %in% names(a) && code != "FT") else NULL
      ))
    }
  }
  rows
}

#' `(page ids, team object, side)` for each team of gameDetails.c.
#' @noRd
.fiba_teams <- function(page) {
  page <- .fiba_dict(page)
  info <- .fiba_game_info(page)
  lapply(.fiba_list(.fiba_dict(page[["gameDetails"]])[["c"]]), function(team) {
    team <- .fiba_dict(team)
    list(info = info, team = team, side = info[["side"]](team[["Id"]]))
  })
}

#' Player box rows (sdv-py `_box_player_rows`).
#' @noRd
.fiba_box_player_rows <- function(page) {
  page <- .fiba_dict(page)
  people <- .fiba_people(page)
  rows <- list()
  for (t in .fiba_teams(page)) {
    for (child in .fiba_list(t[["team"]][["Children"]])) {
      c0 <- .fiba_dict(child)
      pid <- .fiba_id(c0[["Id"]])
      stats <- .fiba_dict(c0[["Stats"]])
      who <- if (!is.null(pid)) people[[as.character(pid)]] %||% list() else list()
      rows[[length(rows) + 1L]] <- c(t[["info"]][["head"]], list(
        team_side = t[["side"]],
        organisation_id = .fiba_id(t[["team"]][["Id"]]),
        player_id = pid,
        first_name = who[["firstName"]],
        last_name = who[["lastName"]],
        jersey = who[["uniformNumber"]],
        position = who[["position"]],
        is_captain = who[["isCaptain"]],
        is_starter = stats[["Starter"]],
        has_played = stats[["HasPlayed"]],
        minutes = stats[["TP"]],
        seconds_played = .fiba_seconds(stats[["TP"]])
      ), .fiba_stat_cols(stats, .FIBA_STATS), list(plus_minus = stats[["PM"]], cb = stats[["CB"]]))
    }
  }
  rows
}

#' Team box rows (sdv-py `_box_team_rows`).
#' @noRd
.fiba_box_team_rows <- function(page) {
  page <- .fiba_dict(page)
  game_stats <- .fiba_dict(.fiba_dict(page[["gameDetails"]])[["Stats"]])
  lapply(.fiba_teams(page), function(t) {
    stats <- .fiba_dict(t[["team"]][["Stats"]])
    c(t[["info"]][["head"]], list(
      statistic_system = t[["info"]][["system"]],
      team_side = t[["side"]],
      organisation_id = .fiba_id(t[["team"]][["Id"]]),
      score = t[["team"]][["Score"]]
    ), .fiba_stat_cols(stats, .FIBA_STATS), .fiba_stat_cols(stats, .FIBA_TEAM_STATS), list(
      lead_changes = game_stats[["A_LC"]],
      times_tied = game_stats[["A_TT"]],
      duration = game_stats[["DUR"]],
      attendance = game_stats[["SPECT"]]
    ))
  })
}

#' Period score rows (sdv-py `_period_rows`).
#' @noRd
.fiba_period_rows <- function(page) {
  rows <- list()
  for (t in .fiba_teams(page)) {
    pers <- .fiba_list(t[["team"]][["Periods"]])
    for (number in seq_along(pers)) {
      p <- .fiba_dict(pers[[number]])
      rows[[length(rows) + 1L]] <- c(t[["info"]][["head"]], list(
        team_side = t[["side"]],
        organisation_id = .fiba_id(t[["team"]][["Id"]]),
        period = p[["Id"]],
        period_number = number,
        points = p[["Score"]],
        points_first_five_min = p[["HalfTimeScore"]]
      ))
    }
  }
  rows
}

#' Lineup rows (sdv-py `_lineup_rows`).
#' @noRd
.fiba_lineup_rows <- function(page) {
  page <- .fiba_dict(page)
  info <- .fiba_game_info(page)
  rows <- list()
  for (side in c("A", "B")) {
    for (p in .fiba_list(page[[paste0("playersTeam", side)]])) {
      p <- .fiba_dict(p)
      rows[[length(rows) + 1L]] <- c(info[["head"]], list(
        team_side = side,
        organisation_id = info[["org"]][[side]],
        player_id = .fiba_id(p[["personId"]]),
        first_name = p[["firstName"]],
        last_name = p[["lastName"]],
        jersey = p[["uniformNumber"]],
        position = p[["position"]],
        is_captain = p[["isCaptain"]]
      ))
    }
  }
  rows
}

#' A game-page dict as the route's typed tibble.
#' @noRd
.fiba_gamepage_parse <- function(route, page) {
  rows <- tryCatch(switch(route,
    pbp = .fiba_pbp_rows(page),
    shots = lapply(Filter(function(r) !is.null(r[["shot_type"]]), .fiba_pbp_rows(page)), function(r) r[.FIBA_SHOT_KEEP]),
    box_players = .fiba_box_player_rows(page),
    box_teams = .fiba_box_team_rows(page),
    period_scores = .fiba_period_rows(page),
    lineup = .fiba_lineup_rows(page),
    stop("unknown fiba_gamepage route: ", route)
  ), error = function(e) list())
  .fiba_finish(.fiba_frame(rows), paste0("fiba_gamepage_", route))
}

#' The body of a fiba_gamepage_* wrapper.
#' @noRd
.fiba_gamepage_route <- function(route, game_id, comp, return_parsed = TRUE, call = rlang::caller_env()) {
  game_id <- .fiba_int_id(game_id, "game_id", call = call)
  comp <- .fiba_int_id(comp, "comp", call = call)
  page <- .fiba_page(game_id, comp, call = call)
  if (!isTRUE(return_parsed)) return(page)
  .fiba_data(.fiba_gamepage_parse(route, page), paste0("fiba_gamepage_", route))
}
