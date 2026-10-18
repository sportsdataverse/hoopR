# scb_parsers.R -- frames of the BBL / DBBL wrappers (internal; parse_* is not exported).
#
# R mirror of sdv-py sportsdataverse/basketball/scb/scb_parsers.py (origin/main e3d232e): one
# shaper per route, snake_case columns (`.intl_clean_names()`, the sdv-py `underscore()` port),
# one dtype per column (`.scb_dtypes`, then the name rules, then the values), ids as strings except
# the ones the API always sends as integers (real_player_id, season_id, action_id, order_id),
# never through a float. Lists and objects left in a cell become compact JSON text. `season` is
# the END year (`season_id + 1`); bodies that do not name their season take it from the stamped
# request. Rows are built as named lists whose `NULL` entries are kept (Python's `None`): never
# assign `x[[k]] <- NULL`, which drops the entry.

# ---------------------------------------------------------------------------
# Values
# ---------------------------------------------------------------------------

#' @noRd
.scb_scalar <- function(v) !is.null(v) && is.atomic(v) && length(v) == 1L && !is.na(v)

#' An integer from an integer, a whole double or a digit string; else `NA`.
#' @noRd
.scb_i <- function(v) {
  if (!.scb_scalar(v)) return(NA_integer_)
  if (is.logical(v) || is.integer(v)) return(as.integer(v))
  if (is.double(v)) {
    return(if (is.finite(v) && v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_)
  }
  if (is.character(v) && grepl("^\\s*-?[0-9]+\\s*$", v, perl = TRUE)) return(suppressWarnings(as.integer(trimws(v))))
  NA_integer_
}

#' @noRd
.scb_f <- function(v) {
  if (!.scb_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  t <- trimws(v, whitespace = "[\\h\\v]")
  if (is.character(v) && grepl("^-?[0-9]+(\\.[0-9]+)?$", t, perl = TRUE)) return(as.double(t))
  NA_real_
}

#' @noRd
.scb_b <- function(v) {
  if (!.scb_scalar(v)) return(NA)
  if (is.logical(v)) return(v)
  if (is.integer(v) && v %in% c(0L, 1L)) return(as.logical(v))
  NA
}

#' A string; an integer (or whole double) id becomes its digits, never "123.0"; a list or object
#' becomes compact JSON.
#' @noRd
.scb_s <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (is.list(v)) {
    return(as.character(jsonlite::toJSON(v, auto_unbox = TRUE, null = "null", na = "null", digits = NA)))
  }
  if (length(v) != 1L || is.na(v)) return(NA_character_)
  if (is.logical(v)) return(if (v) "true" else "false")
  if (is.character(v)) {
    t <- trimws(v, whitespace = "[\\h\\v]")
    return(if (nzchar(t)) t else NA_character_)
  }
  if (is.integer(v)) return(as.character(v))
  if (v == trunc(v)) return(formatC(v, format = "f", digits = 0))
  as.character(v)
}

#' `.scb_i()` for a row cell: `NULL` (Python `None`) instead of `NA`.
#' @noRd
.scb_int_cell <- function(v) {
  n <- .scb_i(v)
  if (is.na(n)) NULL else n
}

#' A stat block with its numeric strings made numbers ("12000" -> 12000, "" -> NULL).
#' @noRd
.scb_numify <- function(v) {
  if (!is.character(v) || length(v) != 1L) return(v)
  t <- trimws(v, whitespace = "[\\h\\v]")
  if (!nzchar(t)) return(NULL)
  if (grepl("^-?[0-9]+$", t, perl = TRUE)) return(.scb_int_cell(t) %||% as.double(t))
  if (grepl("^-?[0-9]+(\\.[0-9]+)?$", t, perl = TRUE)) return(as.double(t))
  v
}

#' @noRd
.scb_numify_nested <- function(d) {
  d <- .scb_obj(d)
  for (k in names(d)) if (!is.list(d[[k]])) d[k] <- list(.scb_numify(d[[k]]))
  d
}

#' Period number from 4 / "Q4" / "OT1" (-> 5); anything else -> NULL.
#' @noRd
.scb_period <- function(v) {
  if (is.integer(v) && length(v) == 1L) return(v)
  if (!is.character(v) || length(v) != 1L) return(NULL)
  m <- regmatches(trimws(v), regexec("^(Q|OT)([0-9]+)$", trimws(v)))[[1]]
  if (!length(m)) return(NULL)
  n <- as.integer(m[[3]])
  if (m[[2]] == "Q") n else 4L + n
}

#' @noRd
.scb_seconds_left <- function(clock) {
  if (!is.character(clock) || length(clock) != 1L) return(NULL)
  m <- regmatches(clock, regexec("^([0-9]+):([0-9]{2}):([0-9]{2})$", clock))[[1]]
  if (!length(m)) return(NULL)
  as.integer(m[[2]]) * 3600L + as.integer(m[[3]]) * 60L + as.integer(m[[4]])
}

#' @noRd
.scb_obj <- function(v) if (.scb_is_dict(v)) v else stats::setNames(list(), character())
#' @noRd
.scb_dicts <- function(v) if (.scb_is_array(v)) Filter(.scb_is_dict, v) else list()

#' The request the runtime stamped on a body (or on its first row).
#' @noRd
.scb_req <- function(raw) {
  if (.scb_is_dict(raw) && .scb_is_dict(raw[[.SCB_REQUEST]])) return(raw[[.SCB_REQUEST]])
  rows <- .scb_dicts(raw)
  if (length(rows)) .scb_obj(rows[[1]][[.SCB_REQUEST]]) else list()
}

#' @noRd
.scb_plus1 <- function(season_id) {
  n <- .scb_int_cell(season_id)
  if (is.null(n)) NULL else n + 1L
}

#' A list of strings as "a,b"; a string as it is. A list of objects (the `tvChannel` objects of
#' /games/recent and /games/{gameId}) joins their `name`s. A null entry (or a null `name`) is skipped,
#' where sdv-py joins it as "None"; nothing left is NULL.
#'
#' Deliberate divergence: sdv-py e3d232e joins Python `str(dict)` reprs there
#' ("{'channelId': 4, 'name': 'DYN', ...}"), against its own column description
#' ("TV channel(s) ..., comma-joined"); test-scb.R checks these cells against the oracle's names.
#' @noRd
.scb_join <- function(v) {
  if (.scb_is_array(v)) {
    one <- function(x) {
      if (.scb_is_dict(x)) x <- x[["name"]]
      if (is.null(x)) NA_character_ else as.character(x)[[1]]
    }
    parts <- vapply(v, one, character(1))
    out <- paste(parts[!is.na(parts)], collapse = ",")
    return(if (nzchar(out)) out else NULL)
  }
  .scb_s(v)
}

#' Python `a or b`.
#' @noRd
.scb_or <- function(a, b) if (.scb_truthy(a)) a else b

#' `a` with `b`'s entries set in place (or appended): Python `{**a, **b}`, `NULL` entries kept.
#' @noRd
.scb_merge <- function(a, b) {
  for (k in names(b)) a[k] <- list(b[[k]])
  a
}

#' A named list of `NULL`s.
#' @noRd
.scb_nulls <- function(nms) stats::setNames(vector("list", length(nms)), nms)

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' @noRd
.SCB_INT_IDS <- c("real_player_id", "season_id", "action_id", "order_id", "all_time_order_id", "timestamp")

#' The dtype code a column name implies, or `NULL` when its values decide.
#' @noRd
.scb_rule <- function(name) {
  if (name %in% c(.SCB_INT_IDS, "season")) return("i")
  if (grepl("(^|_)id$", name, perl = TRUE)) return("s")
  if (grepl("^(is|has)_|^overall$|_recomputed$", name, perl = TRUE)) return("b")
  if (grepl(paste0(
    "(^|_)(name|url|time|tlc|type|status|progress|function|position|stage|competition|bucket|side|scope|stat|",
    "direction|round|streak|channel|address|nationalities|teams|ids|qualifiers|identifier|date|achievements|",
    "outcomes|corrections|info|mascot|aggregation|short|reference|shirt_number)$"
  ), name, perl = TRUE)) return("s")
  if (grepl("percent|ratio|per_game|average|height|(^|_)value$", name, perl = TRUE)) return("f")
  NULL
}

#' @noRd
.scb_infer <- function(values) {
  seen <- Filter(Negate(is.null), values)
  if (!length(seen)) return("s")
  is1 <- function(f) all(vapply(seen, function(v) is.atomic(v) && length(v) == 1L && f(v), logical(1)))
  if (is1(is.logical)) return("b")
  if (is1(is.integer)) return("i")
  if (is1(is.numeric)) return("f")
  "s"
}

#' @noRd
.scb_code <- function(parser, name, values) {
  dt <- .scb_dtypes[[parser]]
  if (name %in% names(dt)) return(dt[[name]])
  .scb_rule(name) %||% .scb_infer(values)
}

#' Rows -> a tibble with pinned dtypes; an empty body keeps `columns`, a row missing one gains it as `NA`.
#' @noRd
.scb_frame <- function(parser, rows, columns) {
  nms <- columns
  if (!length(nms) && !length(rows)) nms <- names(.scb_dtypes[[parser]])
  for (r in rows) nms <- c(nms, setdiff(names(r), nms))
  out <- lapply(nms, function(n) {
    vals <- lapply(rows, function(r) r[[n]])
    switch(.scb_code(parser, n, vals),
      i = vapply(vals, .scb_i, integer(1), USE.NAMES = FALSE),
      f = vapply(vals, .scb_f, double(1), USE.NAMES = FALSE),
      b = vapply(vals, .scb_b, logical(1), USE.NAMES = FALSE),
      s = vapply(vals, .scb_s, character(1), USE.NAMES = FALSE)
    )
  })
  names(out) <- nms
  dplyr::as_tibble(out)
}

#' Flatten a nested row: `rename` (dotted wire path -> column) first and in its order, the rest as
#' `underscore(path)`; `drop` paths and the request stamp are skipped. Lists stay as they are (the
#' frame turns them into JSON text).
#' @noRd
.scb_row <- function(row, rename = character(), drop = character()) {
  named <- .scb_nulls(unname(rename))
  rest <- list()
  walk <- function(node, path) {
    for (k in names(node)) {
      v <- node[[k]]
      p <- if (nzchar(path)) paste0(path, ".", k) else k
      if (p %in% drop || (!nzchar(path) && k == .SCB_REQUEST)) next
      if (p %in% names(rename)) {
        named[rename[[p]]] <<- list(v)
      } else if (.scb_is_dict(v)) {
        walk(v, p)
      } else {
        rest[.intl_clean_names(gsub(".", "_", p, fixed = TRUE))] <<- list(v)
      }
    }
  }
  walk(.scb_obj(row), "")
  .scb_merge(named, rest)
}

#' Recompute field goals from the 2- and 3-point parts when the totals disagree (2005-06 box scores).
#' @noRd
.scb_fix_field_goals <- function(row) {
  parts <- lapply(c("two_point_shots_made", "three_point_shots_made", "two_point_shots_attempted",
                    "three_point_shots_attempted"), function(k) row[[k]])
  ints <- Filter(function(v) is.integer(v) && length(v) == 1L && !is.na(v), parts)
  row["field_goals_recomputed"] <- list(FALSE)
  if (length(ints) == 4L) {
    made <- ints[[1]] + ints[[2]]
    att <- ints[[3]] + ints[[4]]
    fgm <- row[["field_goals_made"]]
    fga <- row[["field_goals_attempted"]]
    same <- .scb_scalar(fgm) && .scb_scalar(fga) && is.numeric(fgm) && is.numeric(fga) && fgm == made && fga == att
    if (!same) {
      row["field_goals_made"] <- list(made)
      row["field_goals_attempted"] <- list(att)
      row["field_goals_success_percent"] <- list(if (att) round(100 * made / att, 1) else 0)
      row["field_goals_recomputed"] <- list(TRUE)
    }
  }
  row
}

#' The finished frame: the documented tibble as a `hoopR_data` object.
#' @noRd
.scb_out <- function(df, type) make_hoopR_data(df, type, Sys.time())

# ---------------------------------------------------------------------------
# /seasons, /seasons/{seasonId}, playoff tree
# ---------------------------------------------------------------------------

#' @noRd
.scb_parse_seasons <- function(raw, columns = NULL) {
  rows <- lapply(.scb_dicts(raw), function(r) {
    list(league = .scb_req(r)[["league"]], season = .scb_plus1(r[["id"]]), season_id = r[["id"]],
         is_active = r[["isActive"]])
  })
  .scb_frame("parse_scb_seasons", rows, columns)
}

#' @noRd
.scb_season_head <- function(raw) {
  body <- .scb_obj(raw)
  list(league = .scb_req(raw)[["league"]], season = .scb_plus1(body[["id"]]), season_id = body[["id"]])
}

#' @noRd
.scb_parse_season_players <- function(raw, columns = NULL) {
  head <- .scb_season_head(raw)
  rows <- lapply(.scb_dicts(.scb_obj(raw)[["players"]]), function(p) {
    c(head, list(season_player_id = p[["seasonPlayerId"]], real_player_id = p[["realPlayerId"]],
                 season_team_id = p[["seasonTeamId"]], first_name = p[["firstName"]], last_name = p[["lastName"]]))
  })
  .scb_frame("parse_scb_season_players", rows, columns)
}

#' @noRd
.scb_parse_season_teams <- function(raw, columns = NULL) {
  head <- .scb_season_head(raw)
  rows <- lapply(.scb_dicts(.scb_obj(raw)[["teams"]]), function(t) {
    c(head, list(team_id = t[["teamId"]], season_team_id = t[["seasonTeamId"]], team_name = t[["name"]],
                 tlc = t[["tlc"]], logo_url = t[["logoUrl"]]))
  })
  .scb_frame("parse_scb_season_teams", rows, columns)
}

#' `list(round, series, node)` per series: quarter-finals, semi-finals, finals (an object or a list).
#' @noRd
.scb_series <- function(body) {
  out <- list()
  for (rnd in list(c("quarterFinals", "quarter_finals"), c("semiFinals", "semi_finals"), c("finals", "finals"))) {
    node <- body[[rnd[[1]]]]
    items <- if (.scb_is_dict(node) && length(node)) list(node) else .scb_dicts(node)
    for (n in seq_along(items)) out[[length(out) + 1L]] <- list(round = rnd[[2]], series = n, s = items[[n]])
  }
  out
}

#' @noRd
.scb_playoff_head <- function(raw) {
  body <- .scb_obj(raw)
  list(league = .scb_req(raw)[["league"]], season = .scb_plus1(body[["seasonId"]]), season_id = body[["seasonId"]])
}

#' @noRd
.scb_parse_playoff_series <- function(raw, columns = NULL) {
  head <- .scb_playoff_head(raw)
  rows <- lapply(.scb_series(.scb_obj(raw)), function(x) {
    s <- x$s
    a <- .scb_obj(s[["teamA"]])
    b <- .scb_obj(s[["teamB"]])
    c(head, list(
      round = x$round, series = x$series, match_winner_id = s[["matchWinnerId"]],
      is_match_finished = s[["isMatchFinished"]], team_a_id = a[["seasonTeamId"]], team_a_name = a[["name"]],
      team_a_tlc = a[["tlc"]], team_a_rank = a[["rank"]], team_a_victories = s[["teamAVictories"]],
      team_b_id = b[["seasonTeamId"]], team_b_name = b[["name"]], team_b_tlc = b[["tlc"]], team_b_rank = b[["rank"]],
      team_b_victories = s[["teamBVictories"]], games = length(.scb_dicts(s[["games"]]))
    ))
  })
  .scb_frame("parse_scb_playoff_series", rows, columns)
}

#' @noRd
.scb_parse_playoff_games <- function(raw, columns = NULL) {
  head <- .scb_playoff_head(raw)
  rows <- list()
  for (x in .scb_series(.scb_obj(raw))) {
    s <- x$s
    a <- .scb_obj(s[["teamA"]])
    b <- .scb_obj(s[["teamB"]])
    for (g in .scb_dicts(s[["games"]])) {
      rows[[length(rows) + 1L]] <- c(head, list(
        round = x$round, series = x$series, game_id = g[["gameId"]], scheduled_time = g[["scheduledTime"]],
        timestamp = g[["timestamp"]], game_winner_id = g[["gameWinnerId"]], home_team_id = g[["homeTeamId"]],
        guest_team_id = g[["guestTeamId"]], team_a_id = a[["seasonTeamId"]], team_b_id = b[["seasonTeamId"]],
        points_team_a = g[["pointsTeamA"]], points_team_b = g[["pointsTeamB"]]
      ))
    }
  }
  .scb_frame("parse_scb_playoff_games", rows, columns)
}

# ---------------------------------------------------------------------------
# Season stat tables
# ---------------------------------------------------------------------------

#' @noRd
.SCB_PLAYER_STAT_RENAME <- c(
  "seasonPlayer.id" = "season_player_id", "seasonPlayer.realPlayerId" = "real_player_id",
  "seasonPlayer.firstName" = "first_name", "seasonPlayer.lastName" = "last_name",
  "seasonPlayer.shirtNumber" = "shirt_number", "seasonPlayer.position" = "position",
  "seasonTeam.teamId" = "team_id", "seasonTeam.seasonTeamId" = "season_team_id", "seasonTeam.name" = "team_name",
  "seasonTeam.tlc" = "team_tlc", "seasonTeam.seasonId" = "season_id"
)
#' @noRd
.SCB_TEAM_STAT_RENAME <- .SCB_PLAYER_STAT_RENAME[startsWith(names(.SCB_PLAYER_STAT_RENAME), "seasonTeam.")]
#' @noRd
.SCB_PLAYER_STAT_DROP <- c("seasonPlayer.playerId", "seasonPlayer.imageUrl", "seasonPlayer.foreignLink",
                           "seasonTeam.logoUrl")

#' @noRd
.scb_stat_rows <- function(raw, rename) {
  req <- .scb_req(raw)
  lapply(.scb_dicts(raw), function(r) {
    row <- .scb_row(r, rename, .SCB_PLAYER_STAT_DROP)
    season <- if (is.null(row[["season_id"]])) req[["season"]] else .scb_plus1(row[["season_id"]])
    .scb_merge(list(league = req[["league"]], season = season, display_type = req[["display_type"]]), row)
  })
}

#' @noRd
.scb_parse_player_statistics <- function(raw, columns = NULL) {
  .scb_frame("parse_scb_player_statistics", .scb_stat_rows(raw, .SCB_PLAYER_STAT_RENAME), columns)
}

#' @noRd
.scb_parse_team_statistics <- function(raw, columns = NULL) {
  .scb_frame("parse_scb_team_statistics", .scb_stat_rows(raw, .SCB_TEAM_STAT_RENAME), columns)
}

# ---------------------------------------------------------------------------
# Games
# ---------------------------------------------------------------------------

#' @noRd
.scb_side <- function(d, p) {
  d <- .scb_obj(d)
  stats::setNames(
    list(d[["teamId"]], d[["seasonTeamId"]], d[["name"]], d[["tlc"]], d[["isForeign"]], d[["rank"]], d[["streak"]],
         d[["streakCount"]], d[["last10Victories"]], d[["last10Losses"]], .scb_int_cell(d[["totalGames"]])),
    paste0(p, c("_team_id", "_season_team_id", "_team_name", "_tlc", "_is_foreign", "_rank", "_streak",
                "_streak_count", "_last10_victories", "_last10_losses", "_total_games"))
  )
}

#' @noRd
.scb_official <- function(d, p) {
  d <- .scb_obj(d)
  stats::setNames(list(d[["refId"]], d[["firstName"]], d[["lastName"]]), paste0(p, c("_id", "_first_name", "_last_name")))
}

#' @noRd
.scb_game_row <- function(g, req, bucket = NULL) {
  res <- .scb_obj(g[["result"]])
  venue <- .scb_obj(g[["venue"]])
  top <- .scb_obj(g[["topScorer"]])
  row <- list(league = req[["league"]], season = .scb_plus1(g[["seasonId"]]) %||% req[["season"]],
              season_id = g[["seasonId"]], game_id = g[["id"]], competition = g[["competition"]],
              stage = g[["stage"]], status = g[["status"]])
  if (!is.null(bucket)) row["bucket"] <- list(bucket)
  if ("statstatus" %in% names(g)) row["stat_status"] <- list(g[["statstatus"]])
  if ("gameProgress" %in% names(g)) row["game_progress"] <- list(g[["gameProgress"]])
  row <- c(row, list(scheduled_time = g[["scheduledTime"]], match_day = g[["matchDay"]], is_tbd = g[["isTBD"]],
                     is_hidden = g[["isHidden"]]),
           .scb_side(g[["homeTeam"]], "home"), .scb_side(g[["guestTeam"]], "guest"),
           list(home_score = res[["homeTeamFinalScore"]], guest_score = res[["guestTeamFinalScore"]],
                latest_period = .scb_period(res[["latestPeriod"]]), spectators = res[["spectators"]]))
  for (side in c("home", "guest")) {
    for (q in 1:4) row[paste0(side, "_q", q, "_score")] <- list(res[[paste0(side, "TeamQ", q, "Score")]])
    for (ot in 1:9) row[paste0(side, "_ot", ot, "_score")] <- list(res[[paste0(side, "TeamOT", ot, "Score")]])
  }
  for (p in c("referee1", "referee2", "referee3", "commissioner")) row <- c(row, .scb_official(g[[p]], p))
  c(row, list(
    venue_id = venue[["id"]], venue_name = venue[["name"]], venue_address = venue[["address"]],
    venue_capacity = venue[["capacity"]], venue_is_main = venue[["isMain"]], tv_channel = .scb_join(g[["tvChannel"]]),
    tv_type = g[["tvType"]], is_free_tv = g[["isFreeTV"]], live_stream_url = g[["linkLiveStream"]],
    top_score = g[["topScore"]], top_scorer_season_player_id = top[["playerId"]],
    top_scorer_real_player_id = top[["realPlayerId"]], top_scorer_first_name = top[["firstName"]],
    top_scorer_last_name = top[["lastName"]]
  ))
}

#' `/games` (a page), `/games/{gameId}` (one object) -> one row per game.
#' @noRd
.scb_parse_games <- function(raw, columns = NULL) {
  req <- .scb_req(raw)
  games <- if (.scb_is_dict(raw) && .scb_is_array(raw[["items"]])) {
    .scb_dicts(raw[["items"]])
  } else if (.scb_is_dict(raw) && "id" %in% names(raw)) {
    list(raw)
  } else {
    .scb_dicts(raw)
  }
  .scb_frame("parse_scb_games", lapply(games, .scb_game_row, req = req), columns)
}

#' @noRd
.scb_parse_games_recent <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  req <- .scb_req(raw)
  rows <- list()
  for (bucket in c("past", "present", "future")) {
    for (g in .scb_dicts(body[[bucket]])) rows[[length(rows) + 1L]] <- .scb_game_row(g, req, bucket)
  }
  .scb_frame("parse_scb_games", rows, columns)
}

