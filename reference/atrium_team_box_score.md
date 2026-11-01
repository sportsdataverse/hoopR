# **Atrium Team Box Score**

**One game's team lines: the team totals, the team-level counts and the
game aggregates (lead changes, biggest lead).**

Endpoint:
`GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`

The team line is the API's `entity` block (minutes are the sum over
players, `PT200M`); `extra_*` are the team-level counts not credited to
a player (team rebounds and turnovers) and `total_*` the game-level
aggregates.

## Usage

``` r
atrium_team_box_score(website_id, fixture_id, locale = NULL)
```

## Arguments

- website_id:

  (*integer* required): Site config id: which league site's widget this
  is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador,
  22 Panama, 236 Austria, 326 Montenegro). Not a league id: one site
  serves several competitions.

- fixture_id:

  (*character* required): Game UUID (`fixture_id` in
  [`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md)),
  e.g. `"0dc631bd-c34c-11f1-8d16-4d5a21afb79d"`.

- locale:

  (*character* optional): Locale of the labels, e.g. `"en-EN"` or
  `"fr-FR"`. Omitted = the site's own language. Ids and codes never
  change.

## Value

A `hoopR_data` tibble, one row per `(fixture_id, entity_id)`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
| fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
| season_id | character | Season UUID of the game. |
| entity_id | character | Team UUID (from the fixture's isHome flag). |
| side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
| minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (team, this game). |
| seconds_played | integer | Time played in whole seconds, parsed from minutes (team, this game). |
| points | integer | Points scored (team, this game). |
| rebounds | integer | Total rebounds (team, this game). |
| rebounds_offensive | integer | Offensive rebounds (team, this game). |
| rebounds_defensive | integer | Defensive rebounds (team, this game). |
| assists | integer | Assists (team, this game). |
| steals | integer | Steals (team, this game). |
| blocks | integer | Shots blocked (team, this game). |
| blocks_received | integer | Own shots blocked by an opponent (LNB only) (team, this game). |
| turnovers | integer | Turnovers (team, this game). |
| fouls_total | integer | Fouls committed (team, this game). |
| fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (team, this game). |
| plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (team, this game). |
| efficiency | integer | Efficiency rating, from the site's own formula (team, this game). |
| field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (team, this game). |
| field_goals_attempted | integer | Field goals attempted (LNBP only) (team, this game). |
| field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, this game). |
| points_two_made | integer | Two-point field goals made (team, this game). |
| points_two_attempted | integer | Two-point field goals attempted (team, this game). |
| points_two_percentage | double | Two-point percentage, 0-100 (team, this game). |
| points_three_made | integer | Three-point field goals made (team, this game). |
| points_three_attempted | integer | Three-point field goals attempted (team, this game). |
| points_three_percentage | double | Three-point percentage, 0-100 (team, this game). |
| free_throws_made | integer | Free throws made (team, this game). |
| free_throws_attempted | integer | Free throws attempted (team, this game). |
| free_throws_percentage | double | Free-throw percentage, 0-100 (team, this game). |
| points_fast_break | integer | Fast-break points (LNBP only) (team, this game). |
| extra_fouls_total | integer | Fouls committed (team, credited to the team rather than a player). |
| extra_rebounds | integer | Total rebounds (team, credited to the team rather than a player). |
| extra_rebounds_defensive | integer | Defensive rebounds (team, credited to the team rather than a player). |
| extra_rebounds_offensive | integer | Offensive rebounds (team, credited to the team rather than a player). |
| extra_turnovers | integer | Turnovers (team, credited to the team rather than a player). |
| total_biggest_lead | integer | Biggest lead of the game, in points (team, game total). |
| total_biggest_scoring_run | integer | Longest unanswered scoring run of the game, in points (team, game total). |
| total_field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, game total). |
| total_free_throws_percentage | double | Free-throw percentage, 0-100 (team, game total). |
| total_lead_changes | integer | Number of lead changes in the game (team, game total). |
| total_points_fast_break | integer | Fast-break points (LNBP only) (team, game total). |
| total_points_from_bench | integer | Points scored by non-starters (LNBP only) (team, game total). |
| total_points_from_turnover | integer | Points scored off opponent turnovers (LNBP only) (team, game total). |
| total_time_in_lead | character | Time the team led, as an ISO 8601 duration (PT36M11S) (team, game total). |
| total_time_in_lead_seconds | integer | Time the team led, in whole seconds (team, game total). |
| total_turnovers | integer | Turnovers (team, game total). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

## See also

Other Atrium Functions:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md),
[`atrium_standings_summary()`](https://hoopR.sportsdataverse.org/reference/atrium_standings_summary.md),
[`atrium_team()`](https://hoopR.sportsdataverse.org/reference/atrium_team.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md),
[`nbl1_competition`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md)

## Examples

``` r
# \donttest{
  try(atrium_team_box_score(website_id = 12, fixture_id = "5423072b-6715-11f0-bd8b-9ffadebc148f"))
#> ── Atrium team box score from embed-api.eui.connect.sportradar.com ─────────────
#> ℹ Data updated: 2026-11-01 23:38:13 UTC
#> # A tibble: 2 × 49
#>   website_id fixture_id  season_id entity_id side  minutes seconds_played points
#>        <int> <chr>       <chr>     <chr>     <chr> <chr>            <int>  <int>
#> 1         12 5423072b-6… df310a05… f43b1b0f… home  PT200M           12000     87
#> 2         12 5423072b-6… df310a05… 25bcb29d… away  PT200M           12000     76
#> # ℹ 41 more variables: rebounds <int>, rebounds_offensive <int>,
#> #   rebounds_defensive <int>, assists <int>, steals <int>, blocks <int>,
#> #   blocks_received <int>, turnovers <int>, fouls_total <int>,
#> #   fouls_drawn <int>, plus_minus <int>, efficiency <int>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, points_two_made <int>,
#> #   points_two_attempted <int>, points_two_percentage <dbl>, …
# }
```
