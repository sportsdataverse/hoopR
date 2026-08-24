#' **Get NBA Stats API League Game Log**
#' @name nba_leaguegamelog
NULL
#' @title
#' **Get NBA Stats API League Game Log**
#' @rdname nba_leaguegamelog
#' @author Saiem Gilani
#' @param counter counter
#' @param date_from date_from
#' @param date_to date_to
#' @param direction direction
#' @param league_id league_id
#' @param player_or_team player_or_team
#' @param season season
#' @param season_type season_type
#' @param sorter sorter
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: LeagueGameLog
#'
#'    **LeagueGameLog**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       SEASON_ID \tab character \tab Unique season identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       MATCHUP \tab character \tab Matchup. \cr
#'       WL \tab character \tab Wl. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'       VIDEO_AVAILABLE \tab character \tab Video available. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @details
#' [Player/Team Boxscores](https://www.nba.com/stats/players/boxscores)
#' ```r
#'  nba_leaguegamelog(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguegamelog <- function(
    counter = 0,
    date_from = '',
    date_to = '',
    direction = 'ASC',
    league_id = '00',
    player_or_team = 'T',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    sorter = 'DATE',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "leaguegamelog"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  # Param order matters here. As of 2026, the NBA Stats API rejects
  # the alphabetical ordering (Counter first) with a Cloudflare HTML error
  # page; the LeagueID-first ordering matches what the nba.com client sends
  # and parses successfully. Verified parallel to the WNBA endpoint of the
  # same name (see sportsdataverse/wehoop#54) — same param values,
  # alphabetical-first returns HTML, LeagueID-first returns a populated
  # `LeagueGameLog` result set.
  params <- list(
    LeagueID     = league_id,
    Season       = season,
    SeasonType   = season_type,
    PlayerOrTeam = player_or_team,
    Counter      = counter,
    Direction    = direction,
    Sorter       = sorter,
    DateFrom     = date_from,
    DateTo       = date_to
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league game log data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Standings**
#' @name nba_leaguestandings
NULL
#' @title
#' **Get NBA Stats API League Standings**
#' @rdname nba_leaguestandings
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Standings
#'
#'    **Standings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LeagueID \tab character \tab  \cr
#'       SeasonID \tab character \tab  \cr
#'       TeamID \tab character \tab Teamid. \cr
#'       TeamCity \tab character \tab Teamcity. \cr
#'       TeamName \tab character \tab Teamname. \cr
#'       Conference \tab character \tab Conference. \cr
#'       ConferenceRecord \tab character \tab  \cr
#'       PlayoffRank \tab character \tab  \cr
#'       ClinchIndicator \tab character \tab  \cr
#'       Division \tab character \tab Team division. \cr
#'       DivisionRecord \tab character \tab  \cr
#'       DivisionRank \tab character \tab  \cr
#'       WINS \tab character \tab Total wins. \cr
#'       LOSSES \tab character \tab Total losses. \cr
#'       WinPCT \tab character \tab  \cr
#'       LeagueRank \tab character \tab  \cr
#'       Record \tab character \tab Record string (e.g. '12-4'). \cr
#'       HOME \tab character \tab Home. \cr
#'       ROAD \tab character \tab Road. \cr
#'       L10 \tab character \tab  \cr
#'       Last10Home \tab character \tab  \cr
#'       Last10Road \tab character \tab  \cr
#'       OT \tab character \tab Ot. \cr
#'       ThreePTSOrLess \tab character \tab  \cr
#'       TenPTSOrMore \tab character \tab  \cr
#'       LongHomeStreak \tab character \tab  \cr
#'       strLongHomeStreak \tab character \tab  \cr
#'       LongRoadStreak \tab character \tab  \cr
#'       strLongRoadStreak \tab character \tab  \cr
#'       LongWinStreak \tab character \tab  \cr
#'       LongLossStreak \tab character \tab  \cr
#'       CurrentHomeStreak \tab character \tab  \cr
#'       strCurrentHomeStreak \tab character \tab  \cr
#'       CurrentRoadStreak \tab character \tab  \cr
#'       strCurrentRoadStreak \tab character \tab  \cr
#'       CurrentStreak \tab character \tab  \cr
#'       strCurrentStreak \tab character \tab  \cr
#'       ConferenceGamesBack \tab character \tab  \cr
#'       DivisionGamesBack \tab character \tab  \cr
#'       ClinchedConferenceTitle \tab character \tab  \cr
#'       ClinchedDivisionTitle \tab character \tab  \cr
#'       ClinchedPlayoffBirth \tab character \tab  \cr
#'       EliminatedConference \tab character \tab  \cr
#'       EliminatedDivision \tab character \tab  \cr
#'       AheadAtHalf \tab character \tab  \cr
#'       BehindAtHalf \tab character \tab  \cr
#'       TiedAtHalf \tab character \tab  \cr
#'       AheadAtThird \tab character \tab  \cr
#'       BehindAtThird \tab character \tab  \cr
#'       TiedAtThird \tab character \tab  \cr
#'       Score100PTS \tab character \tab  \cr
#'       OppScore100PTS \tab character \tab  \cr
#'       OppOver500 \tab character \tab  \cr
#'       LeadInFGPCT \tab character \tab  \cr
#'       LeadInReb \tab character \tab  \cr
#'       FewerTurnovers \tab character \tab  \cr
#'       PointsPG \tab character \tab  \cr
#'       OppPointsPG \tab character \tab  \cr
#'       DiffPointsPG \tab character \tab  \cr
#'       vsEast \tab character \tab  \cr
#'       vsAtlantic \tab character \tab  \cr
#'       vsCentral \tab character \tab  \cr
#'       vsSoutheast \tab character \tab  \cr
#'       vsWest \tab character \tab  \cr
#'       vsNorthwest \tab character \tab  \cr
#'       vsPacific \tab character \tab  \cr
#'       vsSouthwest \tab character \tab  \cr
#'       Jan \tab character \tab  \cr
#'       Feb \tab character \tab  \cr
#'       Mar \tab character \tab  \cr
#'       Apr \tab character \tab  \cr
#'       May \tab character \tab  \cr
#'       Jun \tab character \tab  \cr
#'       Jul \tab character \tab  \cr
#'       Aug \tab character \tab  \cr
#'       Sep \tab character \tab  \cr
#'       Oct \tab character \tab  \cr
#'       Nov \tab character \tab  \cr
#'       Dec \tab character \tab  \cr
#'       PreAS \tab character \tab  \cr
#'       PostAS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @details
#' [League Standings](https://www.nba.com/standings)
#' ```r
#'  nba_leaguestandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguestandings <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    season_year = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ','+',season_type)
  version <- "leaguestandings"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league standings data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Standings V3**
#' @name nba_leaguestandingsv3
NULL
#' @title
#' **Get NBA Stats API League Standings V3**
#' @rdname nba_leaguestandingsv3
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Standings
#'
#'    **Standings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LeagueID \tab character \tab  \cr
#'       SeasonID \tab character \tab  \cr
#'       TeamID \tab character \tab Teamid. \cr
#'       TeamCity \tab character \tab Teamcity. \cr
#'       TeamName \tab character \tab Teamname. \cr
#'       TeamSlug \tab character \tab  \cr
#'       Conference \tab character \tab Conference. \cr
#'       ConferenceRecord \tab character \tab  \cr
#'       PlayoffRank \tab character \tab  \cr
#'       ClinchIndicator \tab character \tab  \cr
#'       Division \tab character \tab Team division. \cr
#'       DivisionRecord \tab character \tab  \cr
#'       DivisionRank \tab character \tab  \cr
#'       WINS \tab character \tab Total wins. \cr
#'       LOSSES \tab character \tab Total losses. \cr
#'       WinPCT \tab character \tab  \cr
#'       LeagueRank \tab character \tab  \cr
#'       Record \tab character \tab Record string (e.g. '12-4'). \cr
#'       HOME \tab character \tab Home. \cr
#'       ROAD \tab character \tab Road. \cr
#'       L10 \tab character \tab  \cr
#'       Last10Home \tab character \tab  \cr
#'       Last10Road \tab character \tab  \cr
#'       OT \tab character \tab Ot. \cr
#'       ThreePTSOrLess \tab character \tab  \cr
#'       TenPTSOrMore \tab character \tab  \cr
#'       LongHomeStreak \tab character \tab  \cr
#'       strLongHomeStreak \tab character \tab  \cr
#'       LongRoadStreak \tab character \tab  \cr
#'       strLongRoadStreak \tab character \tab  \cr
#'       LongWinStreak \tab character \tab  \cr
#'       LongLossStreak \tab character \tab  \cr
#'       CurrentHomeStreak \tab character \tab  \cr
#'       strCurrentHomeStreak \tab character \tab  \cr
#'       CurrentRoadStreak \tab character \tab  \cr
#'       strCurrentRoadStreak \tab character \tab  \cr
#'       CurrentStreak \tab character \tab  \cr
#'       strCurrentStreak \tab character \tab  \cr
#'       ConferenceGamesBack \tab character \tab  \cr
#'       DivisionGamesBack \tab character \tab  \cr
#'       ClinchedConferenceTitle \tab character \tab  \cr
#'       ClinchedDivisionTitle \tab character \tab  \cr
#'       ClinchedPlayoffBirth \tab character \tab  \cr
#'       ClinchedPlayIn \tab character \tab  \cr
#'       EliminatedConference \tab character \tab  \cr
#'       EliminatedDivision \tab character \tab  \cr
#'       AheadAtHalf \tab character \tab  \cr
#'       BehindAtHalf \tab character \tab  \cr
#'       TiedAtHalf \tab character \tab  \cr
#'       AheadAtThird \tab character \tab  \cr
#'       BehindAtThird \tab character \tab  \cr
#'       TiedAtThird \tab character \tab  \cr
#'       Score100PTS \tab character \tab  \cr
#'       OppScore100PTS \tab character \tab  \cr
#'       OppOver500 \tab character \tab  \cr
#'       LeadInFGPCT \tab character \tab  \cr
#'       LeadInReb \tab character \tab  \cr
#'       FewerTurnovers \tab character \tab  \cr
#'       PointsPG \tab character \tab  \cr
#'       OppPointsPG \tab character \tab  \cr
#'       DiffPointsPG \tab character \tab  \cr
#'       vsEast \tab character \tab  \cr
#'       vsAtlantic \tab character \tab  \cr
#'       vsCentral \tab character \tab  \cr
#'       vsSoutheast \tab character \tab  \cr
#'       vsWest \tab character \tab  \cr
#'       vsNorthwest \tab character \tab  \cr
#'       vsPacific \tab character \tab  \cr
#'       vsSouthwest \tab character \tab  \cr
#'       Jan \tab character \tab  \cr
#'       Feb \tab character \tab  \cr
#'       Mar \tab character \tab  \cr
#'       Apr \tab character \tab  \cr
#'       May \tab character \tab  \cr
#'       Jun \tab character \tab  \cr
#'       Jul \tab character \tab  \cr
#'       Aug \tab character \tab  \cr
#'       Sep \tab character \tab  \cr
#'       Oct \tab character \tab  \cr
#'       Nov \tab character \tab  \cr
#'       Dec \tab character \tab  \cr
#'       Score_80_Plus \tab character \tab  \cr
#'       Opp_Score_80_Plus \tab character \tab  \cr
#'       Score_Below_80 \tab character \tab  \cr
#'       Opp_Score_Below_80 \tab character \tab  \cr
#'       TotalPoints \tab character \tab  \cr
#'       OppTotalPoints \tab character \tab  \cr
#'       DiffTotalPoints \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @details
#' [League Standings](https://www.nba.com/standings)
#' ```r
#'  nba_leaguestandingsv3(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguestandingsv3 <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    season_year = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ','+',season_type)
  version <- "leaguestandingsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league standings v3 data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Playoff Picture**
#' @name nba_playoffpicture
NULL
#' @title
#' **Get NBA Stats API Playoff Picture**
#' @rdname nba_playoffpicture
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_id season_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: EastConfPlayoffPicture,
#' EastConfRemainingGames, EastConfStandings, WestConfPlayoffPicture,
#' WestConfRemainingGames, WestConfStandings
#'
#'    **EastConfPlayoffPicture**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       CONFERENCE \tab character \tab Conference. \cr
#'       HIGH_SEED_RANK \tab character \tab  \cr
#'       HIGH_SEED_TEAM \tab character \tab  \cr
#'       HIGH_SEED_TEAM_ID \tab character \tab  \cr
#'       LOW_SEED_RANK \tab character \tab  \cr
#'       LOW_SEED_TEAM \tab character \tab  \cr
#'       LOW_SEED_TEAM_ID \tab character \tab  \cr
#'       HIGH_SEED_SERIES_W \tab character \tab  \cr
#'       HIGH_SEED_SERIES_L \tab character \tab  \cr
#'       HIGH_SEED_SERIES_REMAINING_G \tab character \tab  \cr
#'       HIGH_SEED_SERIES_REMAINING_HOME_G \tab character \tab  \cr
#'       HIGH_SEED_SERIES_REMAINING_AWAY_G \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **WestConfPlayoffPicture**
#'
#'
#'    Same columns as the **EastConfPlayoffPicture** table above.
#'
#'    **EastConfStandings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       CONFERENCE \tab character \tab Conference. \cr
#'       RANK \tab character \tab Rank. \cr
#'       TEAM \tab character \tab Team-side label or team identifier. \cr
#'       TEAM_SLUG \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       WINS \tab character \tab Total wins. \cr
#'       LOSSES \tab character \tab Total losses. \cr
#'       PCT \tab character \tab Pct. \cr
#'       DIV \tab character \tab  \cr
#'       CONF \tab character \tab character. \cr
#'       HOME \tab character \tab Home. \cr
#'       AWAY \tab character \tab  \cr
#'       GB \tab character \tab  \cr
#'       GR_OVER_500 \tab character \tab  \cr
#'       GR_OVER_500_HOME \tab character \tab  \cr
#'       GR_OVER_500_AWAY \tab character \tab  \cr
#'       GR_UNDER_500 \tab character \tab  \cr
#'       GR_UNDER_500_HOME \tab character \tab  \cr
#'       GR_UNDER_500_AWAY \tab character \tab  \cr
#'       RANKING_CRITERIA \tab character \tab  \cr
#'       CLINCHED_PLAYOFFS \tab character \tab  \cr
#'       CLINCHED_CONFERENCE \tab character \tab  \cr
#'       CLINCHED_DIVISION \tab character \tab  \cr
#'       ELIMINATED_PLAYOFFS \tab character \tab  \cr
#'       SOSA_REMAINING \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **WestConfStandings**
#'
#'
#'    Same columns as the **EastConfStandings** table above.
#'
#'    **EastConfRemainingGames**
#'
#'
#'    |col_name         |types     |description                         |
#'    |:----------------|:---------|:-----------------------------------|
#'    |TEAM             |character |Team-side label or team identifier. |
#'    |TEAM_ID          |character |Unique team identifier.             |
#'    |REMAINING_G      |character |                                    |
#'    |REMAINING_HOME_G |character |                                    |
#'    |REMAINING_AWAY_G |character |                                    |
#'
#'    **WestConfRemainingGames**
#'
#'
#'    Same columns as the **EastConfRemainingGames** table above.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @details
#' ```r
#'  nba_playoffpicture(league_id = '00', season_id = paste0(2, most_recent_nba_season() - 1))
#' ```
nba_playoffpicture <- function(
    league_id = '00',
    season_id = '22022',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "playoffpicture"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonID = season_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no playoff picture data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API League Game Streak Finder**
#' @name nba_leaguegamefinder
NULL
#' @title
#' **Get NBA Stats API League Game Streak Finder**
#' @rdname nba_leaguegamefinder
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_year draft_year
#' @param draft_team_id draft_team_id
#' @param draft_round draft_round
#' @param draft_number draft_number
#' @param et_ast et_ast
#' @param et_blk et_blk
#' @param et_dd et_dd
#' @param et_dreb et_dreb
#' @param et_fg3a et_fg3a
#' @param et_fg3m et_fg3m
#' @param et_fg3_pct et_fg3_pct
#' @param et_fga et_fga
#' @param et_fgm et_fgm
#' @param et_fg_pct et_fg_pct
#' @param et_fta et_fta
#' @param et_ftm et_ftm
#' @param et_ft_pct et_ft_pct
#' @param et_minutes et_minutes
#' @param et_oreb et_oreb
#' @param et_pf et_pf
#' @param et_pts et_pts
#' @param et_reb et_reb
#' @param et_stl et_stl
#' @param et_td et_td
#' @param et_tov et_tov
#' @param game_id game_id
#' @param gt_ast gt_ast
#' @param gt_blk gt_blk
#' @param gt_dd gt_dd
#' @param gt_dreb gt_dreb
#' @param gt_fg3a gt_fg3a
#' @param gt_fg3m gt_fg3m
#' @param gt_fg3_pct gt_fg3_pct
#' @param gt_fga gt_fga
#' @param gt_fgm gt_fgm
#' @param gt_fg_pct gt_fg_pct
#' @param gt_fta gt_fta
#' @param gt_ftm gt_ftm
#' @param gt_ft_pct gt_ft_pct
#' @param gt_minutes gt_minutes
#' @param gt_oreb gt_oreb
#' @param gt_pf gt_pf
#' @param gt_pts gt_pts
#' @param gt_reb gt_reb
#' @param gt_stl gt_stl
#' @param gt_td gt_td
#' @param gt_tov gt_tov
#' @param league_id league_id
#' @param location location
#' @param lt_ast lt_ast
#' @param lt_blk lt_blk
#' @param lt_dd lt_dd
#' @param lt_dreb lt_dreb
#' @param lt_fg3a lt_fg3a
#' @param lt_fg3m lt_fg3m
#' @param lt_fg3_pct lt_fg3_pct
#' @param lt_fga lt_fga
#' @param lt_fgm lt_fgm
#' @param lt_fg_pct lt_fg_pct
#' @param lt_fta lt_fta
#' @param lt_ftm lt_ftm
#' @param lt_ft_pct lt_ft_pct
#' @param lt_minutes lt_minutes
#' @param lt_oreb lt_oreb
#' @param lt_pf lt_pf
#' @param lt_pts lt_pts
#' @param lt_reb lt_reb
#' @param lt_stl lt_stl
#' @param lt_td lt_td
#' @param lt_tov lt_tov
#' @param outcome outcome
#' @param po_round po_round
#' @param player_or_team player_or_team
#' @param player_id player_id
#' @param rookie_year rookie_year
#' @param season season - Min: '1983-84'
#' @param season_segment season_segment
#' @param season_type season_type
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param years_experience years_experience
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: LeagueGameFinderResults
#'
#'    **LeagueGameFinderResults**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       SEASON_ID \tab character \tab Unique season identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       MATCHUP \tab character \tab Matchup. \cr
#'       WL \tab character \tab Wl. \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @family NBA Game Finder Functions
#' @details
#' ```r
#'  nba_leaguegamefinder(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_leaguegamefinder <- function(
    conference = '',
    date_from = '',
    date_to = '',
    division = '',
    draft_year = '',
    draft_team_id = '',
    draft_round = '',
    draft_number = '',
    et_ast = '',
    et_blk = '',
    et_dd = '',
    et_dreb = '',
    et_fg3a = '',
    et_fg3m = '',
    et_fg3_pct = '',
    et_fga = '',
    et_fgm = '',
    et_fg_pct = '',
    et_fta = '',
    et_ftm = '',
    et_ft_pct = '',
    et_minutes = '',
    et_oreb = '',
    et_pf = '',
    et_pts = '',
    et_reb = '',
    et_stl = '',
    et_td = '',
    et_tov = '',
    game_id = '',
    gt_ast = '',
    gt_blk = '',
    gt_dd = '',
    gt_dreb = '',
    gt_fg3a = '',
    gt_fg3m = '',
    gt_fg3_pct = '',
    gt_fga = '',
    gt_fgm = '',
    gt_fg_pct = '',
    gt_fta = '',
    gt_ftm = '',
    gt_ft_pct = '',
    gt_minutes = '',
    gt_oreb = '',
    gt_pf = '',
    gt_pts = '',
    gt_reb = '',
    gt_stl = '',
    gt_td = '',
    gt_tov = '',
    league_id = '00',
    location = '',
    lt_ast = '',
    lt_blk = '',
    lt_dd = '',
    lt_dreb = '',
    lt_fg3a = '',
    lt_fg3m = '',
    lt_fg3_pct = '',
    lt_fga = '',
    lt_fgm = '',
    lt_fg_pct = '',
    lt_fta = '',
    lt_ftm = '',
    lt_ft_pct = '',
    lt_minutes = '',
    lt_oreb = '',
    lt_pf = '',
    lt_pts = '',
    lt_reb = '',
    lt_stl = '',
    lt_td = '',
    lt_tov = '',
    outcome = '',
    po_round = '',
    player_id = '',
    player_or_team = 'T',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    starter_bench = '',
    team_id = '',
    vs_conference = '',
    vs_division = '',
    vs_team_id = '',
    years_experience = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  version <- "leaguegamefinder"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftNumber = draft_number,
    DraftRound = draft_round,
    DraftTeamID = draft_team_id,
    DraftYear = draft_year,
    EqAST = et_ast,
    EqBLK = et_blk,
    EqDD = et_dd,
    EqDREB = et_dreb,
    EqFG3A = et_fg3a,
    EqFG3M = et_fg3m,
    EqFG3_PCT = et_fg3_pct,
    EqFGA = et_fga,
    EqFGM = et_fgm,
    EqFG_PCT = et_fg_pct,
    EqFTA = et_fta,
    EqFTM = et_ftm,
    EqFT_PCT = et_ft_pct,
    EqMINUTES = et_minutes,
    EqOREB = et_oreb,
    EqPF = et_pf,
    EqPTS = et_pts,
    EqREB = et_reb,
    EqSTL = et_stl,
    EqTD = et_td,
    EqTOV = et_tov,
    GameID = game_id,
    GtAST = gt_ast,
    GtBLK = gt_blk,
    GtDD = gt_dd,
    GtDREB = gt_dreb,
    GtFG3A = gt_fg3a,
    GtFG3M = gt_fg3m,
    GtFG3_PCT = gt_fg3_pct,
    GtFGA = gt_fga,
    GtFGM = gt_fgm,
    GtFG_PCT = gt_fg_pct,
    GtFTA = gt_fta,
    GtFTM = gt_ftm,
    GtFT_PCT = gt_ft_pct,
    GtMINUTES = gt_minutes,
    GtOREB = gt_oreb,
    GtPF = gt_pf,
    GtPTS = gt_pts,
    GtREB = gt_reb,
    GtSTL = gt_stl,
    GtTD = gt_td,
    GtTOV = gt_tov,
    Location = location,
    LtAST = lt_ast,
    LtBLK = lt_blk,
    LtDD = lt_dd,
    LtDREB = lt_dreb,
    LtFG3A = lt_fg3a,
    LtFG3M = lt_fg3m,
    LtFG3_PCT = lt_fg3_pct,
    LtFGA = lt_fga,
    LtFGM = lt_fgm,
    LtFG_PCT = lt_fg_pct,
    LtFTA = lt_fta,
    LtFTM = lt_ftm,
    LtFT_PCT = lt_ft_pct,
    LtMINUTES = lt_minutes,
    LtOREB = lt_oreb,
    LtPF = lt_pf,
    LtPTS = lt_pts,
    LtREB = lt_reb,
    LtSTL = lt_stl,
    LtTD = lt_td,
    LtTOV = lt_tov,
    Outcome = outcome,
    PORound = po_round,
    PlayerID = player_id,
    PlayerOrTeam = player_or_team,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id,
    YearsExperience = years_experience
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league game finder data available for the given parameters!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API In-Season Tournament Standings**
#' @name nba_iststandings
NULL
#' @title
#' **Get NBA Stats API In-Season Tournament Standings**
#' @rdname nba_iststandings
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format: '2023-24'
#' @param section Section filter - 'group' or 'knockout'
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Standings
#'
#'    **Standings**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league_id \tab character \tab League identifier ('10' = WNBA). \cr
#'       season_year \tab character \tab Season year string ('YYYY-YY' format). \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       team_city \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       conference \tab character \tab Conference. \cr
#'       ist_group \tab character \tab Ist group. \cr
#'       clinch_indicator \tab character \tab Playoff clinch indicator (e.g. 'x' clinched playoff, 'e' eliminated). \cr
#'       clinched_ist_knockout \tab character \tab Clinched ist knockout. \cr
#'       clinched_ist_group \tab character \tab Clinched ist group. \cr
#'       clinched_ist_wildcard \tab character \tab Clinched ist wildcard. \cr
#'       ist_wildcard_rank \tab character \tab League/season rank for ist wildcard. \cr
#'       ist_group_rank \tab character \tab League/season rank for ist group. \cr
#'       ist_knockout_rank \tab character \tab League/season rank for ist knockout. \cr
#'       wins \tab character \tab Total wins. \cr
#'       losses \tab character \tab Total losses. \cr
#'       pct \tab character \tab Pct. \cr
#'       ist_group_gb \tab character \tab Ist group gb. \cr
#'       ist_wildcard_gb \tab character \tab Ist wildcard gb. \cr
#'       diff \tab character \tab Diff. \cr
#'       pts \tab character \tab Points scored. \cr
#'       opp_pts \tab character \tab Opponent points. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA League Functions
#' @details
#' ```r
#'  nba_iststandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_iststandings <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    section = 'group',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "iststandings"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    Section = section
  )

  df_list <- list()
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      teams <- resp %>%
        purrr::pluck("teams")

      if (length(teams) > 0) {
        league_id_val <- resp$leagueId %||% NA_character_
        season_year_val <- resp$seasonYear %||% NA_character_

        base_cols <- setdiff(colnames(teams), "games")
        base_data <- teams[, base_cols, drop = FALSE]

        if ("games" %in% colnames(teams)) {
          games_wide <- do.call(rbind, lapply(seq_len(nrow(teams)), function(i) {
            g <- teams$games[[i]]
            if (is.data.frame(g) && nrow(g) > 0) {
              do.call(cbind, lapply(seq_len(nrow(g)), function(j) {
                row_data <- as.list(g[j, ])
                num <- row_data$gameNumber %||% j
                row_data$gameNumber <- NULL
                names(row_data) <- paste0(names(row_data), num)
                data.frame(lapply(row_data, as.character), stringsAsFactors = FALSE)
              }))
            } else {
              data.frame(row.names = 1)
            }
          }))
          base_data <- dplyr::bind_cols(base_data, games_wide)
        }

        data <- base_data %>%
          dplyr::mutate(
            leagueId = as.character(league_id_val),
            seasonYear = as.character(season_year_val)
          ) %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("IST Standings from NBA.com", Sys.time())
      } else {
        data <- dplyr::tibble()
      }

      df_list <- c(list(data))
      names(df_list) <- c("Standings")

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no IST standings data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
