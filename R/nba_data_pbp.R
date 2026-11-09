#' **Get NBA Data API Play-by-Play**
#' @name nba_data_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play**
#' @rdname nba_data_pbp
#' @author Saiem Gilani
#' @param game_id Game ID - 10 digits, i.e. "0021900001"
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_data_pbp", unit = "play-by-play event")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select mutate rename case_when
#' @importFrom tidyr everything
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' data.nba.com serves this play-by-play for the 2016-17 through 2024-25
#' seasons (probed 2026-09-29). Earlier games are missing, and later ones come
#' back without plays, which returns an empty result with a message.
#'
#' ```r
#'  nba_data_pbp(game_id = "0021900001")
#' ```
nba_data_pbp <- function(game_id = "0021900001", ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  league_id <- substr(game_id, 1, 2)
  season_id <- substr(game_id, 4, 5)
  season <- ifelse(
    substr(season_id, 1, 1) == "9",
    paste0("19", season_id),
    paste0("20", season_id)
  )
  league <- dplyr::case_when(
    substr(game_id, 1, 2) == "00" ~ "nba",
    substr(game_id, 1, 2) == "10" ~ "wnba",
    substr(game_id, 1, 2) == "20" ~ "dleague",
    TRUE ~ "NBA"
  )
  full_url <- sprintf(
    "https://data.nba.com/data/v2015/json/mobile_teams/%s/%s/scores/pbp/%s_full_pbp.json",
    league, season, game_id
  )

  plays_df <- .empty_hoopR_data("NBA Play-by-Play Information from NBA.com")

  tryCatch(
    expr = {
      # data.nba.com sits behind the same Akamai block as the NBA CDN: no browser
      # headers gets a 403 "Access Denied" page (probed 2026-09-29).
      res <- .retry_request(full_url, headers = .nba_cdn_headers())

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      data <- jsonlite::fromJSON(resp)$g
      # A changed or error payload without the g.pd play-by-play list is a failed
      # fetch, never the empty shell below.
      if (!is.list(data) || !"pd" %in% names(data)) {
        stop("the data.nba.com payload has no g.pd play-by-play list")
      }
      # data.nba.com stopped updating after 2024-25: later games come back as an
      # empty shell (`pd: []`) with no plays to parse.
      if (length(data$pd) == 0) {
        cli::cli_alert_info("data.nba.com has no play-by-play for {game_id}; it covers 2016-17 through 2024-25.")
      } else {
        plays <- jsonlite::fromJSON(jsonlite::toJSON(data$pd), flatten = TRUE)
        plays_df <- purrr::map_df(plays[[1]], function(x) {
          plays_df <- plays[[2]][[x]] %>%
            dplyr::mutate(period = x) %>%
            dplyr::select("period", tidyr::everything())
        })

        plays_df <- plays_df %>%
          dplyr::select(dplyr::any_of(c(
            "period" = "period",
            "event_num" = "evt",
            "clock" = "cl",
            "description" = "de",
            "locX" = "locX",
            "locY" = "locY",
            "opt1" = "opt1",
            "opt2" = "opt2",
            "event_action_type" = "mtype",
            "event_type" = "etype",
            "team_id" = "tid",
            "offense_team_id" = "oftid",
            "player1_id" = "pid",
            "player2_id" = "epid",
            "player3_id" = "opid",
            "home_score" = "hs",
            "away_score" = "vs",
            "order" = "ord"
          ))) %>%
          dplyr::mutate(
            player2_id = as.integer(.data$player2_id),
            player3_id = as.integer(.data$player3_id),
            game_id = game_id,
            league = dplyr::case_when(
              substr(game_id, 1, 2) == "00" ~ "NBA",
              substr(game_id, 1, 2) == "10" ~ "WNBA",
              substr(game_id, 1, 2) == "20" ~ "G-League",
              TRUE ~ "NBA"
            )
          ) %>%
          dplyr::select("game_id", "league", tidyr::everything()) %>%
          make_hoopR_data("NBA Play-by-Play Information from NBA.com", Sys.time())
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    finally = {}
  )
  return(plays_df)
}
