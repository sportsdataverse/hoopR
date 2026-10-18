# kzs_schema.R -- documented columns and types of the KZS frames.
#
# Copied from sdv-py origin/main e3d232ebc9: `DTYPES` of sportsdataverse/basketball/kzs/kzs_dtypes.py (generated there
# from the returns schemas). Codes: i integer, f double, b logical, s character. Change the columns in sdv-py
# first, then copy them here.

#' @noRd
.kzs_dtypes <- list(
  seasons = c(
    season_id = "i", name = "s", is_active = "b", active = "b", season = "i"
  ),
  competitions = c(
    competition_id = "i", name = "s", gender = "s", category = "s", rank = "s", season_id = "i", season_name =
    "s", season_is_active = "b", season_active = "b", type = "s", season = "i"
  ),
  competition = c(
    competition_id = "i", name = "s", season_id = "i", season_name = "s", season_is_active = "b", season_active
    = "b", gender = "s", category = "s", rank = "s", type = "s", season = "i", social_medias = "s"
  ),
  phases = c(
    competition_id = "i", season = "i", phase_id = "i", name = "s", start_date = "s", end_date = "s", type =
    "s", groups = "s", wins_needed = "i"
  ),
  rounds = c(
    competition_id = "i", phase_id = "i", rounds = "i"
  ),
  player_leaderboard = c(
    competition_id = "i", stats_category = "s", club_id = "i", club_fullname = "s", club_logo_uuid = "s",
    club_code = "s", team_id = "i", team_name = "s", games_played = "i", sum = "f", average = "f", max = "f",
    player_id = "i", player_firstname = "s", player_lastname = "s", photo_uuid = "s"
  ),
  team_leaderboard = c(
    competition_id = "i", stats_category = "s", club_id = "i", club_fullname = "s", club_logo_uuid = "s",
    club_code = "s", team_id = "i", team_name = "s", games_played = "i", sum = "f", average = "f", max = "f"
  ),
  matches = c(
    match_id = "i", competition_id = "i", competition_name = "s", competition_type = "s", competition_phase_id =
    "i", competition_phase_name = "s", transferred = "b", season_id = "i", season = "i", genius_match_id = "i",
    organiser_team_id = "i", round = "i", fiba_live_stats_url = "s", game_index = "i", date_time = "s",
    attendance = "i", sport_hall_name = "s", sport_hall_address = "s", sport_hall_id = "i", first_team_id = "i",
    first_team_team_id = "i", is_first_team_placeholder = "b", second_team_id = "i", second_team_team_id = "i",
    is_second_team_placeholder = "b", first_team_name = "s", first_team_short_name = "s", second_team_name =
    "s", second_team_short_name = "s", first_team_score = "i", second_team_score = "i", score_inserted_manually
    = "b", first_team_logo_uuid = "s", second_team_logo_uuid = "s", first_team_code = "s", second_team_code =
    "s", status = "s", delegated = "b", referee1_id = "i", referee1_person_id = "i", referee1_person_first_name
    = "s", referee1_person_last_name = "s", referee1_person_gender = "s", referee1_ranks = "s", referee2_id =
    "i", referee2_person_id = "i", referee2_person_first_name = "s", referee2_person_last_name = "s",
    referee2_person_gender = "s", referee2_ranks = "s", referee3_id = "i", referee3_person_id = "i",
    referee3_person_first_name = "s", referee3_person_last_name = "s", referee3_person_gender = "s",
    referee3_ranks = "s", commissioner_id = "i", commissioner_person_id = "i", commissioner_person_first_name =
    "s", commissioner_person_last_name = "s", commissioner_person_gender = "s", commissioner_ranks = "s",
    referee_controller_id = "i", referee_controller_person_id = "i", referee_controller_person_first_name = "s",
    referee_controller_person_last_name = "s", referee_controller_person_gender = "s", referee_controller_ranks
    = "s", match_evaluation_id = "i"
  ),
  match = c(
    match_id = "i", competition_id = "i", competition_name = "s", competition_type = "s", competition_phase_id =
    "i", competition_phase_name = "s", transferred = "b", season_id = "i", season = "i", genius_match_id = "i",
    organiser_team_id = "i", round = "i", fiba_live_stats_url = "s", game_index = "i", date_time = "s",
    attendance = "i", first_team_id = "i", first_team_team_id = "i", first_team_name = "s",
    first_team_home_jersey_color = "s", first_team_guest_jersey_color = "s", first_team_logo_uuid = "s",
    first_team_code = "s", first_team_forfeited = "b", first_team_is_placeholder = "b",
    first_team_best_performer_player_id = "i", first_team_best_performer_player_first_name = "s",
    first_team_best_performer_player_last_name = "s", first_team_best_performer_player_photo_uuid = "s",
    first_team_best_performer_efficiency = "i", first_team_best_performer_points = "i",
    first_team_best_performer_rebounds = "i", first_team_best_performer_assists = "i",
    first_team_best_performer_steals = "i", first_team_best_performer_blocks = "i", second_team_id = "i",
    second_team_team_id = "i", second_team_name = "s", second_team_home_jersey_color = "s",
    second_team_guest_jersey_color = "s", second_team_logo_uuid = "s", second_team_code = "s",
    second_team_forfeited = "b", second_team_is_placeholder = "b", second_team_best_performer_player_id = "i",
    second_team_best_performer_player_first_name = "s", second_team_best_performer_player_last_name = "s",
    second_team_best_performer_player_photo_uuid = "s", second_team_best_performer_efficiency = "i",
    second_team_best_performer_points = "i", second_team_best_performer_rebounds = "i",
    second_team_best_performer_assists = "i", second_team_best_performer_steals = "i",
    second_team_best_performer_blocks = "i", sport_hall_id = "i", sport_hall_name = "s", first_team_score = "i",
    second_team_score = "i", score_inserted_manually = "b", status = "s", referee1_id = "i", referee1_person_id
    = "i", referee1_person_first_name = "s", referee1_person_last_name = "s", referee1_person_gender = "s",
    referee1_ranks = "s", referee2_id = "i", referee2_person_id = "i", referee2_person_first_name = "s",
    referee2_person_last_name = "s", referee2_person_gender = "s", referee2_ranks = "s", referee3_id = "i",
    referee3_person_id = "i", referee3_person_first_name = "s", referee3_person_last_name = "s",
    referee3_person_gender = "s", referee3_ranks = "s", commissioner_id = "i", commissioner_person_id = "i",
    commissioner_person_first_name = "s", commissioner_person_last_name = "s", commissioner_person_gender = "s",
    commissioner_ranks = "s", referee_controller_id = "i", referee_controller_person_id = "i",
    referee_controller_person_first_name = "s", referee_controller_person_last_name = "s",
    referee_controller_person_gender = "s", referee_controller_ranks = "s", gender = "s", live_stats = "b",
    without_stats = "b", delegated = "b", home_jersey_color = "s", guest_jersey_color = "s", bests = "s",
    match_evaluation_id = "i"
  ),
  period_scores = c(
    match_id = "i", score_id = "i", match_part = "s", first_team_score = "i", second_team_score = "i"
  ),
  pbp = c(
    match_id = "i", action_number = "i", team_side = "s", source = "s", clock = "s", action_type = "s", sub_type
    = "s", qualifiers = "s", x = "f", y = "f", area = "s", side = "s", success = "b", score1 = "i", score2 =
    "i", period = "i", period_type = "s", part = "s", match_team_player_id = "i", player_id = "i",
    match_team_player_first_name = "s", match_team_player_last_name = "s", team_application_id = "i", team_name
    = "s", match_team_id = "i", player_photo_uuid = "s", shirt_number = "s"
  ),
  pbp_players = c(
    match_id = "i", team_side = "s", player_id = "i", first_name = "s", last_name = "s"
  ),
  box_score = c(
    match_id = "i", team_side = "s", team_id = "i", team_name = "s", minutes = "f", two_pm = "i", two_pa = "i",
    two_p_perc = "f", three_pm = "i", three_pa = "i", three_p_perc = "f", f_tm = "i", f_ta = "i", f_t_perc =
    "f", fg_m = "i", fg_a = "i", fg_perc = "f", offensive_rebounds = "i", defensive_rebounds = "i",
    total_rebounds = "i", assists = "i", steals = "i", turnovers = "i", blocks_in_favor = "i", blocks_against =
    "i", foul_commited = "i", foul_received = "i", p_ir = "i", plus_minus = "i", assists_turnover_ratio = "f",
    defensive_rating = "f", efficiency = "i", points = "i", efficiency_custom = "f", efficiency_game_score =
    "f", fast_break_points_attempted = "i", fast_break_points_made = "i", usage_percentage = "f", m_vp_votes =
    "i", minus = "i", offensive_rating = "f", p_er = "f", plus = "i", points_fast_break = "i",
    points_in_the_paint = "i", points_in_the_paint_attempted = "i", points_in_the_paint_made = "i",
    points_second_chance = "i", second_chance_points_attempted = "i", second_chance_points_made = "i",
    true_shooting_attempts = "i", true_shooting_percentage = "f", player_id = "i", photo_uuid = "s",
    match_team_player_firstname = "s", match_team_player_lastname = "s", match_team_player_year_of_birth = "s",
    jersey_number = "s", starting_lineup = "b", captain = "b", played = "b"
  ),
  team_box_score = c(
    match_id = "i", team_side = "s", team_id = "i", team_name = "s", minutes = "f", two_pm = "i", two_pa = "i",
    two_p_perc = "f", three_pm = "i", three_pa = "i", three_p_perc = "f", f_tm = "i", f_ta = "i", f_t_perc =
    "f", fg_m = "i", fg_a = "i", fg_perc = "f", offensive_rebounds = "i", defensive_rebounds = "i",
    total_rebounds = "i", assists = "i", steals = "i", turnovers = "i", blocks_in_favor = "i", blocks_against =
    "i", foul_commited = "i", foul_received = "i", p_ir = "i", plus_minus = "i", assists_turnover_ratio = "f",
    defensive_rating = "f", efficiency = "i", points = "i", efficiency_custom = "f", efficiency_game_score =
    "f", fast_break_points_attempted = "i", fast_break_points_made = "i", usage_percentage = "f", m_vp_votes =
    "i", minus = "i", offensive_rating = "f", p_er = "f", plus = "i", points_fast_break = "i",
    points_in_the_paint = "i", points_in_the_paint_attempted = "i", points_in_the_paint_made = "i",
    points_second_chance = "i", second_chance_points_attempted = "i", second_chance_points_made = "i",
    true_shooting_attempts = "i", true_shooting_percentage = "f", bench_points = "i", biggest_lead = "i",
    biggest_scoring_run = "i", fouls_bench_technical = "i", fouls_coach_disqualifying = "i",
    fouls_coach_technical = "i", fouls_disqualifying = "i", fouls_offensive = "i", fouls_on = "i",
    fouls_personal = "i", fouls_team = "i", fouls_technical = "i", fouls_technical_other = "i", fouls_throw_in =
    "i", fouls_total = "i", fouls_unsportsmanlike = "i", fouled_out = "i", lead_changes = "i",
    points_from_turnovers = "i", time_leading = "f", times_scores_level = "i", rebounds_team = "i",
    rebounds_team_defensive = "i", rebounds_team_offensive = "i", turnovers_team = "i"
  ),
  score_changes = c(
    match_id = "i", minute = "i", score1 = "i", score2 = "i", total_minutes = "i"
  ),
  standings = c(
    competition_id = "i", phase_id = "i", phase_name = "s", phase_type = "s", group_id = "i", group_name = "s",
    position = "i", team_id = "i", team_name = "s", club_code = "s", logo_uuid = "s", games_played = "i", won =
    "i", lost = "i", pts_plus = "i", pts_minus = "i", home_won = "i", home_lost = "i", away_won = "i", away_lost
    = "i", points = "i", draws = "i", lost_points = "i", tie_break_position = "i", pts_difference = "i"
  ),
  playing_days = c(
    competition_id = "i", date = "s", no_of_games = "i"
  ),
  teams = c(
    competition_id = "i", team_id = "i", team_application_id = "i", club_id = "i", club_member = "b",
    team_internal_ranking = "s", category = "s", rank = "s", gender = "s", sport_hall_id = "i", sport_hall_name
    = "s", name = "s", code = "s", home_jersey_color = "s", guest_jersey_color = "s", logo_uuid = "s",
    home_team_color = "s", guest_team_color = "s", short_name = "s"
  ),
  team = c(
    team_id = "i", team_application_id = "i", club_id = "i", club_member = "b", category = "s", rank = "s",
    gender = "s", sport_hall_id = "i", sport_hall_name = "s", sport_hall_address_id = "i",
    sport_hall_address_post_office_id = "i", sport_hall_address_post_office_zip_code = "s",
    sport_hall_address_post_office_name = "s", sport_hall_address_post_office_municipality = "s",
    sport_hall_address_post_office_country = "s", sport_hall_address_street = "s",
    sport_hall_address_house_number = "s", name = "s", code = "s", season_id = "i", season_name = "s",
    season_is_active = "b", season_active = "b", short_name = "s", home_jersey_color = "s", guest_jersey_color =
    "s", logo_uuid = "s", season = "i", competitions = "s"
  ),
  team_general = c(
    team_id = "i", competition_id = "i", won = "i", lost = "i", last_games = "s", best_points_player_id = "i",
    best_points_player_identification_number = "i", best_points_player_person_id = "i",
    best_points_player_person_first_name = "s", best_points_player_person_last_name = "s",
    best_points_player_person_year_of_birth = "i", best_points_player_nationality_id = "i",
    best_points_player_nationality_alpha2_code = "s", best_points_player_nationality_alpha3_code = "s",
    best_points_player_nationality_name = "s", best_points_player_nationality_eng_name = "s",
    best_points_player_homegrown = "b", best_points_player_photo_uuid = "s", best_points_player_positions = "s",
    best_average_points = "f", best_rebounds_player_id = "i", best_rebounds_player_identification_number = "i",
    best_rebounds_player_person_id = "i", best_rebounds_player_person_first_name = "s",
    best_rebounds_player_person_last_name = "s", best_rebounds_player_person_year_of_birth = "i",
    best_rebounds_player_nationality_id = "i", best_rebounds_player_nationality_alpha2_code = "s",
    best_rebounds_player_nationality_alpha3_code = "s", best_rebounds_player_nationality_name = "s",
    best_rebounds_player_nationality_eng_name = "s", best_rebounds_player_homegrown = "b",
    best_rebounds_player_photo_uuid = "s", best_rebounds_player_positions = "s", best_average_rebounds = "f",
    best_assists_player_id = "i", best_assists_player_identification_number = "i", best_assists_player_person_id
    = "i", best_assists_player_person_first_name = "s", best_assists_player_person_last_name = "s",
    best_assists_player_person_year_of_birth = "i", best_assists_player_nationality_id = "i",
    best_assists_player_nationality_alpha2_code = "s", best_assists_player_nationality_alpha3_code = "s",
    best_assists_player_nationality_name = "s", best_assists_player_nationality_eng_name = "s",
    best_assists_player_homegrown = "b", best_assists_player_photo_uuid = "s", best_assists_player_positions =
    "s", best_average_assists = "f"
  ),
  roster = c(
    team_id = "i", competition_id = "i", roster_entry_id = "i", player_id = "i", identification_number = "i",
    person_id = "i", first_name = "s", last_name = "s", year_of_birth = "i", nationality_id = "i",
    nationality_alpha2_code = "s", nationality_alpha3_code = "s", nationality_name = "s", nationality_eng_name =
    "s", homegrown = "b", photo_uuid = "s", positions = "s", jersey_number = "s"
  ),
  player = c(
    player_id = "i", identification_number = "i", person_id = "i", first_name = "s", last_name = "s",
    year_of_birth = "i", nationality_id = "i", nationality_alpha2_code = "s", nationality_alpha3_code = "s",
    nationality_name = "s", nationality_eng_name = "s", homegrown = "b", photo_uuid = "s", positions = "s"
  ),
  player_stats = c(
    player_id = "i", season_id = "i", season = "i", competition_id = "i", a1 = "i", a2 = "i", a3 = "i", pts =
    "i", ass = "i", blag = "i", blfv = "i", captain = "i", m1 = "i", m2 = "i", m3 = "i", mins = "f", pfcm = "i",
    pfrv = "i", rd = "i", ro = "i", st = "i", startinglineup = "i", tov = "i", played = "i", plus_minus = "i",
    efficiency = "i", avgpts = "f", avga1 = "f", avga2 = "f", avga3 = "f", avgass = "f", avgblag = "f", avgblfv
    = "f", avgm1 = "f", avgm2 = "f", avgm3 = "f", avgmins = "f", avgpfcm = "f", avgpfrv = "f", avgrd = "f",
    avgro = "f", avgsecs = "i", avgst = "f", avgtov = "f", avgplus_minus = "f", avgefficiency = "f", live_stats
    = "b", competition_name = "s", competition_rank = "s", competition_category = "s", competition_gender = "s"
  )
)
