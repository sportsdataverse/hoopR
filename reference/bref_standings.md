# **Basketball-Reference Standings**

**Get end-of-season conference standings from
[Basketball-Reference](https://www.basketball-reference.com).**

No API key is required. Basketball-Reference rate-limits aggressive
scraping (~20 requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_standings(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per team:

|               |           |                                                    |
|---------------|-----------|----------------------------------------------------|
| col_name      | types     | description                                        |
| conference    | character | Conference (`E` or `W`).                           |
| team          | character | Team name (with playoff-seed marker stripped).     |
| wins          | integer   | Wins.                                              |
| losses        | integer   | Losses.                                            |
| win_loss_pct  | numeric   | Win-loss percentage.                               |
| gb            | character | Games behind the conference leader.                |
| pts_per_g     | numeric   | Points scored per game.                            |
| opp_pts_per_g | numeric   | Opponent points per game.                          |
| srs           | numeric   | Simple Rating System (point margin + SOS).         |
| playoffs      | logical   | `TRUE` if the team made the playoffs (`*` marker). |
| season        | integer   | Season (echoes the `season` argument).             |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_standings(season = 2024))
#> ── Standings from basketball-reference.com ────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 03:58:47 UTC
#> # A tibble: 30 × 11
#>    team             wins losses win_loss_pct gb    pts_per_g opp_pts_per_g   srs
#>    <chr>           <dbl>  <dbl>        <dbl> <chr>     <dbl>         <dbl> <dbl>
#>  1 Boston Celtics     64     18        0.78  —          121.          109. 10.8 
#>  2 New York Knicks    50     32        0.61  14.0       113.          108.  4.36
#>  3 Milwaukee Bucks    49     33        0.598 15.0       119           116.  2.44
#>  4 Cleveland Cava…    48     34        0.585 16.0       113.          110.  1.98
#>  5 Orlando Magic      47     35        0.573 17.0       110.          108.  1.48
#>  6 Indiana Pacers     47     35        0.573 17.0       123.          120.  2.75
#>  7 Philadelphia 7…    47     35        0.573 17.0       115.          112.  2.51
#>  8 Miami Heat         46     36        0.561 18.0       110.          108.  1.1 
#>  9 Chicago Bulls      39     43        0.476 25.0       112.          114. -1.77
#> 10 Atlanta Hawks      36     46        0.439 28.0       118.          120. -2.38
#> # ℹ 20 more rows
#> # ℹ 3 more variables: conference <chr>, playoffs <lgl>, season <int>
# }
```
