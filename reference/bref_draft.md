# **Basketball-Reference Draft**

**Get NBA draft results with career stats from
[Basketball-Reference](https://www.basketball-reference.com).**

Returns every pick of a draft, paired with the player's career totals
and advanced metrics. No API key is required. Basketball-Reference
rate-limits aggressive scraping (~20 requests/minute) – space repeated
calls with [`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_draft(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Draft year (e.g. `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per draft pick (career columns shown
– column names are Basketball-Reference `data-stat` keys):

|              |           |                                            |
|--------------|-----------|--------------------------------------------|
| col_name     | types     | description                                |
| pick_overall | integer   | Overall draft pick number.                 |
| round        | integer   | Draft round.                               |
| team         | character | Drafting team abbreviation.                |
| player       | character | Player name.                               |
| college_name | character | College / pre-draft team.                  |
| seasons      | integer   | NBA seasons played.                        |
| g            | integer   | Career games.                              |
| pts          | numeric   | Career points.                             |
| trb          | numeric   | Career total rebounds.                     |
| ast          | numeric   | Career assists.                            |
| ws           | numeric   | Career win shares.                         |
| bpm          | numeric   | Career box plus/minus.                     |
| vorp         | numeric   | Career value over replacement player.      |
| season       | integer   | Draft year (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_draft(season = 2024))
# }
}
```
