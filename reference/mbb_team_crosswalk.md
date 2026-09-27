# **Get the MBB cross-source team crosswalk**

Build a wide, one-row-per-team-per-season crosswalk linking ESPN, Fox
Sports (Bifrost), Bart Torvik (barttorvik.com), and KenPom
([`hoopR::teams_links`](https://hoopR.sportsdataverse.org/reference/teams_links.md)
bundled data) men's college basketball team identities, keyed on
`espn_team_id`. Yahoo columns are NA placeholders. ESPN is deduped by
`team_id` (first occurrence kept).

Fox is joined on the full normalized mascot name (with a curated alias
bridge for cases where Fox and ESPN differ). Torvik and KenPom are each
joined on the normalized school/location name after a curated alias pass
for common divergences (e.g. "UConn" / "Connecticut", "Ole Miss" /
"Mississippi", "LIU" / "Long Island University"). No authentication is
required for any source.

Every source is read **as of `season`**:

- `espn_conference` is the conference each team was in that season,
  under that season's name, from the SDV conference reference
  ([`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)
  and
  [`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md)).
  The ESPN team list itself is today's Division I list, so a team that
  was not in a Division I conference that season has an NA
  `espn_conference`.

- `fox_section` comes from Fox's per-conference standings for that
  season (`league/standings?groupId=&season=`), which start in 2017-18:
  earlier seasons get NA `fox_*`. Fox lists teams under the conference
  they joined the NEXT season, so `fox_section` is set to NA where it
  disagrees with `espn_conference`, and for any Fox conference with
  fewer than two agreeing teams that stay put the next season.
  `fox_team_id` is kept.

- `bart_*` comes from Torvik's `{season}_team_results.csv` (2008 on;
  earlier seasons get NA `bart_*`).

- `kp_*` comes from `teams_links` for that season (2002-2026); a season
  it does not carry gets NA `kp_*`.

A source that fails raises an error instead of returning a crosswalk
whose columns are silently all NA. Torvik answering with no teams
(blocked or empty) for a season it covers, Fox returning no standings
for the season, and a missing conference reference raise an error of
class `crosswalk_source_error`.

## Usage

``` r
mbb_team_crosswalk(season = most_recent_mbb_season(), fox = NULL)
```

## Arguments

- season:

  Season year (4-digit, ending year, e.g. `2025` = 2024-25). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- fox:

  An already-fetched frame with `fox_team_id`, `fox_team_name` and
  `fox_section`, or `NULL` (default) to fetch `season`'s Fox standings
  live. Pass an empty
  [`data.frame()`](https://rdrr.io/r/base/data.frame.html) to skip Fox.

## Value

A `hoopR_data` tibble, one row per ESPN team:

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season year. |
| espn_team_id | integer | ESPN team id (canonical key). |
| espn_abbreviation | character | ESPN abbreviation. |
| espn_display_name | character | ESPN display name (school + mascot). |
| espn_short_name | character | ESPN short name. |
| espn_location | character | ESPN school/location only. |
| espn_mascot | character | ESPN mascot/nickname. |
| espn_conference | character | Conference that season, under that season's name (NA if not in a Division I conference). |
| fox_team_id | character | Fox Bifrost team id (NA if unmatched). |
| fox_team_name | character | Fox team name (NA if unmatched). |
| fox_section | character | Fox conference that season (NA if unmatched or unconfirmed). |
| bart_team | character | Torvik team name (NA if unmatched). |
| bart_conf | character | Torvik conference abbreviation (NA if unmatched). |
| kp_team | character | KenPom team name (NA if unmatched). |
| kp_conf | character | KenPom conference abbreviation (NA if unmatched). |
| yahoo_team_id | character | Yahoo team id (NA placeholder). |
| yahoo_team_name | character | Yahoo team name (NA placeholder). |
| fox_match_confidence | numeric | 1 for matched, NA for unmatched. |
| bart_match_confidence | numeric | 1 for matched, NA for unmatched. |
| kp_match_confidence | numeric | 1 for matched, NA for unmatched. |
| match_method | character | Combination of matched sources, e.g. |
|  |  | "fox+bart+kp" / "fox+bart" / "bart+kp" / |
|  |  | "fox_only" / "bart_only" / "kp_only" / |
|  |  | "espn_only". |

## See also

Other MBB Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md)

## Examples

``` r
# \donttest{
  try(mbb_team_crosswalk(season = 2025))
#> Error in .bb_source_error(sprintf("Torvik %d: no team rows (%d rows, columns %s); a blocked or empty response must not ship as NA bart_* columns",  : 
#>   Torvik 2025: no team rows (19 rows, columns doctype_html_public_w3c_dtd_html_4_01_transitional_en_http_www_w3_org_tr_html4_loose_dtd, year); a blocked or empty response must not ship as NA bart_* columns
# }
```
