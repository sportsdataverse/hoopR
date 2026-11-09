# **Get VTB Infobasket Team Seasons**

The seasons a club has data for (END year and the club's competition
id).

Endpoint:
`GET https://org.infobasket.su/Widget/GetTeamSeasons/{team_id}`

## Usage

``` r
vtb_infobasket_team_seasons(team_id, lang = "en", tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: The seasons a club has data for (END year and the
club's competition id). The columns are always these, in this order
(sportsdataverse-py `vtb_infobasket_team_seasons`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| season | integer | Season END year of the club's season entry (2027 = 2026/2027). |
| comp_id | integer | Competition id of the season in the club's rfb tag (56293 for 2027), not the VTB tag's season CompID. |
| season_name | character | Season name in Russian ('Sezon 2026/2027' = 'Season 2026/2027'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_team_seasons(team_id = 2650)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
