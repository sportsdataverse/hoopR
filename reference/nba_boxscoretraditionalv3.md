# **Get NBA Stats API Boxscore Traditional V3**

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md)
instead.

## Usage

``` r
nba_boxscoretraditionalv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoreadvancedv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoremiscv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscorescoringv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoreusagev3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscorefourfactorsv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoreplayertrackv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscorematchupsv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscorehustlev2(game_id = "0022200021", ...)

nba_boxscoredefensivev2(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_gamerotation(game_id, league_id = "00", rotation_stat = "PLAYER_PTS", ...)

nba_boxscoresummaryv3(game_id = "0022200021", ...)
```

## Arguments

- game_id:

  Game ID - 10-digit zero-padded ID (e.g., '0022200021')

- start_period:

  Start period filter - default: 0

- end_period:

  End period filter - default: 0

- start_range:

  Start range filter (in tenths of a second) - default: 0

- end_range:

  End range filter (in tenths of a second) - default: 0

- range_type:

  Range type - 0: by half, 1: by period, 2: custom range

- ...:

  Additional arguments passed to an underlying function like httr.

- league_id:

  League ID

- rotation_stat:

  Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT

## Value

Returns a named list of data frames: home_team_player_traditional,
away_team_player_traditional, home_team_totals_traditional,
away_team_totals_traditional, home_team_starters_totals,
away_team_starters_totals, home_team_bench_totals,
away_team_bench_totals

**home_team_player_traditional**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls_personal | integer | Personal fouls. |
| points | integer | Points scored. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |

**away_team_player_traditional**

Same columns as the **home_team_player_traditional** table above.

**home_team_totals_traditional**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls_personal | integer | Personal fouls. |
| points | integer | Points scored. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |

**away_team_totals_traditional**

Same columns as the **home_team_totals_traditional** table above.

**home_team_starters_totals**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls_personal | integer | Personal fouls. |
| points | integer | Points scored. |

**away_team_starters_totals**

Same columns as the **home_team_starters_totals** table above.

**home_team_bench_totals**

Same columns as the **home_team_starters_totals** table above.

**away_team_bench_totals**

Same columns as the **home_team_starters_totals** table above.

Returns a named list of data frames: home_team_player_advanced,
away_team_player_advanced, home_team_totals_advanced,
away_team_totals_advanced

**home_team_player_advanced**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| estimated_offensive_rating | numeric | Estimated offensive rating (points per 100 possessions estimate). |
| offensive_rating | numeric | Offensive rating (points per 100 possessions). |
| estimated_defensive_rating | numeric | Estimated defensive rating (points allowed per 100 possessions estimate). |
| defensive_rating | numeric | Defensive rating (points allowed per 100 possessions). |
| estimated_net_rating | numeric | Estimated net rating (off rating - def rating). |
| net_rating | numeric | Net rating (off rating - def rating). |
| assist_percentage | numeric | Assist percentage (0-1). |
| assist_to_turnover | numeric | Assist-to-turnover ratio. |
| assist_ratio | numeric | Assist ratio (assists per 100 possessions used). |
| offensive_rebound_percentage | numeric | Offensive rebound percentage (0-1). |
| defensive_rebound_percentage | numeric | Defensive rebound percentage (0-1). |
| rebound_percentage | numeric | Total rebound percentage (0-1). |
| turnover_ratio | numeric | Turnover ratio (turnovers per 100 possessions used). |
| effective_field_goal_percentage | numeric | Effective field goal percentage (0-1). |
| true_shooting_percentage | numeric | True shooting percentage (0-1). |
| usage_percentage | numeric | Usage percentage (0-1). |
| estimated_usage_percentage | numeric | Estimated usage percentage (0-1). |
| estimated_pace | numeric | Estimated possessions per 48 minutes. |
| pace | numeric | Possessions per 48 minutes. |
| pace_per40 | numeric | Pace per40. |
| possessions | numeric | Possessions used. |
| pie | numeric | Player Impact Estimate (0-1). |

**away_team_player_advanced**

Same columns as the **home_team_player_advanced** table above.

