#' NBA officiating data from official.nba.com
#'
#' Last Two Minute (L2M) reports and referee crew assignments, scraped from
#' official.nba.com. Port of the scraping logic in
#' \href{https://github.com/atlhawksfanatic/L2M}{atlhawksfanatic/L2M} (MIT,
#' (c) 2019 atlhawksfanatic). official.nba.com is S3 behind Akamai Bot
#' Manager: a browser User-Agent is required, and a 403 means two different
#' things -- an S3 XML `AccessDenied` body means "no such report" (signalled
#' as a `hoopR_no_data` condition) while an Akamai HTML interstitial means the
#' fetch was blocked (signalled as a `hoopR_fetch_error` condition).
#' @name nba_officiating
#' @keywords internal
NULL

.OFFICIAL_SEASON_TYPES <- c(
  "1" = "preseason", "2" = "regular", "3" = "all-star",
  "4" = "playoffs", "5" = "play-in", "6" = "nba-cup-final"
)
.OFFICIAL_DECISIONS <- c(
  "CC" = "CC", "CNC" = "CNC", "IC" = "IC", "INC" = "INC",
  "NCC" = "CNC", "NCI" = "INC"
)

# Reuse the CDN browser-UA header set, pointed at official.nba.com instead
# of nba.com -- the libcurl/httr2 default UA is Akamai-blocked outright.
.official_nba_headers <- function() {
  h <- .nba_cdn_headers()
  h["Referer"] <- "https://official.nba.com/"
  h
}

#' Classify an official.nba.com 403 body
#' @keywords internal
.classify_official_403 <- function(body) {
  if (isTRUE(grepl("<Code>AccessDenied</Code>", body, fixed = TRUE))) "no_data" else "fetch_error"
}

.signal_official_condition <- function(kind, message) {
  cls <- if (identical(kind, "no_data")) "hoopR_no_data" else "hoopR_fetch_error"
  stop(structure(
    class = c(cls, "error", "condition"),
    list(message = message, call = sys.call(-1))
  ))
}

#' GET a URL from official.nba.com, signalling classed conditions on failure
#'
#' Returns the response body (character) on HTTP 200. On any other status,
#' classifies the body via [.classify_official_403()] and `stop()`s a classed
#' condition (`hoopR_no_data` / `hoopR_fetch_error`) instead of returning.
#' `.retry_request()` never errors on HTTP status itself, so the status/body
#' must be read here.
#' @keywords internal
.official_nba_get <- function(url, params = list(), proxy = NULL) {
  resp <- .retry_request(url, params = params, headers = .official_nba_headers(), proxy = proxy)
  status <- httr2::resp_status(resp)
  body <- .resp_text(resp)
  if (identical(status, 200L)) {
    return(body)
  }
  kind <- .classify_official_403(body)
  .signal_official_condition(
    kind,
    sprintf("official.nba.com %s (HTTP %d): %s", kind, status, url)
  )
}

.gid10 <- function(game_id) {
  sprintf("%010d", as.integer(game_id))
}

# ---------------------------------------------------------------------------
# L2M reports
# ---------------------------------------------------------------------------

.L2M_CALLS_COLS <- c(
  "game_id", "period", "period_name", "pc_time", "seconds_remaining",
  "call_type", "call", "type", "committing", "disadvantaged", "decision",
  "decision_raw", "comment", "difficulty", "video_event_id", "pos_id",
  "pos_start", "pos_end", "pos_team_id"
)
.L2M_GAME_COLS <- c(
  "game_id", "game_date", "season_type", "home_team_id", "away_team_id",
  "home_team_abbr", "away_team_abbr", "home_team_name", "away_team_name",
  "home_score", "away_score", "l2m_comments"
)
.L2M_STATS_COLS <- c("game_id", "stat_name", "home", "away")

