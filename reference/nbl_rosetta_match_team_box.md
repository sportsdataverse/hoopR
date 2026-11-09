# **NBL Rosetta Match Team Box Score**

One match's team box score by period, one row per team and period (0 =
whole game).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_team_box(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_match_team_box")`) and in
the searchable [return
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
  try(nbl_rosetta_match_team_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_team_box from prod.rosetta.nbl.com.au ────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:14:03 UTC
#> # A tibble: 10 × 36
#>    match_id        match_status stat_line_id rosetta_stat_line_id assists blocks
#>    <chr>           <chr>        <chr>        <chr>                  <int>  <int>
#>  1 b217a699-4bef-… complete     3db61a3d115… 02c748ef-70b6-43c3-…       2      2
#>  2 b217a699-4bef-… complete     b58e3d8d43d… 0805fced-6fb6-4831-…       3      0
#>  3 b217a699-4bef-… complete     3718e495e92… 310918d6-b7d4-4bb0-…       6      1
#>  4 b217a699-4bef-… complete     a6ba64e3851… 4a84f4b4-bb82-4a9a-…       1      0
#>  5 b217a699-4bef-… complete     08567e1d2bf… 719c47df-c663-44c7-…       7      2
#>  6 b217a699-4bef-… complete     30cc3bd15c0… 869c5e78-268f-4c73-…      14      4
#>  7 b217a699-4bef-… complete     5abf7cc10fe… a7ce2bd9-59e1-4788-…       1      0
#>  8 b217a699-4bef-… complete     29f2f7f1aab… abaf4417-79eb-41f3-…       5      1
#>  9 b217a699-4bef-… complete     f5fc779ac41… b514ae2c-431a-458c-…      13      2
#> 10 b217a699-4bef-… complete     cca5bf7851a… fd636482-5e3c-433c-…       2      0
#> # ℹ 30 more variables: defensive_rebounds <int>, field_goals_attempted <int>,
#> #   field_goals_made <int>, field_goals_percentage <dbl>, fouls <int>,
#> #   free_throws_attempted <int>, free_throws_made <int>,
#> #   free_throws_percentage <dbl>, minutes <dbl>, offensive_rebounds <int>,
#> #   period <int>, period_type <chr>, personal_fouls <int>, points <int>,
#> #   rebounds <int>, steals <int>, technical_fouls <int>,
#> #   three_points_attempted <int>, three_points_made <int>, …
# }
```
