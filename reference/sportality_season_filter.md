# **Get Basketligaen Season Filter**

Series, the 25 seasons (2002/03 on), game types and the default ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/season-series-game-types-filter`

## Usage

``` r
sportality_season_filter()
```

## Value

A `hoopR_data` tibble: Series, the 25 seasons (2002/03 on), game types
and the default ssgt. An empty valid answer raises `hoopR_no_data`; the
documented columns come first, in this order (sportsdataverse-py
`sportality_season_filter`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| kind | character | Directory entry kind: series, season or game_type. |
| code | character | Series code (DBL = Basketligaen). |
| name | character | Game type name in Danish (Grundspil = regular season, Slutspil = playoffs). |
| uuid | character | Series uuid (platform key space); the seriesUuid of /sports-v2/game-schedule. |
| deleted | logical | Soft-delete flag; false on every record seen. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_season_filter())
#> ── Basketligaen Season Filter from basketligaen.dk ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:56:38 UTC
#> # A tibble: 27 × 5
#>    kind   code  name         uuid       deleted
#>    <chr>  <chr> <chr>        <chr>      <lgl>  
#>  1 series DBL   Basketligaen m1ay3mpa4t FALSE  
#>  2 season 2026  2026/2027    fg7gxxmm0w FALSE  
#>  3 season 2025  2025/2026    ggp2aapun2 FALSE  
#>  4 season 2024  2024/2025    df8tvo9vtv FALSE  
#>  5 season 2023  2023/2024    kh3bu2clwh FALSE  
#>  6 season 2022  2022/2023    lbi799ptgn FALSE  
#>  7 season 2021  2021/2022    s3vxi2twqh FALSE  
#>  8 season 2020  2020/2021    qk3us0seqa FALSE  
#>  9 season 2019  2019/2020    la8qbr7i9j FALSE  
#> 10 season 2018  2018/2019    yfny9300wf FALSE  
#> # ℹ 17 more rows
# }
```
