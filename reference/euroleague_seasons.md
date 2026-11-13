# **EuroLeague Seasons**

**Get the seasons of a competition.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons`

## Usage

``` r
euroleague_seasons(competition_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_seasons")`) and in the
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
    euroleague_seasons(competition_code = "E")
  })
#> ── EuroLeague seasons from api-live.euroleague.net ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:51 UTC
#> # A tibble: 27 × 16
#>    name   code  alias competition_code  year start_date activation_date end_date
#>    <chr>  <chr> <chr> <chr>            <int> <chr>      <chr>           <chr>   
#>  1 EuroL… E2026 2026… E                 2026 2026-07-0… 2026-07-01T00:… 2027-06…
#>  2 EuroL… E2025 2025… E                 2025 2025-07-0… 2025-07-01T00:… 2026-06…
#>  3 EuroL… E2024 2024… E                 2024 2024-06-2… 2024-06-29T00:… 2025-06…
#>  4 EuroL… E2023 2023… E                 2023 2023-06-2… 2023-06-29T00:… 2024-07…
#>  5 EuroL… E2022 2022… E                 2022 2022-07-0… 2022-07-01T00:… 2023-07…
#>  6 EuroL… E2021 2021… E                 2021 2021-09-0… 2021-07-01T00:… 2022-06…
#>  7 EuroL… E2020 2020… E                 2020 2020-09-0… 2020-06-23T00:… 2021-07…
#>  8 EuroL… E2019 2019… E                 2019 2019-09-0… 2019-07-01T00:… 2020-05…
#>  9 EuroL… E2018 2018… E                 2018 2018-09-0… 2018-07-02T00:… 2019-05…
#> 10 EuroL… E2017 2017… E                 2017 2017-10-0… 2017-07-01T00:… 2018-05…
#> # ℹ 17 more rows
#> # ℹ 8 more variables: winner <chr>, winner_code <chr>, winner_name <chr>,
#> #   winner_abbreviated_name <chr>, winner_editorial_name <chr>,
#> #   winner_tv_code <chr>, winner_is_virtual <lgl>, winner_images_crest <chr>
# }
```
