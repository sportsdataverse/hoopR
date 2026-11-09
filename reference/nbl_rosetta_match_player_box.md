# **NBL Rosetta Match Player Box Score**

One match's official player box score, one row per player line (period 0
= whole game).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_player_box(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble with one row per player line. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_match_player_box")`) and in
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
  try(nbl_rosetta_match_player_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_player_box from prod.rosetta.nbl.com.au ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:15:50 UTC
#> # A tibble: 24 × 49
#>    match_id        match_status stat_line_id rosetta_stat_line_id assists blocks
#>    <chr>           <chr>        <chr>        <chr>                  <int>  <int>
#>  1 b217a699-4bef-… complete     57f5abff663… b2a062e4-f3b3-4c60-…       1      1
#>  2 b217a699-4bef-… complete     53a507c5776… fa64d272-9870-4190-…       0      0
#>  3 b217a699-4bef-… complete     7c9a19fd0b7… f810edb8-0a31-43e4-…       0      1
#>  4 b217a699-4bef-… complete     123825a424c… f761c24a-e52b-431a-…       3      1
#>  5 b217a699-4bef-… complete     2292fcddf70… f457ee22-71c9-4896-…       0      0
#>  6 b217a699-4bef-… complete     90c8fe3e6d1… f2734872-70a2-420a-…       0      0
#>  7 b217a699-4bef-… complete     84fc18c941e… d154ac3e-cb40-4672-…       4      2
#>  8 b217a699-4bef-… complete     36e6d1629cf… ce20e283-9d82-440e-…       0      0
#>  9 b217a699-4bef-… complete     99256f46270… caf9300d-b16c-4487-…       1      0
#> 10 b217a699-4bef-… complete     7aa7ac5d9cb… c5c40b4d-3708-46eb-…       1      0
#> # ℹ 14 more rows
#> # ℹ 43 more variables: defensive_rebounds <int>, efficiency <int>,
#> #   field_goals_attempted <int>, field_goals_made <int>,
#> #   field_goals_percentage <dbl>, fouls <int>, free_throws_attempted <int>,
#> #   free_throws_made <int>, free_throws_percentage <dbl>, jersey_number <chr>,
#> #   minutes <dbl>, minutes_string <chr>, offensive_rebounds <int>,
#> #   participated <lgl>, period <int>, period_type <chr>, …
# }
```
