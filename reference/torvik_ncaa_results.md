# **Bart Torvik NCAA Tournament Results**

**Get historical NCAA tournament performance from
[barttorvik.com](https://barttorvik.com), by team, coach, conference or
seed.**

Returns raw and adjusted NCAA tournament results, including PASE
(performance above seed expectation) and PAKE (performance above KenPom
expectation) plus round-by-round appearance counts. No API key is
required. Data runs from 2000 to present.

## Usage

``` r
torvik_ncaa_results(min_year, max_year, type = "team")
```

## Arguments

- min_year:

  (*integer* required): Minimum tournament year (4-digit, e.g. `2010`).

- max_year:

  (*integer* required): Maximum tournament year (4-digit, e.g. `2024`).

- type:

  (*character* optional): Aggregation level. One of `team` (default),
  `coach`, `conf`, or `seed`.

## Value

A `hoopR_data` tibble with one row per team/coach/conference/seed:

|               |           |                                                |
|---------------|-----------|------------------------------------------------|
| col_name      | types     | description                                    |
| rk            | integer   | Rank within the queried split.                 |
| team          | character | Team / coach / conference / seed (per `type`). |
| pake          | numeric   | Performance above KenPom expectation (wins).   |
| pase          | numeric   | Performance above seed expectation (wins).     |
| wins          | integer   | Total tournament wins.                         |
| loss          | integer   | Total tournament losses.                       |
| w_percent     | numeric   | Tournament win percentage.                     |
| r64           | integer   | Round of 64 appearances.                       |
| r32           | integer   | Round of 32 appearances.                       |
| s16           | integer   | Sweet 16 appearances.                          |
| e8            | integer   | Elite 8 appearances.                           |
| f4            | integer   | Final 4 appearances.                           |
| f2            | integer   | Championship-game appearances.                 |
| champ         | integer   | National championships.                        |
| top2          | integer   | Top-2 (runner-up or champion) finishes.        |
| f4_percent    | numeric   | Final 4 rate.                                  |
| champ_percent | numeric   | Championship rate.                             |
| min_year      | integer   | Minimum year queried (echoes `min_year`).      |
| max_year      | integer   | Maximum year queried (echoes `max_year`).      |
| type          | character | Aggregation level queried (echoes `type`).     |

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_ncaa_results(min_year = 2010, max_year = 2024, type = "conf"))
#> ── Bart Torvik NCAA tournament results from barttorvik.com ────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:09:04 UTC
#> # A tibble: 33 × 20
#>    rk    conf  pake  pase  wins  loss  w_percent r64   r32   s16   e8    f4   
#>    <chr> <chr> <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr> <chr>
#>  1 1     ACC   18.9  15.3  142   80    0.640     84    59    40    23    10   
#>  2 2     P12   7.8   8.0   69    51    0.575     51    36    23    8     2    
#>  3 3     Horz  6.6   7.8   11    14    0.440     14    3     2     2     2    
#>  4 4     SEC   3.7   6.8   106   73    0.592     74    47    29    19    8    
#>  5 5     CUSA  3.6   3.5   10    16    0.385     16    7     1     1     1    
#>  6 6     Ivy   3.4   4.2   8     13    0.381     13    6     2     0     0    
#>  7 7     MVC   3.3   5.8   21    19    0.525     19    12    5     2     2    
#>  8 8     B10   1.2   2.0   132   93    0.587     93    69    35    15    9    
#>  9 9     CAA   1.1   1.4   7     16    0.304     16    4     1     1     1    
#> 10 10    MAC   1.0   1.9   6     14    0.300     14    5     1     0     0    
#> # ℹ 23 more rows
#> # ℹ 8 more variables: f2 <chr>, champ <chr>, top2 <chr>, f4_percent <chr>,
#> #   champ_percent <chr>, min_year <int>, max_year <int>, type <chr>
# }
```
