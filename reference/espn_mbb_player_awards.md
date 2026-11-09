# **Get ESPN Women's College Basketball Athlete Awards**

**Get ESPN Women's College Basketball Athlete Awards**

**Get ESPN Women's College Basketball Athlete Awards**

**Get ESPN NBA Athlete Awards**

**Get ESPN NBA Athlete Awards**

## Usage

``` r
espn_mbb_player_awards(athlete_id, ...)

espn_nba_player_awards(athlete_id, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A single tibble. This endpoint is sparse; many athletes have no award
data, in which case an empty tibble with canonical columns is returned.

Columns as documented in the shared
[espn_mbb_player_awards_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards_schema.md)
table.

A single tibble. This endpoint is sparse; many athletes have no award
data, in which case an empty tibble with canonical columns is returned.

Columns as documented in the shared
[espn_mbb_player_awards_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards_schema.md)
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
  espn_mbb_player_awards(athlete_id = "4593919")
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Awards from ESPN.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:03:58 UTC
#> # A tibble: 0 × 6
#> # ℹ 6 variables: season <chr>, award_id <chr>, name <chr>, description <chr>,
#> #   date <chr>, type <chr>
# }
# \donttest{
  espn_nba_player_awards(athlete_id = "1966")
#> ── ESPN NBA Athlete Awards from ESPN.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:03:58 UTC
#> # A tibble: 25 × 7
#>    season award_id name  description date  type  ref_url                        
#>    <chr>  <chr>    <chr> <chr>       <chr> <chr> <chr>                          
#>  1 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  2 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  3 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  4 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  5 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  6 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  7 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  8 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#>  9 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#> 10 NA     NA       NA    NA          NA    NA    http://sports.core.api.espn.co…
#> # ℹ 15 more rows
# }
```
