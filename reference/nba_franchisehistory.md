# **Get NBA Stats API Franchise Leaders**

**Get NBA Stats API Franchise Leaders**

**Get NBA Stats API Franchise Leaders**

**Get NBA Stats API Franchise Leaders with Rank**

**Get NBA Stats API Franchise Leaders with Rank**

**Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise History**

**Get NBA Stats API Franchise History**

## Usage

``` r
nba_franchiseleaders(league_id = "00", team_id = "1610612739", ...)

nba_franchiseleaderswrank(
  league_id = "00",
  per_mode = "Totals",
  season_type = "Regular Season",
  team_id = "1610612739",
  ...
)

nba_franchiseplayers(
  league_id = "00",
  per_mode = "Totals",
  season_type = "Regular Season",
  team_id = "1610612739",
  ...
)

nba_franchisehistory(league_id = "00", ...)
```

## Arguments

- league_id:

  league_id

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

- per_mode:

  per_mode

- season_type:

  season_type

## Value

Returns a named list of data frames: FranchiseLeaders

**FranchiseLeaders**

|               |           |                         |
|---------------|-----------|-------------------------|
| col_name      | types     | description             |
| TEAM_ID       | character | Unique team identifier. |
| PTS           | character | Points scored.          |
| PTS_PERSON_ID | character |                         |
| PTS_PLAYER    | character |                         |
| AST           | character | Assists.                |
| AST_PERSON_ID | character |                         |
| AST_PLAYER    | character |                         |
| REB           | character | Total rebounds.         |
| REB_PERSON_ID | character |                         |
| REB_PLAYER    | character |                         |
| BLK           | character | Blocks.                 |
| BLK_PERSON_ID | character |                         |
| BLK_PLAYER    | character |                         |
| STL           | character | Steals.                 |
| STL_PERSON_ID | character |                         |
| STL_PLAYER    | character |                         |

Returns a named list of data frames: FranchiseLeaderswRank

**FranchiseLeaderswRank**

|  |  |  |
|----|----|----|
| col_name | types | description |
| LEAGUE_ID | character | League identifier ('10' = WNBA). |
| TEAM_ID | character | Unique team identifier. |
| TEAM | character | Team-side label or team identifier. |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| PLAYER | character | Player. |
| SEASON_TYPE | character | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| ACTIVE_WITH_TEAM | character |  |
| GP | character | Games played. |
| MINUTES | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
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
| PF | character | Personal fouls. |
| STL | character | Steals. |
| TOV | character | Turnovers. |
| BLK | character | Blocks. |
| PTS | character | Points scored. |
| F_RANK_GP | character |  |
| F_RANK_MINUTES | character |  |
| F_RANK_FGM | character |  |
| F_RANK_FGA | character |  |
| F_RANK_FG_PCT | character |  |
| F_RANK_FG3M | character |  |
| F_RANK_FG3A | character |  |
| F_RANK_FG3_PCT | character |  |
| F_RANK_FTM | character |  |
| F_RANK_FTA | character |  |
| F_RANK_FT_PCT | character |  |
| F_RANK_OREB | character |  |
| F_RANK_DREB | character |  |
| F_RANK_REB | character |  |
| F_RANK_AST | character |  |
| F_RANK_PF | character |  |
| F_RANK_STL | character |  |
| F_RANK_TOV | character |  |
| F_RANK_BLK | character |  |
| F_RANK_PTS | character |  |

Returns a named list of data frames: FranchisePlayers

**FranchisePlayers**

|  |  |  |
|----|----|----|
| col_name | types | description |
| LEAGUE_ID | character | League identifier ('10' = WNBA). |
| TEAM_ID | character | Unique team identifier. |
| TEAM | character | Team-side label or team identifier. |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| PLAYER | character | Player. |
| SEASON_TYPE | character | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| ACTIVE_WITH_TEAM | character |  |
| GP | character | Games played. |
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
| PF | character | Personal fouls. |
| STL | character | Steals. |
| TOV | character | Turnovers. |
| BLK | character | Blocks. |
| PTS | character | Points scored. |

Returns a named list of data frames: DefunctTeams, FranchiseHistory

**FranchiseHistory**

|                |           |                                                 |
|----------------|-----------|-------------------------------------------------|
| col_name       | types     | description                                     |
| LEAGUE_ID      | character | League identifier ('10' = WNBA).                |
| TEAM_ID        | character | Unique team identifier.                         |
| TEAM_CITY      | character | Team city or region (e.g. 'Las Vegas').         |
| TEAM_NAME      | character | Full team display name (e.g. 'Las Vegas Aces'). |
| START_YEAR     | character |                                                 |
| END_YEAR       | character |                                                 |
| YEARS          | character | Years.                                          |
| GAMES          | character |                                                 |
| WINS           | character | Total wins.                                     |
| LOSSES         | character | Total losses.                                   |
| WIN_PCT        | character |                                                 |
| PO_APPEARANCES | character |                                                 |
| DIV_TITLES     | character |                                                 |
| CONF_TITLES    | character |                                                 |
| LEAGUE_TITLES  | character |                                                 |

**DefunctTeams**

Same columns as the **FranchiseHistory** table above.

## Details

[Franchise
Leaders](https://www.nba.com/stats/team/1610612737/franchise-leaders)

     nba_franchiseleaders(league_id = '00', team_id = '1610612739')

[Franchise
Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)

     nba_franchiseleaderswrank(league_id = '00', team_id = '1610612739')
     nba_franchiseleaderswrank(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')

[Franchise
Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)

     nba_franchiseplayers(league_id = '00', team_id = '1610612739')
     nba_franchiseplayers(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')

[Franchise History](https://www.nba.com/stats/history)

     nba_franchisehistory(league_id = '00')
     nba_franchisehistory(league_id = '01')
     nba_franchisehistory(league_id = '10')
     nba_franchisehistory(league_id = '20')

## Author

Saiem Gilani