#' Parse a Last Two Minute report payload (internal)
#'
#' @param x list. Result of `jsonlite::fromJSON(path, simplifyVector = TRUE)`
#'   on an official.nba.com `l2m/json/<game_id>.json` payload.
#' @return Named list of `hoopR_data` tibbles: `calls`, `game`, `stats`.
#' @keywords internal
.parse_nba_l2m <- function(x) {
  g <- x$game
  if (is.data.frame(g)) g <- if (nrow(g) > 0) as.list(g[1, , drop = FALSE]) else NULL
  if (is.list(g) && length(g) == 0) g <- NULL
  gid <- if (!is.null(g) && !is.null(g$GameId) && !is.na(g$GameId) && nzchar(as.character(g$GameId))) {
    .gid10(g$GameId)
  } else {
    NA_character_
  }

  l2m <- x$l2m
  if (is.null(l2m) || (is.data.frame(l2m) && nrow(l2m) == 0) || length(l2m) == 0) {
    calls <- stats::setNames(as.data.frame(replicate(length(.L2M_CALLS_COLS), character(0), simplify = FALSE),
      stringsAsFactors = FALSE
    ), .L2M_CALLS_COLS)
  } else {
    l2m <- as.data.frame(l2m, stringsAsFactors = FALSE)
    period_name <- as.character(l2m$PeriodName)
    pc_time <- as.character(l2m$PCTime)
    pc_norm <- sub("^(\\d+):(\\d+):(\\d+)$", "\\1:\\2.\\3", pc_time)
    minutes <- suppressWarnings(as.numeric(sub("^(\\d+):.*$", "\\1", pc_norm)))
    seconds <- suppressWarnings(as.numeric(sub("^\\d+:(\\d+(?:\\.\\d+)?)\\.?$", "\\1", pc_norm, perl = TRUE)))
    call_type_raw <- gsub("\\s+", " ", trimws(as.character(l2m$CallType)))
    decision_raw <- as.character(l2m$CallRatingName)
    decision_clean <- sub("\\*$", "", trimws(decision_raw))
    decision <- unname(.OFFICIAL_DECISIONS[decision_clean])

    calls <- data.frame(
      game_id = rep(gid, nrow(l2m)),
      period = suppressWarnings(as.integer(regmatches(period_name, regexpr("\\d+", period_name)))),
      period_name = period_name,
      pc_time = pc_time,
      seconds_remaining = minutes * 60 + seconds,
      call_type = call_type_raw,
      call = toupper(trimws(sub("^([^:]+):.*$", "\\1", call_type_raw))),
      type = toupper(trimws(sub("^[^:]+:\\s*(.+)$", "\\1", call_type_raw))),
      committing = dplyr::na_if(as.character(l2m$CP), ""),
      disadvantaged = dplyr::na_if(as.character(l2m$DP), ""),
      decision = decision,
      decision_raw = decision_raw,
      comment = as.character(l2m$Comment),
      difficulty = as.character(l2m$Difficulty),
      video_event_id = if (!is.null(l2m$VideolLink)) as.character(l2m$VideolLink) else NA_character_,
      pos_id = suppressWarnings(as.numeric(l2m$posID)),
      pos_start = as.character(l2m$posStart),
      pos_end = as.character(l2m$posEnd),
      pos_team_id = suppressWarnings(as.numeric(l2m$posTeamId)),
      stringsAsFactors = FALSE
    )
    calls <- calls[, .L2M_CALLS_COLS]
  }

  game <- if (!is.null(g)) {
    data.frame(
      game_id = gid,
      game_date = if (!is.null(g$GameDate)) as.Date(substr(as.character(g$GameDate), 1, 10)) else as.Date(NA),
      season_type = if (!is.na(gid)) unname(.OFFICIAL_SEASON_TYPES[substr(gid, 3, 3)]) else NA_character_,
      home_team_id = suppressWarnings(as.numeric(g$HomeTeamId %||% NA)),
      away_team_id = suppressWarnings(as.numeric(g$AwayTeamId %||% NA)),
      home_team_abbr = as.character(g$Home_team_abbr %||% NA_character_),
      away_team_abbr = as.character(g$Away_team_abbr %||% NA_character_),
      home_team_name = as.character(g$Home_team %||% NA_character_),
      away_team_name = as.character(g$Away_team %||% NA_character_),
      home_score = suppressWarnings(as.integer(g$HomeTeamScore %||% NA)),
      away_score = suppressWarnings(as.integer(g$VisitorTeamScore %||% NA)),
      l2m_comments = as.character(g$L2M_Comments %||% NA_character_),
      stringsAsFactors = FALSE
    )[, .L2M_GAME_COLS]
  } else {
    stats::setNames(as.data.frame(replicate(length(.L2M_GAME_COLS), character(0), simplify = FALSE),
      stringsAsFactors = FALSE
    ), .L2M_GAME_COLS)
  }

  s <- x$stats
  stats_df <- if (is.null(s) || (is.data.frame(s) && nrow(s) == 0) || length(s) == 0) {
    stats::setNames(as.data.frame(replicate(length(.L2M_STATS_COLS), character(0), simplify = FALSE),
      stringsAsFactors = FALSE
    ), .L2M_STATS_COLS)
  } else {
    s <- as.data.frame(s, stringsAsFactors = FALSE)
    data.frame(
      game_id = rep(gid, nrow(s)),
      stat_name = as.character(s$stats_name),
      home = suppressWarnings(as.integer(s$home)),
      away = suppressWarnings(as.integer(s$away)),
      stringsAsFactors = FALSE
    )[, .L2M_STATS_COLS]
  }

  now <- Sys.time()
  list(
    calls = make_hoopR_data(dplyr::as_tibble(calls), "NBA L2M calls (official.nba.com)", now),
    game = make_hoopR_data(dplyr::as_tibble(game), "NBA L2M game (official.nba.com)", now),
    stats = make_hoopR_data(dplyr::as_tibble(stats_df), "NBA L2M stats (official.nba.com)", now)
  )
}

