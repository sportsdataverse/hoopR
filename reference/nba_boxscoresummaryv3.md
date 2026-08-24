# **Get NBA Stats API Boxscore Summary V3**

**Get NBA Stats API Boxscore Summary V3**

**Get NBA Stats API Boxscore Summary V3**

## Usage

``` r
nba_boxscoresummaryv3(game_id = "0022200021", ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

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

     nba_boxscoresummaryv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)

## Author

Saiem Gilani
