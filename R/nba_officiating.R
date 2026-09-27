#' NBA officiating data from official.nba.com
#'
#' Last Two Minute (L2M) reports and referee crew assignments, scraped from
#' official.nba.com. Port of the scraping logic in
#' \href{https://github.com/atlhawksfanatic/L2M}{atlhawksfanatic/L2M} (MIT,
#' (c) 2019 atlhawksfanatic). official.nba.com is S3 behind Akamai Bot
#' Manager: a browser User-Agent is required, and a 403 means two different
#' things -- an S3 XML `AccessDenied` body means "no such report" (signalled
#' as a `hoopR_no_data` condition) while an Akamai HTML interstitial means the
#' fetch was blocked (signalled as a `hoopR_fetch_error` condition). Each of
#' [nba_l2m()], [nba_l2m_games()] and [nba_referee_assignments()] lists the
#' conditions it can raise in its own Errors section.
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

#' Classify an official.nba.com 403 response body
#'
#' A 403 from official.nba.com means two different things depending on the
#' body: an S3 XML `AccessDenied` document means "no such object" (there is
#' no report/no data for the request), while anything else (typically an
#' Akamai HTML interstitial) means the fetch itself was blocked.
#' @param body character(1). Response body text.
#' @return character(1). `"no_data"` or `"fetch_error"`.
#' @keywords internal
.classify_official_403 <- function(body) {
  if (isTRUE(grepl("<Code>AccessDenied</Code>", body, fixed = TRUE))) "no_data" else "fetch_error"
}

# Full HTTP-status classification (P1): 404 is always "no such report"; a 403
# defers to the body (S3 AccessDenied vs. an Akamai block); anything else
# (5xx, a non-403 4xx, etc.) is an unclassified fetch failure -- even if its
# body happens to also carry an AccessDenied fragment, since only a 403 gets
# that reclassification.
.classify_official_response <- function(status, body) {
  if (identical(status, 404L)) {
    return("no_data")
  }
  if (identical(status, 403L)) {
    return(.classify_official_403(body))
  }
  "fetch_error"
}

#' GET a URL from official.nba.com, signalling classed conditions on failure
#'
#' Returns the response body (character) on HTTP 200. Any other status raises
#' a classed condition instead of returning: a 404 is always `hoopR_no_data`;
#' only a 403 reads the body, via [.classify_official_403()] (an S3
#' `AccessDenied` document is `hoopR_no_data`, anything else
#' `hoopR_fetch_error`); every other status is `hoopR_fetch_error`. The
#' request is built directly against httr2 here (rather than delegating to
#' the shared [.retry_request()]) so the retry policy can treat 403/404 as
#' definitive instead of transient, and so a transport-level failure (DNS,
#' TLS, a dropped connection) is retried, then reclassified into the same
#' error vocabulary instead of escaping as a raw curl/httr2 condition. Only
#' [httr2::req_perform()] is wrapped: an error while building the request (a
#' malformed `proxy`, say) is the caller's mistake and propagates unchanged.
#' A response without a body (a bare 503, an empty 200) is classified by its
#' status like any other.
#' @param url character(1). Full official.nba.com URL to fetch.
#' @param params Named list of query parameters, spliced onto `url` (default:
#'   empty list).
#' @param proxy Optional proxy: a URL string (e.g. `"http://host:port"`) or a
#'   named list of [httr2::req_proxy()] arguments (`url`, `port`, `username`,
#'   `password`, `auth`). `NULL` (the default) falls back to `getOption("hoopR.proxy")`, then the
#'   `http_proxy`/`https_proxy` environment variables.
#' @return character(1). The response body text.
#' @keywords internal
.official_nba_get <- function(url, params = list(), proxy = NULL) {
  call <- sys.call(-1)
  req <- httr2::request(url)
  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }
  req <- httr2::req_headers(req, !!!as.list(.official_nba_headers()))
  # Same resolution order as .retry_request(): argument, then the session option.
  if (is.null(proxy)) proxy <- getOption("hoopR.proxy", default = NULL)
  if (!is.null(proxy)) {
    req <- if (is.list(proxy)) {
      do.call(httr2::req_proxy, c(list(req = req), proxy))
    } else {
      httr2::req_proxy(req, url = proxy)
    }
  }
  req <- req |>
    httr2::req_timeout(60) |>
    httr2::req_retry(
      max_tries = 3,
      # A dropped connection gets the same retry budget as a 5xx, as sdv-py's
      # download() does (httr2 >= 1.0.4 no longer retries failures by default).
      retry_on_failure = TRUE,
      is_transient = function(resp) httr2::resp_status(resp) %in% c(408L, 429L, 500L, 502L, 503L, 504L)
    ) |>
    httr2::req_error(is_error = function(resp) FALSE)
  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(cnd) {
      cli::cli_abort(
        "official.nba.com fetch failed (transport error) for {.url {url}}: {conditionMessage(cnd)}",
        class = c("hoopR_fetch_error", "hoopR_error"),
        parent = cnd,
        call = call
      )
    }
  )
  status <- httr2::resp_status(resp)
  # resp_body_string() raises an unclassed "empty body" error on a bodiless
  # response; read it as "" so the status still decides the class.
  body <- if (httr2::resp_has_body(resp)) .resp_text(resp) else ""
  if (identical(status, 200L)) {
    return(body)
  }
  kind <- .classify_official_response(status, body)
  # A literal template: `url` is interpolated as a value, never re-parsed as glue.
  cli::cli_abort(
    "official.nba.com {kind} (HTTP {status}): {.url {url}}",
    class = c(paste0("hoopR_", kind), "hoopR_error"),
    call = call
  )
}

