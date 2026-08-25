# **Get NBA Stats API Boxscore Traditional V2**

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

## Usage

``` r
nba_boxscoretraditionalv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoreadvancedv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoredefensive(game_id, ...)

nba_boxscorefourfactorsv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoremiscv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscorescoringv2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoreusagev2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)

nba_boxscoresummaryv2(game_id, ...)

nba_boxscorematchups(game_id, ...)

nba_boxscoreplayertrackv2(game_id, ...)

nba_hustlestatsboxscore(game_id, ...)

nba_boxscoresimilarityscore(
  person_1_id = "202691",
  person_1_league_id = "00",
  person_1_season = most_recent_nba_season() - 3,
  person_1_season_type = "Regular Season",
  person_2_id = "1626164",
  person_2_league_id = "00",
  person_2_season = most_recent_nba_season() - 3,
  person_2_season_type = "Regular Season",
  ...
)

nba_glalumboxscoresimilarityscore(
  person_1_id,
  person_1_league_id,
  person_1_season,
  person_1_season_type,
  person_2_id,
  person_2_league_id,
  person_2_season,
  person_2_season_type,
  ...
)
```

## Arguments

- game_id:

  Game ID

- start_period:

  start_period

- end_period:

  end_period

- start_range:

  start_range

- end_range:

  end_range

- range_type:

  range_type

- ...:

  Additional arguments passed to an underlying function like httr.

- person_1_id:

  person_1_id

- person_1_league_id:

  person_1_league_id

- person_1_season:

  person_1_season

- person_1_season_type:

  person_1_season_type

- person_2_id:

  person_2_id

- person_2_league_id:

  person_2_league_id

- person_2_season:

  person_2_season

- person_2_season_type:

  person_2_season_type

## Value

A list of data frames: PlayerStats, TeamStats, TeamStarterBenchStats

**PlayerStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| TO | character | To. |
| PF | character | Personal fouls. |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |

**TeamStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| TO | character | To. |
| PF | character | Personal fouls. |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |

**TeamStarterBenchStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| STARTERS_BENCH | character |  |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| TO | character | To. |
| PF | character | Personal fouls. |
| PTS | character | Points scored. |

Returns a named list of data frames: PlayerStats, TeamStats

PlayerStats

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| E_OFF_RATING | character |  |
| OFF_RATING | character | Offensive rating (points produced per 100 possessions). |
| E_DEF_RATING | character |  |
| DEF_RATING | character | Defensive rating (points allowed per 100 possessions). |
| E_NET_RATING | character |  |
| NET_RATING | character | Net rating (off rating - def rating). |
| AST_PCT | character | Assist percentage (0-1). |
| AST_TOV | character |  |
| AST_RATIO | character | Assist ratio (assists per 100 possessions used). |
| OREB_PCT | character | Offensive rebound percentage (0-1). |
| DREB_PCT | character | Defensive rebound percentage (0-1). |
| REB_PCT | character | Total rebound percentage (0-1). |
| TM_TOV_PCT | character |  |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| TS_PCT | character | True shooting percentage (0-1). |
| USG_PCT | character | Usage percentage (0-1). |
| E_USG_PCT | character |  |
| E_PACE | character |  |
| PACE | character | Possessions per 48 minutes. |
| PACE_PER40 | character | Pace per40. |
| POSS | character | Poss. |
| PIE | character | Player Impact Estimate (0-1). |

