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
required for any source — Fox is the only network call (slow, ~60 s);
Torvik is a single CSV; KenPom uses the bundled `teams_links` object.

## Usage

``` r
mbb_team_crosswalk(season = most_recent_mbb_season(), fox = NULL)
```

## Arguments

- season:

  Season year (4-digit, e.g. `2025`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- fox:

  An already-fetched
  [`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)
  frame, or `NULL` (default) to fetch live. Pass a pre-fetched frame to
  avoid the ~60-second Fox enumeration when calling repeatedly.

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
| espn_conference | character | ESPN conference name. |
| fox_team_id | character | Fox Bifrost team id (NA if unmatched). |
| fox_team_name | character | Fox team name (NA if unmatched). |
| fox_section | character | Fox conference/section label (NA if unmatched). |
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
#> ✖ 2026-08-25 01:47:51.852911: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.405846: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.60481: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.626517: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.647258: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.722781: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.768162: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.789381: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.809924: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.831605: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.853725: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.875116: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.897411: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.920423: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.94215: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.964803: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:52.985665: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.006097: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.039769: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.06343: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.0865: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.108501: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.129257: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.150067: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.172224: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.195208: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.252088: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 01:47:53.274299: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── MBB team crosswalk (ESPN / Fox / Torvik / KenPom) ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:47:53 UTC
#> # A tibble: 366 × 21
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
#> # ℹ 356 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   espn_conference <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   fox_section <chr>, bart_team <chr>, bart_conf <chr>, kp_team <chr>,
#> #   kp_conf <chr>, yahoo_team_id <chr>, yahoo_team_name <chr>,
#> #   fox_match_confidence <dbl>, bart_match_confidence <dbl>,
#> #   kp_match_confidence <dbl>, match_method <chr>
# }
```