# ---------------------------------------------------------------------------
# Box score: /games/{gameId}/stats
# ---------------------------------------------------------------------------

#' @noRd
.SCB_BOX_DROP <- c("seasonPlayer.playerId", "seasonPlayer.imageUrl", "seasonPlayer.foreignLink", "seasonTeam.logoUrl",
                   "shirtNumber", "gameId")
#' @noRd
.SCB_TEAM_RENAME <- c("seasonTeam.seasonTeamId" = "season_team_id", "seasonTeam.seasonId" = "season_id",
                      "seasonTeam.name" = "team_name", "seasonTeam.tlc" = "team_tlc")
#' @noRd
.SCB_TEAM_DROP <- c("seasonTeam.teamId", "seasonTeam.logoUrl", "gameId", "scheduledTime")
#' @noRd
.SCB_SIDES <- c(home = "homeTeam", guest = "guestTeam")

#' @noRd
.scb_game_head <- function(raw) list(league = .scb_req(raw)[["league"]], game_id = .scb_obj(raw)[["gameId"]])

#' @noRd
.scb_parse_game_players <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  head <- .scb_game_head(raw)
  rows <- list()
  for (side in names(.SCB_SIDES)) {
    team <- .scb_obj(body[[.SCB_SIDES[[side]]]])
    for (p in .scb_dicts(team[["playerStats"]])) {
      row <- .scb_row(.scb_numify_nested(p), .SCB_PLAYER_STAT_RENAME, .SCB_BOX_DROP)
      lead <- c(head, list(season = .scb_plus1(row[["season_id"]]), side = side, team_id = team[["id"]]))
      rows[[length(rows) + 1L]] <- .scb_fix_field_goals(.scb_merge(lead, row))
    }
  }
  .scb_frame("parse_scb_game_players", rows, columns)
}

