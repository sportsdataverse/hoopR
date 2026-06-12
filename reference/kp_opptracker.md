# **Get KenPom's team opponent tracker page**

**Get KenPom's team opponent tracker page**

## Usage

``` r
kp_opptracker(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of team opponent tracker data

|                  |           |                                              |
|------------------|-----------|----------------------------------------------|
| col_name         | types     | description                                  |
| date             | Date      | Date in YYYY-MM-DD format.                   |
| game_date        | numeric   | Game date (YYYY-MM-DD).                      |
| day_date         | character | Date in YYYY-MM-DD format.                   |
| wl               | character | Wl.                                          |
| team             | character | Team-side label or team identifier.          |
| team_score       | numeric   | Team's score / final score.                  |
| opponent         | character | Opponent.                                    |
| opponent_score   | numeric   | Opponent score.                              |
| result           | character | Result.                                      |
| adj_oe           | numeric   | Adj oe.                                      |
| adj_oe_rk        | integer   | Adj oe rk.                                   |
| off_e_fg_pct     | numeric   | Off e field goals percentage (0-1 decimal).  |
| off_e_fg_pct_rk  | integer   | Off e fg pct rk.                             |
| off_to_pct       | numeric   | Off to percentage (0-1 decimal).             |
| off_to_pct_rk    | integer   | Off to pct rk.                               |
| off_or_pct       | numeric   | Off or percentage (0-1 decimal).             |
| off_or_pct_rk    | integer   | Off or pct rk.                               |
| off_ft_rate      | numeric   | Off ft rate.                                 |
| off_ft_rate_rk   | integer   | Off ft rate rk.                              |
| off_fg_2_pct     | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fg_2_pct_rk  | integer   | Off fg 2 pct rk.                             |
| off_fg_3_pct     | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3_pct_rk  | integer   | Off fg 3 pct rk.                             |
| off_blk_pct      | numeric   | Off blocks percentage (0-1 decimal).         |
| off_blk_pct_rk   | integer   | Off blk pct rk.                              |
| off_fg_3a_pct    | numeric   | Off field goals 3a percentage (0-1 decimal). |
| off_fg_3a_pct_rk | integer   | Off fg 3a pct rk.                            |
| off_apl          | numeric   | Off apl.                                     |
| off_apl_rk       | integer   | Off apl rk.                                  |
| adj_de           | numeric   | Adj de.                                      |
| adj_de_rk        | integer   | Adj de rk.                                   |
| def_e_fg_pct     | numeric   | Def e field goals percentage (0-1 decimal).  |
| def_e_fg_pct_rk  | integer   | Def e fg pct rk.                             |
| def_to_pct       | numeric   | Def to percentage (0-1 decimal).             |
| def_to_pct_rk    | integer   | Def to pct rk.                               |
| def_or_pct       | numeric   | Def or percentage (0-1 decimal).             |
| def_or_pct_rk    | integer   | Def or pct rk.                               |
| def_ft_rate      | numeric   | Def ft rate.                                 |
| def_ft_rate_rk   | integer   | Def ft rate rk.                              |
| def_fg_2_pct     | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fg_2_pct_rk  | integer   | Def fg 2 pct rk.                             |
| def_fg_3_pct     | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3_pct_rk  | integer   | Def fg 3 pct rk.                             |
| def_blk_pct      | numeric   | Def blocks percentage (0-1 decimal).         |
| def_blk_pct_rk   | integer   | Def blk pct rk.                              |
| def_fg_3a_pct    | numeric   | Def field goals 3a percentage (0-1 decimal). |
| def_fg_3a_pct_rk | integer   | Def fg 3a pct rk.                            |
| def_apl          | numeric   | Def apl.                                     |
| def_apl_rk       | integer   | Def apl rk.                                  |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
# \donttest{
  try(kp_opptracker(team = 'Florida St.', year = 2021))
#>          date game_date   day_date wl        team team_score       opponent
#> 1  2020-12-02  20201202  Wed Dec 2  W Florida St.         86  North Florida
#> 2  2020-12-09  20201209  Wed Dec 9  W Florida St.         69        Indiana
#> 3  2020-12-12  20201212 Sat Dec 12  W Florida St.         83        Florida
#> 4  2020-12-15  20201215 Tue Dec 15  W Florida St.         74   Georgia Tech
#> 5  2020-12-19  20201219 Sat Dec 19  L Florida St.         74            UCF
#> 6  2020-12-21  20201221 Mon Dec 21  W Florida St.         72   Gardner Webb
#> 7  2020-12-29  20201229 Tue Dec 29  L Florida St.         67        Clemson
#> 8  2021-01-13  20210113 Wed Jan 13  W Florida St.        105     N.C. State
#> 9  2021-01-16  20210116 Sat Jan 16  W Florida St.         82 North Carolina
#> 10 2021-01-18  20210118 Mon Jan 18  W Florida St.         78     Louisville
#> 11 2021-01-23  20210123 Sat Jan 23  W Florida St.         80        Clemson
#> 12 2021-01-27  20210127 Wed Jan 27  W Florida St.         81       Miami FL
#> 13 2021-01-30  20210130 Sat Jan 30  L Florida St.         65   Georgia Tech
#> 14 2021-02-13  20210213 Sat Feb 13  W Florida St.         92    Wake Forest
#> 15 2021-02-15  20210215 Mon Feb 15  W Florida St.         81       Virginia
#> 16 2021-02-20  20210220 Sat Feb 20  W Florida St.         79     Pittsburgh
#> 17 2021-02-24  20210224 Wed Feb 24  W Florida St.         88       Miami FL
#> 18 2021-02-27  20210227 Sat Feb 27  L Florida St.         70 North Carolina
#> 19 2021-03-03  20210303  Wed Mar 3  W Florida St.         93 Boston College
#> 20 2021-03-06  20210306  Sat Mar 6  L Florida St.         73     Notre Dame
#> 21 2021-03-12  20210312 Fri Mar 12  W Florida St.         69 North Carolina
#> 22 2021-03-13  20210313 Sat Mar 13  L Florida St.         75   Georgia Tech
#> 23 2021-03-20  20210320 Sat Mar 20  W Florida St.         64 UNC Greensboro
#> 24 2021-03-22  20210322 Mon Mar 22  W Florida St.         71       Colorado
#> 25 2021-03-28  20210328 Sun Mar 28  L Florida St.         58       Michigan
#>    opponent_score    result adj_oe adj_oe_rk off_e_fg_pct off_e_fg_pct_rk
#> 1              58  W, 86-58  101.9       176         52.7              61
#> 2              67  W, 69-67  109.1        70         48.5             243
#> 3              71  W, 83-71  111.0        44         53.1              53
#> 4              61  W, 74-61  113.7        22         54.1              35
#> 5              86  L, 86-74  106.5       103         50.1             167
#> 6              59  W, 72-59  104.5       130         52.4              72
#> 7              77  L, 77-67  106.4       107         50.0             173
#> 8              73 W, 105-73  109.4        63         53.0              57
#> 9              75  W, 82-75  110.3        52         48.3             251
#> 10             65  W, 78-65  107.7        92         47.8             271
#> 11             61  W, 80-61  106.4       107         50.0             173
#> 12             59  W, 81-59  102.1       172         47.4             281
#> 13             76  L, 76-65  113.7        22         54.1              35
#> 14             85  W, 92-85  101.3       191         49.0             212
#> 15             60  W, 81-60  114.7        17         55.4              14
#> 16             72  W, 79-72  108.2        81         48.8             223
#> 17             71  W, 88-71  102.1       172         47.4             281
#> 18             78  L, 78-70  110.3        52         48.3             251
#> 19             64  W, 93-64  105.1       123         49.8             182
#> 20             83  L, 83-73  113.8        21         53.9              39
#> 21             66  W, 69-66  110.3        52         48.3             251
#> 22             80  L, 80-75  113.7        22         54.1              35
#> 23             54  W, 64-54  103.6       146         47.9             264
#> 24             53  W, 71-53  116.3        13         52.4              69
#> 25             76  L, 76-58  117.6         9         54.7              25
#>    off_to_pct off_to_pct_rk off_or_pct off_or_pct_rk off_ft_rate off_ft_rate_rk
#> 1        21.5           302       25.8           235        25.4            317
#> 2        17.2            87       25.5           241        41.5              8
#> 3        21.2           290       31.1            75        33.9            110
#> 4        16.1            36       24.4           261        28.4            253
#> 5        21.6           306       28.2           160        30.7            194
#> 6        17.5            99       26.6           207        30.0            212
#> 7        19.4           191       26.6           206        23.2            337
#> 8        18.8           166       29.6           112        31.1            181
#> 9        20.3           252       40.9             1        34.2             98
#> 10       17.2            88       32.0            54        32.1            157
#> 11       19.4           191       26.6           206        23.2            337
#> 12       18.4           149       27.0           190        32.8            141
#> 13       16.1            36       24.4           261        28.4            253
#> 14       20.0           231       26.2           227        28.5            250
#> 15       15.0            10       22.7           308        21.7            343
#> 16       18.3           140       34.5            21        36.9             47
#> 17       18.4           149       27.0           190        32.8            141
#> 18       20.3           252       40.9             1        34.2             98
#> 19       19.2           182       25.4           243        29.7            225
#> 20       15.7            26       22.0           318        25.9            308
#> 21       20.3           252       40.9             1        34.2             98
#> 22       16.1            36       24.4           261        28.4            253
#> 23       15.5            17       32.1            53        23.7            332
#> 24       17.1            82       30.8            79        29.5            227
#> 25       16.6            58       29.6           113        30.4            201
#>    off_fg_2_pct off_fg_2_pct_rk off_fg_3_pct off_fg_3_pct_rk off_blk_pct
#> 1          51.2             110         36.2              61        72.2
#> 2          48.5             225         32.4             236        66.5
#> 3          53.0              53         35.6              81        75.3
#> 4          55.1              20         34.8             116        72.6
#> 5          47.9             246         35.5              86        72.9
#> 6          51.0             118         36.1              63        69.0
#> 7          48.6             221         34.5             135        76.9
#> 8          52.6              67         35.8              72        70.2
#> 9          48.5             227         31.8             262        66.8
#> 10         48.4             229         30.8             298        71.7
#> 11         48.6             221         34.5             135        76.9
#> 12         48.9             204         29.5             325        70.0
#> 13         55.1              20         34.8             116        72.6
#> 14         45.9             299         35.1             107        72.2
#> 15         54.9              23         37.5              24        81.6
#> 16         47.8             250         33.9             161        66.4
#> 17         48.9             204         29.5             325        70.0
#> 18         48.5             227         31.8             262        66.8
#> 19         50.1             151         33.0             206        70.2
#> 20         52.9              57         36.8              46        77.3
#> 21         48.5             227         31.8             262        66.8
#> 22         55.1              20         34.8             116        72.6
#> 23         49.9             164         29.9             317        68.3
#> 24         50.4             137         37.2              33        81.9
#> 25         53.5              44         38.1              13        76.9
#>    off_blk_pct_rk off_fg_3a_pct off_fg_3a_pct_rk off_apl off_apl_rk adj_de
#> 1             134          48.0               14    17.8        232  114.2
#> 2             300          32.3              291    18.1        259   94.2
#> 3              49          33.8              264    16.6         88   94.1
#> 4             118          36.4              202    17.7        229   96.2
#> 5             103          40.2               99    17.8        234   97.9
#> 6             235          43.9               39    17.1        160  105.6
#> 7              28          43.4               43    18.0        251   90.9
#> 8             207          32.7              287    17.0        141   97.4
#> 9             294          27.9              336    15.7         25   91.7
#> 10            148          30.3              316    17.9        246   94.2
#> 11             28          43.4               43    18.0        251   90.9
#> 12            215          33.3              272    18.3        279   99.1
#> 13            118          36.4              202    17.7        229   96.2
#> 14            136          46.0               22    18.9        315  101.9
#> 15              3          42.7               48    20.3        346   93.3
#> 16            302          33.2              278    17.5        205   99.5
#> 17            215          33.3              272    18.3        279   99.1
#> 18            294          27.9              336    15.7         25   91.7
#> 19            209          46.1               21    16.8        114  103.6
#> 20             26          43.4               42    17.4        193  103.7
#> 21            294          27.9              336    15.7         25   91.7
#> 22            118          36.4              202    17.7        229   96.2
#> 23            255          39.0              135    16.6         91   95.8
#> 24              2          36.4              201    17.8        237   91.2
#> 25             27          33.9              261    17.4        194   87.9
#>    adj_de_rk def_e_fg_pct def_e_fg_pct_rk def_to_pct def_to_pct_rk def_or_pct
#> 1        352         50.3             182       16.2           309       35.8
#> 2         43         48.8             117       17.6           248       27.4
#> 3         41         47.8              64       20.2            84       30.7
#> 4         68         52.4             269       22.6            18       30.4
#> 5         95         49.3             136       19.5           126       31.5
#> 6        246         48.6             107       18.2           206       28.1
#> 7         19         48.7             109       21.5            48       26.9
#> 8         87         51.3             223       21.6            47       31.6
#> 9         27         49.1             128       19.0           146       26.4
#> 10        44         48.4              95       16.6           299       26.2
#> 11        19         48.7             109       21.5            48       26.9
#> 12       116         52.5             275       17.9           229       26.3
#> 13        68         52.4             269       22.6            18       30.4
#> 14       169         54.5             323       17.9           235       25.9
#> 15        36         48.0              77       15.3           332       22.6
#> 16       122         50.0             171       17.5           260       26.1
#> 17       116         52.5             275       17.9           229       26.3
#> 18        27         49.1             128       19.0           146       26.4
#> 19       200         55.5             337       18.5           188       28.7
#> 20       203         50.8             202       12.7           346       29.8
#> 21        27         49.1             128       19.0           146       26.4
#> 22        68         52.4             269       22.6            18       30.4
#> 23        62         48.2              86       21.1            56       25.7
#> 24        23         47.9              71       19.8           112       25.6
#> 25         4         44.4               6       14.8           336       24.7
#>    def_or_pct_rk def_ft_rate def_ft_rate_rk def_fg_2_pct def_fg_2_pct_rk
#> 1            345        31.8            180         50.1             178
#> 2            151        33.5            222         48.1             110
#> 3            275        35.1            261         48.8             131
#> 4            266        28.9            112         50.8             220
#> 5            292        33.6            225         49.4             155
#> 6            179        36.5            286         46.9              73
#> 7            140        28.9            113         47.7              96
#> 8            298        28.6            104         51.2             238
#> 9            112        26.9             60         47.0              75
#> 10           102        29.8            136         50.3             192
#> 11           140        28.9            113         47.7              96
#> 12           104        19.8              2         49.7             162
#> 13           266        28.9            112         50.8             220
#> 14            92        32.1            186         52.7             276
#> 15            14        24.8             31         46.2              45
#> 16           101        33.2            210         51.1             233
#> 17           104        19.8              2         49.7             162
#> 18           112        26.9             60         47.0              75
#> 19           202        29.1            116         56.8             340
#> 20           247        19.7              1         48.5             125
#> 21           112        26.9             60         47.0              75
#> 22           266        28.9            112         50.8             220
#> 23            86        36.5            289         48.9             135
#> 24            81        29.1            115         46.8              69
#> 25            54        24.3             26         42.6               3
#>    def_fg_3_pct def_fg_3_pct_rk def_blk_pct def_blk_pct_rk def_fg_3a_pct
#> 1          33.9             177         7.5            223          30.1
#> 2          33.4             144        10.5             77          37.6
#> 3          30.7              33        14.1             14          36.2
#> 4          36.8             313         9.6            120          35.3
#> 5          32.7             113         9.8            106          38.4
#> 6          34.1             192        14.7              7          40.7
#> 7          33.4             145         9.2            130          40.9
#> 8          34.3             205        11.4             48          35.1
#> 9          35.0             242        12.8             28          38.4
#> 10         30.5              24         5.5            324          40.6
#> 11         33.4             145         9.2            130          40.9
#> 12         37.8             322        10.9             67          40.7
#> 13         36.8             313         9.6            120          35.3
#> 14         38.3             331         6.4            284          36.6
#> 15         33.9             182        13.4             20          37.5
#> 16         32.2              85        11.2             60          40.5
#> 17         37.8             322        10.9             67          40.7
#> 18         35.0             242        12.8             28          38.4
#> 19         35.4             259        10.0             99          36.0
#> 20         36.6             306         9.6            119          35.9
#> 21         35.0             242        12.8             28          38.4
#> 22         36.8             313         9.6            120          35.3
#> 23         31.4              55        11.9             40          41.4
#> 24         33.3             140         7.8            211          35.1
#> 25         32.2              84        10.1             93          31.9
#>    def_fg_3a_pct_rk def_apl def_apl_rk
#> 1                10    17.2        152
#> 2               180    17.5        227
#> 3               131    17.4        206
#> 4               104    17.6        235
#> 5               221    17.4        197
#> 6               285    18.2        329
#> 7               296    18.7        343
#> 8               101    18.2        325
#> 9               214    17.7        262
#> 10              280    18.2        330
#> 11              296    18.7        343
#> 12              289    16.8         88
#> 13              104    17.6        235
#> 14              146    16.7         57
#> 15              176    18.8        344
#> 16              277    17.4        190
#> 17              289    16.8         88
#> 18              214    17.7        262
#> 19              127    16.5         36
#> 20              123    18.1        317
#> 21              214    17.7        262
#> 22              104    17.6        235
#> 23              300    17.4        215
#> 24               98    18.4        340
#> 25               28    18.1        321
# }
```
