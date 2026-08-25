# **Get NBA Stats API All-time Leaders Grid**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use `nba_leagueleaders()`
instead. Note: `stat_category = "Defense"` was never supported upstream
by this endpoint even before deprecation (#51).

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use `nba_leagueleaders()`
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use `nba_leagueleaders()`
instead.

## Usage

``` r
nba_alltimeleadersgrids(
  league_id = "00",
  per_mode = "PerGame",
  season_type = "Regular Season",
  top_x = 10,
  ...
)

nba_assistleaders(
  league_id = "00",
  per_mode = "PerGame",
  player_or_team = "Team",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_assisttracker(
  league_id = "00",
  per_mode = "PerGame",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_homepageleaders(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat_category = "Points",
  ...
)

nba_homepagev2(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat_type = "Traditional",
  ...
)

nba_leaderstiles(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat = "PTS",
  ...
)

nba_defensehub(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)

nba_leagueleaders(
  active_flag = "",
  league_id = "00",
  per_mode = "Totals",
  scope = "S",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat_category = "PTS",
  ...
)

nba_dunkscoreleaders(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  player_id = "",
  team_id = "",
  game_id = "",
  ...
)

nba_gravityleaders(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Per Mode - PerGame, Totals

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- top_x:

  Top X

- ...:

  Additional arguments passed to an underlying function like httr.

- player_or_team:

  Player or Team

- season:

  Season - format 2020-21

- game_scope:

  Game Scope - Season, Last 10, ,Yesterday, Finals

- player_scope:

  Player Scope - All Players, Rookies

- stat_category:

  Stat Category: Points, Rebounds, Assists, Defense, Clutch, Playmaking,
  Efficiency, Fast Break, Scoring Breakdown

- stat_type:

  Stat Type - Traditional, Advanced, Tracking

- stat:

  Stat - PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK

- active_flag:

  Active Flag

- scope:

  Scope - RS, S, Rookies

- player_id:

  Player ID filter (optional, leave empty for all players)

- team_id:

  Team ID filter (optional, leave empty for all teams)

- game_id:

  Game ID filter (optional, leave empty for all games)

## Value

Returns a named list of data frames: ASTLeaders, BLKLeaders,
DREBLeaders, FG3ALeaders, FG3MLeaders, FG3_PCTLeaders, FGALeaders,
FGMLeaders, FG_PCTLeaders, FTALeaders, FTMLeaders, FT_PCTLeaders,
GPLeaders, OREBLeaders, PFLeaders, PTSLeaders, REBLeaders, STLLeaders,
TOVLeaders

**GPLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| GP             | character | Games played.             |
| GP_RANK        | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**PTSLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| PTS            | character | Points scored.            |
| PTS_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**ASTLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| AST            | character | Assists.                  |
| AST_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**STLLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| STL            | character | Steals.                   |
| STL_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**OREBLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| OREB           | character | Offensive rebounds.       |
| OREB_RANK      | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**DREBLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| DREB           | character | Defensive rebounds.       |
| DREB_RANK      | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**REBLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| REB            | character | Total rebounds.           |
| REB_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**BLKLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| BLK            | character | Blocks.                   |
| BLK_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FGMLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| FGM            | character | Field goals made.         |
| FGM_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FGALeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| FGA            | character | Field goal attempts.      |
| FGA_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FG_PCTLeaders**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| PLAYER_ID      | character | Unique player identifier.    |
| PLAYER_NAME    | character | Player name.                 |
| FG_PCT         | character | Field goal percentage (0-1). |
| FG_PCT_RANK    | character |                              |
| IS_ACTIVE_FLAG | character |                              |

**TOVLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| TOV            | character | Turnovers.                |
| TOV_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FG3MLeaders**

|                |           |                               |
|----------------|-----------|-------------------------------|
| col_name       | types     | description                   |
| PLAYER_ID      | character | Unique player identifier.     |
| PLAYER_NAME    | character | Player name.                  |
| FG3M           | character | Three-point field goals made. |
| FG3M_RANK      | character |                               |
| IS_ACTIVE_FLAG | character |                               |

**FG3ALeaders**

|                |           |                                  |
|----------------|-----------|----------------------------------|
| col_name       | types     | description                      |
| PLAYER_ID      | character | Unique player identifier.        |
| PLAYER_NAME    | character | Player name.                     |
| FG3A           | character | Three-point field goal attempts. |
| FG3A_RANK      | character |                                  |
| IS_ACTIVE_FLAG | character |                                  |

**FG3_PCTLeaders**

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| PLAYER_ID      | character | Unique player identifier.                |
| PLAYER_NAME    | character | Player name.                             |
| FG3_PCT        | character | Three-point field goal percentage (0-1). |
| FG3_PCT_RANK   | character |                                          |
| IS_ACTIVE_FLAG | character |                                          |

**PFLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| PF             | character | Personal fouls.           |
| PF_RANK        | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FTMLeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| FTM            | character | Free throws made.         |
| FTM_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FTALeaders**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| PLAYER_ID      | character | Unique player identifier. |
| PLAYER_NAME    | character | Player name.              |
| FTA            | character | Free throw attempts.      |
| FTA_RANK       | character |                           |
| IS_ACTIVE_FLAG | character |                           |

**FT_PCTLeaders**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| PLAYER_ID      | character | Unique player identifier.    |
| PLAYER_NAME    | character | Player name.                 |
| FT_PCT         | character | Free throw percentage (0-1). |
| FT_PCT_RANK    | character |                              |
| IS_ACTIVE_FLAG | character |                              |

Returns a named list of data frames: AssistLeaders

**AssistLeaders**

Columns as documented in the shared
[nba_assistleaders_assistleaders_schema](https://hoopR.sportsdataverse.org/reference/nba_assistleaders_assistleaders_schema.md)
table.

Returns a named list of data frames: AssistTracker

Returns a named list of data frames: HomePageLeaders, LeagueAverage,
LeagueMax

**HomePageLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| PTS | character | Points scored. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FT_PCT | character | Free throw percentage (0-1). |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| TS_PCT | character | True shooting percentage (0-1). |
| PTS_PER48 | character |  |

**LeagueAverage**

|           |         |                                          |
|-----------|---------|------------------------------------------|
| col_name  | types   | description                              |
| PTS       | numeric | Points scored.                           |
| FG_PCT    | numeric | Field goal percentage (0-1).             |
| FG3_PCT   | numeric | Three-point field goal percentage (0-1). |
| FT_PCT    | numeric | Free throw percentage (0-1).             |
| EFG_PCT   | numeric | Effective field goal percentage (0-1).   |
| TS_PCT    | numeric | True shooting percentage (0-1).          |
| PTS_PER48 | numeric |                                          |

**LeagueMax**

Same columns as the **LeagueAverage** table above.

Returns a named list of data frames: HomePageStat1, HomePageStat2,
HomePageStat3, HomePageStat4, HomePageStat5, HomePageStat6,
HomePageStat7, HomePageStat8

**HomePageStat1**

Columns as documented in the shared
[nba_homepagev2_homepagestat1_schema](https://hoopR.sportsdataverse.org/reference/nba_homepagev2_homepagestat1_schema.md)
table.

**HomePageStat2**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| REB | character | Total rebounds. |

**HomePageStat3**

Columns as documented in the shared
[nba_assistleaders_assistleaders_schema](https://hoopR.sportsdataverse.org/reference/nba_assistleaders_assistleaders_schema.md)
table.

**HomePageStat4**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| STL | character | Steals. |

**HomePageStat5**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FG_PCT | character | Field goal percentage (0-1). |

**HomePageStat6**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FT_PCT | character | Free throw percentage (0-1). |

**HomePageStat7**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FG3_PCT | character | Three-point field goal percentage (0-1). |

**HomePageStat8**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| BLK | character | Blocks. |

Returns a named list of data frames: AllTimeSeasonHigh, LastSeasonHigh,
LeadersTiles, LowSeasonHigh,

**LeadersTiles**

Columns as documented in the shared
[nba_homepagev2_homepagestat1_schema](https://hoopR.sportsdataverse.org/reference/nba_homepagev2_homepagestat1_schema.md)
table.

**AllTimeSeasonHigh**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| SEASON_YEAR | character | Season year string ('YYYY-YY' format). |
| PTS | character | Points scored. |

**LastSeasonHigh**

Columns as documented in the shared
[nba_homepagev2_homepagestat1_schema](https://hoopR.sportsdataverse.org/reference/nba_homepagev2_homepagestat1_schema.md)
table.

**LowSeasonHigh**

Same columns as the **AllTimeSeasonHigh** table above.

Returns a named list of data frames: DefenseHubStat1, DefenseHubStat10,
DefenseHubStat2, DefenseHubStat3, DefenseHubStat4, DefenseHubStat5,
DefenseHubStat6, DefenseHubStat7, DefenseHubStat8, DefenseHubStat9

Returns a named list of data frames: LeagueLeaders

**LeagueLeaders**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| RANK      | character | Rank.                                    |
| PLAYER    | character | Player.                                  |
| TEAM_ID   | character | Unique team identifier.                  |
| TEAM      | character | Team-side label or team identifier.      |
| GP        | character | Games played.                            |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |
| EFF       | character | Eff.                                     |
| AST_TOV   | character |                                          |
| STL_TOV   | character |                                          |

Returns a named list of data frames: DunkScoreLeaders

**DunkScoreLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_date | character | Game date (YYYY-MM-DD). |
| matchup | character | Matchup. |
| period | character | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock_time | character | Time / clock value. |
| event_num | character | Sequential event number within the game (V2 PBP). |
| player_id | character | Unique player identifier. |
| player_name | character | Player name. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| team_id | character | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| dunk_score | character | Dunk score. |
| jump_subscore | character | Jump subscore. |
| power_subscore | character | Power subscore. |
| style_subscore | character | Style subscore. |
| defensive_contest_subscore | character | Defensive contest subscore. |
| max_ball_height | character | Max ball height. |
| ball_speed_through_rim | character | Ball speed through rim. |
| player_vertical | character | Player vertical. |
| hang_time | character | Time / clock value. |
| takeoff_distance | character | Takeoff distance. |
| reverse_dunk | character | Reverse dunk. |
| dunk360 | character | Dunk360. |
| through_the_legs | character | Through the legs. |
| alley_oop | character | Alley oop. |
| tip_in | character | Tip in. |
| self_oop | character | Self oop. |
| player_rotation | character | Player rotation. |
| player_lateral_speed | character | Player lateral speed. |
| ball_distance_traveled | character | Ball distance traveled. |
| ball_reach_back | character | Ball reach back. |
| total_ball_acceleration | character | Total ball acceleration. |
| dunking_hand | character | Dunking hand. |
| jumping_foot | character | Jumping foot. |
| pass_length | character | Pass length. |
| catching_hand | character | Catching hand. |
| catch_distance | character | Catch distance. |
| lateral_catch_distance | character | Lateral catch distance. |
| passer_id | character | Unique identifier for passer. |
| passer_name | character | Passer name. |
| passer_first_name | character | Passer first name. |
| passer_last_name | character | Passer last name. |
| pass_release_point | character | Pass release point. |
| shooter_id | character | Unique identifier for shooter. |
| shooter_name | character | Shooter name (for shot events). |
| shooter_first_name | character | Shooter first name. |
| shooter_last_name | character | Shooter last name. |
| shot_release_point | character | Shot release point. |
| shot_length | character | Shot length. |
| defensive_contest_level | character | Defensive contest level. |
| possible_attempted_charge | character | Possible attempted charge. |
| video_available | character | Video available. |

Returns a named list of data frames: GravityLeaders

**GravityLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| playerid | character | Playerid. |
| firstname | character | Firstname. |
| lastname | character | Lastname. |
| teamid | character | Teamid. |
| teamabbreviation | character | Teamabbreviation. |
| teamname | character | Teamname. |
| teamcity | character | Teamcity. |
| frames | character | Frames. |
| gravityscore | character | Gravityscore. |
| avggravityscore | character | Avggravityscore. |
| onballperimeterframes | character | Onballperimeterframes. |
| onballperimetergravityscore | character | Onballperimetergravityscore. |
| avgonballperimetergravityscore | character | Avgonballperimetergravityscore. |
| offballperimeterframes | character | Offballperimeterframes. |
| offballperimetergravityscore | character | Offballperimetergravityscore. |
| avgoffballperimetergravityscore | character | Avgoffballperimetergravityscore. |
| onballinteriorframes | character | Onballinteriorframes. |
| onballinteriorgravityscore | character | Onballinteriorgravityscore. |
| avgonballinteriorgravityscore | character | Avgonballinteriorgravityscore. |
| offballinteriorframes | character | Offballinteriorframes. |
| offballinteriorgravityscore | character | Offballinteriorgravityscore. |
| avgoffballinteriorgravityscore | character | Avgoffballinteriorgravityscore. |
| gamesplayed | character | Gamesplayed. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| pts | character | Points scored. |
| reb | character | Total rebounds. |
| ast | character | Assists. |

## Details

     nba_alltimeleadersgrids(league_id = '00')

     nba_assistleaders(league_id = '00', player_or_team = "Player")
     nba_assistleaders(league_id = '00', player_or_team = "Team")

      nba_assisttracker(league_id = '00')

     nba_homepageleaders(league_id = '00', player_or_team = "Player")
     nba_homepageleaders(league_id = '00', player_or_team = "Team")

     nba_homepagev2(league_id = '00', player_or_team = "Player")
     nba_homepagev2(league_id = '00', player_or_team = "Team")

     nba_leaderstiles(league_id = '00', player_or_team = "Player")
     nba_leaderstiles(league_id = '00', player_or_team = "Team")

(Possibly Deprecated)

     nba_defensehub(league_id = '00', player_or_team = "Player")
     nba_defensehub(league_id = '00', player_or_team = "Team")

[League Leaders](https://www.nba.com/stats/leaders)

     nba_leagueleaders(league_id = '00')

     nba_dunkscoreleaders(season = year_to_season(most_recent_nba_season() - 1))

     nba_gravityleaders(season = year_to_season(most_recent_nba_season() - 1))

## Author

Saiem Gilani
