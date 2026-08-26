# **Bart Torvik Player Season Stats**

**Get player advanced season statistics from
[barttorvik.com](https://barttorvik.com).**

Pulls every player's advanced season stat line for a year (the
`getadvstats.php` CSV export). No API key is required. barttorvik does
not publish column headers for this file, so the column names below are
mapped from Bart Torvik's standard player advanced-stats layout
(consistent from 2010 onward). Data is available from 2008 to present.

## Usage

``` r
torvik_player_stats(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per player (key columns shown):

|             |           |                                                  |
|-------------|-----------|--------------------------------------------------|
| col_name    | types     | description                                      |
| player_name | character | Player name.                                     |
| team        | character | Team name.                                       |
| conf        | character | Conference abbreviation.                         |
| games       | integer   | Games played.                                    |
| min_pct     | numeric   | Percentage of available minutes played.          |
| o_rtg       | numeric   | Offensive rating (points produced per 100 poss). |
| usage       | numeric   | Usage rate.                                      |
| e_fg        | numeric   | Effective field goal percentage.                 |
| ts_pct      | numeric   | True shooting percentage.                        |
| orb_pct     | numeric   | Offensive rebound percentage.                    |
| drb_pct     | numeric   | Defensive rebound percentage.                    |
| ast_pct     | numeric   | Assist percentage.                               |
| to_pct      | numeric   | Turnover percentage.                             |
| ft_pct      | numeric   | Free-throw percentage.                           |
| two_p_pct   | numeric   | Two-point field goal percentage.                 |
| three_p_pct | numeric   | Three-point field goal percentage.               |
| blk_pct     | numeric   | Block percentage.                                |
| stl_pct     | numeric   | Steal percentage.                                |
| ftr         | numeric   | Free-throw rate.                                 |
| class       | character | Class (Fr/So/Jr/Sr).                             |
| height      | character | Listed height.                                   |
| porpag      | numeric   | Points over replacement per adjusted game.       |
| adj_oe      | numeric   | Adjusted offensive efficiency.                   |
| year        | integer   | Season (4-digit ending-year).                    |
| player_id   | integer   | Bart Torvik player id.                           |
| hometown    | character | Player hometown.                                 |
| bpm         | numeric   | Box plus/minus.                                  |
| obpm        | numeric   | Offensive box plus/minus.                        |
| dbpm        | numeric   | Defensive box plus/minus.                        |
| role        | character | Bart Torvik player role/position label.          |
| pts         | numeric   | Points per game.                                 |

Additional made/attempt splits (`ftm`/`fta`, `two_pm`/`two_pa`,
`three_pm`/`three_pa`), rim/mid/dunk shooting splits, defensive ratings
(`drtg`, `adrtg`, `stops`), and game-box averages (`oreb`, `dreb`,
`ast`, `stl`, `blk`) are also returned.

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_player_stats(year = 2024))
#> ── Bart Torvik player season stats from barttorvik.com ────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:28:23 UTC
#> # A tibble: 20 × 1
#>    v1                                                                           
#>    <chr>                                                                        
#>  1 "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://w…
#>  2 "<HTML><HEAD><META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=…
#>  3 "<TITLE>ERROR: The request could not be satisfied</TITLE>"                   
#>  4 "</HEAD><BODY>"                                                              
#>  5 "<H1>403 ERROR</H1>"                                                         
#>  6 "<H2>The request could not be satisfied.</H2>"                               
#>  7 "<HR noshade size=\"1px\">"                                                  
#>  8 "Request blocked."                                                           
#>  9 "We can't connect to the server for this app or website at this time. There …
#> 10 "<BR clear=\"all\">"                                                         
#> 11 "If you provide content to customers through CloudFront, you can find steps …
#> 12 "<BR clear=\"all\">"                                                         
#> 13 "<HR noshade size=\"1px\">"                                                  
#> 14 "<PRE>"                                                                      
#> 15 "Generated by cloudfront (CloudFront)"                                       
#> 16 "Request ID: DDn95q-XQtPaqt25TXgMb0NwI2u_qg0s_r77xjDqP_QjXzGJlSLfYw=="       
#> 17 "</PRE>"                                                                     
#> 18 "<ADDRESS>"                                                                  
#> 19 "</ADDRESS>"                                                                 
#> 20 "</BODY></HTML>"                                                             
# }
```
