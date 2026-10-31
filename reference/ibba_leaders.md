# **IBBA Leaders**

**The top five players of a season in one stat category, for all teams
or one team.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/LeaderByType`

## Usage

``` r
ibba_leaders(stat_type, season, team_id = 0)
```

## Arguments

- stat_type:

  (*character* required): Stat category code from ibba_stats_types: VAL,
  pts, isr_pts, plusminus, dunk, ASS, TR, `[OR]`, DR, isr_TR, ST,
  `[TO]`, ASSTO, BKF, FF, `[min]`, p2, p3, p1, p32T, p22T, p12T, PTSMIN,
  TRMIN, ASSMIN.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- team_id:

  (*integer*, default `0`): Team-season id to restrict the list to one
  team; 0 (default) for all teams.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| value | double | The leader's value in the requested category (per-game average, percentage or count). |
| games | integer | Games the leader played. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_id | integer | Team-season id of the leader's team. |
| jersey | character | The leader's jersey number as a zero-padded string. |
| player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
| player_name_he | character | Player name in Hebrew, HTML-unescaped. |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)

## Examples

``` r
# \donttest{
  try(ibba_leaders(season = 2026, stat_type = pts))
#> Error in eval(expr, envir) : object 'pts' not found
# }
```
