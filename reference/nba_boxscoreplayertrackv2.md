# **Get NBA Stats API Boxscore Player Tracking V2**

**Get NBA Stats API Boxscore Player Tracking V2**

**Get NBA Stats API Boxscore Player Tracking V2**

## Usage

``` r
nba_boxscoreplayertrackv2(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayerStats, TeamStats

**PlayerStats**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY         | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
| START_POSITION    | character |
| COMMENT           | character |
| MIN               | character |
| SPD               | character |
| DIST              | character |
| ORBC              | character |
| DRBC              | character |
| RBC               | character |
| TCHS              | character |
| SAST              | character |
| FTAST             | character |
| PASS              | character |
| AST               | character |
| CFGM              | character |
| CFGA              | character |
| CFG_PCT           | character |
| UFGM              | character |
| UFGA              | character |
| UFG_PCT           | character |
| FG_PCT            | character |
| DFGM              | character |
| DFGA              | character |
| DFG_PCT           | character |

**TeamStats**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GAME_ID           | character |
| TEAM_ID           | character |
| TEAM_NAME         | character |
| TEAM_ABBREVIATION | character |
| TEAM_CITY         | character |
| MIN               | character |
| DIST              | character |
| ORBC              | character |
| DRBC              | character |
| RBC               | character |
| TCHS              | character |
| SAST              | character |
| FTAST             | character |
| PASS              | character |
| AST               | character |
| CFGM              | character |
| CFGA              | character |
| CFG_PCT           | character |
| UFGM              | character |
| UFGA              | character |
| UFG_PCT           | character |
| FG_PCT            | character |
| DFGM              | character |
| DFGA              | character |
| DFG_PCT           | character |

## Details

     nba_boxscoreplayertrackv2(game_id = "0022200021")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md),
[`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Player Tracking Functions:
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md)

## Author

Saiem Gilani
