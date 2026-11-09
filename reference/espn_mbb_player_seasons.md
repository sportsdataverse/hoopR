# **Get ESPN MBB Athlete Career Seasons**

Returns the list of seasons an MBB athlete appeared in. Useful for
bounding follow-up calls to per-season endpoints.

Returns the list of seasons an NBA athlete appeared in. Useful for
bounding follow-up calls to per-season endpoints.

## Usage

``` r
espn_mbb_player_seasons(athlete_id, ...)

espn_nba_player_seasons(athlete_id, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per career season.

Columns as documented in the shared
[espn_mbb_player_seasons_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons_schema.md)
table.

A tibble with one row per career season.

Columns as documented in the shared
[espn_mbb_player_seasons_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons_schema.md)
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
  # LeBron James (1966): 23 career seasons
  espn_mbb_player_seasons(athlete_id = 4593919)
#> ✖ 2026-11-09 17:04:26.686899: Failed to retrieve ESPN mens-college-basketball athlete seasons for athlete_id=4593919
#> ✖ Args: league = "mens-college-basketball", athlete_id = 4593919
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Seasons ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:26 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  # LeBron James (1966): 23 career seasons
  espn_nba_player_seasons(athlete_id = 1966)
#> ── ESPN NBA Athlete Seasons ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:26 UTC
#> # A tibble: 24 × 4
#>    league athlete_id season ref                                                 
#>    <chr>  <chr>       <int> <chr>                                               
#>  1 nba    1966         2027 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  2 nba    1966         2026 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  3 nba    1966         2025 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  4 nba    1966         2024 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  5 nba    1966         2023 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  6 nba    1966         2022 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  7 nba    1966         2021 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  8 nba    1966         2020 http://sports.core.api.espn.com/v2/sports/basketbal…
#>  9 nba    1966         2019 http://sports.core.api.espn.com/v2/sports/basketbal…
#> 10 nba    1966         2018 http://sports.core.api.espn.com/v2/sports/basketbal…
#> # ℹ 14 more rows
# }
```
