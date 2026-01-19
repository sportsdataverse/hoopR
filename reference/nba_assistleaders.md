# **Get NBA Stats API Assist Leaders**

**Get NBA Stats API Assist Leaders**

**Get NBA Stats API Assist Leaders**

## Usage

``` r
nba_assistleaders(
  league_id = "00",
  per_mode = "PerGame",
  player_or_team = "Team",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- per_mode:

  Per Mode - PerGame, Totals

- player_or_team:

  Player or Team

- season:

  Season - format 2020-21

- season_type:

  Season Type - Regular Season, Playoffs, All-Star

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: AssistLeaders

**AssistLeaders**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| RANK              | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| AST               | character |

## Details

     nba_assistleaders(league_id = '00', player_or_team = "Player")
     nba_assistleaders(league_id = '00', player_or_team = "Team")

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
