# **EuroLeague People**

**Get the people (players, coaches) in a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/people`

## Usage

``` r
euroleague_people(competition_code, season_code, limit = NULL, offset = NULL)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- limit:

  (*integer* optional): Page size (number of rows to return).

- offset:

  (*integer* optional): Row offset into the full list.

## Value

A `hoopR_data` tibble with one row per person-club registration. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_people")`) and in the
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
    euroleague_people(competition_code = "E", season_code = "E2025", limit = 50)
  })
#> ── EuroLeague people from api-live.euroleague.net ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:35 UTC
#> # A tibble: 50 × 48
#>    type  type_name   active start_date end_date order dorsal dorsal_raw position
#>    <chr> <chr>       <lgl>  <chr>      <chr>    <int> <chr>  <chr>         <int>
#>  1 A     Assitant c… FALSE  2025-09-0… 2026-04…     7 ""     ""                0
#>  2 A     Assitant c… TRUE   2025-12-2… 2026-06…     5 ""     ""                0
#>  3 E     Coach       FALSE  2025-12-0… 2025-12…     5 ""     ""                0
#>  4 A     Assitant c… TRUE   2025-11-1… 2026-06…     5 ""     ""                0
#>  5 A     Assitant c… TRUE   2025-09-1… 2026-06…     5 ""     ""                0
#>  6 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  7 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  8 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#>  9 A     Assitant c… TRUE   2025-09-0… 2026-06…     5 ""     ""                0
#> 10 A     Assitant c… TRUE   2025-11-1… 2026-06…     4 ""     ""                0
#> # ℹ 40 more rows
#> # ℹ 39 more variables: position_name <chr>, last_team <chr>, external_id <chr>,
#> #   person_code <chr>, person_name <chr>, person_alias <chr>,
#> #   person_alias_raw <chr>, person_passport_name <chr>,
#> #   person_passport_surname <chr>, person_jersey_name <chr>,
#> #   person_abbreviated_name <chr>, person_country_code <chr>,
#> #   person_country_name <chr>, person_height <int>, person_weight <int>, …
# }
```
