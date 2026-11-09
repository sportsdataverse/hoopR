# **Get ESPN MBB Event Play Personnel (On-Court Lineup at Play)**

Returns the players on court at a specific MBB play in long format (one
row per athlete entry across both competitors). Foundation for lineup
analysis. ESPN coverage is sparse - many plays return zero rows; the
wrapper returns a typed empty tibble in that case.

Returns the players on court at a specific NBA play in long format (one
row per athlete entry across both competitors). Foundation for lineup
analysis. ESPN coverage is sparse - many plays return zero rows; the
wrapper returns a typed empty tibble in that case.

## Usage

``` r
espn_mbb_game_play_personnel(event_id, play_id, ...)

espn_nba_game_play_personnel(event_id, play_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- play_id:

  ESPN play identifier.

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per on-court athlete.

A long tibble with one row per on-court athlete.

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
  espn_mbb_game_play_personnel(event_id = 401256760, play_id = 401256760101805901)
#> ✖ 2026-11-09 21:12:17.371046: Failed to retrieve ESPN mens-college-basketball play personnel for event_id=401256760, play_id=401256760101805888
#> ✖ Args: league = "mens-college-basketball", event_id = 401256760, play_id = 401256760101805888
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Play Personnel ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:17 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_game_play_personnel(event_id = 401283399, play_id = 4012833994)
#> ── ESPN NBA Event Play Personnel ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:17 UTC
#> # A tibble: 0 × 7
#> # ℹ 7 variables: league <chr>, event_id <chr>, play_id <chr>, team_id <chr>,
#> #   athlete_id <chr>, athlete_ref <chr>, competitor_ref <chr>
# }
```