#' @noRd
.scb_parse_game_teams <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  head <- .scb_game_head(raw)
  rows <- list()
  for (side in names(.SCB_SIDES)) {
    team <- .scb_obj(body[[.SCB_SIDES[[side]]]])
    if (!length(team)) next
    stat <- .scb_row(.scb_numify_nested(team[["gameStat"]]), .SCB_TEAM_RENAME, .SCB_TEAM_DROP)
    coach <- .scb_row(.scb_numify_nested(team[["coachStat"]]), character(), c("firstName", "lastName"))
    names(coach) <- paste0("team_line_", names(coach), recycle0 = TRUE)
    lead <- c(head, list(season = .scb_plus1(stat[["season_id"]]), side = side, team_id = team[["id"]],
                         head_coach_name = team[["headCoachName"]], status = body[["status"]],
                         scheduled_time = body[["scheduledTime"]]))
    rows[[length(rows) + 1L]] <- .scb_fix_field_goals(.scb_merge(.scb_merge(lead, stat), coach))
  }
  .scb_frame("parse_scb_game_teams", rows, columns)
}

#' @noRd
.scb_parse_game_actions <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  head <- .scb_game_head(raw)
  # sdv-py looks the side up in a dict keyed by the team id: type-strict ("413" is not 413)
  side_of <- function(id) {
    out <- NULL
    for (side in names(.SCB_SIDES)) {
      t <- body[[.SCB_SIDES[[side]]]]
      if (.scb_is_dict(t) && .scb_is(id, t[["id"]])) out <- side
    }
    out
  }
  rows <- lapply(.scb_dicts(body[["actions"]]), function(a) {
    co <- .scb_obj(a[["coordinates"]])
    x <- co[["x"]]
    y <- co[["y"]]
    unlocated <- function(v) is.null(v) || (is.numeric(v) && length(v) == 1L && !is.na(v) && v == 0)
    located <- !(unlocated(x) && unlocated(y))
    c(head, list(
      action_id = a[["id"]], order_id = a[["orderId"]], action_identifier = a[["actionIdentifier"]],
      period = a[["period"]], game_time = a[["gameTime"]], seconds_left = .scb_seconds_left(a[["gameTime"]]),
      real_time = a[["realTime"]], type = a[["type"]], qualifiers = .scb_join(a[["qualifiers"]]),
      is_successful = a[["isSuccessful"]], season_team_id = a[["seasonTeamId"]], side = side_of(a[["seasonTeamId"]]),
      season_player_id = a[["seasonPlayerId"]], assisting_season_player_id = a[["assistingSeasonPlayerId"]],
      shot_x = if (located) x, shot_y = if (located) y, home_team_points = a[["homeTeamPoints"]],
      guest_team_points = a[["guestTeamPoints"]]
    ))
  })
  .scb_frame("parse_scb_game_actions", rows, columns)
}

