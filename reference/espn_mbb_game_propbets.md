# **Get ESPN MBB Event Prop Bets (Long Format)**

Returns prop-bet markets for one MBB event + provider in long format:
one row per (athlete x prop type). Each row has american / decimal /
fraction odds plus the current target (e.g. over/under line). Hits the
core-v2 `competitions/{id}/odds/{provider_id}/propBets` endpoint and
auto-paginates.

Returns prop-bet markets for one NBA event + provider in long format:
one row per (athlete x prop type). Each row has american / decimal /
fraction odds plus the current target (e.g. over/under line). Hits the
core-v2 `competitions/{id}/odds/{provider_id}/propBets` endpoint and
auto-paginates.

## Usage

``` r
espn_mbb_game_propbets(event_id, provider_id, ...)

espn_nba_game_propbets(event_id, provider_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- provider_id:

  Sportsbook provider id (e.g. 58 = ESPN BET, 100 = Caesars). Look up
  via
  [`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md).

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (athlete x prop type).

A long tibble with one row per (athlete x prop type).

## Details

**Get ESPN MBB Event Prop Bets (Long Format)**

**Get ESPN NBA Event Prop Bets (Long Format)**

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
  espn_mbb_game_propbets(event_id = 401256760, provider_id = 58)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Prop Bets ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:14 UTC
#> # A tibble: 0 × 13
#> # ℹ 13 variables: league <chr>, event_id <chr>, provider_id <chr>,
#> #   athlete_id <chr>, prop_type_id <chr>, prop_type_name <chr>, american <chr>,
#> #   decimal <dbl>, fraction <chr>, total <dbl>, current_target <dbl>,
#> #   last_updated <chr>, athlete_ref <chr>
# }
# \donttest{
  espn_nba_game_propbets(event_id = 401283399, provider_id = 58)
#> ── ESPN NBA Event Prop Bets ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:15 UTC
#> # A tibble: 0 × 13
#> # ℹ 13 variables: league <chr>, event_id <chr>, provider_id <chr>,
#> #   athlete_id <chr>, prop_type_id <chr>, prop_type_name <chr>, american <chr>,
#> #   decimal <dbl>, fraction <chr>, total <dbl>, current_target <dbl>,
#> #   last_updated <chr>, athlete_ref <chr>
# }
```
