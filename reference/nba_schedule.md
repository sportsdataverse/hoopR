# **Get NBA Stats API Season Schedule**

**Get NBA Stats API Season Schedule**

**Get NBA Stats API Season Schedule**

## Usage

``` r
nba_schedule(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a tibble with the following columns:

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| game_date          | character |
| game_id            | character |
| game_code          | character |
| game_status        | integer   |
| game_status_text   | character |
| game_sequence      | integer   |
| game_date_est      | character |
| game_time_est      | character |
| game_date_time_est | character |
| game_date_utc      | character |
| game_time_utc      | character |
| game_date_time_utc | character |
| away_team_time     | character |
| home_team_time     | character |
| day                | character |
| month_num          | integer   |
| week_number        | integer   |
| week_name          | character |
| if_necessary       | character |
| series_game_number | character |
| series_text        | character |
| arena_name         | character |
| arena_state        | character |
| arena_city         | character |
| postponed_status   | character |
| branch_link        | character |
| game_subtype       | character |
| home_team_id       | integer   |
| home_team_name     | character |
| home_team_city     | character |
| home_team_tricode  | character |
| home_team_slug     | character |
| home_team_wins     | integer   |
| home_team_losses   | integer   |
| home_team_score    | integer   |
| home_team_seed     | integer   |
| away_team_id       | integer   |
| away_team_name     | character |
| away_team_city     | character |
| away_team_tricode  | character |
| away_team_slug     | character |
| away_team_wins     | integer   |
| away_team_losses   | integer   |
| away_team_score    | integer   |
| away_team_seed     | integer   |
| season             | character |
| league_id          | character |

## Details

     nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
     nba_schedule(league_id = '20', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Schedule Functions:
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
