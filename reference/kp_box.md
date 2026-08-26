# **Get KenPom Game Box Score**

**Get KenPom Game Box Score**

**Get KenPom Win Probability**

## Usage

``` r
kp_box(game_id, year)

kp_winprob(game_id, year)
```

## Arguments

- game_id:

  Game id of game to pull

- year:

  Year of game to pull

## Value

Returns a tibble of game box scores with names: away_team, home_team,
linescore, officials

**away_team**

|            |           |                                     |
|------------|-----------|-------------------------------------|
| col_name   | types     | description                         |
| hgt        | character | Hgt.                                |
| wgt        | numeric   | Wgt.                                |
| yr         | character | Yr.                                 |
| number     | numeric   | Number.                             |
| player     | character | Player.                             |
| min        | numeric   | Minutes played.                     |
| o_rtg      | numeric   | O rtg.                              |
| percent_ps | numeric   | Percent ps.                         |
| pts        | numeric   | Points scored.                      |
| fgm_2      | numeric   | Fgm 2.                              |
| fga_2      | numeric   | Fga 2.                              |
| fgm_3      | numeric   | Fgm 3.                              |
| fga_3      | numeric   | Fga 3.                              |
| ftm        | numeric   | Free throws made.                   |
| fta        | numeric   | Free throw attempts.                |
| or         | numeric   | Or.                                 |
| dr         | numeric   | Dr.                                 |
| a          | numeric   | A.                                  |
| to         | numeric   | To.                                 |
| blk        | numeric   | Blocks.                             |
| stl        | numeric   | Steals.                             |
| pf         | numeric   | Personal fouls.                     |
| team       | character | Team-side label or team identifier. |
| wp_note    | character | Wp note.                            |
| game_id    | numeric   | Unique game identifier.             |
| year       | numeric   | 4-digit year.                       |

**home_team**

Same columns as the **away_team** table above.

**linescore**

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| team     | character | Team-side label or team identifier. |
| q1       | integer   | Q1.                                 |
| q2       | integer   | Q2.                                 |
| q3       | integer   | Q3.                                 |
| q4       | integer   | Q4.                                 |
| t        | integer   | T.                                  |

**officials**

|               |           |                                       |
|---------------|-----------|---------------------------------------|
| col_name      | types     | description                           |
| official_id   | character | Unique official / referee identifier. |
| official_name | character | Official name.                        |
| game_id       | numeric   | Unique game identifier.               |
| year          | numeric   | 4-digit year.                         |

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

## Examples

``` r
# \donttest{
try(kp_box(game_id = 6, year = 2021))
#> ✖ 2026-08-26 19:55:58.598019: Invalid arguments or no box data for 6 available!
#> ✖ Args: game_id = 6, year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_winprob(game_id = 1238, year = 2020))
#> ✖ 2026-08-26 19:55:58.662171: Invalid arguments or no win probability data for 1238 available!
#> ✖ Args: game_id = 1238, year = 2020
#> ✖ Error: HTTP 403 Forbidden.
#> list()
# }
```
