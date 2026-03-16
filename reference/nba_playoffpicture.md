# **Get NBA Stats API Playoff Picture**

**Get NBA Stats API Playoff Picture**

**Get NBA Stats API Playoff Picture**

## Usage

``` r
nba_playoffpicture(league_id = "00", season_id = "22022", ...)
```

## Arguments

- league_id:

  league_id

- season_id:

  season_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: EastConfPlayoffPicture,
EastConfRemainingGames, EastConfStandings, WestConfPlayoffPicture,
WestConfRemainingGames, WestConfStandings

**EastConfPlayoffPicture**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| CONFERENCE                        | character |
| HIGH_SEED_RANK                    | character |
| HIGH_SEED_TEAM                    | character |
| HIGH_SEED_TEAM_ID                 | character |
| LOW_SEED_RANK                     | character |
| LOW_SEED_TEAM                     | character |
| LOW_SEED_TEAM_ID                  | character |
| HIGH_SEED_SERIES_W                | character |
| HIGH_SEED_SERIES_L                | character |
| HIGH_SEED_SERIES_REMAINING_G      | character |
| HIGH_SEED_SERIES_REMAINING_HOME_G | character |
| HIGH_SEED_SERIES_REMAINING_AWAY_G | character |

**WestConfPlayoffPicture**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| CONFERENCE                        | character |
| HIGH_SEED_RANK                    | character |
| HIGH_SEED_TEAM                    | character |
| HIGH_SEED_TEAM_ID                 | character |
| LOW_SEED_RANK                     | character |
| LOW_SEED_TEAM                     | character |
| LOW_SEED_TEAM_ID                  | character |
| HIGH_SEED_SERIES_W                | character |
| HIGH_SEED_SERIES_L                | character |
| HIGH_SEED_SERIES_REMAINING_G      | character |
| HIGH_SEED_SERIES_REMAINING_HOME_G | character |
| HIGH_SEED_SERIES_REMAINING_AWAY_G | character |

**EastConfStandings**

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| CONFERENCE          | character |
| RANK                | character |
| TEAM                | character |
| TEAM_SLUG           | character |
| TEAM_ID             | character |
| WINS                | character |
| LOSSES              | character |
| PCT                 | character |
| DIV                 | character |
| CONF                | character |
| HOME                | character |
| AWAY                | character |
| GB                  | character |
| GR_OVER_500         | character |
| GR_OVER_500_HOME    | character |
| GR_OVER_500_AWAY    | character |
| GR_UNDER_500        | character |
| GR_UNDER_500_HOME   | character |
| GR_UNDER_500_AWAY   | character |
| RANKING_CRITERIA    | character |
| CLINCHED_PLAYOFFS   | character |
| CLINCHED_CONFERENCE | character |
| CLINCHED_DIVISION   | character |
| ELIMINATED_PLAYOFFS | character |
| SOSA_REMAINING      | character |

**WestConfStandings**

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| CONFERENCE          | character |
| RANK                | character |
| TEAM                | character |
| TEAM_SLUG           | character |
| TEAM_ID             | character |
| WINS                | character |
| LOSSES              | character |
| PCT                 | character |
| DIV                 | character |
| CONF                | character |
| HOME                | character |
| AWAY                | character |
| GB                  | character |
| GR_OVER_500         | character |
| GR_OVER_500_HOME    | character |
| GR_OVER_500_AWAY    | character |
| GR_UNDER_500        | character |
| GR_UNDER_500_HOME   | character |
| GR_UNDER_500_AWAY   | character |
| RANKING_CRITERIA    | character |
| CLINCHED_PLAYOFFS   | character |
| CLINCHED_CONFERENCE | character |
| CLINCHED_DIVISION   | character |
| ELIMINATED_PLAYOFFS | character |
| SOSA_REMAINING      | character |

**EastConfRemainingGames**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| TEAM             | character |
| TEAM_ID          | character |
| REMAINING_G      | character |
| REMAINING_HOME_G | character |
| REMAINING_AWAY_G | character |

**WestConfRemainingGames**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| TEAM             | character |
| TEAM_ID          | character |
| REMAINING_G      | character |
| REMAINING_HOME_G | character |
| REMAINING_AWAY_G | character |

## Details

     nba_playoffpicture(league_id = '00', season_id = paste0(2, most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md),
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md),
[`nba_leaguedashplayerclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerclutch.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_leaguegamefinder()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamefinder.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamelog.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_leagueplayerondetails()`](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails.md),
[`nba_leagueseasonmatchups()`](https://hoopR.sportsdataverse.org/reference/nba_leagueseasonmatchups.md),
[`nba_leaguestandings()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandings.md),
[`nba_leaguestandingsv3()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandingsv3.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md)

## Author

Saiem Gilani
