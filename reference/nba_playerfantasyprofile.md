# **Get NBA Stats API Player Fantasy Profile**

**Get NBA Stats API Player Fantasy Profile**

**Get NBA Stats API Player Fantasy Profile**

## Usage

``` r
nba_playerfantasyprofile(
  league_id = "00",
  measure_type = "Base",
  pace_adjust = "N",
  per_mode = "Totals",
  player_id = "2544",
  plus_minus = "N",
  rank = "N",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- measure_type:

  measure_type

- pace_adjust:

  Pace Adjustment - Y/N

- per_mode:

  Per Mode - PerGame, Totals

- player_id:

  Player ID

- plus_minus:

  Plus Minus - Y/N

- rank:

  Rank - Y/N

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: DaysRestModified, LastNGames,
Location, Opponent, Overall

**Overall**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| GROUP_VALUE     | character |                                               |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| DD2             | character |                                               |
| TD3             | character |                                               |
| FAN_DUEL_PTS    | character |                                               |
| NBA_FANTASY_PTS | character |                                               |

**Location**

Same columns as the **Overall** table above.

**LastNGames**

Same columns as the **Overall** table above.

**DaysRestModified**

|                 |           |                                               |
|-----------------|-----------|-----------------------------------------------|
| col_name        | types     | description                                   |
| GROUP_SET       | character |                                               |
| GROUP_VALUE     | character |                                               |
| SEASON_YEAR     | character | Season year string ('YYYY-YY' format).        |
| GP              | character | Games played.                                 |
| W               | character | Wins.                                         |
| L               | character | Losses.                                       |
| W_PCT           | character |                                               |
| MIN             | character | Minutes played.                               |
| FGM             | character | Field goals made.                             |
| FGA             | character | Field goal attempts.                          |
| FG_PCT          | character | Field goal percentage (0-1).                  |
| FG3M            | character | Three-point field goals made.                 |
| FG3A            | character | Three-point field goal attempts.              |
| FG3_PCT         | character | Three-point field goal percentage (0-1).      |
| FTM             | character | Free throws made.                             |
| FTA             | character | Free throw attempts.                          |
| FT_PCT          | character | Free throw percentage (0-1).                  |
| OREB            | character | Offensive rebounds.                           |
| DREB            | character | Defensive rebounds.                           |
| REB             | character | Total rebounds.                               |
| AST             | character | Assists.                                      |
| TOV             | character | Turnovers.                                    |
| STL             | character | Steals.                                       |
| BLK             | character | Blocks.                                       |
| BLKA            | character |                                               |
| PF              | character | Personal fouls.                               |
| PFD             | character |                                               |
| PTS             | character | Points scored.                                |
| PLUS_MINUS      | character | Plus/minus point differential while on court. |
| DD2             | character |                                               |
| TD3             | character |                                               |
| FAN_DUEL_PTS    | character |                                               |
| NBA_FANTASY_PTS | character |                                               |

**Opponent**

Same columns as the **Overall** table above.

## Details

     nba_playerfantasyprofile(player_id = '2544')

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
[`nba_playerdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashboard.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_playerestimatedmetrics.md),
[`nba_playerfantasyprofilebargraph()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofilebargraph.md),
[`nba_playergamelog()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelog.md),
[`nba_playergamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_playergamelogs.md),
[`nba_playergamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_playergamestreakfinder.md),
[`nba_playerheadshot()`](https://hoopR.sportsdataverse.org/reference/nba_playerheadshot.md),
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md),
[`nba_playernextngames()`](https://hoopR.sportsdataverse.org/reference/nba_playernextngames.md),
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md),
[`nba_playervsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_playervsplayer.md)

Other NBA Fantasy Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_infographicfanduelplayer()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md),
[`nba_playerfantasyprofilebargraph()`](https://hoopR.sportsdataverse.org/reference/nba_playerfantasyprofilebargraph.md)

## Author

Saiem Gilani
