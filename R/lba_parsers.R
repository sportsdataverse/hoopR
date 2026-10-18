# lba_parsers.R -- the legabasket.it bodies as tibbles, one shaper per lba_* route.
#
# R mirror of sdv-py sportsdataverse/basketball/lba/lba_parsers.py (origin/main e3d232ebc9):
#
# * Row rule: inside a shaper, nested objects flatten into `<parent>_<child>` columns (names through
#   `.intl_clean_names()`, the port of sdv-py `underscore()`), and lists become JSON strings written the way
#   Python's `json.dumps(ensure_ascii = FALSE)` writes them. A wire `id` is renamed for what it identifies
#   (`championship_id`, `game_id`, `team_id`, `player_id`, `coach_id`, `standing_id`, `stat_line_id`).
# * Season: every season-scoped frame carries the END year as `season`: the row's own START year (`year`,
#   `championship_year`, `player_season`) + 1, else the END year the runtime stamped under `_request`. The
#   standings' own wire `season` (a START year) becomes `season_start_year`.
# * Types: polars' inference over every row (integers and doubles -> double; any string -> character), then ids
#   (`(^|_)id$`) to integer when lossless, the per-family numeric strings (`"28.66"`, `"100%"`) to double, and the
#   schema type for an all-null column or a whole-number rate (`.LBA_DTYPES`). Missing documented columns are
#   added as typed NA, documented columns first; a body with no rows gives a zero-row tibble with these columns.
# * Dates stay character, as in sdv-py (offset-carrying ISO strings).

#' @noRd
.LBA_ID_COL <- "(^|_)id$"
#' @noRd
.LBA_START_YEAR <- c("year", "championship_year", "player_season")
#' @noRd
.LBA_NUM <- list(leaderboard = "^(minutes|score)$", player = "_avg$", standings = "_percent$")
#' @noRd
.LBA_SIDES <- list(c("ht", "home", "h_team_id"), c("vt", "visitor", "v_team_id"))
#' Half-court image pixels in 2017-18 and 2018-19 (START years); court percent from 2019-20 on.
#' @noRd
.LBA_PIXEL_STARTS <- c(2017L, 2018L)
#' @noRd
.LBA_RTYPE <- c(i = "integer", f = "double", b = "logical", s = "character")

# ---------------------------------------------------------------------------
# Python json.dumps(ensure_ascii = FALSE)
# ---------------------------------------------------------------------------

#' A string as a JSON literal, escaped as Python's json module escapes it.
#' @noRd
.lba_pystr <- function(x) {
  x <- enc2utf8(x)
  x <- gsub("\\", "\\\\", x, fixed = TRUE)
  x <- gsub("\"", "\\\"", x, fixed = TRUE)
  x <- gsub("\n", "\\n", x, fixed = TRUE)
  x <- gsub("\r", "\\r", x, fixed = TRUE)
  x <- gsub("\t", "\\t", x, fixed = TRUE)
  x <- gsub("\b", "\\b", x, fixed = TRUE)
  x <- gsub("\f", "\\f", x, fixed = TRUE)
  if (grepl("[\001-\037]", x, perl = TRUE)) {
    cp <- utf8ToInt(x)
    x <- paste(vapply(cp, function(c) if (c < 32L) sprintf("\\u%04x", c) else intToUtf8(c), ""), collapse = "")
  }
  paste0("\"", x, "\"")
}

#' A double as Python's `repr()` writes it (shortest round trip; exponent outside 1e-4 .. 1e16).
#' @noRd
.lba_pyfloat <- function(x) {
  if (is.nan(x)) return("NaN")
  if (is.infinite(x)) return(if (x > 0) "Infinity" else "-Infinity")
  if (x == 0) return(if (1 / x < 0) "-0.0" else "0.0")
  for (d in 1:17) {
    s <- sprintf("%.*e", d - 1L, x)
    if (as.numeric(s) == x) break
  }
  m <- regmatches(s, regexec("^(-?)([0-9])\\.?([0-9]*)e([+-][0-9]+)$", s))[[1]]
  sign <- m[[2]]
  digits <- sub("0+$", "", paste0(m[[3]], m[[4]]))
  if (!nzchar(digits)) digits <- "0"
  e <- as.integer(m[[5]])
  if (e >= -4L && e < 16L) {
    if (e >= 0L) {
      digits <- paste0(digits, strrep("0", max(0L, e + 1L - nchar(digits))))
      int <- substr(digits, 1L, e + 1L)
      frac <- substr(digits, e + 2L, nchar(digits))
      return(paste0(sign, int, ".", if (nzchar(frac)) frac else "0"))
    }
    return(paste0(sign, "0.", strrep("0", -e - 1L), digits))
  }
  mant <- if (nchar(digits) > 1L) paste0(substr(digits, 1L, 1L), ".", substr(digits, 2L, nchar(digits))) else digits
  paste0(sign, mant, "e", if (e < 0L) "-" else "+", sprintf("%02d", abs(e)))
}

