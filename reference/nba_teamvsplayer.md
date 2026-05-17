# **Get NBA Stats API Team vs Player**

**Get NBA Stats API Team vs Player**

**Get NBA Stats API Team vs Player**

## Usage

``` r
nba_teamvsplayer(
  date_from = "",
  date_to = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  measure_type = "Base",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  pace_adjust = "N",
  per_mode = "Totals",
  period = 0,
  player_id = "",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
  vs_player_id = "2544",
  ...
)
```

## Arguments

- date_from:

  date_from

- date_to:

  date_to

- game_segment:

  game_segment

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- measure_type:

  measure_type

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- po_round:

  po_round

- pace_adjust:

  pace_adjust

- per_mode:

  per_mode

- period:

  period

- player_id:

  Player ID

- plus_minus:

  plus_minus

- rank:

  rank

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- shot_clock_range:

  shot_clock_range

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_player_id:

  vs_player_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: OnOffCourt, Overall,
ShotAreaOffCourt, ShotAreaOnCourt, ShotAreaOverall,
ShotDistanceOffCourt, ShotDistanceOnCourt, ShotDistanceOverall,
vsPlayerOverall

**Overall**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| GROUP_SET         | character |                                               |
| GROUP_VALUE       | character |                                               |
| TEAM_ID           | character | Unique team identifier.                       |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').         |
| GP                | character | Games played.                                 |
| W                 | character | Wins.                                         |
| L                 | character | Losses.                                       |
| W_PCT             | character |                                               |
| MIN               | character | Minutes played.                               |
| FGM               | character | Field goals made.                             |
| FGA               | character | Field goal attempts.                          |
| FG_PCT            | character | Field goal percentage (0-1).                  |
| FG3M              | character | Three-point field goals made.                 |
| FG3A              | character | Three-point field goal attempts.              |
| FG3_PCT           | character | Three-point field goal percentage (0-1).      |
| FTM               | character | Free throws made.                             |
| FTA               | character | Free throw attempts.                          |
| FT_PCT            | character | Free throw percentage (0-1).                  |
| OREB              | character | Offensive rebounds.                           |
| DREB              | character | Defensive rebounds.                           |
| REB               | character | Total rebounds.                               |
| AST               | character | Assists.                                      |
| TOV               | character | Turnovers.                                    |
| STL               | character | Steals.                                       |
| BLK               | character | Blocks.                                       |
| BLKA              | character |                                               |
| PF                | character | Personal fouls.                               |
| PFD               | character |                                               |
| PTS               | character | Points scored.                                |
| PLUS_MINUS        | character | Plus/minus point differential while on court. |
| GP_RANK           | character |                                               |
| W_RANK            | character |                                               |
| L_RANK            | character |                                               |
| W_PCT_RANK        | character |                                               |
| MIN_RANK          | character |                                               |
| FGM_RANK          | character |                                               |
| FGA_RANK          | character |                                               |
| FG_PCT_RANK       | character |                                               |
| FG3M_RANK         | character |                                               |
| FG3A_RANK         | character |                                               |
| FG3_PCT_RANK      | character |                                               |
| FTM_RANK          | character |                                               |
| FTA_RANK          | character |                                               |
| FT_PCT_RANK       | character |                                               |
| OREB_RANK         | character |                                               |
| DREB_RANK         | character |                                               |
| REB_RANK          | character |                                               |
| AST_RANK          | character |                                               |
| TOV_RANK          | character |                                               |
| STL_RANK          | character |                                               |
| BLK_RANK          | character |                                               |
| BLKA_RANK         | character |                                               |
| PF_RANK           | character |                                               |
| PFD_RANK          | character |                                               |
| PTS_RANK          | character |                                               |
| PLUS_MINUS_RANK   | character |                                               |

