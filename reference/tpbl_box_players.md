# **Get TPBL Player Box Score**

Whole-game box score lines of every player on either team sheet, keyed
by GoHoops roster id.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_players(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble: Whole-game box score lines of every player on
either team sheet, keyed by GoHoops roster id. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `tpbl_box_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
| gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
| gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). The key of the box score players: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
| player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
| number | character | Jersey number as text (so '0' and '00' stay distinct). |
| position | character | Playing position as a PascalCase enum: PointGuard, ShootingGuard, SmallForward, PowerForward, Center, and the combinations PointGuardAndShootingGuard, ShootingGuardAndSmallForward, SmallForwardAndPowerForward and PowerForwardAndCenter; ” when unset. |
| status | character | Registration status of the player on the squad as of the request, not at game time: 'official', or 'withdrawn' / 'WITHDRAWN' (one state in two spellings: the player left the squad later; most withdrawn players still played). |
| roster_status | character | Roster registration status as an upper-case enum: 'OFFICIAL' in the 2026-27 preseason game; null in the 2024-25 and 2025-26 box scores (an era difference in the feed). |
| is_starting | logical | True when the player was in the starting five. |
| entered | logical | True when the player has a stat line (he entered the game; a few such players have 0 seconds on court); false for a registered player who did not play, whose stats are all null. |
| time_on_court | integer | Seconds on court by the player over the whole game (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
| score | integer | Points scored by the player over the whole game. The stat keys are absent for a player who did not enter the game (11 keys in all); a few players who did not play carry them with time_on_court 0. |
| plus_minus | integer | Plus/minus: the team's point differential while the player was on court (standard definition; not independently checked). |
| field_goals_made | integer | Field goals made by the player over the whole game. |
| field_goals_missed | integer | Field goals missed by the player over the whole game. |
| field_goals_attempted | integer | Field goals attempted by the player over the whole game. |
| field_goals_percentage | double | Field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| two_pointers_made | integer | 2-point field goals made by the player over the whole game. |
| two_pointers_missed | integer | 2-point field goals missed by the player over the whole game. |
| two_pointers_attempted | integer | 2-point field goals attempted by the player over the whole game. |
| two_pointers_percentage | double | 2-point field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| three_pointers_made | integer | 3-point field goals made by the player over the whole game. |
| three_pointers_missed | integer | 3-point field goals missed by the player over the whole game. |
| three_pointers_attempted | integer | 3-point field goals attempted by the player over the whole game. |
| three_pointers_percentage | double | 3-point field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| free_throws_made | integer | Free throws made by the player over the whole game. |
| free_throws_missed | integer | Free throws missed by the player over the whole game. |
| free_throws_attempted | integer | Free throws attempted by the player over the whole game. |
| free_throws_percentage | double | Free throws percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| rebounds | integer | Total rebounds by the player over the whole game (offensive + defensive). |
| defensive_rebounds | integer | Defensive rebounds by the player over the whole game. |
| offensive_rebounds | integer | Offensive rebounds by the player over the whole game. |
| defensive_fouls | integer | Fouls committed on defense by the player over the whole game. |
| offensive_fouls | integer | Fouls committed on offense by the player over the whole game. |
| personal_fouls | integer | Personal fouls by the player over the whole game (excludes technical, unsportsmanlike and disqualifying fouls). |
| fouls | integer | Fouls charged by the player over the whole game: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
| assists | integer | Assists by the player over the whole game. |
| steals | integer | Steals by the player over the whole game. |
| blocks | integer | Blocked shots by the player over the whole game. |
| turnovers | integer | Turnovers committed by the player over the whole game; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
| points_in_paint | integer | Points scored in the paint by the player over the whole game. |
| second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the player over the whole game. |
| fast_break_points | integer | Points scored on the fast break by the player over the whole game. |
| efficiency | integer | Efficiency rating by the player over the whole game: (points + rebounds + assists + steals + blocks) - (missed field goals + missed free throws + turnovers); verified on all 4,237 played player lines of 189 games. |
| efg | double | Effective field-goal percentage by the player over the whole game, 0-100 as a string with one decimal rounded half up: (FGM + 0.5 x 3PM) / FGA; '0.0' without attempts. |
| tsp | double | True shooting percentage by the player over the whole game, 0-100 as a string with one decimal rounded half up: points / (2 x (FGA + 0.44 x FTA)); '0.0' without attempts. |
| pir | integer | Performance Index Rating by the player over the whole game: efficiency - fouls (verified on all 4,237 played player lines of 189 games). |
| field_goals_made_in_the_paint | integer | Field goals made in the paint by the player over the whole game. |
| field_goals_missed_in_the_paint | integer | Field goals missed in the paint by the player over the whole game. |
| field_goals_attempted_in_the_paint | integer | Field goals attempted in the paint by the player over the whole game. |
| field_goals_made_on_fast_break | integer | Field goals made on the fast break by the player over the whole game. |
| field_goals_missed_on_fast_break | integer | Field goals missed on the fast break by the player over the whole game. |
| field_goals_attempted_on_fast_break | integer | Field goals attempted on the fast break by the player over the whole game. |
| field_goals_made_on_second_chance | integer | Field goals made on a second chance (after an offensive rebound) by the player over the whole game. |
| field_goals_missed_on_second_chance | integer | Field goals missed on a second chance (after an offensive rebound) by the player over the whole game. |
| field_goals_attempted_on_second_chance | integer | Field goals attempted on a second chance (after an offensive rebound) by the player over the whole game. |
| technical_fouls | integer | Technical fouls by the player over the whole game. |
| unsportsmanlike_fouls | integer | Unsportsmanlike fouls by the player over the whole game. |
| disqualifying_fouls | integer | Disqualifying fouls by the player over the whole game. |
| bad_pass_turnovers | integer | Turnovers of type 'bad pass' by the player over the whole game. |
| ball_handling_turnovers | integer | Turnovers of type 'ball-handling error' by the player over the whole game. |
| out_of_bounds_turnovers | integer | Turnovers of type 'out of bounds' by the player over the whole game. |
| travel_turnovers | integer | Turnovers of type 'traveling' by the player over the whole game. |
| three_seconds_turnovers | integer | Turnovers of type 'three-second violation' by the player over the whole game. |
| five_seconds_turnovers | integer | Turnovers of type 'five-second violation' by the player over the whole game. |
| back_court_turnovers | integer | Turnovers of type 'back-court violation' by the player over the whole game. |
| offensive_goal_tending_turnovers | integer | Turnovers of type 'offensive goaltending' by the player over the whole game. |
| double_dribble_turnovers | integer | Turnovers of type 'double dribble' by the player over the whole game. |
| carry_turnovers | integer | Turnovers of type 'carrying' by the player over the whole game. |
| offensive_foul_turnovers | integer | Turnovers of type 'offensive foul' by the player over the whole game. |
| other_turnovers | integer | Turnovers of type 'other' by the player over the whole game. |
| points_off_turnovers | integer | Points scored off opponent turnovers by the player over the whole game. |
| two_pointers_jump_shot_made | integer | 2-point field goals made that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| two_pointers_jump_shot_missed | integer | 2-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| two_pointers_jump_shot_attempted | integer | 2-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| three_pointers_jump_shot_made | integer | 3-point field goals made that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| three_pointers_jump_shot_missed | integer | 3-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| three_pointers_jump_shot_attempted | integer | 3-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
| two_pointers_layup_made | integer | 2-point field goals made that were a layup by the player over the whole game. |
| two_pointers_layup_missed | integer | 2-point field goals missed that were a layup by the player over the whole game. |
| two_pointers_layup_attempted | integer | 2-point field goals attempted that were a layup by the player over the whole game. |
| two_pointers_driving_layup_made | integer | 2-point field goals made that were a driving layup by the player over the whole game. |
| two_pointers_driving_layup_missed | integer | 2-point field goals missed that were a driving layup by the player over the whole game. |
| two_pointers_driving_layup_attempted | integer | 2-point field goals attempted that were a driving layup by the player over the whole game. |
| two_pointers_dunk_made | integer | 2-point field goals made that were a dunk by the player over the whole game. |
| two_pointers_dunk_missed | integer | 2-point field goals missed that were a dunk by the player over the whole game. |
| two_pointers_dunk_attempted | integer | 2-point field goals attempted that were a dunk by the player over the whole game. |
| two_pointers_putback_dunk_made | integer | 2-point field goals made that were a putback dunk (off an offensive rebound) by the player over the whole game. |
| two_pointers_putback_dunk_missed | integer | 2-point field goals missed that were a putback dunk (off an offensive rebound) by the player over the whole game. |
| two_pointers_putback_dunk_attempted | integer | 2-point field goals attempted that were a putback dunk (off an offensive rebound) by the player over the whole game. |
| two_pointers_putback_tip_in_made | integer | 2-point field goals made that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
| two_pointers_putback_tip_in_missed | integer | 2-point field goals missed that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
| two_pointers_putback_tip_in_attempted | integer | 2-point field goals attempted that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
| two_pointers_alley_oop_made | integer | 2-point field goals made that were a alley-oop by the player over the whole game. |
| two_pointers_alley_oop_missed | integer | 2-point field goals missed that were a alley-oop by the player over the whole game. |
| two_pointers_alley_oop_attempted | integer | 2-point field goals attempted that were a alley-oop by the player over the whole game. |
| two_pointers_hook_shot_made | integer | 2-point field goals made that were a hook shot by the player over the whole game. |
| two_pointers_hook_shot_missed | integer | 2-point field goals missed that were a hook shot by the player over the whole game. |
| two_pointers_hook_shot_attempted | integer | 2-point field goals attempted that were a hook shot by the player over the whole game. |
| three_pointers_hook_shot_made | integer | 3-point field goals made that were a hook shot by the player over the whole game. |
| three_pointers_hook_shot_missed | integer | 3-point field goals missed that were a hook shot by the player over the whole game. |
| three_pointers_hook_shot_attempted | integer | 3-point field goals attempted that were a hook shot by the player over the whole game. |
| two_pointers_floating_jump_shot_made | integer | 2-point field goals made that were a floating jump shot (floater) by the player over the whole game. |
| two_pointers_floating_jump_shot_missed | integer | 2-point field goals missed that were a floating jump shot (floater) by the player over the whole game. |
| two_pointers_floating_jump_shot_attempted | integer | 2-point field goals attempted that were a floating jump shot (floater) by the player over the whole game. |
| three_pointers_floating_jump_shot_made | integer | 3-point field goals made that were a floating jump shot (floater) by the player over the whole game. |
| three_pointers_floating_jump_shot_missed | integer | 3-point field goals missed that were a floating jump shot (floater) by the player over the whole game. |
| three_pointers_floating_jump_shot_attempted | integer | 3-point field goals attempted that were a floating jump shot (floater) by the player over the whole game. |
| two_pointers_fadeaway_jump_shot_made | integer | 2-point field goals made that were a fadeaway jump shot by the player over the whole game. |
| two_pointers_fadeaway_jump_shot_missed | integer | 2-point field goals missed that were a fadeaway jump shot by the player over the whole game. |
| two_pointers_fadeaway_jump_shot_attempted | integer | 2-point field goals attempted that were a fadeaway jump shot by the player over the whole game. |
| three_pointers_fadeaway_jump_shot_made | integer | 3-point field goals made that were a fadeaway jump shot by the player over the whole game. |
| three_pointers_fadeaway_jump_shot_missed | integer | 3-point field goals missed that were a fadeaway jump shot by the player over the whole game. |
| three_pointers_fadeaway_jump_shot_attempted | integer | 3-point field goals attempted that were a fadeaway jump shot by the player over the whole game. |
| two_pointers_turnaround_jump_shot_made | integer | 2-point field goals made that were a turnaround jump shot by the player over the whole game. |
| two_pointers_turnaround_jump_shot_missed | integer | 2-point field goals missed that were a turnaround jump shot by the player over the whole game. |
| two_pointers_turnaround_jump_shot_attempted | integer | 2-point field goals attempted that were a turnaround jump shot by the player over the whole game. |
| three_pointers_turnaround_jump_shot_made | integer | 3-point field goals made that were a turnaround jump shot by the player over the whole game. |
| three_pointers_turnaround_jump_shot_missed | integer | 3-point field goals missed that were a turnaround jump shot by the player over the whole game. |
| three_pointers_turnaround_jump_shot_attempted | integer | 3-point field goals attempted that were a turnaround jump shot by the player over the whole game. |
| two_pointers_step_back_jump_shot_made | integer | 2-point field goals made that were a step-back jump shot by the player over the whole game. |
| two_pointers_step_back_jump_shot_missed | integer | 2-point field goals missed that were a step-back jump shot by the player over the whole game. |
| two_pointers_step_back_jump_shot_attempted | integer | 2-point field goals attempted that were a step-back jump shot by the player over the whole game. |
| three_pointers_step_back_jump_shot_made | integer | 3-point field goals made that were a step-back jump shot by the player over the whole game. |
| three_pointers_step_back_jump_shot_missed | integer | 3-point field goals missed that were a step-back jump shot by the player over the whole game. |
| three_pointers_step_back_jump_shot_attempted | integer | 3-point field goals attempted that were a step-back jump shot by the player over the whole game. |
| two_pointers_pull_up_jump_shot_made | integer | 2-point field goals made that were a pull-up jump shot by the player over the whole game. |
| two_pointers_pull_up_jump_shot_missed | integer | 2-point field goals missed that were a pull-up jump shot by the player over the whole game. |
| two_pointers_pull_up_jump_shot_attempted | integer | 2-point field goals attempted that were a pull-up jump shot by the player over the whole game. |
| three_pointers_pull_up_jump_shot_made | integer | 3-point field goals made that were a pull-up jump shot by the player over the whole game. |
| three_pointers_pull_up_jump_shot_missed | integer | 3-point field goals missed that were a pull-up jump shot by the player over the whole game. |
| three_pointers_pull_up_jump_shot_attempted | integer | 3-point field goals attempted that were a pull-up jump shot by the player over the whole game. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)

## Examples

``` r
# \donttest{
  try(tpbl_box_players(game_id = 6))
#> ── TPBL Player Box Score from api.tpbl.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:50:16 UTC
#> # A tibble: 35 × 137
#>    game_id side  team_id team       gohoops_squad_id player_id gohoops_person_id
#>      <int> <chr>   <int> <chr>                 <int>     <int>             <int>
#>  1       6 home        4 新竹御嵿攻城獅……             8211        72             70829
#>  2       6 home        4 新竹御嵿攻城獅……             8211        74             70831
#>  3       6 home        4 新竹御嵿攻城獅……             8211        76             70833
#>  4       6 home        4 新竹御嵿攻城獅……             8211        78             70835
#>  5       6 home        4 新竹御嵿攻城獅……             8211        80             70837
#>  6       6 home        4 新竹御嵿攻城獅……             8211        85             70843
#>  7       6 home        4 新竹御嵿攻城獅……             8211        96             70854
#>  8       6 home        4 新竹御嵿攻城獅……             8211        84             70842
#>  9       6 home        4 新竹御嵿攻城獅……             8211        87             70845
#> 10       6 home        4 新竹御嵿攻城獅……             8211        88             70846
#> # ℹ 25 more rows
#> # ℹ 130 more variables: gohoops_roster_id <int>, player <chr>, number <chr>,
#> #   position <chr>, status <chr>, roster_status <chr>, is_starting <lgl>,
#> #   entered <lgl>, time_on_court <int>, score <int>, plus_minus <int>,
#> #   field_goals_made <int>, field_goals_missed <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   two_pointers_made <int>, two_pointers_missed <int>, …
# }
```
