# **Get NBA Stats API Team Game Log**

**Get NBA Stats API Team Game Log**

**Get NBA Stats API Team Game Log**

## Usage

``` r
nba_teamgamelog(
  date_from = "",
  date_to = "",
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "1610612749",
  ...
)
```

## Arguments

- date_from:

  date_from

- date_to:

  date_to

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- team_id:

  Team ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: TeamGameLog

**TeamGameLog**

|           |           |                                          |
|-----------|-----------|------------------------------------------|
| col_name  | types     | description                              |
| Team_ID   | character | Unique team identifier.                  |
| Game_ID   | character | Unique game identifier.                  |
| GAME_DATE | character | Game date (YYYY-MM-DD).                  |
| MATCHUP   | character | Matchup.                                 |
| WL        | character | Wl.                                      |
| W         | character | Wins.                                    |
| L         | character | Losses.                                  |
| W_PCT     | character |                                          |
| MIN       | character | Minutes played.                          |
| FGM       | character | Field goals made.                        |
| FGA       | character | Field goal attempts.                     |
| FG_PCT    | character | Field goal percentage (0-1).             |
| FG3M      | character | Three-point field goals made.            |
| FG3A      | character | Three-point field goal attempts.         |
| FG3_PCT   | character | Three-point field goal percentage (0-1). |
| FTM       | character | Free throws made.                        |
| FTA       | character | Free throw attempts.                     |
| FT_PCT    | character | Free throw percentage (0-1).             |
| OREB      | character | Offensive rebounds.                      |
| DREB      | character | Defensive rebounds.                      |
| REB       | character | Total rebounds.                          |
| AST       | character | Assists.                                 |
| STL       | character | Steals.                                  |
| BLK       | character | Blocks.                                  |
| TOV       | character | Turnovers.                               |
| PF        | character | Personal fouls.                          |
| PTS       | character | Points scored.                           |

## Details

[Teams Game Log](https://www.nba.com/stats/team/1610612749/boxscores)

     nba_teamgamelog(team_id = '1610612749')

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_teamdetails()`](https://hoopR.sportsdataverse.org/reference/nba_teamdetails.md),
[`nba_teamestimatedmetrics()`](https://hoopR.sportsdataverse.org/reference/nba_teamestimatedmetrics.md),
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
