# **IBBA Team Stats**

**A team-season's totals, or per-game averages with is_averages=True.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/TeamStatsById`

## Usage

``` r
ibba_team_stats(team_id, season, is_averages = FALSE, is_playoff = FALSE)
```

## Arguments

- team_id:

  (*integer* required): Team-season id (new every season; Maccabi = 1109
  in 2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` /
  `away_team_id` or ibba_box_score.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- is_averages:

  (*logical*, default `FALSE`): True returns per-game averages
  (decimals); False (default) the season totals.

- is_playoff:

  (*logical*, default `FALSE`): True returns the playoff games only;
  False (default) the regular season.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_team_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(ibba_team_stats(season = 2026, team_id = 1109))
#> ── IBBA team stats ────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:59:20 UTC
#> # A tibble: 1 × 27
#>   season team_id games minutes   pts  fg2m  fg2a fg2_pct  fg3m  fg3a fg3_pct
#>    <int>   <int> <int>   <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl> <dbl>   <dbl>
#> 1   2026    1109    26    5225  2585   550   986      NA   348   851      NA
#> # ℹ 16 more variables: ftm <dbl>, fta <dbl>, ft_pct <dbl>, dreb <dbl>,
#> #   oreb <dbl>, reb <dbl>, fouls_drawn <dbl>, fouls <dbl>, steals <dbl>,
#> #   turnovers <dbl>, assists <dbl>, blocks <dbl>, blocks_against <dbl>,
#> #   val <dbl>, plus_minus <dbl>, dunks <dbl>
# }
```