# ---------------------------------------------------------------------------
# Standings, profiles, referees, transfers, records
# ---------------------------------------------------------------------------

#' @noRd
.SCB_STANDINGS_RENAME <- c(
  "id" = "standing_id", "seasonTeam.id" = "season_team_id", "seasonTeam.teamId" = "team_id",
  "seasonTeam.name" = "team_name", "seasonTeam.tlc" = "team_tlc", "seasonTeam.nameShort" = "team_name_short",
  "seasonTeam.hasReachedPlayoffs" = "has_reached_playoffs", "seasonTeam.hasReachedPlayins" = "has_reached_playins",
  "seasonTeam.isRelegationCertain" = "is_relegation_certain"
)

#' @noRd
.scb_parse_standings <- function(raw, columns = NULL) {
  req <- .scb_req(raw)
  table <- c(total_points_made = "table_points", total_points_against = "table_points_against")
  points <- c(goals_made = "points_for", goals_against = "points_against", goal_difference = "point_difference")
  rows <- lapply(.scb_dicts(raw), function(r) {
    row <- .scb_row(r, .SCB_STANDINGS_RENAME, "seasonTeam.logoUrl")
    hit <- names(row) %in% names(table)
    names(row)[hit] <- table[names(row)[hit]]
    for (old in names(points)) {
      for (k in names(row)[endsWith(names(row), old)]) {
        v <- row[[k]]
        row[k] <- NULL
        row[paste0(substr(k, 1L, nchar(k) - nchar(old)), points[[old]])] <- list(v)
      }
    }
    c(list(league = req[["league"]], season = .scb_plus1(r[["seasonId"]])), row)
  })
  .scb_frame("parse_scb_standings", rows, columns)
}

