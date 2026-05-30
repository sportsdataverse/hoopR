# **Get NBA Stats API Team Details**

**Get NBA Stats API Team Details**

**Get NBA Stats API Team Details**

## Usage

``` r
nba_teamdetails(team_id = "1610612749", ...)
```

## Arguments

- team_id:

  Team ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: TeamAwardsChampionships,
TeamAwardsConf, TeamAwardsDiv, TeamBackground, TeamHistory, TeamHof,
TeamRetired, TeamSocialSites

**TeamBackground**

|                    |           |                           |
|--------------------|-----------|---------------------------|
| col_name           | types     | description               |
| TEAM_ID            | character | Unique team identifier.   |
| ABBREVIATION       | character | Short abbreviation.       |
| NICKNAME           | character | Team or athlete nickname. |
| YEARFOUNDED        | character |                           |
| CITY               | character | City.                     |
| ARENA              | character | Arena.                    |
| ARENACAPACITY      | character |                           |
| OWNER              | character |                           |
| GENERALMANAGER     | character |                           |
| HEADCOACH          | character |                           |
| DLEAGUEAFFILIATION | character |                           |

**TeamHistory**

|                |           |                           |
|----------------|-----------|---------------------------|
| col_name       | types     | description               |
| TEAM_ID        | character | Unique team identifier.   |
| CITY           | character | City.                     |
| NICKNAME       | character | Team or athlete nickname. |
| YEARFOUNDED    | character |                           |
| YEARACTIVETILL | character |                           |

**TeamSocialSites**

|              |           |             |
|--------------|-----------|-------------|
| col_name     | types     | description |
| ACCOUNTTYPE  | character |             |
| WEBSITE_LINK | character |             |

**TeamAwardsChampionships**

|              |           |             |
|--------------|-----------|-------------|
| col_name     | types     | description |
| YEARAWARDED  | character |             |
| OPPOSITETEAM | character |             |

**TeamAwardsConf**

|              |         |             |
|--------------|---------|-------------|
| col_name     | types   | description |
| YEARAWARDED  | integer |             |
| OPPOSITETEAM | integer |             |

**TeamAwardsDiv**

|              |         |             |
|--------------|---------|-------------|
| col_name     | types   | description |
| YEARAWARDED  | integer |             |
| OPPOSITETEAM | integer |             |

**TeamHof**

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| PLAYERID        | character | Playerid.                               |
| PLAYER          | character | Player.                                 |
| POSITION        | character | Listed roster position (G, F, C, etc.). |
| JERSEY          | character | Jersey number worn by the player.       |
| SEASONSWITHTEAM | character |                                         |
| YEAR            | character | 4-digit year.                           |

**TeamRetired**

|                 |           |                                         |
|-----------------|-----------|-----------------------------------------|
| col_name        | types     | description                             |
| PLAYERID        | character | Playerid.                               |
| PLAYER          | character | Player.                                 |
| POSITION        | character | Listed roster position (G, F, C, etc.). |
| JERSEY          | character | Jersey number worn by the player.       |
| SEASONSWITHTEAM | character |                                         |
| YEAR            | character | 4-digit year.                           |

## Details

     nba_teamdetails(team_id = '1610612749')

## See also

Other NBA Team Functions:
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md),
[`nba_teamdashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashlineups.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
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
