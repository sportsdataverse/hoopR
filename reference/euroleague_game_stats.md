# **EuroLeague Game Stats (Competition Engine box score)**

**Get the box score of one game from the Competition Engine: one row
with the `local` and `road` sides flattened to prefixed columns; each
side's `players` list is kept JSON-encoded.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/games/{game_code}/stats`

For one row per player use
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md)
(the live API).

## Usage

``` r
euroleague_game_stats(competition_code, season_code, game_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

## Value

A `hoopR_data` tibble with one row (the game). The `local_players` /
`road_players` cells are JSON text: semantically equal to sdv-py's, not
byte-equal (separators and unicode escaping differ):

|  |  |  |
|----|----|----|
| col_name | types | description |
| local_coach_code | character | Home side: head coach code (Utf8 join key). |
| local_coach_name | character | Home side: head coach name. |
| local_players | character | Home side: per-player box-score rows for the side, JSON-encoded. |
| local_team_time_played | numeric | Home side: team-only (not attributed to a player): seconds played. |
| local_team_valuation | numeric | Home side: team-only (not attributed to a player): performance index rating (PIR). |
| local_team_points | numeric | Home side: team-only (not attributed to a player): points. |
| local_team_field_goals_made2 | numeric | Home side: team-only (not attributed to a player): two-point field goals made. |
| local_team_field_goals_attempted2 | numeric | Home side: team-only (not attributed to a player): two-point field goals attempted. |
| local_team_field_goals_made3 | numeric | Home side: team-only (not attributed to a player): three-point field goals made. |
| local_team_field_goals_attempted3 | numeric | Home side: team-only (not attributed to a player): three-point field goals attempted. |
| local_team_free_throws_made | numeric | Home side: team-only (not attributed to a player): free throws made. |
| local_team_free_throws_attempted | numeric | Home side: team-only (not attributed to a player): free throws attempted. |
| local_team_field_goals_made_total | numeric | Home side: team-only (not attributed to a player): field goals made. |
| local_team_field_goals_attempted_total | numeric | Home side: team-only (not attributed to a player): field goals attempted. |
| local_team_accuracy_made | numeric | Home side: team-only (not attributed to a player): shots made (accuracy numerator). |
| local_team_accuracy_attempted | numeric | Home side: team-only (not attributed to a player): shots attempted (accuracy denominator). |
| local_team_total_rebounds | numeric | Home side: team-only (not attributed to a player): total rebounds. |
| local_team_defensive_rebounds | numeric | Home side: team-only (not attributed to a player): defensive rebounds. |
| local_team_offensive_rebounds | numeric | Home side: team-only (not attributed to a player): offensive rebounds. |
| local_team_assistances | numeric | Home side: team-only (not attributed to a player): assists. |
| local_team_steals | numeric | Home side: team-only (not attributed to a player): steals. |
| local_team_turnovers | numeric | Home side: team-only (not attributed to a player): turnovers. |
| local_team_blocks_favour | numeric | Home side: team-only (not attributed to a player): blocks made. |
| local_team_blocks_against | numeric | Home side: team-only (not attributed to a player): shots blocked by the opponent. |
| local_team_fouls_commited | numeric | Home side: team-only (not attributed to a player): personal fouls committed. |
| local_team_fouls_received | numeric | Home side: team-only (not attributed to a player): fouls drawn. |
| local_team_plus_minus | numeric | Home side: team-only (not attributed to a player): plus/minus. |
| local_total_time_played | numeric | Home side: totals: seconds played. |
| local_total_valuation | numeric | Home side: totals: performance index rating (PIR). |
| local_total_points | numeric | Home side: totals: points. |
| local_total_field_goals_made2 | numeric | Home side: totals: two-point field goals made. |
| local_total_field_goals_attempted2 | numeric | Home side: totals: two-point field goals attempted. |
| local_total_field_goals_made3 | numeric | Home side: totals: three-point field goals made. |
| local_total_field_goals_attempted3 | numeric | Home side: totals: three-point field goals attempted. |
| local_total_free_throws_made | numeric | Home side: totals: free throws made. |
| local_total_free_throws_attempted | numeric | Home side: totals: free throws attempted. |
| local_total_field_goals_made_total | numeric | Home side: totals: field goals made. |
| local_total_field_goals_attempted_total | numeric | Home side: totals: field goals attempted. |
| local_total_accuracy_made | numeric | Home side: totals: shots made (accuracy numerator). |
| local_total_accuracy_attempted | numeric | Home side: totals: shots attempted (accuracy denominator). |
| local_total_total_rebounds | numeric | Home side: totals: total rebounds. |
| local_total_defensive_rebounds | numeric | Home side: totals: defensive rebounds. |
| local_total_offensive_rebounds | numeric | Home side: totals: offensive rebounds. |
| local_total_assistances | numeric | Home side: totals: assists. |
| local_total_steals | numeric | Home side: totals: steals. |
| local_total_turnovers | numeric | Home side: totals: turnovers. |
| local_total_blocks_favour | numeric | Home side: totals: blocks made. |
| local_total_blocks_against | numeric | Home side: totals: shots blocked by the opponent. |
| local_total_fouls_commited | numeric | Home side: totals: personal fouls committed. |
| local_total_fouls_received | numeric | Home side: totals: fouls drawn. |
| local_total_plus_minus | numeric | Home side: totals: plus/minus. |
| road_coach_code | character | Away side: head coach code (Utf8 join key). |
| road_coach_name | character | Away side: head coach name. |
| road_players | character | Away side: per-player box-score rows for the side, JSON-encoded. |
| road_team_time_played | numeric | Away side: team-only (not attributed to a player): seconds played. |
| road_team_valuation | numeric | Away side: team-only (not attributed to a player): performance index rating (PIR). |
| road_team_points | numeric | Away side: team-only (not attributed to a player): points. |
| road_team_field_goals_made2 | numeric | Away side: team-only (not attributed to a player): two-point field goals made. |
| road_team_field_goals_attempted2 | numeric | Away side: team-only (not attributed to a player): two-point field goals attempted. |
| road_team_field_goals_made3 | numeric | Away side: team-only (not attributed to a player): three-point field goals made. |
| road_team_field_goals_attempted3 | numeric | Away side: team-only (not attributed to a player): three-point field goals attempted. |
| road_team_free_throws_made | numeric | Away side: team-only (not attributed to a player): free throws made. |
| road_team_free_throws_attempted | numeric | Away side: team-only (not attributed to a player): free throws attempted. |
| road_team_field_goals_made_total | numeric | Away side: team-only (not attributed to a player): field goals made. |
| road_team_field_goals_attempted_total | numeric | Away side: team-only (not attributed to a player): field goals attempted. |
| road_team_accuracy_made | numeric | Away side: team-only (not attributed to a player): shots made (accuracy numerator). |
| road_team_accuracy_attempted | numeric | Away side: team-only (not attributed to a player): shots attempted (accuracy denominator). |
| road_team_total_rebounds | numeric | Away side: team-only (not attributed to a player): total rebounds. |
| road_team_defensive_rebounds | numeric | Away side: team-only (not attributed to a player): defensive rebounds. |
| road_team_offensive_rebounds | numeric | Away side: team-only (not attributed to a player): offensive rebounds. |
| road_team_assistances | numeric | Away side: team-only (not attributed to a player): assists. |
| road_team_steals | numeric | Away side: team-only (not attributed to a player): steals. |
| road_team_turnovers | numeric | Away side: team-only (not attributed to a player): turnovers. |
| road_team_blocks_favour | numeric | Away side: team-only (not attributed to a player): blocks made. |
| road_team_blocks_against | numeric | Away side: team-only (not attributed to a player): shots blocked by the opponent. |
| road_team_fouls_commited | numeric | Away side: team-only (not attributed to a player): personal fouls committed. |
| road_team_fouls_received | numeric | Away side: team-only (not attributed to a player): fouls drawn. |
| road_team_plus_minus | numeric | Away side: team-only (not attributed to a player): plus/minus. |
| road_total_time_played | numeric | Away side: totals: seconds played. |
| road_total_valuation | numeric | Away side: totals: performance index rating (PIR). |
| road_total_points | numeric | Away side: totals: points. |
| road_total_field_goals_made2 | numeric | Away side: totals: two-point field goals made. |
| road_total_field_goals_attempted2 | numeric | Away side: totals: two-point field goals attempted. |
| road_total_field_goals_made3 | numeric | Away side: totals: three-point field goals made. |
| road_total_field_goals_attempted3 | numeric | Away side: totals: three-point field goals attempted. |
| road_total_free_throws_made | numeric | Away side: totals: free throws made. |
| road_total_free_throws_attempted | numeric | Away side: totals: free throws attempted. |
| road_total_field_goals_made_total | numeric | Away side: totals: field goals made. |
| road_total_field_goals_attempted_total | numeric | Away side: totals: field goals attempted. |
| road_total_accuracy_made | numeric | Away side: totals: shots made (accuracy numerator). |
| road_total_accuracy_attempted | numeric | Away side: totals: shots attempted (accuracy denominator). |
| road_total_total_rebounds | numeric | Away side: totals: total rebounds. |
| road_total_defensive_rebounds | numeric | Away side: totals: defensive rebounds. |
| road_total_offensive_rebounds | numeric | Away side: totals: offensive rebounds. |
| road_total_assistances | numeric | Away side: totals: assists. |
| road_total_steals | numeric | Away side: totals: steals. |
| road_total_turnovers | numeric | Away side: totals: turnovers. |
| road_total_blocks_favour | numeric | Away side: totals: blocks made. |
| road_total_blocks_against | numeric | Away side: totals: shots blocked by the opponent. |
| road_total_fouls_commited | numeric | Away side: totals: personal fouls committed. |
| road_total_fouls_received | numeric | Away side: totals: fouls drawn. |
| road_total_plus_minus | numeric | Away side: totals: plus/minus. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sdv-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

Other Euroleague:
[`euroleague_clubs()`](https://hoopR.sportsdataverse.org/reference/euroleague_clubs.md),
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md),
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_game_stats(competition_code = "E", season_code = "E2025", game_code = 1)
  })
#> ── EuroLeague game stats from api-live.euroleague.net ────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 04:32:37 UTC
#> # A tibble: 1 × 102
#>   local_coach_code local_coach_name local_players         local_team_time_played
#>   <chr>            <chr>            <chr>                                  <dbl>
#> 1 010561           KOKOSKOV, IGOR   "[{\"player\":{\"per…                      0
#> # ℹ 98 more variables: local_team_valuation <dbl>, local_team_points <dbl>,
#> #   local_team_field_goals_made2 <dbl>,
#> #   local_team_field_goals_attempted2 <dbl>,
#> #   local_team_field_goals_made3 <dbl>,
#> #   local_team_field_goals_attempted3 <dbl>, local_team_free_throws_made <dbl>,
#> #   local_team_free_throws_attempted <dbl>,
#> #   local_team_field_goals_made_total <dbl>, …
# }
```