#' @noRd
.scb_body_without_request <- function(raw) {
  if (!.scb_is_dict(raw)) return(list())
  raw[names(raw) != .SCB_REQUEST]
}

#' @noRd
.scb_parse_season_player <- function(raw, columns = NULL) {
  d <- .scb_body_without_request(raw)
  if (!length(d)) return(.scb_frame("parse_scb_season_player", list(), columns))
  team <- .scb_obj(d[["team"]])
  row <- list(
    league = .scb_req(raw)[["league"]], season_player_id = d[["id"]], real_player_id = d[["realPlayerId"]],
    active_season_player_id = d[["activeSeasonPlayerId"]], first_name = d[["firstName"]], last_name = d[["lastName"]],
    birth_date = d[["birthDate"]], position = d[["position"]], shirt_number = d[["shirtNumber"]],
    height = d[["height"]], weight = d[["weight"]], nationalities = .scb_join(d[["nationalities"]]),
    is_all_star = d[["isAllStar"]], is_young = d[["isYoung"]], has_changed_teams = d[["hasChangedTeams"]],
    bbl_games_played = d[["bblGamesPlayed"]], team_id = team[["id"]], team_name = team[["name"]],
    previous_teams = d[["previousTeams"]], season_ids = d[["seasonIds"]]
  )
  .scb_frame("parse_scb_season_player", list(row), columns)
}

