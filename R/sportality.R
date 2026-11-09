# sportality.R -- Basketligaen (Denmark) wrappers over www.basketligaen.dk/api, at parity with sportsdataverse-py
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
#' @eval .returns_rd("sportality_athlete_career", inline = FALSE, unit = "ssgt")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_career(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_athlete_details", inline = FALSE, unit = "athlete")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_details(athlete_uuid = "dpu0901c0t")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_athlete_profile", inline = FALSE, unit = "athlete")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_athlete_profile(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_boxscore", inline = FALSE, unit = "player or team row, per side")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_boxscore(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_game_header", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_game_header(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_game_overview", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_game_overview(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_game_summary", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_game_summary(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_last_game_day", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_last_game_day())
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_layout_info", inline = FALSE, unit = "season-series-game type (ssgt)")
#' @eval .intl_details(.sportality_schedule_details, "sportality_layout_info()")
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_next_game_day", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details, "sportality_next_game_day()")
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_pbp", inline = FALSE, unit = "play-by-play event")
#' @section Sub-type codes:
#' The values of `sub_type`:
#'
#' * `1of1`: free throw 1 of 1
#' * `1of2`: free throw 1 of 2
#' * `1of3`: free throw 1 of 3
#' * `24sec`: shot-clock violation
#' * `2of2`: free throw 2 of 2
#' * `2of3`: free throw 2 of 3
#' * `3of3`: free throw 3 of 3
#' * `3sec`: three-second violation
#' * `5sec`: five-second violation
#' * `8sec`: eight-second violation
#' * `adjustment`: clock adjustment
#' * `alleyoop`: alley-oop shot
#' * `alleyoopdunk`: alley-oop dunk
#' * `backcourt`: backcourt violation
#' * `badpass`: bad pass
#' * `ballhandling`: ball-handling error
#' * `benchTechnical`: technical foul on the bench
#' * `coachTechnical`: technical foul on the coach
#' * `defensive`: defensive rebound
#' * `disqualifying`: disqualifying foul
#' * `disruptive`: disruptive foul (unverified)
#' * `doubledribble`: double dribble
#' * `drivinglayup`: driving layup
#' * `dunk`: dunk
#' * `end`: end of the period or game
#' * `eurostep`: euro-step layup
#' * `fadeaway`: fadeaway jump shot
#' * `flagrant`: flagrant foul
#' * `floatingjumpshot`: floating jump shot
#' * `full`: full timeout
#' * `heldball`: held ball
#' * `hookshot`: hook shot
#' * `in`: player enters
#' * `jumpshot`: jump shot
#' * `layup`: layup
#' * `lodgedball`: lodged ball
#' * `lost`: lost the jump ball
#' * `offensive`: offensive rebound or offensive foul
#' * `offensivegoaltending`: offensive goaltending
#' * `officials`: official timeout
#' * `other`: other
#' * `out`: player leaves
#' * `outofbounds`: out of bounds
#' * `outofboundsrebound`: rebound off an out-of-bounds ball (unverified)
#' * `personal`: personal foul
#' * `pullupjumpshot`: pull-up jump shot
#' * `reverselayup`: reverse layup
#' * `start`: start of the period or game, or clock start
#' * `startperiod`: start of a period (jump ball line)
#' * `stepbackjumpshot`: step-back jump shot
#' * `stop`: clock stop
#' * `technical`: technical foul
#' * `throwIn`: throw-in violation (unverified)
#' * `tipindunk`: tip-in dunk
#' * `tipinlayup`: tip-in layup
#' * `travel`: traveling
#' * `turnaroundjumpshot`: turnaround jump shot
#' * `unsportsmanlike`: unsportsmanlike foul
#' * `won`: won the jump ball
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_pbp(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_player_box", inline = FALSE, unit = "player and period")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_player_box(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_player_h2h", inline = FALSE, unit = "player")
#' @eval .intl_details(.sportality_schedule_details, c(
#'   'sportality_player_h2h(',
#'   '  away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",',
#'   '  ssgt_uuid = "xs07bd3fmp"',
#'   ')'
#' ))
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_post_game_team_stats", inline = FALSE, unit = "statistic")
#' @eval .intl_details(.sportality_schedule_details, c(
#'   'sportality_post_game_team_stats(',
#'   '  away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",',
#'   '  ssgt_uuid = "xs07bd3fmp"',
#'   ')'
#' ))
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_roster(team_uuid = "rfo82vr830"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
  "  wrappers). The terms page was not read; check it before you republish the data.",
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
#' @eval .returns_rd("sportality_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(sportality_schedule(season = 2026))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_season_filter", inline = FALSE, unit = "filter option")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_season_filter())
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_sites", inline = FALSE, unit = "club")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_sites(ssgt_uuid = "xs07bd3fmp"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_ssgt_provider", inline = FALSE, unit = "stats provider")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_ssgt_provider(ssgt_uuid = "xs07bd3fmp")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_standings(ssgt_uuid = "xs07bd3fmp"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_stats_info", inline = FALSE, unit = "table row")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_stats_info(module = "players_summary", season = 2026)')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_team", inline = FALSE, unit = "team")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_team(team_uuid = "rfo82vr830"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_team_played_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_team_played_games(team_uuid = "rfo82vr830")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_team_stats", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.sportality_schedule_details)
#' @examples
#' \donttest{
#'   try(sportality_team_stats(game_uuid = "c4hh5nig6t"))
#' }
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
#' @eval .returns_rd("sportality_team_upcoming_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportality_schedule_details, 'sportality_team_upcoming_games(team_uuid = "rfo82vr830")')
#' @export
#' @concept Basketligaen Functions
#' @seealso [family_basketligaen] lists every function in this family.
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
