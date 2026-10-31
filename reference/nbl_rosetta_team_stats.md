# **NBL Rosetta Team Stats**

Team season totals and averages by period (0 = whole game, 1-4 quarters,
5 and up overtime).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/team/stats/for/season/{season}/regular`

## Usage

``` r
nbl_rosetta_team_stats(season, org = "nbl", limit = NULL)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble (one row per team and period):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| assists | integer | Assists, team season total (in that period on period rows) |
| assists_average | double | Assists per game. |
| blocks | integer | Blocks, team season total (in that period on period rows) |
| blocks_average | double | Blocks per game. |
| defensive_rebounds | integer | Defensive rebounds, team season total (in that period on period rows) |
| field_goals_attempted | integer | Field goals attempted, team season total (in that period on period rows) |
| field_goals_attempted_average | double | Field goals attempted per game. |
| field_goals_made | integer | Field goals made, team season total (in that period on period rows) |
| field_goals_made_average | double | Field goals made per game. |
| field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
| fouls | integer | Fouls committed (personal + technical + others), team season total (in that period on period rows) |
| fouls_average | double | Fouls committed (personal + technical + others) per game. |
| free_throws_attempted | integer | Free throws attempted, team season total (in that period on period rows) |
| free_throws_attempted_average | double | Free throws attempted per game. |
| free_throws_made | integer | Free throws made, team season total (in that period on period rows) |
| free_throws_made_average | double | Free throws made per game. |
| free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
| games | integer | Games played in the season (in the period rows, by the player or team). |
| minutes | double | Player-minutes played (5 x game minutes) |
| offensive_rebounds | integer | Offensive rebounds, team season total (in that period on period rows) |
| offensive_rebounds_average | double | Offensive rebounds per game. |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| personal_fouls_average | double | Personal fouls per game. |
| points | integer | Points, team season total (in that period on period rows) |
| points_average | double | Points per game. |
| rebounds | integer | Total rebounds, team season total (in that period on period rows) |
| rebounds_average | double | Total rebounds per game. |
| results_string | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| steals | integer | Steals, team season total (in that period on period rows) |
| steals_average | double | Steals per game. |
| three_points_attempted | integer | Three-point field goals attempted, team season total (in that period on period rows) |
| three_points_attempted_average | double | Three-point field goals attempted per game. |
| three_points_made | integer | Three-point field goals made, team season total (in that period on period rows) |
| three_points_made_average | double | Three-point field goals made per game. |
| three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
| turnovers | integer | Turnovers, team season total (in that period on period rows) |
| turnovers_average | double | Turnovers per game. |
| two_points_attempted | integer | Two-point field goals attempted, team season total (in that period on period rows) |
| two_points_attempted_average | double | Two-point field goals attempted per game. |
| two_points_made | integer | Two-point field goals made, team season total (in that period on period rows) |
| two_points_made_average | double | Two-point field goals made per game. |
| two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
| rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_team_stats(org = "nbl", season = 2026)

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
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)
