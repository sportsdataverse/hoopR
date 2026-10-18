# sportpress_parsers.R -- frames of the BNXT League (Sportpress) wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/bnxt/bnxt_parsers.py (origin/main e3d232e): every frame
# has a fixed column list with types pinned by name (`.SPORTPRESS_SPECS`, sdv-py `SPECS`), filled from
# the items an extractor builds (`.SPORTPRESS_ITEMS`, sdv-py `ITEMS`) by a dotted path per column.
# Types: i integer (sdv-py Int64), f double (Float64), s character (Utf8), b logical (Boolean), d Date,
# t POSIXct in Europe/Brussels (sdv-py's naive local Datetime: the source carries no offset). Every id is
# integer. A value of the wrong JSON type is NA, never coerced (a float id is NA, not "123.0").

# ---------------------------------------------------------------------------
# Casts (sdv-py _i / _f / _s / _b / _d / _dt) over a list of raw values
# ---------------------------------------------------------------------------

#' @noRd
.sportpress_scalar <- function(v) !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)

#' @noRd
.sportpress_cast_i <- function(vals) {
  vapply(vals, function(v) {
    if (!.sportpress_scalar(v) || is.logical(v)) return(NA_integer_)
    if (is.integer(v)) return(v)
    if (is.double(v) && v == trunc(v) && abs(v) <= .Machine$integer.max) return(as.integer(v))
    NA_integer_
  }, integer(1), USE.NAMES = FALSE)
}

#' @noRd
.sportpress_cast_f <- function(vals) {
  vapply(vals, function(v) if (.sportpress_scalar(v) && is.numeric(v)) as.double(v) else NA_real_,
         double(1), USE.NAMES = FALSE)
}

#' Python `str()` of a JSON scalar: `True` / `False`, `5`, `5.0`, text as is.
#' @noRd
.sportpress_cast_s <- function(vals) {
  vapply(vals, function(v) {
    if (!.sportpress_scalar(v)) return(NA_character_)
    if (is.logical(v)) return(if (v) "True" else "False")
    # ponytail: a whole double prints as "5.0" (Python repr); other doubles use R's 15 digits
    if (is.double(v) && v == trunc(v) && abs(v) < 1e16) return(sprintf("%.1f", v))
    as.character(v)
  }, character(1), USE.NAMES = FALSE)
}

#' @noRd
.sportpress_cast_b <- function(vals) {
  vapply(vals, function(v) if (.sportpress_scalar(v) && is.logical(v)) v else NA, logical(1), USE.NAMES = FALSE)
}

#' The first 10 characters as an ISO date, else NA.
#' @noRd
.sportpress_cast_d <- function(vals) {
  x <- vapply(vals, function(v) if (.sportpress_scalar(v) && is.character(v)) substr(v, 1L, 10L) else NA_character_,
              character(1), USE.NAMES = FALSE)
  x[!grepl("^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$", x)] <- NA_character_
  as.Date(x, format = "%Y-%m-%d")
}

#' `YYYY-MM-DD HH:MM:SS` as league local time (POSIXct, Europe/Brussels), else NA.
#' @noRd
.sportpress_cast_t <- function(vals) {
  x <- vapply(vals, function(v) if (.sportpress_scalar(v) && is.character(v)) trimws(v) else NA_character_,
              character(1), USE.NAMES = FALSE)
  x[!grepl("^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}$", x)] <- NA_character_
  as.POSIXct(x, tz = .SPORTPRESS_TZ, format = "%Y-%m-%d %H:%M:%S")
}

#' @noRd
.SPORTPRESS_CAST <- list(i = .sportpress_cast_i, f = .sportpress_cast_f, s = .sportpress_cast_s,
                         b = .sportpress_cast_b, d = .sportpress_cast_d, t = .sportpress_cast_t)

#' The value at a dotted path in nested objects, `NULL` when a step is missing or not an object.
#' @noRd
.sportpress_at <- function(item, path) {
  for (key in strsplit(path, ".", fixed = TRUE)[[1]]) {
    if (!.sportpress_is_dict(item)) return(NULL)
    item <- item[[key]]
  }
  item
}

