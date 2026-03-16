# **Get NBA Stats API Team and Players vs Players**

**Get NBA Stats API Team and Players vs Players**

**Get NBA Stats API Team and Players vs Players**

## Usage

``` r
nba_teamandplayersvsplayers(
  team_id,
  vs_team_id,
  player_id1,
  player_id2,
  player_id3,
  player_id4,
  player_id5,
  vs_player_id1,
  vs_player_id2,
  vs_player_id3,
  vs_player_id4,
  vs_player_id5,
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  measure_type = "Base",
  per_mode = "Totals",
  plus_minus = "N",
  pace_adjust = "N",
  rank = "N",
  league_id = "00",
  last_n_games = 0,
  month = 0,
  opponent_team_id = 0,
  period = 0,
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  game_segment = "",
  location = "",
  outcome = "",
  season_segment = "",
  shot_clock_range = "",
  vs_conference = "",
  vs_division = "",
  ...
)
```

## Arguments

- team_id:

  Team ID

- vs_team_id:

  Opponent Team ID to compare against

- player_id1:

  Player ID 1 for team lineup

- player_id2:

  Player ID 2 for team lineup

- player_id3:

  Player ID 3 for team lineup

- player_id4:

  Player ID 4 for team lineup

- player_id5:

  Player ID 5 for team lineup

- vs_player_id1:

  Opponent Player ID 1 for comparison lineup

- vs_player_id2:

  Opponent Player ID 2 for comparison lineup

- vs_player_id3:

  Opponent Player ID 3 for comparison lineup

- vs_player_id4:

  Opponent Player ID 4 for comparison lineup

- vs_player_id5:

  Opponent Player ID 5 for comparison lineup

- season:

  Season - format: '2023-24'

- season_type:

  Season Type - 'Regular Season', 'Playoffs'

- measure_type:

  Measure Type - 'Base', 'Advanced', 'Misc', 'Scoring', 'Usage'

- per_mode:

  Per Mode - 'Totals', 'PerGame', 'Per36', 'Per48'

- plus_minus:

  Plus Minus - 'Y' or 'N'

- pace_adjust:

  Pace Adjust - 'Y' or 'N'

- rank:

  Rank - 'Y' or 'N'

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- last_n_games:

  Last N Games filter

- month:

  Month filter (0 for all)

- opponent_team_id:

  Opponent Team ID filter

- period:

  Period filter (0 for all)

- conference:

  Conference filter - 'East', 'West', or ”

- date_from:

  Date From filter - format: 'MM/DD/YYYY'

- date_to:

  Date To filter - format: 'MM/DD/YYYY'

- division:

  Division filter

- game_segment:

  Game Segment - 'First Half', 'Second Half', 'Overtime', or ”

- location:

  Location filter - 'Home', 'Road', or ”

- outcome:

  Outcome filter - 'W', 'L', or ”

- season_segment:

  Season Segment - 'Pre All-Star', 'Post All-Star', or ”

- shot_clock_range:

  Shot Clock Range filter

- vs_conference:

  Opponent Conference filter

- vs_division:

  Opponent Division filter

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayersVsPlayers,
TeamPlayersVsPlayersOff, TeamPlayersVsPlayersOn, TeamVsPlayers,
TeamVsPlayersOff

**PlayersVsPlayers**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TITLE_DESCRIPTION | character |
| DESCRIPTION       | character |
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

**TeamPlayersVsPlayersOn**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TITLE_DESCRIPTION | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
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

**TeamPlayersVsPlayersOff**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TITLE_DESCRIPTION | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
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

**TeamVsPlayers**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TITLE_DESCRIPTION | character |
| DESCRIPTION       | character |
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

**TeamVsPlayersOff**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| GROUP_SET         | character |
| TITLE_DESCRIPTION | character |
| DESCRIPTION       | character |
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

## Details

     nba_teamandplayersvsplayers(
       team_id = '1610612739',
       vs_team_id = '1610612765',
       player_id1 = '202681', player_id2 = '203078',
       player_id3 = '203507', player_id4 = '201567',
       player_id5 = '203954',
       vs_player_id1 = '201566', vs_player_id2 = '201939',
       vs_player_id3 = '201935', vs_player_id4 = '201142',
       vs_player_id5 = '203076',
       season = '2019-20')

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
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
[`nba_teamvsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_teamvsplayer.md),
[`nba_teamyearbyyearstats()`](https://hoopR.sportsdataverse.org/reference/nba_teamyearbyyearstats.md)

## Author

Saiem Gilani
