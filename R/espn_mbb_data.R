#' **Get ESPN men's college basketball data (Pbp, Team and Player Box)**
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
#'    |type_id                   |integer   |
#'    |type_text                 |character |
#'    |period_number             |integer   |
#'    |period_display_value      |character |
#'    |clock_display_value       |character |
#'    |team_id                   |integer   |
#'    |coordinate_x_raw          |numeric   |
#'    |coordinate_y_raw          |numeric   |
#'    |coordinate_x              |numeric   |
#'    |coordinate_y              |numeric   |
#'    |play_id                   |character |
#'    |athlete_id_1              |integer   |
#'    |athlete_id_2              |integer   |
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
#'    |game_date_time            |POSIXct   |
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
#'    |game_date_time                    |POSIXct   |
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
#'    |steals                            |integer   |
#'    |team_turnovers                    |integer   |
#'    |technical_fouls                   |integer   |
#'    |three_point_field_goal_pct        |numeric   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |total_rebounds                    |integer   |
#'    |total_technical_fouls             |integer   |
#'    |total_turnovers                   |integer   |
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
#'    |opponent_team_score               |integer   |
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
#'    |game_date_time                    |POSIXct   |
#'    |athlete_id                        |integer   |
#'    |athlete_display_name              |character |
#'    |team_id                           |integer   |
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
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
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
#'    |team_score                        |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_name                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_score               |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Game
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_game_all(game_id = 401479672))
#' }

