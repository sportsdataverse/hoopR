# **Get G League Schedule from NBA API**

Retrieves G-League schedule data via the NBA Stats API schedule
endpoint.

## Usage

``` r
nbagl_schedule(
  league_id = "20",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)
```

## Arguments

- league_id:

  League - default: '20' (G-League).

- season:

  Season - format 2020-21.

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame of the G League Season Schedule

|                         |           |
|-------------------------|-----------|
| col_name                | types     |
| game_date               | date      |
| game_id                 | character |
| game_code               | character |
| game_status             | integer   |
| game_status_text        | character |
| game_sequence           | integer   |
| game_date_est           | character |
| game_time_est           | character |
| game_date_utc           | character |
| game_time_utc           | character |
| arena_name              | character |
| arena_state             | character |
| arena_city              | character |
| home_team_id            | character |
| home_team_name          | character |
| home_team_tricode       | character |
| home_team_score         | character |
| away_team_id            | character |
| away_team_name          | character |
| away_team_tricode       | character |
| away_team_score         | character |
| season                  | character |
| league_id               | character |
| season_type_id          | character |
| season_type_description | character |

## Details

     nbagl_schedule(season = most_recent_nba_season() - 1)

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
