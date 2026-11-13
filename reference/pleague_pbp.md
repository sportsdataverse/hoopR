# **Get P. LEAGUE+ Play-by-Play**

Play-by-play of one finished game (2022-23 on) in game order, with shot
x / y and the clip references.

Endpoint:
`GET https://pleagueofficial.com/api/playbyplay.php?uuid={uuid} (after the game page, which holds the uuid)`

## Usage

``` r
pleague_pbp(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## Action codes

Each code of `action`, its meaning and \[the number of plays\] in
258,183 plays of 404 finished 2022-23..2025-26 games (82 printed phrases
plus the blank row):

- `ast`: assist \[17,020\]

- `blk`: block \[3,181\]

- `fg2_alley_oop_made`: 2-point alley-oop, made \[205\]

- `fg2_alley_oop_missed`: 2-point alley-oop, missed \[81\]

- `fg2_driving_layup_made`: 2-point driving layup, made \[4,281\]

- `fg2_driving_layup_missed`: 2-point driving layup, missed \[3,961\]

- `fg2_dunk_made`: 2-point dunk, made \[1,316\]

- `fg2_dunk_missed`: 2-point dunk, missed \[162\]

- `fg2_fadeaway_jumper_made`: 2-point fadeaway jumper, made \[583\]

- `fg2_fadeaway_jumper_missed`: 2-point fadeaway jumper, missed
  \[1,121\]

- `fg2_floater_made`: 2-point floater, made \[1,920\]

- `fg2_floater_missed`: 2-point floater, missed \[3,052\]

- `fg2_hook_shot_made`: 2-point hook shot, made \[610\]

- `fg2_hook_shot_missed`: 2-point hook shot, missed \[773\]

- `fg2_jump_shot_made`: 2-point jump shot, made \[1,657\]

- `fg2_jump_shot_missed`: 2-point jump shot, missed \[3,606\]

- `fg2_layup_made`: 2-point layup, made \[4,428\]

- `fg2_layup_missed`: 2-point layup, missed \[3,403\]

- `fg2_pull_up_jumper_made`: 2-point pull-up jumper, made \[1,004\]

- `fg2_pull_up_jumper_missed`: 2-point pull-up jumper, missed \[1,564\]

- `fg2_putback_made`: 2-point putback / tip-in, made \[2,138\]

- `fg2_putback_missed`: 2-point putback / tip-in, missed \[1,539\]

- `fg2_step_back_shot_made`: 2-point step-back shot, made \[243\]

- `fg2_step_back_shot_missed`: 2-point step-back shot, missed \[410\]

- `fg2_turnaround_jumper_made`: 2-point turnaround jumper, made \[672\]

- `fg2_turnaround_jumper_missed`: 2-point turnaround jumper, missed
  \[1,158\]

- `fg3_fadeaway_jumper_made`: 3-point fadeaway jumper, made \[48\]

- `fg3_fadeaway_jumper_missed`: 3-point fadeaway jumper, missed \[92\]

- `fg3_made`: 3-point shot, style not recorded, made \[7,817\]

- `fg3_missed`: 3-point shot, style not recorded, missed \[17,046\]

- `fg3_pull_up_jumper_made`: 3-point pull-up jumper, made \[480\]

- `fg3_pull_up_jumper_missed`: 3-point pull-up jumper, missed \[922\]

- `fg3_step_back_shot_made`: 3-point step-back shot, made \[245\]

- `fg3_step_back_shot_missed`: 3-point step-back shot, missed \[559\]

- `fg3_turnaround_jumper_made`: 3-point turnaround jumper, made \[10\]

- `fg3_turnaround_jumper_missed`: 3-point turnaround jumper, missed
  \[23\]

- `fg_made`: field goal made, shot type and distance not recorded
  \[158\]

- `fg_missed`: field goal missed, shot type and distance not recorded
  \[168\]

- `foul`: foul, kind not recorded (team row) \[18\]

- `foul_bench_technical`: technical foul on the bench \[35\]

- `foul_coach_technical`: technical foul on the coach \[75\]

- `foul_disqualifying`: disqualifying foul \[2\]

- `foul_drawn`: foul drawn (the opponent's foul on this player)
  \[17,035\]

- `foul_offensive`: offensive foul committed \[1,024\]

- `foul_personal`: personal foul committed \[15,745\]

- `foul_technical`: technical foul \[210\]

- `foul_unsportsmanlike`: unsportsmanlike foul \[261\]

- `ft_made`: free throw 1 of 1 awarded, made \[1,326\]

- `ft_made`: free throw 1 of 3 awarded, made \[128\]

- `ft_made`: free throw 1 of 2 awarded, made \[5,187\]

- `ft_made`: free throw 3, made \[149\]

- `ft_made`: free throw 2, made \[5,798\]

- `ft_missed`: free throw 1 of 1 awarded, missed \[669\]

- `ft_missed`: free throw 1 of 3 awarded, missed \[67\]

- `ft_missed`: free throw 1 of 2 awarded, missed \[2,736\]

- `ft_missed`: free throw 3, missed \[46\]

- `ft_missed`: free throw 2, missed \[2,319\]

- `jump_ball_lost`: jump ball lost \[404\]

- `jump_ball_won`: jump ball won \[708\]

- `reb_def`: defensive rebound (a team rebound has no player) \[29,537\]

- `reb_off`: offensive rebound (a team rebound has no player) \[12,379\]

- `review_coach_challenge`: video review: coach's challenge (2025-26
  onward; the printed text ends with a bare comma) \[videoReview,
  coachChallenge,, 82\]

- `review_instant_replay`: video review: instant-replay system, started
  by the officials (2025-26 onward) \[videoReview, instantReplaySystem,,
  67\]

- `review_instant_replay_1`: video review: instant-replay system,
  variant printed with a trailing '1' (meaning unexplained; the row also
  prints the running score and the points tag '+videoReview')
  \[videoReview, instantReplaySystem, 1, 6\]

- `stl`: steal \[7,361\]

- `sub_in`: substitution: enters the game \[25,505\]

- `sub_out`: substitution: leaves the game \[25,532\]

- `timeout`: timeout (a team row) \[2,854\]

- `tov_3sec`: turnover: 3-second violation \[249\]

- `tov_5sec`: turnover: 5-second violation \[40\]

- `tov_8sec`: turnover: 8-second violation \[26\]

- `tov_backcourt`: turnover: backcourt violation \[96\]

- `tov_bad_pass`: turnover: bad pass \[6,325\]

- `tov_ball_handling`: turnover: ball-handling \[3,547\]

- `tov_carrying`: turnover: carrying the ball \[47\]

- `tov_double_dribble`: turnover: double dribble \[53\]

- `tov_offensive`: turnover: offensive (kind not recorded) \[1,007\]

- `tov_offensive_goaltending`: turnover: offensive goaltending \[4\]

- `tov_other`: turnover: other \[51\]

- `tov_out_of_bounds`: turnover: ball out of bounds \[441\]

- `tov_shot_clock`: turnover: shot-clock violation \[489\]

- `tov_travel`: turnover: travelling \[718\]

- `unlabelled`: row has a player but no action text; in the corpus a
  shot with x/y followed by a rebound, i.e. a missed shot (inferred)
  \[(blank), 169\]

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_pbp(gid = 197))
#> ── P. LEAGUE+ Play-by-Play from pleagueofficial.com ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:18:53 UTC
#> # A tibble: 630 × 26
#>      gid   seq period period_no clock seconds_left side  jersey player_zh action
#>    <int> <int> <chr>      <int> <chr>        <int> <chr> <chr>  <chr>     <chr> 
#>  1   197     1 Q1             1 12:00          720 away  35     辛巴      jump_…
#>  2   197     2 Q1             1 12:00          720 home  5      強森      jump_…
#>  3   197     3 Q1             1 11:41          701 away  35     辛巴      fg2_d…
#>  4   197     4 Q1             1 11:41          701 away  31     阿提諾    ast   
#>  5   197     5 Q1             1 11:20          680 home  5      強森      fg3_m…
#>  6   197     6 Q1             1 10:53          653 away  8      朱雲豪    tov_b…
#>  7   197     7 Q1             1 10:53          653 home  5      強森      stl   
#>  8   197     8 Q1             1 10:49          649 home  NA     賴廷恩    fg3_m…
#>  9   197     9 Q1             1 10:42          642 away  35     辛巴      fg2_l…
#> 10   197    10 Q1             1 10:42          642 away  9      田浩      ast   
#> # ℹ 620 more rows
#> # ℹ 16 more variables: action_zh <chr>, action_en <chr>, text_zh <chr>,
#> #   ft_number <int>, ft_awarded <int>, points <int>, score_away <int>,
#> #   score_home <int>, x <dbl>, y <dbl>, nice_play <lgl>, video_uuid <chr>,
#> #   synergy_play_id <chr>, video_stat_category <chr>, tryspot_player_id <int>,
#> #   video_created_at <chr>
# }
```