espn_mbb_game_all <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  # plays_df <- data.frame()
  # team_box_score <- data.frame()
  # player_box_score <- data.frame()

  #---- Play-by-Play ------
  tryCatch(
    expr = {

      plays_df <- helper_espn_mbb_pbp(resp)

      if (is.null(plays_df)) {
        message(glue::glue("{Sys.time()}: No play-by-play data for {game_id} available!"))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  #---- Team Box ------
  tryCatch(
    expr = {

      team_box_score <- helper_espn_mbb_team_box(resp)

      if (is.null(team_box_score)) {
        message(glue::glue("{Sys.time()}: No team box score data for {game_id} available!"))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  #---- Player Box ------
  tryCatch(
    expr = {

      player_box_score <- helper_espn_mbb_player_box(resp)

      if (is.null(player_box_score)) {
        message(glue::glue("{Sys.time()}: No player box score data for {game_id} available!"))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"
        )
      )
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



#' **Get ESPN men's college basketball PBP data**
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
#'    |type_id                   |integer   |
#'    |type_text                 |character |
#'    |period_number             |integer   |
#'    |period_display_value      |character |
#'    |clock_display_value       |character |
#'    |team_id                   |integer   |
#'    |coordinate_x_raw          |numeric   |
#'    |coordinate_y_raw          |numeric   |
#'    |coordinate_x              |numeric   |
#'    |coordinate_y              |numeric   |
#'    |play_id                   |character |
#'    |athlete_id_1              |integer   |
#'    |athlete_id_2              |integer   |
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
#'    |game_date_time            |POSIXct   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB PBP
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_pbp(game_id = 401479672))
#' }
#'
espn_mbb_pbp <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  tryCatch(
    expr = {

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      plays_df <- helper_espn_mbb_pbp(resp)

      if (is.null(plays_df)) {
        return(message(glue::glue("{Sys.time()}: No play-by-play data for {game_id} available!")))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )

  return(plays_df)
}
#' **Get ESPN men's college basketball team box scores**
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
#'    |game_date_time                    |POSIXct   |
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
#'    |steals                            |integer   |
#'    |team_turnovers                    |integer   |
#'    |technical_fouls                   |integer   |
#'    |three_point_field_goal_pct        |numeric   |
#'    |three_point_field_goals_made      |integer   |
#'    |three_point_field_goals_attempted |integer   |
#'    |total_rebounds                    |integer   |
#'    |total_technical_fouls             |integer   |
#'    |total_turnovers                   |integer   |
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
#'    |opponent_team_score               |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Team Box
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_team_box(game_id = 401479672))
#' }
espn_mbb_team_box <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      team_box_score <- helper_espn_mbb_team_box(resp)

      if (is.null(team_box_score)) {
        return(message(glue::glue("{Sys.time()}: No team box score data for {game_id} available!")))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  return(team_box_score)
}
#' **Get ESPN men's college basketball player box scores**
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
#'    |game_date_time                    |POSIXct   |
#'    |athlete_id                        |integer   |
#'    |athlete_display_name              |character |
#'    |team_id                           |integer   |
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
#'    |points                            |integer   |
#'    |starter                           |logical   |
#'    |ejected                           |logical   |
#'    |did_not_play                      |logical   |
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
#'    |team_score                        |integer   |
#'    |opponent_team_id                  |integer   |
#'    |opponent_team_name                |character |
#'    |opponent_team_location            |character |
#'    |opponent_team_display_name        |character |
#'    |opponent_team_abbreviation        |character |
#'    |opponent_team_logo                |character |
#'    |opponent_team_color               |character |
#'    |opponent_team_alternate_color     |character |
#'    |opponent_team_score               |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Player Box
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_player_box(game_id = 401479672))
#' }
espn_mbb_player_box <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      player_box_score <- helper_espn_mbb_player_box(resp)

      if (is.null(player_box_score)) {
        return(message(glue::glue("{Sys.time()}: No player box score data for {game_id} available!")))
      }

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  return(player_box_score)
}



#' **Get ESPN men's college basketball game rosters**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A game rosters data frame
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |athlete_id               |integer   |
#'    |athlete_uid              |character |
#'    |athlete_guid             |character |
#'    |athlete_type             |character |
#'    |sdr                      |integer   |
#'    |first_name               |character |
#'    |last_name                |character |
#'    |full_name                |character |
#'    |athlete_display_name     |character |
#'    |short_name               |character |
#'    |weight                   |integer   |
#'    |display_weight           |character |
#'    |height                   |integer   |
#'    |display_height           |character |
#'    |age                      |integer   |
#'    |date_of_birth            |character |
#'    |birth_place_city         |character |
#'    |birth_place_state        |character |
#'    |birth_place_country      |character |
#'    |slug                     |character |
#'    |headshot_href            |character |
#'    |headshot_alt             |character |
#'    |jersey                   |character |
#'    |hand_type                |character |
#'    |hand_abbreviation        |character |
#'    |hand_display_value       |character |
#'    |position_id              |integer   |
#'    |position_name            |character |
#'    |position_display_name    |character |
#'    |position_abbreviation    |character |
#'    |position_leaf            |logical   |
#'    |linked                   |logical   |
#'    |experience_years         |integer   |
#'    |experience_display_value |character |
#'    |experience_abbreviation  |character |
#'    |active                   |logical   |
#'    |draft_display_text       |character |
#'    |draft_round              |integer   |
#'    |draft_year               |integer   |
#'    |draft_selection          |integer   |
#'    |status_id                |integer   |
#'    |status_name              |character |
#'    |status_type              |character |
#'    |status_abbreviation      |character |
#'    |starter                  |logical   |
#'    |valid                    |logical   |
#'    |did_not_play             |logical   |
#'    |display_name             |character |
#'    |ejected                  |logical   |
#'    |team_id                  |integer   |
#'    |team_guid                |character |
#'    |team_uid                 |character |
#'    |team_sdr                 |integer   |
#'    |team_slug                |character |
#'    |team_location            |character |
#'    |team_name                |character |
#'    |team_nickname            |character |
#'    |team_abbreviation        |character |
#'    |team_display_name        |character |
#'    |team_short_display_name  |character |
#'    |team_color               |character |
#'    |team_alternate_color     |character |
#'    |is_active                |logical   |
#'    |is_all_star              |logical   |
#'    |logo_href                |character |
#'    |logo_dark_href           |character |
#'    |game_id                  |integer   |
#'    |order                    |integer   |
#'    |home_away                |character |
#'    |winner                   |logical   |
#'    |roster_href              |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Game Roster
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_game_rosters(game_id = 401256760))
#' }
espn_mbb_game_rosters <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/events/",
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
      team_ids <- teams_df$team_id
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
        raw_play_df[['links']] <- NULL
        raw_play_df[['injuries']] <- NULL
        raw_play_df[['teams']] <- NULL
        raw_play_df[['team']] <- NULL
        raw_play_df[['college']] <- NULL
        raw_play_df[['proAthlete']] <- NULL
        raw_play_df[['statistics']] <- NULL
        raw_play_df[['notes']] <- NULL
        raw_play_df[['eventLog']] <- NULL
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
        janitor::clean_names()  %>%
        dplyr::select(-dplyr::any_of(c(
          "athlete_href",
          "position_href",
          "statistics_href"
        ))) %>%
        dplyr::mutate_at(c(
          "game_id",
          "athlete_id",
          "team_id",
          "position_id",
          "status_id",
          "sdr",
          "team_sdr"), as.integer) %>%
        make_hoopR_data("ESPN MBB Game Roster Information from ESPN.com", Sys.time())

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



#' **Get ESPN conference names and IDs**
#' @author Saiem Gilani
#' @return A conferences data frame
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |group_id              |integer   |
#'    |conference_short_name |character |
#'    |conference_uid        |character |
#'    |conference_name       |character |
#'    |conference_logo       |character |
#'    |parent_group_id       |integer   |
#'    |conference_id         |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Conferences
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_conferences())
#' }
espn_mbb_conferences <- function() {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))


  tryCatch(
    expr = {
      play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard/conferences?seasontype=2"

      res <- httr::RETRY("GET", play_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      conferences <- jsonlite::fromJSON(resp)[["conferences"]] %>%
        dplyr::select(-"subGroups") %>%
        janitor::clean_names() %>%
        dplyr::filter(!(.data$group_id %in% c(0,50))) %>%
        dplyr::mutate(
          group_id = as.integer(.data$group_id),
          conference_id = .data$group_id,
          parent_group_id = as.integer(.data$parent_group_id)) %>%
        dplyr::rename(dplyr::any_of(c(
          "conference_short_name" = "short_name",
          "conference_uid" = "uid",
          "conference_name" = "name",
          "conference_logo" = "logo"
        ))) %>%
        make_hoopR_data("ESPN MBB Conferences Information from ESPN.com", Sys.time())

    },
    error = function(e) {
      message(glue::glue(
        "{Sys.time()}: Invalid arguments or no conferences info available!"
      ))
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  return(conferences)
}

#' **Get ESPN men's college basketball team names and IDs**
#' @author Saiem Gilani
#' @param year Either numeric or character (YYYY)
#' @return A teams data frame
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |team_id               |integer   |
#'    |abbreviation          |character |
#'    |display_name          |character |
#'    |short_name            |character |
#'    |mascot                |character |
#'    |nickname              |character |
#'    |team                  |character |
#'    |color                 |character |
#'    |alternate_color       |character |
#'    |logo                  |character |
#'    |logo_dark             |character |
#'    |href                  |character |
#'    |conference_url        |character |
#'    |group_id              |integer   |
#'    |conference_short_name |character |
#'    |conference_uid        |character |
#'    |conference_name       |character |
#'    |conference_logo       |character |
#'    |parent_group_id       |integer   |
#'    |conference_id         |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import furrr
#' @import rvest
#' @export
#' @keywords MBB Teams
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   try(espn_mbb_teams())
#' }
espn_mbb_teams <- function(year = most_recent_mbb_season()) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  tryCatch(
    expr = {
      teams_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams?limit=1000"

      res <- httr::RETRY("GET", teams_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      leagues <-
        jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][['teams']][[1]][['team']] %>%
        dplyr::group_by(.data$id) %>%
        tidyr::unnest_wider("logos", names_sep = "_") %>%
        tidyr::unnest_wider("logos_href", names_sep = "_") %>%
        dplyr::select(
          -"logos_width",
          -"logos_height",
          -"logos_alt",
          -"logos_rel") %>%
        dplyr::ungroup()
      if ("records" %in% colnames(leagues)) {
        records <- leagues$record
        records <- records %>%
          tidyr::unnest_wider("items") %>%
          tidyr::unnest_wider("stats", names_sep = "_") %>%
          dplyr::mutate(row = dplyr::row_number())
        stat <- records %>%
          dplyr::group_by(.data$row) %>%
          purrr::map_if(is.data.frame, list)
        stat <- lapply(stat$stats_1, function(x)
          x %>%
            purrr::map_if(is.data.frame, list) %>%
            dplyr::as_tibble())

        s <- lapply(stat, function(x) {
          tidyr::pivot_wider(x)
        })

        s <- tibble::tibble(g = s)
        stats <- s %>%
          tidyr::unnest_wider("g")

        records <-
          dplyr::bind_cols(records %>% dplyr::select("summary"), stats)
        leagues <- leagues %>%
          dplyr::select(-dplyr::any_of("record"))
      }
      league_drop_cols <- c("links","isActive","isAllStar","uid","slug")
      leagues <- leagues %>%
        dplyr::select(-dplyr::any_of(league_drop_cols))
      teams <- leagues %>%
        dplyr::rename(
          "logo" = "logos_href_1",
          "logo_dark" = "logos_href_2",
          "mascot" = "name",
          "team" = "location",
          "team_id" = "id",
          "short_name" = "shortDisplayName",
          "alternate_color" = "alternateColor",
          "display_name" = "displayName") %>%
        dplyr::mutate(team_id = as.integer(.data$team_id))

      conferences <- espn_mbb_conferences()

      # ---- Figuring out which teams are in which conference (32 calls)
      base_url <- "http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons"
      conferences_base_url <- glue::glue("{base_url}/{year}/types/2/groups/50/children?limit=1000&lang=en&region=us")

      res <- httr::RETRY("GET", conferences_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      conf_items <- resp %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("items") %>%
        data.frame() %>%
        dplyr::rename("href" = "X.ref") %>%
        dplyr::mutate(
          group_id = as.integer(stringr::str_extract(.data$href, "(?<=groups\\/)\\d+")),
          teams_url = paste0(base_url,"/",
                             year,
                             "/types/2/groups/",
                             .data$group_id,
                             "/teams?lang=en&region=us")
        )

      conference_teams <- purrr::map_dfr(conf_items$teams_url, function(x){
        res <- httr::RETRY("GET", x)

        # Check the result
        check_status(res)

        resp <- res %>%
          httr::content(as = "text", encoding = "UTF-8")

        conf_items <- resp %>%
          jsonlite::fromJSON() %>%
          purrr::pluck("items") %>%
          data.frame() %>%
          dplyr::rename("href" = "X.ref") %>%
          dplyr::mutate(
            conference_url = x,
            group_id = as.integer(stringr::str_extract(x, "(?<=groups\\/)\\d+")),
            team_id = as.integer(stringr::str_extract(.data$href, "(?<=teams\\/)\\d+"))
          )
        return(conf_items)
      })

      teams <- teams %>%
        dplyr::left_join(conference_teams, by = c("team_id" = "team_id")) %>%
        dplyr::left_join(conferences, by = c("group_id" = "group_id")) %>%
        dplyr::mutate(
          team_id = as.integer(.data$team_id),
          parent_group_id = as.integer(.data$parent_group_id)) %>%
        make_hoopR_data("ESPN MBB Teams Information from ESPN.com", Sys.time())

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

#' **Parse ESPN schedule, helper function**
#'
#' @param group The ESPN conference group. Most helpful ones:
#' * 50 - Regular season/NIT
#' * 55 - CBI
#' * 56 - CIT
#' * 100 - NCAA Tournament
#' @param season_dates Either numeric or character
#' @return Returns a tibble
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom glue glue
#' @importFrom lubridate with_tz ymd_hm
#' @import rvest
#' @noRd
parse_espn_mbb_scoreboard <- function(group, season_dates) {
  schedule_api <-
    glue::glue(
      "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?groups={group}&limit=1000&dates={season_dates}"
    )


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

      mbb_data <- raw_sched[["events"]] %>%
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
        tidyr::hoist("status",
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

      mbb_data <- mbb_data %>%
        dplyr::mutate(
          game_date_time = lubridate::ymd_hm(substr(.data$game_date, 1, nchar(.data$game_date) - 1)) %>%
            lubridate::with_tz(tzone = "America/New_York"),
          game_date = as.Date(substr(.data$game_date_time, 1, 10)))

      mbb_data <- mbb_data %>%
        tidyr::hoist(
          "competitors",
          homeAway = list(1,"homeAway"))

      mbb_data <- mbb_data %>%
        tidyr::hoist(
          "competitors",
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


      mbb_data <- mbb_data %>%
        dplyr::mutate(
          home_team_name = ifelse(.data$homeAway == "home",.data$team1_team_name, .data$team2_team_name),
          home_team_logo = ifelse(.data$homeAway == "home",.data$team1_team_logo, .data$team2_team_logo),
          home_team_abb = ifelse(.data$homeAway == "home",.data$team1_team_abb, .data$team2_team_abb),
          home_team_id = ifelse(.data$homeAway == "home",.data$team1_team_id, .data$team2_team_id),
          home_team_location = ifelse(.data$homeAway == "home",.data$team1_team_location, .data$team2_team_location),
          home_team_full_name = ifelse(.data$homeAway == "home",.data$team1_team_full, .data$team2_team_full),
          home_team_color = ifelse(.data$homeAway == "home",.data$team1_team_color, .data$team2_team_color),
          home_score = ifelse(.data$homeAway == "home",.data$team1_score, .data$team2_score),
          home_win = ifelse(.data$homeAway == "home",.data$team1_win, .data$team2_win),
          home_record = ifelse(.data$homeAway == "home",.data$team1_record, .data$team2_record),
          away_team_name = ifelse(.data$homeAway == "away",.data$team1_team_name, .data$team2_team_name),
          away_team_logo = ifelse(.data$homeAway == "away",.data$team1_team_logo, .data$team2_team_logo),
          away_team_abb = ifelse(.data$homeAway == "away",.data$team1_team_abb, .data$team2_team_abb),
          away_team_id = ifelse(.data$homeAway == "away",.data$team1_team_id, .data$team2_team_id),
          away_team_location = ifelse(.data$homeAway == "away",.data$team1_team_location, .data$team2_team_location),
          away_team_full_name = ifelse(.data$homeAway == "away",.data$team1_team_full, .data$team2_team_full),
          away_team_color = ifelse(.data$homeAway == "away",.data$team1_team_color, .data$team2_team_color),
          away_score = ifelse(.data$homeAway == "away",.data$team1_score, .data$team2_score),
          away_win = ifelse(.data$homeAway == "away",.data$team1_win, .data$team2_win),
          away_record = ifelse(.data$homeAway == "away",.data$team1_record, .data$team2_record)
        )

      mbb_data <- mbb_data %>%
        dplyr::mutate_at(c(
          "game_id",
          "home_team_id",
          "home_win",
          "away_team_id",
          "away_win",
          "home_score",
          "away_score"), as.integer)
      mbb_data <- mbb_data %>%
        dplyr::select(-dplyr::any_of(dplyr::starts_with("team1")),
                      -dplyr::any_of(dplyr::starts_with("team2")),
                      -dplyr::any_of(c("homeAway")))

      if ("leaders" %in% names(mbb_data)) {
        schedule_out <- mbb_data %>%
          tidyr::hoist(
            "leaders",
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
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!dplyr::where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com",Sys.time())
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com",Sys.time())
        }
      } else {

        if ("broadcasts" %in% names(mbb_data) && !any(is.na(mbb_data[['broadcasts']]))) {
          mbb_data %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!dplyr::where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com",Sys.time())
        } else {
          mbb_data %>%
            dplyr::select(!dplyr::where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com",Sys.time())
        }
      }

    },
    error = function(e) {

    },
    warning = function(w) {

    },
    finally = {

    }
  )
}

#' **Get ESPN men's college basketball schedule for a specific year**
#'
#' @param season Either numeric or character
#' @return Returns a tibble
#'
#'    |col_name            |types     |
#'    |:-------------------|:---------|
#'    |matchup             |character |
#'    |matchup_short       |character |
#'    |season              |integer   |
#'    |season_type         |integer   |
#'    |season_slug         |character |
#'    |game_id             |integer   |
#'    |game_uid            |character |
#'    |game_date           |Date      |
#'    |attendance          |integer   |
#'    |status_name         |character |
#'    |broadcast_market    |character |
#'    |broadcast_name      |character |
#'    |start_date          |character |
#'    |game_date_time      |POSIXct   |
#'    |home_team_name      |character |
#'    |home_team_logo      |character |
#'    |home_team_abb       |character |
#'    |home_team_id        |integer   |
#'    |home_team_location  |character |
#'    |home_team_full_name |character |
#'    |home_team_color     |character |
#'    |home_score          |integer   |
#'    |home_win            |integer   |
#'    |home_record         |character |
#'    |away_team_name      |character |
#'    |away_team_logo      |character |
#'    |away_team_abb       |character |
#'    |away_team_id        |integer   |
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
#' @importFrom purrr map2_dfr possibly quietly
#' @import rvest
#' @export
#' @family ESPN MBB Functions
#' @examples
#'
#' # Get schedule from date 2022-11-17
#' \donttest{
#'   try(espn_mbb_scoreboard (season = "20221117"))
#' }

espn_mbb_scoreboard <- function(season) {

  max_year <- substr(Sys.Date(), 1, 4)

  if (!(as.integer(substr(season, 1, 4)) > 2001)) {
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  # check for regular and postseason games

  scoreboard_df <-
    purrr::map2_dfr(c("56", "55", "50", "100"),
                    rep(season, 4),
                    parse_espn_mbb_scoreboard)

  if (!nrow(scoreboard_df)) {
    message(glue::glue(
      "{Sys.time()}: Invalid arguments or no scoreboard data available!"
    ))
  }
  return(scoreboard_df)
}

#' **Get men's college basketball AP and Coaches Poll rankings from ESPN**
#'
#' @author Saiem Gilani
#' @return Returns a tibble
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |id                       |integer   |
#'    |name                     |character |
#'    |short_name               |character |
#'    |type                     |character |
#'    |headline                 |character |
#'    |short_headline           |character |
#'    |current                  |integer   |
#'    |previous                 |integer   |
#'    |points                   |numeric   |
#'    |first_place_votes        |integer   |
#'    |trend                    |character |
#'    |date                     |character |
#'    |last_updated             |character |
#'    |record_summary           |character |
#'    |team_id                  |integer   |
#'    |team_uid                 |character |
#'    |team_location            |character |
#'    |team_name                |character |
#'    |team_nickname            |character |
#'    |team_abbreviation        |character |
#'    |team_color               |character |
#'    |team_logo                |character |
#'    |occurrence_number        |integer   |
#'    |occurrence_type          |character |
#'    |occurrence_last          |logical   |
#'    |occurrence_value         |character |
#'    |occurrence_display_value |character |
#'    |season_year              |integer   |
#'    |season_start_date        |character |
#'    |season_end_date          |character |
#'    |season_display_name      |character |
#'    |season_type_type         |integer   |
#'    |season_type_name         |character |
#'    |season_type_abbreviation |character |
#'    |season_futures_ref       |character |
#'    |first_occurrence_type    |character |
#'    |first_occurrence_value   |character |
#'
#' @importFrom dplyr %>%  bind_rows arrange
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest
#' @export
#' @family ESPN MBB Functions
#' @examples
#' # Get current AP and Coaches Poll rankings
#' \donttest{
#'   try(espn_mbb_rankings())
#' }

espn_mbb_rankings <- function() {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  ranks_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/rankings?groups=50"


  tryCatch(
    expr = {
      res <- httr::RETRY("GET", ranks_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")
      ranks_df <- jsonlite::fromJSON(resp, flatten = TRUE)[['rankings']]
      ranks_top25 <- ranks_df %>%
        tidyr::unnest("ranks", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated")
      ranks_others <- ranks_df %>%
        tidyr::unnest("others", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated")
      ranks_dropped_out <- ranks_df %>%
        tidyr::unnest("droppedOut", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated")

      ranks <-
        dplyr::bind_rows(ranks_top25, ranks_others, ranks_dropped_out)
      drop_cols <- c(
        "$ref",
        "team.links",
        "season.powerIndexes.$ref",
        "season.powerIndexLeaders.$ref",
        "season.athletes.$ref",
        "season.leaders.$ref",
        "season.powerIndexLeaders.$ref",
        "others",
        "droppedOut",
        "ranks"
      )
      ranks <- ranks  %>%
        dplyr::select(-dplyr::any_of(drop_cols))
      ranks <-
        ranks %>% dplyr::arrange(.data$name, -.data$points) %>%
        janitor::clean_names() %>%
        dplyr::mutate_at(c(
          "id",
          "team_id"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Rankings Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue(
        "{Sys.time()}: Invalid arguments or no rankings data available!"
      ))
    },
    warning = function(w) {

    },
    finally = {

    }
  )

  return(ranks)
}


#' **Get ESPN men's college basketball standings**
#'
#' @param year Either numeric or character (YYYY)
#' @return A standings data frame
#'
#'    |col_name                          |types     |
#'    |:---------------------------------|:---------|
#'    |team_id                           |integer   |
#'    |team                              |character |
#'    |avgpointsagainst                  |numeric   |
#'    |avgpointsfor                      |numeric   |
#'    |gamesbehind                       |numeric   |
#'    |leaguewinpercent                  |numeric   |
#'    |losses                            |numeric   |
#'    |playoffseed                       |numeric   |
#'    |pointsagainst                     |numeric   |
#'    |pointsfor                         |numeric   |
#'    |streak                            |numeric   |
#'    |winpercent                        |numeric   |
#'    |wins                              |numeric   |
#'    |total                             |character |
#'    |home_avgpointsagainst             |numeric   |
#'    |home_avgpointsfor                 |numeric   |
#'    |home_gamesbehind                  |numeric   |
#'    |home_leaguewinpercent             |numeric   |
#'    |home_losses                       |numeric   |
#'    |home_playoffseed                  |numeric   |
#'    |home_pointsagainst                |numeric   |
#'    |home_pointsfor                    |numeric   |
#'    |home_streak                       |numeric   |
#'    |home_winpercent                   |numeric   |
#'    |home_wins                         |numeric   |
#'    |home                              |character |
#'    |road_avgpointsagainst             |numeric   |
#'    |road_avgpointsfor                 |numeric   |
#'    |road_gamesbehind                  |numeric   |
#'    |road_leaguewinpercent             |numeric   |
#'    |road_losses                       |numeric   |
#'    |road_playoffseed                  |numeric   |
#'    |road_pointsagainst                |numeric   |
#'    |road_pointsfor                    |numeric   |
#'    |road_streak                       |numeric   |
#'    |road_winpercent                   |numeric   |
#'    |road_wins                         |numeric   |
#'    |road                              |character |
#'    |vsaprankedteams_avgpointsagainst  |numeric   |
#'    |vsaprankedteams_avgpointsfor      |numeric   |
#'    |vsaprankedteams_gamesbehind       |numeric   |
#'    |vsaprankedteams_leaguewinpercent  |numeric   |
#'    |vsaprankedteams_losses            |numeric   |
#'    |vsaprankedteams_playoffseed       |numeric   |
#'    |vsaprankedteams_pointsagainst     |numeric   |
#'    |vsaprankedteams_pointsfor         |numeric   |
#'    |vsaprankedteams_streak            |numeric   |
#'    |vsaprankedteams_winpercent        |numeric   |
#'    |vsaprankedteams_wins              |numeric   |
#'    |vsaprankedteams                   |character |
#'    |vsusarankedteams_avgpointsagainst |numeric   |
#'    |vsusarankedteams_avgpointsfor     |numeric   |
#'    |vsusarankedteams_gamesbehind      |numeric   |
#'    |vsusarankedteams_leaguewinpercent |numeric   |
#'    |vsusarankedteams_losses           |numeric   |
#'    |vsusarankedteams_playoffseed      |numeric   |
#'    |vsusarankedteams_pointsagainst    |numeric   |
#'    |vsusarankedteams_pointsfor        |numeric   |
#'    |vsusarankedteams_streak           |numeric   |
#'    |vsusarankedteams_winpercent       |numeric   |
#'    |vsusarankedteams_wins             |numeric   |
#'    |vsusarankedteams                  |character |
#'    |vsconf_avgpointsagainst           |numeric   |
#'    |vsconf_avgpointsfor               |numeric   |
#'    |vsconf_gamesbehind                |numeric   |
#'    |vsconf_leaguewinpercent           |numeric   |
#'    |vsconf_losses                     |numeric   |
#'    |vsconf_playoffseed                |numeric   |
#'    |vsconf_pointsagainst              |numeric   |
#'    |vsconf_pointsfor                  |numeric   |
#'    |vsconf_streak                     |numeric   |
#'    |vsconf_winpercent                 |numeric   |
#'    |vsconf_wins                       |numeric   |
#'    |vsconf                            |character |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @export
#' @keywords MBB Standings
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   try(espn_mbb_standings(2021))
#' }
espn_mbb_standings <- function(year = most_recent_mbb_season()) {
  standings_url <-
    "https://site.web.api.espn.com/apis/v2/sports/basketball/mens-college-basketball/standings?region=us&lang=en&contentorigin=espn&type=0&level=1&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

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

      raw_resp <- resp %>%
        jsonlite::fromJSON()

      raw_standings <- raw_resp %>%
        purrr::pluck("standings")
      #Create a dataframe of all NBA teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]

      teams <- teams %>%
        dplyr::select(
          "id",
          "displayName") %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName")

      #creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <-
        data.table::rbindlist(standings_df, fill = TRUE, idcol = T)

      #Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <-
        ifelse(
          is.na(standings_data$value) &
            !is.na(standings_data$summary),
          standings_data$summary,
          standings_data$value
        )

      standings_data <- standings_data %>%
        dplyr::select(
          ".id",
          "type",
          "value")

      #Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(
          names_from = "type",
          values_from = "value")


      standings_data <- standings_data %>%
        dplyr::select(-".id")

      #joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id))

      standings <- standings %>%
        dplyr::mutate_at(c(
          "avgpointsagainst",
          "avgpointsfor",
          "gamesbehind",
          "leaguewinpercent",
          "losses",
          "playoffseed",
          "pointsagainst",
          "pointsfor",
          "streak",
          "winpercent",
          "wins",
          "home_avgpointsagainst",
          "home_avgpointsfor",
          "home_gamesbehind",
          "home_leaguewinpercent",
          "home_losses",
          "home_playoffseed",
          "home_pointsagainst",
          "home_pointsfor",
          "home_streak",
          "home_winpercent",
          "home_wins",
          "road_avgpointsagainst",
          "road_avgpointsfor",
          "road_gamesbehind",
          "road_leaguewinpercent",
          "road_losses",
          "road_playoffseed",
          "road_pointsagainst",
          "road_pointsfor",
          "road_streak",
          "road_winpercent",
          "road_wins",
          "vsaprankedteams_avgpointsagainst",
          "vsaprankedteams_avgpointsfor",
          "vsaprankedteams_gamesbehind",
          "vsaprankedteams_leaguewinpercent",
          "vsaprankedteams_losses",
          "vsaprankedteams_playoffseed",
          "vsaprankedteams_pointsagainst",
          "vsaprankedteams_pointsfor",
          "vsaprankedteams_streak",
          "vsaprankedteams_winpercent",
          "vsaprankedteams_wins",
          "vsusarankedteams_avgpointsagainst",
          "vsusarankedteams_avgpointsfor",
          "vsusarankedteams_gamesbehind",
          "vsusarankedteams_leaguewinpercent",
          "vsusarankedteams_losses",
          "vsusarankedteams_playoffseed",
          "vsusarankedteams_pointsagainst",
          "vsusarankedteams_pointsfor",
          "vsusarankedteams_streak",
          "vsusarankedteams_winpercent",
          "vsusarankedteams_wins",
          "vsconf_avgpointsagainst",
          "vsconf_avgpointsfor",
          "vsconf_gamesbehind",
          "vsconf_leaguewinpercent",
          "vsconf_losses",
          "vsconf_playoffseed",
          "vsconf_pointsagainst",
          "vsconf_pointsfor",
          "vsconf_streak",
          "vsconf_winpercent",
          "vsconf_wins"
        ), as.numeric) %>%
        make_hoopR_data("ESPN MBB Standings Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue(
        "{Sys.time()}: Invalid arguments or no standings data available!"
      ))
    },
    warning = function(w) {

    },
    finally = {

    }

  )
  return(standings)
}


#' **Get ESPN MBB's Betting information**
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
#'    |over_under                           |numeric   |
#'    |spread                               |numeric   |
#'    |provider_id                          |integer   |
#'    |provider_name                        |character |
#'    |provider_priority                    |integer   |
#'    |away_team_odds_favorite              |logical   |
#'    |away_team_odds_underdog              |logical   |
#'    |away_team_odds_money_line            |integer   |
#'    |away_team_odds_spread_odds           |numeric   |
#'    |away_team_odds_team_id               |integer   |
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
#'    |home_team_odds_team_id               |integer   |
#'    |home_team_odds_win_percentage        |numeric   |
#'    |home_team_odds_average_score         |numeric   |
#'    |home_team_odds_money_line_odds       |numeric   |
#'    |home_team_odds_spread_return         |numeric   |
#'    |home_team_odds_spread_record_wins    |integer   |
#'    |home_team_odds_spread_record_losses  |integer   |
#'    |home_team_odds_spread_record_pushes  |integer   |
#'    |home_team_odds_spread_record_summary |character |
#'    |game_id                              |integer   |
#'
#'    **againstTheSpread**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |id           |integer   |
#'    |uid          |character |
#'    |display_name |character |
#'    |abbreviation |character |
#'    |logo         |character |
#'    |logos        |list      |
#'    |records      |list      |
#'    |game_id      |integer   |
#'    |team_id      |integer   |
#'
#'    **predictor**
#'
#'
#'    |col_name                  |types   |
#'    |:-------------------------|:-------|
#'    |game_id                   |integer |
#'    |home_team_id              |integer |
#'    |away_team_id              |integer |
#'    |away_team_game_projection |numeric |
#'    |away_team_chance_loss     |numeric |
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @keywords MBB Betting
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   try(espn_mbb_betting(game_id = 401256760))
#' }
espn_mbb_betting <- function(game_id) {
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()
  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      raw_summary <- jsonlite::fromJSON(resp)
      if ("pickcenter" %in% names(raw_summary)) {
        pickcenter <-
          jsonlite::fromJSON(jsonlite::toJSON(raw_summary$pickcenter), flatten =
                               TRUE) %>%
          janitor::clean_names() %>%
          dplyr::select(-"links") %>%
          dplyr::mutate(game_id = as.integer(game_id)) %>%
          dplyr::mutate_at(c(
            "provider_id",
            "away_team_odds_team_id",
            "home_team_odds_team_id"), as.integer) %>%
          make_hoopR_data("ESPN MBB Pickcenter Information from ESPN.com",Sys.time())
      }
      if ("againstTheSpread" %in% names(raw_summary)) {
        againstTheSpread <-
          jsonlite::fromJSON(jsonlite::toJSON(raw_summary$againstTheSpread)) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-"links") %>%
          janitor::clean_names()
        records <- againstTheSpread$records

        teams$records <- records
        againstTheSpread <- teams %>%
          dplyr::mutate(
            game_id = as.integer(game_id),
            id = as.integer(.data$id),
            team_id = as.integer(.data$id)) %>%
          make_hoopR_data("ESPN MBB Against the Spread Information from ESPN.com",Sys.time())
      }
      if ("predictor" %in% names(raw_summary)) {
        predictor_df <- data.frame(
          game_id = as.integer(game_id),
          home_team_id =  as.integer(raw_summary$predictor$homeTeam$id),
          away_team_id =  as.integer(raw_summary$predictor$awayTeam$id),
          away_team_game_projection = as.numeric(raw_summary$predictor$awayTeam$gameProjection),
          away_team_chance_loss = as.numeric(raw_summary$predictor$awayTeam$teamChanceLoss)
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data("ESPN MBB Predictor Information from ESPN.com",Sys.time())
      }
    },
    error = function(e) {
      message(glue::glue(
        "{Sys.time()}: Invalid arguments or no betting data available!"
      ))
    },
    warning = function(w) {

    },
    finally = {

    }

  )
  betting <-
    c(list(pickcenter),
      list(againstTheSpread),
      list(predictor_df))
  names(betting) <-
    c("pickcenter", "againstTheSpread", "predictor")
  return(betting)
}


#' @title
#' **Get ESPN men's college basketball team stats data**
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the team stats data
#'
#'    |col_name                                        |types     |
#'    |:-----------------------------------------------|:---------|
#'    |team_id                                         |character |
#'    |team_guid                                       |character |
#'    |team_uid                                        |character |
#'    |team_sdr                                        |character |
#'    |team_slug                                       |character |
#'    |team_location                                   |character |
#'    |team_name                                       |character |
#'    |team_nickname                                   |character |
#'    |team_abbreviation                               |character |
#'    |team_display_name                               |character |
#'    |team_short_display_name                         |character |
#'    |team_color                                      |character |
#'    |team_alternate_color                            |character |
#'    |is_active                                       |logical   |
#'    |is_all_star                                     |logical   |
#'    |logo_href                                       |character |
#'    |logo_dark_href                                  |character |
#'    |defensive_blocks                                |numeric   |
#'    |defensive_defensive_rebounds                    |numeric   |
#'    |defensive_steals                                |numeric   |
#'    |defensive_turnover_points                       |numeric   |
#'    |defensive_avg_defensive_rebounds                |numeric   |
#'    |defensive_avg_blocks                            |numeric   |
#'    |defensive_avg_steals                            |numeric   |
#'    |general_disqualifications                       |numeric   |
#'    |general_flagrant_fouls                          |numeric   |
#'    |general_fouls                                   |numeric   |
#'    |general_ejections                               |numeric   |
#'    |general_technical_fouls                         |numeric   |
#'    |general_rebounds                                |numeric   |
#'    |general_minutes                                 |numeric   |
#'    |general_avg_minutes                             |numeric   |
#'    |general_fantasy_rating                          |numeric   |
#'    |general_avg_rebounds                            |numeric   |
#'    |general_avg_fouls                               |numeric   |
#'    |general_avg_flagrant_fouls                      |numeric   |
#'    |general_avg_technical_fouls                     |numeric   |
#'    |general_avg_ejections                           |numeric   |
#'    |general_avg_disqualifications                   |numeric   |
#'    |general_assist_turnover_ratio                   |numeric   |
#'    |general_steal_foul_ratio                        |numeric   |
#'    |general_block_foul_ratio                        |numeric   |
#'    |general_avg_team_rebounds                       |numeric   |
#'    |general_total_rebounds                          |numeric   |
#'    |general_total_technical_fouls                   |numeric   |
#'    |general_team_assist_turnover_ratio              |numeric   |
#'    |general_team_rebounds                           |numeric   |
#'    |general_steal_turnover_ratio                    |numeric   |
#'    |general_games_played                            |numeric   |
#'    |general_games_started                           |numeric   |
#'    |general_double_double                           |numeric   |
#'    |general_triple_double                           |numeric   |
#'    |offensive_assists                               |numeric   |
#'    |offensive_field_goals                           |numeric   |
#'    |offensive_field_goals_attempted                 |numeric   |
#'    |offensive_field_goals_made                      |numeric   |
#'    |offensive_field_goal_pct                        |numeric   |
#'    |offensive_free_throws                           |numeric   |
#'    |offensive_free_throw_pct                        |numeric   |
#'    |offensive_free_throws_attempted                 |numeric   |
#'    |offensive_free_throws_made                      |numeric   |
#'    |offensive_offensive_rebounds                    |numeric   |
#'    |offensive_points                                |numeric   |
#'    |offensive_turnovers                             |numeric   |
#'    |offensive_three_point_field_goals_attempted     |numeric   |
#'    |offensive_three_point_field_goals_made          |numeric   |
#'    |offensive_team_turnovers                        |numeric   |
#'    |offensive_total_turnovers                       |numeric   |
#'    |offensive_fast_break_points                     |numeric   |
#'    |offensive_avg_field_goals_made                  |numeric   |
#'    |offensive_avg_field_goals_attempted             |numeric   |
#'    |offensive_avg_three_point_field_goals_made      |numeric   |
#'    |offensive_avg_three_point_field_goals_attempted |numeric   |
#'    |offensive_avg_free_throws_made                  |numeric   |
#'    |offensive_avg_free_throws_attempted             |numeric   |
#'    |offensive_avg_points                            |numeric   |
#'    |offensive_avg_offensive_rebounds                |numeric   |
#'    |offensive_avg_assists                           |numeric   |
#'    |offensive_avg_turnovers                         |numeric   |
#'    |offensive_offensive_rebound_pct                 |numeric   |
#'    |offensive_estimated_possessions                 |numeric   |
#'    |offensive_avg_estimated_possessions             |numeric   |
#'    |offensive_points_per_estimated_possessions      |numeric   |
#'    |offensive_avg_team_turnovers                    |numeric   |
#'    |offensive_avg_total_turnovers                   |numeric   |
#'    |offensive_three_point_field_goal_pct            |numeric   |
#'    |offensive_two_point_field_goals_made            |numeric   |
#'    |offensive_two_point_field_goals_attempted       |numeric   |
#'    |offensive_avg_two_point_field_goals_made        |numeric   |
#'    |offensive_avg_two_point_field_goals_attempted   |numeric   |
#'    |offensive_two_point_field_goal_pct              |numeric   |
#'    |offensive_shooting_efficiency                   |numeric   |
#'    |offensive_scoring_efficiency                    |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @keywords MBB Team Stats
#' @family ESPN MBB Functions
#'
#' @examples
#' \donttest{
#'   try(espn_mbb_team_stats(team_id = 52, year = 2020))
#' }

espn_mbb_team_stats <- function(team_id, year, season_type='regular', total=FALSE){
  if (!(tolower(season_type) %in% c("regular","postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/"

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
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(names_from = "stats_category_name",
                           values_from = "stats_value",
                           values_fn = dplyr::first) %>%
        janitor::clean_names()
      df <- team_df %>%
        dplyr::bind_cols(df)
      df <- df %>%
        dplyr::mutate_at(c(
          "team_id",
          "team_sdr"), as.integer) %>%
        make_hoopR_data("ESPN MBB Team Season Stats from ESPN.com",Sys.time())

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
#' **Get ESPN men's college basketball player stats data**
#' @author Saiem Gilani
#' @param athlete_id Athlete ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the player stats data
#'
#'    |col_name                                        |types     |
#'    |:-----------------------------------------------|:---------|
#'    |athlete_id                                      |integer   |
#'    |athlete_uid                                     |character |
#'    |athlete_guid                                    |character |
#'    |athlete_type                                    |character |
#'    |sdr                                             |integer   |
#'    |first_name                                      |character |
#'    |last_name                                       |character |
#'    |full_name                                       |character |
#'    |display_name                                    |character |
#'    |short_name                                      |character |
#'    |weight                                          |numeric   |
#'    |display_weight                                  |character |
#'    |height                                          |numeric   |
#'    |display_height                                  |character |
#'    |age                                             |integer   |
#'    |date_of_birth                                   |character |
#'    |birth_place_city                                |character |
#'    |birth_place_state                               |character |
#'    |birth_place_country                             |character |
#'    |slug                                            |character |
#'    |headshot_href                                   |character |
#'    |headshot_alt                                    |character |
#'    |jersey                                          |character |
#'    |position_id                                     |integer   |
#'    |position_name                                   |character |
#'    |position_display_name                           |character |
#'    |position_abbreviation                           |character |
#'    |position_leaf                                   |logical   |
#'    |linked                                          |logical   |
#'    |experience_years                                |integer   |
#'    |experience_display_value                        |character |
#'    |experience_abbreviation                         |character |
#'    |active                                          |logical   |
#'    |draft_display_text                              |character |
#'    |draft_round                                     |integer   |
#'    |draft_year                                      |integer   |
#'    |draft_selection                                 |integer   |
#'    |status_id                                       |integer   |
#'    |status_name                                     |character |
#'    |status_type                                     |character |
#'    |status_abbreviation                             |character |
#'    |defensive_blocks                                |numeric   |
#'    |defensive_defensive_rebounds                    |numeric   |
#'    |defensive_steals                                |numeric   |
#'    |defensive_turnover_points                       |numeric   |
#'    |defensive_avg_defensive_rebounds                |numeric   |
#'    |defensive_avg_blocks                            |numeric   |
#'    |defensive_avg_steals                            |numeric   |
#'    |general_disqualifications                       |numeric   |
#'    |general_flagrant_fouls                          |numeric   |
#'    |general_fouls                                   |numeric   |
#'    |general_per                                     |numeric   |
#'    |general_ejections                               |numeric   |
#'    |general_technical_fouls                         |numeric   |
#'    |general_rebounds                                |numeric   |
#'    |general_minutes                                 |numeric   |
#'    |general_avg_minutes                             |numeric   |
#'    |general_fantasy_rating                          |numeric   |
#'    |general_plus_minus                              |numeric   |
#'    |general_avg_rebounds                            |numeric   |
#'    |general_avg_fouls                               |numeric   |
#'    |general_avg_flagrant_fouls                      |numeric   |
#'    |general_avg_technical_fouls                     |numeric   |
#'    |general_avg_ejections                           |numeric   |
#'    |general_avg_disqualifications                   |numeric   |
#'    |general_assist_turnover_ratio                   |numeric   |
#'    |general_steal_foul_ratio                        |numeric   |
#'    |general_block_foul_ratio                        |numeric   |
#'    |general_avg_team_rebounds                       |numeric   |
#'    |general_total_rebounds                          |numeric   |
#'    |general_total_technical_fouls                   |numeric   |
#'    |general_steal_turnover_ratio                    |numeric   |
#'    |general_games_played                            |numeric   |
#'    |general_games_started                           |numeric   |
#'    |general_double_double                           |numeric   |
#'    |general_triple_double                           |numeric   |
#'    |offensive_assists                               |numeric   |
#'    |offensive_field_goals                           |numeric   |
#'    |offensive_field_goals_attempted                 |numeric   |
#'    |offensive_field_goals_made                      |numeric   |
#'    |offensive_field_goal_pct                        |numeric   |
#'    |offensive_free_throws                           |numeric   |
#'    |offensive_free_throw_pct                        |numeric   |
#'    |offensive_free_throws_attempted                 |numeric   |
#'    |offensive_free_throws_made                      |numeric   |
#'    |offensive_offensive_rebounds                    |numeric   |
#'    |offensive_points                                |numeric   |
#'    |offensive_turnovers                             |numeric   |
#'    |offensive_three_point_field_goals_attempted     |numeric   |
#'    |offensive_three_point_field_goals_made          |numeric   |
#'    |offensive_total_turnovers                       |numeric   |
#'    |offensive_points_in_paint                       |numeric   |
#'    |offensive_fast_break_points                     |numeric   |
#'    |offensive_avg_field_goals_made                  |numeric   |
#'    |offensive_avg_field_goals_attempted             |numeric   |
#'    |offensive_avg_three_point_field_goals_made      |numeric   |
#'    |offensive_avg_three_point_field_goals_attempted |numeric   |
#'    |offensive_avg_free_throws_made                  |numeric   |
#'    |offensive_avg_free_throws_attempted             |numeric   |
#'    |offensive_avg_points                            |numeric   |
#'    |offensive_avg_offensive_rebounds                |numeric   |
#'    |offensive_avg_assists                           |numeric   |
#'    |offensive_avg_turnovers                         |numeric   |
#'    |offensive_offensive_rebound_pct                 |numeric   |
#'    |offensive_estimated_possessions                 |numeric   |
#'    |offensive_avg_estimated_possessions             |numeric   |
#'    |offensive_points_per_estimated_possessions      |numeric   |
#'    |offensive_avg_team_turnovers                    |numeric   |
#'    |offensive_avg_total_turnovers                   |numeric   |
#'    |offensive_three_point_field_goal_pct            |numeric   |
#'    |offensive_two_point_field_goals_made            |numeric   |
#'    |offensive_two_point_field_goals_attempted       |numeric   |
#'    |offensive_avg_two_point_field_goals_made        |numeric   |
#'    |offensive_avg_two_point_field_goals_attempted   |numeric   |
#'    |offensive_two_point_field_goal_pct              |numeric   |
#'    |offensive_shooting_efficiency                   |numeric   |
#'    |offensive_scoring_efficiency                    |numeric   |
#'    |team_id                                         |integer   |
#'    |team_guid                                       |character |
#'    |team_uid                                        |character |
#'    |team_sdr                                        |integer   |
#'    |team_slug                                       |character |
#'    |team_location                                   |character |
#'    |team_name                                       |character |
#'    |team_nickname                                   |character |
#'    |team_abbreviation                               |character |
#'    |team_display_name                               |character |
#'    |team_short_display_name                         |character |
#'    |team_color                                      |character |
#'    |team_alternate_color                            |character |
#'    |is_active                                       |logical   |
#'    |is_all_star                                     |logical   |
#'    |logo_href                                       |character |
#'    |logo_dark_href                                  |character |
#'
#' @export
#' @keywords MBB Player Stats
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   try(espn_mbb_player_stats(athlete_id = 4433134, year = 2021))
#' }

espn_mbb_player_stats <- function(athlete_id, year, season_type='regular', total=FALSE){
  if (!(tolower(season_type) %in% c("regular","postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/"

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
        dplyr::select(
          "stats_category_name",
          "stats_value") %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first) %>%
        janitor::clean_names()
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        dplyr::mutate_at(c(
          "athlete_id",
          "team_id",
          "position_id",
          "status_id",
          "sdr",
          "team_sdr"), as.integer) %>%
        make_hoopR_data("ESPN MBB Player Season Stats from ESPN.com",Sys.time())

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

#'  **Parse ESPN MBB PBP, helper function**
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_mbb_pbp <- function(resp){

  game_json <- resp %>%
    jsonlite::fromJSON()

  pbp_source <- game_json[["header"]][["competitions"]][["playByPlaySource"]]

  plays <- game_json %>%
    purrr::pluck("plays") %>%
    dplyr::as_tibble()

  if (pbp_source != "none" && nrow(plays) > 10) {
    homeAway1 <- jsonlite::fromJSON(resp)[['header']][['competitions']][['competitors']][[1]][['homeAway']][1]

    gameId <- as.integer(game_json[["header"]][["id"]])
    season <- game_json[['header']][['season']][['year']]
    season_type <- game_json[['header']][['season']][['type']]
    game_date_time <- substr(game_json[['header']][['competitions']][['date']], 1,
                             nchar(game_json[['header']][['competitions']][['date']]) - 1) %>%
      lubridate::ymd_hm() %>%
      lubridate::with_tz(tzone = "America/New_York")

    game_date <- as.Date(substr(game_date_time, 0, 10))
    id_vars <- data.frame()
    if (homeAway1 == "home") {

      homeTeamId = as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']] %>%
                                purrr::pluck(1, .default = NA_integer_))
      homeTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']] %>%
                                   purrr::pluck(1, .default = NA_character_))
      homeTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamId = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['team']][['id']] %>%
                                purrr::pluck(2, .default = NA_integer_))
      awayTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']] %>%
                                   purrr::pluck(2, .default = NA_integer_))
      awayTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']] %>%
        purrr::pluck(2, .default = NA_character_)
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

      awayTeamId = as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']] %>%
                                purrr::pluck(1, .default = NA_integer_))
      awayTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']] %>%
                                   purrr::pluck(1, .default = NA_integer_))
      awayTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamId = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['team']][['id']] %>%
                                purrr::pluck(2, .default = NA_integer_))
      homeTeamMascot = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['name']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['location']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAbbrev = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogo = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogoDark = game_json[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAlternateColor = game_json[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamScore = as.integer(game_json[['header']][['competitions']][['competitors']][[1]][['score']] %>%
                                   purrr::pluck(2, .default = NA_integer_))
      homeTeamWinner = game_json[['header']][['competitions']][['competitors']][[1]][['winner']] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamRecord = game_json[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']] %>%
        purrr::pluck(2, .default = NA_character_)
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


    plays <- game_json %>%
      purrr::pluck("plays")

    if ("coordinate.x" %in% names(plays) & "coordinate.y" %in% names(plays)) {
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

    ## Written this way for compliance with data repository processing
    if ("participants" %in% names(plays)) {
      plays <- plays %>%
        tidyr::unnest_wider("participants")
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(
            "id",
            "athlete.id") %>%
          tidyr::unnest_wider("athlete.id", names_sep = "_")
      )
      names(aths) <- c("play.id", "athlete.id.1", "athlete.id.2")
      plays <- plays %>%
        dplyr::bind_cols(aths) %>%
        janitor::clean_names() %>%
        dplyr::mutate(dplyr::across(dplyr::any_of(c(
          "athlete_id_1",
          "athlete_id_2",
          "athlete_id_3"
        )), ~as.integer(.x)))
    }
    ## Written this way for compliance with data repository processing
    if (!("homeTeamName" %in% names(plays))) {
      plays <- plays %>%
        dplyr::bind_cols(id_vars)
    }

    plays <- plays %>%
      dplyr::select(-dplyr::any_of(c("athlete.id", "athlete_id")))  %>%
      janitor::clean_names() %>%
      dplyr::mutate(
        game_id = gameId,
        season = season,
        season_type = season_type,
        game_date = game_date,
        game_date_time = game_date_time) %>%
      dplyr::rename(dplyr::any_of(c(
        "athlete_id_1" = "participants_0_athlete_id",
        "athlete_id_2" = "participants_1_athlete_id",
        "athlete_id_3" = "participants_2_athlete_id")))

    plays <- plays %>%
      dplyr::mutate(dplyr::across(dplyr::any_of(c(
        "athlete_id_1",
        "athlete_id_2",
        "athlete_id_3",
        "type_id",
        "team_id"
      )), ~as.integer(.x)))

    plays_df <- plays %>%
      make_hoopR_data("ESPN MBB Play-by-Play Information from ESPN.com", Sys.time())

    return(plays_df)
  }
}

#'  **Parse ESPN MBB Team Box, helper function**
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_mbb_team_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  gameId <- as.integer(game_json[["header"]][["id"]])
  game_date_time <- substr(game_json[['header']][['competitions']][['date']], 1,
                           nchar(game_json[['header']][['competitions']][['date']]) - 1) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))
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
      statistics_df_1$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )

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
      statistics_df_2$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )

      complete_statistics_df <- statistics_df_1 %>%
        dplyr::bind_rows(statistics_df_2)

      # Assigning game/season level data to team box score and converting types
      complete_statistics_df$season <- game_json[["header"]][["season"]][["year"]]
      complete_statistics_df$season_type <- game_json[["header"]][["season"]][["type"]]
      complete_statistics_df$game_date <- game_date
      complete_statistics_df$game_date_time <- game_date_time
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
          "game_date_time",
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
        make_hoopR_data("ESPN MBB Team Box Information from ESPN.com", Sys.time())

      return(team_box_score)
    }
  }
}

#'  **Parse ESPN MBB Player Box, helper function**
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_mbb_player_box <- function(resp){
  game_json <- resp %>%
    jsonlite::fromJSON(flatten = TRUE)

  players_box_score_df <- game_json[["boxscore"]][["players"]] %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as.data.frame()

  gameId <- as.integer(game_json[["header"]][["id"]])
  season <- game_json[["header"]][["season"]][["year"]]
  season_type <- game_json[["header"]][["season"]][["type"]]
  game_date_time <- substr(game_json[['header']][['competitions']][['date']], 1,
                           nchar(game_json[['header']][['competitions']][['date']]) - 1) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))

  boxScoreAvailable <- game_json[["header"]][["competitions"]][["boxscoreAvailable"]]

  boxScoreSource <- game_json[["header"]][["competitions"]][["boxscoreSource"]]

  valid_stats <- players_box_score_df %>%
    tidyr::unnest("statistics")

  valid_athletes <- is.data.frame(valid_stats[["athletes"]][[1]]) && is.data.frame(valid_stats[["athletes"]][[2]])
  # This is checking if  [[athletes]][[1]]'s stat rebounds is able to be converted to a numeric value
  #  without introducing NA's
  suppressWarnings(
    valid_stats <- players_box_score_df[["statistics"]][[1]][["athletes"]][[1]][["stats"]][[1]] %>%
      purrr::pluck(7) %>%
      as.numeric()
  )
  if (boxScoreAvailable == TRUE &&
      length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]]) > 1 &&
      length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]][["stats"]][[1]]) > 1 &&
      valid_athletes &&
      !is.na(valid_stats)) {

    players_df <- players_box_score_df %>%
      tidyr::unnest("statistics") %>%
      tidyr::unnest("athletes")

    if (length(players_box_score_df[["statistics"]]) > 1 &&
        length(players_df$stats[[1]] > 0)) {

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
          game_date = game_date,
          game_date_time = game_date_time)


      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.id <- as.integer(teams_df[["id"]] %>%
                                        purrr::pluck(1, .default = NA_integer_))
      homeAway1_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.logos <- teams_df[["team.logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.score <- as.integer(teams_df[["score"]] %>%
                                           purrr::pluck(1, .default = NA_integer_))

      homeAway2 <- teams_df[["homeAway"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.id <- as.integer(teams_df[["id"]] %>%
                                        purrr::pluck(2, .default = NA_integer_))
      homeAway2_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.logos <- teams_df[["team.logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway2_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.score <- as.integer(teams_df[["score"]] %>%
                                           purrr::pluck(2, .default = NA_integer_))

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
          "game_date_time",
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
        dplyr::mutate_at(c(
          "athlete_id",
          "team_id",
          "team_score",
          "opponent_team_score"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Player Box Information from ESPN.com", Sys.time())

      return(player_box_score)
    }
  }
}

