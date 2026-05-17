# **Get NBA Stats API Boxscore Scoring V3**

**Get NBA Stats API Boxscore Scoring V3**

**Get NBA Stats API Boxscore Scoring V3**

## Usage

``` r
nba_boxscorescoringv3(
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

## Details

     nba_boxscorescoringv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
