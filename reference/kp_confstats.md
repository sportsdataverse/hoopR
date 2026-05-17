# **Get KenPom's conference comparison stats**

**Get KenPom's conference comparison stats**

## Usage

``` r
kp_confstats(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year (YYYY)

## Value

A data frame with the following columns:

|              |           |                                            |
|--------------|-----------|--------------------------------------------|
| col_name     | types     | description                                |
| conf         | character | character.                                 |
| eff          | numeric   | Eff.                                       |
| eff_rk       | numeric   | Eff rk.                                    |
| tempo        | numeric   | Tempo.                                     |
| tempo_rk     | numeric   | Tempo rk.                                  |
| e_fg_pct     | numeric   | E field goals percentage (0-1 decimal).    |
| e_fg_pct_rk  | numeric   | E fg pct rk.                               |
| to_pct       | numeric   | To percentage (0-1 decimal).               |
| to_pct_rk    | numeric   | To pct rk.                                 |
| or_pct       | numeric   | Or percentage (0-1 decimal).               |
| or_pct_rk    | numeric   | Or pct rk.                                 |
| ft_rate      | numeric   | Ft rate.                                   |
| ft_rate_rk   | numeric   | Ft rate rk.                                |
| blk_pct      | numeric   | Blocks percentage (0-1 decimal).           |
| blk_pct_rk   | numeric   | Blk pct rk.                                |
| stl_pct      | numeric   | Steals percentage (0-1 decimal).           |
| stl_pct_rk   | numeric   | Stl pct rk.                                |
| fg_2_pct     | numeric   | Field goals 2 percentage (0-1 decimal).    |
| fg_2_pct_rk  | numeric   | Fg 2 pct rk.                               |
| fg_3_pct     | numeric   | Field goals 3 percentage (0-1 decimal).    |
| fg_3_pct_rk  | numeric   | Fg 3 pct rk.                               |
| ft_pct       | numeric   | Free throw percentage (0-1).               |
| ft_pct_rk    | numeric   | Ft pct rk.                                 |
| fg_3a_pct    | numeric   | Field goals 3a percentage (0-1 decimal).   |
| fg_3a_pct_rk | numeric   | Fg 3a pct rk.                              |
| a_pct        | numeric   | A percentage (0-1 decimal).                |
| a_pct_rk     | numeric   | A pct rk.                                  |
| home_w_l     | character | Home team's wins losses.                   |
| home_w_l_pct | numeric   | Home wins losses percentage (0-1 decimal). |
| home_w_l_rk  | numeric   | Home team's wins losses rk.                |
| close        | numeric   | Close.                                     |
| close_rk     | numeric   | Close rk.                                  |
| blowouts     | numeric   | Blowouts.                                  |
| blowouts_rk  | numeric   | Blowouts rk.                               |
| year         | numeric   | 4-digit year.                              |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_confstats(year=most_recent_mbb_season()))
#>    conf   eff eff_rk tempo tempo_rk e_fg_pct e_fg_pct_rk to_pct to_pct_rk
#> 1   A10 107.8     21  66.6       24     51.4          17   16.9        22
#> 2   ACC 110.4      8  67.5       17     52.3          12   15.7         8
#> 3    AE 105.8     25  65.0       30     50.6          22   15.5         7
#> 4  Amer 108.8     15  68.3        9     49.9          27   16.0        13
#> 5  ASun 114.8      2  67.9       15     54.7           1   15.4         5
#> 6   B10 112.5      5  65.5       28     52.9           6   15.1         4
#> 7   B12 110.0     11  68.5        8     51.6          16   15.8        10
#> 8    BE 108.4     16  68.2       10     51.1          20   16.3        17
#> 9  BSky 111.4      7  68.2       11     53.2           5   15.5         6
#> 10 BSth 108.2     18  69.8        3     51.7          15   17.2        25
#> 11   BW 106.2     24  72.2        1     51.2          19   17.6        26
#> 12  CAA 108.1     20  67.1       20     50.7          21   15.9        11
#> 13 CUSA 109.2     13  66.9       23     51.2          18   16.3        16
#> 14 Horz 113.7      3  68.9        6     53.9           2   16.1        14
#> 15  Ivy 109.7     12  66.2       25     52.6           9   16.2        15
#> 16 MAAC 105.8     26  65.5       29     49.4          30   16.9        23
#> 17  MAC 110.1      9  69.1        5     52.8           7   16.6        18
#> 18 MEAC 104.0     31  68.1       13     49.8          29   20.1        31
#> 19  MVC 107.5     22  67.3       18     52.1          13   16.6        19
#> 20  MWC 110.1     10  67.1       21     52.7           8   16.7        20
#> 21  NEC 105.5     27  64.9       31     50.6          23   16.9        24
#> 22  OVC 104.2     30  67.3       19     48.8          31   17.7        27
#> 23   PL 108.9     14  65.7       27     52.3          11   15.7         9
#> 24   SB 108.2     19  67.8       16     50.5          25   15.9        12
#> 25   SC 113.3      4  67.0       22     53.3           4   14.5         1
#> 26  SEC 114.8      1  69.4        4     52.4          10   14.6         2
#> 27 Slnd 106.8     23  65.9       26     50.5          24   17.8        28
#> 28  Sum 112.4      6  68.8        7     53.6           3   14.8         3
#> 29 SWAC 105.1     28  70.0        2     49.9          28   18.4        29
#> 30  WAC 104.6     29  68.1       12     50.3          26   19.3        30
#> 31  WCC 108.3     17  67.9       14     51.8          14   16.8        21
#>    or_pct or_pct_rk ft_rate ft_rate_rk blk_pct blk_pct_rk stl_pct stl_pct_rk
#> 1    29.9        17    34.5         15    10.4          2     9.8          6
#> 2    29.8        18    32.7         24     9.9          6     9.2         21
#> 3    26.6        31    33.5         20     8.6         24     8.7         28
#> 4    32.7         3    35.8         13    10.8          1     9.6          9
#> 5    29.8        19    34.2         18     8.1         28     9.3         17
#> 6    30.1        16    31.8         29     9.3         14     8.1         31
#> 7    31.2         9    31.9         28     9.6         10     9.2         20
#> 8    31.3         7    33.5         21     9.7          9     9.8          7
#> 9    27.6        29    35.2         14     8.3         27     9.1         25
#> 10   30.8        11    38.4          4    10.2          5     9.6         10
#> 11   28.4        26    36.3          9     9.2         18     9.6         12
#> 12   30.2        14    34.2         19     9.2         17     8.8         27
#> 13   30.5        13    37.6          5    10.3          4     9.6         11
#> 14   31.2        10    34.4         17     9.4         12     9.4         15
#> 15   28.9        23    32.2         26     9.1         22     9.1         23
#> 16   31.3         8    31.7         30     9.4         13     9.8          8
#> 17   29.3        21    35.8         11     8.9         23     9.4         13
#> 18   33.6         1    43.4          1     9.7          8    10.1          4
#> 19   28.0        28    32.1         27     9.1         21     9.0         26
#> 20   29.0        22    37.6          7     9.1         20     9.2         19
#> 21   28.5        25    33.3         22     7.8         31     9.3         18
#> 22   32.5         4    35.8         12     9.4         11    10.4          2
#> 23   27.0        30    31.5         31     7.8         30     9.2         22
#> 24   30.1        15    36.2         10     9.9          7     9.4         16
#> 25   28.8        24    34.5         16     8.5         26     8.2         30
#> 26   32.8         2    37.6          6    10.4          3     9.1         24
#> 27   31.9         6    36.9          8     9.3         15    10.0          5
#> 28   28.0        27    33.1         23     8.0         29     8.4         29
#> 29   30.5        12    41.5          2     9.2         19    10.2          3
#> 30   32.4         5    39.3          3     9.2         16    10.9          1
#> 31   29.6        20    32.2         25     8.6         25     9.4         14
#>    fg_2_pct fg_2_pct_rk fg_3_pct fg_3_pct_rk ft_pct ft_pct_rk fg_3a_pct
#> 1      51.5          17     34.1          17   71.9        24      41.9
#> 2      52.6          12     34.6          12   72.5        17      42.5
#> 3      51.8          15     32.4          31   71.1        30      37.9
#> 4      50.5          24     32.6          29   72.3        20      38.0
#> 5      55.3           1     35.9           1   73.6         9      42.3
#> 6      54.0           4     34.2          15   76.1         1      42.5
#> 7      51.5          18     34.6          11   73.1        12      38.5
#> 8      51.3          20     33.9          19   72.0        23      38.0
#> 9      53.0           7     35.6           3   75.5         2      38.5
#> 10     52.2          14     33.9          18   69.8        31      38.0
#> 11     51.5          16     33.8          22   73.1        13      39.2
#> 12     50.7          22     33.9          20   72.1        22      39.2
#> 13     50.1          28     35.3           5   72.1        21      40.5
#> 14     54.1           3     35.7           2   74.8         3      40.3
#> 15     52.9          10     34.7          10   73.6        10      40.8
#> 16     49.2          30     33.0          27   74.2         5      38.6
#> 17     53.0           9     35.0           8   73.0        14      39.1
#> 18     49.6          29     33.5          25   71.5        27      34.0
#> 19     52.3          13     34.6          13   71.3        28      40.1
#> 20     53.0           8     34.8           9   73.7         8      40.7
#> 21     50.5          25     33.9          21   72.4        19      36.7
#> 22     48.7          31     32.6          30   71.2        29      34.3
#> 23     53.0           6     34.2          16   74.5         4      41.3
#> 24     50.6          23     33.5          24   72.5        18      40.9
#> 25     53.5           5     35.4           4   72.9        15      44.1
#> 26     52.7          11     34.5          14   74.1         6      38.7
#> 27     50.8          21     33.3          26   71.6        26      37.8
#> 28     54.1           2     35.2           6   72.6        16      40.8
#> 29     50.2          27     32.9          28   73.6        11      35.2
#> 30     50.3          26     33.6          23   71.6        25      31.6
#> 31     51.3          19     35.0           7   74.1         7      39.4
#>    fg_3a_pct_rk a_pct a_pct_rk home_w_l home_w_l_pct home_w_l_rk close close_rk
#> 1             5  55.4        5    72-54        0.571          19    NA       26
#> 2             2  52.1       19    94-68        0.580          18    NA       13
#> 3            25  47.4       30    42-30        0.583          15    NA       21
#> 4            22  48.8       25    56-61        0.479          31    NA       11
#> 5             4  52.9       13    71-37        0.657           1    NA       10
#> 6             3  56.5        1   104-75        0.581          17    NA       21
#> 7            21  54.0        8    92-52        0.639           5    NA       29
#> 8            24  56.5        2    61-49        0.555          22    NA       17
#> 9            20  48.3       26    59-31        0.656           2    NA       24
#> 10           23  46.5       31    45-27        0.625           6    NA        5
#> 11           16  53.0       12    65-45        0.591          12    NA       14
#> 12           15  51.8       20    71-45        0.612          10    NA       11
#> 13           11  52.7       14    75-45        0.625           6    NA        3
#> 14           12  55.0        6    58-52        0.527          29    NA       18
#> 15            9  55.7        4    28-28        0.500          30    NA        6
#> 16           19  53.8        9    80-50        0.615           9    NA       28
#> 17           17  52.2       18    65-52        0.556          21    NA        4
#> 18           30  53.7       10    30-26        0.536          28    NA        6
#> 19           13  52.5       17    65-45        0.591          12    NA       14
#> 20           10  52.7       15    74-46        0.617           8    NA       31
#> 21           27  52.6       16    55-35        0.611          11    NA        2
#> 22           29  48.1       29    59-51        0.536          27    NA       27
#> 23            6  54.3        7    49-41        0.544          25    NA        1
#> 24            7  48.3       28    69-56        0.552          23    NA        9
#> 25            1  50.5       21    51-39        0.567          20    NA       19
#> 26           18  50.0       23    78-66        0.542          26    NA       16
#> 27           26  53.3       11    72-60        0.545          24    NA       20
#> 28            8  48.3       27    42-30        0.583          15    NA       25
#> 29           28  50.1       22    63-44        0.589          14    NA        8
#> 30           31  49.9       24    41-22        0.651           4    NA       23
#> 31           14  55.8        3    70-37        0.654           3    NA       30
#>    blowouts blowouts_rk year
#> 1        NA          15 2026
#> 2        NA           9 2026
#> 3        NA          10 2026
#> 4        NA          17 2026
#> 5        NA          12 2026
#> 6        NA           4 2026
#> 7        NA           3 2026
#> 8        NA          23 2026
#> 9        NA          22 2026
#> 10       NA          16 2026
#> 11       NA          18 2026
#> 12       NA          27 2026
#> 13       NA          28 2026
#> 14       NA          25 2026
#> 15       NA           6 2026
#> 16       NA          21 2026
#> 17       NA          20 2026
#> 18       NA           8 2026
#> 19       NA          13 2026
#> 20       NA           2 2026
#> 21       NA          29 2026
#> 22       NA          13 2026
#> 23       NA          29 2026
#> 24       NA          24 2026
#> 25       NA           7 2026
#> 26       NA          10 2026
#> 27       NA          26 2026
#> 28       NA           5 2026
#> 29       NA          19 2026
#> 30       NA          31 2026
#> 31       NA           1 2026
# }
```
