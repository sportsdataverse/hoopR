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

|            |           |
|------------|-----------|
| col_name   | types     |
| hgt        | character |
| wgt        | numeric   |
| yr         | character |
| number     | numeric   |
| player     | character |
| min        | numeric   |
| o_rtg      | numeric   |
| percent_ps | numeric   |
| pts        | numeric   |
| fgm_2      | numeric   |
| fga_2      | numeric   |
| fgm_3      | numeric   |
| fga_3      | numeric   |
| ftm        | numeric   |
| fta        | numeric   |
| or         | numeric   |
| dr         | numeric   |
| a          | numeric   |
| to         | numeric   |
| blk        | numeric   |
| stl        | numeric   |
| pf         | numeric   |
| team       | character |
| wp_note    | character |
| game_id    | numeric   |
| year       | numeric   |

**home_team**

|            |           |
|------------|-----------|
| col_name   | types     |
| hgt        | character |
| wgt        | numeric   |
| yr         | character |
| number     | numeric   |
| player     | character |
| min        | numeric   |
| o_rtg      | numeric   |
| percent_ps | numeric   |
| pts        | numeric   |
| fgm_2      | numeric   |
| fga_2      | numeric   |
| fgm_3      | numeric   |
| fga_3      | numeric   |
| ftm        | numeric   |
| fta        | numeric   |
| or         | numeric   |
| dr         | numeric   |
| a          | numeric   |
| to         | numeric   |
| blk        | numeric   |
| stl        | numeric   |
| pf         | numeric   |
| team       | character |
| wp_note    | character |
| game_id    | numeric   |
| year       | numeric   |

**linescore**

|          |           |
|----------|-----------|
| col_name | types     |
| team     | character |
| q1       | integer   |
| q2       | integer   |
| q3       | integer   |
| q4       | integer   |
| t        | integer   |

**officials**

|               |           |
|---------------|-----------|
| col_name      | types     |
| official_id   | character |
| official_name | character |
| game_id       | numeric   |
| year          | numeric   |

## See also

Other KenPom Boxscore Functions:
[`kp_winprob()`](https://hoopR.sportsdataverse.org/reference/kp_winprob.md)

## Examples

``` r
# \donttest{
try(kp_box(game_id = 6, year = 2021))
#> 2026-03-24 01:20:53.682594: Invalid arguments or no box data for 6 available!
#> Error in kp_box(game_id = 6, year = 2021) : object 'kenpom' not found
# }
```