#' Fetch an NBA Last Two Minute (L2M) report
#'
#' Retrieves and parses the Last Two Minute officiating report for a single
#' NBA game from official.nba.com. A report is published for any game that is
#' within 3 points (5 points before 2017-18) at any point in the last two
#' minutes of the 4th quarter or overtime -- not only playoff games. JSON
#' reports exist only from 2019-01-01 onward.
#'
#' @param game_id character or numeric. NBA game id; zero-padded to 10
#'   digits automatically (e.g. `42500405` becomes `"0042500405"`).
#' @param proxy optional proxy passed to the HTTP layer (see
#'   [.retry_request()]).
#' @return Named list of `hoopR_data` tibbles:
#'   * `calls` -- one row per graded play (`game_id`, `period`, `period_name`,
#'     `pc_time`, `seconds_remaining`, `call_type`, `call`, `type`,
#'     `committing`, `disadvantaged`, `decision`, `decision_raw`, `comment`,
#'     `difficulty`, `video_event_id`, `pos_id`, `pos_start`, `pos_end`,
#'     `pos_team_id`). `decision` is normalized to `CC`/`CNC`/`IC`/`INC`
#'     (`NCC`->`CNC`, `NCI`->`INC`, trailing `*` stripped, blank/
#'     `"Undetectable"` -> `NA`, never `INC`). `game_id` is a 10-char
#'     zero-padded string. Player and team names are kept verbatim (no ASCII
#'     folding).
#'   * `game` -- one row of game metadata.
#'   * `stats` -- 3 rows of error-count stats (`Calls`, `Errors in Favor`,
#'     `Possessions in Favor`).
#' @family NBA Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     l2m <- nba_l2m(game_id = "0042500405")
#'     head(l2m$calls)
#'   })
#' }
nba_l2m <- function(game_id, proxy = NULL) {
  gid <- .gid10(game_id)
  url <- sprintf("https://official.nba.com/l2m/json/%s.json", gid)
  body <- .official_nba_get(url, proxy = proxy)
  x <- jsonlite::fromJSON(body, simplifyVector = TRUE)
  .parse_nba_l2m(x)
}

# ---------------------------------------------------------------------------
# L2M season game listing
# ---------------------------------------------------------------------------

.LISTING_RE <- "L2MReport\\.html\\?gameId=(?:%0[dD])?(\\d{10})[^>]*>([^<]*)</a>"

#' Parse an L2M season listing page (internal)
#' @keywords internal
.parse_nba_l2m_games <- function(html, season) {
  m <- gregexpr(.LISTING_RE, html, perl = TRUE)
  matches <- regmatches(html, m)[[1]]
  if (length(matches) == 0) {
    return(stats::setNames(
      as.data.frame(replicate(4, character(0), simplify = FALSE), stringsAsFactors = FALSE),
      c("game_id", "season", "season_type", "label")
    ))
  }
  gid <- sub("^.*gameId=(?:%0[dD])?(\\d{10}).*$", "\\1", matches, perl = TRUE)
  # A non-breaking space (unplayed/placeholder link text) trims to "" here,
  # matching Python's str.strip() (which treats NBSP as whitespace too).
  label_raw <- sub("^.*>([^<]*)</a>$", "\\1", matches, perl = TRUE)
  label <- trimws(gsub(" ", " ", label_raw))
  keep <- !duplicated(gid)
  gid <- gid[keep]
  label <- label[keep]
  data.frame(
    game_id = gid,
    season = as.integer(season),
    season_type = unname(.OFFICIAL_SEASON_TYPES[substr(gid, 3, 3)]),
    label = label,
    stringsAsFactors = FALSE
  )
}

