
#' **Get NBA Stats API play-by-play**
#' @name pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname pbp
#' @author Jason Lee
#' @param game_id Game ID
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param p Progress bar
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_pbp <- function(
    game_id,
    version = "v2",
    p,
    ...){


  if(version == "v2"){
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0&",
                     "GameID=", pad_id(game_id),
                     "&StartPeriod=0")

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      # if (return_message) {
      #   glue::glue("Getting play by play for game {game_id}") %>% cat(fill = T)
      # }

      data <-
        resp$resultSets$rowSet[[1]] %>%
        data.frame(stringsAsFactors = F) %>%
        as_tibble()

      json_names <-
        resp$resultSets$headers[[1]]
      colnames(data) <- json_names

      # Fix version 2 Dataset
      if (version == "v2") {
        data <- data %>%
          # fix column names
          janitor::clean_names() %>%
          dplyr::rename(
            "wc_time_string" = "wctimestring",
            "time_quarter" = "pctimestring",
            "score_margin" = "scoremargin",
            "even_num" = "eventnum",
            "event_msg_type" = "eventmsgtype",
            "event_msg_action_type" = "eventmsgactiontype",
            "home_description" = "homedescription",
            "neutral_description" = "neutraldescription",
            "visitor_description" = "visitordescription"
          ) %>%
          ## Get Team Scores
          tidyr::separate(
            "score",
            into = c("away_score", "home_score"),
            sep = "\\ - ",
            remove = FALSE
          ) %>%
          dplyr::mutate(
            home_score = as.numeric(.data$home_score),
            away_score = as.numeric(.data$away_score),
            team_leading = dplyr::case_when(
              .data$score_margin == 0 ~ "Tie",
              .data$score_margin < 0 ~ "Away",
              is.na(.data$score_margin) ~ NA_character_,
              TRUE ~ "Home"
            )
          ) %>%
          ## Time Remaining
          tidyr::separate(
            "time_quarter",
            into = c("minute_remaining_quarter", "seconds_remaining_quarter"),
            sep = "\\:",
            remove = F
          ) %>%
          dplyr::mutate(
            minute_remaining_quarter = as.numeric(.data$minute_remaining_quarter),
            seconds_remaining_quarter = as.numeric(.data$seconds_remaining_quarter),
            period = as.numeric(.data$period)
          ) %>%
          dplyr::mutate(
            minute_game = round(((.data$period - 1) * 12) + (12 - .data$minute_remaining_quarter) +
                                  (((
                                    60 - .data$seconds_remaining_quarter
                                  ) / 60) - 1), 2),
            time_remaining = 48 - round(((.data$period - 1) * 12) - (12 - .data$minute_remaining_quarter) -
                                          ((60 - .data$seconds_remaining_quarter) / 60 - 1), 2)
          ) %>%
          dplyr::select(
            "game_id":"period",
            "minute_game",
            "time_remaining",
            dplyr::everything()
          )
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}


#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @name pbps
NULL
#' @title
#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @rdname pbps
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param nest_data If TRUE returns nested data by game
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#' @export
nba_pbps <- function(
    game_ids = NULL,
    version = "v2",
    nest_data = FALSE,
    ...) {

  if (game_ids %>% purrr::is_null()) {
    stop("Please enter game ids")
  }


  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = game_ids)
  get_pbp_safe <- progressively(nba_pbp, p)


  all_data <-
    game_ids %>%
    purrr::map_dfr(function(game_id) {
      get_pbp_safe(game_id = game_id, ..., p = p)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(.data$game_id) %>%
      tidyr::nest()
  }

  return(all_data)
}



#' **Get NBA Stats API Season Schedule**
#' @name nba_stats_schedule
NULL
#' @title
#' **Get NBA Stats API Season Schedule**
#' @rdname nba_stats_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @return Returns a tibble with the following columns:
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |game_date          |character |
#'    |game_id            |character |
#'    |game_code          |character |
#'    |game_status        |integer   |
#'    |game_status_text   |character |
#'    |game_sequence      |integer   |
#'    |game_date_est      |character |
#'    |game_time_est      |character |
#'    |game_date_time_est |character |
#'    |game_date_utc      |character |
#'    |game_time_utc      |character |
#'    |game_date_time_utc |character |
#'    |away_team_time     |character |
#'    |home_team_time     |character |
#'    |day                |character |
#'    |month_num          |integer   |
#'    |week_number        |integer   |
#'    |week_name          |character |
#'    |if_necessary       |character |
#'    |series_game_number |character |
#'    |series_text        |character |
#'    |arena_name         |character |
#'    |arena_state        |character |
#'    |arena_city         |character |
#'    |postponed_status   |character |
#'    |branch_link        |character |
#'    |game_subtype       |character |
#'    |home_team_id       |integer   |
#'    |home_team_name     |character |
#'    |home_team_city     |character |
#'    |home_team_tricode  |character |
#'    |home_team_slug     |character |
#'    |home_team_wins     |integer   |
#'    |home_team_losses   |integer   |
#'    |home_team_score    |integer   |
#'    |home_team_seed     |integer   |
#'    |away_team_id       |integer   |
#'    |away_team_name     |character |
#'    |away_team_city     |character |
#'    |away_team_tricode  |character |
#'    |away_team_slug     |character |
#'    |away_team_wins     |integer   |
#'    |away_team_losses   |integer   |
#'    |away_team_score    |integer   |
#'    |away_team_seed     |integer   |
#'    |season             |character |
#'    |league_id          |character |
#'
#' @export
nba_schedule <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    ...){


  version <- "scheduleleaguev2"
  full_url <- nba_endpoint(version)
  params <- list(
    LeagueID = league_id,
    Season = season
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params, ...)

      league_sched <- resp %>%
        purrr::pluck("leagueSchedule")
      games <- league_sched %>%
        purrr::pluck("gameDates") %>%
        tidyr::unnest("games") %>%
        tidyr::unnest("awayTeam", names_sep = "_") %>%
        tidyr::unnest("homeTeam", names_sep = "_") %>%
        dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
        janitor::clean_names()
      colnames(games) <- gsub('team_team', 'team', colnames(games))
      games$game_id <- unlist(purrr::map(games$game_id,function(x){
        pad_id(x)
      }))
      games$season <- league_sched$seasonYear
      games$league_id <- league_sched$leagueId
      games <- games %>%
        dplyr::mutate(
          season_type_id = substr(.data$game_id, 3, 3),
          season_type_description = dplyr::case_when(
            .data$season_type_id == 1 ~ "Pre-Season",
            .data$season_type_id == 2 ~ "Regular Season",
            .data$season_type_id == 3 ~ "All-Star",
            .data$season_type_id == 4 ~ "Playoffs",
            .data$season_type_id == 5 ~ "Play-In Game"),
          game_date = lubridate::ymd(substring(.data$game_date,1,10)))

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league schedule data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}
