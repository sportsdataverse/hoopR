# **Get Basketligaen Game Overview**

Score, state, clock and the Genius ids of one game (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/game-overview/{game_uuid}`

## Usage

``` r
sportality_game_overview(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_game_overview")`) and in the
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
  try(sportality_game_overview(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Overview from basketligaen.dk ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:57:20 UTC
#> # A tibble: 1 × 29
#>   game_uuid  home_team_game_source_id home_team_game_id home_team_team_id
#>   <chr>                         <int>             <int>             <int>
#> 1 c4hh5nig6t                  2868126           2868126            153747
#> # ℹ 25 more variables: home_team_team_name <chr>, home_team_team_code <chr>,
#> #   home_team_team_number <int>, home_team_place <chr>,
#> #   home_team_instance_id <chr>, home_team_source <chr>,
#> #   home_team_game_uuid <chr>, away_team_game_source_id <int>,
#> #   away_team_game_id <int>, away_team_team_id <int>,
#> #   away_team_team_name <chr>, away_team_team_code <chr>,
#> #   away_team_team_number <int>, away_team_place <chr>, …
# }
```
