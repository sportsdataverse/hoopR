# sportality_parsers.R -- frames of the Basketligaen wrappers (internal; parse_* is not exported).
#
# R mirror of sdv-py sportsdataverse/basketball/dbl/sportality_parsers.py (origin/main e3d232e).
# Rows are built as named lists whose `NULL` entries are kept (Python's `None`): never assign
# `x[[k]] <- NULL`, which drops the entry. Columns are snake_case (`.sportality_column()`, over
# the sdv-py `underscore()` port); each column gets one type from its values exactly as sdv-py's
# `_series()` does, every Genius id (`player_id`, `game_id`, `game_source_id`, `event_id`,
# `ext_id`, `team_id`, prefixed or not) is an integer, and the frame is then conformed to the
# route's documented schema (`.sportality_schemas`, sdv-py `SCHEMAS`): documented columns first,
# in order and type (a value the type cannot hold becomes `NA`, as polars `strict=False`), then
# anything the API added later. Platform uuids are character. Objects and arrays left in a cell
# become JSON text in Python's `json.dumps(sort_keys=True)` form.

#' @noRd
.SPORTALITY_INT_ID <- "(^|_)(player_id|game_id|game_source_id|event_id|ext_id|team_id)$"
#' Stat cells that are labels, ids or placeholders, not measurements.
#' @noRd
.SPORTALITY_NOT_STATS <- c("NR", "POS", "Strk", "Attendance", "pno", "teamNumber", "Rank")
#' Stats-table display slots holding a constant 0 / null: dropped.
#' @noRd
.SPORTALITY_PLACEHOLDERS <- c("Rank", "Player", "Team", "Season", "Series", "GameType")
#' games_games cells duplicated by info.homeTeamId / info.awayTeamId.
#' @noRd
.SPORTALITY_DUPLICATE_CELLS <- c("HomeTeam", "GuestTeam")
#' @noRd
.SPORTALITY_SCHEDULE_KEYS <- c("gameInfo", "games", "playedGames", "upcomingGames")
#' @noRd
.SPORTALITY_TEAM_PREFIX <- c(homeTeamInfo = "homeTeam", awayTeamInfo = "awayTeam", venueInfo = "venue",
                             seriesInfo = "series")
#' @noRd
.SPORTALITY_BOX_LABELS <- c("sports.stats.team_coach" = "team_coach", "sports.stats.team_totals" = "team_totals")
#' Team-block fields kept on a play-by-play line.
#' @noRd
.SPORTALITY_PBP_TEAM_KEYS <- c("teamId", "teamCode", "teamName", "abbreviation", "teamNumber", "place", "score")
#' The team record of a stats-info team row, cut to the fields that identify the team.
#' @noRd
.SPORTALITY_TEAM_INFO_KEYS <- c("id", "uuid", "teamCode", "name", "siteDisplayName", "ownerInstanceId", "gender",
                                "nationality")

# ---------------------------------------------------------------------------
# Values
# ---------------------------------------------------------------------------

#' @noRd
.sportality_scalar <- function(v) is.atomic(v) && length(v) == 1L && !is.na(v)
#' A JSON number (not a boolean).
#' @noRd
.sportality_is_number <- function(v) (is.integer(v) || is.double(v)) && length(v) == 1L && !is.na(v)
#' A JSON integer (sdv-py `isinstance(v, int)`).
#' @noRd
.sportality_is_int <- function(v) is.integer(v) && length(v) == 1L && !is.na(v)

#' @noRd
.SPORTALITY_FLOAT_RE <- "^\\s*[+-]?(([0-9]+\\.?[0-9]*)|(\\.[0-9]+))([eE][+-]?[0-9]+)?\\s*$"

#' A number or numeric string as a double (Python `float()`), else `NA`.
#' @noRd
.sportality_as_float <- function(v) {
  if (.sportality_is_number(v)) return(as.double(v))
  if (is.character(v) && length(v) == 1L && !is.na(v)) {
    t <- trimws(v)
    if (grepl(.SPORTALITY_FLOAT_RE, v, perl = TRUE)) return(as.double(t))
    if (grepl("^[+-]?(nan|inf|infinity)$", t, ignore.case = TRUE)) {
      return(suppressWarnings(as.double(sub("(?i)infinity", "inf", t, perl = TRUE))))
    }
  }
  NA_real_
}

