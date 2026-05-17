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
#> $away_team
#> # A tibble: 11 × 26
#>    hgt      wgt yr    number player       min o_rtg percent_ps   pts fgm_2 fga_2
#>    <chr>  <dbl> <chr>  <dbl> <chr>      <dbl> <dbl>      <dbl> <dbl> <dbl> <dbl>
#>  1 "6-2"    180 So        11 James Bis…    36   108         35    20     4     8
#>  2 "6-7"    225 So        10 Jamison B…    35    99         24    20     2     2
#>  3 "6-9"    225 Sr         0 Matt Moyer    31    53         17     2     1     3
#>  4 "6-1"    200 So         1 Jameer Ne…    30   127         25    18     5     6
#>  5 "6-9"    245 So         3 Chase Paar    24    48          6     2     1     1
#>  6 "6-9"    215 Jr        23 Sloan Sey…    20   107         13     5     0     1
#>  7 "6-5"    190 Sr        33 Maceo Jack    15    56         12     2     1     1
#>  8 "6-11"   270 Fr        21 Noel Brown     7    NA         NA     2     1     1
#>  9 "6-10"   245 Sr        20 Ace Stall…     2    NA         NA     0     0     0
#> 10 ""        NA NA        NA Team          NA    NA         NA    NA    NA    NA
#> 11 ""        NA NA        NA TOTAL        200    NA         NA    71    15    23
#> # ℹ 15 more variables: fgm_3 <dbl>, fga_3 <dbl>, ftm <dbl>, fta <dbl>,
#> #   or <dbl>, dr <dbl>, a <dbl>, to <dbl>, blk <dbl>, stl <dbl>, pf <dbl>,
#> #   team <chr>, wp_note <chr>, game_id <dbl>, year <dbl>
#> 
#> $home_team
#> # A tibble: 14 × 26
#>    hgt      wgt yr    number player       min o_rtg percent_ps   pts fgm_2 fga_2
#>    <chr>  <dbl> <chr>  <dbl> <chr>      <dbl> <dbl>      <dbl> <dbl> <dbl> <dbl>
#>  1 "6-0"    183 Sr        22 "Cam Davi…    33   115         23    15     6    10
#>  2 "6-4"    200 Jr        20 "Greg Sum…    29   102         15     5     1     3
#>  3 "6-3"    195 Jr         1 "John Car…    28   120         25    17     1     2
#>  4 "6-7"    230 Jr        55 "Richard …    27   136         18    12     6    10
#>  5 "6-6"    214 So         5 "Tyler Ne…    21   139         21    12     3     5
#>  6 "6-7"    225 Sr        33 "Luke Loe…    14   110         22     9     3     4
#>  7 "6-8"    225 So        31 "Daniel D…    13    74         26     2     1     5
#>  8 "6-5"    208 So        21 "Patrick …    13    93         16     3     0     1
#>  9 "6-2"    195 So         3 "Sean Yod…    10   100          9     3     0     0
#> 10 "6-2"    175 So        15 "PJ Roach"     7    NA         NA     0     0     0
#> 11 "6-5"    218 So        11 "Jaylen W…     5    NA         NA     0     0     1
#> 12 ""        NA NA        NA "Team"        NA    NA         NA    NA    NA    NA
#> 13 ""        NA NA        NA "TOTAL"      200    NA         NA    78    21    41
#> 14 "DNP:"    NA Inge.     NA "DNP: Aus…    NA    NA         NA    NA    NA    NA
#> # ℹ 15 more variables: fgm_3 <dbl>, fga_3 <dbl>, ftm <dbl>, fta <dbl>,
#> #   or <dbl>, dr <dbl>, a <dbl>, to <dbl>, blk <dbl>, stl <dbl>, pf <dbl>,
#> #   team <chr>, wp_note <chr>, game_id <dbl>, year <dbl>
#> 
#> $linescore
#> # A tibble: 2 × 6
#>   team                 q1    q2    q3    q4     t
#>   <chr>             <int> <int> <int> <int> <int>
#> 1 George Washington    15    15    22    19    71
#> 2 Navy                 22    19    16    21    78
#> 
#> $officials
#>   official_id  official_name game_id year
#> 1      714272 Mike McCloskey       6 2021
#> 2      719474  Mike Millione       6 2021
#> 3      721752 Dave Fernandez       6 2021
#> 
# }
```
