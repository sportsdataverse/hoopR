# **Get BBL / DBBL Season Player Profile**

Player profile by season-player id: bio, position, club and previous
clubs.

Endpoint:
`GET https://api.basketball-bundesliga.de/season-players/{season_player_id}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_season_player(season_player_id, league = "bbl")
```

## Arguments

- season_player_id:

  (required) Season-player id (`season_player_id` in a box score, an
  action or `scb_season_players`): one player's engagement with one
  club.

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble: Player profile by season-player id: bio,
position, club and previous clubs. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `scb_season_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| active_season_player_id | character | The player's current season-player id (his latest club engagement). Joins to `/season-players/{seasonPlayerId}`. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| birth_date | character | Date of birth, YYYY-MM-DD. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| shirt_number | character | Jersey number. A number or a numeric string across rows. |
| height | double | Height in metres (float32 noise: 1.77 arrives as 1.7699999809265137). |
| weight | integer | Weight in kg; 0 when unknown. |
| nationalities | character | Nationalities, ISO 3166-1 alpha-2 codes. |
| is_all_star | logical | All-Star selection flag. |
| is_young | logical | Young-player flag (German-trained youth rule; inferred). |
| has_changed_teams | logical | Moved clubs during the season. |
| bbl_games_played | integer | Career league games played (BBL host; 0 on DBBL). |
| team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
| team_name | character | Team name as listed that season (sponsor names included). |
| previous_teams | character | Former clubs, free text (German names). |
| season_ids | character | Seasons (start years) with this player or club. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_season_player(season_player_id = "56414")

## See also

Other SCB Functions:
[`scb_game()`](https://hoopR.sportsdataverse.org/reference/scb_game.md),
[`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md),
[`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md),
[`scb_game_teams()`](https://hoopR.sportsdataverse.org/reference/scb_game_teams.md),
[`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md),
[`scb_games_recent()`](https://hoopR.sportsdataverse.org/reference/scb_games_recent.md),
[`scb_player_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_player_statistics.md),
[`scb_playoff_games()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_games.md),
[`scb_playoff_series()`](https://hoopR.sportsdataverse.org/reference/scb_playoff_series.md),
[`scb_records_per_game()`](https://hoopR.sportsdataverse.org/reference/scb_records_per_game.md),
[`scb_records_season_averages()`](https://hoopR.sportsdataverse.org/reference/scb_records_season_averages.md),
[`scb_referees()`](https://hoopR.sportsdataverse.org/reference/scb_referees.md),
[`scb_season_players()`](https://hoopR.sportsdataverse.org/reference/scb_season_players.md),
[`scb_season_teams()`](https://hoopR.sportsdataverse.org/reference/scb_season_teams.md),
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md),
[`scb_standings()`](https://hoopR.sportsdataverse.org/reference/scb_standings.md),
[`scb_team()`](https://hoopR.sportsdataverse.org/reference/scb_team.md),
[`scb_team_rosters()`](https://hoopR.sportsdataverse.org/reference/scb_team_rosters.md),
[`scb_team_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_team_seasons.md),
[`scb_team_statistics()`](https://hoopR.sportsdataverse.org/reference/scb_team_statistics.md),
[`scb_transfers()`](https://hoopR.sportsdataverse.org/reference/scb_transfers.md),
[`scb_transfers_teams()`](https://hoopR.sportsdataverse.org/reference/scb_transfers_teams.md)
