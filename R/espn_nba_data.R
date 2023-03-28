#' **Get ESPN NBA game data (Pbp, Team and Player Box)**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A named list of data frames: Plays, Team, Player
#'
#'    **Plays**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |id                        |character |
#'    |sequence_number           |character |
#'    |text                      |character |
#'    |away_score                |integer   |
#'    |home_score                |integer   |
#'    |scoring_play              |logical   |
#'    |score_value               |integer   |
#'    |wallclock                 |character |
#'    |shooting_play             |logical   |
#'    |type_id                   |character |
#'    |type_text                 |character |
#'    |period_number             |integer   |
#'    |period_display_value      |character |
#'    |clock_display_value       |character |
#'    |team_id                   |character |
#'    |coordinate_x_raw          |numeric   |
#'    |coordinate_y_raw          |numeric   |
#'    |coordinate_x              |numeric   |
#'    |coordinate_y              |numeric   |
#'    |play_id                   |character |
#'    |athlete_id_1              |character |
#'    |athlete_id_2              |character |
#'    |athlete_id_3              |character |
#'    |home_team_id              |integer   |
#'    |home_team_mascot          |character |
#'    |home_team_name            |character |
#'    |home_team_abbrev          |character |
#'    |home_team_logo            |character |
#'    |home_team_logo_dark       |character |
#'    |home_team_full_name       |character |
#'    |home_team_color           |character |
#'    |home_team_alternate_color |character |
#'    |home_team_score           |integer   |
#'    |home_team_winner          |logical   |
#'    |home_team_record          |character |
#'    |away_team_id              |integer   |
#'    |away_team_mascot          |character |
#'    |away_team_name            |character |
#'    |away_team_abbrev          |character |
#'    |away_team_logo            |character |
#'    |away_team_logo_dark       |character |
#'    |away_team_full_name       |character |
#'    |away_team_color           |character |
#'    |away_team_alternate_color |character |
#'    |away_team_score           |integer   |
#'    |away_team_winner          |logical   |
#'    |away_team_record          |character |
#'    |game_id                   |integer   |
#'    |season                    |integer   |
#'    |season_type               |integer   |
#'    |game_date                 |Date      |
#'
#'    **Team**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |team_id                           |integer   |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_location                     |character |
#'    |team_name                         |character |
#'    |team_abbreviation                 |character |
#'    |team_display_name                 |character |
#'    |team_short_display_name           |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |team_logo                         |character |
#'    |team_home_away                    |character |
#'    |team_score                        |integer   |
#'    |team_winner                       |logical   |
#'    |assists                           |integer   |
#'    |blocks                            |integer   |
#'    |defensive_rebounds                |integer   |
#'    |fast_break_points                 |character |
#'    |field_goal_pct                    |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |flagrant_fouls                    |integer   |
#'    |fouls                             |integer   |
#'    |free_throw_pct                    |numeric   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |largest_lead                      |character |
#'    |offensive_rebounds                |integer   |
#'    |points_in_paint                   |character |
#'    |steals                            |integer   |
#'    |team_turnovers                    |integer   |
#'    |technical_fouls                   |integer   |
#'    |three_point_field_goal_pct        |numeric   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |total_rebounds                    |integer   |
#'    |total_technical_fouls             |integer   |
#'    |total_turnovers                   |integer   |
#'    |turnover_points                   |character |
#'    |turnovers                         |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_uid                 |character |
#'    |opponent_team_slug                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_name                |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_short_display_name  |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_logo                |character |
#'
#'    **Player**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |athlete_id                        |character |
#'    |athlete_display_name              |character |
#'    |team_id                           |character |
#'    |team_name                         |character |
#'    |team_location                     |character |
#'    |team_short_display_name           |character |
#'    |minutes                           |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |offensive_rebounds                |integer   |
#'    |defensive_rebounds                |integer   |
#'    |rebounds                          |integer   |
#'    |assists                           |integer   |
#'    |steals                            |integer   |
#'    |blocks                            |integer   |
#'    |turnovers                         |integer   |
#'    |fouls                             |integer   |
#'    |plus_minus                        |character |
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
#'    |reason                            |character |
#'    |active                            |logical   |
#'    |athlete_jersey                    |character |
#'    |athlete_short_name                |character |
#'    |athlete_headshot_href             |character |
#'    |athlete_position_name             |character |
#'    |athlete_position_abbreviation     |character |
#'    |team_display_name                 |character |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_logo                         |character |
#'    |team_abbreviation                 |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |home_away                         |character |
#'    |team_winner                       |logical   |
#'    |team_score                        |character |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_name                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_score               |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   try(espn_nba_game_all(game_id = 401283399))
#' }
#'

