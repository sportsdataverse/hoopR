# fox_basketball.R -- Fox Sports "Bifrost" basketball wrappers (NBA + MBB).
#
# Read-only wrappers over api.foxsports.com/bifrost/v1/{nba,cbk}/*, flattening
# Fox's layout JSON (sections -> tables -> rows -> cells) into tidy hoopR
# tibbles. Basketball play-by-play is period-based (QUARTER/HALF -> plays).
# NBA uses the `nba` slug; men's college basketball uses the `cbk` slug.
# Reverse-engineering notes + an OpenAPI spec live in the sdv-internal-refs repo.

# Fox Bifrost public web apikey. Resolved from option -> env var -> literal so
# the key can be overridden without a code change while preserving the legacy
# default. The literal is the public key the foxsports.com site itself ships.
.fox_bb_key <- function() {
  getOption(
    "hoopR.fox_data_key",
    default = Sys.getenv(
      "HOOPR_FOX_DATA_KEY",
      unset = "jE7yBJVRNAwdDesMgTzTXUUSx1It41Fq"
    )
  )
}
.fox_or <- function(a, b) if (is.null(a) || length(a) == 0) b else a

#' @keywords internal
#' @importFrom jsonlite fromJSON
.fox_bb_get <- function(path, query = list()) {
  query[["apikey"]] <- .fox_or(query[["apikey"]], .fox_bb_key())
  query[["api-version"]] <- .fox_or(query[["api-version"]], "1.1")
  # Route through hoopR's shared GET helper so the Fox calls inherit the
  # package-standard timeout, retry, proxy resolution (explicit arg ->
  # getOption("hoopR.proxy") -> http(s)_proxy env vars) and status handling.
  res <- .retry_request(
    url     = paste0("https://api.foxsports.com/bifrost/v1/", path),
    params  = query,
    headers = c(Origin  = "https://www.foxsports.com",
                Referer = "https://www.foxsports.com/")
  )
  check_status(res)
  res |>
    .resp_text() |>
    jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)
}

.fox_cells <- function(cols) {
  vapply(cols, function(c) {
    v <- if (is.list(c)) c[["text"]] else c
    if (is.null(v) || length(v) == 0) NA_character_ else as.character(v)[1]
  }, character(1))
}
.fox_uri_id <- function(uri) {
  if (is.null(uri)) return(NA_character_)
  m <- regmatches(uri, regexpr("[0-9]+$", uri)); if (length(m)) m else NA_character_
}
#' @importFrom janitor make_clean_names
.fox_table_df <- function(tbl, extra = list()) {
  if (is.null(tbl)) return(NULL)
  hdr <- .fox_cells(tbl[["headers"]][[1]][["columns"]])
  nm <- janitor::make_clean_names(ifelse(is.na(hdr) | hdr == "", paste0("v", seq_along(hdr)), hdr))
  rws <- .fox_or(tbl[["rows"]], list()); if (!length(rws)) return(NULL)
  recs <- lapply(rws, function(r) {
    cells <- .fox_cells(r[["columns"]]); vals <- as.list(cells); names(vals) <- nm[seq_along(vals)]
    eid <- .fox_uri_id(.fox_or(r[["entityLink"]][["contentUri"]], NULL))
    as.data.frame(c(extra, vals, list(entity_id = eid)), stringsAsFactors = FALSE)
  })
  dplyr::bind_rows(recs)
}

