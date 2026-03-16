# **Get NBA Stats API Scoreboard**

**Get NBA Stats API Scoreboard**

**Get NBA Stats API Scoreboard**

## Usage

``` r
nba_scoreboard(league_id = "00", game_date = "2021-07-20", day_offset = 0, ...)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- game_date:

  Game Date

- day_offset:

  Day Offset (integer 0,-1)

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: Available, EastConfStandingsByDay,
GameHeader, LastMeeting, LineScore, SeriesStandings,
WestConfStandingsByDay

**GameHeader**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| GAME_DATE_EST                    | character |
| GAME_SEQUENCE                    | character |
| GAME_ID                          | character |
| GAME_STATUS_ID                   | character |
| GAME_STATUS_TEXT                 | character |
| GAMECODE                         | character |
| HOME_TEAM_ID                     | character |
| VISITOR_TEAM_ID                  | character |
| SEASON                           | character |
| LIVE_PERIOD                      | character |
| LIVE_PC_TIME                     | character |
| NATL_TV_BROADCASTER_ABBREVIATION | character |
| LIVE_PERIOD_TIME_BCAST           | character |
| WH_STATUS                        | character |

**LineScore**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_DATE_EST     | character |
| GAME_SEQUENCE     | character |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY_NAME    | character |
| TEAM_WINS_LOSSES  | character |
| PTS_QTR1          | character |
| PTS_QTR2          | character |
| PTS_QTR3          | character |
| PTS_QTR4          | character |
| PTS_OT1           | character |
| PTS_OT2           | character |
| PTS_OT3           | character |
| PTS_OT4           | character |
| PTS_OT5           | character |
| PTS_OT6           | character |
| PTS_OT7           | character |
| PTS_OT8           | character |
| PTS_OT9           | character |
| PTS_OT10          | character |
| PTS               | character |
| FG_PCT            | character |
| FT_PCT            | character |
| FG3_PCT           | character |
| AST               | character |
| REB               | character |
| TOV               | character |

**SeriesStandings**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| GAME_ID          | character |
| HOME_TEAM_ID     | character |
| VISITOR_TEAM_ID  | character |
| GAME_DATE_EST    | character |
| HOME_TEAM_WINS   | character |
| HOME_TEAM_LOSSES | character |
| SERIES_LEADER    | character |

**LastMeeting**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| GAME_ID                          | character |
| LAST_GAME_ID                     | character |
| LAST_GAME_DATE_EST               | character |
| LAST_GAME_HOME_TEAM_ID           | character |
| LAST_GAME_HOME_TEAM_CITY         | character |
| LAST_GAME_HOME_TEAM_NAME         | character |
| LAST_GAME_HOME_TEAM_ABBREVIATION | character |
| LAST_GAME_HOME_TEAM_POINTS       | character |
| LAST_GAME_VISITOR_TEAM_ID        | character |
| LAST_GAME_VISITOR_TEAM_CITY      | character |
| LAST_GAME_VISITOR_TEAM_NAME      | character |
| LAST_GAME_VISITOR_TEAM_CITY1     | character |
| LAST_GAME_VISITOR_TEAM_POINTS    | character |

**EastConfStandingsByDay**

|               |           |
|---------------|-----------|
| col_name      | types     |
| TEAM_ID       | character |
| LEAGUE_ID     | character |
| SEASON_ID     | character |
| STANDINGSDATE | character |
| CONFERENCE    | character |
| TEAM          | character |
| G             | character |
| W             | character |
| L             | character |
| W_PCT         | character |
| HOME_RECORD   | character |
| ROAD_RECORD   | character |

**WestConfStandingsByDay**

|               |           |
|---------------|-----------|
| col_name      | types     |
| TEAM_ID       | character |
| LEAGUE_ID     | character |
| SEASON_ID     | character |
| STANDINGSDATE | character |
| CONFERENCE    | character |
| TEAM          | character |
| G             | character |
| W             | character |
| L             | character |
| W_PCT         | character |
| HOME_RECORD   | character |
| ROAD_RECORD   | character |

**Available**

|              |           |
|--------------|-----------|
| col_name     | types     |
| GAME_ID      | character |
| PT_AVAILABLE | character |

## Details

     nba_scoreboard(league_id = '00', game_date = '2021-07-20')

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
