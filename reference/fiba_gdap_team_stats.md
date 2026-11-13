# **FIBA GDAP: team stats**

A team's per-game averages and totals at a competition, with the bench
totals.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`

## Usage

``` r
fiba_gdap_team_stats(team_id, return_parsed = TRUE)
```

## Arguments

- team_id:

  (integer, required) Required. Competition team id: one per team per
  competition (teamA.teamId of a game row; Germany is 279569 at the 2023
  World Cup and 281545 at Paris 2024). Not the federation organisationId

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_team_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_team_stats(team_id = 279569))
#> ── FIBA gdap_team_stats from fiba.basketball ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:59:00 UTC
#> # A tibble: 1 × 75
#>   team_id competition_id points_per_game rebounds_per_game
#>     <int>          <int>           <dbl>             <dbl>
#> 1  279569         208182              93              36.1
#> # ℹ 71 more variables: rebounds_offensive_per_game <dbl>,
#> #   rebounds_defensive_per_game <dbl>, assists_per_game <dbl>,
#> #   blocks_per_game <dbl>, turnovers_per_game <dbl>, fouls_per_game <dbl>,
#> #   plus_minus_per_game <dbl>, efficiency_per_game <dbl>,
#> #   play_time_in_seconds_per_game <dbl>, field_goals_made_per_game <dbl>,
#> #   field_goals_attempted_per_game <dbl>, two_points_made_per_game <dbl>,
#> #   two_points_attempted_per_game <dbl>, three_points_made_per_game <dbl>, …
# }
```
