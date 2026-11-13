# **Load the stats.ncaa.org to ESPN MBB crosswalks**

stats.ncaa.org gives a team a new numeric id every season and spells
school names in AP style; ESPN keeps one id per school. These loaders
read the all-seasons crosswalk tables on the `mbb_crosswalk` release tag
that join the two, so the `load_ncaa_mbb_*()` tables can be matched to
the ESPN-based `load_mbb_*()` tables.

- `load_mbb_ncaa_espn_team_crosswalk()`: one row per season and
  stats.ncaa.org team id (2009-10 onward), with the ESPN team and both
  sources' conference for that season. The same table as
  sportsdataverse-py's `ncaa_espn_team_crosswalk(league = "mbb")`.

- `load_mbb_ncaa_espn_schools()`: one row per NCAA school (org id) with
  its ESPN team.

- `load_mbb_ncaa_espn_school_seasons()`: one row per school, sport and
  season with that season's stats.ncaa.org team id. It covers both
  sports (`sport` is `mbb` or `wbb`), since an org id is shared by every
  team of a school.

The ESPN ids (`espn_team_id`, `espn_conference_id`) are returned as
integer, matching the ESPN loaders. `ncaa_team_id` and `ncaa_org_id` are
integer, as published and as in sportsdataverse-py and wehoop; the
`load_ncaa_mbb_*()` loaders keep the NCAA ids as character (e.g. the
`id` of
[`load_ncaa_mbb_team_ids()`](https://hoopR.sportsdataverse.org/reference/load_ncaa_mbb_lineups.md)),
so cast one side before joining them. `season` is the `"YYYY-YY"` string
the release uses. The files are parquet, so these loaders need the arrow
package.

## Usage

``` r
load_mbb_ncaa_espn_team_crosswalk()

load_mbb_ncaa_espn_schools()

load_mbb_ncaa_espn_school_seasons()
```

## Source

The `mbb_crosswalk` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_crosswalk>.

## Value

A `hoopR_data` tibble with one row per season and stats.ncaa.org team
(`load_mbb_ncaa_espn_team_crosswalk()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | character | Season, `"YYYY-YY"` (e.g. `"2024-25"`). |
| ncaa_team_id | integer | stats.ncaa.org team id for that season (a new id every season). |
| ncaa_org_id | integer | stats.ncaa.org school (org) id, stable across seasons. |
| ncaa_team | character | stats.ncaa.org school name (AP style, e.g. `Ark.-Pine Bluff`). |
| ncaa_conference | character | stats.ncaa.org conference that season. |
| conference_id | character | SportsDataverse group id of that season's conference (e.g. `mbb:big-ten`), as in [`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md); `NA` when unmatched. |
| espn_team_id | integer | ESPN team id; `NA` when the school could not be matched. |
| espn_display_name | character | ESPN team display name. |
| espn_location | character | ESPN team location. |
| espn_mascot | character | ESPN team mascot. |
| espn_abbreviation | character | ESPN team abbreviation. |
| espn_conference_name | character | ESPN conference name that season. |
| espn_conference_id | integer | ESPN conference (group) id that season. |
| match_method | character | How the team was matched: `exact`, `dict`, `alias`, `org` (the school's ESPN id from its other seasons) or `unmatched`. |

A `hoopR_data` tibble with one row per NCAA school
(`load_mbb_ncaa_espn_schools()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| ncaa_org_id | integer | stats.ncaa.org school (org) id, stable across seasons. |
| ncaa_team | character | stats.ncaa.org school name. |
| espn_team_id | integer | ESPN team id of the school. |
| espn_display_name | character | ESPN team display name. |

A `hoopR_data` tibble with one row per school, sport and season
(`load_mbb_ncaa_espn_school_seasons()`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| ncaa_org_id | integer | stats.ncaa.org school (org) id, stable across seasons. |
| sport | character | `mbb` (men's) or `wbb` (women's): an org id is shared by every team of a school. |
| season | character | Season, `"YYYY-YY"` (e.g. `"2024-25"`). |
| ncaa_team_id | integer | stats.ncaa.org team id of the school's team in that sport and season. |
| espn_team_id | integer | ESPN team id of the school. |

## See also

The WBB twins in wehoop, `load_wbb_ncaa_espn_team_crosswalk()` and
friends.

Other MBB Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(load_mbb_ncaa_espn_team_crosswalk())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 6,371 × 14
#>    season  ncaa_team_id ncaa_org_id ncaa_team      ncaa_conference conference_id
#>    <chr>          <int>       <int> <chr>          <chr>           <chr>        
#>  1 2009-10        51431       26172 A&M-Corpus Ch… Southland       mbb:southland
#>  2 2009-10        51381         721 Air Force      MWC             mbb:mountain…
#>  3 2009-10        51088           5 Akron          MAC             mbb:mac      
#>  4 2009-10        51091           8 Alabama        SEC             mbb:sec      
#>  5 2009-10        51089           6 Alabama A&M    SWAC            mbb:swac     
#>  6 2009-10        51090           7 Alabama St.    SWAC            mbb:swac     
#>  7 2009-10        51094          17 Alcorn         SWAC            mbb:swac     
#>  8 2009-10        51095          23 American       Patriot         mbb:patriot  
#>  9 2009-10        51096          27 App State      SoCon           mbb:socon    
#> 10 2009-10        51098          29 Arizona        Pac-12          mbb:pac-12   
#> # ℹ 6,361 more rows
#> # ℹ 8 more variables: espn_team_id <int>, espn_display_name <chr>,
#> #   espn_location <chr>, espn_mascot <chr>, espn_abbreviation <chr>,
#> #   espn_conference_name <chr>, espn_conference_id <int>, match_method <chr>
  try(load_mbb_ncaa_espn_schools())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 371 × 4
#>    ncaa_org_id ncaa_team         espn_team_id espn_display_name         
#>          <int> <chr>                    <int> <chr>                     
#>  1           2 Abilene Christian         2000 Abilene Christian Wildcats
#>  2           5 Akron                     2006 Akron Zips                
#>  3           6 Alabama A&M               2010 Alabama A&M Bulldogs      
#>  4           7 Alabama St.               2011 Alabama State Hornets     
#>  5           8 Alabama                    333 Alabama Crimson Tide      
#>  6           9 UAB                          5 UAB Blazers               
#>  7          14 UAlbany                    399 UAlbany Great Danes       
#>  8          17 Alcorn                    2016 Alcorn State Braves       
#>  9          23 American                    44 American University Eagles
#> 10          27 App State                 2026 App State Mountaineers    
#> # ℹ 361 more rows
  try(load_mbb_ncaa_espn_school_seasons())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 12,706 × 5
#>    ncaa_org_id sport season  ncaa_team_id espn_team_id
#>          <int> <chr> <chr>          <int>        <int>
#>  1           2 mbb   2013-14       102423         2000
#>  2           2 mbb   2014-15        83943         2000
#>  3           2 mbb   2015-16        21731         2000
#>  4           2 mbb   2016-17        42376         2000
#>  5           2 mbb   2017-18       110938         2000
#>  6           2 mbb   2018-19       450462         2000
#>  7           2 mbb   2019-20       486751         2000
#>  8           2 mbb   2020-21       505571         2000
#>  9           2 mbb   2021-22       527486         2000
#> 10           2 mbb   2022-23       541987         2000
#> # ℹ 12,696 more rows
# }
```