#' An integer or an integer-looking string (never "123.0" -> 123), else `NULL`.
#' @noRd
.sportality_as_int <- function(v) {
  if (.sportality_is_int(v)) return(v)
  if (is.character(v) && length(v) == 1L && !is.na(v) && grepl("^\\s*-?[0-9]+\\s*$", v)) {
    n <- suppressWarnings(as.integer(trimws(v)))
    if (!is.na(n)) return(n)
  }
  NULL
}

#' `""` -> `NULL` (the box score fills team-row cells with empty strings).
#' @noRd
.sportality_blank <- function(v) if (identical(v, "")) NULL else v

#' Python `repr()` of a float.
#' @noRd
.sportality_pyfloat <- function(x) {
  if (is.nan(x)) return("NaN")
  if (is.infinite(x)) return(if (x > 0) "Infinity" else "-Infinity")
  if (x == trunc(x) && abs(x) < 1e16) return(sprintf("%.1f", x))
  for (d in 15:17) {
    s <- formatC(x, digits = d, format = "g")
    if (as.double(s) == x) break
  }
  s <- trimws(s)
  s <- sub("e([+-])0?([0-9])", "e\\1\\2", s)
  sub("e([+-])([0-9])$", "e\\10\\2", s)
}

#' Python `json.dumps(v, ensure_ascii = False, sort_keys = True)`.
#' @noRd
.sportality_pyjson <- function(v) {
  if (is.null(v)) return("null")
  if (.sportality_is_dict(v)) {
    if (!length(v)) return("{}")
    keys <- sort(names(v), method = "radix")
    parts <- vapply(keys, function(k) paste0(.sportality_pyjson(k), ": ", .sportality_pyjson(v[[k]])), "")
    return(paste0("{", paste(parts, collapse = ", "), "}"))
  }
  if (is.list(v)) return(paste0("[", paste(vapply(v, .sportality_pyjson, ""), collapse = ", "), "]"))
  if (is.logical(v)) return(if (isTRUE(v)) "true" else "false")
  if (is.integer(v)) return(as.character(v))
  if (is.double(v)) return(.sportality_pyfloat(v))
  s <- gsub("\\", "\\\\", v, fixed = TRUE)
  s <- gsub("\"", "\\\"", s, fixed = TRUE)
  s <- gsub("\n", "\\n", s, fixed = TRUE)
  s <- gsub("\r", "\\r", s, fixed = TRUE)
  s <- gsub("\t", "\\t", s, fixed = TRUE)
  paste0("\"", s, "\"")
}

#' A cell as text (sdv-py `_text`): objects and arrays as JSON, booleans as true / false.
#' @noRd
.sportality_text <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (is.list(v)) return(.sportality_pyjson(v))
  if (length(v) != 1L || is.na(v)) return(NA_character_)
  if (is.logical(v)) return(if (v) "true" else "false")
  if (is.double(v)) return(.sportality_pyfloat(v))
  as.character(v)
}

# ---------------------------------------------------------------------------
# Rows and frames
# ---------------------------------------------------------------------------

#' Wire key -> snake_case column (`FG%` -> `fg_perc`, `+/-` -> `plus_minus`).
#' @noRd
.sportality_column <- function(key) {
  key <- gsub("%", "Perc", gsub("+/-", "PlusMinus", key, fixed = TRUE), fixed = TRUE)
  gsub("^_+|_+$", "", gsub("[^0-9a-z_]+", "_", .intl_clean_names(key), perl = TRUE))
}

#' Python `{**a, **b}`: `b`'s entries set in place (or appended), `NULL` entries kept.
#' @noRd
.sportality_merge <- function(a, b) {
  for (k in names(b)) a[k] <- list(b[[k]])
  a
}