#' A parsed JSON value as Python's `json.dumps(value, ensure_ascii = False)` text.
#' @noRd
.lba_pyjson <- function(x) {
  if (is.null(x)) return("null")
  if (is.list(x)) {
    if (!length(x)) return(if (is.null(names(x))) "[]" else "{}")
    parts <- vapply(x, .lba_pyjson, "")
    if (is.null(names(x))) return(paste0("[", paste(parts, collapse = ", "), "]"))
    return(paste0("{", paste(paste0(vapply(names(x), .lba_pystr, ""), ": ", parts), collapse = ", "), "}"))
  }
  if (length(x) != 1L || is.na(x)) return("null")
  if (is.logical(x)) return(if (x) "true" else "false")
  if (is.character(x)) return(.lba_pystr(x))
  if (is.integer(x)) return(as.character(x))
  .lba_pyfloat(x)
}

#' A scalar as Python's `str()` writes it (the `str(id)` key of the calendar's id-keyed maps).
#' @noRd
.lba_pystr_value <- function(x) {
  if (is.null(x) || (length(x) == 1L && is.na(x))) return("None")
  if (is.character(x)) return(x)
  if (is.logical(x)) return(if (x) "True" else "False")
  if (is.integer(x)) return(as.character(x))
  if (is.double(x)) return(.lba_pyfloat(x))
  .lba_pyjson(x)
}

# ---------------------------------------------------------------------------
# Rows
# ---------------------------------------------------------------------------

#' A JSON object (named list) or `list()`.
#' @noRd
.lba_obj <- function(x) if (.lba_is_dict(x)) x else stats::setNames(list(), character())
#' The objects of a JSON array.
#' @noRd
.lba_list <- function(x) if (.lba_is_array(x)) Filter(.lba_is_dict, x) else list()
#' A JSON integer, else NA (a logical is not one).
#' @noRd
.lba_int <- function(x) if (is.integer(x) && length(x) == 1L && !is.na(x)) x else NA_integer_
#' The END year the runtime stamped under `_request`.
#' @noRd
.lba_request_season <- function(raw) .lba_int(.lba_obj(.lba_obj(raw)[[.LBA_REQUEST]])$season)

#' The END-year season of a row: its own START year + 1, else `fallback`.
#' @noRd
.lba_season <- function(row, fallback = NA_integer_) {
  for (key in .LBA_START_YEAR) {
    start <- .lba_int(row[[key]])
    if (!is.na(start)) return(start + 1L)
  }
  fallback
}

#' Assign `b`'s fields into `a` in order (a dict update: an existing key keeps its place).
#' @noRd
.lba_merge <- function(a, b) {
  for (k in names(b)) a[[k]] <- b[[k]]
  a
}

#' One flat row: nested objects as `<parent>_<child>`, lists as JSON strings, null as NA.
#' @noRd
.lba_flat <- function(obj, prefix = "") {
  out <- list()
  keys <- names(obj)
  for (i in seq_along(obj)) {
    if (identical(keys[[i]], .LBA_REQUEST)) next
    value <- obj[[i]]
    name <- paste0(prefix, .intl_clean_names(keys[[i]]))
    if (.lba_is_array(value)) {
      out[[name]] <- .lba_pyjson(value)
    } else if (.lba_is_dict(value)) {
      out <- .lba_merge(out, .lba_flat(value, paste0(name, "_")))
    } else {
      out[[name]] <- if (is.null(value)) NA else value
    }
  }
  out
}

#' Flatten `obj`; a wire `id` becomes `id_name` and `rename` maps other wire names (in place).
#' @noRd
.lba_named <- function(obj, id_name = NULL, rename = NULL) {
  row <- .lba_flat(obj)
  map <- c(if (!is.null(id_name)) c(id = id_name), rename)
  for (old in names(map)) {
    if (!old %in% names(row)) next
    new <- list()
    for (k in names(row)) new[[if (k == old) map[[old]] else k]] <- row[[k]]
    row <- new
  }
  row
}

