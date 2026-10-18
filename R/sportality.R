# sportality.R -- Basketligaen (Denmark) wrappers over www.basketligaen.dk/api, at parity with sdv-py
# sportsdataverse/basketball/dbl (origin/main e3d232e). The site runs on the Sportality platform; its stats
# are genius-basketball (Genius Sports LiveStats), so the Genius match, team and person ids join the genius
# family. Transport, season mapping and refusals: R/sportality_runtime.R; frames: R/sportality_parsers.R;
# documented columns: R/sportality_schema.R.

#' @title
#' **Get Basketligaen Player Career**
#' @description
#' Player career totals, one row per ssgt.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/athlete/playerProfile_gameLog`
#' @param athlete_uuid (required) Athlete uuid.
#' @param master_site_instance_id (default `NULL`) Site instance (dbl1_dbl). No effect in the drop-one probe.
#' @return
#' A `hoopR_data` tibble: Player career totals, one row per ssgt. An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_athlete_career`), then any column the
#'   API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | g | integer | Games played in the ssgt. |
#' | gps | integer | Games started (0 on every row seen). |
#' | mpg | double | Minutes per game, 'M.m' string. |
#' | ppg | double | Points per game (a number or. |
#' | drpg | double | Defensive rebounds per game. |
#' | orpg | double | Offensive rebounds per game. |
#' | rpg | double | Rebounds per game. |
#' | apg | double | Assists per game. |
#' | stpg | double | Steals per game. |
#' | blkpg | double | Blocks per game. |
#' | pfpg | double | Personal fouls per game. |
#' | 2_p_perc | double | Two-point percentage, 0-100. |
#' | 3_pm | integer | Three-pointers made (total). |
#' | 3_pa | double | Three-pointers attempted (total, or a percentage string in the checked rows; unverified). |
#' | 3_p_perc | double | Three-point percentage, 0-100. |
#' | ft_perc | double | Free-throw percentage, 0-100. |
#' | topg | double | Turnovers per game. |
#' | plus_minus_pg | double | Plus/minus per game. |
#' | info_uuid | character | Athlete uuid on player tables, team uuid on team tables (platform key space). |
#' | info_full_name | character | Full display name of the player. |
#' | info_first_name | character | Given (first) name(s) of the player. |
#' | info_last_name | character | Family name (surname) of the player. |
#' | info_nationality | character | ISO 3166-1 alpha-2 country code. |
#' | info_gender | character | Gender of the person as recorded by the site (male in every row seen). |
#' | info_age_value | integer | Age in whole years. |
#' | info_age_format | character | Unit of the value (years). Values: `years` = years. |
#' | info_weight_value | integer | Weight of the player in kilograms. |
#' | info_weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
#' | info_height_value | integer | Height of the player in centimetres. |
#' | info_height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
#' | info_jersey_number | character | Jersey number ('N/A' on career rows). |
#' | info_position | character | Position code (G, F, C, SG, SF ...). |
#' | info_position_code | character | Position code ('N/A' on career rows). Values: `N/A` = not applicable (career rows). |
#' | info_shoots | character | Shooting hand (null). |
#' | info_team_uuid | character | Team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | info_team_instance_id | character | Site instance id of the club (platform key space). |
#' | info_team_name | character | Name of the team. |
#' | info_team_code | character | Three-letter team code. |
#' | info_season_stats | character | Season totals (always empty here). |
#' | info_career_stats | character | Career totals (always empty here). |
#' | info_statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |
#' | info_is_in_squad | logical | Whether the player is in the team's current squad. |
#' | info_player_id | integer | Genius person id (Genius key space; an integer). |
#' | info_ssgt_uuid | character | ssgt uuid of the career row (platform key space). |
#' | info_team_id | integer | Genius team id (Genius key space; an integer here). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_career(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")')
#' @export
#' @family Basketligaen Functions
sportality_athlete_career <- function(athlete_uuid, master_site_instance_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(athlete_uuid, "athlete_uuid")
  .sportality_check_id(master_site_instance_id, "master_site_instance_id", optional = TRUE)
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/athlete/playerProfile_gameLog"),
    list(playerUuid = athlete_uuid, masterSiteInstanceId = master_site_instance_id),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_stats_info(raw, .sportality_schemas$athlete_career),
    "Basketligaen Player Career from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Athlete Details**
#' @description
#' Player bio plus playerExtIds (the Genius person id).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/athlete-details/{athlete_uuid}`
#' @param athlete_uuid (required) Athlete uuid: roster `players[].uuid` or stats-info `stats[].info.uuid`. Key space: platform
#'   athlete uuids (not the Genius person id).
#' @return
#' A `hoopR_data` tibble: Player bio plus playerExtIds (the Genius person id). An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_athlete_details`),
#'   then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | athlete_uuid | character | Platform athlete uuid (rosters and athlete routes key on it); not the Genius person id; null where the site has none. |
#' | player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
#' | created_at | character | Creation timestamp. |
#' | created_by | character | Creating site instance. |
#' | creator_site | character | Unobserved: null in every sample and every full body. When filled: Creating site (null). |
#' | height | integer | Height of the player in centimetres. |
#' | deleted | logical | Soft-delete flag. |
#' | first_name | character | Given (first) name(s) of the player. |
#' | gender | character | Gender of the person as recorded by the site (male in every row seen). |
#' | last_modified | character | Last-modified timestamp. |
#' | last_name | character | Family name (surname) of the player. |
#' | metadata | character | Free metadata (always empty). |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | shoots | character | Shooting hand (''). |
#' | weight | integer | Weight of the player in kilograms. |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_details(athlete_uuid = "dpu0901c0t")')
#' @export
#' @family Basketligaen Functions
sportality_athlete_details <- function(athlete_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(athlete_uuid, "athlete_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/athlete-details/", athlete_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_athlete(raw, .sportality_schemas$athlete_details),
    "Basketligaen Athlete Details from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Athlete Profile**
#' @description
#' Player profile: age, height, position, season and career totals.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/athlete/profile-page`
#' @param athlete_uuid (required) Athlete uuid.
#' @param master_site_instance_id (default `NULL`) Site instance (dbl1_dbl). No effect in the drop-one probe.
#' @return
#' A `hoopR_data` tibble: Player profile: age, height, position, season and career totals. An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_athlete_profile`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | uuid | character | Platform uuid of this record (10-character lowercase key space of its record type; joins the route that serves it). |
#' | full_name | character | Full display name of the player. |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | gender | character | Gender of the team or player: male or female (every record on this host is male). |
#' | age_value | integer | Age in whole years. |
#' | age_format | character | Unit of the value (years). Values: `years` = years. |
#' | weight_value | integer | Weight of the player in kilograms. |
#' | weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
#' | height_value | integer | Height of the player in centimetres. |
#' | height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
#' | jersey_number | integer | Jersey (shirt) number of the player. |
#' | position | character | Playing position. |
#' | position_code | character | Position code (G, F, C, or a finer code such as SG on the profile route). Values: `G` = guard. |
#' | shoots | character | Shooting hand (empty or null for every player seen). |
#' | team_uuid | character | Platform team uuid. |
#' | team_instance_id | character | Site instance id of the club (platform key space). |
#' | team_name | character | Name of the team. |
#' | team_code | character | Platform team code (HOL, RAN). |
#' | team_media | character | URL of the team logo image. |
#' | season_stats | character | The player's current-season totals as field/value pairs (GP, PAvg, ...). |
#' | career_stats | character | The player's career totals as field/value pairs. |
#' | statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |
#' | is_in_squad | logical | Whether the player is in the team's current squad. |
#' | media_url | character | Portrait image URL (imgix CDN). |
#' | media_alt | character | Image alt text (''). |
#' | media_srcset | character | Responsive image set (imgix CDN URLs with widths). |
#' | media_url_img_original_proportion | character | Portrait URL at its original proportions. |
#' | media_url_placeholder_image | character | Placeholder image URL (''). |
#' | media_videourl | character | Video URL (''). |
#' | media_photographer | character | Photographer credit (''). |
#' | media_focal_point | character | Focal point record (empty). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_profile(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")')
#' @export
#' @family Basketligaen Functions
sportality_athlete_profile <- function(athlete_uuid, master_site_instance_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(athlete_uuid, "athlete_uuid")
  .sportality_check_id(master_site_instance_id, "master_site_instance_id", optional = TRUE)
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/athlete/profile-page"),
    list(playerUuid = athlete_uuid, masterSiteInstanceId = master_site_instance_id),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_page(raw, .sportality_schemas$athlete_profile),
    "Basketligaen Athlete Profile from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Box Score**
#' @description
#' Player box score and team rows of both sides (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/boxscore/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Player box score and team rows of both sides (2023/24 on). An empty valid answer
#'   raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_boxscore`),
#'   then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_side | character | home or away: the side the row belongs to. |
#' | row_type | character | Kind of row: player, team_coach (the bench row: team rebounds, turnovers and fouls charged to the team or coach) or team_totals. |
#' | player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
#' | team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
#' | team_name | character | Name of the team. |
#' | period | integer | Period of the line: 0 = the whole game (the only value seen). |
#' | full_name | character | Full display name of the player. |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | nr | integer | Jersey number (null on the bench and totals rows). |
#' | pos | character | Position code of the line (G, F, C; null on the bench and totals rows). |
#' | mins | character | Minutes played as 'MM:SS' (null on the bench and totals rows). |
#' | pts | integer | Number of points scored. |
#' | fg | character | Field goals as 'made-attempted'. |
#' | fg_perc | double | Field-goal percentage, 0-100. |
#' | 2_p | character | Two-pointers as 'made-attempted'. |
#' | 2_p_perc | double | Two-point percentage, 0-100. |
#' | 3_p | character | Three-pointers as 'made-attempted'. |
#' | 3_p_perc | double | Three-point percentage, 0-100. |
#' | ft | character | Free throws as 'made-attempted'. |
#' | ft_perc | double | Free-throw percentage, 0-100. |
#' | off | integer | Offensive rebounds. |
#' | def | integer | Defensive rebounds. |
#' | reb | integer | Total rebounds. |
#' | ast | integer | Number of assists credited. |
#' | to | integer | Number of turnovers committed. |
#' | stl | integer | Number of steals. |
#' | blk | integer | Number of blocked shots made. |
#' | blkr | integer | Blocks received (shots of the player that were blocked). |
#' | pf | integer | Personal fouls. |
#' | f_on | integer | Fouls on (fouls drawn). |
#' | plus_minus | integer | Plus/minus while on court. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_boxscore(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_boxscore <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/boxscore/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_player_box(raw, .sportality_schemas$boxscore),
    "Basketligaen Box Score from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Game Header**
#' @description
#' Game header: Genius match id (extId), arena, state, teams, scores.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/game-info/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Game header: Genius match id (extId), arena, state, teams, scores. An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_game_header`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | instance_context_site_team_is_in_game | logical | Whether the requesting site's own team plays in the game. |
#' | instance_context_site_team_is_home_team | logical | Whether the requesting site's own team is the home team. |
#' | instance_context_site_team_is_away_team | logical | Whether the requesting site's own team is the away team. |
#' | game_info_game_uuid | character | Game uuid (platform key space). |
#' | game_info_ext_id | integer | Genius match id (Int64; the same number as gameday game_source_id). |
#' | game_info_start_date_time | character | Scheduled start, ISO 8601 UTC with milliseconds. |
#' | game_info_arena_name | character | Name of the arena (venue). |
#' | game_info_state | character | Game state, underscore form: post_game once played. Values: `post_game` = played (sports-v2 game-info). |
#' | game_info_overtime | logical | Whether the game went to overtime. |
#' | game_info_shootout | character | Unobserved: null in every sample and every full body. When filled: Shootout flag (null on every game seen). |
#' | game_info_series_code | character | Series code (DBL). |
#' | game_info_series_name | character | Series name (Basketligaen). |
#' | game_info_round_number | integer | Round number (0). |
#' | game_info_round_label | character | Round label (''). |
#' | game_info_series_display_name | character | Series display name (Basketligaen). |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_instance_id | character | Site instance id of the home club (platform key space). |
#' | home_team_founded_on | character | Year the club was founded ('' when unknown). |
#' | home_team_icon | character | Home team logo URL. |
#' | home_team_score | integer | Points scored by the home team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_instance_id | character | Site instance id of the away club (platform key space). |
#' | away_team_founded_on | character | Year the club was founded ('' when unknown). |
#' | away_team_icon | character | Away team logo URL. |
#' | away_team_score | integer | Points scored by the away team. |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | series_uuid | character | Series uuid (platform key space; Basketligaen = m1ay3mpa4t, the only series on this host). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_game_header(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_game_header <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/game-info/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_page(raw, .sportality_schemas$game_header),
    "Basketligaen Game Header from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Game Overview**
#' @description
#' Score, state, clock and the Genius ids of one game (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/game-overview/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Score, state, clock and the Genius ids of one game (2023/24 on). An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_game_overview`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | home_team_game_source_id | integer | Genius match id (Genius key space; integer here). |
#' | home_team_game_id | integer | Genius match id (Genius key space; the same number as gameSourceId). |
#' | home_team_team_id | integer | Genius team id of the home team (Genius key space; Int64). |
#' | home_team_team_name | character | Name of the home team. |
#' | home_team_team_code | character | Home team code as Genius spells it (mixed case, 'Hol'). |
#' | home_team_team_number | integer | Team number in the game; home is 1. |
#' | home_team_place | character | home. Values: `home` = home team. |
#' | home_team_instance_id | character | Site instance id of the home club (platform key space). |
#' | home_team_source | character | Feed that produced the row (genius-basketball-stream-reader). |
#' | home_team_game_uuid | character | Game uuid (platform key space). |
#' | away_team_game_source_id | integer | Genius match id (Genius key space; integer here). |
#' | away_team_game_id | integer | Genius match id (Genius key space; the same number as gameSourceId). |
#' | away_team_team_id | integer | Genius team id of the away team (Genius key space; Int64). |
#' | away_team_team_name | character | Name of the away team. |
#' | away_team_team_code | character | Away team code as Genius spells it. |
#' | away_team_team_number | integer | Team number in the game; away is 2. |
#' | away_team_place | character | away. Values: `away` = away team. |
#' | away_team_instance_id | character | Site instance id of the away club (platform key space). |
#' | away_team_source | character | Feed that produced the row (genius-basketball-stream-reader). |
#' | away_team_game_uuid | character | Game uuid (platform key space). |
#' | home_goals | integer | Points scored by the home team. |
#' | away_goals | integer | Points scored by the away team. |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `GameEnded` = played (gameday overview). |
#' | time_game_id | integer | Genius match id (Genius key space). |
#' | time_period | integer | Period number the clock stands in (1-4 regulation, 5+ overtime). |
#' | time_period_time | character | Clock remaining in the period, 'hh:mm:ss' ('00:00:00' once the period or game is over). |
#' | time_instance_id | character | Site instance that owns the feed (platform key space; dbl1_dbl). |
#' | time_source | character | Feed that produced the row (genius-basketball-stream-reader). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_game_overview(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_game_overview <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/game-overview/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_page(raw, .sportality_schemas$game_overview),
    "Basketligaen Game Overview from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Game Summary**
#' @description
#' Points per period, team comparison and best scorers (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/game-info/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Points per period, team comparison and best scorers (2023/24 on). An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_game_summary`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_head2_head | character | Team comparison rows (2P, 3P, FT, rebounds, ...), home and away side by side. |
#' | team_period_caption | character | Column caption of the table (G = goals/points). Values: `G` = goals/points column. |
#' | team_period_overtime | logical | Whether the game went to overtime. |
#' | team_period_shootout | logical | Whether the game was decided by a shootout (false). |
#' | team_period_stats | character | One row per period. |
#' | best_scorers | character | The game's top scorers, one per side (or the two best). |
#' | statistics_provider | character | Stats provider of the data (genius-basketball = Genius Sports LiveStats). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_game_summary(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_game_summary <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/game-info/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_page(raw, .sportality_schemas$game_summary),
    "Basketligaen Game Summary from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Last Game Day**
#' @description
#' Games of the last played match day of an ssgt.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/last-game-day`
#' @param season (default `NULL`) Season END year (2026 = 2025/26), mapped to its ssgt through layout-info. NULL = the active
#'   ssgt (these match-day views follow the current season).
#' @param game_type (default `"regular"`) Game type: regular (the league season) or finals (the playoffs, Slutspil).
#' @return
#' A `hoopR_data` tibble: Games of the last played match day of an ssgt. An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_last_game_day`), then
#'   any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `post-game` = played (schedule, day views). |
#' | overtime | logical | Whether the game went to overtime. |
#' | shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | home_team_code | character | Three-letter code of the home team. |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_score | integer | Home points; null before the game is played. |
#' | home_team_icon | character | Home team logo URL. |
#' | away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | away_team_code | character | Three-letter code of the away team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_score | integer | Away points; null before the game is played. |
#' | away_team_icon | character | Away team logo URL. |
#' | venue_uuid | character | Venue uuid (platform key space). |
#' | venue_name | character | Venue name; absent when unknown. |
#' | series_uuid | character | Series uuid (platform key space). |
#' | series_code | character | Series display name (Basketligaen; NOT the DBL code). |
#' | series_display_name | character | Series display name (Basketligaen). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_last_game_day())
#' }
#' @export
#' @family Basketligaen Functions
sportality_last_game_day <- function(season = NULL, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_choice(game_type, .SPORTALITY_GAME_TYPES, "game_type")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/last-game-day"),
    list(season = season, gameType = game_type),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_schedule(raw, .sportality_schemas$last_game_day),
    "Basketligaen Last Game Day from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Layout Info (ssgt Directory)**
#' @description
#' Directory of every ssgt (season + series + game type) with its teams, and the stats modules.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/layout-info`
#' @return
#' A `hoopR_data` tibble: Directory of every ssgt (season + series + game type) with its teams, and the stats
#'   modules. An empty valid answer raises `hoopR_no_data`; the documented columns come first, in this order
#'   (sdv-py `sportality_layout_info`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025/26). |
#' | season_code | character | Provider season code: the START year (2025 = 2025/26). |
#' | season_name | character | Season name as 'YYYY/YYYY' (start/end year). |
#' | game_type | character | Game type of the game ('' on every line seen). |
#' | game_type_name | character | Game type name in Danish (Grundspil = regular season, Slutspil = playoffs). |
#' | series_code | character | Series code (DBL = Basketligaen). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `active` = current ssgt; `closed` = past ssgt. |
#' | season_uuid | character | Season uuid (platform key space). |
#' | series_uuid | character | Series uuid (platform key space). |
#' | game_type_uuid | character | Game type uuid (platform key space). |
#' @eval .intl_details(.sportality_schedule_details, "sportality_layout_info()")
#' @export
#' @family Basketligaen Functions
sportality_layout_info <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/layout-info"),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_layout(raw, .sportality_schemas$layout_info),
    "Basketligaen Layout Info (ssgt Directory) from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Next Game Day**
#' @description
#' Games of the next match day of an ssgt.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/next-game-day`
#' @param season (default `NULL`) Season END year (2026 = 2025/26), mapped to its ssgt through layout-info. NULL = the active
#'   ssgt (these match-day views follow the current season).
#' @param game_type (default `"regular"`) Game type: regular (the league season) or finals (the playoffs, Slutspil).
#' @return
#' A `hoopR_data` tibble: Games of the next match day of an ssgt. An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_next_game_day`), then any column the
#'   API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `pre-game` = not yet played (schedule, day views). |
#' | overtime | logical | Whether the game went to overtime. |
#' | shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `N/A` = no result yet / not applicable. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | home_team_code | character | Three-letter code of the home team. |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_score | integer | Home points; null before the game is played. |
#' | home_team_icon | character | Home team logo URL. |
#' | away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `N/A` = no result yet / not applicable. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | away_team_code | character | Three-letter code of the away team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_score | integer | Away points; null before the game is played. |
#' | away_team_icon | character | Away team logo URL. |
#' | venue_uuid | character | Venue uuid (platform key space). |
#' | venue_name | character | Venue name; absent when unknown. |
#' | series_uuid | character | Series uuid (platform key space). |
#' | series_code | character | Series display name (Basketligaen; NOT the DBL code). |
#' | series_display_name | character | Series display name (Basketligaen). |
#' @eval .intl_details(.sportality_schedule_details, "sportality_next_game_day()")
#' @export
#' @family Basketligaen Functions
sportality_next_game_day <- function(season = NULL, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_choice(game_type, .SPORTALITY_GAME_TYPES, "game_type")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/next-game-day"),
    list(season = season, gameType = game_type),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_schedule(raw, .sportality_schemas$next_game_day),
    "Basketligaen Next Game Day from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Play-by-Play**
#' @description
#' Play-by-play events with shot coordinates and the Genius ids (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/play-by-play/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Play-by-play events with shot coordinates and the Genius ids (2023/24 on). An empty
#'   valid answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_pbp`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_source_id | integer | Genius match id (Int64), the same number as game_id and sports-v2 game_info_ext_id. |
#' | game_id | integer | Genius match id (Int64), the join to the genius family; on play-by-play lines, an integer elsewhere. |
#' | event_id | integer | Genius event number within the game (Int64), increasing through the game. |
#' | type | character | Event type: one line per action; shots are the shooter's line, assists, blocks, steals and fouls drawn are further lines. Values: `2pt` = two-point attempt (made when isSuccessful = 1); `3pt` = three-point attempt (made when isSuccessful = 1); `assist` = assist on the previous made shot; `block` = block; `clock` = clock start, stop or adjustment; `foul` = foul committed; `foulon` = foul drawn (fouled player); `freethrow` = free-throw attempt; `game` = game start / end line; `headcoachchallenge` = head coach challenge; `jumpball` = jump ball or held ball; `period` = period start / end line; `rebound` = rebound; `steal` = steal; `substitution` = substitution (in or out); `timeout` = timeout; `turnover` = turnover. |
#' | event_uuid | character | Event uuid (UUID v5 derived from the event; unique per event). |
#' | period | integer | Period: 0 = the whole game, 1-4 the quarters, 5 and up overtime. |
#' | period_type | character | REGULAR or OVERTIME; absent on the period marker lines. Values: `OVERTIME` = overtime period; `REGULAR` = regulation period. |
#' | time | character | Clock REMAINING in the period as mm:ss:cc (cc looks like hundredths of a second, only ever 00, 10, 30, 50 ... seen; unverified). Absent on the per-period marker lines. |
#' | real_world_time | character | Wall-clock time of the event, ISO 8601 UTC. |
#' | updated_time | character | When the feed last updated the event, ISO 8601 UTC. |
#' | home_team_id | integer | Genius team id of the home team (Genius key space; Int64). |
#' | home_team_code | character | Home team code as Genius spells it (mixed case, 'Hol'). |
#' | home_team_name | character | Name of the home team. |
#' | home_abbreviation | character | Home team abbreviation. |
#' | home_team_number | integer | Team number in the game; home is 1. |
#' | home_place | character | Side of the home block: always home. |
#' | home_score | integer | Points scored by the home team. |
#' | away_team_id | integer | Genius team id of the away team (Genius key space; Int64). |
#' | away_team_code | character | Away team code as Genius spells it. |
#' | away_team_name | character | Name of the away team. |
#' | away_abbreviation | character | Away team abbreviation. |
#' | away_team_number | integer | Team number in the game; away is 2. |
#' | away_place | character | Side of the away block: always away. |
#' | away_score | integer | Points scored by the away team. |
#' | revision | integer | Revision counter of the event. |
#' | game_state | character | Game state at the event: ongoing during play, GameEnded on the final line. Values: `GameEnded` = game over (the final line of a complete feed); `ongoing` = game in progress. |
#' | game_type | character | Game type of the game ('' on every line seen). |
#' | round | integer | Round number (0). |
#' | start_date_and_time | character | Start of the game ('' on every line seen). |
#' | sub_type | character | Refinement of `type` (the shot type, rebound kind, foul kind, ...); null on types that have none. Values: `1of1` = free throw 1 of 1; `1of2` = free throw 1 of 2; `1of3` = free throw 1 of 3; `24sec` = shot-clock violation; `2of2` = free throw 2 of 2; `2of3` = free throw 2 of 3; `3of3` = free throw 3 of 3; `3sec` = three-second violation; `5sec` = five-second violation; `8sec` = eight-second violation; `adjustment` = clock adjustment; `alleyoop` = alley-oop shot; `alleyoopdunk` = alley-oop dunk; `backcourt` = backcourt violation; `badpass` = bad pass; `ballhandling` = ball-handling error; `benchTechnical` = technical foul on the bench; `coachTechnical` = technical foul on the coach; `defensive` = defensive rebound; `disqualifying` = disqualifying foul; `disruptive` = disruptive foul (unverified); `doubledribble` = double dribble; `drivinglayup` = driving layup; `dunk` = dunk; `end` = end of the period or game; `eurostep` = euro-step layup; `fadeaway` = fadeaway jump shot; `flagrant` = flagrant foul; `floatingjumpshot` = floating jump shot; `full` = full timeout; `heldball` = held ball; `hookshot` = hook shot; `in` = player enters; `jumpshot` = jump shot; `layup` = layup; `lodgedball` = lodged ball; `lost` = lost the jump ball; `offensive` = offensive rebound or offensive foul; `offensivegoaltending` = offensive goaltending; `officials` = official timeout; `other` = other; `out` = player leaves; `outofbounds` = out of bounds; `outofboundsrebound` = rebound off an out-of-bounds ball (unverified); `personal` = personal foul; `pullupjumpshot` = pull-up jump shot; `reverselayup` = reverse layup; `start` = start of the period or game, or clock start; `startperiod` = start of a period (jump ball line); `stepbackjumpshot` = step-back jump shot; `stop` = clock stop; `technical` = technical foul; `throwIn` = throw-in violation (unverified); `tipindunk` = tip-in dunk; `tipinlayup` = tip-in layup; `travel` = traveling; `turnaroundjumpshot` = turnaround jump shot; `unsportsmanlike` = unsportsmanlike foul; `won` = won the jump ball. |
#' | qualifiers | character | Event qualifiers joined by ';' (a list in recent games, a ';'-joined string or null in older ones). |
#' | is_successful | integer | 1 when the action succeeded (a made shot or free throw, a recorded rebound ...). ABSENT, not 0, for a missed shot, so count misses as rows without it. |
#' | instance_id | character | Site instance id of the club or league (platform key space, `<code><n>_<code>` such as hol2_hol; the league itself is dbl1_dbl). |
#' | source | character | Feed that produced the line (genius-basketball-stream-reader). |
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | event_team_id | integer | Genius team id (Genius key space; Int64). |
#' | event_team_code | character | Team code as Genius spells it. |
#' | event_team_name | character | Name of the team. |
#' | event_abbreviation | character | Team abbreviation. |
#' | event_team_number | integer | Team number in the game (1 home, 2 away). |
#' | event_place | character | Side of the team the event belongs to: home or away. |
#' | player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
#' | player_pno | integer | Genius shirt-table number of the player. |
#' | player_team_number | integer | Team number in the game (1 home, 2 away). |
#' | player_first_name | character | Given (first) name(s) of the player. |
#' | player_family_name | character | Family name (this route says familyName; the others lastName). |
#' | coordinates_x | double | Shot or event x coordinate in Genius court units (Float64); origin and scale unverified. |
#' | coordinates_y | double | Shot or event y coordinate in Genius court units (Float64); origin and orientation unverified. |
#' | period_time | integer | Marker lines only: 0 (an integer), the start of the period. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_pbp(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_pbp <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/play-by-play/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_pbp(raw, .sportality_schemas$pbp),
    "Basketligaen Play-by-Play from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Player Box Score**
#' @description
#' Box score with jersey and Genius shirt numbers (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/player-stats/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Box score with jersey and Genius shirt numbers (2023/24 on). An empty valid answer
#'   raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_player_box`),
#'   then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_side | character | home or away: the side the row belongs to. |
#' | row_type | character | Kind of row: player, team_coach (the bench row: team rebounds, turnovers and fouls charged to the team or coach) or team_totals. |
#' | player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
#' | team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
#' | team_name | character | Name of the team. |
#' | period | integer | Period of the line: 0 = the whole game (the only value seen). |
#' | full_name | character | Full display name of the player. |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | nr | integer | Jersey number (null on the bench and totals rows). |
#' | pos | character | Position code of the line (G, F, C; null on the bench and totals rows). |
#' | mins | character | Minutes played as 'MM:SS' (null on the bench and totals rows). |
#' | pts | integer | Number of points scored. |
#' | fg | character | Field goals as 'made-attempted'. |
#' | fg_perc | double | Field-goal percentage, 0-100. |
#' | 2_p | character | Two-pointers as 'made-attempted'. |
#' | 2_p_perc | double | Two-point percentage, 0-100. |
#' | 3_p | character | Three-pointers as 'made-attempted'. |
#' | 3_p_perc | double | Three-point percentage, 0-100. |
#' | ft | character | Free throws as 'made-attempted'. |
#' | ft_perc | double | Free-throw percentage, 0-100. |
#' | off | integer | Offensive rebounds. |
#' | def | integer | Defensive rebounds. |
#' | reb | integer | Total rebounds. |
#' | ast | integer | Number of assists credited. |
#' | to | integer | Number of turnovers committed. |
#' | stl | integer | Number of steals. |
#' | blk | integer | Number of blocked shots made. |
#' | blkr | integer | Blocks received (shots of the player that were blocked). |
#' | pf | integer | Personal fouls. |
#' | f_on | integer | Fouls on (fouls drawn). |
#' | plus_minus | integer | Plus/minus while on court. |
#' | team_number | integer | Team number in the game (1 home, 2 away) as Genius numbers the shirt table. |
#' | pno | integer | Genius shirt-table number of the player (player-stats only). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_player_box(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_player_box <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/player-stats/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_player_box(raw, .sportality_schemas$player_box),
    "Basketligaen Player Box Score from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Player Head-to-Head**
#' @description
#' Player head-to-head of a matchup with per-game and season lines.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/player-h2h-v2/{ssgt_uuid}/{home_team_uuid}/{away_team_uuid}`
#' @param ssgt_uuid (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp = 2026/2027 regular season.
#'   Directory: `/statistics-v2/layout-info` `seasonSeriesGameTypeTeams[].ssgtUuid`.
#' @param home_team_uuid (required) Home team uuid of the game.
#' @param away_team_uuid (required) Away team uuid of the game.
#' @param game_uuid (default `NULL`) Game uuid; selects the game whose box-score lines the head-to-head carries.
#' @return
#' A `hoopR_data` tibble: Player head-to-head of a matchup with per-game and season lines. An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_player_h2h`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | uuid | character | Athlete uuid (platform key space). |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | full_name | character | Full display name of the player. |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | gender | character | Gender of the person as recorded by the site (male in every row seen). |
#' | jersey_number | integer | Jersey (shirt) number of the player. |
#' | position | character | Position name (Guard, Forward, Center ...). |
#' | position_code | character | Position code. Values: `C` = center; `G` = guard; `N/A` = not applicable (career rows); `PF` = power forward; `PG` = point guard; `SF` = small forward; `SG` = shooting guard. |
#' | age_value | integer | Age in whole years. |
#' | age_format | character | Unit of the value (years). Values: `years` = years. |
#' | height_value | integer | Height of the player in centimetres. |
#' | height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
#' | weight_value | integer | Weight of the player in kilograms. |
#' | weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
#' | team_uuid | character | Platform team uuid. |
#' | team_instance_id | character | Site instance id of the club (platform key space). |
#' | team_name | character | Name of the team. |
#' | team_code | character | Platform team code (HOL, RAN). |
#' | team_media | character | URL of the team logo image. |
#' | media_url | character | Portrait image URL (imgix CDN). |
#' | media_alt | character | Image alt text (''). |
#' | media_srcset | character | Responsive image set (imgix CDN URLs with widths). |
#' | season_stats | character | Season totals as field/value pairs (absent for some players). |
#' | career_stats | character | Career totals as field/value pairs (absent for some players). |
#' | match_stats_nr | integer | Jersey (shirt) number of the player. |
#' | match_stats_pos | character | Playing position code of the player (G, F, C, ...). |
#' | match_stats_team_number | integer | Team number in the game. |
#' | match_stats_pno | integer | Genius shirt-table number. |
#' | match_stats_mins | character | Minutes played 'MM:SS'. |
#' | match_stats_pts | integer | Number of points scored. |
#' | match_stats_fg | character | Field goals 'made-attempted'. |
#' | match_stats_fg_perc | double | Field-goal percentage, 0-100. |
#' | match_stats_2_p | character | Two-pointers 'made-attempted'. |
#' | match_stats_2_p_perc | double | Two-point percentage, 0-100. |
#' | match_stats_3_p | character | Three-pointers 'made-attempted'. |
#' | match_stats_3_p_perc | double | Three-point percentage, 0-100. |
#' | match_stats_ft | character | Free throws 'made-attempted'. |
#' | match_stats_ft_perc | double | Free-throw percentage, 0-100. |
#' | match_stats_off | integer | Offensive rebounds. |
#' | match_stats_def | integer | Defensive rebounds. |
#' | match_stats_reb | integer | Total rebounds. |
#' | match_stats_ast | integer | Number of assists credited. |
#' | match_stats_to | integer | Number of turnovers committed. |
#' | match_stats_stl | integer | Number of steals. |
#' | match_stats_blk | integer | Number of blocked shots made. |
#' | match_stats_blkr | integer | Blocks received. |
#' | match_stats_pf | integer | Personal fouls. |
#' | match_stats_f_on | integer | Fouls on (fouls drawn). |
#' | match_stats_plus_minus | integer | Plus/minus while on court. |
#' | season_avg_stats | character | The player's season averages (an object keyed by stat). |
#' | statistics_provider | character | Stats provider (genius-basketball). |
#' | is_in_squad | logical | Whether the player is in the squad. |
#' | effective_ssgt_uuid | character | The ssgt the head-to-head was computed for: the CURRENT season, whatever the path asked. |
#' @eval .intl_details(.sportality_schedule_details, c(
#'   'sportality_player_h2h(',
#'   '  away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",',
#'   '  ssgt_uuid = "xs07bd3fmp"',
#'   ')'
#' ))
#' @export
#' @family Basketligaen Functions
sportality_player_h2h <- function(ssgt_uuid, home_team_uuid, away_team_uuid, game_uuid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(ssgt_uuid, "ssgt_uuid")
  .sportality_check_id(home_team_uuid, "home_team_uuid")
  .sportality_check_id(away_team_uuid, "away_team_uuid")
  .sportality_check_id(game_uuid, "game_uuid", optional = TRUE)
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/player-h2h-v2/", ssgt_uuid, "/", home_team_uuid, "/", away_team_uuid),
    list(gameUuid = game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_h2h(raw, .sportality_schemas$player_h2h),
    "Basketligaen Player Head-to-Head from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Post-Game Team Stats**
#' @description
#' Post-game team comparison (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/post-game-data/team-stats/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @param ssgt_uuid (required) ssgt uuid. Without it the answer is an empty 200 body.
#' @param home_team_uuid (required) Home team uuid; without it the home side comes back blank.
#' @param away_team_uuid (required) Away team uuid; without it the away side comes back blank.
#' @return
#' A `hoopR_data` tibble: Post-game team comparison (2023/24 on). An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_post_game_team_stats`), then any column
#'   the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | home_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
#' | home_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
#' | home_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
#' | home_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
#' | home_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
#' | home_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
#' | home_team_center_value | integer | Centre value (percentage as an integer 0-100). |
#' | away_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
#' | away_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
#' | away_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
#' | away_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
#' | away_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
#' | away_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
#' | away_team_center_value | integer | Centre value (percentage as an integer 0-100). |
#' @eval .intl_details(.sportality_schedule_details, c(
#'   'sportality_post_game_team_stats(',
#'   '  away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",',
#'   '  ssgt_uuid = "xs07bd3fmp"',
#'   ')'
#' ))
#' @export
#' @family Basketligaen Functions
sportality_post_game_team_stats <- function(game_uuid, ssgt_uuid, home_team_uuid, away_team_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  .sportality_check_id(ssgt_uuid, "ssgt_uuid")
  .sportality_check_id(home_team_uuid, "home_team_uuid")
  .sportality_check_id(away_team_uuid, "away_team_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/post-game-data/team-stats/", game_uuid),
    list(ssgtUuid = ssgt_uuid, homeTeamUuid = home_team_uuid, awayTeamUuid = away_team_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse(raw, .sportality_schemas$post_game_team_stats),
    "Basketligaen Post-Game Team Stats from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Team Roster**
#' @description
#' Current roster of a team, grouped by position.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/athletes/by-team-uuid/{team_uuid}`
#' @param team_uuid (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the schedule or `teamList[].uuid`. Key
#'   space: platform team uuids (not the numeric Genius team id).
#' @return
#' A `hoopR_data` tibble: Current roster of a team, grouped by position. An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_roster`), then any
#'   column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | position | character | Playing position. |
#' | position_code | character | Position code (G, F, C, or a finer code such as SG on the profile route). Values: `C` = center; `F` = forward; `G` = guard. |
#' | player_type | character | Record type (athlete). Values: `athlete` = a player. |
#' | gender | character | Gender of the person as recorded by the site (male in every row seen). |
#' | uuid | character | Athlete uuid (platform key space). |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | full_name | character | Full display name of the player. |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | jersey_number | integer | Jersey (shirt) number of the player. |
#' | portrait_url | character | URL of the player's latest rendered portrait. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_roster(team_uuid = "rfo82vr830"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_roster <- function(team_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(team_uuid, "team_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/athletes/by-team-uuid/", team_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_roster(raw, .sportality_schemas$roster),
    "Basketligaen Team Roster from basketligaen.dk"
  )
}

# The @details of every sportality topic that shares the sportality_schedule() notes (roxygen @eval .intl_details()).
.sportality_schedule_details <- c(
  "* Unofficial: the JSON API behind www.basketligaen.dk, the Danish men's basketball league (Basketligaen,",
  "  series code DBL). The site runs on the Sportality platform (the vendor behind the SHL and HockeyAllsvenskan",
  "  wrappers). The terms page was not read; payloads are not redistributed as release assets.",
  "* Stats provider: genius-basketball, a relay of Genius Sports LiveStats. The Genius match, team and person ids",
  "  in play-by-play, box scores and stats tables (game_id, team_id, player_id, all Int64) join the genius",
  "  family; the platform uuids (game, team, athlete, ssgt) are not Genius ids and exist only on this site. The",
  "  Genius ORG code of Denmark is not exposed.",
  "* Season = the END year (2026 = 2025/26) everywhere; the runtime maps it, with game_type ('regular' or",
  "  'finals', the playoffs), to the site's ssgt (season + series + game type) through layout-info. Schedules,",
  "  standings and season tables start in 2002/03; game-level data (play-by-play with shot x/y, box scores, team",
  "  stats) starts in 2023/24.",
  "* Source defects the runtime refuses (`hoopR_asset_fetch`): an unfinished game or a truncated play-by-play",
  "  feed, a box score or feed that names another game, a cut stats table. The 2002/03 regular-season schedule",
  "  lists 109 finished games where its own standings count 110: a source gap.",
  "* Personal data is removed from every body: birth dates, e-mail addresses, phone numbers, addresses and",
  "  contact blocks.",
  "* No women's league: Dameligaen has its own domain (dameligaen.dk), which answers 401 to anonymous requests.",
  "* Errors are classed conditions: `hoopR_no_data` (404, an empty gameday body, `{}` / `[]`, a table with",
  "  no rows, a season or game type layout-info does not list), `hoopR_bad_request` (a bad argument, a 400 /",
  "  422) and `hoopR_asset_fetch` (an error envelope or non-JSON 200, a body for another game / team / athlete /",
  "  ssgt, an unfinished game or truncated play-by-play, a cut stats table, any other non-2xx; a 500 is the",
  "  site's answer for an unknown uuid and is not retried), all inheriting `hoopR_error`. Wrappers raise; they",
  "  never return an empty frame."
)

#' @title
#' **Get Basketligaen Schedule**
#' @description
#' Schedule and results of one season + series + game type.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/game-schedule`
#' @param season (required) Season END year (2026 = 2025/26). Mapped to the provider's ssgt through /statistics-v2/layout-
#'   info (Basketligaen 2002/03 on); a season it does not list raises `hoopR_no_data`.
#' @param game_type (default `"regular"`) Game type: regular (the league season) or finals (the playoffs, Slutspil).
#' @return
#' A `hoopR_data` tibble: Schedule and results of one season + series + game type. An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_schedule`), then any
#'   column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | raw_start_date_time | character | Scheduled start, ISO 8601 UTC. |
#' | start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `post-game` = played (schedule, day views); `pre-game` = not yet played (schedule, day views). |
#' | overtime | logical | Whether the game went to overtime. |
#' | shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `N/A` = no result yet / not applicable; `WIN` = the team won. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | home_team_code | character | Three-letter code of the home team. |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_score | integer | Home points; null before the game is played. |
#' | home_team_icon | character | Home team logo URL. |
#' | away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `N/A` = no result yet / not applicable; `WIN` = the team won. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | away_team_code | character | Three-letter code of the away team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_score | integer | Away points; null before the game is played. |
#' | away_team_icon | character | Away team logo URL. |
#' | venue_uuid | character | Venue uuid (platform key space). |
#' | venue_name | character | Venue name; absent when unknown. |
#' | series_uuid | character | Series uuid (platform key space). |
#' | series_code | character | Series display name (Basketligaen; NOT the DBL code). |
#' | series_display_name | character | Series display name (Basketligaen). |
#' | round_number | integer | Round number (0 for every game seen; the league has no rounds). |
#' | round_label | character | Round label ('' for every game seen). |
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_schedule(season = 2026))
#' }
#' @export
#' @family Basketligaen Functions
sportality_schedule <- function(season, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_season(season)
  .sportality_check_choice(game_type, .SPORTALITY_GAME_TYPES, "game_type")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/game-schedule"),
    list(season = season, gameType = game_type),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_schedule(raw, .sportality_schemas$schedule),
    "Basketligaen Schedule from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Season Filter**
#' @description
#' Series, the 25 seasons (2002/03 on), game types and the default ssgt.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/season-series-game-types-filter`
#' @return
#' A `hoopR_data` tibble: Series, the 25 seasons (2002/03 on), game types and the default ssgt. An empty valid
#'   answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_season_filter`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | kind | character | Directory entry kind: series, season or game_type. |
#' | code | character | Series code (DBL = Basketligaen). |
#' | name | character | Game type name in Danish (Grundspil = regular season, Slutspil = playoffs). |
#' | uuid | character | Series uuid (platform key space); the seriesUuid of /sports-v2/game-schedule. |
#' | deleted | logical | Soft-delete flag; false on every record seen. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_season_filter())
#' }
#' @export
#' @family Basketligaen Functions
sportality_season_filter <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/season-series-game-types-filter"),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_filter(raw, .sportality_schemas$season_filter),
    "Basketligaen Season Filter from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Sites (Clubs) of an ssgt**
#' @description
#' Clubs (sites) taking part in an ssgt.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/all-sites/{ssgt_uuid}`
#' @param ssgt_uuid (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp = 2026/2027 regular season.
#'   Directory: `/statistics-v2/layout-info` `seasonSeriesGameTypeTeams[].ssgtUuid`.
#' @return
#' A `hoopR_data` tibble: Clubs (sites) taking part in an ssgt. An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_sites`), then any column the API added
#'   later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | id | character | Site instance id of the club (platform key space; the same as instanceId). |
#' | instance_id | character | Site instance id of the club or league (platform key space, `<code><n>_<code>` such as hol2_hol; the league itself is dbl1_dbl). |
#' | public_url | character | The club's own website. |
#' | name | character | Display name of the club. |
#' | icon | character | Team logo URL (SVG on sportality.cdn.s8y.se). |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_sites(ssgt_uuid = "xs07bd3fmp"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_sites <- function(ssgt_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(ssgt_uuid, "ssgt_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/all-sites/", ssgt_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse(raw, .sportality_schemas$sites),
    "Basketligaen Sites (Clubs) of an ssgt from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen ssgt Stats Provider**
#' @description
#' Stats provider of an ssgt, a bare word (genius-basketball).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/ssgt/{ssgt_uuid}/provider`
#' @param ssgt_uuid (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp = 2026/2027 regular season.
#'   Directory: `/statistics-v2/layout-info` `seasonSeriesGameTypeTeams[].ssgtUuid`.
#' @return
#' A `hoopR_data` tibble: Stats provider of an ssgt, a bare word (genius-basketball). An empty valid answer
#'   raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_ssgt_provider`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | provider | character | Stats provider of the ssgt (genius-basketball, a Genius Sports LiveStats relay). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_ssgt_provider(ssgt_uuid = "xs07bd3fmp")')
#' @export
#' @family Basketligaen Functions
sportality_ssgt_provider <- function(ssgt_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(ssgt_uuid, "ssgt_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/ssgt/", ssgt_uuid, "/provider"),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse(raw, .sportality_schemas$ssgt_provider),
    "Basketligaen ssgt Stats Provider from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Standings**
#' @description
#' Standings of an ssgt (gameday widget).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/team-standings/{ssgt_uuid}`
#' @param ssgt_uuid (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp = 2026/2027 regular season.
#'   Directory: `/statistics-v2/layout-info` `seasonSeriesGameTypeTeams[].ssgtUuid`.
#' @return
#' A `hoopR_data` tibble: Standings of an ssgt (gameday widget). An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_standings`), then any column the API
#'   added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
#' | team_uuid | character | Platform team uuid. |
#' | team_code | character | Platform team code (HOL, RAN). |
#' | team_name | character | Name of the team. |
#' | rank | integer | Rank in the standings table, 1 = first. |
#' | gp | integer | Number of games played. |
#' | w | integer | Number of wins. |
#' | l | integer | Number of losses. |
#' | tp | integer | League table points (2 per win). |
#' | for | integer | Points scored by the team (points for). |
#' | ga | integer | Points conceded. |
#' | plus_minus | integer | Point difference. |
#' | strk | integer | Current streak as a signed integer: positive = wins in a row, negative = losses in a row. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_standings(ssgt_uuid = "xs07bd3fmp"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_standings <- function(ssgt_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(ssgt_uuid, "ssgt_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/team-standings/", ssgt_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_standings(raw, .sportality_schemas$standings),
    "Basketligaen Standings from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Stats Table**
#' @description
#' Stats table of one module for a season (players, teams, games, standings).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/stats-info/{module}`
#' @param module (required) Stats table: players_* (summary, fieldGoal, rebound, point, offensive, defensive, foul), teams_*
#'   (summary, attendance, possession, fieldGoal, point, rebound, offensive, defensive, foul), games_games or
#'   standings_standings. One of `games_games`, `players_defensive`, `players_fieldGoal`, `players_foul`,
#'   `players_offensive`, `players_point`, `players_rebound`, `players_summary`, `standings_standings`,
#'   `teams_attendance`, `teams_defensive`, `teams_fieldGoal`, `teams_foul`, `teams_offensive`, `teams_point`,
#'   `teams_possession`, `teams_rebound`, `teams_summary`.
#' @param season (required) Season END year (2026 = 2025/26). Mapped to the provider's ssgt through /statistics-v2/layout-
#'   info (Basketligaen 2002/03 on); a season it does not list raises `hoopR_no_data`.
#' @param game_type (default `"regular"`) Game type: regular (the league season) or finals (the playoffs, Slutspil).
#' @return
#' A `hoopR_data` tibble: Stats table of one module for a season (players, teams, games, standings). An empty
#'   valid answer raises `hoopR_no_data`; the documented columns come first, in this order (sdv-py
#'   `sportality_stats_info`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
#' | gp | integer | Number of games played. |
#' | eff | double | Efficiency (valuation) per game; the formula is the site's own (unverified). |
#' | mins | double | Average minutes played per game ('27.3'). |
#' | ppg | double | Points per game. |
#' | rpg | double | Rebounds per game. |
#' | apg | double | Assists per game. |
#' | stpg | double | Steals per game. |
#' | blkpg | double | Blocks per game, or the integer 0). |
#' | info_uuid | character | Athlete uuid on player tables, team uuid on team tables (platform key space). |
#' | info_full_name | character | Full display name of the player. |
#' | info_first_name | character | Given (first) name(s) of the player. |
#' | info_last_name | character | Family name (surname) of the player. |
#' | info_nationality | character | ISO 3166-1 alpha-2 country code. |
#' | info_shoots | character | Shooting hand (null). |
#' | info_gender | character | Gender of the person as recorded by the site (male in every row seen). |
#' | info_weight_value | integer | Weight of the player in kilograms. |
#' | info_weight_format | character | Unit of the value (kg). Values: `kg` = kilograms. |
#' | info_height_value | integer | Height of the player in centimetres. |
#' | info_height_format | character | Unit of the value (cm). Values: `cm` = centimetres. |
#' | info_team_uuid | character | Team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | info_team_name | character | Name of the team. |
#' | info_team_code | character | Three-letter team code. |
#' | info_team_media | character | URL of the team logo image. |
#' | info_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | info_team_site_display_name | character | Team name as the league site displays it. |
#' | info_team_id | integer | Genius team id (Genius key space; an integer here). |
#' | info_number | integer | Jersey (shirt) number of the player. |
#' | info_position | character | Position code (G, F, C, SG, SF ...). |
#' | w | integer | Wins. Team and standings modules: wins of the team in the ssgt. |
#' | p_avg | double | Points per game. |
#' | r_avg | double | Rebounds per game. |
#' | a_avg | double | Assists per game. |
#' | s_avg | double | Steals per game. |
#' | b_avg | double | Blocks per game. |
#' | f_avg | double | Fouls per game. |
#' | 2_p_perc | double | Two-point percentage, 0-100. |
#' | 3_p_perc | double | Three-point percentage, 0-100 (the integer 0, or. |
#' | ft_perc | double | Free-throw percentage, 0-100, or the integer 0). |
#' | info_name | character | Name of the team. |
#' | info_site_display_name | character | Team name as the league site displays it. |
#' | info_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | date_time | character | Start time 'YYYY-MM-DD HH:MM:SS', LOCAL (Europe/Copenhagen) wall time with no zone. |
#' | home_team | character | Name of the home team. |
#' | away_team | character | Name of the away team. |
#' | venue | character | Name of the venue the game was played in. |
#' | attendance | integer | Attendance as an integer; present and non-null on all 706 rows of the six seasons sampled (2012/13-2026/27). |
#' | home_score | integer | Points scored by the home team (games_games; Int64 on the wire). |
#' | away_score | integer | Points scored by the away team (games_games; Int64 on the wire). |
#' | decided_in | character | How the game was decided: null after regulation, otherwise the extra period (OT = overtime). |
#' | info_game_id | integer | Genius match id of the row (Genius key space). |
#' | info_home_team_id | integer | Genius team id of the home team (Genius key space). |
#' | info_away_team_id | integer | Genius team id of the away team (Genius key space). |
#' | blk | integer | Blocks (total). |
#' | br | integer | Blocks received (shots of the player that were blocked), total (read from BLKR in the box score; unverified). |
#' | stl | integer | Steals (total). |
#' | plus | integer | Team points scored while the player was on court (total; unverified). |
#' | minus | integer | Opponent points scored while the player was on court (total; unverified). |
#' | fgm | integer | Field goals made (total). |
#' | fga | integer | Field goals attempted (total). |
#' | fg_perc | double | Field-goal percentage, 0-100. |
#' | fge_perc | double | Effective field-goal percentage ((FGM + 0.5 x 3PM) / FGA), 0-100. |
#' | 3_pm | integer | Three-pointers made (total). |
#' | 3_pa | integer | Three-pointers attempted (total). |
#' | 2_pm | integer | Two-pointers made (total). |
#' | 2_pa | integer | Two-pointers attempted (total). |
#' | pf | integer | Personal fouls (total). |
#' | tf | integer | Technical fouls (total). |
#' | of | integer | Offensive fouls (total). |
#' | f_on | double | Fouls on (fouls drawn), total. |
#' | uf | integer | Unsportsmanlike fouls (total). |
#' | f_outs | integer | Times fouled out. |
#' | o_rat | double | Offensive rating (points produced per 100 possessions, the site's formula; unverified). |
#' | tsa | integer | True-shooting attempts (FGA + 0.44 x FTA), total. |
#' | ts_perc | double | True-shooting percentage, 0-100. |
#' | a | integer | Assists (total). |
#' | atr | double | Assist-to-turnover ratio. |
#' | u_perc | double | Usage percentage, 0-100. |
#' | egs | double | Game score per game (unverified). |
#' | tp | integer | Total points scored. |
#' | fbp | integer | Fast-break points (total). |
#' | fbp_perc | double | Fast-break points as a percentage of the player's points (unverified). |
#' | pitp | integer | Points in the paint (total). |
#' | pitp_perc | double | Points in the paint as a percentage of the player's points (unverified). |
#' | 2nd_ch_p | integer | Second-chance points (total). |
#' | 2nd_ch_p_perc | double | Second-chance points as a percentage of the player's points (unverified). |
#' | plus_minus | integer | Plus/minus (team points minus opponent points while on court), total. |
#' | dr | double | Defensive rebounds (total). |
#' | or | integer | Offensive rebounds (total). |
#' | reb | integer | Total rebounds. |
#' | or_perc | double | Offensive rebound percentage; the denominator is the site's own (unverified). |
#' | dr_perc | double | Defensive rebound percentage; values far below ORPerc in the same row suggest a different base (unverified). |
#' | rank | integer | Unobserved: null in every sample and every full body. When filled: Always null on this table: the rows are sorted, not ranked. |
#' | l | integer | Losses. Standings module: losses of the team in the ssgt. |
#' | for | integer | Points scored by the team (points for). |
#' | ga | integer | Points conceded. |
#' | strk | character | Current streak: a positive number = wins in a row, '-n' = losses in a row. |
#' | gp_home | integer | Home games played. |
#' | att_total_overall | integer | Total attendance over all games (the site's own sum). |
#' | att_avg_overall | integer | Average attendance per game. |
#' | br_avg | double | Blocks received per game. |
#' | dr_avg | double | Defensive rebounds per game. |
#' | td | integer | Takeaways or turnovers forced (unverified). |
#' | td_avg | double | Per-game average of TD (unverified). |
#' | fgm_avg | double | Field goals made per game. |
#' | fga_avg | double | Field goals attempted per game. |
#' | fg_perc_avg | double | Field-goal percentage per game average (values near 0.1 in the rows seen; unverified). |
#' | 3_pa_avg | double | Three-pointers attempted per game. |
#' | 3_pm_avg | double | Three-pointers made per game. |
#' | 2_pm_avg | double | Two-pointers made per game. |
#' | 2_pa_avg | double | Two-pointers attempted per game. |
#' | fd | integer | Fouls drawn (0 in every row seen; unverified). |
#' | fd_avg | integer | Fouls drawn per game (unverified, as FD). |
#' | of_avg | double | Offensive fouls per game. |
#' | f_on_avg | double | Fouls on per game. |
#' | pf_avg | double | Personal fouls per game. |
#' | tf_avg | double | Technical fouls per game. |
#' | tfo | integer | Technical fouls on the opponent (unverified). |
#' | tfo_avg | integer | Per-game average of TFO (unverified). |
#' | uf_avg | double | Unsportsmanlike fouls per game. |
#' | fo | integer | Fouls-out count (unverified). |
#' | fo_avg | integer | Per-game average of FO (unverified). |
#' | fcd | integer | Coach disqualifying fouls (unverified). |
#' | fcd_avg | integer | Per-game average of FCD (unverified). |
#' | fct | integer | Coach technical fouls (read from the play-by-play foul subtype coachTechnical; unverified). |
#' | fct_avg | double | Coach technical fouls per game. |
#' | fbt | integer | Bench technical fouls (read from the play-by-play foul subtype benchTechnical; unverified). |
#' | fbt_avg | double | Bench technical fouls per game. |
#' | f | integer | Total personal fouls committed. |
#' | f_team | integer | Team fouls (unverified). |
#' | f_team_avg | double | Team fouls per game (unverified). |
#' | o_rat_avg | double | Offensive rating per game average. |
#' | ad | integer | Assists difference or assists allowed (0 in every row seen; unverified). |
#' | ad_avg | integer | Per-game average of AD (0 in every row seen; unverified). |
#' | ec | double | Unverified in the hundreds, e.g. '509.0'; possibly an efficiency sum). |
#' | to | integer | Turnovers (total). |
#' | to_avg | double | Turnovers per game. |
#' | fbp_avg | double | Fast-break points per game. |
#' | fbpa | integer | Fast-break points attempts (unverified). |
#' | fbpm | integer | Fast-break points made (unverified). |
#' | pitp_avg | double | Points in the paint per game. |
#' | pitpa | integer | Paint shots attempted (unverified). |
#' | pitpa_avg | double | Paint shots attempted per game (unverified). |
#' | pitpm | integer | Paint shots made (unverified). |
#' | pitpm_avg | double | Paint shots made per game (unverified). |
#' | pfto | integer | Points from turnovers (total). |
#' | pfto_avg | double | Points from turnovers per game. |
#' | 2nd_ch_pm | integer | Second-chance field goals made (unverified). |
#' | 2nd_ch_pm_avg | double | Second-chance field goals made per game (unverified). |
#' | 2nd_ch_pa | integer | Second-chance field goals attempted (unverified). |
#' | 2nd_ch_pa_avg | double | Second-chance field goals attempted per game (unverified). |
#' | ftm | integer | Free throws made (total). |
#' | ftm_avg | double | Free throws made per game. |
#' | fta | integer | Free throws attempted (total). |
#' | fta_avg | double | Free throws attempted per game. |
#' | poss | integer | Possessions (total). |
#' | poss_avg | double | Possessions per game. |
#' | poss_o | integer | Offensive possessions (total; equal to Poss in every row seen). |
#' | poss_o_avg | double | Offensive possessions per game. |
#' | dppp | double | Defensive points per possession (unverified). |
#' | dppp_avg | double | Defensive points per possession, per game average (unverified). |
#' | oppp | double | Offensive points per possession. |
#' | oppp_avg | double | Offensive points per possession, per game average. |
#' | pace | integer | Pace (possessions per 40 minutes; 0 in every row seen, unverified). |
#' | pace_avg | integer | Pace, per game average (0 in every row seen). |
#' | tl | integer | Team leads / lead changes (unverified). |
#' | otr | integer | Offensive team rebounds (unverified). |
#' | dtr | integer | Defensive team rebounds (unverified). |
#' | tr | integer | Total team rebounds (unverified). |
#' | tr_avg | double | Team rebounds per game (unverified). |
#' | pr | integer | Player rebounds (total; Reb minus TR, unverified). |
#' | pr_avg | double | Player rebounds per game (unverified). |
#' | ord | integer | Offensive rebounds allowed or the opponent's offensive rebounds (0 in every row seen; unverified). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_stats_info(module = "players_summary", season = 2026)')
#' @export
#' @family Basketligaen Functions
sportality_stats_info <- function(module, season, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_choice(module, .SPORTALITY_MODULES, "module")
  .sportality_season(season)
  .sportality_check_choice(game_type, .SPORTALITY_GAME_TYPES, "game_type")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/stats-info/", module),
    list(count = 1000L, season = season, gameType = game_type),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_stats_info(raw, .sportality_schemas$stats_info),
    "Basketligaen Stats Table from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Team**
#' @description
#' One team.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/teams/{team_uuid}`
#' @param team_uuid (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the schedule or `teamList[].uuid`. Key
#'   space: platform team uuids (not the numeric Genius team id).
#' @return
#' A `hoopR_data` tibble: One team. An empty valid answer raises `hoopR_no_data`; the documented columns come
#'   first, in this order (sdv-py `sportality_team`), then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | names_short | character | Short name of the team. |
#' | names_long | character | Long name of the team. |
#' | names_full | character | Full name of the team. |
#' | names_code_site | character | Team code as the club's own site shows it. |
#' | names_short_site | character | Short team name as the club's own site shows it. |
#' | names_full_site | character | Full team name as the club's own site shows it. |
#' | names_long_site | character | Long team name as the club's own site shows it. |
#' | info | character | Detail record (shape depends on the route; see the child columns). |
#' | uuid | character | Platform uuid of this record (10-character lowercase key space of its record type; joins the route that serves it). |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | arena_name | character | Name of the arena. |
#' | public_url | character | The club's own website. |
#' | icon | character | Team logo URL (SVG on sportality.cdn.s8y.se). |
#' | owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | site_display_name | character | Team name as the league site displays it. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_team(team_uuid = "rfo82vr830"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_team <- function(team_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(team_uuid, "team_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/teams/", team_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_page(raw, .sportality_schemas$team),
    "Basketligaen Team from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Team Played Games**
#' @description
#' A team's recent games (current season view).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/played-games/{team_uuid}`
#' @param team_uuid (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the schedule or `teamList[].uuid`. Key
#'   space: platform team uuids (not the numeric Genius team id).
#' @return
#' A `hoopR_data` tibble: A team's recent games (current season view). An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_team_played_games`),
#'   then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | date | character | Game date, 'D mon YY' in English ('10 oct 26'). |
#' | time | character | Local start time 'HH:MM' (Europe/Copenhagen). |
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `post-game` = played (schedule, day views). |
#' | overtime | logical | Whether the game went to overtime. |
#' | shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | home_team_code | character | Three-letter code of the home team. |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_score | integer | Home points; null before the game is played. |
#' | home_team_icon | character | Home team logo URL. |
#' | away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `LOSE` = the team lost; `WIN` = the team won. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | away_team_code | character | Three-letter code of the away team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_score | integer | Away points; null before the game is played. |
#' | away_team_icon | character | Away team logo URL. |
#' | venue_uuid | character | Venue uuid (platform key space). |
#' | venue_name | character | Venue name; absent when unknown. |
#' | series_uuid | character | Series uuid (platform key space). |
#' | series_code | character | Series display name (Basketligaen; NOT the DBL code). |
#' | series_display_name | character | Series display name (Basketligaen). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_team_played_games(team_uuid = "rfo82vr830")')
#' @export
#' @family Basketligaen Functions
sportality_team_played_games <- function(team_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(team_uuid, "team_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/played-games/", team_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_schedule(raw, .sportality_schemas$team_played_games),
    "Basketligaen Team Played Games from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Team Stats**
#' @description
#' Team totals per period (2023/24 on).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/gameday/team-stats/{game_uuid}`
#' @param game_uuid (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase letters and digits). Key space:
#'   platform game uuids; the Genius match id is `extId` / `gameSourceId` in the body.
#' @return
#' A `hoopR_data` tibble: Team totals per period (2023/24 on). An empty valid answer raises `hoopR_no_data`;
#'   the documented columns come first, in this order (sdv-py `sportality_team_stats`), then any column the API
#'   added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_side | character | home or away: the side the row belongs to. |
#' | game_source_id | integer | Genius match id (Int64), the same number as game_id and sports-v2 game_info_ext_id. |
#' | game_id | integer | Genius match id (Int64), the join to the genius family; on play-by-play lines, an integer elsewhere. |
#' | team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
#' | team_name | character | Name of the team. |
#' | team_code | character | Platform team code (HOL, RAN). |
#' | team_number | integer | Team number; home is 1. |
#' | instance_id | character | Site instance that owns the feed (platform key space; dbl1_dbl). |
#' | source | character | Feed that produced the row (genius-basketball-stream-reader). |
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | period | integer | Period: 0 = the whole game, 1-4 the quarters, 5 and up overtime. |
#' | period_type | character | REGULAR or OVERTIME; absent on the whole-game row of some eras. Values: `REGULAR` = regulation period. |
#' | tp | integer | Points scored by the team in the period (period 0 = the whole game). |
#' | fgm | integer | Field goals made (total). |
#' | a | integer | Assists (total). |
#' | reb | integer | Total rebounds. |
#' | stl | integer | Number of steals. |
#' | blk | integer | Number of blocked shots made. |
#' | pf | integer | Personal fouls. |
#' @inherit sportality_schedule details
#' @examples
#' \donttest{
#'   try(sportality_team_stats(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @family Basketligaen Functions
sportality_team_stats <- function(game_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(game_uuid, "game_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/gameday/team-stats/", game_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_team_stats(raw, .sportality_schemas$team_stats),
    "Basketligaen Team Stats from basketligaen.dk"
  )
}

#' @title
#' **Get Basketligaen Team Upcoming Games**
#' @description
#' A team's next games (current season view).
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/sports-v2/upcoming-games/{team_uuid}`
#' @param team_uuid (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the schedule or `teamList[].uuid`. Key
#'   space: platform team uuids (not the numeric Genius team id).
#' @return
#' A `hoopR_data` tibble: A team's next games (current season view). An empty valid answer raises
#'   `hoopR_no_data`; the documented columns come first, in this order (sdv-py `sportality_team_upcoming_games`),
#'   then any column the API added later:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | date | character | Game date, 'D mon YY' in English. |
#' | time | character | Local start time 'HH:MM' (Europe/Copenhagen). |
#' | game_uuid | character | Platform game uuid (c4hh5nig6t); every gameday route takes it. |
#' | start_date_time | character | Scheduled start. On the schedule route this is the LOCAL (Europe/Copenhagen) wall time 'YYYY-MM-DD HH:MM:SS' with no zone; on the other routes it is ISO 8601 UTC with milliseconds (compare rawStartDateTime). |
#' | state | character | Game state. Schedule and day views: pre-game or post-game (hyphen). sports-v2 game-info: post_game (underscore). Gameday overview: GameEnded. Values: `pre-game` = not yet played (schedule, day views). |
#' | overtime | logical | Whether the game went to overtime. |
#' | shootout | character | Unobserved: null in every sample and every full body. When filled: Whether the game was decided by a shootout (null on every game seen; basketball has none). |
#' | ssgt_uuid | character | ssgt uuid (platform key space: one season + series + game type); joins /statistics-v2/layout-info `seasonSeriesGameTypeTeams[].ssgtUuid` and every route keyed by ssgt. |
#' | home_team_status | character | WIN or LOSE for the home team once the game is played; absent or empty before. Values: `N/A` = no result yet / not applicable. |
#' | home_team_uuid | character | Home team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | home_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | home_team_code | character | Three-letter code of the home team. |
#' | home_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | home_team_names_short | character | Short name of the team. |
#' | home_team_names_long | character | Long name of the team. |
#' | home_team_names_full | character | Full name of the team. |
#' | home_team_names_code_site | character | Team code as the club's own site shows it. |
#' | home_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | home_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | home_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | home_team_score | integer | Home points; null before the game is played. |
#' | home_team_icon | character | Home team logo URL. |
#' | away_team_status | character | WIN or LOSE for the away team once the game is played; absent or empty before. Values: `N/A` = no result yet / not applicable. |
#' | away_team_uuid | character | Away team uuid (platform key space); joins `/sports-v2/teams/{team_uuid}`. |
#' | away_team_owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
#' | away_team_code | character | Three-letter code of the away team. |
#' | away_team_names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
#' | away_team_names_short | character | Short name of the team. |
#' | away_team_names_long | character | Long name of the team. |
#' | away_team_names_full | character | Full name of the team. |
#' | away_team_names_code_site | character | Team code as the club's own site shows it. |
#' | away_team_names_short_site | character | Short team name as the club's own site shows it. |
#' | away_team_names_full_site | character | Full team name as the club's own site shows it. |
#' | away_team_names_long_site | character | Long team name as the club's own site shows it. |
#' | away_team_score | integer | Away points; null before the game is played. |
#' | away_team_icon | character | Away team logo URL. |
#' | venue_uuid | character | Venue uuid (platform key space). |
#' | venue_name | character | Venue name; absent when unknown. |
#' | series_uuid | character | Series uuid (platform key space). |
#' | series_code | character | Series display name (Basketligaen; NOT the DBL code). |
#' | series_display_name | character | Series display name (Basketligaen). |
#' @eval .intl_details(.sportality_schedule_details, 'sportality_team_upcoming_games(team_uuid = "rfo82vr830")')
#' @export
#' @family Basketligaen Functions
sportality_team_upcoming_games <- function(team_uuid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_check_id(team_uuid, "team_uuid")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/sports-v2/upcoming-games/", team_uuid),
    call = rlang::current_env()
  )
  .sportality_out(
    .sportality_parse_schedule(raw, .sportality_schemas$team_upcoming_games),
    "Basketligaen Team Upcoming Games from basketligaen.dk"
  )
}
