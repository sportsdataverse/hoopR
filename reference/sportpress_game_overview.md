# **Get BNXT League Game Overview**

Team totals of both sides of a finished game.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`

## Usage

``` r
sportpress_game_overview(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: Team totals of both sides of a finished game. An
empty valid answer raises `hoopR_no_data`; the columns are always these,
in this order (sportsdataverse-py `sportpress_game_overview`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the overview was asked for (the body does not echo it). |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| score | integer | Final score of the side. |
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
| points | integer | The team's total: points scored (2 x two-pointers + 3 x three-pointers + free throws). |
| value | integer | The team's total: efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
| plusminus | integer | The team's total: plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md),
[`sportpress_game_film()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_film.md),
[`sportpress_game_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_find.md),
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
[`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md),
[`sportpress_player_career()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_career.md),
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)

## Examples

``` r
# \donttest{
  try(sportpress_game_overview(game_id = 11295))
#> ── BNXT League Game Overview from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:44:46 UTC
#> # A tibble: 2 × 35
#>   game_id team_side competition_team_id team  team_short_name score minute  foul
#>     <int> <chr>                   <int> <chr> <chr>           <int>  <int> <int>
#> 1   11295 home                      541 Wind… ANT               113    250    30
#> 2   11295 away                      565 Hous… KOR               106    250    26
#> # ℹ 27 more variables: defensive_foul <int>, dunk_made <int>, dunk_all <int>,
#> #   dunk_percent <dbl>, two_point_made <int>, two_point_all <int>,
#> #   two_point_percent <dbl>, three_point_made <int>, three_point_all <int>,
#> #   three_point_percent <dbl>, throw_made <int>, throw_all <int>,
#> #   throw_percent <dbl>, free_throw_made <int>, free_throw_all <int>,
#> #   free_throw_percent <dbl>, offensive_rebound <int>, defensive_rebound <int>,
#> #   total_rebound <int>, block <int>, block_against <int>, turnover <int>, …
# }
```
