# nbl_rosetta_schema.R -- column dtypes and documented columns of the NBL Rosetta frames.
#
# Copied from sdv-py (sportsdataverse/basketball/nbl_au/nbl_rosetta_dtypes.py DTYPES, per parser,
# and the per-endpoint returns-schemas, tools/codegen/schemas/native/nbl_rosetta/). Codes: i integer,
# f double, b logical, s character. Refresh both together when sdv-py re-captures the family.

#' @noRd
.NBL_ROSETTA_DTYPES <- list(
  parse_nbl_rosetta_match = c(
    org = "s", match_id = "s", match_status = "s", start_time_datetime = "s", match_type = "s",
    attendance = "i", clock = "s", current_period = "i", clock_running = "b", home_score = "i",
    away_score = "i", round = "s", start_time = "s", status = "s", external_media_id = "s", match_slug = "s",
    match_title = "s", secondary_external_id = "s", live_exclusive = "b", season_id = "s",
    rosetta_season_id = "s", season_year = "i", season_type = "s", season_competition_id = "s",
    season_competition_name = "s", season_competition_gender = "s", season_competition_league_name = "s",
    season_competition_division = "s", venue_id = "s", rosetta_venue_id = "s", venue_name = "s",
    venue_address = "s", venue_capacity = "i", venue_timezone = "s", venue_code = "s", venue_state = "s",
    venue_suburb = "s", venue_latitude = "f", venue_longitude = "f", venue_country = "s", home_team_id = "s",
    home_team_name = "s", home_team_external_team_name = "s", home_team_code = "s", away_team_id = "s",
    away_team_name = "s", away_team_external_team_name = "s", away_team_code = "s", data_source = "s",
    match_status_string = "s", play_by_play_updated_datetime = "s", season_end_year = "i"
  ),
  parse_nbl_rosetta_match_pbp = c(
    match_id = "s", rosetta_match_id = "s", match_status = "s", action_id = "i", period = "i",
    period_type = "s", clock = "s", clock_seconds = "f", shot_clock = "s", shot_clock_seconds = "f",
    score_home = "i", score_away = "i", action_type = "s", sub_type = "s", sub_type_key = "s", success = "b",
    team_id = "s", team_code = "s", team_name = "s", is_home = "b", player_id = "s", player_name = "s",
    jersey_number = "s", x = "f", y = "f", readable_action_type = "s", system_action_type = "s",
    timestamp = "s", feed = "s"
  ),
  parse_nbl_rosetta_match_player_box = c(
    match_id = "s", match_status = "s", stat_line_id = "s", rosetta_stat_line_id = "s", assists = "i",
    blocks = "i", defensive_rebounds = "i", efficiency = "i", field_goals_attempted = "i",
    field_goals_made = "i", field_goals_percentage = "f", fouls = "i", free_throws_attempted = "i",
    free_throws_made = "i", free_throws_percentage = "f", jersey_number = "s", minutes = "f",
    minutes_string = "s", offensive_rebounds = "i", participated = "b", period = "i", period_type = "s",
    personal_fouls = "i", playing_position = "s", plus_minus = "i", points = "i", rebounds = "i",
    starter = "b", steals = "i", technical_fouls = "i", three_points_attempted = "i",
    three_points_made = "i", three_points_percentage = "f", turnovers = "i", two_points_attempted = "i",
    two_points_made = "i", two_points_percentage = "f", rosetta_match_id = "s", player_id = "s",
    player_first_name = "s", player_last_name = "s", player_full_name = "s", player_jersey_number = "s",
    player_playing_position = "s", team_id = "s", team_code = "s", team_name = "s", sc = "i"
  ),
  parse_nbl_rosetta_match_player_period_box = c(
    match_id = "s", match_status = "s", player_id = "s", rosetta_player_id = "s", player_first_name = "s",
    player_last_name = "s", player_jersey_number = "s", player_playing_position = "s", team_id = "s",
    rosetta_team_id = "s", period = "i", period_type = "s", rosetta_match_id = "s", assists = "i",
    blocks = "i", defensive_rebounds = "i", field_goals_attempted = "i", field_goals_made = "i",
    field_goals_percentage = "f", fouls = "i", free_throws_attempted = "i", free_throws_made = "i",
    free_throws_percentage = "f", minutes = "f", offensive_rebounds = "i", personal_fouls = "i",
    points = "i", rebounds = "i", steals = "i", technical_fouls = "i", three_points_attempted = "i",
    three_points_made = "i", three_points_percentage = "f", turnovers = "i", two_points_attempted = "i",
    two_points_made = "i", two_points_percentage = "f", jersey_number = "s"
  ),
  parse_nbl_rosetta_match_team_box = c(
    match_id = "s", match_status = "s", stat_line_id = "s", rosetta_stat_line_id = "s", assists = "i",
    blocks = "i", defensive_rebounds = "i", field_goals_attempted = "i", field_goals_made = "i",
    field_goals_percentage = "f", fouls = "i", free_throws_attempted = "i", free_throws_made = "i",
    free_throws_percentage = "f", minutes = "f", offensive_rebounds = "i", period = "i", period_type = "s",
    personal_fouls = "i", points = "i", rebounds = "i", steals = "i", technical_fouls = "i",
    three_points_attempted = "i", three_points_made = "i", three_points_percentage = "f", turnovers = "i",
    two_points_attempted = "i", two_points_made = "i", two_points_percentage = "f", rosetta_match_id = "s",
    team_id = "s", team_code = "s", team_name = "s", timeouts = "i"
  ),
  parse_nbl_rosetta_matches = c(
    org = "s", match_id = "s", external_media_id = "s", date_updated = "s", start_time = "s",
    start_time_datetime = "s", round = "s", match_type = "s", match_status = "s", status = "s",
    home_score = "i", away_score = "i", attendance = "i", match_slug = "s", match_title = "s",
    venue_id = "s", rosetta_venue_id = "s", venue_name = "s", venue_address = "s", venue_suburb = "s",
    venue_state = "s", venue_country = "s", venue_capacity = "i", venue_timezone = "s", venue_code = "s",
    venue_latitude = "f", venue_longitude = "f", home_team_id = "s", rosetta_home_team_id = "s",
    home_team_name = "s", home_team_external_team_name = "s", home_team_code = "s",
    home_team_division_abbreviation = "s", home_team_division_name = "s", home_team_conference_name = "s",
    away_team_id = "s", rosetta_away_team_id = "s", away_team_name = "s", away_team_external_team_name = "s",
    away_team_code = "s", away_team_division_abbreviation = "s", away_team_division_name = "s",
    away_team_conference_name = "s", season_id = "s", rosetta_season_id = "s", season_name = "s",
    season_year = "i", season_type = "s", season_gender = "s", season_competition_id = "s",
    season_competition_name = "s", season_competition_gender = "s", season_competition_league_name = "s",
    season_competition_division = "s", season_end_year = "i", home_team_division = "s",
    home_team_conference = "s", away_team_division = "s", away_team_conference = "s"
  ),
  parse_nbl_rosetta_next_match = c(
    org = "s", match_id = "s", external_media_id = "s", date_updated = "s", start_time = "s",
    start_time_datetime = "s", round = "s", match_type = "s", match_status = "s", status = "s",
    home_score = "i", away_score = "i", attendance = "i", match_slug = "s", match_title = "s",
    venue_id = "s", rosetta_venue_id = "s", venue_name = "s", venue_address = "s", venue_suburb = "s",
    venue_state = "s", venue_country = "s", venue_capacity = "i", venue_timezone = "s", venue_code = "s",
    venue_latitude = "f", venue_longitude = "f", home_team_id = "s", rosetta_home_team_id = "s",
    home_team_name = "s", home_team_external_team_name = "s", home_team_code = "s", home_team_division = "s",
    home_team_conference = "s", away_team_id = "s", rosetta_away_team_id = "s", away_team_name = "s",
    away_team_external_team_name = "s", away_team_code = "s", away_team_division = "s",
    away_team_conference = "s", season_id = "s", rosetta_season_id = "s", season_name = "s",
    season_year = "i", season_type = "s", season_gender = "s", season_competition_id = "s",
    season_competition_name = "s", season_competition_gender = "s", season_competition_league_name = "s",
    season_competition_division = "s", season_end_year = "i"
  ),
  parse_nbl_rosetta_next_matches = c(
    org = "s", rosetta_team_id = "s", team_name = "s", team_code = "s", division = "s", conference = "s",
    match_slug = "s", match_title = "s", start_time_datetime = "s", is_home = "b", opponent_name = "s",
    venue = "s", match_id = "s", rosetta_match_id = "s", rosetta_opponent_id = "s", season_end_year = "i"
  ),
  parse_nbl_rosetta_outcomes = c(
    org = "s", team_name = "s", wins = "i", losses = "i", last10 = "s", last5 = "s", last3 = "s",
    season_end_year = "i"
  ),
  parse_nbl_rosetta_player_game_log = c(
    org = "s", period = "i", playing_position = "s", points = "i", rebounds = "i", assists = "i",
    blocks = "i", steals = "i", turnovers = "i", offensive_rebounds = "i", defensive_rebounds = "i",
    personal_fouls = "i", three_points_attempted = "i", three_points_made = "i",
    three_points_percentage = "f", two_points_attempted = "i", two_points_made = "i",
    two_points_percentage = "f", field_goals_attempted = "i", field_goals_made = "i",
    field_goals_percentage = "f", free_throws_attempted = "i", free_throws_made = "i",
    free_throws_percentage = "f", minutes = "f", participated = "b", match_id = "s", rosetta_match_id = "s",
    match_start_time_datetime = "s", match_status = "s", match_season_id = "s",
    rosetta_match_season_id = "s", match_season_year = "i", match_season_type = "s",
    rosetta_match_home_team_id = "s", match_home_team_name = "s", match_home_team_code = "s",
    rosetta_match_away_team_id = "s", match_away_team_name = "s", match_away_team_code = "s",
    player_id = "s", rosetta_player_id = "s", player_jersey_number = "s", player_first_name = "s",
    player_last_name = "s", team_id = "s", rosetta_team_id = "s", team_name = "s", team_code = "s",
    sc_total_score = "i", sc_total_score_without_dd_and_td = "i", sc_breakdown_points_value = "i",
    sc_breakdown_points_points = "i", sc_breakdown_rebounds_value = "i", sc_breakdown_rebounds_points = "i",
    sc_breakdown_assists_value = "i", sc_breakdown_assists_points = "i", sc_breakdown_blocks_value = "i",
    sc_breakdown_blocks_points = "i", sc_breakdown_steals_value = "i", sc_breakdown_steals_points = "i",
    sc_breakdown_turnovers_value = "i", sc_breakdown_turnovers_points = "i", sc_double_figure_count = "i",
    sc_season_total = "i", season_end_year = "i"
  ),
  parse_nbl_rosetta_player_season_stats = c(
    org = "s", assists_average = "f", blocks_average = "f", field_goals_attempted = "i",
    field_goals_made = "i", field_goals_attempted_average = "f", field_goals_made_average = "f",
    field_goals_percentage = "f", fouls_average = "f", free_throws_attempted = "i", free_throws_made = "i",
    free_throws_attempted_average = "f", free_throws_made_average = "f", free_throws_percentage = "f",
    games = "i", games_started = "i", offensive_rebounds = "i", fouls = "i", personal_fouls = "i",
    technical_fouls = "i", period = "i", three_points_attempted = "i", three_points_attempted_average = "f",
    three_points_made = "i", three_points_made_average = "f", three_points_percentage = "f",
    turnovers_average = "f", turnovers = "i", two_points_attempted = "i", two_points_attempted_average = "f",
    two_points_made = "i", two_points_made_average = "f", two_points_percentage = "f", minutes = "f",
    minutes_average = "f", points = "i", rebounds = "i", assists = "i", blocks = "i", steals = "i",
    plus_minus = "i", plus_minus_average = "f", efficiency = "i", efficiency_average = "f",
    points_average = "f", rebounds_average = "f", steals_average = "f", player_id = "s",
    rosetta_player_id = "s", player_first_name = "s", player_jersey_number = "s", player_last_name = "s",
    player_playing_position = "s", team_id = "s", rosetta_team_id = "s", team_name = "s", team_code = "s",
    season_id = "s", rosetta_season_id = "s", season_year = "i", season_type = "s",
    season_competition_division = "s", sc_total_score = "i", sc_total_score_without_dd_and_td = "i",
    sc_breakdown_points_value = "i", sc_breakdown_points_points = "i", sc_breakdown_rebounds_value = "i",
    sc_breakdown_rebounds_points = "i", sc_breakdown_assists_value = "i", sc_breakdown_assists_points = "i",
    sc_breakdown_blocks_value = "i", sc_breakdown_blocks_points = "i", sc_breakdown_steals_value = "i",
    sc_breakdown_steals_points = "i", sc_breakdown_turnovers_value = "i",
    sc_breakdown_turnovers_points = "i", sc_breakdown_triple_double_value = "i",
    sc_breakdown_triple_double_points = "i", sc_double_figure_count = "i", season_end_year = "i",
    sc_breakdown_double_double_value = "i", sc_breakdown_double_double_points = "i", season_start_date = "s",
    player_full_name = "s", player_active = "b", player_date_of_birth = "s", player_nationality = "s",
    player_height = "f", player_weight = "f", team_gender = "s", synthetic_from_roster = "b"
  ),
  parse_nbl_rosetta_players = c(
    org = "s", jersey_number = "s", playing_position = "s", player_id = "s", rosetta_player_id = "s",
    player_date_updated = "s", player_first_name = "s", player_last_name = "s", player_date_of_birth = "s",
    player_height = "f", player_weight = "f", player_dominant_hand = "s", player_gender = "s",
    player_nationality = "s", player_nationality_code = "s", player_dominant_foot = "s",
    player_jersey_number = "s", player_playing_position = "s", player_active = "b", player_league = "s",
    player_birthplace = "s", player_rookie_year = "s", player_person = "s",
    player_latest_jersey_number = "s", player_full_name = "s", player_source_updated_at = "s",
    player_source_provider = "s", team_id = "s", rosetta_team_id = "s", team_code = "s", team_name = "s",
    season_competition_division = "s", season_end_year = "i", team_gender = "s"
  ),
  parse_nbl_rosetta_seasons = c(
    org = "s", season_id = "s", rosetta_season_id = "s", name = "s", season_year = "i", season_type = "s",
    start_date = "s", end_date = "s", competition_league_name = "s", competition_division = "s",
    season_end_year = "i", competition_name = "s", competition_age_group = "s",
    next_match_start_datetime = "s"
  ),
  parse_nbl_rosetta_standings = c(
    org = "s", rosetta_standing_id = "s", position = "i", won = "i", lost = "i", played = "i",
    points_percentage = "f", win_percentage = "f", last_5 = "s", streak = "i", points_for = "i",
    points_against = "i", away_losses = "i", away_wins = "i", home_losses = "i", home_wins = "i",
    team_id = "s", rosetta_team_id = "s", team_code = "s", team_name = "s", season_year = "i",
    season_type = "s", season_competition_division = "s", season_end_year = "i"
  ),
  parse_nbl_rosetta_team_season_stats = c(
    org = "s", assists = "i", assists_average = "f", blocks = "i", blocks_average = "f",
    defensive_rebounds = "i", field_goals_attempted = "i", field_goals_attempted_average = "f",
    field_goals_made = "i", field_goals_made_average = "f", field_goals_percentage = "f", fouls = "i",
    fouls_average = "f", free_throws_attempted = "i", free_throws_attempted_average = "f",
    free_throws_made = "i", free_throws_made_average = "f", free_throws_percentage = "f", games = "i",
    minutes = "f", offensive_rebounds = "i", offensive_rebounds_average = "f", period = "i",
    personal_fouls_average = "f", points = "i", points_average = "f", rebounds = "i", rebounds_average = "f",
    results_string = "s", steals = "i", steals_average = "f", three_points_attempted = "i",
    three_points_attempted_average = "f", three_points_made = "i", three_points_made_average = "f",
    three_points_percentage = "f", turnovers = "i", turnovers_average = "f", two_points_attempted = "i",
    two_points_attempted_average = "f", two_points_made = "i", two_points_made_average = "f",
    two_points_percentage = "f", team_id = "s", rosetta_team_id = "s", team_name = "s", team_code = "s",
    season_id = "s", rosetta_season_id = "s", season_year = "i", season_type = "s",
    season_competition_division = "s", season_end_year = "i"
  ),
  parse_nbl_rosetta_teams = c(
    org = "s", team_id = "s", rosetta_team_id = "s", name = "s", team_code = "s", established = "s",
    head_coach = "s", championships = "s", website = "s", external_media_competitor_id = "s",
    conference = "s", division = "s", venue_name = "s", venue_address = "s", venue_state = "s",
    venue_country = "s", venue_timezone = "s", venue_latitude = "f", venue_longitude = "f",
    venue_capacity = "i", conference_name = "s", division_name = "s"
  )
)