#' @noRd
.scb_parse_team <- function(raw, columns = NULL) {
  d <- .scb_body_without_request(raw)
  if (!length(d)) return(.scb_frame("parse_scb_team", list(), columns))
  row <- list(
    league = .scb_req(raw)[["league"]], team_id = d[["id"]], tlc = d[["tlc"]], name_full = d[["nameFull"]],
    name_short = d[["nameShort"]], mascot = d[["mascot"]], homepage_url = d[["homepageUrl"]],
    ticket_url = d[["ticketUrl"]], year_joined_bbl = .scb_int_cell(d[["yearJoinedBBL"]]), order_id = d[["orderId"]],
    best_achievements = d[["bestAchievements"]]
  )
  .scb_frame("parse_scb_team", list(row), columns)
}

#' @noRd
.scb_parse_team_seasons <- function(raw, columns = NULL) {
  d <- .scb_obj(raw)
  league <- .scb_req(raw)[["league"]]
  rows <- lapply(.scb_dicts(d[["seasonTeams"]]), function(s) {
    list(league = league, team_id = d[["id"]], season = .scb_plus1(s[["seasonId"]]), season_id = s[["seasonId"]],
         season_team_id = s[["id"]], team_name = s[["name"]], is_championship_winner = s[["isChampionshipWinner"]],
         is_cup_winner = s[["isCupWinner"]])
  })
  .scb_frame("parse_scb_team_seasons", rows, columns)
}

