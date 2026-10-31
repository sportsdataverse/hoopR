# **NBL Rosetta Team Stats Leaders**

Player season totals of one team in a season, optionally one period and
sorted.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/stats/leaders/for/season/id/{season_id}/team/{team_code}`

## Usage

``` r
nbl_rosetta_team_stats_leaders(
  season_id,
  team_code,
  org = "nbl",
  limit = NULL,
  period = NULL,
  sort = NULL
)
```

## Arguments

- season_id:

  (*character* required): Season id: the DataCore season id (season_id
  of nbl_rosetta_seasons) or Rosetta's own id (rosetta_season_id);
  either is accepted. Not the year.

- team_code:

  (*character* required): Team code (team_code of nbl_rosetta_teams),
  e.g. PER for the Perth Wildcats.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

- period:

  (*integer* default `NULL`): Period to keep: 0 = whole game, 1-4
  quarters, 5 and up overtime. Sent as `filter[period]`.

- sort:

  (*character* default `NULL`): Sort key; a leading minus sorts
  descending, e.g. -points.

## Value

A `hoopR_data` tibble (one row per player and period):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| assists_average | double | Assists per game. |
| blocks_average | double | Blocks per game. |
| field_goals_attempted | integer | Field goals attempted, season total. |
| field_goals_made | integer | Field goals made, season total. |
| field_goals_attempted_average | double | Field goals attempted per game. |
| field_goals_made_average | double | Field goals made per game. |
| field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
| fouls_average | double | Fouls committed (personal + technical + others) per game. |
| free_throws_attempted | integer | Free throws attempted, season total. |
| free_throws_made | integer | Free throws made, season total. |
| free_throws_attempted_average | double | Free throws attempted per game. |
| free_throws_made_average | double | Free throws made per game. |
| free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
| games | integer | Games played in the season (in the period rows, by the player or team). |
| games_started | integer | Games in the starting five. |
| offensive_rebounds | integer | Offensive rebounds, season total. |
| fouls | integer | Fouls committed (personal + technical + others), season total. |
| personal_fouls | integer | Personal fouls, season total. |
| technical_fouls | integer | Technical fouls, season total. |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| three_points_attempted | integer | Three-point field goals attempted, season total. |
| three_points_attempted_average | double | Three-point field goals attempted per game. |
| three_points_made | integer | Three-point field goals made, season total. |
| three_points_made_average | double | Three-point field goals made per game. |
| three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
| turnovers_average | double | Turnovers per game. |
| turnovers | integer | Turnovers, season total. |
| two_points_attempted | integer | Two-point field goals attempted, season total. |
| two_points_attempted_average | double | Two-point field goals attempted per game. |
| two_points_made | integer | Two-point field goals made, season total. |
| two_points_made_average | double | Two-point field goals made per game. |
| two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
| minutes | double | Minutes played, decimal minutes. |
| minutes_average | double | Minutes per game, decimal minutes. |
| points | integer | Points, season total. |
| rebounds | integer | Total rebounds, season total. |
| assists | integer | Assists, season total. |
| blocks | integer | Blocks, season total. |
| steals | integer | Steals, season total. |
| plus_minus | integer | Point differential while on court, season total. |
| plus_minus_average | double | Point differential while on court per game. |
| efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV), season total. |
| efficiency_average | double | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) per game. |
| points_average | double | Points per game. |
| rebounds_average | double | Total rebounds per game. |
| steals_average | double | Steals per game. |
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
| player_first_name | character | The player's given name, e.g. Elijah. |
| player_jersey_number | character | Jersey number, a STRING. |
| player_last_name | character | The player's family name, e.g. Pepper. |
| player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
| rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_competition_division | character | Always an empty array in samples; element shape and meaning unverified. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_team_stats_leaders(
       org = "nbl", period = 0, season_id = "1f8e4a79-e98b-457b-85a5-e4b898c6c0bd",
       sort = "-points", team_code = "PER"
     )

## See also

Other NBL Rosetta Functions:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_next_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_matches.md),
[`nbl_rosetta_outcomes()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_outcomes.md),
[`nbl_rosetta_player_game_log()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_game_log.md),
[`nbl_rosetta_player_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_stats.md),
[`nbl_rosetta_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_players.md),
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md),
[`nbl_rosetta_seasons_current()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons_current.md),
[`nbl_rosetta_standings()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_standings.md),
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)