#' Nested objects -> one flat row; keys joined by `_` (arrays stay as values, `{}` becomes `NULL`).
#' @noRd
.sportality_flatten <- function(obj, prefix = "") {
  out <- stats::setNames(list(), character())
  for (k in names(obj)) {
    v <- obj[[k]]
    key <- if (nzchar(prefix)) paste0(prefix, "_", k) else k
    if (.sportality_is_dict(v) && length(v)) {
      out <- .sportality_merge(out, .sportality_flatten(v, key))
    } else {
      out[key] <- list(if (.sportality_is_dict(v)) NULL else v)
    }
  }
  out
}

#' One column typed from the values, as sdv-py `_series()`.
#' @noRd
.sportality_series <- function(name, values, stat) {
  present <- Filter(Negate(is.null), values)
  if (stat && length(present) && all(!is.na(vapply(present, .sportality_as_float, 0)))) {
    if (all(vapply(present, .sportality_is_int, logical(1))) && !grepl("(_perc|pg)$", name)) {
      return(vapply(values, function(v) if (is.null(v)) NA_integer_ else v, integer(1), USE.NAMES = FALSE))
    }
    return(vapply(values, function(v) if (is.null(v)) NA_real_ else .sportality_as_float(v), double(1), USE.NAMES = FALSE))
  }
  if (length(present) && all(vapply(present, function(v) is.logical(v) && length(v) == 1L && !is.na(v), logical(1)))) {
    return(vapply(values, function(v) if (is.null(v)) NA else v, logical(1), USE.NAMES = FALSE))
  }
  if (length(present) && all(vapply(present, .sportality_is_number, logical(1)))) {
    if (all(vapply(present, is.integer, logical(1)))) {
      return(vapply(values, function(v) if (is.null(v)) NA_integer_ else v, integer(1), USE.NAMES = FALSE))
    }
    return(vapply(values, function(v) if (is.null(v)) NA_real_ else as.double(v), double(1), USE.NAMES = FALSE))
  }
  vapply(values, .sportality_text, character(1), USE.NAMES = FALSE)
}

#' A column cast to a type code (`i`, `f`, `s`, `b`) the way polars `cast(strict = FALSE)` does.
#' @noRd
.sportality_cast <- function(x, code) {
  if (is.list(x)) x <- vapply(x, .sportality_text, character(1))
  switch(code,
    i = {
      if (is.integer(x)) return(x)
      if (is.logical(x)) return(as.integer(x))
      if (is.double(x)) {
        ok <- is.finite(x) & abs(x) <= .Machine$integer.max
        out <- rep(NA_integer_, length(x))
        out[ok] <- as.integer(trunc(x[ok]))
        return(out)
      }
      out <- rep(NA_integer_, length(x))
      ok <- !is.na(x) & grepl("^-?[0-9]+$", x)
      out[ok] <- suppressWarnings(as.integer(x[ok]))
      out
    },
    f = {
      if (is.double(x)) return(x)
      if (is.integer(x) || is.logical(x)) return(as.double(x))
      vapply(x, .sportality_as_float, double(1), USE.NAMES = FALSE)
    },
    s = {
      if (is.character(x)) return(x)
      if (is.logical(x)) return(ifelse(is.na(x), NA_character_, ifelse(x, "true", "false")))
      if (is.integer(x)) return(as.character(x))
      vapply(x, function(v) if (is.na(v)) NA_character_ else .sportality_pyfloat(v), character(1), USE.NAMES = FALSE)
    },
    b = {
      if (is.logical(x)) return(x)
      if (is.numeric(x)) return(x != 0)
      out <- rep(NA, length(x))
      low <- tolower(x)
      out[!is.na(low) & low == "true"] <- TRUE
      out[!is.na(low) & low == "false"] <- FALSE
      out
    }
  )
}

