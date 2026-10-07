# **CBD Team Season Overview**

**Get a stored full-season overview of one team from the
CollegeBasketballData API.**

## Usage

``` r
cbbd_teams_season_overview(team_id, season = most_recent_mbb_season())
```

## Arguments

- team_id:

  (*integer* required): CollegeBasketballData team id. See
  [`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md)
  or
  [`cbbd_teams_directory()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_directory.md)
  for valid values.

- season:

  (*integer* required): Season, in 4-digit format ending-year (e.g.
  `2025` for the 2024-25 season). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A named list of `hoopR_data` tibbles, one per section of the overview.
`team`, `record`, `ratings`, `efficiency` and `sources` are one row
each; `shooting` (one row per shot bucket), `players` (one row per
player) and `schedule` (one row per game) are row tables. `shooting`
also carries the attributes `tracked_attempts` (integer) and `coverage`,
and `players` carries `coverage`: a list of `state`, `reason`,
`coveredGames` and `eligibleGames`. A section upstream leaves empty
comes back as a 0-column tibble. Types follow the values: a field
upstream sends as `null` parses as logical `NA`, a whole-number value as
integer, and a nullable object sent as `null` (e.g. the adjusted
ratings) as one `NA` column in place of its fields.

**team: one row**

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | CollegeBasketballData team id. |
| season | integer | Season, as the 4-digit ending year (e.g. 2025 for 2024-25). |
| season_label | character | Season label as upstream formats it. |
| generated_at | character | When upstream built this overview (ISO 8601, UTC). |
| format_version | integer | Version of the upstream overview format. |
| mascot | character | Team mascot. |
| school | character | School name. |
| source_id | character | Source (ESPN) team id. |
| conference_id | integer | Conference id. |
| conference_name | character | Conference name. |
| conference_abbreviation | character | Conference abbreviation. |

**record: one row**

|  |  |  |
|----|----|----|
| col_name | type | description |
| overall_wins | integer | Wins in all games. |
| overall_games | integer | Number of all games in the record. |
| overall_losses | integer | Losses in all games. |
| overall_unresolved | integer | All games without a final result yet. |
| complete | logical | Whether every game in the record has a final result. |
| conference_wins | integer | Wins in conference games. |
| conference_games | integer | Number of conference games in the record. |
| conference_losses | integer | Losses in conference games. |
| conference_unresolved | integer | Conference games without a final result yet. |
| unknown_conference_games | integer | Games whose conference-game status is unknown. |
| unknown_eligibility_games | integer | Games whose eligibility for the overview is unknown. |

**ratings: one row**

|  |  |  |
|----|----|----|
| col_name | type | description |
| elo | double | Elo rating. |
| srs | double | Simple Rating System rating: average scoring margin adjusted for strength of schedule. |
| polls_ap_date | character | Date of the AP poll the standing comes from (YYYY-MM-DD). |
| polls_ap_rank | integer | AP poll rank; NA when unranked. |
| polls_ap_week | integer | Week of that AP poll. |
| polls_ap_state | character | AP poll standing (e.g. ranked). |
| polls_ap_season_type | character | Season type of that AP poll (regular or postseason). |
| polls_coaches_date | character | Date of the Coaches poll the standing comes from (YYYY-MM-DD). |
| polls_coaches_rank | integer | Coaches poll rank; NA when unranked. |
| polls_coaches_week | integer | Week of that Coaches poll. |
| polls_coaches_state | character | Coaches poll standing (e.g. ranked). |
| polls_coaches_season_type | character | Season type of that Coaches poll (regular or postseason). |
| adjusted_net_rank | integer | Rank of the adjusted net rating among the rated teams (1 is best). |
| adjusted_net_value | double | Adjusted net efficiency: adjusted offense minus adjusted defense. |
| adjusted_defense_rank | integer | Rank of the adjusted defense rating among the rated teams (1 is best). |
| adjusted_defense_value | double | Opponent-adjusted defensive efficiency: points allowed per 100 possessions against an average offense (lower is better). |
| adjusted_offense_rank | integer | Rank of the adjusted offense rating among the rated teams (1 is best). |
| adjusted_offense_value | double | Opponent-adjusted offensive efficiency: points scored per 100 possessions against an average defense. |
| adjusted_population | integer | Number of teams in the adjusted ratings. |

