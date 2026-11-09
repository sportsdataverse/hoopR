# **Get BNXT League Game Team Box Score**

Team totals of both sides from the box score of a finished game.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`

## Usage

``` r
sportpress_game_team_box(competition_id, game_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: Team totals of both sides from the box score of a
finished game. An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sportsdataverse-py
`sportpress_game_team_box`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the box score was asked for (the body does not echo it). |
| competition_id | integer | Competition id the box score was asked for; checked against the game. |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| minute | integer | The team's total: minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
| foul | integer | The team's total: personal fouls committed. |
| defensive_foul | integer | The team's total: fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
| dunk_made | integer | The team's total: dunks made (a subset of the two-point field goals). |
| dunk_all | integer | The team's total: dunks attempted. |
| dunk_percent | double | The team's total: dunk percentage 0-100; 0 when none were attempted. |
| two_point_made | integer | The team's total: two-point field goals made. |
| two_point_all | integer | The team's total: two-point field goals attempted. |
| two_point_percent | double | The team's total: two-point percentage 0-100. |
| three_point_made | integer | The team's total: three-point field goals made. |
| three_point_all | integer | The team's total: three-point field goals attempted. |
| three_point_percent | double | The team's total: three-point percentage 0-100. |
| throw_made | integer | The team's total: all field goals made, two- plus three-pointers (the provider calls them 'throw'). |
| throw_all | integer | The team's total: all field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
| throw_percent | double | The team's total: field-goal percentage 0-100. |
| free_throw_made | integer | The team's total: free throws made. |
| free_throw_all | integer | The team's total: free throws attempted. |
| free_throw_percent | double | The team's total: free-throw percentage 0-100. |
| offensive_rebound | integer | The team's total: offensive rebounds. |
| defensive_rebound | integer | The team's total: defensive rebounds. |
| total_rebound | integer | The team's total: total rebounds (offensive plus defensive). |
| block | integer | The team's total: shots blocked by the player. |
| block_against | integer | The team's total: own shots blocked by an opponent. |
| turnover | integer | The team's total: turnovers committed. |
| steal | integer | The team's total: steals (balls taken from an opponent). |
| assist | integer | The team's total: assists (passes leading directly to a made basket). |
| points | integer | Team points in the box score; can differ from the schedule final score (about 18 of 1,246 sampled team boxes, by 2-21 points). |
| value | integer | The team's total: efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
| plusminus | integer | The team's total: plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_game_team_box(competition_id = 25, game_id = 11295))
#> ── BNXT League Game Team Box Score from Sportpress ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:09:19 UTC
#> # A tibble: 2 × 35
#>   game_id competition_id team_side competition_team_id team      team_short_name
#>     <int>          <int> <chr>                   <int> <chr>     <chr>          
#> 1   11295             25 home                      541 Windrose… ANT            
#> 2   11295             25 away                      565 House of… KOR            
#> # ℹ 29 more variables: minute <int>, foul <int>, defensive_foul <int>,
#> #   dunk_made <int>, dunk_all <int>, dunk_percent <dbl>, two_point_made <int>,
#> #   two_point_all <int>, two_point_percent <dbl>, three_point_made <int>,
#> #   three_point_all <int>, three_point_percent <dbl>, throw_made <int>,
#> #   throw_all <int>, throw_percent <dbl>, free_throw_made <int>,
#> #   free_throw_all <int>, free_throw_percent <dbl>, offensive_rebound <int>,
#> #   defensive_rebound <int>, total_rebound <int>, block <int>, …
# }
```
