# **Get NBA Stats API Boxscore Player Tracking V3**

**Get NBA Stats API Boxscore Player Tracking V3**

**Get NBA Stats API Boxscore Player Tracking V3**

## Usage

``` r
nba_boxscoreplayertrackv3(
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

## Details

     nba_boxscoreplayertrackv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
