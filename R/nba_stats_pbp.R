
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
#' @return Returns a data frame: PlayByPlay
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_pbp <- function(game_id, version = "v2", p){

  p("loading...")
  if(version=="v2"){
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0&",
                     "GameID=",pad_id(game_id),
                     "&StartPeriod=0")

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
#' @return Returns a data frame: PlayByPlay
#' @export
nba_pbps <-function(game_ids = NULL,
                    version = "v2",
                    nest_data = FALSE) {

  if (game_ids %>% purrr::is_null()) {
    stop("Please enter game ids")
  }


  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = game_ids)
  get_pbp_safe <- progressively(nba_pbp, p)


  all_data <-
    game_ids %>%
    purrr::map_dfr(function(game_id) {
      get_pbp_safe(game_id = game_id, p = p)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(.data$game_id) %>%
      tidyr::nest()
  }

  return(all_data)
}


#' **Get NBA Stats API Schedule**
#' @name schedule
NULL
#' @title
#' **Get NBA Stats API Schedule**
#' @rdname schedule
#' @author Saiem Gilani
#' @param season Season - 4 digit integer corresponding to the first year in the season format 2020-21
#' @param league League - default: 'NBA'. Other options include 'all'
#' @return Returns a tibble
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @return A tibble with the following columns:
#'
#'  |col_name                |types     |
#'  |:-----------------------|:---------|
#'  |game_id                 |character |
#'  |season_type_id          |character |
#'  |season_type_description |character |
#'  |visitor_team_id         |character |
#'  |visitor_city            |character |
#'  |visitor_nickname        |character |
#'  |visitor_name_short      |character |
#'  |visitor_abbr            |character |
#'  |visitor_team_name_full  |character |
#'  |home_team_id            |character |
#'  |home_city               |character |
#'  |home_nickname           |character |
#'  |home_name_short         |character |
#'  |home_abbr               |character |
#'  |home_team_name_full     |character |
#'  |game_date               |Date      |
#'  |game_start_time         |character |
#'  |day                     |character |
#'
#' @details
#' ```
#'   nba_schedule(season = 1996, league = 'NBA')
#' ```
nba_schedule <- function(season = most_recent_nba_season()-1, league = 'NBA'){

  full_url <- glue::glue("https://stats.nba.com/stats/internationalbroadcasterschedule?LeagueID=00&Season={season}&RegionID=1")
  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  tryCatch(
    expr = {
      season_year <- hoopR::year_to_season(season)
      standings <- nba_leaguestandingsv3(season = season)$Standings
      teams <- standings %>%
        dplyr::select(c("LeagueID","SeasonID","TeamID", "TeamCity", "TeamName","TeamSlug","Conference","Division")) %>%
        dplyr::mutate(
          Season = paste0('',season),
          TeamNameFull = paste(.data$TeamCity,.data$TeamName)) %>%
        dplyr::arrange(.data$TeamNameFull)
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")


      data <- jsonlite::fromJSON(resp)[["resultSets"]]
      data <- data[["CompleteGameList"]][[2]] %>%
        janitor::clean_names()

      data$game_id <- unlist(purrr::map(data$game_id,function(x){
        pad_id(x)
      }))

      schedule_df <- data %>%
        dplyr::mutate(
          season_type_id = substr(.data$game_id, 3, 3),
          season_type_description = dplyr::case_when(
            .data$season_type_id == 1 ~ "Pre-Season",
            .data$season_type_id == 2 ~ "Regular Season",
            .data$season_type_id == 3 ~ "All-Star",
            .data$season_type_id == 4 ~ "Playoffs",
            .data$season_type_id == 5 ~ "Play-In Game"),
          game_date = lubridate::mdy(.data$date),
          visitor_team_name_full = paste(.data$vt_city, .data$vt_nick_name),
          home_team_name_full = paste(.data$ht_city, .data$ht_nick_name)) %>%
        dplyr::arrange(.data$game_date) %>%
        dplyr::as_tibble()
      schedule_df <- schedule_df %>%
        dplyr::left_join(teams %>% dplyr::select("visitor_team_id" = "TeamID","TeamNameFull"), by = c("visitor_team_name_full" = "TeamNameFull")) %>%
        dplyr::left_join(teams %>% dplyr::select("home_team_id" = "TeamID","TeamNameFull"), by = c("home_team_name_full" = "TeamNameFull")) %>%
        dplyr::select(
        "game_id"
        , "season_type_id"
        , "season_type_description"
        , "visitor_team_id"
        , "visitor_city" = "vt_city"
        , "visitor_nickname" = "vt_nick_name"
        , "visitor_name_short" = "vt_short_name"
        , "visitor_abbr" = "vt_abbreviation"
        , "visitor_team_name_full"
        , "home_team_id"
        , "home_city" = "ht_city"
        , "home_nickname" = "ht_nick_name"
        , "home_name_short" = "ht_short_name"
        , "home_abbr" = "ht_abbreviation"
        , "home_team_name_full"
        , "game_date"
        , "game_start_time" = "time"
        , "day")


    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no schedule data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(schedule_df)
}



rejoin_schedules <- function(df){
  df <- df %>%
    dplyr::mutate(
      HOME_AWAY = ifelse(stringr::str_detect(.data$MATCHUP,"@"),"AWAY","HOME")) %>%
    dplyr::select(-.data$WL,.data$MATCHUP)
  away_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "AWAY") %>%
    dplyr::select(-.data$HOME_AWAY) %>%
    dplyr::select(.data$SEASON_ID, .data$GAME_ID, .data$GAME_DATE, .data$MATCHUP, tidyr::everything())
  colnames(away_df)[5:ncol(away_df)]<-paste0("AWAY_", colnames(away_df)[5:ncol(away_df)])
  home_df <- df %>%
    dplyr::filter(.data$HOME_AWAY == "HOME") %>%
    dplyr::select(-.data$HOME_AWAY, -.data$MATCHUP) %>%
    dplyr::select(.data$SEASON_ID, .data$GAME_ID, .data$GAME_DATE,  tidyr::everything())
  colnames(home_df)[4:ncol(home_df)]<-paste0("HOME_", colnames(home_df)[4:ncol(home_df)])
  sched_df <- away_df %>%
    dplyr::left_join(home_df, by=c("GAME_ID", "SEASON_ID", "GAME_DATE"))
  return(sched_df)
}
