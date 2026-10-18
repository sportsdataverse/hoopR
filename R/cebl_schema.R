# cebl_schema.R -- documented columns, dtypes and wire sources of the CEBL frames.
#
# Copied from sdv-py origin/main e3d232ebc9: `SPECS` of sportsdataverse/basketball/cebl/cebl_parsers.py.
# Each entry is `column = "<source>|<type>"`: the source is the wire key, `@x` the request stamp `x`,
# or `=...` a computed value (see `.cebl_value()`); the type is i integer, f double, s character,
# b logical, d Date, t POSIXct (UTC). Change the columns in sdv-py first, then copy them here.

#' @noRd
.cebl_specs <- list(
  seasons = c(
    season_id = "id|i", season = "year|i", is_active = "is_active|b", is_live = "is_live|b"
  ),
  teams = c(
    team_id = "id|i", name_en = "name_en|s", short_name_en = "short_name_en|s", name_fr = "name_fr|s",
    short_name_fr = "short_name_fr|s", is_active = "is_active|b", logo_url = "logo_url|s", icon_url =
    "icon_url|s"
  ),
  standings = c(
    season = "@season|i", team_id = "id|i", name_en = "name_en|s", short_name_en = "short_name_en|s", name_fr =
    "name_fr|s", short_name_fr = "short_name_fr|s", conference = "conference|s", position = "position|i", played
    = "played|i", wins = "wins|i", win_percentage = "win_percentage|f", home_wins = "home_wins|i", away_wins =
    "away_wins|i", losses = "losses|i", home_losses = "home_losses|i", away_losses = "away_losses|i",
    games_behind = "games_behind|f", points_difference = "points_difference|i", last_five = "last_five|s",
    streak = "streak|s", logo_url = "logo_url|s", icon_url = "icon_url|s", tickets_url_en = "tickets_url_en|s",
    tickets_url_fr = "tickets_url_fr|s", website_url_en = "website_url_en|s", website_url_fr =
    "website_url_fr|s", shop_url_en = "shop_url_en|s", shop_url_fr = "shop_url_fr|s", stats_url_en =
    "stats_url_en|s", stats_url_fr = "stats_url_fr|s"
  ),
  roster = c(
    season = "@season|i", team_id = "@team_id|i", player_id = "id|i", full_name = "full_name|s", nationality =
    "nationality|s", birth_date = "birth_date|d", position = "position|s", jersey_number = "jersey_number|s",
    photo_url = "photo_url|s"
  ),
  team_stats = c(
    season = "@season|i", mode = "@mode|s", competition = "@competition|s", segment = "@segment|s",
    vs_conference = "@vs_conference|s", vs_team_id = "@vs_team_id|i", team_id = "id|i", is_league_row =
    "=league_row|b", name_en = "name_en|s", short_name_en = "short_name_en|s", name_fr = "name_fr|s",
    short_name_fr = "short_name_fr|s", played = "played|i", wins = "wins|i", win_percentage =
    "win_percentage|f", losses = "losses|i", points = "points|f", points_against = "points_against|f",
    point_difference = "point_difference|f", field_goals_made = "field_goals_made|f", field_goals_attempted =
    "field_goals_attempted|f", field_goal_percentage = "field_goal_percentage|f", three_points_made =
    "three_points_made|f", three_points_attempted = "three_points_attempted|f", three_point_percentage =
    "three_point_percentage|f", free_throws_made = "free_throws_made|f", free_throws_attempted =
    "free_throws_attempted|f", free_throw_percentage = "free_throw_percentage|f", offensive_rebounds =
    "offensive_rebounds|f", defensive_rebounds = "defensive_rebounds|f", rebounds = "rebounds|f", assists =
    "assists|f", turn_overs = "turn_overs|f", steals = "steals|f", blocks = "blocks|f", fouls = "fouls|f",
    fouls_drawn = "fouls_drawn|f", efficiency = "efficiency|f", logo_url = "logo_url|s", icon_url =
    "icon_url|s", stats_url_en = "stats_url_en|s", stats_url_fr = "stats_url_fr|s"
  ),
  games = c(
    season = "=year:start_time_utc|i", game_id = "id|i", genius_match_id =
    "=genius:stats_url_en,cebl_stats_url_en|i", start_time_utc = "start_time_utc|t", competition =
    "competition|s", status = "status|s", period = "period|i", venue_name = "venue_name|s", home_team_id =
    "home_team_id|i", home_team_name = "home_team_name|s", home_team_score = "home_team_score|i", away_team_id =
    "away_team_id|i", away_team_name = "away_team_name|s", away_team_score = "away_team_score|i",
    home_team_logo_url = "home_team_logo_url|s", home_team_stats_url_en = "home_team_stats_url_en|s",
    home_team_stats_url_fr = "home_team_stats_url_fr|s", away_team_logo_url = "away_team_logo_url|s",
    away_team_stats_url_en = "away_team_stats_url_en|s", away_team_stats_url_fr = "away_team_stats_url_fr|s",
    stats_url_en = "stats_url_en|s", stats_url_fr = "stats_url_fr|s", cebl_stats_url_en = "cebl_stats_url_en|s",
    cebl_stats_url_fr = "cebl_stats_url_fr|s", tickets_url_en = "tickets_url_en|s", tickets_url_fr =
    "tickets_url_fr|s", broadcast_partner_logo_urls = "broadcast_partner_logo_urls|s"
  ),
  player_stats = c(
    season = "@season|i", mode = "@mode|s", competition = "@competition|s", segment = "@segment|s", player_id =
    "id|i", full_name = "full_name|s", nationality = "nationality|s", team_id = "team_id|i", team_name_en =
    "team_name_en|s", team_short_name_en = "team_short_name_en|s", team_name_fr = "team_name_fr|s",
    team_short_name_fr = "team_short_name_fr|s", team_logo_url = "team_logo_url|s", played = "played|i", started
    = "started|i", minutes = "minutes|f", points = "points|f", field_goals_made = "field_goals_made|f",
    field_goals_attempted = "field_goals_attempted|f", field_goal_percentage = "field_goal_percentage|f",
    three_points_made = "three_points_made|f", three_points_attempted = "three_points_attempted|f",
    three_point_percentage = "three_point_percentage|f", free_throws_made = "free_throws_made|f",
    free_throws_attempted = "free_throws_attempted|f", free_throw_percentage = "free_throw_percentage|f",
    offensive_rebounds = "offensive_rebounds|f", defensive_rebounds = "defensive_rebounds|f", rebounds =
    "rebounds|f", assists = "assists|f", turn_overs = "turn_overs|f", steals = "steals|f", blocks = "blocks|f",
    fouls = "fouls|f", double_doubles = "double_doubles|f", triple_doubles = "triple_doubles|f", target_scores =
    "target_scores|f"
  ),
  player_leaders = c(
    statistic = "=statistic|s", ranking = "ranking|i", season = "@season|i", mode = "@mode|s", competition =
    "@competition|s", player_id = "id|i", full_name = "full_name|s", team_id = "team_id|i", team_name_en =
    "team_name_en|s", team_short_name_en = "team_short_name_en|s", team_name_fr = "team_name_fr|s",
    team_short_name_fr = "team_short_name_fr|s", team_abbreviated_name = "team_abbreviated_name|s",
    team_logo_url = "team_logo_url|s", value = "value|f", photo_url = "photo_url|s"
  ),
  player_seasons = c(
    mode = "@mode|s", competition = "@competition|s", player_id = "id|i", season = "season|i", is_career =
    "=career|b", team_id = "team_id|i", team_name_en = "team_name_en|s", team_short_name_en =
    "team_short_name_en|s", team_name_fr = "team_name_fr|s", team_short_name_fr = "team_short_name_fr|s",
    team_logo_url = "team_logo_url|s", played = "played|i", started = "started|i", minutes = "minutes|f", points
    = "points|f", field_goals_made = "field_goals_made|f", field_goals_attempted = "field_goals_attempted|f",
    field_goal_percentage = "field_goal_percentage|f", three_points_made = "three_points_made|f",
    three_points_attempted = "three_points_attempted|f", three_point_percentage = "three_point_percentage|f",
    free_throws_made = "free_throws_made|f", free_throws_attempted = "free_throws_attempted|f",
    free_throw_percentage = "free_throw_percentage|f", offensive_rebounds = "offensive_rebounds|f",
    defensive_rebounds = "defensive_rebounds|f", rebounds = "rebounds|f", assists = "assists|f", turn_overs =
    "turn_overs|f", steals = "steals|f", blocks = "blocks|f", fouls = "fouls|f", double_doubles =
    "double_doubles|f", triple_doubles = "triple_doubles|f", target_scores = "target_scores|f"
  ),
  player = c(
    player_id = "id|i", full_name = "full_name|s", nationality = "nationality|s", birth_date = "birth_date|d",
    age = "age|i", position = "position|s", jersey_number = "jersey_number|s", team_id = "team_id|i",
    team_name_en = "team_name_en|s", team_short_name_en = "team_short_name_en|s", team_name_fr =
    "team_name_fr|s", team_short_name_fr = "team_short_name_fr|s", team_icon_url = "team_icon_url|s",
    team_stats_url_en = "team_stats_url_en|s", team_stats_url_fr = "team_stats_url_fr|s", photo_url =
    "photo_url|s"
  ),
  player_gamelog = c(
    player_id = "@player_id|i", season = "=year:game_date|i", game_date = "game_date|t", genius_match_id =
    "=genius:game_stats_url_en|i", team_abbreviated_name = "team_abbreviated_name|s", matchup = "matchup|s",
    minutes = "minutes|f", points = "points|i", field_goals_made = "field_goals_made|i", field_goals_attempted =
    "field_goals_attempted|i", field_goal_percentage = "field_goal_percentage|f", three_points_made =
    "three_points_made|i", three_points_attempted = "three_points_attempted|i", three_point_percentage =
    "three_point_percentage|f", free_throws_made = "free_throws_made|i", free_throws_attempted =
    "free_throws_attempted|i", free_throw_percentage = "free_throw_percentage|f", offensive_rebounds =
    "offensive_rebounds|i", defensive_rebounds = "defensive_rebounds|i", rebounds = "rebounds|i", assists =
    "assists|i", turn_overs = "turn_overs|i", steals = "steals|i", blocks = "blocks|i", fouls = "fouls|i",
    is_target_scorer = "is_target_scorer|b", game_stats_url_en = "game_stats_url_en|s", game_stats_url_fr =
    "game_stats_url_fr|s", team_stats_url_en = "team_stats_url_en|s", team_stats_url_fr = "team_stats_url_fr|s"
  ),
  news = c(
    news_id = "id|i", language = "@language|s", title = "title|s", published_at_utc = "published_at_utc|t",
    image_url = "image_url|s", html_content = "html_content|s"
  )
)
