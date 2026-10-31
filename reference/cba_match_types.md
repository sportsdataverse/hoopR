# **Get CBA Match Types**

The match types (regular season, playoffs, preseason, all-star,
relegation play-off) with their ids.

Endpoint:
`GET https://data-server.cbaleague.com/api/com-code-tables/getMatchType`

## Usage

``` r
cba_match_types()
```

## Value

A `hoopR_data` tibble: One row per match type (regular season, playoffs,
preseason, all-star, relegation). An empty valid answer is a zero-row
tibble with these columns, in this order (sportsdataverse-py
`cba_match_types`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| is_default | integer | Default-selection flag: 1 = the site's default (the preseason, '3', at capture time: it follows the calendar), 2 = not the default. |
| key | character | Match type name (Chinese): regular season, (Chinese text) playoffs, (Chinese text) preseason, (Chinese text) all-star, (Chinese text) relegation play-off. |
| value | character | Match type id as a string ('1' regular season, '2' playoffs, '3' preseason, '4' all-star, '9' relegation); the matchTypeId of every other route. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

Other CBA Functions:
[`cba_best_player()`](https://hoopR.sportsdataverse.org/reference/cba_best_player.md),
[`cba_best_stats()`](https://hoopR.sportsdataverse.org/reference/cba_best_stats.md),
[`cba_game_info()`](https://hoopR.sportsdataverse.org/reference/cba_game_info.md),
[`cba_game_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_four.md),
[`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md),
[`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md),
[`cba_period_scores()`](https://hoopR.sportsdataverse.org/reference/cba_period_scores.md),
[`cba_player_advanced()`](https://hoopR.sportsdataverse.org/reference/cba_player_advanced.md),
[`cba_player_base()`](https://hoopR.sportsdataverse.org/reference/cba_player_base.md),
[`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md),
[`cba_player_defensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_defensive.md),
[`cba_player_extras()`](https://hoopR.sportsdataverse.org/reference/cba_player_extras.md),
[`cba_player_offensive()`](https://hoopR.sportsdataverse.org/reference/cba_player_offensive.md),
[`cba_player_shots()`](https://hoopR.sportsdataverse.org/reference/cba_player_shots.md),
[`cba_report_status()`](https://hoopR.sportsdataverse.org/reference/cba_report_status.md),
[`cba_rosters()`](https://hoopR.sportsdataverse.org/reference/cba_rosters.md),
[`cba_schedule_day()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_day.md),
[`cba_schedule_month()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_month.md),
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md),
[`cba_team_basic()`](https://hoopR.sportsdataverse.org/reference/cba_team_basic.md),
[`cba_team_counts()`](https://hoopR.sportsdataverse.org/reference/cba_team_counts.md),
[`cba_team_four()`](https://hoopR.sportsdataverse.org/reference/cba_team_four.md),
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)

## Examples

``` r
# \donttest{
  try(cba_match_types())
#> ── CBA Match Types from data-server.cbaleague.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:27:34 UTC
#> # A tibble: 5 × 3
#>   is_default key    value
#>        <int> <chr>  <chr>
#> 1          1 常规赛 1    
#> 2          2 季后赛 2    
#> 3          2 季前赛 3    
#> 4          2 全明星 4    
#> 5          2 保级赛 9    
# }
```