**vsPlayerOverall**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| GROUP_VALUE | character |  |
| PLAYER_ID | character | Unique player identifier. |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
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
| TOV | character | Turnovers. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| NBA_FANTASY_PTS | character |  |
| DD2 | character |  |
| TD3 | character |  |
| WNBA_FANTASY_PTS | character |  |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| FGM_RANK | character |  |
| FGA_RANK | character |  |
| FG_PCT_RANK | character |  |
| FG3M_RANK | character |  |
| FG3A_RANK | character |  |
| FG3_PCT_RANK | character |  |
| FTM_RANK | character |  |
| FTA_RANK | character |  |
| FT_PCT_RANK | character |  |
| OREB_RANK | character |  |
| DREB_RANK | character |  |
| REB_RANK | character |  |
| AST_RANK | character |  |
| TOV_RANK | character |  |
| STL_RANK | character |  |
| BLK_RANK | character |  |
| BLKA_RANK | character |  |
| PF_RANK | character |  |
| PFD_RANK | character |  |
| PTS_RANK | character |  |
| PLUS_MINUS_RANK | character |  |
| NBA_FANTASY_PTS_RANK | character |  |
| DD2_RANK | character |  |
| TD3_RANK | character |  |
| WNBA_FANTASY_PTS_RANK | character |  |

**OnOffCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
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
| TOV | character | Turnovers. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| BLKA | character |  |
| PF | character | Personal fouls. |
| PFD | character |  |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| FGM_RANK | character |  |
| FGA_RANK | character |  |
| FG_PCT_RANK | character |  |
| FG3M_RANK | character |  |
| FG3A_RANK | character |  |
| FG3_PCT_RANK | character |  |
| FTM_RANK | character |  |
| FTA_RANK | character |  |
| FT_PCT_RANK | character |  |
| OREB_RANK | character |  |
| DREB_RANK | character |  |
| REB_RANK | character |  |
| AST_RANK | character |  |
| TOV_RANK | character |  |
| STL_RANK | character |  |
| BLK_RANK | character |  |
| BLKA_RANK | character |  |
| PF_RANK | character |  |
| PFD_RANK | character |  |
| PTS_RANK | character |  |
| PLUS_MINUS_RANK | character |  |

**ShotDistanceOverall**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| GROUP_VALUE | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotDistanceOnCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GROUP_VALUE | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotDistanceOffCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GROUP_VALUE | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotAreaOverall**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| GROUP_VALUE | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotAreaOnCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GROUP_VALUE | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

**ShotAreaOffCourt**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GROUP_SET | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| VS_PLAYER_ID | character |  |
| VS_PLAYER_NAME | character |  |
| COURT_STATUS | character |  |
| GROUP_VALUE | character |  |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |

## Details

     nba_teamvsplayer(team_id = '1610612749', vs_player_id = '2544')

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyclutch.md),
[`nba_teamdashboardbygamesplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygamesplits.md),
[`nba_teamdashboardbygeneralsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygeneralsplits.md),
[`nba_teamdashboardbylastngames()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbylastngames.md),
[`nba_teamdashboardbyopponent()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyopponent.md),
[`nba_teamdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyshootingsplits.md),
[`nba_teamdashboardbyteamperformance()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyteamperformance.md),
[`nba_teamdashboardbyyearoveryear()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyyearoveryear.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_teamdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamdetails.md),
[`nba_teamestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_teamestimatedmetrics.md),
[`nba_teamgamelog()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelog.md),
[`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md),
[`nba_teamgamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamestreakfinder.md),
[`nba_teamhistoricalleaders()`](https://hoopR.sportsdataverse.org/reference/nba_teamhistoricalleaders.md),
[`nba_teaminfocommon()`](https://hoopR.sportsdataverse.org/reference/nba_teaminfocommon.md),
[`nba_teamplayerdashboard()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayerdashboard.md),
[`nba_teamplayeronoffdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md),
[`nba_teamplayeronoffsummary()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffsummary.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

## Author

Saiem Gilani