TeamStats

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| E_OFF_RATING | character |  |
| OFF_RATING | character | Offensive rating (points produced per 100 possessions). |
| E_DEF_RATING | character |  |
| DEF_RATING | character | Defensive rating (points allowed per 100 possessions). |
| E_NET_RATING | character |  |
| NET_RATING | character | Net rating (off rating - def rating). |
| AST_PCT | character | Assist percentage (0-1). |
| AST_TOV | character |  |
| AST_RATIO | character | Assist ratio (assists per 100 possessions used). |
| OREB_PCT | character | Offensive rebound percentage (0-1). |
| DREB_PCT | character | Defensive rebound percentage (0-1). |
| REB_PCT | character | Total rebound percentage (0-1). |
| E_TM_TOV_PCT | character |  |
| TM_TOV_PCT | character |  |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| TS_PCT | character | True shooting percentage (0-1). |
| USG_PCT | character | Usage percentage (0-1). |
| E_USG_PCT | character |  |
| E_PACE | character |  |
| PACE | character | Possessions per 48 minutes. |
| PACE_PER40 | character | Pace per40. |
| POSS | character | Poss. |
| PIE | character | Player Impact Estimate (0-1). |

Returns a named list of data frames: PlayerDefensiveStats, Table1

Returns a named list of data frames: sqlPlayersFourFactors,
sqlTeamFourFactors

**sqlPlayersFourFactors**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| FTA_RATE | character | Free throw attempt rate (FTA / FGA). |
| TM_TOV_PCT | character |  |
| OREB_PCT | character | Offensive rebound percentage (0-1). |
| OPP_EFG_PCT | character |  |
| OPP_FTA_RATE | character |  |
| OPP_TOV_PCT | character |  |
| OPP_OREB_PCT | character |  |

**sqlTeamsFourFactors**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| FTA_RATE | character | Free throw attempt rate (FTA / FGA). |
| TM_TOV_PCT | character |  |
| OREB_PCT | character | Offensive rebound percentage (0-1). |
| OPP_EFG_PCT | character |  |
| OPP_FTA_RATE | character |  |
| OPP_TOV_PCT | character |  |
| OPP_OREB_PCT | character |  |

Returns a named list of data frames: sqlPlayersMisc, sqlTeamsMisc

**sqlPlayersMisc**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| PTS_OFF_TOV | character | Points scored off opponent turnovers. |
| PTS_2ND_CHANCE | character |  |
| PTS_FB | character |  |
| PTS_PAINT | character | Points scored in the paint. |
| OPP_PTS_OFF_TOV | character |  |
| OPP_PTS_2ND_CHANCE | character |  |
| OPP_PTS_FB | character |  |
| OPP_PTS_PAINT | character |  |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |

**sqlTeamsMisc**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| PTS_OFF_TOV | character | Points scored off opponent turnovers. |
| PTS_2ND_CHANCE | character |  |
| PTS_FB | character |  |
| PTS_PAINT | character | Points scored in the paint. |
| OPP_PTS_OFF_TOV | character |  |
| OPP_PTS_2ND_CHANCE | character |  |
| OPP_PTS_FB | character |  |
| OPP_PTS_PAINT | character |  |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |

Returns a named list of data frames: sqlPlayersScoring, sqlTeamsScoring

**sqlPlayersScoring**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| PCT_FGA_2PT | character |  |
| PCT_FGA_3PT | character |  |
| PCT_PTS_2PT | character |  |
| PCT_PTS_2PT_MR | character |  |
| PCT_PTS_3PT | character |  |
| PCT_PTS_FB | character |  |
| PCT_PTS_FT | character |  |
| PCT_PTS_OFF_TOV | character |  |
| PCT_PTS_PAINT | character |  |
| PCT_AST_2PM | character |  |
| PCT_UAST_2PM | character |  |
| PCT_AST_3PM | character |  |
| PCT_UAST_3PM | character |  |
| PCT_AST_FGM | character |  |
| PCT_UAST_FGM | character |  |

**sqlTeamsScoring**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| PCT_FGA_2PT | character |  |
| PCT_FGA_3PT | character |  |
| PCT_PTS_2PT | character |  |
| PCT_PTS_2PT_MR | character |  |
| PCT_PTS_3PT | character |  |
| PCT_PTS_FB | character |  |
| PCT_PTS_FT | character |  |
| PCT_PTS_OFF_TOV | character |  |
| PCT_PTS_PAINT | character |  |
| PCT_AST_2PM | character |  |
| PCT_UAST_2PM | character |  |
| PCT_AST_3PM | character |  |
| PCT_UAST_3PM | character |  |
| PCT_AST_FGM | character |  |
| PCT_UAST_FGM | character |  |

