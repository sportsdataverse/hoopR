# **FIBA GAMEPAGE: box teams**

Team box score of one FIBA game, with the game-level figures.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_box_teams(game_id, comp, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) FIBA game id (global): gameId of a gdap schedule
  row, e.g. 100720 = the World Cup 2023 final.

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). The
  game must belong to it. Find it with fiba_gdap_editions or
  fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list (the game-page objects `game`, `playByPlay`,
  `gameDetails`, `playersTeamA`, `playersTeamB`).

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64), global across competitions: gdapGameId, the `<gameId>` of a game-page URL. |
| competition_id | integer | FIBA competition id (Int64) of the game's edition; the comp argument. |
| statistic_system | character | Live-stats system of the game: OVR (World Cup, Olympics) or FLS (club competitions, most qualifiers); they differ in the play-by-play action ids, order and text. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| score | integer | Team final score. |
| points | integer | Points scored in the game. |
| fg_made | integer | Field goals made (2 + 3 points). |
| fg_attempted | integer | Field goals attempted (2 + 3 points). |
| fg_pct | double | Field-goal percentage, 0-100. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| fg2_pct | double | Two-point field-goal percentage, 0-100. |
| fg3_made | integer | Three-point field goals made. |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg3_pct | double | Three-point field-goal percentage, 0-100. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| ft_pct | double | Free-throw percentage, 0-100. |
| reb_offensive | integer | Offensive rebounds. |
| reb_defensive | integer | Defensive rebounds. |
| reb_total | integer | Total rebounds (a team row includes the team rebounds team_reb_total). |
| assists | integer | Assists credited in the game. |
| steals | integer | Steals credited in the game. |
| blocks | integer | Blocked shots (blocks made). |
| blocks_received | integer | Own shots blocked by the opponent (blocks received). |
| turnovers | integer | Turnovers (a team row includes the team turnovers team_turnovers). |
| fouls | integer | Personal fouls (a team row includes the team fouls team_fouls). |
| fouls_drawn | integer | Fouls drawn in the game. |
| paint_fg_made | integer | Field goals made in the paint (team points_in_paint = 2 x paint_fg_made on every sampled game). |
| paint_fg_attempted | integer | Field goals attempted in the paint. |
| paint_fg_pct | double | Field-goal percentage in the paint, 0-100. |
| efficiency | integer | Efficiency (FIBA EFF: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers). |
| biggest_lead | integer | Biggest lead, points. |
| biggest_lead_score | character | Score when the biggest lead was reached, 'A-B' string (spacing varies; empty when the team never led). |
| biggest_run | integer | Biggest scoring run, points. |
| biggest_run_score | character | Score of the biggest scoring run, 'x-y' string; exact meaning unverified. |
| fast_break_points | integer | Fast-break points. |
| points_off_turnovers | integer | Points scored after turnovers. |
| bench_points | integer | Points from the bench (the sum of the non-starters' points). |
| points_in_paint | integer | Points in the paint (2 x paint_fg_made). |
| second_chance_points | integer | Second-chance points. |
| a_act | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_ACT). |
| a_foul | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_FOUL). |
| a_tod | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_TOD). |
| a_tot | integer | Always 0 in the samples; meaning unverified (FIBA stat code A_TOT). |
| team_reb_offensive | integer | Team offensive rebounds, credited to no player. |
| team_reb_defensive | integer | Team defensive rebounds, credited to no player. |
| team_reb_total | integer | Team rebounds (total rebounds minus the players' sum). |
| team_fouls | integer | Team (bench/coach) fouls (personal fouls minus the players' sum). |
| team_turnovers | integer | Team turnovers (turnovers minus the players' sum). |
| team_bench_points_flag | integer | Bench points in FLS games (equal to bench_points); 0 in OVR games (FIBA stat code T_PFB). |
| time_led | character | Time the team led, 'mm:ss' string. |
| lead_changes | integer | Lead changes in the game (game-level; repeats on both team rows). |
| times_tied | integer | Times the score was tied (game-level; repeats on both team rows). |
| duration | character | Game duration as an 'h:mm' string (game-level; repeats on both team rows). |
| attendance | integer | Attendance (game-level; repeats on both team rows). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gamepage_box_teams(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_box_teams from fiba.basketball ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:30 UTC
#> # A tibble: 2 × 57
#>   game_id competition_id statistic_system team_side organisation_id score points
#>     <int>          <int> <chr>            <chr>               <int> <int>  <int>
#> 1  100720         208182 OVR              A                      64    83     83
#> 2  100720         208182 OVR              B                    8323    77     77
#> # ℹ 50 more variables: fg_made <int>, fg_attempted <int>, fg_pct <dbl>,
#> #   fg2_made <int>, fg2_attempted <int>, fg2_pct <dbl>, fg3_made <int>,
#> #   fg3_attempted <int>, fg3_pct <dbl>, ft_made <int>, ft_attempted <int>,
#> #   ft_pct <dbl>, reb_offensive <int>, reb_defensive <int>, reb_total <int>,
#> #   assists <int>, steals <int>, blocks <int>, blocks_received <int>,
#> #   turnovers <int>, fouls <int>, fouls_drawn <int>, paint_fg_made <int>,
#> #   paint_fg_attempted <int>, paint_fg_pct <dbl>, efficiency <int>, …
# }
```
