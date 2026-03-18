# **Get NBA Stats API Leaders Tiles**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)
instead.

## Usage

``` r
nba_leaderstiles(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat = "PTS",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- game_scope:

  Game Scope - Season, Last 10, ,Yesterday, Finals

- player_or_team:

  Player or Team

- player_scope:

  Player Scope - All Players, Rookies

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs

- stat:

  Stat - PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: AllTimeSeasonHigh, LastSeasonHigh,
LeadersTiles, LowSeasonHigh,

**LeadersTiles**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| RANK              | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| PTS               | character |

**AllTimeSeasonHigh**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| SEASON_YEAR       | character |
| PTS               | character |

**LastSeasonHigh**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| RANK              | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| PTS               | character |

**LowSeasonHigh**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| SEASON_YEAR       | character |
| PTS               | character |

## Details

     nba_leaderstiles(league_id = '00', player_or_team = "Player")
     nba_leaderstiles(league_id = '00', player_or_team = "Team")

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
