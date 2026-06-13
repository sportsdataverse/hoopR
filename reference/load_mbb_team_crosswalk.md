# **Load hoopR MBB team crosswalk**

Loads a pre-built per-season MBB team crosswalk that maps ESPN team
identifiers to Fox Sports (Bifrost), Bart Torvik, and KenPom identifiers
and canonical abbreviations. The files are versioned `.rds` snapshots
stored in the `mbb_crosswalk` release of the sportsdataverse-data
repository.

## Usage

``` r
load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002; default:
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per MBB team per
season. Columns include at minimum `season` and `espn_team_id`.

## See also

Other MBB Crosswalk Functions:
[`load_mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_crosswalk.md),
[`load_mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB team crosswalk (ESPN / Fox / Torvik / KenPom) ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:49:37 UTC
#> # A tibble: 362 × 21
#>    season espn_team_id espn_abbreviation espn_display_name       espn_short_name
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2026         2000 ACU               Abilene Christian Wild… Abilene Chrstn 
#>  2   2026         2005 AF                Air Force Falcons       Air Force      
#>  3   2026         2006 AKR               Akron Zips              Akron          
#>  4   2026         2010 AAMU              Alabama A&M Bulldogs    Alabama A&M    
#>  5   2026          333 ALA               Alabama Crimson Tide    Alabama        
#>  6   2026         2011 ALST              Alabama State Hornets   Alabama St     
#>  7   2026         2016 ALCN              Alcorn State Braves     Alcorn St      
#>  8   2026           44 AMER              American University Ea… American       
#>  9   2026         2026 APP               App State Mountaineers  App State      
#> 10   2026            9 ASU               Arizona State Sun Devi… Arizona St     
#> # ℹ 352 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   espn_conference <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   fox_section <chr>, bart_team <chr>, bart_conf <chr>, kp_team <chr>,
#> #   kp_conf <chr>, yahoo_team_id <chr>, yahoo_team_name <chr>,
#> #   fox_match_confidence <dbl>, bart_match_confidence <dbl>,
#> #   kp_match_confidence <dbl>, match_method <chr>
# }
```
