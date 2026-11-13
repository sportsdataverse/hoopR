# **EuroLeague Games**

**Get the games of a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games`

## Usage

``` r
euroleague_games(competition_code, season_code, limit = NULL, offset = NULL)
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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_games")`) and in the
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
    euroleague_games(competition_code = "E", season_code = "E2025")
  })
#> ── EuroLeague games from api-live.euroleague.net ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:32 UTC
#> # A tibble: 402 × 101
#>    id             identifier game_code round round_alias round_name played date 
#>    <chr>          <chr>      <chr>     <int> <chr>       <chr>      <lgl>  <chr>
#>  1 13302d2b-97e6… E2025_406  406          47 Round 47    Round 47   TRUE   2026…
#>  2 1f32f9dc-91bf… E2025_405  405          46 Round 46    Round 46   TRUE   2026…
#>  3 8de7a6c5-68ab… E2025_404  404          46 Round 46    Round 46   TRUE   2026…
#>  4 9b5ebfbd-3338… E2025_403  403          45 Round 45    Round 45   TRUE   2026…
#>  5 5ffbcdf2-9182… E2025_399  399          44 Round 44    Round 44   TRUE   2026…
#>  6 e58d48f0-0537… E2025_397  397          44 Round 44    Round 44   TRUE   2026…
#>  7 93413528-9072… E2025_398  398          44 Round 44    Round 44   TRUE   2026…
#>  8 84fefa93-abdb… E2025_395  395          43 Round 43    Round 43   TRUE   2026…
#>  9 37a8e805-55b6… E2025_393  393          43 Round 43    Round 43   TRUE   2026…
#> 10 9b7f950f-b54a… E2025_392  392          43 Round 43    Round 43   TRUE   2026…
#> # ℹ 392 more rows
#> # ℹ 93 more variables: confirmed_date <lgl>, confirmed_hour <lgl>,
#> #   local_time_zone <int>, local_date <chr>, utc_date <chr>, audience <int>,
#> #   audience_confirmed <lgl>, social_feed <chr>, operations_code <chr>,
#> #   referee4 <chr>, is_neutral_venue <lgl>, game_status <chr>,
#> #   season_name <chr>, season_code <chr>, season_alias <chr>,
#> #   season_competition_code <chr>, season_year <int>, …
# }
```