Returns a named list of data frames: sqlPlayersUsage, sqlTeamsUsage

**sqlPlayersUsage**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| NICKNAME | character | Team or athlete nickname. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| USG_PCT | character | Usage percentage (0-1). |
| PCT_FGM | character |  |
| PCT_FGA | character |  |
| PCT_FG3M | character |  |
| PCT_FG3A | character |  |
| PCT_FTM | character |  |
| PCT_FTA | character |  |
| PCT_OREB | character |  |
| PCT_DREB | character |  |
| PCT_REB | character |  |
| PCT_AST | character |  |
| PCT_TOV | character |  |
| PCT_STL | character |  |
| PCT_BLK | character |  |
| PCT_BLKA | character |  |
| PCT_PF | character |  |
| PCT_PFD | character |  |
| PCT_PTS | character |  |

**sqlTeamsUsage**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| USG_PCT | character | Usage percentage (0-1). |
| PCT_FGM | character |  |
| PCT_FGA | character |  |
| PCT_FG3M | character |  |
| PCT_FG3A | character |  |
| PCT_FTM | character |  |
| PCT_FTA | character |  |
| PCT_OREB | character |  |
| PCT_DREB | character |  |
| PCT_REB | character |  |
| PCT_AST | character |  |
| PCT_TOV | character |  |
| PCT_STL | character |  |
| PCT_BLK | character |  |
| PCT_BLKA | character |  |
| PCT_PF | character |  |
| PCT_PFD | character |  |
| PCT_PTS | character |  |

Returns a named list of data frames: AvailableVideo, GameInfo,
GameSummary, InactivePlayers, LastMeeting, LineScore, Officials,
OtherStats, SeasonSeries

**GameSummary**

Columns as documented in the shared
[nba_boxscoresummaryv2_gamesummary_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_gamesummary_schema.md)
table.

**OtherStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| LEAGUE_ID | character | League identifier ('10' = WNBA). |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PTS_PAINT | character | Points scored in the paint. |
| PTS_2ND_CHANCE | character |  |
| PTS_FB | character |  |
| LARGEST_LEAD | character | Largest lead during the game. |
| LEAD_CHANGES | character | Lead changes. |
| TIMES_TIED | character | Times tied. |
| TEAM_TURNOVERS | character | Team turnovers (turnovers credited to the team rather than a player). |
| TOTAL_TURNOVERS | character | Total turnovers (player + team). |
| TEAM_REBOUNDS | character | Team rebounds (rebounds credited to the team rather than a player). |
| PTS_OFF_TO | character |  |

**Officials**

|             |           |                                       |
|-------------|-----------|---------------------------------------|
| col_name    | types     | description                           |
| OFFICIAL_ID | character | Unique official / referee identifier. |
| FIRST_NAME  | character | Player's first name.                  |
| LAST_NAME   | character | Player's last name.                   |
| JERSEY_NUM  | character | Jersey number worn by the player.     |

**InactivePlayers**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PLAYER_ID | character | Unique player identifier. |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| JERSEY_NUM | character | Jersey number worn by the player. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |

**GameInfo**

|            |           |                         |
|------------|-----------|-------------------------|
| col_name   | types     | description             |
| GAME_DATE  | character | Game date (YYYY-MM-DD). |
| ATTENDANCE | character | Reported attendance.    |
| GAME_TIME  | character | Game start time.        |

