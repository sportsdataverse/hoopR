# **Get ESPN MBB Event Play Detail (Single Play)**

Returns the rich detail block for a single MBB play: sequence, period,
clock, text, scoring/shooting flags, current home/away score, team
`$ref`, and shot coordinates if applicable. Complements the bulk
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md)
output by exposing the canonical core-v2 play record.

Returns the rich detail block for a single NBA play: sequence, period,
clock, text, scoring/shooting flags, current home/away score, team
`$ref`, and shot coordinates if applicable. Complements the bulk
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md)
output by exposing the canonical core-v2 play record.

## Usage

``` r
espn_mbb_game_play(event_id, play_id, ...)

espn_nba_game_play(event_id, play_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- play_id:

  ESPN play identifier (visible in `pbp()` output as `play_id` or
  extractable from `plays[].$ref`).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

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
  espn_mbb_game_play(event_id = 401256760, play_id = "401256760101805901")
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Play Detail ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:10 UTC
#> # A tibble: 1 × 19
#>   league     event_id play_id sequence_number type_id type_text text  short_text
#>   <chr>      <chr>    <chr>   <chr>           <chr>   <chr>     <chr> <chr>     
#> 1 mens-coll… 4012567… 401256… 101805901       558     JumpShot  M.J.… M. Walker…
#> # ℹ 11 more variables: period <int>, clock <chr>, scoring_play <lgl>,
#> #   score_value <dbl>, away_score <int>, home_score <int>, shooting_play <lgl>,
#> #   coordinate_x <dbl>, coordinate_y <dbl>, team_ref <chr>, wallclock <chr>
# }
# \donttest{
  espn_nba_game_play(event_id = 401283399, play_id = 4012833994)
#> ── ESPN NBA Event Play Detail ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:10 UTC
#> # A tibble: 1 × 19
#>   league event_id  play_id    sequence_number type_id type_text text  short_text
#>   <chr>  <chr>     <chr>      <chr>           <chr>   <chr>     <chr> <chr>     
#> 1 nba    401283399 4012833994 4               615     Jumpball  Isai… NA        
#> # ℹ 11 more variables: period <int>, clock <chr>, scoring_play <lgl>,
#> #   score_value <dbl>, away_score <int>, home_score <int>, shooting_play <lgl>,
#> #   coordinate_x <dbl>, coordinate_y <dbl>, team_ref <chr>, wallclock <chr>
# }
```