#' `items` as a tibble with exactly the spec's columns and types (zero rows when there are none).
#' @noRd
.sportpress_frame <- function(items, spec) {
  cols <- lapply(names(spec), function(name) {
    s <- spec[[name]]
    .SPORTPRESS_CAST[[s[[1]]]](lapply(items, .sportpress_at, s[[2]]))
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

# ---------------------------------------------------------------------------
# Body access and merging (Python `{**a, **b}`: later keys win)
# ---------------------------------------------------------------------------

#' @noRd
.sportpress_merge <- function(...) {
  out <- stats::setNames(list(), character())
  for (x in list(...)) if (length(x)) out[names(x)] <- x
  out
}

#' @noRd
.sportpress_ctx <- function(raw) {
  req <- if (.sportpress_is_dict(raw)) raw[[.SPORTPRESS_REQUEST]]
  if (.sportpress_is_dict(req)) req else list()
}

#' Only the objects of a JSON array (`list()` for anything else).
#' @noRd
.sportpress_list <- function(v) if (.sportpress_is_array(v)) Filter(.sportpress_is_dict, v) else list()

#' @noRd
.sportpress_rows <- function(raw) .sportpress_list(if (.sportpress_is_dict(raw)) raw$data)

#' @noRd
.sportpress_obj <- function(raw) {
  d <- if (.sportpress_is_dict(raw)) raw$data
  if (.sportpress_is_dict(d)) d else list()
}

#' @noRd
.sportpress_side_name <- function(is_home) {
  if (is.logical(is_home) && length(is_home) == 1L && !is.na(is_home)) if (is_home) "home" else "away"
}

#' A game object plus `home` / `away` = its competitors by `side` (1 / 2; the last one wins).
#' @noRd
.sportpress_game_item <- function(g) {
  home <- list()
  away <- list()
  for (c in .sportpress_list(g$competitors)) {
    s <- c$side
    if (.sportpress_scalar(s) && (is.numeric(s) || is.logical(s))) {
      if (s == 1) home <- c
      if (s == 2) away <- c
    }
  }
  .sportpress_merge(g, list(home = home, away = away))
}

# ---------------------------------------------------------------------------
# Column blocks (sdv-py _stat_cols, _player_cols, _team_cols, _game_cols, _roster_cols)
# ---------------------------------------------------------------------------

#' @noRd
.SPORTPRESS_STATS <- c(
  "minute", "foul", "defensive_foul", "dunk_made", "dunk_all", "dunk_percent",
  "two_point_made", "two_point_all", "two_point_percent",
  "three_point_made", "three_point_all", "three_point_percent",
  "throw_made", "throw_all", "throw_percent",
  "free_throw_made", "free_throw_all", "free_throw_percent",
  "offensive_rebound", "defensive_rebound", "total_rebound",
  "block", "block_against", "turnover", "steal", "assist", "points", "value"
)

#' @noRd
.sportpress_col <- function(type, path) list(type, path)

#' @noRd
.sportpress_stat_cols <- function(prefix = "", avg = FALSE, plusminus = FALSE) {
  nm <- c(.SPORTPRESS_STATS, if (plusminus) "plusminus")
  stats::setNames(lapply(nm, function(n) {
    .sportpress_col(if (avg || endsWith(n, "_percent")) "f" else "i", paste0(prefix, n))
  }), nm)
}

#' @noRd
.sportpress_player_cols <- function(prefix) {
  list(player_id = .sportpress_col("i", paste0(prefix, "id")),
       first_name = .sportpress_col("s", paste0(prefix, "first_name")),
       last_name = .sportpress_col("s", paste0(prefix, "last_name")),
       nationality_code = .sportpress_col("s", paste0(prefix, "nationality_code")),
       birth_date = .sportpress_col("d", paste0(prefix, "birthdate")))
}

#' @noRd
.sportpress_team_cols <- function(prefix, club = TRUE) {
  out <- list(competition_team_id = .sportpress_col("i", paste0(prefix, "id")),
              team = .sportpress_col("s", paste0(prefix, "name")),
              team_short_name = .sportpress_col("s", paste0(prefix, "short_name")))
  if (club) {
    out$club_id <- .sportpress_col("i", paste0(prefix, "club.id"))
    out$club_name <- .sportpress_col("s", paste0(prefix, "club.name"))
  }
  out
}

#' @noRd
.sportpress_game_cols <- function(p = "") {
  out <- list(
    game_id = .sportpress_col("i", paste0(p, "id")),
    game_time = .sportpress_col("t", paste0(p, "game_time")),
    status = .sportpress_col("s", paste0(p, "status")),
    competition_id = .sportpress_col("i", paste0(p, "competition.id")),
    season = .sportpress_col("i", paste0(p, "competition.season")),
    phase_id = .sportpress_col("i", paste0(p, "phase.id")),
    phase_name = .sportpress_col("s", paste0(p, "phase.name")),
    round_name = .sportpress_col("s", paste0(p, "round.name")),
    round_priority = .sportpress_col("i", paste0(p, "round.priority")),
    period_name = .sportpress_col("s", paste0(p, "period.name")),
    arena = .sportpress_col("s", paste0(p, "arena.name"))
  )
  for (side in c("home", "away")) {
    out[[paste0(side, "_competition_team_id")]] <- .sportpress_col("i", paste0(p, side, ".competition_team.id"))
    out[[paste0(side, "_team")]] <- .sportpress_col("s", paste0(p, side, ".competition_team.name"))
    out[[paste0(side, "_team_short_name")]] <- .sportpress_col("s", paste0(p, side, ".competition_team.short_name"))
    out[[paste0(side, "_score")]] <- .sportpress_col("i", paste0(p, side, ".finalScore"))
  }
  out
}

#' @noRd
.sportpress_roster_cols <- function() {
  c(list(roster_id = .sportpress_col("i", "id"),
         competition_team_id = .sportpress_col("i", "competition_team_id"),
         jersey = .sportpress_col("s", "jersey"),
         weight = .sportpress_col("i", "weight"),
         height = .sportpress_col("i", "height"),
         active = .sportpress_col("b", "active"),
         position_id = .sportpress_col("i", "player_position.id"),
         position = .sportpress_col("s", "player_position.name")),
    .sportpress_player_cols("player."))
}

#' @noRd
.sportpress_ctx_cols <- function(...) {
  nm <- c(...)
  stats::setNames(lapply(nm, function(n) .sportpress_col("i", n)), nm)
}

#' @noRd
.SPORTPRESS_SIDE <- list(team_side = list("s", "team_side"))
#' @noRd
.SPORTPRESS_GAME_ROUTE <- list(game_id = list("i", "game_id"), competition_id = list("i", "competition_id"))

#' Column name -> list(type, dotted path), per wrapper (sdv-py `bnxt_parsers.SPECS`).
#' @noRd
.SPORTPRESS_SPECS <- list(
  ui_strings = list(language = list("s", "language"), key = list("s", "key"), text = list("s", "text")),
  club_seasons = list(season = list("i", "season")),
  referees = list(staff_id = list("i", "id"), name = list("s", "name"), title_id = list("i", "title.id"),
                  title_name = list("s", "title.name")),
  phases = list(season = list("i", "competition.season"), competition_id = list("i", "competition.id"),
                competition_name = list("s", "competition.name"), phase_id = list("i", "phase.id"),
                phase_name = list("s", "phase.name"), standings_visible = list("b", "phase.standings_visible")),
  competition_teams = c(list(competition_id = list("i", "competition_id"),
                             season = list("i", "competition.season"), uu_team_id = list("i", "uu_team_id")),
                        .sportpress_team_cols("")),
  competition_staff = list(competition_id = list("i", "team.competition_id"),
                           competition_team_id = list("i", "competition_team_id"),
                           staff_id = list("i", "staff.id"), name = list("s", "staff.name"),
                           title_id = list("i", "title.id"), title_name = list("s", "title.name")),
  standings = c(
    .sportpress_ctx_cols("competition_id", "phase_id"), .sportpress_team_cols("team."),
    list(position = list("i", "position"), played = list("i", "played"), win = list("i", "win"),
         loss = list("i", "loss"), even = list("i", "even"), score = list("i", "score"),
         against = list("i", "against"), score_difference = list("i", "score_difference"),
         percent = list("f", "percent"), point = list("i", "point"), point_percent = list("f", "point_percent"),
         home_win = list("i", "win_loss.home.win"), home_loss = list("i", "win_loss.home.loss"),
         away_win = list("i", "win_loss.away.win"), away_loss = list("i", "win_loss.away.loss"),
         last5_win = list("i", "last5.win"), last5_loss = list("i", "last5.loss"),
         streak_is_win = list("b", "streak.is_win"), streak_count = list("i", "streak.count"),
         group = list("s", "group"))
  ),
  schedule = .sportpress_game_cols(),
  game_slider = c(
    list(game_id = list("i", "id"), genius_id = list("i", "genius_id"), game_time = list("t", "game_time"),
         status = list("s", "status"), competition_id = list("i", "competition.id"),
         season = list("i", "competition.season"), phase_id = list("i", "phase.id"),
         phase_name = list("s", "phase.name")),
    .sportpress_game_cols()[grepl("^(home|away)_", names(.sportpress_game_cols()))]
  ),
  team_rankings = c(.sportpress_ctx_cols("competition_id"),
                    list(category = list("s", "category"), rank = list("i", "rank")),
                    .sportpress_team_cols("team.", club = FALSE), list(value = list("f", "value"))),
  player_rankings = c(.sportpress_ctx_cols("competition_id"),
                      list(category = list("s", "category"), rank = list("i", "rank"),
                           roster_id = list("i", "roster_id")),
                      .sportpress_player_cols("player."), .sportpress_team_cols("team.", club = FALSE),
                      list(value = list("f", "value"), throw_made = list("f", "throw_made"),
                           throw_attempted = list("f", "throw_attempted"))),
  season_roster = c(list(season = list("i", "season")), .sportpress_roster_cols()),
  nationality_codes = list(season = list("i", "season"), nationality_code = list("s", "nationality_code")),
  team_roster = .sportpress_roster_cols(),
  team_find = c(list(competition_id = list("i", "competition_id"), season = list("i", "competition.season"),
                     competition_name = list("s", "competition.name"), uu_team_id = list("i", "uu_team_id")),
                .sportpress_team_cols(""),
                list(average_score_for = list("f", "statistics.average_score_for"),
                     average_score_against = list("f", "statistics.average_score_against"),
                     field_goal_percent = list("f", "statistics.field_goal_percent"))),
  team_player_averages = c(.sportpress_ctx_cols("competition_team_id"), list(roster_id = list("i", "roster_id")),
                           .sportpress_player_cols("player."),
                           list(played_games = list("i", "played_games"), games_started = list("i", "starter")),
                           .sportpress_stat_cols(avg = TRUE)),
  team_games = c(.sportpress_ctx_cols("competition_team_id"), .sportpress_game_cols(),
                 .sportpress_stat_cols("total.", plusminus = TRUE)),
  roster_find = c(.sportpress_roster_cols(),
                  list(uu_team_id = list("i", "competition_team.uu_team_id"),
                       team = list("s", "competition_team.name"),
                       team_short_name = list("s", "competition_team.short_name"),
                       competition_id = list("i", "competition_team.competition_id"),
                       season = list("i", "competition_team.competition.season"))),
  player_career = c(.sportpress_ctx_cols("roster_id"),
                    list(competition_id = list("i", "competition.id"), season = list("i", "competition.season"),
                         competition_name = list("s", "competition.name")),
                    .sportpress_team_cols("team."),
                    list(position = list("s", "position.name"), jersey = list("s", "jersey"),
                         played_games = list("i", "played_games"), games_started = list("i", "starter")),
                    .sportpress_stat_cols(avg = TRUE)),
  player_games = c(.sportpress_ctx_cols("roster_id"), .sportpress_game_cols("game."),
                   list(competition_team_id = list("i", "competition_team_id"), starter = list("b", "starter"),
                        jersey = list("s", "jersey")),
                   .sportpress_stat_cols()),
  game_find = c(.sportpress_game_cols(),
                list(last_game_id = list("i", "last_game.id"), next_game_id = list("i", "next_game.id"))),
  game_periods = c(list(game_id = list("i", "game_id")), .SPORTPRESS_SIDE,
                   list(competition_team_id = list("i", "competition_team_id"), period = list("i", "period_id"),
                        score = list("i", "score"))),
  game_overview = c(list(game_id = list("i", "game_id")), .SPORTPRESS_SIDE,
                    .sportpress_team_cols("competitor.competition_team.", club = FALSE),
                    list(score = list("i", "competitor.finalScore")),
                    .sportpress_stat_cols("total.", plusminus = TRUE)),
  game_top_performers = c(list(game_id = list("i", "game_id")), .SPORTPRESS_SIDE,
                          .sportpress_team_cols("competitor.competition_team.", club = FALSE),
                          .sportpress_player_cols("player.player."),
                          list(jersey = list("s", "player.jersey"), starter = list("b", "player.starter")),
                          .sportpress_stat_cols("player.")),
  game_leaders = c(list(game_id = list("i", "game_id")), .SPORTPRESS_SIDE,
                   .sportpress_team_cols("competitor.competition_team.", club = FALSE),
                   list(stat = list("s", "stat")), .sportpress_player_cols("leader.player."),
                   list(value = list("f", "leader.value"))),
  game_box = c(.SPORTPRESS_GAME_ROUTE, .SPORTPRESS_SIDE, .sportpress_team_cols("team.", club = FALSE),
               list(roster_id = list("i", "roster_id")), .sportpress_player_cols("player."),
               list(position_id = list("i", "position.id"), position = list("s", "position.name"),
                    starter = list("b", "starter"), jersey = list("s", "jersey")),
               .sportpress_stat_cols(plusminus = TRUE)),
  game_team_box = c(.SPORTPRESS_GAME_ROUTE, .SPORTPRESS_SIDE, .sportpress_team_cols("team.", club = FALSE),
                    .sportpress_stat_cols("total.", plusminus = TRUE)),
  game_film = c(.SPORTPRESS_GAME_ROUTE,
                list(order = list("i", "order"), period = list("i", "period"), minute = list("i", "minute"),
                     second = list("i", "second")),
                .SPORTPRESS_SIDE, .sportpress_team_cols("team.", club = FALSE),
                list(event_code = list("i", "event_code"), event_subcode = list("i", "event_subcode"),
                     x = list("i", "x"), y = list("i", "y"), home_score = list("i", "current_home_score"),
                     away_score = list("i", "current_away_score")),
                .sportpress_player_cols("player."),
                list(player2_id = list("i", "player2.id"), player2_first_name = list("s", "player2.first_name"),
                     player2_last_name = list("s", "player2.last_name")))
)

# ---------------------------------------------------------------------------
# Item extractors (sdv-py ITEMS)
# ---------------------------------------------------------------------------

#' @noRd
.sportpress_it_plain <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  lapply(.sportpress_rows(raw), function(r) .sportpress_merge(ctx, r))
}

#' @noRd
.sportpress_it_ui_strings <- function(raw) {
  langs <- .sportpress_list(if (.sportpress_is_dict(raw)) raw$available_lang_array)
  out <- lapply(langs, function(lg) {
    res <- lg$resources
    if (!.sportpress_is_dict(res)) return(list())
    lapply(names(res), function(k) list(language = lg$alpha2, key = k, text = res[[k]]))
  })
  unlist(out, recursive = FALSE)
}

#' @noRd
.sportpress_it_phases <- function(raw) {
  unlist(lapply(.sportpress_rows(raw), function(r) {
    lapply(.sportpress_list(r$phases), function(p) .sportpress_merge(r, list(phase = p)))
  }), recursive = FALSE)
}

#' @noRd
.sportpress_it_competition_staff <- function(raw) {
  unlist(lapply(.sportpress_rows(raw), function(t) {
    lapply(.sportpress_list(t$staffs), function(s) .sportpress_merge(list(team = t), s))
  }), recursive = FALSE)
}

#' @noRd
.sportpress_it_schedule <- function(raw) lapply(.sportpress_rows(raw), .sportpress_game_item)

#' @noRd
.sportpress_it_rankings <- function(raw) {
  if (!.sportpress_is_dict(raw)) return(list())
  ctx <- .sportpress_ctx(raw)
  cats <- setdiff(names(raw), .SPORTPRESS_REQUEST)
  unlist(lapply(cats, function(cat) {
    rows <- .sportpress_list(raw[[cat]])
    lapply(seq_along(rows), function(n) .sportpress_merge(ctx, list(category = cat, rank = n), rows[[n]]))
  }), recursive = FALSE)
}

#' @noRd
.sportpress_it_nationality_codes <- function(raw) {
  codes <- if (.sportpress_is_dict(raw)) raw$data
  if (!.sportpress_is_array(codes)) return(list())
  ctx <- .sportpress_ctx(raw)
  codes <- Filter(function(c) is.character(c) && length(c) == 1L, codes)
  lapply(codes, function(c) .sportpress_merge(ctx, list(nationality_code = c)))
}

#' @noRd
.sportpress_it_obj <- function(raw) {
  o <- .sportpress_obj(raw)
  if (length(o)) list(.sportpress_merge(.sportpress_ctx(raw), o)) else list()
}

#' @noRd
.sportpress_it_team_games <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  lapply(.sportpress_rows(raw), function(g) .sportpress_merge(ctx, .sportpress_game_item(g)))
}

#' @noRd
.sportpress_it_player_games <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  rows <- Filter(function(r) .sportpress_is_dict(r$game), .sportpress_rows(raw))
  lapply(rows, function(r) .sportpress_merge(ctx, r, list(game = .sportpress_game_item(r$game))))
}

