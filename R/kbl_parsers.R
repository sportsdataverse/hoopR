# kbl_parsers.R -- frames of the KBL wrappers (internal; parse_* is not exported).
#
# R mirror of sdv-py sportsdataverse/basketball/kbl/kbl_parsers.py (origin/main e3d232ebc9). Every frame is built
# from `.kbl_specs` (R/kbl_tables.R): one type per column, never sampled, so an empty body is a zero-row tibble
# with the documented columns. Ids: gmkey / glkey / team_code / pcode are character (team_code keeps its leading
# zero), season / season_code / game_no integer. Dates are `Date` (KST calendar dates, `YYYYMMDD` on the wire);
# game_start / game_end stay `HHMM` strings. Percentages are 0-100.

# --- value coercion (the boundary: one type per column) ----------------------------------------------------------

#' @noRd
.kbl_scalar <- function(v) is.atomic(v) && length(v) == 1L && !is.na(v)

#' A string as sent; an integer becomes its decimal text; a double or a logical (never an id) is refused.
#' @noRd
.kbl_s <- function(v) {
  if (!.kbl_scalar(v)) return(NA_character_)
  if (is.character(v)) v else if (is.integer(v)) as.character(v) else NA_character_
}

#' @noRd
.kbl_i <- function(v) {
  if (!.kbl_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.character(v)) {
    if (!grepl("^\\s*-?[0-9]+\\s*$", v, perl = TRUE)) return(NA_integer_)
    v <- as.numeric(v)
  }
  if (is.double(v) && is.finite(v) && v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_
}

#' @noRd
.kbl_f <- function(v) {
  if (!.kbl_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v)) return(suppressWarnings(as.numeric(trimws(v))))
  NA_real_
}

#' @noRd
.kbl_b <- function(v) {
  if (!.kbl_scalar(v)) return(NA)
  if (is.logical(v)) v else if (is.integer(v) && v %in% c(0L, 1L)) v == 1L else NA
}

#' A `YYYYMMDD` date as days since the epoch.
#' @noRd
.kbl_d <- function(v) {
  if (!(.kbl_scalar(v) && is.character(v) && grepl("^[0-9]{8}$", v))) return(NA_real_)
  as.double(as.Date(v, format = "%Y%m%d"))
}

#' Python `json.dumps(list_of_strings, ensure_ascii=False)`, NULL for an empty list.
#' @noRd
.kbl_json <- function(x) {
  if (!length(x)) return(NULL)
  paste0("[", paste(vapply(x, function(s) as.character(jsonlite::toJSON(s, auto_unbox = TRUE)), ""), collapse = ", "), "]")
}

#' Python `a or b` for strings: an empty or missing string falls back.
#' @noRd
.kbl_or <- function(a, b) if (!is.null(a) && !is.na(a) && nzchar(a)) a else b

# --- frames -------------------------------------------------------------------------------------------------------

#' One row source: the wire object and the derived values (a derived NULL still overrides the wire).
#' @noRd
.kbl_src <- function(obj = list(), ...) list(o = obj, d = list(...))

#' @noRd
.kbl_path <- function(obj, parts) {
  for (p in parts) {
    if (!.kbl_is_dict(obj)) return(NULL)
    obj <- obj[[p]]
  }
  obj
}

