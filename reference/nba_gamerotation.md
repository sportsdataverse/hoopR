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

|               |           |                                                 |
|---------------|-----------|-------------------------------------------------|
| col_name      | types     | description                                     |
| GAME_ID       | character | Unique game identifier.                         |
| TEAM_ID       | character | Unique team identifier.                         |
| TEAM_CITY     | character | Team city or region (e.g. 'Las Vegas').         |
| TEAM_NAME     | character | Full team display name (e.g. 'Las Vegas Aces'). |
| PERSON_ID     | character | Unique player identifier (V3 endpoints).        |
| PLAYER_FIRST  | character |                                                 |
| PLAYER_LAST   | character |                                                 |
| IN_TIME_REAL  | character |                                                 |
| OUT_TIME_REAL | character |                                                 |
| PLAYER_PTS    | character |                                                 |
| PT_DIFF       | character |                                                 |
| USG_PCT       | character | Usage percentage (0-1).                         |

**HomeTeam**

Same columns as the **AwayTeam** table above.

## Details

     nba_gamerotation(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Lineup Functions:
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_possession_lineups()`](https://hoopR.sportsdataverse.org/reference/nba_possession_lineups.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md)

## Author

Saiem Gilani
