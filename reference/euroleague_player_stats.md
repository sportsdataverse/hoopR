# **EuroLeague Player Stats (season)**

**Get season player stats, traditional (box-score totals or per-game
averages) or advanced (eFG%, TS%, rebound / assist / turnover rates),
one row per player.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/players/{mode}`

## Usage

``` r
euroleague_player_stats(
  competition_code,
  mode = c("traditional", "advanced"),
  season_mode = "Single",
  season_code = NULL,
  statistic_mode = "PerGame",
  limit = NULL,
  offset = NULL
)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- mode:

  (*character* default `"traditional"`): `"traditional"` or
  `"advanced"`, matched exactly (no prefixes, as in sportsdataverse-py);
  the columns depend on it (see Returns).

- season_mode:

  (*character* default `"Single"`): Season mode; `Single` as captured
  (other values unverified).

- season_code:

  (*character* required by the API): Competition code + start year, e.g.
  `E2025` for 2025-26 (the `SeasonCode` query parameter).

- statistic_mode:

  (*character* default `"PerGame"`): `PerGame` as captured (other values
  unverified).

- limit:

  (*integer* optional): Page size.

- offset:

  (*integer* optional): Row offset into the full list.

## Value

A `hoopR_data` tibble with one row per player. Its columns depend on
`mode`: `"traditional"`, `"advanced"`. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_player_stats")`) and in the
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
    euroleague_player_stats(competition_code = "E", season_code = "E2025", limit = 25)
    euroleague_player_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
  })
#> ── EuroLeague advanced player stats from api-live.euroleague.net ───────────────
#> ℹ Data updated: 2026-11-10 02:01:11 UTC
#> # A tibble: 100 × 23
#>    player_ranking games_played minutes_played effective_field_goal_percentage
#>             <int>        <dbl>          <dbl> <chr>                          
#>  1              1           27           6.23 47.1%                          
#>  2              2           26           5.11 50%                            
#>  3              3           26          10.1  44.5%                          
#>  4              4           31           8.59 43.7%                          
#>  5              5           25          10.8  30.2%                          
#>  6              6           40          10.7  38.8%                          
#>  7              7           36          14.3  49%                            
#>  8              8           31          16.4  51.7%                          
#>  9              9           29          10.6  60.3%                          
#> 10             10           24          16.4  47.9%                          
#> # ℹ 90 more rows
#> # ℹ 19 more variables: true_shooting_percentage <chr>,
#> #   offensive_rebounds_percentage <chr>, defensive_rebounds_percentage <chr>,
#> #   rebounds_percentage <chr>, assists_to_turnovers_ratio <dbl>,
#> #   assists_ratio <chr>, turnovers_ratio <chr>, two_point_attempts_ratio <chr>,
#> #   three_point_attempts_ratio <chr>, free_throws_rate <chr>, possesions <dbl>,
#> #   player_code <chr>, player_name <chr>, player_age <int>, …
# }
```