# Decode a successful (200) official.nba.com body as JSON, or raise
# hoopR_fetch_error (P1): a 200 status does not guarantee a JSON body -- an
# Akamai interstitial or a misconfigured edge response can return HTML with a
# 200 status, and the JSON parser would otherwise raise a raw parse error
# instead of the package's classed error vocabulary. parse_json() (not
# fromJSON()) only ever parses the string: fromJSON() would fetch a body that
# looks like a URL, or read one that names a local file.
.official_nba_json <- function(body, url, simplifyVector = TRUE, call = sys.call(-1)) {
  x <- tryCatch(
    jsonlite::parse_json(body, simplifyVector = simplifyVector),
    error = function(e) {
      cli::cli_abort(
        "official.nba.com returned a non-JSON 200 body for {.url {url}}",
        class = c("hoopR_fetch_error", "hoopR_error"),
        parent = e,
        call = call
      )
    }
  )
  # Every official.nba.com payload is a JSON object (a named list here); null,
  # an array or a bare value is a failed fetch, not an empty report.
  if (!is.list(x) || is.data.frame(x) || is.null(names(x))) {
    cli::cli_abort(
      "official.nba.com returned JSON that is not an object for {.url {url}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      call = call
    )
  }
  x
}

# Zero-pads an all-digit id to 10 characters; anything else (non-numeric,
# already-long, NULL/NA) is returned verbatim as a string -- never raises.
# Deliberately string-only (no as.integer()/sprintf("%d")) so it never
# overflows R's 32-bit integer range the way `sprintf("%010d", 3e9)` would.
# `digits = 15` keeps a fractional part visible: at format()'s default 7
# significant digits, 42500405.5 would round to "42500406", another game.
.gid10 <- function(game_id) {
  if (is.null(game_id) || (length(game_id) == 1 && is.na(game_id))) {
    return(NA_character_)
  }
  s <- if (is.numeric(game_id)) format(game_id, scientific = FALSE, trim = TRUE, digits = 15) else as.character(game_id)
  if (!grepl("^[0-9]+$", s) || nchar(s) >= 10) {
    return(s)
  }
  paste0(strrep("0", 10 - nchar(s)), s)
}

# A field absent from EVERY row of a parsed JSON table comes back NULL, and a
# length-0 column breaks tibble() recycling; it becomes an all-NA column
# instead, as sdv-py's parser does.
.chr_col <- function(df, name) {
  v <- df[[name]]
  if (is.null(v)) rep(NA_character_, nrow(df)) else as.character(v)
}

# A character string only: a factor passes %in% by its label but indexes
# x[[league]] by its integer code, so it would read another league's block.
.validate_league <- function(league, call = sys.call(-1)) {
  if (!is.character(league) || !identical(length(league), 1L) || is.na(league) ||
      !league %in% c("nba", "gl", "wnba")) {
    cli::cli_abort(
      "{.arg league} must be one character string: 'nba', 'gl' or 'wnba', got {.val {league}} ({class(league)[1]})",
      call = call
    )
  }
  invisible(league)
}

# Id/count fields to integer; a non-number, or a value outside R's 32-bit
# integer range, becomes NA without a coercion warning.
.as_int <- function(x) suppressWarnings(as.integer(as.numeric(x)))

# Run a parser on a payload that passed the fetch-time shape checks. A value
# the parser still cannot read is a bad payload, re-raised in the package's
# error vocabulary instead of escaping as a raw R error.
.official_parse <- function(expr, url, call) {
  tryCatch(expr, error = function(e) {
    cli::cli_abort(
      "official.nba.com returned a malformed payload for {.url {url}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      parent = e,
      call = call
    )
  })
}

# ---------------------------------------------------------------------------
# L2M reports
# ---------------------------------------------------------------------------

.L2M_CALLS_PTYPE <- dplyr::tibble(
  game_id = character(), period = integer(), period_name = character(),
  pc_time = character(), seconds_remaining = double(), call_type = character(),
  call = character(), type = character(), committing = character(),
  disadvantaged = character(), decision = character(), decision_raw = character(),
  comment = character(), difficulty = character(), video_event_id = character(),
  pos_id = integer(), pos_start = character(), pos_end = character(),
  pos_team_id = integer()
)
.L2M_GAME_PTYPE <- dplyr::tibble(
  game_id = character(), game_date = as.Date(character()), season_type = character(),
  home_team_id = integer(), away_team_id = integer(), home_team_abbr = character(),
  away_team_abbr = character(), home_team_name = character(), away_team_name = character(),
  home_score = integer(), away_score = integer(), l2m_comments = character()
)
.L2M_STATS_PTYPE <- dplyr::tibble(
  game_id = character(), stat_name = character(), home = integer(), away = integer()
)

