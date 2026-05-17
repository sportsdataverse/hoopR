# **Get KenPom's team game plan page**

**Get KenPom's team game plan page**

## Usage

``` r
kp_gameplan(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a named list of tibbles: gameplan, correlations,
position_distributions

**gameplan**

|                |           |                                              |
|----------------|-----------|----------------------------------------------|
| col_name       | types     | description                                  |
| date           | Date      | Date in YYYY-MM-DD format.                   |
| opponent_rk    | numeric   | Opponent rk.                                 |
| opponent       | character | Opponent.                                    |
| result         | character | Result.                                      |
| location       | character | Location.                                    |
| pace           | numeric   | Possessions per 48 minutes.                  |
| off_eff        | numeric   | Off eff.                                     |
| off_eff_rk     | numeric   | Off eff rk.                                  |
| off_e_fg_pct   | numeric   | Off e field goals percentage (0-1 decimal).  |
| off_to_pct     | numeric   | Off to percentage (0-1 decimal).             |
| off_or_pct     | numeric   | Off or percentage (0-1 decimal).             |
| off_ftr        | numeric   | Off ftr.                                     |
| off_fgm_2      | numeric   | Off fgm 2.                                   |
| off_fga_2      | numeric   | Off fga 2.                                   |
| off_fg_2_pct   | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fgm_3      | numeric   | Off fgm 3.                                   |
| off_fga_3      | numeric   | Off fga 3.                                   |
| off_fg_3_pct   | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3a_pct  | numeric   | Off field goals 3a percentage (0-1 decimal). |
| def_eff        | numeric   | Def eff.                                     |
| def_eff_rk     | numeric   | Def eff rk.                                  |
| def_e_fg_pct   | numeric   | Def e field goals percentage (0-1 decimal).  |
| def_to_pct     | numeric   | Def to percentage (0-1 decimal).             |
| def_or_pct     | numeric   | Def or percentage (0-1 decimal).             |
| def_ftr        | numeric   | Def ftr.                                     |
| def_fgm_2      | numeric   | Def fgm 2.                                   |
| def_fga_2      | numeric   | Def fga 2.                                   |
| def_fg_2_pct   | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fgm_3      | numeric   | Def fgm 3.                                   |
| def_fga_3      | numeric   | Def fga 3.                                   |
| def_fg_3_pct   | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3a_pct  | numeric   | Def field goals 3a percentage (0-1 decimal). |
| wl             | character | Wl.                                          |
| team_score     | numeric   | Team's score / final score.                  |
| opponent_score | numeric   | Opponent score.                              |
| day_date       | character | Date in YYYY-MM-DD format.                   |
| game_date      | numeric   | Game date (YYYY-MM-DD).                      |

**correlations**

|                      |           |                                             |
|----------------------|-----------|---------------------------------------------|
| col_name             | types     | description                                 |
| correlations_r_x_100 | character | Correlations r x 100.                       |
| pace                 | character | Possessions per 48 minutes.                 |
| off_e_fg_pct         | character | Off e field goals percentage (0-1 decimal). |
| off_to_pct           | character | Off to percentage (0-1 decimal).            |
| off_or_pct           | character | Off or percentage (0-1 decimal).            |
| off_ftr              | character | Off ftr.                                    |
| def_e_fg_pct         | character | Def e field goals percentage (0-1 decimal). |
| def_to_pct           | character | Def to percentage (0-1 decimal).            |
| def_or_pct           | character | Def or percentage (0-1 decimal).            |
| def_ftr              | character | Def ftr.                                    |

**position_distributions**

|               |           |                                          |
|---------------|-----------|------------------------------------------|
| col_name      | types     | description                              |
| team          | character | Team-side label or team identifier.      |
| category      | character | Category label.                          |
| c_pct         | numeric   | C percentage (0-1 decimal).              |
| pf_pct        | numeric   | Personal fouls percentage (0-1 decimal). |
| sf_pct        | numeric   | Sf percentage (0-1 decimal).             |
| sg_pct        | numeric   | Sg percentage (0-1 decimal).             |
| pg_pct        | numeric   | Pg percentage (0-1 decimal).             |
| c_pct_rk      | numeric   | C pct rk.                                |
| pf_pct_rk     | numeric   | Pf pct rk.                               |
| sf_pct_rk     | numeric   | Sf pct rk.                               |
| sg_pct_rk     | numeric   | Sg pct rk.                               |
| pg_pct_rk     | numeric   | Pg pct rk.                               |
| c_pct_d1_avg  | numeric   | C pct d1 avg.                            |
| pf_pct_d1_avg | numeric   | Pf pct d1 avg.                           |
| sf_pct_d1_avg | numeric   | Sf pct d1 avg.                           |
| sg_pct_d1_avg | numeric   | Sg pct d1 avg.                           |
| pg_pct_d1_avg | numeric   | Pg pct d1 avg.                           |

## See also

Other KenPom Team Functions:
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
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
   try(kp_gameplan(team='Florida St.', year=2021))
#> $gameplan
#>          date opponent_rk       opponent    result location pace off_eff
#> 1  2020-12-02         297  North Florida  W, 86-58        H   72   118.9
#> 2  2020-12-09          50        Indiana  W, 69-67        H   62    99.1
#> 3  2020-12-12          41        Florida  W, 83-71        H   76   108.6
#> 4  2020-12-15          37   Georgia Tech  W, 74-61        H   64   115.0
#> 5  2020-12-19         100            UCF  L, 86-74        H   69   106.7
#> 6  2020-12-21         182   Gardner Webb  W, 72-59        H   74    97.5
#> 7  2020-12-29          45        Clemson  L, 77-67        A   73    91.2
#> 8  2021-01-13          71     N.C. State W, 105-73        H   69   153.3
#> 9  2021-01-16          34 North Carolina  W, 82-75        H   70   116.8
#> 10 2021-01-18          59     Louisville  W, 78-65        A   66   117.9
#> 11 2021-01-23          45        Clemson  W, 80-61        H   70   115.1
#> 12 2021-01-27         138       Miami FL  W, 81-59        H   68   118.5
#> 13 2021-01-30          37   Georgia Tech  L, 76-65        A   73    89.2
#> 14 2021-02-13         175    Wake Forest  W, 92-85        H   67   121.5
#> 15 2021-02-15          19       Virginia  W, 81-60        H   62   130.8
#> 16 2021-02-20          97     Pittsburgh  W, 79-72        A   71   111.1
#> 17 2021-02-24         138       Miami FL  W, 88-71        A   70   126.3
#> 18 2021-02-27          34 North Carolina  L, 78-70        A   75    92.9
#> 19 2021-03-03         148 Boston College  W, 93-64        H   78   119.8
#> 20 2021-03-06          85     Notre Dame  L, 83-73        A   77    94.4
#> 21 2021-03-12          34 North Carolina  W, 69-66        N   71    97.0
#> 22 2021-03-13          37   Georgia Tech  L, 80-75        N   69   108.7
#> 23 2021-03-20         108 UNC Greensboro  W, 64-54        N   66    96.5
#> 24 2021-03-22           8       Colorado  W, 71-53        N   65   109.9
#> 25 2021-03-28           3       Michigan  L, 76-58        N   68    85.4
#>    off_eff_rk off_e_fg_pct off_to_pct off_or_pct off_ftr off_fgm_2 off_fga_2
#> 1           5         50.7       13.8       47.2    30.0        25        46
#> 2          16         42.0       14.4       39.6    30.4        17        49
#> 3           8         55.6       20.9       25.0    55.6        18        38
#> 4           3         60.8       20.2       29.2    31.4        19        34
#> 5           8         56.9       20.2       26.7    51.0        14        28
#> 6          16         39.3       21.7       43.9    52.5        15        28
#> 7          15         49.2       23.1       21.1    14.5        17        30
#> 8           1         81.0       16.1       37.5    19.0        29        40
#> 9           3         56.0       24.2       36.0    54.0        16        34
#> 10          4         57.3       18.1       33.3    16.1        22        41
#> 11          4         58.3       20.1       35.3    23.3        17        32
#> 12          5         56.5       21.9       48.4    22.6        26        44
#> 13         24         45.5       28.8       44.1    41.1        21        42
#> 14          6         55.9       15.8       36.1    59.3        15        34
#> 15          2         61.2        8.1       25.0    22.4        16        34
#> 16          7         48.3       15.5       33.3    50.0        22        44
#> 17          3         60.1       15.8       42.4    10.1        28        44
#> 18         20         42.5       22.6       42.9    29.9        21        50
#> 19          4         65.9       21.9       26.7    20.6        22        36
#> 20         21         45.3       18.1       25.0    31.2        20        40
#> 21         17         50.0       25.3       32.3    41.5        19        40
#> 22          8         64.0       36.2       54.5    28.0        20        35
#> 23         15         52.1       22.6       19.2    41.7        25        39
#> 24          7         58.7       23.2       24.0    45.6        18        29
#> 25         23         44.2       20.6       25.7    10.0        19        40
#>    off_fg_2_pct off_fgm_3 off_fga_3 off_fg_3_pct off_fg_3a_pct def_eff
#> 1          54.3         7        24         29.2          34.3    80.2
#> 2          34.7         8        20         40.0          29.0    96.2
#> 3          47.4         8        16         50.0          29.6    92.9
#> 4          55.9         8        17         47.1          33.3    94.8
#> 5          50.0        10        23         43.5          45.1   124.0
#> 6          53.6         6        33         18.2          54.1    79.9
#> 7          56.7         9        32         28.1          51.6   104.8
#> 8          72.5        12        18         66.7          31.0   106.5
#> 9          47.1         8        16         50.0          32.0   106.8
#> 10         53.7         9        21         42.9          33.9    98.3
#> 11         53.1        12        28         42.9          46.7    87.8
#> 12         59.1         6        18         33.3          29.0    86.3
#> 13         50.0         3        14         21.4          25.0   104.2
#> 14         44.1        12        25         48.0          42.4   112.2
#> 15         47.1        13        24         54.2          41.4    96.9
#> 16         50.0         4        14         28.6          24.1   101.2
#> 17         63.6         9        25         36.0          36.2   101.9
#> 18         42.0         5        17         29.4          25.4   103.5
#> 19         61.1        13        27         48.1          42.9    82.5
#> 20         50.0         6        24         25.0          37.5   107.3
#> 21         47.5         5        13         38.5          24.5    92.8
#> 22         57.1         8        15         53.3          30.0   116.0
#> 23         64.1         0         9          0.0          18.8    81.4
#> 24         62.1         6        17         35.3          37.0    82.0
#> 25         47.5         5        20         25.0          33.3   112.0
#>    def_eff_rk def_e_fg_pct def_to_pct def_or_pct def_ftr def_fgm_2 def_fga_2
#> 1           2         49.0       33.2       24.2    24.0         8        23
#> 2           9         40.4       20.1       37.5    49.1        17        42
#> 3           5         50.9       26.2       28.6    27.1        15        36
#> 4           4         48.0       18.6       21.4    29.4        17        31
#> 5          23         58.3       18.8       37.0    48.1        18        35
#> 6           2         38.8       18.9       16.7    31.0         9        25
#> 7          16         42.1       16.3       41.3    52.4        16        39
#> 8          14         53.2       16.1       25.7    12.7        17        37
#> 9          17         51.6       19.9       38.2    22.6        17        38
#> 10          6         47.4       18.1       35.1    31.6        21        41
#> 11          5         34.8       17.3       25.6    46.4        12        26
#> 12          5         45.4       19.0       18.9    31.5        11        31
#> 13         11         50.0       19.2       29.4    43.9        18        33
#> 14         20         55.8       18.5       25.7    41.7        14        33
#> 15          5         56.4       21.0       14.3    25.5        13        24
#> 16         11         41.2       11.2       32.6    32.4        22        51
#> 17         18         40.0       11.5       35.4    27.1        16        47
#> 18         14         42.5       27.9       52.6    50.0        18        37
#> 19          4         46.7       29.6       34.1    28.3        10        29
#> 20         14         50.9       19.4       24.2    63.0        14        27
#> 21          5         38.2       16.9       42.0    36.8        17        50
#> 22         20         47.6       10.2       36.8    45.2        22        39
#> 23          3         37.5       15.1       25.0    21.7        12        33
#> 24          2         41.1       29.4       43.2    19.6        14        31
#> 25         13         51.7       13.3       33.3    39.0        26        48
#>    def_fg_2_pct def_fgm_3 def_fga_3 def_fg_3_pct def_fg_3a_pct wl team_score
#> 1          34.8        11        27         40.7          54.0  W         86
#> 2          40.5         4        15         26.7          26.3  W         69
#> 3          41.7        10        23         43.5          39.0  W         83
#> 4          54.8         5        20         25.0          39.2  W         74
#> 5          51.4         9        19         47.4          35.2  L         74
#> 6          36.0         9        33         27.3          56.9  W         72
#> 7          41.0         7        24         29.2          38.1  L         67
#> 8          45.9        11        26         42.3          41.3  W        105
#> 9          44.7        10        24         41.7          38.7  W         82
#> 10         51.2         4        16         25.0          28.1  W         78
#> 11         46.2         5        30         16.7          53.6  W         80
#> 12         35.5         9        23         39.1          42.6  W         81
#> 13         54.5         7        24         29.2          42.1  L         65
#> 14         42.4        13        27         48.1          45.0  W         92
#> 15         54.2         9        23         39.1          48.9  W         81
#> 16         43.1         4        17         23.5          25.0  W         79
#> 17         34.0         8        23         34.8          32.9  W         88
#> 18         48.6         5        23         21.7          38.3  L         70
#> 19         34.5        12        31         38.7          51.7  W         93
#> 20         51.9         9        27         33.3          50.0  L         73
#> 21         34.0         6        18         33.3          26.5  W         69
#> 22         56.4         5        23         21.7          37.1  L         75
#> 23         36.4         7        27         25.9          45.0  W         64
#> 24         45.2         6        25         24.0          44.6  W         71
#> 25         54.2         3        11         27.3          18.6  L         58
#>    opponent_score   day_date game_date
#> 1              58  Wed Dec 2  20201202
#> 2              67  Wed Dec 9  20201209
#> 3              71 Sat Dec 12  20201212
#> 4              61 Tue Dec 15  20201215
#> 5              86 Sat Dec 19  20201219
#> 6              59 Mon Dec 21  20201221
#> 7              77 Tue Dec 29  20201229
#> 8              73 Wed Jan 13  20210113
#> 9              75 Sat Jan 16  20210116
#> 10             65 Mon Jan 18  20210118
#> 11             61 Sat Jan 23  20210123
#> 12             59 Wed Jan 27  20210127
#> 13             76 Sat Jan 30  20210130
#> 14             85 Sat Feb 13  20210213
#> 15             60 Mon Feb 15  20210215
#> 16             72 Sat Feb 20  20210220
#> 17             71 Wed Feb 24  20210224
#> 18             78 Sat Feb 27  20210227
#> 19             64  Wed Mar 3  20210303
#> 20             83  Sat Mar 6  20210306
#> 21             66 Fri Mar 12  20210312
#> 22             80 Sat Mar 13  20210313
#> 23             54 Sat Mar 20  20210320
#> 24             53 Mon Mar 22  20210322
#> 25             76 Sun Mar 28  20210328
#> 
#> $correlations
#>        correlations_r_x_100 pace off_e_fg_pct off_to_pct off_or_pct off_ftr
#> 27 to offensive efficiency:  -28          +84        -44        +16     -15
#> 28 to defensive efficiency:   -2           +7        +13         +3      +0
#>    def_e_fg_pct def_to_pct def_or_pct def_ftr
#> 27          +30         +4        -34     -61
#> 28          +57        -48        +30     +46
#> 
#> $position_distributions
#>          team   category c_pct pf_pct sf_pct sg_pct pg_pct c_pct_rk pf_pct_rk
#> 1 Florida St.   % Points  20.2   19.1   21.8   20.8   18.1      169       188
#> 2 Florida St. % Off Rebs  35.7   21.3   18.5   15.5    9.0      173       279
#> 3 Florida St. % Def Rebs  28.9   17.5   25.3   16.1   12.0       81       324
#>   sf_pct_rk sg_pct_rk pg_pct_rk c_pct_d1_avg pf_pct_d1_avg sf_pct_d1_avg
#> 1       101       144       237         20.2          19.6          19.6
#> 2       123        73       131         36.1          27.1          16.8
#> 3        21       175       278         25.9          23.5          19.5
#>   sg_pct_d1_avg pg_pct_d1_avg
#> 1          20.2          20.4
#> 2          11.6           8.4
#> 3          16.6          14.4
#> 
# }
```
