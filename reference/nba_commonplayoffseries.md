# **Get NBA Stats API Playoff Series**

**Get NBA Stats API Playoff Series**

**Get NBA Stats API Playoff Series**

## Usage

``` r
nba_commonplayoffseries(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 2),
  series_id = "",
  ...
)
```

## Arguments

- league_id:

  league_id

- season:

  season

- series_id:

  series_id

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: PlayoffSeries

**PlayoffSeries**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| GAME_ID         | character |
| HOME_TEAM_ID    | character |
| VISITOR_TEAM_ID | character |
| SERIES_ID       | character |
| GAME_NUM        | character |

## Details

     nba_commonplayoffseries(league_id = '00', season = year_to_season(most_recent_nba_season() - 2))

## Author

Saiem Gilani
