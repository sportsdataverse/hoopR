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

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| game_code                 | character |
| game_status               | integer   |
| game_status_text          | character |
| period                    | integer   |
| game_clock                | character |
| game_time_utc             | character |
| game_et                   | character |
| regulation_periods        | integer   |
| if_necessary              | logical   |
| series_game_number        | character |
| series_text               | character |
| series_conference         | character |
| po_round_desc             | character |
| game_subtype              | character |
| home_team_id              | integer   |
| home_team_name            | character |
| home_team_city            | character |
| home_team_tricode         | character |
| home_wins                 | integer   |
| home_losses               | integer   |
| home_score                | integer   |
| home_seed                 | logical   |
| home_in_bonus             | character |
| home_timeouts_remaining   | integer   |
| home_periods              | list      |
| away_team_id              | integer   |
| away_team_name            | character |
| away_team_city            | character |
| away_team_tricode         | character |
| away_wins                 | integer   |
| away_losses               | integer   |
| away_score                | integer   |
| away_seed                 | logical   |
| away_in_bonus             | character |
| away_timeouts_remaining   | integer   |
| away_periods              | list      |
| home_leaders_person_id    | integer   |
| home_leaders_name         | character |
| home_leaders_jersey_num   | character |
| home_leaders_position     | character |
| home_leaders_team_tricode | character |
| home_leaders_player_slug  | character |
| home_leaders_points       | integer   |
| home_leaders_rebounds     | integer   |
| home_leaders_assists      | integer   |
| away_leaders_person_id    | integer   |
| away_leaders_name         | character |
| away_leaders_jersey_num   | character |
| away_leaders_position     | character |
| away_leaders_team_tricode | character |
| away_leaders_player_slug  | character |
| away_leaders_points       | integer   |
| away_leaders_rebounds     | integer   |
| away_leaders_assists      | integer   |
| pb_odds_team              | logical   |
| pb_odds_odds              | numeric   |
| pb_odds_suspended         | integer   |

## Details

     nba_todays_scoreboard()

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md)

Other NBA Live Functions:
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md)

## Author

Saiem Gilani
