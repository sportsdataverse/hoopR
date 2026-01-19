# **Get NBA Stats API Boxscore Scoring V2**

**Get NBA Stats API Boxscore Scoring V2**

**Get NBA Stats API Boxscore Scoring V2**

## Usage

``` r
nba_boxscorescoringv2(
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

Returns a named list of data frames: sqlPlayersScoring, sqlTeamsScoring

**sqlPlayersScoring**

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
| PCT_FGA_2PT       | character |
| PCT_FGA_3PT       | character |
| PCT_PTS_2PT       | character |
| PCT_PTS_2PT_MR    | character |
| PCT_PTS_3PT       | character |
| PCT_PTS_FB        | character |
| PCT_PTS_FT        | character |
| PCT_PTS_OFF_TOV   | character |
| PCT_PTS_PAINT     | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |

**sqlTeamsScoring**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_NAME         | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY         | character |
| MIN               | character |
| PCT_FGA_2PT       | character |
| PCT_FGA_3PT       | character |
| PCT_PTS_2PT       | character |
| PCT_PTS_2PT_MR    | character |
| PCT_PTS_3PT       | character |
| PCT_PTS_FB        | character |
| PCT_PTS_FT        | character |
| PCT_PTS_OFF_TOV   | character |
| PCT_PTS_PAINT     | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |

## Details

     nba_boxscorescoringv2(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md),
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

## Author

Saiem Gilani
