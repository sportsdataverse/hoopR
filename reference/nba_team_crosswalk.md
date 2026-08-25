# **Get the NBA cross-source team crosswalk**

Build a wide, one-row-per-team crosswalk linking ESPN, NBA Stats, and
Fox team identities, keyed on `espn_team_id`.
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md)
already supplies the ESPN\<-\>Stats linkage; this reshapes it and
attaches Fox. Yahoo columns are NA placeholders. NOTE: ESPN/Stats team
endpoints are current-season snapshots, so `season` is a stamp;
historical relocations are not back-modeled live.

## Usage

``` r
nba_team_crosswalk(season = most_recent_nba_season())
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md);
  e.g. 2025 for 2024-25).

## Value

A `hoopR_data` tibble, one row per team (ESPN / `nba_*` / Fox / Yahoo
column groups + `match_method` / `match_confidence`).

## See also

Other NBA Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_team_crosswalk())
#> ── NBA team crosswalk (ESPN / NBA Stats / Fox) ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 00:32:27 UTC
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