#' @noRd
.sportpress_it_game_find <- function(raw) {
  g <- .sportpress_obj(raw)
  if (length(g)) list(.sportpress_game_item(g)) else list()
}

#' @noRd
.sportpress_it_game_periods <- function(raw) {
  g <- .sportpress_obj(raw)
  unlist(lapply(.sportpress_list(g$competitors), function(c) {
    s <- c$side
    side <- if (.sportpress_scalar(s) && is.numeric(s) && s == 1) "home" else if (.sportpress_scalar(s) && is.numeric(s) && s == 2) "away"
    lapply(.sportpress_list(c$period_scores), function(ps) {
      .sportpress_merge(list(game_id = g$id, team_side = side,
                             competition_team_id = .sportpress_at(c, "competition_team.id")), ps)
    })
  }), recursive = FALSE)
}

#' @noRd
.sportpress_overview <- function(raw, key) {
  d <- .sportpress_obj(raw)
  gid <- .sportpress_ctx(raw)$game_id
  lapply(.sportpress_list(d[[key]]), function(r) {
    .sportpress_merge(list(game_id = gid, team_side = .sportpress_side_name(r$is_home)), r)
  })
}

#' @noRd
.sportpress_it_game_leaders <- function(raw) {
  unlist(lapply(.sportpress_overview(raw, "game_leaders"), function(r) {
    leaders <- if (.sportpress_is_dict(r$leaders)) r$leaders else list()
    leaders <- Filter(.sportpress_is_dict, leaders)
    lapply(names(leaders), function(stat) .sportpress_merge(r, list(stat = stat, leader = leaders[[stat]])))
  }), recursive = FALSE)
}

