# **Men's College Basketball Team Names by Source**

Team names from sources the crosswalk does not fetch (NCAA, ESPN
play-by-play, Warren Nolan, 247Sports and Sports-Reference), one row per
ESPN team.
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)
joins it on `espn_team_id` and applies it to every season. Built by
`data-raw/mbb_team_names.R` from `data-raw/dict_hoopR.csv`, re-keyed to
ESPN ids through the crosswalk's KenPom matching. The names are as that
2023 source recorded them, so some predate a rename (Utah Tech's Warren
Nolan and 247Sports names are `Dixie St.`, Purdue Fort Wayne's are
`IPFW`). Teams that joined Division I later carry only the names that
could be checked. A name that is not known is `NA`.

## Usage

``` r
mbb_team_names
```

## Format

A data frame with 368 rows (one per team) and 8 variables:

|  |  |  |
|----|----|----|
| col_name | type | description |
| `espn_team_id` | integer | ESPN team id (unique). |
| `kp_team` | character | Current KenPom team name (the dict's 2023 name for Hartford and St. Francis NY, which left Division I). |
| `ncaa_team` | character | NCAA (stats.ncaa.org) team name. |
| `espn_pbp_name` | character | Team name as ESPN play-by-play prints it. |
| `warren_nolan_team` | character | Warren Nolan team name. |
| `team_247` | character | 247Sports team name. |
| `sref_slug` | character | Sports-Reference school URL slug (`/cbb/schools/<slug>/`). |
| `sref_team` | character | Sports-Reference school name. |

## Examples

``` r
head(mbb_team_names)
#>   espn_team_id           kp_team         ncaa_team     espn_pbp_name
#> 1         2000 Abilene Christian Abilene Christian Abilene Christian
#> 2         2005         Air Force         Air Force         Air Force
#> 3         2006             Akron             Akron             Akron
#> 4          333           Alabama           Alabama           Alabama
#> 5         2010       Alabama A&M       Alabama A&M       Alabama A&M
#> 6         2011       Alabama St.       Alabama St.     Alabama State
#>   warren_nolan_team          team_247         sref_slug         sref_team
#> 1 Abilene Christian Abilene Christian abilene-christian Abilene Christian
#> 2         Air Force         Air Force         air-force         Air Force
#> 3             Akron             Akron             akron             Akron
#> 4           Alabama           Alabama           alabama           Alabama
#> 5       Alabama A&M       Alabama A&M        alabama-am       Alabama A&M
#> 6     Alabama State     Alabama State     alabama-state     Alabama State
```
