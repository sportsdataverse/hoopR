# **Get NBA Stats API Scoreboard V2**

Restored in `hoopR` 3.1.0 – a residential-IP live re-probe (2026-08-24)
confirmed this endpoint still serves real rows for NBA. For real-time
scores, prefer
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)
instead (see \#129).

## Usage

``` r
nba_scoreboardv2(
  league_id = "00",
  game_date = "2021-07-20",
  day_offset = 0,
  ...
)
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
GameHeader, LastMeeting, LineScore, SeriesStandings, TeamLeaders,
TicketLinks, WestConfStandingsByDay, WinProbability

**GameHeader**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_DATE_EST | character | Game date est. |
| GAME_SEQUENCE | character | Game sequence. |
| GAME_ID | character | Unique game identifier. |
| GAME_STATUS_ID | character | Numeric game status identifier. |
| GAME_STATUS_TEXT | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| GAMECODE | character |  |
| HOME_TEAM_ID | character | Unique identifier for the home team. |
| VISITOR_TEAM_ID | character |  |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| LIVE_PERIOD | character |  |
| LIVE_PC_TIME | character |  |
| NATL_TV_BROADCASTER_ABBREVIATION | character |  |
| HOME_TV_BROADCASTER_ABBREVIATION | character |  |
| AWAY_TV_BROADCASTER_ABBREVIATION | character |  |
| LIVE_PERIOD_TIME_BCAST | character |  |
| ARENA_NAME | character | Arena name. |
| WH_STATUS | character | Wh status. |
| WNBA_COMMISSIONER_FLAG | character |  |

**LineScore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_DATE_EST | character | Game date est. |
| GAME_SEQUENCE | character | Game sequence. |
| GAME_ID | character | Unique game identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CITY_NAME | character |  |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_WINS_LOSSES | character |  |
| PTS_QTR1 | character |  |
| PTS_QTR2 | character |  |
| PTS_QTR3 | character |  |
| PTS_QTR4 | character |  |
| PTS_OT1 | character |  |
| PTS_OT2 | character |  |
| PTS_OT3 | character |  |
| PTS_OT4 | character |  |
| PTS_OT5 | character |  |
| PTS_OT6 | character |  |
| PTS_OT7 | character |  |
| PTS_OT8 | character |  |
| PTS_OT9 | character |  |
| PTS_OT10 | character |  |
| PTS | character | Points scored. |
| FG_PCT | character | Field goal percentage (0-1). |
| FT_PCT | character | Free throw percentage (0-1). |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| AST | character | Assists. |
| REB | character | Total rebounds. |
| TOV | character | Turnovers. |

**SeriesStandings**

|                  |           |                                      |
|------------------|-----------|--------------------------------------|
| col_name         | types     | description                          |
| GAME_ID          | character | Unique game identifier.              |
| HOME_TEAM_ID     | character | Unique identifier for the home team. |
| VISITOR_TEAM_ID  | character |                                      |
| GAME_DATE_EST    | character | Game date est.                       |
| HOME_TEAM_WINS   | character | Home team's team wins.               |
| HOME_TEAM_LOSSES | character | Home team's team losses.             |
| SERIES_LEADER    | character |                                      |

**LastMeeting**

|                                  |           |                         |
|----------------------------------|-----------|-------------------------|
| col_name                         | types     | description             |
| GAME_ID                          | character | Unique game identifier. |
| LAST_GAME_ID                     | character |                         |
| LAST_GAME_DATE_EST               | character |                         |
| LAST_GAME_HOME_TEAM_ID           | character |                         |
| LAST_GAME_HOME_TEAM_CITY         | character |                         |
| LAST_GAME_HOME_TEAM_NAME         | character |                         |
| LAST_GAME_HOME_TEAM_ABBREVIATION | character |                         |
| LAST_GAME_HOME_TEAM_POINTS       | character |                         |
| LAST_GAME_VISITOR_TEAM_ID        | character |                         |
| LAST_GAME_VISITOR_TEAM_CITY      | character |                         |
| LAST_GAME_VISITOR_TEAM_NAME      | character |                         |
| LAST_GAME_VISITOR_TEAM_CITY1     | character |                         |
| LAST_GAME_VISITOR_TEAM_POINTS    | character |                         |

**EastConfStandingsByDay**

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| TEAM_ID       | character | Unique team identifier.             |
| LEAGUE_ID     | character | League identifier ('10' = WNBA).    |
| SEASON_ID     | character | Unique season identifier.           |
| STANDINGSDATE | character |                                     |
| CONFERENCE    | character | Conference.                         |
| TEAM          | character | Team-side label or team identifier. |
| G             | character | Games played.                       |
| W             | character | Wins.                               |
| L             | character | Losses.                             |
| W_PCT         | character |                                     |
| HOME_RECORD   | character | Home win-loss record.               |
| ROAD_RECORD   | character |                                     |

**WestConfStandingsByDay**

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| TEAM_ID       | character | Unique team identifier.             |
| LEAGUE_ID     | character | League identifier ('10' = WNBA).    |
| SEASON_ID     | character | Unique season identifier.           |
| STANDINGSDATE | character |                                     |
| CONFERENCE    | character | Conference.                         |
| TEAM          | character | Team-side label or team identifier. |
| G             | character | Games played.                       |
| W             | character | Wins.                               |
| L             | character | Losses.                             |
| W_PCT         | character |                                     |
| HOME_RECORD   | character | Home win-loss record.               |
| ROAD_RECORD   | character |                                     |

**Available**

|              |           |                         |
|--------------|-----------|-------------------------|
| col_name     | types     | description             |
| GAME_ID      | character | Unique game identifier. |
| PT_AVAILABLE | character | Pt available.           |

**TeamLeaders**

|                   |           |                                         |
|-------------------|-----------|-----------------------------------------|
| col_name          | types     | description                             |
| GAME_ID           | character | Unique game identifier.                 |
| TEAM_ID           | character | Unique team identifier.                 |
| TEAM_CITY         | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NICKNAME     | character | Team nickname.                          |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').   |
| PTS_PLAYER_ID     | character |                                         |
| PTS_PLAYER_NAME   | character |                                         |
| PTS               | character | Points scored.                          |
| REB_PLAYER_ID     | character |                                         |
| REB_PLAYER_NAME   | character |                                         |
| REB               | character | Total rebounds.                         |
| AST_PLAYER_ID     | character |                                         |
| AST_PLAYER_NAME   | character |                                         |
| AST               | character | Assists.                                |

**TicketLinks**

**WinProbability**

## Details

     nba_scoreboardv2(league_id = '00', game_date = '2021-07-20')

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
