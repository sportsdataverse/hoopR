# **Get NBA Stats API Player Career Stats**

**Get NBA Stats API Player Career Stats**

**Get NBA Stats API Player Career Stats**

## Usage

``` r
nba_playercareerstats(
  league_id = "00",
  per_mode = "Totals",
  player_id = "2544",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Per Mode - PerGame, Totals

- player_id:

  Player ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: CareerTotalsAllStarSeason,
CareerTotalsCollegeSeason, CareerTotalsPostSeason,
CareerTotalsRegularSeason, SeasonRankingsPostSeason,
SeasonRankingsRegularSeason, SeasonTotalsAllStarSeason,
SeasonTotalsCollegeSeason, SeasonTotalsPostSeason,
SeasonTotalsRegularSeason

**SeasonTotalsRegularSeason**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| PLAYER_ID         | character |
| SEASON_ID         | character |
| LEAGUE_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| PLAYER_AGE        | character |
| GP                | character |
| GS                | character |
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
| STL               | character |
| BLK               | character |
| TOV               | character |
| PF                | character |
| PTS               | character |

**CareerTotalsRegularSeason**

|           |           |
|-----------|-----------|
| col_name  | types     |
| PLAYER_ID | character |
| LEAGUE_ID | character |
| Team_ID   | character |
| GP        | character |
| GS        | character |
| MIN       | character |
| FGM       | character |
| FGA       | character |
| FG_PCT    | character |
| FG3M      | character |
| FG3A      | character |
| FG3_PCT   | character |
| FTM       | character |
| FTA       | character |
| FT_PCT    | character |
| OREB      | character |
| DREB      | character |
| REB       | character |
| AST       | character |
| STL       | character |
| BLK       | character |
| TOV       | character |
| PF        | character |
| PTS       | character |

**SeasonTotalsPostSeason**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| PLAYER_ID         | character |
| SEASON_ID         | character |
| LEAGUE_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| PLAYER_AGE        | character |
| GP                | character |
| GS                | character |
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
| STL               | character |
| BLK               | character |
| TOV               | character |
| PF                | character |
| PTS               | character |

**CareerTotalsPostSeason**

|           |           |
|-----------|-----------|
| col_name  | types     |
| PLAYER_ID | character |
| LEAGUE_ID | character |
| Team_ID   | character |
| GP        | character |
| GS        | character |
| MIN       | character |
| FGM       | character |
| FGA       | character |
| FG_PCT    | character |
| FG3M      | character |
| FG3A      | character |
| FG3_PCT   | character |
| FTM       | character |
| FTA       | character |
| FT_PCT    | character |
| OREB      | character |
| DREB      | character |
| REB       | character |
| AST       | character |
| STL       | character |
| BLK       | character |
| TOV       | character |
| PF        | character |
| PTS       | character |

**SeasonTotalsAllStarSeason**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| PLAYER_ID         | character |
| SEASON_ID         | character |
| LEAGUE_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| PLAYER_AGE        | character |
| GP                | character |
| GS                | character |
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
| STL               | character |
| BLK               | character |
| TOV               | character |
| PF                | character |
| PTS               | character |

**CareerTotalsAllStarSeason**

|           |           |
|-----------|-----------|
| col_name  | types     |
| PLAYER_ID | character |
| LEAGUE_ID | character |
| Team_ID   | character |
| GP        | character |
| GS        | character |
| MIN       | character |
| FGM       | character |
| FGA       | character |
| FG_PCT    | character |
| FG3M      | character |
| FG3A      | character |
| FG3_PCT   | character |
| FTM       | character |
| FTA       | character |
| FT_PCT    | character |
| OREB      | character |
| DREB      | character |
| REB       | character |
| AST       | character |
| STL       | character |
| BLK       | character |
| TOV       | character |
| PF        | character |
| PTS       | character |

**SeasonTotalsCollegeSeason**

**CareerTotalsCollegeSeason**

**SeasonTotalsShowcaseSeason**

**CareerTotalsShowcaseSeason**

**SeasonRankingsRegularSeason**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| PLAYER_ID         | character |
| SEASON_ID         | character |
| LEAGUE_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| PLAYER_AGE        | character |
| GP                | character |
| GS                | character |
| RANK_MIN          | character |
| RANK_FGM          | character |
| RANK_FGA          | character |
| RANK_FG_PCT       | character |
| RANK_FG3M         | character |
| RANK_FG3A         | character |
| RANK_FG3_PCT      | character |
| RANK_FTM          | character |
| RANK_FTA          | character |
| RANK_FT_PCT       | character |
| RANK_OREB         | character |
| RANK_DREB         | character |
| RANK_REB          | character |
| RANK_AST          | character |
| RANK_STL          | character |
| RANK_BLK          | character |
| RANK_TOV          | character |
| RANK_PTS          | character |
| RANK_EFF          | character |

**SeasonRankingsPostSeason**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| PLAYER_ID         | character |
| SEASON_ID         | character |
| LEAGUE_ID         | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| PLAYER_AGE        | character |
| GP                | character |
| GS                | character |
| RANK_MIN          | character |
| RANK_FGM          | character |
| RANK_FGA          | character |
| RANK_FG_PCT       | character |
| RANK_FG3M         | character |
| RANK_FG3A         | character |
| RANK_FG3_PCT      | character |
| RANK_FTM          | character |
| RANK_FTA          | character |
| RANK_FT_PCT       | character |
| RANK_OREB         | character |
| RANK_DREB         | character |
| RANK_REB          | character |
| RANK_AST          | character |
| RANK_STL          | character |
| RANK_BLK          | character |
| RANK_TOV          | character |
| RANK_PTS          | character |
| RANK_EFF          | character |

## Details

[Player Career Stats](https://www.nba.com/stats/player/2544/career)

     nba_playercareerstats(player_id = '2544')

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
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

## Author

Saiem Gilani
