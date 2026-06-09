# **Bart Torvik Game Stats**

**Get per-game team statistics from
[barttorvik.com](https://barttorvik.com).**

Pulls one row per team-game for a season (the `getgamestats.php`
export): adjusted and raw offensive/defensive efficiency, the four
factors on both ends, tempo, the result, pre-game win probability, and
the opposing coach. No API key is required. barttorvik does not publish
column headers for this file, so the column names below are mapped from
its observed positional layout. Data is available from 2008 to present.

## Usage

``` r
torvik_game_stats(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per team-game:

|            |           |                                                     |
|------------|-----------|-----------------------------------------------------|
| col_name   | types     | description                                         |
| date       | character | Game date (M/D/YY).                                 |
| type       | numeric   | Game-type flag.                                     |
| team       | character | Team name.                                          |
| conf       | character | Team conference.                                    |
| opp        | character | Opponent name.                                      |
| venue      | character | Venue relative to `team` (`H`/`A`/`N`).             |
| result     | character | Result string (e.g. `L, 78-73`).                    |
| adj_oe     | numeric   | Adjusted offensive efficiency.                      |
| adj_de     | numeric   | Adjusted defensive efficiency.                      |
| oe         | numeric   | Raw offensive efficiency (points/100 poss).         |
| off_efg    | numeric   | Offensive effective field goal percentage.          |
| off_to     | numeric   | Offensive turnover percentage.                      |
| off_or     | numeric   | Offensive rebound percentage.                       |
| off_ftr    | numeric   | Offensive free-throw rate.                          |
| de         | numeric   | Raw defensive efficiency (points allowed/100 poss). |
| def_efg    | numeric   | Defensive effective field goal percentage allowed.  |
| def_to     | numeric   | Defensive turnover percentage forced.               |
| def_or     | numeric   | Defensive (opponent) rebound percentage.            |
| def_ftr    | numeric   | Defensive free-throw rate allowed.                  |
| game_score | numeric   | Bart Torvik single-game quality score.              |
| opp_conf   | character | Opponent conference.                                |
| year       | integer   | Season (4-digit ending-year).                       |
| tempo      | numeric   | Game tempo (possessions).                           |
| muid       | character | Matchup unique id.                                  |
| coach      | character | Team head coach.                                    |
| opp_coach  | character | Opponent head coach.                                |
| win_prob   | numeric   | Pre-game win probability for `team`.                |

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_game_stats(year = 2024))
#> ── Bart Torvik game stats from barttorvik.com ─────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 20:09:04 UTC
#> # A tibble: 11,452 × 31
#>    date   type team  conf  opp   venue result adj_oe adj_de    oe off_efg off_to
#>    <chr> <int> <chr> <chr> <chr> <chr> <chr>   <dbl>  <dbl> <dbl>   <dbl>  <dbl>
#>  1 12/2…     0 Abil… WAC   Arka… A     L, 83…  101.   100.   94.9    41.7   10.4
#>  2 12/2…     0 Arka… SEC   Abil… H     W, 83…  105.   103.  108.     58.7   22.1
#>  3 1/13…     1 Abil… WAC   Cal … A     L, 68…   81.1  103.   79.4    36.6   18  
#>  4 1/13…     1 Cal … WAC   Abil… H     W, 68…   99.9   85.4 102.     44.7   21  
#>  5 11/1…     0 Abil… WAC   Ford… N     W, 59…   93.6   68.7  88.7    42.7   15  
#>  6 11/1…     0 Ford… A10   Abil… N     L, 59…   66     94.7  67.6    30.6   28.6
#>  7 1/11…     1 Abil… WAC   Gran… A     L, 74…  102.    96    91.1    42.4   14.2
#>  8 1/11…     1 Gran… WAC   Abil… H     W, 74…  102.    99.2 105.     52.9   21.3
#>  9 11/2…     0 Abil… WAC   Miss… N     L, 87…  104.   116.   95.3    48.3   16.6
#> 10 11/2…     0 Miss… MVC   Abil… N     W, 87…  115.   105.  120.     64.4   22.1
#> # ℹ 11,442 more rows
#> # ℹ 19 more variables: off_or <dbl>, off_ftr <dbl>, de <dbl>, def_efg <dbl>,
#> #   def_to <dbl>, def_or <dbl>, def_ftr <dbl>, game_score <dbl>,
#> #   opp_conf <chr>, quad <int>, year <int>, tempo <dbl>, muid <chr>,
#> #   coach <chr>, opp_coach <chr>, margin <dbl>, win_prob <dbl>,
#> #   game_stats <chr>, overtimes <int>
# }
```
