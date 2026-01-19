# **Get NBA Stats API Player Dashboard by Shooting Splits**

**Get NBA Stats API Player Dashboard by Shooting Splits**

**Get NBA Stats API Player Dashboard by Shooting Splits**

## Usage

``` r
nba_playerdashboardbyshootingsplits(
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
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
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

- po_round:

  po_round

- pace_adjust:

  pace_adjust

- per_mode:

  per_mode

- period:

  period

- player_id:

  player_id

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

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: AssistedBy,
AssitedShotPlayerDashboard, OverallPlayerDashboard,
Shot5FTPlayerDashboard, Shot8FTPlayerDashboard, ShotAreaPlayerDashboard,
ShotTypePlayerDashboard, ShotTypeSummaryPlayerDashboard

**OverallPlayerDashboard**

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

**Shot5FTPlayerDashboard**

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

**Shot8FTPlayerDashboard**

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

**ShotAreaPlayerDashboard**

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

**AssitedShotPlayerDashboard**

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

**ShotTypeSummaryPlayerDashboard**

|              |           |
|--------------|-----------|
| col_name     | types     |
| GROUP_SET    | character |
| GROUP_VALUE  | character |
| FGM          | character |
| FGA          | character |
| FG_PCT       | character |
| FG3M         | character |
| FG3A         | character |
| FG3_PCT      | character |
| EFG_PCT      | character |
| BLKA         | character |
| PCT_AST_2PM  | character |
| PCT_UAST_2PM | character |
| PCT_AST_3PM  | character |
| PCT_UAST_3PM | character |
| PCT_AST_FGM  | character |
| PCT_UAST_FGM | character |

**ShotTypePlayerDashboard**

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

[Player Stats Dashboard by Shooting
Splits](https://www.nba.com/stats/player/2544/shooting)

     nba_playerdashboardbyshootingsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

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
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyclutch.md),
[`nba_playerdashboardbygamesplits()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbygamesplits.md),
[`nba_playerdashboardbygeneralsplits()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbygeneralsplits.md),
[`nba_playerdashboardbylastngames()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbylastngames.md),
[`nba_playerdashboardbyopponent()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyopponent.md),
[`nba_playerdashboardbyteamperformance()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyteamperformance.md),
[`nba_playerdashboardbyyearoveryear()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyyearoveryear.md),
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
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

Other NBA Shooting Functions:
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md),
[`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md),
[`nba_teamdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboardbyshootingsplits.md)

## Author

Saiem Gilani
