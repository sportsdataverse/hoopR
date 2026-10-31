# **Get BNXT League Game Play-by-Play (Film)**

Play-by-play ('film') of a finished game with court x/y (2021-22 and
2026-27 only).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/film/game/{competition_id}/{game_id}`

## Usage

``` r
sportpress_game_film(competition_id, game_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: Play-by-play ('film') of a finished game with
court x/y (2021-22 and 2026-27 only). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_game_film`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the film was asked for (the body does not echo it). |
| competition_id | integer | Competition id the film was asked for; checked against the game. |
| order | integer | Event sequence number in the game, strictly increasing from 0. |
| period | integer | Period of the event: 1-4 quarters, 5 and up overtimes. |
| minute | integer | Whole minutes ELAPSED in the period (not clock remaining). |
| second | integer | Seconds elapsed within that minute. |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| event_code | integer | Provider event code: 1000 made shot, 1001 missed shot, 1002 defensive rebound, 1003 offensive rebound, 1004 steal, 1005 turnover, 1006 foul drawn, 1007 foul committed, 1008 assist, 1009 block, 1011 substitution, 1101 period marker; 2xxx team events (meaning unverified). |
| event_subcode | integer | Provider sub-type of the event: for shots 1, 2 and 5 = two-pointer, 3 = three-pointer, 4 = free throw; turnover and foul sub-types are unnamed by the provider. |
| x | integer | Court x position of the event in the provider's integer court coordinates (0 on events with none); the coordinate system and orientation are unverified. |
| y | integer | Court y position of the event in the provider's integer court coordinates (0 on events with none); the coordinate system and orientation are unverified. |
| home_score | integer | Running home score AFTER the event; the maximum is the final score. |
| away_score | integer | Running away score AFTER the event; the maximum is the final score. |
| player_id | integer | Player id of the actor; null on team events and period markers. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| player2_id | integer | Player id of the second player; filled on substitutions only. |
| player2_first_name | character | Given name of the second player; substitutions only. |
| player2_last_name | character | Family name of the second player; substitutions only. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_game_film(competition_id = 25, game_id = 11295)

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md),
[`sportpress_game_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_find.md),
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
[`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md),
[`sportpress_player_career()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_career.md),
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)