#' Flat wire-keyed rows -> tibble: snake_case columns, typed cells, integer Genius ids.
#' @noRd
.sportality_frame <- function(rows, stat_keys = character()) {
  rows <- Filter(function(r) .sportality_is_dict(r) && any(!vapply(r, is.null, logical(1))), rows)
  if (!length(rows)) return(dplyr::tibble())
  keys <- unique(unlist(lapply(rows, names), use.names = FALSE))
  cols <- list()
  for (k in keys) {
    name <- .sportality_column(k)
    if (!nzchar(name) || name %in% names(cols)) next
    values <- lapply(rows, function(r) r[[k]])
    numeric_list <- function(v) .sportality_is_array(v) && length(v) && all(vapply(v, .sportality_is_number, logical(1)))
    if (endsWith(name, "_ids") && any(vapply(values, numeric_list, logical(1)))) {
      cols[[name]] <- lapply(values, function(v) if (is.null(v)) NULL else as.integer(unlist(v)))
      next
    }
    cols[[name]] <- .sportality_series(name, values, k %in% stat_keys || endsWith(name, "_perc"))
  }
  for (n in names(cols)) {
    if (grepl(.SPORTALITY_INT_ID, n, perl = TRUE) && !is.integer(cols[[n]])) cols[[n]] <- .sportality_cast(cols[[n]], "i")
  }
  dplyr::as_tibble(cols)
}

#' A zero-length vector of a type code.
#' @noRd
.sportality_empty <- function(code) switch(code, i = integer(), f = double(), s = character(), b = logical())

#' Conform a frame to a documented schema (named type codes): documented columns first, in order
#' and type, then the rest.
#' @noRd
.sportality_finish <- function(df, schema = NULL) {
  if (is.null(schema)) return(if (nrow(df)) df else dplyr::tibble())
  if (!nrow(df)) return(dplyr::as_tibble(lapply(schema, .sportality_empty)))
  out <- lapply(names(schema), function(c) {
    if (c %in% names(df)) .sportality_cast(df[[c]], schema[[c]]) else .sportality_cast(rep(NA, nrow(df)), schema[[c]])
  })
  names(out) <- names(schema)
  extra <- setdiff(names(df), names(schema))
  dplyr::as_tibble(c(out, as.list(df)[extra]))
}

#' The one object of a one-item-list body (stats-info, career log); `raw` otherwise.
#' @noRd
.sportality_body <- function(raw) {
  if (.sportality_is_array(raw) && length(raw) && .sportality_is_dict(raw[[1]])) raw[[1]] else raw
}

# ---------------------------------------------------------------------------
# Parsers (one per sdv-py parse_sportality_*)
# ---------------------------------------------------------------------------

#' Any body by the generic row rule: an array -> its items; an object holding exactly one array ->
#' that array's items; any other non-empty object -> one row; the provider route's bare word -> one
#' `provider` row.
#' @noRd
.sportality_parse <- function(raw, schema = NULL) {
  rows <- list()
  if (is.character(raw) && length(raw) == 1L && grepl("^[a-z_-]{1,40}$", trimws(raw))) {
    rows <- list(list(provider = trimws(raw)))
  } else if (.sportality_is_array(raw)) {
    rows <- raw
  } else if (.sportality_is_dict(raw) && length(raw)) {
    lists <- Filter(.sportality_is_array, unname(raw))
    rows <- if (length(lists) == 1L) lists[[1]] else list(raw)
  }
  flat <- lapply(Filter(.sportality_is_dict, rows), function(r) .sportality_flatten(.sportality_scrub(r)))
  .sportality_finish(.sportality_frame(flat), schema)
}

