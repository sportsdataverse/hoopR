# **RealGM NBA Player Stats**

**Get season player statistics leaders from
[RealGM](https://basketball.realgm.com).**

Returns the qualified-player leaderboard for a season, statistic family
and season segment. RealGM exposes basic box-score averages as well as
advanced and miscellaneous splits not all available from first-party
feeds.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_player_stats(
  season = most_recent_nba_season(),
  stat_type = "Averages",
  season_type = "Regular_Season"
)
```

## Arguments

- season:

  Season (the year the season ends, e.g. `2026` for 2025-26). Defaults
  to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- stat_type:

  Statistic family. One of `"Averages"` (default), `"Totals"`,
  `"Per_48"`, `"Per_40"`, `"Per_36"`, `"Per_Minute"`, `"Advanced_Stats"`
  or `"Misc_Stats"`.

- season_type:

  Season segment. One of `"Regular_Season"` (default), `"Playoffs"`,
  `"Preseason"` or `"Summer_League"`.

## Value

A `hoopR_data` tibble (one row per qualified player) carrying the
requested `season`, `stat_type` and `season_type` as columns. Columns
vary by `stat_type`; for `"Averages"`:

|          |           |                    |
|----------|-----------|--------------------|
| col_name | types     | description        |
| player   | character | Player name.       |
| team     | character | Team abbreviation. |
| gp       | integer   | Games played.      |
| mpg      | numeric   | Minutes per game.  |
| ppg      | numeric   | Points per game.   |
| rpg      | numeric   | Rebounds per game. |
| apg      | numeric   | Assists per game.  |

## See also

Other RealGM Functions:
[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md),
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md),
[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md),
[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md),
[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md),
[`realgm_gms()`](https://hoopR.sportsdataverse.org/reference/realgm_gms.md),
[`realgm_individual_games()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_games.md),
[`realgm_individual_seasons()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_seasons.md),
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md),
[`realgm_players_abroad()`](https://hoopR.sportsdataverse.org/reference/realgm_players_abroad.md),
[`realgm_rookie_scale()`](https://hoopR.sportsdataverse.org/reference/realgm_rookie_scale.md),
[`realgm_salary_cap()`](https://hoopR.sportsdataverse.org/reference/realgm_salary_cap.md),
[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md),
[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md),
[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md),
[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)

## Examples

``` r
# \donttest{
  try(realgm_player_stats(season = 2025, stat_type = "Averages"))
#> ── NBA player stats from basketball.realgm.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 18:21:04 UTC
#> # A tibble: 100 × 26
#>    number player      team     gp   mpg   ppg   fgm   fga fg_percent  x3pm  x3pa
#>     <dbl> <chr>       <chr> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl> <dbl> <dbl>
#>  1      1 Shai Gilge… OKC      76  34.2  32.7  11.3  21.8      0.519   2.1   5.7
#>  2      2 Giannis An… MIL      67  34.2  30.4  11.8  19.7      0.601   0.2   0.9
#>  3      3 Nikola Jok… DEN      70  36.7  29.6  11.2  19.5      0.576   2     4.7
#>  4      4 Luka Doncic LAL      50  35.4  28.2   9.2  20.5      0.45    3.5   9.6
#>  5      5 Anthony Ed… MIN      79  36.3  27.6   9.1  20.4      0.447   4.1  10.3
#>  6      6 Jayson Tat… BOS      72  36.4  26.8   9.2  20.3      0.452   3.5  10.1
#>  7      7 Kevin Dura… PHX      62  36.5  26.6   9.5  18.1      0.527   2.6   6  
#>  8      8 Tyrese Max… PHL      52  37.7  26.3   9.2  21        0.437   3.1   9.2
#>  9      9 Cade Cunni… DET      70  35    26.1   9.8  20.8      0.469   2.1   6  
#> 10     10 Jalen Brun… NYK      65  35.4  26     9    18.5      0.488   2.3   6.1
#> # ℹ 90 more rows
#> # ℹ 15 more variables: x3p_percent <dbl>, ftm <dbl>, fta <dbl>,
#> #   ft_percent <dbl>, orb <dbl>, drb <dbl>, rpg <dbl>, apg <dbl>, spg <dbl>,
#> #   bpg <dbl>, tov <dbl>, pf <dbl>, season <dbl>, stat_type <chr>,
#> #   season_type <chr>
# }
```
