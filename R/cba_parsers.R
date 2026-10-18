# cba_parsers.R -- frames of the CBA wrappers, the R mirror of sdv-py
# sportsdataverse/basketball/cba/cba_parsers.py + cba_dtypes.py (origin/main e3d232e).
#
# Every parser takes the DECRYPTED body (stamped with `_request` = list(schedule_id) on the game
# routes that answer an object) and returns a tibble with snake_case columns (.intl_clean_names, the
# port of sdv-py dl_utils.underscore), typed by .cba_dtypes. An empty or unrecognised body gives a
# zero-row tibble with the documented columns.
#
# Row rule (.cba_routes, one entry per parser): a list body is the rows; `records` is the page of a
# paged route; a two-sided body (homeCounts / visitingCounts, ...) gives one block per side with a
# `side` column (home / away); a dict body is one row. Nested lists (the play-by-play
# player_cn_names) become compact JSON text. createdBy / lastModifiedBy are dropped.
#
# Casts (.cba_cast_col): display text of a number is parsed ('21.6' -> 21.6, '1,234' -> 1234,
# '12.0' -> 12 under an integer column, '12.5' there is NA; 'nan' / 'inf' / '' are NA). Code "p" is a
# percent column whose route sends percent STRINGS: every string there is percent display text and
# becomes a FRACTION 0-1, with or without the % sign ('39.4%' -> 0.394, '100' -> 1); a JSON number
# under "p" is taken as already that fraction. Under "f" a '15.3%' keeps the route's 0-100 scale.
# Code "I" (R only): an integer id too wide for R (the 19-digit roster registration id), kept as its
# exact digits.
#
# Duplicate rows: advance-count and schedule-other-data repeat player rows in some games; those
# parsers keep the FIRST row per player_id.

#' short -> row rule and the side keys.
#' @noRd
.cba_routes <- list(
  seasons = list("list"), match_types = list("list"), team_options = list("list"), teams = list("list"),
  schedule_month = list("list"), schedule_day = list("list"), game_info = list("one"),
  player_box = list("sides", c("homeCounts", "visitingCounts")),
  period_scores = list("periods", c("home", "visiting")),
  game_team_shots = list("list"),
  player_advanced = list("sides", c("homes", "visitings")),
  player_extras = list("sides", c("homePlayers", "visitingPlayers")),
  game_team_four = list("list"),
  best_player = list("sideobj", c("hostBestPlayer", "guestBestPlayer")),
  best_stats = list("sides", c("hostTeamBestData", "guestTeamBestData")),
  rosters = list("sides", c("hostPlayers", "guestPlayers")),
  report_status = list("one"), pbp = list("records"), team_counts = list("list"), team_basic = list("list"),
  team_four = list("list"), team_overview = list("records"), team_shots = list("records"),
  player_base = list("records"), player_offensive = list("records"), player_defensive = list("records"),
  player_shots = list("records")
)
#' @noRd
.CBA_DEDUPE <- c("player_advanced", "player_extras")
#' @noRd
.CBA_PERIODS <- c("oneScore", "twoScore", "threeScore", "fourScore", "fiveScore", "sixScore", "sevenScore")

#' A scalar as a number: list(num, text); `num` is NA when it does not convert.
#' @noRd
.cba_num <- function(v) {
  if (is.null(v) || length(v) != 1L || is.list(v) || is.logical(v)) return(list(num = NA_real_, text = FALSE))
  if (is.numeric(v)) return(list(num = if (is.finite(v)) as.numeric(v) else NA_real_, text = FALSE))
  if (!is.character(v)) return(list(num = NA_real_, text = FALSE))
  s <- gsub(",", "", trimws(sub("%+$", "", trimws(v))), fixed = TRUE)
  ok <- grepl("^[+-]?([0-9]+\\.?[0-9]*|\\.[0-9]+)([eE][+-]?[0-9]+)?$", s)
  num <- if (ok) as.numeric(s) else NA_real_
  list(num = if (is.finite(num)) num else NA_real_, text = TRUE)
}

