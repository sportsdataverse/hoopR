# **Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise Players**

**Get NBA Stats API Franchise Players**

## Usage

``` r
nba_franchiseplayers(
  league_id = "00",
  per_mode = "Totals",
  season_type = "Regular Season",
  team_id = "1610612739",
  ...
)
```

## Arguments

- league_id:

  league_id

- per_mode:

  per_mode

- season_type:

  season_type

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

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

## Details

[Franchise
Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)

     nba_franchiseplayers(league_id = '00', team_id = '1610612739')
     nba_franchiseplayers(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')

## See also

Other NBA Franchise Functions:
[`nba_franchisehistory()`](https://hoopR.sportsdataverse.org/reference/nba_franchisehistory.md),
[`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaders.md),
[`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md)

## Author

Saiem Gilani
