# **Get NBA Possession-Level Stint Matrix**

**Get NBA Possession-Level Stint Matrix**

**Get NBA Possession-Level Stint Matrix**

## Usage

``` r
nba_possession_lineups(game_id, ...)
```

## Arguments

- game_id:

  NBA Stats game id. 10-character zero-padded string (e.g.,
  `"0022200001"`).

- ...:

  reserved for future use.

## Value

Returns a data frame with one row per possession:

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier (10-character NBA Stats ID). |
| period | integer | Game period (1-4 regular, 5+ overtime). |
| possession_number | integer | Sequential possession counter within the game (1-based). |
| offense_team_id | integer | NBA Stats team ID of the team on offense for this possession. |
| defense_team_id | integer | NBA Stats team ID of the team on defense for this possession. |
| points | integer | Points scored by the offense during this possession (0 or positive). |
| second_chance | logical | TRUE if the possession was extended by an offensive rebound (second-chance opportunity). |
| start_event_idx | integer | 1-based row index into the source PBP frame for the first event of this possession. |
| end_event_idx | integer | 1-based row index into the source PBP frame for the last event of this possession. |
| off_player_1 | integer | NBA Stats person_id for offensive on-court player slot 1. |
| off_player_2 | integer | NBA Stats person_id for offensive on-court player slot 2. |
| off_player_3 | integer | NBA Stats person_id for offensive on-court player slot 3. |
| off_player_4 | integer | NBA Stats person_id for offensive on-court player slot 4. |
| off_player_5 | integer | NBA Stats person_id for offensive on-court player slot 5. |
| def_player_1 | integer | NBA Stats person_id for defensive on-court player slot 1. |
| def_player_2 | integer | NBA Stats person_id for defensive on-court player slot 2. |
| def_player_3 | integer | NBA Stats person_id for defensive on-court player slot 3. |
| def_player_4 | integer | NBA Stats person_id for defensive on-court player slot 4. |
| def_player_5 | integer | NBA Stats person_id for defensive on-court player slot 5. |

## Details

     nba_possession_lineups(game_id = "0022200001")

## See also

Other NBA Lineup Functions:
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_rapm()`](https://hoopR.sportsdataverse.org/reference/nba_rapm.md),
[`nba_shot_zones()`](https://hoopR.sportsdataverse.org/reference/nba_shot_zones.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md),
[`nba_teamdashboardbyclutch()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashboard.md)

## Author

Saiem Gilani
