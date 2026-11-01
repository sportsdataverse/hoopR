#' **Men's College Basketball KenPom Teams Dictionary**
#' KenPom team and conference names with their KenPom page links, one row per
#' team-season. The KenPom team functions validate `team` against `Team`; they
#' build the page link from the name itself, so they also work for seasons this
#' table does not list yet.
#' @format A data frame with 8,679 rows (one per team-season, 2002-2026) and 7 variables:
#'
#' | col_name | description |
#' |---|---|
#' | `Team` | character. Team name as KenPom prints it (the `team` argument of the KenPom team functions). |
#' | `Team.link` | character. Relative KenPom team page link, `team.php?team=<team.link.ref>`. |
#' | `team.link.ref` | character. URL-encoded team name used in the link (`+` for spaces). |
#' | `Conf` | character. Conference abbreviation that season (the `conf` argument of the KenPom conference functions). |
#' | `Conf.link` | character. Relative KenPom conference page link, `conf.php?c=<conf.link.ref>`. |
#' | `conf.link.ref` | character. Conference code used in the link. |
#' | `Year` | integer. KenPom season (END year: 2026 = 2025-26). |
#'
"teams_links"

#' **NBA Stats API Parameter Descriptions**
#'
#' Reference table of the query parameters that hoopR's NBA Stats API
#' (`stats.nba.com`) wrappers send: one row per R argument, with the API
#' parameter it maps to, what it does, the values the API accepts and the
#' `nba_*()` functions that take it. Built by `data-raw/parameter_descriptions.R`
#' from the wrappers' own bodies, formals and `@param` text, the stats.nba.com
#' parameter values (cross-checked against nba_api) and wehoop's WNBA table.
#' @format A data frame with 300 rows (one per parameter) and 7 variables:
#'
#' | col_name | description |
#' |---|---|
#' | `parameter` | character. R argument name (snake_case). |
#' | `api_name` | character. NBA Stats API query parameter (CamelCase) the argument is sent as; comma-separated, most common first, when functions send it under different names. |
#' | `description` | character. What the parameter does. |
#' | `valid_values` | character. Comma-separated values the API accepts: the union across the endpoints of the listed functions, so one endpoint may accept only some of them (`data-raw/nba_stats_parameter_values.csv` in the source repository has the per-endpoint sets). An empty string means no list of values is known, not that any value works; a format may still be given in `description`. |
#' | `default` | character. Most common default in the function signatures, as R prints it; for an argument with no default, the endpoint's own default. Suffixed `(varies by function)` when the listed functions' defaults differ. |
#' | `functions` | character. Comma-separated `nba_*()` functions that send the parameter. |
#' | `n_functions` | integer. Number of functions in `functions`. |
#'
#' @source <https://www.nba.com/stats/>
#' @examples
#' head(parameter_descriptions[, c("parameter", "api_name", "valid_values")])
"parameter_descriptions"
