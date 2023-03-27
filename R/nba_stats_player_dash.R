## Player Dashboard parameters are the same

#' **Get NBA Stats API Player Dashboard by Clutch Splits**
#' @name nba_playerdashboardbyclutch
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Clutch Splits**
#' @rdname nba_playerdashboardbyclutch
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Last10Sec3Point2PlayerDashboard,
#' Last10Sec3PointPlayerDashboard, Last1Min5PointPlayerDashboard,
#' Last1MinPlusMinus5PointPlayerDashboard, Last30Sec3Point2PlayerDashboard,
#'  Last30Sec3PointPlayerDashboard, Last3Min5PointPlayerDashboard,
#' Last3MinPlusMinus5PointPlayerDashboard, Last5Min5PointPlayerDashboard,
#' Last5MinPlusMinus5PointPlayerDashboard,  OverallPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last5Min5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last3Min5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last1Min5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last30Sec3PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last10Sec3PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last5MinPlusMinus5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last3MinPlusMinus5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last1MinPlusMinus5PointPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last30Sec3Point2PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last10Sec3Point2PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Clutch Functions
#' @details
#' [Player Clutch Stats Dashboard](https://www.nba.com/stats/players/clutch-traditional)
#' ```r
#'  nba_playerdashboardbyclutch(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbyclutch <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbyclutch"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player dashboard by clutch splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Game Splits**
#' @name nba_playerdashboardbygamesplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Game Splits**
#' @rdname nba_playerdashboardbygamesplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ByActualMarginPlayerDashboard,
#' ByHalfPlayerDashboard, ByPeriodPlayerDashboard, ByScoreMarginPlayerDashboard,
#' OverallPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ByHalfPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ByPeriodPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ByScoreMarginPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ByActualMarginPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by Game Splits](https://www.nba.com/stats/player/2544/traditional?Split=ingame)
#' ```r
#'  nba_playerdashboardbygamesplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbygamesplits <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbygamesplits"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player dashboard by game splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by General Splits**
#' @name nba_playerdashboardbygeneralsplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by General Splits**
#' @rdname nba_playerdashboardbygeneralsplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: DaysRestPlayerDashboard, LocationPlayerDashboard,
#' MonthPlayerDashboard, OverallPlayerDashboard, PrePostAllStarPlayerDashboard,
#' StartingPosition, WinsLossesPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **LocationPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **WinsLossesPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **MonthPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **PrePostAllStarPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **StartingPosition**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **DaysRestPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by General Splits](https://www.nba.com/stats/player/2544/traditional)
#' ```r
#'  nba_playerdashboardbygeneralsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbygeneralsplits <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbygeneralsplits"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by general splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by Last N Games**
#' @name nba_playerdashboardbylastngames
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Last N Games**
#' @rdname nba_playerdashboardbylastngames
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: GameNumberPlayerDashboard, Last10PlayerDashboard,
#'  Last15PlayerDashboard, Last20PlayerDashboard,
#' Last5PlayerDashboard, OverallPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last5PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last10PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last15PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **Last20PlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **GameNumberPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by Last N Games](https://www.nba.com/stats/player/2544/traditional?Split=lastn)
#' ```r
#'  nba_playerdashboardbylastngames(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbylastngames <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbylastngames"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by last n games data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by Opponent**
#' @name nba_playerdashboardbyopponent
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Opponent**
#' @rdname nba_playerdashboardbyopponent
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ConferencePlayerDashboard,
#' DivisionPlayerDashboard, OpponentPlayerDashboard, OverallPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ConferencePlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **DivisionPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **OpponentPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by Opponent](https://www.nba.com/stats/player/2544/traditional?Split=opp)
#' ```r
#'  nba_playerdashboardbyopponent(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbyopponent <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbyopponent"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by opponent data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Shooting Splits**
#' @name nba_playerdashboardbyshootingsplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Shooting Splits**
#' @rdname nba_playerdashboardbyshootingsplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: AssistedBy, AssitedShotPlayerDashboard,
#'  OverallPlayerDashboard, Shot5FTPlayerDashboard, Shot8FTPlayerDashboard,
#'  ShotAreaPlayerDashboard, ShotTypePlayerDashboard, ShotTypeSummaryPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **Shot5FTPlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **Shot8FTPlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **ShotAreaPlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **AssitedShotPlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **ShotTypeSummaryPlayerDashboard**
#'
#'
#'    |col_name     |types     |
#'    |:------------|:---------|
#'    |GROUP_SET    |character |
#'    |GROUP_VALUE  |character |
#'    |FGM          |character |
#'    |FGA          |character |
#'    |FG_PCT       |character |
#'    |FG3M         |character |
#'    |FG3A         |character |
#'    |FG3_PCT      |character |
#'    |EFG_PCT      |character |
#'    |BLKA         |character |
#'    |PCT_AST_2PM  |character |
#'    |PCT_UAST_2PM |character |
#'    |PCT_AST_3PM  |character |
#'    |PCT_UAST_3PM |character |
#'    |PCT_AST_FGM  |character |
#'    |PCT_UAST_FGM |character |
#'
#'    **ShotTypePlayerDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#'    **AssistedBy**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |PLAYER_ID         |character |
#'    |PLAYER_NAME       |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |EFG_PCT           |character |
#'    |BLKA              |character |
#'    |PCT_AST_2PM       |character |
#'    |PCT_UAST_2PM      |character |
#'    |PCT_AST_3PM       |character |
#'    |PCT_UAST_3PM      |character |
#'    |PCT_AST_FGM       |character |
#'    |PCT_UAST_FGM      |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |EFG_PCT_RANK      |character |
#'    |BLKA_RANK         |character |
#'    |PCT_AST_2PM_RANK  |character |
#'    |PCT_UAST_2PM_RANK |character |
#'    |PCT_AST_3PM_RANK  |character |
#'    |PCT_UAST_3PM_RANK |character |
#'    |PCT_AST_FGM_RANK  |character |
#'    |PCT_UAST_FGM_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Shooting Functions
#' @details
#' [Player Stats Dashboard by Shooting Splits](https://www.nba.com/stats/player/2544/shooting)
#' ```r
#'  nba_playerdashboardbyshootingsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbyshootingsplits <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbyshootingsplits"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by shooting splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Team Performance**
#' @name nba_playerdashboardbyteamperformance
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Team Performance**
#' @rdname nba_playerdashboardbyteamperformance
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: OverallPlayerDashboard,
#' PointsScoredPlayerDashboard, PointsAgainstPlayerDashboard,
#' ScoreDifferentialPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ScoreDifferentialPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE_ORDER     |character |
#'    |GROUP_VALUE           |character |
#'    |GROUP_VALUE_2         |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **PointsScoredPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE_ORDER     |character |
#'    |GROUP_VALUE           |character |
#'    |GROUP_VALUE_2         |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **PontsAgainstPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE_ORDER     |character |
#'    |GROUP_VALUE           |character |
#'    |GROUP_VALUE_2         |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by Team Performance](https://www.nba.com/stats/player/2544/traditional?Split=teamperf&PerMode=PerGame)
#' ```r
#'  nba_playerdashboardbyteamperformance(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbyteamperformance <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbyteamperformance"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by team performance data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Year over Year**
#' @name nba_playerdashboardbyyearoveryear
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Year over Year**
#' @rdname nba_playerdashboardbyyearoveryear
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ByYearPlayerDashboard, OverallPlayerDashboard
#'
#'    **OverallPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |TEAM_ID               |character |
#'    |TEAM_ABBREVIATION     |character |
#'    |MAX_GAME_DATE         |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#'    **ByYearPlayerDashboard**
#'
#'
#'    |col_name              |types     |
#'    |:---------------------|:---------|
#'    |GROUP_SET             |character |
#'    |GROUP_VALUE           |character |
#'    |TEAM_ID               |character |
#'    |TEAM_ABBREVIATION     |character |
#'    |MAX_GAME_DATE         |character |
#'    |GP                    |character |
#'    |W                     |character |
#'    |L                     |character |
#'    |W_PCT                 |character |
#'    |MIN                   |character |
#'    |FGM                   |character |
#'    |FGA                   |character |
#'    |FG_PCT                |character |
#'    |FG3M                  |character |
#'    |FG3A                  |character |
#'    |FG3_PCT               |character |
#'    |FTM                   |character |
#'    |FTA                   |character |
#'    |FT_PCT                |character |
#'    |OREB                  |character |
#'    |DREB                  |character |
#'    |REB                   |character |
#'    |AST                   |character |
#'    |TOV                   |character |
#'    |STL                   |character |
#'    |BLK                   |character |
#'    |BLKA                  |character |
#'    |PF                    |character |
#'    |PFD                   |character |
#'    |PTS                   |character |
#'    |PLUS_MINUS            |character |
#'    |NBA_FANTASY_PTS       |character |
#'    |DD2                   |character |
#'    |TD3                   |character |
#'    |WNBA_FANTASY_PTS      |character |
#'    |GP_RANK               |character |
#'    |W_RANK                |character |
#'    |L_RANK                |character |
#'    |W_PCT_RANK            |character |
#'    |MIN_RANK              |character |
#'    |FGM_RANK              |character |
#'    |FGA_RANK              |character |
#'    |FG_PCT_RANK           |character |
#'    |FG3M_RANK             |character |
#'    |FG3A_RANK             |character |
#'    |FG3_PCT_RANK          |character |
#'    |FTM_RANK              |character |
#'    |FTA_RANK              |character |
#'    |FT_PCT_RANK           |character |
#'    |OREB_RANK             |character |
#'    |DREB_RANK             |character |
#'    |REB_RANK              |character |
#'    |AST_RANK              |character |
#'    |TOV_RANK              |character |
#'    |STL_RANK              |character |
#'    |BLK_RANK              |character |
#'    |BLKA_RANK             |character |
#'    |PF_RANK               |character |
#'    |PFD_RANK              |character |
#'    |PTS_RANK              |character |
#'    |PLUS_MINUS_RANK       |character |
#'    |NBA_FANTASY_PTS_RANK  |character |
#'    |DD2_RANK              |character |
#'    |TD3_RANK              |character |
#'    |WNBA_FANTASY_PTS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Stats Dashboard by Team Performance](https://www.nba.com/stats/player/2544/traditional?Split=yoy&PerMode=PerGame)
#' ```r
#'  nba_playerdashboardbyyearoveryear(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashboardbyyearoveryear <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    po_round = '',
    pace_adjust = 'N',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    plus_minus = 'N',
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashboardbyyearoveryear"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard year-over-year data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Dashboard Player Tracking - Passing**
#' @name nba_playerdashptpass
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Passing**
#' @rdname nba_playerdashptpass
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: PassesMade, PassesReceived
#'
#'    **PassesMade**
#'
#'
#'    |col_name                |types     |
#'    |:-----------------------|:---------|
#'    |PLAYER_ID               |character |
#'    |PLAYER_NAME_LAST_FIRST  |character |
#'    |TEAM_NAME               |character |
#'    |TEAM_ID                 |character |
#'    |TEAM_ABBREVIATION       |character |
#'    |PASS_TYPE               |character |
#'    |G                       |character |
#'    |PASS_TO                 |character |
#'    |PASS_TEAMMATE_PLAYER_ID |character |
#'    |FREQUENCY               |character |
#'    |PASS                    |character |
#'    |AST                     |character |
#'    |FGM                     |character |
#'    |FGA                     |character |
#'    |FG_PCT                  |character |
#'    |FG2M                    |character |
#'    |FG2A                    |character |
#'    |FG2_PCT                 |character |
#'    |FG3M                    |character |
#'    |FG3A                    |character |
#'    |FG3_PCT                 |character |
#'
#'    **PassesReceived**
#'
#'
#'    |col_name                |types     |
#'    |:-----------------------|:---------|
#'    |PLAYER_ID               |character |
#'    |PLAYER_NAME_LAST_FIRST  |character |
#'    |TEAM_NAME               |character |
#'    |TEAM_ID                 |character |
#'    |TEAM_ABBREVIATION       |character |
#'    |PASS_TYPE               |character |
#'    |G                       |character |
#'    |PASS_FROM               |character |
#'    |PASS_TEAMMATE_PLAYER_ID |character |
#'    |FREQUENCY               |character |
#'    |PASS                    |character |
#'    |AST                     |character |
#'    |FGM                     |character |
#'    |FGA                     |character |
#'    |FG_PCT                  |character |
#'    |FG2M                    |character |
#'    |FG2A                    |character |
#'    |FG2_PCT                 |character |
#'    |FG3M                    |character |
#'    |FG3A                    |character |
#'    |FG3_PCT                 |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Player Tracking (Second Spectrum) Stats - Passing](https://www.nba.com/stats/player/2544/passes-dash)
#' ```r
#'  nba_playerdashptpass(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashptpass  <- function(
    date_from = '',
    date_to = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    per_mode = 'Totals',
    player_id = '2544',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '0',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashptpass"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PerMode = per_mode,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking passing data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Player Tracking - Rebounding**