**home_team_totals_advanced**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| estimated_offensive_rating | numeric | Estimated offensive rating (points per 100 possessions estimate). |
| offensive_rating | numeric | Offensive rating (points per 100 possessions). |
| estimated_defensive_rating | numeric | Estimated defensive rating (points allowed per 100 possessions estimate). |
| defensive_rating | numeric | Defensive rating (points allowed per 100 possessions). |
| estimated_net_rating | numeric | Estimated net rating (off rating - def rating). |
| net_rating | numeric | Net rating (off rating - def rating). |
| assist_percentage | numeric | Assist percentage (0-1). |
| assist_to_turnover | numeric | Assist-to-turnover ratio. |
| assist_ratio | numeric | Assist ratio (assists per 100 possessions used). |
| offensive_rebound_percentage | numeric | Offensive rebound percentage (0-1). |
| defensive_rebound_percentage | numeric | Defensive rebound percentage (0-1). |
| rebound_percentage | numeric | Total rebound percentage (0-1). |
| estimated_team_turnover_percentage | numeric | Estimated team turnover percentage (0-1). |
| turnover_ratio | numeric | Turnover ratio (turnovers per 100 possessions used). |
| effective_field_goal_percentage | numeric | Effective field goal percentage (0-1). |
| true_shooting_percentage | numeric | True shooting percentage (0-1). |
| usage_percentage | numeric | Usage percentage (0-1). |
| estimated_usage_percentage | numeric | Estimated usage percentage (0-1). |
| estimated_pace | numeric | Estimated possessions per 48 minutes. |
| pace | numeric | Possessions per 48 minutes. |
| pace_per40 | numeric | Pace per40. |
| possessions | numeric | Possessions used. |
| pie | numeric | Player Impact Estimate (0-1). |

**away_team_totals_advanced**

Same columns as the **home_team_totals_advanced** table above.

Returns a named list of data frames: home_team_player_misc,
away_team_player_misc, home_team_totals_misc, away_team_totals_misc

**home_team_player_misc**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| points_off_turnovers | integer | Points scored off opponent turnovers. |
| points_second_chance | integer | Second-chance points scored. |
| points_fast_break | integer | Fast-break points scored. |
| points_paint | integer | Points scored in the paint. |
| opp_points_off_turnovers | integer | Opponent points off turnovers. |
| opp_points_second_chance | integer | Opponent points second chance. |
| opp_points_fast_break | integer | Opponent points fast break. |
| opp_points_paint | integer | Opponent points paint. |
| blocks | integer | Total blocks. |
| blocks_against | integer | Shots blocked by opponents while attempting. |
| fouls_personal | integer | Personal fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |

**away_team_player_misc**

Same columns as the **home_team_player_misc** table above.

**home_team_totals_misc**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| points_off_turnovers | integer | Points scored off opponent turnovers. |
| points_second_chance | integer | Second-chance points scored. |
| points_fast_break | integer | Fast-break points scored. |
| points_paint | integer | Points scored in the paint. |
| opp_points_off_turnovers | integer | Opponent points off turnovers. |
| opp_points_second_chance | integer | Opponent points second chance. |
| opp_points_fast_break | integer | Opponent points fast break. |
| opp_points_paint | integer | Opponent points paint. |
| blocks | integer | Total blocks. |
| blocks_against | integer | Shots blocked by opponents while attempting. |
| fouls_personal | integer | Personal fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |

**away_team_totals_misc**

Same columns as the **home_team_totals_misc** table above.

Returns a named list of data frames: home_team_player_scoring,
away_team_player_scoring, home_team_totals_scoring,
away_team_totals_scoring

**home_team_player_scoring**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| percentage_field_goals_attempted2pt | numeric | Percentage field goals attempted2pt. |
| percentage_field_goals_attempted3pt | numeric | Percentage field goals attempted3pt. |
| percentage_points2pt | numeric | Percentage points2pt. |
| percentage_points_midrange2pt | numeric | Percentage points midrange2pt. |
| percentage_points3pt | numeric | Percentage points3pt. |
| percentage_points_fast_break | numeric | Percentage points fast break. |
| percentage_points_free_throw | numeric | Percentage points free throw. |
| percentage_points_off_turnovers | numeric | Percentage points off turnovers. |
| percentage_points_paint | numeric | Percentage points paint. |
| percentage_assisted2pt | numeric | Percentage assisted2pt. |
| percentage_unassisted2pt | numeric | Percentage unassisted2pt. |
| percentage_assisted3pt | numeric | Percentage assisted3pt. |
| percentage_unassisted3pt | numeric | Percentage unassisted3pt. |
| percentage_assisted_fgm | numeric | Percentage assisted fgm. |
| percentage_unassisted_fgm | numeric | Percentage unassisted fgm. |

