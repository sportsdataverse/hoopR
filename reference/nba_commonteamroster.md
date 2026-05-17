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

|  |  |  |
|----|----|----|
| col_name | types | description |
| TeamID | character | Teamid. |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| LeagueID | character |  |
| PLAYER | character | Player. |
| NICKNAME | character | Team or athlete nickname. |
| PLAYER_SLUG | character | URL-safe player identifier. |
| NUM | character |  |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| HEIGHT | character | Player height (string e.g. '6-2' or inches). |
| WEIGHT | character | Player weight in pounds. |
| BIRTH_DATE | character | Date of birth (YYYY-MM-DD). |
| AGE | character | Player age (in years). |
| EXP | character | Exp. |
| SCHOOL | character | Player's school / college (when distinct from 'college'). |
| PLAYER_ID | character | Unique player identifier. |
| HOW_ACQUIRED | character |  |

**Coaches**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| SEASON | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| COACH_ID | character |  |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| COACH_NAME | character |  |
| IS_ASSISTANT | character |  |
| COACH_TYPE | character |  |
| SORT_SEQUENCE | character |  |
| SUB_SORT_SEQUENCE | character |  |

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