#' A value as JSON text, NA for null.
#' @noRd
.lba_json <- function(x) if (is.null(x)) NA_character_ else .lba_pyjson(x)

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' Integer when every value fits, else (an id over 2^31) the digits as character.
#' @noRd
.lba_whole <- function(x) {
  if (all(is.na(x) | abs(x) <= .Machine$integer.max)) return(as.integer(x))
  ifelse(is.na(x), NA_character_, format(x, scientific = FALSE, trim = TRUE))
}

#' One column from its row values, typed as polars infers it (`strict = False`).
#' @noRd
.lba_column <- function(values) {
  na <- vapply(values, function(v) length(v) == 1L && is.na(v) && is.logical(v), logical(1))
  vals <- values[!na]
  if (!length(vals)) return(rep(NA, length(values)))
  kind <- vapply(vals, function(v) if (is.character(v)) "s" else if (is.logical(v)) "b" else if (is.integer(v)) "i" else "f", "")
  out <- if (any(kind == "s")) {
    vapply(vals, function(v) if (is.character(v)) v else if (is.logical(v)) tolower(as.character(v)) else if (is.integer(v)) as.character(v) else .lba_pyfloat(v), "")
  } else if (any(kind == "f")) {
    as.numeric(unlist(vals))
  } else if (any(kind == "i")) {
    as.integer(unlist(vals))
  } else {
    as.logical(unlist(vals))
  }
  col <- rep(out[1][NA], length(values))
  col[!na] <- out
  col
}

#' sdv-py `_cast_ids_int64` on one column: to integer only when every value survives the round trip.
#' @noRd
.lba_id <- function(x) {
  if (is.integer(x)) return(x)
  ok <- !is.na(x)
  if (is.logical(x)) return(as.integer(x))
  if (is.double(x)) {
    if (all(x[ok] == trunc(x[ok]))) return(.lba_whole(x))
    return(x)
  }
  if (is.character(x)) {
    if (!all(grepl("^-?(0|[1-9][0-9]*)$", x[ok]))) return(x)
    big <- ok & abs(suppressWarnings(as.numeric(x))) > .Machine$integer.max
    if (any(big)) return(x)
    return(as.integer(x))
  }
  x
}

#' A numeric string (`"28.66"`, `"100%"`) as double; unparseable -> NA.
#' @noRd
.lba_number <- function(x) suppressWarnings(as.numeric(sub("%$", "", trimws(x))))

#' A column cast to an R type.
#' @noRd
.lba_cast <- function(x, type) {
  switch(type,
    integer = if (is.double(x)) .lba_whole(x) else suppressWarnings(as.integer(x)),
    double = as.numeric(x),
    logical = as.logical(x),
    character = as.character(x)
  )
}

#' The R type of a column without a value to go by: the schema's, else integer for an id, else character.
#' @noRd
.lba_type_for <- function(col, schema) {
  if (col %in% names(schema)) return(.LBA_RTYPE[[schema[[col]]]])
  if (grepl(.LBA_ID_COL, col)) "integer" else "character"
}

#' The rows of one route as its documented tibble (sdv-py `_frame` + `_typed` + `_finish`).
#' @noRd
.lba_frame <- function(rows, short, num = NULL) {
  schema <- .LBA_DTYPES[[short]]
  rows <- Filter(length, rows)
  if (!length(rows)) {
    return(.empty_tibble(stats::setNames(vapply(names(schema), .lba_type_for, "", schema = schema), names(schema))))
  }
  cols <- unique(unlist(lapply(rows, names), use.names = FALSE))
  out <- list()
  for (col in cols) {
    x <- .lba_column(lapply(rows, function(r) if (col %in% names(r)) r[[col]] else NA))
    if (grepl(.LBA_ID_COL, col)) x <- .lba_id(x)
    if (all(is.na(x)) && is.logical(x)) x <- .lba_cast(x, .lba_type_for(col, character()))
    if (!is.null(num) && is.character(x) && grepl(num, col, perl = TRUE)) x <- .lba_number(x)
    want <- if (col %in% names(schema)) .LBA_RTYPE[[schema[[col]]]] else NULL
    if (!is.null(want) && !identical(typeof(x), want) &&
        (all(is.na(x)) || (want == "double" && is.numeric(x)))) {
      x <- .lba_cast(x, want)
    }
    out[[col]] <- x
  }
  for (col in setdiff(names(schema), cols)) {
    out[[col]] <- .lba_cast(rep(NA, length(rows)), .LBA_RTYPE[[schema[[col]]]])
  }
  dplyr::as_tibble(out[c(names(schema), setdiff(cols, names(schema)))])
}

