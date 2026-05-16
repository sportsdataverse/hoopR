# **Get KenPom's conference-wide stats**

**Get KenPom's conference-wide stats**

## Usage

``` r
kp_conf(year, conf)
```

## Arguments

- year:

  Year (YYYY)

- conf:

  Used to limit to players in a specific conference. Allowed values are:
  'A10', 'ACC', 'AE', 'AMER',  
  'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA',
  'HORZ', 'IND', IVY',  
  'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB',
  'SC', 'SEC', 'SLND',  
  'SUM', 'SWAC', 'WAC', 'WCC'.  
  If you try to use a conference that doesn't exist for a given season,
  like 'IND' and '2018',  
  you'll get an empty table, as kenpom.com doesn't serve 404 pages for
  invalid table queries like that.  
  No filter applied by default.

## Value

A list of named data frames:

**Standings**

|             |           |
|-------------|-----------|
| col_name    | types     |
| team        | character |
| overall     | character |
| conf        | character |
| adj_em      | numeric   |
| adj_em_rk   | numeric   |
| adj_o       | numeric   |
| adj_o_rk    | numeric   |
| adj_d       | numeric   |
| adj_d_rk    | numeric   |
| adj_t       | numeric   |
| adj_t_rk    | numeric   |
| conf_sos    | numeric   |
| conf_sos_rk | numeric   |
| next_game   | character |
| year        | numeric   |

**ConferencePlayOffense**

|             |           |
|-------------|-----------|
| col_name    | types     |
| team        | character |
| oe          | numeric   |
| oe_rk       | numeric   |
| e_fg_pct    | numeric   |
| e_fg_pct_rk | numeric   |
| to_pct      | numeric   |
| to_pct_rk   | numeric   |
| or_pct      | numeric   |
| or_pct_rk   | numeric   |
| ft_rate     | numeric   |
| ft_rate_rk  | numeric   |
| fg_2_pct    | numeric   |
| fg_2_pct_rk | numeric   |
| fg_3_pct    | numeric   |
| fg_3_pct_rk | numeric   |
| ft_pct      | numeric   |
| ft_pct_rk   | numeric   |
| tempo       | numeric   |
| tempo_rk    | numeric   |
| year        | numeric   |

**ConferencePlayDefense**

|             |           |
|-------------|-----------|
| col_name    | types     |
| team        | character |
| de          | numeric   |
| de_rk       | numeric   |
| e_fg_pct    | numeric   |
| e_fg_pct_rk | numeric   |
| to_pct      | numeric   |
| to_pct_rk   | numeric   |
| or_pct      | numeric   |
| or_pct_rk   | numeric   |
| ft_rate     | numeric   |
| ft_rate_rk  | numeric   |
| fg_2_pct    | numeric   |
| fg_2_pct_rk | numeric   |
| fg_3_pct    | numeric   |
| fg_3_pct_rk | numeric   |
| blk_pct     | numeric   |
| blk_pct_rk  | numeric   |
| stl_pct     | numeric   |
| stl_pct_rk  | numeric   |
| year        | numeric   |

**AllKenPom**

|          |           |
|----------|-----------|
| col_name | types     |
| rk       | integer   |
| player   | character |
| year     | numeric   |

**ConferenceAggregateStats**

|          |           |
|----------|-----------|
| col_name | types     |
| stat     | character |
| value    | numeric   |
| rk       | numeric   |
| year     | numeric   |

**WinningTrends**

|          |           |
|----------|-----------|
| col_name | types     |
| stat     | character |
| count    | character |
| value    | numeric   |
| rk       | numeric   |
| year     | numeric   |

**ConferenceComparison**

|            |           |
|------------|-----------|
| col_name   | types     |
| rk         | numeric   |
| conference | character |
| rating     | numeric   |
| year       | numeric   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
    try(kp_conf(year = 2020, conf = 'ACC'))