**efficiency: one row; each `defense_` column is the opponents' version
of its `offense_` twin**

|  |  |  |
|----|----|----|
| col_name | type | description |
| pace | double | Pace: possessions per 40 minutes. |
| defense_points | integer | Points allowed. |
| defense_box_score_fouls | integer | Opponents' personal fouls. |
| defense_box_score_blocks | integer | Opponents' blocked shots. |
| defense_box_score_steals | integer | Opponents' steals. |
| defense_box_score_assists | integer | Opponents' assists. |
| defense_box_score_minutes | integer | Opponents' minutes played (team minutes). |
| defense_box_score_rebounds_total | integer | Opponents' total rebounds. |
| defense_box_score_rebounds_defensive | integer | Opponents' defensive rebounds. |
| defense_box_score_rebounds_offensive | integer | Opponents' offensive rebounds. |
| defense_box_score_turnovers | integer | Opponents' turnovers credited to players. |
| defense_box_score_field_goals_pct | double | Opponents' field goals percentage (0-100). |
| defense_box_score_field_goals_made | integer | Opponents' field goals made. |
| defense_box_score_field_goals_attempted | integer | Opponents' field goals attempted. |
| defense_box_score_free_throws_pct | double | Opponents' free throws percentage (0-100). |
| defense_box_score_free_throws_made | integer | Opponents' free throws made. |
| defense_box_score_free_throws_attempted | integer | Opponents' free throws attempted. |
| defense_box_score_flagrant_fouls | integer | Opponents' flagrant fouls. |
| defense_box_score_points_in_paint | integer | Opponents' points in the paint. |
| defense_box_score_team_turnovers | integer | Opponents' team turnovers (not credited to a player). |
| defense_box_score_technical_fouls | integer | Opponents' technical fouls. |
| defense_box_score_fast_break_points | integer | Opponents' fast-break points. |
| defense_box_score_true_shooting_pct | double | Opponents' true shooting percentage (0-100). |
| defense_box_score_points_off_turnovers | integer | Opponents' points off turnovers. |
| defense_box_score_two_point_field_goals_pct | double | Opponents' two-point field goals percentage (0-100). |
| defense_box_score_two_point_field_goals_made | integer | Opponents' two-point field goals made. |
| defense_box_score_two_point_field_goals_attempted | integer | Opponents' two-point field goals attempted. |
| defense_box_score_three_point_field_goals_pct | double | Opponents' three-point field goals percentage (0-100). |
| defense_box_score_three_point_field_goals_made | integer | Opponents' three-point field goals made. |
| defense_box_score_three_point_field_goals_attempted | integer | Opponents' three-point field goals attempted. |
| defense_raw_rating | double | Points allowed per 100 opponent possessions, not adjusted for opponent. |
| defense_possessions | integer | Opponent possessions. |
| defense_turnover_pct | double | Opponents' turnovers per 100 possessions. |
| defense_free_throw_rate | double | Opponents' free throw attempts per 100 field goal attempts. |
| defense_offensive_rebound_pct | double | Opponents' offensive rebound percentage (0-100). |
| defense_effective_field_goal_pct | double | Opponents' effective field goal percentage (0-100). |
| offense_points | integer | Points scored. |
| offense_box_score_fouls | integer | Team personal fouls. |
| offense_box_score_blocks | integer | Team blocked shots. |
| offense_box_score_steals | integer | Team steals. |
| offense_box_score_assists | integer | Team assists. |
| offense_box_score_minutes | integer | Team minutes played (team minutes). |
| offense_box_score_rebounds_total | integer | Team total rebounds. |
| offense_box_score_rebounds_defensive | integer | Team defensive rebounds. |
| offense_box_score_rebounds_offensive | integer | Team offensive rebounds. |
| offense_box_score_turnovers | integer | Team turnovers credited to players. |
| offense_box_score_field_goals_pct | double | Team field goals percentage (0-100). |
| offense_box_score_field_goals_made | integer | Team field goals made. |
| offense_box_score_field_goals_attempted | integer | Team field goals attempted. |
| offense_box_score_free_throws_pct | double | Team free throws percentage (0-100). |
| offense_box_score_free_throws_made | integer | Team free throws made. |
| offense_box_score_free_throws_attempted | integer | Team free throws attempted. |
| offense_box_score_flagrant_fouls | integer | Team flagrant fouls. |
| offense_box_score_points_in_paint | integer | Team points in the paint. |
| offense_box_score_team_turnovers | integer | Team team turnovers (not credited to a player). |
| offense_box_score_technical_fouls | integer | Team technical fouls. |
| offense_box_score_fast_break_points | integer | Team fast-break points. |
| offense_box_score_true_shooting_pct | double | Team true shooting percentage (0-100). |
| offense_box_score_points_off_turnovers | integer | Team points off turnovers. |
| offense_box_score_two_point_field_goals_pct | double | Team two-point field goals percentage (0-100). |
| offense_box_score_two_point_field_goals_made | integer | Team two-point field goals made. |
| offense_box_score_two_point_field_goals_attempted | integer | Team two-point field goals attempted. |
| offense_box_score_three_point_field_goals_pct | double | Team three-point field goals percentage (0-100). |
| offense_box_score_three_point_field_goals_made | integer | Team three-point field goals made. |
| offense_box_score_three_point_field_goals_attempted | integer | Team three-point field goals attempted. |
| offense_raw_rating | double | Points scored per 100 possessions, not adjusted for opponent. |
| offense_possessions | integer | Possessions. |
| offense_turnover_pct | double | Team turnovers per 100 possessions. |
| offense_free_throw_rate | double | Team free throw attempts per 100 field goal attempts. |
| offense_offensive_rebound_pct | double | Team offensive rebound percentage (0-100). |
| offense_effective_field_goal_pct | double | Team effective field goal percentage (0-100). |
| coverage_state | character | Whether the play-by-play this section needs is available (e.g. available, partial). |
| coverage_reason | character | Why coverage is not complete (e.g. unclassified_shots); NA when available. |
| coverage_covered_games | integer | Games with the data this section needs. |
| coverage_eligible_games | integer | Games eligible for this section. |
| pace_games | integer | Games in the pace sample. |