#' Python `str()` of a scalar or compact JSON of a list (sdv-py's String cast).
#' @noRd
.cba_str <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (is.list(v)) {
    return(as.character(jsonlite::toJSON(v, auto_unbox = TRUE, null = "null", na = "null", digits = NA)))
  }
  if (is.logical(v)) return(if (isTRUE(v)) "True" else "False")
  if (is.double(v)) {
    # jsonlite reads a JSON integer past 2^31 as a double: Python str() of that int has no ".0"
    if (is.finite(v) && v == trunc(v) && abs(v) >= 2^31 && abs(v) < 1e16) return(.cba_num_text(v))
    if (is.finite(v) && v == trunc(v) && abs(v) < 1e16) return(paste0(.cba_num_text(v), ".0"))
    for (d in 15:17) {
      s <- sprintf("%.*g", d, v)
      if (as.numeric(s) == v) break
    }
    return(s)
  }
  as.character(v)
}

#' The column of `vals` (one raw value or NULL per row) as dtype `code`.
#' @noRd
.cba_cast_col <- function(vals, code) {
  switch(code,
    s = vapply(vals, .cba_str, character(1), USE.NAMES = FALSE),
    b = vapply(vals, function(v) if (is.logical(v) && length(v) == 1L) v else NA, logical(1), USE.NAMES = FALSE),
    i = vapply(vals, function(v) {
      n <- .cba_num(v)$num
      if (is.na(n) || n != trunc(n) || abs(n) > .Machine$integer.max) NA_integer_ else as.integer(n)
    }, integer(1), USE.NAMES = FALSE),
    I = vapply(vals, function(v) {
      if (is.character(v) && length(v) == 1L && grepl("^-?[0-9]+$", v)) return(v)
      n <- .cba_num(v)$num
      if (is.na(n) || n != trunc(n)) NA_character_ else .cba_num_text(n)
    }, character(1), USE.NAMES = FALSE),
    f = vapply(vals, function(v) .cba_num(v)$num, numeric(1), USE.NAMES = FALSE),
    p = vapply(vals, function(v) {
      n <- .cba_num(v)
      if (n$text && !is.na(n$num)) round(n$num / 100, 6) else n$num
    }, numeric(1), USE.NAMES = FALSE)
  )
}

#' A wire row as a flat row: snake_case names, operator ids and the request stamp dropped.
#' @noRd
.cba_flat <- function(row) {
  keep <- !names(row) %in% c(.CBA_REDACT_KEYS, "_request")
  out <- list()
  for (i in which(keep)) out[.intl_clean_names(names(row)[[i]])] <- list(row[[i]])
  out
}

#' `a` updated by `b` (Python `{**a, **b}`: NULL values kept, a's key order first).
#' @noRd
.cba_merge <- function(a, b) {
  for (k in names(b)) a[k] <- list(b[[k]])
  a
}

