## Team Dashboard parameters are the same

#' **Get NBA Stats API Team Dashboard by Clutch Splits**
#' @name nba_teamdashboardbyclutch
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Clutch Splits**
#' @rdname nba_teamdashboardbyclutch
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Last10Sec3Point2TeamDashboard,
#' Last10Sec3PointTeamDashboard, Last1Min5PointTeamDashboard, Last1MinPlusMinus5PointTeamDashboard,
#' Last30Sec3Point2TeamDashboard, Last30Sec3PointTeamDashboard, Last3Min5PointTeamDashboard,
#' Last3MinPlusMinus5PointTeamDashboard, Last5Min5PointTeamDashboard,
#' Last5MinPlusMinus5PointTeamDashboard, OverallTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last5Min5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last3Min5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last1Min5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last30Sec3PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last10Sec3PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last5MinPlusMinus5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last3MinPlusMinus5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last1MinPlusMinus5PointTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last30Sec3Point2TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last10Sec3Point2TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Clutch Functions
#' @details
#' [Team Clutch Stats Dashboard](https://www.nba.com/stats/teams/clutch-traditional)
#' ```r
#'  nba_teamdashboardbyclutch(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbyclutch <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbyclutch"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by clutch data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Game Splits**
#' @name nba_teamdashboardbygamesplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Game Splits**
#' @rdname nba_teamdashboardbygamesplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ByActualMarginTeamDashboard,
#' ByHalfTeamDashboard, ByPeriodTeamDashboard, ByScoreMarginTeamDashboard,
#' OverallTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ByHalfTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ByPeriodTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ByScoreMarginTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ByActualMarginTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by Game Splits](https://www.nba.com/stats/team/1610612749/traditional?Split=ingame)
#' ```r
#'  nba_teamdashboardbygamesplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbygamesplits <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbygamesplits"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by game splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by General Splits**
#' @name nba_teamdashboardbygeneralsplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by General Splits**
#' @rdname nba_teamdashboardbygeneralsplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: DaysRestTeamDashboard,
#' LocationTeamDashboard, MonthTeamDashboard, OverallTeamDashboard,
#' PrePostAllStarTeamDashboard, WinsLossesTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |SEASON_YEAR     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **LocationTeamDashboard**
#'
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |GROUP_SET          |character |
#'    |GROUP_VALUE        |character |
#'    |TEAM_GAME_LOCATION |character |
#'    |GP                 |character |
#'    |W                  |character |
#'    |L                  |character |
#'    |W_PCT              |character |
#'    |MIN                |character |
#'    |FGM                |character |
#'    |FGA                |character |
#'    |FG_PCT             |character |
#'    |FG3M               |character |
#'    |FG3A               |character |
#'    |FG3_PCT            |character |
#'    |FTM                |character |
#'    |FTA                |character |
#'    |FT_PCT             |character |
#'    |OREB               |character |
#'    |DREB               |character |
#'    |REB                |character |
#'    |AST                |character |
#'    |TOV                |character |
#'    |STL                |character |
#'    |BLK                |character |
#'    |BLKA               |character |
#'    |PF                 |character |
#'    |PFD                |character |
#'    |PTS                |character |
#'    |PLUS_MINUS         |character |
#'    |GP_RANK            |character |
#'    |W_RANK             |character |
#'    |L_RANK             |character |
#'    |W_PCT_RANK         |character |
#'    |MIN_RANK           |character |
#'    |FGM_RANK           |character |
#'    |FGA_RANK           |character |
#'    |FG_PCT_RANK        |character |
#'    |FG3M_RANK          |character |
#'    |FG3A_RANK          |character |
#'    |FG3_PCT_RANK       |character |
#'    |FTM_RANK           |character |
#'    |FTA_RANK           |character |
#'    |FT_PCT_RANK        |character |
#'    |OREB_RANK          |character |
#'    |DREB_RANK          |character |
#'    |REB_RANK           |character |
#'    |AST_RANK           |character |
#'    |TOV_RANK           |character |
#'    |STL_RANK           |character |
#'    |BLK_RANK           |character |
#'    |BLKA_RANK          |character |
#'    |PF_RANK            |character |
#'    |PFD_RANK           |character |
#'    |PTS_RANK           |character |
#'    |PLUS_MINUS_RANK    |character |
#'
#'    **WinsLossesTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GAME_RESULT     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **MonthTeamDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |SEASON_MONTH_NAME |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PrePostAllStarTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |SEASON_SEGMENT  |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **DaysRestTeamDashboard**
#'
#'
#'    |col_name             |types     |
#'    |:--------------------|:---------|
#'    |GROUP_SET            |character |
#'    |GROUP_VALUE          |character |
#'    |TEAM_DAYS_REST_RANGE |character |
#'    |GP                   |character |
#'    |W                    |character |
#'    |L                    |character |
#'    |W_PCT                |character |
#'    |MIN                  |character |
#'    |FGM                  |character |
#'    |FGA                  |character |
#'    |FG_PCT               |character |
#'    |FG3M                 |character |
#'    |FG3A                 |character |
#'    |FG3_PCT              |character |
#'    |FTM                  |character |
#'    |FTA                  |character |
#'    |FT_PCT               |character |
#'    |OREB                 |character |
#'    |DREB                 |character |
#'    |REB                  |character |
#'    |AST                  |character |
#'    |TOV                  |character |
#'    |STL                  |character |
#'    |BLK                  |character |
#'    |BLKA                 |character |
#'    |PF                   |character |
#'    |PFD                  |character |
#'    |PTS                  |character |
#'    |PLUS_MINUS           |character |
#'    |GP_RANK              |character |
#'    |W_RANK               |character |
#'    |L_RANK               |character |
#'    |W_PCT_RANK           |character |
#'    |MIN_RANK             |character |
#'    |FGM_RANK             |character |
#'    |FGA_RANK             |character |
#'    |FG_PCT_RANK          |character |
#'    |FG3M_RANK            |character |
#'    |FG3A_RANK            |character |
#'    |FG3_PCT_RANK         |character |
#'    |FTM_RANK             |character |
#'    |FTA_RANK             |character |
#'    |FT_PCT_RANK          |character |
#'    |OREB_RANK            |character |
#'    |DREB_RANK            |character |
#'    |REB_RANK             |character |
#'    |AST_RANK             |character |
#'    |TOV_RANK             |character |
#'    |STL_RANK             |character |
#'    |BLK_RANK             |character |
#'    |BLKA_RANK            |character |
#'    |PF_RANK              |character |
#'    |PFD_RANK             |character |
#'    |PTS_RANK             |character |
#'    |PLUS_MINUS_RANK      |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by General Splits](https://www.nba.com/stats/team/1610612749/traditional?Split=general)
#' ```r
#'  nba_teamdashboardbygeneralsplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbygeneralsplits <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbygeneralsplits"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by general splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by Last N Games**
#' @name nba_teamdashboardbylastngames
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Last N Games**
#' @rdname nba_teamdashboardbylastngames
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: GameNumberTeamDashboard,
#' Last10TeamDashboard, Last15TeamDashboard, Last20TeamDashboard,
#' Last5TeamDashboard, OverallTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last5TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last10TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last15TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **Last20TeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **GameNumberTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by Last N Games](https://www.nba.com/stats/team/1610612749/traditional?Split=lastn)
#' ```r
#'  nba_teamdashboardbylastngames(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbylastngames <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbylastngames"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no teamdashboard by last n games data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by Opponent**
#' @name nba_teamdashboardbyopponent
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Opponent**
#' @rdname nba_teamdashboardbyopponent
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ConferenceTeamDashboard,
#' DivisionTeamDashboard, OpponentTeamDashboard, OverallTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ConferenceTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **DivisionTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **OpponentTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by Opponent](https://www.nba.com/stats/team/1610612749/traditional?Split=opp)
#' ```r
#'  nba_teamdashboardbyopponent(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbyopponent <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbyopponent"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by opponent data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Shooting Splits**
#' @name nba_teamdashboardbyshootingsplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Shooting Splits**
#' @rdname nba_teamdashboardbyshootingsplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: AssistedBy,
#' AssitedShotTeamDashboard, OverallTeamDashboard, Shot5FTTeamDashboard,
#' Shot8FTTeamDashboard, ShotAreaTeamDashboard, ShotTypeTeamDashboard
#'
#'    **OverallTeamDashboard**
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
#'    **Shot5FTTeamDashboard**
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
#'    **Shot8FTTeamDashboard**
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
#'    **ShotAreaTeamDashboard**
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
#'    **AssitedShotTeamDashboard**
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
#'    **ShotTypeTeamDashboard**
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
#' @family NBA Team Functions
#' @family NBA Shooting Functions
#' @details
#' [Team Dashboard by Shooting Splits](https://www.nba.com/stats/team/1610612749/shooting)
#' ```r
#'  nba_teamdashboardbyshootingsplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbyshootingsplits <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbyshootingsplits"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by shooting splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Team Performance**
#' @name nba_teamdashboardbyteamperformance
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Team Performance**
#' @rdname nba_teamdashboardbyteamperformance
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: OverallTeamDashboard,
#' PointsScoredTeamDashboard, PontsAgainstTeamDashboard, ScoreDifferentialTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ScoreDifferentialTeamDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE_ORDER |character |
#'    |GROUP_VALUE       |character |
#'    |GROUP_VALUE_2     |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PointsScoredTeamDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE_ORDER |character |
#'    |GROUP_VALUE       |character |
#'    |GROUP_VALUE_2     |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **PontsAgainstTeamDashboard**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE_ORDER |character |
#'    |GROUP_VALUE       |character |
#'    |GROUP_VALUE_2     |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by Team Performance](https://www.nba.com/stats/team/1610612749/traditional?Split=teamperf)
#' ```r
#'  nba_teamdashboardbyteamperformance(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbyteamperformance <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbyteamperformance"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom =  date_from,
    DateTo =  date_to,
    GameSegment =  game_segment,
    LastNGames =  last_n_games,
    LeagueID =  league_id,
    Location =  location,
    MeasureType =  measure_type,
    Month =  month,
    OpponentTeamID =  opponent_team_id,
    Outcome =  outcome,
    PaceAdjust =  pace_adjust,
    PORound =  po_round,
    PerMode =  per_mode,
    Period =  period,
    PlusMinus =  plus_minus,
    Rank =  rank,
    Season =  season,
    SeasonSegment =  season_segment,
    SeasonType =  season_type,
    ShotClockRange =  shot_clock_range,
    TeamID =  team_id,
    VsConference =  vs_conference,
    VsDivision =  vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by team performance data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard Year over Year**
