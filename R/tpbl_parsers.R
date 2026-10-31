# tpbl_parsers.R -- frames of the TPBL wrappers (internal; parse_* is not exported).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/tpbl/tpbl_parsers.py (origin/main e3d232ebc9). Every frame is
# built from `.tpbl_specs` (below, copied from sportsdataverse-py `SPECS`): one type per column, never sampled. Codes: i
# integer, f double, s character, b logical, d Date, t POSIXct. Every id is an integer (all fit R's integer),
# shirt numbers stay character, the percentages (one-decimal strings on the wire, '57.1') are doubles on sportsdataverse-py's
# 0-100 scale, attendance (a string on the wire) is an integer. `tipoff` is POSIXct in Asia/Taipei: sportsdataverse-py's is a
# naive Taiwan-local timestamp (the API sends no zone). An empty or unrecognised input is a zero-row tibble with
# the documented columns.
#
# Id key spaces: TPBL ids (season, division, team, game, player, referee) are the ones every route takes;
# gohoops_* ids are GoHoops', the stats platform behind the league. The box score keys its players by
# gohoops_roster_id (one person registered with one squad in one season): join a box score to a roster on it.

#' @noRd
.tpbl_scalar <- function(v) !is.null(v) && is.atomic(v) && length(v) == 1L && !is.na(v)

#' An integer from an integer, a whole double or a digit string; never from a logical (sportsdataverse-py `_i`).
#' @noRd
.tpbl_i <- function(v) {
  if (!.tpbl_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) {
    return(if (is.finite(v) && v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_)
  }
  t <- trimws(v)
  if (!grepl("^-?[0-9]+$", t)) return(NA_integer_)
  f <- as.double(t)
  if (abs(f) > .Machine$integer.max) NA_integer_ else as.integer(f)
}

#' A double from a number or a decimal string, a trailing '%' dropped (sportsdataverse-py `_f`).
#' @noRd
.tpbl_f <- function(v) {
  if (!.tpbl_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  t <- sub("%+$", "", trimws(v))
  if (grepl("^[+-]?([0-9]+\\.?[0-9]*|\\.[0-9]+)([eE][+-]?[0-9]+)?$", t)) as.double(t) else NA_real_
}

#' @noRd
.tpbl_s <- function(v) if (.tpbl_scalar(v) && is.character(v)) v else NA_character_

#' @noRd
.tpbl_b <- function(v) if (.tpbl_scalar(v) && is.logical(v)) v else NA

#' A 'YYYY-MM-DD' date as days since the epoch.
#' @noRd
.tpbl_d <- function(v) {
  if (!.tpbl_scalar(v) || !is.character(v) || !grepl("^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$", v)) return(NA_real_)
  as.double(as.Date(v, format = "%Y-%m-%d"))
}

#' A naive 'YYYY-MM-DD HH:MM:SS' Taiwan-local time as seconds since the epoch.
#' @noRd
.tpbl_t <- function(v) {
  re <- "^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}$"
  if (!.tpbl_scalar(v) || !is.character(v) || !grepl(re, v)) return(NA_real_)
  as.double(as.POSIXct(v, format = "%Y-%m-%d %H:%M:%S", tz = "Asia/Taipei"))
}

#' One column from its raw values and type code.
#' @noRd
.tpbl_column <- function(values, type) {
  switch(type,
    i = vapply(values, .tpbl_i, integer(1), USE.NAMES = FALSE),
    f = vapply(values, .tpbl_f, double(1), USE.NAMES = FALSE),
    s = vapply(values, .tpbl_s, character(1), USE.NAMES = FALSE),
    b = vapply(values, .tpbl_b, logical(1), USE.NAMES = FALSE),
    d = structure(vapply(values, .tpbl_d, double(1), USE.NAMES = FALSE), class = "Date"),
    t = structure(vapply(values, .tpbl_t, double(1), USE.NAMES = FALSE), class = c("POSIXct", "POSIXt"),
                  tzone = "Asia/Taipei")
  )
}

#' `rows` (lists of raw values keyed by column) as a tibble with exactly `spec`'s columns and types.
#' @noRd
.tpbl_frame <- function(rows, spec) {
  cols <- lapply(stats::setNames(names(spec), names(spec)), function(n) {
    .tpbl_column(lapply(rows, function(r) r[[n]]), spec[[n]])
  })
  dplyr::as_tibble(cols)
}

#' @noRd
.tpbl_obj <- function(v) if (.tpbl_is_obj(v)) v else list()

#' @noRd
.tpbl_season_ctx <- function(req) list(season = req$season, season_id = req$season_id)

#' The stat values of `line` for every spec column not in `skip`.
#' @noRd
.tpbl_stats <- function(line, spec, skip) {
  n <- setdiff(names(spec), skip)
  stats::setNames(lapply(n, function(k) line[[k]]), n)
}

# ---------------------------------------------------------------------------
# Season routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_parse_seasons <- function(body, req = list()) {
  rows <- lapply(.tpbl_rows(body), function(r) {
    list(season = .tpbl_season_label_end(r[["name"]]), season_id = r[["id"]], gohoops_season_id = r[["gohoops_id"]],
         name = r[["name"]], status = r[["status"]], started_at = r[["started_at"]], ended_at = r[["ended_at"]])
  })
  .tpbl_frame(rows, .tpbl_specs$seasons)
}

#' The second year of a 'YYYY-YYYY' label (sportsdataverse-py's parser does not require it to be the first + 1).
#' @noRd
.tpbl_season_label_end <- function(name) {
  if (!is.character(name) || length(name) != 1L) return(NULL)
  m <- regmatches(name, regexec("^\\s*([0-9]{4})\\s*-\\s*([0-9]{4})", name, perl = TRUE))[[1]]
  if (length(m)) as.integer(m[[3]]) else NULL
}

#' @noRd
.tpbl_parse_divisions <- function(body, req = list()) {
  ctx <- .tpbl_season_ctx(req)
  rows <- lapply(.tpbl_rows(body), function(r) {
    c(ctx, list(division_id = r[["id"]], gohoops_division_id = r[["gohoops_id"]],
                gohoops_event_id = r[["gohoops_event_id"]], name = r[["name"]], status = r[["status"]]))
  })
  .tpbl_frame(rows, .tpbl_specs$divisions)
}

#' @noRd
.tpbl_parse_teams <- function(body, req = list()) {
  ctx <- .tpbl_season_ctx(req)
  rows <- lapply(.tpbl_rows(body), function(r) {
    c(ctx, list(team_id = r[["id"]], gohoops_team_id = r[["gohoops_id"]], name = r[["name"]],
                is_real_team = r[["is_real_team"]], status = r[["status"]]))
  })
  .tpbl_frame(rows, .tpbl_specs$teams)
}

#' @noRd
.tpbl_game_row <- function(g, ctx) {
  meta <- .tpbl_obj(g[["meta"]])
  home <- .tpbl_obj(g[["home_team"]])
  away <- .tpbl_obj(g[["away_team"]])
  c(ctx, list(
    game_id = g[["id"]], gohoops_game_id = g[["gohoops_id"]], division_id = g[["division_id"]],
    gohoops_division_id = g[["gohoops_division_id"]], gohoops_season_id = home[["gohoops_season_id"]],
    gohoops_event_id = home[["gohoops_event_id"]], code = g[["code"]], status = g[["status"]],
    is_live = g[["is_live"]], periods = g[["round"]], game_date = g[["game_date"]],
    game_day_of_week = g[["game_day_of_week"]], game_time = g[["game_time"]], tipoff = g[["gamed_at"]],
    venue = g[["venue"]], attendance = meta[["visitors"]],
    home_team_id = home[["id"]], home_gohoops_team_id = home[["gohoops_id"]],
    home_gohoops_squad_id = home[["gohoops_squad_id"]], home_team = home[["name"]],
    home_alt_name = .tpbl_at(home, "meta", "alt_name"), home_score = home[["won_score"]],
    away_team_id = away[["id"]], away_gohoops_team_id = away[["gohoops_id"]],
    away_gohoops_squad_id = away[["gohoops_squad_id"]], away_team = away[["name"]],
    away_alt_name = .tpbl_at(away, "meta", "alt_name"), away_score = away[["won_score"]],
    recap_url = meta[["recap"]], live_stream_url = meta[["live_stream_url"]],
    judgement_report_url = meta[["judgement_report"]], ticket_url = meta[["ticket_url"]]
  ))
}

#' @noRd
.tpbl_parse_games <- function(body, req = list()) {
  ctx <- .tpbl_season_ctx(req)
  .tpbl_frame(lapply(.tpbl_rows(body), .tpbl_game_row, ctx = ctx), .tpbl_specs$games)
}

# ---------------------------------------------------------------------------
# Game routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_parse_game <- function(body, req = list()) {
  if (!.tpbl_is_obj(body) || !.tpbl_is_int(body[["id"]])) return(.tpbl_frame(list(), .tpbl_specs$game))
  .tpbl_frame(list(.tpbl_game_row(body, list())), .tpbl_specs$game)
}

