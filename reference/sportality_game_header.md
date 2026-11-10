# **Get Basketligaen Game Header**

Game header: Genius match id (extId), arena, state, teams, scores.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/game-info/{game_uuid}`

## Usage

``` r
sportality_game_header(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_game_header")`) and in the
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
  try(sportality_game_header(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Header from basketligaen.dk ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:05:07 UTC
#> # A tibble: 1 × 43
#>   instance_context_site_team_is_…¹ instance_context_sit…² instance_context_sit…³
#>   <lgl>                            <lgl>                  <lgl>                 
#> 1 TRUE                             TRUE                   TRUE                  
#> # ℹ abbreviated names: ¹​instance_context_site_team_is_in_game,
#> #   ²​instance_context_site_team_is_home_team,
#> #   ³​instance_context_site_team_is_away_team
#> # ℹ 40 more variables: game_info_game_uuid <chr>, game_info_ext_id <int>,
#> #   game_info_start_date_time <chr>, game_info_arena_name <chr>,
#> #   game_info_state <chr>, game_info_overtime <lgl>, game_info_shootout <chr>,
#> #   game_info_series_code <chr>, game_info_series_name <chr>, …
# }
```
