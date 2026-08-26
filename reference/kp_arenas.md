# **Get Division-I statistical trends**

**Get Division-I statistical trends**

**Get officials rankings**

**Get referee game log**

**Get Home Court Advantage Estimates**

**Get Home Court Arenas**

**Get Game Attributes**

**Get FanMatch by date**

## Usage

``` r
kp_trends()

kp_officials(year = most_recent_mbb_season())

kp_referee(referee, year)

kp_hca()

kp_arenas(year = most_recent_mbb_season())

kp_game_attrs(year = most_recent_mbb_season(), attr = "Excitement")

kp_fanmatch(date)
```

## Arguments

- year:

  Year of data to pull

- referee:

  Referee ID

- attr:

  Game Attribute, valid values include:  
  'Excitement', 'Tension','Dominance','MinWp','FanMatch',  
  'Upsets','Busts','Comeback','Window'

- date:

  Date of games to pull (YYYY-MM-DD)

## Value

A data frame with the following columns:

|              |         |                                                       |
|--------------|---------|-------------------------------------------------------|
| col_name     | types   | description                                           |
| season       | numeric | Season identifier (4-digit year or 'YYYY-YY' string). |
| efficiency   | numeric | Efficiency.                                           |
| tempo        | numeric | Tempo.                                                |
| e_fg_pct     | numeric | E field goals percentage (0-1 decimal).               |
| to_pct       | numeric | To percentage (0-1 decimal).                          |
| or_pct       | numeric | Or percentage (0-1 decimal).                          |
| ft_rate      | numeric | Ft rate.                                              |
| fg_2_pct     | numeric | Field goals 2 percentage (0-1 decimal).               |
| fg_3_pct     | numeric | Field goals 3 percentage (0-1 decimal).               |
| fg_3a_pct    | numeric | Field goals 3a percentage (0-1 decimal).              |
| ft_pct       | numeric | Free throw percentage (0-1).                          |
| a_pct        | numeric | A percentage (0-1 decimal).                           |
| blk_pct      | numeric | Blocks percentage (0-1 decimal).                      |
| stl_pct      | numeric | Steals percentage (0-1 decimal).                      |
| non_stl_pct  | numeric | Non steals percentage (0-1 decimal).                  |
| avg_hgt      | numeric | Avg hgt.                                              |
| continuity   | numeric | Continuity.                                           |
| home_win_pct | numeric | Home win percentage (0-1 decimal).                    |
| ppg          | numeric | Points per game.                                      |

A data frame with the following columns:

|               |           |                                 |
|---------------|-----------|---------------------------------|
| col_name      | types     | description                     |
| rk            | integer   | Rk.                             |
| official_name | character | Official name.                  |
| ref_rating    | numeric   | Ref rating.                     |
| gms           | numeric   | Gms.                            |
| last_game     | character | Last game date or score string. |
| last_game_1   | character | Last game 1.                    |
| year          | numeric   | 4-digit year.                   |

A data frame with the following columns:

|              |           |                             |
|--------------|-----------|-----------------------------|
| col_name     | types     | description                 |
| game_number  | integer   | Game number.                |
| date         | character | Date in YYYY-MM-DD format.  |
| time_et      | character | Time et.                    |
| game         | character | Game.                       |
| location     | character | Location.                   |
| venue        | character | Venue name.                 |
| conference   | character | Conference.                 |
| thrill_score | numeric   | Thrill score.               |
| referee_name | character | Referee name.               |
| ref_rank     | numeric   | League/season rank for ref. |
| year         | numeric   | 4-digit year.               |

A data frame with the following columns:

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| team     | character | Team-side label or team identifier. |
| conf     | character | character.                          |
| hca      | numeric   | Hca.                                |
| hca_rk   | numeric   | Hca rk.                             |
| pf       | numeric   | Personal fouls.                     |
| pf_rk    | numeric   | Pf rk.                              |
| pts      | numeric   | Points scored.                      |
| pts_rk   | numeric   | Pts rk.                             |
| nst      | numeric   | Nst.                                |
| nst_rk   | numeric   | Nst rk.                             |
| blk      | numeric   | Blocks.                             |
| blk_rk   | numeric   | Blk rk.                             |
| elev     | numeric   | Elev.                               |
| elev_rk  | numeric   | Elev rk.                            |

A data frame with the following columns:

|           |           |                                     |
|-----------|-----------|-------------------------------------|
| col_name  | types     | description                         |
| rk        | numeric   | Rk.                                 |
| team      | character | Team-side label or team identifier. |
| conf      | character | character.                          |
| arena     | character | Arena.                              |
| alternate | character | Alternate.                          |
| year      | numeric   | 4-digit year.                       |

Returns a tibble with game attributes

|            |           |               |
|------------|-----------|---------------|
| col_name   | types     | description   |
| rk         | integer   | Rk.           |
| data       | character | Data.         |
| game       | character | Game.         |
| location   | character | Location.     |
| conf       | character | character.    |
| excitement | numeric   | Excitement.   |
| year       | numeric   | 4-digit year. |

A data frame with the following columns:

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| prediction   | character | Prediction.                |
| time_et      | character | Time et.                   |
| location     | character | Location.                  |
| thrill_score | numeric   | Thrill score.              |
| comeback     | numeric   | Comeback.                  |
| excitement   | numeric   | Excitement.                |
| road_rk      | numeric   | Road rk.                   |
| road_team    | character | Road team.                 |
| home_rk      | numeric   | Home team's rk.            |
| home_team    | character | Home team's team.          |
| win_rk       | numeric   | Win rk.                    |
| win_team     | character | Win team.                  |
| win_score    | numeric   | Win score.                 |
| loss_rk      | numeric   | Loss rk.                   |
| loss_team    | character | Loss team.                 |
| loss_score   | numeric   | Loss score.                |
| poss         | numeric   | Poss.                      |
| mvp          | character | Mvp.                       |
| event        | character | Event.                     |
| date         | character | Date in YYYY-MM-DD format. |

## Examples

``` r
# \donttest{
try(kp_trends())
#> ✖ 2026-08-26 19:55:57.906181: Invalid arguments or no trends data available!
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_officials(year = 2021))
#> ✖ 2026-08-26 19:55:57.962001: Invalid arguments or no officials data for 2021 available!
#> ✖ Args: year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_referee(referee = 714363, year = 2021))
#> ✖ 2026-08-26 19:55:58.019901: Invalid arguments or no referee data for 714363 in 2021 available!
#> ✖ Args: referee = 714363, year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_hca())
#> ✖ 2026-08-26 19:55:58.077009: Invalid arguments or no home court advantage data available!
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_arenas(year = 2021))
#> ✖ 2026-08-26 19:55:58.162071: Invalid arguments or no arenas data available!
#> ✖ Args: year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_game_attrs(year = 2021, attr = "Excitement"))
#> ✖ 2026-08-26 19:55:58.2188: Invalid arguments or no game attributes data for Excitement available!
#> ✖ Args: year = 2021, attr = "Excitement"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_fanmatch(date = "2022-02-22"))
#> ✖ 2026-08-26 19:55:58.276132: Invalid arguments or no Fan Match data for 2022-02-22 available!
#> ✖ Args: date = "2022-02-22"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
