# **Get Minutes Matrix from Expanded Player Page**

**Get Minutes Matrix from Expanded Player Page**

## Usage

``` r
kp_minutes_matrix(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of minutes matrix data

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
#>          date opponent_rk       opponent    result justin_lindner
#> 1   Wed Dec 2         297  North Florida  W, 86-58               
#> 2   Wed Dec 9          50        Indiana  W, 69-67               
#> 3  Sat Dec 12          41        Florida  W, 83-71               
#> 4  Tue Dec 15          37   Georgia Tech  W, 74-61               
#> 5  Sat Dec 19         100            UCF  L, 86-74               
#> 6  Mon Dec 21         182   Gardner Webb  W, 72-59              1
#> 7  Tue Dec 29          45        Clemson  L, 77-67               
#> 8  Wed Jan 13          71     N.C. State W, 105-73              6
#> 9  Sat Jan 16          34 North Carolina  W, 82-75               
#> 10 Mon Jan 18          59     Louisville  W, 78-65              1
#> 11 Sat Jan 23          45        Clemson  W, 80-61              3
#> 12 Wed Jan 27         138       Miami FL  W, 81-59              2
#> 13 Sat Jan 30          37   Georgia Tech  L, 76-65               
#> 14 Sat Feb 13         175    Wake Forest  W, 92-85               
#> 15 Mon Feb 15          19       Virginia  W, 81-60              1
#> 16 Sat Feb 20          97     Pittsburgh  W, 79-72               
#> 17 Wed Feb 24         138       Miami FL  W, 88-71              2
#> 18 Sat Feb 27          34 North Carolina  L, 78-70               
#> 19  Wed Mar 3         148 Boston College  W, 93-64              5
#> 20  Sat Mar 6          85     Notre Dame  L, 83-73               
#> 21 Fri Mar 12          34 North Carolina  W, 69-66               
#> 22 Sat Mar 13          37   Georgia Tech  L, 80-75               
#> 23 Sat Mar 20         108 UNC Greensboro  W, 64-54               
#> 24 Mon Mar 22           8       Colorado  W, 71-53               
#> 25 Sun Mar 28           3       Michigan  L, 76-58              1
#>    ray_quan_evans mj_walker nathanael_jack anthony_polite sardaar_calhoun
#> 1              16        27             11             24              15
#> 2              13        41                            33              14
#> 3              18        29              3             27               7
#> 4                        35              5             34               6
#> 5              15        37                            31               8
#> 6              24        23             11             28              10
#> 7              21        33              4             27              11
#> 8              19        22             12             21              15
#> 9              31        32              2             27              16
#> 10             27        32              7                             16
#> 11             18        17             22                             17
#> 12             18        27             13                             25
#> 13             27        25              4                             17
#> 14             17        37              3             30              10
#> 15             19        29              2             15              19
#> 16             22        28                            20              14
#> 17             15                       15             24              24
#> 18             17        29                            26              20
#> 19             16        24             12             25              11
#> 20             31        26              2             26              20
#> 21             13        28              4             24              20
#> 22             12        27                            32              12
#> 23             16        32                            30              11
#> 24             18        31              9             28              11
#> 25             16        26              4             25               9
#>    travis_light will_miles harrison_prieto rai_quan_gray wyatt_wilkes
#> 1                                                     18           16
#> 2                                        1            31            7
#> 3                                                     23           18
#> 4                                                     30           11
#> 5                                        3            26           15
#> 6             0          0               0            25           12
#> 7                                                     21           15
#> 8             3          3                            22           15
#> 9                                                     30           10
#> 10            1          1                            30           16
#> 11            3          3                            11           18
#> 12            2          2                            22           20
#> 13                                                    34           26
#> 14                                                    37           20
#> 15            1          1                            28           13
#> 16                                                    29           13
#> 17            2          2                            26           22
#> 18                                                    32            9
#> 19            5          5               5            19           16
#> 20                                                    35            8
#> 21                                                    27            6
#> 22                                                    21           11
#> 23                                                    31            6
#> 24            1          1               1            28           11
#> 25            1                          1            20            9
#>    malik_osborne scottie_barnes quincy_ballard balsa_koprivica tanor_ngom
#> 1             17             24              7              18          7
#> 2             31             30              1              21          2
#> 3             21             28              2              16          6
#> 4             19             30              4              26           
#> 5             13             29              2              14          5
#> 6             17             22              2              23          2
#> 7             24             21                             19          3
#> 8             20             13              5              14         10
#> 9             15                                            30          7
#> 10            25             22              1              14          8
#> 11            24             23              5              23         12
#> 12            19             19              4              17          9
#> 13            21             23                             17          6
#> 14            25             33              7                          6
#> 15            24             24              2              14          8
#> 16            24             26                             15          9
#> 17             9             24             11              23           
#> 18            20             22              0              24          1
#> 19                           21              5              23          8
#> 20             8             32                              6          5
#> 21            20             25              1              28          5
#> 22            22             29                             26          8
#> 23            14             26                             24         10
#> 24            20             22              1              11          7
#> 25            31             25              1              23          5
#>    starting_lineup_number        team year
#> 1                       1 Florida St. 2021
#> 2                       1 Florida St. 2021
#> 3                       1 Florida St. 2021
#> 4                       1 Florida St. 2021
#> 5                       1 Florida St. 2021
#> 6                       1 Florida St. 2021
#> 7                       1 Florida St. 2021
#> 8                       2 Florida St. 2021
#> 9                       2 Florida St. 2021
#> 10                      3 Florida St. 2021
#> 11                      3 Florida St. 2021
#> 12                      3 Florida St. 2021
#> 13                      3 Florida St. 2021
#> 14                      4 Florida St. 2021
#> 15                      4 Florida St. 2021
#> 16                      4 Florida St. 2021
#> 17                      5 Florida St. 2021
#> 18                      3 Florida St. 2021
#> 19                      6 Florida St. 2021
#> 20                      2 Florida St. 2021
#> 21                      2 Florida St. 2021
#> 22                      2 Florida St. 2021
#> 23                      2 Florida St. 2021
#> 24                      2 Florida St. 2021
#> 25                      2 Florida St. 2021
  # }

```
