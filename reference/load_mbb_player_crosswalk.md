# **Load hoopR MBB player crosswalk**

Loads a pre-built per-season MBB player crosswalk that maps ESPN athlete
identifiers to Fox Sports (Bifrost) player identifiers. The files are
versioned `.rds` snapshots stored in the `mbb_crosswalk` release of the
sportsdataverse-data repository.

## Usage

``` r
load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002; default:
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md))

## Value

Returns a tibble of class `hoopR_data` with one row per MBB player per
season. Columns include at minimum `season` and `espn_athlete_id`.

## See also

Other MBB Crosswalk Functions:
[`load_mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule_crosswalk.md),
[`load_mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
#> ── MBB player crosswalk (ESPN / Fox) ──────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 05:03:58 UTC
#> # A tibble: 5,656 × 17
#>    season espn_team_id team_abbreviation player_name      espn_athlete_id
#>     <int>        <int> <chr>             <chr>            <chr>          
#>  1   2026         2000 ACU               christian alston 5241312        
#>  2   2026         2000 ACU               isaiah carrillo  5314819        
#>  3   2026         2000 ACU               isaac dye        5314820        
#>  4   2026         2000 ACU               mashy hill       5177705        
#>  5   2026         2000 ACU               cade hornecker   5107885        
#>  6   2026         2000 ACU               bradyn hubbard   5241314        
#>  7   2026         2000 ACU               tylan lewis      5314817        
#>  8   2026         2000 ACU               cbo newton       5177575        
#>  9   2026         2000 ACU               yaniel rivera    5177702        
#> 10   2026         2000 ACU               joseph scott     5314818        
#> # ℹ 5,646 more rows
#> # ℹ 12 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, fox_athlete_id <chr>, fox_player <chr>,
#> #   fox_jersey <chr>, fox_position_group <chr>, yahoo_player_id <chr>,
#> #   yahoo_player_name <chr>, match_method <chr>, match_confidence <dbl>,
#> #   match_keys <chr>
# }
```
