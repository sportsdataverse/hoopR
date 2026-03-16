# **Get NBA Stats API Homepage Leaders**

**Get NBA Stats API Homepage Leaders**

**Get NBA Stats API Homepage Leaders**

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

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| RANK              | character |
| TEAM_ID           | character |
| TEAM_NAME         | character |
| TEAM_ABBREVIATION | character |
| PTS               | character |
| FG_PCT            | character |
| FG3_PCT           | character |
| FT_PCT            | character |
| EFG_PCT           | character |
| TS_PCT            | character |
| PTS_PER48         | character |

**LeagueAverage**

|           |         |
|-----------|---------|
| col_name  | types   |
| PTS       | numeric |
| FG_PCT    | numeric |
| FG3_PCT   | numeric |
| FT_PCT    | numeric |
| EFG_PCT   | numeric |
| TS_PCT    | numeric |
| PTS_PER48 | numeric |

**LeagueMax**

|           |         |
|-----------|---------|
| col_name  | types   |
| PTS       | numeric |
| FG_PCT    | numeric |
| FG3_PCT   | numeric |
| FT_PCT    | numeric |
| EFG_PCT   | numeric |
| TS_PCT    | numeric |
| PTS_PER48 | numeric |

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