#' Fetch the list of NBA games with a Last Two Minute report for a season
#'
#' Scrapes official.nba.com's season index page. JSON L2M reports exist only
#' from 2019-01-01 onward; earlier seasons' index pages list PDFs, which this
#' function ignores (use a release loader for that history once published).
#'
#' @param season integer. NBA season, END year (e.g. `2026` for 2025-26).
#' @param proxy optional proxy passed to the HTTP layer.
#' @return A `hoopR_data` tibble, one row per unique game id in page order:
#'   `game_id` (10-char zero-padded string), `season` (END year), `season_type`,
#'   `label` (e.g. `"Knicks 94, Spurs 90"`).
#' @family NBA Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     games <- nba_l2m_games(season = 2026)
#'     head(games)
#'   })
#' }
nba_l2m_games <- function(season, proxy = NULL) {
  span <- sprintf("%d-%s", season - 1L, substr(as.character(season), 3, 4))
  url <- sprintf("https://official.nba.com/%s-nba-officiating-last-two-minute-reports/", span)
  html <- .official_nba_get(url, proxy = proxy)
  # An Akamai 200 interstitial must not look like "no reports for this page".
  if (!grepl("last two minute", html, ignore.case = TRUE)) {
    .signal_official_condition(
      "fetch_error",
      sprintf("official.nba.com listing page missing the 'Last Two Minute' marker (Akamai interstitial?): %s", url)
    )
  }
  df <- .parse_nba_l2m_games(html, season)
  make_hoopR_data(dplyr::as_tibble(df), "NBA L2M games listing (official.nba.com)", Sys.time())
}

# ---------------------------------------------------------------------------
# Referee assignments
# ---------------------------------------------------------------------------

.official_season_end_year <- function(s, league) {
  if (nchar(s) != 5) return(NA_integer_)
  start_year <- suppressWarnings(as.integer(substr(s, 2, 5)))
  if (league %in% c("nba", "gl")) start_year + 1L else start_year
}

.ASSIGN_OFFICIALS_COLS <- c(
  "league", "game_id", "game_date", "season", "season_type", "game_code",
  "home_team_id", "home_team_abbr", "away_team_id", "away_team_abbr",
  "crew_position", "official_id", "official_name", "jersey_num"
)
.ASSIGN_REPLAY_COLS <- c("league", "game_date", "official_id", "official_name")

