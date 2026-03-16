# **Get NBA Stats API Player Info**

**Get NBA Stats API Player Info**

**Get NBA Stats API Player Info**

## Usage

``` r
nba_commonplayerinfo(league_id = "00", player_id = "2544", ...)
```

## Arguments

- league_id:

  league_id

- player_id:

  player_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: CommonPlayerInfo,
PlayerHeadlineStats, AvailableSeasons

**CommonPlayerInfo**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| PERSON_ID                        | character |
| FIRST_NAME                       | character |
| LAST_NAME                        | character |
| DISPLAY_FIRST_LAST               | character |
| DISPLAY_LAST_COMMA_FIRST         | character |
| DISPLAY_FI_LAST                  | character |
| PLAYER_SLUG                      | character |
| BIRTHDATE                        | character |
| SCHOOL                           | character |
| COUNTRY                          | character |
| LAST_AFFILIATION                 | character |
| HEIGHT                           | character |
| WEIGHT                           | character |
| SEASON_EXP                       | character |
| JERSEY                           | character |
| POSITION                         | character |
| ROSTERSTATUS                     | character |
| GAMES_PLAYED_CURRENT_SEASON_FLAG | character |
| TEAM_ID                          | character |
| TEAM_NAME                        | character |
| TEAM_ABBREVIATION                | character |
| TEAM_CODE                        | character |
| TEAM_CITY                        | character |
| PLAYERCODE                       | character |
| FROM_YEAR                        | character |
| TO_YEAR                          | character |
| DLEAGUE_FLAG                     | character |
| NBA_FLAG                         | character |
| GAMES_PLAYED_FLAG                | character |
| DRAFT_YEAR                       | character |
| DRAFT_ROUND                      | character |
| DRAFT_NUMBER                     | character |
| GREATEST_75_FLAG                 | character |

**PlayerHeadlineStats**

|             |           |
|-------------|-----------|
| col_name    | types     |
| PLAYER_ID   | character |
| PLAYER_NAME | character |
| TimeFrame   | character |
| PTS         | character |
| AST         | character |
| REB         | character |
| PIE         | character |

**AvailableSeasons**

|           |           |
|-----------|-----------|
| col_name  | types     |
| SEASON_ID | character |

## Details

[Player Info](https://www.nba.com/stats/player/2544)

     nba_commonplayerinfo(league_id = '00', player_id = '2544')

## See also

Other NBA Roster Functions:
[`nba_commonallplayers()`](https://hoopR.sportsdataverse.org/reference/nba_commonallplayers.md),
[`nba_commonteamroster()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamroster.md),
[`nba_commonteamyears()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamyears.md)

## Author

Saiem Gilani
