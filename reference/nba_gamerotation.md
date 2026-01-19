# **Get NBA Stats API Game Rotation**

**Get NBA Stats API Game Rotation**

**Get NBA Stats API Game Rotation**

## Usage

``` r
nba_gamerotation(game_id, league_id = "00", rotation_stat = "PLAYER_PTS", ...)
```

## Arguments

- game_id:

  Game ID

- league_id:

  League ID

- rotation_stat:

  Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: AwayTeam, HomeTeam

**AwayTeam**

|               |           |
|---------------|-----------|
| col_name      | types     |
| GAME_ID       | character |
| TEAM_ID       | character |
| TEAM_CITY     | character |
| TEAM_NAME     | character |
| PERSON_ID     | character |
| PLAYER_FIRST  | character |
| PLAYER_LAST   | character |
| IN_TIME_REAL  | character |
| OUT_TIME_REAL | character |
| PLAYER_PTS    | character |
| PT_DIFF       | character |
| USG_PCT       | character |

**HomeTeam**

|               |           |
|---------------|-----------|
| col_name      | types     |
| GAME_ID       | character |
| TEAM_ID       | character |
| TEAM_CITY     | character |
| TEAM_NAME     | character |
| PERSON_ID     | character |
| PLAYER_FIRST  | character |
| PLAYER_LAST   | character |
| IN_TIME_REAL  | character |
| OUT_TIME_REAL | character |
| PLAYER_PTS    | character |
| PT_DIFF       | character |
| USG_PCT       | character |

## Details

     nba_gamerotation(game_id = "0022200021")

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
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Lineup Functions:
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md)

## Author

Saiem Gilani