#' A page object (a team, a game header or overview, an athlete profile) as ONE row.
#' @noRd
.sportality_parse_page <- function(raw, schema = NULL) {
  rows <- if (.sportality_is_dict(raw) && length(raw)) list(.sportality_flatten(.sportality_scrub(raw))) else list()
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/sports-v2/athlete-details/{uuid}`: one row with the Genius person id from `playerExtIds`.
#' @noRd
.sportality_parse_athlete <- function(raw, schema = NULL) {
  data <- .sportality_dict(.sportality_dict(raw)$athleteData)
  if (!length(data)) return(.sportality_finish(dplyr::tibble(), schema))
  genius <- NULL
  for (e in .sportality_list(data$playerExtIds)) {
    if (.sportality_is_dict(e) && identical(.sportality_dict(e$extIdType)$code, "genius-basketball")) {
      genius <- .sportality_as_int(e$extId)
      break
    }
  }
  rec <- .sportality_scrub(data[setdiff(names(data), c("playerExtIds", "uuid"))])
  row <- .sportality_merge(list(athleteUuid = data$uuid, playerId = genius), .sportality_flatten(rec))
  .sportality_finish(.sportality_frame(list(row)), schema)
}

#' A schedule body (game-schedule, last / next game day, played / upcoming games): one row per game.
#' @noRd
.sportality_parse_schedule <- function(raw, schema = NULL) {
  games <- list()
  if (.sportality_is_dict(raw)) {
    for (k in .SPORTALITY_SCHEDULE_KEYS) {
      if (.sportality_is_array(raw[[k]])) {
        games <- raw[[k]]
        break
      }
    }
  }
  rows <- list()
  for (g in Filter(.sportality_is_dict, games)) {
    row <- stats::setNames(list(), character())
    g <- .sportality_scrub(g)
    for (k in names(g)) {
      v <- g[[k]]
      if (k == "uuid") {
        row["gameUuid"] <- list(v)
      } else if (k %in% names(.SPORTALITY_TEAM_PREFIX) && .sportality_is_dict(v)) {
        row <- .sportality_merge(row, .sportality_flatten(v, .SPORTALITY_TEAM_PREFIX[[k]]))
      } else {
        row <- .sportality_merge(row, .sportality_flatten(stats::setNames(list(v), k)))
      }
    }
    for (key in grep("_score$", names(row), value = TRUE)) row[key] <- list(.sportality_blank(row[[key]]))
    rows[[length(rows) + 1L]] <- row
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' A play-by-play player record -> `playerId` (Genius) + its names.
#' @noRd
.sportality_pbp_player <- function(rec) {
  if (!.sportality_is_dict(rec)) return(list())
  out <- list(playerId = rec$playerId)
  .sportality_merge(out, .sportality_flatten(rec[setdiff(names(rec), "playerId")], "player"))
}

#' `/gameday/play-by-play/{game_uuid}`: one row per event, in upstream order.
#' @noRd
.sportality_parse_pbp <- function(raw, schema = NULL) {
  rows <- list()
  for (ev in Filter(.sportality_is_dict, if (.sportality_is_array(raw)) raw else list())) {
    row <- stats::setNames(list(), character())
    for (k in names(ev)) {
      v <- ev[[k]]
      if (k %in% c("homeTeam", "awayTeam", "eventTeam") && .sportality_is_dict(v)) {
        keep <- intersect(.SPORTALITY_PBP_TEAM_KEYS, names(v))
        row <- .sportality_merge(row, .sportality_flatten(v[keep], sub("Team$", "", k)))
      } else if (k == "player") {
        row <- .sportality_merge(row, .sportality_pbp_player(v))
      } else if (k == "qualifiers") {
        row["qualifiers"] <- list(if (.sportality_is_array(v)) paste(vapply(v, .sportality_text, ""), collapse = ";") else v)
      } else {
        row <- .sportality_merge(row, .sportality_flatten(stats::setNames(list(v), k)))
      }
    }
    rows[[length(rows) + 1L]] <- row
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/gameday/boxscore/{game_uuid}` and `/gameday/player-stats/{game_uuid}`: players, then each
#' side's team_coach and team_totals rows; `team_id` is the side's id from its totals row.
#' @noRd
.sportality_parse_player_box <- function(raw, schema = NULL) {
  rows <- list()
  stats <- character()
  body <- .sportality_scrub(.sportality_dict(raw))
  sides <- .sportality_dict(body$stats)
  names_map <- .sportality_dict(body$players)
  for (side_key in c("homeTeamValue", "awayTeamValue")) {
    side <- if (side_key == "homeTeamValue") "home" else "away"
    recs <- Filter(.sportality_is_dict, .sportality_list(sides[[side_key]]))
    side_names <- .sportality_dict(names_map[[side_key]])
    team_id <- NULL
    for (r in recs) {
      if (identical(.sportality_dict(r$info)$label, "sports.stats.team_totals")) {
        team_id <- .sportality_dict(r$info)$teamId
        break
      }
    }
    start <- length(rows)
    for (rec in recs) {
      info <- .sportality_dict(rec$info)
      pid <- .sportality_blank(info$playerId)
      label <- .sportality_str(info$label)
      row <- list(teamSide = side,
                  rowType = if (label %in% names(.SPORTALITY_BOX_LABELS)) .SPORTALITY_BOX_LABELS[[label]] else "player",
                  playerId = pid, teamId = team_id, teamName = info$team, period = info$period)
      who <- .sportality_dict(side_names[[.sportality_str(pid)]])
      row <- .sportality_merge(row, who[setdiff(names(who), "extIds")])
      cells <- rec[setdiff(names(rec), "info")]
      cells <- lapply(cells, .sportality_blank)
      for (k in names(cells)) {
        v <- cells[[k]]
        if (!k %in% .SPORTALITY_NOT_STATS && !is.list(v)) stats <- union(stats, k)
      }
      rows[[length(rows) + 1L]] <- .sportality_merge(row, cells)
    }
    mine <- seq_along(rows)[seq_along(rows) > start]
    side_team <- NULL
    for (i in mine) {
      t <- rows[[i]]$teamName
      if (is.character(t) && length(t) == 1L && nzchar(t)) {
        side_team <- t
        break
      }
    }
    for (i in mine) rows[[i]]["teamName"] <- list(side_team) # the summary rows carry no team name
  }
  .sportality_finish(.sportality_frame(rows, stats), schema)
}

#' `/gameday/team-stats/{game_uuid}`: one row per side and period (0 = the game).
#' @noRd
.sportality_parse_team_stats <- function(raw, schema = NULL) {
  rows <- list()
  stat_keys <- character()
  body <- .sportality_dict(raw)
  for (side in c("home", "away")) {
    team <- body[[side]]
    if (!.sportality_is_dict(team)) next
    head <- .sportality_merge(list(teamSide = side), team[setdiff(names(team), c("statistics", "place"))])
    for (per in Filter(.sportality_is_dict, .sportality_list(team$statistics))) {
      row <- .sportality_merge(head, list(period = per$period, periodType = per$periodType))
      for (kv in .sportality_list(per$parsedTotalStatistics)) {
        if (.sportality_is_dict(kv) && !is.null(kv$key) && !identical(kv$key, "")) {
          k <- .sportality_str(kv$key)
          row[k] <- list(kv$value)
          stat_keys <- union(stat_keys, k)
        }
      }
      rows[[length(rows) + 1L]] <- row
    }
  }
  .sportality_finish(.sportality_frame(rows, stat_keys), schema)
}

#' `/gameday/team-standings/{ssgt_uuid}`: one row per team; `strk` as a signed integer.
#' @noRd
.sportality_parse_standings <- function(raw, schema = NULL) {
  rows <- list()
  for (rec in Filter(.sportality_is_dict, .sportality_list(.sportality_dict(raw)$leagueStandings))) {
    info <- .sportality_dict(rec$info)
    team <- .sportality_dict(info$teamInfo)
    nm <- .sportality_dict(team$teamNames)
    long <- nm$long
    row <- list(teamId = info$teamId, teamUuid = team$teamUuid, teamCode = nm$code,
                teamName = if (is.character(long) && length(long) == 1L && nzchar(long)) long else info$code)
    row <- .sportality_merge(row, rec[setdiff(names(rec), c("info", "Team"))])
    row["Strk"] <- list(.sportality_as_int(row$Strk))
    rows[[length(rows) + 1L]] <- row
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `players{<genius id>: {uuid}}` -> `c(<uuid> = <genius id>)`.
#' @noRd
.sportality_genius_by_uuid <- function(players) {
  out <- integer()
  if (.sportality_is_dict(players)) {
    for (k in names(players)) {
      v <- players[[k]]
      u <- if (.sportality_is_dict(v)) v$uuid else NULL
      if (!is.null(u) && !identical(u, "") && grepl("^[0-9]+$", k)) {
        u <- .sportality_str(u)
        if (is.na(out[u])) out[u] <- suppressWarnings(as.integer(k))
      }
    }
  }
  out
}

#' A stats-info row's `info` record with the team ids named consistently.
#' @noRd
.sportality_stats_info_record <- function(info) {
  info <- info[setdiff(names(info), "playerMedia")]
  if (.sportality_is_int(info$teamCode)) {
    v <- info$teamCode
    info <- info[setdiff(names(info), "teamCode")]
    info["teamId"] <- list(v)
  } else if (identical(info$type, "team")) {
    keep <- intersect(.SPORTALITY_TEAM_INFO_KEYS, names(info))
    info <- stats::setNames(info[keep], ifelse(keep == "id", "teamId", keep))
  }
  info
}

#' `/statistics-v2/stats-info/{module}` and the athlete career log: one row per `stats[]` entry.
#' @noRd
.sportality_parse_stats_info <- function(raw, schema = NULL) {
  body <- .sportality_scrub(.sportality_body(raw))
  if (!.sportality_is_dict(body)) return(.sportality_finish(dplyr::tibble(), schema))
  genius <- if (!identical(body$type, "athlete_single")) .sportality_genius_by_uuid(body$players) else integer()
  rows <- list()
  stats <- character()
  for (rec in Filter(.sportality_is_dict, .sportality_list(body$stats))) {
    info <- .sportality_stats_info_record(.sportality_dict(rec$info))
    row <- stats::setNames(list(), character())
    if (length(genius)) {
      g <- genius[.sportality_str(info$uuid)]
      row["playerId"] <- list(if (is.na(g)) NULL else unname(g))
    }
    cells <- stats::setNames(list(), character())
    for (k in names(rec)) {
      v <- rec[[k]]
      if (k == "info" || k %in% .SPORTALITY_DUPLICATE_CELLS) next
      zero <- is.null(v) || identical(v, "") || ((is.numeric(v) || is.logical(v)) && .sportality_scalar(v) && v == 0)
      if (k %in% .SPORTALITY_PLACEHOLDERS && zero) next
      cells[k] <- list(.sportality_blank(v))
    }
    if ("GameScore" %in% names(cells)) {
      score <- cells$GameScore
      cells <- cells[names(cells) != "GameScore"]
      if (.sportality_is_dict(score)) {
        cells <- .sportality_merge(cells, list(homeScore = .sportality_as_int(score$homeScore),
                                               awayScore = .sportality_as_int(score$awayScore),
                                               decidedIn = .sportality_blank(score$decidedIn)))
      }
    }
    for (k in names(cells)) {
      if (!k %in% c(.SPORTALITY_NOT_STATS, "homeScore", "awayScore") && !is.list(cells[[k]])) stats <- union(stats, k)
    }
    row <- .sportality_merge(row, .sportality_flatten(cells))
    row <- .sportality_merge(row, .sportality_flatten(info, "info"))
    rows[[length(rows) + 1L]] <- row
  }
  .sportality_finish(.sportality_frame(rows, stats), schema)
}

#' The `players{}` map of a stats-info body: one row per player (Genius person id -> athlete uuid).
#' @noRd
.sportality_parse_player_crosswalk <- function(raw, schema = NULL) {
  body <- .sportality_scrub(.sportality_body(raw))
  players <- if (.sportality_is_dict(body)) body$players else NULL
  rows <- list()
  if (.sportality_is_dict(players)) {
    for (k in names(players)) {
      v <- players[[k]]
      if (!.sportality_is_dict(v) || !grepl("^[0-9]+$", k)) next
      rec <- v[setdiff(names(v), c("id", "uuid", "type", "playerMedia", "teamPlayers"))]
      rows[[length(rows) + 1L]] <- .sportality_merge(list(playerId = suppressWarnings(as.integer(k)), athleteUuid = v$uuid),
                                                     .sportality_flatten(rec))
    }
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/statistics-v2/layout-info`: one row per ssgt; `season` is the END year.
#' @noRd
.sportality_parse_layout <- function(raw, schema = NULL) {
  body <- .sportality_body(raw)
  ssgts <- if (.sportality_is_dict(body)) body$seasonSeriesGameTypeTeams else NULL
  rows <- list()
  for (s in Filter(.sportality_is_dict, .sportality_list(ssgts))) {
    season <- .sportality_dict(s$season)
    gtype <- .sportality_dict(s$gameType)
    series <- .sportality_dict(s$series)
    code <- if (is.null(season$code) || identical(season$code, "")) "" else .sportality_str(season$code)
    rows[[length(rows) + 1L]] <- list(
      season = if (grepl("^[0-9]+$", code)) as.integer(code) + 1L else NULL,
      seasonCode = if (nzchar(code)) code else NULL,
      seasonName = season$name,
      gameType = gtype$code,
      gameTypeName = gtype$name,
      seriesCode = series$code,
      ssgtUuid = s$ssgtUuid,
      state = s$state,
      seasonUuid = season$uuid,
      seriesUuid = series$uuid,
      gameTypeUuid = gtype$uuid
    )
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/sports-v2/season-series-game-types-filter`: one row per series, season and game type.
#' @noRd
.sportality_parse_filter <- function(raw, schema = NULL) {
  body <- .sportality_dict(raw)
  rows <- list()
  kinds <- c(series = "series", season = "season", gameType = "game_type")
  for (key in names(kinds)) {
    kind <- kinds[[key]]
    for (rec in Filter(.sportality_is_dict, .sportality_list(body[[key]]))) {
      tr <- list()
      for (n in Filter(.sportality_is_dict, .sportality_list(rec$names))) {
        tr[.sportality_str(n$language)] <- list(n$translation)
      }
      en <- tr[["en"]]
      truthy <- function(x) !is.null(x) && !identical(x, "") && !identical(x, FALSE) && !identical(x, 0L)
      name <- if (truthy(en)) en else if (length(tr)) tr[[1]] else NULL
      rows[[length(rows) + 1L]] <- list(kind = kind, code = rec$code, name = name, uuid = rec$uuid,
                                        deleted = rec$deleted)
    }
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/sports-v2/athletes/by-team-uuid/{team_uuid}`: one row per player of the current roster.
#' @noRd
.sportality_parse_roster <- function(raw, schema = NULL) {
  rows <- list()
  for (group in Filter(.sportality_is_dict, if (.sportality_is_array(raw)) raw else list())) {
    for (p in Filter(.sportality_is_dict, .sportality_list(group$players))) {
      p <- .sportality_scrub(p)
      portrait <- .sportality_dict(p$renderedLatestPortrait)
      rec <- p[setdiff(names(p), c("portraitList", "renderedLatestPortrait", "globalPortraitFallback"))]
      row <- .sportality_merge(list(position = group$position, positionCode = group$positionCode),
                               .sportality_flatten(rec))
      rows[[length(rows) + 1L]] <- .sportality_merge(row, list(portraitUrl = portrait$url))
    }
  }
  .sportality_finish(.sportality_frame(rows), schema)
}

#' `/statistics-v2/player-h2h-v2/...`: one row per player, `effective_ssgt_uuid` on every row.
#' @noRd
.sportality_parse_h2h <- function(raw, schema = NULL) {
  body <- .sportality_scrub(.sportality_dict(raw))
  rows <- lapply(Filter(.sportality_is_dict, .sportality_list(body$players)), function(p) {
    .sportality_merge(.sportality_flatten(p), list(effectiveSsgtUuid = body$effectiveSsgtUuid))
  })
  .sportality_finish(.sportality_frame(rows), schema)
}

#' The finished frame: the documented tibble as a `hoopR_data` object.
#' @noRd
.sportality_out <- function(df, type) make_hoopR_data(df, type, Sys.time())
