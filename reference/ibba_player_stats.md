# **IBBA Player Stats**

**A player-season's totals, or per-game averages with
is_averages=True.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerStatsById`

## Usage

``` r
ibba_player_stats(player_id, season, is_averages = FALSE, is_playoff = FALSE)
```

## Arguments

- player_id:

  (*integer* required): Player-season id (new every season; Jaylen Hoard
  = 21912 in 2025-26): `player_id` in ibba_players.

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

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_player_stats")`) and in the
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
  try(ibba_player_stats(player_id = 21912, season = 2026))
#> ── IBBA player stats ──────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:50 UTC
#> # A tibble: 1 × 29
#>   player_id jersey season team_id games minutes   pts  fg2m  fg2a fg2_pct  fg3m
#>       <int> <chr>   <int>   <int> <int>   <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>
#> 1     21912 01       2026    1109    20     454   195    64   118      NA     5
#> # ℹ 18 more variables: fg3a <dbl>, fg3_pct <dbl>, ftm <dbl>, fta <dbl>,
#> #   ft_pct <dbl>, dreb <dbl>, oreb <dbl>, reb <dbl>, fouls_drawn <dbl>,
#> #   fouls <dbl>, steals <dbl>, turnovers <dbl>, assists <dbl>, blocks <dbl>,
#> #   blocks_against <dbl>, val <dbl>, plus_minus <dbl>, dunks <dbl>
# }
```