# ---- parsers (return data.frame) ------------------------------------------
.fox_bb_pbp <- function(raw, game_id) {
  rows <- list()
  for (sec in .fox_or(raw[["pbp"]][["sections"]], list())) {
    for (grp in .fox_or(sec[["groups"]], list())) {
      period <- .fox_or(grp[["title"]], NA_character_)
      left <- .fox_or(grp[["leftTeamAbbr"]], NA_character_)
      right <- .fox_or(grp[["rightTeamAbbr"]], NA_character_)
      for (p in .fox_or(grp[["plays"]], list())) {
        rows[[length(rows) + 1]] <- data.frame(
          game_id = as.character(game_id), period = period, left_team = left, right_team = right,
          play_id = as.character(.fox_or(p[["id"]], NA_character_)),
          clock = .fox_or(p[["timeOfPlay"]], NA_character_),
          team = .fox_or(p[["entityLink"]][["title"]], .fox_or(p[["imageAltText"]], NA_character_)),
          left_score_change = as.character(.fox_or(p[["leftTeamScoreChange"]], NA)),
          right_score_change = as.character(.fox_or(p[["rightTeamScoreChange"]], NA)),
          play_text = .fox_or(p[["playDescription"]], NA_character_), stringsAsFactors = FALSE)
      }
    }
  }
  if (length(rows)) do.call(rbind, rows) else data.frame()
}
.fox_bb_boxscore <- function(raw, game_id) {
  rows <- list()
  for (sec in .fox_or(raw[["boxscore"]][["boxscoreSections"]], list())) {
    team <- .fox_or(sec[["title"]], NA_character_)
    for (item in .fox_or(sec[["boxscoreItems"]], list())) {
      tbl <- item[["boxscoreTable"]]; if (is.null(tbl)) next
      hdr <- .fox_cells(tbl[["headers"]][[1]][["columns"]])
      stat_group <- .fox_or(hdr[1], NA_character_)
      stat_names <- janitor::make_clean_names(.fox_or(hdr[-1], character(0)))
      for (r in .fox_or(tbl[["rows"]], list())) {
        cells <- .fox_cells(r[["columns"]]); player <- .fox_or(cells[1], NA_character_)
        aid <- .fox_uri_id(.fox_or(r[["entityLink"]][["contentUri"]], NULL)); vals <- cells[-1]
        for (j in seq_along(vals)) {
          rows[[length(rows) + 1]] <- data.frame(
            game_id = as.character(game_id), team = team, stat_group = stat_group,
            player = player, athlete_id = aid,
            stat = .fox_or(stat_names[j], paste0("v", j)), value = vals[j], stringsAsFactors = FALSE)
        }
      }
    }
  }
  if (length(rows)) do.call(rbind, rows) else data.frame()
}
.fox_bb_roster <- function(raw, team_id) {
  rows <- list()
  for (g in .fox_or(raw[["groups"]], list())) {
    hdr <- .fox_cells(g[["headers"]][[1]][["columns"]])
    group_label <- .fox_or(g[["title"]], .fox_or(hdr[1], NA_character_))
    col_names <- c("player", tolower(.fox_or(hdr[-1], character(0))))
    for (r in .fox_or(g[["rows"]], list())) {
      uri <- .fox_or(r[["entityLink"]][["contentUri"]], NULL)
      if (is.null(uri) || !grepl("athletes/", uri)) next
      cells <- .fox_cells(r[["columns"]]); vals <- as.list(cells); names(vals) <- col_names[seq_along(vals)]
      rows[[length(rows) + 1]] <- data.frame(
        team_id = as.character(team_id), position_group = group_label,
        as.data.frame(vals, stringsAsFactors = FALSE), athlete_id = .fox_uri_id(uri), stringsAsFactors = FALSE)
    }
  }
  if (length(rows)) dplyr::bind_rows(rows) else data.frame()
}
.fox_bb_team_stats <- function(raw, team_id) {
  rows <- list()
  for (sec in .fox_or(raw[["leadersSections"]], list())) {
    for (ld in .fox_or(sec[["leaders"]], list())) {
      rows[[length(rows) + 1]] <- data.frame(
        team_id = as.character(team_id), category = .fox_or(sec[["title"]], NA_character_),
        stat = .fox_or(ld[["title"]], NA_character_),
        stat_abbreviation = .fox_or(ld[["statAbbreviation"]], NA_character_),
        player = .fox_or(ld[["name"]], NA_character_), value = .fox_or(ld[["statValue"]], NA_character_),
        stringsAsFactors = FALSE)
    }
  }
  if (length(rows)) do.call(rbind, rows) else data.frame()
}
.fox_bb_gamelog <- function(raw, team_id) {
  rows <- list()
  for (sec in .fox_or(raw[["sectionList"]], list())) {
    category <- .fox_or(sec[["id"]], NA_character_)
    for (tbl in .fox_or(sec[["tables"]], list())) {
      hdr <- .fox_cells(tbl[["headers"]][[1]][["columns"]])
      season_type <- .fox_or(hdr[1], NA_character_)
      stat_names <- janitor::make_clean_names(.fox_or(hdr[-(1:2)], character(0)))
      for (r in .fox_or(tbl[["rows"]], list())) {
        cells <- .fox_cells(r[["columns"]]); gid <- .fox_uri_id(.fox_or(r[["entityLink"]][["contentUri"]], NULL))
        vals <- cells[-(1:2)]
        for (j in seq_along(vals)) {
          rows[[length(rows) + 1]] <- data.frame(
            team_id = as.character(team_id), season_type = season_type, category = category, game_id = gid,
            game_date = .fox_or(cells[1], NA_character_), opponent = .fox_or(cells[2], NA_character_),
            stat = .fox_or(stat_names[j], paste0("v", j)), value = vals[j], stringsAsFactors = FALSE)
        }
      }
    }
  }
  if (length(rows)) do.call(rbind, rows) else data.frame()
}
.fox_bb_standings <- function(raw, team_id) {
  parts <- list()
  for (s in .fox_or(raw[["standingsSections"]], list())) {
    for (tbl in .fox_or(s[["standings"]], list())) {
      parts[[length(parts) + 1]] <- .fox_table_df(
        tbl, extra = list(team_id = as.character(team_id), section = .fox_or(s[["title"]], NA_character_)))
    }
  }
  dplyr::bind_rows(parts)
}
.fox_bb_teams <- function(raw) {
  rows <- list()
  for (s in .fox_or(raw[["standingsSections"]], list())) {
    section <- .fox_or(
      tryCatch(s[["metadata"]][["parameters"]][[3]], error = function(e) NULL),
      .fox_or(s[["pageTitle"]], .fox_or(s[["title"]], NA_character_)))
    for (tbl in .fox_or(s[["standings"]], list())) {
      for (r in .fox_or(tbl[["rows"]], list())) {
        cells <- .fox_cells(r[["columns"]])
        eid <- .fox_uri_id(.fox_or(r[["entityLink"]][["contentUri"]], NULL))
        if (is.na(eid)) next
        title <- .fox_or(r[["entityLink"]][["title"]], NA_character_)
        nm <- if (!is.na(title)) stringr::str_to_title(tolower(title)) else .fox_or(cells[2], NA_character_)
        rows[[length(rows) + 1]] <- data.frame(
          fox_team_id = eid, fox_team_name = nm, fox_section = section,
          stringsAsFactors = FALSE)
      }
    }
  }
  if (!length(rows)) return(data.frame())
  out <- dplyr::bind_rows(rows)
  out[!duplicated(out$fox_team_id), , drop = FALSE]
}
.fox_bb_leaders <- function(raw) {
  parts <- lapply(.fox_or(raw[["sectionList"]], list()), function(s) .fox_table_df(s[["table"]]))
  dplyr::bind_rows(parts)
}
.fox_bb_odds <- function(raw, game_id) {
  sp <- raw[["sixPack"]]; o <- if (is.null(sp)) NULL else sp[["odds"]]; rows <- list()
  if (!is.null(o)) {
    hdr <- janitor::make_clean_names(.fox_cells(o[["columnHeaders"]]))
    for (r in .fox_or(o[["rows"]], list())) {
      vals <- vapply(.fox_or(r[["values"]], list()),
                     function(v) as.character(.fox_or(v[["odds"]], NA_character_)), character(1))
      rec <- as.list(vals); names(rec) <- hdr[seq_along(rec)]
      rows[[length(rows) + 1]] <- data.frame(
        game_id = as.character(game_id), team = .fox_or(r[["fullText"]], .fox_or(r[["text"]], NA_character_)),
        as.data.frame(rec, stringsAsFactors = FALSE), stringsAsFactors = FALSE)
    }
  }
  if (length(rows)) dplyr::bind_rows(rows) else data.frame()
}