#' The flat rows of `raw` under the route's row rule (`list()` for an unrecognised body).
#' @noRd
.cba_rows <- function(short, raw) {
  route <- .cba_routes[[short]]
  rule <- route[[1]]
  keys <- if (length(route) > 1L) route[[2]] else character()
  spec <- names(.cba_dtypes[[short]])
  req <- if (.cba_is_obj(raw)) raw[["_request"]] else NULL
  extra <- if (.cba_is_obj(raw) && "schedule_id" %in% spec) {
    list(schedule_id = if (.cba_is_obj(req)) req[["schedule_id"]] else NULL)
  } else {
    list()
  }
  out <- list()
  if (rule == "list") {
    if (.cba_is_arr(raw)) out <- lapply(Filter(.cba_is_obj, raw), .cba_flat)
  } else if (rule == "records") {
    recs <- if (.cba_is_obj(raw)) raw[["records"]] else NULL
    if (.cba_is_arr(recs)) out <- lapply(Filter(.cba_is_obj, recs), function(r) .cba_merge(extra, .cba_flat(r)))
  } else if (rule == "one") {
    if (.cba_is_obj(raw) && length(intersect(names(.cba_flat(raw)), spec))) out <- list(.cba_merge(extra, .cba_flat(raw)))
  } else if (rule %in% c("sides", "sideobj") && .cba_is_obj(raw)) {
    for (i in 1:2) {
      block <- raw[[keys[[i]]]]
      if (.cba_is_obj(block)) block <- list(block)
      seen <- character()
      for (r in if (.cba_is_arr(block)) block else list()) {
        if (!.cba_is_obj(r)) next
        if (short %in% .CBA_DEDUPE) {
          k <- .cba_key(r[["playerId"]])
          if (is.na(k) || k %in% seen) next
          seen <- c(seen, k)
        }
        out[[length(out) + 1L]] <- .cba_merge(.cba_merge(extra, list(side = c("home", "away")[[i]])), .cba_flat(r))
      }
    }
  } else if (rule == "periods" && .cba_is_obj(raw)) {
    for (i in 1:2) {
      block <- raw[[keys[[i]]]]
      if (!.cba_is_obj(block)) next
      for (n in seq_along(.CBA_PERIODS)) {
        v <- block[[.CBA_PERIODS[[n]]]]
        if (!is.null(v)) {
          out[[length(out) + 1L]] <- .cba_merge(extra, list(side = c("home", "away")[[i]], period = n, points = v))
        }
      }
    }
  }
  out
}

