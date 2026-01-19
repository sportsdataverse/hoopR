# **Get NBA Stats API Cumulative Player Game Stats**

**Get NBA Stats API Cumulative Player Game Stats**

**Get NBA Stats API Cumulative Player Game Stats**

## Usage

``` r
nba_cumestatsplayergames(
  league_id = "00",
  location = "",
  outcome = "",
  player_id = "2544",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
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

- player_id:

  player_id

- season:

  season

- season_type:

  season_type

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_team_id:

  vs_team_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: CumeStatsPlayerGames

**CumeStatsPlayerGames**

|          |           |
|----------|-----------|
| col_name | types     |
| MATCHUP  | character |
| GAME_ID  | character |

## Details

[CUME Stats](https://www.nba.com/stats/cumestats)

     nba_cumestatsplayergames(player_id = '2544')

## See also

Other NBA Cume Functions:
[`nba_cumestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsplayer.md),
[`nba_cumestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsteam.md),
[`nba_cumestatsteamgames()`](https://hoopR.sportsdataverse.org/reference/nba_cumestatsteamgames.md)

## Author

Saiem Gilani
