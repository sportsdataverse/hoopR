# **Get P. LEAGUE+ Player Season Stats**

Player season averages and totals of one season and stage: shooting,
rebounds, assists and fouls.

Endpoint:
`GET https://pleagueofficial.com/stat-player/{season slug}/{stage_sn}`

## Usage

``` r
pleague_stat_player(season, stage_sn)
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

- stage_sn:

  Required. Stage select value of the player table: 2 = regular season,
  3 = playoffs, 4 = finals.

## Value

A `hoopR_data` tibble: Player season averages and totals of one season
and stage: shooting, rebounds, assists and fouls. An empty valid answer
is a zero-row tibble with these columns, in this order
(sportsdataverse-py `pleague_stat_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
| season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
| stage_sn | integer | Stage select value: 2 = regular season, 3 = playoffs, 4 = finals (echo of the request, checked against the page's selected option). |
| stage | character | Stage slug: pre-season ((Chinese text), exhibition games before the season), regular-season ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese text), the championship series). |
| player_page_id | character | The 8-character page id of /player/{id} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
| name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
| jersey | character | Shirt number as a string (the player's number in the latest game). |
| team_zh | character | Team name in Traditional Chinese as the page prints it (a traded player shows the current team). |
| games | integer | Games played ((Chinese text)). |
| minutes_avg | character | Minutes per game 'mm:ss' ((Chinese text)). |
| minutes_total | character | Total minutes 'mmm:ss' ((Chinese text)). |
| fg2_made_avg | double | Per-game average of 2-point makes ((Chinese text)). |
| fg2_made_total | integer | Season total of 2-point makes ((Chinese text)). |
| fg2_att_avg | double | Per-game average of 2-point attempts ((Chinese text)). |
| fg2_att_total | integer | Season total of 2-point attempts ((Chinese text)). |
| fg3_made_avg | double | Per-game average of 3-point makes ((Chinese text)). |
| fg3_made_total | integer | Season total of 3-point makes ((Chinese text)). |
| fg3_att_avg | double | Per-game average of 3-point attempts ((Chinese text)). |
| fg3_att_total | integer | Season total of 3-point attempts ((Chinese text)). |
| ft_made_avg | double | Per-game average of free-throw makes ((Chinese text)). |
| ft_made_total | integer | Season total of free-throw makes ((Chinese text)). |
| ft_att_avg | double | Per-game average of free-throw attempts ((Chinese text)). |
| ft_att_total | integer | Season total of free-throw attempts ((Chinese text)). |
| points_avg | double | Per-game average of points ((Chinese text)). |
| points_total | integer | Season total of points ((Chinese text)). |
| reb_off_avg | double | Per-game average of offensive rebounds ((Chinese text)). |
| reb_off_total | integer | Season total of offensive rebounds ((Chinese text)). |
| reb_def_avg | double | Per-game average of defensive rebounds ((Chinese text)). |
| reb_def_total | integer | Season total of defensive rebounds ((Chinese text)). |
| reb_avg | double | Per-game average of total rebounds ((Chinese text)). |
| reb_total | integer | Season total of total rebounds ((Chinese text)). |
| ast_avg | double | Per-game average of assists ((Chinese text)). |
| ast_total | integer | Season total of assists ((Chinese text)). |
| stl_avg | double | Per-game average of steals ((Chinese text)). |
| stl_total | integer | Season total of steals ((Chinese text)). |
| blk_avg | double | Per-game average of blocks ((Chinese text)). |
| blk_total | integer | Season total of blocks ((Chinese text)). |
| tov_avg | double | Per-game average of turnovers ((Chinese text)). |
| tov_total | integer | Season total of turnovers ((Chinese text)). |
| pf_avg | double | Per-game average of personal fouls ((Chinese text)). |
| pf_total | integer | Season total of personal fouls ((Chinese text)). |
| fg2_pct | double | 2-point percentage 0-100 ((Chinese text); the cell holds the same value as average and total). |
| fg3_pct | double | 3-point percentage 0-100 ((Chinese text); same value as average and total). |
| ft_pct | double | Free-throw percentage 0-100 ((Chinese text); same value as average and total). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
[`pleague_player()`](https://hoopR.sportsdataverse.org/reference/pleague_player.md),
[`pleague_player_seasons()`](https://hoopR.sportsdataverse.org/reference/pleague_player_seasons.md),
[`pleague_preciser_injury()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_injury.md),
[`pleague_preciser_lead_flow()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_lead_flow.md),
[`pleague_preciser_rotation()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_rotation.md),
[`pleague_preciser_score_log()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_score_log.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_stat_player(season = 2025, stage_sn = 2))
#> Error in pleague_stat_player(season = 2025, stage_sn = 2) : 
#>   pleagueofficial.com/stat-player/2024-25/2: not the page asked for:
#> layout drift: stat-player header [#排名, PLAYER球員, NO背號, TEAM球隊, GP出賽,
#> MIN時間, PTS得分, 2PT二分, 2PM二分命中, 2PA二分出手, 2PT%二分%, 3PT三分,
#> 3PM三分命中, 3PA三分出手, 3PT%三分%, FT罰球, FTM罰球命中, FTA罰球出手,
#> FT%罰球%, REB籃板, OREB攻板, DREB防板, AST助攻, BLK阻攻, STL抄截, TO失誤,
#> PF犯規]
# }
```