#' @noRd
.scb_parse_referees <- function(raw, columns = NULL) {
  items <- if (.scb_is_dict(raw)) raw[["items"]] else raw
  league <- .scb_req(raw)[["league"]]
  rows <- lapply(.scb_dicts(items), function(r) {
    list(league = league, referee_id = r[["refId"]], first_name = r[["firstName"]], last_name = r[["lastName"]],
         official_function = r[["officialFunction"]], participations = r[["participations"]],
         year_joined_bbl = .scb_int_cell(r[["yearJoinedBBL"]]))
  })
  .scb_frame("parse_scb_referees", rows, columns)
}

#' @noRd
.scb_transfer_row <- function(t, req) {
  src <- .scb_obj(t[["sourceTeam"]])
  dst <- .scb_obj(t[["destinationTeam"]])
  p <- .scb_obj(t[["player"]])
  list(
    league = req[["league"]], transfer_date = t[["sortingDate"]], season_player_id = p[["id"]],
    real_player_id = .scb_int_cell(p[["playerId"]]), first_name = p[["firstName"]], last_name = p[["lastName"]],
    position = p[["position"]], source_team_id = src[["id"]],
    source_team_name = .scb_or(t[["sourceTeamFreeText"]], src[["nameShort"]]), destination_team_id = dst[["id"]],
    destination_team_name = .scb_or(t[["destinationTeamFreeText"]], dst[["nameShort"]])
  )
}

