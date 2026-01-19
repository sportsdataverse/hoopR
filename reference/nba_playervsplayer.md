# **Get NBA Stats API Player vs Player**

**Get NBA Stats API Player vs Player**

**Get NBA Stats API Player vs Player**

## Usage

``` r
nba_playervsplayer(
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
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  vs_conference = "",
  vs_division = "",
  vs_player_id = "203076",
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

- player_id:

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

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_player_id:

  vs_player_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: OnOffCourt, Overall, PlayerInfo,
ShotAreaOffCourt, ShotAreaOnCourt, ShotAreaOverall,
ShotDistanceOffCourt, ShotDistanceOnCourt, ShotDistanceOverall,
VsPlayerInfo

**Overall**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| GROUP_SET       | character |
| GROUP_VALUE     | character |
| PLAYER_ID       | character |
| PLAYER_NAME     | character |
| GP              | character |
| W               | character |
| L               | character |
| W_PCT           | character |
| MIN             | character |
| FGM             | character |
| FGA             | character |
| FG_PCT          | character |
| FG3M            | character |
| FG3A            | character |
| FG3_PCT         | character |
| FTM             | character |
| FTA             | character |
| FT_PCT          | character |
| OREB            | character |
| DREB            | character |
| REB             | character |
| AST             | character |
| TOV             | character |
| STL             | character |
| BLK             | character |
| BLKA            | character |
| PF              | character |
| PFD             | character |
| PTS             | character |
| PLUS_MINUS      | character |
| NBA_FANTASY_PTS | character |

**OnOffCourt**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| GROUP_SET       | character |
| PLAYER_ID       | character |
| PLAYER_NAME     | character |
| VS_PLAYER_ID    | character |
| VS_PLAYER_NAME  | character |
| COURT_STATUS    | character |
| GP              | character |
| W               | character |
| L               | character |
| W_PCT           | character |
| MIN             | character |
| FGM             | character |
| FGA             | character |
| FG_PCT          | character |
| FG3M            | character |
| FG3A            | character |
| FG3_PCT         | character |
| FTM             | character |
| FTA             | character |
| FT_PCT          | character |
| OREB            | character |
| DREB            | character |
| REB             | character |
| AST             | character |
| TOV             | character |
| STL             | character |
| BLK             | character |
| BLKA            | character |
| PF              | character |
| PFD             | character |
| PTS             | character |
| PLUS_MINUS      | character |
| NBA_FANTASY_PTS | character |

**ShotDistanceOverall**

|             |           |
|-------------|-----------|
| col_name    | types     |
| GROUP_SET   | character |
| GROUP_VALUE | character |
| PLAYER_ID   | character |
| PLAYER_NAME | character |
| FGM         | character |
| FGA         | character |
| FG_PCT      | character |

**ShotDistanceOnCourt**

|                |           |
|----------------|-----------|
| col_name       | types     |
| GROUP_SET      | character |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| VS_PLAYER_ID   | character |
| VS_PLAYER_NAME | character |
| COURT_STATUS   | character |
| GROUP_VALUE    | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |

**ShotDistanceOffCourt**

|                |           |
|----------------|-----------|
| col_name       | types     |
| GROUP_SET      | character |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| VS_PLAYER_ID   | character |
| VS_PLAYER_NAME | character |
| COURT_STATUS   | character |
| GROUP_VALUE    | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |

**ShotAreaOverall**

|             |           |
|-------------|-----------|
| col_name    | types     |
| GROUP_SET   | character |
| GROUP_VALUE | character |
| PLAYER_ID   | character |
| PLAYER_NAME | character |
| FGM         | character |
| FGA         | character |
| FG_PCT      | character |

**ShotAreaOnCourt**

|                |           |
|----------------|-----------|
| col_name       | types     |
| GROUP_SET      | character |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| VS_PLAYER_ID   | character |
| VS_PLAYER_NAME | character |
| COURT_STATUS   | character |
| GROUP_VALUE    | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |

**ShotAreaOffCourt**

|                |           |
|----------------|-----------|
| col_name       | types     |
| GROUP_SET      | character |
| PLAYER_ID      | character |
| PLAYER_NAME    | character |
| VS_PLAYER_ID   | character |
| VS_PLAYER_NAME | character |
| COURT_STATUS   | character |
| GROUP_VALUE    | character |
| FGM            | character |
| FGA            | character |
| FG_PCT         | character |

**PlayerInfo**

|                          |           |
|--------------------------|-----------|
| col_name                 | types     |
| PERSON_ID                | character |
| FIRST_NAME               | character |
| LAST_NAME                | character |
| DISPLAY_FIRST_LAST       | character |
| DISPLAY_LAST_COMMA_FIRST | character |
| DISPLAY_FI_LAST          | character |
| BIRTHDATE                | character |
| SCHOOL                   | character |
| COUNTRY                  | character |
| LAST_AFFILIATION         | character |

**VsPlayerInfo**

|                          |           |
|--------------------------|-----------|
| col_name                 | types     |
| PERSON_ID                | character |
| FIRST_NAME               | character |
| LAST_NAME                | character |
| DISPLAY_FIRST_LAST       | character |
| DISPLAY_LAST_COMMA_FIRST | character |
| DISPLAY_FI_LAST          | character |
| BIRTHDATE                | character |
| SCHOOL                   | character |
| COUNTRY                  | character |
| LAST_AFFILIATION         | character |

## Details

     nba_playervsplayer(player_id = '2544', vs_player_id = '203076')

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
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md)

## Author

Saiem Gilani