#' @noRd
.sportpress_it_game_box <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  unlist(lapply(.sportpress_rows(raw), function(t) {
    lapply(.sportpress_list(t$players), function(p) {
      .sportpress_merge(ctx, list(team_side = .sportpress_side_name(t$is_home), team = t$team), p)
    })
  }), recursive = FALSE)
}

#' @noRd
.sportpress_it_game_team_box <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  rows <- Filter(function(t) .sportpress_is_dict(t$total), .sportpress_rows(raw))
  lapply(rows, function(t) .sportpress_merge(ctx, list(team_side = .sportpress_side_name(t$is_home)), t))
}

#' @noRd
.sportpress_it_game_film <- function(raw) {
  ctx <- .sportpress_ctx(raw)
  lapply(.sportpress_rows(raw), function(e) .sportpress_merge(ctx, list(team_side = .sportpress_side_name(e$is_home)), e))
}

#' Wrapper -> item extractor (sdv-py `bnxt_parsers.ITEMS`).
#' @noRd
.SPORTPRESS_ITEMS <- list(
  ui_strings = .sportpress_it_ui_strings,
  club_seasons = .sportpress_it_plain,
  referees = .sportpress_it_plain,
  phases = .sportpress_it_phases,
  competition_teams = .sportpress_it_plain,
  competition_staff = .sportpress_it_competition_staff,
  standings = .sportpress_it_plain,
  schedule = .sportpress_it_schedule,
  game_slider = .sportpress_it_schedule,
  team_rankings = .sportpress_it_rankings,
  player_rankings = .sportpress_it_rankings,
  season_roster = .sportpress_it_plain,
  nationality_codes = .sportpress_it_nationality_codes,
  team_roster = .sportpress_it_plain,
  team_find = .sportpress_it_obj,
  team_player_averages = .sportpress_it_plain,
  team_games = .sportpress_it_team_games,
  roster_find = .sportpress_it_obj,
  player_career = .sportpress_it_plain,
  player_games = .sportpress_it_player_games,
  game_find = .sportpress_it_game_find,
  game_periods = .sportpress_it_game_periods,
  game_overview = function(raw) .sportpress_overview(raw, "team_totals"),
  game_top_performers = function(raw) .sportpress_overview(raw, "top_performer"),
  game_leaders = .sportpress_it_game_leaders,
  game_box = .sportpress_it_game_box,
  game_team_box = .sportpress_it_game_team_box,
  game_film = .sportpress_it_game_film
)

#' The documented frame of wrapper `short` over a stamped body, as a `hoopR_data` tibble.
#'
#' A body of the wrong shape parses to the zero-row frame with the documented columns.
#' @noRd
.sportpress_parse <- function(short, raw, type) {
  items <- tryCatch(.SPORTPRESS_ITEMS[[short]](raw), error = function(e) list())
  make_hoopR_data(.sportpress_frame(items %||% list(), .SPORTPRESS_SPECS[[short]]), type, Sys.time())
}
