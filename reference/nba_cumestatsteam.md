# **Get NBA Stats API Cumulative Team Stats**

**Get NBA Stats API Cumulative Team Stats**

**Get NBA Stats API Cumulative Team Stats**

## Usage

``` r
nba_cumestatsteam(
  game_ids = "0022201094",
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "1610612739",
  ...
)
```

## Arguments

- game_ids:

  game_ids

- league_id:

  league_id

- season:

  season

- season_type:

  season_type

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: GameByGameStats, TotalTeamStats

**GameByGameStats**

|                    |           |                                           |
|--------------------|-----------|-------------------------------------------|
| col_name           | types     | description                               |
| JERSEY_NUM         | character | Jersey number worn by the player.         |
| PLAYER             | character | Player.                                   |
| PERSON_ID          | character | Unique player identifier (V3 endpoints).  |
| TEAM_ID            | character | Unique team identifier.                   |
| GP                 | character | Games played.                             |
| GS                 | character | Games started.                            |
| ACTUAL_MINUTES     | character |                                           |
| ACTUAL_SECONDS     | character |                                           |
| FG                 | character | Field goals made.                         |
| FGA                | character | Field goal attempts.                      |
| FG_PCT             | character | Field goal percentage (0-1).              |
| FG3                | character |                                           |
| FG3A               | character | Three-point field goal attempts.          |
| FG3_PCT            | character | Three-point field goal percentage (0-1).  |
| FT                 | character |                                           |
| FTA                | character | Free throw attempts.                      |
| FT_PCT             | character | Free throw percentage (0-1).              |
| OFF_REB            | character |                                           |
| DEF_REB            | character |                                           |
| TOT_REB            | character |                                           |
| AST                | character | Assists.                                  |
| PF                 | character | Personal fouls.                           |
| DQ                 | character |                                           |
| STL                | character | Steals.                                   |
| TURNOVERS          | character | Total turnovers.                          |
| BLK                | character | Blocks.                                   |
| PTS                | character | Points scored.                            |
| MAX_ACTUAL_MINUTES | character |                                           |
| MAX_ACTUAL_SECONDS | character |                                           |
| MAX_REB            | character |                                           |
| MAX_AST            | character |                                           |
| MAX_STL            | character |                                           |
| MAX_TURNOVERS      | character |                                           |
| MAX_BLKP           | character |                                           |
| MAX_PTS            | character |                                           |
| AVG_ACTUAL_MINUTES | character |                                           |
| AVG_ACTUAL_SECONDS | character |                                           |
| AVG_REB            | character |                                           |
| AVG_AST            | character |                                           |
| AVG_STL            | character |                                           |
| AVG_TURNOVERS      | character | The average turnovers committed per game. |
| AVG_BLKP           | character |                                           |
| AVG_PTS            | character |                                           |
| PER_MIN_REB        | character |                                           |
| PER_MIN_AST        | character |                                           |
| PER_MIN_STL        | character |                                           |
| PER_MIN_TURNOVERS  | character |                                           |
| PER_MIN_BLK        | character |                                           |
| PER_MIN_PTS        | character |                                           |

**TotalTeamStats**

|  |  |  |
|----|----|----|
| col_name | types | description |
| CITY | character | City. |
| NICKNAME | character | Team or athlete nickname. |
| TEAM_ID | character | Unique team identifier. |
| W | character | Wins. |
| L | character | Losses. |
| W_HOME | character |  |
| L_HOME | character |  |
| W_ROAD | character |  |
| L_ROAD | character |  |
| TEAM_TURNOVERS | character | Team turnovers (turnovers credited to the team rather than a player). |
| TEAM_REBOUNDS | character | Team rebounds (rebounds credited to the team rather than a player). |
| GP | character | Games played. |
| GS | character | Games started. |
| ACTUAL_MINUTES | character |  |
| ACTUAL_SECONDS | character |  |
| FG | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3 | character |  |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FT | character |  |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OFF_REB | character |  |
| DEF_REB | character |  |
| TOT_REB | character |  |
| AST | character | Assists. |
| PF | character | Personal fouls. |
| STL | character | Steals. |
| TOTAL_TURNOVERS | character | Total turnovers (player + team). |
| BLK | character | Blocks. |
| PTS | character | Points scored. |
| AVG_REB | character |  |
| AVG_PTS | character |  |
| DQ | character |  |

## Details

[CUME Stats](https://www.nba.com/stats/cumestats)

     nba_cumestatsteam(game_ids = '0022201094', season = '2022-23', team_id = '1610612739')

## See also

Other NBA Cume Functions:
[`nba_cumestatsplayergames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayergames.md),
[`nba_cumestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayer.md),
[`nba_cumestatsteamgames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsteamgames.md)

## Author

Saiem Gilani
