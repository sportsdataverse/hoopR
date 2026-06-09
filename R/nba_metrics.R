# ---------------------------------------------------------------------------
# Basketball analytics utilities (pure, vectorized -- no network calls)
# ---------------------------------------------------------------------------
#
# Standard efficiency / rating / four-factor formulas from the Basketball-
# Reference glossary (https://www.basketball-reference.com/about/glossary.html).
# Every function is vectorized over its numeric inputs and returns NA where a
# denominator would be zero. Box-score column names follow the hoopR /
# stats.nba.com convention (pts, fgm, fga, fg3m, fta, ftm, oreb, dreb, ast, stl,
# blk, tov, pf). These are league-agnostic -- they work on NBA, WNBA and college
# box scores alike.

.nz <- function(x) ifelse(is.na(x) | x == 0, NA_real_, x)

#' @title **True Shooting Percentage**
#' @description Points per shooting possession:
#'   `PTS / (2 * (FGA + 0.44 * FTA))`.
#' @param pts,fga,fta Numeric vectors: points, field-goal attempts, free-throw attempts.
#' @return A numeric vector of true-shooting percentages (0-1 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_true_shooting_pct(pts = 30, fga = 20, fta = 8)
nba_true_shooting_pct <- function(pts, fga, fta) {
  pts / .nz(2 * (fga + 0.44 * fta))
}

#' @title **Effective Field Goal Percentage**
#' @description Field-goal percentage adjusted for the extra value of the
#'   three-pointer: `(FGM + 0.5 * FG3M) / FGA`.
#' @param fgm,fg3m,fga Numeric vectors: field goals made, three-pointers made, field-goal attempts.
#' @return A numeric vector of effective field-goal percentages (0-1 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_effective_fg_pct(fgm = 10, fg3m = 4, fga = 20)
nba_effective_fg_pct <- function(fgm, fg3m, fga) {
  (fgm + 0.5 * fg3m) / .nz(fga)
}

#' @title **Free Throw Rate**
#' @description Free-throw attempts per field-goal attempt: `FTA / FGA`.
#' @param fta,fga Numeric vectors: free-throw attempts, field-goal attempts.
#' @return A numeric vector.
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_ft_rate(fta = 8, fga = 20)
nba_ft_rate <- function(fta, fga) {
  fta / .nz(fga)
}

#' @title **Game Score**
#' @description John Hollinger's single-game player rating, roughly scaled like
#'   points (a Game Score of 40 is outstanding, 10 is an average starter).
#' @param pts,fgm,fga,fta,ftm,oreb,dreb,stl,ast,blk,pf,tov Numeric vectors of box-score totals.
#' @return A numeric vector of game scores.
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' nba_game_score(pts = 30, fgm = 10, fga = 20, fta = 8, ftm = 7,
#'                oreb = 1, dreb = 6, stl = 2, ast = 8, blk = 1, pf = 2, tov = 3)
nba_game_score <- function(pts, fgm, fga, fta, ftm, oreb, dreb, stl, ast, blk, pf, tov) {
  pts + 0.4 * fgm - 0.7 * fga - 0.4 * (fta - ftm) +
    0.7 * oreb + 0.3 * dreb + stl + 0.7 * ast + 0.7 * blk - 0.4 * pf - tov
}

#' @title **Assist-to-Turnover Ratio**
#' @param ast,tov Numeric vectors: assists, turnovers.
#' @return A numeric vector (`NA` when turnovers are 0).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_assist_to_turnover(ast = 8, tov = 3)
nba_assist_to_turnover <- function(ast, tov) {
  ast / .nz(tov)
}

#' @title **Estimated Possessions**
#' @description Simple single-team possession estimate:
#'   `FGA + 0.44 * FTA - OREB + TOV`. For a more exact figure use the full
#'   possessions formula with opponent inputs.
#' @param fga,fta,oreb,tov Numeric vectors: field-goal attempts, free-throw attempts, offensive rebounds, turnovers.
#' @return A numeric vector of estimated possessions.
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_possessions(fga = 88, fta = 25, oreb = 10, tov = 13)
nba_possessions <- function(fga, fta, oreb, tov) {
  fga + 0.44 * fta - oreb + tov
}

#' @title **Pace (possessions per 48 minutes)**
#' @param poss Numeric vector of possessions (e.g. from [nba_possessions()]).
#' @param minutes Numeric vector of total team minutes played (player-minutes; 240
#'   for a regulation game).
#' @return A numeric vector of pace (possessions per 48 minutes).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_pace(poss = 100, minutes = 240)
nba_pace <- function(poss, minutes) {
  48 * poss / .nz(minutes / 5)
}

