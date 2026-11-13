# **IBBA Leaders**

**The top five players of a season in one stat category, for all teams
or one team.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/LeaderByType`

## Usage

``` r
ibba_leaders(stat_type, season, team_id = 0)
```

## Arguments

- stat_type:

  (*character* required): Stat category code from ibba_stats_types: VAL,
  pts, isr_pts, plusminus, dunk, ASS, TR, `[OR]`, DR, isr_TR, ST,
  `[TO]`, ASSTO, BKF, FF, `[min]`, p2, p3, p1, p32T, p22T, p12T, PTSMIN,
  TRMIN, ASSMIN.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- team_id:

  (*integer*, default `0`): Team-season id to restrict the list to one
  team; 0 (default) for all teams.

## Value

A `hoopR_data` tibble with one row per leaderboard entry. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_leaders")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(ibba_leaders(season = 2026, stat_type = "pts"))
#> ── IBBA leaders ───────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:55 UTC
#> # A tibble: 5 × 8
#>   value games season team_id jersey player_id player_name_he     photo_path     
#>   <dbl> <int>  <int>   <int> <chr>      <int> <chr>              <chr>          
#> 1  22.3     6   2026    1118 03         25928 זאק בראיינט        /pics/2025-202…
#> 2  21.8     6   2026    1114 03         25946 רוב אדוארדס        NA             
#> 3  20.7     3   2026    1118 12         25949 ג'סטין אדלר-דייויס /pics/2025-202…
#> 4  20.2    17   2026    1118 44         21837 אלייז'ה סטיוארט    /pics/2025-202…
#> 5  19       2   2026    1119 00         24891 זאהיר פורטר        /pics/2025-202…
# }
```