#' @noRd
.scb_parse_transfers <- function(raw, columns = NULL) {
  req <- .scb_req(raw)
  .scb_frame("parse_scb_transfers", lapply(.scb_dicts(raw), .scb_transfer_row, req = req), columns)
}

#' @noRd
.scb_parse_transfers_teams <- function(raw, columns = NULL) {
  req <- .scb_req(raw)
  rows <- list()
  for (cl in .scb_dicts(raw)) {
    for (direction in c("joining", "leaving")) {
      for (t in .scb_dicts(cl[[direction]])) {
        rows[[length(rows) + 1L]] <- .scb_merge(list(team_id = .scb_obj(cl[["team"]])[["id"]], direction = direction),
                                                .scb_transfer_row(t, req))
      }
    }
  }
  .scb_frame("parse_scb_transfers_teams", rows, columns)
}

#' @noRd
.scb_parse_team_rosters <- function(raw, columns = NULL) {
  req <- .scb_req(raw)
  rows <- list()
  for (cl in .scb_dicts(raw)) {
    for (p in .scb_dicts(cl[["roster"]])) {
      rows[[length(rows) + 1L]] <- list(
        league = req[["league"]], team_id = .scb_obj(cl[["team"]])[["id"]], season = .scb_plus1(p[["seasonId"]]),
        season_id = p[["seasonId"]], season_team_id = p[["seasonTeamId"]], season_player_id = p[["id"]],
        real_player_id = p[["realPlayerId"]], first_name = p[["firstName"]], last_name = p[["lastName"]],
        birth_date = p[["birthDate"]], position = p[["position"]], shirt_number = p[["shirtNumber"]],
        height = p[["height"]], weight = p[["weight"]], nationalities = .scb_join(p[["nationalities"]]),
        is_all_star = p[["isAllStar"]], is_young = p[["isYoung"]]
      )
    }
  }
  .scb_frame("parse_scb_team_rosters", rows, columns)
}

#' @noRd
.scb_parse_records_per_game <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  season_id <- .scb_int_cell(body[["seasonId"]])
  league <- .scb_req(raw)[["league"]]
  rows <- list()
  for (scope in list(c("season", "seasonRecords"), c("all_time", "allTimeRecords"))) {
    group <- .scb_obj(body[[scope[[2]]]])
    for (stat in names(group)) {
      for (r in .scb_dicts(group[[stat]])) {
        rows[[length(rows) + 1L]] <- list(
          league = league, season = .scb_plus1(season_id), season_id = season_id, scope = scope[[1]],
          stat = .intl_clean_names(stat), place = r[["place"]], all_time_place = r[["allTimePlace"]],
          order_id = r[["orderId"]], all_time_order_id = r[["allTimeOrderId"]], value = r[["value"]],
          ratio = r[["ratio"]], season_player_id = r[["seasonPlayerId"]], real_player_id = r[["realPlayerId"]],
          first_name = r[["firstName"]], last_name = r[["lastName"]], team_name = r[["seasonTeamName"]],
          team_tlc = r[["teamTLC"]], home_tlc = r[["homeTeamTLC"]], guest_tlc = r[["guestTeamTLC"]],
          game_id = r[["gameId"]], scheduled_time = r[["scheduledTime"]]
        )
      }
    }
  }
  .scb_frame("parse_scb_records_per_game", rows, columns)
}

#' @noRd
.scb_parse_records_season_averages <- function(raw, columns = NULL) {
  body <- .scb_obj(raw)
  league <- .scb_req(raw)[["league"]]
  rows <- list()
  for (stat in setdiff(names(body), .SCB_REQUEST)) {
    for (r in .scb_dicts(body[[stat]])) {
      rows[[length(rows) + 1L]] <- list(
        league = league, stat = .intl_clean_names(stat), season = .scb_plus1(r[["seasonId"]]),
        season_id = r[["seasonId"]], place = r[["place"]], order_id = r[["orderId"]], value = r[["value"]],
        ratio = r[["ratio"]], season_player_id = r[["seasonPlayerId"]], real_player_id = r[["realPlayerId"]],
        first_name = r[["firstName"]], last_name = r[["lastName"]], team_name = r[["seasonTeamName"]],
        team_tlc = r[["teamTLC"]]
      )
    }
  }
  .scb_frame("parse_scb_records_season_averages", rows, columns)
}
