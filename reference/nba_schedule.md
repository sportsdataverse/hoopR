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

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | character | Game date (YYYY-MM-DD). |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_sequence | integer | Game sequence. |
| game_date_est | character | Game date est. |
| game_time_est | character | Game time est. |
| game_date_time_est | character | Game date time est. |
| game_date_utc | character | Game date utc. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_date_time_utc | character | Game date time utc. |
| away_team_time | character | Time / clock value. |
| home_team_time | character | Time / clock value. |
| day | character | Day number within the month. |
| month_num | integer | Month num. |
| week_number | integer | Week number. |
| week_name | character | Week name. |
| if_necessary | character | If necessary. |
| series_game_number | character | Series game number. |
| series_text | character | Series text. |
| arena_name | character | Arena name. |
| arena_state | character | Arena state. |
| arena_city | character | Arena city. |
| postponed_status | character | Postponed status. |
| branch_link | character | Branch link. |
| game_subtype | character | Game subtype. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_slug | character | Home team's team slug. |
| home_team_wins | integer | Home team's team wins. |
| home_team_losses | integer | Home team's team losses. |
| home_team_score | integer | Home team's score. |
| home_team_seed | integer | Home team's team seed. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_slug | character | Away team's team slug. |
| away_team_wins | integer | Away team's team wins. |
| away_team_losses | integer | Away team's team losses. |
| away_team_score | integer | Away team's score. |
| away_team_seed | integer | Away team's team seed. |
| season | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| league_id | character | League identifier ('10' = WNBA). |

## Details

     nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
     nba_schedule(league_id = '20', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Schedule Functions:
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
