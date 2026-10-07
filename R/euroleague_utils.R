# ---------------------------------------------------------------------------
# Internal: shared HTTP + parsing layer for the EuroLeague `euroleague_*()` family
# ---------------------------------------------------------------------------
#
# R mirror of sdv-py's `sportsdataverse/euroleague/` (same function names,
# arguments, defaults and snake_case columns, one row per sdv-py row). Three
# keyless, unofficial hosts behind euroleaguebasketball.net:
#   v2   https://api-live.euroleague.net/v2  -- Competition Engine lists + game box score
#   v3   https://api-live.euroleague.net/v3  -- standings (under a round), season stats, game report
#   live https://live.euroleague.net/api     -- legacy per-game feeds (shots, pbp, box, header)
# api-live answers XML unless `Accept: application/json` is sent; the live API is
# JSON by default and answers "no such game" with an EMPTY 200 body. Reference:
# sdv-internal-refs/euroleague/README.md.

.euroleague_hosts <- c(
  v2 = "https://api-live.euroleague.net/v2",
  v3 = "https://api-live.euroleague.net/v3",
  live = "https://live.euroleague.net/api"
)

# Raise one of the family's classed conditions (mirrors sdv-py's error
# vocabulary: 404 -> NoDataError, 400/422 -> ValueError, else AssetFetchError).
.euroleague_abort <- function(kind, msg, call, parent = NULL, env = parent.frame()) {
  cli::cli_abort(msg, class = c(paste0("hoopR_", kind), "hoopR_error"), call = call, parent = parent, .envir = env)
}

#' Internal: GET a EuroLeague API route as parsed JSON
#'
#' The single HTTP chokepoint of the `euroleague_*()` family. Picks the host,
#' sends `Accept: application/json` to api-live only (the live API gets no
#' Accept header), drops `NULL` query params, and classifies the answer:
#' 404 -> `hoopR_no_data`; 400 / 422 -> `hoopR_invalid_request`; any other
#' non-2xx, a transport error, a non-JSON body or an empty api-live body ->
#' `hoopR_fetch_error` (all inherit `hoopR_error`). The live host's empty 200
#' body is its "no such game" sentinel and is returned as `list()`, which the
#' live parsers turn into a zero-row frame with the documented columns.
#'
#' @param path Route path beginning with `/` (e.g. `"/competitions"`).
#' @param params Named list of query parameters (`NULL` entries are dropped).
#' @param host One of `"v2"`, `"v3"`, `"live"`.
#' @return The parsed JSON body as a nested list (`jsonlite::parse_json`,
#'   `simplifyVector = FALSE`), or `list()` for the live API's empty body.
#' @keywords internal
#' @noRd
euroleague_api <- function(path, params = list(), host = c("v2", "v3", "live")) {
  host <- match.arg(host)
  call <- sys.call(-1)
  url <- paste0(.euroleague_hosts[[host]], path)
  params <- params[!vapply(params, is.null, logical(1))]
  headers <- if (host == "live") NULL else c(Accept = "application/json")
  resp <- tryCatch(
    .retry_request(url, params = params, headers = headers),
    error = function(cnd) {
      .euroleague_abort(
        "fetch_error",
        "EuroLeague fetch failed (transport error) for {.url {url}}: {conditionMessage(cnd)}",
        call, parent = cnd
      )
    }
  )
  status <- httr2::resp_status(resp)
  body <- if (httr2::resp_has_body(resp)) .resp_text(resp) else ""
  if (identical(status, 404L)) {
    .euroleague_abort("no_data", "EuroLeague API returned 404 (no such competition, season, round or game) for {.url {url}}", call)
  }
  if (status %in% c(400L, 422L)) {
    .euroleague_abort("invalid_request", "EuroLeague API rejected the request (HTTP {status}) for {.url {url}}", call)
  }
  if (status < 200L || status >= 300L) {
    .euroleague_abort("fetch_error", "EuroLeague fetch failed (HTTP {status}) for {.url {url}}", call)
  }
  if (!nzchar(trimws(body))) {
    if (host == "live") return(list())
    .euroleague_abort("fetch_error", "EuroLeague API returned an empty {status} body for {.url {url}}", call)
  }
  tryCatch(
    jsonlite::parse_json(body, simplifyVector = FALSE),
    error = function(e) {
      .euroleague_abort("fetch_error", "EuroLeague API returned a non-JSON {status} body for {.url {url}}", call, parent = e)
    }
  )
}

# --- flattening (mirror of sdv-py's rows_to_frame: pandas.json_normalize(sep="_")
#     + dl_utils.underscore + JSON-encoded list cells + Utf8 id columns) -------

