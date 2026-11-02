# **Get P. LEAGUE+ Team Box Score**

Team totals of one finished game: the box score's total row, home then
away.

Endpoint:
`GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`

## Usage

``` r
pleague_box_teams(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble: Team totals of one finished game: the box score's
total row, home then away. An empty valid answer is a zero-row tibble
with these columns, in this order (sportsdataverse-py
`pleague_box_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The {gid} of /game/{gid}. |
| side | character | Which team the row belongs to: home or away. The box lists home first, the play-by-play and the schedule list away first. |
| minutes | character | Team minutes 'mm:ss' ('240:00' = 5 players x 48 min; more with overtime). |
| seconds | integer | Team seconds on court (14400 = 240 minutes): the site's value in 2020-21 and 2021-22, derived from minutes from 2022-23. |
| points | integer | Team points; equals the final score (the runtime checks it). |
| fg2_made | integer | Team 2-point field goals made. |
| fg2_att | integer | Team 2-point field goals attempted. |
| fg2_pct | double | Team 2-point percentage, 0-100. |
| fg3_made | integer | Team 3-point field goals made. |
| fg3_att | integer | Team 3-point field goals attempted. |
| fg3_pct | double | Team 3-point percentage, 0-100. |
| ft_made | integer | Team free throws made. |
| ft_att | integer | Team free throws attempted. |
| ft_pct | double | Team free-throw percentage, 0-100. |
| reb | integer | Team total rebounds, including team rebounds that no player row carries (so it can exceed the sum of the player rows). |
| reb_off | integer | Team offensive rebounds. |
| reb_def | integer | Team defensive rebounds. |
| ast | integer | Team assists in the game (the total row). |
| stl | integer | Team steals in the game. |
| blk | integer | Team blocks made in the game. |
| tov | integer | Team turnovers. |
| pf | integer | Team personal fouls. |
| plus_minus | integer | Sum of the players' plus/minus (2020-21 and 2021-22 only; null from 2022-23). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
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
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(pleague_box_teams(gid = 197))
#> ── P. LEAGUE+ Team Box from pleagueofficial.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:55:59 UTC
#> # A tibble: 2 × 23
#>     gid side  minutes seconds points fg2_made fg2_att fg2_pct fg3_made fg3_att
#>   <int> <chr> <chr>     <int>  <int>    <int>   <int>   <dbl>    <int>   <int>
#> 1   197 home  240:00    14400    102       26      59    44.1       12      28
#> 2   197 away  240:00    14400     94       25      55    45.4       11      26
#> # ℹ 13 more variables: fg3_pct <dbl>, ft_made <int>, ft_att <int>,
#> #   ft_pct <dbl>, reb <int>, reb_off <int>, reb_def <int>, ast <int>,
#> #   stl <int>, blk <int>, tov <int>, pf <int>, plus_minus <int>
# }
```
