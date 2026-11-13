# **EuroLeague Game Report**

**Get the report of one game: date, round, phase, both clubs with score
and last-5 form, one row.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/report`

## Usage

``` r
euroleague_game_report(competition_code, season_code, game_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_game_report")`) and in the
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
    euroleague_game_report(competition_code = "E", season_code = "E2025", game_code = 1)
  })
#> ── EuroLeague game report from api-live.euroleague.net ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:33 UTC
#> # A tibble: 1 × 45
#>   game_code round round_alias round_name played date              confirmed_date
#>   <chr>     <int> <chr>       <chr>      <lgl>  <chr>             <lgl>         
#> 1 1             1 Round 1     Round 1    TRUE   2025-09-30T19:45… TRUE          
#> # ℹ 38 more variables: confirmed_hour <lgl>, local_time_zone <int>,
#> #   local_date <chr>, utc_date <chr>, local_last5_form <chr>,
#> #   road_last5_form <chr>, season_name <chr>, season_code <chr>,
#> #   season_alias <chr>, season_competition_code <chr>, season_year <int>,
#> #   season_start_date <chr>, group_id <chr>, group_order <int>,
#> #   group_name <chr>, group_raw_name <chr>, phase_type_code <chr>,
#> #   phase_type_alias <chr>, phase_type_name <chr>, …
# }
```
