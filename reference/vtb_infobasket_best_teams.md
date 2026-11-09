# **Get VTB Infobasket Best Teams**

Team leaders of a season for the first `count` leader categories.

Endpoint: `GET https://org.infobasket.su/Comp/GetBestTeams/{season}`

## Usage

``` r
vtb_infobasket_best_teams(season, count = 5, lang = "en", tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- count:

  Leader categories to return (the site's widget asks 5).

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: Team leaders of a season for the first `count`
leader categories. The columns are always these, in this order
(sportsdataverse-py `vtb_infobasket_best_teams`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| param_id | integer | Leader-category id (the `param` of the parameter lists). |
| param_name | character | Leader category name (ParamName), e.g. 'Points'. |
| param_short_name | character | Leader category short label, e.g. 'Points in a game'. |
| param_label | character | Leader category label in the requested language (lang). |
| param_group | integer | Category group; 0 in the samples. |
| rank | integer | Rank in the leader list. |
| team_id | integer | Infobasket TeamID (2650 = Lokomotiv Kuban); the v2 teamId. Not a club-record id and not a registration id. |
| team_short_name_ru | character | The the team's short name in Russian (as the competition names it). |
| team_short_name_en | character | The the team's short name in English (as the competition names it). |
| team_name_ru | character | The the team's name in Russian (as the competition names it). |
| team_name_en | character | The the team's name in English (as the competition names it). |
| team_region_name_ru | character | The the team's region or city in Russian (as the competition names it). |
| team_region_name_en | character | The the team's region or city in English (as the competition names it). |
| game_id | integer | Infobasket GameID of the game (the v2 matches' match_id); global across seasons. |
| game_count | integer | Games the value is averaged over. |
| res | double | The leader's value (a per-game average for 'in a game' categories). |
| pre_res | character | The value as displayed, a string (e.g. '1070' for 10.70 without separator; format unverified). |
| is_same | logical | True when the row ties the previous one. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_best_teams(season = 2026)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