# sdv-py `dl_utils.underscore()`: CamelCase / UPPER_CASE / kebab -> snake_case.
.euroleague_underscore <- function(x) {
  x <- gsub("([A-Z]+)([A-Z][a-z])", "\\1_\\2", x, perl = TRUE)
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x, perl = TRUE)
  tolower(gsub("-", "_", x, fixed = TRUE))
}

# One JSON record -> a flat named list: nested objects join their keys with "_",
# list cells are JSON-encoded (an id list is comma-joined), null -> NA, `{}` -> no column.
# Column order is pandas.json_normalize's (`nested_to_record`): at the top level
# the scalar keys keep their order and each nested object's columns are appended
# after them; inside a nested object every key stays in place.
.euroleague_flatten <- function(rec, prefix = NULL) {
  out <- list()
  nested <- list()
  for (k in names(rec)) {
    v <- rec[[k]]
    key <- if (is.null(prefix)) k else paste0(prefix, "_", k)
    if (is.list(v) && !is.null(names(v))) {
      if (is.null(prefix)) nested <- c(nested, .euroleague_flatten(v, key)) else out <- c(out, .euroleague_flatten(v, key))
    } else if (is.list(v)) {
      out[[key]] <- if (grepl("(^|_)ids?$", .euroleague_underscore(key))) {
        paste(vapply(v, function(e) as.character(e), character(1)), collapse = ",")
      } else {
        as.character(jsonlite::toJSON(v, auto_unbox = TRUE, null = "null", digits = NA))
      }
    } else if (is.null(v)) {
      out[key] <- list(NA)
    } else {
      out[[key]] <- v
    }
  }
  c(out, nested)
}

# sdv-py `rows_to_frame` name rule: a repeated snake_case name gets `_2`, `_3`, ...
.euroleague_dedupe <- function(nm) {
  seen <- list()
  for (i in seq_along(nm)) {
    n <- nm[i]
    if (is.null(seen[[n]])) {
      seen[[n]] <- 1L
    } else {
      seen[[n]] <- seen[[n]] + 1L
      nm[i] <- paste0(n, "_", seen[[n]])
    }
  }
  nm
}

# A list of records -> data.frame with snake_case, de-duplicated (`_2`, `_3`) names
# in order of first appearance. Non-record entries become a `value` column.
.euroleague_rows <- function(rows) {
  rows <- rows[!vapply(rows, is.null, logical(1))]
  if (length(rows) == 0) return(data.frame())
  is_rec <- vapply(rows, function(r) is.list(r) && !is.null(names(r)), logical(1))
  if (!any(is_rec)) return(data.frame(value = vapply(rows, as.character, character(1))))
  flat <- lapply(rows, function(r) {
    if (!(is.list(r) && !is.null(names(r)))) r <- list(value = r)
    f <- .euroleague_flatten(r)
    names(f) <- .euroleague_dedupe(.euroleague_underscore(names(f)))
    f
  })
  as.data.frame(data.table::rbindlist(flat, use.names = TRUE, fill = TRUE), stringsAsFactors = FALSE)
}

# Pin join-key (and, when asked, all-NA) columns to character; an integer id
# never stringifies as "406.0".
.euroleague_pin_character <- function(df, pattern, all_na = FALSE) {
  for (col in names(df)) {
    v <- df[[col]]
    if (grepl(pattern, col, perl = TRUE) || (all_na && all(is.na(v)))) {
      # a whole-number double id prints without a float suffix ("406", never "406.0"), overflow-safe
      if (is.double(v) && all(is.na(v) | v == trunc(v))) v <- ifelse(is.na(v), NA_character_, sprintf("%.0f", v))
      df[[col]] <- as.character(v)
    }
  }
  df
}

# sdv-py `_as_rows`: a list is the rows; an object with exactly one list-valued
# key is that list; any other non-empty object is a single row; else nothing.
.euroleague_as_rows <- function(raw) {
  if (is.list(raw) && is.null(names(raw))) return(raw)
  if (is.list(raw) && length(raw) > 0) {
    lists <- Filter(function(v) is.list(v) && is.null(names(v)), raw)
    if (length(lists) == 1) return(lists[[1]])
    return(list(raw))
  }
  list()
}

# The frame every api-live (v2 / v3) route returns: sdv-py `parse_euroleague`.
.euroleague_frame <- function(raw) {
  df <- .euroleague_rows(.euroleague_as_rows(raw))
  # an all-null column (a season without a winner, a referee4 never set) is an
  # unknown string, not a logical: keep it character so the dtype is stable.
  .euroleague_pin_character(df, "(^|_)(id|code)$", all_na = TRUE)
}

# --- live.euroleague.net/api parsers (one per route; keys are UPPER-CASE,
#     space-padded fixed-width strings) ---------------------------------------