#' @noRd
.tpbl_parse_referees <- function(body, req = list()) {
  refs <- if (.tpbl_is_obj(body)) Filter(.tpbl_is_obj, body[["referees"]] %||% list()) else list()
  gid <- req$game_id %||% .tpbl_at(body, "id")
  rows <- lapply(seq_along(refs), function(n) {
    r <- refs[[n]]
    list(game_id = gid, sequence = n, referee_id = r[["id"]], gohoops_referee_id = r[["gohoops_id"]],
         name = r[["name"]], role = r[["type"]])
  })
  .tpbl_frame(rows, .tpbl_specs$referees)
}

#' Both sides of a box score: `list(side, team object, identity columns)`, home first.
#' @noRd
.tpbl_team_heads <- function(body, req) {
  if (!.tpbl_is_obj(body)) return(list())
  out <- list()
  for (side in c("home", "away")) {
    t <- body[[paste0(side, "_team")]]
    if (!.tpbl_is_obj(t)) next
    ident <- list(game_id = req$game_id, side = side, team_id = t[["id"]], team = t[["name"]],
                  gohoops_squad_id = t[["gohoops_squad_id"]])
    out[[length(out) + 1L]] <- list(side = side, team = t, ident = ident)
  }
  out
}

#' @noRd
.TPBL_BOX_WHO <- c("game_id", "side", "team_id", "team", "gohoops_squad_id", "period", "player_id",
                   "gohoops_person_id", "gohoops_roster_id", "player", "number", "position", "status",
                   "roster_status", "is_starting", "entered")