#' Documented columns per endpoint, in order (sdv-py `_PARSER_COLUMNS`).
#' @noRd
.NBL_ROSETTA_COLUMNS <- list(
  seasons = c(
    "org", "season_id", "rosetta_season_id", "name", "season_year", "season_type", "start_date", "end_date",
    "competition_league_name", "competition_division", "season_end_year"
  ),
  seasons_current = c(
    "org", "season_id", "rosetta_season_id", "name", "season_year", "season_type", "start_date", "end_date",
    "competition_name", "competition_age_group", "next_match_start_datetime", "season_end_year"
  ),
  matches = c(
    "org", "match_id", "external_media_id", "date_updated", "start_time", "start_time_datetime", "round",
    "match_type", "match_status", "status", "home_score", "away_score", "attendance", "match_slug",
    "match_title", "venue_id", "rosetta_venue_id", "venue_name", "venue_address", "venue_suburb",
    "venue_state", "venue_country", "venue_capacity", "venue_timezone", "venue_code", "venue_latitude",
    "venue_longitude", "home_team_id", "rosetta_home_team_id", "home_team_name",
    "home_team_external_team_name", "home_team_code", "home_team_division_abbreviation",
    "home_team_division_name", "home_team_conference_name", "away_team_id", "rosetta_away_team_id",
    "away_team_name", "away_team_external_team_name", "away_team_code", "away_team_division_abbreviation",
    "away_team_division_name", "away_team_conference_name", "season_id", "rosetta_season_id", "season_name",
    "season_year", "season_type", "season_gender", "season_competition_id", "season_competition_name",
    "season_competition_gender", "season_competition_league_name", "season_competition_division",
    "season_end_year", "home_team_division", "home_team_conference", "away_team_division",
    "away_team_conference"
  ),
  teams = c(
    "org", "team_id", "rosetta_team_id", "name", "team_code", "established", "head_coach", "championships",
    "website", "external_media_competitor_id", "conference", "division", "venue_name", "venue_address",
    "venue_state", "venue_country", "venue_timezone", "venue_latitude", "venue_longitude", "venue_capacity",
    "conference_name", "division_name"
  ),
  match_by_id = c(
    "org", "match_id", "match_status", "start_time_datetime", "match_type", "attendance", "clock",
    "current_period", "clock_running", "home_score", "away_score", "round", "start_time", "status",
    "external_media_id", "match_slug", "match_title", "secondary_external_id", "live_exclusive", "season_id",
    "rosetta_season_id", "season_year", "season_type", "season_competition_id", "season_competition_name",
    "season_competition_gender", "season_competition_league_name", "season_competition_division", "venue_id",
    "rosetta_venue_id", "venue_name", "venue_address", "venue_capacity", "venue_timezone", "venue_code",
    "venue_state", "venue_suburb", "venue_latitude", "venue_longitude", "venue_country", "home_team_id",
    "home_team_name", "home_team_external_team_name", "home_team_code", "away_team_id", "away_team_name",
    "away_team_external_team_name", "away_team_code", "data_source", "match_status_string",
    "play_by_play_updated_datetime", "season_end_year"
  ),
  match = c(
    "org", "match_id", "match_status", "start_time_datetime", "match_type", "attendance", "clock",
    "current_period", "clock_running", "home_score", "away_score", "round", "start_time", "status",
    "external_media_id", "match_slug", "match_title", "secondary_external_id", "live_exclusive", "season_id",
    "rosetta_season_id", "season_year", "season_type", "season_competition_id", "season_competition_name",
    "season_competition_gender", "season_competition_league_name", "season_competition_division", "venue_id",
    "rosetta_venue_id", "venue_name", "venue_address", "venue_capacity", "venue_timezone", "venue_code",
    "venue_state", "venue_suburb", "venue_latitude", "venue_longitude", "venue_country", "home_team_id",
    "home_team_name", "home_team_external_team_name", "home_team_code", "away_team_id", "away_team_name",
    "away_team_external_team_name", "away_team_code", "data_source", "match_status_string",
    "play_by_play_updated_datetime", "season_end_year"
  ),
  match_player_box = c(
    "match_id", "match_status", "stat_line_id", "rosetta_stat_line_id", "assists", "blocks",
    "defensive_rebounds", "efficiency", "field_goals_attempted", "field_goals_made",
    "field_goals_percentage", "fouls", "free_throws_attempted", "free_throws_made", "free_throws_percentage",
    "jersey_number", "minutes", "minutes_string", "offensive_rebounds", "participated", "period",
    "period_type", "personal_fouls", "playing_position", "plus_minus", "points", "rebounds", "starter",
    "steals", "technical_fouls", "three_points_attempted", "three_points_made", "three_points_percentage",
    "turnovers", "two_points_attempted", "two_points_made", "two_points_percentage", "rosetta_match_id",
    "player_id", "player_first_name", "player_last_name", "player_full_name", "player_jersey_number",
    "player_playing_position", "team_id", "team_code", "team_name", "sc"
  ),
  match_team_box = c(
    "match_id", "match_status", "stat_line_id", "rosetta_stat_line_id", "assists", "blocks",
    "defensive_rebounds", "field_goals_attempted", "field_goals_made", "field_goals_percentage", "fouls",
    "free_throws_attempted", "free_throws_made", "free_throws_percentage", "minutes", "offensive_rebounds",
    "period", "period_type", "personal_fouls", "points", "rebounds", "steals", "technical_fouls",
    "three_points_attempted", "three_points_made", "three_points_percentage", "turnovers",
    "two_points_attempted", "two_points_made", "two_points_percentage", "rosetta_match_id", "team_id",
    "team_code", "team_name", "timeouts"
  ),
  match_player_period_box = c(
    "match_id", "match_status", "player_id", "rosetta_player_id", "player_first_name", "player_last_name",
    "player_jersey_number", "player_playing_position", "team_id", "rosetta_team_id", "period", "period_type",
    "rosetta_match_id", "assists", "blocks", "defensive_rebounds", "field_goals_attempted",
    "field_goals_made", "field_goals_percentage", "fouls", "free_throws_attempted", "free_throws_made",
    "free_throws_percentage", "minutes", "offensive_rebounds", "personal_fouls", "points", "rebounds",
    "steals", "technical_fouls", "three_points_attempted", "three_points_made", "three_points_percentage",
    "turnovers", "two_points_attempted", "two_points_made", "two_points_percentage", "jersey_number"
  ),
  match_pbp = c(
    "match_id", "rosetta_match_id", "match_status", "action_id", "period", "period_type", "clock",
    "clock_seconds", "shot_clock", "shot_clock_seconds", "score_home", "score_away", "action_type",
    "sub_type", "sub_type_key", "success", "team_id", "team_code", "team_name", "is_home", "player_id",
    "player_name", "jersey_number", "x", "y", "readable_action_type", "system_action_type", "timestamp",
    "feed"
  ),
  standings = c(
    "org", "rosetta_standing_id", "position", "won", "lost", "played", "points_percentage", "win_percentage",
    "last_5", "streak", "points_for", "points_against", "away_losses", "away_wins", "home_losses",
    "home_wins", "team_id", "rosetta_team_id", "team_code", "team_name", "season_year", "season_type",
    "season_competition_division", "season_end_year"
  ),
  players = c(
    "org", "jersey_number", "playing_position", "player_id", "rosetta_player_id", "player_date_updated",
    "player_first_name", "player_last_name", "player_date_of_birth", "player_height", "player_weight",
    "player_dominant_hand", "player_gender", "player_nationality", "player_nationality_code",
    "player_dominant_foot", "player_jersey_number", "player_playing_position", "player_active",
    "player_league", "player_birthplace", "player_rookie_year", "player_person",
    "player_latest_jersey_number", "player_full_name", "player_source_updated_at", "player_source_provider",
    "team_id", "rosetta_team_id", "team_code", "team_name", "season_competition_division", "season_end_year"
  ),
  team_players = c(
    "org", "jersey_number", "playing_position", "team_id", "rosetta_team_id", "team_name", "team_code",
    "team_gender", "player_id", "rosetta_player_id", "player_first_name", "player_last_name",
    "player_full_name", "player_jersey_number", "player_playing_position", "player_active",
    "player_date_of_birth", "player_nationality", "player_height", "player_weight", "player_dominant_hand",
    "player_gender", "player_nationality_code", "player_birthplace", "player_rookie_year", "season_end_year"
  ),
  outcomes = c(
    "org", "team_name", "wins", "losses", "last10", "last5", "last3", "season_end_year"
  ),
  player_game_log = c(
    "org", "period", "playing_position", "points", "rebounds", "assists", "blocks", "steals", "turnovers",
    "offensive_rebounds", "defensive_rebounds", "personal_fouls", "three_points_attempted",
    "three_points_made", "three_points_percentage", "two_points_attempted", "two_points_made",
    "two_points_percentage", "field_goals_attempted", "field_goals_made", "field_goals_percentage",
    "free_throws_attempted", "free_throws_made", "free_throws_percentage", "minutes", "participated",
    "match_id", "rosetta_match_id", "match_start_time_datetime", "match_status", "match_season_id",
    "rosetta_match_season_id", "match_season_year", "match_season_type", "rosetta_match_home_team_id",
    "match_home_team_name", "match_home_team_code", "rosetta_match_away_team_id", "match_away_team_name",
    "match_away_team_code", "player_id", "rosetta_player_id", "player_jersey_number", "player_first_name",
    "player_last_name", "team_id", "rosetta_team_id", "team_name", "team_code", "sc_total_score",
    "sc_total_score_without_dd_and_td", "sc_breakdown_points_value", "sc_breakdown_points_points",
    "sc_breakdown_rebounds_value", "sc_breakdown_rebounds_points", "sc_breakdown_assists_value",
    "sc_breakdown_assists_points", "sc_breakdown_blocks_value", "sc_breakdown_blocks_points",
    "sc_breakdown_steals_value", "sc_breakdown_steals_points", "sc_breakdown_turnovers_value",
    "sc_breakdown_turnovers_points", "sc_double_figure_count", "sc_season_total", "season_end_year"
  ),
  player_stats = c(
    "org", "assists_average", "blocks_average", "field_goals_attempted", "field_goals_made",
    "field_goals_attempted_average", "field_goals_made_average", "field_goals_percentage", "fouls_average",
    "free_throws_attempted", "free_throws_made", "free_throws_attempted_average", "free_throws_made_average",
    "free_throws_percentage", "games", "games_started", "offensive_rebounds", "fouls", "personal_fouls",
    "technical_fouls", "period", "three_points_attempted", "three_points_attempted_average",
    "three_points_made", "three_points_made_average", "three_points_percentage", "turnovers_average",
    "turnovers", "two_points_attempted", "two_points_attempted_average", "two_points_made",
    "two_points_made_average", "two_points_percentage", "minutes", "minutes_average", "points", "rebounds",
    "assists", "blocks", "steals", "plus_minus", "plus_minus_average", "efficiency", "efficiency_average",
    "points_average", "rebounds_average", "steals_average", "player_id", "rosetta_player_id",
    "player_first_name", "player_jersey_number", "player_last_name", "player_playing_position", "team_id",
    "rosetta_team_id", "team_name", "team_code", "season_id", "rosetta_season_id", "season_year",
    "season_type", "season_competition_division", "sc_total_score", "sc_total_score_without_dd_and_td",
    "sc_breakdown_points_value", "sc_breakdown_points_points", "sc_breakdown_rebounds_value",
    "sc_breakdown_rebounds_points", "sc_breakdown_assists_value", "sc_breakdown_assists_points",
    "sc_breakdown_blocks_value", "sc_breakdown_blocks_points", "sc_breakdown_steals_value",
    "sc_breakdown_steals_points", "sc_breakdown_turnovers_value", "sc_breakdown_turnovers_points",
    "sc_breakdown_triple_double_value", "sc_breakdown_triple_double_points", "sc_double_figure_count",
    "season_end_year", "sc_breakdown_double_double_value", "sc_breakdown_double_double_points",
    "season_start_date", "player_full_name", "player_active", "player_date_of_birth", "player_nationality",
    "player_height", "player_weight", "team_gender", "synthetic_from_roster"
  ),
  stats_leaders = c(
    "org", "assists_average", "blocks_average", "field_goals_attempted", "field_goals_made",
    "field_goals_attempted_average", "field_goals_made_average", "field_goals_percentage", "fouls_average",
    "free_throws_attempted", "free_throws_made", "free_throws_attempted_average", "free_throws_made_average",
    "free_throws_percentage", "games", "games_started", "offensive_rebounds", "fouls", "personal_fouls",
    "technical_fouls", "period", "three_points_attempted", "three_points_attempted_average",
    "three_points_made", "three_points_made_average", "three_points_percentage", "turnovers_average",
    "turnovers", "two_points_attempted", "two_points_attempted_average", "two_points_made",
    "two_points_made_average", "two_points_percentage", "minutes", "minutes_average", "points", "rebounds",
    "assists", "blocks", "steals", "plus_minus", "plus_minus_average", "efficiency", "efficiency_average",
    "points_average", "rebounds_average", "steals_average", "player_id", "rosetta_player_id",
    "player_first_name", "player_jersey_number", "player_last_name", "player_playing_position", "team_id",
    "rosetta_team_id", "team_name", "team_code", "season_id", "rosetta_season_id", "season_year",
    "season_type", "season_competition_division", "sc_total_score", "sc_total_score_without_dd_and_td",
    "sc_breakdown_points_value", "sc_breakdown_points_points", "sc_breakdown_rebounds_value",
    "sc_breakdown_rebounds_points", "sc_breakdown_assists_value", "sc_breakdown_assists_points",
    "sc_breakdown_blocks_value", "sc_breakdown_blocks_points", "sc_breakdown_steals_value",
    "sc_breakdown_steals_points", "sc_breakdown_turnovers_value", "sc_breakdown_turnovers_points",
    "sc_breakdown_triple_double_value", "sc_breakdown_triple_double_points", "sc_double_figure_count",
    "season_end_year"
  ),
  team_stats_leaders = c(
    "org", "assists_average", "blocks_average", "field_goals_attempted", "field_goals_made",
    "field_goals_attempted_average", "field_goals_made_average", "field_goals_percentage", "fouls_average",
    "free_throws_attempted", "free_throws_made", "free_throws_attempted_average", "free_throws_made_average",
    "free_throws_percentage", "games", "games_started", "offensive_rebounds", "fouls", "personal_fouls",
    "technical_fouls", "period", "three_points_attempted", "three_points_attempted_average",
    "three_points_made", "three_points_made_average", "three_points_percentage", "turnovers_average",
    "turnovers", "two_points_attempted", "two_points_attempted_average", "two_points_made",
    "two_points_made_average", "two_points_percentage", "minutes", "minutes_average", "points", "rebounds",
    "assists", "blocks", "steals", "plus_minus", "plus_minus_average", "efficiency", "efficiency_average",
    "points_average", "rebounds_average", "steals_average", "player_id", "rosetta_player_id",
    "player_first_name", "player_jersey_number", "player_last_name", "player_playing_position", "team_id",
    "rosetta_team_id", "team_name", "team_code", "season_id", "rosetta_season_id", "season_year",
    "season_type", "season_competition_division", "season_end_year"
  ),
  team_stats = c(
    "org", "assists", "assists_average", "blocks", "blocks_average", "defensive_rebounds",
    "field_goals_attempted", "field_goals_attempted_average", "field_goals_made", "field_goals_made_average",
    "field_goals_percentage", "fouls", "fouls_average", "free_throws_attempted",
    "free_throws_attempted_average", "free_throws_made", "free_throws_made_average",
    "free_throws_percentage", "games", "minutes", "offensive_rebounds", "offensive_rebounds_average",
    "period", "personal_fouls_average", "points", "points_average", "rebounds", "rebounds_average",
    "results_string", "steals", "steals_average", "three_points_attempted", "three_points_attempted_average",
    "three_points_made", "three_points_made_average", "three_points_percentage", "turnovers",
    "turnovers_average", "two_points_attempted", "two_points_attempted_average", "two_points_made",
    "two_points_made_average", "two_points_percentage", "team_id", "rosetta_team_id", "team_name",
    "team_code", "season_id", "rosetta_season_id", "season_year", "season_type",
    "season_competition_division", "season_end_year"
  ),
  next_match = c(
    "org", "match_id", "external_media_id", "date_updated", "start_time", "start_time_datetime", "round",
    "match_type", "match_status", "status", "home_score", "away_score", "attendance", "match_slug",
    "match_title", "venue_id", "rosetta_venue_id", "venue_name", "venue_address", "venue_suburb",
    "venue_state", "venue_country", "venue_capacity", "venue_timezone", "venue_code", "venue_latitude",
    "venue_longitude", "home_team_id", "rosetta_home_team_id", "home_team_name",
    "home_team_external_team_name", "home_team_code", "home_team_division", "home_team_conference",
    "away_team_id", "rosetta_away_team_id", "away_team_name", "away_team_external_team_name",
    "away_team_code", "away_team_division", "away_team_conference", "season_id", "rosetta_season_id",
    "season_name", "season_year", "season_type", "season_gender", "season_competition_id",
    "season_competition_name", "season_competition_gender", "season_competition_league_name",
    "season_competition_division", "season_end_year"
  ),
  next_match_team = c(
    "org", "match_id", "external_media_id", "date_updated", "start_time", "start_time_datetime", "round",
    "match_type", "match_status", "status", "home_score", "away_score", "attendance", "match_slug",
    "match_title", "venue_id", "rosetta_venue_id", "venue_name", "venue_address", "venue_suburb",
    "venue_state", "venue_country", "venue_capacity", "venue_timezone", "venue_code", "venue_latitude",
    "venue_longitude", "home_team_id", "rosetta_home_team_id", "home_team_name",
    "home_team_external_team_name", "home_team_code", "home_team_division", "home_team_conference",
    "away_team_id", "rosetta_away_team_id", "away_team_name", "away_team_external_team_name",
    "away_team_code", "away_team_division", "away_team_conference", "season_id", "rosetta_season_id",
    "season_name", "season_year", "season_type", "season_gender", "season_competition_id",
    "season_competition_name", "season_competition_gender", "season_competition_league_name",
    "season_competition_division", "season_end_year"
  ),
  next_matches = c(
    "org", "rosetta_team_id", "team_name", "team_code", "division", "conference", "match_slug",
    "match_title", "start_time_datetime", "is_home", "opponent_name", "venue", "match_id",
    "rosetta_match_id", "rosetta_opponent_id", "season_end_year"
  )
)

