#' **Men's College Basketball KenPom Teams Dictionary**
#' KenPom team and conference names with their KenPom page links, one row per
#' team-season. The KenPom team functions validate `team` against `Team`; they
#' build the page link from the name itself, so they also work for seasons this
#' table does not list yet.
#' @format A data frame with 9,044 rows (one per team-season, 2002-2027) and 7 variables:
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

#' **Return Columns of hoopR Functions**
#'
#' The columns of every data frame a hoopR function returns: one row per
#' column, with its type and description, for 979 functions. Most functions
#' outside the NBA and men's college basketball families list their columns
#' here rather than in their help page; the NBA and MBB functions show the
#' same table in their help page too. Built by `data-raw/return_columns.R`
#' from `data-raw/return_columns.csv`, the file every `@return` column table
#' is generated from. The same table is searchable in the
#' [return columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
#' article.
#' @format A data frame with 28,634 rows (one per returned column) and 5 variables:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | `fn` | character | Function name. |
#' | `component` | character | Element of the returned named list the column belongs to (`PlayerStats`, `TeamStats`, ...), or the argument value that selects the table (``kind = "streaks"``); `NA` when the function returns a single data frame. |
#' | `col_name` | character | Column name. |
#' | `type` | character | Column type (`character`, `integer`, `numeric`, ...); `NA` when the source table gave none. |
#' | `description` | character | What the column holds; `NA` when the source table gave none. Inline code is in backticks. |
#'
#' @source The `@return` sections of the hoopR help pages, and the APIs they
#'   document: <https://www.nba.com/stats/>, ESPN, KenPom and the other
#'   sources the functions wrap.
#' @examples
#' head(subset(return_columns, fn == "nba_boxscoretraditionalv3"))
"return_columns"

#' **Men's College Basketball Team Names by Source**
#'
#' Team names from sources the crosswalk does not fetch (NCAA, ESPN
#' play-by-play, Warren Nolan, 247Sports and Sports-Reference), one row per
#' ESPN team. [mbb_team_crosswalk()] joins it on `espn_team_id` and applies it
#' to every season. Built by `data-raw/mbb_team_names.R` from
#' `data-raw/dict_hoopR.csv`, re-keyed to ESPN ids through the crosswalk's
#' KenPom matching. The names are as that 2023 source recorded them, so some
#' predate a rename (Utah Tech's Warren Nolan and 247Sports names are
#' `Dixie St.`, Purdue Fort Wayne's are `IPFW`). Teams that joined Division I
#' later carry only the names that could be checked. A name that is not known
#' is `NA`.
#' @format A data frame with 368 rows (one per team) and 8 variables:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | `espn_team_id` | integer | ESPN team id (unique). |
#' | `kp_team` | character | Current KenPom team name (the dict's 2023 name for Hartford and St. Francis NY, which left Division I). |
#' | `ncaa_team` | character | NCAA (stats.ncaa.org) team name. |
#' | `espn_pbp_name` | character | Team name as ESPN play-by-play prints it. |
#' | `warren_nolan_team` | character | Warren Nolan team name. |
#' | `team_247` | character | 247Sports team name. |
#' | `sref_slug` | character | Sports-Reference school URL slug (`/cbb/schools/<slug>/`). |
#' | `sref_team` | character | Sports-Reference school name. |
#'
#' @examples
#' head(mbb_team_names)
"mbb_team_names"
