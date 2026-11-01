# **Get CBA Team Options**

The teams of one season as a select list: team id and the season's
display name.

Endpoint:
`GET https://data-server.cbaleague.com/api/com-code-tables/getTeam`

## Usage

``` r
cba_team_options(season)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

## Value

A `hoopR_data` tibble: One row per team: id (key) and display name. An
empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_team_options`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| is_default | integer | Default-selection flag: 2 = not the default on every row (the site prepends its own 'all teams' row, which this route does not send). |
| key | character | Team display name (Chinese) in the requested season; names change with the sponsor, the teamId does not. |
| value | character | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Here a string of digits. |

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
[`cba_match_types()`](https://hoopR.sportsdataverse.org/reference/cba_match_types.md),
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
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md),
[`cba_teams()`](https://hoopR.sportsdataverse.org/reference/cba_teams.md)

## Examples

``` r
# \donttest{
  try(cba_team_options(season = 2026))
#> ── CBA Team Options from data-server.cbaleague.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:45:40 UTC
#> # A tibble: 20 × 3
#>    is_default key          value    
#>         <int> <chr>        <chr>    
#>  1          2 北京控股     29136    
#>  2          2 北京首钢     29115    
#>  3          2 福建晋江文旅 29134    
#>  4          2 广东东阳光   29124    
#>  5          2 广州朗肽海本 29139    
#>  6          2 江苏肯帝亚   29118    
#>  7          2 辽宁本钢     29129    
#>  8          2 南京天之蓝   29133    
#>  9          2 宁波町渥     100074683
#> 10          2 青岛崂山啤酒 29135    
#> 11          2 山东高速     29130    
#> 12          2 上海久事     29125    
#> 13          2 山西汾酒     29132    
#> 14          2 深圳马可波罗 29131    
#> 15          2 四川丰谷酒业 29127    
#> 16          2 天津先行者   29138    
#> 17          2 新疆伊力特   29117    
#> 18          2 长白山恩都里 29137    
#> 19          2 浙江稠州金租 29140    
#> 20          2 浙江浙商证券 29128    
# }
```
