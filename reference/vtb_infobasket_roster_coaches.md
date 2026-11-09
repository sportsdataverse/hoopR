# **Get VTB Infobasket Roster Coaches**

A club's coaches in one season (no birth data).

Endpoint: `GET https://org.infobasket.su/Widget/TeamRoster/{team_id}`

## Usage

``` r
vtb_infobasket_roster_coaches(team_id, season, lang = "en", tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached). Required.

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: A club's coaches in one season (no birth data).
The columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_roster_coaches`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| person_id | integer | Infobasket person id (PersonID): one person (player, coach or official) across clubs and seasons. Joins to /Widget/PlayerPage/{personId} (players) and /Widget/CoachPage/{personId} (coaches). |
| coach_number | integer | Coach order on the team sheet (1 = head coach). |
| display_number | character | Shirt number as displayed ('0' and '00' differ). |
| post_id | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| post | character | Coaching post ('Head Coach', 'Assistant Coach'). |
| country_code_ioc | character | Nationality code: ISO 3166 alpha-2 in most rows ('RU', 'US'), IOC alpha-3 in some ('BLR'). |
| country_name | character | Nationality, English country name. |
| rank | integer | Unobserved: the roster sends an empty string for every player and coach (null here); the field belongs to the leader lists (best_players), so its meaning on the roster is unconfirmed. |
| is_active | logical | True while the person is on the current roster. |
| active_status | character | Roster status text ('Accepted'), empty otherwise. |
| person_last_name_ru | character | Last name, Russian. |
| person_last_name_en | character | Last name, English. |
| person_first_name_ru | character | First name, Russian. |
| person_first_name_en | character | First name, English. |
| person_full_name_ru | character | Full name, 'Last First', Russian. |
| person_full_name_en | character | Full name, 'Last First', English. |
| person_gender | integer | Person gender: 1 on every sampled (male) person. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_roster_coaches(season = 2026, team_id = 2650)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
