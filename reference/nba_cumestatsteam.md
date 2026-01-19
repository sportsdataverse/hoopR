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

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| JERSEY_NUM         | character |
| PLAYER             | character |
| PERSON_ID          | character |
| TEAM_ID            | character |
| GP                 | character |
| GS                 | character |
| ACTUAL_MINUTES     | character |
| ACTUAL_SECONDS     | character |
| FG                 | character |
| FGA                | character |
| FG_PCT             | character |
| FG3                | character |
| FG3A               | character |
| FG3_PCT            | character |
| FT                 | character |
| FTA                | character |
| FT_PCT             | character |
| OFF_REB            | character |
| DEF_REB            | character |
| TOT_REB            | character |
| AST                | character |
| PF                 | character |
| DQ                 | character |
| STL                | character |
| TURNOVERS          | character |
| BLK                | character |
| PTS                | character |
| MAX_ACTUAL_MINUTES | character |
| MAX_ACTUAL_SECONDS | character |
| MAX_REB            | character |
| MAX_AST            | character |
| MAX_STL            | character |
| MAX_TURNOVERS      | character |
| MAX_BLKP           | character |
| MAX_PTS            | character |
| AVG_ACTUAL_MINUTES | character |
| AVG_ACTUAL_SECONDS | character |
| AVG_REB            | character |
| AVG_AST            | character |
| AVG_STL            | character |
| AVG_TURNOVERS      | character |
| AVG_BLKP           | character |
| AVG_PTS            | character |
| PER_MIN_REB        | character |
| PER_MIN_AST        | character |
| PER_MIN_STL        | character |
| PER_MIN_TURNOVERS  | character |
| PER_MIN_BLK        | character |
| PER_MIN_PTS        | character |

**TotalTeamStats**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| CITY            | character |
| NICKNAME        | character |
| TEAM_ID         | character |
| W               | character |
| L               | character |
| W_HOME          | character |
| L_HOME          | character |
| W_ROAD          | character |
| L_ROAD          | character |
| TEAM_TURNOVERS  | character |
| TEAM_REBOUNDS   | character |
| GP              | character |
| GS              | character |
| ACTUAL_MINUTES  | character |
| ACTUAL_SECONDS  | character |
| FG              | character |
| FGA             | character |
| FG_PCT          | character |
| FG3             | character |
| FG3A            | character |
| FG3_PCT         | character |
| FT              | character |
| FTA             | character |
| FT_PCT          | character |
| OFF_REB         | character |
| DEF_REB         | character |
| TOT_REB         | character |
| AST             | character |
| PF              | character |
| STL             | character |
| TOTAL_TURNOVERS | character |
| BLK             | character |
| PTS             | character |
| AVG_REB         | character |
| AVG_PTS         | character |
| DQ              | character |

## Details

[CUME Stats](https://www.nba.com/stats/cumestats)

     nba_cumestatsteam(game_ids = '0022201094', season = '2022-23', team_id = '1610612739')

## See also

Other NBA Cume Functions:
[`nba_cumestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayer.md),
[`nba_cumestatsplayergames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayergames.md),
[`nba_cumestatsteamgames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsteamgames.md)

## Author

Saiem Gilani
