#' **Get G League Schedule from NBA API**
#' @name nbagl_schedule
NULL
#' @title **Get G League Schedule from NBA API**
#' @description Retrieves G-League schedule data via the NBA Stats API schedule endpoint.
#' @rdname nbagl_schedule
#' @author Billy Fryer
#' @param league_id League - default: '20' (G-League).
#' @param season Season - format 2020-21.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame of the G League Season Schedule
#'
#'    |col_name                |types     |
#'    |:-----------------------|:---------|
#'    |game_date               |date      |
#'    |game_id                 |character |
#'    |game_code               |character |
#'    |game_status             |integer   |
#'    |game_status_text        |character |
#'    |game_sequence           |integer   |
#'    |game_date_est           |character |
#'    |game_time_est           |character |
#'    |game_date_utc           |character |
#'    |game_time_utc           |character |
#'    |arena_name              |character |
#'    |arena_state             |character |
#'    |arena_city              |character |
#'    |home_team_id            |character |
#'    |home_team_name          |character |
#'    |home_team_tricode       |character |
#'    |home_team_score         |character |
#'    |away_team_id            |character |
#'    |away_team_name          |character |
#'    |away_team_tricode       |character |
#'    |away_team_score         |character |
#'    |season                  |character |
#'    |league_id               |character |
#'    |season_type_id          |character |
#'    |season_type_description |character |
#'
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows arrange
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_schedule(season = most_recent_nba_season() - 1)
#' ```

nbagl_schedule <- function(
    league_id = "20",
    season = year_to_season(most_recent_nba_season() - 1),
    ...) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  games <- dplyr::tibble()

  version <- "scheduleleaguev2"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    Season = season
  )

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      league_sched <- resp %>%
        purrr::pluck("leagueSchedule")
      games <- league_sched %>%
        purrr::pluck("gameDates") %>%
        tidyr::unnest("games") %>%
        dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
        dplyr::bind_cols(
          league_sched %>%
            purrr::pluck("gameDates") %>%
            tidyr::unnest("games") %>%
            purrr::pluck("homeTeam") %>%
            dplyr::rename_with(~ paste0("home_team_", .x))
        ) %>%
        dplyr::bind_cols(
          league_sched %>%
            purrr::pluck("gameDates") %>%
            tidyr::unnest("games") %>%
            purrr::pluck("awayTeam") %>%
            dplyr::rename_with(~ paste0("away_team_", .x))
        ) %>%
        dplyr::select(-"homeTeam", -"awayTeam") %>%
        janitor::clean_names()
      colnames(games) <- gsub("team_team", "team", colnames(games))
      games$game_id <- unlist(purrr::map(games$game_id, function(x) {
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
            .data$season_type_id == 5 ~ "Play-In Game"
          ),
          game_date = lubridate::mdy(substring(.data$game_date, 1, 10))
        )
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


# Example JSON Link:
# https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/league/20_full_schedule.json

# 2015 and Older does not work

### Variable Explanation

# gid = Game Id
# gcode = GameDate/VisitorAbbreveationHomeAbbreviation
# seri = Always returns ""
# is = Always returns 1
# gdte = Game Date
# htm = Game Date and time for Home Team
# vtm = Game Date and time for Visiting Team
# etm = Game Date and time in Eastern
# an = Arena where game was played
# ac = City where game was played
# as = Atate where game was played
# st = Always "1"
# stt = Game Start time in eastern for "12:00 pm EST"
# bd.b = Data Frame with 6 variables about television broadcast
# v.tid = Visitor Team Id
# v.re = Visitor Record (?)
# v.ta = Visitor Abbreviation
# v.tn = Visitor Team Nickname
# v.tc = Visitor Team City
# v.s = NULL
# h.tid = Home Team Id
# h.re =  Home Record (?)
# h.ta =  Home Abbreviation
# h.tn =  Home Team Nickname
# h.tc =  Home Team City
# h.s = NULL
# gdctm = Game Date but somehow different than gdte
# utctm = ???
# ppdst = ???
# seq = Game Order By Day (1st game on 1-1-2022, 2nd game on 1-1-2022, 1st game on 1-2-2022, etc.)
