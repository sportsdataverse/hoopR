# **Basketball-Reference Team Roster**

**Get a team's season roster from
[Basketball-Reference](https://www.basketball-reference.com).**

No API key is required. Basketball-Reference rate-limits aggressive
scraping (~20 requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_team_roster(team, season = most_recent_nba_season())
```

## Arguments

- team:

  (*character* required): Basketball-Reference team abbreviation (e.g.
  `BOS`, `LAL`, `GSW`). Historical franchises use their era code (e.g.
  `NJN`, `SEA`).

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per player on the roster:

|                  |           |                                                 |
|------------------|-----------|-------------------------------------------------|
| col_name         | types     | description                                     |
| number           | character | Jersey number.                                  |
| player           | character | Player name.                                    |
| pos              | character | Position.                                       |
| height           | character | Height.                                         |
| weight           | integer   | Weight (lbs).                                   |
| birth_date       | character | Birth date.                                     |
| years_experience | character | Years of NBA experience (`R` for rookies).      |
| college          | character | College.                                        |
| team             | character | Team abbreviation (echoes the `team` argument). |
| season           | integer   | Season (echoes the `season` argument).          |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_team_roster(team = "BOS", season = 2024))
# }
}
```
