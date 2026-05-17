# **Get KenPom's player career stats from the player page**

**Get KenPom's player career stats from the player page**

## Usage

``` r
kp_player_career(player_id)
```

## Arguments

- player_id:

  Player Id filter to select.

## Value

Returns a named list of tibbles: player_stats, gamelog

**player_stats**

|               |           |                                         |
|---------------|-----------|-----------------------------------------|
| col_name      | types     | description                             |
| year          | numeric   | 4-digit year.                           |
| team_rk       | numeric   | Team rk.                                |
| team          | character | Team-side label or team identifier.     |
| number        | numeric   | Number.                                 |
| name          | character | Display name.                           |
| position      | character | Listed roster position (G, F, C, etc.). |
| hgt           | character | Hgt.                                    |
| wgt           | numeric   | Wgt.                                    |
| yr            | character | Yr.                                     |
| g             | numeric   | Games played.                           |
| min_pct       | numeric   | Min percentage (0-1 decimal).           |
| o_rtg         | numeric   | O rtg.                                  |
| poss_pct      | numeric   | Poss percentage (0-1 decimal).          |
| shots_pct     | numeric   | Shots percentage (0-1 decimal).         |
| e_fg_pct      | numeric   | E field goals percentage (0-1 decimal). |
| ts_pct        | numeric   | True shooting percentage (0-1).         |
| or_pct        | numeric   | Or percentage (0-1 decimal).            |
| dr_pct        | numeric   | Dr percentage (0-1 decimal).            |
| a_rate        | numeric   | A rate.                                 |
| to_rate       | numeric   | To rate.                                |
| blk_pct       | numeric   | Blocks percentage (0-1 decimal).        |
| stl_pct       | numeric   | Steals percentage (0-1 decimal).        |
| f_cper40      | numeric   | F cper40.                               |
| f_dper40      | numeric   | F dper40.                               |
| ft_rate       | numeric   | Ft rate.                                |
| ftm           | numeric   | Free throws made.                       |
| fta           | numeric   | Free throw attempts.                    |
| ft_pct        | numeric   | Free throw percentage (0-1).            |
| fgm_2         | numeric   | Fgm 2.                                  |
| fga_2         | numeric   | Fga 2.                                  |
| fg_2_pct      | numeric   | Field goals 2 percentage (0-1 decimal). |
| fgm_3         | numeric   | Fgm 3.                                  |
| fga_3         | numeric   | Fga 3.                                  |
| fg_3_pct      | numeric   | Field goals 3 percentage (0-1 decimal). |
| group_rank    | character | League/season rank for group.           |
| team_finish   | character | Team finish.                            |
| ncaa_seed     | numeric   | Ncaa seed.                              |
| hometown      | character | Player hometown.                        |
| date_of_birth | character | Date of birth (YYYY-MM-DD).             |
| age           | character | Player age (in years).                  |
| comparisons   | character | Comparisons.                            |

**gamelog**