# ---- dispatcher ------------------------------------------------------------
#' @keywords internal
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble bind_rows
.fox_bb_resource <- function(sport, resource, game_id = NULL, team_id = NULL,
                             category = "scoring", who = "player", page = 0) {
  type <- paste0("Fox Sports ", toupper(sport), " ", resource)
  out <- .empty_hoopR_data(type)
  tryCatch(
    expr = {
      raw <- switch(
        resource,
        pbp = , boxscore = .fox_bb_get(paste0(sport, "/event/", game_id, "/data")),
        odds = .fox_bb_get(paste0(sport, "/event/", game_id, "/odds")),
        league_leaders = .fox_bb_get(paste0(sport, "/league/stats-con/", who, "/", category, "/", page)),
        roster = .fox_bb_get(paste0(sport, "/team/", team_id, "/roster")),
        team_stats = .fox_bb_get(paste0(sport, "/team/", team_id, "/stats")),
        gamelog = .fox_bb_get(paste0(sport, "/team/", team_id, "/gamelog")),
        standings = .fox_bb_get(paste0(sport, "/team/", team_id, "/standings")),
        teams = .fox_bb_get(paste0(sport, "/team/", team_id, "/standings")))
      df <- switch(
        resource,
        pbp = .fox_bb_pbp(raw, game_id), boxscore = .fox_bb_boxscore(raw, game_id),
        odds = .fox_bb_odds(raw, game_id), roster = .fox_bb_roster(raw, team_id),
        team_stats = .fox_bb_team_stats(raw, team_id), gamelog = .fox_bb_gamelog(raw, team_id),
        standings = .fox_bb_standings(raw, team_id), league_leaders = .fox_bb_leaders(raw),
        teams = .fox_bb_teams(raw))
      out <- df |>
        dplyr::as_tibble() |>
        janitor::clean_names() |>
        make_hoopR_data(type, Sys.time())
    },
    error = function(e) {
      cli::cli_alert_danger(
        "{Sys.time()}: no Fox {toupper(sport)} {resource} data available!")
      cli::cli_alert_danger("Error: {conditionMessage(e)}")
    }
  )
  out
}