#' One player line: identity, then every stat column of `spec` read from the line by name.
#' @noRd
.tpbl_player_row <- function(ident, rid, line, spec) {
  c(ident, list(
    player_id = line[["id"]], gohoops_person_id = line[["gohoops_id"]],
    gohoops_roster_id = line[["gohoops_roster_id"]] %||% rid, player = line[["name"]], number = line[["number"]],
    position = line[["positions"]], status = line[["status"]], roster_status = line[["roster_status"]],
    is_starting = line[["is_starting"]], entered = "time_on_court" %in% names(line)
  ), .tpbl_stats(line, spec, .TPBL_BOX_WHO))
}

#' @noRd
.tpbl_parse_box_players <- function(body, req = list()) {
  spec <- .tpbl_specs$box_players
  rows <- list()
  for (h in .tpbl_team_heads(body, req)) {
    players <- .tpbl_obj(.tpbl_at(h$team, "players", "total"))
    for (rid in names(players)) {
      if (.tpbl_is_obj(players[[rid]])) rows[[length(rows) + 1L]] <- .tpbl_player_row(h$ident, rid, players[[rid]], spec)
    }
  }
  .tpbl_frame(rows, spec)
}

#' Per-quarter lines of the players who were on court (a line with time_on_court).
#' @noRd
.tpbl_parse_box_player_periods <- function(body, req = list()) {
  spec <- .tpbl_specs$box_player_periods
  rows <- list()
  for (h in .tpbl_team_heads(body, req)) {
    quarters <- .tpbl_obj(.tpbl_at(h$team, "players", "rounds"))
    for (q in names(quarters)) {
      lines <- .tpbl_obj(quarters[[q]])
      for (rid in names(lines)) {
        line <- lines[[rid]]
        if (.tpbl_is_obj(line) && "time_on_court" %in% names(line)) {
          rows[[length(rows) + 1L]] <- c(.tpbl_player_row(h$ident, rid, line, spec), list(period = q))
        }
      }
    }
  }
  .tpbl_frame(rows, spec)
}

#' @noRd
.TPBL_BOX_TEAM_WHO <- c("game_id", "side", "team_id", "team", "gohoops_squad_id", "opponent_team_id", "period")

#' @noRd
.tpbl_parse_box_teams <- function(body, req = list()) {
  spec <- .tpbl_specs$box_teams
  heads <- .tpbl_team_heads(body, req)
  opp <- stats::setNames(lapply(heads, function(h) h$ident$team_id), vapply(heads, `[[`, "", "side"))
  rows <- lapply(heads, function(h) {
    other <- opp[[if (h$side == "home") "away" else "home"]]
    c(h$ident, list(opponent_team_id = other),
      .tpbl_stats(.tpbl_obj(.tpbl_at(h$team, "teams", "total")), spec, .TPBL_BOX_TEAM_WHO))
  })
  .tpbl_frame(rows, spec)
}

#' @noRd
.tpbl_parse_box_team_periods <- function(body, req = list()) {
  spec <- .tpbl_specs$box_team_periods
  rows <- list()
  for (h in .tpbl_team_heads(body, req)) {
    quarters <- .tpbl_obj(.tpbl_at(h$team, "teams", "rounds"))
    for (q in names(quarters)) {
      if (.tpbl_is_obj(quarters[[q]])) {
        rows[[length(rows) + 1L]] <- c(h$ident, list(period = q), .tpbl_stats(quarters[[q]], spec, .TPBL_BOX_TEAM_WHO))
      }
    }
  }
  .tpbl_frame(rows, spec)
}

# ---------------------------------------------------------------------------
# Division / player routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_parse_standings <- function(body, req = list()) {
  rows <- lapply(.tpbl_rows(body), function(r) {
    list(division_id = req$division_id, rank = r[["rank"]], team_id = .tpbl_at(r, "team", "id"),
         gohoops_team_id = .tpbl_at(r, "team", "gohoops_id"), gohoops_squad_id = .tpbl_at(r, "team", "gohoops_squad_id"),
         team = .tpbl_at(r, "team", "name"), alt_name = .tpbl_at(r, "team", "meta", "alt_name"),
         won = r[["score_won_matches"]], lost = r[["score_lost_matches"]], drawn = r[["score_draw_matches"]],
         games_behind = r[["games_behind"]], streak = r[["streaks"]])
  })
  .tpbl_frame(rows, .tpbl_specs$standings)
}

#' @noRd
.tpbl_parse_standings_against <- function(body, req = list()) {
  rows <- list()
  for (r in .tpbl_rows(body)) {
    for (a in Filter(.tpbl_is_obj, r[["against_result"]] %||% list())) {
      rows[[length(rows) + 1L]] <- list(
        division_id = req$division_id, team_id = .tpbl_at(r, "team", "id"),
        opponent_team_id = .tpbl_at(a, "team", "id"), opponent_gohoops_team_id = .tpbl_at(a, "team", "gohoops_id"),
        opponent = .tpbl_at(a, "team", "name"), won = a[["score_won_matches"]], lost = a[["score_lost_matches"]],
        drawn = a[["score_draw_matches"]]
      )
    }
  }
  .tpbl_frame(rows, .tpbl_specs$standings_against)
}

