# **Get NBA Stats API Boxscore Usage V3**

**Get NBA Stats API Boxscore Usage V3**

**Get NBA Stats API Boxscore Usage V3**

## Usage

``` r
nba_boxscoreusagev3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)
```

## Arguments

- game_id:

  Game ID

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

## Value

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

## Details

     nba_boxscoreusagev3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)

## Author

Saiem Gilani
