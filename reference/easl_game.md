# **Get EASL Game**

Header of one finished fixture: teams, final score, status, stage, pool,
venue and attendance.

Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}`

## Usage

``` r
easl_game(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_game")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_game(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Game from easl.joshricha.com ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:57 UTC
#> # A tibble: 1 × 44
#>   season season_id fixture_id    fixture_number fixture_type status fixture_name
#>    <int> <chr>     <chr>                  <int> <chr>        <chr>  <chr>       
#> 1     NA NA        10af8fd4-106…        2526042 FINAL        CONFI… EASL Champi…
#> # ℹ 37 more variables: start_time_utc <chr>, start_time_local <chr>,
#> #   attendance <int>, live_data_available <lgl>, live_video_available <lgl>,
#> #   pool_code <chr>, pool_id <chr>, pool_name <chr>, pool_abb <chr>,
#> #   stage_id <chr>, stage_code <chr>, stage_name <chr>, stage_order <int>,
#> #   venue_name <chr>, venue_name_latin <chr>, venue_abbreviation_latin <chr>,
#> #   venue_abbreviation_local <chr>, venue_alternate_name_latin <chr>,
#> #   venue_country_code <chr>, venue_city <chr>, venue_state <chr>, …
# }
```
