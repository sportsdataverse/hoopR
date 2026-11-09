# **Get CEBL Team Statistics**

Team statistic table (totals or per game) with a league row; filter by
season, competition, segment, opponent team or opponent conference.

Endpoint: `GET https://api.data.cebl.ca/teams/statistics/aggregated/`

## Usage

``` r
cebl_team_stats(
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  segment = NULL,
  vs_team_id = NULL,
  vs_conference = NULL
)
```

## Arguments

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

- segment:

  (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last
  5 games), L10G (last 10 games), MAY, JUNE, JULY or AUGUST. `NULL` =
  all games. Values from the CEBL Stats Hub bundle.

- vs_team_id:

  (default `NULL`) CEBL team id of the opponent: only games against that
  team count.

- vs_conference:

  (default `NULL`) EAST or WEST: only games against that conference's
  teams count.

## Value

A `hoopR_data` tibble with one row per team, plus a league row. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_team_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_team_stats(mode = "TOTALS", season = 2025, competition = "REGULAR")

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
