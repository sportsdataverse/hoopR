# lba_schema.R -- the documented columns and their types, one entry per lba_* route.
#
# Generated from sportsdataverse-py sportsdataverse/basketball/lba/lba_dtypes.py (origin/main e3d232ebc9); codes: i integer,
# f double, b logical, s character. The parsers give these types to an empty frame, a gap-filled column and an
# all-null column (sportsdataverse-py lba_parsers._finish), and put these columns first, in this order.

#' @noRd
.LBA_DTYPES <- list(
  box_score = c(game_id = "i", season = "i", side = "s", team_id = "i", player_id = "i", player_num = "i",
    player_surname = "s", player_name = "s", player_code = "s", player_p_key = "s", pun = "i", min = "i", sec = "i",
    sf = "s", falli_c = "i", falli_sf = "i", falli_tc1 = "i", falli_fla = "i", t2_r = "i", t2_t = "i", t2_perc =
    "f", sc = "i", t3_r = "i", t3_t = "i", t3_perc = "f", tl_r = "i", tl_t = "i", tl_perc = "f", rimbalzi_o = "i",
    rimbalzi_d = "i", rimbalzi_t = "i", stoppate_dat = "i", stoppate_sub = "i", palle_p = "i", palle_r = "i", ass =
    "i", val_lega = "i", val_oer = "f", plus_minus = "i"),
  calendar = c(season = "i", game_id = "i", game_status = "s", championship_id = "i", championships_day_id = "i",
    year = "i", number = "i", match_datetime = "s", match_hh = "i", match_mm = "i", home_final_score = "i",
    visitor_final_score = "i", target_score = "s", additional_time = "i", plant_id = "i", websocket_match_id = "i",
    ticketing_url = "s", has_streaming = "i", updated_at = "s", h_team_id = "i", h_team_name = "s", h_club_code =
    "s", h_team_enabled = "b", home_logo_key = "s", v_team_id = "i", v_team_name = "s", v_club_code = "s",
    v_team_enabled = "b", v_logo_key = "s", town_id = "i", plant_name = "s", town_name = "s", day_code = "s",
    day_serial = "i", day_name = "s", match_serie_key = "s", referees = "s", broadcasters = "s"),
  championships = c(season = "i", championship_id = "i", year = "i", name = "s", status = "i", championship_type_id
    = "i", championship_series_id = "i", full_name = "s", focus_on = "b", ctype_code = "s", ctype_name = "s",
    cserie_code = "s", cserie_name = "s", logo_key = "s"),
  game = c(season = "i", game_id = "i", game_status = "s", championship_id = "i", competition_name = "s",
    championships_day_id = "i", year = "i", number = "i", match_datetime = "s", match_hh = "i", match_mm = "i",
    target_score = "s", home_final_score = "i", visitor_final_score = "i", q1_hs = "i", q1_vs = "i", q2_hs = "i",
    q2_vs = "i", q3_hs = "i", q3_vs = "i", q4_hs = "i", q4_vs = "i", ot_hs = "i", ot_vs = "i", home_coach_id = "i",
    home_coach_code = "s", home_coach_fullname = "s", visitor_coach_id = "i", visitor_coach_code = "s",
    visitor_coach_fullname = "s", additional_time = "i", plant_id = "i", websocket_match_id = "i", has_streaming =
    "i", live_match_data = "s", quarter = "s", ticketing_url = "s", match_serie = "s", match_hw = "i", match_vw =
    "i", updated_at = "s", h_team_id = "i", h_team_name = "s", h_team_enabled = "b", home_logo_key = "s", v_team_id
    = "i", v_team_name = "s", v_team_enabled = "b", v_logo_key = "s", plant_name = "s", day_code = "s", day_serial =
    "i", day_name = "s", competition_type_id = "i", competition_type_code = "s", competition_type = "s",
    competition_serie_id = "i", competition_serie = "s", day_phase_id = "i", spectators = "i", referees = "s",
    broadcasters = "s"),
  game_log = c(season = "i", stat_line_id = "i", championship_id = "i", championships_match_id = "i", player_id =
    "i", team_id = "i", number = "i", played_minutes = "i", points = "i", suffered_fouls = "i", done_fouls = "i",
    shots_2p_realized = "i", shots_2p_total = "i", shots_3p_realized = "i", shots_3p_total = "i",
    free_throws_realized = "i", free_throws_total = "i", restricted_area_p1 = "s", restricted_area_p2 = "s",
    restricted_area_p3 = "s", slam_dunk = "i", offensive_rebound = "i", defensive_rebound = "i", ball_stop_given =
    "i", ball_stop_received = "i", lost_balls = "i", regain_balls = "i", assists = "i", technical_fouls = "s",
    minute5_fouls = "i", time5_fouls = "i", rating_lega = "i", quintet = "i", rating_oer = "f", avg_points = "i",
    wp_id = "i", deleted_at = "s", created_at = "s", updated_at = "s", player_role_id = "i", order = "i", captain =
    "b", shots_2p_perc = "i", shots_3p_perc = "i", free_throws_perc = "i", total_rebound = "i", ext_code = "s",
    fouls_first_category = "i", fouls_flagrant = "i", championship_day_name = "s", home_score = "i", visitor_score =
    "i", match_date = "s", match_hh = "i", match_mm = "i", championship_match_id = "i", player_team_id = "i",
    player_team_name = "s", player_team_code = "s", visitor_team_id = "i", visitor_team_name = "s",
    visitor_team_logo_key = "s", home_team_id = "i", home_team_name = "s", home_team_logo_key = "s",
    phase_description = "s", match_adp = "i", home_match_result = "s", visitor_match_result = "s"),
  pbp = c(game_id = "i", season = "i", home_team_id = "i", visitor_team_id = "i", team_side = "s", home_score = "i",
    visitor_score = "i", coord_frame = "s", action_id = "i", description = "s", player_id = "i", team_id = "i",
    home_club = "i", in_area = "b", dunk = "i", seconds = "i", minute = "i", period = "i", order = "i", side = "i",
    x = "i", y = "i", score = "s", linked_action_id = "i", print_time = "s", action_1_qualifier_code = "s",
    action_2_qualifier_code = "s", action_1_qualifier_description = "s", action_2_qualifier_description = "s",
    side_area_zone = "s", side_area_code = "s", player_name = "s", player_surname = "s", player_number = "s",
    team_name = "s", id = "i"),
  pbp_legend = c(code = "i", label = "s"),
  player = c(player_id = "i", code = "s", name = "s", surname = "s", place_of_birth = "s", birth_date = "s",
    updated_at = "s", ext_code = "s", seo_meta_title = "s", seo_meta_description = "s", photo_picture_key = "s",
    fullbody_picture_key = "s", start_date = "s", end_date = "s", player_number = "s", uefa_ratio = "s", height =
    "i", weight = "i", team_id = "i", player_role_description = "s", player_alpha3 = "s", player_country_name = "s",
    player_country = "s", team_code = "s", team_name = "s", year = "i", team_logo_key = "s", stats_played_matches =
    "i", stats_totals_highs_rs_player_id = "i", stats_totals_highs_rs_championship_serie_code = "s",
    stats_totals_highs_rs_quintet_sum = "i", stats_totals_highs_rs_points_sum = "i",
    stats_totals_highs_rs_played_minutes_sum = "i", stats_totals_highs_rs_played_matches_sum = "i",
    stats_totals_highs_rs_total_matches_sum = "i", stats_totals_highs_rs_done_fouls_sum = "i",
    stats_totals_highs_rs_suffered_fouls_sum = "i", stats_totals_highs_rs_shots_2p_realized_sum = "i",
    stats_totals_highs_rs_shots_2p_total_sum = "i", stats_totals_highs_rs_slam_dunk_sum = "i",
    stats_totals_highs_rs_shots_3p_realized_sum = "i", stats_totals_highs_rs_shots_3p_total_sum = "i",
    stats_totals_highs_rs_free_throws_realized_sum = "i", stats_totals_highs_rs_free_throws_total_sum = "i",
    stats_totals_highs_rs_offensive_rebound_sum = "i", stats_totals_highs_rs_defensive_rebound_sum = "i",
    stats_totals_highs_rs_ball_stop_given_sum = "i", stats_totals_highs_rs_ball_stop_received_sum = "i",
    stats_totals_highs_rs_lost_balls_sum = "i", stats_totals_highs_rs_regain_balls_sum = "i",
    stats_totals_highs_rs_assists_sum = "i", stats_totals_highs_rs_rating_lega_sum = "i",
    stats_totals_highs_rs_rating_oer_sum = "f", stats_totals_highs_rs_avg_points_sum = "i",
    stats_totals_highs_rs_quintet_max = "i", stats_totals_highs_rs_points_max = "i",
    stats_totals_highs_rs_played_minutes_max = "i", stats_totals_highs_rs_done_fouls_max = "i",
    stats_totals_highs_rs_suffered_fouls_max = "i", stats_totals_highs_rs_shots_2p_realized_max = "i",
    stats_totals_highs_rs_shots_2p_total_max = "i", stats_totals_highs_rs_shots_2p_perc_max = "i",
    stats_totals_highs_rs_slam_dunk_max = "i", stats_totals_highs_rs_shots_3p_realized_max = "i",
    stats_totals_highs_rs_shots_3p_total_max = "i", stats_totals_highs_rs_shots_3p_perc_max = "i",
    stats_totals_highs_rs_free_throws_realized_max = "i", stats_totals_highs_rs_free_throws_total_max = "i",
    stats_totals_highs_rs_free_throws_perc_max = "i", stats_totals_highs_rs_offensive_rebound_max = "i",
    stats_totals_highs_rs_defensive_rebound_max = "i", stats_totals_highs_rs_total_rebounds_max = "i",
    stats_totals_highs_rs_ball_stop_given_max = "i", stats_totals_highs_rs_ball_stop_received_max = "i",
    stats_totals_highs_rs_lost_balls_max = "i", stats_totals_highs_rs_regain_balls_max = "i",
    stats_totals_highs_rs_assists_max = "i", stats_totals_highs_rs_rating_lega_max = "i",
    stats_totals_highs_rs_rating_oer_max = "f", stats_totals_highs_rs_avg_points_max = "i",
    stats_totals_highs_rs_adp_max = "i", stats_totals_highs_rs_id = "i", stats_avg_rs_player_id = "i",
    stats_avg_rs_championship_serie_code = "s", stats_avg_rs_quintet_avg = "f", stats_avg_rs_points_avg = "f",
    stats_avg_rs_played_minutes_avg = "f", stats_avg_rs_played_matches_avg = "f", stats_avg_rs_total_matches_avg =
    "f", stats_avg_rs_done_fouls_avg = "f", stats_avg_rs_suffered_fouls_avg = "f",
    stats_avg_rs_shots_2p_realized_avg = "f", stats_avg_rs_shots_2p_total_avg = "f", stats_avg_rs_slam_dunk_avg =
    "f", stats_avg_rs_shots_3p_realized_avg = "f", stats_avg_rs_shots_3p_total_avg = "f",
    stats_avg_rs_free_throws_realized_avg = "f", stats_avg_rs_free_throws_total_avg = "f",
    stats_avg_rs_offensive_rebound_avg = "f", stats_avg_rs_defensive_rebound_avg = "f",
    stats_avg_rs_ball_stop_given_avg = "f", stats_avg_rs_ball_stop_received_avg = "f", stats_avg_rs_lost_balls_avg =
    "f", stats_avg_rs_regain_balls_avg = "f", stats_avg_rs_assists_avg = "f", stats_avg_rs_rating_lega_avg = "f",
    stats_avg_rs_rating_oer_avg = "f", stats_avg_rs_avg_points_avg = "f", stats_avg_rs_id = "i"),
  player_stats = c(player_id = "i", stat_type = "s", season = "i", championship_year = "i", championship_position =
    "i", championship_name = "s", team_name = "s", quintet = "i", points = "f", played_minutes = "f", played_matches
    = "i", total_matches = "i", done_fouls = "i", suffered_fouls = "i", shots_2p_realized = "f", shots_2p_total =
    "i", slam_dunk = "i", shots_3p_realized = "i", shots_3p_total = "i", free_throws_realized = "i",
    free_throws_total = "i", offensive_rebound = "i", defensive_rebound = "i", total_rebound = "i", ball_stop_given
    = "i", ball_stop_received = "i", lost_balls = "i", regain_balls = "i", assists = "i", rating_lega = "i",
    rating_oer = "f", avg_points = "f", aplus_dp = "i"),
  players = c(season = "i", player_id = "i", name = "s", surname = "s", code = "s", team_name = "s", year = "i",
    player_picture_key = "s"),
  players_leaderboard = c(season = "i", category = "s", player_id = "i", name = "s", surname = "s", team_name = "s",
    tv_name = "s", year = "i", category_filter_total = "i", attempts = "i", presences = "i", minutes = "f",
    score_40_min = "f", score = "f", team_id = "i", player_photo_key = "s"),
  roster = c(team_id = "i", club_id = "i", club_code = "s", season = "i", player_id = "i", name = "s", surname =
    "s", code = "s", place_of_birth = "s", birth_date = "s", player_number = "s", country = "s", uefa_ratio = "s",
    height = "i", weight = "i", year = "i", start_date = "s", end_date = "s", player_role_id = "i", player_role =
    "s", team_name = "s", player_picture_key = "s", team_logo_key = "s"),
  roster_coach = c(team_id = "i", club_id = "i", club_code = "s", season = "i", coach_id = "i", name = "s", surname
    = "s", birth_date = "s", place_of_birth = "s", coach_type_id = "i", coach_type_description = "s",
    coach_type_code = "s", team_name = "s", coach_picture_key = "s", team_logo_key = "s"),
  shots = c(game_id = "i", season = "i", side = "s", team_id = "i", zone = "i", made = "i", attempts = "i", perc =
    "f", precision = "i", num = "s", opacity = "i"),
  standings = c(season = "i", standing_id = "i", championships_day_id = "i", team_id = "i", position = "i", wins =
    "i", defeats = "i", points_made = "i", points_suffered = "i", qp = "i", lv = "s", lp = "s", lpf = "s", lps =
    "s", lqp = "s", updated_at = "s", points = "i", penalty_points = "i", game_played = "i", home_game_played = "i",
    home_wins = "i", home_defeats = "i", away_game_played = "i", away_wins = "i", away_defeats = "i",
    avg_points_made = "f", avg_points_suffered = "f", home_points_made = "i", home_points_suffered = "i",
    home_avg_points_made = "f", home_avg_points_suffered = "f", away_points_made = "i", away_points_suffered = "i",
    away_avg_points_made = "f", away_avg_points_suffered = "f", year = "i", ties = "i", home_ties = "i", away_ties =
    "i", play_off_qualified = "b", relegation = "b", movement = "s", wins_percent = "f", home_wins_percent = "f",
    away_wins_percent = "f", max_points_made = "i", home_max_points_made = "i", away_max_points_made = "i", day_code
    = "i", day_name = "s", team_name = "s", club_code = "s", logo_key = "s", ctp = "i", ctp_symbol = "s",
    ctp_description = "s", season_start_year = "i"),
  team_box_score = c(game_id = "i", season = "i", side = "s", team_id = "i", row_type = "s", pun = "i", falli_c =
    "i", falli_sf = "i", falli_tc1 = "i", falli_fla = "i", rimbalzi_o = "i", rimbalzi_d = "i", rimbalzi_t = "i",
    palle_p = "i", palle_r = "i", val_lega = "i", min = "i", sec = "i", t2_r = "i", t2_t = "i", t2_perc = "f", sc =
    "i", t3_r = "i", t3_t = "i", t3_perc = "f", tl_r = "i", tl_t = "i", tl_perc = "f", stoppate_dat = "i",
    stoppate_sub = "i", ass = "i", val_oer = "f"),
  team_players_stats = c(team_id = "i", club_id = "i", club_code = "s", season = "i", player_id = "i", player_name =
    "s", player_surname = "s", player_season = "i", player_photo_key = "s", played_matches = "i", total_matches =
    "i", start_formation = "i", points_sum = "i", played_minutes_sum = "i", rating_lega_sum = "i", rating_oer_sum =
    "f", offensive_rebound_sum = "i", defensive_rebound_sum = "i", total_rebound_sum = "i", assists_sum = "i",
    regain_balls_sum = "i", lost_balls_sum = "i", ball_stop_given_sum = "i", ball_stop_received_sum = "i",
    done_fouls_sum = "i", suffered_fouls_sum = "i", plus_minus_sum = "i", aplus_dp_sum = "i", slam_dunk_sum = "i",
    shots_2p_realized_sum = "i", shots_2p_total_sum = "i", shots_2p_perc_sum = "f", shots_3p_realized_sum = "i",
    shots_3p_total_sum = "i", shots_3p_perc_sum = "f", free_throws_realized_sum = "i", free_throws_total_sum = "i",
    free_throws_perc_sum = "f"),
  teams = c(season = "i", team_id = "i", name = "s", year = "i", club_id = "i", club_code = "s", updated_at = "s",
    logo_key = "s"),
  teams_leaderboard = c(season = "i", category = "s", name = "s", sponsor_name = "s", short_name = "s", tv_name =
    "s", year = "i", logo_key = "s", attempts = "i", total_played_matches = "i", total_points = "i", minutes = "i",
    score_40_min = "f", score = "f", team_id = "i")
)

