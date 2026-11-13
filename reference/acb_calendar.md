# **Get ACB Calendar**

Every round of a season with its games: one call lists every game id.

One row per game with its round (`round_id`, `round_number`) and the
teams looked up in the body's team list. The cheapest way to crawl a
season: one call lists every game id.

Endpoint:
`GET https://api2.acb.com/api/seasondata/Calendar/season-calendar`

## Usage

``` r
acb_calendar(competition_id = NULL, season = NULL)
```

## Arguments

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_calendar")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_calendar(season = 2027))
#> ── ACB Calendar from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:51:30 UTC
#> # A tibble: 306 × 25
#>    competition_id edition_id season round_id round_number subphase_id
#>             <int>      <int>  <int>    <int>        <int>       <int>
#>  1              1         91   2027     6015            1          NA
#>  2              1         91   2027     6015            1          NA
#>  3              1         91   2027     6015            1          NA
#>  4              1         91   2027     6015            1          NA
#>  5              1         91   2027     6015            1          NA
#>  6              1         91   2027     6015            1          NA
#>  7              1         91   2027     6015            1          NA
#>  8              1         91   2027     6015            1          NA
#>  9              1         91   2027     6015            1          NA
#> 10              1         91   2027     6016            2          NA
#> # ℹ 296 more rows
#> # ℹ 19 more variables: subphase_number <int>, week_id <int>, match_id <int>,
#> #   home_team_id <int>, away_team_id <int>, home_score <int>, away_score <int>,
#> #   start <dttm>, status <chr>, is_on_half_time <lgl>, current_quarter <int>,
#> #   home_club_id <int>, home_team <chr>, home_team_abbr <chr>,
#> #   away_club_id <int>, away_team <chr>, away_team_abbr <chr>,
#> #   ticketing_link <chr>, broadcasters <chr>
# }
```
