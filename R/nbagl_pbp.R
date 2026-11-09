#' **Get NBA Data API Play-by-Play for G-League Games**
#' @name nbagl_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play for G-League Games**
#' @description Retrieves G-League play-by-play using the NBA Stats play-by-play pipeline.
#' @rdname nbagl_pbp
#' @author Billy Fryer
#' @param game_id Game ID - 10 digits, i.e. 0021900001
#' @param on_court If TRUE (default), on-court player IDs are added for each play event.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nbagl_pbp", inline = FALSE, unit = "play-by-play event")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_pbp(game_id = "2052500034")
#' ```

nbagl_pbp <- function(
    game_id,
    on_court = TRUE,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  plays_df <- data.frame()

  tryCatch(
    expr = {
      plays_df <- nba_pbp(game_id = {{ game_id }}, on_court = on_court)

      if (on_court) {
        on_court_cols <- c(
          "away_player1", "away_player2", "away_player3", "away_player4", "away_player5",
          "home_player1", "home_player2", "home_player3", "home_player4", "home_player5"
        )
        missing_cols <- setdiff(on_court_cols, colnames(plays_df))
        if (length(missing_cols) > 0) {
          plays_df[missing_cols] <- NA_real_
        }
      }

      plays_df <- plays_df |>
        make_hoopR_data("NBA G-League Play-by-Play Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )

  return(plays_df)
}


#' **Get NBA G-League Stats API Live play-by-play**
#' @name nbagl_live_pbp
NULL
#' @title
#' **Get NBA G-League Stats API Live play-by-play**
#' @rdname nbagl_live_pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nbagl_live_pbp", inline = FALSE, unit = "play-by-play event")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_live_pbp(game_id = '2052500034')
#' ```
nbagl_live_pbp <- function(
    game_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  data <- data.frame()

  endpoint <- nbagl_live_endpoint("playbyplay")

  full_url <- paste0(
    endpoint,
    "/playbyplay_",
    pad_id(game_id),
    ".json"
  )

  tryCatch(
    expr = {
      res <- .retry_request(full_url, headers = .nba_cdn_headers())

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game") %>%
        purrr::pluck("actions") %>%
        janitor::clean_names()

      data <- data %>%
        dplyr::rename(dplyr::any_of(c(
          "period" = "period",
          "event_num" = "action_number",
          "clock" = "clock",
          "description" = "description",
          "locX" = "xLegacy",
          "locY" = "yLegacy",
          "action_type" = "action_type",
          "sub_type" = "sub_type",
          "descriptor" = "descriptor",
          "shot_result" = "shot_result",
          "shot_action_number" = "shot_action_number",
          "qualifiers" = "qualifiers",
          "team_id" = "team_id",
          "player1_id" = "person_id",
          "home_score" = "score_home",
          "away_score" = "score_away",
          "offense_team_id" = "possession",
          "order" = "order_number"
        ))) %>%
        dplyr::mutate(
          player2_id = dplyr::case_when(
            !is.na(.data$assist_person_id) ~ .data$assist_person_id,
            TRUE ~ NA_integer_
          ),
          player3_id = dplyr::case_when(
            !is.na(.data$block_person_id) ~ .data$block_person_id,
            !is.na(.data$steal_person_id) ~ .data$steal_person_id,
            !is.na(.data$foul_drawn_person_id) ~ .data$foul_drawn_person_id,
            TRUE ~ NA_integer_
          )
        ) %>%
        make_hoopR_data("NBA G-League Game Play-by-Play Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    finally = {
    }
  )
  return(data)
}



#' **Get NBA G-League Stats API Live Boxscore**
#' @name nbagl_live_boxscore
NULL
#' @title
#' **Get NBA G-League Stats API Live Boxscore**
#' @rdname nbagl_live_boxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nbagl_live_boxscore", inline = FALSE)
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_live_boxscore(game_id = "2052500034")
#' ```
nbagl_live_boxscore <- function(
    game_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nbagl_live_endpoint("boxscore")

  full_url <- paste0(
    endpoint,
    "/boxscore_",
    pad_id(game_id),
    ".json"
  )

  df_list <- list()

  tryCatch(
    expr = {
      res <- .retry_request(full_url, headers = .nba_cdn_headers())

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game")

      game_details <- data.frame(
        game_id = data %>% purrr::pluck("gameId"),
        game_time_local = data %>% purrr::pluck("gameTimeLocal"),
        game_time_utc = data %>% purrr::pluck("gameTimeUTC"),
        game_time_home = data %>% purrr::pluck("gameTimeHome"),
        game_time_away = data %>% purrr::pluck("gameTimeAway"),
        game_et = data %>% purrr::pluck("gameEt"),
        duration = data %>% purrr::pluck("duration"),
        game_code = data %>% purrr::pluck("gameCode"),
        game_status_text = data %>% purrr::pluck("gameStatusText"),
        game_status = data %>% purrr::pluck("gameStatus"),
        regulation_periods = data %>% purrr::pluck("regulationPeriods"),
        period = data %>% purrr::pluck("period"),
        game_clock = data %>% purrr::pluck("gameClock"),
        attendance = data %>% purrr::pluck("attendance"),
        sellout = data %>% purrr::pluck("sellout")
      )

      arena <- data %>%
        purrr::pluck("arena") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA G-League Game Arena Information from NBA.com", Sys.time())

      officials <- data %>%
        purrr::pluck("officials") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA G-League Game Officials Information from NBA.com", Sys.time())

      if ("homeTeam" %in% names(data)) {
        home_team <- data %>%
          purrr::pluck("homeTeam")

        home_team_info <- data.frame(
          team_id = home_team %>% purrr::pluck("teamId"),
          team_name = home_team %>% purrr::pluck("teamName"),
          team_city = home_team %>% purrr::pluck("teamCity"),
          team_tricode = home_team %>% purrr::pluck("teamTricode"),
          team_score = home_team %>% purrr::pluck("score"),
          team_in_bonus = home_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = home_team %>% purrr::pluck("timeoutsRemaining")
        )

        home_team_box <- home_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        home_team_linescores <- home_team$periods %>%
          janitor::clean_names()

        home_team_players <- home_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        home_team_player_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Player Boxscore Information from NBA.com", Sys.time())

        home_team_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Team Boxscore Information from NBA.com", Sys.time())
      }

      if ("awayTeam" %in% names(data)) {
        away_team <- data %>%
          purrr::pluck("awayTeam")

        away_team_info <- data.frame(
          team_id = away_team %>% purrr::pluck("teamId"),
          team_name = away_team %>% purrr::pluck("teamName"),
          team_city = away_team %>% purrr::pluck("teamCity"),
          team_tricode = away_team %>% purrr::pluck("teamTricode"),
          team_score = away_team %>% purrr::pluck("score"),
          team_in_bonus = away_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = away_team %>% purrr::pluck("timeoutsRemaining")
        )

        away_team_box <- away_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        away_team_linescores <- away_team$periods %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Linescore Information from NBA.com", Sys.time())

        away_team_players <- away_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        away_team_player_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA G-League Game Player Boxscore Information from NBA.com", Sys.time())

        away_team_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())
      }

      colnames(home_team_info) <- paste0("home_", colnames(home_team_info))
      colnames(away_team_info) <- paste0("away_", colnames(away_team_info))

      game_details <- game_details %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(away_team_info) %>%
        make_hoopR_data("NBA G-League Game Linescore Information from NBA.com", Sys.time())

      df_list <- c(
        list(game_details),
        list(arena),
        list(officials),
        list(home_team_boxscore),
        list(away_team_boxscore),
        list(home_team_player_boxscore),
        list(away_team_player_boxscore),
        list(home_team_linescores),
        list(away_team_linescores)
      )

      names(df_list) <- c(
        "game_details",
        "arena",
        "officials",
        "home_team_boxscore",
        "away_team_boxscore",
        "home_team_player_boxscore",
        "away_team_player_boxscore",
        "home_team_linescores",
        "away_team_linescores"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore data for {game_id} available!",
      args = .args
    ),
    finally = {
    }
  )
  return(df_list)
}


### Variables included

# evt = Event number
# cl = Time Remaining in Quarter
# de = description
# locX = X location of action
# locY = Y location of action
# opt1 = ???
# opt2 = ???
# mtype = ???
# etype = ???
# opid = ???
# tid = Team ID, 0 for events not relating to a team (such as end of Q)
# pid = Player ID
# hs = Home Score
# vs = Visitor Score
# epid = Secondary Person ID (such as assister)
# oftid = Offensive Team ID? This is equal to tid in my test case
# ord = ???