#' @title **Offensive Rating (points per 100 possessions)**
#' @param pts,poss Numeric vectors: points scored, possessions.
#' @return A numeric vector of points per 100 possessions.
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_offensive_rating(pts = 115, poss = 100)
nba_offensive_rating <- function(pts, poss) {
  100 * pts / .nz(poss)
}

#' @title **Defensive Rating (points allowed per 100 possessions)**
#' @param opp_pts,poss Numeric vectors: opponent points, possessions.
#' @return A numeric vector of points allowed per 100 possessions.
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_defensive_rating(opp_pts = 108, poss = 100)
nba_defensive_rating <- function(opp_pts, poss) {
  100 * opp_pts / .nz(poss)
}

#' @title **Net Rating**
#' @param off_rating,def_rating Numeric vectors: offensive and defensive ratings.
#' @return A numeric vector (`off_rating - def_rating`).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_net_rating(off_rating = 115, def_rating = 108)
nba_net_rating <- function(off_rating, def_rating) {
  off_rating - def_rating
}

#' @title **Usage Rate**
#' @description Percentage of team plays a player used while on the floor.
#' @param fga,fta,tov,minutes Player box-score totals: field-goal attempts, free-throw attempts, turnovers, minutes.
#' @param team_fga,team_fta,team_tov,team_minutes Team totals for the same game(s).
#' @return A numeric vector of usage percentages (0-100 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' nba_usage_rate(fga = 20, fta = 8, tov = 3, minutes = 36,
#'                team_fga = 88, team_fta = 25, team_tov = 13, team_minutes = 240)
nba_usage_rate <- function(fga, fta, tov, minutes,
                           team_fga, team_fta, team_tov, team_minutes) {
  100 * ((fga + 0.44 * fta + tov) * (team_minutes / 5)) /
    .nz(minutes * (team_fga + 0.44 * team_fta + team_tov))
}

#' @title **Assist Percentage**
#' @description Estimated percentage of teammate field goals a player assisted
#'   while on the floor.
#' @param ast,fgm,minutes Player totals: assists, field goals made, minutes.
#' @param team_fgm,team_minutes Team field goals made and minutes for the same game(s).
#' @return A numeric vector of assist percentages (0-100 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' nba_assist_pct(ast = 8, fgm = 10, minutes = 36, team_fgm = 40, team_minutes = 240)
nba_assist_pct <- function(ast, fgm, minutes, team_fgm, team_minutes) {
  100 * ast / .nz(((minutes / (team_minutes / 5)) * team_fgm) - fgm)
}

#' @title **Turnover Percentage**
#' @description Turnovers per 100 plays: `100 * TOV / (FGA + 0.44 * FTA + TOV)`.
#' @param tov,fga,fta Numeric vectors: turnovers, field-goal attempts, free-throw attempts.
#' @return A numeric vector (0-100 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_turnover_pct(tov = 13, fga = 88, fta = 25)
nba_turnover_pct <- function(tov, fga, fta) {
  100 * tov / .nz(fga + 0.44 * fta + tov)
}

#' @title **Offensive Rebound Percentage**
#' @param oreb,opp_dreb Numeric vectors: offensive rebounds, opponent defensive rebounds.
#' @return A numeric vector (0-100 scale).
#' @family Basketball Analytics Utilities
#' @export
#' @examples nba_oreb_pct(oreb = 10, opp_dreb = 33)
nba_oreb_pct <- function(oreb, opp_dreb) {
  100 * oreb / .nz(oreb + opp_dreb)
}

#' @title **Four Factors**
#' @description Dean Oliver's "Four Factors" of winning basketball, as a tidy
#'   tibble (one row per input element): effective field-goal percentage,
#'   turnover percentage, offensive-rebound percentage and free-throw rate.
#' @param fgm,fg3m,fga,fta,ftm,oreb,tov Team box-score totals.
#' @param opp_dreb Opponent defensive rebounds (for offensive-rebound percentage).
#' @return A `tibble` with columns `efg_pct`, `tov_pct`, `oreb_pct`, `ft_rate`.
#' @importFrom dplyr tibble
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' nba_four_factors(fgm = 40, fg3m = 12, fga = 88, fta = 25, ftm = 20,
#'                  oreb = 10, tov = 13, opp_dreb = 33)
nba_four_factors <- function(fgm, fg3m, fga, fta, ftm, oreb, tov, opp_dreb) {
  dplyr::tibble(
    efg_pct  = nba_effective_fg_pct(fgm, fg3m, fga),
    tov_pct  = nba_turnover_pct(tov, fga, fta),
    oreb_pct = nba_oreb_pct(oreb, opp_dreb),
    ft_rate  = ftm / .nz(fga)
  )
}
