# **Get NBA Stats API Boxscore Matchups V3**

**Get NBA Stats API Boxscore Matchups V3**

**Get NBA Stats API Boxscore Matchups V3**

## Usage

``` r
nba_boxscorematchupsv3(
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

## Details

     nba_boxscorematchupsv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
