# **Get VTB Infobasket Comp Issue**

Stage tree of a season (regular season, playoff, series): the stage ids
the standings wrappers take.

Endpoint: `GET https://org.infobasket.su/Widget/CompIssue/{season}`

## Usage

``` r
vtb_infobasket_comp_issue(season, tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: Stage tree of a season (regular season, playoff,
series): the stage ids the standings wrappers take. The columns are
always these, in this order (sportsdataverse-py
`vtb_infobasket_comp_issue`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26): the season the request asked for, stamped by the runtime. |
| season_comp_id | integer | Season-level Infobasket CompID of the season (50714 = 2025-26): the id every season-keyed route takes. |
| level | integer | Depth in the stage tree: 1 = a stage of the season, 2 = a series or group below it. |
| comp_id | integer | Stage CompID (the id vtb_infobasket_standings, \_cross_table and \_playoff take). |
| parent_comp_id | integer | CompID of the parent stage (0 at the top). |
| comp_type | integer | Stage type code: 0 season, regular season or group; 10 playoff container; 5 and 7 playoff series; -5 seen in season lists. Meanings inferred from the stage names, unverified. |
| comp_sort | integer | Sort order among sibling stages. |
| comp_round | integer | Playoff round as the number of series in it (4 = quarter-finals, 2 = semi-finals, 1 = final); 0 outside the playoff. |
| comp_short_name_ru | character | Stage name, Russian. |
| comp_short_name_en | character | Stage name, English. |
| comp_abc_name_ru | character | Stage abbreviation ('1/4-1' = quarter-final 1), Russian. |
| comp_abc_name_en | character | Stage abbreviation ('1/4-1' = quarter-final 1), English. |
| comp_gender | integer | Competition gender: 0 on every sample (men). |
| comp_state | integer | Stage state code: 0 or 2 seen (2 on finished stages, but some finished stages show 0); unverified. |
| is_public | logical | True when the site shows the stage. |
| note_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| note_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_comp_issue(season = 2026)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
