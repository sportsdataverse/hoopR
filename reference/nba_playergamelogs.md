# **Get NBA Stats API Player Game Logs**

**Get NBA Stats API Player Game Logs**

**Get NBA Stats API Player Game Logs**

## Usage

``` r
nba_playergamelogs(
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
  per_mode = "Totals",
  period = 0,
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
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

- po_round:

  po_round

- per_mode:

  per_mode

- period:

  period

- player_id:

  Player ID

- season:

  Season - format 2020-21

- season_segment:

  season_segment

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: PlayerGameLogs

**PlayerGameLogs**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| SEASON_YEAR           | character |
| PLAYER_ID             | character |
| PLAYER_NAME           | character |
| NICKNAME              | character |
| TEAM_ID               | character |
| TEAM_ABBREVIATION     | character |
| TEAM_NAME             | character |
| GAME_ID               | character |
| GAME_DATE             | character |
| MATCHUP               | character |
| WL                    | character |
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
| VIDEO_AVAILABLE_FLAG  | character |

## Details

[Player Game
Logs](https://www.nba.com/stats/player/2544/boxscores-traditional)

     nba_playergamelogs(player_id = '2544')

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
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md),
[`nba_playerheadshot()`](https://hoopR.sportsdataverse.org/reference/nba_playerheadshot.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md),
[`nba_playernextngames()`](https://hoopR.sportsdataverse.org/reference/nba_playernextngames.md),
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

## Author

Saiem Gilani