**away_team_player_scoring**

Same columns as the **home_team_player_scoring** table above.

**home_team_totals_scoring**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| percentage_field_goals_attempted2pt | numeric | Percentage field goals attempted2pt. |
| percentage_field_goals_attempted3pt | numeric | Percentage field goals attempted3pt. |
| percentage_points2pt | numeric | Percentage points2pt. |
| percentage_points_midrange2pt | numeric | Percentage points midrange2pt. |
| percentage_points3pt | numeric | Percentage points3pt. |
| percentage_points_fast_break | numeric | Percentage points fast break. |
| percentage_points_free_throw | numeric | Percentage points free throw. |
| percentage_points_off_turnovers | numeric | Percentage points off turnovers. |
| percentage_points_paint | numeric | Percentage points paint. |
| percentage_assisted2pt | numeric | Percentage assisted2pt. |
| percentage_unassisted2pt | numeric | Percentage unassisted2pt. |
| percentage_assisted3pt | numeric | Percentage assisted3pt. |
| percentage_unassisted3pt | numeric | Percentage unassisted3pt. |
| percentage_assisted_fgm | numeric | Percentage assisted fgm. |
| percentage_unassisted_fgm | numeric | Percentage unassisted fgm. |

**away_team_totals_scoring**

Same columns as the **home_team_totals_scoring** table above.

Returns a named list of data frames: home_team_player_usage,
away_team_player_usage, home_team_totals_usage, away_team_totals_usage

**home_team_player_usage**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| usage_percentage | numeric | Usage percentage (0-1). |
| percentage_field_goals_made | numeric | Number of percentage field goals made. |
| percentage_field_goals_attempted | numeric | Number of percentage field goals attempted. |
| percentage_three_pointers_made | numeric | Number of percentage three pointers made. |
| percentage_three_pointers_attempted | numeric | Number of percentage three pointers attempted. |
| percentage_free_throws_made | numeric | Number of percentage free throws made. |
| percentage_free_throws_attempted | numeric | Number of percentage free throws attempted. |
| percentage_rebounds_offensive | numeric | Percentage rebounds offensive. |
| percentage_rebounds_defensive | numeric | Percentage rebounds defensive. |
| percentage_rebounds_total | numeric | Percentage rebounds total. |
| percentage_assists | numeric | Percentage assists. |
| percentage_turnovers | numeric | Percentage turnovers. |
| percentage_steals | numeric | Percentage steals. |
| percentage_blocks | numeric | Percentage blocks. |
| percentage_blocks_allowed | numeric | Percentage blocks allowed. |
| percentage_personal_fouls | numeric | Percentage personal fouls. |
| percentage_personal_fouls_drawn | numeric | Percentage personal fouls drawn. |
| percentage_points | numeric | Percentage points. |

**away_team_player_usage**

Same columns as the **home_team_player_usage** table above.

**home_team_totals_usage**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| usage_percentage | numeric | Usage percentage (0-1). |
| percentage_field_goals_made | numeric | Number of percentage field goals made. |
| percentage_field_goals_attempted | numeric | Number of percentage field goals attempted. |
| percentage_three_pointers_made | numeric | Number of percentage three pointers made. |
| percentage_three_pointers_attempted | numeric | Number of percentage three pointers attempted. |
| percentage_free_throws_made | numeric | Number of percentage free throws made. |
| percentage_free_throws_attempted | numeric | Number of percentage free throws attempted. |
| percentage_rebounds_offensive | numeric | Percentage rebounds offensive. |
| percentage_rebounds_defensive | numeric | Percentage rebounds defensive. |
| percentage_rebounds_total | numeric | Percentage rebounds total. |
| percentage_assists | numeric | Percentage assists. |
| percentage_turnovers | numeric | Percentage turnovers. |
| percentage_steals | numeric | Percentage steals. |
| percentage_blocks | numeric | Percentage blocks. |
| percentage_blocks_allowed | numeric | Percentage blocks allowed. |
| percentage_personal_fouls | numeric | Percentage personal fouls. |
| percentage_personal_fouls_drawn | numeric | Percentage personal fouls drawn. |
| percentage_points | numeric | Percentage points. |

