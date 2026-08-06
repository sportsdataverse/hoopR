# **Get KenPom Game Box Score**

**Get KenPom Game Box Score**

## Usage

``` r
kp_box(game_id, year)
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

## See also

Other KenPom Boxscore Functions:
[`kp_winprob()`](https://hoopR.sportsdataverse.org/reference/kp_winprob.md)

## Examples

``` r
# \donttest{
try(kp_box(game_id = 6, year = 2021))
#> ✖ 2026-08-06 04:00:50.53001: Invalid arguments or no box data for 6 available!
#> ✖ Args: game_id = 6, year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
