# **Get NBA Stats API Scoreboard**

Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md)
instead.

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

Columns as documented in the shared
[nba_boxscoresummaryv2_gamesummary_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_gamesummary_schema.md)
table.

**LineScore**

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| GAME_DATE_EST     | character | Game date est.                           |
| GAME_SEQUENCE     | character | Game sequence.                           |
| GAME_ID           | character | Unique game identifier.                  |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| TEAM_CITY_NAME    | character |                                          |
| TEAM_WINS_LOSSES  | character |                                          |
| PTS_QTR1          | character |                                          |
| PTS_QTR2          | character |                                          |
| PTS_QTR3          | character |                                          |
| PTS_QTR4          | character |                                          |
| PTS_OT1           | character |                                          |
| PTS_OT2           | character |                                          |
| PTS_OT3           | character |                                          |
| PTS_OT4           | character |                                          |
| PTS_OT5           | character |                                          |
| PTS_OT6           | character |                                          |
| PTS_OT7           | character |                                          |
| PTS_OT8           | character |                                          |
| PTS_OT9           | character |                                          |
| PTS_OT10          | character |                                          |
| PTS               | character | Points scored.                           |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FT_PCT            | character | Free throw percentage (0-1).             |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| AST               | character | Assists.                                 |
| REB               | character | Total rebounds.                          |
| TOV               | character | Turnovers.                               |

**SeriesStandings**

Columns as documented in the shared
[nba_boxscoresummaryv2_seasonseries_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_seasonseries_schema.md)
table.

**LastMeeting**

Columns as documented in the shared
[nba_boxscoresummaryv2_lastmeeting_schema](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2_lastmeeting_schema.md)
table.

**EastConfStandingsByDay**

Columns as documented in the shared
[nba_scoreboard_eastconfstandingsbyday_schema](https://hoopR.sportsdataverse.org/reference/nba_scoreboard_eastconfstandingsbyday_schema.md)
table.

**WestConfStandingsByDay**

Columns as documented in the shared
[nba_scoreboard_eastconfstandingsbyday_schema](https://hoopR.sportsdataverse.org/reference/nba_scoreboard_eastconfstandingsbyday_schema.md)
table.

**Available**

|              |           |                         |
|--------------|-----------|-------------------------|
| col_name     | types     | description             |
| GAME_ID      | character | Unique game identifier. |
| PT_AVAILABLE | character | Pt available.           |

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