**away_team_totals_usage**

Same columns as the **home_team_totals_usage** table above.

Returns a named list of data frames: home_team_player_four_factors,
away_team_player_four_factors, home_team_totals_four_factors,
away_team_totals_four_factors

**home_team_player_four_factors**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| effective_field_goal_percentage | numeric | Effective field goal percentage (0-1). |
| free_throw_attempt_rate | numeric | Free throw attempt rate (FTA / FGA). |
| team_turnover_percentage | numeric | Team turnover percentage (0-1). |
| offensive_rebound_percentage | numeric | Offensive rebound percentage (0-1). |
| opp_effective_field_goal_percentage | numeric | Opponent effective field goal percentage (0-1 decimal). |
| opp_free_throw_attempt_rate | numeric | Opponent free throw attempt rate. |
| opp_team_turnover_percentage | numeric | Opponent team turnover percentage (0-1 decimal). |
| opp_offensive_rebound_percentage | numeric | Opponent offensive rebound percentage (0-1 decimal). |

**away_team_player_four_factors**

Same columns as the **home_team_player_four_factors** table above.

**home_team_totals_four_factors**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| effective_field_goal_percentage | numeric | Effective field goal percentage (0-1). |
| free_throw_attempt_rate | numeric | Free throw attempt rate (FTA / FGA). |
| team_turnover_percentage | numeric | Team turnover percentage (0-1). |
| offensive_rebound_percentage | numeric | Offensive rebound percentage (0-1). |
| opp_effective_field_goal_percentage | numeric | Opponent effective field goal percentage (0-1 decimal). |
| opp_free_throw_attempt_rate | numeric | Opponent free throw attempt rate. |
| opp_team_turnover_percentage | numeric | Opponent team turnover percentage (0-1 decimal). |
| opp_offensive_rebound_percentage | numeric | Opponent offensive rebound percentage (0-1 decimal). |

**away_team_totals_four_factors**

Same columns as the **home_team_totals_four_factors** table above.

Returns a named list of data frames: home_team_player_player_track,
away_team_player_player_track, home_team_totals_player_track,
away_team_totals_player_track

**home_team_player_player_track**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| speed | numeric | Speed. |
| distance | numeric | Distance value (in feet for shot data; otherwise context-dependent). |
| rebound_chances_offensive | integer | Rebound chances offensive. |
| rebound_chances_defensive | integer | Rebound chances defensive. |
| rebound_chances_total | integer | Rebound chances total. |
| touches | integer | Touches. |
| secondary_assists | integer | Secondary assists. |
| free_throw_assists | integer | Free throw assists (passes that led to a fouled shot attempt). |
| passes | integer | Passes. |
| assists | integer | Total assists. |
| contested_field_goals_made | integer | Contested field goals made. |
| contested_field_goals_attempted | integer | Contested field goal attempts. |
| contested_field_goal_percentage | numeric | Contested field goal percentage (0-1). |
| uncontested_field_goals_made | integer | Number of uncontested field goals made. |
| uncontested_field_goals_attempted | integer | Number of uncontested field goals attempted. |
| uncontested_field_goals_percentage | numeric | Uncontested field goals percentage (0-1 decimal). |
| field_goal_percentage | numeric | Field Goal Percentage. |
| defended_at_rim_field_goals_made | integer | Field goals made allowed when defending at the rim. |
| defended_at_rim_field_goals_attempted | integer | Field goal attempts allowed when defending at the rim. |
| defended_at_rim_field_goal_percentage | numeric | Field goal percentage allowed at the rim (0-1). |

**away_team_player_player_track**

Same columns as the **home_team_player_player_track** table above.