# ---- public wrappers (nba + mbb share each resource via @rdname) -----------

# ---------------------------------------------------------------------------
# fox_basketball_pbp
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Play-by-Play**
#' @name fox_basketball_pbp
NULL
#' @title
#' **Get Fox Sports Basketball Play-by-Play**
#' @rdname fox_basketball_pbp
#' @author Saiem Gilani
#' @param game_id Fox Bifrost event id (e.g. `"106422"`).
#' @return A `hoopR_data` tibble, one row per play: `game_id`, `period`,
#'   `left_team`, `right_team`, `play_id`, `clock`, `team`, `left_score_change`,
#'   `right_score_change`, `play_text`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_pbp("106422"))
#' }
fox_nba_pbp <- function(game_id) .fox_bb_resource("nba", "pbp", game_id = game_id)
#' @rdname fox_basketball_pbp
#' @export
#' @examples
#' \donttest{
#'   try(fox_mbb_pbp("262052"))
#' }
fox_mbb_pbp <- function(game_id) .fox_bb_resource("cbk", "pbp", game_id = game_id)

# ---------------------------------------------------------------------------
# fox_basketball_boxscore
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Boxscore**
#' @name fox_basketball_boxscore
NULL
#' @title
#' **Get Fox Sports Basketball Boxscore**
#' @rdname fox_basketball_boxscore
#' @author Saiem Gilani
#' @param game_id Fox Bifrost event id.
#' @return A `hoopR_data` tibble (long), one row per (player, stat): `game_id`,
#'   `team`, `stat_group`, `player`, `athlete_id`, `stat`, `value`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_boxscore("106422"))
#' }
fox_nba_boxscore <- function(game_id) .fox_bb_resource("nba", "boxscore", game_id = game_id)
#' @rdname fox_basketball_boxscore
#' @export
fox_mbb_boxscore <- function(game_id) .fox_bb_resource("cbk", "boxscore", game_id = game_id)

