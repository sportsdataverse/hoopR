# **EuroLeague Team Stats (season)**

**Get season team stats, traditional (box-score totals or per-game
averages) or advanced (eFG%, TS%, four-factor style rates), one row per
team.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/teams/{mode}`

## Usage

``` r
euroleague_team_stats(
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

A `hoopR_data` tibble with one row per team. Its columns depend on
`mode`: `"traditional"`, `"advanced"`. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_team_stats")`) and in the
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
    euroleague_team_stats(competition_code = "E", season_code = "E2025")
    euroleague_team_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
  })
#> ── EuroLeague advanced team stats from api-live.euroleague.net ── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:38 UTC
#> # A tibble: 20 × 20
#>    team_ranking games_played effective_field_goal_perce…¹ true_shooting_percen…²
#>           <int>        <dbl> <chr>                        <chr>                 
#>  1            1           38 50.7%                        54.6%                 
#>  2            2           38 53.9%                        57.9%                 
#>  3            3           38 54.1%                        57.5%                 
#>  4            4           43 54.2%                        58.4%                 
#>  5            5           38 53%                          56.9%                 
#>  6            6           38 54.4%                        58.5%                 
#>  7            7           38 53.8%                        57.6%                 
#>  8            8           40 55.4%                        58.8%                 
#>  9            9           38 55.1%                        59.9%                 
#> 10           10           38 56.5%                        60.7%                 
#> 11           11           39 54.5%                        58.3%                 
#> 12           12           42 57.6%                        61.2%                 
#> 13           13           44 55%                          59%                   
#> 14           14           42 56.1%                        59.6%                 
#> 15           15           38 54.1%                        59.5%                 
#> 16           16           38 53.5%                        58.3%                 
#> 17           17           43 54.6%                        59.4%                 
#> 18           18           44 56%                          58.8%                 
#> 19           19           44 56.2%                        60.4%                 
#> 20           20           43 57.1%                        61.5%                 
#> # ℹ abbreviated names: ¹​effective_field_goal_percentage,
#> #   ²​true_shooting_percentage
#> # ℹ 16 more variables: offensive_rebounds_percentage <chr>,
#> #   defensive_rebounds_percentage <chr>, rebounds_percentage <chr>,
#> #   assists_to_turnovers_ratio <dbl>, assists_ratio <chr>,
#> #   turnovers_ratio <chr>, two_point_rate <chr>, three_point_rate <chr>,
#> #   free_throws_rate <chr>, points_from_two_pointers_percentage <chr>, …
# }
```
