# **Get ACB Team Totals**

A club's team season totals, averages and per-40 values for an edition.

One row: the same `total_*` / `avg_*` / `per40_*` columns as
`acb_team_stats`, for the team as a whole (`team_id` is the season-team
entry).

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-stats`

## Usage

``` r
acb_team_totals(club_id, competition_id = NULL, season = NULL)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_team_totals`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club_id | integer | Stable club id of the club asked for (2 = Barca). |
| team_id | integer | Season-team entry id (the API's teamEditionId). |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| total_num_games | integer | Season total of games played. |
| total_time_played | integer | Season total of time on court in seconds. |
| total_starter | integer | Season total of games started. |
| total_points | integer | Season total of points. |
| total_max_points | integer | Season total of most points in a single game. |
| total_three_pointers_made | integer | Season total of three-point field goals made. |
| total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
| total_three_pointers_percentage | double | Season total of three-point percentage (0-100). |
| total_two_pointers_made | integer | Season total of two-point field goals made. |
| total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
| total_two_pointers_percentage | double | Season total of two-point percentage (0-100). |
| total_free_throws_made | integer | Season total of free throws made. |
| total_free_throws_attempted | integer | Season total of free throws attempted. |
| total_free_throws_percentage | double | Season total of free-throw percentage (0-100). |
| total_rebounds | integer | Season total of total rebounds. |
| total_offensive_rebounds | integer | Season total of offensive rebounds. |
| total_defensive_rebounds | integer | Season total of defensive rebounds. |
| total_assists | integer | Season total of assists. |
| total_steals | integer | Season total of steals. |
| total_turnovers | integer | Season total of turnovers. |
| total_blocks | integer | Season total of blocks made. |
| total_shots_rejected | integer | Season total of own shots blocked. |
| total_dunks | integer | Season total of dunks. |
| total_personal_fouls | integer | Season total of personal fouls committed. |
| total_fouls_received | integer | Season total of fouls drawn. |
| total_rating | integer | Season total of ACB rating (valoracion). |
| total_plus_minus | integer | Season total of plus/minus. |
| total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
| total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
| avg_num_games | double | Per-game average of games played. |
| avg_time_played | double | Per-game average of time on court in seconds. |
| avg_starter | double | Per-game average of games started. |
| avg_points | double | Per-game average of points. |
| avg_max_points | double | Per-game average of most points in a single game. |
| avg_three_pointers_made | double | Per-game average of three-point field goals made. |
| avg_three_pointers_attempted | double | Per-game average of three-point field goals attempted. |
| avg_three_pointers_percentage | double | Per-game average of three-point percentage (0-100). |
| avg_two_pointers_made | double | Per-game average of two-point field goals made. |
| avg_two_pointers_attempted | double | Per-game average of two-point field goals attempted. |
| avg_two_pointers_percentage | double | Per-game average of two-point percentage (0-100). |
| avg_free_throws_made | double | Per-game average of free throws made. |
| avg_free_throws_attempted | double | Per-game average of free throws attempted. |
| avg_free_throws_percentage | double | Per-game average of free-throw percentage (0-100). |
| avg_rebounds | double | Per-game average of total rebounds. |
| avg_offensive_rebounds | double | Per-game average of offensive rebounds. |
| avg_defensive_rebounds | double | Per-game average of defensive rebounds. |
| avg_assists | double | Per-game average of assists. |
| avg_steals | double | Per-game average of steals. |
| avg_turnovers | double | Per-game average of turnovers. |
| avg_blocks | double | Per-game average of blocks made. |
| avg_shots_rejected | double | Per-game average of own shots blocked. |
| avg_dunks | double | Per-game average of dunks. |
| avg_personal_fouls | double | Per-game average of personal fouls committed. |
| avg_fouls_received | double | Per-game average of fouls drawn. |
| avg_rating | double | Per-game average of ACB rating (valoracion). |
| avg_plus_minus | double | Per-game average of plus/minus. |
| avg_wins | double | Per-game average of team wins in the counted games (meaning unverified). |
| avg_losses | double | Per-game average of team losses in the counted games (meaning unverified). |
| per40_num_games | double | Per-40-minute rate of games played. |
| per40_time_played | double | Always null: the per-40 block carries no time played. |
| per40_starter | double | Per-40-minute rate of games started. |
| per40_points | double | Per-40-minute rate of points. |
| per40_max_points | double | Per-40-minute rate of most points in a single game. |
| per40_three_pointers_made | double | Per-40-minute rate of three-point field goals made. |
| per40_three_pointers_attempted | double | Per-40-minute rate of three-point field goals attempted. |
| per40_three_pointers_percentage | double | Per-40-minute rate of three-point percentage (0-100). |
| per40_two_pointers_made | double | Per-40-minute rate of two-point field goals made. |
| per40_two_pointers_attempted | double | Per-40-minute rate of two-point field goals attempted. |
| per40_two_pointers_percentage | double | Per-40-minute rate of two-point percentage (0-100). |
| per40_free_throws_made | double | Per-40-minute rate of free throws made. |
| per40_free_throws_attempted | double | Per-40-minute rate of free throws attempted. |
| per40_free_throws_percentage | double | Per-40-minute rate of free-throw percentage (0-100). |
| per40_rebounds | double | Per-40-minute rate of total rebounds. |
| per40_offensive_rebounds | double | Per-40-minute rate of offensive rebounds. |
| per40_defensive_rebounds | double | Per-40-minute rate of defensive rebounds. |
| per40_assists | double | Per-40-minute rate of assists. |
| per40_steals | double | Per-40-minute rate of steals. |
| per40_turnovers | double | Per-40-minute rate of turnovers. |
| per40_blocks | double | Per-40-minute rate of blocks made. |
| per40_shots_rejected | double | Per-40-minute rate of own shots blocked. |
| per40_dunks | double | Per-40-minute rate of dunks. |
| per40_personal_fouls | double | Per-40-minute rate of personal fouls committed. |
| per40_fouls_received | double | Per-40-minute rate of fouls drawn. |
| per40_rating | double | Per-40-minute rate of ACB rating (valoracion). |
| per40_plus_minus | double | Per-40-minute rate of plus/minus. |
| per40_wins | double | Per-40-minute rate of team wins in the counted games (meaning unverified). |
| per40_losses | double | Per-40-minute rate of team losses in the counted games (meaning unverified). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_totals(club_id = 2, season = 2027)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
