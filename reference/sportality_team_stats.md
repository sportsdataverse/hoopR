# **Get Basketligaen Team Stats**

Team totals per period (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/team-stats/{game_uuid}`

## Usage

``` r
sportality_team_stats(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_team_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_team_stats(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Team Stats from basketligaen.dk ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:03 UTC
#> # A tibble: 10 × 19
#>    team_side game_source_id game_id team_id team_name      team_code team_number
#>    <chr>              <int>   <int>   <int> <chr>          <chr>           <int>
#>  1 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  2 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  3 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  4 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  5 home             2868126 2868126  153747 Holbæk-Stenhus Hol                 1
#>  6 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  7 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  8 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#>  9 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#> 10 away             2868126 2868126   22250 Randers Cimbr… RAN                 2
#> # ℹ 12 more variables: instance_id <chr>, source <chr>, game_uuid <chr>,
#> #   period <int>, period_type <chr>, tp <int>, fgm <int>, a <int>, reb <int>,
#> #   stl <int>, blk <int>, pf <int>
# }
```