#' @noRd
.tpbl_parse_roster <- function(body, req = list()) {
  rows <- lapply(.tpbl_rows(body), function(r) {
    meta <- .tpbl_obj(r[["meta"]])
    list(division_id = req$division_id, team_id = .tpbl_at(r, "team", "id") %||% req$team_id,
         team = .tpbl_at(r, "team", "name"), player_id = r[["id"]], gohoops_person_id = r[["gohoops_id"]],
         gohoops_roster_id = r[["gohoops_roster_id"]], gohoops_squad_id = r[["gohoops_squad_id"]],
         gohoops_event_id = r[["gohoops_event_id"]], gohoops_season_id = r[["gohoops_season_id"]],
         player = r[["name"]], alt_name = meta[["alt_name"]], number = r[["number"]], position = meta[["position"]],
         height_cm = meta[["height"]], weight_kg = meta[["weight"]], nationality = meta[["nationality"]],
         national_identity = meta[["national_identity"]],
         national_identity_detail = meta[["national_identity_extra_detail"]], registered = r[["registered"]],
         is_listing = r[["is_listing"]])
  })
  .tpbl_frame(rows, .tpbl_specs$roster)
}

#' @noRd
.tpbl_parse_shots <- function(body, req, spec) {
  ctx <- list(division_id = req$division_id, team_id = req$team_id, player_id = req$player_id,
              rounds = if (length(req$rounds)) paste(req$rounds, collapse = ",") else NULL)
  rows <- lapply(.tpbl_rows(body), function(r) {
    c(ctx, list(is_made = r[["is_made"]], point_x = r[["point_x"]], point_y = r[["point_y"]],
                offense_basket = r[["offense_basket"]]))
  })
  .tpbl_frame(rows, spec)
}

#' @noRd
.tpbl_parse_team_shots <- function(body, req = list()) .tpbl_parse_shots(body, req, .tpbl_specs$team_shots)

#' @noRd
.tpbl_parse_player_shots <- function(body, req = list()) .tpbl_parse_shots(body, req, .tpbl_specs$player_shots)

#' @noRd
.TPBL_LOG_RENAMES <- c(performance_index_rating = "pir", effective_field_goals_percentage = "efg",
                       true_shooting_percentage = "tsp")

#' @noRd
.TPBL_LOG_WHO <- c("player_id", "gohoops_person_id", "gohoops_roster_id", "player", "division_id",
                   "gohoops_division_id", "team_id", "team", "game_id", "gohoops_game_id", "game_title",
                   "home_team_id", "away_team_id", "home_score", "away_score", "venue", "tipoff", "periods_played")

#' @noRd
.tpbl_parse_player_games <- function(body, req = list()) {
  spec <- .tpbl_specs$player_games
  rows <- lapply(.tpbl_rows(body), function(r) {
    game <- .tpbl_obj(r[["game"]])
    player <- .tpbl_obj(r[["player"]])
    stats <- c(.tpbl_obj(r[["accumulated_stats"]]), .tpbl_obj(r[["percentage_stats"]]))
    renamed <- names(stats) %in% names(.TPBL_LOG_RENAMES)
    names(stats)[renamed] <- .TPBL_LOG_RENAMES[names(stats)[renamed]]
    stats <- rev(stats)[!duplicated(rev(names(stats)))] # a later key wins, as in a Python dict merge
    c(list(
      player_id = player[["id"]], gohoops_person_id = player[["gohoops_id"]],
      gohoops_roster_id = player[["gohoops_roster_id"]], player = player[["name"]], division_id = req$division_id,
      gohoops_division_id = game[["gohoops_division_id"]], team_id = .tpbl_at(r, "team", "id"),
      team = .tpbl_at(r, "team", "name"), game_id = game[["id"]], gohoops_game_id = game[["gohoops_id"]],
      game_title = game[["title"]], home_team_id = .tpbl_at(game, "home_team", "id"),
      away_team_id = .tpbl_at(game, "away_team", "id"), home_score = .tpbl_at(game, "home_team", "won_score"),
      away_score = .tpbl_at(game, "away_team", "won_score"), venue = game[["location"]],
      tipoff = game[["gamed_at"]], periods_played = r[["round_count"]]
    ), .tpbl_stats(stats, spec, .TPBL_LOG_WHO))
  })
  .tpbl_frame(rows, spec)
}

#' The `hoopR_data` tibble of a wrapper.
#' @noRd
.tpbl_out <- function(df, what) make_hoopR_data(df, paste("TPBL", what, "from api.tpbl.basketball"), Sys.time())

