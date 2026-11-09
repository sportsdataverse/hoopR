# lkl.R -- the LKL `lkl_*()` family: Lietuvos krepsinio lyga (Lithuania) on lkl.lt.
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/lkl (e3d232e): same names, arguments and columns.
# Runtime and parsers: R/lkl_utils.R. Generated from sportsdataverse-py's endpoint YAML, parser docstrings and
# manual_column_descriptions.yaml; edit the sportsdataverse-py sources first.

#' @title
#' **LKL Game Info**
#' @description
#' Game header from the game page: status, tip-off, venue, attendance, officials and both teams.
#'
#' Endpoint: `GET https://lkl.lt/rungtynes/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_game_info", inline = FALSE, unit = "game")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_game_info(game_id = 11446))
#' }
lkl_game_info <- function(game_id) {
  .lkl_wrap("game_info", game_id, type = "LKL Game Info", call = rlang::current_env())
}

#' @title
#' **LKL Game Players**
#' @description
#' Game roster from the game page: every player on either team sheet with the lkl.lt player id and slug.
#'
#' Endpoint: `GET https://lkl.lt/rungtynes/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_game_players", inline = FALSE, unit = "rostered player")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_players(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_players <- function(game_id) {
  .lkl_wrap("game_players", game_id, type = "LKL Game Players", call = rlang::current_env())
}

#' @title
#' **LKL Player Box**
#' @description
#' Per-player box score of a finished game: minutes, points, shooting splits, rebounds, assists and plus/minus.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_player_box", inline = FALSE, unit = "player on the team sheet")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_player_box(game_id = 11446))
#' }
lkl_player_box <- function(game_id) {
  .lkl_wrap("player_box", game_id, type = "LKL Player Box", call = rlang::current_env())
}

#' @title
#' **LKL Team Box**
#' @description
#' Team game totals of both teams: shooting, rebounds, assists, turnovers, fouls, paint, bench and fast-break points.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_team_box", inline = FALSE, unit = "team in the game")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_team_box(game_id = 11446))
#' }
lkl_team_box <- function(game_id) {
  .lkl_wrap("team_box", game_id, type = "LKL Team Box", call = rlang::current_env())
}

#' @title
#' **LKL Period Scores**
#' @description
#' Points each team scored in each period of a game, overtime included.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/boxscore/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_period_scores", inline = FALSE, unit = "team and period")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_period_scores(game_id = 11446))
#' }
lkl_period_scores <- function(game_id) {
  .lkl_wrap("period_scores", game_id, type = "LKL Period Scores", call = rlang::current_env())
}

#' @title
#' **LKL Summary**
#' @description
#' Summary tab: the head-to-head comparison of both teams (shooting, rebounds, assists, bench points...).
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/summary/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_summary", inline = FALSE, unit = "comparison line")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_summary(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_summary <- function(game_id) {
  .lkl_wrap("summary", game_id, type = "LKL Summary", call = rlang::current_env())
}

#' @title
#' **LKL Game Score**
#' @description
#' Score line of a game: both scores and the clock text.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-score/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_game_score", inline = FALSE, unit = "game")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_score(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_score <- function(game_id) {
  .lkl_wrap("game_score", game_id, type = "LKL Game Score", call = rlang::current_env())
}

#' @title
#' **LKL Game Stats**
#' @description
#' Statistics tab: the head-to-head comparison of both teams, one row per statistic.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-stats/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_game_stats", inline = FALSE, unit = "line of comparison")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_game_stats(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_game_stats <- function(game_id) {
  .lkl_wrap("game_stats", game_id, type = "LKL Game Stats", call = rlang::current_env())
}

#' @title
#' **LKL Lead Chart**
#' @description
#' Lead chart of a game: the score margin at each chart point of each period.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/game-stats/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_lead_chart", inline = FALSE, unit = "chart point")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_lead_chart(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_lead_chart <- function(game_id) {
  .lkl_wrap("lead_chart", game_id, type = "LKL Lead Chart", call = rlang::current_env())
}

#' @title
#' **LKL Leaders**
#' @description
#' Leaders tab: each team's top players in points, rebounds, assists, efficiency, steals and blocks.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/leaders/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_leaders", inline = FALSE, unit = "statistic, team and rank")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_leaders(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_leaders <- function(game_id) {
  .lkl_wrap("leaders", game_id, type = "LKL Leaders", call = rlang::current_env())
}

