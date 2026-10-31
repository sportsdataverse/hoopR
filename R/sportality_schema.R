# sportality_schema.R -- documented columns and types of the Basketligaen frames.
#
# Copied from sportsdataverse-py origin/main e3d232e: `SCHEMAS` of sportsdataverse/basketball/dbl/sportality_dtypes.py
# (codes: i integer, f double, s character, b logical). Change the columns in sportsdataverse-py first, then copy them here.

#' Documented columns and types per wrapper route (sportsdataverse-py `SCHEMAS`).
#' @noRd
.sportality_schemas <- list(
  athlete_career = c(
    g = "i", gps = "i", mpg = "f", ppg = "f", drpg = "f", orpg = "f", rpg = "f", apg = "f", stpg = "f",
      blkpg = "f", pfpg = "f", "2_p_perc" = "f", "3_pm" = "i", "3_pa" = "f", "3_p_perc" = "f", ft_perc = "f",
      topg = "f", plus_minus_pg = "f", info_uuid = "s", info_full_name = "s", info_first_name = "s",
      info_last_name = "s", info_nationality = "s", info_gender = "s", info_age_value = "i",
      info_age_format = "s", info_weight_value = "i", info_weight_format = "s", info_height_value = "i",
      info_height_format = "s", info_jersey_number = "s", info_position = "s", info_position_code = "s",
      info_shoots = "s", info_team_uuid = "s", info_team_instance_id = "s", info_team_name = "s",
      info_team_code = "s", info_season_stats = "s", info_career_stats = "s", info_statistics_provider = "s",
      info_is_in_squad = "b", info_player_id = "i", info_ssgt_uuid = "s", info_team_id = "i"
  ),
  athlete_details = c(
    athlete_uuid = "s", player_id = "i", created_at = "s", created_by = "s", creator_site = "s",
      height = "i", deleted = "b", first_name = "s", gender = "s", last_modified = "s", last_name = "s",
      metadata = "s", nationality = "s", shoots = "s", weight = "i"
  ),
  athlete_profile = c(
    uuid = "s", full_name = "s", first_name = "s", last_name = "s", nationality = "s", gender = "s",
      age_value = "i", age_format = "s", weight_value = "i", weight_format = "s", height_value = "i",
      height_format = "s", jersey_number = "i", position = "s", position_code = "s", shoots = "s",
      team_uuid = "s", team_instance_id = "s", team_name = "s", team_code = "s", team_media = "s",
      season_stats = "s", career_stats = "s", statistics_provider = "s", is_in_squad = "b", media_url = "s",
      media_alt = "s", media_srcset = "s", media_url_img_original_proportion = "s",
      media_url_placeholder_image = "s", media_videourl = "s", media_photographer = "s",
      media_focal_point = "s"
  ),
  boxscore = c(
    team_side = "s", row_type = "s", player_id = "i", team_id = "i", team_name = "s", period = "i",
      full_name = "s", first_name = "s", last_name = "s", nr = "i", pos = "s", mins = "s", pts = "i",
      fg = "s", fg_perc = "f", "2_p" = "s", "2_p_perc" = "f", "3_p" = "s", "3_p_perc" = "f", ft = "s",
      ft_perc = "f", off = "i", def = "i", reb = "i", ast = "i", to = "i", stl = "i", blk = "i", blkr = "i",
      pf = "i", f_on = "i", plus_minus = "i"
  ),
  game_header = c(
    instance_context_site_team_is_in_game = "b", instance_context_site_team_is_home_team = "b",
      instance_context_site_team_is_away_team = "b", game_info_game_uuid = "s", game_info_ext_id = "i",
      game_info_start_date_time = "s", game_info_arena_name = "s", game_info_state = "s",
      game_info_overtime = "b", game_info_shootout = "s", game_info_series_code = "s",
      game_info_series_name = "s", game_info_round_number = "i", game_info_round_label = "s",
      game_info_series_display_name = "s", home_team_names_code = "s", home_team_names_short = "s",
      home_team_names_long = "s", home_team_names_full = "s", home_team_names_code_site = "s",
      home_team_names_short_site = "s", home_team_names_full_site = "s", home_team_names_long_site = "s",
      home_team_uuid = "s", home_team_instance_id = "s", home_team_founded_on = "s", home_team_icon = "s",
      home_team_score = "i", away_team_names_code = "s", away_team_names_short = "s",
      away_team_names_long = "s", away_team_names_full = "s", away_team_names_code_site = "s",
      away_team_names_short_site = "s", away_team_names_full_site = "s", away_team_names_long_site = "s",
      away_team_uuid = "s", away_team_instance_id = "s", away_team_founded_on = "s", away_team_icon = "s",
      away_team_score = "i", ssgt_uuid = "s", series_uuid = "s"
  ),
  game_overview = c(
    game_uuid = "s", home_team_game_source_id = "i", home_team_game_id = "i", home_team_team_id = "i",
      home_team_team_name = "s", home_team_team_code = "s", home_team_team_number = "i",
      home_team_place = "s", home_team_instance_id = "s", home_team_source = "s", home_team_game_uuid = "s",
      away_team_game_source_id = "i", away_team_game_id = "i", away_team_team_id = "i",
      away_team_team_name = "s", away_team_team_code = "s", away_team_team_number = "i",
      away_team_place = "s", away_team_instance_id = "s", away_team_source = "s", away_team_game_uuid = "s",
      home_goals = "i", away_goals = "i", state = "s", time_game_id = "i", time_period = "i",
      time_period_time = "s", time_instance_id = "s", time_source = "s"
  ),
  game_summary = c(
    team_head2_head = "s", team_period_caption = "s", team_period_overtime = "b", team_period_shootout = "b",
      team_period_stats = "s", best_scorers = "s", statistics_provider = "s"
  ),
  last_game_day = c(
    game_uuid = "s", start_date_time = "s", state = "s", overtime = "b", shootout = "s", ssgt_uuid = "s",
      home_team_status = "s", home_team_uuid = "s", home_team_owner_instance_id = "s", home_team_code = "s",
      home_team_names_code = "s", home_team_names_short = "s", home_team_names_long = "s",
      home_team_names_full = "s", home_team_names_code_site = "s", home_team_names_short_site = "s",
      home_team_names_full_site = "s", home_team_names_long_site = "s", home_team_score = "i",
      home_team_icon = "s", away_team_status = "s", away_team_uuid = "s", away_team_owner_instance_id = "s",
      away_team_code = "s", away_team_names_code = "s", away_team_names_short = "s",
      away_team_names_long = "s", away_team_names_full = "s", away_team_names_code_site = "s",
      away_team_names_short_site = "s", away_team_names_full_site = "s", away_team_names_long_site = "s",
      away_team_score = "i", away_team_icon = "s", venue_uuid = "s", venue_name = "s", series_uuid = "s",
      series_code = "s", series_display_name = "s"
  ),
  layout_info = c(
    season = "i", season_code = "s", season_name = "s", game_type = "s", game_type_name = "s",
      series_code = "s", ssgt_uuid = "s", state = "s", season_uuid = "s", series_uuid = "s",
      game_type_uuid = "s"
  ),
  next_game_day = c(
    game_uuid = "s", start_date_time = "s", state = "s", overtime = "b", shootout = "s", ssgt_uuid = "s",
      home_team_status = "s", home_team_uuid = "s", home_team_owner_instance_id = "s", home_team_code = "s",
      home_team_names_code = "s", home_team_names_short = "s", home_team_names_long = "s",
      home_team_names_full = "s", home_team_names_code_site = "s", home_team_names_short_site = "s",
      home_team_names_full_site = "s", home_team_names_long_site = "s", home_team_score = "i",
      home_team_icon = "s", away_team_status = "s", away_team_uuid = "s", away_team_owner_instance_id = "s",
      away_team_code = "s", away_team_names_code = "s", away_team_names_short = "s",
      away_team_names_long = "s", away_team_names_full = "s", away_team_names_code_site = "s",
      away_team_names_short_site = "s", away_team_names_full_site = "s", away_team_names_long_site = "s",
      away_team_score = "i", away_team_icon = "s", venue_uuid = "s", venue_name = "s", series_uuid = "s",
      series_code = "s", series_display_name = "s"
  ),
  pbp = c(
    game_source_id = "i", game_id = "i", event_id = "i", type = "s", event_uuid = "s", period = "i",
      period_type = "s", time = "s", real_world_time = "s", updated_time = "s", home_team_id = "i",
      home_team_code = "s", home_team_name = "s", home_abbreviation = "s", home_team_number = "i",
      home_place = "s", home_score = "i", away_team_id = "i", away_team_code = "s", away_team_name = "s",
      away_abbreviation = "s", away_team_number = "i", away_place = "s", away_score = "i", revision = "i",
      game_state = "s", game_type = "s", round = "i", start_date_and_time = "s", sub_type = "s",
      qualifiers = "s", is_successful = "i", instance_id = "s", source = "s", game_uuid = "s",
      event_team_id = "i", event_team_code = "s", event_team_name = "s", event_abbreviation = "s",
      event_team_number = "i", event_place = "s", player_id = "i", player_pno = "i",
      player_team_number = "i", player_first_name = "s", player_family_name = "s", coordinates_x = "f",
      coordinates_y = "f", period_time = "i"
  ),
  player_box = c(
    team_side = "s", row_type = "s", player_id = "i", team_id = "i", team_name = "s", period = "i",
      full_name = "s", first_name = "s", last_name = "s", nr = "i", pos = "s", mins = "s", pts = "i",
      fg = "s", fg_perc = "f", "2_p" = "s", "2_p_perc" = "f", "3_p" = "s", "3_p_perc" = "f", ft = "s",
      ft_perc = "f", off = "i", def = "i", reb = "i", ast = "i", to = "i", stl = "i", blk = "i", blkr = "i",
      pf = "i", f_on = "i", plus_minus = "i", team_number = "i", pno = "i"
  ),
  player_h2h = c(
    uuid = "s", first_name = "s", last_name = "s", full_name = "s", nationality = "s", gender = "s",
      jersey_number = "i", position = "s", position_code = "s", age_value = "i", age_format = "s",
      height_value = "i", height_format = "s", weight_value = "i", weight_format = "s", team_uuid = "s",
      team_instance_id = "s", team_name = "s", team_code = "s", team_media = "s", media_url = "s",
      media_alt = "s", media_srcset = "s", season_stats = "s", career_stats = "s", match_stats_nr = "i",
      match_stats_pos = "s", match_stats_team_number = "i", match_stats_pno = "i", match_stats_mins = "s",
      match_stats_pts = "i", match_stats_fg = "s", match_stats_fg_perc = "f", match_stats_2_p = "s",
      match_stats_2_p_perc = "f", match_stats_3_p = "s", match_stats_3_p_perc = "f", match_stats_ft = "s",
      match_stats_ft_perc = "f", match_stats_off = "i", match_stats_def = "i", match_stats_reb = "i",
      match_stats_ast = "i", match_stats_to = "i", match_stats_stl = "i", match_stats_blk = "i",
      match_stats_blkr = "i", match_stats_pf = "i", match_stats_f_on = "i", match_stats_plus_minus = "i",
      season_avg_stats = "s", statistics_provider = "s", is_in_squad = "b", effective_ssgt_uuid = "s"
  ),
  post_game_team_stats = c(
    home_team_side_translate_key = "s", home_team_left_type = "s", home_team_left_value = "i",
      home_team_right_type = "s", home_team_right_value = "i", home_team_center_type = "s",
      home_team_center_value = "i", away_team_side_translate_key = "s", away_team_left_type = "s",
      away_team_left_value = "i", away_team_right_type = "s", away_team_right_value = "i",
      away_team_center_type = "s", away_team_center_value = "i"
  ),
  roster = c(
    position = "s", position_code = "s", player_type = "s", gender = "s", uuid = "s", first_name = "s",
      last_name = "s", full_name = "s", nationality = "s", jersey_number = "i", portrait_url = "s"
  ),
  schedule = c(
    game_uuid = "s", raw_start_date_time = "s", start_date_time = "s", state = "s", overtime = "b",
      shootout = "s", ssgt_uuid = "s", home_team_status = "s", home_team_uuid = "s",
      home_team_owner_instance_id = "s", home_team_code = "s", home_team_names_code = "s",
      home_team_names_short = "s", home_team_names_long = "s", home_team_names_full = "s",
      home_team_names_code_site = "s", home_team_names_short_site = "s", home_team_names_full_site = "s",
      home_team_names_long_site = "s", home_team_score = "i", home_team_icon = "s", away_team_status = "s",
      away_team_uuid = "s", away_team_owner_instance_id = "s", away_team_code = "s",
      away_team_names_code = "s", away_team_names_short = "s", away_team_names_long = "s",
      away_team_names_full = "s", away_team_names_code_site = "s", away_team_names_short_site = "s",
      away_team_names_full_site = "s", away_team_names_long_site = "s", away_team_score = "i",
      away_team_icon = "s", venue_uuid = "s", venue_name = "s", series_uuid = "s", series_code = "s",
      series_display_name = "s", round_number = "i", round_label = "s"
  ),
  season_filter = c(
    kind = "s", code = "s", name = "s", uuid = "s", deleted = "b"
  ),
  sites = c(
    id = "s", instance_id = "s", public_url = "s", name = "s", icon = "s"
  ),
  ssgt_provider = c(
    provider = "s"
  ),
  standings = c(
    team_id = "i", team_uuid = "s", team_code = "s", team_name = "s", rank = "i", gp = "i", w = "i", l = "i",
      tp = "i", "for" = "i", ga = "i", plus_minus = "i", strk = "i"
  ),
  stats_info = c(
    player_id = "i", gp = "i", eff = "f", mins = "f", ppg = "f", rpg = "f", apg = "f", stpg = "f",
      blkpg = "f", info_uuid = "s", info_full_name = "s", info_first_name = "s", info_last_name = "s",
      info_nationality = "s", info_shoots = "s", info_gender = "s", info_weight_value = "i",
      info_weight_format = "s", info_height_value = "i", info_height_format = "s", info_team_uuid = "s",
      info_team_name = "s", info_team_code = "s", info_team_media = "s", info_team_owner_instance_id = "s",
      info_team_site_display_name = "s", info_team_id = "i", info_number = "i", info_position = "s", w = "i",
      p_avg = "f", r_avg = "f", a_avg = "f", s_avg = "f", b_avg = "f", f_avg = "f", "2_p_perc" = "f",
      "3_p_perc" = "f", ft_perc = "f", info_name = "s", info_site_display_name = "s",
      info_owner_instance_id = "s", date_time = "s", home_team = "s", away_team = "s", venue = "s",
      attendance = "i", home_score = "i", away_score = "i", decided_in = "s", info_game_id = "i",
      info_home_team_id = "i", info_away_team_id = "i", blk = "i", br = "i", stl = "i", plus = "i",
      minus = "i", fgm = "i", fga = "i", fg_perc = "f", fge_perc = "f", "3_pm" = "i", "3_pa" = "i",
      "2_pm" = "i", "2_pa" = "i", pf = "i", tf = "i", of = "i", f_on = "f", uf = "i", f_outs = "i",
      o_rat = "f", tsa = "i", ts_perc = "f", a = "i", atr = "f", u_perc = "f", egs = "f", tp = "i",
      fbp = "i", fbp_perc = "f", pitp = "i", pitp_perc = "f", "2nd_ch_p" = "i", "2nd_ch_p_perc" = "f",
      plus_minus = "i", dr = "f", or = "i", reb = "i", or_perc = "f", dr_perc = "f", rank = "i", l = "i",
      "for" = "i", ga = "i", strk = "s", gp_home = "i", att_total_overall = "i", att_avg_overall = "i",
      br_avg = "f", dr_avg = "f", td = "i", td_avg = "f", fgm_avg = "f", fga_avg = "f", fg_perc_avg = "f",
      "3_pa_avg" = "f", "3_pm_avg" = "f", "2_pm_avg" = "f", "2_pa_avg" = "f", fd = "i", fd_avg = "i",
      of_avg = "f", f_on_avg = "f", pf_avg = "f", tf_avg = "f", tfo = "i", tfo_avg = "i", uf_avg = "f",
      fo = "i", fo_avg = "i", fcd = "i", fcd_avg = "i", fct = "i", fct_avg = "f", fbt = "i", fbt_avg = "f",
      f = "i", f_team = "i", f_team_avg = "f", o_rat_avg = "f", ad = "i", ad_avg = "i", ec = "f", to = "i",
      to_avg = "f", fbp_avg = "f", fbpa = "i", fbpm = "i", pitp_avg = "f", pitpa = "i", pitpa_avg = "f",
      pitpm = "i", pitpm_avg = "f", pfto = "i", pfto_avg = "f", "2nd_ch_pm" = "i", "2nd_ch_pm_avg" = "f",
      "2nd_ch_pa" = "i", "2nd_ch_pa_avg" = "f", ftm = "i", ftm_avg = "f", fta = "i", fta_avg = "f",
      poss = "i", poss_avg = "f", poss_o = "i", poss_o_avg = "f", dppp = "f", dppp_avg = "f", oppp = "f",
      oppp_avg = "f", pace = "i", pace_avg = "i", tl = "i", otr = "i", dtr = "i", tr = "i", tr_avg = "f",
      pr = "i", pr_avg = "f", ord = "i"
  ),
  team = c(
    names_code = "s", names_short = "s", names_long = "s", names_full = "s", names_code_site = "s",
      names_short_site = "s", names_full_site = "s", names_long_site = "s", info = "s", uuid = "s",
      nationality = "s", arena_name = "s", public_url = "s", icon = "s", owner_instance_id = "s",
      site_display_name = "s"
  ),
  team_played_games = c(
    date = "s", time = "s", game_uuid = "s", start_date_time = "s", state = "s", overtime = "b",
      shootout = "s", ssgt_uuid = "s", home_team_status = "s", home_team_uuid = "s",
      home_team_owner_instance_id = "s", home_team_code = "s", home_team_names_code = "s",
      home_team_names_short = "s", home_team_names_long = "s", home_team_names_full = "s",
      home_team_names_code_site = "s", home_team_names_short_site = "s", home_team_names_full_site = "s",
      home_team_names_long_site = "s", home_team_score = "i", home_team_icon = "s", away_team_status = "s",
      away_team_uuid = "s", away_team_owner_instance_id = "s", away_team_code = "s",
      away_team_names_code = "s", away_team_names_short = "s", away_team_names_long = "s",
      away_team_names_full = "s", away_team_names_code_site = "s", away_team_names_short_site = "s",
      away_team_names_full_site = "s", away_team_names_long_site = "s", away_team_score = "i",
      away_team_icon = "s", venue_uuid = "s", venue_name = "s", series_uuid = "s", series_code = "s",
      series_display_name = "s"
  ),
  team_stats = c(
    team_side = "s", game_source_id = "i", game_id = "i", team_id = "i", team_name = "s", team_code = "s",
      team_number = "i", instance_id = "s", source = "s", game_uuid = "s", period = "i", period_type = "s",
      tp = "i", fgm = "i", a = "i", reb = "i", stl = "i", blk = "i", pf = "i"
  ),
  team_upcoming_games = c(
    date = "s", time = "s", game_uuid = "s", start_date_time = "s", state = "s", overtime = "b",
      shootout = "s", ssgt_uuid = "s", home_team_status = "s", home_team_uuid = "s",
      home_team_owner_instance_id = "s", home_team_code = "s", home_team_names_code = "s",
      home_team_names_short = "s", home_team_names_long = "s", home_team_names_full = "s",
      home_team_names_code_site = "s", home_team_names_short_site = "s", home_team_names_full_site = "s",
      home_team_names_long_site = "s", home_team_score = "i", home_team_icon = "s", away_team_status = "s",
      away_team_uuid = "s", away_team_owner_instance_id = "s", away_team_code = "s",
      away_team_names_code = "s", away_team_names_short = "s", away_team_names_long = "s",
      away_team_names_full = "s", away_team_names_code_site = "s", away_team_names_short_site = "s",
      away_team_names_full_site = "s", away_team_names_long_site = "s", away_team_score = "i",
      away_team_icon = "s", venue_uuid = "s", venue_name = "s", series_uuid = "s", series_code = "s",
      series_display_name = "s"
  )
)
