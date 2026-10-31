# **Basketball-Reference Player Game Log**

**Get a player's game-by-game log for a season from
[Basketball-Reference](https://www.basketball-reference.com).**

No API key is required. Basketball-Reference rate-limits aggressive
scraping (~20 requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_player_game_log(player_id, season = most_recent_nba_season())
```

## Arguments

- player_id:

  (*character* required): Basketball-Reference player id slug (e.g.
  `jokicni01` for Nikola Jokić, `jamesle01` for LeBron James). This is
  the id in the player's BREF URL (`/players/j/jokicni01.html`).

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per regular-season game (column names
are Basketball-Reference `data-stat` keys):

|  |  |  |
|----|----|----|
| col_name | types | description |
| ranker | integer | Season game number. |
| player_game_num_career | integer | Career game number. |
| date | character | Game date. |
| team | character | Team abbreviation. |
| location | character | `@` for away games, empty for home. |
| opp | character | Opponent abbreviation. |
| result | character | Result with final score (e.g. `W (+12)`). |
| is_starter | integer | 1 if the player started. |
| mp | character | Minutes played. |
| pts | numeric | Points. |
| trb | numeric | Total rebounds. |
| ast | numeric | Assists. |
| game_score | numeric | Hollinger game score. |
| plus_minus | numeric | Plus/minus. |
| player_id | character | Player id (echoes the `player_id` argument). |
| season | integer | Season (echoes the `season` argument). |

Full shooting / box columns (`fg`, `fga`, `fg_pct`, `fg3`, `ft`, `orb`,
`drb`, `stl`, `blk`, `tov`, `pf`, ...) are also returned.

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_player_game_log(player_id = "jokicni01", season = 2024))
# }
}
```
