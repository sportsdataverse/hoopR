# **Get KBL Schedule**

Every game (all competitions, KBL and D-League) of a season or of a date
window, with scores and venue.

Endpoint: `GET https://api.kbl.or.kr/match/list`

## Usage

``` r
kbl_schedule(season = NULL, from_date = NULL, to_date = NULL)
```

## Arguments

- season:

  Season END year (2026 = 2025-26): the window from the first to the
  last game of that END year's KBL and D-League editions, fetched as at
  most two requests (one per calendar year). Pass this or from_date and
  to_date.

- from_date:

  First date of a window, YYYYMMDD (KST). Needs to_date; inside one
  calendar year the API answers the whole window in one request (up to
  396 games a year, no paging).

- to_date:

  Last date of the window, YYYYMMDD (KST), not before from_date.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_schedule")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kbl_schedule(from_date = "20251101", to_date = "20251102"))
#> ── KBL Schedule from api.kbl.or.kr ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:14:11 UTC
#> # A tibble: 6 × 33
#>   gmkey     glkey  season season_code season_name season_grade game_code game_no
#>   <chr>     <chr>   <int>       <int> <chr>              <int> <chr>       <int>
#> 1 S47G01N49 S47G01   2026          47 2025-2026              1 01             49
#> 2 S47G01N50 S47G01   2026          47 2025-2026              1 01             50
#> 3 S47G01N51 S47G01   2026          47 2025-2026              1 01             51
#> 4 S47G01N52 S47G01   2026          47 2025-2026              1 01             52
#> 5 S47G01N53 S47G01   2026          47 2025-2026              1 01             53
#> 6 S47G01N54 S47G01   2026          47 2025-2026              1 01             54
#> # ℹ 25 more variables: season_category <chr>, season_category_name <chr>,
#> #   game_date <date>, week_day <chr>, game_start <chr>, game_end <chr>,
#> #   game_time <int>, home_team_code <chr>, away_team_code <chr>,
#> #   home_team_name <chr>, away_team_name <chr>, home_team_name_full <chr>,
#> #   away_team_name_full <chr>, home_score <int>, away_score <int>,
#> #   is_started <int>, is_ended <int>, playing_quarter <chr>,
#> #   stadium_name <chr>, stadium_name_full <chr>, stadium_name_en <chr>, …
# }
```