#' Parse a Last Two Minute report payload (internal)
#'
#' @param x list. Result of `jsonlite::fromJSON(path, simplifyVector = TRUE)`
#'   on an official.nba.com `l2m/json/<game_id>.json` payload.
#' @return Named list of `hoopR_data` tibbles: `calls`, `game`, `stats`.
#' @keywords internal
.parse_nba_l2m <- function(x) {
  g <- x[["game"]]
  if (is.data.frame(g)) g <- if (nrow(g) > 0) as.list(g[1, , drop = FALSE]) else NULL
  if (is.list(g) && length(g) == 0) g <- NULL
  gid <- if (!is.null(g)) .gid10(g[["GameId"]]) else NA_character_

  l2m <- x[["l2m"]]
  calls <- if (is.null(l2m) || (is.data.frame(l2m) && nrow(l2m) == 0) || length(l2m) == 0) {
    .L2M_CALLS_PTYPE
  } else {
    l2m <- as.data.frame(l2m, stringsAsFactors = FALSE)
    period_name <- .chr_col(l2m, "PeriodName")
    pc_time <- .chr_col(l2m, "PCTime")
    pc_norm <- sub("^(\\d+):(\\d+):(\\d+)$", "\\1:\\2.\\3", pc_time)
    # str_match()[, 2] (not sub()-as-extractor / regmatches(regexpr())): a
    # non-match must yield NA, aligned 1:1 with the input, never a dropped
    # element (which would silently shift every later row) or the unchanged
    # input string (T1/P2).
    minutes <- suppressWarnings(as.numeric(stringr::str_match(pc_norm, "^(\\d+):")[, 2]))
    seconds <- suppressWarnings(as.numeric(stringr::str_match(pc_norm, ":(\\d+(?:\\.\\d+)?)\\.?$")[, 2]))
    # call_type is stored verbatim (untouched) in the output; `ct` is a
    # transient whitespace-normalized copy used only to split call/type.
    call_type_raw <- .chr_col(l2m, "CallType")
    ct <- stringr::str_squish(call_type_raw)
    decision_raw <- .chr_col(l2m, "CallRatingName")
    decision_clean <- sub("\\*$", "", stringr::str_trim(decision_raw))
    decision <- unname(.OFFICIAL_DECISIONS[decision_clean])

    calls <- dplyr::tibble(
      game_id = rep(gid, nrow(l2m)),
      period = as.integer(stringr::str_extract(period_name, "\\d+")),
      period_name = period_name,
      pc_time = pc_time,
      seconds_remaining = minutes * 60 + seconds,
      call_type = call_type_raw,
      call = toupper(stringr::str_trim(stringr::str_match(ct, "^([^:]+):")[, 2])),
      type = toupper(stringr::str_match(ct, ":\\s*(.+)$")[, 2]),
      committing = dplyr::na_if(.chr_col(l2m, "CP"), ""),
      disadvantaged = dplyr::na_if(.chr_col(l2m, "DP"), ""),
      decision = decision,
      decision_raw = decision_raw,
      comment = .chr_col(l2m, "Comment"),
      difficulty = .chr_col(l2m, "Difficulty"),
      video_event_id = .chr_col(l2m, "VideolLink"),
      pos_id = .as_int(.chr_col(l2m, "posID")),
      pos_start = .chr_col(l2m, "posStart"),
      pos_end = .chr_col(l2m, "posEnd"),
      pos_team_id = .as_int(.chr_col(l2m, "posTeamId"))
    )
    calls[, names(.L2M_CALLS_PTYPE)]
  }

  # `[[ ]]` (not `$`) on every field read off parsed JSON (P6): a list built
  # from a one-row data.frame partial-matches on `$` (e.g. a missing
  # `Home_team` would silently return `Home_team_abbr`'s value, and a missing
  # `GameDate` would return `GameDateOut`'s), which `[[ ]]` never does.
  game <- if (!is.null(g)) {
    dplyr::tibble(
      game_id = gid,
      # An explicit format gives NA on a malformed date instead of an error.
      game_date = if (!is.null(g[["GameDate"]])) as.Date(substr(as.character(g[["GameDate"]]), 1, 10), format = "%Y-%m-%d") else as.Date(NA),
      season_type = if (!is.na(gid)) unname(.OFFICIAL_SEASON_TYPES[substr(gid, 3, 3)]) else NA_character_,
      home_team_id = .as_int(g[["HomeTeamId"]] %||% NA),
      away_team_id = .as_int(g[["AwayTeamId"]] %||% NA),
      home_team_abbr = as.character(g[["Home_team_abbr"]] %||% NA_character_),
      away_team_abbr = as.character(g[["Away_team_abbr"]] %||% NA_character_),
      home_team_name = as.character(g[["Home_team"]] %||% NA_character_),
      away_team_name = as.character(g[["Away_team"]] %||% NA_character_),
      home_score = .as_int(g[["HomeTeamScore"]] %||% NA),
      away_score = .as_int(g[["VisitorTeamScore"]] %||% NA),
      l2m_comments = as.character(g[["L2M_Comments"]] %||% NA_character_)
    )
  } else {
    .L2M_GAME_PTYPE
  }

  s <- x[["stats"]]
  stats_df <- if (is.null(s) || (is.data.frame(s) && nrow(s) == 0) || length(s) == 0) {
    .L2M_STATS_PTYPE
  } else {
    s <- as.data.frame(s, stringsAsFactors = FALSE)
    dplyr::tibble(
      game_id = rep(gid, nrow(s)),
      stat_name = .chr_col(s, "stats_name"),
      home = .as_int(.chr_col(s, "home")),
      away = .as_int(.chr_col(s, "away"))
    )
  }

  now <- Sys.time()
  list(
    calls = make_hoopR_data(calls, "NBA L2M calls (official.nba.com)", now),
    game = make_hoopR_data(game, "NBA L2M game (official.nba.com)", now),
    stats = make_hoopR_data(stats_df, "NBA L2M stats (official.nba.com)", now)
  )
}

