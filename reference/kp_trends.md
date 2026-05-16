# **Get Division-I statistical trends**

**Get Division-I statistical trends**

## Usage

``` r
kp_trends()
```

## Value

A data frame with the following columns:

|              |         |
|--------------|---------|
| col_name     | types   |
| season       | numeric |
| efficiency   | numeric |
| tempo        | numeric |
| e_fg_pct     | numeric |
| to_pct       | numeric |
| or_pct       | numeric |
| ft_rate      | numeric |
| fg_2_pct     | numeric |
| fg_3_pct     | numeric |
| fg_3a_pct    | numeric |
| ft_pct       | numeric |
| a_pct        | numeric |
| blk_pct      | numeric |
| stl_pct      | numeric |
| non_stl_pct  | numeric |
| avg_hgt      | numeric |
| continuity   | numeric |
| home_win_pct | numeric |
| ppg          | numeric |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md)

## Examples

``` r
# \donttest{
try(kp_trends())
#>    season efficiency tempo e_fg_pct to_pct or_pct ft_rate fg_2_pct fg_3_pct
#> 1    2026      108.5  68.3     51.4   16.7   30.6    35.0     51.7     33.9
#> 2    2025      106.2  68.0     50.9   17.2   29.8    33.0     51.0     33.8
#> 3    2024      105.2  68.5     50.5   17.1   29.0    32.8     50.3     33.8
#> 4    2023      103.2  67.9     50.4   18.2   28.5    31.5     50.1     34.0
#> 5    2022      102.0  68.1     50.0   18.4   28.1    30.3     49.7     33.6
#> 6    2021      101.4  69.2     50.1   18.9   28.0    31.4     49.8     33.8
#> 7    2020      100.8  69.1     49.6   18.9   28.0    32.6     49.4     33.3
#> 8    2019      103.2  69.0     50.7   18.5   28.4    33.0     50.1     34.4
#> 9    2018      104.2  69.4     51.0   18.4   28.7    33.5     50.0     35.1
#> 10   2017      103.7  69.4     50.5   18.5   29.3    35.3     49.3     35.0
#> 11   2016      103.3  69.1     49.9   18.1   29.8    36.6     48.7     34.7
#> 12   2015      102.1  64.9     49.0   19.1   31.0    37.0     47.8     34.3
#> 13   2014      104.5  66.5     49.6   18.3   31.4    40.5     48.5     34.4
#> 14   2013      100.6  65.9     48.6   20.0   31.8    35.9     47.5     33.9
#> 15   2012      100.1  66.8     49.0   20.1   31.4    36.4     47.8     34.3
#> 16   2011      101.5  66.8     49.1   20.1   33.8    37.7     47.8     34.4
#> 17   2010      101.1  67.3     48.8   20.4   34.3    37.7     47.7     34.2
#> 18   2009      101.4  66.5     49.1   20.4   34.5    36.4     48.0     34.2
#> 19   2008      101.8  67.0     49.8   21.0   34.5    36.3     48.4     35.1
#> 20   2007      102.1  66.8     49.9   21.2   35.1    36.7     48.7     34.9
#> 21   2006      101.5  67.0     49.5   21.3   35.6    36.1     48.1     34.8
#> 22   2005      101.3  67.3     49.3   21.3   35.5    36.5     48.0     34.6
#> 23   2004      101.0  67.7     49.2   21.4   35.5    37.1     48.0     34.4
#> 24   2003       98.8  70.0     49.4   21.1   32.2    36.7     48.1     34.7
#> 25   2002      100.9  69.6     49.1   21.5   34.1    37.6     47.8     34.5
#> 26   2001      100.9  69.7     49.1   21.7   34.1    39.4     47.9     34.5
#> 27   2000       99.3  70.0     48.6   22.4   34.7    36.9     47.3     34.3
#> 28   1999       99.1  70.0     48.6   22.8   35.1    37.8     47.4     34.1
#> 29   1998      100.0  70.4     48.8   22.5   35.6    38.2     47.7     34.3
#> 30   1997       99.8  69.6     48.5   22.3   35.6    38.3     47.5     33.9
#> 31   1996         NA    NA     49.1     NA     NA    38.3     48.2     34.2
#> 32   1995         NA    NA     49.4     NA     NA    37.9     48.4     34.4
#> 33   1994         NA    NA     49.0     NA     NA    38.3     48.0     34.5
#> 34   1993         NA    NA     49.7     NA     NA    38.9     48.5     35.4
#> 35   1992         NA    NA     50.0     NA     NA    39.9     48.9     35.6
#> 36   1991         NA    NA     50.2     NA     NA    38.3     49.0     36.2
#> 37   1990         NA    NA     50.2     NA     NA    38.0     48.8     36.8
#> 38   1989         NA    NA     51.1     NA     NA    38.0     49.7     37.8
#> 39   1988         NA    NA     50.7     NA     NA    37.7     49.2     38.3
#> 40   1987         NA    NA     49.4     NA     NA    36.6     47.9     38.4
#> 41   1986         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 42   1985         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 43   1984         NA    NA     48.1     NA     NA      NA     48.1       NA
#> 44   1983         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 45   1982         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 46   1981         NA    NA     48.0     NA     NA      NA     48.0       NA
#> 47   1980         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 48   1979         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 49   1978         NA    NA     47.3     NA     NA      NA     47.3       NA
#> 50   1977         NA    NA     46.7     NA     NA      NA     46.7       NA
#> 51   1976         NA    NA     46.7     NA     NA      NA     46.7       NA
#> 52   1975         NA    NA     46.0     NA     NA      NA     46.0       NA
#> 53   1974         NA    NA     45.4     NA     NA      NA     45.4       NA
#> 54   1973         NA    NA     44.8     NA     NA      NA     44.8       NA
#> 55   1972         NA    NA     44.8     NA     NA      NA     44.8       NA
#> 56   1971         NA    NA     44.4     NA     NA      NA     44.4       NA
#> 57   1970         NA    NA     44.2     NA     NA      NA     44.2       NA
#> 58   1969         NA    NA     43.8     NA     NA      NA     43.8       NA
#> 59   1968         NA    NA     43.7     NA     NA      NA     43.7       NA
#> 60   1967         NA    NA     43.8     NA     NA      NA     43.8       NA
#> 61   1966         NA    NA     43.6     NA     NA      NA     43.6       NA
#> 62   1965         NA    NA     43.1     NA     NA      NA     43.1       NA
#> 63   1964         NA    NA     42.5     NA     NA      NA     42.5       NA
#> 64   1963         NA    NA     41.7     NA     NA      NA     41.7       NA
#> 65   1962         NA    NA     40.2     NA     NA      NA     40.2       NA
#> 66   1961         NA    NA     40.7     NA     NA      NA     40.7       NA
#> 67   1960         NA    NA     39.8     NA     NA      NA     39.8       NA
#> 68   1959         NA    NA     39.1     NA     NA      NA     39.1       NA
#> 69   1958         NA    NA     38.4     NA     NA      NA     38.4       NA
#> 70   1957         NA    NA     38.2     NA     NA      NA     38.2       NA
#> 71   1956         NA    NA     37.5     NA     NA      NA     37.5       NA
#> 72   1955         NA    NA     36.9     NA     NA      NA     36.9       NA
#> 73   1954         NA    NA     35.4     NA     NA      NA     35.4       NA
#> 74   1953         NA    NA     34.7     NA     NA      NA     34.7       NA
#> 75   1952         NA    NA     33.7     NA     NA      NA     33.7       NA
#> 76   1951         NA    NA     33.1     NA     NA      NA     33.1       NA
#> 77   1950         NA    NA     31.6     NA     NA      NA     31.6       NA
#> 78   1949         NA    NA     30.8     NA     NA      NA     30.8       NA
#> 79   1948         NA    NA     29.3     NA     NA      NA     29.3       NA
#>    fg_3a_pct ft_pct a_pct blk_pct stl_pct non_stl_pct avg_hgt continuity
#> 1       39.5   72.5  52.6     9.5     9.5         7.2    77.4       24.9
#> 2       39.1   72.1  51.9     9.4     9.7         7.5    77.2       33.7
#> 3       37.3   71.9  50.7     9.3     9.4         7.7    77.1       39.1
#> 4       37.3   71.7  50.9     8.8     9.3         8.9    77.1       41.5
#> 5       37.7   71.7  50.9     9.0     9.3         9.0    77.0       48.9
#> 6       37.4   71.0  51.8     8.8     9.1         9.8    76.9       46.0
#> 7       37.5   70.8  51.5     8.9     9.0         9.9    76.8       46.9
#> 8       38.7   70.7  51.9     9.3     8.9         9.7    76.8       47.8
#> 9       37.5   71.4  52.3     9.3     8.7         9.7    76.8       48.4
#> 10      36.4   70.4  52.4     9.2     8.7         9.8    76.8       49.5
#> 11      35.4   70.0  52.4     9.2     8.6         9.5    76.8       49.2
#> 12      34.2   69.3  53.1     9.6     9.4         9.7    76.7       49.4
#> 13      32.9   69.9  51.8     9.7     9.0         9.3    76.7       51.4
#> 14      33.0   69.4  53.6     9.3     9.9        10.0    76.6       50.3
#> 15      32.9   69.2  53.6     9.2     9.5        10.5    76.5       48.7
#> 16      32.9   69.3  53.7     9.2     9.4        10.7    76.5       51.6
#> 17      32.6   68.9  53.5     9.2     9.8        10.6    76.5       53.0
#> 18      33.1   68.9  54.0     8.8     9.9        10.5    76.5       51.4
#> 19      34.5   69.1  54.8     9.1     9.9        11.0    76.4       51.2
#> 20      34.2   69.1  55.2     9.0     9.9        11.3    76.5       50.5
#> 21      33.2   69.2  55.7     8.8    10.3        11.0      NA       50.1
#> 22      33.0   68.7  55.7     8.8    10.4        10.8      NA         NA
#> 23      32.7   68.8  55.6     8.5    10.4        11.0      NA         NA
#> 24      32.1   69.5  55.2     8.6    10.0        11.1      NA         NA
#> 25      32.1   69.0  55.2     8.5    10.3        11.2      NA         NA
#> 26      31.2   68.6  55.4     8.4    10.0        11.6      NA         NA
#> 27      30.9   68.2  55.8     8.4    10.7        11.7      NA         NA
#> 28      30.6   67.9  55.7     8.3    11.0        11.8      NA         NA
#> 29      30.2   67.6  55.2     7.9    10.6        11.9      NA         NA
#> 30      29.9   67.5  55.6     7.8    10.6        11.8      NA         NA
#> 31      29.2   67.4  54.7     7.7      NA          NA      NA         NA
#> 32      28.8   67.6  54.7     7.8      NA          NA      NA         NA
#> 33      27.2   67.1  54.0     7.5      NA          NA      NA         NA
#> 34      25.4   67.7  54.7     7.3      NA          NA      NA         NA
#> 35      24.0   68.1    NA      NA      NA          NA      NA         NA
#> 36      22.8   68.6    NA      NA      NA          NA      NA         NA
#> 37      21.5   68.9    NA      NA      NA          NA      NA         NA
#> 38      19.9   69.1    NA      NA      NA          NA      NA         NA
#> 39      17.8   68.9    NA      NA      NA          NA      NA         NA
#> 40      15.7   69.1    NA      NA      NA          NA      NA         NA
#> 41        NA   69.1    NA      NA      NA          NA      NA         NA
#> 42        NA   68.9    NA      NA      NA          NA      NA         NA
#> 43        NA   68.9    NA      NA      NA          NA      NA         NA
#> 44        NA   68.5    NA      NA      NA          NA      NA         NA
#> 45        NA   68.6    NA      NA      NA          NA      NA         NA
#> 46        NA   68.9    NA      NA      NA          NA      NA         NA
#> 47        NA   69.6    NA      NA      NA          NA      NA         NA
#> 48        NA   69.7    NA      NA      NA          NA      NA         NA
#> 49        NA   69.2    NA      NA      NA          NA      NA         NA
#> 50        NA   69.4    NA      NA      NA          NA      NA         NA
#> 51        NA   69.2    NA      NA      NA          NA      NA         NA
#> 52        NA   69.0    NA      NA      NA          NA      NA         NA
#> 53        NA   68.4    NA      NA      NA          NA      NA         NA
#> 54        NA   68.4    NA      NA      NA          NA      NA         NA
#> 55        NA   68.6    NA      NA      NA          NA      NA         NA
#> 56        NA   68.1    NA      NA      NA          NA      NA         NA
#> 57        NA   68.7    NA      NA      NA          NA      NA         NA
#> 58        NA   68.4    NA      NA      NA          NA      NA         NA
#> 59        NA   69.1    NA      NA      NA          NA      NA         NA
#> 60        NA   69.0    NA      NA      NA          NA      NA         NA
#> 61        NA   69.2    NA      NA      NA          NA      NA         NA
#> 62        NA   69.0    NA      NA      NA          NA      NA         NA
#> 63        NA   68.3    NA      NA      NA          NA      NA         NA
#> 64        NA   68.2    NA      NA      NA          NA      NA         NA
#> 65        NA   67.9    NA      NA      NA          NA      NA         NA
#> 66        NA   68.2    NA      NA      NA          NA      NA         NA
#> 67        NA   67.4    NA      NA      NA          NA      NA         NA
#> 68        NA   67.1    NA      NA      NA          NA      NA         NA
#> 69        NA   66.4    NA      NA      NA          NA      NA         NA
#> 70        NA   67.3    NA      NA      NA          NA      NA         NA
#> 71        NA   66.8    NA      NA      NA          NA      NA         NA
#> 72        NA   66.5    NA      NA      NA          NA      NA         NA
#> 73        NA   65.2    NA      NA      NA          NA      NA         NA
#> 74        NA   64.0    NA      NA      NA          NA      NA         NA
#> 75        NA   62.6    NA      NA      NA          NA      NA         NA
#> 76        NA   62.8    NA      NA      NA          NA      NA         NA
#> 77        NA   61.8    NA      NA      NA          NA      NA         NA
#> 78        NA   61.6    NA      NA      NA          NA      NA         NA
#> 79        NA   59.8    NA      NA      NA          NA      NA         NA
#>    home_win_pct  ppg
#> 1          58.3 74.7
#> 2          59.3 72.8
#> 3          59.9 72.6
#> 4          59.9 70.7
#> 5          57.5 70.1
#> 6          57.5 70.8
#> 7          61.0 70.2
#> 8          59.0 71.9
#> 9          61.0 73.6
#> 10         59.0 72.7
#> 11         60.5 72.3
#> 12         59.8 66.9
#> 13         60.3 70.2
#> 14         61.3 66.9
#> 15         60.5 67.4
#> 16         60.9 68.4
#> 17         61.2 68.6
#> 18         62.2 68.1
#> 19         61.7 68.9
#> 20         62.4 68.8
#> 21         61.3 68.6
#> 22         62.9 68.7
#> 23         62.0 69.0
#> 24         62.4 69.8
#> 25         62.3 70.9
#> 26         63.4 71.5
#> 27         62.3 70.5
#> 28         62.6 69.9
#> 29         62.2 70.9
#> 30         64.3 70.0
#> 31           NA 72.5
#> 32           NA 74.2
#> 33           NA 75.0
#> 34           NA 73.6
#> 35           NA 74.2
#> 36           NA 76.7
#> 37           NA 75.3
#> 38           NA 76.2
#> 39           NA 74.4
#> 40           NA 72.8
#> 41           NA 69.4
#> 42           NA 69.2
#> 43           NA 68.2
#> 44           NA 69.3
#> 45           NA 67.6
#> 46           NA 70.1
#> 47           NA 72.0
#> 48           NA 74.0
#> 49           NA 74.5
#> 50           NA 74.9
#> 51           NA 75.7
#> 52           NA 76.6
#> 53           NA 74.8
#> 54           NA 75.5
#> 55           NA 77.7
#> 56           NA 77.7
#> 57           NA 77.6
#> 58           NA 75.6
#> 59           NA 75.5
#> 60           NA 74.9
#> 61           NA 77.5
#> 62           NA 75.7
#> 63           NA 74.4
#> 64           NA 69.5
#> 65           NA 70.5
#> 66           NA 70.7
#> 67           NA 70.0
#> 68           NA 68.7
#> 69           NA 68.4
#> 70           NA 72.0
#> 71           NA 73.3
#> 72           NA 72.7
#> 73           NA 69.0
#> 74           NA 69.1
#> 75           NA 63.3
#> 76           NA 60.7
#> 77           NA 57.6
#> 78           NA 54.8
#> 79           NA 53.3
# }
```
