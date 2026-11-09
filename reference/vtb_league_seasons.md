# **Get VTB League Seasons**

The seasons the API serves for one league (new seasons only, from
2024-25).

Endpoint:
`GET https://api.vtb-league.com/v2/leagues/{league_slug}/seasons`

## Usage

``` r
vtb_league_seasons(league_slug)
```

## Arguments

- league_slug:

  League slug (league in vtb_league_leagues): vtb (VTB United League),
  vtbyouth (youth league) or wbc (WINLINE Basket Cup).

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_league_seasons")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Source, access, seasons, ids and the error classes: see the notes of
  [`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

- v2 pages: meta.count is the rows returned (not a total), page is
  ignored and the default limit is 20, so the matches wrapper asks for
  1000 and refuses a body whose count reaches its limit. The API lists
  new seasons only (from 2024-25; vtb: 2025-2027, wbc: 2026-2027):
  earlier years answer no rows (`hoopR_no_data`).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_league_seasons(league_slug = "vtb"))
#> ── VTB League Seasons from api.vtb-league.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:17:54 UTC
#> # A tibble: 3 × 5
#>   season league is_current season_name                             season_abbrev
#>    <int> <chr>  <lgl>      <chr>                                   <chr>        
#> 1   2027 vtb    TRUE       "{\"ru\": \"Сезон 2026/2027\", \"en\":… "{\"ru\": \"…
#> 2   2026 vtb    FALSE      "{\"ru\": \"Сезон 2025/2026\", \"en\":… "{\"ru\": \"…
#> 3   2025 vtb    FALSE      "{\"ru\": \"Сезон 2024/2025\", \"en\":… "{\"ru\": \"…
# }
```
