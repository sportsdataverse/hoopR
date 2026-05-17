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

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | date | Game date (YYYY-MM-DD). |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_sequence | integer | Game sequence. |
| game_date_est | character | Game date est. |
| game_time_est | character | Game time est. |
| game_date_utc | character | Game date utc. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| arena_name | character | Arena name. |
| arena_state | character | Arena state. |
| arena_city | character | Arena city. |
| home_team_id | character | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_score | character | Home team's score. |
| away_team_id | character | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_score | character | Away team's score. |
| season | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| league_id | character | League identifier ('10' = WNBA). |
| season_type_id | character | Unique identifier for season type. |
| season_type_description | character | Season type description. |

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
