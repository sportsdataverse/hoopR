# **Get NBA Stats API Team Dashboard by Shooting Splits**

**Get NBA Stats API Team Dashboard by Shooting Splits**

**Get NBA Stats API Team Dashboard by Shooting Splits**

## Usage

``` r
nba_teamdashboardbyshootingsplits(
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
  pace_adjust = "N",
  plus_minus = "N",
  po_round = "",
  per_mode = "Totals",
  period = 0,
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  team_id = "1610612749",
  vs_conference = "",
  vs_division = "",
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

- pace_adjust:

  pace_adjust

- plus_minus:

  plus_minus

- po_round:

  po_round

- per_mode:

  per_mode

- period:

  period

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

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: AssistedBy,
AssitedShotTeamDashboard, OverallTeamDashboard, Shot5FTTeamDashboard,
Shot8FTTeamDashboard, ShotAreaTeamDashboard, ShotTypeTeamDashboard

**OverallTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**Shot5FTTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**Shot8FTTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**ShotAreaTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**AssitedShotTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**ShotTypeTeamDashboard**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| GROUP_VALUE       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

**AssistedBy**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
| FGM               | character |
| FGA               | character |
| FG_PCT            | character |
| FG3M              | character |
| FG3A              | character |
| FG3_PCT           | character |
| EFG_PCT           | character |
| BLKA              | character |
| PCT_AST_2PM       | character |
| PCT_UAST_2PM      | character |
| PCT_AST_3PM       | character |
| PCT_UAST_3PM      | character |
| PCT_AST_FGM       | character |
| PCT_UAST_FGM      | character |
| FGM_RANK          | character |
| FGA_RANK          | character |
| FG_PCT_RANK       | character |
| FG3M_RANK         | character |
| FG3A_RANK         | character |
| FG3_PCT_RANK      | character |
| EFG_PCT_RANK      | character |
| BLKA_RANK         | character |
| PCT_AST_2PM_RANK  | character |
| PCT_UAST_2PM_RANK | character |
| PCT_AST_3PM_RANK  | character |
| PCT_UAST_3PM_RANK | character |
| PCT_AST_FGM_RANK  | character |
| PCT_UAST_FGM_RANK | character |

## Details

[Team Dashboard by Shooting
Splits](https://www.nba.com/stats/team/1610612749/shooting)

     nba_teamdashboardbyshootingsplits(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyclutch.md),
[`nba_teamdashboardbygamesplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygamesplits.md),
[`nba_teamdashboardbygeneralsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbygeneralsplits.md),
[`nba_teamdashboardbylastngames()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbylastngames.md),
[`nba_teamdashboardbyopponent()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyopponent.md),
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
[`nba_teamvsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_teamvsplayer.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

Other NBA Shooting Functions:
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_playerdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyshootingsplits.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md)

## Author

Saiem Gilani
