# **Get ACB Team Records**

A club's single-game records (best performance per statistic).

One row per statistic (`stat`): `value` is the record, with the game
(`game_id`, `game_date`), the player and both teams of that game.
Records go back to 1983-84; `game_id` is a match id of the legacy
sequence.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-records`

## Usage

``` r
acb_team_records(club_id)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_team_records`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club_id | integer | Stable club id asked for. |
| stat | character | Record category in snake_case (rating, points, rebounds, assists, steals, ...). |
| value | double | The record value (a count; Float64 so every category fits). |
| game_id | integer | Match id of the record game (legacy sequence for old games). |
| game_date | POSIXct | Date of the record game (UTC midnight). |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| local_team_id | integer | Home season-team entry of the record game. |
| local_club_id | integer | Home stable club id of the record game. |
| local_team | character | Home team name in the record game. |
| local_team_abbr | character | Home team abbreviation in the record game. |
| visitor_team_id | integer | Away season-team entry of the record game. |
| visitor_club_id | integer | Away stable club id of the record game. |
| visitor_team | character | Away team name in the record game. |
| visitor_team_abbr | character | Away team abbreviation in the record game. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_records(club_id = 2)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