#' Parse a referee-assignments payload (internal)
#'
#' @param x list. Result of `jsonlite::fromJSON(path, simplifyVector = FALSE)`
#'   on an official.nba.com `get-game-officials` payload (top-level keys
#'   `nba`, `gl`, `wnba`).
#' @param league character(1). One of `"nba"`, `"gl"`, `"wnba"`.
#' @return Named list of `hoopR_data` tibbles: `officials`, `replay_center`.
#' @keywords internal
.parse_nba_referee_assignments <- function(x, league = "nba") {
  if (!league %in% c("nba", "gl", "wnba")) {
    stop(sprintf("league must be 'nba', 'gl' or 'wnba', got %s", league))
  }
  block <- x[[league]]
  table_rows <- tryCatch(block$Table$rows, error = function(e) NULL)
  if (is.null(table_rows)) table_rows <- list()

  officials_rows <- list()
  for (g in table_rows) {
    s <- as.character(g$season %||% "")
    for (k in 1:4) {
      nm <- g[[paste0("official", k)]]
      if (is.null(nm) || !nzchar(as.character(nm))) next
      officials_rows[[length(officials_rows) + 1]] <- data.frame(
        league = league,
        game_id = .gid10(g$game_id),
        game_date = as.Date(as.character(g$game_date %||% NA), format = "%m/%d/%Y"),
        season = .official_season_end_year(s, league),
        season_type = unname(.OFFICIAL_SEASON_TYPES[substr(s, 1, 1)]),
        game_code = as.character(g$game_code %||% NA_character_),
        home_team_id = suppressWarnings(as.numeric(g$home_team_id %||% NA)),
        home_team_abbr = as.character(g$home_team_abbr %||% NA_character_),
        away_team_id = suppressWarnings(as.numeric(g$away_team_id %||% NA)),
        away_team_abbr = as.character(g$away_team_abbr %||% NA_character_),
        crew_position = k,
        official_id = suppressWarnings(as.numeric(g[[paste0("official", k, "_code")]] %||% NA)),
        official_name = as.character(nm),
        jersey_num = as.character(g[[paste0("official", k, "_JNum")]] %||% NA_character_),
        stringsAsFactors = FALSE
      )
    }
  }
  officials <- if (length(officials_rows)) {
    dplyr::bind_rows(officials_rows)[, .ASSIGN_OFFICIALS_COLS]
  } else {
    stats::setNames(
      as.data.frame(replicate(length(.ASSIGN_OFFICIALS_COLS), character(0), simplify = FALSE), stringsAsFactors = FALSE),
      .ASSIGN_OFFICIALS_COLS
    )
  }

  table1_rows <- tryCatch(block$Table1$rows, error = function(e) NULL)
  if (is.null(table1_rows)) table1_rows <- list()
  replay_rows <- list()
  for (r in table1_rows) {
    replay_rows[[length(replay_rows) + 1]] <- data.frame(
      league = league,
      game_date = as.Date(as.character(r$game_date %||% NA), format = "%m/%d/%Y"),
      official_id = suppressWarnings(as.numeric(r$official_code %||% NA)),
      official_name = as.character(r$replaycenter_official %||% NA_character_),
      stringsAsFactors = FALSE
    )
  }
  replay_center <- if (length(replay_rows)) {
    dplyr::bind_rows(replay_rows)[, .ASSIGN_REPLAY_COLS]
  } else {
    stats::setNames(
      as.data.frame(replicate(length(.ASSIGN_REPLAY_COLS), character(0), simplify = FALSE), stringsAsFactors = FALSE),
      .ASSIGN_REPLAY_COLS
    )
  }

  now <- Sys.time()
  list(
    officials = make_hoopR_data(dplyr::as_tibble(officials), "NBA referee assignments -- officials (official.nba.com)", now),
    replay_center = make_hoopR_data(dplyr::as_tibble(replay_center), "NBA referee assignments -- replay center (official.nba.com)", now)
  )
}

#' Fetch NBA/G-League/WNBA referee crew assignments for a date
#'
#' Retrieves referee crew assignments and replay-center officials for every
#' game on a date, from official.nba.com's `get-game-officials` endpoint
#' (covers NBA, G-League, and WNBA in one payload).
#'
#' `crew_position` is the feed's slot order (1-4); slot 1 is *inferred* to be
#' the crew chief from that ordering -- the API does not label roles
#' directly. `season` converts the feed's `<type digit><START year>` code to
#' an END year: START+1 for `"nba"`/`"gl"` (two-calendar-year seasons), START
#' unchanged for `"wnba"` (single-year seasons).
#'
#' @param date character or Date. Date to fetch, `"YYYY-MM-DD"`.
#' @param league character(1). One of `"nba"` (default), `"gl"`, `"wnba"`.
#' @param proxy optional proxy passed to the HTTP layer.
#' @return Named list of `hoopR_data` tibbles:
#'   * `officials` -- one row per game x crew slot: `league`, `game_id`,
#'     `game_date`, `season`, `season_type`, `game_code`, `home_team_id`,
#'     `home_team_abbr`, `away_team_id`, `away_team_abbr`, `crew_position`,
#'     `official_id`, `official_name`, `jersey_num`.
#'   * `replay_center` -- one row per replay-center official per game/day:
#'     `league`, `game_date`, `official_id`, `official_name`.
#'
#'   A date with no games for the league is not an error -- both tibbles come
#'   back zero-row rather than raising.
#' @family NBA Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     refs <- nba_referee_assignments(date = "2026-06-13")
#'     head(refs$officials)
#'   })
#' }
nba_referee_assignments <- function(date, league = "nba", proxy = NULL) {
  if (!league %in% c("nba", "gl", "wnba")) {
    stop(sprintf("league must be 'nba', 'gl' or 'wnba', got %s", league))
  }
  day <- if (inherits(date, "Date")) format(date, "%Y-%m-%d") else as.character(date)
  url <- sprintf("https://official.nba.com/wp-json/api/v1/get-game-officials?&date=%s", day)
  body <- .official_nba_get(url, proxy = proxy)
  x <- jsonlite::fromJSON(body, simplifyVector = FALSE)
  .parse_nba_referee_assignments(x, league)
}
