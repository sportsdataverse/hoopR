# **Get P. LEAGUE+ Player Season Stats**

Player season averages and totals of one season and stage: shooting,
rebounds, assists and fouls.

Endpoint:
`GET https://pleagueofficial.com/stat-player/{season slug}/{stage_sn}`

## Usage

``` r
pleague_stat_player(season, stage_sn)
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

- stage_sn:

  Required. Stage select value of the player table: 2 = regular season,
  3 = playoffs, 4 = finals.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_stat_player")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_stat_player(season = 2025, stage_sn = 2))
#> Error in pleague_stat_player(season = 2025, stage_sn = 2) : 
#>   pleagueofficial.com/stat-player/2024-25/2: not the page asked for:
#> layout drift: stat-player header [#排名, PLAYER球員, NO背號, TEAM球隊, GP出賽,
#> MIN時間, PTS得分, 2PT二分, 2PM二分命中, 2PA二分出手, 2PT%二分%, 3PT三分,
#> 3PM三分命中, 3PA三分出手, 3PT%三分%, FT罰球, FTM罰球命中, FTA罰球出手,
#> FT%罰球%, REB籃板, OREB攻板, DREB防板, AST助攻, STL抄截, BLK阻攻, TO失誤,
#> PF犯規]
# }
```
