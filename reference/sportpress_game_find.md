# **Get BNXT League Game**

One game: teams, scores, phase, venue and the neighbouring game ids.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`

## Usage

``` r
sportpress_game_find(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: One game: teams, scores, phase, venue and the
neighbouring game ids. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_game_find`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
| game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
| status | character | Game status: finished, or ready for an upcoming game. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
| phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
| phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
| round_name | character | Round label as entered in the CMS; often empty. |
| round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
| period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
| arena | character | Name of the arena where the game is played. |
| home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| home_score | integer | Home side. Final points of the side, including overtime. |
| away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| away_score | integer | Away side. Final points of the side, including overtime. |
| last_game_id | integer | Latest finished meeting of the same two teams in the competition, which can be LATER than this game; null when none. |
| next_game_id | integer | Next meeting of the same two teams; null in every sample. |

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
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
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
  try(sportpress_game_find(game_id = 11295))
#> ── BNXT League Game from Sportpress ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:56:49 UTC
#> # A tibble: 1 × 21
#>   game_id game_time           status   competition_id season phase_id phase_name
#>     <int> <dttm>              <chr>             <int>  <int>    <int> <chr>     
#> 1   11295 2026-10-10 20:30:00 finished             25   2027      183 Regular s…
#> # ℹ 14 more variables: round_name <chr>, round_priority <int>,
#> #   period_name <chr>, arena <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>, last_game_id <int>,
#> #   next_game_id <int>
# }
```
