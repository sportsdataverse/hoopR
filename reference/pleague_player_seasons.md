# **Get P. LEAGUE+ Player Seasons**

One player's season totals and per-game averages, league and East Asia
Super League, with a career row.

Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`

## Usage

``` r
pleague_player_seasons(player_page_id)
```

## Arguments

- player_page_id:

  Required. The 8-character page id of /player/{id} (e.g. '1JbPozLB' =
  Lai Ting-En); `player_page_id` in pleague_stat_player, `random_id` in
  pleague_box_players from 2022-23 (unreliable before).

## Value

A `hoopR_data` tibble: One player's season totals and per-game averages,
league and East Asia Super League, with a career row. An empty valid
answer is a zero-row tibble with these columns, in this order
(sportsdataverse-py `pleague_player_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_page_id | character | The 8-character page id of /player/{id} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
| competition | character | Table block: plg (the league's tables) or easl (the East Asia Super League block, present only for players with games there). |
| table | character | totals (the (Chinese text) table: season totals) or averages (the (Chinese text) table: per game). |
| season | integer | Season END year of the slug; null on the career row. |
| season_slug | character | Season slug as printed ('2025-26'), or 'career' for the final totals / averages row. |
| games | integer | Games played ((Chinese text)). |
| minutes | character | Minutes 'mm:ss' (a season total in the totals table, a per-game average in the averages table). |
| points | double | Points (total in the totals table, per game in the averages table; (Chinese text)). |
| reb | double | Rebounds (total / per game; (Chinese text)). |
| ast | double | Assists (total / per game; (Chinese text)). |
| stl | double | Steals (total / per game; (Chinese text)). |
| blk | double | Blocks (total / per game; (Chinese text)). |
| tov | double | Turnovers (total / per game; (Chinese text)). |
| pf | double | Personal fouls (total / per game; (Chinese text)). |
| fg2_made | double | 2-point makes: the first number of the page's '56 - 103' cell (total / per game). |
| fg2_att | double | 2-point attempts: the second number of the cell. |
| fg2_pct | double | 2-point percentage 0-100 ('54.4 percent' -\> 54.4). |
| fg3_made | double | 3-point makes (total / per game). |
| fg3_att | double | 3-point attempts (total / per game). |
| fg3_pct | double | 3-point percentage 0-100. |
| ft_made | double | Free-throw makes (total / per game). |
| ft_att | double | Free-throw attempts (total / per game). |
| ft_pct | double | Free-throw percentage 0-100. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

     pleague_player_seasons(player_page_id = "1JbPozLB")

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
[`pleague_player()`](https://hoopR.sportsdataverse.org/reference/pleague_player.md),
[`pleague_preciser_injury()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_injury.md),
[`pleague_preciser_lead_flow()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_lead_flow.md),
[`pleague_preciser_rotation()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_rotation.md),
[`pleague_preciser_score_log()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_score_log.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
