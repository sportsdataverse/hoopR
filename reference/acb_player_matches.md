# **Get ACB Player Matches**

A player's game log for an edition (default: the current one).

One row per game. `has_won` is true when the player's team won;
`is_selected_local` is true when it played at home. `play_time` is
`'mm:ss'` (`seconds_played` in seconds). Percentages are Float64, the
rest counts. Names follow the player-route vocabulary (`rebounds`,
`shots_rejected`, `fouls_received`).

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/matches`

## Usage

``` r
acb_player_matches(player_id, season = NULL)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_player_matches`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ACB licence number asked for. |
| match_id | integer | ACB match id of the game. |
| round_type | character | Phase code of the game (LR regular season, PO playoff). |
| round_number | integer | Round number within the phase. |
| date | POSIXct | Tip-off instant (UTC). |
| home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| home_team | character | Team name that season (sponsor names change) |
| home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| away_team | character | Team name that season (sponsor names change) |
| away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| edition_id | integer | Season id read from the home team entry (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| is_selected_local | logical | True when the player's team played at home. |
| has_won | logical | True when the player's team won the game. |
| play_time | character | Time on court as 'mm:ss'. |
| seconds_played | integer | Time on court in whole seconds (play_time parsed). |
| points | integer | Points (player game-log row) |
| three_pointers_made | integer | Three-point field goals made |
| three_pointers_attempted | integer | Three-point field goals attempted |
| three_pointers_percentage | double | Three-point percentage, 0-100 with one decimal; 0 when there was no attempt |
| two_pointers_made | integer | Two-point field goals made |
| two_pointers_attempted | integer | Two-point field goals attempted |
| two_pointers_percentage | double | Two-point percentage, 0-100 with one decimal; 0 when there was no attempt |
| free_throws_made | integer | Free throws the player made in that match (a count, not a season total). |
| free_throws_attempted | integer | Free throws the player attempted in that match (a count, not a season total). |
| free_throws_percentage | double | Free-throw percentage, 0-100 with one decimal; 0 when there was no attempt |
| rebounds | integer | Total rebounds in the game. |
| offensive_rebounds | integer | Offensive rebounds the player took in that match (a count; part of the total rebounds). |
| defensive_rebounds | integer | Defensive rebounds the player took in that match (a count; part of the total rebounds). |
| assists | integer | Assists (player game-log row) |
| steals | integer | Steals (player game-log row) |
| turnovers | integer | Turnovers (player game-log row) |
| blocks | integer | Shots blocked (player game-log row) |
| shots_rejected | integer | Shots of the player that were blocked. |
| dunks | integer | Dunks (player game-log row) |
| personal_fouls | integer | Fouls committed |
| fouls_received | integer | Fouls drawn by the player in the game. |
| rating | integer | ACB rating (valoracion) of the game. |
| plus_minus | integer | Point differential while on court (+/-) |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

Other ACB Functions:
[`acb_box_info()`](https://hoopR.sportsdataverse.org/reference/acb_box_info.md),
[`acb_bracket()`](https://hoopR.sportsdataverse.org/reference/acb_bracket.md),
[`acb_bracket_games()`](https://hoopR.sportsdataverse.org/reference/acb_bracket_games.md),
[`acb_calendar()`](https://hoopR.sportsdataverse.org/reference/acb_calendar.md),
[`acb_career_stints()`](https://hoopR.sportsdataverse.org/reference/acb_career_stints.md),
[`acb_career_trophies()`](https://hoopR.sportsdataverse.org/reference/acb_career_trophies.md),
[`acb_club_data()`](https://hoopR.sportsdataverse.org/reference/acb_club_data.md),
[`acb_competition_current()`](https://hoopR.sportsdataverse.org/reference/acb_competition_current.md),
[`acb_competition_editions()`](https://hoopR.sportsdataverse.org/reference/acb_competition_editions.md),
[`acb_competition_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_competition_rounds.md),
[`acb_competition_weeks()`](https://hoopR.sportsdataverse.org/reference/acb_competition_weeks.md),
[`acb_current_roster()`](https://hoopR.sportsdataverse.org/reference/acb_current_roster.md),
[`acb_lead_stats()`](https://hoopR.sportsdataverse.org/reference/acb_lead_stats.md),
[`acb_lead_tracker()`](https://hoopR.sportsdataverse.org/reference/acb_lead_tracker.md),
[`acb_league_zones()`](https://hoopR.sportsdataverse.org/reference/acb_league_zones.md),
[`acb_lineup()`](https://hoopR.sportsdataverse.org/reference/acb_lineup.md),
[`acb_match_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_match_advanced_stats.md),
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md),
[`acb_match_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_match_leaders.md),
[`acb_matchlist()`](https://hoopR.sportsdataverse.org/reference/acb_matchlist.md),
[`acb_next_matches()`](https://hoopR.sportsdataverse.org/reference/acb_next_matches.md),
[`acb_pbp()`](https://hoopR.sportsdataverse.org/reference/acb_pbp.md),
[`acb_period_scores()`](https://hoopR.sportsdataverse.org/reference/acb_period_scores.md),
[`acb_player_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_advanced_stats.md),
[`acb_player_box()`](https://hoopR.sportsdataverse.org/reference/acb_player_box.md),
[`acb_player_data()`](https://hoopR.sportsdataverse.org/reference/acb_player_data.md),
[`acb_player_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_stats.md),
[`acb_player_totals()`](https://hoopR.sportsdataverse.org/reference/acb_player_totals.md),
[`acb_quickfacts()`](https://hoopR.sportsdataverse.org/reference/acb_quickfacts.md),
[`acb_round_matches()`](https://hoopR.sportsdataverse.org/reference/acb_round_matches.md),
[`acb_search()`](https://hoopR.sportsdataverse.org/reference/acb_search.md),
[`acb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_season_leaders.md),
[`acb_serie()`](https://hoopR.sportsdataverse.org/reference/acb_serie.md),
[`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md),
[`acb_standings()`](https://hoopR.sportsdataverse.org/reference/acb_standings.md),
[`acb_standings_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_standings_rounds.md),
[`acb_team_box()`](https://hoopR.sportsdataverse.org/reference/acb_team_box.md),
[`acb_team_comparison()`](https://hoopR.sportsdataverse.org/reference/acb_team_comparison.md),
[`acb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_team_leaders.md),
[`acb_team_matches()`](https://hoopR.sportsdataverse.org/reference/acb_team_matches.md),
[`acb_team_records()`](https://hoopR.sportsdataverse.org/reference/acb_team_records.md),
[`acb_team_stats()`](https://hoopR.sportsdataverse.org/reference/acb_team_stats.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_player_matches(player_id = 20209407, season = 2027))
#> ── ACB Player Matches from api2.acb.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:37:42 UTC
#> # A tibble: 6 × 42
#>   player_id match_id round_type round_number date                home_team_id
#>       <int>    <int> <chr>             <int> <dttm>                     <int>
#> 1  20209407   105383 LR                    1 2026-09-27 17:00:00         4476
#> 2  20209407   105389 LR                    2 2026-10-04 10:30:00         4479
#> 3  20209407   105397 LR                    3 2026-10-11 10:00:00         4476
#> 4  20209407   105407 LR                    4 2026-10-18 10:30:00         4476
#> 5  20209407   105419 LR                    5 2026-10-25 18:00:00         4465
#> 6  20209407   105425 LR                    6 2026-11-01 11:30:00         4476
#> # ℹ 36 more variables: home_club_id <int>, home_team <chr>,
#> #   home_team_abbr <chr>, away_team_id <int>, away_club_id <int>,
#> #   away_team <chr>, away_team_abbr <chr>, edition_id <int>, season <int>,
#> #   is_selected_local <lgl>, has_won <lgl>, play_time <chr>,
#> #   seconds_played <int>, points <int>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   two_pointers_made <int>, two_pointers_attempted <int>, …
# }
```
