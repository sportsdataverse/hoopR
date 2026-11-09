# **Get ESPN MBB Event Official Detail (Single Official)**

Returns a single-row tibble for one referee assigned to one MBB event,
with their name, position (Referee / Crew Chief / Umpire), and crew
order. Pair with
[`espn_mbb_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md)
to enumerate the crew.

Returns a single-row tibble for one referee assigned to one NBA event,
with their name, position (Referee / Crew Chief / Umpire), and crew
order. Pair with
[`espn_nba_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md)
to enumerate the crew.

## Usage

``` r
espn_mbb_game_official_detail(event_id, order, ...)

espn_nba_game_official_detail(event_id, order, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- order:

  Crew order index (1 = first official). Pair with the `order` column
  from event_officials().

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
  espn_mbb_game_official_detail(event_id = 401256760, order = 1)
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Official Detail ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:48 UTC
#> # A tibble: 1 × 10
#>   league        event_id official_id first_name last_name full_name display_name
#>   <chr>         <chr>    <chr>       <chr>      <chr>     <chr>     <chr>       
#> 1 mens-college… 4012567… 70901       Doug       Shows     Doug Sho… Doug Shows  
#> # ℹ 3 more variables: position_id <chr>, position_name <chr>, order <int>
# }
# \donttest{
  espn_nba_game_official_detail(event_id = 401283399, order = 1)
#> ── ESPN NBA Event Official Detail ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:48 UTC
#> # A tibble: 1 × 10
#>   league event_id  official_id first_name last_name full_name  display_name
#>   <chr>  <chr>     <chr>       <chr>      <chr>     <chr>      <chr>       
#> 1 nba    401283399 6856        Eric       Lewis     Eric Lewis Eric Lewis  
#> # ℹ 3 more variables: position_id <chr>, position_name <chr>, order <int>
# }
```