**home_team_totals_player_track**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| distance | numeric | Distance value (in feet for shot data; otherwise context-dependent). |
| rebound_chances_offensive | integer | Rebound chances offensive. |
| rebound_chances_defensive | integer | Rebound chances defensive. |
| rebound_chances_total | integer | Rebound chances total. |
| touches | integer | Touches. |
| secondary_assists | integer | Secondary assists. |
| free_throw_assists | integer | Free throw assists (passes that led to a fouled shot attempt). |
| passes | integer | Passes. |
| assists | integer | Total assists. |
| contested_field_goals_made | integer | Contested field goals made. |
| contested_field_goals_attempted | integer | Contested field goal attempts. |
| contested_field_goal_percentage | numeric | Contested field goal percentage (0-1). |
| uncontested_field_goals_made | integer | Number of uncontested field goals made. |
| uncontested_field_goals_attempted | integer | Number of uncontested field goals attempted. |
| uncontested_field_goals_percentage | numeric | Uncontested field goals percentage (0-1 decimal). |
| field_goal_percentage | numeric | Field Goal Percentage. |
| defended_at_rim_field_goals_made | integer | Field goals made allowed when defending at the rim. |
| defended_at_rim_field_goals_attempted | integer | Field goal attempts allowed when defending at the rim. |
| defended_at_rim_field_goal_percentage | numeric | Field goal percentage allowed at the rim (0-1). |

**away_team_totals_player_track**

Same columns as the **home_team_totals_player_track** table above.

Returns a named list of data frames: home_team_player_matchups,
away_team_player_matchups

**home_team_player_matchups**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| matchups_person_id | integer | Unique identifier for matchups person. |
| matchups_first_name | character | Matchups first name. |
| matchups_family_name | character | Matchups family name. |
| matchups_name_i | character | Matchups name i. |
| matchups_player_slug | character | Matchups player slug. |
| matchups_jersey_num | character | Matchups jersey num. |
| matchup_minutes | character | Matchup minutes. |
| matchup_minutes_sort | numeric | Matchup minutes sort. |
| partial_possessions | numeric | Partial possessions. |
| percentage_defender_total_time | numeric | Time / clock value. |
| percentage_offensive_total_time | numeric | Time / clock value. |
| percentage_total_time_both_on | numeric | Percentage total time both on. |
| switches_on | integer | Switches on. |
| player_points | integer | Player points. |
| team_points | integer | Team points. |
| matchup_assists | integer | Matchup assists. |
| matchup_potential_assists | integer | Matchup potential assists. |
| matchup_turnovers | integer | Matchup turnovers. |
| matchup_blocks | integer | Matchup blocks. |
| matchup_field_goals_made | integer | Number of matchup field goals made. |
| matchup_field_goals_attempted | integer | Number of matchup field goals attempted. |
| matchup_field_goals_percentage | numeric | Matchup field goals percentage (0-1 decimal). |
| matchup_three_pointers_made | integer | Number of matchup three pointers made. |
| matchup_three_pointers_attempted | integer | Number of matchup three pointers attempted. |
| matchup_three_pointers_percentage | numeric | Matchup three pointers percentage (0-1 decimal). |
| help_blocks | integer | Help blocks. |
| help_field_goals_made | integer | Number of help field goals made. |
| help_field_goals_attempted | integer | Number of help field goals attempted. |
| help_field_goals_percentage | numeric | Help field goals percentage (0-1 decimal). |
| matchup_free_throws_made | integer | Number of matchup free throws made. |
| matchup_free_throws_attempted | integer | Number of matchup free throws attempted. |
| shooting_fouls | integer | Shooting fouls. |

**away_team_player_matchups**

Same columns as the **home_team_player_matchups** table above.

Returns a named list of data frames: home_team_player_hustle,
away_team_player_hustle, home_team_hustle_totals,
away_team_hustle_totals

**home_team_player_hustle**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| points | integer | Points scored. |
| contested_shots | integer | Defensively contested shots. |
| contested_shots2pt | integer | Contested shots2pt. |
| contested_shots3pt | integer | Contested shots3pt. |
| deflections | integer | Defensive deflections. |
| charges_drawn | integer | Charges drawn. |
| screen_assists | integer | Screen assists (resulting in a basket). |
| screen_assist_points | integer | Points generated from screen assists. |
| loose_balls_recovered_offensive | integer | Loose balls recovered on offense. |
| loose_balls_recovered_defensive | integer | Loose balls recovered on defense. |
| loose_balls_recovered_total | integer | Loose balls recovered total. |
| offensive_box_outs | integer | Offensive box outs. |
| defensive_box_outs | integer | Defensive box outs. |
| box_out_player_team_rebounds | integer | Box-outs that led to either a player or team rebound. |
| box_out_player_rebounds | integer | Box-outs that led to a player rebound. |
| box_outs | integer | Box-outs executed. |

**away_team_player_hustle**

Same columns as the **home_team_player_hustle** table above.

