# **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**

Returns the per-quarter scoring breakdown for one team in one NBA event.
One row per period (regulation quarters + any overtime periods).

Returns the per-team statistical leaders for one MBB event in long
format: one row per (category x athlete rank). Categories typically
include points, rebounds, assists, and rating.

Returns the game-day roster index for one team in one MBB event. Each
row carries the athlete id and the core-v2 `$ref` URL - use the ref to
dereference athlete-game splits or biographical data.

Returns full team-game statistics for one team in one MBB event in long
format: one row per (category x stat). Covers offensive, defensive, and
general categories with both raw values and display strings.

Returns team records as of the given MBB event: overall, home, away,
conference, and division breakdowns where available. One row per record
type.

Returns a one-row tibble with one team's final score for one MBB event:
numeric `value`, display string, `winner` flag, and source metadata.
Quick-lookup wrapper - use `espn_mbb_game_team_linescores()` for
per-period detail.

Returns the per-quarter scoring breakdown for one team in one NBA event.
One row per period (regulation quarters + any overtime periods).

Returns the per-team statistical leaders for one NBA event in long
format: one row per (category x athlete rank). Categories typically
include points, rebounds, assists, and rating.

Returns the game-day roster index for one team in one NBA event. Each
row carries the athlete id and the core-v2 `$ref` URL - use the ref to
dereference athlete-game splits or biographical data.

Returns full team-game statistics for one team in one NBA event in long
format: one row per (category x stat). Covers offensive, defensive, and
general categories with both raw values and display strings.

Returns team records as of the given NBA event: overall, home, away,
conference, and division breakdowns where available. One row per record
type.

Returns a one-row tibble with one team's final score for one NBA event:
numeric `value`, display string, `winner` flag, and source metadata.
Quick-lookup wrapper - use `espn_nba_game_team_linescores()` for
per-period detail.

## Usage

