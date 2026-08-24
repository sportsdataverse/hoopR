# **Get NBA Stats API Boxscore Defensive**

**\[deprecated\]**

NBA Stats no longer returns stable data for this V2 endpoint. This
function is deprecated and now errors when called. Use
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
instead.

## Usage

``` r
nba_boxscoredefensive(game_id, ...)

nba_boxscoresummaryv2(game_id, ...)

nba_boxscorematchups(game_id, ...)

nba_boxscoreplayertrackv2(game_id, ...)

nba_hustlestatsboxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayerDefensiveStats, Table1

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

|               |           |                         |
|---------------|-----------|-------------------------|
| col_name      | types     | description             |
| GAME_ID       | character | Unique game identifier. |
| HUSTLE_STATUS | character | Hustle status.          |

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

## Details

(Possibly Deprecated)

     nba_boxscoredefensive(game_id = "0022200021")

     nba_boxscoresummaryv2(game_id = "0022200021")

(Possibly Deprecated)

     nba_boxscorematchups(game_id = "0022200021")

     nba_boxscoreplayertrackv2(game_id = "0022200021")

     nba_hustlestatsboxscore(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Player Tracking Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

Other NBA Hustle Functions:
[`nba_leaguehustlestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayer.md)

## Author

Saiem Gilani