#' The `kind` frame over row sources (zero rows keep the documented columns).
#' @noRd
.kbl_frame <- function(kind, rows) {
  spec <- .kbl_specs[[kind]]
  wire <- sub("\\|[a-z]$", "", spec)
  type <- sub("^.*\\|", "", spec)
  cols <- lapply(seq_along(spec), function(j) {
    col <- names(spec)[[j]]
    parts <- if (nzchar(wire[[j]])) strsplit(wire[[j]], ".", fixed = TRUE)[[1]] else character()
    values <- lapply(rows, function(r) {
      if (col %in% names(r$d)) r$d[[col]] else if (length(parts)) .kbl_path(r$o, parts) else NULL
    })
    switch(type[[j]],
      s = vapply(values, .kbl_s, character(1), USE.NAMES = FALSE),
      i = vapply(values, .kbl_i, integer(1), USE.NAMES = FALSE),
      f = vapply(values, .kbl_f, double(1), USE.NAMES = FALSE),
      b = vapply(values, .kbl_b, logical(1), USE.NAMES = FALSE),
      d = structure(vapply(values, .kbl_d, double(1), USE.NAMES = FALSE), class = "Date")
    )
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

# --- context ------------------------------------------------------------------------------------------------------

#' Rows of a list route: a bare list, or `items` of an object.
#' @noRd
.kbl_items <- function(body) if (.kbl_is_array(body)) .kbl_rows(body) else .kbl_rows(.kbl_obj(body)$items)

#' @noRd
.kbl_season_end <- function(code) {
  hit <- .kbl_season_table$end[.kbl_season_table$code %in% code]
  if (length(code) == 1L && !is.na(code) && length(hit)) hit[[1]] else NULL
}

#' The columns every game frame starts with, derived from the gmkey alone.
#' @noRd
.kbl_game_ctx <- function(gmkey) {
  p <- .kbl_game_key_parts(gmkey)
  if (is.null(p)) return(list(gmkey = if (is.character(gmkey) && length(gmkey) == 1L) gmkey))
  list(gmkey = gmkey, season_code = p$season_code, season = .kbl_season_end(p$season_code),
       game_code = p$game_code, game_no = p$game_no)
}

#' The game a body belongs to: the request stamp, else the header's own `game.gmkey`.
#' @noRd
.kbl_game_key <- function(body, req) {
  if (is.character(req$gmkey)) req$gmkey else .kbl_path(body, c("game", "gmkey"))
}

#' `season` / `season_code` / `game_code` / `glkey` from the request stamp, else from a row's own.
#' @noRd
.kbl_season_ctx <- function(req, season_code = NULL, game_code = NULL) {
  code <- .kbl_i(req$season_code)
  if (is.na(code)) code <- .kbl_i(season_code)
  end <- .kbl_i(req$season)
  if (is.na(end)) end <- if (is.na(code)) NA_integer_ else .kbl_season_end(code) %||% NA_integer_
  gc <- .kbl_or(.kbl_s(req$game_code), .kbl_s(game_code))
  glkey <- .kbl_or(.kbl_s(req$glkey), if (!is.na(code) && !is.na(gc) && nzchar(gc)) paste0("S", code, "G", gc))
  list(season = end, season_code = code, game_code = gc, glkey = glkey)
}

#' `(period, period_label)` of a wire period label: Q1-Q4 -> 1-4, X1 / EQ1 / eq1 -> 5 (OT1), ...
#' @noRd
.kbl_period_of <- function(label) {
  m <- if (is.character(label) && length(label) == 1L && !is.na(label)) {
    regmatches(label, regexec("^(?i)(Q|X|EQ)([0-9])$", label, perl = TRUE))[[1]]
  }
  if (!length(m)) return(list(NULL, NULL))
  n <- as.integer(m[[3]])
  if (toupper(m[[2]]) == "Q") {
    return(if (n >= 1L && n <= 4L) list(n, paste0("Q", n)) else list(NULL, NULL))
  }
  list(4L + n, paste0("OT", n))
}

#' @noRd
.kbl_minutes <- function(play_min, play_sec) {
  m <- .kbl_i(play_min)
  s <- .kbl_i(play_sec)
  if (is.na(m) || is.na(s)) NULL else round(m + s / 60, 4)
}

#' @noRd
.kbl_lookup <- function(table, key) if (.kbl_scalar(key) && key %in% names(table)) table[[key]] else NULL

# --- shapers (one per frame) --------------------------------------------------------------------------------------

#' @noRd
.kbl_shape_game <- function(body, req) {
  game <- .kbl_obj(.kbl_obj(body)$game)
  if (!length(game)) return(list())
  records <- .kbl_obj(body)$teamrecords
  totals <- lapply(c("home", "away"), function(side) {
    rec <- .kbl_obj(.kbl_obj(records)[[side]])
    q <- lapply(1:4, function(i) .kbl_i(rec[[paste0("scoreq", i)]]))
    eq <- if (.kbl_is_array(rec$scoreeq)) lapply(rec$scoreeq, .kbl_i) else list()
    v <- unlist(c(q, eq))
    if (anyNA(v)) NULL else sum(v)
  })
  sides <- Filter(function(s) .kbl_is_array(.kbl_obj(.kbl_obj(records)[[s]])$scoreeq), c("home", "away"))
  ots <- if (length(sides)) max(vapply(sides, function(s) length(.kbl_obj(records)[[s]]$scoreeq), integer(1)))
  subs <- Filter(function(n) is.character(n) && length(n) == 1L,
                 lapply(.kbl_rows(.kbl_obj(game$judges)$sub), function(j) j$name))
  coaches <- function(side) {
    staff <- .kbl_obj(.kbl_obj(.kbl_obj(body$teams)[[side]])$staffs)
    .kbl_json(Filter(function(n) is.character(n) && length(n) == 1L, lapply(.kbl_rows(staff$coaches), function(x) x$name)))
  }
  ctx <- .kbl_game_ctx(game$gmkey)
  list(.kbl_src(body, season = ctx$season, home_score = totals[[1]], away_score = totals[[2]], overtimes = ots,
                referees_sub = .kbl_json(subs), home_coaches = coaches("home"), away_coaches = coaches("away")))
}

#' @noRd
.kbl_shape_period_scores <- function(body, req) {
  game <- .kbl_obj(.kbl_obj(body)$game)
  records <- .kbl_obj(.kbl_obj(body)$teamrecords)
  if (!length(records)) return(list())
  ctx <- .kbl_game_ctx(if (length(game)) game$gmkey else .kbl_game_key(body, req))
  rows <- list()
  for (side in c("home", "away")) {
    rec <- .kbl_obj(records[[side]])
    code <- .kbl_path(body, c("teams", side, "tcode"))
    if (is.null(code) || identical(code, "")) code <- game[[if (side == "home") "tcodeH" else "tcodeA"]]
    eq <- if (.kbl_is_array(rec$scoreeq)) rec$scoreeq else list()
    labels <- c(paste0("Q", 1:4), if (length(eq)) paste0("X", seq_along(eq)))
    scores <- c(lapply(1:4, function(i) rec[[paste0("scoreq", i)]]), eq)
    for (k in seq_along(labels)) {
      p <- .kbl_period_of(labels[[k]])
      rows[[length(rows) + 1L]] <- do.call(.kbl_src, c(list(list()), ctx, list(
        side = side, team_code = code, period = p[[1]], period_label = p[[2]], score = scores[[k]]
      )))
    }
  }
  rows
}

#' @noRd
.kbl_shape_pbp <- function(body, req) {
  ctx <- .kbl_game_ctx(.kbl_game_key(body, req))
  items <- .kbl_items(body)
  lapply(seq_along(items), function(n) {
    r <- items[[n]]
    action <- .kbl_s(r$a)
    p <- .kbl_period_of(r$q)
    team <- .kbl_s(r$t)
    m <- .kbl_i(r$m)
    s <- .kbl_i(r$s)
    team <- if (is.na(team)) NULL else .kbl_or(trimws(team, whitespace = "[\\h\\v]"), NULL)
    do.call(.kbl_src, c(list(r), ctx, list(
      action_number = n, period = p[[1]], period_label = p[[2]],
      clock_seconds_left = if (!is.na(m) && !is.na(s)) m * 60L + s,
      team_code = team,
      action = .kbl_lookup(.kbl_action_en, action), action_ko = .kbl_lookup(.kbl_action_ko, action),
      points = .kbl_lookup(.kbl_action_points, action),
      substitution = .kbl_lookup(.kbl_substitutions, .kbl_s(r$c)), foul = .kbl_lookup(.kbl_fouls, .kbl_s(r$f))
    )))
  })
}

#' @noRd
.kbl_shape_box <- function(body, req) {
  ctx <- .kbl_game_ctx(.kbl_game_key(body, req))
  lapply(.kbl_items(body), function(r) {
    rec <- .kbl_obj(r$records)
    do.call(.kbl_src, c(list(r), ctx, list(minutes_played = .kbl_minutes(rec$playMin, rec$playSec))))
  })
}

#' @noRd
.kbl_shape_shots <- function(body, req) {
  ctx <- .kbl_game_ctx(.kbl_game_key(body, req))
  rows <- list()
  for (player in .kbl_rows(.kbl_obj(body)$shootLog)) {
    for (shot in .kbl_rows(player$logs)) {
      p <- .kbl_period_of(shot$q)
      made <- shot$o
      obj <- player
      obj$logs <- shot
      rows[[length(rows) + 1L]] <- do.call(.kbl_src, c(list(obj), ctx, list(
        period = p[[1]], period_label = p[[2]],
        made = if (.kbl_scalar(made) && made %in% c("O", "X")) made == "O"
      )))
    }
  }
  rows
}

#' @noRd
.kbl_shape_score_track <- function(body, req) {
  ctx <- .kbl_game_ctx(.kbl_game_key(body, req))
  lead <- .kbl_obj(.kbl_obj(body)$leadTrack)
  chart <- .kbl_obj(.kbl_obj(body)$scoreChart)
  home <- .kbl_obj(chart$home)
  away <- .kbl_obj(chart$away)
  keys <- unique(c(names(lead), names(home), names(away)))
  per <- lapply(keys, function(k) .kbl_period_of(k)[[1]])
  keys <- keys[!vapply(per, is.null, logical(1))]
  keys <- keys[order(vapply(keys, function(k) .kbl_period_of(k)[[1]], integer(1)))]
  rows <- list()
  for (key in keys) {
    p <- .kbl_period_of(key)
    series <- lapply(list(lead[[key]], home[[key]], away[[key]]), function(s) if (.kbl_is_array(s)) s else list())
    for (i in seq_len(max(lengths(series)))) {
      at <- lapply(series, function(s) if (i <= length(s)) s[[i]])
      rows[[length(rows) + 1L]] <- do.call(.kbl_src, c(list(list()), ctx, list(
        period = p[[1]], period_label = p[[2]], checkpoint = i,
        home_margin = at[[1]], home_score = at[[2]], away_score = at[[3]]
      )))
    }
  }
  rows
}

#' @noRd
.kbl_shape_game_leaders <- function(body, req) {
  ctx <- .kbl_game_ctx(.kbl_game_key(body, req))
  rows <- list()
  for (best in .kbl_rows(.kbl_obj(body)$bestPlayer)) {
    for (side in c("home", "away")) {
      p <- .kbl_obj(best[[side]])
      if (!length(p)) next
      wired <- list(bestPlayer = list(part = best$part, home = p))
      rows[[length(rows) + 1L]] <- do.call(.kbl_src, c(list(wired), ctx, list(side = side)))
    }
  }
  rows
}

#' @noRd
.kbl_shape_player_totals <- function(body, req) {
  ctx <- .kbl_season_ctx(req)
  lapply(.kbl_items(body), function(r) {
    rec <- .kbl_obj(r$records)
    do.call(.kbl_src, c(list(r), ctx, list(minutes_played = .kbl_minutes(rec$playMin, rec$playSec))))
  })
}

#' @noRd
.kbl_shape_standings <- function(body, req) {
  lapply(.kbl_items(body), function(r) {
    ctx <- .kbl_season_ctx(req, r$seasonCode, r$gameCode)
    .kbl_src(r, season = ctx$season, season_code = ctx$season_code)
  })
}

#' @noRd
.kbl_shape_team_tracks <- function(body, req) {
  ctx <- .kbl_season_ctx(req)
  rows <- list()
  for (team in .kbl_rows(.kbl_obj(body)$tracks)) {
    ranks <- if (.kbl_is_array(team$tracks)) team$tracks else list()
    for (n in seq_along(ranks)) {
      rows[[length(rows) + 1L]] <- do.call(.kbl_src, c(list(team), ctx, list(game_number = n, rank = ranks[[n]])))
    }
  }
  rows
}

#' @noRd
.kbl_shape_rounds <- function(body, req) {
  ctx <- .kbl_season_ctx(req)
  lapply(.kbl_rows(.kbl_obj(body)$rounds), function(r) do.call(.kbl_src, c(list(r), ctx)))
}

#' @noRd
.kbl_playoff_ctx <- function(body, req) {
  seeds <- .kbl_rows(.kbl_obj(body)$defaultRank)
  first <- if (length(seeds)) seeds[[1]] else list()
  .kbl_season_ctx(req, first$seasonCode, first$gameCode)
}

#' @noRd
.kbl_shape_playoff_seeds <- function(body, req) {
  ctx <- .kbl_playoff_ctx(body, req)
  lapply(.kbl_rows(.kbl_obj(body)$defaultRank), function(s) .kbl_src(list(defaultRank = s), season = ctx$season))
}

#' New-format series: round, series number, games key, wins keys, team slot keys (sdv-py `_SERIES`).
#' @noRd
.KBL_SERIES <- list(
  list("quarterfinal", 1L, "game1", c("resultFinalSix1", "resultFinalSix2"), c("finalSix4", "finalSix5")),
  list("quarterfinal", 2L, "game2", c("resultFinalSix3", "resultFinalSix4"), c("finalSix3", "finalSix6")),
  list("semifinal", 1L, "game3", c("resultFinalFour1", "resultFinalFour2"), c("finalSix1", "finalSix1vs2Winner")),
  list("semifinal", 2L, "game4", c("resultFinalFour3", "resultFinalFour4"), c("finalSix2", "finalSix3vs4Winner")),
  list("final", 1L, "game5", c("resultFinal1", "resultFinal2"), c("finalFour1vs2Winner", "finalFour3vs4Winner"))
)

#' @noRd
.kbl_shape_playoff_series <- function(body, req) {
  ctx <- .kbl_playoff_ctx(body, req)
  seed_rows <- .kbl_rows(.kbl_obj(body)$defaultRank)
  seed_keys <- vapply(seed_rows, function(s) .kbl_or(.kbl_s(s$teamCode), ""), character(1))
  seed_vals <- vapply(seed_rows, function(s) .kbl_i(s$rank), integer(1))
  seed_of <- function(code) { # a dict: the last row of a team wins
    i <- utils::tail(which(seed_keys == .kbl_or(code, "")), 1)
    if (length(i)) seed_vals[[i]]
  }
  result <- .kbl_obj(.kbl_obj(body)$result)
  rows <- list()
  if (length(result)) { # new format (seasonCode 45 on): the bracket as numbers, teams from the seed slots
    for (sr in .KBL_SERIES) {
      codes <- c(.kbl_s(result[[sr[[5]][[1]]]]), .kbl_s(result[[sr[[5]][[2]]]]))
      wins <- list(result[[sr[[4]][[1]]]], result[[sr[[4]][[2]]]])
      games <- .kbl_rows(result[[sr[[3]]]])
      played <- unique(unlist(lapply(games, function(g) c(.kbl_s(g$tcodeH), .kbl_s(g$tcodeA)))))
      played <- played[!is.na(played) & nzchar(played)]
      slots <- unique(codes[!is.na(codes) & nzchar(codes)])
      if (length(played) && !setequal(played, slots)) codes <- c(NA, NA) # the slot rule does not hold: do not guess
      for (i in 1:2) {
        rows[[length(rows) + 1L]] <- .kbl_src(
          list(), season = ctx$season, season_code = ctx$season_code, bracket_format = "new", round = sr[[1]],
          series_no = sr[[2]], team_code = codes[[i]], opponent_code = codes[[3L - i]],
          seed = seed_of(if (is.na(codes[[i]])) NULL else codes[[i]]), wins = wins[[i]], losses = wins[[3L - i]]
        )
      }
    }
    return(rows)
  }
  rounds <- c(sixResult = "quarterfinal", fourResult = "semifinal", finalResult = "final")
  for (key in names(rounds)) { # old format: one row per team per round
    for (r in .kbl_rows(.kbl_obj(body)[[key]])) {
      rows[[length(rows) + 1L]] <- .kbl_src(
        r, season = ctx$season, season_code = ctx$season_code, bracket_format = "old", round = rounds[[key]],
        seed = seed_of(.kbl_s(r$teamCode))
      )
    }
  }
  # the opponent: the other team of the same round and series
  rnd <- vapply(rows, function(x) x$d$round, character(1))
  sno <- vapply(rows, function(x) .kbl_i(x$o$gameHoi), integer(1))
  team <- vapply(rows, function(x) .kbl_s(x$o$teamCode), character(1))
  for (k in seq_along(rows)) {
    grp <- team[rnd == rnd[[k]] & (sno %in% sno[[k]])]
    others <- grp[!grp %in% team[[k]]]
    rows[[k]]$d["opponent_code"] <- list(if (length(others) == 1L) others[[1]])
  }
  rows
}

#' @noRd
.kbl_shape_playoff_games <- function(body, req) {
  result <- .kbl_obj(.kbl_obj(body)$result)
  ctx <- .kbl_playoff_ctx(body, req)
  rows <- list()
  for (sr in .KBL_SERIES) {
    for (g in .kbl_rows(result[[sr[[3]]]])) {
      gk <- .kbl_obj(g$gmkey)
      parts <- list(.kbl_i(gk$seasonCode), .kbl_s(gk$gameCode), .kbl_i(gk$gameNo))
      key <- if (!anyNA(unlist(parts))) paste0("S", parts[[1]], "G", parts[[2]], "N", parts[[3]])
      g$gmkey <- gk
      rows[[length(rows) + 1L]] <- .kbl_src(list(result = list(game1 = g)), season = ctx$season, gmkey = key,
                                            round = sr[[1]], series_no = sr[[2]])
    }
  }
  rows
}

#' @noRd
.kbl_shape_round_mvps <- function(body, req) {
  lapply(.kbl_items(body), function(r) {
    parts <- c(.kbl_i(r$totalHour), .kbl_i(r$totalMinute), .kbl_i(r$totalSecond))
    total <- if (!anyNA(parts)) sum(parts * c(3600L, 60L, 1L))
    .kbl_src(r, season = .kbl_season_ctx(req, r$seasonCode)$season, total_seconds = total)
  })
}

#' @noRd
.kbl_shape_current_standings <- function(body, req) {
  lapply(.kbl_items(body), function(r) {
    last <- r$lastRecord
    five <- if (.kbl_is_array(last) && all(!is.na(vapply(last, .kbl_i, integer(1))))) {
      paste(vapply(last, function(x) as.character(x), character(1)), collapse = ",")
    }
    .kbl_src(r, last_five = five)
  })
}

#' @noRd
.kbl_shape_season_leaders <- function(body, req) {
  rows <- list()
  for (cat in .kbl_items(body)) {
    part <- .kbl_s(cat$part)
    for (entry in .kbl_rows(cat$list)) {
      rows[[length(rows) + 1L]] <- .kbl_src(list(part = part, list = entry),
                                            part_label = .kbl_lookup(.kbl_leader_parts, part))
    }
  }
  rows
}

#' @noRd
.kbl_shape_plain <- function(body, req) lapply(.kbl_items(body), .kbl_src)

#' @noRd
.kbl_shape_seasoned <- function(body, req) {
  lapply(.kbl_items(body), function(r) .kbl_src(r, season = .kbl_season_end(.kbl_or(.kbl_i(r$seasonCode), 0L))))
}

#' @noRd
.kbl_shapers <- list(
  seasons = .kbl_shape_seasoned, teams = .kbl_shape_plain, schedule = .kbl_shape_seasoned,
  game = .kbl_shape_game, period_scores = .kbl_shape_period_scores, pbp = .kbl_shape_pbp,
  player_box = .kbl_shape_box, team_box = .kbl_shape_box, shots = .kbl_shape_shots,
  score_track = .kbl_shape_score_track, game_leaders = .kbl_shape_game_leaders,
  player_totals = .kbl_shape_player_totals, standings = .kbl_shape_standings, team_tracks = .kbl_shape_team_tracks,
  rounds = .kbl_shape_rounds, playoff_seeds = .kbl_shape_playoff_seeds, playoff_series = .kbl_shape_playoff_series,
  playoff_games = .kbl_shape_playoff_games, round_mvps = .kbl_shape_round_mvps,
  current_standings = .kbl_shape_current_standings, season_leaders = .kbl_shape_season_leaders,
  players = .kbl_shape_plain
)

#' The `kind` frame of a runtime answer (`list(body =, req =)`).
#' @noRd
.kbl_parse <- function(kind, raw) .kbl_frame(kind, .kbl_shapers[[kind]](raw$body, raw$req))

#' @noRd
.kbl_out <- function(kind, raw, type) make_hoopR_data(.kbl_parse(kind, raw), type, Sys.time())
