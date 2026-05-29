#' @name kp
#' @aliases kp kenpom hoopR_kenpom
#' @title **KenPom Scraper Overview**
#' @description
#' Authenticated scrapers for [kenpom.com](https://kenpom.com) men's
#' college-basketball pages. Authentication uses an `httr2` cookie jar
#' via `login()`; pages are pulled with `.kp_get_page(jar, url)` and
#' parsed with `rvest`. CSS selectors for tables are fragile — KenPom
#' changes the HTML occasionally and selectors may need updating.
#'
#' Credentials are read from `KP_USER` / `KP_PW` env vars (or function
#' args). See `?login` for the auth flow.
#'
#' @details
#'
#' ## **Team / season ratings**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_pomeroy_ratings()]              | Pomeroy season ratings |
#' | [kp_pomeroy_archive_ratings()]      | Historical Pomeroy ratings |
#' | [kp_program_ratings()]              | Program-level ratings |
#' | [kp_team_history()]                 | Team history page |
#' | [kp_arenas()]                       | Arena reference |
#'
#' ## **Per-game / per-team detail**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_box()]                          | Box-score detail |
#' | [kp_fanmatch()]                     | FanMatch daily slate |
#' | [kp_gameplan()]                     | Game-plan page |
#' | [kp_team_lineups()]                 | Team lineup stats |
#' | [kp_team_depth_chart()]             | Team depth chart |
#' | [kp_team_player_stats()]            | Per-team player stats |
#' | [kp_team_schedule()]                | Per-team schedule |
#' | [kp_team_players()]                 | Team roster |
#'
#' ## **Conference / efficiency / four-factor splits**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_conf()]                  | Conference summary |
#' | [kp_confhistory()]           | Conference history |
#' | [kp_confstats()]             | Conference stats |
#' | [kp_efficiency()]            | Efficiency rankings |
#' | [kp_fourfactors()]           | Four-factor rankings |
#' | [kp_pointdist()]             | Points distribution |
#' | [kp_teamstats()]             | Team stats |
#' | [kp_hca()]                   | Home-court advantage |
#'
#' ## **Player + coach + officials**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_player_career()]         | Player career page |
#' | [kp_playerstats()]           | Player stats |
#' | [kp_kpoy()]                  | KenPom player of the year |
#' | [kp_height()]                | Team height/experience |
#' | [kp_coach_history()]         | Coach history |
#' | [kp_referee()]               | Referee splits |
#' | [kp_officials()]             | Game officials |
#'
#' ## **Trends and miscellany**
#'
#' [kp_trends()], [kp_winprob()], [kp_minutes_matrix()],
#' [kp_foul_trouble()], [kp_opptracker()], [kp_game_attrs()],
#' [kp_user_pw()].
#'
#' @keywords KenPom
#' @family KenPom
NULL
