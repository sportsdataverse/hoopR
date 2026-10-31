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
if (FALSE) { # interactive()
# \donttest{
  try(bref_standings(season = 2024))
# }
}
```