#' Fetch an NBA Last Two Minute (L2M) report
#' @name nba_l2m
NULL
#' @title
#' Fetch an NBA Last Two Minute (L2M) report
#' @rdname nba_l2m
#' @description
#' Retrieves and parses the Last Two Minute officiating report for a single
#' NBA game from official.nba.com. A report is published for any game that is
#' within 3 points (5 points before 2017-18) at any point in the last two
#' minutes of the 4th quarter or overtime -- not only playoff games. JSON
#' reports exist only from 2019-01-01 onward. Port of the scraping logic in
#' \href{https://github.com/atlhawksfanatic/L2M}{atlhawksfanatic/L2M} (MIT,
#' (c) 2019 atlhawksfanatic).
#'
#' @param game_id character or numeric. A single all-digit NBA game id;
#'   zero-padded to 10 digits automatically (e.g. `42500405` becomes
#'   `"0042500405"`). Anything else errors before any request is made.
#' @param proxy Optional proxy: a URL string (e.g. `"http://host:port"`) or a
#'   named list of [httr2::req_proxy()] arguments (`url`, `port`, `username`,
#'   `password`, `auth`). `NULL` (the default) falls back to `getOption("hoopR.proxy")`, then the
#'   `http_proxy`/`https_proxy` environment variables.
#' @return Named list of `hoopR_data` tibbles:
#'
#'    **calls** -- one row per graded play. `decision` is normalized to
#'    `CC`/`CNC`/`IC`/`INC` (`NCC`->`CNC`, `NCI`->`INC`, trailing `*`
#'    stripped, blank/`"Undetectable"` -> `NA`, never `INC`). `game_id` is a
#'    10-char zero-padded string. Player and team names are kept verbatim
#'    (no ASCII folding).
#'
#'    |col_name          |types     |description                                                                       |
#'    |:-----------------|:---------|:---------------------------------------------------------------------------------|
#'    |game_id           |character |10-digit zero-padded game id; joins to game and stats.                            |
#'    |period            |integer   |Period number from period_name (4 = fourth quarter, 5+ = overtime).               |
#'    |period_name       |character |Raw period label, e.g. Q4, or Q5 for the first overtime.                          |
#'    |pc_time           |character |Raw game clock string, MM:SS or MM:SS.t.                                          |
#'    |seconds_remaining |double    |Seconds left in the period, parsed from pc_time.                                  |
#'    |call_type         |character |Raw "Call: Type" label, whitespace untouched.                                     |
#'    |call              |character |Upper-cased part of call_type before the colon, e.g. FOUL.                        |
#'    |type              |character |Upper-cased part of call_type after the colon, e.g. SHOOTING.                     |
#'    |committing        |character |Player, team or coach committing the graded action.                               |
#'    |disadvantaged     |character |Player or team disadvantaged by the graded action.                                |
#'    |decision          |character |Normalized grade: CC, CNC, IC or INC.                                             |
#'    |decision_raw      |character |Raw grading code before normalization.                                            |
#'    |comment           |character |Grader's free-text explanation of the ruling.                                     |
#'    |difficulty        |character |Grader's difficulty rating, e.g. Observable or Difficult.                         |
#'    |video_event_id    |character |Report video event id (source field VideolLink); not a play-by-play event number. |
#'    |pos_id            |integer   |Report possession id; rows sharing it belong to one possession.                   |
#'    |pos_start         |character |Game clock at the start of the possession.                                        |
#'    |pos_end           |character |Game clock at the end of the possession.                                          |
#'    |pos_team_id       |integer   |NBA team id of the team in possession.                                            |
#'
#'    **game** -- one row of game metadata.
#'
#'    |col_name       |types     |description                                                  |
#'    |:--------------|:---------|:------------------------------------------------------------|
#'    |game_id        |character |10-digit zero-padded game id; joins to calls and stats.      |
#'    |game_date      |Date      |Game date from the report's local tip-off timestamp.         |
#'    |season_type    |character |Season type from the third digit of game_id, e.g. playoffs.  |
#'    |home_team_id   |integer   |NBA team id of the home team.                                |
#'    |away_team_id   |integer   |NBA team id of the away team.                                |
#'    |home_team_abbr |character |Home team three-letter abbreviation.                         |
#'    |away_team_abbr |character |Away team three-letter abbreviation.                         |
#'    |home_team_name |character |Home team nickname as published in the report.               |
#'    |away_team_name |character |Away team nickname as published in the report.               |
#'    |home_score     |integer   |Home team final score.                                       |
#'    |away_score     |integer   |Away team final score.                                       |
#'    |l2m_comments   |character |Report-level note from the league; NA for almost every game. |
#'
#'    **stats** -- 3 rows of error-count stats (`Calls`, `Errors in Favor`,
#'    `Possessions in Favor`).
#'
#'    |col_name  |types     |description                                                |
#'    |:---------|:---------|:----------------------------------------------------------|
#'    |game_id   |character |10-digit zero-padded game id; joins to calls and game.     |
#'    |stat_name |character |Statistic: Calls, Errors in Favor or Possessions in Favor. |
#'    |home      |integer   |Value of stat_name for the home team.                      |
#'    |away      |integer   |Value of stat_name for the away team.                      |
#' @section Errors:
#' Raises a classed condition instead of returning on failure. Both classes
#' inherit from `hoopR_error`, so one handler can catch either:
#' * `hoopR_no_data` -- the game has no L2M report (common for regular-season
#'   games, games that did not reach the final two minutes, or very recent
#'   games): official.nba.com answers 403 with an S3 `AccessDenied` body, or
#'   404s the request.
#' * `hoopR_fetch_error` -- the fetch failed (network error, rate limit,
#'   Akamai WAF block, any other HTTP status), or a 200 response is not a
#'   report: not valid JSON, JSON that is not an object, a payload without a
#'   one-row `game` table (an empty object or an error envelope, say), a
#'   `game`, `l2m` or `stats` table of the wrong shape, or a field the parser
#'   cannot read.
#'
#' An invalid argument is an ordinary error, raised before any request.
#' @author Saiem Gilani
#' @family NBA Officiating Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     l2m <- nba_l2m(game_id = "0042500405")
#'     head(l2m$calls)
#'   })
#' }
nba_l2m <- function(game_id, proxy = NULL) {
  call <- sys.call()
  # Strict, like sdv-py's _gid(): the caller's id builds the request URL, so
  # anything but one all-digit id stops here. The lenient .gid10() alone is
  # for ids read back out of a payload.
  gid <- if (length(game_id) == 1 && !is.na(game_id)) .gid10(game_id) else NA_character_
  if (!grepl("^[0-9]+$", gid)) {
    cli::cli_abort(
      "{.arg game_id} must be a single all-digit NBA game id (e.g. {.val 0042500405}), got {.val {game_id}}",
      call = call
    )
  }
  url <- sprintf("https://official.nba.com/l2m/json/%s.json", gid)
  body <- .official_nba_get(url, proxy = proxy)
  x <- .official_nba_json(body, url, simplifyVector = TRUE, call = call)
  # A report holds a one-row `game` table plus `l2m` and `stats` tables
  # (possibly empty) of scalar fields. `{}`, an error envelope, or a table sent
  # as a string, a bare array, an object or with nested fields is a failed
  # fetch, never an empty report or made-up rows.
  is_table <- function(v) is.data.frame(v) && all(vapply(v, is.atomic, logical(1)))
  is_table_or_empty <- function(v) is.null(v) || is_table(v) || (is.list(v) && length(v) == 0)
  # The one game row must name its game: `[{}]` is a one-row, zero-column table.
  has_game_id <- function(g) {
    id <- g[["GameId"]]
    length(id) == 1L && !is.na(id) && nzchar(trimws(as.character(id)))
  }
  if (!is_table(x[["game"]]) || nrow(x[["game"]]) != 1 || !has_game_id(x[["game"]]) ||
      !is_table_or_empty(x[["l2m"]]) || !is_table_or_empty(x[["stats"]])) {
    cli::cli_abort(
      "official.nba.com returned no well-formed L2M report (game/l2m/stats tables) for {.url {url}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      call = call
    )
  }
  # The report must be for the game asked for: a cached or misrouted payload for
  # another game is a failed fetch, never that game's report.
  got <- .gid10(x[["game"]][["GameId"]])
  if (!identical(got, gid)) {
    cli::cli_abort(
      "official.nba.com returned the report for game {.val {got}} when {.val {gid}} was requested: {.url {url}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      call = call
    )
  }
  .official_parse(.parse_nba_l2m(x), url, call)
}

