# **Bart Torvik Season Schedule & Results**

**Get the full game-by-game schedule and results for a season from
[barttorvik.com](https://barttorvik.com).**

Pulls Bart Torvik's "super schedule" (the `{year}_super_sked.json`
file): one row per game with the pre-game prediction, both teams'
adjusted efficiencies and tempo, the final result, and post-game
game-quality metrics. No API key is required. Data is available from
2008 to present.

## Usage

``` r
torvik_game_schedule(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_game_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Torvik Functions:
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  # Interactive only: a whole season's schedule, 3-5 s of parsing.
  try(torvik_game_schedule(year = 2024))
#> ── Bart Torvik season schedule from barttorvik.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:02:53 UTC
#> # A tibble: 6,243 × 56
#>    muid    date  conmatch matchup prediction   ttq  conf venue team1  t1oe  t1de
#>    <chr>   <chr> <chr>    <chr>   <chr>      <dbl> <int> <int> <chr> <dbl> <dbl>
#>  1 Arkans… 11/6… SWAC at… 329 Ar… Missouri … 24.4      0     0 Arka… 100.   120.
#>  2 Portla… 11/6… BSky at… 245 Po… Air Force… 38.7      0     0 Port…  97.5  106.
#>  3 The Ci… 11/6… SC at A… 278 Th… N.C. Stat… 32.5      0     0 The …  99.9  112.
#>  4 Centra… 11/6… MAC at … 269 Ce… Oklahoma … 33.0      0     0 Cent…  94.6  105.
#>  5 BrownC… 11/6… Ivy at … 180 Br… Colgate -… 46.6      0     0 Brown 103.   107.
#>  6 North … 11/6… D2 at SC 0 Nort… Furman (1… -1.99    99     0 Nort…  77.0  126.
#>  7 Bradle… 11/6… MVC at … 60 Bra… Bradley -… 71.4      0     0 Brad… 110.   100.
#>  8 Nichol… 11/6… Slnd at… 236 Ni… Tulane -1… 39.4      0     0 Nich… 102.   111.
#>  9 FIUUCF… 11/6… CUSA at… 291 FI… UCF -21.5… 33.6      0     0 FIU    98.9  112.
#> 10 Housto… 11/6… Slnd at… 355 Ho… BYU -41.9… 28.9      0     0 Hous…  95.5  122.
#> # ℹ 6,233 more rows
#> # ℹ 45 more variables: t1py <dbl>, t1wp <int>, t1propt <dbl>, team2 <chr>,
#> #   t2oe <dbl>, t2de <dbl>, t2py <dbl>, t2wp <int>, t2propt <dbl>, tpro <dbl>,
#> #   t1qual <chr>, t2qual <chr>, gp <int>, result <chr>, tempo <dbl>,
#> #   possessions <dbl>, t1pts <int>, t2pts <int>, winner <chr>, loser <chr>,
#> #   t1adjt <dbl>, t2adjt <dbl>, t1adjo <dbl>, t1adjd <dbl>, t2adjo <dbl>,
#> #   t2adjd <dbl>, gamevalue <dbl>, mismatch <dbl>, blowout <dbl>, …
# }
```