#' @title
#' **LKL Play-by-Play**
#' @description
#' Play-by-play of a finished game (2024-25 onward), oldest first, with the running score and the lkl.lt player id.
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/play-by-play/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_pbp", inline = FALSE, unit = "play")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_pbp(game_id = 11446))
#' }
lkl_pbp <- function(game_id) {
  .lkl_wrap("pbp", game_id, type = "LKL Play-by-Play", call = rlang::current_env())
}

#' @title
#' **LKL Shots**
#' @description
#' Every field-goal attempt of a finished game (2024-25 onward) with its court position (Genius LiveStats data).
#'
#' Endpoint: `GET https://lkl.lt/api/livestream/shot-chart/{game_id}`
#' @param game_id Required. lkl.lt game id (integer), e.g. 11446; `game_id` in lkl_results. Not sequential by season
#' before 2018-19. Only a finished game is served.
#' @eval .returns_rd("lkl_shots", inline = FALSE, unit = "attempt")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#'
#' ```r
#'  lkl_shots(game_id = 11446)
#' ```
#' @family LKL Functions
#' @export
lkl_shots <- function(game_id) {
  .lkl_wrap("shots", game_id, type = "LKL Shots", call = rlang::current_env())
}

#' @title
#' **LKL Results**
#' @description
#' Every played game of one LKL season (all pages of the site's results list, merged), newest first.
#'
#' Endpoint: `GET https://lkl.lt/loadResults`
#' @param season Required. Season END year (2026 = the 2025-26 season). The site keys a season by two opaque ids (a
#' results id and a standings id, neither a year); the runtime reads them from the site's season selects by the label
#' `YYYY-YYYY m. sezonas`. A year the selects do not list raises `hoopR_no_data`.
#' @eval .returns_rd("lkl_results", inline = FALSE, unit = "played game")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examplesIf interactive()
#' \donttest{
#'   # Pages through the whole season, 10 games per request.
#'   try(lkl_results(season = 2026))
#' }
lkl_results <- function(season) {
  .lkl_wrap("results", season, type = "LKL Results", call = rlang::current_env())
}

#' @title
#' **LKL Standings**
#' @description
#' League table of one LKL season: overall, home and away records, and the final ranking once it is set.
#'
#' Endpoint: `GET https://lkl.lt/loadStandings/{season}`
#' @param season Required. Season END year (2026 = the 2025-26 season). The site keys a season by two opaque ids (a
#' results id and a standings id, neither a year); the runtime reads them from the site's season selects by the label
#' `YYYY-YYYY m. sezonas`. A year the selects do not list raises `hoopR_no_data`.
#' @eval .returns_rd("lkl_standings", inline = FALSE, unit = "team and table")
#' @details
#' Unofficial and unsupported: these are the routes lkl.lt's own game page calls (found in its front-end bundle) and
#' its server-rendered pages. The site's robots.txt allows everything and sets no crawl-delay; the runtime still spaces
#' requests at least 1 s apart. The site's terms were not reviewed; check them before you
#' republish the data.
#'
#' Coverage: game wrappers serve FINISHED games only (an unfinished game raises `hoopR_asset_fetch`). The box score,
#' summary, score line, statistics and leaders answer for every season from 1993-94 (before 2024-25 the scoring splits
#' and lead statistics are 0). Play-by-play and shots exist from 2024-25 only; an earlier finished game raises
#' `hoopR_no_data`. From 2016-17 the results season id is also the Genius LiveStats competition id (see the `genius`
#' family) which holds play-by-play for older games; lkl.lt game, team and player ids are lkl.lt's own and do not join
#' Genius ids. The King Mindaugas Cup shares the routes but is not wrapped. Text fields are Lithuanian.
#'
#' Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP 404, an unknown game or standings season, a
#' season the site's selects do not list, a season without played games, a finished game before 2024-25 asked for
#' play-by-play or shots); `hoopR_bad_request` for a game id or season that is not an integer, or HTTP 400 / 422;
#' `hoopR_asset_fetch` when the fetch failed or the answer is not the one asked for (an unfinished game, a body or page
#' for another game or season, an error or changed body, a truncated results list). All inherit `hoopR_error`. Dates
#' and times are Lithuanian local (Europe/Vilnius) as the site prints them.
#' @family LKL Functions
#' @export
#' @examples
#' \donttest{
#'   try(lkl_standings(season = 2026))
#' }
lkl_standings <- function(season) {
  .lkl_wrap("standings", season, type = "LKL Standings", call = rlang::current_env())
}
