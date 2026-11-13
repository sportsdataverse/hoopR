# **Get TPBL Teams**

The teams of one season (bracket placeholders flagged).

Endpoint: `GET https://api.tpbl.basketball/api/events/{season}/teams`

## Usage

``` r
tpbl_teams(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season; 2025 is the
  first). The API keys a season by its own small integer (1, 2, 3 =
  2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the
  same number): the runtime reads /seasons once and sends that id, so
  the example URL shows the year. A year the list lacks raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_teams")`) and in the searchable
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
  try(tpbl_teams(season = 2026))
#> ── TPBL Teams from api.tpbl.basketball ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:46 UTC
#> # A tibble: 9 × 7
#>   season season_id team_id gohoops_team_id name             is_real_team status
#>    <int>     <int>   <int>           <int> <chr>            <lgl>        <chr> 
#> 1   2026         2       8             946 臺北台新戰神     TRUE         ACTIVE
#> 2   2026         2       7             945 新北國王         TRUE         ACTIVE
#> 3   2026         2       6             944 新北中信特攻     TRUE         ACTIVE
#> 4   2026         2       5             943 桃園台啤永豐雲豹 TRUE         ACTIVE
#> 5   2026         2       4             942 新竹御嵿攻城獅   TRUE         ACTIVE
#> 6   2026         2       3             941 福爾摩沙夢想家   TRUE         ACTIVE
#> 7   2026         2       2             940 高雄全家海神     TRUE         ACTIVE
#> 8   2026         2      67            2054 高順位隊伍       FALSE        ACTIVE
#> 9   2026         2      68            2055 低順位隊伍       FALSE        ACTIVE
# }
```