espn_nba_game_all <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  plays_df <- data.frame()
  team_box_score <- data.frame()
  player_box_score <- data.frame()

  #---- Play-by-Play ------
  tryCatch(
    expr = {

      plays_df <- helper_espn_nba_pbp(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  #---- Team Box ------
  tryCatch(
    expr = {

      team_box_score <- helper_espn_nba_team_box(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  #---- Player Box ------
  tryCatch(
    expr = {

      player_box_score <- helper_espn_nba_player_box(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  pbp <- c(list(plays_df), list(team_box_score), list(player_box_score))
  names(pbp) <- c("Plays", "Team", "Player")
  return(pbp)
}


#' **Get ESPN NBA PBP data**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A play-by-play data frame.
#'
#'    **Plays**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |id                        |character |
#'    |sequence_number           |character |
#'    |text                      |character |
#'    |away_score                |integer   |
#'    |home_score                |integer   |
#'    |scoring_play              |logical   |
#'    |score_value               |integer   |
#'    |wallclock                 |character |
#'    |shooting_play             |logical   |
#'    |type_id                   |character |
#'    |type_text                 |character |
#'    |period_number             |integer   |
#'    |period_display_value      |character |
#'    |clock_display_value       |character |
#'    |team_id                   |character |
#'    |coordinate_x_raw          |numeric   |
#'    |coordinate_y_raw          |numeric   |
#'    |coordinate_x              |numeric   |
#'    |coordinate_y              |numeric   |
#'    |play_id                   |character |
#'    |athlete_id_1              |character |
#'    |athlete_id_2              |character |
#'    |athlete_id_3              |character |
#'    |home_team_id              |integer   |
#'    |home_team_mascot          |character |
#'    |home_team_name            |character |
#'    |home_team_abbrev          |character |
#'    |home_team_logo            |character |
#'    |home_team_logo_dark       |character |
#'    |home_team_full_name       |character |
#'    |home_team_color           |character |
#'    |home_team_alternate_color |character |
#'    |home_team_score           |integer   |
#'    |home_team_winner          |logical   |
#'    |home_team_record          |character |
#'    |away_team_id              |integer   |
#'    |away_team_mascot          |character |
#'    |away_team_name            |character |
#'    |away_team_abbrev          |character |
#'    |away_team_logo            |character |
#'    |away_team_logo_dark       |character |
#'    |away_team_full_name       |character |
#'    |away_team_color           |character |
#'    |away_team_alternate_color |character |
#'    |away_team_score           |integer   |
#'    |away_team_winner          |logical   |
#'    |away_team_record          |character |
#'    |game_id                   |integer   |
#'    |season                    |integer   |
#'    |season_type               |integer   |
#'    |game_date                 |Date      |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA PBP
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_pbp(game_id = 401071880))
#' }
#'
espn_nba_pbp <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  plays_df <- data.frame()
  #---- Play-by-Play ------
  tryCatch(
    expr = {

      plays_df <- helper_espn_nba_pbp(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )


  return(plays_df)
}


#' **Get ESPN NBA team box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A team boxscore data frame
#'
#'    **Team**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |team_id                           |integer   |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_location                     |character |
#'    |team_name                         |character |
#'    |team_abbreviation                 |character |
#'    |team_display_name                 |character |
#'    |team_short_display_name           |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |team_logo                         |character |
#'    |team_home_away                    |character |
#'    |team_score                        |integer   |
#'    |team_winner                       |logical   |
#'    |assists                           |integer   |
#'    |blocks                            |integer   |
#'    |defensive_rebounds                |integer   |
#'    |fast_break_points                 |character |
#'    |field_goal_pct                    |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |flagrant_fouls                    |integer   |
#'    |fouls                             |integer   |
#'    |free_throw_pct                    |numeric   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |largest_lead                      |character |
#'    |offensive_rebounds                |integer   |
#'    |points_in_paint                   |character |
#'    |steals                            |integer   |
#'    |team_turnovers                    |integer   |
#'    |technical_fouls                   |integer   |
#'    |three_point_field_goal_pct        |numeric   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |total_rebounds                    |integer   |
#'    |total_technical_fouls             |integer   |
#'    |total_turnovers                   |integer   |
#'    |turnover_points                   |character |
#'    |turnovers                         |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_uid                 |character |
#'    |opponent_team_slug                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_name                |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_short_display_name  |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_logo                |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Team Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_team_box(game_id = 401071880))
#' }
#'
espn_nba_team_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  team_box_score <- data.frame()
  #---- Team Box ------
  tryCatch(
    expr = {

      team_box_score <- helper_espn_nba_team_box(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(team_box_score)
}
#' **Get ESPN NBA player box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A player boxscore data frame
#'
#'    **Player**
#'
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |game_id                           |integer   |
#'    |season                            |integer   |
#'    |season_type                       |integer   |
#'    |game_date                         |Date      |
#'    |athlete_id                        |character |
#'    |athlete_display_name              |character |
#'    |team_id                           |character |
#'    |team_name                         |character |
#'    |team_location                     |character |
#'    |team_short_display_name           |character |
#'    |minutes                           |numeric   |
#'    |field_goals_made                  |integer   |
#'    |field_goals_attempted             |integer   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |free_throws_made                  |integer   |
#'    |free_throws_attempted             |integer   |
#'    |offensive_rebounds                |integer   |
#'    |defensive_rebounds                |integer   |
#'    |rebounds                          |integer   |
#'    |assists                           |integer   |
#'    |steals                            |integer   |
#'    |blocks                            |integer   |
#'    |turnovers                         |integer   |
#'    |fouls                             |integer   |
#'    |plus_minus                        |character |
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
#'    |reason                            |character |
#'    |active                            |logical   |
#'    |athlete_jersey                    |character |
#'    |athlete_short_name                |character |
#'    |athlete_headshot_href             |character |
#'    |athlete_position_name             |character |
#'    |athlete_position_abbreviation     |character |
#'    |team_display_name                 |character |
#'    |team_uid                          |character |
#'    |team_slug                         |character |
#'    |team_logo                         |character |
#'    |team_abbreviation                 |character |
#'    |team_color                        |character |
#'    |team_alternate_color              |character |
#'    |home_away                         |character |
#'    |team_winner                       |logical   |
#'    |team_score                        |character |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_name                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_score               |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Player Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_player_box(game_id = 401071880))
#' }
#'
espn_nba_player_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")


  player_box_score <- data.frame()
  #---- Player Box ------
  tryCatch(
    expr = {

      player_box_score <- helper_espn_nba_player_box(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(player_box_score)
}



#' **Get ESPN NBA game rosters**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A game rosters data frame
#'
#'    |col_name                                   |types     |
#'    |:------------------------------------------|:---------|
#'    |athlete_id                                 |integer   |
#'    |athlete_uid                                |character |
#'    |athlete_guid                               |character |
#'    |athlete_type                               |character |
#'    |sdr                                        |character |
#'    |first_name                                 |character |
#'    |last_name                                  |character |
#'    |full_name                                  |character |
#'    |athlete_display_name                       |character |
#'    |short_name                                 |character |
#'    |weight                                     |integer   |
#'    |display_weight                             |character |
#'    |height                                     |integer   |
#'    |display_height                             |character |
#'    |age                                        |integer   |
#'    |date_of_birth                              |character |
#'    |debut_year                                 |integer   |
#'    |birth_place_city                           |character |
#'    |birth_place_state                          |character |
#'    |birth_place_country                        |character |
#'    |slug                                       |character |
#'    |headshot_href                              |character |
#'    |headshot_alt                               |character |
#'    |jersey                                     |character |
#'    |position_id                                |character |
#'    |position_name                              |character |
#'    |position_display_name                      |character |
#'    |position_abbreviation                      |character |
#'    |position_leaf                              |logical   |
#'    |linked                                     |logical   |
#'    |years                                      |integer   |
#'    |active                                     |logical   |
#'    |contract_bird_status                       |integer   |
#'    |contract_active                            |logical   |
#'    |contract_active_1                          |logical   |
#'    |contract_incoming_trade_value              |integer   |
#'    |contract_outgoing_trade_value              |integer   |
#'    |contract_minimum_salary_exception          |logical   |
#'    |contract_option_type                       |integer   |
#'    |contract_salary                            |integer   |
#'    |contract_salary_remaining                  |integer   |
#'    |contract_years_remaining                   |integer   |
#'    |contract_trade_kicker_active               |logical   |
#'    |contract_trade_kicker_percentage           |integer   |
#'    |contract_trade_kicker_value                |integer   |
#'    |contract_trade_kicker_trade_value          |integer   |
#'    |contract_trade_restriction                 |logical   |
#'    |contract_unsigned_foreign_pick             |logical   |
#'    |contract_active_2                          |logical   |
#'    |draft_display_text                         |character |
#'    |draft_round                                |integer   |
#'    |draft_year                                 |integer   |
#'    |draft_selection                            |integer   |
#'    |status_id                                  |character |
#'    |status_name                                |character |
#'    |status_type                                |character |
#'    |status_abbreviation                        |character |
#'    |starter                                    |logical   |
#'    |valid                                      |logical   |
#'    |did_not_play                               |logical   |
#'    |display_name                               |character |
#'    |reason                                     |character |
#'    |ejected                                    |logical   |
#'    |team_id                                    |character |
#'    |team_guid                                  |character |
#'    |team_uid                                   |character |
#'    |team_slug                                  |character |
#'    |team_location                              |character |
#'    |team_name                                  |character |
#'    |team_abbreviation                          |character |
#'    |team_display_name                          |character |
#'    |team_short_display_name                    |character |
#'    |team_color                                 |character |
#'    |team_alternate_color                       |character |
#'    |team_is_active                             |logical   |
#'    |team_is_all_star                           |logical   |
#'    |logo_href                                  |character |
#'    |logo_dark_href                             |character |
#'    |logos_href_2                               |character |
#'    |logos_href_3                               |character |
#'    |game_id                                    |numeric   |
#'    |order                                      |integer   |
#'    |home_away                                  |character |
#'    |winner                                     |logical   |
#'    |citizenship                                |character |
#'    |contract_base_year_compensation_active     |logical   |
#'    |contract_base_year_compensation_expiration |character |
#'    |hand_type                                  |character |
#'    |hand_abbreviation                          |character |
#'    |hand_display_value                         |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game Roster
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_game_rosters(game_id = 401283399))
#' }
espn_nba_game_rosters <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/events/",
        game_id, "/competitions/",
        game_id,"/competitors/")
      game_res <- httr::RETRY("GET", play_base_url)
      # Check the result
      check_status(game_res)

      game_resp <- game_res %>%
        httr::content(as = "text", encoding = "UTF-8")
      game_df <- jsonlite::fromJSON(game_resp)[["items"]] %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename("team_statistics_href" = "statistics.$ref")

      colnames(game_df) <- gsub(".\\$ref","_href", colnames(game_df))

      game_df <- game_df %>%
        dplyr::rename(
          "team_id" = "id",
          "team_uid" = "uid")

      game_df$game_id <- game_id

      teams_df <- purrr::map_dfr(game_df$team_href, function(x){

        res <- httr::RETRY("GET", x)
        # Check the result
        check_status(res)

        team_df <- res %>%
          httr::content(as = "text", encoding = "UTF-8") %>%
          jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

        team_df[["links"]] <- NULL
        team_df[["injuries"]] <- NULL
        team_df[["record"]] <- NULL
        team_df[["athletes"]] <- NULL
        team_df[["venue"]] <- NULL
        team_df[["groups"]] <- NULL
        team_df[["ranks"]] <- NULL
        team_df[["statistics"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["links"]] <- NULL
        team_df[["notes"]] <- NULL
        team_df[["franchise"]] <- NULL
        team_df[["againstTheSpreadRecords"]] <- NULL
        team_df[["oddsRecords"]] <- NULL
        team_df[["college"]] <- NULL
        team_df[["transactions"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["depthCharts"]] <- NULL
        team_df[["awards"]] <- NULL
        team_df[["events"]] <- NULL

        team_df <- team_df %>%
          purrr::map_if(is.list, as.data.frame) %>%
          as.data.frame() %>%
          dplyr::select(
            -dplyr::any_of(
              c("logos.width",
                "logos.height",
                "logos.alt",
                "logos.rel..full.",
                "logos.rel..default.",
                "logos.rel..scoreboard.",
                "logos.rel..scoreboard..1",
                "logos.rel..scoreboard.2",
                "logos.lastUpdated",
                "logos.width.1",
                "logos.height.1",
                "logos.alt.1",
                "logos.rel..full..1",
                "logos.rel..dark.",
                "logos.rel..dark..1",
                "logos.lastUpdated.1",
                "logos.width.2",
                "logos.height.2",
                "logos.alt.2",
                "logos.rel..full..2",
                "logos.rel..scoreboard.",
                "logos.lastUpdated.2",
                "logos.width.3",
                "logos.height.3",
                "logos.alt.3",
                "logos.rel..full..3",
                "logos.lastUpdated.3",
                "X.ref",
                "X.ref.1",
                "X.ref.2"))) %>%
          janitor::clean_names()

        colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

        team_df <- team_df %>%
          dplyr::rename(
            "logo_href" = "logos_href",
            "logo_dark_href" = "logos_href_1") %>%
          dplyr::left_join(
            game_df %>%
              dplyr::select(
                "game_id",
                "team_id",
                "team_uid",
                "order",
                "homeAway",
                "winner",
                "roster_href"),
            by = c("team_id" = "team_id",
                   "team_uid" = "team_uid")
          )

      })

      ## Inputs
      ## game_id
      team_roster_df <- purrr::map_dfr(teams_df$team_id, function(x){

        res <- httr::RETRY("GET", paste0(play_base_url, x, "/roster"))

        # Check the result
        check_status(res)

        resp <- res %>%
          httr::content(as = "text", encoding = "UTF-8")

        raw_play_df <- jsonlite::fromJSON(resp)[["entries"]]

        raw_play_df <- raw_play_df %>%
          jsonlite::toJSON() %>%
          jsonlite::fromJSON(flatten = TRUE) %>%
          dplyr::mutate(team_id = x) %>%
          dplyr::select(-"period", -"forPlayerId", -"active")

        raw_play_df <- raw_play_df %>%
          dplyr::left_join(teams_df, by = c("team_id" = "team_id"))

      })

      colnames(team_roster_df) <- gsub(".\\$ref","_href", colnames(team_roster_df))

      athlete_roster_df <- purrr::map_dfr(team_roster_df$athlete_href, function(x){

        res <- httr::RETRY("GET", x)

        # Check the result
        check_status(res)

        resp <- res %>%
          httr::content(as = "text", encoding = "UTF-8")

        raw_play_df <- jsonlite::fromJSON(resp, flatten = TRUE)
        raw_play_df[["links"]] <- NULL
        raw_play_df[["injuries"]] <- NULL
        raw_play_df[["teams"]] <- NULL
        raw_play_df[["team"]] <- NULL
        raw_play_df[["college"]] <- NULL
        raw_play_df[["proAthlete"]] <- NULL
        raw_play_df[["statistics"]] <- NULL
        raw_play_df[["notes"]] <- NULL
        raw_play_df[["eventLog"]] <- NULL
        raw_play_df[["$ref"]] <- NULL
        raw_play_df[["position"]][["$ref"]] <- NULL


        raw_play_df2 <- raw_play_df %>%
          jsonlite::toJSON() %>%
          jsonlite::fromJSON(flatten = TRUE) %>%
          as.data.frame() %>%
          dplyr::mutate(id = as.integer(.data$id)) %>%
          dplyr::rename(
            "athlete_id" = "id",
            "athlete_uid" = "uid",
            "athlete_guid" = "guid",
            "athlete_type" = "type",
            "athlete_display_name" = "displayName"
          )

        raw_play_df2 <- raw_play_df2 %>%
          dplyr::left_join(team_roster_df, by = c("athlete_id" = "playerId"))

      })

      colnames(athlete_roster_df) <- gsub(".\\$ref","_href", colnames(athlete_roster_df))

      athlete_roster_df <- athlete_roster_df %>%
        janitor::clean_names() %>%
        dplyr::select(-dplyr::any_of(c(
          "x_ref",
          "x_ref_1",
          "contract_ref",
          "contract_ref_1",
          "contract_ref_2",
          "draft_ref",
          "draft_ref_1",
          "athlete_href",
          "position_ref",
          "position_href",
          "roster_href",
          "statistics_href"
        ))) %>%
        make_hoopR_data("ESPN NBA Game Roster Information from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no game roster data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  return(athlete_roster_df)
}




#' **Get ESPN NBA team names and IDs**
#' @author Saiem Gilani
#' @return A teams data frame
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |team_id         |character |
#'    |abbreviation    |character |
#'    |display_name    |character |
#'    |short_name      |character |
#'    |mascot          |character |
#'    |nickname        |character |
#'    |team            |character |
#'    |color           |character |
#'    |alternate_color |character |
#'    |logo            |character |
#'    |logo_dark       |character |
#'    |logos_href_3    |character |
#'    |logos_href_4    |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import furrr
#' @import rvest
#' @export
#' @keywords NBA Teams
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_teams())
#' }
#'

espn_nba_teams <- function(){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams?limit=1000"


  res <- httr::RETRY("GET", play_base_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  tryCatch(
    expr = {

      leagues <- jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][['teams']][[1]][['team']] %>%
        dplyr::group_by(.data$id) %>%
        tidyr::unnest_wider("logos", names_sep = "_") %>%
        tidyr::unnest_wider("logos_href", names_sep = "_") %>%
        dplyr::select(
          -"logos_width",
          -"logos_height",
          -"logos_alt",
          -"logos_rel") %>%
        dplyr::ungroup()

      if("records" %in% colnames(leagues)){
        records <- leagues$record
        records<- records %>%
          tidyr::unnest_wider("items") %>%
          tidyr::unnest_wider("stats", names_sep = "_") %>%
          dplyr::mutate(row = dplyr::row_number())
        stat <- records %>%
          dplyr::group_by(.data$row) %>%
          purrr::map_if(is.data.frame, list)
        stat <- lapply(stat$stats_1,function(x) x %>%
                         purrr::map_if(is.data.frame,list) %>%
                         dplyr::as_tibble())

        s <- lapply(stat, function(x) {
          tidyr::pivot_wider(x)
        })

        s <- tibble::tibble(g = s)
        stats <- s %>%
          tidyr::unnest_wider("g")

        records <- dplyr::bind_cols(records %>% dplyr::select("summary"), stats)
        leagues <- leagues %>%
          dplyr::select(-"record")
      }
      leagues <- leagues %>% dplyr::select(
        -"links",
        -"isActive",
        -"isAllStar",
        -"uid",
        -"slug")
      teams <- leagues %>%
        dplyr::rename(
          "logo" = "logos_href_1",
          "logo_dark" = "logos_href_2",
          "mascot" = "name",
          "team" = "location",
          "team_id" = "id",
          "short_name" = "shortDisplayName",
          "alternate_color" = "alternateColor",
          "display_name" = "displayName"
        ) %>%
        janitor::clean_names() %>%
        make_hoopR_data("ESPN NBA Teams Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no teams data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(teams)
}


#' **Get ESPN men's NBA schedule for a specific year**
#'
#' @param season Either numeric or character (YYYYMMDD)
#' @return Returns a tibble with scoreboard data
#'
#'    |col_name            |types     |
#'    |:-------------------|:---------|
#'    |matchup             |character |
#'    |matchup_short       |character |
#'    |season              |integer   |
#'    |season_type         |integer   |
#'    |season_slug         |character |
#'    |game_id             |character |
#'    |game_uid            |character |
#'    |game_date           |character |
#'    |attendance          |integer   |
#'    |notes               |logical   |
#'    |status_name         |character |
#'    |broadcasts          |logical   |
#'    |start_date          |character |
#'    |geo_broadcasts      |logical   |
#'    |home_team_name      |character |
#'    |home_team_logo      |character |
#'    |home_team_abb       |character |
#'    |home_team_id        |character |
#'    |home_team_location  |character |
#'    |home_team_full_name |character |
#'    |home_team_color     |character |
#'    |home_score          |integer   |
#'    |home_win            |integer   |
#'    |home_record         |character |
#'    |away_team_name      |character |
#'    |away_team_logo      |character |
#'    |away_team_abb       |character |
#'    |away_team_id        |character |
#'    |away_team_location  |character |
#'    |away_team_full_name |character |
#'    |away_team_color     |character |
#'    |away_score          |integer   |
#'    |away_win            |integer   |
#'    |away_record         |character |
#'
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom glue glue
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @examples
#'
#' # Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
#' \donttest{
#'   try(espn_nba_scoreboard (season = "20221117"))
#' }

espn_nba_scoreboard <- function(season){

  max_year <- substr(Sys.Date(), 1,4)

  if(!(as.integer(substr(season, 1, 4)) > 2001)){
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  schedule_api <- glue::glue("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?limit=1000&dates={season_dates}")

  tryCatch(
    expr = {

      res <- httr::RETRY("GET", schedule_api)

      # Check the result
      check_status(res)

      raw_sched <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      nba_data <- raw_sched[["events"]] %>%
        tibble::tibble(data = .data$.) %>%
        tidyr::unnest_wider("data") %>%
        tidyr::unchop("competitions") %>%
        dplyr::select(
          -"id",
          -"uid",
          -"date",
          -"status") %>%
        tidyr::unnest_wider("competitions") %>%
        dplyr::rename(
          "matchup" = "name",
          "matchup_short" = "shortName",
          "game_id" = "id",
          "game_uid" = "uid",
          "game_date" = "date"
        ) %>%
        tidyr::hoist(.data$status,
                     status_name = list("type", "name")) %>%
        dplyr::select(!dplyr::any_of(
          c(
            "timeValid",
            "neutralSite",
            "conferenceCompetition",
            "recent",
            "venue",
            "type"
          )
        )) %>%
        tidyr::unnest_wider("season", names_sep = "_") %>%
        dplyr::rename("season" = "season_year") %>%
        dplyr::select(-dplyr::any_of("status"))
      nba_data <- nba_data %>%
        tidyr::hoist(
          .data$competitors,
          homeAway = list(1,"homeAway")
        )
      nba_data <- nba_data %>%
        tidyr::hoist(
          .data$competitors,
          team1_team_name = list(1, "team", "name"),
          team1_team_logo = list(1, "team", "logo"),
          team1_team_abb = list(1, "team", "abbreviation"),
          team1_team_id = list(1, "team", "id"),
          team1_team_location = list(1, "team", "location"),
          team1_team_full = list(1, "team", "displayName"),
          team1_team_color = list(1, "team", "color"),
          team1_score = list(1, "score"),
          team1_win = list(1, "winner"),
          team1_record = list(1, "records", 1, "summary"),
          # away team
          team2_team_name = list(2, "team", "name"),
          team2_team_logo = list(2, "team", "logo"),
          team2_team_abb = list(2, "team", "abbreviation"),
          team2_team_id = list(2, "team", "id"),
          team2_team_location = list(2, "team", "location"),
          team2_team_full = list(2, "team", "displayName"),
          team2_team_color = list(2, "team", "color"),
          team2_score = list(2, "score"),
          team2_win = list(2, "winner"),
          team2_record = list(2, "records", 1, "summary"))


      nba_data <- nba_data %>%
        dplyr::mutate(
          home_team_name = ifelse(.data$homeAway=="home",.data$team1_team_name, .data$team2_team_name),
          home_team_logo = ifelse(.data$homeAway=="home",.data$team1_team_logo, .data$team2_team_logo),
          home_team_abb = ifelse(.data$homeAway=="home",.data$team1_team_abb, .data$team2_team_abb),
          home_team_id = ifelse(.data$homeAway=="home",.data$team1_team_id, .data$team2_team_id),
          home_team_location = ifelse(.data$homeAway=="home",.data$team1_team_location, .data$team2_team_location),
          home_team_full_name = ifelse(.data$homeAway=="home",.data$team1_team_full, .data$team2_team_full),
          home_team_color = ifelse(.data$homeAway=="home",.data$team1_team_color, .data$team2_team_color),
          home_score = ifelse(.data$homeAway=="home",.data$team1_score, .data$team2_score),
          home_win = ifelse(.data$homeAway=="home",.data$team1_win, .data$team2_win),
          home_record = ifelse(.data$homeAway=="home",.data$team1_record, .data$team2_record),
          away_team_name = ifelse(.data$homeAway=="away",.data$team1_team_name, .data$team2_team_name),
          away_team_logo = ifelse(.data$homeAway=="away",.data$team1_team_logo, .data$team2_team_logo),
          away_team_abb = ifelse(.data$homeAway=="away",.data$team1_team_abb, .data$team2_team_abb),
          away_team_id = ifelse(.data$homeAway=="away",.data$team1_team_id, .data$team2_team_id),
          away_team_location = ifelse(.data$homeAway=="away",.data$team1_team_location, .data$team2_team_location),
          away_team_full_name = ifelse(.data$homeAway=="away",.data$team1_team_full, .data$team2_team_full),
          away_team_color = ifelse(.data$homeAway=="away",.data$team1_team_color, .data$team2_team_color),
          away_score = ifelse(.data$homeAway=="away",.data$team1_score, .data$team2_score),
          away_win = ifelse(.data$homeAway=="away",.data$team1_win, .data$team2_win),
          away_record = ifelse(.data$homeAway=="away",.data$team1_record, .data$team2_record)
        )

      nba_data <- nba_data %>%
        dplyr::mutate(
          home_win = as.integer(.data$home_win),
          away_win = as.integer(.data$away_win),
          home_score = as.integer(.data$home_score),
          away_score = as.integer(.data$away_score))
      nba_data <- nba_data %>%
        dplyr::select(-dplyr::any_of(dplyr::starts_with("team1")),
                      -dplyr::any_of(dplyr::starts_with("team2")),
                      -dplyr::any_of(c("homeAway")))

      if ("leaders" %in% names(nba_data)) {
        schedule_out <- nba_data %>%
          tidyr::hoist(
            .data$leaders,
            # points
            points_leader_points = list(1, "leaders", 1, "value"),
            points_leader_stat = list(1, "leaders", 1, "displayValue"),
            points_leader_name = list(1, "leaders", 1, "athlete", "displayName"),
            points_leader_shortname = list(1, "leaders", 1, "athlete", "shortName"),
            points_leader_headshot = list(1, "leaders", 1, "athlete", "headshot"),
            points_leader_team_id = list(1, "leaders", 1, "team", "id"),
            points_leader_pos = list(1, "leaders", 1, "athlete", "position", "abbreviation"),
            # rebounds
            rebounds_leader_rebounds = list(2, "leaders", 1, "value"),
            rebounds_leader_stat = list(2, "leaders", 1, "displayValue"),
            rebounds_leader_name = list(2, "leaders", 1, "athlete", "displayName"),
            rebounds_leader_shortname = list(2, "leaders", 1, "athlete", "shortName"),
            rebounds_leader_headshot = list(2, "leaders", 1, "athlete", "headshot"),
            rebounds_leader_team_id = list(2, "leaders", 1, "team", "id"),
            rebounds_leader_pos = list(2, "leaders", 1, "athlete", "position", "abbreviation"),
            # assists
            assists_leader_assists = list(3, "leaders", 1, "value"),
            assists_leader_stat = list(3, "leaders", 1, "displayValue"),
            assists_leader_name = list(3, "leaders", 1, "athlete", "displayName"),
            assists_leader_shortname = list(3, "leaders", 1, "athlete", "shortName"),
            assists_leader_headshot = list(3, "leaders", 1, "athlete", "headshot"),
            assists_leader_team_id = list(3, "leaders", 1, "team", "id"),
            assists_leader_pos = list(3, "leaders", 1, "athlete", "position", "abbreviation"),
          )

        if ("broadcasts" %in% names(schedule_out) && !any(is.na(schedule_out[['broadcasts']]))) {
          schedule_out %>%
            tidyr::hoist(
              .data$broadcasts,
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        }
      } else {

        if ("broadcasts" %in% names(nba_data) && !any(is.na(nba_data[['broadcasts']]))) {
          nba_data %>%
            tidyr::hoist(
              .data$broadcasts,
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        } else {
          nba_data %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        }
      }

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoreboard data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
}

#' **Get ESPN NBA's Standings**
#'
#' @param year Either numeric or character (YYYY)
#' @return A standings data frame
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |team_id            |character |
#'    |team               |character |
#'    |avgpointsagainst   |character |
#'    |avgpointsfor       |character |
#'    |clincher           |character |
#'    |differential       |character |
#'    |divisionwinpercent |character |
#'    |gamesbehind        |character |
#'    |leaguewinpercent   |character |
#'    |losses             |character |
#'    |playoffseed        |character |
#'    |streak             |character |
#'    |winpercent         |character |
#'    |wins               |character |
#'    |leaguestandings    |character |
#'    |home               |character |
#'    |road               |character |
#'    |vsdiv              |character |
#'    |vsconf             |character |
#'    |lasttengames       |character |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @keywords NBA Standings
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   try(espn_nba_standings(year = 2021))
#' }
espn_nba_standings <- function(year){

  standings_url <- "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings?region=us&lang=en&contentorigin=espn&type=0&level=1&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

  ## Inputs
  ## year
  full_url <- paste0(standings_url,
                     "season=", year)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      raw_standings <- jsonlite::fromJSON(resp)[["standings"]]

      #Create a dataframe of all NBA teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]

      teams <- teams %>%
        dplyr::select("id", "displayName") %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName")

      #creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <- data.table::rbindlist(standings_df, fill = TRUE, idcol = T)

      #Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <- ifelse(is.na(standings_data$value) & !is.na(standings_data$summary), standings_data$summary, standings_data$value)

      standings_data <- standings_data %>%
        dplyr::select(
          ".id",
          "type",
          "value")

      #Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(names_from = "type", values_from = "value")

      standings_data <- standings_data %>%
        dplyr::select(-".id")

      #joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data)
      standings <- standings %>%
        make_hoopR_data("ESPN NBA Standings Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no standings data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }

  )
  return(standings)
}


#' **Get ESPN NBA's Betting information**
#'
#' @param game_id  Game ID
#' @returns Returns a named list of data frames: pickcenter, againstTheSpread, predictor
#'
#'    **pickcenter**
#'
#'
#'    |col_name                             |types     |
#'    |:------------------------------------|:---------|
#'    |details                              |character |
#'    |over_under                           |integer   |
#'    |spread                               |integer   |
#'    |provider_id                          |character |
#'    |provider_name                        |character |
#'    |provider_priority                    |integer   |
#'    |away_team_odds_favorite              |logical   |
#'    |away_team_odds_underdog              |logical   |
#'    |away_team_odds_money_line            |integer   |
#'    |away_team_odds_spread_odds           |numeric   |
#'    |away_team_odds_team_id               |character |
#'    |away_team_odds_win_percentage        |numeric   |
#'    |away_team_odds_average_score         |numeric   |
#'    |away_team_odds_money_line_odds       |numeric   |
#'    |away_team_odds_spread_return         |numeric   |
#'    |away_team_odds_spread_record_wins    |integer   |
#'    |away_team_odds_spread_record_losses  |integer   |
#'    |away_team_odds_spread_record_pushes  |integer   |
#'    |away_team_odds_spread_record_summary |character |
#'    |home_team_odds_favorite              |logical   |
#'    |home_team_odds_underdog              |logical   |
#'    |home_team_odds_money_line            |integer   |
#'    |home_team_odds_spread_odds           |numeric   |
#'    |home_team_odds_team_id               |character |
#'    |home_team_odds_win_percentage        |numeric   |
#'    |home_team_odds_average_score         |numeric   |
#'    |home_team_odds_money_line_odds       |numeric   |
#'    |home_team_odds_spread_return         |numeric   |
#'    |home_team_odds_spread_record_wins    |integer   |
#'    |home_team_odds_spread_record_losses  |integer   |
#'    |home_team_odds_spread_record_pushes  |integer   |
#'    |home_team_odds_spread_record_summary |character |
#'
#'    **againstTheSpread**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |id           |character |
#'    |uid          |character |
#'    |display_name |character |
#'    |abbreviation |character |
#'    |logo         |character |
#'    |logos        |list      |
#'    |records      |list      |
#'
#'    **predictor**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |home_team_id              |character |
#'    |away_team_id              |character |
#'    |away_team_game_projection |character |
#'    |away_team_chance_loss     |character |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @export
#' @keywords NBA Betting
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   try(espn_nba_betting(game_id = 401283399))
#' }
espn_nba_betting <- function(game_id){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()
  tryCatch(
    expr = {

      raw_summary <- jsonlite::fromJSON(resp)
      if("pickcenter" %in% names(raw_summary)){
        pickcenter <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$pickcenter), flatten=TRUE) %>%
          janitor::clean_names() %>%
          dplyr::select(-"links") %>%
          make_hoopR_data("ESPN NBA Pickcenter Information from ESPN.com",Sys.time())
      }
      if("againstTheSpread" %in% names(raw_summary)){
        againstTheSpread <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$againstTheSpread)) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-"links") %>%
          janitor::clean_names()
        records <- againstTheSpread$records

        teams$records <- records
        againstTheSpread <- teams %>%
          make_hoopR_data("ESPN NBA Against the Spread Information from ESPN.com",Sys.time())
      }
      if("predictor" %in% names(raw_summary)){
        predictor_df <- data.frame(
          home_team_id =  raw_summary$predictor$homeTeam$id,
          away_team_id =  raw_summary$predictor$awayTeam$id,
          away_team_game_projection = raw_summary$predictor$awayTeam$gameProjection,
          away_team_chance_loss = raw_summary$predictor$awayTeam$teamChanceLoss
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data("ESPN NBA Predictor Information from ESPN.com",Sys.time())
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no betting data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }

  )
  betting <- c(list(pickcenter), list(againstTheSpread), list(predictor_df))
  names(betting) <- c("pickcenter", "againstTheSpread", "predictor")
  return(betting)
}


#' @title
#' **Get ESPN NBA team stats data**
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the team stats data
#'
#'    |col_name                                         |types     |
#'    |:------------------------------------------------|:---------|
#'    |team_id                                          |character |
#'    |team_guid                                        |character |
#'    |team_uid                                         |character |
#'    |team_slug                                        |character |
#'    |team_location                                    |character |
#'    |team_name                                        |character |
#'    |team_abbreviation                                |character |
#'    |team_display_name                                |character |
#'    |team_short_display_name                          |character |
#'    |team_color                                       |character |
#'    |team_alternate_color                             |character |
#'    |team_is_active                                   |logical   |
#'    |team_is_all_star                                 |logical   |
#'    |logo_href                                        |character |
#'    |logo_dark_href                                   |character |
#'    |logos_href_2                                     |character |
#'    |logos_href_3                                     |character |
#'    |defensive_blocks                                 |numeric   |
#'    |defensive_defensive_rebounds                     |numeric   |
#'    |defensive_steals                                 |numeric   |
#'    |defensive_turnover_points                        |numeric   |
#'    |defensive_def_rebound_rate                       |numeric   |
#'    |defensive_avg_defensive_rebounds                 |numeric   |
#'    |defensive_avg_blocks                             |numeric   |
#'    |defensive_avg_steals                             |numeric   |
#'    |defensive_avg48defensive_rebounds                |numeric   |
#'    |defensive_avg48blocks                            |numeric   |
#'    |defensive_avg48steals                            |numeric   |
#'    |general_disqualifications                        |numeric   |
#'    |general_flagrant_fouls                           |numeric   |
#'    |general_fouls                                    |numeric   |
#'    |general_rebound_rate                             |numeric   |
#'    |general_ejections                                |numeric   |
#'    |general_technical_fouls                          |numeric   |
#'    |general_rebounds                                 |numeric   |
#'    |general_minutes                                  |numeric   |
#'    |general_avg_minutes                              |numeric   |
#'    |general_fantasy_rating                           |numeric   |
#'    |general_nba_rating                               |numeric   |
#'    |general_plus_minus                               |numeric   |
#'    |general_avg_rebounds                             |numeric   |
#'    |general_avg_fouls                                |numeric   |
#'    |general_avg_flagrant_fouls                       |numeric   |
#'    |general_avg_technical_fouls                      |numeric   |
#'    |general_avg_ejections                            |numeric   |
#'    |general_avg_disqualifications                    |numeric   |
#'    |general_assist_turnover_ratio                    |numeric   |
#'    |general_steal_foul_ratio                         |numeric   |
#'    |general_block_foul_ratio                         |numeric   |
#'    |general_avg_team_rebounds                        |numeric   |
#'    |general_total_rebounds                           |numeric   |
#'    |general_total_technical_fouls                    |numeric   |
#'    |general_team_assist_turnover_ratio               |numeric   |
#'    |general_team_rebounds                            |numeric   |
#'    |general_steal_turnover_ratio                     |numeric   |
#'    |general_avg48rebounds                            |numeric   |
#'    |general_avg48fouls                               |numeric   |
#'    |general_avg48flagrant_fouls                      |numeric   |
#'    |general_avg48technical_fouls                     |numeric   |
#'    |general_avg48ejections                           |numeric   |
#'    |general_avg48disqualifications                   |numeric   |
#'    |general_r40                                      |numeric   |
#'    |general_games_played                             |numeric   |
#'    |general_games_started                            |numeric   |
#'    |general_double_double                            |numeric   |
#'    |general_triple_double                            |numeric   |
#'    |offensive_assists                                |numeric   |
#'    |offensive_effective_fg_pct                       |numeric   |
#'    |offensive_field_goals                            |numeric   |
#'    |offensive_field_goals_attempted                  |numeric   |
#'    |offensive_field_goals_made                       |numeric   |
#'    |offensive_field_goal_pct                         |numeric   |
#'    |offensive_free_throws                            |numeric   |
#'    |offensive_free_throw_pct                         |numeric   |
#'    |offensive_free_throws_attempted                  |numeric   |
#'    |offensive_free_throws_made                       |numeric   |
#'    |offensive_offensive_rebounds                     |numeric   |
#'    |offensive_points                                 |numeric   |
#'    |offensive_turnovers                              |numeric   |
#'    |offensive_three_point_pct                        |numeric   |
#'    |offensive_three_point_field_goals_attempted      |numeric   |
#'    |offensive_three_point_field_goals_made           |numeric   |
#'    |offensive_true_shooting_pct                      |numeric   |
#'    |offensive_team_turnovers                         |numeric   |
#'    |offensive_total_turnovers                        |numeric   |
#'    |offensive_assist_ratio                           |numeric   |
#'    |offensive_points_in_paint                        |numeric   |
#'    |offensive_off_rebound_rate                       |numeric   |
#'    |offensive_turnover_ratio                         |numeric   |
#'    |offensive_fast_break_points                      |numeric   |
#'    |offensive_possessions                            |numeric   |
#'    |offensive_pace_factor                            |numeric   |
#'    |offensive_avg_field_goals_made                   |numeric   |
#'    |offensive_avg_field_goals_attempted              |numeric   |
#'    |offensive_avg_three_point_field_goals_made       |numeric   |
#'    |offensive_avg_three_point_field_goals_attempted  |numeric   |
#'    |offensive_avg_free_throws_made                   |numeric   |
#'    |offensive_avg_free_throws_attempted              |numeric   |
#'    |offensive_avg_points                             |numeric   |
#'    |offensive_avg_offensive_rebounds                 |numeric   |
#'    |offensive_avg_assists                            |numeric   |
#'    |offensive_avg_turnovers                          |numeric   |
#'    |offensive_offensive_rebound_pct                  |numeric   |
#'    |offensive_estimated_possessions                  |numeric   |
#'    |offensive_avg_estimated_possessions              |numeric   |
#'    |offensive_points_per_estimated_possessions       |numeric   |
#'    |offensive_avg_team_turnovers                     |numeric   |
#'    |offensive_avg_total_turnovers                    |numeric   |
#'    |offensive_three_point_field_goal_pct             |numeric   |
#'    |offensive_two_point_field_goals_made             |numeric   |
#'    |offensive_two_point_field_goals_attempted        |numeric   |
#'    |offensive_avg_two_point_field_goals_made         |numeric   |
#'    |offensive_avg_two_point_field_goals_attempted    |numeric   |
#'    |offensive_two_point_field_goal_pct               |numeric   |
#'    |offensive_shooting_efficiency                    |numeric   |
#'    |offensive_scoring_efficiency                     |numeric   |
#'    |offensive_avg48field_goals_made                  |numeric   |
#'    |offensive_avg48field_goals_attempted             |numeric   |
#'    |offensive_avg48three_point_field_goals_made      |numeric   |
#'    |offensive_avg48three_point_field_goals_attempted |numeric   |
#'    |offensive_avg48free_throws_made                  |numeric   |
#'    |offensive_avg48free_throws_attempted             |numeric   |
#'    |offensive_avg48points                            |numeric   |
#'    |offensive_avg48offensive_rebounds                |numeric   |
#'    |offensive_avg48assists                           |numeric   |
#'    |offensive_avg48turnovers                         |numeric   |
#'    |offensive_p40                                    |numeric   |
#'    |offensive_a40                                    |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @keywords NBA Team Stats
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#'   try(espn_nba_team_stats(team_id = 18, year = 2020))
#' }

espn_nba_team_stats <- function(
    team_id,
    year,
    season_type = "regular",
    total = FALSE) {

  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    '/types/',s_type,
    '/teams/',team_id,
    '/statistics/', totals
  )

  df <- data.frame()
  tryCatch(
    expr = {

      # Create the GET request and set response as res
      res <- httr::RETRY("GET", full_url)

      # Check the result
      check_status(res)

      # Get the content and return result as data.frame
      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8")  %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- httr::RETRY("GET", team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL


      team_df <- team_df %>%
        purrr::map_if(is.list,as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c("logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"))) %>%
        janitor::clean_names()

      colnames(team_df)[1:13] <- paste0("team_",colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1")

      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep="_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = glue::glue("{.data$name}_{.data$stats_name}")) %>%
        dplyr::select(
          "stats_category_name",
          "stats_value") %>%
        tidyr::pivot_wider(names_from = "stats_category_name",
                           values_from = "stats_value",
                           values_fn = dplyr::first) %>%
        janitor::clean_names()

      df <- team_df %>%
        dplyr::bind_cols(df)


      df <- df %>%
        make_hoopR_data("ESPN NBA Team Season Stats from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}:Invalid arguments or no team season stats data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **Get ESPN NBA player stats data**
#' @author Saiem Gilani
#' @param athlete_id Athlete ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the player stats data
#'
#'    |col_name                                         |types     |
#'    |:------------------------------------------------|:---------|
#'    |athlete_id                                       |character |
#'    |athlete_uid                                      |character |
#'    |athlete_guid                                     |character |
#'    |athlete_type                                     |character |
#'    |sdr                                              |character |
#'    |first_name                                       |character |
#'    |last_name                                        |character |
#'    |full_name                                        |character |
#'    |display_name                                     |character |
#'    |short_name                                       |character |
#'    |weight                                           |numeric   |
#'    |display_weight                                   |character |
#'    |height                                           |numeric   |
#'    |display_height                                   |character |
#'    |age                                              |integer   |
#'    |date_of_birth                                    |character |
#'    |slug                                             |character |
#'    |headshot_href                                    |character |
#'    |headshot_alt                                     |character |
#'    |jersey                                           |character |
#'    |position_id                                      |character |
#'    |position_name                                    |character |
#'    |position_display_name                            |character |
#'    |position_abbreviation                            |character |
#'    |position_leaf                                    |logical   |
#'    |linked                                           |logical   |
#'    |years                                            |integer   |
#'    |active                                           |logical   |
#'    |contract_x_ref                                   |character |
#'    |contract_bird_status                             |integer   |
#'    |contract_active                                  |logical   |
#'    |contract_active_1                                |logical   |
#'    |contract_incoming_trade_value                    |integer   |
#'    |contract_outgoing_trade_value                    |integer   |
#'    |contract_minimum_salary_exception                |logical   |
#'    |contract_option_type                             |integer   |
#'    |contract_salary                                  |integer   |
#'    |contract_salary_remaining                        |integer   |
#'    |contract_years_remaining                         |integer   |
#'    |contract_x_ref_1                                 |character |
#'    |contract_x_ref_2                                 |character |
#'    |contract_trade_kicker_active                     |logical   |
#'    |contract_trade_kicker_percentage                 |numeric   |
#'    |contract_trade_kicker_value                      |integer   |
#'    |contract_trade_kicker_trade_value                |integer   |
#'    |contract_trade_restriction                       |logical   |
#'    |contract_unsigned_foreign_pick                   |logical   |
#'    |contract_active_2                                |logical   |
#'    |draft_display_text                               |character |
#'    |draft_round                                      |integer   |
#'    |draft_year                                       |integer   |
#'    |draft_selection                                  |integer   |
#'    |draft_x_ref                                      |character |
#'    |draft_x_ref_1                                    |character |
#'    |status_id                                        |character |
#'    |status_name                                      |character |
#'    |status_type                                      |character |
#'    |status_abbreviation                              |character |
#'    |defensive_blocks                                 |numeric   |
#'    |defensive_defensive_rebounds                     |numeric   |
#'    |defensive_steals                                 |numeric   |
#'    |defensive_def_rebound_rate                       |numeric   |
#'    |defensive_avg_defensive_rebounds                 |numeric   |
#'    |defensive_avg_blocks                             |numeric   |
#'    |defensive_avg_steals                             |numeric   |
#'    |defensive_avg48defensive_rebounds                |numeric   |
#'    |defensive_avg48blocks                            |numeric   |
#'    |defensive_avg48steals                            |numeric   |
#'    |defensive_drpm                                   |numeric   |
#'    |general_disqualifications                        |numeric   |
#'    |general_flagrant_fouls                           |numeric   |
#'    |general_fouls                                    |numeric   |
#'    |general_per                                      |numeric   |
#'    |general_rebound_rate                             |numeric   |
#'    |general_ejections                                |numeric   |
#'    |general_technical_fouls                          |numeric   |
#'    |general_rebounds                                 |numeric   |
#'    |general_vorp                                     |numeric   |
#'    |general_warp                                     |numeric   |
#'    |general_rpm                                      |numeric   |
#'    |general_minutes                                  |numeric   |
#'    |general_avg_minutes                              |numeric   |
#'    |general_nba_rating                               |numeric   |
#'    |general_plus_minus                               |numeric   |
#'    |general_avg_rebounds                             |numeric   |
#'    |general_avg_fouls                                |numeric   |
#'    |general_avg_flagrant_fouls                       |numeric   |
#'    |general_avg_technical_fouls                      |numeric   |
#'    |general_avg_ejections                            |numeric   |
#'    |general_avg_disqualifications                    |numeric   |
#'    |general_assist_turnover_ratio                    |numeric   |
#'    |general_steal_foul_ratio                         |numeric   |
#'    |general_block_foul_ratio                         |numeric   |
#'    |general_avg_team_rebounds                        |numeric   |
#'    |general_total_rebounds                           |numeric   |
#'    |general_total_technical_fouls                    |numeric   |
#'    |general_team_assist_turnover_ratio               |numeric   |
#'    |general_steal_turnover_ratio                     |numeric   |
#'    |general_avg48rebounds                            |numeric   |
#'    |general_avg48fouls                               |numeric   |
#'    |general_avg48flagrant_fouls                      |numeric   |
#'    |general_avg48technical_fouls                     |numeric   |
#'    |general_avg48ejections                           |numeric   |
#'    |general_avg48disqualifications                   |numeric   |
#'    |general_r40                                      |numeric   |
#'    |general_games_played                             |numeric   |
#'    |general_games_started                            |numeric   |
#'    |general_double_double                            |numeric   |
#'    |general_triple_double                            |numeric   |
#'    |offensive_assists                                |numeric   |
#'    |offensive_effective_fg_pct                       |numeric   |
#'    |offensive_field_goals                            |numeric   |
#'    |offensive_field_goals_attempted                  |numeric   |
#'    |offensive_field_goals_made                       |numeric   |
#'    |offensive_field_goal_pct                         |numeric   |
#'    |offensive_free_throws                            |numeric   |
#'    |offensive_free_throw_pct                         |numeric   |
#'    |offensive_free_throws_attempted                  |numeric   |
#'    |offensive_free_throws_made                       |numeric   |
#'    |offensive_offensive_rebounds                     |numeric   |
#'    |offensive_points                                 |numeric   |
#'    |offensive_turnovers                              |numeric   |
#'    |offensive_three_point_pct                        |numeric   |
#'    |offensive_three_point_field_goals_attempted      |numeric   |
#'    |offensive_three_point_field_goals_made           |numeric   |
#'    |offensive_true_shooting_pct                      |numeric   |
#'    |offensive_total_turnovers                        |numeric   |
#'    |offensive_assist_ratio                           |numeric   |
#'    |offensive_points_in_paint                        |numeric   |
#'    |offensive_off_rebound_rate                       |numeric   |
#'    |offensive_turnover_ratio                         |numeric   |
#'    |offensive_brick_index                            |numeric   |
#'    |offensive_usage_rate                             |numeric   |
#'    |offensive_avg_field_goals_made                   |numeric   |
#'    |offensive_avg_field_goals_attempted              |numeric   |
#'    |offensive_avg_three_point_field_goals_made       |numeric   |
#'    |offensive_avg_three_point_field_goals_attempted  |numeric   |
#'    |offensive_avg_free_throws_made                   |numeric   |
#'    |offensive_avg_free_throws_attempted              |numeric   |
#'    |offensive_avg_points                             |numeric   |
#'    |offensive_avg_offensive_rebounds                 |numeric   |
#'    |offensive_avg_assists                            |numeric   |
#'    |offensive_avg_turnovers                          |numeric   |
#'    |offensive_offensive_rebound_pct                  |numeric   |
#'    |offensive_estimated_possessions                  |numeric   |
#'    |offensive_avg_estimated_possessions              |numeric   |
#'    |offensive_points_per_estimated_possessions       |numeric   |
#'    |offensive_avg_team_turnovers                     |numeric   |
#'    |offensive_avg_total_turnovers                    |numeric   |
#'    |offensive_three_point_field_goal_pct             |numeric   |
#'    |offensive_two_point_field_goals_made             |numeric   |
#'    |offensive_two_point_field_goals_attempted        |numeric   |
#'    |offensive_avg_two_point_field_goals_made         |numeric   |
#'    |offensive_avg_two_point_field_goals_attempted    |numeric   |
#'    |offensive_two_point_field_goal_pct               |numeric   |
#'    |offensive_shooting_efficiency                    |numeric   |
#'    |offensive_scoring_efficiency                     |numeric   |
#'    |offensive_avg48field_goals_made                  |numeric   |
#'    |offensive_avg48field_goals_attempted             |numeric   |
#'    |offensive_avg48three_point_field_goals_made      |numeric   |
#'    |offensive_avg48three_point_field_goals_attempted |numeric   |
#'    |offensive_avg48free_throws_made                  |numeric   |
#'    |offensive_avg48free_throws_attempted             |numeric   |
#'    |offensive_avg48points                            |numeric   |
#'    |offensive_avg48offensive_rebounds                |numeric   |
#'    |offensive_avg48assists                           |numeric   |
#'    |offensive_avg48turnovers                         |numeric   |
#'    |offensive_p40                                    |numeric   |
#'    |offensive_a40                                    |numeric   |
#'    |offensive_orpm                                   |numeric   |
#'    |team_id                                          |character |
#'    |team_guid                                        |character |
#'    |team_uid                                         |character |
#'    |team_slug                                        |character |
#'    |team_location                                    |character |
#'    |team_name                                        |character |
#'    |team_abbreviation                                |character |
#'    |team_display_name                                |character |
#'    |team_short_display_name                          |character |
#'    |team_color                                       |character |
#'    |team_alternate_color                             |character |
#'    |team_is_active                                   |logical   |
#'    |team_is_all_star                                 |logical   |
#'    |logo_href                                        |character |
#'    |logo_dark_href                                   |character |
#'    |logos_href_2                                     |character |
#'    |logos_href_3                                     |character |
#'
#' @export
#' @keywords NBA Player Stats
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   try(espn_nba_player_stats(athlete_id = 4433134, year = 2022))
#' }

espn_nba_player_stats <- function(athlete_id, year, season_type='regular', total=FALSE){
  if (!(tolower(season_type) %in% c("regular","postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    '/types/',s_type,
    '/athletes/', athlete_id,
    '/statistics/', totals
  )
  athlete_url <- paste0(
    base_url,
    year,
    '/athletes/', athlete_id
  )
  df <- data.frame()
  tryCatch(
    expr = {

      # Create the GET request and set response as res
      res <- httr::RETRY("GET", full_url)

      # Check the result
      check_status(res)
      # Create the GET request and set response as res
      athlete_res <- httr::RETRY("GET", athlete_url)

      # Check the result
      check_status(athlete_res)

      athlete_df <- athlete_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- athlete_df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- httr::RETRY("GET", team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL


      team_df <- team_df %>%
        purrr::map_if(is.list,as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c("logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"))) %>%
        janitor::clean_names()
      colnames(team_df)[1:13] <- paste0("team_",colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1")


      athlete_df[["links"]] <- NULL
      athlete_df[["injuries"]] <- NULL
      athlete_df[["birthPlace"]] <- NULL

      athlete_df <- athlete_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        tibble::tibble(data=.data$.)
      athlete_df <- athlete_df$data %>%
        as.data.frame() %>%
        dplyr::select(-dplyr::any_of(c("X.ref","X.ref.1","X.ref.2","X.ref.3","X.ref.4","X.ref.5","X.ref.6","X.ref.7","X.ref.8",
                                       "position.X.ref","position.X.ref.1",
                                       "contract.x.ref","contract.x.ref.1","contract.x.ref.2",
                                       "draft.x.ref","draft.x.ref.1"))) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "athlete_id" = "id",
          "athlete_uid" = "uid",
          "athlete_guid" = "guid",
          "athlete_type" = "type")


      # Get the content and return result as data.frame
      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep="_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = glue::glue("{.data$name}_{.data$stats_name}")) %>%
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(names_from = "stats_category_name",
                           values_from = "stats_value",
                           values_fn = dplyr::first) %>%
        janitor::clean_names()
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        make_hoopR_data("ESPN NBA Player Season Stats from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}:Invalid arguments or no player season stats data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df)
}

#'  **Parse ESPN NBA PBP, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @export
helper_espn_nba_pbp <- function(resp){

  game_json <- resp %>%
    jsonlite::fromJSON()

  homeAway1 <- jsonlite::fromJSON(resp)[['header']][['competitions']][['competitors']][[1]][['homeAway']][1]

  gameId <- as.integer(game_json[["header"]][["id"]])
  season <- game_json[['header']][['season']][['year']]
  season_type <- game_json[['header']][['season']][['type']]
  game_date <- as.Date(substr(game_json[['header']][['competitions']][['date']], 0, 10))

  id_vars <- data.frame()
  if (homeAway1 == "home") {

    homeTeamId = as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
    homeTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
    homeTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
    homeTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
    homeTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
    homeTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
    homeTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
    homeTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
    homeTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
    homeTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']][1])
    homeTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']][1]
    homeTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
    awayTeamId = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
    awayTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
    awayTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
    awayTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
    awayTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
    awayTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
    awayTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
    awayTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
    awayTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
    awayTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']][2])
    awayTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']][2]
    awayTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
    id_vars <- data.frame(
      homeTeamId,
      homeTeamMascot,
      homeTeamName,
      homeTeamAbbrev,
      homeTeamLogo,
      homeTeamLogoDark,
      homeTeamFullName,
      homeTeamColor,
      homeTeamAlternateColor,
      homeTeamScore,
      homeTeamWinner,
      homeTeamRecord,
      awayTeamId,
      awayTeamMascot,
      awayTeamName,
      awayTeamAbbrev,
      awayTeamLogo,
      awayTeamLogoDark,
      awayTeamFullName,
      awayTeamColor,
      awayTeamAlternateColor,
      awayTeamScore,
      awayTeamWinner,
      awayTeamRecord
    )
  } else {

    awayTeamId = as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
    awayTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
    awayTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
    awayTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
    awayTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
    awayTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
    awayTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
    awayTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
    awayTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
    awayTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']][1])
    awayTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']][1]
    awayTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
    homeTeamId = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
    homeTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
    homeTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
    homeTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
    homeTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
    homeTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
    homeTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
    homeTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
    homeTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
    homeTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']][2])
    homeTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']][2]
    homeTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
    id_vars <- data.frame(
      homeTeamId,
      homeTeamMascot,
      homeTeamName,
      homeTeamAbbrev,
      homeTeamLogo,
      homeTeamLogoDark,
      homeTeamFullName,
      homeTeamColor,
      homeTeamAlternateColor,
      homeTeamScore,
      homeTeamWinner,
      homeTeamRecord,
      awayTeamId,
      awayTeamMascot,
      awayTeamName,
      awayTeamAbbrev,
      awayTeamLogo,
      awayTeamLogoDark,
      awayTeamFullName,
      awayTeamColor,
      awayTeamAlternateColor,
      awayTeamScore,
      awayTeamWinner,
      awayTeamRecord
    )

  }

  game_json <- game_json %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(flatten = TRUE)


  plays <- game_json[["plays"]] %>%
    tidyr::unnest_wider("participants")

  if (("coordinate.x" %in% names(plays)) && ("coordinate.y" %in% names(plays))) {
    plays <- plays %>%
      dplyr::mutate(
        # convert types
        coordinate.x = as.double(.data$coordinate.x),
        coordinate.y = as.double(.data$coordinate.y),
        # Free throws are adjusted automatically to 19' from baseline, which
        # corresponds to 13.75' from the center of the basket (originally
        # the center of the basket is (25, 0))
        coordinate.y = dplyr::case_when(
          stringr::str_detect(.data$type.text, "Free Throw") ~ 13.75,
          TRUE ~ .data$coordinate.y
        ),
        coordinate.x = dplyr::case_when(
          stringr::str_detect(.data$type.text, "Free Throw") ~ 25,
          TRUE ~ .data$coordinate.x
        ),
        coordinate_x_transformed = dplyr::case_when(
          .data$team.id == homeTeamId ~ -1 * (.data$coordinate.y - 41.75),
          TRUE ~ .data$coordinate.y - 41.75
        ),
        coordinate_y_transformed = dplyr::case_when(
          .data$team.id == homeTeamId ~ -1 * (.data$coordinate.x - 25),
          TRUE ~ .data$coordinate.x - 25
        )
      ) %>%
      dplyr::rename(
        "coordinate.x.raw" = "coordinate.x",
        "coordinate.y.raw" = "coordinate.y",
        "coordinate.x" = "coordinate_x_transformed",
        "coordinate.y" = "coordinate_y_transformed"
      )
  }
  suppressWarnings(
    aths <- plays %>%
      dplyr::group_by(.data$id) %>%
      dplyr::select(
        "id",
        "athlete.id") %>%
      tidyr::unnest_wider("athlete.id", names_sep = "_")
  )
  names(aths) <- c("play.id", "athlete.id.1", "athlete.id.2", "athlete.id.3")
  plays_df <- dplyr::bind_cols(plays, aths, id_vars) %>%
    select(-"athlete.id") %>%
    dplyr::mutate(
      game_id = gameId,
      season = season,
      season_type = season_type,
      game_date = game_date) %>%
    janitor::clean_names() %>%
    make_hoopR_data("ESPN NBA Play-by-Play Information from ESPN.com", Sys.time())

  return(plays_df)
}

#'  **Parse ESPN NBA Team Box, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @export
helper_espn_nba_team_box <- function(resp){

  game_json <- resp %>%
    jsonlite::fromJSON()

  gameId <- as.integer(game_json[["header"]][["id"]])
  box_score_available <- game_json[["header"]][["competitions"]][["boxscoreAvailable"]]
  if (box_score_available == TRUE) {
    teams_box_score_df <- game_json[["boxscore"]][["teams"]] %>%
      jsonlite::toJSON() %>%
      jsonlite::fromJSON(flatten = TRUE)
    if (length(teams_box_score_df[["statistics"]][[1]]) > 0) {
      # Teams info columns and values
      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]][1]
      homeAway1_team.id <- as.integer(teams_df[["id"]][1])
      homeAway1_team.score <- as.integer(teams_df[["score"]][1])
      homeAway1_team.winner <- teams_df[["winner"]][1]

      homeAway2 <- teams_df[["homeAway"]][2]
      homeAway2_team.id <- as.integer(teams_df[["id"]][2])
      homeAway2_team.score <- as.integer(teams_df[["score"]][2])
      homeAway2_team.winner <- teams_df[["winner"]][2]

      # Pivoting the table values for each team from long to wide
      statistics_df_1 <- teams_box_score_df[["statistics"]][[1]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      statistics_df_2 <- teams_box_score_df[["statistics"]][[2]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      # Assigning values to the correct data frame rows - 1
      statistics_df_1$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        homeAway1,
        homeAway2
      )
      statistics_df_1$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      statistics_df_1$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        homeAway1_team.winner,
        homeAway2_team.winner
      )
      statistics_df_1$team.id <- as.integer(teams_box_score_df[["team.id"]][[1]])
      statistics_df_1$team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_1$team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_1$team.location <- teams_box_score_df[["team.location"]][[1]]
      statistics_df_1$team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_1$team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[1]]
      statistics_df_1$team.displayName <- teams_box_score_df[["team.displayName"]][[1]]
      statistics_df_1$team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[1]]
      statistics_df_1$team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_1$team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[1]]
      statistics_df_1$team.logo <- teams_box_score_df[["team.logo"]][[1]]
      statistics_df_1$opponent.team.id <- as.integer(teams_box_score_df[["team.id"]][[2]])
      statistics_df_1$opponent.team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_1$opponent.team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_1$opponent.team.location <- teams_box_score_df[["team.location"]][[2]]
      statistics_df_1$opponent.team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_1$opponent.team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[2]]
      statistics_df_1$opponent.team.displayName <- teams_box_score_df[["team.displayName"]][[2]]
      statistics_df_1$opponent.team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[2]]
      statistics_df_1$opponent.team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_1$opponent.team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[2]]
      statistics_df_1$opponent.team.logo <- teams_box_score_df[["team.logo"]][[2]]

      # Assigning values to the correct data frame rows - 2
      statistics_df_2$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        homeAway2,
        homeAway1
      )
      statistics_df_2$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      statistics_df_2$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        homeAway2_team.winner,
        homeAway1_team.winner
      )
      statistics_df_2$team.id <- as.integer(teams_box_score_df[["team.id"]][[2]])
      statistics_df_2$team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_2$team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_2$team.location <- teams_box_score_df[["team.location"]][[2]]
      statistics_df_2$team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_2$team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[2]]
      statistics_df_2$team.displayName <- teams_box_score_df[["team.displayName"]][[2]]
      statistics_df_2$team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[2]]
      statistics_df_2$team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_2$team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[2]]
      statistics_df_2$team.logo <- teams_box_score_df[["team.logo"]][[2]]
      statistics_df_2$opponent.team.id <- as.integer(teams_box_score_df[["team.id"]][[1]])
      statistics_df_2$opponent.team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_2$opponent.team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_2$opponent.team.location <- teams_box_score_df[["team.location"]][[1]]
      statistics_df_2$opponent.team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_2$opponent.team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[1]]
      statistics_df_2$opponent.team.displayName <- teams_box_score_df[["team.displayName"]][[1]]
      statistics_df_2$opponent.team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[1]]
      statistics_df_2$opponent.team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_2$opponent.team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[1]]
      statistics_df_2$opponent.team.logo <- teams_box_score_df[["team.logo"]][[1]]

      complete_statistics_df <- statistics_df_1 %>%
        dplyr::bind_rows(statistics_df_2)

      # Assigning game/season level data to team box score and converting types
      complete_statistics_df$season <- game_json[["header"]][["season"]][["year"]]
      complete_statistics_df$season_type <- game_json[["header"]][["season"]][["type"]]
      complete_statistics_df$game_date <- as.Date(substr(game_json[["header"]][["competitions"]][["date"]], 0, 10))
      complete_statistics_df$game_id <- as.integer(gameId)

      suppressWarnings(
        complete_statistics_df <- complete_statistics_df %>%
          tidyr::separate("fieldGoalsMade-fieldGoalsAttempted",
                          into = c("fieldGoalsMade", "fieldGoalsAttempted"),
                          sep = "-") %>%
          tidyr::separate("freeThrowsMade-freeThrowsAttempted",
                          into = c("freeThrowsMade", "freeThrowsAttempted"),
                          sep = "-") %>%
          tidyr::separate("threePointFieldGoalsMade-threePointFieldGoalsAttempted",
                          into = c("threePointFieldGoalsMade", "threePointFieldGoalsAttempted"),
                          sep = "-") %>%
          dplyr::mutate(dplyr::across(c(
            "fieldGoalPct",
            "freeThrowPct",
            "threePointFieldGoalPct"
          ), ~as.numeric(.x))) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "assists",
            "blocks",
            "defensiveRebounds",
            "fieldGoalsMade",
            "fieldGoalsAttempted",
            "flagrantFouls",
            "fouls",
            "freeThrowsMade",
            "freeThrowsAttempted",
            "offensiveRebounds",
            "steals",
            "teamTurnovers",
            "technicalFouls",
            "threePointFieldGoalsMade",
            "threePointFieldGoalsAttempted",
            "totalRebounds",
            "totalTechnicalFouls",
            "totalTurnovers",
            "turnovers"
          )), ~as.integer(.x)))
      )
      team_box_score <- complete_statistics_df %>%
        janitor::clean_names() %>%
        dplyr::select(dplyr::any_of(c(
          "game_id",
          "season",
          "season_type",
          "game_date",
          "team_id",
          "team_uid",
          "team_slug",
          "team_location",
          "team_name",
          "team_abbreviation",
          "team_display_name",
          "team_short_display_name",
          "team_color",
          "team_alternate_color",
          "team_logo",
          "team_home_away",
          "team_score",
          "team_winner")),
          tidyr::everything()) %>%
        make_hoopR_data("ESPN NBA Team Box Information from ESPN.com", Sys.time())
    }
  }
  return(team_box_score)
}

#'  **Parse ESPN NBA Player Box, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @export
helper_espn_nba_player_box <- function(resp){

  game_json <- resp %>%
    jsonlite::fromJSON(flatten = TRUE)

  players_box_score_df <- game_json[["boxscore"]][["players"]] %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as.data.frame()

  gameId <- as.integer(game_json[["header"]][["id"]])
  season <- game_json[["header"]][["season"]][["year"]]
  season_type <- game_json[["header"]][["season"]][["type"]]
  game_date <- as.Date(substr(game_json[["header"]][["competitions"]][["date"]], 0, 10))
  boxScoreAvailable <- game_json[["header"]][["competitions"]][["boxscoreAvailable"]]

  boxScoreSource <- game_json[["header"]][["competitions"]][["boxscoreSource"]]
  if (boxScoreAvailable == TRUE &&
      length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]]) > 1) {
    players_df <- players_box_score_df %>%
      tidyr::unnest("statistics") %>%
      tidyr::unnest("athletes")
    if (length(players_box_score_df[["statistics"]]) > 1 &&
        length(players_df$stats[[1]]) > 0) {

      players_df <- jsonlite::fromJSON(jsonlite::toJSON(game_json[["boxscore"]][["players"]]), flatten = TRUE) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")

      stat_cols <- players_df$keys[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind,stats))
      colnames(stats_df) <- stat_cols
      suppressWarnings(
        stats_df <- stats_df %>%
          tidyr::separate("fieldGoalsMade-fieldGoalsAttempted",
                          into = c("fieldGoalsMade", "fieldGoalsAttempted"),
                          sep = "-") %>%
          tidyr::separate("freeThrowsMade-freeThrowsAttempted",
                          into = c("freeThrowsMade", "freeThrowsAttempted"),
                          sep = "-") %>%
          tidyr::separate("threePointFieldGoalsMade-threePointFieldGoalsAttempted",
                          into = c("threePointFieldGoalsMade", "threePointFieldGoalsAttempted"),
                          sep = "-") %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "minutes",
            "fieldGoalPct",
            "freeThrowPct",
            "threePointFieldGoalPct"
          )), ~as.numeric(.x))) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "assists",
            "blocks",
            "defensiveRebounds",
            "fieldGoalsMade",
            "fieldGoalsAttempted",
            "flagrantFouls",
            "fouls",
            "freeThrowsMade",
            "freeThrowsAttempted",
            "offensiveRebounds",
            "steals",
            "teamTurnovers",
            "technicalFouls",
            "threePointFieldGoalsMade",
            "threePointFieldGoalsAttempted",
            "rebounds",
            "totalTechnicalFouls",
            "totalTurnovers",
            "turnovers",
            "points"
          )), ~as.integer(.x)))
      )
      players_df_did_not_play <- players_df %>%
        dplyr::filter(.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- stats_df %>%
        dplyr::bind_cols(players_df) %>%
        dplyr::bind_rows(players_df_did_not_play)

      players_df <- players_df %>%
        dplyr::select(dplyr::any_of(c(
          "athlete.displayName",
          "team.shortDisplayName")),
          tidyr::everything()) %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_id = gameId,
          season = season,
          season_type = season_type,
          game_date = game_date)


      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]][1]
      homeAway1_team.id <- as.integer(teams_df[["id"]][1])
      homeAway1_team.location <- teams_df[["team.location"]][1]
      homeAway1_team.name <- teams_df[["team.name"]][1]
      homeAway1_team.abbreviation <- teams_df[["team.abbreviation"]][1]
      homeAway1_team.displayName <- teams_df[["team.displayName"]][1]
      homeAway1_team.logos <- teams_df[["team.logos"]][[1]][["href"]][1]
      homeAway1_team.color <- teams_df[["team.color"]][1]
      homeAway1_team.alternateColor <- teams_df[["team.alternateColor"]][1]
      homeAway1_team.winner <- teams_df[["winner"]][1]
      homeAway1_team.score <- teams_df[["score"]][1]

      homeAway2 <- teams_df[["homeAway"]][2]
      homeAway2_team.id <- as.integer(teams_df[["id"]][2])
      homeAway2_team.location <- teams_df[["team.location"]][2]
      homeAway2_team.name <- teams_df[["team.name"]][2]
      homeAway2_team.abbreviation <- teams_df[["team.abbreviation"]][2]
      homeAway2_team.displayName <- teams_df[["team.displayName"]][2]
      homeAway2_team.logos <- teams_df[["team.logos"]][[2]][["href"]][1]
      homeAway2_team.color <- teams_df[["team.color"]][2]
      homeAway2_team.alternateColor <- teams_df[["team.alternateColor"]][2]
      homeAway2_team.winner <- teams_df[["winner"]][2]
      homeAway2_team.score <- teams_df[["score"]][2]

      players_df <- players_df %>%
        dplyr::mutate(
          home_away = ifelse(.data$team_id == homeAway1_team.id, homeAway1, homeAway2),
          team_winner = ifelse(.data$team_id == homeAway1_team.id, homeAway1_team.winner, homeAway2_team.winner),
          team_score = ifelse(.data$team_id == homeAway1_team.id, homeAway1_team.score, homeAway2_team.score),
          opponent_team_id = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.id, homeAway1_team.id),
          opponent_team_name = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.name, homeAway1_team.name),
          opponent_team_location = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.location, homeAway1_team.location),
          opponent_team_display_name = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.displayName, homeAway1_team.displayName),
          opponent_team_abbreviation = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.abbreviation, homeAway1_team.abbreviation),
          opponent_team_logo = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.logos, homeAway1_team.logos),
          opponent_team_color = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.color, homeAway1_team.color),
          opponent_team_alternate_color = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.alternateColor, homeAway1_team.alternateColor),
          opponent_team_score = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.score, homeAway1_team.score),
        ) %>%
        dplyr::arrange(.data$home_away)

      player_box_score <- players_df %>%
        dplyr::select(dplyr::any_of(c(
          "game_id",
          "season",
          "season_type",
          "game_date",
          "athlete_id",
          "athlete_display_name",
          "team_id",
          "team_name",
          "team_location",
          "team_short_display_name",
          "minutes",
          "field_goals_made",
          "field_goals_attempted",
          "three_point_field_goals_made",
          "three_point_field_goals_attempted",
          "free_throws_made",
          "free_throws_attempted",
          "offensive_rebounds",
          "defensive_rebounds",
          "rebounds",
          "assists",
          "steals",
          "blocks",
          "turnovers",
          "fouls",
          "plus_minus",
          "points",
          "starter",
          "ejected",
          "did_not_play",
          "reason",
          "active",
          "athlete_jersey",
          "athlete_short_name",
          "athlete_headshot_href",
          "athlete_position_name",
          "athlete_position_abbreviation",
          "team_display_name",
          "team_uid",
          "team_slug",
          "team_logo",
          "team_abbreviation",
          "team_color",
          "team_alternate_color",
          "home_away",
          "team_winner",
          "team_score",
          "opponent_team_id",
          "opponent_team_name",
          "opponent_team_location",
          "opponent_team_display_name",
          "opponent_team_abbreviation",
          "opponent_team_logo",
          "opponent_team_color",
          "opponent_team_alternate_color",
          "opponent_team_score"
          ))) %>%
        make_hoopR_data("ESPN NBA Player Box Information from ESPN.com", Sys.time())
    }
  }
  return(player_box_score)
}
