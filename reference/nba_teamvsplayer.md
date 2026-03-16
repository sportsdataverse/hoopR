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

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| GP                | character |
| W                 | character |
| L                 | character |
| W_PCT             | character |
| MIN               | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| FTM               | character |
| FTA               | character |
| FT_PCT            | character |
| OREB              | character |
| DREB              | character |
| REB               | character |
| AST               | character |
| TOV               | character |
| STL               | character |
| BLK               | character |
| BLKA              | character |
| PF                | character |
| PFD               | character |
| PTS               | character |
| PLUS_MINUS        | character |
| GP_RANK           | character |
| W_RANK            | character |
| L_RANK            | character |
| W_PCT_RANK        | character |
| MIN_RANK          | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| FTM_RANK          | character |
| FTA_RANK          | character |
| FT_PCT_RANK       | character |
| OREB_RANK         | character |
| DREB_RANK         | character |
| REB_RANK          | character |
| AST_RANK          | character |
| TOV_RANK          | character |
| STL_RANK          | character |
| BLK_RANK          | character |
| BLKA_RANK         | character |
| PF_RANK           | character |
| PFD_RANK          | character |
| PTS_RANK          | character |
| PLUS_MINUS_RANK   | character |

**vsPlayerOverall**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| GROUP_SET             | character |
| GROUP_VALUE           | character |
| PLAYER_ID             | character |
| GP                    | character |
| W                     | character |
| L                     | character |
| W_PCT                 | character |
| MIN                   | character |
| FGM                   | character |
| FGA                   | character |
| FG_PCT                | character |
| FG3M                  | character |
| FG3A                  | character |
| FG3_PCT               | character |
| FTM                   | character |
| FTA                   | character |
| FT_PCT                | character |
| OREB                  | character |
| DREB                  | character |
| REB                   | character |
| AST                   | character |
| TOV                   | character |
| STL                   | character |
| BLK                   | character |
| BLKA                  | character |
| PF                    | character |
| PFD                   | character |
| PTS                   | character |
| PLUS_MINUS            | character |
| NBA_FANTASY_PTS       | character |
| DD2                   | character |
| TD3                   | character |
| WNBA_FANTASY_PTS      | character |
| GP_RANK               | character |
| W_RANK                | character |
| L_RANK                | character |
| W_PCT_RANK            | character |
| MIN_RANK              | character |
| FGM_RANK              | character |
| FGA_RANK              | character |
| FG_PCT_RANK           | character |
| FG3M_RANK             | character |
| FG3A_RANK             | character |
| FG3_PCT_RANK          | character |
| FTM_RANK              | character |
| FTA_RANK              | character |
| FT_PCT_RANK           | character |
| OREB_RANK             | character |
| DREB_RANK             | character |
| REB_RANK              | character |
| AST_RANK              | character |
| TOV_RANK              | character |
| STL_RANK              | character |
| BLK_RANK              | character |
| BLKA_RANK             | character |
| PF_RANK               | character |
| PFD_RANK              | character |
| PTS_RANK              | character |
| PLUS_MINUS_RANK       | character |
| NBA_FANTASY_PTS_RANK  | character |
| DD2_RANK              | character |
| TD3_RANK              | character |
| WNBA_FANTASY_PTS_RANK | character |

**OnOffCourt**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| VS_PLAYER_ID      | character |
| VS_PLAYER_NAME    | character |
| COURT_STATUS      | character |
| GP                | character |
| W                 | character |
| L                 | character |
| W_PCT             | character |
| MIN               | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| FTM               | character |
| FTA               | character |
| FT_PCT            | character |
| OREB              | character |
| DREB              | character |
| REB               | character |
| AST               | character |
| TOV               | character |
| STL               | character |
| BLK               | character |
| BLKA              | character |
| PF                | character |
| PFD               | character |
| PTS               | character |
| PLUS_MINUS        | character |
| GP_RANK           | character |
| W_RANK            | character |
| L_RANK            | character |
| W_PCT_RANK        | character |
| MIN_RANK          | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| FTM_RANK          | character |
| FTA_RANK          | character |
| FT_PCT_RANK       | character |
| OREB_RANK         | character |
| DREB_RANK         | character |
| REB_RANK          | character |
| AST_RANK          | character |
| TOV_RANK          | character |
| STL_RANK          | character |
| BLK_RANK          | character |
| BLKA_RANK         | character |
| PF_RANK           | character |
| PFD_RANK          | character |
| PTS_RANK          | character |
| PLUS_MINUS_RANK   | character |

**ShotDistanceOverall**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

**ShotDistanceOnCourt**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| VS_PLAYER_ID      | character |
| VS_PLAYER_NAME    | character |
| COURT_STATUS      | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

**ShotDistanceOffCourt**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| VS_PLAYER_ID      | character |
| VS_PLAYER_NAME    | character |
| COURT_STATUS      | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

**ShotAreaOverall**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

**ShotAreaOnCourt**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| VS_PLAYER_ID      | character |
| VS_PLAYER_NAME    | character |
| COURT_STATUS      | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

**ShotAreaOffCourt**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| VS_PLAYER_ID      | character |
| VS_PLAYER_NAME    | character |
| COURT_STATUS      | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |

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
