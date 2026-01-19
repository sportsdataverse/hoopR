# **Get NBA Stats API Cumulative Team Game Stats**

**Get NBA Stats API Cumulative Team Game Stats**

**Get NBA Stats API Cumulative Team Game Stats**

## Usage

``` r
nba_cumestatsteamgames(
  league_id = "00",
  location = "",
  outcome = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_id = "",
  season_type = "Regular Season",
  team_id = 1610612739,
  vs_conference = "",
  vs_division = "",
  vs_team_id = "",
  ...
)
```

## Arguments

- league_id:

  league_id

- location:

  location

- outcome:

  outcome

- season:

  season

- season_id:

  season_id

- season_type:

  season_type

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_team_id:

  vs_team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: CumeStatsTeamGames

**CumeStatsTeamGames**

|          |           |
|----------|-----------|
| col_name | types     |
| MATCHUP  | character |
| GAME_ID  | character |

## Details

[CUME Stats](https://www.nba.com/stats/cumestats)

     nba_cumestatsteamgames(team_id = 1610612739, season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Cume Functions:
[`nba_cumestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayer.md),
[`nba_cumestatsplayergames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayergames.md),
[`nba_cumestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsteam.md)

## Author

Saiem Gilani
