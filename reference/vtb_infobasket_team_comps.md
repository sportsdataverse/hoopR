# **Get VTB Infobasket Team Comps**

The competitions a club played in one season.

Endpoint: `GET https://org.infobasket.su/Widget/GetTeamComps/{team_id}`

## Usage

``` r
vtb_infobasket_team_comps(team_id, season, lang = "en", tag = "vtb")
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

A `hoopR_data` tibble: The competitions a club played in one season. The
columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_team_comps`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| comp_id | integer | Competition id (the season or a stage of it). |
| comp_type | integer | Stage type code: 0 season, regular season or group; 10 playoff container; 5 and 7 playoff series; -5 seen in season lists. Meanings inferred from the stage names, unverified. |
| comp_sort | integer | Sort order among sibling stages. |
| level | integer | Depth of the competition in the tree (1 = season level). |
| comp_name_ru | character | Competition name, Russian ('Edinaya liga VTB' = 'VTB United League'). |
| comp_name_en | character | Stage name (e.g. 'Regular Season'), English. |
| parent_comp_id | integer | Unobserved: null in every sample, so its type and meaning are unconfirmed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_team_comps(season = 2026, team_id = 2650)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
