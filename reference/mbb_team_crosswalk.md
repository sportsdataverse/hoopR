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

- `kp_*` comes from `teams_links` for that season (2002-2027); a season
  it does not carry gets NA `kp_*`.

The NCAA, ESPN play-by-play, Warren Nolan, 247Sports and
Sports-Reference names (`ncaa_team` through `sref_team`) come from
[mbb_team_names](https://hoopR.sportsdataverse.org/reference/mbb_team_names.md),
joined on `espn_team_id`. They are **not** read as of `season`: each
team has one set of names (as the 2023 source recorded them, so some
predate a rename), applied to every season. A name that is not known is
NA, never a guess.

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

A `hoopR_data` tibble with one row per ESPN team.

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
| ncaa_team | character | NCAA (stats.ncaa.org) team name; same for every season (NA if unknown). |
| espn_pbp_name | character | Team name as ESPN play-by-play prints it; same for every season (NA if unknown). |
| warren_nolan_team | character | Warren Nolan team name; same for every season (NA if unknown). |
| team_247 | character | 247Sports team name; same for every season (NA if unknown). |
| sref_slug | character | Sports-Reference school URL slug (`/cbb/schools/<slug>/`); same for every season (NA if unknown). |
| sref_team | character | Sports-Reference school name; same for every season (NA if unknown). |
| yahoo_team_id | character | Yahoo team id (NA placeholder). |
| yahoo_team_name | character | Yahoo team name (NA placeholder). |
| fox_match_confidence | numeric | 1 for matched, NA for unmatched. |
| bart_match_confidence | numeric | 1 for matched, NA for unmatched. |
| kp_match_confidence | numeric | 1 for matched, NA for unmatched. |
| match_method | character | Combination of matched sources, e.g. "fox+bart+kp" / "fox+bart" / "bart+kp" / "fox_only" / "bart_only" / "kp_only" / "espn_only". |

## See also

Other MBB Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md)

## Examples

``` r
# \donttest{
  # Builds from ESPN, Torvik and one Fox request per conference (about 30).
  try(mbb_team_crosswalk(season = 2025))
#> ── MBB team crosswalk (ESPN / Fox / Torvik / KenPom) ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:01:11 UTC
#> # A tibble: 365 × 27
#>    season espn_team_id espn_abbreviation espn_display_name       espn_short_name
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2025         2000 ACU               Abilene Christian Wild… Abilene Chrstn 
#>  2   2025         2005 AF                Air Force Falcons       Air Force      
#>  3   2025         2006 AKR               Akron Zips              Akron          
#>  4   2025         2010 AAMU              Alabama A&M Bulldogs    Alabama A&M    
#>  5   2025          333 ALA               Alabama Crimson Tide    Alabama        
#>  6   2025         2011 ALST              Alabama State Hornets   Alabama St     
#>  7   2025         2016 ALCN              Alcorn State Braves     Alcorn St      
#>  8   2025           44 AMER              American University Ea… American       
#>  9   2025         2026 APP               App State Mountaineers  App State      
#> 10   2025            9 ASU               Arizona State Sun Devi… Arizona St     
#> # ℹ 355 more rows
#> # ℹ 22 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   espn_conference <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   fox_section <chr>, bart_team <chr>, bart_conf <chr>, kp_team <chr>,
#> #   kp_conf <chr>, ncaa_team <chr>, espn_pbp_name <chr>,
#> #   warren_nolan_team <chr>, team_247 <chr>, sref_slug <chr>, sref_team <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_name <chr>, fox_match_confidence <dbl>, …
# }
```