#' @name nba_playerdashptreb
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Rebounding**
#' @rdname nba_playerdashptreb
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: NumContestedRebounding,
#' OverallRebounding, RebDistanceRebounding,
#' ShotDistanceRebounding, ShotTypeRebounding
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Player Tracking (Second Spectrum) Stats - Rebounding](https://www.nba.com/stats/player/2544/rebounds-dash)
#' ```r
#'  nba_playerdashptreb(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashptreb  <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '0',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashptreb"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking rebounding data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard Player Tracking - Defense**
#' @name nba_playerdashptshotdefend
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Defense**
#' @rdname nba_playerdashptshotdefend
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: DefendingShots
#'
#'    **DefendingShots**
#'
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |CLOSE_DEF_playerId |character |
#'    |GP                 |character |
#'    |G                  |character |
#'    |DEFENSE_CATEGORY   |character |
#'    |FREQ               |character |
#'    |D_FGM              |character |
#'    |D_FGA              |character |
#'    |D_FG_PCT           |character |
#'    |NORMAL_FG_PCT      |character |
#'    |PCT_PLUSMINUS      |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Player Tracking (Second Spectrum) Stats - Defending](https://www.nba.com/stats/player/2544/defense-dash)
#' ```r
#'  nba_playerdashptshotdefend(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashptshotdefend  <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '0',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashptshotdefend"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking shot defense data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Player Tracking - Shots**
#' @name nba_playerdashptshots
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Shots**
#' @rdname nba_playerdashptshots
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ClosestDefender10ftPlusShooting,
#' ClosestDefenderShooting, DribbleShooting,
#' GeneralShooting, Overall, ShotClockShooting, TouchTimeShooting
#'
#'    **Overall**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |SHOT_TYPE              |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **GeneralShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |SHOT_TYPE              |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **ShotClockShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |SHOT_CLOCK_RANGE       |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **DribbleShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |DRIBBLE_RANGE          |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **ClosestDefenderShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |CLOSE_DEF_DIST_RANGE   |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **ClosestDefender10ftPlusShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |CLOSE_DEF_DIST_RANGE   |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#'    **TouchTimeShooting**
#'
#'
#'    |col_name               |types     |
#'    |:----------------------|:---------|
#'    |PLAYER_ID              |character |
#'    |PLAYER_NAME_LAST_FIRST |character |
#'    |SORT_ORDER             |character |
#'    |GP                     |character |
#'    |G                      |character |
#'    |TOUCH_TIME_RANGE       |character |
#'    |FGA_FREQUENCY          |character |
#'    |FGM                    |character |
#'    |FGA                    |character |
#'    |FG_PCT                 |character |
#'    |EFG_PCT                |character |
#'    |FG2A_FREQUENCY         |character |
#'    |FG2M                   |character |
#'    |FG2A                   |character |
#'    |FG2_PCT                |character |
#'    |FG3A_FREQUENCY         |character |
#'    |FG3M                   |character |
#'    |FG3A                   |character |
#'    |FG3_PCT                |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Player Tracking (Second Spectrum) Stats - Shooting](https://www.nba.com/stats/player/2544/shots-dash)
#' ```r
#'  nba_playerdashptshots(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_playerdashptshots  <- function(
    date_from = '',
    date_to = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    per_mode = 'Totals',
    period = 0,
    player_id = '2544',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '0',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerdashptshots"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking shots data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API Synergy Play Type Stats**
#' @name nba_synergyplaytypes
NULL
#' @title
#' **Get NBA Stats API Synergy Play Type Stats**
#' @rdname nba_synergyplaytypes
#' @author Saiem Gilani
#' @param league_id league_id
#' @param per_mode per_mode
#' @param play_type play_type - 'Isolation', 'Transition', 'PRBallHandler', 'PRRollman', 'Postup',
#'  'Spotup', 'Handoff', 'Cut', 'OffScreen', 'OffRebound', 'Misc'
#' @param player_or_team player_or_team ('P' or 'T')
#' @param season_type season_type
#' @param season season
#' @param type_grouping type_grouping - Offensive, Defensive
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return  Return a named list of data frames: SynergyPlayType
#'
#'    **SynergyPlayType**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |SEASON_ID         |character |
#'    |PLAYER_ID         |character |
#'    |PLAYER_NAME       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |PLAY_TYPE         |character |
#'    |TYPE_GROUPING     |character |
#'    |PERCENTILE        |character |
#'    |GP                |character |
#'    |POSS_PCT          |character |
#'    |PPP               |character |
#'    |FG_PCT            |character |
#'    |FT_POSS_PCT       |character |
#'    |TOV_POSS_PCT      |character |
#'    |SF_POSS_PCT       |character |
#'    |PLUSONE_POSS_PCT  |character |
#'    |SCORE_POSS_PCT    |character |
#'    |EFG_PCT           |character |
#'    |POSS              |character |
#'    |PTS               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FGMX              |character |
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Tracking Functions
#' @details
#' [Synergy Play Type Stats](https://www.nba.com/stats/teams/isolation)
#' ```r
#'  nba_synergyplaytypes(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_synergyplaytypes <- function(
    league_id = '00',
    per_mode = 'PerGame',
    play_type = 'Isolation',
    player_or_team = 'P',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    type_grouping = 'Offensive',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "synergyplaytypes"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    PlayType = play_type,
    PlayerOrTeam = player_or_team,
    SeasonType = season_type,
    SeasonYear = season,
    TypeGrouping = type_grouping
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no Synergy play types data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
