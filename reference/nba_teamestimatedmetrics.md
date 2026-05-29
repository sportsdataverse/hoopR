# **Get NBA Stats API Team Estimated Metrics**

**Get NBA Stats API Team Estimated Metrics**

**Get NBA Stats API Team Estimated Metrics**

## Usage

``` r
nba_teamestimatedmetrics(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: TeamEstimatedMetrics

**TeamEstimatedMetrics**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ID | character | Unique team identifier. |
| GP | character | Games played. |
| W | character | Wins. |
| L | character | Losses. |
| W_PCT | character |  |
| MIN | character | Minutes played. |
| E_OFF_RATING | character |  |
| E_DEF_RATING | character |  |
| E_NET_RATING | character |  |
| E_PACE | character |  |
| E_AST_RATIO | character |  |
| E_OREB_PCT | character |  |
| E_DREB_PCT | character |  |
| E_REB_PCT | character |  |
| E_TM_TOV_PCT | character |  |
| GP_RANK | character |  |
| W_RANK | character |  |
| L_RANK | character |  |
| W_PCT_RANK | character |  |
| MIN_RANK | character |  |
| E_OFF_RATING_RANK | character |  |
| E_DEF_RATING_RANK | character |  |
| E_NET_RATING_RANK | character |  |
| E_AST_RATIO_RANK | character |  |
| E_OREB_PCT_RANK | character |  |
| E_DREB_PCT_RANK | character |  |
| E_REB_PCT_RANK | character |  |
| E_TM_TOV_PCT_RANK | character |  |
| E_PACE_RANK | character |  |

## Details

[Team Estimated
Metrics](https://www.nba.com/stats/teams/estimated-advanced)

     nba_teamestimatedmetrics()

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
[`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md),
[`nba_teamgamelog()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelog.md),
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
