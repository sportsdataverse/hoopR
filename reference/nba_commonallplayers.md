# **Get NBA Stats API All Players**

**Get NBA Stats API All Players**

**Get NBA Stats API All Players**

**Get NBA Stats API Player Info**

**Get NBA Stats API Player Info**

**Get NBA Stats API Playoff Series**

**Get NBA Stats API Playoff Series**

**Get NBA Stats API Team Roster**

**Get NBA Stats API Team Roster**

**Get NBA Stats API Common Team Years**

**Get NBA Stats API Common Team Years**

## Usage

``` r
nba_commonallplayers(
  is_only_current_season = 0,
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)

nba_commonplayerinfo(league_id = "00", player_id = "2544", ...)

nba_commonplayoffseries(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 2),
  series_id = "",
  ...
)

nba_commonteamroster(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  team_id = "1610612739",
  ...
)

nba_commonteamyears(league_id = "00", ...)
```

## Arguments

- is_only_current_season:

  is_only_current_season

- league_id:

  league_id

- season:

  season

- ...:

  Additional arguments passed to an underlying function like httr.

- player_id:

  player_id

- series_id:

  series_id

- team_id:

  team_id

## Value

Return a named list of data frames: CommonAllPlayers

**CommonAllPlayers**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| DISPLAY_LAST_COMMA_FIRST | character |  |
| DISPLAY_FIRST_LAST | character |  |
| ROSTERSTATUS | character |  |
| FROM_YEAR | character |  |
| TO_YEAR | character |  |
| PLAYERCODE | character |  |
| PLAYER_SLUG | character | URL-safe player identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CODE | character |  |
| TEAM_SLUG | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| GAMES_PLAYED_FLAG | character |  |
| OTHERLEAGUE_EXPERIENCE_CH | character |  |

Return a named list of data frames: CommonPlayerInfo,
PlayerHeadlineStats, AvailableSeasons

**CommonPlayerInfo**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| FIRST_NAME | character | Player's first name. |
| LAST_NAME | character | Player's last name. |
| DISPLAY_FIRST_LAST | character |  |
| DISPLAY_LAST_COMMA_FIRST | character |  |
| DISPLAY_FI_LAST | character |  |
| PLAYER_SLUG | character | URL-safe player identifier. |
| BIRTHDATE | character |  |
| SCHOOL | character | Player's school / college (when distinct from 'college'). |
| COUNTRY | character | Country (full name or code). |
| LAST_AFFILIATION | character |  |
| HEIGHT | character | Player height (string e.g. '6-2' or inches). |
| WEIGHT | character | Player weight in pounds. |
| SEASON_EXP | character |  |
| JERSEY | character | Jersey number worn by the player. |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| ROSTERSTATUS | character |  |
| GAMES_PLAYED_CURRENT_SEASON_FLAG | character |  |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_CODE | character |  |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| PLAYERCODE | character |  |
| FROM_YEAR | character |  |
| TO_YEAR | character |  |
| DLEAGUE_FLAG | character |  |
| NBA_FLAG | character |  |
| GAMES_PLAYED_FLAG | character |  |
| DRAFT_YEAR | character | Draft year (4-digit). |
| DRAFT_ROUND | character | Round of the draft selection. |
| DRAFT_NUMBER | character |  |
| GREATEST_75_FLAG | character |  |

**PlayerHeadlineStats**

|             |           |                               |
|-------------|-----------|-------------------------------|
| col_name    | types     | description                   |
| PLAYER_ID   | character | Unique player identifier.     |
| PLAYER_NAME | character | Player name.                  |
| TimeFrame   | character |                               |
| PTS         | character | Points scored.                |
| AST         | character | Assists.                      |
| REB         | character | Total rebounds.               |
| PIE         | character | Player Impact Estimate (0-1). |

**AvailableSeasons**

|           |           |                           |
|-----------|-----------|---------------------------|
| col_name  | types     | description               |
| SEASON_ID | character | Unique season identifier. |

Return a named list of data frames: PlayoffSeries

**PlayoffSeries**

|                 |           |                                      |
|-----------------|-----------|--------------------------------------|
| col_name        | types     | description                          |
| GAME_ID         | character | Unique game identifier.              |
| HOME_TEAM_ID    | character | Unique identifier for the home team. |
| VISITOR_TEAM_ID | character |                                      |
| SERIES_ID       | character |                                      |
| GAME_NUM        | character |                                      |

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

Returns a named list of data frames: TeamYears

**TeamYears**

|              |           |                                  |
|--------------|-----------|----------------------------------|
| col_name     | types     | description                      |
| LEAGUE_ID    | character | League identifier ('10' = WNBA). |
| TEAM_ID      | character | Unique team identifier.          |
| MIN_YEAR     | character |                                  |
| MAX_YEAR     | character |                                  |
| ABBREVIATION | character | Short abbreviation.              |

## Details

[All Players](https://www.nba.com/players)

      nba_commonallplayers(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[Player Info](https://www.nba.com/stats/player/2544)

     nba_commonplayerinfo(league_id = '00', player_id = '2544')

     nba_commonplayoffseries(league_id = '00', season = year_to_season(most_recent_nba_season() - 2))

[Team Roster](https://www.nba.com/stats/team/1610612756)

     nba_commonteamroster(season = year_to_season(most_recent_nba_season() - 1), team_id = '1610612739')

     nba_commonteamyears(league_id = '00')

## Author

Saiem Gilani
