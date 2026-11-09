# **Get VTB Infobasket Game Staff**

The coaches and officials of a finished game (names and roles only).

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_game_staff(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: The coaches and officials of a finished game
(names and roles only). The columns are always these, in this order
(sportsdataverse-py `vtb_infobasket_game_staff`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Infobasket GameID of the game (the v2 matches' match_id); global across seasons. |
| team_number | integer | Side: 1 team A (home), 2 team B (away), 0 neither (officials, the placeholder row). |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| start_id | integer | Line-up slot id within this game; not a person id. |
| start_type | integer | Line-up row type: 3 coach, 4 official. |
| role | character | English role of the person: head coach, assistant coach, referee, commissioner, table official (from start_type and pos_id). |
| pos_id | integer | Position code of the coach or official (coach 1000 head / 1001 assistant; referees 101-103, commissioner 104, table officials 111-123). |
| person_id | integer | Infobasket person id (PersonID): one person (player, coach or official) across clubs and seasons. Joins to /Widget/PlayerPage/{personId} (players) and /Widget/CoachPage/{personId} (coaches). 0 on team and placeholder rows. |
| person_name_en | character | Name in English, as 'Last First'. |
| person_name_ru | character | Name in Russian, as 'Last First'. |
| country_code_ioc | character | Country code as the host sends it (ISO alpha-2 in most rows, IOC alpha-3 in some). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_game_staff(game_id = 921391)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
