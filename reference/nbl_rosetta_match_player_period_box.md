# **NBL Rosetta Match Player Box Score by Period**

One match's player box score by period (Rosetta-computed from the event
log), one row per player and period.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_player_period_box(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble (one row per player and period):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
| match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
| player_first_name | character | The player's given name, e.g. Elijah. |
| player_last_name | character | The player's family name, e.g. Pepper. |
| player_jersey_number | character | Jersey number, a STRING. |
| player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
| period_type | character | Period type: regular (overtime unobserved) |
| rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
| assists | integer | Assists in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| blocks | integer | Blocks in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| defensive_rebounds | integer | Defensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
| fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
| minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
| offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| steals | integer | Steals in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| technical_fouls | integer | Technical fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_attempted | integer | Three-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_made | integer | Three-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
| turnovers | integer | Turnovers in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_attempted | integer | Two-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_made | integer | Two-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
| two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
| jersey_number | character | Jersey number, a STRING. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

     nbl_rosetta_match_player_period_box(match_id = "b217a699-4bef-11f0-bc08-933162362355")

## See also

Other NBL Rosetta Functions:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
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
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)