#' Parser of each endpoint.
#' @noRd
.NBL_ROSETTA_PARSER <- c(
  seasons = "parse_nbl_rosetta_seasons", seasons_current = "parse_nbl_rosetta_seasons",
  matches = "parse_nbl_rosetta_matches", teams = "parse_nbl_rosetta_teams",
  match_by_id = "parse_nbl_rosetta_match", match = "parse_nbl_rosetta_match",
  match_player_box = "parse_nbl_rosetta_match_player_box",
  match_team_box = "parse_nbl_rosetta_match_team_box",
  match_player_period_box = "parse_nbl_rosetta_match_player_period_box",
  match_pbp = "parse_nbl_rosetta_match_pbp", standings = "parse_nbl_rosetta_standings",
  players = "parse_nbl_rosetta_players", team_players = "parse_nbl_rosetta_players",
  outcomes = "parse_nbl_rosetta_outcomes", player_game_log = "parse_nbl_rosetta_player_game_log",
  player_stats = "parse_nbl_rosetta_player_season_stats",
  stats_leaders = "parse_nbl_rosetta_player_season_stats",
  team_stats_leaders = "parse_nbl_rosetta_player_season_stats",
  team_stats = "parse_nbl_rosetta_team_season_stats", next_match = "parse_nbl_rosetta_next_match",
  next_match_team = "parse_nbl_rosetta_next_match", next_matches = "parse_nbl_rosetta_next_matches"
)