# ---------------------------------------------------------------------------
# L2M season game listing
# ---------------------------------------------------------------------------

.LISTING_RE <- "L2MReport\\.html\\?gameId=(?:%0[dD])?(\\d{10})[^>]*>([^<]*)</a>"
.LISTING_PTYPE <- dplyr::tibble(
  game_id = character(), season = integer(), season_type = character(), label = character()
)

#' Parse an L2M season listing page (internal)
#' @param html character(1). HTML of the L2M season listing page.
#' @param season integer(1). NBA season (end year) to stamp onto every row.
#' @return A `hoopR_data`-ready tibble: `game_id`, `season`, `season_type`, `label`.
#' @keywords internal
.parse_nba_l2m_games <- function(html, season) {
  # Read the regex's own capture groups (as sdv-py's findall() does); the
  # label group `[^<]*` stops at `</a>`, so a ">" inside a label is kept.
  m <- stringr::str_match_all(html, .LISTING_RE)[[1]]
  if (nrow(m) == 0) {
    return(.LISTING_PTYPE)
  }
  gid <- m[, 2]
  # str_trim() strips all Unicode whitespace (NBSP, thin space, ...) from the
  # edges only, matching Python's str.strip() exactly -- interior NBSPs (e.g.
  # inside a matchup label) are left untouched (T2/P3).
  label <- stringr::str_trim(m[, 3])
  keep <- !duplicated(gid)
  gid <- gid[keep]
  label <- label[keep]
  dplyr::tibble(
    game_id = gid,
    season = as.integer(season),
    season_type = unname(.OFFICIAL_SEASON_TYPES[substr(gid, 3, 3)]),
    label = label
  )
}

