# **Get BNXT League Roster Entry**

One roster entry with its player, team and season.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/roster/find/{roster_id}`

## Usage

``` r
sportpress_roster_find(roster_id)
```

## Arguments

- roster_id:

  (required) Roster id (integer): one player on one team in one season;
  from the roster frames.

## Value

A `hoopR_data` tibble: One roster entry with its player, team and
season. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py
`sportpress_roster_find`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| weight | integer | Weight in kg; null when unknown. |
| height | integer | Height in cm; null when unknown. |
| active | logical | True for a current roster entry; former entries are false. |
| position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
| position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| uu_team_id | integer | Stable club key across seasons of the team. |
| team | character | Team display name including the sponsor. |
| team_short_name | character | Three-letter club code of the team. |
| competition_id | integer | Competition id the roster entry's team plays in. |
| season | integer | Season END year of the roster entry's competition. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_roster_find(roster_id = 11193)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
