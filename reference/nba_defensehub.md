# **Get NBA Stats API Defense Hub**

**Get NBA Stats API Defense Hub**

**Get NBA Stats API Defense Hub**

## Usage

``` r
nba_defensehub(
  league_id = "00",
  game_scope = "Season",
  player_or_team = "Team",
  player_scope = "All Players",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
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

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: DefenseHubStat1, DefenseHubStat10,
DefenseHubStat2, DefenseHubStat3, DefenseHubStat4, DefenseHubStat5,
DefenseHubStat6, DefenseHubStat7, DefenseHubStat8, DefenseHubStat9

## Details

(Possibly Deprecated)

     nba_defensehub(league_id = '00', player_or_team = "Player")
     nba_defensehub(league_id = '00', player_or_team = "Team")

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
