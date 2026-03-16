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

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| TEAM_NAME         | character |
| TEAM_ID           | character |
| GP                | character |
| W                 | character |
| L                 | character |
| W_PCT             | character |
| MIN               | character |
| E_OFF_RATING      | character |
| E_DEF_RATING      | character |
| E_NET_RATING      | character |
| E_PACE            | character |
| E_AST_RATIO       | character |
| E_OREB_PCT        | character |
| E_DREB_PCT        | character |
| E_REB_PCT         | character |
| E_TM_TOV_PCT      | character |
| GP_RANK           | character |
| W_RANK            | character |
| L_RANK            | character |
| W_PCT_RANK        | character |
| MIN_RANK          | character |
| E_OFF_RATING_RANK | character |
| E_DEF_RATING_RANK | character |
| E_NET_RATING_RANK | character |
| E_AST_RATIO_RANK  | character |
| E_OREB_PCT_RANK   | character |
| E_DREB_PCT_RANK   | character |
| E_REB_PCT_RANK    | character |
| E_TM_TOV_PCT_RANK | character |
| E_PACE_RANK       | character |

## Details

[Team Estimated
Metrics](https://www.nba.com/stats/teams/estimated-advanced)

     nba_teamestimatedmetrics()

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
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
