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

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| game_date         | character |
| game_id           | character |
| game_code         | character |
| game_status       | character |
| game_status_text  | character |
| game_sequence     | character |
| home_team_id      | character |
| home_team_name    | character |
| home_team_city    | character |
| home_team_tricode | character |
| home_team_slug    | character |
| home_team_wins    | character |
| home_team_losses  | character |
| home_team_score   | character |
| away_team_id      | character |
| away_team_name    | character |
| away_team_city    | character |
| away_team_tricode | character |
| away_team_slug    | character |
| away_team_wins    | character |
| away_team_losses  | character |
| away_team_score   | character |
| season            | character |
| league_id         | character |

**SeasonWeeks**

|             |           |
|-------------|-----------|
| col_name    | types     |
| league_id   | character |
| season_year | character |
| week_number | character |
| week_name   | character |
| start_date  | character |
| end_date    | character |

**BroadcasterList**

|                          |           |
|--------------------------|-----------|
| col_name                 | types     |
| league_id                | character |
| season_year              | character |
| broadcaster_abbreviation | character |
| broadcaster_display      | character |
| broadcaster_id           | character |
| region_id                | character |

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