#> $Standings
#>                                                                          team
#> 1                                                              Florida St. 2*
#> 2                                                                     Duke 3*
#> 3                                                               Louisville 4*
#> 4                                                                 Virginia 7*
#> 5                                                                Georgia Tech
#> 6                                                              N.C. State 11*
#> 7                                                                    Syracuse
#> 8                                                                  Notre Dame
#> 9                                                                     Clemson
#> 10                                                                   Miami FL
#> 11                                                              Virginia Tech
#> 12                                                             Boston College
#> 13                                                             North Carolina
#> 14                                                                Wake Forest
#> 15                                                                 Pittsburgh
#> 16 Conference SOS is expected wins gained relative to a round-robin schedule.
#> 17               *Tournament seed is from the consensus at bracketmatrix.com.
#>                                                                       overall
#> 1                                                                        26-5
#> 2                                                                        25-6
#> 3                                                                        24-7
#> 4                                                                        23-7
#> 5                                                                       17-14
#> 6                                                                       20-12
#> 7                                                                       18-14
#> 8                                                                       20-12
#> 9                                                                       16-15
#> 10                                                                      15-16
#> 11                                                                      16-16
#> 12                                                                      13-19
#> 13                                                                      14-19
#> 14                                                                      13-18
#> 15                                                                      16-17
#> 16 Conference SOS is expected wins gained relative to a round-robin schedule.
#> 17               *Tournament seed is from the consensus at bracketmatrix.com.
#>                                                                          conf
#> 1                                                                        16-4
#> 2                                                                        15-5
#> 3                                                                        15-5
#> 4                                                                        15-5
#> 5                                                                        11-9
#> 6                                                                       10-10
#> 7                                                                       10-10
#> 8                                                                       10-10
#> 9                                                                        9-11
#> 10                                                                       7-13
#> 11                                                                       7-13
#> 12                                                                       7-13
#> 13                                                                       6-14
#> 14                                                                       6-14
#> 15                                                                       6-14
#> 16 Conference SOS is expected wins gained relative to a round-robin schedule.
#> 17               *Tournament seed is from the consensus at bracketmatrix.com.
#>    adj_em adj_em_rk adj_o adj_o_rk adj_d adj_d_rk adj_t adj_t_rk conf_sos
#> 1   20.22        15 111.7       32  91.5       15  69.9       89    -0.09
#> 2   24.62         5 115.7        9  91.1       12  72.0       34     0.40
#> 3   21.36         9 114.5       12  93.1       30  67.1      242    -0.04
#> 4   14.22        42  99.3      234  85.1        1  59.4      353    -0.03
#> 5   11.26        64 103.1      171  91.8       16  70.0       88    -0.14
#> 6   13.39        50 110.7       42  97.3       79  69.5      103     0.04
#> 7   13.28        51 112.8       21  99.6      116  68.3      179     0.44
#> 8   12.09        57 110.7       41  98.6      100  68.1      190     0.19
#> 9   10.42        72 103.9      155  93.5       33  66.0      290    -0.21
#> 10   6.39       104 107.7       79 101.3      149  68.3      180    -0.39
#> 11   6.33       105 104.3      147  98.0       82  65.5      309     0.10
#> 12  -0.68       179  99.6      228 100.3      128  69.3      120    -0.07
#> 13   9.36        84 107.7       77  98.4       94  70.4       67    -0.09
#> 14   6.70       103 108.7       61 102.0      166  70.1       79     0.07
#> 15   5.65       111 104.0      154  98.3       91  65.5      308    -0.16
#> 16     NA        NA    NA       NA    NA       NA    NA       NA       NA
#> 17     NA        NA    NA       NA    NA       NA    NA       NA       NA
#>    conf_sos_rk
#> 1            5
#> 2           14
#> 3            8
#> 4            9
#> 5            4
#> 6           10
#> 7           15
#> 8           13
#> 9            2
#> 10           1
#> 11          12
#> 12           7
#> 13           5
#> 14          11
#> 15           3
#> 16          NA
#> 17          NA
#>                                                                     next_game
#> 1                                                                        <NA>
#> 2                                                                        <NA>
#> 3                                                                        <NA>
#> 4                                                                        <NA>
#> 5                                                                        <NA>
#> 6                                                                        <NA>
#> 7                                                                        <NA>
#> 8                                                                        <NA>
#> 9                                                                        <NA>
#> 10                                                                       <NA>
#> 11                                                                       <NA>
#> 12                                                                       <NA>
#> 13                                                                       <NA>
#> 14                                                                       <NA>
#> 15                                                                       <NA>
#> 16 Conference SOS is expected wins gained relative to a round-robin schedule.
#> 17               *Tournament seed is from the consensus at bracketmatrix.com.
#>    year
#> 1  2020
#> 2  2020
#> 3  2020
#> 4  2020
#> 5  2020
#> 6  2020
#> 7  2020
#> 8  2020
#> 9  2020
#> 10 2020
#> 11 2020
#> 12 2020
#> 13 2020
#> 14 2020
#> 15 2020
#> 16 2020
#> 17 2020
#> 
#> $ConferencePlayOffense
#>              team    oe oe_rk e_fg_pct e_fg_pct_rk to_pct to_pct_rk or_pct
#> 1            Duke 111.2     1     52.7           1   17.1         4   31.9
#> 2      Louisville 107.9     2     51.7           2   17.9         6   31.4
#> 3        Syracuse 106.3     3     48.8           9   16.0         3   29.6
#> 4     Florida St. 106.1     4     51.5           3   19.1        12   34.0
#> 5      Notre Dame 105.8     5     50.0           6   14.8         1   26.9
#> 6  North Carolina 102.8     6     48.0          11   18.5        10   34.8
#> 7     Wake Forest 102.3     7     50.1           5   19.8        13   27.4
#> 8      N.C. State 102.1     8     49.1           8   17.2         5   28.5
#> 9    Georgia Tech  99.5     9     51.1           4   22.8        15   31.4
#> 10       Miami FL  97.3    10     46.1          14   18.0         7   27.2
#> 11        Clemson  97.3    11     49.6           7   18.3         9   22.8
#> 12     Pittsburgh  95.2    12     43.5          15   18.0         8   31.1
#> 13  Virginia Tech  94.8    13     48.1          10   15.6         2   18.0
#> 14       Virginia  93.5    14     46.9          12   20.2        14   25.7
#> 15 Boston College  93.1    15     46.9          13   18.8        11   26.3
#>    or_pct_rk ft_rate ft_rate_rk fg_2_pct fg_2_pct_rk fg_3_pct fg_3_pct_rk
#> 1          3    34.7          4     52.5           2     35.4           4
#> 2          5    30.7          7     47.6          11     38.9           1
#> 3          7    34.2          5     50.4           4     30.9          12
#> 4          2    26.8         13     49.3           6     36.9           2
#> 5         11    24.3         14     49.2           7     34.1           5
#> 6          1    33.2          6     48.6           8     30.9          11
#> 7          9    41.6          1     48.0          10     36.1           3
#> 8          8    28.1          9     50.2           5     31.4           8
#> 9          4    35.0          2     51.2           3     34.1           6
#> 10        10    29.6          8     48.3           9     28.3          15
#> 11        14    27.9         11     52.6           1     30.8          13
#> 12         6    34.9          3     42.5          15     30.3          14
#> 13        15    22.6         15     47.6          12     32.4           7
#> 14        13    28.1         10     46.9          14     31.4           9
#> 15        12    27.3         12     47.1          13     31.0          10
#>    ft_pct ft_pct_rk tempo tempo_rk year
#> 1    73.7         6  72.3        1 2020
#> 2    73.5         7  67.1       11 2020
#> 3    76.9         2  68.5        8 2020
#> 4    74.1         4  69.0        6 2020
#> 5    75.3         3  68.4        9 2020
#> 6    68.9        13  69.6        5 2020
#> 7    74.0         5  70.3        2 2020
#> 8    71.6        10  69.8        3 2020
#> 9    69.0        12  69.7        4 2020
#> 10   78.0         1  68.7        7 2020
#> 11   65.7        14  66.1       13 2020
#> 12   71.0        11  65.7       14 2020
#> 13   71.8         9  66.2       12 2020
#> 14   71.8         8  60.5       15 2020
#> 15   62.9        15  68.3       10 2020
#> 
#> $ConferencePlayDefense
#>              team    de de_rk e_fg_pct e_fg_pct_rk to_pct to_pct_rk or_pct
#> 1        Virginia  87.9     1     43.3           1   17.4        10   23.1
#> 2            Duke  95.4     2     45.8           2   18.5         6   29.4
#> 3     Florida St.  95.8     3     47.3           4   22.0         2   29.6
#> 4      Louisville  97.3     4     47.9           5   17.8         9   24.3
#> 5    Georgia Tech  98.6     5     46.2           3   18.1         7   29.7
#> 6         Clemson  99.0     6     49.5           8   17.9         8   23.7
#> 7   Virginia Tech 101.4     7     49.3           7   16.0        13   24.5
#> 8      N.C. State 101.7     8     48.8           6   19.6         4   31.7
#> 9        Syracuse 103.0     9     50.3          10   19.9         3   32.0
#> 10     Pittsburgh 103.8    10     52.0          14   22.2         1   33.6
#> 11 North Carolina 105.2    11     50.2           9   16.1        12   25.6
#> 12       Miami FL 105.5    12     50.5          12   17.1        11   31.8
#> 13     Notre Dame 106.5    13     50.8          13   16.0        14   29.6
#> 14 Boston College 107.0    14     52.2          15   19.1         5   31.5
#> 15    Wake Forest 107.5    15     50.3          11   14.2        15   27.0
#>    or_pct_rk ft_rate ft_rate_rk fg_2_pct fg_2_pct_rk fg_3_pct fg_3_pct_rk
#> 1          1    23.1          3     43.2           1     28.9           1
#> 2          7    31.4          9     46.7           2     29.0           2
#> 3          9    32.6         12     46.7           3     32.1           6
#> 4          3    29.7          5     47.5           5     32.2           7
#> 5         10    38.4         14     47.4           4     29.2           3
#> 6          2    31.0          8     49.4           8     33.1           8
#> 7          4    29.8          6     50.3          13     31.9           5
#> 8         12    39.4         15     49.6          10     31.3           4
#> 9         14    29.3          4     49.8          12     33.8          10
#> 10        15    29.9          7     51.6          14     35.0          13
#> 11         5    32.1         11     49.5           9     34.2          12
#> 12        13    22.8          2     49.3           7     35.4          14
#> 13         8    20.9          1     48.6           6     36.5          15
#> 14        11    31.7         10     53.3          15     33.5           9
#> 15         6    37.2         13     49.7          11     34.2          11
#>    blk_pct blk_pct_rk stl_pct stl_pct_rk year
#> 1     15.8          2     8.4         10 2020
#> 2     12.3          4    10.4          3 2020
#> 3     16.2          1    11.4          1 2020
#> 4      8.4          9     7.7         14 2020
#> 5     10.4          6     9.9          7 2020
#> 6      8.0         11     9.2          8 2020
#> 7      7.5         13     8.6          9 2020
#> 8     11.2          5    10.0          6 2020
#> 9     14.5          3    10.3          4 2020
#> 10     9.7          7    11.1          2 2020
#> 11     8.1         10     8.1         12 2020
#> 12     8.8          8     7.9         13 2020
#> 13     7.6         12     8.1         11 2020
#> 14     6.4         14    10.1          5 2020
#> 15     6.3         15     6.3         15 2020
#> 
#> $AllKenPom
#>   rk                        player year
#> 1  1       Vernon Carey, Duke (Fr) 2020
#> 2  2 Jordan Nwora, Louisville (Jr) 2020
#> 3  3  John Mooney, Notre Dame (Sr) 2020
#> 4  4  Elijah Hughes, Syracuse (Jr) 2020
#> 5  5          Tre Jones, Duke (So) 2020
#> 
#> $ConferenceAggregateStats
#>             stat value rk year
#> 1     Efficiency 100.9 22 2020
#> 2          Tempo  68.0 17 2020
#> 3  Effective FG%  49.0 25 2020
#> 4     Turnover %  18.1 12 2020
#> 5    Off. Reb. %  28.5 12 2020
#> 6        FTA/FGA  30.6 26 2020
#> 7        Block %  10.0  4 2020
#> 8        Steal %   9.2  8 2020
#> 9        3PA/FGA  37.4 16 2020
#> 10         A/FGM  52.2 14 2020
#> 11           3P%  32.8 23 2020
#> 12           2P%  48.8 22 2020
#> 13           FT%  72.0 11 2020
#> 
#> $WinningTrends
#>                         stat       count value rk year
#> 1                  Home win% (91 of 150)    NA 16 2020
#> 2 Close game% (<4 pts or OT) (40 of 150)    NA  3 2020
#> 3        Blowout % (>19 pts) (17 of 150)    NA 24 2020
#> 
#> $ConferenceComparison
#>    rk                         conference rating year
#> 1   1                 Big Ten Conference  17.49 2020
#> 2   2                  Big 12 Conference  15.73 2020
#> 3   3                Big East Conference  15.49 2020
#> 4   4          Atlantic Coast Conference  11.45 2020
#> 5   5                  Pac 12 Conference  11.35 2020
#> 6   6            Southeastern Conference  10.98 2020
#> 7   7       American Athletic Conference   8.62 2020
#> 8   8              West Coast Conference   5.29 2020
#> 9   9             Atlantic 10 Conference   5.01 2020
#> 10 10           Mountain West Conference   4.99 2020
#> 11 11         Missouri Valley Conference   2.46 2020
#> 12 12            Mid American Conference   0.22 2020
#> 13 13                     Conference USA  -0.12 2020
#> 14 14                Sun Belt Conference  -0.14 2020
#> 15 15                Southern Conference  -0.20 2020
#> 16 16                         Ivy League  -0.95 2020
#> 17 17                 Big Sky Conference  -2.26 2020
#> 18 18      Colonial Athletic Association  -3.35 2020
#> 19 19                      Summit League  -3.53 2020
#> 20 20                Big West Conference  -5.07 2020
#> 21 21 Metro Atlantic Athletic Conference  -6.30 2020
#> 22 22                     Horizon League  -6.46 2020
#> 23 23                     Patriot League  -6.55 2020
#> 24 24        Western Athletic Conference  -6.64 2020
#> 25 25            America East Conference  -7.69 2020
#> 26 26                    ASUN Conference  -8.16 2020
#> 27 27               Northeast Conference  -8.63 2020
#> 28 28               Southland Conference  -9.41 2020
#> 29 29             Ohio Valley Conference  -9.67 2020
#> 30 30               Big South Conference -10.82 2020
#> 31 31   Southwestern Athletic Conference -14.37 2020
#> 32 32    Mid-Eastern Athletic Conference -15.47 2020
#> 
# }
```