**home_team_totals_hustle**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| points | integer | Points scored. |
| contested_shots | integer | Defensively contested shots. |
| contested_shots2pt | integer | Contested shots2pt. |
| contested_shots3pt | integer | Contested shots3pt. |
| deflections | integer | Defensive deflections. |
| charges_drawn | integer | Charges drawn. |
| screen_assists | integer | Screen assists (resulting in a basket). |
| screen_assist_points | integer | Points generated from screen assists. |
| loose_balls_recovered_offensive | integer | Loose balls recovered on offense. |
| loose_balls_recovered_defensive | integer | Loose balls recovered on defense. |
| loose_balls_recovered_total | integer | Loose balls recovered total. |
| offensive_box_outs | integer | Offensive box outs. |
| defensive_box_outs | integer | Defensive box outs. |
| box_out_player_team_rebounds | integer | Box-outs that led to either a player or team rebound. |
| box_out_player_rebounds | integer | Box-outs that led to a player rebound. |
| box_outs | integer | Box-outs executed. |

**away_team_totals_hustle**

Same columns as the **home_team_totals_hustle** table above.

Returns a named list of data frames: home_team_player_defensive,
away_team_player_defensive, home_team_totals_defensive,
away_team_totals_defensive

**home_team_player_defensive**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| player_slug | character | URL-safe player identifier. |
| position | character | Listed roster position (G, F, C, etc.). |
| comment | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| jersey_num | character | Jersey number worn by the player. |
| matchup_minutes | character | Matchup minutes. |
| partial_possessions | numeric | Partial possessions. |
| switches_on | integer | Switches on. |
| player_points | integer | Player points. |
| defensive_rebounds | integer | Defensive rebounds. |
| matchup_assists | integer | Matchup assists. |
| matchup_turnovers | integer | Matchup turnovers. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| matchup_field_goals_made | integer | Number of matchup field goals made. |
| matchup_field_goals_attempted | integer | Number of matchup field goals attempted. |
| matchup_field_goal_percentage | numeric | Matchup field goal percentage (0-1 decimal). |
| matchup_three_pointers_made | integer | Number of matchup three pointers made. |
| matchup_three_pointers_attempted | integer | Number of matchup three pointers attempted. |
| matchup_three_pointer_percentage | numeric | Matchup three pointer percentage (0-1 decimal). |

**away_team_player_defensive**

Same columns as the **home_team_player_defensive** table above.

**home_team_totals_defensive**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |

**away_team_totals_defensive**

Same columns as the **home_team_totals_defensive** table above.

Returns a named list of data frames: AwayTeam, HomeTeam

**AwayTeam**

|               |           |                                                 |
|---------------|-----------|-------------------------------------------------|
| col_name      | types     | description                                     |
| GAME_ID       | character | Unique game identifier.                         |
| TEAM_ID       | character | Unique team identifier.                         |
| TEAM_CITY     | character | Team city or region (e.g. 'Las Vegas').         |
| TEAM_NAME     | character | Full team display name (e.g. 'Las Vegas Aces'). |
| PERSON_ID     | character | Unique player identifier (V3 endpoints).        |
| PLAYER_FIRST  | character |                                                 |
| PLAYER_LAST   | character |                                                 |
| IN_TIME_REAL  | character |                                                 |
| OUT_TIME_REAL | character |                                                 |
| PLAYER_PTS    | character |                                                 |
| PT_DIFF       | character |                                                 |
| USG_PCT       | character | Usage percentage (0-1).                         |

**HomeTeam**

Same columns as the **AwayTeam** table above.

Returns a named list of data frames: GameSummary, GameInfo, ArenaInfo,
Officials, LineScore, InactivePlayers, LastFiveMeetings, OtherStats,
AvailableVideo

**GameSummary**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock | character | Game clock. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_et | character | Game et. |
| away_team_id | integer | Unique identifier for the away team. |
| home_team_id | integer | Unique identifier for the home team. |
| duration | integer | Duration. |
| attendance | integer | Reported attendance. |
| sellout | character | Sellout. |

**GameInfo**

|               |           |                         |
|---------------|-----------|-------------------------|
| col_name      | types     | description             |
| game_id       | character | Unique game identifier. |
| game_date     | character | Game date (YYYY-MM-DD). |
| attendance    | integer   | Reported attendance.    |
| game_duration | integer   | Game duration.          |

