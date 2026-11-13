# **Get Basketligaen Game Summary**

Points per period, team comparison and best scorers (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/game-info/{game_uuid}`

## Usage

``` r
sportality_game_summary(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_game_summary")`) and in the
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
  try(sportality_game_summary(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Game Summary from basketligaen.dk ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:17:14 UTC
#> # A tibble: 1 × 7
#>   team_head2_head  team_period_caption team_period_overtime team_period_shootout
#>   <chr>            <chr>               <lgl>                <lgl>               
#> 1 "[{\"awayTeam\"… G                   FALSE                FALSE               
#> # ℹ 3 more variables: team_period_stats <chr>, best_scorers <chr>,
#> #   statistics_provider <chr>
# }
```
