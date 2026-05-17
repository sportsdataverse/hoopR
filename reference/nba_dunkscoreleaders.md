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

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_date | character | Game date (YYYY-MM-DD). |
| matchup | character | Matchup. |
| period | character | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock_time | character | Time / clock value. |
| event_num | character | Sequential event number within the game (V2 PBP). |
| player_id | character | Unique player identifier. |
| player_name | character | Player name. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| team_id | character | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| dunk_score | character | Dunk score. |
| jump_subscore | character | Jump subscore. |
| power_subscore | character | Power subscore. |
| style_subscore | character | Style subscore. |
| defensive_contest_subscore | character | Defensive contest subscore. |
| max_ball_height | character | Max ball height. |
| ball_speed_through_rim | character | Ball speed through rim. |
| player_vertical | character | Player vertical. |
| hang_time | character | Time / clock value. |
| takeoff_distance | character | Takeoff distance. |
| reverse_dunk | character | Reverse dunk. |
| dunk360 | character | Dunk360. |
| through_the_legs | character | Through the legs. |
| alley_oop | character | Alley oop. |
| tip_in | character | Tip in. |
| self_oop | character | Self oop. |
| player_rotation | character | Player rotation. |
| player_lateral_speed | character | Player lateral speed. |
| ball_distance_traveled | character | Ball distance traveled. |
| ball_reach_back | character | Ball reach back. |
| total_ball_acceleration | character | Total ball acceleration. |
| dunking_hand | character | Dunking hand. |
| jumping_foot | character | Jumping foot. |
| pass_length | character | Pass length. |
| catching_hand | character | Catching hand. |
| catch_distance | character | Catch distance. |
| lateral_catch_distance | character | Lateral catch distance. |
| passer_id | character | Unique identifier for passer. |
| passer_name | character | Passer name. |
| passer_first_name | character | Passer first name. |
| passer_last_name | character | Passer last name. |
| pass_release_point | character | Pass release point. |
| shooter_id | character | Unique identifier for shooter. |
| shooter_name | character | Shooter name (for shot events). |
| shooter_first_name | character | Shooter first name. |
| shooter_last_name | character | Shooter last name. |
| shot_release_point | character | Shot release point. |
| shot_length | character | Shot length. |
| defensive_contest_level | character | Defensive contest level. |
| possible_attempted_charge | character | Possible attempted charge. |
| video_available | character | Video available. |

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
