# Shared column schema: espn mbb game odds schema

Columns shared verbatim across: espn_mbb_game_odds, espn_nba_game_odds.

## Details

|                      |           |                                        |
|----------------------|-----------|----------------------------------------|
| col_name             | types     | description                            |
| event_id             | character | Unique event / game identifier (ESPN). |
| provider_id          | character | Unique identifier for provider.        |
| provider_name        | character | Provider name.                         |
| details              | character | Details.                               |
| over_under           | numeric   | Over under.                            |
| spread               | numeric   | Spread.                                |
| home_money_line      | integer   |                                        |
| away_money_line      | integer   |                                        |
| home_team_odds_open  | numeric   |                                        |
| home_team_odds_close | numeric   |                                        |
| away_team_odds_open  | numeric   |                                        |
| away_team_odds_close | numeric   |                                        |
