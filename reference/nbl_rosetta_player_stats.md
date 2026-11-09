# **NBL Rosetta Player Stats**

A player's season totals and averages for every season, by period.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/statistics/for/player/{player_id}`

## Usage

``` r
nbl_rosetta_player_stats(player_id, org = "nbl")
```

## Arguments

- player_id:

  (*character* required): Player id: the DataCore person id (player_id
  of nbl_rosetta_players) or Rosetta's own id; either is accepted.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

## Value

A `hoopR_data` tibble with one row per season and period. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_player_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_player_stats(org = "nbl", player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f"))
#> ── NBL Rosetta player_stats from prod.rosetta.nbl.com.au ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:15:55 UTC
#> # A tibble: 3 × 91
#>   org   assists_average blocks_average field_goals_attempted field_goals_made
#>   <chr>           <dbl>          <dbl>                 <int>            <int>
#> 1 nbl              1.57         0.243                    338              134
#> 2 nbl              2.36         0                        174               78
#> 3 nbl              1.23         0.0645                   184               77
#> # ℹ 86 more variables: field_goals_attempted_average <dbl>,
#> #   field_goals_made_average <dbl>, field_goals_percentage <dbl>,
#> #   fouls_average <dbl>, free_throws_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted_average <dbl>, free_throws_made_average <dbl>,
#> #   free_throws_percentage <dbl>, games <int>, games_started <int>,
#> #   offensive_rebounds <int>, fouls <int>, personal_fouls <int>,
#> #   technical_fouls <int>, period <int>, three_points_attempted <int>, …
# }
```