#' Fetch the list of NBA games with a Last Two Minute report for a season
#' @name nba_l2m_games
NULL
#' @title
#' Fetch the list of NBA games with a Last Two Minute report for a season
#' @rdname nba_l2m_games
#' @description
#' Scrapes official.nba.com's season index page. JSON L2M reports exist only
#' from 2019-01-01 onward; earlier seasons' index pages list PDFs, which this
#' function ignores (use a release loader for that history once published).
#' Port of the scraping logic in
#' \href{https://github.com/atlhawksfanatic/L2M}{atlhawksfanatic/L2M} (MIT,
#' (c) 2019 atlhawksfanatic).
#'
#' @param season integer, or a numeric-like string. NBA season, END year
#'   (e.g. `2026` or `"2026"` for 2025-26).
#' @param proxy Optional proxy: a URL string (e.g. `"http://host:port"`) or a
#'   named list of [httr2::req_proxy()] arguments. `NULL` (the default) falls back to `getOption("hoopR.proxy")`, then the
#'   `http_proxy`/`https_proxy` environment variables.
#' @return A `hoopR_data` tibble, one row per unique game id in page order:
#'
#'    |col_name    |types     |description                                                 |
#'    |:-----------|:---------|:-----------------------------------------------------------|
#'    |game_id     |character |10-digit zero-padded game id from the report link.          |
#'    |season      |integer   |Season end year passed in, stamped on every row.            |
#'    |season_type |character |Season type from the third digit of game_id, e.g. playoffs. |
#'    |label       |character |Matchup label text of the report link, edges trimmed.       |
#' @section Errors:
#' Raises a classed condition instead of returning on failure. Both classes
#' inherit from `hoopR_error`, so one handler can catch either:
#' * `hoopR_no_data` -- official.nba.com 404s the season's page (a season
#'   without one), or answers 403 with an S3 `AccessDenied` body.
#' * `hoopR_fetch_error` -- the fetch failed (network error, rate limit,
#'   Akamai WAF block, any other HTTP status), or a 200 response is missing
#'   the expected "Last Two Minute" page marker (an Akamai interstitial, a
#'   blank body, or a redesigned page) -- checked here, not in
#'   [.parse_nba_l2m_games()], so the parser itself never raises.
#'
#' An invalid argument is an ordinary error, raised before any request.
#' @author Saiem Gilani
#' @family NBA Officiating Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     games <- nba_l2m_games(season = 2026)
#'     head(games)
#'   })
#' }
nba_l2m_games <- function(season, proxy = NULL) {
  call <- sys.call()
  # as.character() first: as.integer() on a factor is its level code, not its label.
  s <- suppressWarnings(as.integer(as.character(season)))
  if (length(season) != 1 || is.na(s) || !grepl("^[0-9]{4}$", trimws(as.character(season)))) {
    cli::cli_abort(
      "{.arg season} must be a 4-digit year (numeric or numeric-like string), got {.val {season}}",
      call = call
    )
  }
  span <- sprintf("%d-%s", s - 1L, substr(as.character(s), 3, 4))
  url <- sprintf("https://official.nba.com/%s-nba-officiating-last-two-minute-reports/", span)
  html <- .official_nba_get(url, proxy = proxy)
  # An Akamai 200 interstitial must not look like "no reports for this page".
  if (!grepl("last two minute", html, ignore.case = TRUE)) {
    cli::cli_abort(
      "official.nba.com listing page is missing the 'Last Two Minute' marker (Akamai interstitial?): {.url {url}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      call = call
    )
  }
  df <- .official_parse(.parse_nba_l2m_games(html, s), url, call)
  make_hoopR_data(df, "NBA L2M games listing (official.nba.com)", Sys.time())
}

# ---------------------------------------------------------------------------
# Referee assignments
# ---------------------------------------------------------------------------

# One parsed JSON field as one value, else NA (wehoop's guard). A null (NULL),
# an array or an object (a list) would otherwise drop the row (a length-0
# column recycles a one-row tibble() to zero rows), duplicate it (a length-2
# column makes two) or raise.
.scalar <- function(x) if (length(x) == 1L && !is.list(x)) x else NA

# Exactly five digits, <type digit><START year>: "2 025" or "21e03" is a
# malformed code, not a year (as in sdv-py).
.official_season_end_year <- function(s, league) {
  if (!grepl("^[0-9]{5}$", s)) return(NA_integer_)
  start_year <- as.integer(substr(s, 2, 5))
  if (league %in% c("nba", "gl")) start_year + 1L else start_year
}

# Parse "MM/DD/YYYY" (the feed's date format) to a Date; a null, non-scalar,
# empty or any other value -> NA. The whole string must match, as with
# Python's strptime: R's format= parse alone ignores trailing text and reads
# "26" as year 26.
.mdy <- function(s) {
  s <- as.character(.scalar(s))
  if (is.na(s) || !grepl("^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$", s)) {
    return(as.Date(NA))
  }
  as.Date(s, format = "%m/%d/%Y")
}

.ASSIGN_OFFICIALS_PTYPE <- dplyr::tibble(
  league = character(), game_id = character(), game_date = as.Date(character()),
  season = integer(), season_type = character(), game_code = character(),
  home_team_id = integer(), home_team_abbr = character(), away_team_id = integer(),
  away_team_abbr = character(), crew_position = integer(), official_id = integer(),
  official_name = character(), jersey_num = character()
)
.ASSIGN_REPLAY_PTYPE <- dplyr::tibble(
  league = character(), game_date = as.Date(character()),
  official_id = integer(), official_name = character()
)

