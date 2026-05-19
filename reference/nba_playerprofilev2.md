# **Get NBA Stats API Player Profile V2**

**Get NBA Stats API Player Profile V2**

**Get NBA Stats API Player Profile V2**

## Usage

``` r
nba_playerprofilev2(
  league_id = "",
  per_mode = "Totals",
  player_id = "2544",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Season - format 2020-21

- player_id:

  Player ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: CareerHighs,
CareerTotalsAllStarSeason, CareerTotalsCollegeSeason,
CareerTotalsPostSeason, CareerTotalsPreseason,
CareerTotalsRegularSeason, NextGame, SeasonHighs,
SeasonRankingsPostSeason, SeasonRankingsRegularSeason,
SeasonTotalsAllStarSeason, SeasonTotalsCollegeSeason,
SeasonTotalsPostSeason, SeasonTotalsPreseason, SeasonTotalsRegularSeason

**SeasonTotalsRegularSeason**

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| PLAYER_ID         | character | Unique player identifier.                |
| SEASON_ID         | character | Unique season identifier.                |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).         |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| PLAYER_AGE        | character |                                          |
| GP                | character | Games played.                            |
| GS                | character | Games started.                           |
| MIN               | character | Minutes played.                          |
| FGM               | character | Field goals made.                        |
| FGA               | character | Field goal attempts.                     |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FG3M              | character | Three-point field goals made.            |
| FG3A              | character | Three-point field goal attempts.         |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| FTM               | character | Free throws made.                        |
| FTA               | character | Free throw attempts.                     |
| FT_PCT            | character | Free throw percentage (0-1).             |
| OREB              | character | Offensive rebounds.                      |
| DREB              | character | Defensive rebounds.                      |
| REB               | character | Total rebounds.                          |
| AST               | character | Assists.                                 |
| STL               | character | Steals.                                  |
| BLK               | character | Blocks.                                  |
| TOV               | character | Turnovers.                               |
| PF                | character | Personal fouls.                          |
| PTS               | character | Points scored.                           |

**CareerTotalsRegularSeason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| TEAM_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonTotalsPostSeason**

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| PLAYER_ID         | character | Unique player identifier.                |
| SEASON_ID         | character | Unique season identifier.                |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).         |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| PLAYER_AGE        | character |                                          |
| GP                | character | Games played.                            |
| GS                | character | Games started.                           |
| MIN               | character | Minutes played.                          |
| FGM               | character | Field goals made.                        |
| FGA               | character | Field goal attempts.                     |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FG3M              | character | Three-point field goals made.            |
| FG3A              | character | Three-point field goal attempts.         |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| FTM               | character | Free throws made.                        |
| FTA               | character | Free throw attempts.                     |
| FT_PCT            | character | Free throw percentage (0-1).             |
| OREB              | character | Offensive rebounds.                      |
| DREB              | character | Defensive rebounds.                      |
| REB               | character | Total rebounds.                          |
| AST               | character | Assists.                                 |
| STL               | character | Steals.                                  |
| BLK               | character | Blocks.                                  |
| TOV               | character | Turnovers.                               |
| PF                | character | Personal fouls.                          |
| PTS               | character | Points scored.                           |

**CareerTotalsPostSeason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| TEAM_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonTotalsAllStarSeason**

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| PLAYER_ID         | character | Unique player identifier.                |
| SEASON_ID         | character | Unique season identifier.                |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).         |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| PLAYER_AGE        | character |                                          |
| GP                | character | Games played.                            |
| GS                | character | Games started.                           |
| MIN               | character | Minutes played.                          |
| FGM               | character | Field goals made.                        |
| FGA               | character | Field goal attempts.                     |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FG3M              | character | Three-point field goals made.            |
| FG3A              | character | Three-point field goal attempts.         |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| FTM               | character | Free throws made.                        |
| FTA               | character | Free throw attempts.                     |
| FT_PCT            | character | Free throw percentage (0-1).             |
| OREB              | character | Offensive rebounds.                      |
| DREB              | character | Defensive rebounds.                      |
| REB               | character | Total rebounds.                          |
| AST               | character | Assists.                                 |
| STL               | character | Steals.                                  |
| BLK               | character | Blocks.                                  |
| TOV               | character | Turnovers.                               |
| PF                | character | Personal fouls.                          |
| PTS               | character | Points scored.                           |

**CareerTotalsAllStarSeason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| TEAM_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonTotalsCollegeSeason**

**CareerTotalsCollegeSeason**

**SeasonTotalsPreseason**

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| PLAYER_ID         | character | Unique player identifier.                |
| SEASON_ID         | character | Unique season identifier.                |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).         |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| PLAYER_AGE        | character |                                          |
| GP                | character | Games played.                            |
| GS                | character | Games started.                           |
| MIN               | character | Minutes played.                          |
| FGM               | character | Field goals made.                        |
| FGA               | character | Field goal attempts.                     |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FG3M              | character | Three-point field goals made.            |
| FG3A              | character | Three-point field goal attempts.         |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| FTM               | character | Free throws made.                        |
| FTA               | character | Free throw attempts.                     |
| FT_PCT            | character | Free throw percentage (0-1).             |
| OREB              | character | Offensive rebounds.                      |
| DREB              | character | Defensive rebounds.                      |
| REB               | character | Total rebounds.                          |
| AST               | character | Assists.                                 |
| STL               | character | Steals.                                  |
| BLK               | character | Blocks.                                  |
| TOV               | character | Turnovers.                               |
| PF                | character | Personal fouls.                          |
| PTS               | character | Points scored.                           |

**CareerTotalsPreseason**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| PLAYER_ID | character | Unique player identifier.                |
| LEAGUE_ID | character | League identifier ('10' = WNBA).         |
| TEAM_ID   | character | Unique team identifier.                  |
| GP        | character | Games played.                            |
| GS        | character | Games started.                           |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

**SeasonRankingsRegularSeason**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| SEASON_ID         | character | Unique season identifier.             |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).      |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| PLAYER_AGE        | character |                                       |
| GP                | character | Games played.                         |
| GS                | character | Games started.                        |
| RANK_MIN          | character |                                       |
| RANK_FGM          | character |                                       |
| RANK_FGA          | character |                                       |
| RANK_FG_PCT       | character |                                       |
| RANK_FG3M         | character |                                       |
| RANK_FG3A         | character |                                       |
| RANK_FG3_PCT      | character |                                       |
| RANK_FTM          | character |                                       |
| RANK_FTA          | character |                                       |
| RANK_FT_PCT       | character |                                       |
| RANK_OREB         | character |                                       |
| RANK_DREB         | character |                                       |
| RANK_REB          | character |                                       |
| RANK_AST          | character |                                       |
| RANK_STL          | character |                                       |
| RANK_BLK          | character |                                       |
| RANK_TOV          | character |                                       |
| RANK_PTS          | character |                                       |
| RANK_EFF          | character |                                       |

**SeasonRankingsPostSeason**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| SEASON_ID         | character | Unique season identifier.             |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).      |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| PLAYER_AGE        | character |                                       |
| GP                | character | Games played.                         |
| GS                | character | Games started.                        |
| RANK_MIN          | character |                                       |
| RANK_FGM          | character |                                       |
| RANK_FGA          | character |                                       |
| RANK_FG_PCT       | character |                                       |
| RANK_FG3M         | character |                                       |
| RANK_FG3A         | character |                                       |
| RANK_FG3_PCT      | character |                                       |
| RANK_FTM          | character |                                       |
| RANK_FTA          | character |                                       |
| RANK_FT_PCT       | character |                                       |
| RANK_OREB         | character |                                       |
| RANK_DREB         | character |                                       |
| RANK_REB          | character |                                       |
| RANK_AST          | character |                                       |
| RANK_STL          | character |                                       |
| RANK_BLK          | character |                                       |
| RANK_TOV          | character |                                       |
| RANK_PTS          | character |                                       |
| RANK_EFF          | character |                                       |

**SeasonHighs**

|                      |           |                           |
|----------------------|-----------|---------------------------|
| col_name             | types     | description               |
| PLAYER_ID            | character | Unique player identifier. |
| GAME_ID              | character | Unique game identifier.   |
| GAME_DATE            | character | Game date (YYYY-MM-DD).   |
| VS_TEAM_ID           | character |                           |
| VS_TEAM_CITY         | character |                           |
| VS_TEAM_NAME         | character |                           |
| VS_TEAM_ABBREVIATION | character |                           |
| STAT                 | character | Stat.                     |
| STAT_VALUE           | character |                           |
| STAT_ORDER           | character |                           |
| DATE_EST             | character |                           |

**CareerHighs**

|                      |           |                           |
|----------------------|-----------|---------------------------|
| col_name             | types     | description               |
| PLAYER_ID            | character | Unique player identifier. |
| GAME_ID              | character | Unique game identifier.   |
| GAME_DATE            | character | Game date (YYYY-MM-DD).   |
| VS_TEAM_ID           | character |                           |
| VS_TEAM_CITY         | character |                           |
| VS_TEAM_NAME         | character |                           |
| VS_TEAM_ABBREVIATION | character |                           |
| STAT                 | character | Stat.                     |
| STAT_VALUE           | character |                           |
| STAT_ORDER           | character |                           |
| DATE_EST             | character |                           |

**NextGame**

|                          |           |                         |
|--------------------------|-----------|-------------------------|
| col_name                 | types     | description             |
| GAME_ID                  | character | Unique game identifier. |
| GAME_DATE                | character | Game date (YYYY-MM-DD). |
| GAME_TIME                | character | Game start time.        |
| LOCATION                 | character | Location.               |
| PLAYER_TEAM_ID           | character |                         |
| PLAYER_TEAM_CITY         | character |                         |
| PLAYER_TEAM_NICKNAME     | character |                         |
| PLAYER_TEAM_ABBREVIATION | character |                         |
| VS_TEAM_ID               | character |                         |
| VS_TEAM_CITY             | character |                         |
| VS_TEAM_NICKNAME         | character |                         |
| VS_TEAM_ABBREVIATION     | character |                         |

## Details

[Player Profile](https://www.nba.com/stats/player/2544/career)

     nba_playerprofilev2(player_id = '2544')

## See also

Other NBA Player Functions:
[`nba_infographicfanduelplayer()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md),
[`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md),
[`nba_leaguedashplayerclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerclutch.md),
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leagueplayerondetails()`](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails.md),
[`nba_leagueseasonmatchups()`](https://hoopR.sportsdataverse.org/reference/nba_leagueseasonmatchups.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_playerawards()`](https://hoopR.sportsdataverse.org/reference/nba_playerawards.md),
[`nba_playercareerbycollege()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollege.md),
[`nba_playercareerbycollegerollup()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollegerollup.md),
[`nba_playercareerstats()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats.md),
[`nba_playercompare()`](https://hoopR.sportsdataverse.org/reference/nba_playercompare.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_playerestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_playerestimatedmetrics.md),
[`nba_playerfantasyprofile()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofile.md),
[`nba_playerfantasyprofilebargraph()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofilebargraph.md),
[`nba_playergamelog()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelog.md),
[`nba_playergamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelogs.md),
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md),
[`nba_playerheadshot()`](https://hoopR.sportsdataverse.org/reference/nba_playerheadshot.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md),
[`nba_playernextngames()`](https://hoopR.sportsdataverse.org/reference/nba_playernextngames.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

## Author

Saiem Gilani
