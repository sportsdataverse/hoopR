# **Get NBA Stats API Player Dashboard by Opponent**

**Get NBA Stats API Player Dashboard by Opponent**

**Get NBA Stats API Player Dashboard by Opponent**

## Usage

``` r
nba_playerdashboardbyopponent(
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

Return a named list of data frames: ConferencePlayerDashboard,
DivisionPlayerDashboard, OpponentPlayerDashboard, OverallPlayerDashboard

**OverallPlayerDashboard**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| GROUP_SET             | character |
| GROUP_VALUE           | character |
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

**ConferencePlayerDashboard**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| GROUP_SET             | character |
| GROUP_VALUE           | character |
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

**DivisionPlayerDashboard**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| GROUP_SET             | character |
| GROUP_VALUE           | character |
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

**OpponentPlayerDashboard**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| GROUP_SET             | character |
| GROUP_VALUE           | character |
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

## Details

[Player Stats Dashboard by
Opponent](https://www.nba.com/stats/player/2544/traditional?Split=opp)

     nba_playerdashboardbyopponent(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

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
[`nba_playerdashboardbyshootingsplits()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboardbyshootingsplits.md),
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

## Author

Saiem Gilani
