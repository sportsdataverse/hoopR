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

|                                |            |
|--------------------------------|------------|
| col_name                       | types      |
| game_id                        | character  |
| game_code                      | character  |
| game_status                    | integer    |
| game_status_text               | character  |
| game_date                      | character  |
| game_time_utc                  | character  |
| game_et                        | character  |
| home_team_id                   | integer    |
| home_team_name                 | character  |
| home_team_city                 | character  |
| home_team_tricode              | character  |
| home_team_slug                 | character  |
| away_team_id                   | integer    |
| away_team_name                 | character  |
| away_team_city                 | character  |
| away_team_tricode              | character  |
| away_team_slug                 | character  |
| period                         | integer    |
| game_clock                     | character  |
| regulation_periods             | integer    |
| series_game_number             | character  |
| series_text                    | character  |
| if_necessary                   | logical    |
| series_conference              | character  |
| po_round_desc                  | character  |
| game_subtype                   | character  |
| game_home_leaders_person_id    | integer    |
| game_home_leaders_name         | character  |
| game_home_leaders_player_slug  | character  |
| game_home_leaders_jersey_num   | character  |
| game_home_leaders_position     | character  |
| game_home_leaders_team_tricode | character  |
| game_home_leaders_points       | integer    |
| game_home_leaders_rebounds     | integer    |
| game_home_leaders_assists      | integer    |
| game_away_leaders_person_id    | integer    |
| game_away_leaders_name         | character  |
| game_away_leaders_player_slug  | character  |
| game_away_leaders_jersey_num   | character  |
| game_away_leaders_position     | character  |
| game_away_leaders_team_tricode | character  |
| game_away_leaders_points       | integer    |
| game_away_leaders_rebounds     | integer    |
| game_away_leaders_assists      | integer    |
| team_home_leaders_person_id    | integer    |
| team_home_leaders_name         | character  |
| team_home_leaders_player_slug  | character  |
| team_home_leaders_jersey_num   | character  |
| team_home_leaders_position     | character  |
| team_home_leaders_team_tricode | character  |
| team_home_leaders_points       | numeric    |
| team_home_leaders_rebounds     | numeric    |
| team_home_leaders_assists      | numeric    |
| team_away_leaders_person_id    | integer    |
| team_away_leaders_name         | character  |
| team_away_leaders_player_slug  | character  |
| team_away_leaders_jersey_num   | character  |
| team_away_leaders_position     | character  |
| team_away_leaders_team_tricode | character  |
| team_away_leaders_points       | numeric    |
| team_away_leaders_rebounds     | numeric    |
| team_away_leaders_assists      | numeric    |
| team_season_leaders_flag       | integer    |
| home_wins                      | integer    |
| home_losses                    | integer    |
| home_score                     | integer    |
| home_seed                      | integer    |
| home_in_bonus                  | logical    |
| home_timeouts_remaining        | integer    |
| home_periods                   | list       |
| away_wins                      | integer    |
| away_losses                    | integer    |
| away_score                     | integer    |
| away_seed                      | integer    |
| away_in_bonus                  | logical    |
| away_timeouts_remaining        | integer    |
| away_periods                   | list       |
| league_id                      | character  |
| league                         | character  |
| broadcasters                   | data.frame |

## Details

     nba_scoreboardv3(league_id = '00', game_date = '2023-03-26')

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
