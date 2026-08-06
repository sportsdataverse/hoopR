# **Load hoopR NBA player crosswalk**

Loads a pre-built per-season NBA player crosswalk that maps ESPN athlete
identifiers to NBA.com player identifiers. The files are versioned
`.rds` snapshots stored in the `nba_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_nba_player_crosswalk(seasons = most_recent_nba_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons. (Min:
  2002; default:
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per NBA player per
season. Columns include at minimum `season`, `espn_athlete_id`, and
`nba_player_id`.

## See also

Other NBA Crosswalk Functions:
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_nba_player_crosswalk(seasons = most_recent_nba_season())
#> ── NBA player crosswalk (ESPN / NBA Stats / Fox) ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-07-14 11:59:23 UTC
#> # A tibble: 544 × 21
#>    season espn_team_id team_abbreviation player_name             espn_athlete_id
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2026            1 ATL               nickeil alexander walk… 4278039        
#>  2   2026            1 ATL               devin carter            4433188        
#>  3   2026            1 ATL               dyson daniels           4869342        
#>  4   2026            1 ATL               rayj dennis             4431941        
#>  5   2026            1 ATL               zuby ejiofor            5106262        
#>  6   2026            1 ATL               kingston flemings       5149077        
#>  7   2026            1 ATL               keshon gilbert          4585618        
#>  8   2026            1 ATL               mouhamed gueye          4712863        
#>  9   2026            1 ATL               buddy hield             2990984        
#> 10   2026            1 ATL               jalen johnson           4701230        
#> # ℹ 534 more rows
#> # ℹ 16 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, nba_player_id <chr>, nba_player_name <chr>,
#> #   nba_jersey_num <chr>, nba_position <chr>, fox_athlete_id <chr>,
#> #   fox_player <chr>, fox_jersey <chr>, fox_position_group <chr>,
#> #   yahoo_player_id <chr>, yahoo_player_name <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
```
