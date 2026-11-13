# **NBL Rosetta Match**

One match's header: status, scores, clock, venue, season and teams. Box
score and play-by-play: the `match_*` frames.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble with one row per match. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_match")`) and in the
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
  try(nbl_rosetta_match(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match from prod.rosetta.nbl.com.au ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:53:55 UTC
#> # A tibble: 1 × 52
#>   org   match_id    match_status start_time_datetime match_type attendance clock
#>   <chr> <chr>       <chr>        <chr>               <chr>           <int> <chr>
#> 1 nbl   b217a699-4… complete     2025-12-18T10:30:00 regular         10802 00:0…
#> # ℹ 45 more variables: current_period <int>, clock_running <lgl>,
#> #   home_score <int>, away_score <int>, round <chr>, start_time <chr>,
#> #   status <chr>, external_media_id <chr>, match_slug <chr>, match_title <chr>,
#> #   secondary_external_id <chr>, live_exclusive <lgl>, season_id <chr>,
#> #   rosetta_season_id <chr>, season_year <int>, season_type <chr>,
#> #   season_competition_id <chr>, season_competition_name <chr>,
#> #   season_competition_gender <chr>, season_competition_league_name <chr>, …
# }
```
