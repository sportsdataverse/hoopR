# **EuroLeague Rounds**

**Get the rounds of a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/rounds`

## Usage

``` r
euroleague_rounds(competition_code, season_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

## Value

A `hoopR_data` tibble with one row per round. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_rounds")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sportsdataverse-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_rounds(competition_code = "E", season_code = "E2025")
  })
#> ── EuroLeague rounds from api-live.euroleague.net ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:01 UTC
#> # A tibble: 47 × 8
#>    season_code phase_type_code round index name      min_game_start_date
#>    <chr>       <chr>           <int> <int> <chr>     <chr>              
#>  1 E2025       FF                 47     2 Final     2026-05-23T00:00:00
#>  2 E2025       FF                 46     1 Semifinal 2026-05-15T00:00:00
#>  3 E2025       PO                 45     5 Game 5    2026-05-11T00:00:00
#>  4 E2025       PO                 44     4 Game 4    2026-05-07T00:00:00
#>  5 E2025       PO                 43     3 Game 3    2026-05-04T00:00:00
#>  6 E2025       PO                 42     2 Game 2    2026-04-30T00:00:00
#>  7 E2025       PO                 41     1 Game 1    2026-04-25T00:00:00
#>  8 E2025       PI                 40     2 Round 2   2026-04-22T00:00:00
#>  9 E2025       PI                 39     1 Round 1   2026-04-18T00:00:00
#> 10 E2025       RS                 38    38 Round 38  2026-04-13T00:00:00
#> # ℹ 37 more rows
#> # ℹ 2 more variables: max_game_start_date <chr>, dates_formmated <chr>
# }
```
