# **Get NBA Stats API Scoreboard V3**

**Get NBA Stats API Scoreboard V3**

**Get NBA Stats API Scoreboard V3**

## Usage

``` r
nba_scoreboardv3(league_id = "00", game_date = "2023-03-26", ...)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- game_date:

  Game Date

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a tibble with the following scoreboard data:

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_date | character | Game date (YYYY-MM-DD). |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_et | character | Game et. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_slug | character | Home team's team slug. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_slug | character | Away team's team slug. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock | character | Game clock. |
| regulation_periods | integer | Regulation periods. |
| series_game_number | character | Series game number. |
| series_text | character | Series text. |
| if_necessary | logical | If necessary. |
| series_conference | character | Series conference. |
| po_round_desc | character | Po round desc. |
| game_subtype | character | Game subtype. |
| game_home_leaders_person_id | integer | Unique identifier for game home leaders person. |
| game_home_leaders_name | character | Game home leaders name. |
| game_home_leaders_player_slug | character | Game home leaders player slug. |
| game_home_leaders_jersey_num | character | Game home leaders jersey num. |
| game_home_leaders_position | character | Game home leaders position. |
| game_home_leaders_team_tricode | character | Game home leaders team tricode. |
| game_home_leaders_points | integer | Game home leaders points. |
| game_home_leaders_rebounds | integer | Game home leaders rebounds. |
| game_home_leaders_assists | integer | Game home leaders assists. |
| game_away_leaders_person_id | integer | Unique identifier for game away leaders person. |
| game_away_leaders_name | character | Game away leaders name. |
| game_away_leaders_player_slug | character | Game away leaders player slug. |
| game_away_leaders_jersey_num | character | Game away leaders jersey num. |
| game_away_leaders_position | character | Game away leaders position. |
| game_away_leaders_team_tricode | character | Game away leaders team tricode. |
| game_away_leaders_points | integer | Game away leaders points. |
| game_away_leaders_rebounds | integer | Game away leaders rebounds. |
| game_away_leaders_assists | integer | Game away leaders assists. |
| team_home_leaders_person_id | integer | Unique identifier for team home leaders person. |
| team_home_leaders_name | character | Team home leaders name. |
| team_home_leaders_player_slug | character | Team home leaders player slug. |
| team_home_leaders_jersey_num | character | Team home leaders jersey num. |
| team_home_leaders_position | character | Team home leaders position. |
| team_home_leaders_team_tricode | character | Team home leaders team tricode. |
| team_home_leaders_points | numeric | Team home leaders points. |
| team_home_leaders_rebounds | numeric | Team home leaders rebounds. |
| team_home_leaders_assists | numeric | Team home leaders assists. |
| team_away_leaders_person_id | integer | Unique identifier for team away leaders person. |
| team_away_leaders_name | character | Team away leaders name. |
| team_away_leaders_player_slug | character | Team away leaders player slug. |
| team_away_leaders_jersey_num | character | Team away leaders jersey num. |
| team_away_leaders_position | character | Team away leaders position. |
| team_away_leaders_team_tricode | character | Team away leaders team tricode. |
| team_away_leaders_points | numeric | Team away leaders points. |
| team_away_leaders_rebounds | numeric | Team away leaders rebounds. |
| team_away_leaders_assists | numeric | Team away leaders assists. |
| team_season_leaders_flag | integer | Team season leaders flag. |
| home_wins | integer | Home team's wins. |
| home_losses | integer | Home team's losses. |
| home_score | integer | Home team score at the time of the play. |
| home_seed | integer | Home team's seed. |
| home_in_bonus | logical | Home team's in bonus. |
| home_timeouts_remaining | integer | Home team's timeouts remaining. |
| home_periods | list | Home team's periods. |
| away_wins | integer | Away team's wins. |
| away_losses | integer | Away team's losses. |
| away_score | integer | Away team score at the time of the play. |
| away_seed | integer | Away team's seed. |
| away_in_bonus | logical | Away team's in bonus. |
| away_timeouts_remaining | integer | Away team's timeouts remaining. |
| away_periods | list | Away team's periods. |
| league_id | character | League identifier ('10' = WNBA). |
| league | character | League. |
| broadcasters | data.frame |  |

## Details

     nba_scoreboardv3(league_id = '00', game_date = '2023-03-26')

## See also

Other NBA Schedule Functions:
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