#' Route table: the wire path, the fixed query parameters and the parser of each lba_* wrapper.
#' @noRd
.LBA_ROUTES <- list(
  championships = list(path = "/championships/get-championships", fixed = list(cs_id = 1L, items = 1000L), title = "Championships"),
  calendar = list(path = "/championships/get-championships-calendar-by-id", fixed = list(), title = "Calendar"),
  game = list(path = "/championships/get-championships-matches-by-id", fixed = list(sc = 1L), title = "Game"),
  box_score = list(path = "/championships/get-championships-matches-scores-by-id", fixed = list(info = "true"), title = "Box Score"),
  team_box_score = list(path = "/championships/get-championships-matches-scores-by-id", fixed = list(info = "true"), title = "Team Box Score"),
  pbp = list(path = "/championships/get-championships-matches-play-by-play", fixed = list(info = "true", sort = "asc"), title = "Play-by-Play"),
  pbp_legend = list(path = "/championships/get-championships-matches-play-by-play", fixed = list(info = "true", sort = "asc"), title = "Play-by-Play Legend"),
  shots = list(path = "/matches/get-championship-matches-shots-by-id", fixed = list(info = 1L), title = "Shots"),
  standings = list(path = "/championships/get-championship-ranking", fixed = list(), title = "Standings"),
  teams = list(path = "/teams/get-teams", fixed = list(items = 50L), title = "Teams"),
  roster = list(path = "/teams/get-team-roster", fixed = list(), title = "Roster"),
  roster_coach = list(path = "/teams/get-team-roster", fixed = list(), title = "Roster Coach"),
  team_players_stats = list(path = "/teams/get-team-players-stats", fixed = list(cs_id = 1L), title = "Team Players Stats"),
  players = list(path = "/players/get-players", fixed = list(items = 50L), title = "Players"),
  player = list(path = "/players/get-player-by-id", fixed = list(stats = 1L), title = "Player"),
  player_stats = list(path = "/players/get-player-stats", fixed = list(), title = "Player Stats"),
  game_log = list(path = "/players/get-player-matches", fixed = list(cs_id = 1L), title = "Game Log"),
  players_leaderboard = list(path = "/statistics/get-players-statistics", fixed = list(cs_id = 1L), title = "Players Leaderboard"),
  teams_leaderboard = list(path = "/statistics/get-teams-statistics-by-type", fixed = list(cs_id = 1L), title = "Teams Leaderboard")
)
