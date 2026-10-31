# **Basketball-Reference Player Season Stats**

**Get player season statistics from
[Basketball-Reference](https://www.basketball-reference.com).**

Scrapes the league-wide player stat table for a season. No API key is
required. Choose the stat table with `table`. Data is available back to
the 1947 (BAA) season for most tables.

Basketball-Reference rate-limits aggressive scraping (~20
requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_players_stats(season = most_recent_nba_season(), table = "per_game")
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024` for the 2023-24 season). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- table:

  (*character* optional): Which stat table to return. One of `per_game`
  (default), `totals`, `advanced`, `per_minute` (per 36 minutes), or
  `per_poss` (per 100 possessions).

## Value

A `hoopR_data` tibble with one row per player (columns vary by `table`;
common identifying columns shown – column names are Basketball-Reference
`data-stat` keys):

|           |           |                                                       |
|-----------|-----------|-------------------------------------------------------|
| col_name  | types     | description                                           |
| ranker    | integer   | Row rank.                                             |
| player    | character | Player name.                                          |
| age       | integer   | Player age on Feb 1 of the season.                    |
| team_id   | character | Team abbreviation (`TOT` for players on \>1 team).    |
| pos       | character | Position.                                             |
| g         | integer   | Games played.                                         |
| gs        | integer   | Games started.                                        |
| mp_per_g  | numeric   | Minutes (per_game table) / `mp` total (totals table). |
| pts_per_g | numeric   | Points (scaled to the chosen `table`).                |
| season    | integer   | Season (echoes the `season` argument).                |

The `advanced` table adds `per`, `ts_pct`, `usg_pct`, `ws`, `bpm`,
`vorp`, etc.; `totals`/`per_minute`/`per_poss` return the same box
categories scaled accordingly.

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_players_stats(season = 2024, table = "per_game"))
# }
}
```