# The live API's join keys.
.euroleague_live_id <- "^(id_\\w+|\\w+_id|codeteam|code_team_[ab]|tv_code_[ab]|team)$"

# A zero-row frame carrying the route's documented columns (the parser contract
# for the live API's empty-body "no such game" answer).
.euroleague_empty <- function(route) {
  schema <- .euroleague_live_schemas[[route]]
  as.data.frame(lapply(schema, function(type) vector(type, 0L)), stringsAsFactors = FALSE)
}

# Finish a live-API row list: snake_case, strip the space padding, pin ids + all-NA columns.
.euroleague_live_frame <- function(route, rows) {
  rows <- Filter(function(r) is.list(r) && !is.null(names(r)), rows)
  if (length(rows) == 0) return(.euroleague_empty(route))
  df <- .euroleague_rows(rows)
  for (col in names(df)) if (is.character(df[[col]])) df[[col]] <- trimws(df[[col]])
  .euroleague_pin_character(df, .euroleague_live_id, all_na = TRUE)
}

.euroleague_points <- function(raw) {
  .euroleague_live_frame("game_points", .euroleague_as_rows(raw))
}

.euroleague_header <- function(raw) {
  .euroleague_live_frame("game_header", .euroleague_as_rows(raw))
}

# `PlayByPlay` arrays in game order; every overtime period is in `ExtraTime`.
.euroleague_quarters <- c(FirstQuarter = 1L, SecondQuarter = 2L, ThirdQuarter = 3L, ForthQuarter = 4L, ExtraTime = 5L)

.euroleague_pbp <- function(raw) {
  rows <- list()
  if (is.list(raw) && !is.null(names(raw))) {
    head <- lapply(c("TeamA", "TeamB", "CodeTeamA", "CodeTeamB"), function(k) raw[[k]])
    names(head) <- c("TeamA", "TeamB", "CodeTeamA", "CodeTeamB")
    for (key in names(.euroleague_quarters)) {
      plays <- raw[[key]]
      if (!(is.list(plays) && is.null(names(plays)))) next
      for (play in plays) {
        if (is.list(play) && !is.null(names(play))) {
          rows[[length(rows) + 1L]] <- c(list(Quarter = .euroleague_quarters[[key]]), head, play)
        }
      }
    }
  }
  df <- .euroleague_live_frame("game_pbp", rows)
  # The running score is an integer on the wire but null on the admin plays that
  # open a period; a truncated or partial body must not drift it to character.
  for (col in intersect(c("points_a", "points_b"), names(df))) df[[col]] <- suppressWarnings(as.integer(df[[col]]))
  df
}

# The side's `{prefix}_Q1..` cells from a `ByQuarter` / `EndOfQuarter` block
# (matched by team name, case folded, falling back to the side's position).
.euroleague_quarter_scores <- function(block, side, team, prefix) {
  if (!(is.list(block) && is.null(names(block)))) return(list())
  rows <- Filter(function(r) is.list(r) && !is.null(names(r)), block)
  name <- tolower(trimws(as.character(if (is.null(team)) "" else team)))
  match <- NULL
  for (r in rows) {
    if (identical(tolower(trimws(as.character(if (is.null(r$Team)) "" else r$Team))), name)) {
      match <- r
      break
    }
  }
  if (is.null(match) && side <= length(rows)) match <- rows[[side]]
  if (is.null(match)) return(list())
  match <- match[names(match) != "Team"]
  names(match) <- paste0(prefix, "_", sub("Quarter", "Q", names(match), fixed = TRUE))
  lapply(match, function(v) if (is.null(v)) NA else v)
}

.euroleague_boxscore <- function(raw) {
  rows <- list()
  sides <- if (is.list(raw) && !is.null(names(raw))) raw$Stats else NULL
  if (is.list(sides) && is.null(names(sides))) {
    game <- list(Attendance = raw$Attendance, Referees = raw$Referees)
    game <- lapply(game, function(v) if (is.null(v)) NA else v)
    for (i in seq_along(sides)) {
      side <- sides[[i]]
      if (!(is.list(side) && !is.null(names(side)))) next
      head <- c(
        list(TeamName = if (is.null(side$Team)) NA else side$Team, Coach = if (is.null(side$Coach)) NA else side$Coach),
        game,
        .euroleague_quarter_scores(raw$ByQuarter, i, side$Team, "ByQuarter"),
        .euroleague_quarter_scores(raw$EndOfQuarter, i, side$Team, "EndOfQuarter")
      )
      players <- side$PlayersStats
      if (is.list(players) && is.null(names(players))) {
        for (player in players) {
          if (is.list(player) && !is.null(names(player))) {
            rows[[length(rows) + 1L]] <- c(list(RowType = "player"), head, player)
          }
        }
      }
      for (key in c("tmr", "totr")) {
        block <- side[[key]]
        if (is.list(block) && !is.null(names(block))) {
          rows[[length(rows) + 1L]] <- c(list(RowType = if (key == "tmr") "team" else "total"), head, block)
        }
      }
    }
  }
  df <- .euroleague_live_frame("game_boxscore", rows)
  # 1 / 0 flags on the player rows, absent on the totals row: pin them, never double.
  for (col in intersect(c("is_starter", "is_playing"), names(df))) df[[col]] <- suppressWarnings(as.integer(df[[col]]))
  df
}

