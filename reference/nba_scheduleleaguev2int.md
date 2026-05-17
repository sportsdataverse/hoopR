# **Get NBA Stats API International Schedule**

**Get NBA Stats API International Schedule**

**Get NBA Stats API International Schedule**

## Usage

``` r
nba_scheduleleaguev2int(
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

  Season - format: '2023-24'

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: SeasonGames, SeasonWeeks,
BroadcasterList

**SeasonGames**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | character | Game date (YYYY-MM-DD). |
| game_id | character | Unique game identifier. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status | character | Game status label. |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_sequence | character | Game sequence. |
| home_team_id | character | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_slug | character | Home team's team slug. |
| home_team_wins | character | Home team's team wins. |
| home_team_losses | character | Home team's team losses. |
| home_team_score | character | Home team's score. |
| away_team_id | character | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_slug | character | Away team's team slug. |
| away_team_wins | character | Away team's team wins. |
| away_team_losses | character | Away team's team losses. |
| away_team_score | character | Away team's score. |
| season | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| league_id | character | League identifier ('10' = WNBA). |

**SeasonWeeks**

|             |           |                                        |
|-------------|-----------|----------------------------------------|
| col_name    | types     | description                            |
| league_id   | character | League identifier ('10' = WNBA).       |
| season_year | character | Season year string ('YYYY-YY' format). |
| week_number | character | Week number.                           |
| week_name   | character | Week name.                             |
| start_date  | character | Start date (YYYY-MM-DD).               |
| end_date    | character | End date (YYYY-MM-DD).                 |

**BroadcasterList**

|                          |           |                                        |
|--------------------------|-----------|----------------------------------------|
| col_name                 | types     | description                            |
| league_id                | character | League identifier ('10' = WNBA).       |
| season_year              | character | Season year string ('YYYY-YY' format). |
| broadcaster_abbreviation | character | Broadcaster abbreviation.              |
| broadcaster_display      | character | Broadcaster display.                   |
| broadcaster_id           | character | Unique identifier for broadcaster.     |
| region_id                | character | Unique identifier for region.          |

## Details

     nba_scheduleleaguev2int(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Schedule Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md),
[`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md),
[`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md),
[`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
