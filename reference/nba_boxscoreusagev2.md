# **Get NBA Stats API Boxscore Usage V2**

**Get NBA Stats API Boxscore Usage V2**

**Get NBA Stats API Boxscore Usage V2**

## Usage

``` r
nba_boxscoreusagev2(
  game_id,
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
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

## Value

Returns a named list of data frames: sqlPlayersUsage, sqlTeamsUsage

**sqlPlayersUsage**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY         | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
| NICKNAME          | character |
| START_POSITION    | character |
| COMMENT           | character |
| MIN               | character |
| USG_PCT           | character |
| PCT_FGM           | character |
| PCT_FGA           | character |
| PCT_FG3M          | character |
| PCT_FG3A          | character |
| PCT_FTM           | character |
| PCT_FTA           | character |
| PCT_OREB          | character |
| PCT_DREB          | character |
| PCT_REB           | character |
| PCT_AST           | character |
| PCT_TOV           | character |
| PCT_STL           | character |
| PCT_BLK           | character |
| PCT_BLKA          | character |
| PCT_PF            | character |
| PCT_PFD           | character |
| PCT_PTS           | character |

**sqlTeamsUsage**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_NAME         | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY         | character |
| MIN               | character |
| USG_PCT           | character |
| PCT_FGM           | character |
| PCT_FGA           | character |
| PCT_FG3M          | character |
| PCT_FG3A          | character |
| PCT_FTM           | character |
| PCT_FTA           | character |
| PCT_OREB          | character |
| PCT_DREB          | character |
| PCT_REB           | character |
| PCT_AST           | character |
| PCT_TOV           | character |
| PCT_STL           | character |
| PCT_BLK           | character |
| PCT_BLKA          | character |
| PCT_PF            | character |
| PCT_PFD           | character |
| PCT_PTS           | character |

## Details

     nba_boxscoreusagev2(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md),
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

## Author

Saiem Gilani
