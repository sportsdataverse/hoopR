# **Get NBA Stats API Team Dashboard Player Tracking - Shots**

**Get NBA Stats API Team Dashboard Player Tracking - Shots**

**Get NBA Stats API Team Dashboard Player Tracking - Shots**

## Usage

``` r
nba_teamdashptshots(
  date_from = "",
  date_to = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  per_mode = "Totals",
  period = 0,
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
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

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- per_mode:

  per_mode

- period:

  period

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: ClosestDefender10ftPlusShooting,
ClosestDefenderShooting, DribbleShooting, GeneralShooting,
ShotClockShooting, TouchTimeShooting

**GeneralShooting**

|                |           |
|----------------|-----------|
| col_name       | types     |
| TEAM_ID        | character |
| TEAM_NAME      | character |
| SORT_ORDER     | character |
| G              | character |
| SHOT_TYPE      | character |
| FGA_FREQUENCY  | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |
| EFG_PCT        | character |
| FG2A_FREQUENCY | character |
| FG2M           | character |
| FG2A           | character |
| FG2_PCT        | character |
| FG3A_FREQUENCY | character |
| FG3M           | character |
| FG3A           | character |
| FG3_PCT        | character |

**ShotClockShooting**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| TEAM_ID          | character |
| TEAM_NAME        | character |
| SORT_ORDER       | character |
| G                | character |
| SHOT_CLOCK_RANGE | character |
| FGA_FREQUENCY    | character |
| FGM              | character |
| FGA              | character |
| FG_PCT           | character |
| EFG_PCT          | character |
| FG2A_FREQUENCY   | character |
| FG2M             | character |
| FG2A             | character |
| FG2_PCT          | character |
| FG3A_FREQUENCY   | character |
| FG3M             | character |
| FG3A             | character |
| FG3_PCT          | character |

**DribbleShooting**

|                |           |
|----------------|-----------|
| col_name       | types     |
| TEAM_ID        | character |
| TEAM_NAME      | character |
| SORT_ORDER     | character |
| G              | character |
| DRIBBLE_RANGE  | character |
| FGA_FREQUENCY  | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |
| EFG_PCT        | character |
| FG2A_FREQUENCY | character |
| FG2M           | character |
| FG2A           | character |
| FG2_PCT        | character |
| FG3A_FREQUENCY | character |
| FG3M           | character |
| FG3A           | character |
| FG3_PCT        | character |

**ClosestDefenderShooting**

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| TEAM_ID              | character |
| TEAM_NAME            | character |
| SORT_ORDER           | character |
| G                    | character |
| CLOSE_DEF_DIST_RANGE | character |
| FGA_FREQUENCY        | character |
| FGM                  | character |
| FGA                  | character |
| FG_PCT               | character |
| EFG_PCT              | character |
| FG2A_FREQUENCY       | character |
| FG2M                 | character |
| FG2A                 | character |
| FG2_PCT              | character |
| FG3A_FREQUENCY       | character |
| FG3M                 | character |
| FG3A                 | character |
| FG3_PCT              | character |

**ClosestDefender10ftPlusShooting**

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| TEAM_ID              | character |
| TEAM_NAME            | character |
| SORT_ORDER           | character |
| G                    | character |
| CLOSE_DEF_DIST_RANGE | character |
| FGA_FREQUENCY        | character |
| FGM                  | character |
| FGA                  | character |
| FG_PCT               | character |
| EFG_PCT              | character |
| FG2A_FREQUENCY       | character |
| FG2M                 | character |
| FG2A                 | character |
| FG2_PCT              | character |
| FG3A_FREQUENCY       | character |
| FG3M                 | character |
| FG3A                 | character |
| FG3_PCT              | character |

**TouchTimeShooting**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| TEAM_ID          | character |
| TEAM_NAME        | character |
| SORT_ORDER       | character |
| G                | character |
| TOUCH_TIME_RANGE | character |
| FGA_FREQUENCY    | character |
| FGM              | character |
| FGA              | character |
| FG_PCT           | character |
| EFG_PCT          | character |
| FG2A_FREQUENCY   | character |
| FG2M             | character |
| FG2A             | character |
| FG2_PCT          | character |
| FG3A_FREQUENCY   | character |
| FG3M             | character |
| FG3A             | character |
| FG3_PCT          | character |

## Details

[Team Player Tracking (Second Spectrum) Stats -
Shooting](https://www.nba.com/stats/team/1610612749/shots-dash)

     nba_teamdashptshots(team_id = '1610612749', season = year_to_season(most_recent_nba_season() - 1))

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

Other NBA Player Tracking Functions:
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
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
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md)

## Author

Saiem Gilani