# ---------------------------------------------------------------------------
# Documented columns (sportsdataverse-py SPECS; change them there first, then copy them here)
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_specs <- list(
  seasons = c(
    season = "i", season_id = "i", gohoops_season_id = "i", name = "s", status = "s", started_at = "s",
    ended_at = "s"
  ),
  divisions = c(
    season = "i", season_id = "i", division_id = "i", gohoops_division_id = "i", gohoops_event_id = "i",
    name = "s", status = "s"
  ),
  teams = c(
    season = "i", season_id = "i", team_id = "i", gohoops_team_id = "i", name = "s", is_real_team = "b",
    status = "s"
  ),
  games = c(
    season = "i", season_id = "i", game_id = "i", gohoops_game_id = "i", division_id = "i",
    gohoops_division_id = "i", gohoops_season_id = "i", gohoops_event_id = "i", code = "s", status = "s",
    is_live = "b", periods = "i", game_date = "d", game_day_of_week = "s", game_time = "s", tipoff = "t",
    venue = "s", attendance = "i", home_team_id = "i", home_gohoops_team_id = "i", home_gohoops_squad_id = "i",
    home_team = "s", home_alt_name = "s", home_score = "i", away_team_id = "i", away_gohoops_team_id = "i",
    away_gohoops_squad_id = "i", away_team = "s", away_alt_name = "s", away_score = "i", recap_url = "s",
    live_stream_url = "s", judgement_report_url = "s", ticket_url = "s"
  ),
  referees = c(
    game_id = "i", sequence = "i", referee_id = "i", gohoops_referee_id = "i", name = "s", role = "s"
  ),
  standings = c(
    division_id = "i", rank = "i", team_id = "i", gohoops_team_id = "i", gohoops_squad_id = "i", team = "s",
    alt_name = "s", won = "i", lost = "i", drawn = "i", games_behind = "f", streak = "s"
  ),
  standings_against = c(
    division_id = "i", team_id = "i", opponent_team_id = "i", opponent_gohoops_team_id = "i", opponent = "s",
    won = "i", lost = "i", drawn = "i"
  ),
  box_players = c(
    game_id = "i", side = "s", team_id = "i", team = "s", gohoops_squad_id = "i", player_id = "i",
    gohoops_person_id = "i", gohoops_roster_id = "i", player = "s", number = "s", position = "s", status = "s",
    roster_status = "s", is_starting = "b", entered = "b", time_on_court = "i", score = "i", plus_minus = "i",
    field_goals_made = "i", field_goals_missed = "i", field_goals_attempted = "i",
    field_goals_percentage = "f", two_pointers_made = "i", two_pointers_missed = "i",
    two_pointers_attempted = "i", two_pointers_percentage = "f", three_pointers_made = "i",
    three_pointers_missed = "i", three_pointers_attempted = "i", three_pointers_percentage = "f",
    free_throws_made = "i", free_throws_missed = "i", free_throws_attempted = "i",
    free_throws_percentage = "f", rebounds = "i", defensive_rebounds = "i", offensive_rebounds = "i",
    defensive_fouls = "i", offensive_fouls = "i", personal_fouls = "i", fouls = "i", assists = "i",
    steals = "i", blocks = "i", turnovers = "i", points_in_paint = "i", second_chance_points = "i",
    fast_break_points = "i", efficiency = "i", efg = "f", tsp = "f", pir = "i",
    field_goals_made_in_the_paint = "i", field_goals_missed_in_the_paint = "i",
    field_goals_attempted_in_the_paint = "i", field_goals_made_on_fast_break = "i",
    field_goals_missed_on_fast_break = "i", field_goals_attempted_on_fast_break = "i",
    field_goals_made_on_second_chance = "i", field_goals_missed_on_second_chance = "i",
    field_goals_attempted_on_second_chance = "i", technical_fouls = "i", unsportsmanlike_fouls = "i",
    disqualifying_fouls = "i", bad_pass_turnovers = "i", ball_handling_turnovers = "i",
    out_of_bounds_turnovers = "i", travel_turnovers = "i", three_seconds_turnovers = "i",
    five_seconds_turnovers = "i", back_court_turnovers = "i", offensive_goal_tending_turnovers = "i",
    double_dribble_turnovers = "i", carry_turnovers = "i", offensive_foul_turnovers = "i",
    other_turnovers = "i", points_off_turnovers = "i", two_pointers_jump_shot_made = "i",
    two_pointers_jump_shot_missed = "i", two_pointers_jump_shot_attempted = "i",
    three_pointers_jump_shot_made = "i", three_pointers_jump_shot_missed = "i",
    three_pointers_jump_shot_attempted = "i", two_pointers_layup_made = "i", two_pointers_layup_missed = "i",
    two_pointers_layup_attempted = "i", two_pointers_driving_layup_made = "i",
    two_pointers_driving_layup_missed = "i", two_pointers_driving_layup_attempted = "i",
    two_pointers_dunk_made = "i", two_pointers_dunk_missed = "i", two_pointers_dunk_attempted = "i",
    two_pointers_putback_dunk_made = "i", two_pointers_putback_dunk_missed = "i",
    two_pointers_putback_dunk_attempted = "i", two_pointers_putback_tip_in_made = "i",
    two_pointers_putback_tip_in_missed = "i", two_pointers_putback_tip_in_attempted = "i",
    two_pointers_alley_oop_made = "i", two_pointers_alley_oop_missed = "i",
    two_pointers_alley_oop_attempted = "i", two_pointers_hook_shot_made = "i",
    two_pointers_hook_shot_missed = "i", two_pointers_hook_shot_attempted = "i",
    three_pointers_hook_shot_made = "i", three_pointers_hook_shot_missed = "i",
    three_pointers_hook_shot_attempted = "i", two_pointers_floating_jump_shot_made = "i",
    two_pointers_floating_jump_shot_missed = "i", two_pointers_floating_jump_shot_attempted = "i",
    three_pointers_floating_jump_shot_made = "i", three_pointers_floating_jump_shot_missed = "i",
    three_pointers_floating_jump_shot_attempted = "i", two_pointers_fadeaway_jump_shot_made = "i",
    two_pointers_fadeaway_jump_shot_missed = "i", two_pointers_fadeaway_jump_shot_attempted = "i",
    three_pointers_fadeaway_jump_shot_made = "i", three_pointers_fadeaway_jump_shot_missed = "i",
    three_pointers_fadeaway_jump_shot_attempted = "i", two_pointers_turnaround_jump_shot_made = "i",
    two_pointers_turnaround_jump_shot_missed = "i", two_pointers_turnaround_jump_shot_attempted = "i",
    three_pointers_turnaround_jump_shot_made = "i", three_pointers_turnaround_jump_shot_missed = "i",
    three_pointers_turnaround_jump_shot_attempted = "i", two_pointers_step_back_jump_shot_made = "i",
    two_pointers_step_back_jump_shot_missed = "i", two_pointers_step_back_jump_shot_attempted = "i",
    three_pointers_step_back_jump_shot_made = "i", three_pointers_step_back_jump_shot_missed = "i",
    three_pointers_step_back_jump_shot_attempted = "i", two_pointers_pull_up_jump_shot_made = "i",
    two_pointers_pull_up_jump_shot_missed = "i", two_pointers_pull_up_jump_shot_attempted = "i",
    three_pointers_pull_up_jump_shot_made = "i", three_pointers_pull_up_jump_shot_missed = "i",
    three_pointers_pull_up_jump_shot_attempted = "i"
  ),
  box_player_periods = c(
    game_id = "i", side = "s", team_id = "i", team = "s", gohoops_squad_id = "i", period = "i",
    player_id = "i", gohoops_person_id = "i", gohoops_roster_id = "i", player = "s", number = "s",
    position = "s", status = "s", roster_status = "s", is_starting = "b", entered = "b", time_on_court = "i",
    score = "i", plus_minus = "i", field_goals_made = "i", field_goals_missed = "i",
    field_goals_attempted = "i", field_goals_percentage = "f", two_pointers_made = "i",
    two_pointers_missed = "i", two_pointers_attempted = "i", two_pointers_percentage = "f",
    three_pointers_made = "i", three_pointers_missed = "i", three_pointers_attempted = "i",
    three_pointers_percentage = "f", free_throws_made = "i", free_throws_missed = "i",
    free_throws_attempted = "i", free_throws_percentage = "f", rebounds = "i", defensive_rebounds = "i",
    offensive_rebounds = "i", defensive_fouls = "i", offensive_fouls = "i", personal_fouls = "i", fouls = "i",
    assists = "i", steals = "i", blocks = "i", turnovers = "i", points_in_paint = "i",
    second_chance_points = "i", fast_break_points = "i", efg = "f", tsp = "f", pir = "i",
    field_goals_made_in_the_paint = "i", field_goals_missed_in_the_paint = "i",
    field_goals_attempted_in_the_paint = "i", field_goals_made_on_fast_break = "i",
    field_goals_missed_on_fast_break = "i", field_goals_attempted_on_fast_break = "i",
    field_goals_made_on_second_chance = "i", field_goals_missed_on_second_chance = "i",
    field_goals_attempted_on_second_chance = "i", technical_fouls = "i", unsportsmanlike_fouls = "i",
    disqualifying_fouls = "i", bad_pass_turnovers = "i", ball_handling_turnovers = "i",
    out_of_bounds_turnovers = "i", travel_turnovers = "i", three_seconds_turnovers = "i",
    five_seconds_turnovers = "i", back_court_turnovers = "i", offensive_goal_tending_turnovers = "i",
    double_dribble_turnovers = "i", carry_turnovers = "i", offensive_foul_turnovers = "i",
    other_turnovers = "i", points_off_turnovers = "i", two_pointers_jump_shot_made = "i",
    two_pointers_jump_shot_missed = "i", two_pointers_jump_shot_attempted = "i",
    three_pointers_jump_shot_made = "i", three_pointers_jump_shot_missed = "i",
    three_pointers_jump_shot_attempted = "i", two_pointers_layup_made = "i", two_pointers_layup_missed = "i",
    two_pointers_layup_attempted = "i", two_pointers_driving_layup_made = "i",
    two_pointers_driving_layup_missed = "i", two_pointers_driving_layup_attempted = "i",
    two_pointers_dunk_made = "i", two_pointers_dunk_missed = "i", two_pointers_dunk_attempted = "i",
    two_pointers_putback_dunk_made = "i", two_pointers_putback_dunk_missed = "i",
    two_pointers_putback_dunk_attempted = "i", two_pointers_putback_tip_in_made = "i",
    two_pointers_putback_tip_in_missed = "i", two_pointers_putback_tip_in_attempted = "i",
    two_pointers_alley_oop_made = "i", two_pointers_alley_oop_missed = "i",
    two_pointers_alley_oop_attempted = "i", two_pointers_hook_shot_made = "i",
    two_pointers_hook_shot_missed = "i", two_pointers_hook_shot_attempted = "i",
    three_pointers_hook_shot_made = "i", three_pointers_hook_shot_missed = "i",
    three_pointers_hook_shot_attempted = "i", two_pointers_floating_jump_shot_made = "i",
    two_pointers_floating_jump_shot_missed = "i", two_pointers_floating_jump_shot_attempted = "i",
    three_pointers_floating_jump_shot_made = "i", three_pointers_floating_jump_shot_missed = "i",
    three_pointers_floating_jump_shot_attempted = "i", two_pointers_fadeaway_jump_shot_made = "i",
    two_pointers_fadeaway_jump_shot_missed = "i", two_pointers_fadeaway_jump_shot_attempted = "i",
    three_pointers_fadeaway_jump_shot_made = "i", three_pointers_fadeaway_jump_shot_missed = "i",
    three_pointers_fadeaway_jump_shot_attempted = "i", two_pointers_turnaround_jump_shot_made = "i",
    two_pointers_turnaround_jump_shot_missed = "i", two_pointers_turnaround_jump_shot_attempted = "i",
    three_pointers_turnaround_jump_shot_made = "i", three_pointers_turnaround_jump_shot_missed = "i",
    three_pointers_turnaround_jump_shot_attempted = "i", two_pointers_step_back_jump_shot_made = "i",
    two_pointers_step_back_jump_shot_missed = "i", two_pointers_step_back_jump_shot_attempted = "i",
    three_pointers_step_back_jump_shot_made = "i", three_pointers_step_back_jump_shot_missed = "i",
    three_pointers_step_back_jump_shot_attempted = "i", two_pointers_pull_up_jump_shot_made = "i",
    two_pointers_pull_up_jump_shot_missed = "i", two_pointers_pull_up_jump_shot_attempted = "i",
    three_pointers_pull_up_jump_shot_made = "i", three_pointers_pull_up_jump_shot_missed = "i",
    three_pointers_pull_up_jump_shot_attempted = "i"
  ),
  box_teams = c(
    game_id = "i", side = "s", team_id = "i", team = "s", gohoops_squad_id = "i", opponent_team_id = "i",
    field_goals_made = "i", field_goals_missed = "i", field_goals_attempted = "i",
    field_goals_percentage = "f", two_pointers_made = "i", two_pointers_missed = "i",
    two_pointers_attempted = "i", two_pointers_percentage = "f", three_pointers_made = "i",
    three_pointers_missed = "i", three_pointers_attempted = "i", three_pointers_percentage = "f",
    free_throws_made = "i", free_throws_missed = "i", free_throws_attempted = "i",
    free_throws_percentage = "f", won_score = "i", total_won_score = "i", lost_score = "i",
    total_lost_score = "i", rebounds = "i", defensive_rebounds = "i", offensive_rebounds = "i",
    defensive_fouls = "i", offensive_fouls = "i", personal_fouls = "i", fouls = "i", assists = "i",
    steals = "i", blocks = "i", turnovers = "i", points_in_paint = "i", second_chance_points = "i",
    fast_break_points = "i"
  ),
  box_team_periods = c(
    game_id = "i", side = "s", team_id = "i", team = "s", gohoops_squad_id = "i", period = "i",
    won_score = "i", time_on_court = "i", lost_score = "i", total_won_score = "i", total_lost_score = "i",
    field_goals_made = "i", field_goals_missed = "i", field_goals_attempted = "i",
    field_goals_percentage = "f", two_pointers_made = "i", two_pointers_missed = "i",
    two_pointers_attempted = "i", two_pointers_percentage = "f", three_pointers_made = "i",
    three_pointers_missed = "i", three_pointers_attempted = "i", three_pointers_percentage = "f",
    free_throws_made = "i", free_throws_missed = "i", free_throws_attempted = "i",
    free_throws_percentage = "f", rebounds = "i", defensive_rebounds = "i", offensive_rebounds = "i",
    defensive_fouls = "i", offensive_fouls = "i", personal_fouls = "i", fouls = "i", assists = "i",
    steals = "i", blocks = "i", turnovers = "i", points_in_paint = "i", second_chance_points = "i",
    fast_break_points = "i"
  ),
  roster = c(
    division_id = "i", team_id = "i", team = "s", player_id = "i", gohoops_person_id = "i",
    gohoops_roster_id = "i", gohoops_squad_id = "i", gohoops_event_id = "i", gohoops_season_id = "i",
    player = "s", alt_name = "s", number = "s", position = "s", height_cm = "i", weight_kg = "f",
    nationality = "s", national_identity = "s", national_identity_detail = "s", registered = "b",
    is_listing = "b"
  ),
  team_shots = c(
    division_id = "i", team_id = "i", rounds = "s", is_made = "b", point_x = "i", point_y = "i",
    offense_basket = "i"
  ),
  player_shots = c(
    division_id = "i", player_id = "i", is_made = "b", point_x = "i", point_y = "i", offense_basket = "i"
  ),
  player_games = c(
    player_id = "i", gohoops_person_id = "i", gohoops_roster_id = "i", player = "s", division_id = "i",
    gohoops_division_id = "i", team_id = "i", team = "s", game_id = "i", gohoops_game_id = "i",
    game_title = "s", home_team_id = "i", away_team_id = "i", home_score = "i", away_score = "i", venue = "s",
    tipoff = "t", periods_played = "i", score = "i", rebounds = "i", assists = "i", steals = "i", blocks = "i",
    turnovers = "i", fouls = "i", roster_fouls = "i", bench_fouls = "i", time_on_court = "i",
    two_pointers_made = "i", two_pointers_missed = "i", two_pointers_attempted = "i",
    three_pointers_made = "i", three_pointers_missed = "i", three_pointers_attempted = "i",
    free_throws_made = "i", free_throws_missed = "i", free_throws_attempted = "i", field_goals_made = "i",
    field_goals_missed = "i", field_goals_attempted = "i", field_goals_made_in_the_paint = "i",
    field_goals_missed_in_the_paint = "i", field_goals_attempted_in_the_paint = "i",
    field_goals_made_on_fast_break = "i", field_goals_missed_on_fast_break = "i",
    field_goals_attempted_on_fast_break = "i", field_goals_made_on_second_chance = "i",
    field_goals_missed_on_second_chance = "i", field_goals_attempted_on_second_chance = "i",
    defensive_rebounds = "i", offensive_rebounds = "i", offensive_fouls = "i", defensive_fouls = "i",
    personal_fouls = "i", technical_fouls = "i", unsportsmanlike_fouls = "i", disqualifying_fouls = "i",
    bad_pass_turnovers = "i", ball_handling_turnovers = "i", out_of_bounds_turnovers = "i",
    travel_turnovers = "i", three_seconds_turnovers = "i", five_seconds_turnovers = "i",
    back_court_turnovers = "i", offensive_goal_tending_turnovers = "i", double_dribble_turnovers = "i",
    carry_turnovers = "i", offensive_foul_turnovers = "i", other_turnovers = "i", plus_minus = "i",
    fast_break_points = "i", second_chance_points = "i", points_in_paint = "i", points_off_turnovers = "i",
    two_pointers_jump_shot_made = "i", two_pointers_jump_shot_missed = "i",
    two_pointers_jump_shot_attempted = "i", three_pointers_jump_shot_made = "i",
    three_pointers_jump_shot_missed = "i", three_pointers_jump_shot_attempted = "i",
    two_pointers_layup_made = "i", two_pointers_layup_missed = "i", two_pointers_layup_attempted = "i",
    two_pointers_driving_layup_made = "i", two_pointers_driving_layup_missed = "i",
    two_pointers_driving_layup_attempted = "i", two_pointers_dunk_made = "i", two_pointers_dunk_missed = "i",
    two_pointers_dunk_attempted = "i", two_pointers_putback_dunk_made = "i",
    two_pointers_putback_dunk_missed = "i", two_pointers_putback_dunk_attempted = "i",
    two_pointers_putback_tip_in_made = "i", two_pointers_putback_tip_in_missed = "i",
    two_pointers_putback_tip_in_attempted = "i", two_pointers_alley_oop_made = "i",
    two_pointers_alley_oop_missed = "i", two_pointers_alley_oop_attempted = "i",
    two_pointers_hook_shot_made = "i", two_pointers_hook_shot_missed = "i",
    two_pointers_hook_shot_attempted = "i", three_pointers_hook_shot_made = "i",
    three_pointers_hook_shot_missed = "i", three_pointers_hook_shot_attempted = "i",
    two_pointers_floating_jump_shot_made = "i", two_pointers_floating_jump_shot_missed = "i",
    two_pointers_floating_jump_shot_attempted = "i", three_pointers_floating_jump_shot_made = "i",
    three_pointers_floating_jump_shot_missed = "i", three_pointers_floating_jump_shot_attempted = "i",
    two_pointers_fadeaway_jump_shot_made = "i", two_pointers_fadeaway_jump_shot_missed = "i",
    two_pointers_fadeaway_jump_shot_attempted = "i", three_pointers_fadeaway_jump_shot_made = "i",
    three_pointers_fadeaway_jump_shot_missed = "i", three_pointers_fadeaway_jump_shot_attempted = "i",
    two_pointers_turnaround_jump_shot_made = "i", two_pointers_turnaround_jump_shot_missed = "i",
    two_pointers_turnaround_jump_shot_attempted = "i", three_pointers_turnaround_jump_shot_made = "i",
    three_pointers_turnaround_jump_shot_missed = "i", three_pointers_turnaround_jump_shot_attempted = "i",
    two_pointers_step_back_jump_shot_made = "i", two_pointers_step_back_jump_shot_missed = "i",
    two_pointers_step_back_jump_shot_attempted = "i", three_pointers_step_back_jump_shot_made = "i",
    three_pointers_step_back_jump_shot_missed = "i", three_pointers_step_back_jump_shot_attempted = "i",
    two_pointers_pull_up_jump_shot_made = "i", two_pointers_pull_up_jump_shot_missed = "i",
    two_pointers_pull_up_jump_shot_attempted = "i", three_pointers_pull_up_jump_shot_made = "i",
    three_pointers_pull_up_jump_shot_missed = "i", three_pointers_pull_up_jump_shot_attempted = "i",
    efficiency = "i", pir = "i", two_pointers_percentage = "f", three_pointers_percentage = "f",
    free_throws_percentage = "f", field_goals_percentage = "f", turnovers_percentage = "f", efg = "f",
    tsp = "f"
  )
)
.tpbl_specs$game <- .tpbl_specs$games
