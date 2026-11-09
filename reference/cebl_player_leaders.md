# **Get CEBL Player Leaders**

Top five players per requested statistic (long frame, one row per
statistic and leader).

Endpoint: `GET https://api.data.cebl.ca/players/statistics/leaders/`

## Usage

``` r
cebl_player_leaders(
  statistics = "POINTS,REBOUNDS,ASSISTS,TARGET_SCORES",
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  team_id = NULL
)
```

## Arguments

- statistics:

  (default `"POINTS,REBOUNDS,ASSISTS,TARGET_SCORES"`) Comma-separated
  statistic names; the frame has one block per name. Names the Stats Hub
  sends: POINTS, REBOUNDS, ASSISTS, BLOCKS, STEALS, TARGET_SCORES,
  FIELD_GOAL_PERCENTAGE, THREE_POINTS_MADE, THREE_POINT_PERCENTAGE,
  FREE_THROW_PERCENTAGE, FOULS, TURNOVERS, MINUTES.

- mode:

  (default `"PER_GAME"`) TOTALS (sums over the selected games) or
  PER_GAME (per-game averages); the API requires one.

- season:

  (default `NULL`) Season: the calendar year (May to August) = the sdv
  END year. `NULL` = every season combined (the Stats Hub's All-Time).
  An unknown year answers `hoopR_no_data`.

- competition:

  (default `NULL`) REGULAR (regular season) or FINALS (the playoffs).
  `NULL` = both.

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble with one row per statistic and leader. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_player_leaders")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_player_leaders(mode = "PER_GAME", season = 2025)

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