**ArenaInfo**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| game_id        | character | Unique game identifier.      |
| arena_id       | integer   | Unique identifier for arena. |
| arena_name     | character | Arena name.                  |
| arena_city     | character | Arena city.                  |
| arena_state    | character | Arena state.                 |
| arena_country  | character | Arena country.               |
| arena_timezone | character | Arena timezone.              |

**Officials**

|             |           |                                          |
|-------------|-----------|------------------------------------------|
| col_name    | types     | description                              |
| game_id     | character | Unique game identifier.                  |
| person_id   | integer   | Unique player identifier (V3 endpoints). |
| name        | character | Display name.                            |
| name_i      | character | Initialed name (e.g. 'A. Wilson').       |
| first_name  | character | Player's first name.                     |
| family_name | character | Player's family / last name.             |
| jersey_num  | character | Jersey number worn by the player.        |

**LineScore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| team_id | integer | Unique team identifier. |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_wins | integer | Team wins. |
| team_losses | integer | Team losses. |
| period1_score | integer | Period1 score. |
| period2_score | integer | Period2 score. |
| period3_score | integer | Period3 score. |
| period4_score | integer | Period4 score. |
| score | integer | Final score. |

**InactivePlayers**

|             |           |                                          |
|-------------|-----------|------------------------------------------|
| col_name    | types     | description                              |
| game_id     | character | Unique game identifier.                  |
| team_id     | integer   | Unique team identifier.                  |
| person_id   | integer   | Unique player identifier (V3 endpoints). |
| first_name  | character | Player's first name.                     |
| family_name | character | Player's family / last name.             |
| jersey_num  | character | Jersey number worn by the player.        |

**LastFiveMeetings**

|  |  |  |
|----|----|----|
| col_name | types | description |
| recency_order | integer | Recency order. |
| game_id | character | Unique game identifier. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_et | character | Game et. |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_city | character | Away team city / location. |
| away_team_name | character | Away team name. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_score | integer | Away team's score. |
| away_team_wins | integer | Away team's team wins. |
| away_team_losses | integer | Away team's team losses. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_city | character | Home team city / location. |
| home_team_name | character | Home team name. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_score | integer | Home team's score. |
| home_team_wins | integer | Home team's team wins. |
| home_team_losses | integer | Home team's team losses. |

**OtherStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| team_id | integer | Unique team identifier. |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| points | integer | Points scored. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| points_in_the_paint | integer | Points in the paint. |
| points_second_chance | integer | Second-chance points scored. |
| points_fast_break | integer | Fast-break points scored. |
| biggest_lead | integer | Biggest lead. |
| lead_changes | integer | Lead changes. |
| times_tied | integer | Times tied. |
| biggest_scoring_run | integer | Biggest scoring run. |
| turnovers_team | integer | Turnovers team. |
| turnovers_total | integer | Turnovers total. |
| rebounds_team | integer | Rebounds team. |
| points_from_turnovers | integer | Points from turnovers. |
| bench_points | integer | Points scored by the bench. |

**AvailableVideo**

|                      |           |                         |
|----------------------|-----------|-------------------------|
| col_name             | types     | description             |
| game_id              | character | Unique game identifier. |
| video_available_flag | integer   | Video available flag.   |
| pt_available         | integer   | Pt available.           |
| pt_xyz_available     | integer   | Pt xyz available.       |
| wh_status            | integer   | Wh status.              |
| hustle_status        | integer   | Hustle status.          |
| historical_status    | integer   | Historical status.      |

## Details

     nba_boxscoretraditionalv3(game_id = "0022200021")

     nba_boxscoreadvancedv3(game_id = "0022200021")

     nba_boxscoremiscv3(game_id = "0022200021")

     nba_boxscorescoringv3(game_id = "0022200021")

     nba_boxscoreusagev3(game_id = "0022200021")

     nba_boxscorefourfactorsv3(game_id = "0022200021")

     nba_boxscoreplayertrackv3(game_id = "0022200021")

     nba_boxscorematchupsv3(game_id = "0022200021")

     nba_boxscorehustlev2(game_id = "0022200021")

     nba_boxscoredefensivev2(game_id = "0022200021")

     nba_gamerotation(game_id = "0022200021")

     nba_boxscoresummaryv3(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Lineup Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

## Author

Saiem Gilani
