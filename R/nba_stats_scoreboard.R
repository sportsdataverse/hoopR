#' **Get NBA Stats API Season Schedule**
#' @name nba_schedule
NULL
#' @title
#' **Get NBA Stats API Season Schedule**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @return Returns a tibble with the following columns:
#'
#'    |col_name           |types     |description                                            |
#'    |:------------------|:---------|:------------------------------------------------------|
#'    |game_date          |character |Game date (YYYY-MM-DD).                                |
#'    |game_id            |character |Unique game identifier.                                |
#'    |game_code          |character |ESPN game code (numeric identifier).                   |
#'    |game_status        |integer   |Game status label.                                     |
#'    |game_status_text   |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |game_sequence      |integer   |Game sequence.                                         |
#'    |game_date_est      |character |Game date est.                                         |
#'    |game_time_est      |character |Game time est.                                         |
#'    |game_date_time_est |character |Game date time est.                                    |
#'    |game_date_utc      |character |Game date utc.                                         |
#'    |game_time_utc      |character |Game start time in UTC (ISO 8601 timestamp).           |
#'    |game_date_time_utc |character |Game date time utc.                                    |
#'    |away_team_time     |character |Time / clock value.                                    |
#'    |home_team_time     |character |Time / clock value.                                    |
#'    |day                |character |Day number within the month.                           |
#'    |month_num          |integer   |Month num.                                             |
#'    |week_number        |integer   |Week number.                                           |
#'    |week_name          |character |Week name.                                             |
#'    |if_necessary       |character |If necessary.                                          |
#'    |series_game_number |character |Series game number.                                    |
#'    |series_text        |character |Series text.                                           |
#'    |arena_name         |character |Arena name.                                            |
#'    |arena_state        |character |Arena state.                                           |
#'    |arena_city         |character |Arena city.                                            |
#'    |postponed_status   |character |Postponed status.                                      |
#'    |branch_link        |character |Branch link.                                           |
#'    |game_subtype       |character |Game subtype.                                          |
#'    |home_team_id       |integer   |Unique identifier for the home team.                   |
#'    |home_team_name     |character |Home team name.                                        |
#'    |home_team_city     |character |Home team city / location.                             |
#'    |home_team_tricode  |character |Home team three-letter code.                           |
#'    |home_team_slug     |character |Home team's team slug.                                 |
#'    |home_team_wins     |integer   |Home team's team wins.                                 |
#'    |home_team_losses   |integer   |Home team's team losses.                               |
#'    |home_team_score    |integer   |Home team's score.                                     |
#'    |home_team_seed     |integer   |Home team's team seed.                                 |
#'    |away_team_id       |integer   |Unique identifier for the away team.                   |
#'    |away_team_name     |character |Away team name.                                        |
#'    |away_team_city     |character |Away team city / location.                             |
#'    |away_team_tricode  |character |Away team three-letter code.                           |
#'    |away_team_slug     |character |Away team's team slug.                                 |
#'    |away_team_wins     |integer   |Away team's team wins.                                 |
#'    |away_team_losses   |integer   |Away team's team losses.                               |
#'    |away_team_score    |integer   |Away team's score.                                     |
#'    |away_team_seed     |integer   |Away team's team seed.                                 |
#'    |season             |character |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'    |league_id          |character |League identifier ('10' = WNBA).                       |
#'
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#'  nba_schedule(league_id = '20', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_schedule <- function(
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # The stats.nba.com/stats/scheduleleaguev2 endpoint was retired upstream in
  # March 2026 (returns Connection Reset across multiple client environments;
  # see issue #184 and #187). The same payload — identical
  # leagueSchedule.gameDates[].games[] schema — is served unauthenticated from
  # the public CDN, but only for the current season. The CDN host honors the
  # NBA/G-League distinction via the host prefix (`cdn.nba.com` vs the WNBA
  # mirror at `cdn.wnba.com`), and the G-League schedule is exposed at the
  # `_2`-suffixed variant on the NBA CDN.
  cdn_host <- if (identical(as.character(league_id), "20")) {
    # G-League — the same NBA CDN serves its schedule via a variant suffix
    "https://cdn.nba.com/static/json/staticData/scheduleLeagueV2_2.json"
  } else {
    "https://cdn.nba.com/static/json/staticData/scheduleLeagueV2.json"
  }
  cdn_headers <- c(
    `User-Agent` = paste0(
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ",
      "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"),
    `Accept` = "application/json, text/plain, */*",
    `Accept-Language` = "en-US,en;q=0.9",
    `Origin` = "https://www.nba.com",
    `Referer` = "https://www.nba.com/"
  )

  games <- NULL

  tryCatch(
    expr = {
      resp <- .retry_request(cdn_host, headers = cdn_headers) %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      league_sched <- resp %>% purrr::pluck("leagueSchedule")
      cdn_season   <- league_sched$seasonYear

      if (!is.null(cdn_season) &&
          !identical(as.character(season), as.character(cdn_season))) {
        message(glue::glue(
          "NBA CDN schedule is for season {cdn_season}, not {season}. ",
          "For historical seasons use `load_nba_schedule(seasons = ...)`."))
      }

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
        dplyr::select(-dplyr::any_of(c("homeTeam", "awayTeam"))) %>%
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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league schedule data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Scoreboard**
#' @name nba_scoreboard
NULL
#' @title
#' **Get NBA Stats API Scoreboard**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use `nba_scoreboardv3()` instead.
#' @rdname nba_scoreboard
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Available, EastConfStandingsByDay,
#' GameHeader, LastMeeting, LineScore, SeriesStandings, WestConfStandingsByDay
#'
#'    **GameHeader**
#'
#'
#'    |col_name                         |types     |description                                            |
#'    |:--------------------------------|:---------|:------------------------------------------------------|
#'    |GAME_DATE_EST                    |character |Game date est.                                         |
#'    |GAME_SEQUENCE                    |character |Game sequence.                                         |
#'    |GAME_ID                          |character |Unique game identifier.                                |
#'    |GAME_STATUS_ID                   |character |Numeric game status identifier.                        |
#'    |GAME_STATUS_TEXT                 |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |GAMECODE                         |character |                                                       |
#'    |HOME_TEAM_ID                     |character |Unique identifier for the home team.                   |
#'    |VISITOR_TEAM_ID                  |character |                                                       |
#'    |SEASON                           |character |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'    |LIVE_PERIOD                      |character |                                                       |
#'    |LIVE_PC_TIME                     |character |                                                       |
#'    |NATL_TV_BROADCASTER_ABBREVIATION |character |                                                       |
#'    |LIVE_PERIOD_TIME_BCAST           |character |                                                       |
#'    |WH_STATUS                        |character |Wh status.                                             |
#'
#'    **LineScore**
#'
#'
#'    |col_name          |types     |description                              |
#'    |:-----------------|:---------|:----------------------------------------|
#'    |GAME_DATE_EST     |character |Game date est.                           |
#'    |GAME_SEQUENCE     |character |Game sequence.                           |
#'    |GAME_ID           |character |Unique game identifier.                  |
#'    |TEAM_ID           |character |Unique team identifier.                  |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').    |
#'    |TEAM_CITY_NAME    |character |                                         |
#'    |TEAM_WINS_LOSSES  |character |                                         |
#'    |PTS_QTR1          |character |                                         |
#'    |PTS_QTR2          |character |                                         |
#'    |PTS_QTR3          |character |                                         |
#'    |PTS_QTR4          |character |                                         |
#'    |PTS_OT1           |character |                                         |
#'    |PTS_OT2           |character |                                         |
#'    |PTS_OT3           |character |                                         |
#'    |PTS_OT4           |character |                                         |
#'    |PTS_OT5           |character |                                         |
#'    |PTS_OT6           |character |                                         |
#'    |PTS_OT7           |character |                                         |
#'    |PTS_OT8           |character |                                         |
#'    |PTS_OT9           |character |                                         |
#'    |PTS_OT10          |character |                                         |
#'    |PTS               |character |Points scored.                           |
#'    |FG_PCT            |character |Field goal percentage (0-1).             |
#'    |FT_PCT            |character |Free throw percentage (0-1).             |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1). |
#'    |AST               |character |Assists.                                 |
#'    |REB               |character |Total rebounds.                          |
#'    |TOV               |character |Turnovers.                               |
#'
#'    **SeriesStandings**
#'
#'
#'    |col_name         |types     |description                          |
#'    |:----------------|:---------|:------------------------------------|
#'    |GAME_ID          |character |Unique game identifier.              |
#'    |HOME_TEAM_ID     |character |Unique identifier for the home team. |
#'    |VISITOR_TEAM_ID  |character |                                     |
#'    |GAME_DATE_EST    |character |Game date est.                       |
#'    |HOME_TEAM_WINS   |character |Home team's team wins.               |
#'    |HOME_TEAM_LOSSES |character |Home team's team losses.             |
#'    |SERIES_LEADER    |character |                                     |
#'
#'    **LastMeeting**
#'
#'
#'    |col_name                         |types     |description             |
#'    |:--------------------------------|:---------|:-----------------------|
#'    |GAME_ID                          |character |Unique game identifier. |
#'    |LAST_GAME_ID                     |character |                        |
#'    |LAST_GAME_DATE_EST               |character |                        |
#'    |LAST_GAME_HOME_TEAM_ID           |character |                        |
#'    |LAST_GAME_HOME_TEAM_CITY         |character |                        |
#'    |LAST_GAME_HOME_TEAM_NAME         |character |                        |
#'    |LAST_GAME_HOME_TEAM_ABBREVIATION |character |                        |
#'    |LAST_GAME_HOME_TEAM_POINTS       |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_ID        |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_CITY      |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_NAME      |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_CITY1     |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_POINTS    |character |                        |
#'
#'    **EastConfStandingsByDay**
#'
#'
#'    |col_name      |types     |description                         |
#'    |:-------------|:---------|:-----------------------------------|
#'    |TEAM_ID       |character |Unique team identifier.             |
#'    |LEAGUE_ID     |character |League identifier ('10' = WNBA).    |
#'    |SEASON_ID     |character |Unique season identifier.           |
#'    |STANDINGSDATE |character |                                    |
#'    |CONFERENCE    |character |Conference.                         |
#'    |TEAM          |character |Team-side label or team identifier. |
#'    |G             |character |Games played.                       |
#'    |W             |character |Wins.                               |
#'    |L             |character |Losses.                             |
#'    |W_PCT         |character |                                    |
#'    |HOME_RECORD   |character |Home win-loss record.               |
#'    |ROAD_RECORD   |character |                                    |
#'
#'    **WestConfStandingsByDay**
#'
#'
#'    |col_name      |types     |description                         |
#'    |:-------------|:---------|:-----------------------------------|
#'    |TEAM_ID       |character |Unique team identifier.             |
#'    |LEAGUE_ID     |character |League identifier ('10' = WNBA).    |
#'    |SEASON_ID     |character |Unique season identifier.           |
#'    |STANDINGSDATE |character |                                    |
#'    |CONFERENCE    |character |Conference.                         |
#'    |TEAM          |character |Team-side label or team identifier. |
#'    |G             |character |Games played.                       |
#'    |W             |character |Wins.                               |
#'    |L             |character |Losses.                             |
#'    |W_PCT         |character |                                    |
#'    |HOME_RECORD   |character |Home win-loss record.               |
#'    |ROAD_RECORD   |character |                                    |
#'
#'    **Available**
#'
#'
#'    |col_name     |types     |description             |
#'    |:------------|:---------|:-----------------------|
#'    |GAME_ID      |character |Unique game identifier. |
#'    |PT_AVAILABLE |character |Pt available.           |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboard(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboard <- function(
    league_id = "00",
    game_date = "2021-07-20",
    day_offset = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_scoreboard()",
    with = "nba_scoreboardv3()"
  )

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scoreboard"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Scoreboard V2**
#' @name nba_scoreboardv2
NULL
#' @title
#' **Get NBA Stats API Scoreboard V2**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/partial; use `nba_scoreboardv3()` instead.
#' @rdname nba_scoreboardv2
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Available, EastConfStandingsByDay,
#' GameHeader, LastMeeting, LineScore, SeriesStandings, TeamLeaders,
#' TicketLinks, WestConfStandingsByDay, WinProbability
#'
#'
#'   **GameHeader**
#'
#'
#'   |col_name                         |types     |description                                            |
#'   |:--------------------------------|:---------|:------------------------------------------------------|
#'   |GAME_DATE_EST                    |character |Game date est.                                         |
#'   |GAME_SEQUENCE                    |character |Game sequence.                                         |
#'   |GAME_ID                          |character |Unique game identifier.                                |
#'   |GAME_STATUS_ID                   |character |Numeric game status identifier.                        |
#'   |GAME_STATUS_TEXT                 |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'   |GAMECODE                         |character |                                                       |
#'   |HOME_TEAM_ID                     |character |Unique identifier for the home team.                   |
#'   |VISITOR_TEAM_ID                  |character |                                                       |
#'   |SEASON                           |character |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'   |LIVE_PERIOD                      |character |                                                       |
#'   |LIVE_PC_TIME                     |character |                                                       |
#'   |NATL_TV_BROADCASTER_ABBREVIATION |character |                                                       |
#'   |HOME_TV_BROADCASTER_ABBREVIATION |character |                                                       |
#'   |AWAY_TV_BROADCASTER_ABBREVIATION |character |                                                       |
#'   |LIVE_PERIOD_TIME_BCAST           |character |                                                       |
#'   |ARENA_NAME                       |character |Arena name.                                            |
#'   |WH_STATUS                        |character |Wh status.                                             |
#'   |WNBA_COMMISSIONER_FLAG           |character |                                                       |
#'
#'   **LineScore**
#'
#'
#'   |col_name          |types     |description                                     |
#'   |:-----------------|:---------|:-----------------------------------------------|
#'   |GAME_DATE_EST     |character |Game date est.                                  |
#'   |GAME_SEQUENCE     |character |Game sequence.                                  |
#'   |GAME_ID           |character |Unique game identifier.                         |
#'   |TEAM_ID           |character |Unique team identifier.                         |
#'   |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'   |TEAM_CITY_NAME    |character |                                                |
#'   |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'   |TEAM_WINS_LOSSES  |character |                                                |
#'   |PTS_QTR1          |character |                                                |
#'   |PTS_QTR2          |character |                                                |
#'   |PTS_QTR3          |character |                                                |
#'   |PTS_QTR4          |character |                                                |
#'   |PTS_OT1           |character |                                                |
#'   |PTS_OT2           |character |                                                |
#'   |PTS_OT3           |character |                                                |
#'   |PTS_OT4           |character |                                                |
#'   |PTS_OT5           |character |                                                |
#'   |PTS_OT6           |character |                                                |
#'   |PTS_OT7           |character |                                                |
#'   |PTS_OT8           |character |                                                |
#'   |PTS_OT9           |character |                                                |
#'   |PTS_OT10          |character |                                                |
#'   |PTS               |character |Points scored.                                  |
#'   |FG_PCT            |character |Field goal percentage (0-1).                    |
#'   |FT_PCT            |character |Free throw percentage (0-1).                    |
#'   |FG3_PCT           |character |Three-point field goal percentage (0-1).        |
#'   |AST               |character |Assists.                                        |
#'   |REB               |character |Total rebounds.                                 |
#'   |TOV               |character |Turnovers.                                      |
#'
#'   **SeriesStandings**
#'
#'
#'   |col_name         |types     |description                          |
#'   |:----------------|:---------|:------------------------------------|
#'   |GAME_ID          |character |Unique game identifier.              |
#'   |HOME_TEAM_ID     |character |Unique identifier for the home team. |
#'   |VISITOR_TEAM_ID  |character |                                     |
#'   |GAME_DATE_EST    |character |Game date est.                       |
#'   |HOME_TEAM_WINS   |character |Home team's team wins.               |
#'   |HOME_TEAM_LOSSES |character |Home team's team losses.             |
#'   |SERIES_LEADER    |character |                                     |
#'
#'   **LastMeeting**
#'
#'
#'   |col_name                         |types     |description             |
#'   |:--------------------------------|:---------|:-----------------------|
#'   |GAME_ID                          |character |Unique game identifier. |
#'   |LAST_GAME_ID                     |character |                        |
#'   |LAST_GAME_DATE_EST               |character |                        |
#'   |LAST_GAME_HOME_TEAM_ID           |character |                        |
#'   |LAST_GAME_HOME_TEAM_CITY         |character |                        |
#'   |LAST_GAME_HOME_TEAM_NAME         |character |                        |
#'   |LAST_GAME_HOME_TEAM_ABBREVIATION |character |                        |
#'   |LAST_GAME_HOME_TEAM_POINTS       |character |                        |
#'   |LAST_GAME_VISITOR_TEAM_ID        |character |                        |
#'   |LAST_GAME_VISITOR_TEAM_CITY      |character |                        |
#'   |LAST_GAME_VISITOR_TEAM_NAME      |character |                        |
#'   |LAST_GAME_VISITOR_TEAM_CITY1     |character |                        |
#'   |LAST_GAME_VISITOR_TEAM_POINTS    |character |                        |
#'
#'   **EastConfStandingsByDay**
#'
#'
#'   |col_name      |types     |description                         |
#'   |:-------------|:---------|:-----------------------------------|
#'   |TEAM_ID       |character |Unique team identifier.             |
#'   |LEAGUE_ID     |character |League identifier ('10' = WNBA).    |
#'   |SEASON_ID     |character |Unique season identifier.           |
#'   |STANDINGSDATE |character |                                    |
#'   |CONFERENCE    |character |Conference.                         |
#'   |TEAM          |character |Team-side label or team identifier. |
#'   |G             |character |Games played.                       |
#'   |W             |character |Wins.                               |
#'   |L             |character |Losses.                             |
#'   |W_PCT         |character |                                    |
#'   |HOME_RECORD   |character |Home win-loss record.               |
#'   |ROAD_RECORD   |character |                                    |
#'
#'   **WestConfStandingsByDay**
#'
#'
#'   |col_name      |types     |description                         |
#'   |:-------------|:---------|:-----------------------------------|
#'   |TEAM_ID       |character |Unique team identifier.             |
#'   |LEAGUE_ID     |character |League identifier ('10' = WNBA).    |
#'   |SEASON_ID     |character |Unique season identifier.           |
#'   |STANDINGSDATE |character |                                    |
#'   |CONFERENCE    |character |Conference.                         |
#'   |TEAM          |character |Team-side label or team identifier. |
#'   |G             |character |Games played.                       |
#'   |W             |character |Wins.                               |
#'   |L             |character |Losses.                             |
#'   |W_PCT         |character |                                    |
#'   |HOME_RECORD   |character |Home win-loss record.               |
#'   |ROAD_RECORD   |character |                                    |
#'
#'   **Available**
#'
#'
#'   |col_name     |types     |description             |
#'   |:------------|:---------|:-----------------------|
#'   |GAME_ID      |character |Unique game identifier. |
#'   |PT_AVAILABLE |character |Pt available.           |
#'
#'   **TeamLeaders**
#'
#'
#'   |col_name          |types     |description                             |
#'   |:-----------------|:---------|:---------------------------------------|
#'   |GAME_ID           |character |Unique game identifier.                 |
#'   |TEAM_ID           |character |Unique team identifier.                 |
#'   |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas'). |
#'   |TEAM_NICKNAME     |character |Team nickname.                          |
#'   |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').   |
#'   |PTS_PLAYER_ID     |character |                                        |
#'   |PTS_PLAYER_NAME   |character |                                        |
#'   |PTS               |character |Points scored.                          |
#'   |REB_PLAYER_ID     |character |                                        |
#'   |REB_PLAYER_NAME   |character |                                        |
#'   |REB               |character |Total rebounds.                         |
#'   |AST_PLAYER_ID     |character |                                        |
#'   |AST_PLAYER_NAME   |character |                                        |
#'   |AST               |character |Assists.                                |
#'
#'   **TicketLinks**
#'
#'   **WinProbability**
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv2(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboardv2 <- function(
    league_id = "00",
    game_date = "2021-07-20",
    day_offset = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_scoreboardv2()",
    with = "nba_scoreboardv3()"
  )

  version <- "scoreboardv2"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboardv2 data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Scoreboard V3**
#' @name nba_scoreboardv3
NULL
#' @title
#' **Get NBA Stats API Scoreboard V3**
#' @rdname nba_scoreboardv3
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a tibble with the following scoreboard data:
#'
#'    |col_name                       |types      |description                                            |
#'    |:------------------------------|:----------|:------------------------------------------------------|
#'    |game_id                        |character  |Unique game identifier.                                |
#'    |game_code                      |character  |ESPN game code (numeric identifier).                   |
#'    |game_status                    |integer    |Game status label.                                     |
#'    |game_status_text               |character  |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |game_date                      |character  |Game date (YYYY-MM-DD).                                |
#'    |game_time_utc                  |character  |Game start time in UTC (ISO 8601 timestamp).           |
#'    |game_et                        |character  |Game et.                                               |
#'    |home_team_id                   |integer    |Unique identifier for the home team.                   |
#'    |home_team_name                 |character  |Home team name.                                        |
#'    |home_team_city                 |character  |Home team city / location.                             |
#'    |home_team_tricode              |character  |Home team three-letter code.                           |
#'    |home_team_slug                 |character  |Home team's team slug.                                 |
#'    |away_team_id                   |integer    |Unique identifier for the away team.                   |
#'    |away_team_name                 |character  |Away team name.                                        |
#'    |away_team_city                 |character  |Away team city / location.                             |
#'    |away_team_tricode              |character  |Away team three-letter code.                           |
#'    |away_team_slug                 |character  |Away team's team slug.                                 |
#'    |period                         |integer    |Period of the game (1-4 quarters; 5+ for OT).          |
#'    |game_clock                     |character  |Game clock.                                            |
#'    |regulation_periods             |integer    |Regulation periods.                                    |
#'    |series_game_number             |character  |Series game number.                                    |
#'    |series_text                    |character  |Series text.                                           |
#'    |if_necessary                   |logical    |If necessary.                                          |
#'    |series_conference              |character  |Series conference.                                     |
#'    |po_round_desc                  |character  |Po round desc.                                         |
#'    |game_subtype                   |character  |Game subtype.                                          |
#'    |game_home_leaders_person_id    |integer    |Unique identifier for game home leaders person.        |
#'    |game_home_leaders_name         |character  |Game home leaders name.                                |
#'    |game_home_leaders_player_slug  |character  |Game home leaders player slug.                         |
#'    |game_home_leaders_jersey_num   |character  |Game home leaders jersey num.                          |
#'    |game_home_leaders_position     |character  |Game home leaders position.                            |
#'    |game_home_leaders_team_tricode |character  |Game home leaders team tricode.                        |
#'    |game_home_leaders_points       |integer    |Game home leaders points.                              |
#'    |game_home_leaders_rebounds     |integer    |Game home leaders rebounds.                            |
#'    |game_home_leaders_assists      |integer    |Game home leaders assists.                             |
#'    |game_away_leaders_person_id    |integer    |Unique identifier for game away leaders person.        |
#'    |game_away_leaders_name         |character  |Game away leaders name.                                |
#'    |game_away_leaders_player_slug  |character  |Game away leaders player slug.                         |
#'    |game_away_leaders_jersey_num   |character  |Game away leaders jersey num.                          |
#'    |game_away_leaders_position     |character  |Game away leaders position.                            |
#'    |game_away_leaders_team_tricode |character  |Game away leaders team tricode.                        |
#'    |game_away_leaders_points       |integer    |Game away leaders points.                              |
#'    |game_away_leaders_rebounds     |integer    |Game away leaders rebounds.                            |
#'    |game_away_leaders_assists      |integer    |Game away leaders assists.                             |
#'    |team_home_leaders_person_id    |integer    |Unique identifier for team home leaders person.        |
#'    |team_home_leaders_name         |character  |Team home leaders name.                                |
#'    |team_home_leaders_player_slug  |character  |Team home leaders player slug.                         |
#'    |team_home_leaders_jersey_num   |character  |Team home leaders jersey num.                          |
#'    |team_home_leaders_position     |character  |Team home leaders position.                            |
#'    |team_home_leaders_team_tricode |character  |Team home leaders team tricode.                        |
#'    |team_home_leaders_points       |numeric    |Team home leaders points.                              |
#'    |team_home_leaders_rebounds     |numeric    |Team home leaders rebounds.                            |
#'    |team_home_leaders_assists      |numeric    |Team home leaders assists.                             |
#'    |team_away_leaders_person_id    |integer    |Unique identifier for team away leaders person.        |
#'    |team_away_leaders_name         |character  |Team away leaders name.                                |
#'    |team_away_leaders_player_slug  |character  |Team away leaders player slug.                         |
#'    |team_away_leaders_jersey_num   |character  |Team away leaders jersey num.                          |
#'    |team_away_leaders_position     |character  |Team away leaders position.                            |
#'    |team_away_leaders_team_tricode |character  |Team away leaders team tricode.                        |
#'    |team_away_leaders_points       |numeric    |Team away leaders points.                              |
#'    |team_away_leaders_rebounds     |numeric    |Team away leaders rebounds.                            |
#'    |team_away_leaders_assists      |numeric    |Team away leaders assists.                             |
#'    |team_season_leaders_flag       |integer    |Team season leaders flag.                              |
#'    |home_wins                      |integer    |Home team's wins.                                      |
#'    |home_losses                    |integer    |Home team's losses.                                    |
#'    |home_score                     |integer    |Home team score at the time of the play.               |
#'    |home_seed                      |integer    |Home team's seed.                                      |
#'    |home_in_bonus                  |logical    |Home team's in bonus.                                  |
#'    |home_timeouts_remaining        |integer    |Home team's timeouts remaining.                        |
#'    |home_periods                   |list       |Home team's periods.                                   |
#'    |away_wins                      |integer    |Away team's wins.                                      |
#'    |away_losses                    |integer    |Away team's losses.                                    |
#'    |away_score                     |integer    |Away team score at the time of the play.               |
#'    |away_seed                      |integer    |Away team's seed.                                      |
#'    |away_in_bonus                  |logical    |Away team's in bonus.                                  |
#'    |away_timeouts_remaining        |integer    |Away team's timeouts remaining.                        |
#'    |away_periods                   |list       |Away team's periods.                                   |
#'    |league_id                      |character  |League identifier ('10' = WNBA).                       |
#'    |league                         |character  |League.                                                |
#'    |broadcasters                   |data.frame |                                                       |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv3(league_id = '00', game_date = '2023-03-26')
#' ```
nba_scoreboardv3 <- function(
    league_id = "00",
    game_date = "2023-03-26",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "scoreboardv3"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date
  )

  games <- .empty_hoopR_data("NBA Scoreboard V3 Information from NBA.com")

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      games <- scoreboard %>%
        purrr::pluck("games") %>%
        tidyr::unnest("homeTeam", names_sep = "_") %>%
        tidyr::unnest("awayTeam", names_sep = "_") %>%
        tidyr::unnest("gameLeaders", names_sep = "_") %>%
        tidyr::unnest("gameLeaders_homeLeaders", names_sep = "_") %>%
        tidyr::unnest("gameLeaders_awayLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders_homeLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders_awayLeaders", names_sep = "_")


      colnames(games) <- gsub("gameLeaders", "game", colnames(games))
      colnames(games) <- gsub("teamLeaders", "team", colnames(games))
      colnames(games) <- gsub("homeTeam", "home", colnames(games))
      colnames(games) <- gsub("awayTeam", "away", colnames(games))



      games <- games %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_date = game_date,
          league_id = league_id,
          league = dplyr::case_when(
            league_id == "00" ~ "NBA",
            league_id == "10" ~ "WNBA",
            league_id == "20" ~ "G-League",
            TRUE ~ "NBA"
          )
        ) %>%
        dplyr::select(
          "game_id",
          "game_code",
          "game_status",
          "game_status_text",
          "game_date",
          "game_time_utc",
          "game_et",
          dplyr::starts_with("home_team"),
          dplyr::starts_with("away_team"),
          tidyr::everything()
        ) %>%
        dplyr::relocate("broadcasters", .after = dplyr::last_col()) %>%
        make_hoopR_data("NBA Scoreboard V3 Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard v3 data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Today's Scoreboard**
#' @name nba_todays_scoreboard
NULL
#' @title
#' **Get NBA Stats API Today's Scoreboard**
#' @rdname nba_todays_scoreboard
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a data frame with the following columns:
#'
#'   |col_name                  |types     |description                                            |
#'   |:-------------------------|:---------|:------------------------------------------------------|
#'   |game_id                   |character |Unique game identifier.                                |
#'   |game_code                 |character |ESPN game code (numeric identifier).                   |
#'   |game_status               |integer   |Game status label.                                     |
#'   |game_status_text          |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'   |period                    |integer   |Period of the game (1-4 quarters; 5+ for OT).          |
#'   |game_clock                |character |Game clock.                                            |
#'   |game_time_utc             |character |Game start time in UTC (ISO 8601 timestamp).           |
#'   |game_et                   |character |Game et.                                               |
#'   |regulation_periods        |integer   |Regulation periods.                                    |
#'   |if_necessary              |logical   |If necessary.                                          |
#'   |series_game_number        |character |Series game number.                                    |
#'   |series_text               |character |Series text.                                           |
#'   |series_conference         |character |Series conference.                                     |
#'   |po_round_desc             |character |Po round desc.                                         |
#'   |game_subtype              |character |Game subtype.                                          |
#'   |home_team_id              |integer   |Unique identifier for the home team.                   |
#'   |home_team_name            |character |Home team name.                                        |
#'   |home_team_city            |character |Home team city / location.                             |
#'   |home_team_tricode         |character |Home team three-letter code.                           |
#'   |home_wins                 |integer   |Home team's wins.                                      |
#'   |home_losses               |integer   |Home team's losses.                                    |
#'   |home_score                |integer   |Home team score at the time of the play.               |
#'   |home_seed                 |logical   |Home team's seed.                                      |
#'   |home_in_bonus             |character |Home team's in bonus.                                  |
#'   |home_timeouts_remaining   |integer   |Home team's timeouts remaining.                        |
#'   |home_periods              |list      |Home team's periods.                                   |
#'   |away_team_id              |integer   |Unique identifier for the away team.                   |
#'   |away_team_name            |character |Away team name.                                        |
#'   |away_team_city            |character |Away team city / location.                             |
#'   |away_team_tricode         |character |Away team three-letter code.                           |
#'   |away_wins                 |integer   |Away team's wins.                                      |
#'   |away_losses               |integer   |Away team's losses.                                    |
#'   |away_score                |integer   |Away team score at the time of the play.               |
#'   |away_seed                 |logical   |Away team's seed.                                      |
#'   |away_in_bonus             |character |Away team's in bonus.                                  |
#'   |away_timeouts_remaining   |integer   |Away team's timeouts remaining.                        |
#'   |away_periods              |list      |Away team's periods.                                   |
#'   |home_leaders_person_id    |integer   |Unique identifier for home leaders person.             |
#'   |home_leaders_name         |character |Home leaders name.                                     |
#'   |home_leaders_jersey_num   |character |Home team's leaders jersey num.                        |
#'   |home_leaders_position     |character |Home team's leaders position.                          |
#'   |home_leaders_team_tricode |character |Home team's leaders team tricode.                      |
#'   |home_leaders_player_slug  |character |Home team's leaders player slug.                       |
#'   |home_leaders_points       |integer   |Home team's leaders points.                            |
#'   |home_leaders_rebounds     |integer   |Home team's leaders rebounds.                          |
#'   |home_leaders_assists      |integer   |Home team's leaders assists.                           |
#'   |away_leaders_person_id    |integer   |Unique identifier for away leaders person.             |
#'   |away_leaders_name         |character |Away leaders name.                                     |
#'   |away_leaders_jersey_num   |character |Away team's leaders jersey num.                        |
#'   |away_leaders_position     |character |Away team's leaders position.                          |
#'   |away_leaders_team_tricode |character |Away team's leaders team tricode.                      |
#'   |away_leaders_player_slug  |character |Away team's leaders player slug.                       |
#'   |away_leaders_points       |integer   |Away team's leaders points.                            |
#'   |away_leaders_rebounds     |integer   |Away team's leaders rebounds.                          |
#'   |away_leaders_assists      |integer   |Away team's leaders assists.                           |
#'   |pb_odds_team              |logical   |Pb odds team.                                          |
#'   |pb_odds_odds              |numeric   |Pb odds odds.                                          |
#'   |pb_odds_suspended         |integer   |Pb odds suspended.                                     |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_todays_scoreboard()
#' ```
nba_todays_scoreboard <- function(
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  games <- .empty_hoopR_data("NBA Today's Scoreboard Information from NBA.com")

  tryCatch(
    expr = {
      full_url <- "https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json"
      res <- .retry_request(full_url)

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      games <- scoreboard %>%
        purrr::pluck("games") %>%
        tidyr::unnest("homeTeam", names_sep = "_") %>%
        tidyr::unnest("awayTeam", names_sep = "_") %>%
        tidyr::unnest("gameLeaders") %>%
        tidyr::unnest("homeLeaders", names_sep = "_") %>%
        tidyr::unnest("awayLeaders", names_sep = "_") %>%
        tidyr::unnest("pbOdds", names_sep = "_")

      colnames(games) <- gsub("homeTeam", "home", colnames(games))
      colnames(games) <- gsub("awayTeam", "away", colnames(games))

      games <- games %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Today's Scoreboard Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no today's scoreboard data available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}



#' **Get NBA Stats API Win Probability PBP**
#' @name nba_winprobabilitypbp
NULL
#' @title
#' **Get NBA Stats API Win Probability PBP**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_playbyplayv3()` instead.
#' @rdname nba_winprobabilitypbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param run_type Run Type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: WinProbPBP, GameInfo
#'
#'    **WinProbPBP**
#'
#'
#'    |col_name          |types     |description                                       |
#'    |:-----------------|:---------|:-------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                           |
#'    |EVENT_NUM         |character |Sequential event number within the game (V2 PBP). |
#'    |HOME_PCT          |character |                                                  |
#'    |VISITOR_PCT       |character |                                                  |
#'    |HOME_PTS          |character |                                                  |
#'    |VISITOR_PTS       |character |                                                  |
#'    |HOME_SCORE_MARGIN |character |                                                  |
#'    |PERIOD            |character |Period of the game (1-4 quarters; 5+ for OT).     |
#'    |SECONDS_REMAINING |character |Seconds remaining in the period.                  |
#'    |HOME_POSS_IND     |character |                                                  |
#'    |HOME_G            |character |                                                  |
#'    |DESCRIPTION       |character |Long-form description text.                       |
#'    |LOCATION          |character |Location.                                         |
#'    |PCTIMESTRING      |character |                                                  |
#'    |ISVISIBLE         |character |                                                  |
#'
#'    **GameInfo**
#'
#'
#'    |col_name         |types     |description                          |
#'    |:----------------|:---------|:------------------------------------|
#'    |GAME_ID          |character |Unique game identifier.              |
#'    |GAME_DATE        |character |Game date (YYYY-MM-DD).              |
#'    |HOME_TEAM_ID     |character |Unique identifier for the home team. |
#'    |HOME_TEAM_ABR    |character |                                     |
#'    |HOME_TEAM_PTS    |character |                                     |
#'    |VISITOR_TEAM_ID  |character |                                     |
#'    |VISITOR_TEAM_ABR |character |                                     |
#'    |VISITOR_TEAM_PTS |character |                                     |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')
#' ```
nba_winprobabilitypbp <- function(
    game_id = "0021700807",
    run_type = "each second",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_winprobabilitypbp()",
    with = "nba_playbyplayv3()"
  )

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # run_type <- gsub(' ', '+', run_type)
  version <- "winprobabilitypbp"
  full_url <- nba_endpoint(version)

  params <- list(
    GameID = game_id,
    RunType = run_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no win probability pbp data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API International Schedule**
#' @name nba_scheduleleaguev2int
NULL
#' @title
#' **Get NBA Stats API International Schedule**
#' @rdname nba_scheduleleaguev2int
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format: '2023-24'
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: SeasonGames, SeasonWeeks, BroadcasterList
#'
#'    **SeasonGames**
#'
#'
#'    |col_name          |types     |description                                            |
#'    |:-----------------|:---------|:------------------------------------------------------|
#'    |game_date         |character |Game date (YYYY-MM-DD).                                |
#'    |game_id           |character |Unique game identifier.                                |
#'    |game_code         |character |ESPN game code (numeric identifier).                   |
#'    |game_status       |character |Game status label.                                     |
#'    |game_status_text  |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |game_sequence     |character |Game sequence.                                         |
#'    |home_team_id      |character |Unique identifier for the home team.                   |
#'    |home_team_name    |character |Home team name.                                        |
#'    |home_team_city    |character |Home team city / location.                             |
#'    |home_team_tricode |character |Home team three-letter code.                           |
#'    |home_team_slug    |character |Home team's team slug.                                 |
#'    |home_team_wins    |character |Home team's team wins.                                 |
#'    |home_team_losses  |character |Home team's team losses.                               |
#'    |home_team_score   |character |Home team's score.                                     |
#'    |away_team_id      |character |Unique identifier for the away team.                   |
#'    |away_team_name    |character |Away team name.                                        |
#'    |away_team_city    |character |Away team city / location.                             |
#'    |away_team_tricode |character |Away team three-letter code.                           |
#'    |away_team_slug    |character |Away team's team slug.                                 |
#'    |away_team_wins    |character |Away team's team wins.                                 |
#'    |away_team_losses  |character |Away team's team losses.                               |
#'    |away_team_score   |character |Away team's score.                                     |
#'    |season            |character |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'    |league_id         |character |League identifier ('10' = WNBA).                       |
#'
#'    **SeasonWeeks**
#'
#'
#'    |col_name    |types     |description                            |
#'    |:-----------|:---------|:--------------------------------------|
#'    |league_id   |character |League identifier ('10' = WNBA).       |
#'    |season_year |character |Season year string ('YYYY-YY' format). |
#'    |week_number |character |Week number.                           |
#'    |week_name   |character |Week name.                             |
#'    |start_date  |character |Start date (YYYY-MM-DD).               |
#'    |end_date    |character |End date (YYYY-MM-DD).                 |
#'
#'    **BroadcasterList**
#'
#'
#'    |col_name                 |types     |description                            |
#'    |:------------------------|:---------|:--------------------------------------|
#'    |league_id                |character |League identifier ('10' = WNBA).       |
#'    |season_year              |character |Season year string ('YYYY-YY' format). |
#'    |broadcaster_abbreviation |character |Broadcaster abbreviation.              |
#'    |broadcaster_display      |character |Broadcaster display.                   |
#'    |broadcaster_id           |character |Unique identifier for broadcaster.     |
#'    |region_id                |character |Unique identifier for region.          |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scheduleleaguev2int(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_scheduleleaguev2int <- function(
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scheduleleaguev2int"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    Season = season
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      league_sched <- resp %>%
        purrr::pluck("leagueSchedule")

      # SeasonGames
      game_dates <- league_sched %>%
        purrr::pluck("gameDates")

      if (length(game_dates) > 0) {
        games <- game_dates %>%
          tidyr::unnest("games") %>%
          dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
          dplyr::bind_cols(
            game_dates %>%
              tidyr::unnest("games") %>%
              purrr::pluck("homeTeam") %>%
              dplyr::rename_with(~ paste0("home_team_", .x))
          ) %>%
          dplyr::bind_cols(
            game_dates %>%
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
      } else {
        games <- dplyr::tibble()
      }

      # SeasonWeeks
      weeks <- league_sched %>%
        purrr::pluck("weeks")
      if (!is.null(weeks) && length(weeks) > 0) {
        weeks_df <- weeks %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names()
        weeks_df$league_id <- league_sched$leagueId
        weeks_df$season_year <- league_sched$seasonYear
      } else {
        weeks_df <- dplyr::tibble()
      }

      # BroadcasterList
      broadcasters <- league_sched %>%
        purrr::pluck("broadcasters")
      if (!is.null(broadcasters) && length(broadcasters) > 0) {
        broadcast_df <- broadcasters %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names()
        broadcast_df$league_id <- league_sched$leagueId
        broadcast_df$season_year <- league_sched$seasonYear
      } else {
        broadcast_df <- dplyr::tibble()
      }

      df_list <- c(list(games), list(weeks_df), list(broadcast_df))
      names(df_list) <- c("SeasonGames", "SeasonWeeks", "BroadcasterList")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no international schedule data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
