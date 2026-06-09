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
#> ℹ Data updated: 2026-06-09 19:17:58 UTC
#> # A tibble: 5,002 × 67
#>    player_name        team  conf  games min_pct o_rtg usage  e_fg ts_pct orb_pct
#>    <chr>              <chr> <chr> <int>   <dbl> <dbl> <dbl> <dbl>  <dbl>   <dbl>
#>  1 DeJuan Clayton     Manh… MAAC      2     4.3  88.3  27.8  47.4   49.3     0  
#>  2 Seth Towns         Howa… MEAC     30    73.4 108.   22.1  45.2   52.2     4.2
#>  3 Terrence Lewis     Gram… SWAC     20    26.9 116.   19    63.9   64.0     3.2
#>  4 Austin Williams    Rutg… B10      26    32.1  85.7  16.5  50     48.6     5.3
#>  5 Avery Wilson       Sout… Slnd     29    27.8  87.8  16.7  45.1   47.2     4.1
#>  6 Jalen Jordan       Midd… CUSA     28    37.2 102.   20.4  49.6   54.1     1.9
#>  7 Cam Martin         Bois… MWC      30    42.1 104.   20.8  49.1   54.0     9  
#>  8 Chuck O'Bannon Jr. TCU   B12      31    32.8 126.   16.6  50.8   55.4     7.8
#>  9 Cam Bacote         Geor… BE       17    10.5  89.9  10.1  46.2   46.2     0.8
#> 10 Michael Hueitt Jr. Pitt… ACC       5     3   139.   11.5  80     73.1     0  
#> # ℹ 4,992 more rows
#> # ℹ 57 more variables: drb_pct <dbl>, ast_pct <dbl>, to_pct <dbl>, ftm <int>,
#> #   fta <int>, ft_pct <dbl>, two_pm <int>, two_pa <int>, two_p_pct <dbl>,
#> #   three_pm <int>, three_pa <int>, three_p_pct <dbl>, blk_pct <dbl>,
#> #   stl_pct <dbl>, ftr <dbl>, class <chr>, height <chr>, number <int>,
#> #   porpag <dbl>, adj_oe <dbl>, pfr <dbl>, year <int>, player_id <int>,
#> #   hometown <chr>, rec_rank <dbl>, ast_to <dbl>, rim_made <int>, …
# }
```
