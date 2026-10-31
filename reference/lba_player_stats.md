# **Get LBA Player Stats**

A player's career by championship: per-game averages, single-game highs
and totals.

Endpoint: `GET https://www.legabasket.it/api/players/get-player-stats`
(`id=<player_id>`)

## Usage

``` r
lba_player_stats(player_id)
```

## Arguments

- player_id:

  (required) Player id (player_id in lba_players or a box score),
  e.g. 969. Global: one id for a whole career.

## Value

A `hoopR_data` tibble: A player's career by championship: per-game
averages, single-game highs and totals. The columns are always these, in
this order (sportsdataverse-py `lba_player_stats`); a column the site
adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player id (global: one id for a whole career); the request's player. |
| stat_type | character | Statistic of the row: avg (per game), max (single-game high) or sum (total). |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| championship_year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| championship_position | integer | Display order of the competition within the season (1 = Regular Season; inferred). |
| championship_name | character | Competition name (`Regular Season`, `Play Off`, `Coppa Italia`, ...). |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| quintet | integer | Per-game average of starts (in the starting five) in that season, competition and team. |
| points | double | Per-game average of points in that season, competition and team. |
| played_minutes | double | Per-game average of minutes played in that season, competition and team. |
| played_matches | integer | Games played in that season, competition and team: a count, the same in the avg, max and sum rows. |
| total_matches | integer | Team games while the player was listed (a player with 3 of 21 shows 21; inferred) in that season, competition and team: a count, the same in the avg, max and sum rows. |
| done_fouls | integer | Per-game average of fouls committed in that season, competition and team. |
| suffered_fouls | integer | Per-game average of fouls drawn in that season, competition and team. |
| shots_2p_realized | double | Per-game average of 2-point field goals made in that season, competition and team. |
| shots_2p_total | integer | Per-game average of 2-point field goals attempted in that season, competition and team. |
| slam_dunk | integer | Per-game average of dunks in that season, competition and team. |
| shots_3p_realized | integer | Per-game average of 3-point field goals made in that season, competition and team. |
| shots_3p_total | integer | Per-game average of 3-point field goals attempted in that season, competition and team. |
| free_throws_realized | integer | Per-game average of free throws made in that season, competition and team. |
| free_throws_total | integer | Per-game average of free throws attempted in that season, competition and team. |
| offensive_rebound | integer | Per-game average of offensive rebounds in that season, competition and team. |
| defensive_rebound | integer | Per-game average of defensive rebounds in that season, competition and team. |
| total_rebound | integer | Per-game average of total rebounds in that season, competition and team. |
| ball_stop_given | integer | Per-game average of blocks in that season, competition and team. |
| ball_stop_received | integer | Per-game average of own shots blocked in that season, competition and team. |
| lost_balls | integer | Per-game average of turnovers in that season, competition and team. |
| regain_balls | integer | Per-game average of steals in that season, competition and team. |
| assists | integer | Per-game average of assists in that season, competition and team. |
| rating_lega | integer | Per-game average of LBA efficiency rating (`valutazione`) in that season, competition and team. |
| rating_oer | double | Per-game average of OER (points / (FGA + turnovers + FTA / 2)) in that season, competition and team. |
| avg_points | double | Per-game average of plus-minus, despite the name (see the game-log row, where it equals the box score `plus_minus`) in that season, competition and team. |
| aplus_dp | integer | Per-game average of `aplus_dp`, an unverified metric (not plus-minus or assists: Macura 2026-27 has 9 against plus-minus 8 and 3 assists) in that season, competition and team. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_player_stats(player_id = 969)

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)
