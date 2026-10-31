# **Basketball-Reference Team Season Stats**

**Get team season statistics from
[Basketball-Reference](https://www.basketball-reference.com).**

Scrapes a team stat table from the league season page. No API key is
required. Basketball-Reference rate-limits aggressive scraping (~20
requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_teams_stats(season = most_recent_nba_season(), table = "per_game")
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- table:

  (*character* optional): Which team table to return. One of `per_game`
  (default, team per-game), `totals`, `per_poss` (per 100 poss),
  `advanced`, or `opponent` (opponent per-game).

## Value

A `hoopR_data` tibble with one row per team (columns vary by `table`;
common identifying columns shown – names are Basketball-Reference
`data-stat` keys):

|          |           |                                        |
|----------|-----------|----------------------------------------|
| col_name | types     | description                            |
| ranker   | integer   | Row rank.                              |
| team     | character | Team name.                             |
| g        | integer   | Games played.                          |
| mp       | numeric   | Minutes played.                        |
| pts      | numeric   | Points (scaled to the chosen `table`). |
| season   | integer   | Season (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_teams_stats(season = 2024, table = "per_game"))
# }
}
```