#' Parse a referee-assignments payload (internal)
#'
#' @param x list. Result of `jsonlite::fromJSON(path, simplifyVector = FALSE)`
#'   on an official.nba.com `get-game-officials` payload (top-level keys
#'   `nba`, `gl`, `wnba`).
#' @param league character(1). One of `"nba"`, `"gl"`, `"wnba"`.
#' @return Named list of `hoopR_data` tibbles: `officials`, `replay_center`.
#' @keywords internal
.parse_nba_referee_assignments <- function(x, league = "nba") {
  .validate_league(league)
  block <- x[[league]]
  table_rows <- block[["Table"]][["rows"]] %||% list()
  table1_rows <- block[["Table1"]][["rows"]] %||% list()

  # Every field goes through .scalar(), so a null, array or object field is NA:
  # it never drops the row, duplicates it, or raises (as in wehoop).
  officials_for_game <- function(g) {
    s <- as.character(.scalar(g[["season"]]))
    rows <- purrr::map(1:4, function(k) {
      nm <- g[[paste0("official", k)]]
      # An absent, null, "" or empty name is an empty slot. Any other name fills
      # the slot and keeps its row (and the official's id), with NA as the name
      # when it is not a scalar.
      if (length(nm) == 0L || identical(nm, "")) {
        return(NULL)
      }
      dplyr::tibble(
        league = league,
        game_id = .gid10(.scalar(g[["game_id"]])),
        game_date = .mdy(g[["game_date"]]),
        season = .official_season_end_year(s, league),
        season_type = unname(.OFFICIAL_SEASON_TYPES[substr(s, 1, 1)]),
        game_code = as.character(.scalar(g[["game_code"]])),
        home_team_id = .as_int(.scalar(g[["home_team_id"]])),
        home_team_abbr = as.character(.scalar(g[["home_team_abbr"]])),
        away_team_id = .as_int(.scalar(g[["away_team_id"]])),
        away_team_abbr = as.character(.scalar(g[["away_team_abbr"]])),
        crew_position = as.integer(k),
        official_id = .as_int(.scalar(g[[paste0("official", k, "_code")]])),
        official_name = as.character(.scalar(nm)),
        jersey_num = as.character(.scalar(g[[paste0("official", k, "_JNum")]]))
      )
    })
    purrr::list_rbind(purrr::compact(rows), ptype = .ASSIGN_OFFICIALS_PTYPE)
  }
  officials <- purrr::list_rbind(purrr::map(table_rows, officials_for_game), ptype = .ASSIGN_OFFICIALS_PTYPE)

  replay_center <- purrr::list_rbind(
    purrr::map(table1_rows, function(r) {
      dplyr::tibble(
        league = league,
        game_date = .mdy(r[["game_date"]]),
        official_id = .as_int(.scalar(r[["official_code"]])),
        official_name = as.character(.scalar(r[["replaycenter_official"]]))
      )
    }),
    ptype = .ASSIGN_REPLAY_PTYPE
  )

  now <- Sys.time()
  list(
    officials = make_hoopR_data(officials, "NBA referee assignments -- officials (official.nba.com)", now),
    replay_center = make_hoopR_data(replay_center, "NBA referee assignments -- replay center (official.nba.com)", now)
  )
}

