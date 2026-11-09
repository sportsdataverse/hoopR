# **Get BNXT League Game Top Performers**

The top performer of each side of a finished game, with his full line.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`

## Usage

``` r
sportpress_game_top_performers(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: The top performer of each side of a finished
game, with his full line. An empty valid answer raises `hoopR_no_data`;
the columns are always these, in this order (sportsdataverse-py
`sportpress_game_top_performers`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the overview was asked for (the body does not echo it). |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| jersey | character | Shirt number as text. |
| starter | logical | True when the player started the game. |
| minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
| foul | integer | Personal fouls committed. |
| defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
| dunk_made | integer | Dunks made (a subset of the two-point field goals). |
| dunk_all | integer | Dunks attempted. |
| dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
| two_point_made | integer | Two-point field goals made. |
| two_point_all | integer | Two-point field goals attempted. |
| two_point_percent | double | Two-point percentage 0-100. |
| three_point_made | integer | Three-point field goals made. |
| three_point_all | integer | Three-point field goals attempted. |
| three_point_percent | double | Three-point percentage 0-100. |
| throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
| throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
| throw_percent | double | Field-goal percentage 0-100. |
| free_throw_made | integer | Free throws made. |
| free_throw_all | integer | Free throws attempted. |
| free_throw_percent | double | Free-throw percentage 0-100. |
| offensive_rebound | integer | Offensive rebounds. |
| defensive_rebound | integer | Defensive rebounds. |
| total_rebound | integer | Total rebounds (offensive plus defensive). |
| block | integer | Shots blocked by the player. |
| block_against | integer | Own shots blocked by an opponent. |
| turnover | integer | Turnovers committed. |
| steal | integer | Steals (balls taken from an opponent). |
| assist | integer | Assists (passes leading directly to a made basket). |
| points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
| value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_game_top_performers(game_id = 11295)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
