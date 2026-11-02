# **Get BNXT League Phases**

The competition of a season with its phases (regular season, playoffs,
supercup).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/phase/season/{season}`

## Usage

``` r
sportpress_phases(season)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

## Value

A `hoopR_data` tibble: The competition of a season with its phases
(regular season, playoffs, supercup). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_phases`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| competition_name | character | Competition name, 'BNXT League 2025-2026'. |
| phase_id | integer | Phase id (key space: sportpress phases); the `{phaseId}` of the standings route. New every season. |
| phase_name | character | Phase name as entered in the CMS; names differ every season. |
| standings_visible | logical | Whether the phase shows standings; false for playoff phases, which answer the standings route empty. |

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
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
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
  try(sportpress_phases(season = 2026))
#> ── BNXT League Phases from Sportpress ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:56:54 UTC
#> # A tibble: 6 × 6
#>   season competition_id competition_name   phase_id phase_name standings_visible
#>    <int>          <int> <chr>                 <int> <chr>      <lgl>            
#> 1   2026             24 BNXT League 2025-…      169 "Regular … TRUE             
#> 2   2026             24 BNXT League 2025-…      173 ""         FALSE            
#> 3   2026             24 BNXT League 2025-…      175 "BNXT Sup… FALSE            
#> 4   2026             24 BNXT League 2025-…      177 "NL Super… FALSE            
#> 5   2026             24 BNXT League 2025-…      179 "Playoffs… FALSE            
#> 6   2026             24 BNXT League 2025-…      181 "Playoffs… FALSE            
# }
```
