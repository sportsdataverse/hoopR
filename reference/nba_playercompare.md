# **Get NBA Stats API Player Compare**

**Get NBA Stats API Player Compare**

**Get NBA Stats API Player Compare**

## Usage

``` r
nba_playercompare(
  conference = "",
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
  per_mode = "Totals",
  period = 0,
  player_id_list = "202681,203078,2544,201567,203954",
  plus_minus = "N",
  rank = "N",
  season = "2020-21",
  season_segment = "",
  season_type = "Regular Season",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  vs_player_id_list = "201566,201939,201935,201142,203076",
  ...
)
```

## Arguments

- conference:

  conference

- date_from:

  date_from

- date_to:

  date_to

- game_segment:

  game_segment

- last_n_games:

  last_n_games

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

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

- per_mode:

  per_mode

- period:

  period

- player_id_list:

  Player ID

- plus_minus:

  plus_minus

- rank:

  rank

- season:

  Season - format 2020-21

- season_segment:

  season_segment

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- shot_clock_range:

  shot_clock_range

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_player_id_list:

  vs_player_id_list

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: Individual, OverallCompare

**OverallCompare**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| GROUP_SET   | character |                                               |
| DESCRIPTION | character | Long-form description text.                   |
| MIN         | character | Minutes played.                               |
| FGM         | character | Field goals made.                             |
| FGA         | character | Field goal attempts.                          |
| FG_PCT      | character | Field goal percentage (0-1).                  |
| FG3M        | character | Three-point field goals made.                 |
| FG3A        | character | Three-point field goal attempts.              |
| FG3_PCT     | character | Three-point field goal percentage (0-1).      |
| FTM         | character | Free throws made.                             |
| FTA         | character | Free throw attempts.                          |
| FT_PCT      | character | Free throw percentage (0-1).                  |
| OREB        | character | Offensive rebounds.                           |
| DREB        | character | Defensive rebounds.                           |
| REB         | character | Total rebounds.                               |
| AST         | character | Assists.                                      |
| TOV         | character | Turnovers.                                    |
| STL         | character | Steals.                                       |
| BLK         | character | Blocks.                                       |
| BLKA        | character |                                               |
| PF          | character | Personal fouls.                               |
| PFD         | character |                                               |
| PTS         | character | Points scored.                                |
| PLUS_MINUS  | character | Plus/minus point differential while on court. |

**Individual**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| GROUP_SET   | character |                                               |
| DESCRIPTION | character | Long-form description text.                   |
| MIN         | character | Minutes played.                               |
| FGM         | character | Field goals made.                             |
| FGA         | character | Field goal attempts.                          |
| FG_PCT      | character | Field goal percentage (0-1).                  |
| FG3M        | character | Three-point field goals made.                 |
| FG3A        | character | Three-point field goal attempts.              |
| FG3_PCT     | character | Three-point field goal percentage (0-1).      |
| FTM         | character | Free throws made.                             |
| FTA         | character | Free throw attempts.                          |
| FT_PCT      | character | Free throw percentage (0-1).                  |
| OREB        | character | Offensive rebounds.                           |
| DREB        | character | Defensive rebounds.                           |
| REB         | character | Total rebounds.                               |
| AST         | character | Assists.                                      |
| TOV         | character | Turnovers.                                    |
| STL         | character | Steals.                                       |
| BLK         | character | Blocks.                                       |
| BLKA        | character |                                               |
| PF          | character | Personal fouls.                               |
| PFD         | character |                                               |
| PTS         | character | Points scored.                                |
| PLUS_MINUS  | character | Plus/minus point differential while on court. |

## Details

     nba_playercompare(player_id_list = '202681,203078,2544,201567,203954', vs_player_id_list = '201566,201939,201935,201142,203076')

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
[`nba_playercareerbycollegerollup()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollegerollup.md),
[`nba_playercareerbycollege()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollege.md),
[`nba_playercareerstats()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats.md),
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_playerestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_playerestimatedmetrics.md),
[`nba_playerfantasyprofilebargraph()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofilebargraph.md),
[`nba_playerfantasyprofile()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofile.md),
[`nba_playergamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelogs.md),
[`nba_playergamelog()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelog.md),
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md),
[`nba_playerheadshot()`](https://hoopR.sportsdataverse.org/reference/nba_playerheadshot.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md),
[`nba_playernextngames()`](https://hoopR.sportsdataverse.org/reference/nba_playernextngames.md),
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

## Author

Saiem Gilani
