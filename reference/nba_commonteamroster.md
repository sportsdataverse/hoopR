# **Get NBA Stats API Team Roster**

**Get NBA Stats API Team Roster**

**Get NBA Stats API Team Roster**

## Usage

``` r
nba_commonteamroster(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  team_id = "1610612739",
  ...
)
```

## Arguments

- league_id:

  league_id

- season:

  season

- team_id:

  team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: Coaches, CommonTeamRoster

**CommonTeamRoster**

|              |           |
|--------------|-----------|
| col_name     | types     |
| TeamID       | character |
| SEASON       | character |
| LeagueID     | character |
| PLAYER       | character |
| NICKNAME     | character |
| PLAYER_SLUG  | character |
| NUM          | character |
| POSITION     | character |
| HEIGHT       | character |
| WEIGHT       | character |
| BIRTH_DATE   | character |
| AGE          | character |
| EXP          | character |
| SCHOOL       | character |
| PLAYER_ID    | character |
| HOW_ACQUIRED | character |

**Coaches**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| TEAM_ID           | character |
| SEASON            | character |
| COACH_ID          | character |
| FIRST_NAME        | character |
| LAST_NAME         | character |
| COACH_NAME        | character |
| IS_ASSISTANT      | character |
| COACH_TYPE        | character |
| SORT_SEQUENCE     | character |
| SUB_SORT_SEQUENCE | character |

## Details

[Team Roster](https://www.nba.com/stats/team/1610612756)

     nba_commonteamroster(season = year_to_season(most_recent_nba_season() - 1), team_id = '1610612739')

## See also

Other NBA Roster Functions:
[`nba_commonallplayers()`](https://hoopR.sportsdataverse.org/reference/nba_commonallplayers.md),
[`nba_commonplayerinfo()`](https://hoopR.sportsdataverse.org/reference/nba_commonplayerinfo.md),
[`nba_commonteamyears()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamyears.md)

## Author

Saiem Gilani