**LineScore**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| GAME_DATE_EST     | character | Game date est.                        |
| GAME_SEQUENCE     | character | Game sequence.                        |
| GAME_ID           | character | Unique game identifier.               |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY_NAME    | character |                                       |
| TEAM_NICKNAME     | character | Team nickname.                        |
| TEAM_WINS_LOSSES  | character |                                       |
| PTS_QTR1          | character |                                       |
| PTS_QTR2          | character |                                       |
| PTS_QTR3          | character |                                       |
| PTS_QTR4          | character |                                       |
| PTS_OT1           | character |                                       |
| PTS_OT2           | character |                                       |
| PTS_OT3           | character |                                       |
| PTS_OT4           | character |                                       |
| PTS_OT5           | character |                                       |
| PTS_OT6           | character |                                       |
| PTS_OT7           | character |                                       |
| PTS_OT8           | character |                                       |
| PTS_OT9           | character |                                       |
| PTS_OT10          | character |                                       |
| PTS               | character | Points scored.                        |

**LastMeeting**

Columns as documented in the shared
[nba_boxscoresummaryv2_lastmeeting_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_lastmeeting_schema.md)
table.

**SeasonSeries**

Columns as documented in the shared
[nba_boxscoresummaryv2_seasonseries_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_seasonseries_schema.md)
table.

**AvailableVideo**

|                      |           |                         |
|----------------------|-----------|-------------------------|
| col_name             | types     | description             |
| GAME_ID              | character | Unique game identifier. |
| VIDEO_AVAILABLE_FLAG | character | Video available flag.   |
| PT_AVAILABLE         | character | Pt available.           |
| PT_XYZ_AVAILABLE     | character | Pt xyz available.       |
| WH_STATUS            | character | Wh status.              |
| HUSTLE_STATUS        | character | Hustle status.          |
| HISTORICAL_STATUS    | character | Historical status.      |

Returns a named list of data frames: PlayerMatchupsStats

Returns a named list of data frames: PlayerStats, TeamStats

**PlayerStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MIN | character | Minutes played. |
| SPD | character |  |
| DIST | character |  |
| ORBC | character |  |
| DRBC | character |  |
| RBC | character |  |
| TCHS | character |  |
| SAST | character |  |
| FTAST | character |  |
| PASS | character |  |
| AST | character | Assists. |
| CFGM | character |  |
| CFGA | character |  |
| CFG_PCT | character |  |
| UFGM | character |  |
| UFGA | character |  |
| UFG_PCT | character |  |
| FG_PCT | character | Field goal percentage (0-1). |
| DFGM | character |  |
| DFGA | character |  |
| DFG_PCT | character |  |

**TeamStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MIN | character | Minutes played. |
| DIST | character |  |
| ORBC | character |  |
| DRBC | character |  |
| RBC | character |  |
| TCHS | character |  |
| SAST | character |  |
| FTAST | character |  |
| PASS | character |  |
| AST | character | Assists. |
| CFGM | character |  |
| CFGA | character |  |
| CFG_PCT | character |  |
| UFGM | character |  |
| UFGA | character |  |
| UFG_PCT | character |  |
| FG_PCT | character | Field goal percentage (0-1). |
| DFGM | character |  |
| DFGA | character |  |
| DFG_PCT | character |  |

Returns a named list of data frames: HustleStatsAvailable, PlayerStats,
TeamStats

**HustleStatsAvailable**

|  |  |  |
|----|----|----|
| col_name | types | description |
| LEAGUE_ID | character | League identifier ('10' = WNBA). |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PTS_PAINT | character | Points scored in the paint. |
| PTS_2ND_CHANCE | character |  |
| PTS_FB | character |  |
| LARGEST_LEAD | character | Largest lead during the game. |
| LEAD_CHANGES | character | Lead changes. |
| TIMES_TIED | character | Times tied. |
| TEAM_TURNOVERS | character | Team turnovers (turnovers credited to the team rather than a player). |
| TOTAL_TURNOVERS | character | Total turnovers (player + team). |
| TEAM_REBOUNDS | character | Team rebounds (rebounds credited to the team rather than a player). |
| PTS_OFF_TO | character |  |

**PlayerStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| START_POSITION | character |  |
| COMMENT | character | Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
| MINUTES | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| PTS | character | Points scored. |
| CONTESTED_SHOTS | character | Defensively contested shots. |
| CONTESTED_SHOTS_2PT | character | Contested two-point shots. |
| CONTESTED_SHOTS_3PT | character | Contested three-point shots. |
| DEFLECTIONS | character | Defensive deflections. |
| CHARGES_DRAWN | character | Charges drawn. |
| SCREEN_ASSISTS | character | Screen assists (resulting in a basket). |
| SCREEN_AST_PTS | character |  |
| OFF_LOOSE_BALLS_RECOVERED | character |  |
| DEF_LOOSE_BALLS_RECOVERED | character |  |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered. |
| OFF_BOXOUTS | character |  |
| DEF_BOXOUTS | character |  |
| BOX_OUT_PLAYER_TEAM_REBS | character |  |
| BOX_OUT_PLAYER_REBS | character |  |
| BOX_OUTS | character | Box-outs executed. |

**TeamStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| MINUTES | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| PTS | character | Points scored. |
| CONTESTED_SHOTS | character | Defensively contested shots. |
| CONTESTED_SHOTS_2PT | character | Contested two-point shots. |
| CONTESTED_SHOTS_3PT | character | Contested three-point shots. |
| DEFLECTIONS | character | Defensive deflections. |
| CHARGES_DRAWN | character | Charges drawn. |
| SCREEN_ASSISTS | character | Screen assists (resulting in a basket). |
| SCREEN_AST_PTS | character |  |
| OFF_LOOSE_BALLS_RECOVERED | character |  |
| DEF_LOOSE_BALLS_RECOVERED | character |  |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered. |
| OFF_BOXOUTS | character |  |
| DEF_BOXOUTS | character |  |
| BOX_OUT_PLAYER_TEAM_REBS | character |  |
| BOX_OUT_PLAYER_REBS | character |  |
| BOX_OUTS | character | Box-outs executed. |

Returns a named list of data frames: BoxScoreSimilarityScores

Returns a named list of data frames: GLeagueAlumBoxScoreSimilarityScores

## Details

     nba_boxscoretraditionalv2(game_id = "0022200021")

League-scoped: as of a 2026-08-24 residential-IP probe sweep this V2
endpoint returns HTTP 200 with zero rows for NBA (LeagueID '00') game
IDs – use
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
for NBA instead. It still serves real rows for WNBA (LeagueID '10') and
G-League (LeagueID '20') game IDs, so the wrapper stays exported/active
rather than deprecated.

     nba_boxscoreadvancedv2(game_id = "0022200021")

(Possibly Deprecated)

     nba_boxscoredefensive(game_id = "0022200021")

     nba_boxscorefourfactorsv2(game_id = "0022200021")

     nba_boxscoremiscv2(game_id = "0022200021")

     nba_boxscorescoringv2(game_id = "0022200021")

     nba_boxscoreusagev2(game_id = "0022200021")

     nba_boxscoresummaryv2(game_id = "0022200021")

(Possibly Deprecated)

     nba_boxscorematchups(game_id = "0022200021")

     nba_boxscoreplayertrackv2(game_id = "0022200021")

     nba_hustlestatsboxscore(game_id = "0022200021")

(Possibly Deprecated)

    z <- nba_commonallplayers()$CommonAllPlayers
    klay <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Klay Thompson')
    book <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Devin Booker')
    nba_boxscoresimilarityscore(person_1_id = klay$PERSON_ID,
      person_1_league_id = '00',
      person_1_season = year_to_season(most_recent_nba_season() - 1),
      person_1_season_type = 'Regular Season',
      person_2_id = book$PERSON_ID,
      person_2_league_id = '00',
      person_2_season = year_to_season(most_recent_nba_season() - 1),
      person_2_season_type = 'Regular Season'
    )

(Possibly Deprecated)

## See also

Other NBA Boxscore Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Player Tracking Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

Other NBA Hustle Functions:
[`nba_leaguehustlestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayer.md)

## Author

Saiem Gilani
