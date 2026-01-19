# **Get NBA Stats API Hustle Stats Boxscore**

**Get NBA Stats API Hustle Stats Boxscore**

**Get NBA Stats API Hustle Stats Boxscore**

## Usage

``` r
nba_hustlestatsboxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: HustleStatsAvailable, PlayerStats,
TeamStats

**HustleStatsAvailable**

|               |           |
|---------------|-----------|
| col_name      | types     |
| GAME_ID       | character |
| HUSTLE_STATUS | character |

**PlayerStats**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| GAME_ID                   | character |
| TEAM_ID                   | character |
| TEAM_ABBREVIATION         | character |
| TEAM_CITY                 | character |
| PLAYER_ID                 | character |
| PLAYER_NAME               | character |
| START_POSITION            | character |
| COMMENT                   | character |
| MINUTES                   | character |
| PTS                       | character |
| CONTESTED_SHOTS           | character |
| CONTESTED_SHOTS_2PT       | character |
| CONTESTED_SHOTS_3PT       | character |
| DEFLECTIONS               | character |
| CHARGES_DRAWN             | character |
| SCREEN_ASSISTS            | character |
| SCREEN_AST_PTS            | character |
| OFF_LOOSE_BALLS_RECOVERED | character |
| DEF_LOOSE_BALLS_RECOVERED | character |
| LOOSE_BALLS_RECOVERED     | character |
| OFF_BOXOUTS               | character |
| DEF_BOXOUTS               | character |
| BOX_OUT_PLAYER_TEAM_REBS  | character |
| BOX_OUT_PLAYER_REBS       | character |
| BOX_OUTS                  | character |

**TeamStats**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| GAME_ID                   | character |
| TEAM_ID                   | character |
| TEAM_NAME                 | character |
| TEAM_ABBREVIATION         | character |
| TEAM_CITY                 | character |
| MINUTES                   | character |
| PTS                       | character |
| CONTESTED_SHOTS           | character |
| CONTESTED_SHOTS_2PT       | character |
| CONTESTED_SHOTS_3PT       | character |
| DEFLECTIONS               | character |
| CHARGES_DRAWN             | character |
| SCREEN_ASSISTS            | character |
| SCREEN_AST_PTS            | character |
| OFF_LOOSE_BALLS_RECOVERED | character |
| DEF_LOOSE_BALLS_RECOVERED | character |
| LOOSE_BALLS_RECOVERED     | character |
| OFF_BOXOUTS               | character |
| DEF_BOXOUTS               | character |
| BOX_OUT_PLAYER_TEAM_REBS  | character |
| BOX_OUT_PLAYER_REBS       | character |
| BOX_OUTS                  | character |

## Details

     nba_hustlestatsboxscore(game_id = "0022200021")

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
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)

Other NBA Hustle Functions:
[`nba_leaguehustlestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayer.md),
[`nba_leaguehustlestatsplayerleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayerleaders.md),
[`nba_leaguehustlestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteam.md),
[`nba_leaguehustlestatsteamleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteamleaders.md)

## Author

Saiem Gilani
