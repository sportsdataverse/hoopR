# **Get CBA Teams**

The current team list: logo, team id, club name and display name.

Endpoint: `GET https://data-server.cbaleague.com/api/teams/teamList`

## Usage

``` r
cba_teams()
```

## Value

A `hoopR_data` tibble: One row per club: logo, id, club name and display
name. An empty valid answer is a zero-row tibble with these columns, in
this order (sportsdataverse-py `cba_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club | character | Empty string on every row; meaning unverified (a club-code slot the site leaves unused). |
| team_cn_alias | character | Current team name (Chinese short name, e.g. 'Beijing Holdings'). Names change with the sponsor, the id does not; teamId -\> English glossary in cba_glossary.yaml. |
| team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
| team_logo | character | Protocol-relative URL of the 300x300 team logo (`//image.cbaleague.com/cbaleague/teamlogo/300x300/<teamId>_300.png`). |

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
[`cba_team_options()`](https://hoopR.sportsdataverse.org/reference/cba_team_options.md),
[`cba_team_overview()`](https://hoopR.sportsdataverse.org/reference/cba_team_overview.md),
[`cba_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_team_shots.md)

## Examples

``` r
# \donttest{
  try(cba_teams())
#> ── CBA Teams from data-server.cbaleague.com ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:50:54 UTC
#> # A tibble: 20 × 4
#>    club  team_cn_alias   team_id team_logo                                      
#>    <chr> <chr>             <int> <chr>                                          
#>  1 ""    北京控股          29136 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  2 ""    北京首钢          29115 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  3 ""    长白山恩都里      29137 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  4 ""    福建晋江文旅      29134 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  5 ""    广东东阳光        29124 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  6 ""    广州智都集团      29139 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  7 ""    江苏肯帝亚        29118 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  8 ""    辽宁本钢          29129 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#>  9 ""    南京同曦宙光      29133 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 10 ""    宁波町渥      100074683 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 11 ""    青岛崂山啤酒      29135 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 12 ""    山东高速          29130 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 13 ""    山西汾酒          29132 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 14 ""    上海久事          29125 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 15 ""    深圳马可波罗      29131 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 16 ""    四川锦城          29127 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 17 ""    天津先行者        29138 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 18 ""    新疆广汇能源      29117 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 19 ""    浙江稠州金租      29140 //image.cbaleague.com/cbaleague/teamlogo/300x3…
#> 20 ""    浙江浙商证券      29128 //image.cbaleague.com/cbaleague/teamlogo/300x3…
# }
```
