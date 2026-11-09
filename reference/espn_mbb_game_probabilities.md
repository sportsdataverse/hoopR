# **Get ESPN Women's College Basketball Event Win Probabilities**

**Get ESPN Women's College Basketball Event Win Probabilities**

**Get ESPN Women's College Basketball Event Win Probabilities**

**Get ESPN NBA Event Win Probabilities**

**Get ESPN NBA Event Win Probabilities**

## Usage

``` r
espn_mbb_game_probabilities(event_id, limit = 200, ...)

espn_nba_game_probabilities(event_id, limit = 200, ...)
```

## Arguments

- event_id:

  ESPN event/game identifier (character or numeric).

- limit:

  integer. Maximum number of probability rows to return. Defaults to
  `200`. Pagination is handled internally.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per play-level win-probability entry.

Columns as documented in the shared
[espn_mbb_game_probabilities_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities_schema.md)
table.

A tibble with one row per play-level win-probability entry.

Columns as documented in the shared
[espn_mbb_game_probabilities_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities_schema.md)
table.

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
  espn_mbb_game_probabilities(event_id = "401256760", limit = 50)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Probabilities (event_id=401256760) from ES
#> ℹ Data updated: 2026-11-09 17:04:18 UTC
#> # A tibble: 50 × 10
#>    event_id  sequence_number play_id period clock home_win_percentage
#>    <chr>     <chr>           <chr>    <int> <chr>               <dbl>
#>  1 401256760 101805901       NA          NA NA                  0.413
#>  2 401256760 101806301       NA          NA NA                  0.431
#>  3 401256760 101806302       NA          NA NA                  0.458
#>  4 401256760 101808801       NA          NA NA                  0.482
#>  5 401256760 101809001       NA          NA NA                  0.489
#>  6 401256760 101814501       NA          NA NA                  0.467
#>  7 401256760 101814502       NA          NA NA                  0.459
#>  8 401256760 101817001       NA          NA NA                  0.409
#>  9 401256760 101818201       NA          NA NA                  0.387
#> 10 401256760 101818202       NA          NA NA                  0.387
#> # ℹ 40 more rows
#> # ℹ 4 more variables: away_win_percentage <dbl>, tie_percentage <dbl>,
#> #   secs_to_end_of_period <dbl>, secs_to_end_of_game <dbl>
# }
# \donttest{
  espn_nba_game_probabilities(event_id = "401283399", limit = 50)
#> ── ESPN NBA Event Probabilities (event_id=401283399) from ESPN.com ─────────────
#> ℹ Data updated: 2026-11-09 17:04:18 UTC
#> # A tibble: 50 × 10
#>    event_id  sequence_number play_id period clock home_win_percentage
#>    <chr>     <chr>           <chr>    <int> <chr>               <dbl>
#>  1 401283399 4               NA          NA NA                  0.615
#>  2 401283399 7               NA          NA NA                  0.6  
#>  3 401283399 8               NA          NA NA                  0.595
#>  4 401283399 9               NA          NA NA                  0.594
#>  5 401283399 11              NA          NA NA                  0.61 
#>  6 401283399 12              NA          NA NA                  0.615
#>  7 401283399 13              NA          NA NA                  0.599
#>  8 401283399 14              NA          NA NA                  0.593
#>  9 401283399 15              NA          NA NA                  0.54 
#> 10 401283399 16              NA          NA NA                  0.577
#> # ℹ 40 more rows
#> # ℹ 4 more variables: away_win_percentage <dbl>, tie_percentage <dbl>,
#> #   secs_to_end_of_period <dbl>, secs_to_end_of_game <dbl>
# }
```
