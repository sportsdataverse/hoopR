# **IBBA Segev Team Box**

**Team totals of both sides: final score, timeouts, lead stats,
shooting, rebounds and team game stats.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`

## Usage

``` r
ibba_segev_team_box(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
| team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
| team_id | integer | Segev team id of the side (key space: Segev teams, stable across seasons). Not an IBBA team-season id; null on game-level actions. |
| score | integer | Final score of the side (homeScore / awayScore). |
| timeouts | integer | Timeouts the side took (the feed's homeTimeOut / awayTimeOut). |
| time_leading | character | Time the side led as 'mm:ss'. |
| biggest_lead | integer | The side's biggest lead in points. |
| times_tied | integer | Times the score was tied (same value for both sides). |
| lead_changes | integer | Lead changes (same value for both sides). |
| fg2m | integer | Two-point field goals made. |
| fg2_missed | integer | Two-point field goals MISSED (not attempted; attempts = made + missed, verified against the IBBA box score). |
| fg3m | integer | Three-point field goals made. |
| fg3_missed | integer | Three-point field goals MISSED (not attempted). |
| ftm | integer | Free throws made. |
| ft_missed | integer | Free throws MISSED (not attempted). |
| dreb | integer | Defensive rebounds. |
| oreb | integer | Offensive rebounds. |
| fouls | integer | Fouls committed (the feed's f; equals the IBBA fouls). |
| fouls_drawn | integer | Fouls drawn (the feed's f_drawn; equals the IBBA fouls_drawn). |
| steals | integer | Steals made by the player or team. |
| turnovers | integer | Turnovers committed by the player or team. |
| assists | integer | Assists credited to the player or team. |
| blocks | integer | Shots the player or team blocked. |
| blocks_against | integer | Own shots that were blocked. |
| fast_break_pts | integer | Fast-break points; for a team total it equals the P of the feed's 'P of N' fast-break stat. |
| second_chance_pts | integer | Second-chance points (scored after an offensive rebound). |
| pts | integer | Points scored by the player or side (free throws included). |
| val | integer | Efficiency rating (the feed's rate; equals the IBBA VAL). |
| deflections | integer | Deflections (count of deflection actions). |
| recoveries | integer | The feed's rec count; unverified, probably loose-ball recoveries. |
| dunks | integer | Dunks made by the player or side. |
| offensive_fouls_drawn | integer | Offensive fouls drawn (charges taken); inferred. |
| and_ones | integer | And-one plays (a made basket plus a foul); inferred. |
| vps | double | The feed's vps ratio with two decimals; its definition is unverified (it matches neither points per shot nor rate per minute). |
| fg2a | integer | Two-point field goals attempted, derived as made + missed. |
| fg3a | integer | Three-point field goals attempted, derived as made + missed. |
| fta | integer | Free throws attempted, derived as made + missed. |
| pts_from_turnovers | integer | Points scored off opponent turnovers (the feed renamed the key in 2026-27). |
| pts_in_paint | integer | Points scored in the paint (the feed renamed the key in 2026-27). |
| starting_points | integer | Points scored by the starting five. |
| bench_points | integer | Points scored by the bench. |
| fast_break_possessions | integer | The N of the feed's 'P of N' fast-break stat (fast-break possessions or attempts); unverified. Null before 2026-27 where the key differs. |
| defensive_stops | integer | Defensive stops; the feed adds it in 2026-27, null before. |
| biggest_scoring_run | character | Biggest scoring run as the feed prints it ('23-0 (36-6)'); 2026-27 on, null before. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_team_box(game_id = 50))
#> ── IBBA Segev team box ────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:41:40 UTC
#> # A tibble: 2 × 44
#>   game_id team_side team_id score timeouts time_leading biggest_lead times_tied
#>     <int> <chr>       <int> <int>    <int> <chr>               <int>      <int>
#> 1      50 home           11    92        1 01:37                   2          6
#> 2      50 away            2   104        2 34:32                  17          6
#> # ℹ 36 more variables: lead_changes <int>, fg2m <int>, fg2_missed <int>,
#> #   fg3m <int>, fg3_missed <int>, ftm <int>, ft_missed <int>, dreb <int>,
#> #   oreb <int>, fouls <int>, fouls_drawn <int>, steals <int>, turnovers <int>,
#> #   assists <int>, blocks <int>, blocks_against <int>, fast_break_pts <int>,
#> #   second_chance_pts <int>, pts <int>, val <int>, deflections <int>,
#> #   recoveries <int>, dunks <int>, offensive_fouls_drawn <int>, and_ones <int>,
#> #   vps <dbl>, fg2a <int>, fg3a <int>, fta <int>, pts_from_turnovers <int>, …
# }
```