#' The typed frame of `raw` for parser `short`; a wire column the full bodies never showed is text.
#' @noRd
.cba_frame <- function(short, raw) {
  rows <- .cba_rows(short, raw)
  spec <- .cba_dtypes[[short]]
  extra <- setdiff(unique(unlist(lapply(rows, names), use.names = FALSE)), names(spec))
  spec <- c(spec, structure(rep("s", length(extra)), names = extra))
  cols <- lapply(names(spec), function(col) .cba_cast_col(lapply(rows, function(r) r[[col]]), spec[[col]]))
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

#' @noRd
.cba_out <- function(short, raw, type) make_hoopR_data(.cba_frame(short, raw), type, Sys.time())

# Column dtypes, one map per parser: sdv-py cba_dtypes.DTYPES (generated there by
# tools/codegen/gen_cba.py from full-body presence sidecars). Codes: "i" integer, "f" double, "p" double
# from a percent string (a FRACTION 0-1), "b" logical, "s" character; "I" (R only) exact-digits
# character for an id wider than R's integer.
.cba_dtypes <- list(
  seasons = c(
    is_default = "i",
    key = "s",
    value = "s"
  ),
  match_types = c(
    is_default = "i",
    key = "s",
    value = "s"
  ),
  team_options = c(
    is_default = "i",
    key = "s",
    value = "s"
  ),
  teams = c(
    club = "s",
    team_cn_alias = "s",
    team_id = "i",
    team_logo = "s"
  ),
  schedule_month = c(
    schedule_num = "i",
    schedule_time = "s"
  ),
  schedule_day = c(
    home_team_id = "i",
    home_team_logo = "s",
    home_team_lose = "i",
    home_team_name = "s",
    home_team_score = "i",
    home_team_win = "i",
    is_events = "i",
    is_report = "i",
    match_order = "i",
    match_type_id = "i",
    minutes = "i",
    quarter = "i",
    round = "i",
    round_desc = "s",
    schedule_id = "i",
    schedule_num = "i",
    schedule_time = "s",
    schedule_type_name = "s",
    season = "i",
    seconds = "f",
    status = "i",
    visiting_team_id = "i",
    visiting_team_logo = "s",
    visiting_team_lose = "i",
    visiting_team_name = "s",
    visiting_team_score = "i",
    visiting_team_win = "i"
  ),
  game_info = c(
    schedule_id = "i",
    count = "i",
    guest_color = "s",
    guest_score = "i",
    guest_team_id = "i",
    guest_team_logo = "s",
    guest_team_name = "s",
    host_color = "s",
    host_score = "i",
    host_team_id = "i",
    host_team_logo = "s",
    host_team_name = "s",
    schedule_time = "s"
  ),
  player_box = c(
    schedule_id = "i",
    side = "s",
    assists = "i",
    blocked = "i",
    cn_alias = "s",
    field_goals = "i",
    field_goals_attempted = "i",
    field_goals_percentage = "f",
    fouls = "i",
    free_throws = "i",
    free_throws_attempted = "i",
    free_throws_percentage = "f",
    game_start = "i",
    number = "s",
    player_id = "i",
    plus_minus = "i",
    points = "i",
    rebounds = "i",
    rebounds_defensive = "i",
    rebounds_offensive = "i",
    steals = "i",
    three_point_attempted = "i",
    three_point_goals = "i",
    three_point_percentage = "f",
    turnovers = "i",
    up_time = "i"
  ),
  period_scores = c(
    schedule_id = "i",
    side = "s",
    period = "i",
    points = "i"
  ),
  game_team_shots = c(
    bout_no_points_sort = "f",
    bout_point_sort = "f",
    bout_subtract_points_sort = "f",
    guard_field_goals_at_rim = "p",
    guard_field_goals_at_rim_rank = "f",
    guard_field_goals_at_rim_sort = "f",
    guard_hit_at_rim_made_rate = "p",
    guard_hit_at_rim_made_rate_rank = "f",
    guard_hit_at_rim_made_rate_sort = "f",
    guard_hit_middle_rate = "p",
    guard_hit_middle_rate_rank = "f",
    guard_hit_middle_rate_sort = "f",
    guard_middle_rate = "p",
    guard_middle_rate_rank = "f",
    guard_middle_rate_sort = "f",
    guard_real_point = "p",
    guard_real_point_rank = "f",
    guard_real_point_sort = "f",
    guard_three_goals_rate = "p",
    guard_three_goals_rate_rank = "f",
    guard_three_goals_rate_sort = "f",
    guard_three_rate = "p",
    guard_three_rate_rank = "f",
    guard_three_rate_sort = "f",
    is_avg = "i",
    num = "f",
    offensive_field_goals_at_rim = "p",
    offensive_field_goals_at_rim_rank = "f",
    offensive_field_goals_at_rim_sort = "f",
    offensive_hit_at_rim_made_rate = "p",
    offensive_hit_at_rim_made_rate_rank = "f",
    offensive_hit_at_rim_made_rate_sort = "f",
    offensive_hit_middle_rate = "p",
    offensive_hit_middle_rate_rank = "f",
    offensive_hit_middle_rate_sort = "f",
    offensive_middle_rate = "p",
    offensive_middle_rate_rank = "f",
    offensive_middle_rate_sort = "f",
    offensive_real_point = "p",
    offensive_real_point_rank = "f",
    offensive_real_point_sort = "f",
    offensive_three_goals_rate = "p",
    offensive_three_goals_rate_rank = "f",
    offensive_three_goals_rate_sort = "f",
    offensive_three_rate = "p",
    offensive_three_rate_rank = "f",
    offensive_three_rate_sort = "f",
    season = "i",
    team_id = "i",
    team_name = "s"
  ),
  player_advanced = c(
    schedule_id = "i",
    side = "s",
    assists_percentage = "p",
    assists_percentage_rank = "f",
    assists_percentage_sort = "f",
    blocked_percentage = "p",
    blocked_percentage_rank = "f",
    blocked_percentage_sort = "f",
    cn_alias = "s",
    field_goals_at_rim_percentage = "s",
    field_goals_at_rim_percentage_rank = "s",
    field_goals_at_rim_percentage_sort = "s",
    field_goals_mid_percentage = "s",
    field_goals_mid_percentage_rank = "s",
    field_goals_mid_percentage_sort = "s",
    game_start = "i",
    is_color = "i",
    number = "s",
    player_id = "i",
    player_times = "i",
    position = "s",
    rebounds_defensive_percentage = "p",
    rebounds_defensive_percentage_rank = "f",
    rebounds_defensive_percentage_sort = "f",
    rebounds_offensive_percentage = "p",
    rebounds_offensive_percentage_rank = "f",
    rebounds_offensive_percentage_sort = "f",
    steals_percentage = "p",
    steals_percentage_rank = "f",
    steals_percentage_sort = "f",
    team_id = "i",
    true_shooting_percentage = "p",
    true_shooting_percentage_rank = "f",
    true_shooting_percentage_sort = "f",
    turn_share = "p",
    turn_share_rank = "f",
    turn_share_sort = "f",
    turnovers_percentage = "p",
    turnovers_percentage_rank = "f",
    turnovers_percentage_sort = "f",
    type = "i",
    up_time = "i"
  ),
  player_extras = c(
    schedule_id = "i",
    side = "s",
    cn_alias = "s",
    dunks_points = "i",
    fast_break_points = "i",
    field_goals_at_rim_made = "i",
    game_start = "i",
    number = "s",
    player_id = "i",
    up_time = "i"
  ),
  game_team_four = c(
    effective_hit_rate = "f",
    effective_hit_rate_average = "s",
    effective_hit_rate_rank = "f",
    free_throw_rate = "f",
    free_throw_rate_average = "s",
    free_throw_rate_rank = "f",
    loss_average = "f",
    loss_num = "i",
    offensive_rebound_rate = "f",
    offensive_rebound_rate_average = "s",
    offensive_rebound_rate_rank = "f",
    other_effective_hit_rate = "f",
    other_effective_hit_rate_average = "s",
    other_effective_hit_rate_rank = "f",
    other_free_throw_rate = "f",
    other_free_throw_rate_average = "s",
    other_free_throw_rate_rank = "f",
    other_offensive_rebound_rate = "f",
    other_offensive_rebound_rate_average = "s",
    other_offensive_rebound_rate_rank = "f",
    other_points_hundred_round = "f",
    other_points_hundred_round_average = "f",
    other_points_hundred_round_rank = "f",
    other_turnovers_rate = "f",
    other_turnovers_rate_average = "s",
    other_turnovers_rate_rank = "f",
    points_hundred_round = "f",
    points_hundred_round_average = "f",
    points_hundred_round_rank = "f",
    rhythm = "f",
    rhythm_num = "f",
    rhythm_rank = "f",
    schedule_season = "i",
    season = "i",
    team_id = "i",
    team_name = "s",
    turnovers_rate = "f",
    turnovers_rate_average = "s",
    turnovers_rate_rank = "f",
    win_num = "i",
    win_points_hundred_round = "f",
    win_points_hundred_round_average = "f",
    wine_average = "f"
  ),
  best_player = c(
    schedule_id = "i",
    side = "s",
    assists = "i",
    blocked = "i",
    fouls = "i",
    free_throw_str = "s",
    minutes = "i",
    number = "s",
    player_img = "s",
    player_name = "s",
    player_name_str = "s",
    points = "i",
    real_point_rate = "p",
    rebounds = "i",
    steals = "i",
    three_points_str = "s",
    turn_share = "p",
    turnovers = "i",
    two_points_str = "s"
  ),
  best_stats = c(
    schedule_id = "i",
    side = "s",
    ctype = "s",
    cvalue = "s",
    player_id = "i",
    player_name = "s",
    player_no = "s",
    seconds = "i",
    team_id = "i",
    type = "i"
  ),
  rosters = c(
    schedule_id = "i",
    side = "s",
    age = "i",
    birth_date = "s",
    body_data = "s",
    cn_alias = "s",
    cn_alias_show = "s",
    cn_name = "s",
    created_date = "s",
    first_name = "s",
    height = "i",
    id = "I",
    is_captain = "b",
    is_delete = "b",
    is_injury = "b",
    is_three = "i",
    last_modified_date = "s",
    last_name = "s",
    match_type_id = "i",
    nationality = "s",
    number = "s",
    player_cba_id = "i",
    player_id = "i",
    player_pic = "s",
    position = "s",
    position_description = "s",
    position_string = "s",
    season = "i",
    season_id = "i",
    season_name = "s",
    season_year = "s",
    team_cba_id = "i",
    team_cn_alias = "s",
    team_cn_name = "s",
    team_en_alias = "s",
    team_en_name = "s",
    team_id = "i",
    weight = "i"
  ),
  report_status = c(
    schedule_id = "i",
    is_report = "b"
  ),
  pbp = c(
    schedule_id = "i",
    bt_textual_format = "s",
    color = "s",
    distance = "s",
    home_color = "s",
    home_score = "i",
    minutes = "i",
    player_cn_names = "s",
    player_fouls = "s",
    player_score = "s",
    quarter_num = "i",
    seconds = "i",
    team_cn_alias1 = "s",
    team_cn_alias2 = "s",
    team_cn_alias3 = "s",
    textual_format = "s",
    type = "i",
    visiting_color = "s",
    visitor_score = "i"
  ),
  team_counts = c(
    key = "s",
    value = "i"
  ),
  team_basic = c(
    assists = "f",
    blocked = "f",
    cba_rank = "s",
    field_goals = "f",
    field_goals_attempted = "f",
    field_goals_percentage_rate = "p",
    fouls = "f",
    free_throws = "f",
    free_throws_attempted = "f",
    free_throws_percentage_rate = "p",
    losses_number = "i",
    points = "f",
    real_player_times = "i",
    rebounds = "f",
    rebounds_defensive = "f",
    rebounds_offensive = "f",
    round = "f",
    schedule_number = "i",
    schedule_season = "i",
    season = "s",
    steals = "f",
    team_id = "i",
    team_name = "s",
    three_point_attempted = "f",
    three_point_goals = "f",
    three_point_percentage_rate = "p",
    time = "f",
    turnovers = "f",
    win_number = "i",
    win_rate = "p"
  ),
  team_four = c(
    effective_hit_rate = "f",
    effective_hit_rate_average = "s",
    effective_hit_rate_rank = "f",
    effective_hit_sort = "f",
    field_goals = "i",
    field_goals_attempted = "i",
    free_throw_rate = "f",
    free_throw_rate_average = "s",
    free_throw_rate_rank = "f",
    free_throw_sort = "f",
    free_throws = "i",
    loss_average = "f",
    loss_num = "i",
    offensive_rebound_rate = "f",
    offensive_rebound_rate_average = "s",
    offensive_rebound_rate_rank = "f",
    offensive_rebound_sort = "f",
    other_effective_hit_rate = "f",
    other_effective_hit_rate_average = "s",
    other_effective_hit_rate_rank = "f",
    other_effective_hit_sort = "f",
    other_field_goals = "i",
    other_field_goals_attempted = "i",
    other_free_throw_rate = "f",
    other_free_throw_rate_average = "s",
    other_free_throw_rate_rank = "f",
    other_free_throw_sort = "f",
    other_free_throws = "i",
    other_offensive_rebound_rate = "f",
    other_offensive_rebound_rate_average = "s",
    other_offensive_rebound_rate_rank = "f",
    other_offensive_rebound_sort = "f",
    other_points_hundred_round = "f",
    other_points_hundred_round_average = "f",
    other_points_hundred_round_rank = "f",
    other_rebounds_defensive = "i",
    other_rebounds_offensive = "i",
    other_three_point_goals = "i",
    other_turnovers = "i",
    other_turnovers_rate = "f",
    other_turnovers_rate_average = "s",
    other_turnovers_rate_rank = "f",
    other_turnovers_sort = "f",
    other_win_points_hundred_round = "f",
    points_hundred_round = "f",
    points_hundred_round_average = "f",
    points_hundred_round_rank = "f",
    rhythm = "f",
    rhythm_num = "f",
    rhythm_rank = "f",
    round = "f",
    round_jingque = "f",
    schedule_season = "i",
    season = "i",
    self_rebounds_defensive = "i",
    self_rebounds_offensive = "i",
    team_id = "i",
    team_name = "s",
    three_point_goals = "i",
    total_minute = "i",
    total_other_points = "i",
    total_points = "i",
    turnovers = "i",
    turnovers_rate = "f",
    turnovers_rate_average = "s",
    turnovers_rate_rank = "f",
    turnovers_sort = "f",
    win_num = "i",
    win_points_hundred_round = "f",
    win_points_hundred_round_average = "f",
    win_points_hundred_round_rank = "f",
    wine_average = "f"
  ),
  team_overview = c(
    bout_no_points = "f",
    bout_no_points_rank = "f",
    bout_no_points_sort = "f",
    bout_point_sort = "f",
    bout_points = "f",
    bout_points_rank = "f",
    bout_subtract_points = "f",
    bout_subtract_points_rank = "f",
    bout_subtract_points_sort = "f",
    is_avg = "i",
    loss_num = "f",
    player_times = "f",
    rhythm = "f",
    rhythm_rank = "f",
    season = "i",
    team_id = "i",
    team_name = "s",
    win_num = "f",
    win_rate = "p"
  ),
  team_shots = c(
    bout_no_points_sort = "f",
    bout_point_sort = "f",
    bout_subtract_points_sort = "f",
    guard_field_goals_at_rim = "p",
    guard_field_goals_at_rim_rank = "f",
    guard_field_goals_at_rim_sort = "f",
    guard_hit_at_rim_made_rate = "p",
    guard_hit_at_rim_made_rate_rank = "f",
    guard_hit_at_rim_made_rate_sort = "f",
    guard_hit_middle_rate = "p",
    guard_hit_middle_rate_rank = "f",
    guard_hit_middle_rate_sort = "f",
    guard_middle_rate = "p",
    guard_middle_rate_rank = "f",
    guard_middle_rate_sort = "f",
    guard_real_point = "p",
    guard_real_point_rank = "f",
    guard_real_point_sort = "f",
    guard_three_goals_rate = "p",
    guard_three_goals_rate_rank = "f",
    guard_three_goals_rate_sort = "f",
    guard_three_rate = "p",
    guard_three_rate_rank = "f",
    guard_three_rate_sort = "f",
    is_avg = "i",
    num = "f",
    offensive_field_goals_at_rim = "p",
    offensive_field_goals_at_rim_rank = "f",
    offensive_field_goals_at_rim_sort = "f",
    offensive_hit_at_rim_made_rate = "p",
    offensive_hit_at_rim_made_rate_rank = "f",
    offensive_hit_at_rim_made_rate_sort = "f",
    offensive_hit_middle_rate = "p",
    offensive_hit_middle_rate_rank = "f",
    offensive_hit_middle_rate_sort = "f",
    offensive_middle_rate = "p",
    offensive_middle_rate_rank = "f",
    offensive_middle_rate_sort = "f",
    offensive_real_point = "p",
    offensive_real_point_rank = "f",
    offensive_real_point_sort = "f",
    offensive_three_goals_rate = "p",
    offensive_three_goals_rate_rank = "f",
    offensive_three_goals_rate_sort = "f",
    offensive_three_rate = "p",
    offensive_three_rate_rank = "f",
    offensive_three_rate_sort = "f",
    season = "i",
    team_id = "i",
    team_name = "s"
  ),
  player_base = c(
    age = "i",
    assists = "f",
    birth_date = "s",
    blocked = "f",
    cn_alias = "s",
    field_goals = "f",
    field_goals_at_rim_attempted = "f",
    field_goals_at_rim_made = "f",
    field_goals_attempted = "f",
    field_goals_mid_range_attempted = "f",
    field_goals_mid_range_made = "f",
    field_goals_percentage = "p",
    field_goals_percentage_sort = "f",
    fouls = "f",
    fouls_defensive = "f",
    free_throws = "f",
    free_throws_attempted = "f",
    free_throws_percentage = "p",
    free_throws_percentage_sort = "f",
    game_start_num = "i",
    minutes = "f",
    nationality = "s",
    number = "s",
    player_id = "i",
    player_times = "f",
    player_times2 = "s",
    points = "f",
    position = "s",
    position_num = "f",
    rank_sort = "s",
    rebounds = "f",
    rebounds_defensive = "f",
    rebounds_offensive = "f",
    schedule_id = "i",
    season = "i",
    seconds = "f",
    steals = "f",
    team_cn_alias = "s",
    team_id = "i",
    three_point_attempted = "f",
    three_point_goals = "f",
    three_point_percentage = "p",
    three_point_percentage_sort = "f",
    turnovers = "f"
  ),
  player_offensive = c(
    age = "i",
    assists = "i",
    assists_rate = "p",
    assists_rate_rank = "f",
    assists_rate_sort = "f",
    assists_round_rate = "p",
    assists_round_rate_rank = "f",
    assists_round_rate_sort = "f",
    birth_date = "s",
    field_goals_attempted = "i",
    first_position = "s",
    free_throws = "i",
    is_color = "i",
    minutes = "i",
    nationality = "s",
    number = "s",
    play_times = "i",
    player_id = "i",
    player_name = "s",
    position = "s",
    position_num = "f",
    rank = "s",
    real_rate = "p",
    real_rate_rank = "f",
    real_rate_sort = "f",
    round_rate = "p",
    round_rate_rank = "f",
    round_rate_sort = "f",
    season = "i",
    seconds = "i",
    team_cn_alias = "s",
    team_id = "i",
    turnovers = "i",
    turnovers_rate = "p",
    turnovers_rate_rank = "f",
    turnovers_rate_sort = "f"
  ),
  player_defensive = c(
    age = "i",
    blocked_rate = "p",
    blocked_rate_rank = "f",
    blocked_rate_sort = "f",
    first_position = "s",
    fouls_rate = "p",
    fouls_rate_rank = "f",
    fouls_rate_sort = "f",
    is_color = "i",
    minutes = "i",
    nationality = "s",
    number = "s",
    play_times = "i",
    player_id = "i",
    player_name = "s",
    position = "s",
    position_num = "f",
    rank = "s",
    rebounds_defensive_rate = "p",
    rebounds_defensive_rate_rank = "f",
    rebounds_defensive_rate_sort = "f",
    rebounds_offensive_rate = "p",
    rebounds_offensive_rate_rank = "f",
    rebounds_offensive_rate_sort = "f",
    season = "i",
    seconds = "i",
    steals_rate = "p",
    steals_rate_rank = "f",
    steals_rate_sort = "f",
    team_cn_alias = "s",
    team_id = "i"
  ),
  player_shots = c(
    age = "i",
    at_rim_made_rate = "f",
    at_rim_made_rate_rank = "f",
    at_rim_made_rate_sort = "f",
    first_position = "s",
    free_rate = "f",
    free_rate_rank = "f",
    free_rate_sort = "f",
    hit_at_rim_made_rate = "p",
    hit_at_rim_made_rate_rank = "f",
    hit_at_rim_made_rate_sort = "f",
    hit_free_rate = "p",
    hit_free_rate_rank = "f",
    hit_free_rate_sort = "f",
    hit_middle_rate = "p",
    hit_middle_rate_rank = "f",
    hit_middle_rate_sort = "f",
    hit_rate = "p",
    hit_rate_rank = "f",
    hit_rate_sort = "f",
    hit_three_rate = "p",
    hit_three_rate_rank = "f",
    hit_three_rate_sort = "f",
    is_color = "i",
    middle_rate = "f",
    middle_rate_rank = "f",
    middle_rate_sort = "f",
    minutes = "i",
    nationality = "s",
    number = "s",
    play_times = "i",
    player_id = "i",
    player_name = "s",
    position = "s",
    position_num = "f",
    rank = "s",
    season = "i",
    seconds = "i",
    team_cn_alias = "s",
    team_id = "i",
    three_rate = "f",
    three_rate_rank = "f",
    three_rate_sort = "f"
  )
)