**shooting: one row per shot bucket**

|  |  |  |
|----|----|----|
| col_name | type | description |
| key | character | Shot bucket: at_rim, two_point_jumper or three_point_jumper. |
| made | integer | Field goals made from the bucket. |
| attempts | integer | Field goal attempts from the bucket. |
| attempt_pct | double | Share of the team's classified tracked attempts taken from the bucket (0-100). |
| field_goal_pct | double | Field goal percentage from the bucket (0-100). |

**players: one row per player**

|  |  |  |
|----|----|----|
| col_name | type | description |
| name | character | Player name. |
| games | integer | Games played. |
| points | integer | Points. |
| assists | integer | Assists. |
| minutes | integer | Minutes played. |
| complete | logical | Whether upstream marks the player's season line as complete. |
| has_stats | logical | Whether the player has recorded statistics this season. |
| on_roster | logical | Whether the player is on the team's roster. |
| position | character | Position (e.g. G, F, C). |
| rebounds | integer | Rebounds. |
| usage_pct | double | Usage percentage (0-100): share of team possessions the player used while on the floor. |
| athlete_id | integer | CollegeBasketballData athlete id. |
| usage_games | integer | Games in the usage sample. |
| points_per_game | double | Points per game. |
| minutes_per_game | double | Minutes per game. |
| true_shooting_pct | double | True shooting percentage (0-100). |
| effective_field_goal_pct | double | Effective field goal percentage (0-100). |
| season_stats_fouls | integer | Personal fouls. |
| season_stats_blocks | integer | Blocked shots. |
| season_stats_starts | integer | Games started. |
| season_stats_steals | integer | Steals. |
| season_stats_assists | integer | Assists. |
| season_stats_turnovers | integer | Turnovers. |
| season_stats_free_throw_rate | double | Free throw attempts per 100 field goal attempts. |
| season_stats_assist_turnover_ratio | double | Assists per turnover. |
| season_stats_offensive_rebound_pct | double | Offensive rebound percentage (0-100). |
| season_stats_advanced_games | integer | Games in the advanced-stat sample. |
| season_stats_advanced_porpag | double | PORPAG: points over replacement per adjusted game. |
| season_stats_advanced_net_rating | double | Net rating: offensive rating minus defensive rating. |
| season_stats_advanced_defensive_rating | double | Defensive rating: points allowed per 100 possessions while on the floor. |
| season_stats_advanced_offensive_rating | double | Offensive rating: points produced per 100 possessions. |
| season_stats_advanced_win_shares_per40 | double | Win shares per 40 minutes. |
| season_stats_advanced_win_shares_total | double | Win shares. |
| season_stats_advanced_win_shares_defensive | double | Defensive win shares. |
| season_stats_advanced_win_shares_offensive | double | Offensive win shares. |
| season_stats_rebounds_total | integer | Total rebounds. |
| season_stats_rebounds_defensive | integer | Defensive rebounds. |
| season_stats_rebounds_offensive | integer | Offensive rebounds. |
| season_stats_field_goals_pct | double | Field goals percentage (0-100). |
| season_stats_field_goals_made | integer | Field goals made. |
| season_stats_field_goals_attempted | integer | Field goals attempted. |
| season_stats_free_throws_pct | double | Free throws percentage (0-100). |
| season_stats_free_throws_made | integer | Free throws made. |
| season_stats_free_throws_attempted | integer | Free throws attempted. |
| season_stats_two_point_field_goals_pct | double | Two-point field goals percentage (0-100). |
| season_stats_two_point_field_goals_made | integer | Two-point field goals made. |
| season_stats_two_point_field_goals_attempted | integer | Two-point field goals attempted. |
| season_stats_three_point_field_goals_pct | double | Three-point field goals percentage (0-100). |
| season_stats_three_point_field_goals_made | integer | Three-point field goals made. |
| season_stats_three_point_field_goals_attempted | integer | Three-point field goals attempted. |

