# acb_parsers.R -- the ACB (Liga Endesa) frames, at parity with sportsdataverse-py
# sportsdataverse/basketball/acb/acb_parsers.py (origin/main e3d232ebc9).
#
# Table-driven like sportsdataverse-py: each frame's columns, types and source paths are `.acb_fields` (R/acb_schema.R);
# an extractor yields (record, derived columns) pairs; `.acb_emit()` reads the source paths from the
# record, casts them by type letter, overlays the derived columns and builds the frame with exactly the
# documented columns and types. Dtypes are pinned by column name, never sampled: ids and counts integer,
# rates / averages / per-40 / percentages double, flags logical, instants POSIXct UTC, birth dates Date;
# shirt numbers stay strings ("0" and "00" differ). An empty or unrecognised body is a zero-row frame,
# never an error (the runtime refuses bad bodies before parsing).

.ACB_SIDES <- c("home", "away")

# ---------------------------------------------------------------------------
# Casts of one JSON value (NULL, a length-1 atomic, or a list)
# ---------------------------------------------------------------------------

#' @noRd
.acb_atom <- function(v) !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)

#' An id / count from an integer, a whole double or a digit string (sportsdataverse-py `_i`); never a float string.
#' @noRd
.acb_i <- function(v) {
  if (!.acb_atom(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) {
    return(if (is.finite(v) && v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_)
  }
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+\\s*$", v, perl = TRUE)) {
    return(suppressWarnings(as.integer(trimws(v))))
  }
  NA_integer_
}

#' A number from a number or a numeric string, decimal comma accepted (sportsdataverse-py `_f`).
#' @noRd
.acb_f <- function(v) {
  if (!.acb_atom(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+(?:[.,][0-9]+)?\\s*$", v, perl = TRUE)) {
    return(as.double(sub(",", ".", trimws(v), fixed = TRUE)))
  }
  NA_real_
}

#' Python's `str()` of a float: the shortest of 15 / 16 / 17 significant digits that round-trips.
#' @noRd
.acb_num_str <- function(v) {
  if (v == trunc(v)) return(format(v, scientific = FALSE, trim = TRUE))
  for (d in 15:17) {
    s <- formatC(v, digits = d, format = "g")
    if (as.double(s) == v) return(s)
  }
  s
}

#' A stripped non-empty string (numbers stringified, never "123.0"; containers are not) (sportsdataverse-py `_s`).
#' @noRd
.acb_s <- function(v) {
  if (!.acb_atom(v)) return(NA_character_)
  t <- if (is.logical(v)) {
    if (v) "True" else "False"
  } else if (is.double(v)) {
    if (!is.finite(v)) return(NA_character_)
    .acb_num_str(v)
  } else {
    as.character(v)
  }
  t <- stringi::stri_trim_both(t)
  if (nzchar(t)) t else NA_character_
}

#' @noRd
.acb_b <- function(v) if (.acb_atom(v) && is.logical(v)) v else NA

#' An ISO 8601 instant ('2026-10-11T17:00:00Z', or a bare date) -> seconds since the epoch, UTC wall time
#' (sportsdataverse-py `_utc`: the `Z` is dropped and an offset is ignored, never applied).
#' @noRd
.acb_utc <- function(v) {
  if (!(.acb_atom(v) && is.character(v))) return(NA_real_)
  t <- gsub("Z", "", trimws(v), fixed = TRUE)
  m <- regmatches(t, regexec(paste0(
    "^([0-9]{4})-([0-9]{2})-([0-9]{2})(?:[T ]([0-9]{2})(?::([0-9]{2})(?::([0-9]{2})(?:[.,]([0-9]{1,6}))?)?)?)?",
    "(?:[+-][0-9]{2}(?::?[0-9]{2})?)?$"
  ), t, perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  num <- function(x, d = 0) if (nzchar(x)) as.integer(x) else d
  day <- as.Date(sprintf("%s-%s-%s", m[2], m[3], m[4]), format = "%Y-%m-%d", optional = TRUE)
  hh <- num(m[5])
  mi <- num(m[6])
  ss <- num(m[7])
  if (is.na(day) || hh > 23 || mi > 59 || ss > 59) return(NA_real_)
  frac <- if (nzchar(m[8])) as.integer(m[8]) / 10^nchar(m[8]) else 0
  as.double(day) * 86400 + hh * 3600 + mi * 60 + ss + frac
}

#' 'DD-MM-YYYY' -> days since the epoch (sportsdataverse-py `_dmy`).
#' @noRd
.acb_dmy <- function(v) {
  if (!(.acb_atom(v) && is.character(v))) return(NA_real_)
  m <- regmatches(v, regexec("^\\s*([0-9]{2})-([0-9]{2})-([0-9]{4})\\s*$", v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  as.double(as.Date(sprintf("%s-%s-%s", m[4], m[3], m[2]), format = "%Y-%m-%d", optional = TRUE))
}

#' 'mm:ss' -> seconds; minutes may exceed 59 ('8665:53') (sportsdataverse-py `_mmss`).
#' @noRd
.acb_mmss <- function(v) {
  if (!(.acb_atom(v) && is.character(v))) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*([0-9]+):([0-9]{2})\\s*$", v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_integer_)
  as.integer(as.numeric(m[2]) * 60 + as.numeric(m[3]))
}

#' A display value ('79,17%', '35') -> a number; an 'a/b' ratio or text -> NA (sportsdataverse-py `_pct`).
#' @noRd
.acb_pct <- function(v) {
  if (.acb_atom(v) && is.numeric(v)) return(as.double(v))
  if (!(.acb_atom(v) && is.character(v))) return(NA_real_)
  m <- regmatches(v, regexec("^\\s*([+-]?[0-9]+(?:[.,][0-9]+)?)\\s*%?\\s*$", v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  as.double(sub(",", ".", m[2], fixed = TRUE))
}

#' A list of strings joined with '; ' (sportsdataverse-py `_join`).
#' @noRd
.acb_join <- function(v) {
  if (!.acb_is_array(v)) return(NA_character_)
  out <- vapply(v, .acb_s, character(1))
  out <- out[!is.na(out)]
  if (length(out)) paste(out, collapse = "; ") else NA_character_
}

#' @noRd
.acb_cast <- function(type, v) {
  switch(type,
    i = .acb_i(v), f = .acb_f(v), s = .acb_s(v), b = .acb_b(v), t = .acb_utc(v), d = .acb_dmy(v),
    m = .acb_mmss(v), p = .acb_pct(v), j = .acb_join(v)
  )
}

# ---------------------------------------------------------------------------
# Walking the body
# ---------------------------------------------------------------------------

#' @noRd
.acb_dig <- function(d, path) {
  for (k in strsplit(path, ".", fixed = TRUE)[[1]]) {
    if (!.acb_is_dict(d)) return(NULL)
    d <- d[[k]]
  }
  d
}
#' @noRd
.acb_lst <- function(v) if (.acb_is_array(v)) v else list()
#' @noRd
.acb_dct <- function(v) if (.acb_is_dict(v)) v else stats::setNames(list(), character())
#' @noRd
.acb_items <- function(v) .acb_dct(v)
#' @noRd
.acb_season <- function(edition) if (is.na(edition)) NA_integer_ else edition + .ACB_EDITION_OFFSET
#' @noRd
.acb_clock <- function(rec, minute = "minute", second = "second") {
  m <- .acb_i(rec[[minute]])
  s <- .acb_i(rec[[second]])
  if (is.na(m) || is.na(s)) NA_integer_ else m * 60L + s
}
#' @noRd
.acb_code <- function(table, key) if (is.na(key)) NA_character_ else unname(table[as.character(key)])
#' @noRd
.acb_iso <- function(name) if (is.na(name)) NA_character_ else unname(.acb_country_iso[name])
#' @noRd
.acb_side <- function(idx) if (idx <= 2L) .ACB_SIDES[[idx]] else NA_character_
#' @noRd
.acb_pair <- function(rec, ctx = list()) list(rec = rec, ctx = ctx)

#' `raw` when it is a dict holding a non-empty value under one of `keys` (sportsdataverse-py `_body`).
#' @noRd
.acb_has <- function(raw, ...) {
  .acb_is_dict(raw) && any(vapply(c(...), function(k) {
    v <- raw[[k]]
    !is.null(v) && !(is.list(v) && !length(v))
  }, logical(1)))
}

#' @noRd
.acb_req <- function(raw) .acb_dct(.acb_dct(raw)[["_request"]])
#' @noRd
.acb_match_ctx <- function(raw) list(match_id = .acb_i(.acb_req(raw)[["match_id"]]))
#' @noRd
.acb_ed_ctx <- function(edition) list(edition_id = edition, season = .acb_season(edition))
#' @noRd
.acb_team_ctx <- function(team, prefix = "") {
  t <- .acb_dct(team)
  stats::setNames(
    list(.acb_i(t[["id"]]), .acb_i(t[["clubId"]]), .acb_s(t[["fullName"]]), .acb_s(t[["abbreviatedName"]])),
    paste0(prefix, c("team_id", "club_id", "team", "team_abbr"))
  )
}
#' @noRd
.acb_home_edition <- function(raw, paths = "homeTeam.editionId") {
  for (p in paths) {
    e <- .acb_i(.acb_dig(raw, p))
    if (!is.na(e)) return(e)
  }
  NA_integer_
}

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' One column from the row values (`NULL` / NA -> NA), typed by its letter.
#' @noRd
.acb_column <- function(vals, type) {
  n <- length(vals)
  ok <- vapply(vals, .acb_atom, logical(1))
  fill <- function(proto, conv) {
    out <- rep(proto, n)
    if (any(ok)) out[ok] <- conv(unlist(vals[ok], use.names = FALSE))
    out
  }
  switch(type,
    i = , m = fill(NA_integer_, as.integer),
    f = , p = fill(NA_real_, as.double),
    s = , j = fill(NA_character_, as.character),
    b = fill(NA, as.logical),
    t = as.POSIXct(fill(NA_real_, as.double), tz = "UTC", origin = "1970-01-01"),
    d = as.Date(fill(NA_real_, as.double), origin = "1970-01-01")
  )
}

#' Build the `short` frame from (record, derived columns) pairs (sportsdataverse-py `_emit` + `_frame`).
#' @noRd
.acb_emit <- function(short, pairs) {
  ft <- .acb_fields[[short]]
  src <- which(!is.na(ft$path))
  rows <- tryCatch(lapply(pairs, function(p) {
    row <- list()
    for (j in src) row[ft$col[[j]]] <- list(.acb_cast(ft$type[[j]], .acb_dig(p$rec, ft$path[[j]])))
    for (n in names(p$ctx)) row[n] <- list(p$ctx[[n]])
    row
  }), error = function(e) list())
  cols <- lapply(seq_along(ft$col), function(j) {
    .acb_column(lapply(rows, function(r) r[[ft$col[[j]]]]), ft$type[[j]])
  })
  names(cols) <- ft$col
  dplyr::as_tibble(cols)
}

#' Parse a stamped body into the `short` frame; an odd body is a zero-row frame, never an error.
#' @noRd
.acb_parse <- function(short, raw) {
  pairs <- tryCatch(.ACB_EXTRACT[[short]](raw), error = function(e) list())
  .acb_emit(short, pairs)
}

#' @noRd
.acb_out <- function(short, raw, type) make_hoopR_data(.acb_parse(short, raw), type, Sys.time())

# ---------------------------------------------------------------------------
# Extractors: body -> list of (record, derived columns)
# ---------------------------------------------------------------------------

#' @noRd
.acb_x_match_header <- function(raw) {
  if (!.acb_has(raw, "teams", "quarterScores")) return(list())
  list(.acb_pair(raw, .acb_ed_ctx(.acb_i(.acb_dig(raw, "teams.home.editionId")))))
}

#' @noRd
.acb_x_period_scores <- function(raw) {
  if (!.acb_has(raw, "quarterScores")) return(list())
  lapply(.acb_lst(raw[["quarterScores"]]), function(q) .acb_pair(.acb_dct(q), .acb_match_ctx(raw)))
}

#' (side, team boxscore, team) of each `teamBoxscores[]` entry.
#' @noRd
.acb_box_teams <- function(raw) {
  tbs <- .acb_lst(.acb_dct(raw)[["teamBoxscores"]])
  lapply(seq_along(tbs), function(i) {
    tb <- .acb_dct(tbs[[i]])
    list(side = .acb_side(i), tb = tb, team = .acb_dct(tb[["team"]]))
  })
}

#' @noRd
.acb_box_ctx <- function(raw, bt) {
  c(.acb_match_ctx(raw), .acb_ed_ctx(.acb_i(bt$team[["editionId"]])), list(team_side = bt$side),
    .acb_team_ctx(bt$team))
}

#' @noRd
.acb_x_player_box <- function(raw) {
  out <- list()
  for (bt in .acb_box_teams(raw)) {
    ctx0 <- .acb_box_ctx(raw, bt)
    for (per in .acb_lst(bt$tb[["statsByPeriods"]])) {
      per <- .acb_dct(per)
      for (p in .acb_lst(.acb_dct(per[["stats"]])[["players"]])) {
        out[[length(out) + 1L]] <- .acb_pair(.acb_dct(p), c(ctx0, list(quarter = .acb_i(per[["quarter"]]))))
      }
    }
  }
  out
}

#' @noRd
.acb_x_team_box <- function(raw) {
  out <- list()
  for (bt in .acb_box_teams(raw)) {
    ctx0 <- .acb_box_ctx(raw, bt)
    for (per in .acb_lst(bt$tb[["statsByPeriods"]])) {
      per <- .acb_dct(per)
      for (scope in c("total", "team")) {
        block <- .acb_dct(per[["stats"]])[[scope]]
        if (.acb_is_dict(block)) {
          out[[length(out) + 1L]] <- .acb_pair(block, c(ctx0, list(quarter = .acb_i(per[["quarter"]]), scope = scope)))
        }
      }
    }
  }
  out
}

#' @noRd
.acb_x_box_info <- function(raw) {
  lapply(.acb_box_teams(raw), function(bt) {
    .acb_pair(bt$tb, c(.acb_box_ctx(raw, bt), list(
      arena = .acb_s(raw[["arena"]]), attendance = .acb_i(raw[["attendance"]]), referees = .acb_join(raw[["referees"]])
    )))
  })
}

#' @noRd
.acb_x_pbp <- function(raw) {
  if (!.acb_has(raw, "plays")) return(list())
  ed <- .acb_ed_ctx(.acb_home_edition(raw, c("homeTeam.editionId", "awayTeam.editionId")))
  plays <- .acb_lst(raw[["plays"]])
  lapply(seq_along(plays), function(n) {
    p <- .acb_dct(plays[[n]])
    pt <- .acb_i(p[["playType"]])
    tag <- .acb_i(p[["playTag"]])
    .acb_pair(p, c(.acb_match_ctx(raw), ed, list(
      play_index = n, clock_seconds = .acb_clock(p), play_name = .acb_code(.acb_play_types, pt),
      turnover_type = .acb_code(.acb_play_tags, tag)
    )))
  })
}

#' Match ids from 2020-21 on (about 100000+) use the millimetre shot grid; older ids a 0-100 grid.
#' @noRd
.ACB_NEW_MATCH_ID <- 50000L

#' @noRd
.acb_x_shots <- function(raw) {
  if (!.acb_has(raw, "shotPoints")) return(list())
  ed <- .acb_ed_ctx(.acb_home_edition(raw, c("homeTeam.editionId", "awayTeam.editionId")))
  mctx <- .acb_match_ctx(raw)
  mid <- mctx$match_id
  names_by <- list()
  for (key in c("homePlayerStats", "awayPlayerStats")) {
    for (ps in .acb_lst(raw[[key]])) {
      ps <- .acb_dct(ps)
      pid <- .acb_i(ps[["playerLicenseId"]])
      if (!is.na(pid)) names_by[[as.character(pid)]] <- c(.acb_s(ps[["playerName"]]), .acb_s(ps[["playerNumber"]]))
    }
  }
  system <- if (is.na(mid)) NA_character_ else if (mid >= .ACB_NEW_MATCH_ID) "mm" else "grid"
  lapply(.acb_lst(raw[["shotPoints"]]), function(sh) {
    sh <- .acb_dct(sh)
    pt <- .acb_i(sh[["playType"]])
    pid <- .acb_i(sh[["playerLicenseId"]])
    x <- .acb_i(sh[["posX"]])
    y <- .acb_i(sh[["posY"]])
    basket <- identical(system, "mm") && !(pt %in% c(92L, 96L))
    who <- if (is.na(pid)) NULL else names_by[[as.character(pid)]]
    .acb_pair(sh, c(mctx, ed, list(
      coord_system = system,
      x_basket_m = if (basket && !is.na(x)) x / 1000 else NA_real_,
      y_basket_m = if (basket && !is.na(y)) y / 1000 else NA_real_,
      clock_seconds = .acb_clock(sh), play_name = .acb_code(.acb_play_types, pt),
      player_name = if (is.null(who)) NA_character_ else who[[1]],
      shirt_number = if (is.null(who)) NA_character_ else who[[2]]
    )))
  })
}

#' @noRd
.acb_x_lead_tracker <- function(raw) {
  if (!.acb_has(raw, "leadTrackerInfo")) return(list())
  ed <- .acb_ed_ctx(.acb_home_edition(raw, c("homeTeam.editionId", "awayTeam.editionId")))
  lapply(.acb_lst(raw[["leadTrackerInfo"]]), function(r) {
    r <- .acb_dct(r)
    h <- .acb_i(r[["home"]])
    a <- .acb_i(r[["away"]])
    .acb_pair(r, c(.acb_match_ctx(raw), ed, list(clock_seconds = .acb_clock(r), margin = h - a)))
  })
}

#' @noRd
.acb_x_lead_stats <- function(raw) {
  out <- list()
  stats <- .acb_items(.acb_dct(raw)[["stats"]])
  for (stat in names(stats)) {
    sides <- .acb_dct(stats[[stat]])
    for (side in .ACB_SIDES) {
      if (.acb_is_dict(sides[[side]])) {
        out[[length(out) + 1L]] <- .acb_pair(sides[[side]],
                                             c(.acb_match_ctx(raw), list(stat = .intl_clean_names(stat), side = side)))
      }
    }
  }
  out
}

#' Per-team blocks of `key` (`teamLineUps`, `teamLeaders`) with the team context.
#' @noRd
.acb_team_blocks <- function(raw, key) {
  blocks <- .acb_lst(.acb_dct(raw)[[key]])
  lapply(seq_along(blocks), function(i) {
    tl <- .acb_dct(blocks[[i]])
    team <- .acb_dct(tl[["team"]])
    list(tl = tl, ctx = c(.acb_match_ctx(raw), .acb_ed_ctx(.acb_i(team[["editionId"]])),
                          list(team_side = .acb_side(i)), .acb_team_ctx(team)))
  })
}

#' @noRd
.acb_x_lineup <- function(raw) {
  out <- list()
  for (b in .acb_team_blocks(raw, "teamLineUps")) {
    players <- .acb_lst(b$tl[["players"]])
    for (n in seq_along(players)) {
      out[[length(out) + 1L]] <- .acb_pair(.acb_dct(players[[n]]), c(b$ctx, list(lineup_order = n)))
    }
  }
  out
}

#' @noRd
.acb_ranked <- function(block, ctx) {
  out <- list()
  block <- .acb_items(block)
  for (metric in names(block)) {
    rows <- .acb_lst(block[[metric]])
    for (rank in seq_along(rows)) {
      out[[length(out) + 1L]] <- .acb_pair(.acb_dct(rows[[rank]]),
                                           c(ctx, list(metric = .intl_clean_names(metric), rank = rank)))
    }
  }
  out
}

#' @noRd
.acb_x_leaders <- function(raw) {
  unlist(lapply(.acb_team_blocks(raw, "teamLeaders"), function(b) .acb_ranked(b$tl[["leaders"]], b$ctx)),
         recursive = FALSE) %||% list()
}

#' Made (k = 1) or attempted (k = 2) from a bar subtitle such as '19/24'.
#' @noRd
.acb_made <- function(side, k) {
  sub_ <- side[["subtitle"]]
  if (!(.acb_atom(sub_) && is.character(sub_))) return(NA_integer_)
  m <- regmatches(sub_, regexec("^\\s*([0-9]+)/([0-9]+)\\s*$", sub_, perl = TRUE))[[1]]
  if (length(m)) as.integer(m[[k + 1L]]) else NA_integer_
}

#' @noRd
.acb_x_team_comparison <- function(raw) {
  out <- list()
  for (q in .acb_lst(.acb_dct(raw)[["statsPerQuarters"]])) {
    q <- .acb_dct(q)
    stats <- .acb_items(q[["statsPerQuarters"]])
    for (stat in names(stats)) {
      sides <- .acb_dct(stats[[stat]])
      home <- .acb_dct(sides[["home"]])
      away <- .acb_dct(sides[["away"]])
      out[[length(out) + 1L]] <- .acb_pair(list(), c(.acb_match_ctx(raw), list(
        quarter = .acb_i(q[["quarter"]]), stat = .intl_clean_names(stat),
        home_value = .acb_pct(home[["title"]]), away_value = .acb_pct(away[["title"]]),
        home_made = .acb_made(home, 1L), home_attempted = .acb_made(home, 2L),
        away_made = .acb_made(away, 1L), away_attempted = .acb_made(away, 2L),
        home_is_highlighted = .acb_b(home[["isBarHighLighted"]]),
        away_is_highlighted = .acb_b(away[["isBarHighLighted"]])
      )))
    }
  }
  out
}

#' @noRd
.acb_series_ctx <- function(s) {
  c(list(
    phase_id = .acb_i(s[["phaseId"]]), subphase_id = .acb_i(s[["subphaseId"]]),
    series_home_team_id = .acb_i(.acb_dig(s, "homeTeam.id")),
    series_home_club_id = .acb_i(.acb_dig(s, "homeTeam.clubId")),
    series_away_team_id = .acb_i(.acb_dig(s, "awayTeam.id")),
    series_away_club_id = .acb_i(.acb_dig(s, "awayTeam.clubId")),
    series_home_wins = .acb_i(s[["homeScore"]]), series_away_wins = .acb_i(s[["awayScore"]]),
    series_finished = .acb_b(s[["finished"]]), best_of = .acb_i(s[["bestOf"]])
  ), .acb_ed_ctx(.acb_i(.acb_dig(s, "homeTeam.editionId"))))
}

#' @noRd
.acb_x_serie <- function(raw) {
  if (!.acb_has(raw, "matches")) return(list())
  ctx <- c(list(requested_match_id = .acb_match_ctx(raw)$match_id), .acb_series_ctx(raw))
  lapply(.acb_lst(raw[["matches"]]), function(g) .acb_pair(.acb_dct(g), ctx))
}

#' (stage, series) of a bracket, in stage order.
#' @noRd
.acb_series_list <- function(raw) {
  stages <- c(quarterFinals = "quarter_finals", semifinals = "semifinals", final = "final",
              otherPositions = "other_positions")
  data <- .acb_dct(.acb_dct(raw)[["data"]])
  out <- list()
  for (key in names(stages)) {
    for (s in .acb_lst(.acb_dct(data[[key]])[["series"]])) {
      if (.acb_is_dict(s)) out[[length(out) + 1L]] <- list(stage = stages[[key]], s = s)
    }
  }
  out
}

#' @noRd
.acb_x_bracket <- function(raw) {
  lapply(.acb_series_list(raw), function(x) {
    .acb_pair(x$s, list(stage = x$stage, n_games = length(.acb_lst(x$s[["matches"]])),
                        season = .acb_season(.acb_i(.acb_dig(x$s, "homeTeam.editionId")))))
  })
}

#' @noRd
.acb_x_bracket_games <- function(raw) {
  out <- list()
  for (x in .acb_series_list(raw)) {
    ctx <- c(list(stage = x$stage), .acb_series_ctx(x$s))
    for (g in .acb_lst(x$s[["matches"]])) out[[length(out) + 1L]] <- .acb_pair(.acb_dct(g), ctx)
  }
  out
}

#' @noRd
.acb_x_quickfacts <- function(raw) {
  facts <- .acb_lst(.acb_dct(raw)[["facts"]])
  lapply(seq_along(facts), function(i) {
    f <- .acb_dct(facts[[i]])
    .acb_pair(f, c(.acb_match_ctx(raw), list(team_side = .acb_side(i),
                                             season = .acb_season(.acb_i(.acb_dig(f, "team.editionId"))))))
  })
}

#' (group, stat, leaf) of an advanced-stats block.
#' @noRd
.acb_adv_leaves <- function(block) {
  out <- list()
  block <- .acb_items(block)
  for (group in names(block)) {
    stats <- .acb_items(block[[group]])
    for (stat in names(stats)) {
      if (.acb_is_dict(stats[[stat]])) {
        out[[length(out) + 1L]] <- list(group = .intl_clean_names(group), stat = .intl_clean_names(stat),
                                        leaf = stats[[stat]])
      }
    }
  }
  out
}

#' @noRd
.acb_x_match_advanced_stats <- function(raw) {
  out <- list()
  for (side in .ACB_SIDES) {
    team <- .acb_dct(.acb_dct(raw)[[paste0(side, "Team")]])
    for (x in .acb_adv_leaves(.acb_dct(raw)[[paste0(side, "AdvancedStats")]])) {
      out[[length(out) + 1L]] <- .acb_pair(x$leaf, c(
        .acb_match_ctx(raw), .acb_ed_ctx(.acb_i(team[["editionId"]])), list(team_side = side),
        .acb_team_ctx(team), list(group = x$group, stat = x$stat)
      ))
    }
  }
  out
}

#' @noRd
.acb_x_player_advanced_stats <- function(raw) {
  req <- .acb_req(raw)
  body <- .acb_dct(raw)
  body <- body[names(body) != "_request"]
  lapply(.acb_adv_leaves(body), function(x) {
    .acb_pair(x$leaf, c(.acb_match_ctx(raw), list(player_id = .acb_i(req[["player_id"]]), group = x$group,
                                                  stat = x$stat)))
  })
}

#' @noRd
.acb_rich_matches <- function(rows, extra = list()) {
  lapply(.acb_lst(rows), function(m) {
    m <- .acb_dct(m)
    .acb_pair(m, c(list(season = .acb_season(.acb_i(.acb_dig(m, "homeTeam.editionId")))), extra))
  })
}

#' @noRd
.acb_x_matchlist <- function(raw) {
  .acb_rich_matches(.acb_dct(raw)[["matches"]], list(match_grouping = .acb_s(.acb_dct(raw)[["matchGrouping"]])))
}

#' @noRd
.acb_x_matches_plain <- function(raw) .acb_rich_matches(.acb_dct(raw)[["matches"]])

#' @noRd
.acb_x_competition_editions <- function(raw) {
  out <- list()
  for (cp in .acb_lst(.acb_dct(raw)[["competitions"]])) {
    cp <- .acb_dct(cp)
    for (e in .acb_lst(cp[["editions"]])) {
      e <- .acb_dct(e)
      out[[length(out) + 1L]] <- .acb_pair(e, list(
        competition_id = .acb_i(cp[["id"]]), competition_name = .acb_s(cp[["name"]]),
        n_rounds = length(.acb_lst(e[["rounds"]])), n_weeks = length(.acb_lst(e[["weeks"]]))
      ))
    }
  }
  out
}

#' @noRd
.acb_x_competition_sub <- function(key) {
  function(raw) {
    out <- list()
    for (cp in .acb_lst(.acb_dct(raw)[["competitions"]])) {
      cp <- .acb_dct(cp)
      for (e in .acb_lst(cp[["editions"]])) {
        e <- .acb_dct(e)
        ctx <- list(competition_id = .acb_i(cp[["id"]]), edition_id = .acb_i(e[["id"]]),
                    season = .acb_i(e[["seasonEndYear"]]))
        for (r in .acb_lst(e[[key]])) out[[length(out) + 1L]] <- .acb_pair(.acb_dct(r), ctx)
      }
    }
    out
  }
}

#' @noRd
.acb_x_competition_current <- function(raw) {
  if (!.acb_has(raw, "currentCompetitionId", "competitions")) return(list())
  list(.acb_pair(raw, list(season = .acb_season(.acb_i(raw[["currentEditionId"]])))))
}

#' Season-team id -> team record of `teams[]` (later duplicates win).
#' @noRd
.acb_team_index <- function(raw) {
  out <- list()
  for (t in .acb_lst(raw[["teams"]])) {
    tid <- .acb_i(.acb_dct(t)[["id"]])
    if (!is.na(tid)) out[[as.character(tid)]] <- .acb_dct(t)
  }
  out
}

#' @noRd
.acb_team_lookup <- function(teams, id) {
  if (is.na(id) || id == 0L) return(list())
  teams[[as.character(id)]] %||% list()
}

#' @noRd
.acb_lookup_ctx <- function(game, teams) {
  out <- list()
  for (side in .ACB_SIDES) {
    t <- .acb_team_lookup(teams, .acb_i(game[[paste0(side, "TeamId")]]))
    out[[paste0(side, "_club_id")]] <- .acb_i(t[["clubId"]])
    out[[paste0(side, "_team")]] <- .acb_s(t[["fullName"]])
    out[[paste0(side, "_team_abbr")]] <- .acb_s(t[["abbreviatedName"]])
  }
  out
}

#' @noRd
.acb_broadcasters <- function(game) {
  .acb_join(lapply(.acb_lst(game[["broadcastChannels"]]), function(b) .acb_dct(b)[["broadcaster"]]))
}

#' @noRd
.acb_x_round_matches <- function(raw) {
  if (!.acb_has(raw, "matches")) return(list())
  teams <- .acb_team_index(raw)
  sel <- .acb_dct(raw[["selectedFilters"]])
  rid <- .acb_i(sel[["round"]])
  rounds <- list()
  for (r in .acb_lst(.acb_dct(raw[["availableFilters"]])[["rounds"]])) {
    rounds[[as.character(.acb_i(.acb_dct(r)[["id"]]))]] <- .acb_dct(r)
  }
  rnd <- .acb_dct(rounds[[as.character(rid)]])
  lapply(.acb_lst(raw[["matches"]]), function(g) {
    g <- .acb_dct(g)
    .acb_pair(g, c(
      list(competition_id = .acb_i(sel[["competition"]])), .acb_ed_ctx(.acb_i(sel[["season"]])),
      list(round_id = rid, round_number = .acb_i(rnd[["roundNumber"]]), subphase_id = .acb_i(rnd[["subphaseId"]]),
           subphase_number = .acb_i(rnd[["subphaseNumber"]]), week_id = .acb_i(sel[["week"]])),
      .acb_lookup_ctx(g, teams), list(broadcasters = .acb_broadcasters(g))
    ))
  })
}

#' @noRd
.acb_x_calendar <- function(raw) {
  if (!.acb_has(raw, "rounds")) return(list())
  teams <- .acb_team_index(raw)
  sel <- .acb_dct(raw[["selectedFilters"]])
  out <- list()
  for (r in .acb_lst(raw[["rounds"]])) {
    r <- .acb_dct(r)
    for (g in .acb_lst(r[["matches"]])) {
      g <- .acb_dct(g)
      out[[length(out) + 1L]] <- .acb_pair(g, c(
        list(competition_id = .acb_i(sel[["competition"]])), .acb_ed_ctx(.acb_i(sel[["season"]])),
        list(round_id = .acb_i(r[["id"]]), round_number = .acb_i(r[["roundNumber"]]),
             subphase_id = .acb_i(r[["subphaseId"]]), subphase_number = .acb_i(r[["subphaseNumber"]]),
             week_id = NA_integer_),
        .acb_lookup_ctx(g, teams), list(broadcasters = .acb_broadcasters(g))
      ))
    }
  }
  out
}

#' @noRd
.acb_x_standings <- function(raw) {
  if (!.acb_has(raw, "standings")) return(list())
  teams <- .acb_team_index(raw)
  sel <- .acb_dct(raw[["selectedFilters"]])
  lapply(.acb_lst(raw[["standings"]]), function(s) {
    s <- .acb_dct(s)
    t <- .acb_team_lookup(teams, .acb_i(s[["teamId"]]))
    .acb_pair(s, c(
      list(competition_id = .acb_i(sel[["competition"]])), .acb_ed_ctx(.acb_i(sel[["season"]])),
      list(round_id = .acb_i(sel[["round"]]), total_rounds = .acb_i(raw[["totalRounds"]]),
           club_id = .acb_i(t[["clubId"]]), team = .acb_s(t[["fullName"]]), team_abbr = .acb_s(t[["abbreviatedName"]]))
    ))
  })
}

#' @noRd
.acb_x_standings_rounds <- function(raw) {
  teams <- .acb_team_index(.acb_dct(raw))
  sel <- .acb_dct(.acb_dct(raw)[["selectedFilters"]])
  out <- list()
  for (s in .acb_lst(.acb_dct(raw)[["standings"]])) {
    s <- .acb_dct(s)
    tid <- .acb_i(s[["teamId"]])
    t <- .acb_team_lookup(teams, tid)
    ctx <- c(
      list(competition_id = .acb_i(sel[["competition"]])), .acb_ed_ctx(.acb_i(sel[["season"]])),
      list(team_id = tid, club_id = .acb_i(t[["clubId"]]), team = .acb_s(t[["fullName"]]),
           team_abbr = .acb_s(t[["abbreviatedName"]]))
    )
    for (r in .acb_lst(s[["rounds"]])) out[[length(out) + 1L]] <- .acb_pair(.acb_dct(r), ctx)
  }
  out
}

#' @noRd
.acb_x_league_zones <- function(raw) {
  if (!.acb_has(raw, "zones")) return(list())
  ctx <- c(list(competition_id = .acb_i(raw[["competitionId"]])), .acb_ed_ctx(.acb_i(raw[["editionId"]])),
           list(phase_id = .acb_i(raw[["phaseId"]])))
  lapply(.acb_lst(raw[["zones"]]), function(z) .acb_pair(.acb_dct(z), ctx))
}

#' @noRd
.acb_x_teams <- function(raw) {
  lapply(.acb_lst(.acb_dct(raw)[["teams"]]), function(t) {
    .acb_pair(.acb_dct(t), list(season = .acb_season(.acb_i(.acb_dig(t, "selected.editionId")))))
  })
}

#' @noRd
.acb_x_club_data <- function(raw) {
  cd <- .acb_dct(.acb_dct(raw)[["clubData"]])
  if (!length(cd)) return(list())
  list(.acb_pair(cd, list(season = .acb_season(.acb_i(.acb_dig(cd, "team.editionId"))))))
}

#' @noRd
.acb_x_current_roster <- function(raw) {
  r <- .acb_dct(raw)
  club <- .acb_i(.acb_req(raw)[["club_id"]])
  out <- list()
  for (who in list(c("player", "players", "player"), c("staff", "staff", "coach"))) {
    for (m in .acb_lst(r[[who[[2]]]])) {
      m <- .acb_dct(m)
      rec <- m
      rec[["person"]] <- .acb_dct(m[[who[[3]]]])
      out[[length(out) + 1L]] <- .acb_pair(rec, list(
        club_id = club, role = who[[1]], nationality_iso = .acb_iso(.acb_s(m[["nationalityCountry"]])),
        season = .acb_season(.acb_i(.acb_dig(m, paste0(who[[3]], ".editionId")))),
        temporary_roster = .acb_b(r[["temporaryRoster"]])
      ))
    }
  }
  out
}

#' @noRd
.acb_x_team_leaders <- function(raw) {
  req <- .acb_req(raw)
  sel <- .acb_dct(.acb_dct(raw)[["selectedFilters"]])
  ed <- .acb_i(sel[["season"]])
  out <- list()
  for (sc in list(c("all_time", "leaders"), c("edition", "seasonLeaders"))) {
    ctx <- c(list(club_id = .acb_i(req[["club_id"]]), competition_id = .acb_i(sel[["competition"]])),
             .acb_ed_ctx(ed), list(scope = sc[[1]]))
    out <- c(out, .acb_ranked(.acb_dct(raw)[[sc[[2]]]], ctx))
  }
  out
}

#' @noRd
.acb_selected_team <- function(raw) .acb_dct(.acb_dct(.acb_dct(raw)[["team"]])[["selected"]])

#' @noRd
.acb_x_team_stats <- function(raw) {
  team <- .acb_selected_team(raw)
  ctx <- c(list(club_id = .acb_i(team[["clubId"]]), team_id = .acb_i(team[["id"]])),
           .acb_ed_ctx(.acb_i(team[["editionId"]])))
  lapply(.acb_lst(.acb_dct(raw)[["players"]]), function(p) .acb_pair(.acb_dct(p), ctx))
}

#' @noRd
.acb_x_team_totals <- function(raw) {
  team <- .acb_selected_team(raw)
  tt <- .acb_dct(.acb_dct(raw)[["teamTotals"]])
  if (!length(tt)) return(list())
  list(.acb_pair(tt, c(list(club_id = .acb_i(team[["clubId"]])), .acb_ed_ctx(.acb_i(team[["editionId"]])))))
}

#' @noRd
.acb_x_team_records <- function(raw) {
  club <- .acb_i(.acb_req(raw)[["club_id"]])
  body <- .acb_items(raw)
  out <- list()
  for (stat in names(body)) {
    if (stat != "_request" && .acb_is_dict(body[[stat]])) {
      out[[length(out) + 1L]] <- .acb_pair(body[[stat]], list(club_id = club, stat = .intl_clean_names(stat)))
    }
  }
  out
}

#' @noRd
.acb_x_player_data <- function(raw) {
  pd <- .acb_dct(.acb_dct(raw)[["playerData"]])
  if (!length(pd)) return(list())
  list(.acb_pair(pd, list(
    birth_country_iso = .acb_iso(.acb_s(pd[["birthCountry"]])),
    nationality_iso = .acb_iso(.acb_s(pd[["nationality"]])),
    season = .acb_season(.acb_i(.acb_dig(pd, "player.editionId")))
  )))
}

#' @noRd
.acb_x_player_stats <- function(raw) {
  pid <- .acb_i(.acb_req(raw)[["player_id"]])
  lapply(.acb_lst(.acb_dct(raw)[["statsByTeam"]]), function(t) {
    t <- .acb_dct(t)
    .acb_pair(t, list(player_id = pid, season = .acb_season(.acb_i(t[["editionId"]]))))
  })
}

#' @noRd
.acb_x_player_totals <- function(raw) {
  pt <- .acb_dct(.acb_dct(raw)[["playerTotals"]])
  if (!length(pt)) return(list())
  list(.acb_pair(pt))
}

#' @noRd
.acb_x_career_stints <- function(raw) {
  pid <- .acb_i(.acb_req(raw)[["player_id"]])
  lapply(.acb_lst(.acb_dct(raw)[["stints"]]), function(s) {
    s <- .acb_dct(s)
    .acb_pair(s, list(player_id = pid, n_editions = length(.acb_lst(s[["editions"]]))))
  })
}

#' @noRd
.acb_x_career_trophies <- function(raw) {
  pid <- .acb_i(.acb_req(raw)[["player_id"]])
  lapply(.acb_lst(.acb_dct(raw)[["trophies"]]), function(t) .acb_pair(.acb_dct(t), list(player_id = pid)))
}

#' @noRd
.acb_x_player_matches <- function(raw) {
  pid <- .acb_i(.acb_req(raw)[["player_id"]])
  lapply(.acb_lst(.acb_dct(raw)[["matches"]]), function(m) {
    m <- .acb_dct(m)
    .acb_pair(m, list(player_id = pid, season = .acb_season(.acb_i(.acb_dig(m, "homeTeam.editionId")))))
  })
}

#' @noRd
.acb_x_search <- function(raw) {
  out <- list()
  for (kk in list(c("player", "players"), c("team", "teams"), c("coach", "coaches"))) {
    for (r in .acb_lst(.acb_dct(raw)[[kk[[2]]]])) {
      r <- .acb_dct(r)
      nm <- if (kk[[1]] == "team") .acb_s(r[["fullName"]]) else .acb_s(r[["nickname"]])
      out[[length(out) + 1L]] <- .acb_pair(r, list(kind = kk[[1]], name = nm,
                                                   season = .acb_season(.acb_i(r[["editionId"]]))))
    }
  }
  out
}

#' Frame name -> extractor (sportsdataverse-py `_EXTRACT`).
#' @noRd
.ACB_EXTRACT <- list(
  match_header = .acb_x_match_header, period_scores = .acb_x_period_scores, player_box = .acb_x_player_box,
  team_box = .acb_x_team_box, box_info = .acb_x_box_info, pbp = .acb_x_pbp, shots = .acb_x_shots,
  lead_tracker = .acb_x_lead_tracker, lead_stats = .acb_x_lead_stats, lineup = .acb_x_lineup,
  match_leaders = .acb_x_leaders, season_leaders = .acb_x_leaders, team_comparison = .acb_x_team_comparison,
  serie = .acb_x_serie, quickfacts = .acb_x_quickfacts, match_advanced_stats = .acb_x_match_advanced_stats,
  player_advanced_stats = .acb_x_player_advanced_stats, matchlist = .acb_x_matchlist,
  next_matches = .acb_x_matches_plain, team_matches = .acb_x_matches_plain,
  competition_editions = .acb_x_competition_editions, competition_rounds = .acb_x_competition_sub("rounds"),
  competition_weeks = .acb_x_competition_sub("weeks"), competition_current = .acb_x_competition_current,
  round_matches = .acb_x_round_matches, calendar = .acb_x_calendar, standings = .acb_x_standings,
  standings_rounds = .acb_x_standings_rounds, bracket = .acb_x_bracket, bracket_games = .acb_x_bracket_games,
  league_zones = .acb_x_league_zones, teams = .acb_x_teams, club_data = .acb_x_club_data,
  current_roster = .acb_x_current_roster, team_leaders = .acb_x_team_leaders, team_stats = .acb_x_team_stats,
  team_totals = .acb_x_team_totals, team_records = .acb_x_team_records, player_data = .acb_x_player_data,
  player_stats = .acb_x_player_stats, player_totals = .acb_x_player_totals,
  career_stints = .acb_x_career_stints, career_trophies = .acb_x_career_trophies,
  player_matches = .acb_x_player_matches, search = .acb_x_search
)
