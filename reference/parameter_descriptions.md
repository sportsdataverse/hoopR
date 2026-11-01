# **NBA Stats API Parameter Descriptions**

Reference table of the query parameters that hoopR's NBA Stats API
(`stats.nba.com`) wrappers send: one row per R argument, with the API
parameter it maps to, what it does, the values the API accepts and the
`nba_*()` functions that take it. Built by
`data-raw/parameter_descriptions.R` from the wrappers' own bodies,
formals and `@param` text, the stats.nba.com parameter values
(cross-checked against nba_api) and wehoop's WNBA table.

## Usage

``` r
parameter_descriptions
```

## Format

A data frame with 300 rows (one per parameter) and 7 variables:

|  |  |
|----|----|
| col_name | description |
| `parameter` | character. R argument name (snake_case). |
| `api_name` | character. NBA Stats API query parameter (CamelCase) the argument is sent as; comma-separated, most common first, when functions send it under different names. |
| `description` | character. What the parameter does. |
| `valid_values` | character. Comma-separated values the API accepts: the union across the endpoints of the listed functions, so one endpoint may accept only some of them (`data-raw/nba_stats_parameter_values.csv` in the source repository has the per-endpoint sets). An empty string means no list of values is known, not that any value works; a format may still be given in `description`. |
| `default` | character. Most common default in the function signatures, as R prints it; for an argument with no default, the endpoint's own default. Suffixed `(varies by function)` when the listed functions' defaults differ. |
| `functions` | character. Comma-separated `nba_*()` functions that send the parameter. |
| `n_functions` | integer. Number of functions in `functions`. |

## Source

<https://www.nba.com/stats/>

## Examples

``` r
head(parameter_descriptions[, c("parameter", "api_name", "valid_values")])
#>             parameter          api_name
#> 1         active_flag        ActiveFlag
#> 2      active_players     ActivePlayers
#> 3 active_streaks_only ActiveStreaksOnly
#> 4   active_teams_only   ActiveTeamsOnly
#> 5        ahead_behind       AheadBehind
#> 6         btr_opp_ast         BtrOPPAST
#>                                     valid_values
#> 1                                        Yes, No
#> 2                                           Y, N
#> 3                                               
#> 4                                               
#> 5 Ahead or Behind, Behind or Tied, Ahead or Tied
#> 6                                               
```