# ---------------------------------------------------------------------------
# fox_basketball_odds
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Game Odds**
#' @name fox_basketball_odds
NULL
#' @title
#' **Get Fox Sports Basketball Game Odds**
#' @rdname fox_basketball_odds
#' @author Saiem Gilani
#' @param game_id Fox Bifrost event id.
#' @return A `hoopR_data` tibble, one row per team: `game_id`, `team`, plus the
#'   six-pack odds columns (spread / to-win / total). Empty when no market.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_odds("106422"))
#' }
fox_nba_odds <- function(game_id) .fox_bb_resource("nba", "odds", game_id = game_id)
#' @rdname fox_basketball_odds
#' @export
fox_mbb_odds <- function(game_id) .fox_bb_resource("cbk", "odds", game_id = game_id)

# ---------------------------------------------------------------------------
# fox_basketball_team_roster
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Team Roster**
#' @name fox_basketball_team_roster
NULL
#' @title
#' **Get Fox Sports Basketball Team Roster**
#' @rdname fox_basketball_team_roster
#' @author Saiem Gilani
#' @param team_id Fox Bifrost team id (e.g. `"1"`). Discover via the league team directory.
#' @return A `hoopR_data` tibble, one row per player: `team_id`, `position_group`,
#'   `player`, position/age/etc. columns, `athlete_id`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_team_roster("1"))
#' }
fox_nba_team_roster <- function(team_id) .fox_bb_resource("nba", "roster", team_id = team_id)
#' @rdname fox_basketball_team_roster
#' @export
fox_mbb_team_roster <- function(team_id) .fox_bb_resource("cbk", "roster", team_id = team_id)

# ---------------------------------------------------------------------------
# fox_basketball_team_stats
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Team Stat Leaders**
#' @name fox_basketball_team_stats
NULL
#' @title
#' **Get Fox Sports Basketball Team Stat Leaders**
#' @rdname fox_basketball_team_stats
#' @author Saiem Gilani
#' @param team_id Fox Bifrost team id.
#' @return A `hoopR_data` tibble: `team_id`, `category`, `stat`,
#'   `stat_abbreviation`, `player`, `value`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_team_stats("1"))
#' }
fox_nba_team_stats <- function(team_id) .fox_bb_resource("nba", "team_stats", team_id = team_id)
#' @rdname fox_basketball_team_stats
#' @export
fox_mbb_team_stats <- function(team_id) .fox_bb_resource("cbk", "team_stats", team_id = team_id)

# ---------------------------------------------------------------------------
# fox_basketball_team_gamelog
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Team Game Log**
#' @name fox_basketball_team_gamelog
NULL
#' @title
#' **Get Fox Sports Basketball Team Game Log**
#' @rdname fox_basketball_team_gamelog
#' @author Saiem Gilani
#' @param team_id Fox Bifrost team id.
#' @return A `hoopR_data` tibble (long): `team_id`, `season_type`, `category`,
#'   `game_id`, `game_date`, `opponent`, `stat`, `value`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_team_gamelog("1"))
#' }
fox_nba_team_gamelog <- function(team_id) .fox_bb_resource("nba", "gamelog", team_id = team_id)
#' @rdname fox_basketball_team_gamelog
#' @export
fox_mbb_team_gamelog <- function(team_id) .fox_bb_resource("cbk", "gamelog", team_id = team_id)

# ---------------------------------------------------------------------------
# fox_basketball_standings
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Standings**
#' @name fox_basketball_standings
NULL
#' @title
#' **Get Fox Sports Basketball Standings**
#' @rdname fox_basketball_standings
#' @author Saiem Gilani
#' @param team_id Fox Bifrost team id (standings of that team's conference/division).
#' @return A `hoopR_data` tibble of standings rows (`team_id`, `section`, the
#'   standings columns, `entity_id`).
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_standings("1"))
#' }
fox_nba_standings <- function(team_id) .fox_bb_resource("nba", "standings", team_id = team_id)
#' @rdname fox_basketball_standings
#' @export
fox_mbb_standings <- function(team_id) .fox_bb_resource("cbk", "standings", team_id = team_id)

