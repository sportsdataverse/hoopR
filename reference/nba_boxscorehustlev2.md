# **Get NBA Stats API Boxscore Hustle V2**

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md)
instead.

## Usage

``` r
nba_boxscorehustlev2(game_id = "0022200021", ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

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

## Details

     nba_boxscorehustlev2(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