# ---------------------------------------------------------------------------
# Shapers
# ---------------------------------------------------------------------------

#' The home and visitor blocks of a game body: `list(side, team_id, block, ctx)` each.
#' @noRd
.lba_side_rows <- function(raw) {
  body <- .lba_obj(raw)
  match <- .lba_obj(body$match)
  ctx <- list(game_id = .lba_int(match$id), season = .lba_season(match, .lba_request_season(raw)))
  lapply(.LBA_SIDES, function(s) {
    list(side = s[[2]], team_id = .lba_int(match[[s[[3]]]]), block = .lba_obj(.lba_obj(body$scores)[[s[[1]]]]),
         ctx = ctx)
  })
}

#' The team context of a roster / team-players body.
#' @noRd
.lba_team_ctx <- function(raw) {
  team <- .lba_obj(.lba_obj(raw)$team)
  code <- team$club_code
  list(team_id = .lba_int(team$id), club_id = .lba_int(team$club_id),
       club_code = if (is.null(code) || is.list(code)) NA else code,
       season = .lba_season(team, .lba_request_season(raw)))
}

#' Shape one route's body into its rows.
#' @noRd
.lba_rows <- function(short, raw) {
  body <- .lba_obj(raw)
  req <- .lba_request_season(raw)
  switch(short,
    championships = lapply(.lba_list(body$competitions), function(c) {
      .lba_merge(list(season = .lba_season(c, req)), .lba_named(c, "championship_id"))
    }),
    calendar = {
      by_id <- function(v) if (.lba_is_dict(v)) v else list()
      referees <- by_id(body$referees)
      broadcasters <- by_id(body$broadcasters)
      lapply(.lba_list(body$matches), function(m) {
        row <- .lba_named(m, "game_id")
        key <- .lba_pystr_value(m$id)
        row[["referees"]] <- .lba_json(if (key %in% names(referees)) referees[[key]])
        row[["broadcasters"]] <- .lba_json(if (key %in% names(broadcasters)) broadcasters[[key]])
        .lba_merge(list(season = .lba_season(m, req)), row)
      })
    },
    game = {
      match <- .lba_obj(body$match)
      if (!length(match)) return(list())
      row <- .lba_named(match, "game_id")
      row[["referees"]] <- .lba_json(body$referees)
      row[["broadcasters"]] <- .lba_json(body$broadcasters)
      list(.lba_merge(list(season = .lba_season(match, req)), row))
    },
    box_score = unlist(lapply(.lba_side_rows(raw), function(s) {
      lapply(.lba_list(s$block$rows), function(p) {
        .lba_merge(c(s$ctx, list(side = s$side, team_id = s$team_id)), .lba_flat(p))
      })
    }), recursive = FALSE),
    team_box_score = unlist(lapply(.lba_side_rows(raw), function(s) {
      lines <- lapply(c("team", "totals"), function(kind) {
        line <- .lba_obj(s$block[[kind]])
        if (!length(line)) return(NULL)
        .lba_merge(c(s$ctx, list(side = s$side, team_id = s$team_id, row_type = kind)), .lba_flat(line))
      })
      Filter(Negate(is.null), lines)
    }), recursive = FALSE),
    pbp = {
      match <- .lba_obj(body$match)
      pbp <- .lba_obj(body$pbp)
      season <- .lba_season(match, req)
      home <- .lba_int(pbp$ht_id)
      visitor <- .lba_int(pbp$vt_id)
      frame <- if (is.na(season)) NA_character_ else if ((season - 1L) %in% .LBA_PIXEL_STARTS) "half_court_px" else "court_pct"
      lapply(.lba_list(pbp$actions), function(a) {
        team <- .lba_int(a$team_id)
        side <- if (is.na(team)) NA_character_ else if (!is.na(home) && team == home) "home" else if (!is.na(visitor) && team == visitor) "visitor" else NA_character_
        score <- if (is.character(a$score) && length(a$score) == 1L) {
          regmatches(a$score, regexec("^\\s*([0-9]+)\\s*-\\s*([0-9]+)\\s*$", a$score, perl = TRUE))[[1]]
        } else {
          character()
        }
        .lba_merge(list(
          game_id = .lba_int(match$id), season = season, home_team_id = home, visitor_team_id = visitor,
          team_side = side,
          home_score = if (length(score) == 3L) as.integer(score[[2]]) else NA_integer_,
          visitor_score = if (length(score) == 3L) as.integer(score[[3]]) else NA_integer_,
          coord_frame = frame
        ), .lba_flat(a))
      })
    },
    pbp_legend = {
      legend <- .lba_obj(body$legend)
      keep <- grepl("^[0-9]+$", names(legend)) & vapply(legend, function(v) is.character(v) && length(v) == 1L, logical(1))
      Map(function(k, v) list(code = as.integer(k), label = v), names(legend)[keep], legend[keep])
    },
    shots = {
      shots <- .lba_obj(body$shots)
      match <- .lba_obj(body$match)
      ctx <- list(game_id = .lba_int(match$id), season = .lba_season(match, req))
      unlist(lapply(.LBA_SIDES, function(s) {
        zones <- .lba_obj(shots[[s[[1]]]])
        rows <- lapply(seq_along(zones), function(i) {
          zone <- names(zones)[[i]]
          cell <- zones[[i]]
          if (!grepl("^[0-9]+$", zone) || !.lba_is_dict(cell)) return(NULL)
          num <- if (is.character(cell$num) && length(cell$num) == 1L) cell$num else ""
          hit <- regmatches(num, regexec("^\\s*([0-9]+)\\s*/\\s*([0-9]+)\\s*$", num, perl = TRUE))[[1]]
          .lba_merge(c(ctx, list(
            side = s[[2]], team_id = .lba_int(match[[s[[3]]]]), zone = as.integer(zone),
            made = if (length(hit) == 3L) as.integer(hit[[2]]) else NA_integer_,
            attempts = if (length(hit) == 3L) as.integer(hit[[3]]) else NA_integer_
          )), .lba_flat(cell))
        })
        Filter(Negate(is.null), rows)
      }), recursive = FALSE)
    },
    standings = lapply(.lba_list(body$standings), function(s) {
      .lba_merge(list(season = .lba_season(s, req)), .lba_named(s, "standing_id", c(season = "season_start_year")))
    }),
    teams = lapply(.lba_list(body$teams), function(t) {
      .lba_merge(list(season = .lba_season(t, req)), .lba_named(t, "team_id"))
    }),
    roster = {
      ctx <- .lba_team_ctx(raw)
      lapply(.lba_list(body$players), function(p) .lba_merge(ctx, .lba_named(p, "player_id")))
    },
    roster_coach = {
      coach <- .lba_obj(body$coach)
      if (!length(coach)) list() else list(.lba_merge(.lba_team_ctx(raw), .lba_named(coach, "coach_id")))
    },
    team_players_stats = {
      ctx <- .lba_team_ctx(raw)
      lapply(.lba_list(body$players), function(p) .lba_merge(ctx, .lba_flat(p)))
    },
    players = lapply(.lba_list(body$players), function(p) {
      .lba_merge(list(season = .lba_season(p, req)), .lba_named(p, "player_id"))
    }),
    player = {
      player <- .lba_obj(body$player)
      if (!length(player)) return(list())
      list(.lba_merge(.lba_named(player, "player_id"), .lba_flat(.lba_obj(body$stats), "stats_")))
    },
    player_stats = {
      pid <- .lba_int(.lba_obj(body$player)$id)
      data <- .lba_obj(.lba_obj(body$stats)$data)
      unlist(lapply(c("avg", "max", "sum"), function(st) {
        lapply(.lba_list(data[[st]]), function(r) {
          .lba_merge(list(player_id = pid, stat_type = st, season = .lba_season(r)), .lba_flat(r))
        })
      }), recursive = FALSE)
    },
    game_log = lapply(.lba_list(.lba_obj(body$matches_stats)$data), function(g) {
      code <- g$player_team_code
      head <- if (is.character(code) && length(code) == 1L) strsplit(code, "|", fixed = TRUE)[[1]][1] else NA
      start <- if (!is.na(head) && grepl("^[0-9]+$", head)) as.integer(head) else NA_integer_
      season <- if (!is.na(req)) req else start + 1L
      .lba_merge(list(season = season), .lba_named(g, "stat_line_id"))
    }),
    players_leaderboard = ,
    teams_leaderboard = lapply(.lba_list(body$stats), function(s) {
      .lba_merge(list(season = .lba_season(s, req)), .lba_flat(s))
    })
  )
}

#' Parse one route's body into its documented tibble.
#' @noRd
.lba_parse <- function(short, raw) {
  num <- switch(short,
    standings = .LBA_NUM$standings,
    player = .LBA_NUM$player,
    players_leaderboard = ,
    teams_leaderboard = .LBA_NUM$leaderboard,
    NULL
  )
  .lba_frame(unname(.lba_rows(short, raw) %||% list()), short, num)
}