# ---------------------------------------------------------------------------
# fox_basketball_teams
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Team Directory**
#' @name fox_basketball_teams
NULL
#' @title
#' **Get Fox Sports Basketball Team Directory**
#' @rdname fox_basketball_teams
#' @author Saiem Gilani
#' @param team_id Fox Bifrost seed team id used to fetch league standings
#'   (default `"1"`); the standings response enumerates every team in the seed's
#'   league sections.
#' @return A `hoopR_data` tibble, one row per team: `fox_team_id`, `fox_team_name`, `fox_section`.
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_teams())
#' }
fox_nba_teams <- function(team_id = "1") .fox_bb_resource("nba", "teams", team_id = team_id)
#' @rdname fox_basketball_teams
#' @export
fox_mbb_teams <- function(team_id = "1") .fox_bb_resource("cbk", "teams", team_id = team_id)

#' @title
#' **Get the full Fox Sports men's college basketball team directory**
#' @description
#' **Enumerate every MBB team in the Fox Sports (Bifrost) directory.** A single
#' `fox_mbb_teams()` call only returns the seed team's conference, so this walks
#' unseen team ids (one seed per conference) and unions the results.
#' @param max_id Highest Fox team id to probe as a seed (default `500`).
#' @param max_calls Safety cap on the number of standings calls (default `60`).
#' @return A `hoopR_data` tibble, one row per team: `fox_team_id`,
#'   `fox_team_name`, `fox_section`.
#' @importFrom dplyr bind_rows
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_mbb_teams_all())
#' }
fox_mbb_teams_all <- function(max_id = 500, max_calls = 60) {
  seen <- character(0)
  parts <- list()
  calls <- 0L
  for (cand in seq_len(max_id)) {
    if (calls >= max_calls) break
    if (as.character(cand) %in% seen) next
    df <- tryCatch(fox_mbb_teams(team_id = as.character(cand)), error = function(e) NULL)
    calls <- calls + 1L
    if (is.null(df) || !nrow(df)) next
    parts[[length(parts) + 1L]] <- df
    seen <- union(seen, as.character(df$fox_team_id))
  }
  out <- if (length(parts)) dplyr::bind_rows(parts) else data.frame(
    fox_team_id = character(), fox_team_name = character(), fox_section = character(),
    stringsAsFactors = FALSE)
  out <- out[!duplicated(out$fox_team_id), , drop = FALSE]
  make_hoopR_data(out, "Fox Sports MBB full team directory", Sys.time())
}

# ---------------------------------------------------------------------------
# fox_basketball_league_leaders
# ---------------------------------------------------------------------------

#' **Get Fox Sports Basketball Statistical Leaders**
#' @name fox_basketball_league_leaders
NULL
#' @title
#' **Get Fox Sports Basketball Statistical Leaders**
#' @rdname fox_basketball_league_leaders
#' @author Saiem Gilani
#' @param category Stat category (default `"scoring"`).
#' @param who `"player"` or `"team"` (default `"player"`).
#' @param page 0-based page index (default `0`).
#' @return A `hoopR_data` tibble of leaderboard rows (`entity_id` + stat columns).
#' @export
#' @family Fox Basketball Functions
#' @examples
#' \donttest{
#'   try(fox_nba_league_leaders("scoring"))
#' }
fox_nba_league_leaders <- function(category = "scoring", who = "player", page = 0) {
  .fox_bb_resource("nba", "league_leaders", category = category, who = who, page = page)
}
#' @rdname fox_basketball_league_leaders
#' @export
fox_mbb_league_leaders <- function(category = "scoring", who = "player", page = 0) {
  .fox_bb_resource("cbk", "league_leaders", category = category, who = who, page = page)
}