``` r
espn_mbb_game_team_linescores(event_id, team_id, ...)

espn_mbb_game_team_leaders(event_id, team_id, ...)

espn_mbb_game_team_roster(event_id, team_id, ...)

espn_mbb_game_team_statistics(event_id, team_id, ...)

espn_mbb_game_team_records(event_id, team_id, ...)

espn_mbb_game_team_score(event_id, team_id, ...)

espn_nba_game_team_linescores(event_id, team_id, ...)

espn_nba_game_team_leaders(event_id, team_id, ...)

espn_nba_game_team_roster(event_id, team_id, ...)

espn_nba_game_team_statistics(event_id, team_id, ...)

espn_nba_game_team_records(event_id, team_id, ...)

espn_nba_game_team_score(event_id, team_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- team_id:

  ESPN team identifier (the competitor whose linescore to fetch).

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per period.

A long tibble with one row per (category x rank).

A tibble with one row per active athlete.

A long tibble with one row per (category x stat).

A tibble with one row per record type.

A single-row tibble.

A tibble with one row per period.

A long tibble with one row per (category x rank).

A tibble with one row per active athlete.

A long tibble with one row per (category x stat).

A tibble with one row per record type.

A single-row tibble.

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_game_team_linescores(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Linescores ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 4 × 7
#>   league                  event_id  team_id period value display_value source   
#>   <chr>                   <chr>     <chr>    <int> <dbl> <chr>         <chr>    
#> 1 mens-college-basketball 401256760 52           1    45 45            1        
#> 2 mens-college-basketball 401256760 52           1    45 45            Basic/Ma…
#> 3 mens-college-basketball 401256760 52           2    38 38            1        
#> 4 mens-college-basketball 401256760 52           2    38 38            Basic/Ma…
# }
# \donttest{
  espn_mbb_game_team_leaders(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Leaders ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 46 × 11
#>    league  event_id team_id category_name category_display category_abbrev  rank
#>    <chr>   <chr>    <chr>   <chr>         <chr>            <chr>           <int>
#>  1 mens-c… 4012567… 52      points        Points           Pts                 1
#>  2 mens-c… 4012567… 52      points        Points           Pts                 2
#>  3 mens-c… 4012567… 52      points        Points           Pts                 3
#>  4 mens-c… 4012567… 52      points        Points           Pts                 4
#>  5 mens-c… 4012567… 52      points        Points           Pts                 5
#>  6 mens-c… 4012567… 52      points        Points           Pts                 6
#>  7 mens-c… 4012567… 52      points        Points           Pts                 7
#>  8 mens-c… 4012567… 52      points        Points           Pts                 8
#>  9 mens-c… 4012567… 52      points        Points           Pts                 9
#> 10 mens-c… 4012567… 52      points        Points           Pts                10
#> # ℹ 36 more rows
#> # ℹ 4 more variables: athlete_id <chr>, display_value <chr>, value <dbl>,
#> #   athlete_ref <chr>
# }
# \donttest{
  espn_mbb_game_team_roster(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Roster ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 19 × 5
#>    league                  event_id  team_id athlete_id ref                     
#>    <chr>                   <chr>     <chr>   <chr>      <chr>                   
#>  1 mens-college-basketball 401256760 52      4277850    http://sports.core.api.…
#>  2 mens-college-basketball 401256760 52      4432829    http://sports.core.api.…
#>  3 mens-college-basketball 401256760 52      4433134    http://sports.core.api.…
#>  4 mens-college-basketball 401256760 52      4277854    http://sports.core.api.…
#>  5 mens-college-basketball 401256760 52      4277852    http://sports.core.api.…
#>  6 mens-college-basketball 401256760 52      4279098    http://sports.core.api.…
#>  7 mens-college-basketball 401256760 52      4701240    http://sports.core.api.…
#>  8 mens-college-basketball 401256760 52      4683134    http://sports.core.api.…
#>  9 mens-college-basketball 401256760 52      4701239    http://sports.core.api.…
#> 10 mens-college-basketball 401256760 52      4592191    http://sports.core.api.…
#> 11 mens-college-basketball 401256760 52      4592190    http://sports.core.api.…
#> 12 mens-college-basketball 401256760 52      4277855    http://sports.core.api.…
#> 13 mens-college-basketball 401256760 52      4277856    http://sports.core.api.…
#> 14 mens-college-basketball 401256760 52      4701242    http://sports.core.api.…
#> 15 mens-college-basketball 401256760 52      4701241    http://sports.core.api.…
#> 16 mens-college-basketball 401256760 52      4598818    http://sports.core.api.…
#> 17 mens-college-basketball 401256760 52      4277853    http://sports.core.api.…
#> 18 mens-college-basketball 401256760 52      4065661    http://sports.core.api.…
#> 19 mens-college-basketball 401256760 52      4065659    http://sports.core.api.…
# }
# \donttest{
  espn_mbb_game_team_statistics(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Statistics ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 71 × 10
#>    league  event_id team_id category_name category_display stat_name stat_abbrev
#>    <chr>   <chr>    <chr>   <chr>         <chr>            <chr>     <chr>      
#>  1 mens-c… 4012567… 52      defensive     Defensive        blocks    BLK        
#>  2 mens-c… 4012567… 52      defensive     Defensive        defensiv… DR         
#>  3 mens-c… 4012567… 52      defensive     Defensive        steals    STL        
#>  4 mens-c… 4012567… 52      defensive     Defensive        turnover… PTS OFF TO 
#>  5 mens-c… 4012567… 52      defensive     Defensive        avgDefen… DR         
#>  6 mens-c… 4012567… 52      defensive     Defensive        avgBlocks BLK        
#>  7 mens-c… 4012567… 52      defensive     Defensive        avgSteals STL        
#>  8 mens-c… 4012567… 52      general       General          largestL… LL         
#>  9 mens-c… 4012567… 52      general       General          disquali… DQ         
#> 10 mens-c… 4012567… 52      general       General          flagrant… FLAG       
#> # ℹ 61 more rows
#> # ℹ 3 more variables: stat_display <chr>, value <dbl>, display_value <chr>
# }
# \donttest{
  espn_mbb_game_team_records(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Competitor Records ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 4 × 11
#>   league              event_id team_id record_id name  abbreviation display_name
#>   <chr>               <chr>    <chr>   <chr>     <chr> <chr>        <chr>       
#> 1 mens-college-baske… 4012567… 52      1         over… Game         Record Year…
#> 2 mens-college-baske… 4012567… 52      9002      Home  NA           Home        
#> 3 mens-college-baske… 4012567… 52      9003      Road  NA           Road        
#> 4 mens-college-baske… 4012567… 52      9009      vs. … NA           CONF        
#> # ℹ 4 more variables: short_display_name <chr>, type <chr>, summary <chr>,
#> #   value <dbl>
# }
# \donttest{
  espn_mbb_game_team_score(event_id = 401256760, team_id = 52)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Competitor Score ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 1 × 8
#>   league                  event_id  team_id value display_value winner source_id
#>   <chr>                   <chr>     <chr>   <dbl> <chr>         <lgl>  <chr>    
#> 1 mens-college-basketball 401256760 52         83 83            TRUE   1        
#> # ℹ 1 more variable: source_description <chr>
# }
# \donttest{
  espn_nba_game_team_linescores(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Linescores ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 8 × 7
#>   league event_id  team_id period value display_value source      
#>   <chr>  <chr>     <chr>    <int> <dbl> <chr>         <chr>       
#> 1 nba    401283399 29           1    30 30            1           
#> 2 nba    401283399 29           1    30 30            Basic/Manual
#> 3 nba    401283399 29           2    27 27            1           
#> 4 nba    401283399 29           2    27 27            Basic/Manual
#> 5 nba    401283399 29           3    29 29            1           
#> 6 nba    401283399 29           3    29 29            Basic/Manual
#> 7 nba    401283399 29           4    36 36            1           
#> 8 nba    401283399 29           4    36 36            Basic/Manual
# }
# \donttest{
  espn_nba_game_team_leaders(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Leaders ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 48 × 11
#>    league event_id  team_id category_name category_display category_abbrev  rank
#>    <chr>  <chr>     <chr>   <chr>         <chr>            <chr>           <int>
#>  1 nba    401283399 29      points        Points           Pts                 1
#>  2 nba    401283399 29      points        Points           Pts                 2
#>  3 nba    401283399 29      points        Points           Pts                 3
#>  4 nba    401283399 29      points        Points           Pts                 4
#>  5 nba    401283399 29      points        Points           Pts                 5
#>  6 nba    401283399 29      points        Points           Pts                 6
#>  7 nba    401283399 29      points        Points           Pts                 7
#>  8 nba    401283399 29      points        Points           Pts                 8
#>  9 nba    401283399 29      points        Points           Pts                 9
#> 10 nba    401283399 29      assists       Assists          Ast                 1
#> # ℹ 38 more rows
#> # ℹ 4 more variables: athlete_id <chr>, display_value <chr>, value <dbl>,
#> #   athlete_ref <chr>
# }
# \donttest{
  espn_nba_game_team_roster(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Roster ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:44 UTC
#> # A tibble: 12 × 5
#>    league event_id  team_id athlete_id ref                                      
#>    <chr>  <chr>     <chr>   <chr>      <chr>                                    
#>  1 nba    401283399 29      2993874    http://sports.core.api.espn.com/v2/sport…
#>  2 nba    401283399 29      3155526    http://sports.core.api.espn.com/v2/sport…
#>  3 nba    401283399 29      6477       http://sports.core.api.espn.com/v2/sport…
#>  4 nba    401283399 29      3135045    http://sports.core.api.espn.com/v2/sport…
#>  5 nba    401283399 29      4279888    http://sports.core.api.espn.com/v2/sport…
#>  6 nba    401283399 29      3906665    http://sports.core.api.espn.com/v2/sport…
#>  7 nba    401283399 29      3908903    http://sports.core.api.espn.com/v2/sport…
#>  8 nba    401283399 29      4277964    http://sports.core.api.espn.com/v2/sport…
#>  9 nba    401283399 29      3134932    http://sports.core.api.espn.com/v2/sport…
#> 10 nba    401283399 29      3135046    http://sports.core.api.espn.com/v2/sport…
#> 11 nba    401283399 29      2534781    http://sports.core.api.espn.com/v2/sport…
#> 12 nba    401283399 29      4066436    http://sports.core.api.espn.com/v2/sport…
# }
# \donttest{
  espn_nba_game_team_statistics(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Statistics ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:45 UTC
#> # A tibble: 98 × 10
#>    league event_id  team_id category_name category_display stat_name stat_abbrev
#>    <chr>  <chr>     <chr>   <chr>         <chr>            <chr>     <chr>      
#>  1 nba    401283399 29      defensive     Defensive        blocks    BLK        
#>  2 nba    401283399 29      defensive     Defensive        defensiv… DR         
#>  3 nba    401283399 29      defensive     Defensive        steals    STL        
#>  4 nba    401283399 29      defensive     Defensive        turnover… Points Con…
#>  5 nba    401283399 29      defensive     Defensive        avgDefen… DR         
#>  6 nba    401283399 29      defensive     Defensive        avgBlocks BLK        
#>  7 nba    401283399 29      defensive     Defensive        avgSteals STL        
#>  8 nba    401283399 29      defensive     Defensive        avg48Def… DR         
#>  9 nba    401283399 29      defensive     Defensive        avg48Blo… BLK        
#> 10 nba    401283399 29      defensive     Defensive        avg48Ste… STL        
#> # ℹ 88 more rows
#> # ℹ 3 more variables: stat_display <chr>, value <dbl>, display_value <chr>
# }
# \donttest{
  espn_nba_game_team_records(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Competitor Records ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:45 UTC
#> # A tibble: 5 × 11
#>   league event_id  team_id record_id name      abbreviation display_name       
#>   <chr>  <chr>     <chr>   <chr>     <chr>     <chr>        <chr>              
#> 1 nba    401283399 29      900       overall   Game         Record Year To Date
#> 2 nba    401283399 29      33        Home      NA           Home               
#> 3 nba    401283399 29      34        Road      NA           Road               
#> 4 nba    401283399 29      60        vs. Div.  NA           DIV                
#> 5 nba    401283399 29      61        vs. Conf. NA           CONF               
#> # ℹ 4 more variables: short_display_name <chr>, type <chr>, summary <chr>,
#> #   value <dbl>
# }
# \donttest{
  espn_nba_game_team_score(event_id = 401283399, team_id = 29)
#> ── ESPN NBA Event Competitor Score ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:45 UTC
#> # A tibble: 1 × 8
#>   league event_id  team_id value display_value winner source_id
#>   <chr>  <chr>     <chr>   <dbl> <chr>         <lgl>  <chr>    
#> 1 nba    401283399 29        122 122           TRUE   1        
#> # ℹ 1 more variable: source_description <chr>
# }
```