**schedule: one row per game**

|  |  |  |
|----|----|----|
| col_name | type | description |
| id | integer | CollegeBasketballData game id. |
| venue | character | Venue name. |
| result | character | Result for the team: W or L; NA until final. |
| status | character | Game status (e.g. final). |
| game_type | character | Upstream game type code (e.g. STD, TRNMNT). |
| location | character | Where the team played: home, away or neutral. |
| opponent | character | Opponent school name. |
| start_date | character | Tipoff (ISO 8601, UTC). |
| opponent_id | integer | Opponent's CollegeBasketballData team id. |
| season_type | character | Season type: regular or postseason. |
| team_points | integer | Points scored by the team. |
| eligibility | character | Whether the game counts toward the overview (e.g. counted). |
| calendar_date | character | Local calendar date of the game (YYYY-MM-DD). |
| start_time_tbd | logical | Whether the tipoff time is to be determined. |
| conference_game | logical | Whether the game is a conference game. |
| opponent_points | integer | Points scored by the opponent. |
| opponent_has_profile | logical | Whether the opponent has its own season overview. |

**sources: one row**

|  |  |  |
|----|----|----|
| col_name | type | description |
| notes | character | Upstream notes on how the overview is built, joined with a semicolon. |
| latest_final_start_date | character | Tipoff (ISO 8601, UTC) of the latest final game included. |
| leaderboard_updated_at | character | When the leaderboard data behind the player rows last updated (ISO 8601); NA when upstream sends none. |

## See also

Other CBD Teams Functions:
[`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md),
[`cbbd_teams_directory()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_directory.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams_season_overview(team_id = 72, season = 2025))
#> ✖ 2026-10-07 16:28:53.282757: Invalid arguments or no team season overview data available!
#> ✖ Args: team_id = 72, season = 2025
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> list()
# }
```
