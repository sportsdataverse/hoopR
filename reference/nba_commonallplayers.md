# **Get NBA Stats API All Players**

**Get NBA Stats API All Players**

**Get NBA Stats API All Players**

## Usage

``` r
nba_commonallplayers(
  is_only_current_season = 0,
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)
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

## Value

Return a named list of data frames: CommonAllPlayers

**CommonAllPlayers**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| PERSON_ID                 | character |
| DISPLAY_LAST_COMMA_FIRST  | character |
| DISPLAY_FIRST_LAST        | character |
| ROSTERSTATUS              | character |
| FROM_YEAR                 | character |
| TO_YEAR                   | character |
| PLAYERCODE                | character |
| PLAYER_SLUG               | character |
| TEAM_ID                   | character |
| TEAM_CITY                 | character |
| TEAM_NAME                 | character |
| TEAM_ABBREVIATION         | character |
| TEAM_CODE                 | character |
| TEAM_SLUG                 | character |
| GAMES_PLAYED_FLAG         | character |
| OTHERLEAGUE_EXPERIENCE_CH | character |

## Details

[All Players](https://www.nba.com/players)

      nba_commonallplayers(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Roster Functions:
[`nba_commonplayerinfo()`](https://hoopR.sportsdataverse.org/reference/nba_commonplayerinfo.md),
[`nba_commonteamroster()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamroster.md)

## Author

Saiem Gilani
