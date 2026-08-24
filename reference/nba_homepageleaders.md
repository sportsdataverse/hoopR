# **Get NBA Stats API Homepage Leaders**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)
instead. Note: `stat_category = "Defense"` was never supported upstream
by this endpoint even before deprecation (#51).

## Usage

``` r
nba_homepageleaders(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  stat_category = "Points",
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

- stat_category:

  Stat Category: Points, Rebounds, Assists, Defense, Clutch, Playmaking,
  Efficiency, Fast Break, Scoring Breakdown

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: HomePageLeaders, LeagueAverage,
LeagueMax

**HomePageLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| RANK | character | Rank. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| PTS | character | Points scored. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FT_PCT | character | Free throw percentage (0-1). |
| EFG_PCT | character | Effective field goal percentage (0-1). |
| TS_PCT | character | True shooting percentage (0-1). |
| PTS_PER48 | character |  |

**LeagueAverage**

|           |         |                                          |
|-----------|---------|------------------------------------------|
| col_name  | types   | description                              |
| PTS       | numeric | Points scored.                           |
| FG_PCT    | numeric | Field goal percentage (0-1).             |
| FG3_PCT   | numeric | Three-point field goal percentage (0-1). |
| FT_PCT    | numeric | Free throw percentage (0-1).             |
| EFG_PCT   | numeric | Effective field goal percentage (0-1).   |
| TS_PCT    | numeric | True shooting percentage (0-1).          |
| PTS_PER48 | numeric |                                          |

**LeagueMax**

Same columns as the **LeagueAverage** table above.

## Details

     nba_homepageleaders(league_id = '00', player_or_team = "Player")
     nba_homepageleaders(league_id = '00', player_or_team = "Team")

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
