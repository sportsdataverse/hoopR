# **Get TPBL Standings**

League table of one division: rank, record, games behind and streak.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`

## Usage

``` r
tpbl_standings(division_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tpbl_standings(division_id = 2))
#> ── TPBL Standings from api.tpbl.basketball ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:58:21 UTC
#> # A tibble: 7 × 12
#>   division_id  rank team_id gohoops_team_id gohoops_squad_id team       alt_name
#>         <int> <int>   <int>           <int>            <int> <chr>      <chr>   
#> 1           2     1       7             945             8214 新北國王   kings   
#> 2           2     2       3             941             8210 福爾摩沙夢想家…… dreamers
#> 3           2     3       2             940             8209 高雄全家海神…… aquas   
#> 4           2     4       8             946             8215 臺北台新戰神…… mars    
#> 5           2     5       5             943             8212 桃園台啤永豐雲豹…… leopards
#> 6           2     6       6             944             8213 新北中信特攻…… dea     
#> 7           2     7       4             942             8211 新竹御嵿攻城獅…… lioneers
#> # ℹ 5 more variables: won <int>, lost <int>, drawn <int>, games_behind <dbl>,
#> #   streak <chr>
# }
```
