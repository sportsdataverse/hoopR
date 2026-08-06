# **Load hoopR NBA team crosswalk**

Loads a pre-built per-season NBA team crosswalk that maps ESPN team
identifiers to NBA.com identifiers and canonical abbreviations. The
files are versioned `.rds` snapshots stored in the `nba_crosswalk`
release of the sportsdataverse-data repository.

## Usage

``` r
load_nba_team_crosswalk(seasons = most_recent_nba_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons. (Min:
  2002; default:
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per NBA team per
season. Columns include at minimum `season`, `espn_team_id`, and
`nba_team_id`.

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_nba_team_crosswalk(seasons = most_recent_nba_season())
#> ── NBA team crosswalk (ESPN / NBA Stats / Fox) ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-07-14 11:58:51 UTC
#> # A tibble: 30 × 21
#>    season espn_team_id espn_abbreviation espn_display_name     espn_short_name
#>     <int>        <int> <chr>             <chr>                 <chr>          
#>  1   2026            1 ATL               Atlanta Hawks         Hawks          
#>  2   2026            2 BOS               Boston Celtics        Celtics        
#>  3   2026           17 BKN               Brooklyn Nets         Nets           
#>  4   2026           30 CHA               Charlotte Hornets     Hornets        
#>  5   2026            4 CHI               Chicago Bulls         Bulls          
#>  6   2026            5 CLE               Cleveland Cavaliers   Cavaliers      
#>  7   2026            6 DAL               Dallas Mavericks      Mavericks      
#>  8   2026            7 DEN               Denver Nuggets        Nuggets        
#>  9   2026            8 DET               Detroit Pistons       Pistons        
#> 10   2026            9 GS                Golden State Warriors Warriors       
#> # ℹ 20 more rows
#> # ℹ 16 more variables: espn_location <chr>, espn_mascot <chr>,
#> #   nba_team_id <chr>, nba_team_abbreviation <chr>, nba_team_name <chr>,
#> #   nba_team_city <chr>, nba_team_slug <chr>, nba_conference <chr>,
#> #   nba_division <chr>, fox_team_id <chr>, fox_team_name <chr>,
#> #   yahoo_team_id <chr>, yahoo_team_abbreviation <chr>, yahoo_team_name <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
```
