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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_date \tab character \tab Game date (YYYY-MM-DD). \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_code \tab character \tab ESPN game code (numeric identifier). \cr
#'       game_status \tab integer \tab Game status label. \cr
#'       game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       game_sequence \tab integer \tab Game sequence. \cr
#'       game_date_est \tab character \tab Game date est. \cr
#'       game_time_est \tab character \tab Game time est. \cr
#'       game_date_time_est \tab character \tab Game date time est. \cr
#'       game_date_utc \tab character \tab Game date utc. \cr
#'       game_time_utc \tab character \tab Game start time in UTC (ISO 8601 timestamp). \cr
#'       game_date_time_utc \tab character \tab Game date time utc. \cr
#'       away_team_time \tab character \tab Time / clock value. \cr
#'       home_team_time \tab character \tab Time / clock value. \cr
#'       day \tab character \tab Day number within the month. \cr
#'       month_num \tab integer \tab Month num. \cr
#'       week_number \tab integer \tab Week number. \cr
#'       week_name \tab character \tab Week name. \cr
#'       if_necessary \tab character \tab If necessary. \cr
#'       series_game_number \tab character \tab Series game number. \cr
#'       series_text \tab character \tab Series text. \cr
#'       arena_name \tab character \tab Arena name. \cr
#'       arena_state \tab character \tab Arena state. \cr
#'       arena_city \tab character \tab Arena city. \cr
#'       postponed_status \tab character \tab Postponed status. \cr
#'       branch_link \tab character \tab Branch link. \cr
#'       game_subtype \tab character \tab Game subtype. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_city \tab character \tab Home team city / location. \cr
#'       home_team_tricode \tab character \tab Home team three-letter code. \cr
#'       home_team_slug \tab character \tab Home team's team slug. \cr
#'       home_team_wins \tab integer \tab Home team's team wins. \cr
#'       home_team_losses \tab integer \tab Home team's team losses. \cr
#'       home_team_score \tab integer \tab Home team's score. \cr
#'       home_team_seed \tab integer \tab Home team's team seed. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_city \tab character \tab Away team city / location. \cr
#'       away_team_tricode \tab character \tab Away team three-letter code. \cr
#'       away_team_slug \tab character \tab Away team's team slug. \cr
#'       away_team_wins \tab integer \tab Away team's team wins. \cr
#'       away_team_losses \tab integer \tab Away team's team losses. \cr
#'       away_team_score \tab integer \tab Away team's score. \cr
#'       away_team_seed \tab integer \tab Away team's team seed. \cr
#'       season \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname nba_schedule
#' @name nba_scoreboard
NULL
#' @title
#' **Get NBA Stats API Scoreboard**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use `nba_scoreboardv3()` instead.
#' @rdname nba_schedule
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
#'    Columns as documented in the shared [nba_boxscoresummaryv2_gamesummary_schema] table.
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
#'    Columns as documented in the shared [nba_boxscoresummaryv2_seasonseries_schema] table.
#'
#'    **LastMeeting**
#'
#'
#'    Columns as documented in the shared [nba_boxscoresummaryv2_lastmeeting_schema] table.
#'
#'    **EastConfStandingsByDay**
#'
#'
#'    Columns as documented in the shared [nba_scoreboard_eastconfstandingsbyday_schema] table.
#'
#'    **WestConfStandingsByDay**
#'
#'
#'    Columns as documented in the shared [nba_scoreboard_eastconfstandingsbyday_schema] table.
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
    with = "nba_scoreboardv3()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple dates returned an HTML error page instead of JSON; confirmed defunct upstream. For real-time scores, prefer nba_todays_scoreboard() (see #129)."
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
#' @rdname nba_schedule
#' @name nba_scoreboardv2
NULL
#' @title
#' **Get NBA Stats API Scoreboard V2**
#' @description
#' Restored in `hoopR` 3.1.0 -- a residential-IP live re-probe (2026-08-24)
#' confirmed this endpoint still serves real rows for NBA. For real-time
#' scores, prefer [nba_todays_scoreboard()] instead (see #129).
#' @rdname nba_schedule
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
#'   Columns as documented in the shared [nba_boxscoresummaryv2_seasonseries_schema] table.
#'
#'   **LastMeeting**
#'
#'
#'   Columns as documented in the shared [nba_boxscoresummaryv2_lastmeeting_schema] table.
#'
#'   **EastConfStandingsByDay**
#'
#'
#'   Columns as documented in the shared [nba_scoreboard_eastconfstandingsbyday_schema] table.
#'
#'   **WestConfStandingsByDay**
#'
#'
#'   Columns as documented in the shared [nba_scoreboard_eastconfstandingsbyday_schema] table.
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
#' @rdname nba_schedule
#' @name nba_scoreboardv3
NULL
#' @title
#' **Get NBA Stats API Scoreboard V3**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a tibble with the following scoreboard data:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_code \tab character \tab ESPN game code (numeric identifier). \cr
#'       game_status \tab integer \tab Game status label. \cr
#'       game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       game_date \tab character \tab Game date (YYYY-MM-DD). \cr
#'       game_time_utc \tab character \tab Game start time in UTC (ISO 8601 timestamp). \cr
#'       game_et \tab character \tab Game et. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_city \tab character \tab Home team city / location. \cr
#'       home_team_tricode \tab character \tab Home team three-letter code. \cr
#'       home_team_slug \tab character \tab Home team's team slug. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_city \tab character \tab Away team city / location. \cr
#'       away_team_tricode \tab character \tab Away team three-letter code. \cr
#'       away_team_slug \tab character \tab Away team's team slug. \cr
#'       period \tab integer \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       game_clock \tab character \tab Game clock. \cr
#'       regulation_periods \tab integer \tab Regulation periods. \cr
#'       series_game_number \tab character \tab Series game number. \cr
#'       series_text \tab character \tab Series text. \cr
#'       if_necessary \tab logical \tab If necessary. \cr
#'       series_conference \tab character \tab Series conference. \cr
#'       po_round_desc \tab character \tab Po round desc. \cr
#'       game_subtype \tab character \tab Game subtype. \cr
#'       game_home_leaders_person_id \tab integer \tab Unique identifier for game home leaders person. \cr
#'       game_home_leaders_name \tab character \tab Game home leaders name. \cr
#'       game_home_leaders_player_slug \tab character \tab Game home leaders player slug. \cr
#'       game_home_leaders_jersey_num \tab character \tab Game home leaders jersey num. \cr
#'       game_home_leaders_position \tab character \tab Game home leaders position. \cr
#'       game_home_leaders_team_tricode \tab character \tab Game home leaders team tricode. \cr
#'       game_home_leaders_points \tab integer \tab Game home leaders points. \cr
#'       game_home_leaders_rebounds \tab integer \tab Game home leaders rebounds. \cr
#'       game_home_leaders_assists \tab integer \tab Game home leaders assists. \cr
#'       game_away_leaders_person_id \tab integer \tab Unique identifier for game away leaders person. \cr
#'       game_away_leaders_name \tab character \tab Game away leaders name. \cr
#'       game_away_leaders_player_slug \tab character \tab Game away leaders player slug. \cr
#'       game_away_leaders_jersey_num \tab character \tab Game away leaders jersey num. \cr
#'       game_away_leaders_position \tab character \tab Game away leaders position. \cr
#'       game_away_leaders_team_tricode \tab character \tab Game away leaders team tricode. \cr
#'       game_away_leaders_points \tab integer \tab Game away leaders points. \cr
#'       game_away_leaders_rebounds \tab integer \tab Game away leaders rebounds. \cr
#'       game_away_leaders_assists \tab integer \tab Game away leaders assists. \cr
#'       team_home_leaders_person_id \tab integer \tab Unique identifier for team home leaders person. \cr
#'       team_home_leaders_name \tab character \tab Team home leaders name. \cr
#'       team_home_leaders_player_slug \tab character \tab Team home leaders player slug. \cr
#'       team_home_leaders_jersey_num \tab character \tab Team home leaders jersey num. \cr
#'       team_home_leaders_position \tab character \tab Team home leaders position. \cr
#'       team_home_leaders_team_tricode \tab character \tab Team home leaders team tricode. \cr
#'       team_home_leaders_points \tab numeric \tab Team home leaders points. \cr
#'       team_home_leaders_rebounds \tab numeric \tab Team home leaders rebounds. \cr
#'       team_home_leaders_assists \tab numeric \tab Team home leaders assists. \cr
#'       team_away_leaders_person_id \tab integer \tab Unique identifier for team away leaders person. \cr
#'       team_away_leaders_name \tab character \tab Team away leaders name. \cr
#'       team_away_leaders_player_slug \tab character \tab Team away leaders player slug. \cr
#'       team_away_leaders_jersey_num \tab character \tab Team away leaders jersey num. \cr
#'       team_away_leaders_position \tab character \tab Team away leaders position. \cr
#'       team_away_leaders_team_tricode \tab character \tab Team away leaders team tricode. \cr
#'       team_away_leaders_points \tab numeric \tab Team away leaders points. \cr
#'       team_away_leaders_rebounds \tab numeric \tab Team away leaders rebounds. \cr
#'       team_away_leaders_assists \tab numeric \tab Team away leaders assists. \cr
#'       team_season_leaders_flag \tab integer \tab Team season leaders flag. \cr
#'       home_wins \tab integer \tab Home team's wins. \cr
#'       home_losses \tab integer \tab Home team's losses. \cr
#'       home_score \tab integer \tab Home team score at the time of the play. \cr
#'       home_seed \tab integer \tab Home team's seed. \cr
#'       home_in_bonus \tab logical \tab Home team's in bonus. \cr
#'       home_timeouts_remaining \tab integer \tab Home team's timeouts remaining. \cr
#'       home_periods \tab list \tab Home team's periods. \cr
#'       away_wins \tab integer \tab Away team's wins. \cr
#'       away_losses \tab integer \tab Away team's losses. \cr
#'       away_score \tab integer \tab Away team score at the time of the play. \cr
#'       away_seed \tab integer \tab Away team's seed. \cr
#'       away_in_bonus \tab logical \tab Away team's in bonus. \cr
#'       away_timeouts_remaining \tab integer \tab Away team's timeouts remaining. \cr
#'       away_periods \tab list \tab Away team's periods. \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'       league \tab character \tab League. \cr
#'       broadcasters \tab data.frame \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname nba_schedule
#' @name nba_todays_scoreboard
NULL
#' @title
#' **Get NBA Stats API Today's Scoreboard**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a data frame with the following columns:
#'
#'   \if{html}{\tabular{lll}{
#'      col_name \tab types \tab description \cr
#'      game_id \tab character \tab Unique game identifier. \cr
#'      game_code \tab character \tab ESPN game code (numeric identifier). \cr
#'      game_status \tab integer \tab Game status label. \cr
#'      game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'      period \tab integer \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'      game_clock \tab character \tab Game clock. \cr
#'      game_time_utc \tab character \tab Game start time in UTC (ISO 8601 timestamp). \cr
#'      game_et \tab character \tab Game et. \cr
#'      regulation_periods \tab integer \tab Regulation periods. \cr
#'      if_necessary \tab logical \tab If necessary. \cr
#'      series_game_number \tab character \tab Series game number. \cr
#'      series_text \tab character \tab Series text. \cr
#'      series_conference \tab character \tab Series conference. \cr
#'      po_round_desc \tab character \tab Po round desc. \cr
#'      game_subtype \tab character \tab Game subtype. \cr
#'      home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'      home_team_name \tab character \tab Home team name. \cr
#'      home_team_city \tab character \tab Home team city / location. \cr
#'      home_team_tricode \tab character \tab Home team three-letter code. \cr
#'      home_wins \tab integer \tab Home team's wins. \cr
#'      home_losses \tab integer \tab Home team's losses. \cr
#'      home_score \tab integer \tab Home team score at the time of the play. \cr
#'      home_seed \tab logical \tab Home team's seed. \cr
#'      home_in_bonus \tab character \tab Home team's in bonus. \cr
#'      home_timeouts_remaining \tab integer \tab Home team's timeouts remaining. \cr
#'      home_periods \tab list \tab Home team's periods. \cr
#'      away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'      away_team_name \tab character \tab Away team name. \cr
#'      away_team_city \tab character \tab Away team city / location. \cr
#'      away_team_tricode \tab character \tab Away team three-letter code. \cr
#'      away_wins \tab integer \tab Away team's wins. \cr
#'      away_losses \tab integer \tab Away team's losses. \cr
#'      away_score \tab integer \tab Away team score at the time of the play. \cr
#'      away_seed \tab logical \tab Away team's seed. \cr
#'      away_in_bonus \tab character \tab Away team's in bonus. \cr
#'      away_timeouts_remaining \tab integer \tab Away team's timeouts remaining. \cr
#'      away_periods \tab list \tab Away team's periods. \cr
#'      home_leaders_person_id \tab integer \tab Unique identifier for home leaders person. \cr
#'      home_leaders_name \tab character \tab Home leaders name. \cr
#'      home_leaders_jersey_num \tab character \tab Home team's leaders jersey num. \cr
#'      home_leaders_position \tab character \tab Home team's leaders position. \cr
#'      home_leaders_team_tricode \tab character \tab Home team's leaders team tricode. \cr
#'      home_leaders_player_slug \tab character \tab Home team's leaders player slug. \cr
#'      home_leaders_points \tab integer \tab Home team's leaders points. \cr
#'      home_leaders_rebounds \tab integer \tab Home team's leaders rebounds. \cr
#'      home_leaders_assists \tab integer \tab Home team's leaders assists. \cr
#'      away_leaders_person_id \tab integer \tab Unique identifier for away leaders person. \cr
#'      away_leaders_name \tab character \tab Away leaders name. \cr
#'      away_leaders_jersey_num \tab character \tab Away team's leaders jersey num. \cr
#'      away_leaders_position \tab character \tab Away team's leaders position. \cr
#'      away_leaders_team_tricode \tab character \tab Away team's leaders team tricode. \cr
#'      away_leaders_player_slug \tab character \tab Away team's leaders player slug. \cr
#'      away_leaders_points \tab integer \tab Away team's leaders points. \cr
#'      away_leaders_rebounds \tab integer \tab Away team's leaders rebounds. \cr
#'      away_leaders_assists \tab integer \tab Away team's leaders assists. \cr
#'      pb_odds_team \tab logical \tab Pb odds team. \cr
#'      pb_odds_odds \tab numeric \tab Pb odds odds. \cr
#'      pb_odds_suspended \tab integer \tab Pb odds suspended. \cr
#'   }}
#'   \if{latex}{See the HTML help or pkgdown reference for the column table.}
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

  # The NBA CDN rejects requests without browser-like headers with an
  # "Access Denied" HTML page (not JSON). Match the headers nba_schedule()
  # uses for the same cdn.nba.com host.
  cdn_headers <- c(
    `User-Agent` = paste0(
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ",
      "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"),
    `Accept` = "application/json, text/plain, */*",
    `Accept-Language` = "en-US,en;q=0.9",
    `Origin` = "https://www.nba.com",
    `Referer` = "https://www.nba.com/"
  )

  tryCatch(
    expr = {
      full_url <- "https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json"
      res <- .retry_request(full_url, headers = cdn_headers)

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
#' @rdname nba_schedule
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
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param run_type Run Type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: WinProbPBP, GameInfo
#'
#'    **WinProbPBP**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       EVENT_NUM \tab character \tab Sequential event number within the game (V2 PBP). \cr
#'       HOME_PCT \tab character \tab  \cr
#'       VISITOR_PCT \tab character \tab  \cr
#'       HOME_PTS \tab character \tab  \cr
#'       VISITOR_PTS \tab character \tab  \cr
#'       HOME_SCORE_MARGIN \tab character \tab  \cr
#'       PERIOD \tab character \tab Period of the game (1-4 quarters; 5+ for OT). \cr
#'       SECONDS_REMAINING \tab character \tab Seconds remaining in the period. \cr
#'       HOME_POSS_IND \tab character \tab  \cr
#'       HOME_G \tab character \tab  \cr
#'       DESCRIPTION \tab character \tab Long-form description text. \cr
#'       LOCATION \tab character \tab Location. \cr
#'       PCTIMESTRING \tab character \tab  \cr
#'       ISVISIBLE \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **GameInfo**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       HOME_TEAM_ID \tab character \tab Unique identifier for the home team. \cr
#'       HOME_TEAM_ABR \tab character \tab  \cr
#'       HOME_TEAM_PTS \tab character \tab  \cr
#'       VISITOR_TEAM_ID \tab character \tab  \cr
#'       VISITOR_TEAM_ABR \tab character \tab  \cr
#'       VISITOR_TEAM_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
    with = "nba_playbyplayv3()",
    details = "Live re-probe (2026-08-24, residential IP) returned an empty response body; confirmed defunct upstream."
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
#' @rdname nba_schedule
#' @name nba_scheduleleaguev2int
NULL
#' @title
#' **Get NBA Stats API International Schedule**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: SeasonGames, SeasonWeeks, BroadcasterList
#'
#'    **SeasonGames**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_date \tab character \tab Game date (YYYY-MM-DD). \cr
#'       game_id \tab character \tab Unique game identifier. \cr
#'       game_code \tab character \tab ESPN game code (numeric identifier). \cr
#'       game_status \tab character \tab Game status label. \cr
#'       game_status_text \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       game_sequence \tab character \tab Game sequence. \cr
#'       home_team_id \tab character \tab Unique identifier for the home team. \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_city \tab character \tab Home team city / location. \cr
#'       home_team_tricode \tab character \tab Home team three-letter code. \cr
#'       home_team_slug \tab character \tab Home team's team slug. \cr
#'       home_team_wins \tab character \tab Home team's team wins. \cr
#'       home_team_losses \tab character \tab Home team's team losses. \cr
#'       home_team_score \tab character \tab Home team's score. \cr
#'       away_team_id \tab character \tab Unique identifier for the away team. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_city \tab character \tab Away team city / location. \cr
#'       away_team_tricode \tab character \tab Away team three-letter code. \cr
#'       away_team_slug \tab character \tab Away team's team slug. \cr
#'       away_team_wins \tab character \tab Away team's team wins. \cr
#'       away_team_losses \tab character \tab Away team's team losses. \cr
#'       away_team_score \tab character \tab Away team's score. \cr
#'       season \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **SeasonWeeks**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'       season_year \tab character \tab Season year string ('YYYY-YY' format). \cr
#'       week_number \tab character \tab Week number. \cr
#'       week_name \tab character \tab Week name. \cr
#'       start_date \tab character \tab Start date (YYYY-MM-DD). \cr
#'       end_date \tab character \tab End date (YYYY-MM-DD). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **BroadcasterList**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'       season_year \tab character \tab Season year string ('YYYY-YY' format). \cr
#'       broadcaster_abbreviation \tab character \tab Broadcaster abbreviation. \cr
#'       broadcaster_display \tab character \tab Broadcaster display. \cr
#'       broadcaster_id \tab character \tab Unique identifier for broadcaster. \cr
#'       region_id \tab character \tab Unique identifier for region. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