#' @name nba_teamdashboardbyyearoveryear
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Year over Year**
#' @rdname nba_teamdashboardbyyearoveryear
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ByYearTeamDashboard, OverallTeamDashboard
#'
#'    **OverallTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#'    **ByYearTeamDashboard**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_VALUE     |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @details
#' [Team Dashboard by Year over Year](https://www.nba.com/stats/team/1610612749/traditional?Split=yoy)
#' ```r
#'  nba_teamdashboardbyyearoveryear(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashboardbyyearoveryear <- function(
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
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashboardbyyearoveryear"
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by year-over-year data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard - Lineups**
#' @name nba_teamdashlineups
NULL
#' @title
#' **Get NBA Stats API Team Dashboard - Lineups**
#' @rdname nba_teamdashlineups
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_id game_id
#' @param game_segment game_segment
#' @param group_quantity group_quantity
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Lineups, Overall
#'
#'    **Overall**
#'
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |GROUP_SET         |character |
#'    |GROUP_VALUE       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_ABBREVIATION |character |
#'    |TEAM_NAME         |character |
#'    |GP                |character |
#'    |W                 |character |
#'    |L                 |character |
#'    |W_PCT             |character |
#'    |MIN               |character |
#'    |FGM               |character |
#'    |FGA               |character |
#'    |FG_PCT            |character |
#'    |FG3M              |character |
#'    |FG3A              |character |
#'    |FG3_PCT           |character |
#'    |FTM               |character |
#'    |FTA               |character |
#'    |FT_PCT            |character |
#'    |OREB              |character |
#'    |DREB              |character |
#'    |REB               |character |
#'    |AST               |character |
#'    |TOV               |character |
#'    |STL               |character |
#'    |BLK               |character |
#'    |BLKA              |character |
#'    |PF                |character |
#'    |PFD               |character |
#'    |PTS               |character |
#'    |PLUS_MINUS        |character |
#'    |GP_RANK           |character |
#'    |W_RANK            |character |
#'    |L_RANK            |character |
#'    |W_PCT_RANK        |character |
#'    |MIN_RANK          |character |
#'    |FGM_RANK          |character |
#'    |FGA_RANK          |character |
#'    |FG_PCT_RANK       |character |
#'    |FG3M_RANK         |character |
#'    |FG3A_RANK         |character |
#'    |FG3_PCT_RANK      |character |
#'    |FTM_RANK          |character |
#'    |FTA_RANK          |character |
#'    |FT_PCT_RANK       |character |
#'    |OREB_RANK         |character |
#'    |DREB_RANK         |character |
#'    |REB_RANK          |character |
#'    |AST_RANK          |character |
#'    |TOV_RANK          |character |
#'    |STL_RANK          |character |
#'    |BLK_RANK          |character |
#'    |BLKA_RANK         |character |
#'    |PF_RANK           |character |
#'    |PFD_RANK          |character |
#'    |PTS_RANK          |character |
#'    |PLUS_MINUS_RANK   |character |
#'
#'    **Lineups**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |GROUP_SET       |character |
#'    |GROUP_ID        |character |
#'    |GROUP_NAME      |character |
#'    |GP              |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_PCT           |character |
#'    |MIN             |character |
#'    |FGM             |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3M            |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FTM             |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |AST             |character |
#'    |TOV             |character |
#'    |STL             |character |
#'    |BLK             |character |
#'    |BLKA            |character |
#'    |PF              |character |
#'    |PFD             |character |
#'    |PTS             |character |
#'    |PLUS_MINUS      |character |
#'    |GP_RANK         |character |
#'    |W_RANK          |character |
#'    |L_RANK          |character |
#'    |W_PCT_RANK      |character |
#'    |MIN_RANK        |character |
#'    |FGM_RANK        |character |
#'    |FGA_RANK        |character |
#'    |FG_PCT_RANK     |character |
#'    |FG3M_RANK       |character |
#'    |FG3A_RANK       |character |
#'    |FG3_PCT_RANK    |character |
#'    |FTM_RANK        |character |
#'    |FTA_RANK        |character |
#'    |FT_PCT_RANK     |character |
#'    |OREB_RANK       |character |
#'    |DREB_RANK       |character |
#'    |REB_RANK        |character |
#'    |AST_RANK        |character |
#'    |TOV_RANK        |character |
#'    |STL_RANK        |character |
#'    |BLK_RANK        |character |
#'    |BLKA_RANK       |character |
#'    |PF_RANK         |character |
#'    |PFD_RANK        |character |
#'    |PTS_RANK        |character |
#'    |PLUS_MINUS_RANK |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Lineup Functions
#' @details
#' [Team Lineups Dashboard](https://www.nba.com/stats/team/1610612749/lineups-traditional)
#' ```r
#'  nba_teamdashlineups(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashlineups <- function(
    date_from = '',
    date_to = '',
    game_id = '',
    game_segment = '',
    group_quantity = 5,
    last_n_games = 0,
    league_id = '00',
    location = '',
    measure_type = 'Base',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    pace_adjust = 'N',
    plus_minus = 'N',
    po_round = '',
    per_mode = 'Totals',
    period = 0,
    rank = 'N',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashlineups"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    DateFrom = date_from,
    DateTo = date_to,
    GameID = game_id,
    GameSegment = game_segment,
    GroupQuantity = group_quantity,
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
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by lineups data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard Player Tracking - Passing**
#' @name nba_teamdashptpass
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Passing**
#' @rdname nba_teamdashptpass
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
#'    |TEAM_ID                 |character |
#'    |TEAM_NAME               |character |
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
#'    **PassesReceived**
#'
#'
#'    |col_name                |types     |
#'    |:-----------------------|:---------|
#'    |TEAM_ID                 |character |
#'    |TEAM_NAME               |character |
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Team Player Tracking (Second Spectrum) Stats - Passing](https://www.nba.com/stats/team/1610612749/passes-dash)
#' ```r
#'  nba_teamdashptpass(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashptpass  <- function(
    date_from = '',
    date_to = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    per_mode = 'Totals',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashptpass"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking passing data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard Player Tracking - Rebounding**
#' @name nba_teamdashptreb
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Rebounding**
#' @rdname nba_teamdashptreb
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
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: NumContestedRebounding, OverallRebounding,
#' RebDistanceRebounding, ShotDistanceRebounding, ShotTypeRebounding
#'
#'    **OverallRebounding**
#'
#'
#'    |col_name      |types     |
#'    |:-------------|:---------|
#'    |TEAM_ID       |character |
#'    |TEAM_NAME     |character |
#'    |G             |character |
#'    |OVERALL       |character |
#'    |REB_FREQUENCY |character |
#'    |OREB          |character |
#'    |DREB          |character |
#'    |REB           |character |
#'    |C_OREB        |character |
#'    |C_DREB        |character |
#'    |C_REB         |character |
#'    |C_REB_PCT     |character |
#'    |UC_OREB       |character |
#'    |UC_DREB       |character |
#'    |UC_REB        |character |
#'    |UC_REB_PCT    |character |
#'
#'    **ShotTypeRebounding**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |TEAM_ID         |character |
#'    |TEAM_NAME       |character |
#'    |SORT_ORDER      |character |
#'    |G               |character |
#'    |SHOT_TYPE_RANGE |character |
#'    |REB_FREQUENCY   |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |C_OREB          |character |
#'    |C_DREB          |character |
#'    |C_REB           |character |
#'    |C_REB_PCT       |character |
#'    |UC_OREB         |character |
#'    |UC_DREB         |character |
#'    |UC_REB          |character |
#'    |UC_REB_PCT      |character |
#'
#'    **NumContestedRebounding**
#'
#'
#'    |col_name                 |types     |
#'    |:------------------------|:---------|
#'    |TEAM_ID                  |character |
#'    |TEAM_NAME                |character |
#'    |SORT_ORDER               |character |
#'    |G                        |character |
#'    |REB_NUM_CONTESTING_RANGE |character |
#'    |REB_FREQUENCY            |character |
#'    |OREB                     |character |
#'    |DREB                     |character |
#'    |REB                      |character |
#'    |C_OREB                   |character |
#'    |C_DREB                   |character |
#'    |C_REB                    |character |
#'    |C_REB_PCT                |character |
#'    |UC_OREB                  |character |
#'    |UC_DREB                  |character |
#'    |UC_REB                   |character |
#'    |UC_REB_PCT               |character |
#'
#'    **ShotDistanceRebounding**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |TEAM_ID         |character |
#'    |TEAM_NAME       |character |
#'    |SORT_ORDER      |character |
#'    |G               |character |
#'    |SHOT_DIST_RANGE |character |
#'    |REB_FREQUENCY   |character |
#'    |OREB            |character |
#'    |DREB            |character |
#'    |REB             |character |
#'    |C_OREB          |character |
#'    |C_DREB          |character |
#'    |C_REB           |character |
#'    |C_REB_PCT       |character |
#'    |UC_OREB         |character |
#'    |UC_DREB         |character |
#'    |UC_REB          |character |
#'    |UC_REB_PCT      |character |
#'
#'    **RebDistanceRebounding**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |TEAM_ID        |character |
#'    |TEAM_NAME      |character |
#'    |SORT_ORDER     |character |
#'    |G              |character |
#'    |REB_DIST_RANGE |character |
#'    |REB_FREQUENCY  |character |
#'    |OREB           |character |
#'    |DREB           |character |
#'    |REB            |character |
#'    |C_OREB         |character |
#'    |C_DREB         |character |
#'    |C_REB          |character |
#'    |C_REB_PCT      |character |
#'    |UC_OREB        |character |
#'    |UC_DREB        |character |
#'    |UC_REB         |character |
#'    |UC_REB_PCT     |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Team Player Tracking (Second Spectrum) Stats - Rebounds](https://www.nba.com/stats/team/1610612749/rebounds-dash)
#' ```r
#'  nba_teamdashptreb(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashptreb  <- function(
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
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashptreb"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking rebounding data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Team Dashboard Player Tracking - Shots**
#' @name nba_teamdashptshots
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Shots**
#' @rdname nba_teamdashptshots
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
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: ClosestDefender10ftPlusShooting,
#' ClosestDefenderShooting, DribbleShooting, GeneralShooting, ShotClockShooting,
#' TouchTimeShooting
#'
#'    **GeneralShooting**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |TEAM_ID        |character |
#'    |TEAM_NAME      |character |
#'    |SORT_ORDER     |character |
#'    |G              |character |
#'    |SHOT_TYPE      |character |
#'    |FGA_FREQUENCY  |character |
#'    |FGM            |character |
#'    |FGA            |character |
#'    |FG_PCT         |character |
#'    |EFG_PCT        |character |
#'    |FG2A_FREQUENCY |character |
#'    |FG2M           |character |
#'    |FG2A           |character |
#'    |FG2_PCT        |character |
#'    |FG3A_FREQUENCY |character |
#'    |FG3M           |character |
#'    |FG3A           |character |
#'    |FG3_PCT        |character |
#'
#'    **ShotClockShooting**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |TEAM_ID          |character |
#'    |TEAM_NAME        |character |
#'    |SORT_ORDER       |character |
#'    |G                |character |
#'    |SHOT_CLOCK_RANGE |character |
#'    |FGA_FREQUENCY    |character |
#'    |FGM              |character |
#'    |FGA              |character |
#'    |FG_PCT           |character |
#'    |EFG_PCT          |character |
#'    |FG2A_FREQUENCY   |character |
#'    |FG2M             |character |
#'    |FG2A             |character |
#'    |FG2_PCT          |character |
#'    |FG3A_FREQUENCY   |character |
#'    |FG3M             |character |
#'    |FG3A             |character |
#'    |FG3_PCT          |character |
#'
#'    **DribbleShooting**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |TEAM_ID        |character |
#'    |TEAM_NAME      |character |
#'    |SORT_ORDER     |character |
#'    |G              |character |
#'    |DRIBBLE_RANGE  |character |
#'    |FGA_FREQUENCY  |character |
#'    |FGM            |character |
#'    |FGA            |character |
#'    |FG_PCT         |character |
#'    |EFG_PCT        |character |
#'    |FG2A_FREQUENCY |character |
#'    |FG2M           |character |
#'    |FG2A           |character |
#'    |FG2_PCT        |character |
#'    |FG3A_FREQUENCY |character |
#'    |FG3M           |character |
#'    |FG3A           |character |
#'    |FG3_PCT        |character |
#'
#'    **ClosestDefenderShooting**
#'
#'
#'    |col_name             |types     |
#'    |:--------------------|:---------|
#'    |TEAM_ID              |character |
#'    |TEAM_NAME            |character |
#'    |SORT_ORDER           |character |
#'    |G                    |character |
#'    |CLOSE_DEF_DIST_RANGE |character |
#'    |FGA_FREQUENCY        |character |
#'    |FGM                  |character |
#'    |FGA                  |character |
#'    |FG_PCT               |character |
#'    |EFG_PCT              |character |
#'    |FG2A_FREQUENCY       |character |
#'    |FG2M                 |character |
#'    |FG2A                 |character |
#'    |FG2_PCT              |character |
#'    |FG3A_FREQUENCY       |character |
#'    |FG3M                 |character |
#'    |FG3A                 |character |
#'    |FG3_PCT              |character |
#'
#'    **ClosestDefender10ftPlusShooting**
#'
#'
#'    |col_name             |types     |
#'    |:--------------------|:---------|
#'    |TEAM_ID              |character |
#'    |TEAM_NAME            |character |
#'    |SORT_ORDER           |character |
#'    |G                    |character |
#'    |CLOSE_DEF_DIST_RANGE |character |
#'    |FGA_FREQUENCY        |character |
#'    |FGM                  |character |
#'    |FGA                  |character |
#'    |FG_PCT               |character |
#'    |EFG_PCT              |character |
#'    |FG2A_FREQUENCY       |character |
#'    |FG2M                 |character |
#'    |FG2A                 |character |
#'    |FG2_PCT              |character |
#'    |FG3A_FREQUENCY       |character |
#'    |FG3M                 |character |
#'    |FG3A                 |character |
#'    |FG3_PCT              |character |
#'
#'    **TouchTimeShooting**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |TEAM_ID          |character |
#'    |TEAM_NAME        |character |
#'    |SORT_ORDER       |character |
#'    |G                |character |
#'    |TOUCH_TIME_RANGE |character |
#'    |FGA_FREQUENCY    |character |
#'    |FGM              |character |
#'    |FGA              |character |
#'    |FG_PCT           |character |
#'    |EFG_PCT          |character |
#'    |FG2A_FREQUENCY   |character |
#'    |FG2M             |character |
#'    |FG2A             |character |
#'    |FG2_PCT          |character |
#'    |FG3A_FREQUENCY   |character |
#'    |FG3M             |character |
#'    |FG3A             |character |
#'    |FG3_PCT          |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Team Functions
#' @family NBA Player Tracking Functions
#' @details
#' [Team Player Tracking (Second Spectrum) Stats - Shooting](https://www.nba.com/stats/team/1610612749/shots-dash)
#' ```r
#'  nba_teamdashptshots(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_teamdashptshots  <- function(
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
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = '1610612749',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "teamdashptshots"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking shooting data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
