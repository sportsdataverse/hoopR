# **Get KenPom Win Probability**

**Get KenPom Win Probability**

## Usage

``` r
kp_winprob(game_id, year)
```

## Arguments

- game_id:

  Game id of game to pull

- year:

  Year of game to pull

## Value

Returns a named list of tibbles: winprob_dataset, game_data, runs

**winprob_dataset**

|                   |           |                                               |
|-------------------|-----------|-----------------------------------------------|
| col_name          | types     | description                                   |
| period            | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| wp                | numeric   | Wp.                                           |
| time_left         | numeric   | Time left.                                    |
| visitor_score     | integer   | Visitor score.                                |
| home_score        | integer   | Home team score at the time of the play.      |
| visitor_scoring   | integer   | Visitor scoring.                              |
| home_scoring      | integer   | Home team's scoring.                          |
| possession_team   | character | Possession team.                              |
| possession_number | character | Possession number.                            |
| game_id           | numeric   | Unique game identifier.                       |
| year              | numeric   | 4-digit year.                                 |

**game_data**

|                        |           |                            |
|------------------------|-----------|----------------------------|
| col_name               | types     | description                |
| game_id                | character | Unique game identifier.    |
| year                   | integer   | 4-digit year.              |
| full_date              | character | Date in YYYY-MM-DD format. |
| date                   | character | Date in YYYY-MM-DD format. |
| game_time              | character | Game start time.           |
| venue                  | character | Venue name.                |
| city                   | character | City.                      |
| team1                  | character | Team1.                     |
| team1score             | integer   | Team1score.                |
| team1_rk               | character | Team1 rk.                  |
| team2                  | character | Team2.                     |
| team2score             | integer   | Team2score.                |
| team2_rk               | character | Team2 rk.                  |
| dominance_season_rk    | character | Dominance season rk.       |
| tension_season_rk      | character | Tension season rk.         |
| excitement_season_rk   | character | Excitement season rk.      |
| lead_changes_season_rk | character | Lead changes season rk.    |
| minimum_wp_season_rk   | character | Minimum wp season rk.      |
| dominance_rk           | character | Dominance rk.              |
| tension_rk             | character | Tension rk.                |
| excitement_rk          | character | Excitement rk.             |
| lead_changes_rk        | character | Lead changes rk.           |
| minimum_wp_rk          | character | Minimum wp rk.             |
| dominance              | character | Dominance.                 |
| tension                | character | Tension.                   |
| excitement             | character | Excitement.                |
| favchg                 | character | Favchg.                    |
| min_wp                 | character | Min wp.                    |

**runs**

|          |         |             |
|----------|---------|-------------|
| col_name | types   | description |
| start    | numeric | Start.      |
| end      | numeric | End.        |
| visitor  | integer | Visitor.    |
| home     | integer | Home.       |

## See also

Other KenPom Boxscore Functions:
[`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md)

## Examples

``` r
# \donttest{
try(kp_winprob(game_id = 1238, year = 2020))
#> ✖ 2026-05-18 17:14:17.036246: Invalid arguments or no win probability data for 1238 available!
#> ✖ Args: game_id = 1238, year = 2020
#> ✖ Error: ℹ In index: 1. Caused by error in `if (...) NULL`: ! missing value where TRUE/FALSE needed
#> Error in kp_winprob(game_id = 1238, year = 2020) : 
#>   object 'kenpom' not found
# }
```