|                |           |                                         |
|----------------|-----------|-----------------------------------------|
| col_name       | types     | description                             |
| year           | numeric   | 4-digit year.                           |
| team           | character | Team-side label or team identifier.     |
| name           | character | Display name.                           |
| position       | character | Listed roster position (G, F, C, etc.). |
| opponent_tier  | logical   | Opponent tier.                          |
| date           | character | Date in YYYY-MM-DD format.              |
| opponent_rk    | numeric   | Opponent rk.                            |
| opponent       | character | Opponent.                               |
| result         | character | Result.                                 |
| ot             | character | Ot.                                     |
| location       | character | Location.                               |
| game_type      | character | Game type.                              |
| mvp            | character | Mvp.                                    |
| start          | character | Start.                                  |
| minutes_played | numeric   | Minutes played.                         |
| o_rtg          | numeric   | O rtg.                                  |
| poss_pct       | numeric   | Poss percentage (0-1 decimal).          |
| pts            | numeric   | Points scored.                          |
| fgm_2          | numeric   | Fgm 2.                                  |
| fga_2          | numeric   | Fga 2.                                  |
| fgm_3          | numeric   | Fgm 3.                                  |
| fga_3          | numeric   | Fga 3.                                  |
| ftm            | numeric   | Free throws made.                       |
| fta            | numeric   | Free throw attempts.                    |
| or             | numeric   | Or.                                     |
| dr             | numeric   | Dr.                                     |
| a              | numeric   | A.                                      |
| to             | numeric   | To.                                     |
| blk            | numeric   | Blocks.                                 |
| stl            | numeric   | Steals.                                 |
| pf             | numeric   | Personal fouls.                         |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_player_career(player_id = '41180'))
#> $player_stats
#> # A tibble: 19 × 41
#>     year team_rk team      number name  position hgt     wgt yr        g min_pct
#>    <dbl>   <dbl> <chr>      <dbl> <chr> <chr>    <chr> <dbl> <chr> <dbl>   <dbl>
#>  1  2022     105 Florida …     10 Mali… "C·PF"   "6-9"   225 "Sr"     17    37.4
#>  2  2022     105 Conferen…     10 Mali… "C·PF"   "6-9"   225 "Sr"      8    27.4
#>  3  2022     105 vs. Tier…     10 Mali… "C·PF"   "6-9"   225 "Sr"      8    34.5
#>  4  2022     105 vs. Tier…     10 Mali… "C·PF"   "6-9"   225 "Sr"      5    38  
#>  5  2021      15 Florida …     10 Mali… "PF"     "6-9"   225 "Jr"     24    47.8
#>  6  2021      15 Conferen…     10 Mali… "PF"     "6-9"   225 "Jr"     14    45.8
#>  7  2021      15 vs. Tier…     10 Mali… "PF"     "6-9"   225 "Jr"     17    53.9
#>  8  2021      15 vs. Tier…     10 Mali… "PF"     "6-9"   225 "Jr"     10    55.5
#>  9  2020      15 Florida …     10 Mali… "PF·C"   "6-9"   225 "So"     31    48.2
#> 10  2020      15 Conferen…     10 Mali… "PF·C"   "6-9"   225 "So"     20    48.9
#> 11  2020      15 vs. Tier…     10 Mali… "PF·C"   "6-9"   225 "So"     17    53.3
#> 12  2020      15 vs. Tier…     10 Mali… "PF·C"   "6-9"   225 "So"     10    55.1
#> 13  2018     289 Rice          10 Mali… "C"      "6-8"   200 "Fr"     29    68.4
#> 14  2018     289 Conferen…     10 Mali… "C"      "6-8"   200 "Fr"     18    71.9
#> 15  2018     289 vs. Tier…     10 Mali… "C"      "6-8"   200 "Fr"     11    71.5
#> 16  2018     289 vs. Tier…     10 Mali… "C"      "6-8"   200 "Fr"      2    58.8
#> 17    NA      NA Career        NA NA    ""       ""       NA ""      101    NA  
#> 18    NA      NA vs. Tier…     NA NA    ""       ""       NA ""       53    NA  
#> 19    NA      NA vs. Tier…     NA NA    ""       ""       NA ""       27    NA  
#> # ℹ 30 more variables: o_rtg <dbl>, poss_pct <dbl>, shots_pct <dbl>,
#> #   e_fg_pct <dbl>, ts_pct <dbl>, or_pct <dbl>, dr_pct <dbl>, a_rate <dbl>,
#> #   to_rate <dbl>, blk_pct <dbl>, stl_pct <dbl>, f_cper40 <dbl>,
#> #   f_dper40 <dbl>, ft_rate <dbl>, ftm <dbl>, fta <dbl>, ft_pct <dbl>,
#> #   fgm_2 <dbl>, fga_2 <dbl>, fg_2_pct <dbl>, fgm_3 <dbl>, fga_3 <dbl>,
#> #   fg_3_pct <dbl>, group_rank <chr>, team_finish <chr>, ncaa_seed <dbl>,
#> #   hometown <chr>, date_of_birth <chr>, age <chr>, comparisons <chr>
#> 
#> $gamelog
#>     year        team          name position opponent_tier   date opponent_rk
#> 1   2022 Florida St. Malik Osborne     C·PF            NA  Mar 9          69
#> 2   2022 Florida St. Malik Osborne     C·PF            NA  Mar 5         128
#> 3   2022 Florida St. Malik Osborne     C·PF            NA  Mar 2          38
#> 4   2022 Florida St. Malik Osborne     C·PF            NA Feb 26          72
#> 5   2022 Florida St. Malik Osborne     C·PF            NA Feb 21         114
#> 6   2022 Florida St. Malik Osborne     C·PF            NA Feb 19           8
#> 7   2022 Florida St. Malik Osborne     C·PF            NA Feb 15          71
#> 8   2022 Florida St. Malik Osborne     C·PF            NA Feb 12          16
#> 9   2022 Florida St. Malik Osborne     C·PF            NA  Feb 9         195
#> 10  2022 Florida St. Malik Osborne     C·PF            NA  Feb 5          35
#> 11  2022 Florida St. Malik Osborne     C·PF            NA  Feb 2          71
#> 12  2022 Florida St. Malik Osborne     C·PF            NA Jan 29          19
#> 13  2022 Florida St. Malik Osborne     C·PF            NA Jan 26         156
#> 14  2022 Florida St. Malik Osborne     C·PF            NA Jan 22          41
#> 15  2022 Florida St. Malik Osborne     C·PF            NA Jan 20         272
#> 16  2022 Florida St. Malik Osborne     C·PF            NA Jan 18           8
#> 17  2022 Florida St. Malik Osborne     C·PF            NA Jan 15          69
#> 18  2022 Florida St. Malik Osborne     C·PF            NA Jan 11          41
#> 19  2022 Florida St. Malik Osborne     C·PF            NA  Jan 8         127
#> 20  2022 Florida St. Malik Osborne     C·PF            NA  Jan 4          35
#> 21  2022 Florida St. Malik Osborne     C·PF            NA  Jan 1         128
#> 22  2022 Florida St. Malik Osborne     C·PF            NA Dec 15         264
#> 23  2022 Florida St. Malik Osborne     C·PF            NA Dec 12          99
#> 24  2022 Florida St. Malik Osborne     C·PF            NA  Dec 4          69
#> 25  2022 Florida St. Malik Osborne     C·PF            NA Nov 30          14
#> 26  2022 Florida St. Malik Osborne     C·PF            NA Nov 24         218
#> 27  2022 Florida St. Malik Osborne     C·PF            NA Nov 22         137
#> 28  2022 Florida St. Malik Osborne     C·PF            NA Nov 21         203
#> 29  2022 Florida St. Malik Osborne     C·PF            NA Nov 17          98
#> 30  2022 Florida St. Malik Osborne     C·PF            NA Nov 14          59
#> 31  2022 Florida St. Malik Osborne     C·PF            NA Nov 10         211
#> 32  2021 Florida St. Malik Osborne       PF            NA Mar 28           3
#> 33  2021 Florida St. Malik Osborne       PF            NA Mar 22           8
#> 34  2021 Florida St. Malik Osborne       PF            NA Mar 20         108
#> 35  2021 Florida St. Malik Osborne       PF            NA Mar 13          37
#> 36  2021 Florida St. Malik Osborne       PF            NA Mar 12          34
#> 37  2021 Florida St. Malik Osborne       PF            NA  Mar 6          85
#> 38  2021 Florida St. Malik Osborne       PF            NA  Mar 3         148
#> 39  2021 Florida St. Malik Osborne       PF            NA Feb 27          34
#> 40  2021 Florida St. Malik Osborne       PF            NA Feb 24         138
#> 41  2021 Florida St. Malik Osborne       PF            NA Feb 20          97
#> 42  2021 Florida St. Malik Osborne       PF            NA Feb 15          19
#> 43  2021 Florida St. Malik Osborne       PF            NA Feb 13         175
#> 44  2021 Florida St. Malik Osborne       PF            NA Jan 30          37
#> 45  2021 Florida St. Malik Osborne       PF            NA Jan 27         138
#> 46  2021 Florida St. Malik Osborne       PF            NA Jan 23          45
#> 47  2021 Florida St. Malik Osborne       PF            NA Jan 18          59
#> 48  2021 Florida St. Malik Osborne       PF            NA Jan 16          34
#> 49  2021 Florida St. Malik Osborne       PF            NA Jan 13          71
#> 50  2021 Florida St. Malik Osborne       PF            NA Dec 29          45
#> 51  2021 Florida St. Malik Osborne       PF            NA Dec 21         182
#> 52  2021 Florida St. Malik Osborne       PF            NA Dec 19         100
#> 53  2021 Florida St. Malik Osborne       PF            NA Dec 15          37
#> 54  2021 Florida St. Malik Osborne       PF            NA Dec 12          41
#> 55  2021 Florida St. Malik Osborne       PF            NA  Dec 9          50
#> 56  2021 Florida St. Malik Osborne       PF            NA  Dec 2         297
#> 57  2020 Florida St. Malik Osborne     PF·C            NA  Mar 7         179
#> 58  2020 Florida St. Malik Osborne     PF·C            NA  Mar 4          57
#> 59  2020 Florida St. Malik Osborne     PF·C            NA Feb 29          72
#> 60  2020 Florida St. Malik Osborne     PF·C            NA Feb 24           9
#> 61  2020 Florida St. Malik Osborne     PF·C            NA Feb 22          50
#> 62  2020 Florida St. Malik Osborne     PF·C            NA Feb 18         111
#> 63  2020 Florida St. Malik Osborne     PF·C            NA Feb 15          51
#> 64  2020 Florida St. Malik Osborne     PF·C            NA Feb 10           5
#> 65  2020 Florida St. Malik Osborne     PF·C            NA  Feb 8         104
#> 66  2020 Florida St. Malik Osborne     PF·C            NA  Feb 3          84
#> 67  2020 Florida St. Malik Osborne     PF·C            NA  Feb 1         105
#> 68  2020 Florida St. Malik Osborne     PF·C            NA Jan 28          42
#> 69  2020 Florida St. Malik Osborne     PF·C            NA Jan 25          57
#> 70  2020 Florida St. Malik Osborne     PF·C            NA Jan 18         104
#> 71  2020 Florida St. Malik Osborne     PF·C            NA Jan 15          42
#> 72  2020 Florida St. Malik Osborne     PF·C            NA  Jan 8         103
#> 73  2020 Florida St. Malik Osborne     PF·C            NA  Jan 4           9
#> 74  2020 Florida St. Malik Osborne     PF·C            NA Dec 31          64
#> 75  2020 Florida St. Malik Osborne     PF·C            NA Dec 28         284
#> 76  2020 Florida St. Malik Osborne     PF·C            NA Dec 21         125
#> 77  2020 Florida St. Malik Osborne     PF·C            NA Dec 17         166
#> 78  2020 Florida St. Malik Osborne     PF·C            NA  Dec 8          72
#> 79  2020 Florida St. Malik Osborne     PF·C            NA  Dec 3          34
#> 80  2020 Florida St. Malik Osborne     PF·C            NA Nov 30          24
#> 81  2020 Florida St. Malik Osborne     PF·C            NA Nov 29          68
#> 82  2020 Florida St. Malik Osborne     PF·C            NA Nov 25         353
#> 83  2020 Florida St. Malik Osborne     PF·C            NA Nov 23         176
#> 84  2020 Florida St. Malik Osborne     PF·C            NA Nov 20         147
#> 85  2020 Florida St. Malik Osborne     PF·C            NA Nov 15         156
#> 86  2020 Florida St. Malik Osborne     PF·C            NA Nov 10          32
#> 87  2020 Florida St. Malik Osborne     PF·C            NA  Nov 6         111
#> 88  2018        Rice Malik Osborne        C            NA  Mar 3         174
#> 89  2018        Rice Malik Osborne        C            NA  Mar 1         240
#> 90  2018        Rice Malik Osborne        C            NA Feb 24         222
#> 91  2018        Rice Malik Osborne        C            NA Feb 22         233
#> 92  2018        Rice Malik Osborne        C            NA Feb 17          47
#> 93  2018        Rice Malik Osborne        C            NA Feb 15         105
#> 94  2018        Rice Malik Osborne        C            NA Feb 10         109
#> 95  2018        Rice Malik Osborne        C            NA  Feb 8          45
#> 96  2018        Rice Malik Osborne        C            NA  Feb 3         146
#> 97  2018        Rice Malik Osborne        C            NA Jan 27         233
#> 98  2018        Rice Malik Osborne        C            NA Jan 25         222
#> 99  2018        Rice Malik Osborne        C            NA Jan 20         149
#> 100 2018        Rice Malik Osborne        C            NA Jan 18         206
#> 101 2018        Rice Malik Osborne        C            NA Jan 13         146
#> 102 2018        Rice Malik Osborne        C            NA  Jan 6         308
#> 103 2018        Rice Malik Osborne        C            NA  Jan 4          64
#> 104 2018        Rice Malik Osborne        C            NA Dec 30         240
#> 105 2018        Rice Malik Osborne        C            NA Dec 28         174
#> 106 2018        Rice Malik Osborne        C            NA Dec 22         228
#> 107 2018        Rice Malik Osborne        C            NA Dec 19         106
#> 108 2018        Rice Malik Osborne        C            NA Dec 16          11
#> 109 2018        Rice Malik Osborne        C            NA Dec 14          NA
#> 110 2018        Rice Malik Osborne        C            NA  Dec 9         112
#> 111 2018        Rice Malik Osborne        C            NA  Dec 2         260
#> 112 2018        Rice Malik Osborne        C            NA Nov 29         128
#> 113 2018        Rice Malik Osborne        C            NA Nov 25          NA
#> 114 2018        Rice Malik Osborne        C            NA Nov 22         108
#> 115 2018        Rice Malik Osborne        C            NA Nov 20         107
#> 116 2018        Rice Malik Osborne        C            NA Nov 17         345
#> 117 2018        Rice Malik Osborne        C            NA Nov 14         101
#> 118 2018        Rice Malik Osborne        C            NA Nov 10         286
#>                 opponent    result ot  location game_type  mvp        start
#> 1               Syracuse  L, 96-57      Neutral     ACC-T      Did not play
#> 2             N.C. State  W, 89-76         Home       ACC      Did not play
#> 3             Notre Dame  W, 74-70         Home       ACC      Did not play
#> 4               Virginia  W, 64-63         Away       ACC      Did not play
#> 5         Boston College  L, 71-55         Away       ACC      Did not play
#> 6                   Duke  L, 88-70         Away       ACC      Did not play
#> 7                Clemson  W, 81-80         Home       ACC      Did not play
#> 8         North Carolina  L, 94-74         Away       ACC      Did not play
#> 9             Pittsburgh  L, 56-51         Home       ACC      Did not play
#> 10           Wake Forest  L, 68-60         Home       ACC      Did not play
#> 11               Clemson  L, 75-69         Away       ACC      Did not play
#> 12         Virginia Tech  L, 85-72         Home       ACC      Did not play
#> 13          Georgia Tech  L, 75-61         Away       ACC                  
#> 14              Miami FL  W, 61-60         Away       ACC                  
#> 15         North Florida  W, 86-73         Home                Did not play
#> 16                  Duke  W, 79-78 OT      Home       ACC                  
#> 17              Syracuse  W, 76-71         Away       ACC      Did not play
#> 18              Miami FL  W, 65-64         Home       ACC            \u0095
#> 19            Louisville  W, 79-70         Home       ACC            \u0095
#> 20           Wake Forest  L, 76-54         Away       ACC            \u0095
#> 21            N.C. State  W, 83-81         Away       ACC            \u0095
#> 22              Lipscomb  W, 97-60         Home                      \u0095
#> 23        South Carolina  L, 66-65    Semi-Away            MVP       \u0095
#> 24              Syracuse  L, 63-60         Home       ACC            \u0095
#> 25                Purdue  L, 93-65         Away                      \u0095
#> 26     Boston University  W, 81-80 OT      Home                      \u0095
#> 27              Missouri  W, 81-58      Neutral                      \u0095
#> 28      Loyola Marymount  W, 73-45      Neutral            MVP       \u0095
#> 29                Tulane  W, 59-54         Home                      \u0095
#> 30               Florida  L, 71-55         Away                      \u0095
#> 31                  Penn W, 105-70         Home            MVP       \u0095
#> 32              Michigan  L, 76-58      Neutral    NCAA-T <NA>             
#> 33              Colorado  W, 71-53      Neutral    NCAA-T <NA>             
#> 34        UNC Greensboro  W, 64-54      Neutral    NCAA-T <NA>             
#> 35          Georgia Tech  L, 80-75      Neutral     ACC-T <NA>             
#> 36        North Carolina  W, 69-66      Neutral     ACC-T <NA>             
#> 37            Notre Dame  L, 83-73         Away       ACC <NA>             
#> 38        Boston College  W, 93-64         Home       ACC <NA> Did not play
#> 39        North Carolina  L, 78-70         Away       ACC <NA>             
#> 40              Miami FL  W, 88-71         Away       ACC <NA>       \u0095
#> 41            Pittsburgh  W, 79-72         Away       ACC <NA>       \u0095
#> 42              Virginia  W, 81-60         Home       ACC <NA>       \u0095
#> 43           Wake Forest  W, 92-85 OT      Home       ACC <NA>       \u0095
#> 44          Georgia Tech  L, 76-65         Away       ACC <NA>             
#> 45              Miami FL  W, 81-59         Home       ACC <NA>             
#> 46               Clemson  W, 80-61         Home       ACC <NA>             
#> 47            Louisville  W, 78-65         Away       ACC <NA>             
#> 48        North Carolina  W, 82-75         Home       ACC <NA>             
#> 49            N.C. State W, 105-73         Home       ACC <NA>             
#> 50               Clemson  L, 77-67         Away       ACC <NA>             
#> 51          Gardner Webb  W, 72-59         Home           <NA>             
#> 52                   UCF  L, 86-74         Home           <NA>             
#> 53          Georgia Tech  W, 74-61         Home       ACC <NA>             
#> 54               Florida  W, 83-71         Home           <NA>             
#> 55               Indiana  W, 69-67 OT      Home           <NA>             
#> 56         North Florida  W, 86-58         Home           <NA>             
#> 57        Boston College  W, 80-62         Home       ACC <NA>             
#> 58            Notre Dame  W, 73-71         Away       ACC <NA>       \u0095
#> 59               Clemson  L, 70-69         Away       ACC <NA>       \u0095
#> 60            Louisville  W, 82-67         Home       ACC <NA>       \u0095
#> 61            N.C. State  W, 67-61         Away       ACC <NA>       \u0095
#> 62            Pittsburgh  W, 82-67         Home       ACC <NA>       \u0095
#> 63              Syracuse  W, 80-77         Home       ACC <NA>       \u0095
#> 64                  Duke  L, 70-65         Away       ACC <NA>       \u0095
#> 65              Miami FL  W, 99-81         Home       ACC <NA>       \u0095
#> 66        North Carolina  W, 65-59         Home       ACC <NA>       \u0095
#> 67         Virginia Tech  W, 74-63         Away       ACC <NA>       \u0095
#> 68              Virginia  L, 61-56         Away       ACC <NA>       \u0095
#> 69            Notre Dame  W, 85-84         Home       ACC <NA>       \u0095
#> 70              Miami FL  W, 83-79 OT      Away       ACC <NA>       \u0095
#> 71              Virginia  W, 54-50         Home       ACC <NA>       \u0095
#> 72           Wake Forest  W, 78-68         Away       ACC <NA>       \u0095
#> 73            Louisville  W, 78-65         Away       ACC <NA>       \u0095
#> 74          Georgia Tech  W, 70-58         Home       ACC <NA>       \u0095
#> 75         North Alabama  W, 88-71         Home           <NA>       \u0095
#> 76         South Florida  W, 66-60      Neutral           <NA>             
#> 77         North Florida  W, 98-81         Home           <NA>             
#> 78               Clemson  W, 72-53         Home       ACC <NA>       \u0095
#> 79               Indiana  L, 80-64         Away           <NA>       \u0095
#> 80                Purdue  W, 63-60 OT   Neutral           <NA>       \u0095
#> 81             Tennessee  W, 60-57      Neutral           <NA>       \u0095
#> 82           Chicago St. W, 113-56         Home           <NA>       \u0095
#> 83        St. Francis PA  W, 80-65         Home           <NA>       \u0095
#> 84           Chattanooga  W, 89-53         Home           <NA>       \u0095
#> 85      Western Carolina  W, 79-74         Home           <NA>       \u0095
#> 86               Florida  W, 63-51         Away           <NA>       \u0095
#> 87            Pittsburgh  L, 63-61         Away       ACC <NA>       \u0095
#> 88                  UTSA  L, 79-60         Home      CUSA            \u0095
#> 89                  UTEP  W, 76-70         Home      CUSA            \u0095
#> 90                   FIU  L, 67-64         Away      CUSA            \u0095
#> 91      Florida Atlantic  W, 79-76 OT      Away      CUSA            \u0095
#> 92      Western Kentucky  L, 85-66         Home      CUSA            \u0095
#> 93              Marshall  L, 93-80         Home      CUSA            \u0095
#> 94                   UAB  L, 61-56         Away      CUSA            \u0095
#> 95      Middle Tennessee  L, 94-75         Away      CUSA            \u0095
#> 96           North Texas  L, 74-70         Away      CUSA            \u0095
#> 97      Florida Atlantic  L, 63-62         Home      CUSA            \u0095
#> 98                   FIU  W, 73-64         Home      CUSA            \u0095
#> 99        Louisiana Tech  L, 69-54         Away      CUSA            \u0095
#> 100        Southern Miss  L, 86-75         Away      CUSA            \u0095
#> 101          North Texas  L, 85-78         Home      CUSA            \u0095
#> 102            Charlotte  W, 73-64         Home      CUSA  MVP       \u0095
#> 103         Old Dominion  L, 82-75 OT      Home      CUSA            \u0095
#> 104                 UTEP  L, 80-62         Away      CUSA            \u0095
#> 105                 UTSA  L, 79-66         Away      CUSA            \u0095
#> 106            Texas St.  L, 74-66         Home                      \u0095
#> 107           New Mexico  L, 78-69         Away                      \u0095
#> 108           Texas Tech  L, 73-53         Away                      \u0095
#> 109          St. Edwards  W, 91-86         Home                      \u0095
#> 110    Stephen F. Austin  L, 81-62         Away                      \u0095
#> 111 UT Rio Grande Valley  L, 69-67         Home                      \u0095
#> 112         UT Arlington  L, 69-49         Away                      \u0095
#> 113        St. Thomas TX  W, 70-59         Home                      \u0095
#> 114          Mississippi  L, 79-62      Neutral                      \u0095
#> 115                 UNLV  L, 95-68    Semi-Away                            
#> 116     Northwestern St.  W, 87-65         Away                            
#> 117          Georgia St.  L, 75-54         Home                            
#> 118     Eastern Kentucky  L, 73-72         Home                            
#>     minutes_played o_rtg poss_pct pts fgm_2 fga_2 fgm_3 fga_3 ftm fta or dr  a
#> 1               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 2               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 3               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 4               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 5               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 6               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 7               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 8               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 9               NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 10              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 11              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 12              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 13              19    65       16   3     1     3     0     2   1   3  0  2  1
#> 14              23    66       22   4     1     8     0     2   2   2  4  4  0
#> 15              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 16              32   100       16   7     0     1     1     6   4   4  1  6  3
#> 17              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 18              32   110       14   7     1     4     1     3   2   2  2  6  2
#> 19              24   108       18   6     1     3     0     3   4   4  2  4  2
#> 20              32    74       13   6     2     4     0     4   2   2  1  7  0
#> 21              31   139       21  19     3     6     2     4   7   8  1  6  0
#> 22              22   184       15  12     2     3     2     3   2   2  2  3  2
#> 23              33   132       18  15     1     2     3     6   4   6  3  6  0
#> 24              28   102       20  10     0     2     2     7   4   4  2  6  1
#> 25              34   122        9   6     2     3     0     2   2   2  2  2  0
#> 26              30   146       12  10     4     4     0     1   2   2  2  5  0
#> 27              19   137       17  10     2     3     2     3   0   0  1  6  0
#> 28              20   181       15  10     0     2     2     2   4   4  1  2  2
#> 29              32   128       12   9     2     4     1     1   2   3  4  6  0
#> 30              33   118       24  18     3     6     3     4   3   5  2  4  2
#> 31              23   171       22  18     3     3     1     3   9  12  7  6  0
#> 32              31   124       15  12     0     2     4     7   0   0  0  6  1
#> 33              20   120       23  11     3     4     1     4   2   3  1  4  0
#> 34              14   135       12   4     0     0     0     0   4   4  0  5  0
#> 35              22   122        7   3     0     1     1     1   0   0  0  3  1
#> 36              20   223        7   9     0     0     3     4   0   0  0  2  0
#> 37               8    NA       NA   0     0     0     0     0   0   0  0  1  0
#> 38              NA    NA       NA  NA    NA    NA    NA    NA  NA  NA NA NA NA
#> 39              20    79       11   3     1     3     0     0   1   2  2  0  0
#> 40               9    NA       NA   2     1     1     0     1   0   0  1  3  0
#> 41              24   170       15  12     3     3     0     1   6   7  2  7  0
#> 42              24   100       17   7     2     4     1     4   0   0  1  1  0
#> 43              25   140       21  12     0     3     3     4   3   4  4  4  1
#> 44              21    23       11   1     0     3     0     3   1   2  0  3  0
#> 45              19   167       18  11     3     5     1     2   2   2  2  8  0
#> 46              24   142       10   8     1     2     2     4   0   0  0  4  0
#> 47              25   120       21  12     4     5     0     3   4   4  1  2  0
#> 48              15   146       21  10     1     2     2     3   2   2  1  1  0
#> 49              20    46        7   0     0     1     0     2   0   0  1  3  0
#> 50              24    67       14   2     1     2     0     3   0   0  2  6  2
#> 51              17    79       34   8     3     5     0     2   2   3  6  2  0
#> 52              13    82        7   0     0     0     0     0   0   0  2  3  0
#> 53              19    68       12   2     1     3     0     0   0   0  0  1  1
#> 54              21    48       13   2     1     4     0     1   0   0  1  1  0
#> 55              31   164        8   5     0     2     1     1   2   2  4  5  1
#> 56              17   124       16   6     2     2     0     2   2   2  3  0  0
#> 57              12    88       11   2     0     1     0     0   2   4  1  3  0
#> 58              20    78       22   4     1     3     0     2   2   2  3  2  1
#> 59              14    91       38  11     1     3     3     3   0   3  2  6  0
#> 60              15   108       19   4     2     2     0     2   0   0  2  5  1
#> 61              30   102       20   9     4     5     0     3   1   6  5  7  0
#> 62              11   117       22   5     2     2     0     2   1   1  1  0  1
#> 63              17   124       11   4     1     4     0     0   2   2  2  1  0
#> 64              23   109       29  14     4     7     2     6   0   0  4  1  0
#> 65              12   223        8   6     0     1     2     2   0   0  1  2  0
#> 66              15   158       17   8     2     4     1     1   1   1  2  4  0
#> 67              11   104        5   1     0     0     0     0   1   2  0  2  0
#> 68              25    76       17   5     2     5     0     2   1   1  1  3  0
#> 69              14     0       12   0     0     1     0     1   0   0  0  1  0
#> 70              31   122        8   6     2     3     0     1   2   3  1  4  0
#> 71              26   125       10   5     1     2     1     3   0   0  3  1  0
#> 72              21   129       19   9     2     5     1     1   2   2  3  2  0
#> 73              30   121       15   7     2     4     1     3   0   0  4  5  1
#> 74              22   154       11   7     2     4     1     1   0   0  0  4  2
#> 75              18   132       28  14     4     7     2     5   0   0  3  1  0
#> 76              14    87       12   2     1     1     0     1   0   0  1  0  1
#> 77              10   101       23   2     1     4     0     1   0   0  3  2  1
#> 78              22   102       15   5     1     1     1     4   0   0  1  5  1
#> 79              22   126       15   7     2     3     1     2   0   0  1  2  1
#> 80              18   123       12   4     1     2     0     1   2   2  2  4  0
#> 81              16   128       10   4     0     0     1     1   1   4  2  4  0
#> 82              15   208        8   4     2     2     0     0   0   0  2  3  1
#> 83              24   131       12   9     0     2     3     5   0   0  1  3  0
#> 84              20   103       25  10     3     7     1     3   1   1  0  3  2
#> 85              25   150       12   6     2     2     0     0   2   3  4  5  1
#> 86              26   137       15  10     4     7     0     0   2   2  2  2  0
#> 87              23    62       12   2     1     2     0     2   0   0  2  7  0
#> 88              31    96       18   9     2     4     1     6   2   2  3  5  0
#> 89              27    81       29  10     2     5     1     5   3   8  4  6  1
#> 90              35   116       26  20     5     9     2     5   4   6  4  2  2
#> 91              26    57       30   8     3     7     0     5   2   3  1  5  0
#> 92              34   122       16  15     3     6     3     4   0   1  1  3  1
#> 93              32   105       33  22     4     8     3     9   5   9  3 10  1
#> 94              27    73       19   6     3     4     0     4   0   0  2  7  1
#> 95              24    81       30  11     4     7     0     3   3   4  2  3  0
#> 96              25    59       27   7     2     3     0     2   3   7  1  2  0
#> 97              33    88       26  10     3     8     1     6   1   2  4  4  1
#> 98              30   114       22  16     2     5     3     5   3   5  1  4  2
#> 99              33    96       19  11     2     6     2     4   1   1  2  5  0
#> 100             29   158       19  17     5     7     1     2   4   4  2  6  1
#> 101             26    75       17   4     0     2     0     1   4   6  2  2  1
#> 102             24   126       32  18     3     3     1     2   9  11  2  4  1
#> 103             30   113       11   5     2     4     0     0   1   3  1  4  2
#> 104             26   101       18   7     2     5     0     1   3   3  2  4  1
#> 105             33    87       14   7     3     4     0     1   1   4  4  9  0
#> 106             25   113       14   8     2     4     1     1   1   2  1  1  0
#> 107             32   137       16  12     4     7     0     0   4   4  5  6  0
#> 108             23    85       17   4     1     3     0     1   2   2  2  2  2
#> 109             24    88       20   9     1     2     0     1   7   8  0  3  1
#> 110             36    62       19   8     3     3     0     2   2   6  3  6  1
#> 111             30   128       18  14     1     4     3     5   3   3  2  4  0
#> 112             29    10        9   0     0     1     0     2   0   2  0  3  1
#> 113             17    95       16   4     2     3     0     1   0   1  3  4  1
#> 114             25    78       16   4     0     2     0     2   4   4  3  3  2
#> 115             25   108       10   4     2     3     0     1   0   0  5  4  0
#> 116             19    67       25   4     2     6     0     1   0   0  3  5  1
#> 117             26    97       15   5     2     4     0     1   1   2  3  5  2
#> 118              5    NA       NA   1     0     0     0     0   1   2  0  0  0
#>     to blk stl pf
#> 1   NA  NA  NA NA
#> 2   NA  NA  NA NA
#> 3   NA  NA  NA NA
#> 4   NA  NA  NA NA
#> 5   NA  NA  NA NA
#> 6   NA  NA  NA NA
#> 7   NA  NA  NA NA
#> 8   NA  NA  NA NA
#> 9   NA  NA  NA NA
#> 10  NA  NA  NA NA
#> 11  NA  NA  NA NA
#> 12  NA  NA  NA NA
#> 13   0   0   0  1
#> 14   0   0   2  4
#> 15  NA  NA  NA NA
#> 16   1   0   0  2
#> 17  NA  NA  NA NA
#> 18   1   0   1  1
#> 19   0   0   2  1
#> 20   0   0   1  0
#> 21   1   0   1  0
#> 22   0   1   0  0
#> 23   1   1   2  2
#> 24   1   0   2  3
#> 25   0   0   1  2
#> 26   1   0   0  4
#> 27   1   0   0  0
#> 28   0   0   1  0
#> 29   1   2   0  1
#> 30   3   0   3  1
#> 31   0   0   1  1
#> 32   1   0   0  3
#> 33   0   0   1  1
#> 34   1   0   0  1
#> 35   1   0   0  2
#> 36   0   0   1  2
#> 37   2   0   1  1
#> 38  NA  NA  NA NA
#> 39   1   0   2  4
#> 40   0   0   0  0
#> 41   0   0   0  2
#> 42   0   0   0  1
#> 43   1   0   0  3
#> 44   0   2   1  4
#> 45   0   0   0  1
#> 46   0   1   2  1
#> 47   1   0   1  2
#> 48   1   1   0  1
#> 49   0   0   0  2
#> 50   1   1   0  2
#> 51   4   1   0  4
#> 52   1   0   0  2
#> 53   1   0   0  3
#> 54   1   0   1  4
#> 55   0   1   2  3
#> 56   1   0   2  1
#> 57   0   1   0  1
#> 58   2   0   0  3
#> 59   3   0   0  4
#> 60   1   0   0  0
#> 61   0   2   0  2
#> 62   1   1   1  0
#> 63   0   0   2  1
#> 64   2   2   0  3
#> 65   0   0   0  2
#> 66   0   0   0  1
#> 67   0   0   0  0
#> 68   0   2   1  2
#> 69   2   0   0  2
#> 70   0   1   1  3
#> 71   0   1   0  0
#> 72   1   0   3  2
#> 73   1   1   0  4
#> 74   0   1   2  1
#> 75   0   1   1  2
#> 76   1   0   2  2
#> 77   0   1   0  0
#> 78   1   2   0  3
#> 79   1   0   2  1
#> 80   0   0   0  2
#> 81   0   0   3  1
#> 82   0   0   0  1
#> 83   1   2   0  2
#> 84   1   0   0  1
#> 85   1   1   0  2
#> 86   0   0   1  4
#> 87   1   4   0  5
#> 88   1   1   0  1
#> 89   2   1   1  4
#> 90   2   0   1  2
#> 91   2   1   0  4
#> 92   1   1   0  0
#> 93   2   0   0  1
#> 94   2   0   2  4
#> 95   3   1   0  1
#> 96   4   2   0  4
#> 97   0   3   1  1
#> 98   2   0   0  3
#> 99   2   2   1  0
#> 100  1   0   1  1
#> 101  2   2   1  2
#> 102  4   3   1  4
#> 103  0   1   0  4
#> 104  1   0   0  1
#> 105  2   0   1  3
#> 106  1   0   0  5
#> 107  1   1   0  1
#> 108  2   0   1  5
#> 109  4   0   1  2
#> 110  6   1   4  2
#> 111  1   0   0  3
#> 112  1   0   2  2
#> 113  1   0   0  2
#> 114  2   1   0  1
#> 115  1   2   1  1
#> 116  3   0   0  3
#> 117  1   1   0  1
#> 118  0   0   0  1
#> 
  # }
```
