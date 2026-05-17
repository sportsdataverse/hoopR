# **Get NBA Stats API Today's Scoreboard**

**Get NBA Stats API Today's Scoreboard**

**Get NBA Stats API Today's Scoreboard**

## Usage

``` r
nba_todays_scoreboard(...)
```

## Arguments

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a data frame with the following columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | integer | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock | character | Game clock. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_et | character | Game et. |
| regulation_periods | integer | Regulation periods. |
| if_necessary | logical | If necessary. |
| series_game_number | character | Series game number. |
| series_text | character | Series text. |
| series_conference | character | Series conference. |
| po_round_desc | character | Po round desc. |
| game_subtype | character | Game subtype. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_wins | integer | Home team's wins. |
| home_losses | integer | Home team's losses. |
| home_score | integer | Home team score at the time of the play. |
| home_seed | logical | Home team's seed. |
| home_in_bonus | character | Home team's in bonus. |
| home_timeouts_remaining | integer | Home team's timeouts remaining. |
| home_periods | list | Home team's periods. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_wins | integer | Away team's wins. |
| away_losses | integer | Away team's losses. |
| away_score | integer | Away team score at the time of the play. |
| away_seed | logical | Away team's seed. |
| away_in_bonus | character | Away team's in bonus. |
| away_timeouts_remaining | integer | Away team's timeouts remaining. |
| away_periods | list | Away team's periods. |
| home_leaders_person_id | integer | Unique identifier for home leaders person. |
| home_leaders_name | character | Home leaders name. |
| home_leaders_jersey_num | character | Home team's leaders jersey num. |
| home_leaders_position | character | Home team's leaders position. |
| home_leaders_team_tricode | character | Home team's leaders team tricode. |
| home_leaders_player_slug | character | Home team's leaders player slug. |
| home_leaders_points | integer | Home team's leaders points. |
| home_leaders_rebounds | integer | Home team's leaders rebounds. |
| home_leaders_assists | integer | Home team's leaders assists. |
| away_leaders_person_id | integer | Unique identifier for away leaders person. |
| away_leaders_name | character | Away leaders name. |
| away_leaders_jersey_num | character | Away team's leaders jersey num. |
| away_leaders_position | character | Away team's leaders position. |
| away_leaders_team_tricode | character | Away team's leaders team tricode. |
| away_leaders_player_slug | character | Away team's leaders player slug. |
| away_leaders_points | integer | Away team's leaders points. |
| away_leaders_rebounds | integer | Away team's leaders rebounds. |
| away_leaders_assists | integer | Away team's leaders assists. |
| pb_odds_team | logical | Pb odds team. |
| pb_odds_odds | numeric | Pb odds odds. |
| pb_odds_suspended | integer | Pb odds suspended. |

## Details

     nba_todays_scoreboard()

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md)

Other NBA Live Functions:
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md)

## Author

Saiem Gilani
