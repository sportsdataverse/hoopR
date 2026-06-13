# **Get the NBA cross-source player crosswalk**

Build a wide, one-row-per-player-per-team crosswalk linking ESPN, NBA
Stats, and Fox player identities. Matching is deterministic: normalized
exact name within a team block, then Jaro-Winkler fuzzy with jersey/DOB
tiebreakers. Yahoo columns are NA placeholders.

## Usage

``` r
nba_player_crosswalk(season = most_recent_nba_season(), min_confidence = 0.92)
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)).

- min_confidence:

  Jaro-Winkler similarity floor for fuzzy matches (default 0.92).

## Value

A `hoopR_data` tibble, one row per player per team (ESPN-anchored).

## See also

Other NBA Crosswalk Functions:
[`load_nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_crosswalk.md),
[`load_nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule_crosswalk.md),
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(nba_player_crosswalk())
#> ── NBA player crosswalk (ESPN / NBA Stats / Fox) ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:13:12 UTC
#> # A tibble: 537 × 21
#>    season espn_team_id team_abbreviation player_name             espn_athlete_id
#>     <int>        <int> <chr>             <chr>                   <chr>          
#>  1   2026            1 ATL               nickeil alexander walk… 4278039        
#>  2   2026            1 ATL               tony bradley            4065673        
#>  3   2026            1 ATL               dyson daniels           4869342        
#>  4   2026            1 ATL               rayj dennis             4431941        
#>  5   2026            1 ATL               keshon gilbert          4585618        
#>  6   2026            1 ATL               mouhamed gueye          4712863        
#>  7   2026            1 ATL               buddy hield             2990984        
#>  8   2026            1 ATL               caleb houstan           4433623        
#>  9   2026            1 ATL               jalen johnson           4701230        
#> 10   2026            1 ATL               corey kispert           4280151        
#> # ℹ 527 more rows
#> # ℹ 16 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, nba_player_id <chr>, nba_player_name <chr>,
#> #   nba_jersey_num <chr>, nba_position <chr>, fox_athlete_id <chr>,
#> #   fox_player <chr>, fox_jersey <chr>, fox_position_group <chr>,
#> #   yahoo_player_id <chr>, yahoo_player_name <chr>, match_method <chr>,
#> #   match_confidence <dbl>, match_keys <chr>
# }
```
