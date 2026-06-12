# **Get Fox Sports Basketball Play-by-Play**

**Get Fox Sports Basketball Play-by-Play**

**Get Fox Sports Basketball Play-by-Play**

## Usage

``` r
fox_nba_pbp(game_id)

fox_mbb_pbp(game_id)
```

## Arguments

- game_id:

  Fox Bifrost event id (e.g. `"106422"`).

## Value

A `hoopR_data` tibble, one row per play: `game_id`, `period`,
`left_team`, `right_team`, `play_id`, `clock`, `team`,
`left_score_change`, `right_score_change`, `play_text`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_pbp("106422"))
#> ── Fox Sports NBA pbp ─────────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 02:24:29 UTC
#> # A tibble: 448 × 10
#>    game_id period     left_team right_team play_id clock team  left_score_change
#>    <chr>   <chr>      <chr>     <chr>      <chr>   <chr> <chr> <chr>            
#>  1 106422  1ST QUART… BOS       PHI        1       12:00 BOST… FALSE            
#>  2 106422  1ST QUART… BOS       PHI        2       12:00 PHIL… FALSE            
#>  3 106422  1ST QUART… BOS       PHI        3       12:00 NA    FALSE            
#>  4 106422  1ST QUART… BOS       PHI        4       12:00 NA    FALSE            
#>  5 106422  1ST QUART… BOS       PHI        5       11:40 PHIL… FALSE            
#>  6 106422  1ST QUART… BOS       PHI        6       11:38 BOST… FALSE            
#>  7 106422  1ST QUART… BOS       PHI        7       11:22 BOST… TRUE             
#>  8 106422  1ST QUART… BOS       PHI        8       11:22 NA    FALSE            
#>  9 106422  1ST QUART… BOS       PHI        9       11:10 PHIL… FALSE            
#> 10 106422  1ST QUART… BOS       PHI        10      11:10 PHIL… FALSE            
#> # ℹ 438 more rows
#> # ℹ 2 more variables: right_score_change <chr>, play_text <chr>
# }
# \donttest{
  try(fox_mbb_pbp("262052"))
#> ── Fox Sports CBK pbp ─────────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 02:24:29 UTC
#> # A tibble: 333 × 10
#>    game_id period   left_team right_team play_id clock team    left_score_change
#>    <chr>   <chr>    <chr>     <chr>      <chr>   <chr> <chr>   <chr>            
#>  1 262052  1ST HALF VT        UNC        1       20:00 NA      FALSE            
#>  2 262052  1ST HALF VT        UNC        2       19:50 VIRGIN… TRUE             
#>  3 262052  1ST HALF VT        UNC        3       19:33 NORTH … FALSE            
#>  4 262052  1ST HALF VT        UNC        4       19:15 VIRGIN… FALSE            
#>  5 262052  1ST HALF VT        UNC        5       19:03 NORTH … FALSE            
#>  6 262052  1ST HALF VT        UNC        6       18:39 VIRGIN… FALSE            
#>  7 262052  1ST HALF VT        UNC        7       18:37 VIRGIN… FALSE            
#>  8 262052  1ST HALF VT        UNC        8       18:30 VIRGIN… FALSE            
#>  9 262052  1ST HALF VT        UNC        9       18:30 VIRGIN… FALSE            
#> 10 262052  1ST HALF VT        UNC        10      18:11 NORTH … FALSE            
#> # ℹ 323 more rows
#> # ℹ 2 more variables: right_score_change <chr>, play_text <chr>
# }
```