#' Fetch NBA/G-League/WNBA referee crew assignments for a date
#' @name nba_referee_assignments
NULL
#' @title
#' Fetch NBA/G-League/WNBA referee crew assignments for a date
#' @rdname nba_referee_assignments
#' @description
#' Retrieves referee crew assignments and replay-center officials for every
#' game on a date, from official.nba.com's `get-game-officials` endpoint
#' (covers NBA, G-League, and WNBA in one payload). Port of the scraping
#' logic in \href{https://github.com/atlhawksfanatic/L2M}{atlhawksfanatic/L2M}
#' (MIT, (c) 2019 atlhawksfanatic).
#'
#' @details
#' `crew_position` is the feed's slot order (1-4); slot 1 is *inferred* to be
#' the crew chief from that ordering -- the API does not label roles
#' directly. `season` converts the feed's `<type digit><START year>` code to
#' an END year: START+1 for `"nba"`/`"gl"` (two-calendar-year seasons), START
#' unchanged for `"wnba"` (single-year seasons).
#'
#' @param date character or Date/POSIXct, length 1. Date to fetch. A
#'   Date/POSIXct is formatted directly (never routed through `as.Date()`,
#'   which can shift a POSIXct's calendar day across a timezone boundary); a
#'   character must match `"YYYY-MM-DD"`.
#' @param league character(1). One of `"nba"` (default), `"gl"`, `"wnba"`.
#' @param proxy Optional proxy: a URL string (e.g. `"http://host:port"`) or a
#'   named list of [httr2::req_proxy()] arguments. `NULL` (the default) falls back to `getOption("hoopR.proxy")`, then the
#'   `http_proxy`/`https_proxy` environment variables.
#' @return Named list of `hoopR_data` tibbles:
#'
#'    **officials** -- one row per game x filled crew slot. A slot whose
#'    official's name is absent, null or empty is skipped. A field sent as
#'    null, an array or an object reads as NA, never as a dropped or
#'    duplicated row: an array or object name keeps its row, and the
#'    official's id, with an NA `official_name`.
#'
#'    |col_name       |types     |description                                                      |
#'    |:--------------|:---------|:----------------------------------------------------------------|
#'    |league         |character |League: nba, gl (G League) or wnba.                              |
#'    |game_id        |character |10-digit zero-padded game id.                                    |
#'    |game_date      |Date      |Game date, parsed from the feed's MM/DD/YYYY.                    |
#'    |season         |integer   |Season end year (start year + 1 for nba/gl, unchanged for wnba). |
#'    |season_type    |character |Season type from the first digit of the feed's season code.      |
#'    |game_code      |character |League game code, YYYYMMDD/AWYHOM.                               |
#'    |home_team_id   |integer   |Team id of the home team.                                        |
#'    |home_team_abbr |character |Home team three-letter abbreviation.                             |
#'    |away_team_id   |integer   |Team id of the away team.                                        |
#'    |away_team_abbr |character |Away team three-letter abbreviation.                             |
#'    |crew_position  |integer   |Feed slot order (1-4); slot 1 is the inferred crew chief.        |
#'    |official_id    |integer   |Official's person id from the feed.                              |
#'    |official_name  |character |Official's display name.                                         |
#'    |jersey_num     |character |Official's jersey number, as a string.                           |
#'
#'    **replay_center** -- the replay-center officials on duty that date, one
#'    row per official. The rows are per date, not tied to a game or a league:
#'    the feed can repeat the same rows in every league block (`league` only
#'    records which block was read), and they can be present when the league
#'    has no games.
#'
#'    |col_name      |types     |description                                                                |
#'    |:-------------|:---------|:--------------------------------------------------------------------------|
#'    |league        |character |League block the row was read from (nba, gl or wnba); not league-specific. |
#'    |game_date     |Date      |Date the replay-center official worked (not tied to one game).             |
#'    |official_id   |integer   |Replay-center official's person id from the feed.                          |
#'    |official_name |character |Replay-center official's display name.                                     |
#'
#'    A date with no games for the league is not an error: `officials` comes
#'    back zero-row rather than raising, while `replay_center` can still hold
#'    that date's replay-center officials.
#' @section Errors:
#' Raises a classed condition instead of returning on failure. Both classes
#' inherit from `hoopR_error`, so one handler can catch either:
#' * `hoopR_no_data` -- official.nba.com 404s the endpoint, or answers 403
#'   with an S3 `AccessDenied` body.
#' * `hoopR_fetch_error` -- the fetch failed (network error, rate limit,
#'   Akamai WAF block, any other HTTP status), or a 200 response is not valid
#'   JSON, is JSON that is not an object, or has the league's
#'   `Table`/`Table1` `rows` missing or malformed (a `Table` row without a
#'   10-digit `game_id` included). The feed carries every league's block on every
#'   date, with zero rows on a day without games, so a missing block is never
#'   an empty day.
#'
#' An invalid argument, including an impossible date such as `"2026-02-31"`,
#' is an ordinary error, raised before any request.
#' @author Saiem Gilani
#' @family NBA Officiating Functions
#' @export
#' @examples
#' \donttest{
#'   try({
#'     refs <- nba_referee_assignments(date = "2026-06-13")
#'     head(refs$officials)
#'   })
#' }
nba_referee_assignments <- function(date, league = "nba", proxy = NULL) {
  call <- sys.call()
  .validate_league(league, call = call)
  day <- if (inherits(date, c("Date", "POSIXt"))) format(date, "%Y-%m-%d") else as.character(date)
  # One check for every branch: a length-2 or NA Date must fail here too, not
  # reach the request as a multi-valued or "NA" query parameter.
  # Parse and round-trip, so a shape-valid but impossible date ("2026-02-31") is
  # rejected even where strptime would normalize it.
  parsed <- if (length(day) == 1 && !is.na(day)) as.Date(day, format = "%Y-%m-%d") else as.Date(NA)
  if (length(day) != 1 || is.na(day) || !grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", day) ||
      is.na(parsed) || format(parsed, "%Y-%m-%d") != day) {
    cli::cli_abort(
      "{.arg date} must be a single Date/POSIXct or a valid 'YYYY-MM-DD' date string, got {.val {date}}",
      call = call
    )
  }
  url <- "https://official.nba.com/wp-json/api/v1/get-game-officials"
  body <- .official_nba_get(url, params = list(date = day), proxy = proxy)
  x <- .official_nba_json(body, url, simplifyVector = FALSE, call = call)
  # The feed always carries nba, gl and wnba blocks, each with Table and Table1
  # (zero rows on a day without games), so a missing block is a changed schema
  # or an error envelope, not an empty day.
  block <- if (is.list(x)) x[[league]] else NULL
  # Each table must hold a rows array of row objects: with simplifyVector = FALSE a
  # JSON array is an unnamed list and an object a named one. A null table, missing
  # rows, or rows that are an object or scalars is not an empty day.
  has_rows <- function(t) {
    r <- if (is.list(block[[t]])) block[[t]][["rows"]] else NULL
    is.list(r) && is.null(names(r)) &&
      all(vapply(r, function(x) is.list(x) && !is.null(names(x)), logical(1)))
  }
  # Every game row names its game with one game_id that .gid10() turns into the
  # documented 10-digit id; "not-an-id", "12345678901" or "4.2e7" would come
  # through .gid10() unchanged.
  has_gid <- function(r) {
    v <- r[["game_id"]]
    is.atomic(v) && length(v) == 1L && !is.na(v) && grepl("^[0-9]{10}$", .gid10(v))
  }
  if (!is.list(block) || !has_rows("Table") || !has_rows("Table1") ||
      !all(vapply(block[["Table"]][["rows"]], has_gid, logical(1)))) {
    cli::cli_abort(
      "official.nba.com returned a missing or malformed {.val {league}} Table/Table1 block for {.val {day}}",
      class = c("hoopR_fetch_error", "hoopR_error"),
      call = call
    )
  }
  .official_parse(.parse_nba_referee_assignments(x, league), url, call)
}
