# **Get NBA Stats API Dunk Score Leaders**

**Get NBA Stats API Dunk Score Leaders**

**Get NBA Stats API Dunk Score Leaders**

## Usage

``` r
nba_dunkscoreleaders(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  player_id = "",
  team_id = "",
  game_id = "",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format: '2023-24'

- season_type:

  Season Type - 'Regular Season', 'Playoffs'

- player_id:

  Player ID filter (optional, leave empty for all players)

- team_id:

  Team ID filter (optional, leave empty for all teams)

- game_id:

  Game ID filter (optional, leave empty for all games)

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: DunkScoreLeaders

**DunkScoreLeaders**

|                            |           |
|----------------------------|-----------|
| col_name                   | types     |
| game_id                    | character |
| game_date                  | character |
| matchup                    | character |
| period                     | character |
| game_clock_time            | character |
| event_num                  | character |
| player_id                  | character |
| player_name                | character |
| first_name                 | character |
| last_name                  | character |
| team_id                    | character |
| team_name                  | character |
| team_city                  | character |
| team_abbreviation          | character |
| dunk_score                 | character |
| jump_subscore              | character |
| power_subscore             | character |
| style_subscore             | character |
| defensive_contest_subscore | character |
| max_ball_height            | character |
| ball_speed_through_rim     | character |
| player_vertical            | character |
| hang_time                  | character |
| takeoff_distance           | character |
| reverse_dunk               | character |
| dunk360                    | character |
| through_the_legs           | character |
| alley_oop                  | character |
| tip_in                     | character |
| self_oop                   | character |
| player_rotation            | character |
| player_lateral_speed       | character |
| ball_distance_traveled     | character |
| ball_reach_back            | character |
| total_ball_acceleration    | character |
| dunking_hand               | character |
| jumping_foot               | character |
| pass_length                | character |
| catching_hand              | character |
| catch_distance             | character |
| lateral_catch_distance     | character |
| passer_id                  | character |
| passer_name                | character |
| passer_first_name          | character |
| passer_last_name           | character |
| pass_release_point         | character |
| shooter_id                 | character |
| shooter_name               | character |
| shooter_first_name         | character |
| shooter_last_name          | character |
| shot_release_point         | character |
| shot_length                | character |
| defensive_contest_level    | character |
| possible_attempted_charge  | character |
| video_available            | character |

## Details

     nba_dunkscoreleaders(season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