# Wrap a parsed frame as the family's `hoopR_data` tibble.
.euroleague_data <- function(df, what, host = "api-live.euroleague.net") {
  make_hoopR_data(dplyr::as_tibble(df), paste0("EuroLeague ", what, " from ", host), Sys.time())
}

# Documented columns per live-API route (sdv-py `_euroleague_schemas.SCHEMAS`, built
# from the committed captures), so the empty-body "no such game" answer still
# parses to a zero-row frame carrying the returns table.
.euroleague_live_schemas <- list(
  game_boxscore = c(
    row_type = "character",
    team_name = "character",
    coach = "character",
    attendance = "character",
    referees = "character",
    by_quarter_q1 = "integer",
    by_quarter_q2 = "integer",
    by_quarter_q3 = "integer",
    by_quarter_q4 = "integer",
    end_of_quarter_q1 = "integer",
    end_of_quarter_q2 = "integer",
    end_of_quarter_q3 = "integer",
    end_of_quarter_q4 = "integer",
    player_id = "character",
    is_starter = "integer",
    is_playing = "integer",
    team = "character",
    dorsal = "character",
    player = "character",
    minutes = "character",
    points = "integer",
    field_goals_made2 = "integer",
    field_goals_attempted2 = "integer",
    field_goals_made3 = "integer",
    field_goals_attempted3 = "integer",
    free_throws_made = "integer",
    free_throws_attempted = "integer",
    offensive_rebounds = "integer",
    defensive_rebounds = "integer",
    total_rebounds = "integer",
    assistances = "integer",
    steals = "integer",
    turnovers = "integer",
    blocks_favour = "integer",
    blocks_against = "integer",
    fouls_commited = "integer",
    fouls_received = "integer",
    valuation = "integer",
    plusminus = "integer"
  ),
  game_header = c(
    live = "logical",
    round = "character",
    date = "character",
    hour = "character",
    stadium = "character",
    capacity = "character",
    team_a = "character",
    team_b = "character",
    code_team_a = "character",
    tv_code_a = "character",
    code_team_b = "character",
    tv_code_b = "character",
    im_a = "character",
    im_b = "character",
    score_a = "character",
    score_b = "character",
    coach_a = "character",
    coach_b = "character",
    game_time = "character",
    remaining_partial_time = "character",
    wid = "character",
    quarter = "character",
    foults_a = "character",
    foults_b = "character",
    timeouts_a = "character",
    timeouts_b = "character",
    score_quarter1_a = "integer",
    score_quarter2_a = "integer",
    score_quarter3_a = "integer",
    score_quarter4_a = "integer",
    score_extra_time_a = "integer",
    score_quarter1_b = "integer",
    score_quarter2_b = "integer",
    score_quarter3_b = "integer",
    score_quarter4_b = "integer",
    score_extra_time_b = "integer",
    phase = "character",
    phase_reduced_name = "character",
    competition = "character",
    competition_reduced_name = "character",
    pcom = "character",
    referee1 = "character",
    referee2 = "character",
    referee3 = "character"
  ),
  game_pbp = c(
    quarter = "integer",
    team_a = "character",
    team_b = "character",
    code_team_a = "character",
    code_team_b = "character",
    type = "integer",
    numberofplay = "integer",
    codeteam = "character",
    player_id = "character",
    playtype = "character",
    player = "character",
    team = "character",
    dorsal = "character",
    minute = "integer",
    markertime = "character",
    points_a = "integer",
    points_b = "integer",
    comment = "character",
    playinfo = "character"
  ),
  game_points = c(
    num_anot = "integer",
    team = "character",
    id_player = "character",
    player = "character",
    id_action = "character",
    action = "character",
    points = "integer",
    coord_x = "integer",
    coord_y = "integer",
    zone = "character",
    fastbreak = "character",
    second_chance = "character",
    points_off_turnover = "character",
    minute = "integer",
    console = "character",
    points_a = "integer",
    points_b = "integer",
    utc = "character"
  )
)
