# **Get the P. LEAGUE+ Team Crosswalk**

P. LEAGUE+ site `team_id` (1-8) to Preciser team uuid, for every club
ever listed. The site's `team_id` is stable across seasons and renames;
the vendor keys teams by uuid (`team_uuid` / `home_team_uuid` /
`away_team_uuid` of the `pleague_preciser_*()` frames). Persons need no
table: the Preciser `person_id` is the site box row's `person_id`. A
constant table: no request is made.

## Usage

``` r
pleague_team_crosswalk()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_team_crosswalk")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  pleague_team_crosswalk()
#> ── P. LEAGUE+ Team Crosswalk ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:14:25 UTC
#> # A tibble: 8 × 2
#>   team_id team_uuid                           
#>     <int> <chr>                               
#> 1       1 e86394aa-3d88-11ed-8ba8-7f44ba46b0b1
#> 2       2 e865bb20-3d88-11ed-a956-7f44ba46b0b1
#> 3       3 e8674343-3d88-11ed-98b4-7f44ba46b0b1
#> 4       4 e869743f-3d88-11ed-925e-7f44ba46b0b1
#> 5       5 e86cac11-3d88-11ed-8637-7f44ba46b0b1
#> 6       6 e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1
#> 7       7 3c3a601a-358a-11ed-ab92-711c34ed1298
#> 8       8 bf957f5a-9389-11f0-812c-a38482ec4d30
# }
```
