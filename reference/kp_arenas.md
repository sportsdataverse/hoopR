# **Get Division-I statistical trends**

**Get Division-I statistical trends**

**Get officials rankings**

**Get referee game log**

**Get Home Court Advantage Estimates**

**Get Home Court Arenas**

**Get Game Attributes**

**Get FanMatch by date**

## Usage

``` r
kp_trends()

kp_officials(year = most_recent_mbb_season())

kp_referee(referee, year)

kp_hca()

kp_arenas(year = most_recent_mbb_season())

kp_game_attrs(year = most_recent_mbb_season(), attr = "Excitement")

kp_fanmatch(date)
```

## Arguments

- year:

  Year of data to pull

- referee:

  Referee ID

- attr:

  Game Attribute, valid values include:  
  'Excitement', 'Tension','Dominance','MinWp','FanMatch',  
  'Upsets','Busts','Comeback','Window'

- date:

  Date of games to pull (YYYY-MM-DD)

## Value

A data frame with the following columns:

|              |         |                                                       |
|--------------|---------|-------------------------------------------------------|
| col_name     | types   | description                                           |
| season       | numeric | Season identifier (4-digit year or 'YYYY-YY' string). |
| efficiency   | numeric | Efficiency.                                           |
| tempo        | numeric | Tempo.                                                |
| e_fg_pct     | numeric | E field goals percentage (0-1 decimal).               |
| to_pct       | numeric | To percentage (0-1 decimal).                          |
| or_pct       | numeric | Or percentage (0-1 decimal).                          |
| ft_rate      | numeric | Ft rate.                                              |
| fg_2_pct     | numeric | Field goals 2 percentage (0-1 decimal).               |
| fg_3_pct     | numeric | Field goals 3 percentage (0-1 decimal).               |
| fg_3a_pct    | numeric | Field goals 3a percentage (0-1 decimal).              |
| ft_pct       | numeric | Free throw percentage (0-1).                          |
| a_pct        | numeric | A percentage (0-1 decimal).                           |
| blk_pct      | numeric | Blocks percentage (0-1 decimal).                      |
| stl_pct      | numeric | Steals percentage (0-1 decimal).                      |
| non_stl_pct  | numeric | Non steals percentage (0-1 decimal).                  |
| avg_hgt      | numeric | Avg hgt.                                              |
| continuity   | numeric | Continuity.                                           |
| home_win_pct | numeric | Home win percentage (0-1 decimal).                    |
| ppg          | numeric | Points per game.                                      |

A data frame with the following columns:

|               |           |                                 |
|---------------|-----------|---------------------------------|
| col_name      | types     | description                     |
| rk            | integer   | Rk.                             |
| official_name | character | Official name.                  |
| ref_rating    | numeric   | Ref rating.                     |
| gms           | numeric   | Gms.                            |
| last_game     | character | Last game date or score string. |
| last_game_1   | character | Last game 1.                    |
| year          | numeric   | 4-digit year.                   |

A data frame with the following columns:

|              |           |                             |
|--------------|-----------|-----------------------------|
| col_name     | types     | description                 |
| game_number  | integer   | Game number.                |
| date         | character | Date in YYYY-MM-DD format.  |
| time_et      | character | Time et.                    |
| game         | character | Game.                       |
| location     | character | Location.                   |
| venue        | character | Venue name.                 |
| conference   | character | Conference.                 |
| thrill_score | numeric   | Thrill score.               |
| referee_name | character | Referee name.               |
| ref_rank     | numeric   | League/season rank for ref. |
| year         | numeric   | 4-digit year.               |

A data frame with the following columns:

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| team     | character | Team-side label or team identifier. |
| conf     | character | character.                          |
| hca      | numeric   | Hca.                                |
| hca_rk   | numeric   | Hca rk.                             |
| pf       | numeric   | Personal fouls.                     |
| pf_rk    | numeric   | Pf rk.                              |
| pts      | numeric   | Points scored.                      |
| pts_rk   | numeric   | Pts rk.                             |
| nst      | numeric   | Nst.                                |
| nst_rk   | numeric   | Nst rk.                             |
| blk      | numeric   | Blocks.                             |
| blk_rk   | numeric   | Blk rk.                             |
| elev     | numeric   | Elev.                               |
| elev_rk  | numeric   | Elev rk.                            |

A data frame with the following columns:

|           |           |                                     |
|-----------|-----------|-------------------------------------|
| col_name  | types     | description                         |
| rk        | numeric   | Rk.                                 |
| team      | character | Team-side label or team identifier. |
| conf      | character | character.                          |
| arena     | character | Arena.                              |
| alternate | character | Alternate.                          |
| year      | numeric   | 4-digit year.                       |

Returns a tibble with game attributes

|            |           |               |
|------------|-----------|---------------|
| col_name   | types     | description   |
| rk         | integer   | Rk.           |
| data       | character | Data.         |
| game       | character | Game.         |
| location   | character | Location.     |
| conf       | character | character.    |
| excitement | numeric   | Excitement.   |
| year       | numeric   | 4-digit year. |

A data frame with the following columns:

|              |           |                            |
|--------------|-----------|----------------------------|
| col_name     | types     | description                |
| prediction   | character | Prediction.                |
| time_et      | character | Time et.                   |
| location     | character | Location.                  |
| thrill_score | numeric   | Thrill score.              |
| comeback     | numeric   | Comeback.                  |
| excitement   | numeric   | Excitement.                |
| road_rk      | numeric   | Road rk.                   |
| road_team    | character | Road team.                 |
| home_rk      | numeric   | Home team's rk.            |
| home_team    | character | Home team's team.          |
| win_rk       | numeric   | Win rk.                    |
| win_team     | character | Win team.                  |
| win_score    | numeric   | Win score.                 |
| loss_rk      | numeric   | Loss rk.                   |
| loss_team    | character | Loss team.                 |
| loss_score   | numeric   | Loss score.                |
| poss         | numeric   | Poss.                      |
| mvp          | character | Mvp.                       |
| event        | character | Event.                     |
| date         | character | Date in YYYY-MM-DD format. |

## Examples

``` r
# \donttest{
try(kp_trends())
#>    season efficiency tempo e_fg_pct to_pct or_pct ft_rate fg_2_pct fg_3_pct
#> 1    2027        0.0   0.0      0.0    0.0    0.0     0.0      0.0      0.0
#> 2    2026      108.5  68.3     51.4   16.7   30.6    35.0     51.7     33.9
#> 3    2025      106.2  68.0     50.9   17.2   29.8    33.0     51.0     33.8
#> 4    2024      105.2  68.5     50.5   17.1   29.0    32.8     50.3     33.8
#> 5    2023      103.2  67.9     50.4   18.2   28.5    31.5     50.1     34.0
#> 6    2022      102.0  68.1     50.0   18.4   28.1    30.3     49.7     33.6
#> 7    2021      101.4  69.2     50.1   18.9   28.0    31.4     49.8     33.8
#> 8    2020      100.8  69.1     49.6   18.9   28.0    32.6     49.4     33.3
#> 9    2019      103.2  69.0     50.7   18.5   28.4    33.0     50.1     34.4
#> 10   2018      104.2  69.4     51.0   18.4   28.7    33.5     50.0     35.1
#> 11   2017      103.7  69.4     50.5   18.5   29.3    35.3     49.3     35.0
#> 12   2016      103.3  69.1     49.9   18.1   29.8    36.6     48.7     34.7
#> 13   2015      102.1  64.9     49.0   19.1   31.0    37.0     47.8     34.3
#> 14   2014      104.5  66.5     49.6   18.3   31.4    40.5     48.5     34.4
#> 15   2013      100.6  65.9     48.6   20.0   31.8    35.9     47.5     33.9
#> 16   2012      100.1  66.8     49.0   20.1   31.4    36.4     47.8     34.3
#> 17   2011      101.5  66.8     49.1   20.1   33.8    37.7     47.8     34.4
#> 18   2010      101.1  67.3     48.8   20.4   34.3    37.7     47.7     34.2
#> 19   2009      101.4  66.5     49.1   20.4   34.5    36.4     48.0     34.2
#> 20   2008      101.8  67.0     49.8   21.0   34.5    36.3     48.4     35.1
#> 21   2007      102.1  66.8     49.9   21.2   35.1    36.7     48.7     34.9
#> 22   2006      101.5  67.0     49.5   21.3   35.6    36.1     48.1     34.8
#> 23   2005      101.3  67.3     49.3   21.3   35.5    36.5     48.0     34.6
#> 24   2004      101.0  67.7     49.2   21.4   35.5    37.1     48.0     34.4
#> 25   2003       98.8  70.0     49.4   21.1   32.2    36.7     48.1     34.7
#> 26   2002      100.9  69.6     49.1   21.5   34.1    37.6     47.8     34.5
#> 27   2001      100.9  69.7     49.1   21.7   34.1    39.4     47.9     34.5
#> 28   2000       99.3  70.0     48.6   22.4   34.7    36.9     47.3     34.3
#> 29   1999       99.1  70.0     48.6   22.8   35.1    37.8     47.4     34.1
#> 30   1998      100.0  70.4     48.8   22.5   35.6    38.2     47.7     34.3
#> 31   1997       99.8  69.6     48.5   22.3   35.6    38.3     47.5     33.9
#> 32   1996         NA    NA     49.1     NA     NA    38.3     48.2     34.2
#> 33   1995         NA    NA     49.4     NA     NA    37.9     48.4     34.4
#> 34   1994         NA    NA     49.0     NA     NA    38.3     48.0     34.5
#> 35   1993         NA    NA     49.7     NA     NA    38.9     48.5     35.4
#> 36   1992         NA    NA     50.0     NA     NA    39.9     48.9     35.6
#> 37   1991         NA    NA     50.2     NA     NA    38.3     49.0     36.2
#> 38   1990         NA    NA     50.2     NA     NA    38.0     48.8     36.8
#> 39   1989         NA    NA     51.1     NA     NA    38.0     49.7     37.8
#> 40   1988         NA    NA     50.7     NA     NA    37.7     49.2     38.3
#> 41   1987         NA    NA     49.4     NA     NA    36.6     47.9     38.4
#> 42   1986         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 43   1985         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 44   1984         NA    NA     48.1     NA     NA      NA     48.1       NA
#> 45   1983         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 46   1982         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 47   1981         NA    NA     48.0     NA     NA      NA     48.0       NA
#> 48   1980         NA    NA     47.9     NA     NA      NA     47.9       NA
#> 49   1979         NA    NA     47.7     NA     NA      NA     47.7       NA
#> 50   1978         NA    NA     47.3     NA     NA      NA     47.3       NA
#> 51   1977         NA    NA     46.7     NA     NA      NA     46.7       NA
#> 52   1976         NA    NA     46.7     NA     NA      NA     46.7       NA
#> 53   1975         NA    NA     46.0     NA     NA      NA     46.0       NA
#> 54   1974         NA    NA     45.4     NA     NA      NA     45.4       NA
#> 55   1973         NA    NA     44.8     NA     NA      NA     44.8       NA
#> 56   1972         NA    NA     44.8     NA     NA      NA     44.8       NA
#> 57   1971         NA    NA     44.4     NA     NA      NA     44.4       NA
#> 58   1970         NA    NA     44.2     NA     NA      NA     44.2       NA
#> 59   1969         NA    NA     43.8     NA     NA      NA     43.8       NA
#> 60   1968         NA    NA     43.7     NA     NA      NA     43.7       NA
#> 61   1967         NA    NA     43.8     NA     NA      NA     43.8       NA
#> 62   1966         NA    NA     43.6     NA     NA      NA     43.6       NA
#> 63   1965         NA    NA     43.1     NA     NA      NA     43.1       NA
#> 64   1964         NA    NA     42.5     NA     NA      NA     42.5       NA
#> 65   1963         NA    NA     41.7     NA     NA      NA     41.7       NA
#> 66   1962         NA    NA     40.2     NA     NA      NA     40.2       NA
#> 67   1961         NA    NA     40.7     NA     NA      NA     40.7       NA
#> 68   1960         NA    NA     39.8     NA     NA      NA     39.8       NA
#> 69   1959         NA    NA     39.1     NA     NA      NA     39.1       NA
#> 70   1958         NA    NA     38.4     NA     NA      NA     38.4       NA
#> 71   1957         NA    NA     38.2     NA     NA      NA     38.2       NA
#> 72   1956         NA    NA     37.5     NA     NA      NA     37.5       NA
#> 73   1955         NA    NA     36.9     NA     NA      NA     36.9       NA
#> 74   1954         NA    NA     35.4     NA     NA      NA     35.4       NA
#> 75   1953         NA    NA     34.7     NA     NA      NA     34.7       NA
#> 76   1952         NA    NA     33.7     NA     NA      NA     33.7       NA
#> 77   1951         NA    NA     33.1     NA     NA      NA     33.1       NA
#> 78   1950         NA    NA     31.6     NA     NA      NA     31.6       NA
#> 79   1949         NA    NA     30.8     NA     NA      NA     30.8       NA
#> 80   1948         NA    NA     29.3     NA     NA      NA     29.3       NA
#>    fg_3a_pct ft_pct a_pct blk_pct stl_pct non_stl_pct avg_hgt continuity
#> 1        0.0    0.0   0.0     0.0     0.0         0.0      NA         NA
#> 2       39.5   72.5  52.6     9.5     9.5         7.2    77.4       24.9
#> 3       39.1   72.1  51.9     9.4     9.7         7.5    77.2       33.7
#> 4       37.3   71.9  50.7     9.3     9.4         7.7    77.1       39.1
#> 5       37.3   71.7  50.9     8.8     9.3         8.9    77.1       41.5
#> 6       37.7   71.7  50.9     9.0     9.3         9.0    77.0       48.9
#> 7       37.4   71.0  51.8     8.8     9.1         9.8    76.9       46.0
#> 8       37.5   70.8  51.5     8.9     9.0         9.9    76.8       46.9
#> 9       38.7   70.7  51.9     9.3     8.9         9.7    76.8       47.8
#> 10      37.5   71.4  52.3     9.3     8.7         9.7    76.8       48.4
#> 11      36.4   70.4  52.4     9.2     8.7         9.8    76.8       49.5
#> 12      35.4   70.0  52.4     9.2     8.6         9.5    76.8       49.2
#> 13      34.2   69.3  53.1     9.6     9.4         9.7    76.7       49.4
#> 14      32.9   69.9  51.8     9.7     9.0         9.3    76.7       51.4
#> 15      33.0   69.4  53.6     9.3     9.9        10.0    76.6       50.3
#> 16      32.9   69.2  53.6     9.2     9.5        10.5    76.5       48.7
#> 17      32.9   69.3  53.7     9.2     9.4        10.7    76.5       51.6
#> 18      32.6   68.9  53.5     9.2     9.8        10.6    76.5       53.0
#> 19      33.1   68.9  54.0     8.8     9.9        10.5    76.5       51.4
#> 20      34.5   69.1  54.8     9.1     9.9        11.0    76.4       51.2
#> 21      34.2   69.1  55.2     9.0     9.9        11.3    76.5       50.5
#> 22      33.2   69.2  55.7     8.8    10.3        11.0      NA       50.1
#> 23      33.0   68.7  55.7     8.8    10.4        10.8      NA         NA
#> 24      32.7   68.8  55.6     8.5    10.4        11.0      NA         NA
#> 25      32.1   69.5  55.2     8.6    10.0        11.1      NA         NA
#> 26      32.1   69.0  55.2     8.5    10.3        11.2      NA         NA
#> 27      31.2   68.6  55.4     8.4    10.0        11.6      NA         NA
#> 28      30.9   68.2  55.8     8.4    10.7        11.7      NA         NA
#> 29      30.6   67.9  55.7     8.3    11.0        11.8      NA         NA
#> 30      30.2   67.6  55.2     7.9    10.6        11.9      NA         NA
#> 31      29.9   67.5  55.6     7.8    10.6        11.8      NA         NA
#> 32      29.2   67.4  54.7     7.7      NA          NA      NA         NA
#> 33      28.8   67.6  54.7     7.8      NA          NA      NA         NA
#> 34      27.2   67.1  54.0     7.5      NA          NA      NA         NA
#> 35      25.4   67.7  54.7     7.3      NA          NA      NA         NA
#> 36      24.0   68.1    NA      NA      NA          NA      NA         NA
#> 37      22.8   68.6    NA      NA      NA          NA      NA         NA
#> 38      21.5   68.9    NA      NA      NA          NA      NA         NA
#> 39      19.9   69.1    NA      NA      NA          NA      NA         NA
#> 40      17.8   68.9    NA      NA      NA          NA      NA         NA
#> 41      15.7   69.1    NA      NA      NA          NA      NA         NA
#> 42        NA   69.1    NA      NA      NA          NA      NA         NA
#> 43        NA   68.9    NA      NA      NA          NA      NA         NA
#> 44        NA   68.9    NA      NA      NA          NA      NA         NA
#> 45        NA   68.5    NA      NA      NA          NA      NA         NA
#> 46        NA   68.6    NA      NA      NA          NA      NA         NA
#> 47        NA   68.9    NA      NA      NA          NA      NA         NA
#> 48        NA   69.6    NA      NA      NA          NA      NA         NA
#> 49        NA   69.7    NA      NA      NA          NA      NA         NA
#> 50        NA   69.2    NA      NA      NA          NA      NA         NA
#> 51        NA   69.4    NA      NA      NA          NA      NA         NA
#> 52        NA   69.2    NA      NA      NA          NA      NA         NA
#> 53        NA   69.0    NA      NA      NA          NA      NA         NA
#> 54        NA   68.4    NA      NA      NA          NA      NA         NA
#> 55        NA   68.4    NA      NA      NA          NA      NA         NA
#> 56        NA   68.6    NA      NA      NA          NA      NA         NA
#> 57        NA   68.1    NA      NA      NA          NA      NA         NA
#> 58        NA   68.7    NA      NA      NA          NA      NA         NA
#> 59        NA   68.4    NA      NA      NA          NA      NA         NA
#> 60        NA   69.1    NA      NA      NA          NA      NA         NA
#> 61        NA   69.0    NA      NA      NA          NA      NA         NA
#> 62        NA   69.2    NA      NA      NA          NA      NA         NA
#> 63        NA   69.0    NA      NA      NA          NA      NA         NA
#> 64        NA   68.3    NA      NA      NA          NA      NA         NA
#> 65        NA   68.2    NA      NA      NA          NA      NA         NA
#> 66        NA   67.9    NA      NA      NA          NA      NA         NA
#> 67        NA   68.2    NA      NA      NA          NA      NA         NA
#> 68        NA   67.4    NA      NA      NA          NA      NA         NA
#> 69        NA   67.1    NA      NA      NA          NA      NA         NA
#> 70        NA   66.4    NA      NA      NA          NA      NA         NA
#> 71        NA   67.3    NA      NA      NA          NA      NA         NA
#> 72        NA   66.8    NA      NA      NA          NA      NA         NA
#> 73        NA   66.5    NA      NA      NA          NA      NA         NA
#> 74        NA   65.2    NA      NA      NA          NA      NA         NA
#> 75        NA   64.0    NA      NA      NA          NA      NA         NA
#> 76        NA   62.6    NA      NA      NA          NA      NA         NA
#> 77        NA   62.8    NA      NA      NA          NA      NA         NA
#> 78        NA   61.8    NA      NA      NA          NA      NA         NA
#> 79        NA   61.6    NA      NA      NA          NA      NA         NA
#> 80        NA   59.8    NA      NA      NA          NA      NA         NA
#>    home_win_pct  ppg
#> 1            NA  0.0
#> 2          58.3 74.7
#> 3          59.3 72.8
#> 4          59.9 72.6
#> 5          59.9 70.7
#> 6          57.5 70.1
#> 7          57.5 70.8
#> 8          61.0 70.2
#> 9          59.0 71.9
#> 10         61.0 73.6
#> 11         59.0 72.7
#> 12         60.5 72.3
#> 13         59.8 66.9
#> 14         60.3 70.2
#> 15         61.3 66.9
#> 16         60.5 67.4
#> 17         60.9 68.4
#> 18         61.2 68.6
#> 19         62.2 68.1
#> 20         61.7 68.9
#> 21         62.4 68.8
#> 22         61.3 68.6
#> 23         62.9 68.7
#> 24         62.0 69.0
#> 25         62.4 69.8
#> 26         62.3 70.9
#> 27         63.4 71.5
#> 28         62.3 70.5
#> 29         62.6 69.9
#> 30         62.2 70.9
#> 31         64.3 70.0
#> 32           NA 72.5
#> 33           NA 74.2
#> 34           NA 75.0
#> 35           NA 73.6
#> 36           NA 74.2
#> 37           NA 76.7
#> 38           NA 75.3
#> 39           NA 76.2
#> 40           NA 74.4
#> 41           NA 72.8
#> 42           NA 69.4
#> 43           NA 69.2
#> 44           NA 68.2
#> 45           NA 69.3
#> 46           NA 67.6
#> 47           NA 70.1
#> 48           NA 72.0
#> 49           NA 74.0
#> 50           NA 74.5
#> 51           NA 74.9
#> 52           NA 75.7
#> 53           NA 76.6
#> 54           NA 74.8
#> 55           NA 75.5
#> 56           NA 77.7
#> 57           NA 77.7
#> 58           NA 77.6
#> 59           NA 75.6
#> 60           NA 75.5
#> 61           NA 74.9
#> 62           NA 77.5
#> 63           NA 75.7
#> 64           NA 74.4
#> 65           NA 69.5
#> 66           NA 70.5
#> 67           NA 70.7
#> 68           NA 70.0
#> 69           NA 68.7
#> 70           NA 68.4
#> 71           NA 72.0
#> 72           NA 73.3
#> 73           NA 72.7
#> 74           NA 69.0
#> 75           NA 69.1
#> 76           NA 63.3
#> 77           NA 60.7
#> 78           NA 57.6
#> 79           NA 54.8
#> 80           NA 53.3
# }
# \donttest{
try(kp_officials(year = 2021))
#>      rk         official_name ref_rating gms last_game
#> 1     1            Bo Boroski      70.73  61   Mon 4/5
#> 2     2       D.J. Carstensen      70.66  58  Sun 3/28
#> 3     3            Paul Szelc      65.98  57  Mon 3/29
#> 4     4          Keith Kimble      65.08  74   Mon 4/5
#> 5     5        Larry Scirotto      64.73  56  Sat 3/27
#> 6     6           Ron Groover      64.01  69   Sat 4/3
#> 7     7           Roger Ayers      61.71  73  Sun 3/14
#> 8     8            Doug Shows      60.78  64  Tue 3/30
#> 9     9        Kipp Kissinger      60.67  72  Thu 3/11
#> 10   10            Bert Smith      60.52  71  Tue 3/30
#> 11   11         Kelly Pfeifer      59.56  53  Sun 3/28
#> 12   12        Courtney Green      59.13  50  Sat 3/27
#> 13   13          Pat Driscoll      58.70  58  Sun 3/28
#> 14   14          Doug Sirmons      57.92  69   Sat 4/3
#> 15   15          John Higgins      57.87  67  Sat 3/13
#> 16   16          Robert Riley      57.44  50  Mon 3/22
#> 17   17         Brent Hampton      56.99  57  Sat 3/27
#> 18   18         Terry Oglesby      56.71  74  Mon 3/29
#> 19   19           Lee Cassell      56.11  57  Tue 3/30
#> 20   20       Chris Rastatter      55.91  71   Sat 4/3
#> 21   21         Ted Valentine      55.89  59  Sat 3/13
#> 22   22             Pat Adams      55.01  54   Sat 4/3
#> 23   23       Brian O'Connell      54.82  54  Sun 3/28
#> 24   24          Brooks Wells      54.65  63  Sun 3/28
#> 25   25             Don Daily      53.92  55  Sun 3/28
#> 26   26          Brian Dorsey      53.45  54  Sun 3/28
#> 27   27        James Breeding      53.32  59   Sat 4/3
#> 28   28          Tony Padilla      52.55  68  Sun 3/28
#> 29   29           Terry Wymer      52.32  54  Sun 3/21
#> 30   30         Gerry Pollard      51.70  71  Sat 3/27
#> 31   31    Michael Greenstein      51.54  58  Sun 3/28
#> 32   32      Jeffrey Anderson      50.51  49   Sat 4/3
#> 33   33          Randy McCall      50.47  70   Mon 4/5
#> 34   34          Jamie Luckie      50.22  53  Thu 3/11
#> 35   35          John Gaffney      50.20  50  Fri 3/12
#> 36   36    Clarence Armstrong      50.06  54  Sat 3/20
#> 37   37            Ray Natili      49.77  56  Fri 3/12
#> 38   38            Jeff Clark      49.75  54  Mon 3/29
#> 39   39          Verne Harris      49.53  71  Tue 3/30
#> 40   40         Byron Jarrett      48.94  55  Sat 3/27
#> 41   NA              Name FAA         NA  NA Last Game
#> 42   41          Jeb Hartness      47.86  68  Sat 3/27
#> 43   42          Mike Roberts      47.53  45  Sat 3/13
#> 44   43          Gary Maxwell      47.10  61  Sat 3/13
#> 45   44         Donnie Eppley      46.97  43  Sun 3/21
#> 46   45         Lamar Simpson      46.78  42  Sun 3/21
#> 47   46            Eric Curry      46.41  52  Sat 3/13
#> 48   47             Mike Reed      46.30  59  Sun 3/21
#> 49   48      Michael Stephens      45.99  50   Sat 3/6
#> 50   49            David Hall      45.78  61  Sat 3/13
#> 51   50           Tony Greene      44.08  45  Sat 3/20
#> 52   51           Joe Lindsay      43.90  45  Sat 3/27
#> 53   52         Patrick Evans      43.36  43  Sat 3/13
#> 54   53        Anthony Jordan      43.35  48  Sat 3/13
#> 55   54        Michael Irving      42.94  57  Sun 3/28
#> 56   55           Earl Walton      42.44  53  Wed 3/24
#> 57   56          Rob Kueneman      42.42  42  Fri 3/12
#> 58   57        Tony Henderson      41.93  51  Sun 3/28
#> 59   58           Matt Potter      41.15  51  Fri 3/19
#> 60   59           Todd Austin      41.09  52  Sat 3/20
#> 61   60            Bret Smith      40.30  58  Sun 3/21
#> 62   61       Larry Spaulding      39.82  53  Sun 3/28
#> 63   62    Bill Covington Jr.      39.16  47  Mon 3/22
#> 64   63 Vladimir Voyard-Tadal      39.02  46  Sat 3/20
#> 65   64          Tony Chiazza      38.77  42  Sun 3/21
#> 66   65            Bart Lenox      38.31  51  Fri 3/19
#> 67   66         Olandis Poole      37.43  49  Fri 3/12
#> 68   67          Jerry Heater      37.25  50  Sun 3/28
#> 69   68     Marques Pettigrew      37.11  52  Sun 3/28
#> 70   69        Tim Clougherty      37.04  41  Sun 3/21
#> 71   70        Steve Anderson      36.94  43  Mon 3/22
#> 72   71           Owen Shortt      36.92  47  Sat 3/20
#> 73   72         Mike Scyphers      36.41  48  Sat 3/13
#> 74   73            John Floyd      36.20  51  Sun 3/28
#> 75   74           Chuck Jones      35.74  40  Sat 3/13
#> 76   75           Will Howard      35.47  46  Fri 3/12
#> 77   76            Mike Nance      35.28  44  Sat 3/13
#> 78   77            A.J. Desai      35.03  44  Sat 3/27
#> 79   78           Edwin Young      34.81  33  Sun 3/28
#> 80   79               Bill Ek      34.81  47  Mon 3/22
#> 81   80       Tommy Morrissey      34.58  44  Sun 3/28
#> 82   NA              Name FAA         NA  NA Last Game
#> 83   81        Lewis Garrison      34.48  30  Sat 3/13
#> 84   82           Kevin Brill      34.14  45  Sun 3/21
#> 85   83           Nate Harris      34.02  46  Fri 3/12
#> 86   84       Steve McJunkins      33.91  31  Sat 3/20
#> 87   85            Amy Bonner      33.84  61  Thu 3/18
#> 88   86         Antinio Petty      33.75  51  Sat 3/20
#> 89   87           Deron White      33.49  45  Sat 3/13
#> 90   88         Gregory Nixon      33.11  45  Sat 3/20
#> 91   89         Darron George      31.68  51  Thu 3/25
#> 92   90           Jason Baker      31.35  43  Fri 3/12
#> 93   91            Kelly Self      31.13  46  Fri 3/12
#> 94   92           Tommy Nunez      30.97  46  Sat 3/13
#> 95   93          K.B. Burdett      30.65  45  Fri 3/12
#> 96   94          Chance Moore      30.47  46  Thu 3/25
#> 97   95         Rick Crawford      30.07  42  Wed 3/24
#> 98   96           Deldre Carr      30.06  41  Sun 3/21
#> 99   97           Mark Schnur      29.02  44  Wed 3/10
#> 100  98             Les Jones      28.99  42  Thu 3/11
#> 101  99             Tim Comer      28.09  48  Sun 3/14
#> 102 100             Rob Rorke      28.02  36  Fri 3/12
#> 103 101       Randy Heimerman      27.57  37  Sat 3/20
#> 104 102         Steve Honacki      26.35  43   Mon 3/8
#> 105 103           D.G. Nelson      25.93  41  Sat 3/13
#> 106 104           Chad Barlow      25.27  37  Fri 3/12
#> 107 105        Evon Burroughs      24.88  31  Sun 3/14
#> 108 106           Tim Stewart      24.09  34  Sat 3/13
#> 109 107           Bob Staffen      23.68  41  Fri 3/12
#> 110 108          Brandon Cruz      23.19  42  Sat 3/13
#> 111 109          Andy O'Brien      23.18  40  Thu 3/18
#> 112 110          Kevin Mathis      22.78  34  Thu 3/11
#> 113 111            Chase Shaw      22.74  46   Sat 3/6
#> 114 112         Rodrick Dixon      22.27  37  Thu 3/25
#> 115 113     Michael Kitts Jr.      22.15  40  Wed 3/24
#> 116 114         Wally Rutecki      22.10  31  Thu 3/11
#> 117 115          Frank Harvey      22.06  31  Thu 3/11
#> 118 116          Brian McNutt      21.76  35  Thu 3/18
#> 119 117          Shawn Lehigh      21.66  39  Fri 3/12
#> 120 118          Ron Tyburski      21.50  37  Fri 3/12
#> 121 119         Anthony Eades      21.31  46   Sat 3/6
#> 122 120          John Hampton      21.26  31   Sat 3/6
#> 123  NA              Name FAA         NA  NA Last Game
#> 124 121          Craig Murley      21.13  38  Thu 3/11
#> 125 122    Justin Porterfield      20.88  33  Wed 3/10
#> 126 123       Gerald Williams      20.61  30  Thu 3/25
#> 127 124             Tim Smith      20.46  36   Sat 3/6
#> 128 125           Nathan Hall      20.36  36  Wed 3/10
#> 129 126        Raymond Styons      19.96  33  Tue 2/23
#> 130 127          Jim Schipper      18.48  28  Thu 3/11
#> 131 128          Jon Campbell      18.33  30   Tue 3/9
#> 132 129          Alfred Smith      18.24  30  Fri 3/12
#> 133 130       Bryan Anslinger      18.00  30  Thu 3/11
#> 134 131       Casey McClellan      17.83  27  Fri 3/12
#> 135 132           Scott Brown      17.82  27  Fri 3/12
#> 136 133             Sean Hull      17.76  29  Sun 3/14
#> 137 134          Kerby Sitton      17.76  36  Thu 3/25
#> 138 135         Robert Felder      17.70  31  Fri 3/12
#> 139 136      Adam Vandenburgh      17.63  31  Sat 3/13
#> 140 137       Garrick Shannon      17.54  36  Thu 3/11
#> 141 138        Stephen Divine      17.40  27  Thu 3/11
#> 142 139          Rick Batsell      17.28  35  Fri 3/12
#> 143 140             Tim Kelly      17.23  29   Sun 3/7
#> 144 141          Ryan Corbett      17.12  29  Fri 3/12
#> 145 142         Jeremy Mosier      17.09  29   Mon 3/1
#> 146 143         Bill Vinovich      17.04  27  Fri 3/12
#> 147 144           Ed Phillips      16.95  31  Thu 3/11
#> 148 145        Phil Sallustio      16.65  28   Sat 3/6
#> 149 146      Randy Richardson      16.64  26  Thu 3/18
#> 150 147        Keith Fogleman      15.88  29   Sun 3/7
#> 151 148      Mick Fieldbinder      15.83  36  Thu 3/11
#> 152 149         Peter Juzenas      15.81  21  Thu 3/11
#> 153 150         Glen Mayberry      15.60  26  Fri 3/12
#> 154 151            Greg Evans      15.54  24   Sat 3/6
#> 155 152           Matt Palumb      15.32  29  Thu 3/11
#> 156 153            Brian Shey      15.32  25   Sat 3/6
#> 157 154              Jeff Pon      15.32  27  Tue 3/23
#> 158 155         Andrew Walton      15.28  26   Fri 3/5
#> 159 156         Michael Palau      15.22  27   Tue 3/9
#> 160 157          Kerry Sitton      15.18  29  Fri 3/12
#> 161 158           Jeff Malham      15.18  29   Tue 3/9
#> 162 159           Trey Styons      15.08  28  Sat 2/27
#> 163 160           Jeff Ketchu      15.04  26  Fri 3/12
#> 164  NA              Name FAA         NA  NA Last Game
#> 165 161            Tony Crisp      14.90  21  Wed 3/10
#> 166 162          Shane Staggs      14.89  32  Wed 3/10
#> 167 163      Michael Griffith      14.86  28   Mon 3/8
#> 168 164         Lionel Butler      14.81  30  Sat 3/13
#> 169 165           Brent Meaux      14.78  32  Fri 3/12
#> 170 166          Jabir Walker      14.75  29  Thu 3/11
#> 171 167           Tariq Lucas      14.75  27   Tue 3/2
#> 172 168          Luke Schumer      14.67  26   Mon 3/8
#> 173 169           Tyler Kumpf      14.43  26  Wed 3/10
#> 174 170            Ed Corliss      14.27  27  Wed 3/10
#> 175 171          Matt Morales      14.23  24   Tue 3/2
#> 176 172         Daryl Gelinas      14.14  27  Fri 3/12
#> 177 173        King Whetstone      14.07  28  Sat 3/13
#> 178 174         Bill Jacobson      14.02  20  Thu 3/11
#> 179 175          Chris Beaver      13.97  18  Wed 1/27
#> 180 176       Matthew Rukasin      13.82  27   Sat 3/6
#> 181 177        Dwayne Gladden      13.55  25  Sat 3/13
#> 182 178             Tom Nally      13.41  24  Thu 3/11
#> 183 179           Kurt Walker      13.41  21   Sat 3/6
#> 184 180         Gene Grimshaw      13.41  23   Fri 3/5
#> 185 181       Todd Von Sossan      13.37  22  Sun 2/28
#> 186 182          Bret Wegenke      13.33  21   Tue 3/2
#> 187 183          Jourdan Love      13.15  25   Tue 3/2
#> 188 184        Mike McCloskey      13.12  22  Wed 3/10
#> 189 185         Ryan McDaniel      13.11  23  Thu 3/11
#> 190 186       Doran Gotschall      12.97  25  Thu 3/11
#> 191 187           Brad Ferrie      12.88  27  Fri 3/12
#> 192 188  Christopher Slattery      12.82  23  Sat 3/13
#> 193 189          Billy Dunlap      12.72  19   Sun 3/7
#> 194 190          Zelton Steed      12.68  20   Sat 3/6
#> 195 191              JW Lucas      12.58  24   Mon 3/1
#> 196 192            Dan Dorian      12.55  21   Fri 3/5
#> 197 193       Ed Corbett, Jr.      12.52  22  Sun 2/28
#> 198 194       Keith Patterson      12.46  24   Fri 3/5
#> 199 195          Rick O'Neill      12.45  22  Fri 3/12
#> 200 196         Jeff Spedoske      12.38  20   Fri 3/5
#> 201 197            Tony Meeks      12.32  23  Thu 3/11
#> 202 198          Jose Carrion      12.21  24   Sat 3/6
#> 203 199          Hunter Allen      12.20  25   Fri 3/5
#> 204 200      Anthony Franklin      12.19  23   Mon 3/1
#>                                                              last_game_1 year
#> 1                           2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 2                    4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 3                         2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 4                           2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 5                 15 Arkansas 72, 128 Oral Roberts 70 (Indianapolis, IN) 2021
#> 6                       1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 7                          28 St. Bonaventure 74, 43 VCU 65 (Dayton, OH) 2021
#> 8                              1 Gonzaga 85, 6 USC 66 (Indianapolis, IN) 2021
#> 9              37 Oklahoma St. 72, 25 West Virginia 69 (Kansas City, MO) 2021
#> 10                             1 Gonzaga 85, 6 USC 66 (Indianapolis, IN) 2021
#> 11                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 12              48 Oregon St. 65, 9 Loyola Chicago 58 (Indianapolis, IN) 2021
#> 13                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 14                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 15                     25 Texas 91, 30 Oklahoma St. 86 (Kansas City, MO) 2021
#> 16                           3 Michigan 86, 23 LSU 78 (Indianapolis, IN) 2021
#> 17                       4 Houston 62, 37 Syracuse 46 (Indianapolis, IN) 2021
#> 18                        2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 19                          16 UCLA 51, 3 Michigan 49 (Indianapolis, IN) 2021
#> 20                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 21                35 Georgia Tech 80, 13 Florida St. 75 (Greensboro, NC) 2021
#> 22                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 23                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 24                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 25                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 26                   4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 27                      1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 28                   4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 29                 9 Loyola Chicago 71, 2 Illinois 58 (Indianapolis, IN) 2021
#> 30                       2 Baylor 62, 11 Villanova 51 (Indianapolis, IN) 2021
#> 31                      1 Gonzaga 83, 20 Creighton 65 (Indianapolis, IN) 2021
#> 32                      1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 33                          2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 34                       12 Virginia 72, 44 Syracuse 69 (Greensboro, NC) 2021
#> 35                     73 Georgetown 66, 49 Seton Hall 58 (New York, NY) 2021
#> 36                   1 Gonzaga 98, 203 Norfolk St. 55 (Indianapolis, IN) 2021
#> 37                     37 Oklahoma St. 83, 3 Baylor 74 (Kansas City, MO) 2021
#> 38                        2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 39                          16 UCLA 51, 3 Michigan 49 (Indianapolis, IN) 2021
#> 40                       2 Baylor 62, 11 Villanova 51 (Indianapolis, IN) 2021
#> 41                                                             Last Game 2021
#> 42              48 Oregon St. 65, 9 Loyola Chicago 58 (Indianapolis, IN) 2021
#> 43                      68 Georgetown 73, 10 Creighton 48 (New York, NY) 2021
#> 44           73 North Texas 61, 92 Western Kentucky 57 (OT) (Frisco, TX) 2021
#> 45                 135 Oral Roberts 81, 37 Florida 78 (Indianapolis, IN) 2021
#> 46                 15 Villanova 84, 57 North Texas 61 (Indianapolis, IN) 2021
#> 47                   24 San Diego St. 68, 38 Utah St. 57 (Las Vegas, NV) 2021
#> 48                 15 Villanova 84, 57 North Texas 61 (Indianapolis, IN) 2021
#> 49                      26 Connecticut 98, 85 Georgetown 82 (Storrs, CT) 2021
#> 50                   24 San Diego St. 68, 38 Utah St. 57 (Las Vegas, NV) 2021
#> 51           18 Florida St. 64, 100 UNC Greensboro 54 (Indianapolis, IN) 2021
#> 52                15 Arkansas 72, 128 Oral Roberts 70 (Indianapolis, IN) 2021
#> 53                             29 LSU 78, 19 Arkansas 71 (Nashville, TN) 2021
#> 54                 112 Cincinnati 60, 70 Wichita St. 59 (Fort Worth, TX) 2021
#> 55                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 56        105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 57                   7 Ohio St. 87, 12 Purdue 78 (OT) (Indianapolis, IN) 2021
#> 58                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 59                       4 Baylor 79, 192 Hartford 55 (Indianapolis, IN) 2021
#> 60                          7 Alabama 68, 183 Iona 55 (Indianapolis, IN) 2021
#> 61                 9 Loyola Chicago 71, 2 Illinois 58 (Indianapolis, IN) 2021
#> 62                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 63                  16 Florida St. 71, 10 Colorado 53 (Indianapolis, IN) 2021
#> 64                 79 Mississippi St. 74, 46 Saint Louis 68 (Frisco, TX) 2021
#> 65                   13 Arkansas 68, 14 Texas Tech 66 (Indianapolis, IN) 2021
#> 66          151 Oral Roberts 75, 7 Ohio St. 72 (OT) (West Lafayette, IN) 2021
#> 67              69 Wichita St. 68, 180 South Florida 67 (Fort Worth, TX) 2021
#> 68                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 69                      1 Gonzaga 83, 20 Creighton 65 (Indianapolis, IN) 2021
#> 70               63 Oregon St. 80, 29 Oklahoma St. 70 (Indianapolis, IN) 2021
#> 71                             9 USC 85, 18 Kansas 51 (Indianapolis, IN) 2021
#> 72                 79 Mississippi St. 74, 46 Saint Louis 68 (Frisco, TX) 2021
#> 73              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 74                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 75                         8 Alabama 73, 20 Tennessee 68 (Nashville, TN) 2021
#> 76                         112 Cincinnati 74, 54 SMU 71 (Fort Worth, TX) 2021
#> 77                          6 Houston 76, 40 Memphis 74 (Fort Worth, TX) 2021
#> 78                       4 Houston 62, 37 Syracuse 46 (Indianapolis, IN) 2021
#> 79                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 80                        20 Creighton 72, 76 Ohio 58 (Indianapolis, IN) 2021
#> 81                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 82                                                             Last Game 2021
#> 83                           3 Illinois 82, 4 Iowa 71 (Indianapolis, IN) 2021
#> 84                        5 Houston 63, 34 Rutgers 60 (Indianapolis, IN) 2021
#> 85             229 Montana St. 80, 138 Southern Utah 77 (OT) (Boise, ID) 2021
#> 86                          82 Ohio 62, 13 Virginia 58 (Bloomington, IN) 2021
#> 87                         72 N.C. State 75, 55 Davidson 61 (Denton, TX) 2021
#> 88                              40 Memphis 71, 83 Dayton 60 (Denton, TX) 2021
#> 89              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 90            20 Creighton 63, 71 UC Santa Barbara 62 (Indianapolis, IN) 2021
#> 91             78 Louisiana Tech 72, 92 Western Kentucky 65 (Frisco, TX) 2021
#> 92                             40 Memphis 70, 99 UCF 62 (Fort Worth, TX) 2021
#> 93                  77 North Texas 54, 81 Louisiana Tech 48 (Frisco, TX) 2021
#> 94              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 95                   8 Alabama 85, 68 Mississippi St. 48 (Nashville, TN) 2021
#> 96                    76 Mississippi St. 68, 63 Richmond 67 (Denton, TX) 2021
#> 97        105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 98                 135 Oral Roberts 81, 37 Florida 78 (Indianapolis, IN) 2021
#> 99                     53 Syracuse 89, 65 N.C. State 68 (Greensboro, NC) 2021
#> 100                     98 Western Kentucky 80, 160 UTSA 67 (Frisco, TX) 2021
#> 101                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 102             69 Wichita St. 68, 180 South Florida 67 (Fort Worth, TX) 2021
#> 103                             40 Memphis 71, 83 Dayton 60 (Denton, TX) 2021
#> 104          211 Oakland 69, 188 Northern Kentucky 58 (Indianapolis, IN) 2021
#> 105            110 Eastern Washington 65, 223 Montana St. 55 (Boise, ID) 2021
#> 106                     63 Buffalo 81, 101 Akron 74 (OT) (Cleveland, OH) 2021
#> 107                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 108                            83 Ohio 84, 59 Buffalo 69 (Cleveland, OH) 2021
#> 109                   39 Utah St. 62, 59 Colorado St. 50 (Las Vegas, NV) 2021
#> 110                    185 Iona 60, 308 Fairfield 51 (Atlantic City, NJ) 2021
#> 111         200 Norfolk St. 54, 208 Appalachian St. 53 (Bloomington, IN) 2021
#> 112                  76 North Texas 61, 153 Old Dominion 55 (Frisco, TX) 2021
#> 113                        136 Mercer 62, 125 Wofford 61 (Asheville, NC) 2021
#> 114                          39 Memphis 59, 59 Boise St. 56 (Denton, TX) 2021
#> 115       105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 116                        17 Creighton 87, 108 Butler 56 (New York, NY) 2021
#> 117                          16 USC 91, 75 Utah 85 (2OT) (Las Vegas, NV) 2021
#> 118                  53 Drake 53, 74 Wichita St. 52 (West Lafayette, IN) 2021
#> 119            155 New Mexico St. 78, 205 Utah Valley 62 (Las Vegas, NV) 2021
#> 120           312 Fairfield 52, 208 Saint Peter's 47 (Atlantic City, NJ) 2021
#> 121                        149 VMI 91, 87 Furman 90 (OT) (Asheville, NC) 2021
#> 122        128 East Tennessee St. 63, 152 Chattanooga 53 (Asheville, NC) 2021
#> 123                                                            Last Game 2021
#> 124           77 Louisiana Tech 75, 183 Florida Atlantic 69 (Frisco, TX) 2021
#> 125             31 North Carolina 101, 68 Notre Dame 59 (Greensboro, NC) 2021
#> 126                    66 Colorado St. 65, 68 N.C. State 61 (Frisco, TX) 2021
#> 127                  184 Bryant 85, 311 Sacred Heart 55 (Smithfield, RI) 2021
#> 128                       220 Loyola MD 67, 188 Army 63 (West Point, NY) 2021
#> 129                  59 Richmond 79, 111 Massachusetts 65 (Richmond, VA) 2021
#> 130                   238 Seattle 83, 230 Cal Baptist 66 (Las Vegas, NV) 2021
#> 131              157 Cleveland St. 80, 201 Oakland 69 (Indianapolis, IN) 2021
#> 132                             87 Ohio 87, 60 Toledo 80 (Cleveland, OH) 2021
#> 133                       67 Buffalo 74, 142 Miami OH 63 (Cleveland, OH) 2021
#> 134                121 Eastern Washington 78, 192 Montana 50 (Boise, ID) 2021
#> 135            229 Montana St. 80, 138 Southern Utah 77 (OT) (Boise, ID) 2021
#> 136                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 137                   76 Mississippi St. 68, 63 Richmond 67 (Denton, TX) 2021
#> 138                         6 Houston 77, 143 Tulane 52 (Fort Worth, TX) 2021
#> 139                    185 Iona 60, 308 Fairfield 51 (Atlantic City, NJ) 2021
#> 140                         149 Tulane 77, 119 Tulsa 70 (Fort Worth, TX) 2021
#> 141                                  96 UAB 73, 186 Rice 60 (Frisco, TX) 2021
#> 142                121 Eastern Washington 78, 192 Montana 50 (Boise, ID) 2021
#> 143        168 Northeastern 63, 291 William & Mary 47 (Harrisonburg, VA) 2021
#> 144           312 Fairfield 52, 208 Saint Peter's 47 (Atlantic City, NJ) 2021
#> 145                253 Longwood 77, 214 UNC Asheville 61 (Asheville, NC) 2021
#> 146              76 UC Santa Barbara 71, 216 UC Davis 55 (Las Vegas, NV) 2021
#> 147                   105 Akron 74, 121 Bowling Green 67 (Cleveland, OH) 2021
#> 148                        222 Loyola MD 76, 145 Navy 68 (Annapolis, MD) 2021
#> 149                              61 Boise St. 85, 59 SMU 84 (Frisco, TX) 2021
#> 150                 219 Elon 72, 174 James Madison 71 (Harrisonburg, VA) 2021
#> 151                  76 North Texas 61, 153 Old Dominion 55 (Frisco, TX) 2021
#> 152                   59 Toledo 91, 144 Ball St. 89 (OT) (Cleveland, OH) 2021
#> 153                109 UC Irvine 78, 104 UC Riverside 61 (Las Vegas, NV) 2021
#> 154                             50 VCU 64, 56 Davidson 52 (Richmond, VA) 2021
#> 155               216 Saint Peter's 75, 313 Rider 60 (Atlantic City, NJ) 2021
#> 156              140 Georgia St. 71, 258 Arkansas St. 68 (Pensacola, FL) 2021
#> 157     163 Coastal Carolina 77, 231 Stetson 72 (OT) (Daytona Beach, FL) 2021
#> 158              86 Belmont 72, 155 Jacksonville St. 69 (Evansville, IN) 2021
#> 159           227 Mount St. Mary's 73, 167 Bryant 68 (Staten Island, NY) 2021
#> 160                     98 Abilene Christian 93, 308 Lamar 71 (Katy, TX) 2021
#> 161             345 Houston Baptist 80, 340 Incarnate Word 68 (Katy, TX) 2021
#> 162                    324 Hampton 67, 329 Presbyterian 65 (Hampton, VA) 2021
#> 163              76 UC Santa Barbara 71, 216 UC Davis 55 (Las Vegas, NV) 2021
#> 164                                                            Last Game 2021
#> 165                       220 Loyola MD 67, 188 Army 63 (West Point, NY) 2021
#> 166              80 North Texas 76, 305 Middle Tennessee 56 (Frisco, TX) 2021
#> 167          211 Oakland 69, 188 Northern Kentucky 58 (Indianapolis, IN) 2021
#> 168                  211 Norfolk St. 71, 224 Morgan St. 63 (Norfolk, VA) 2021
#> 169                     98 Abilene Christian 93, 308 Lamar 71 (Katy, TX) 2021
#> 170                       67 Buffalo 74, 142 Miami OH 63 (Cleveland, OH) 2021
#> 171       268 Western Michigan 73, 331 Northern Illinois 63 (DeKalb, IL) 2021
#> 172       145 North Dakota St. 79, 172 South Dakota 75 (Sioux Falls, SD) 2021
#> 173              80 North Texas 76, 305 Middle Tennessee 56 (Frisco, TX) 2021
#> 174                       89 Colgate 105, 266 Bucknell 75 (Hamilton, NY) 2021
#> 175             207 Oakland 87, 226 Youngstown St. 83 (OT) (Oakland, MI) 2021
#> 176                109 UC Irvine 78, 104 UC Riverside 61 (Las Vegas, NV) 2021
#> 177             199 Hartford 64, 222 UMass Lowell 50 (West Hartford, CT) 2021
#> 178                     99 UCF 72, 157 East Carolina 62 (Fort Worth, TX) 2021
#> 179                        12 Ohio St. 83, 46 Penn St. 79 (Columbus, OH) 2021
#> 180        244 UC San Diego 85, 253 Cal St. Fullerton 78 (San Diego, CA) 2021
#> 181                  211 Norfolk St. 71, 224 Morgan St. 63 (Norfolk, VA) 2021
#> 182        72 UC Santa Barbara 95, 256 Long Beach St. 87 (Las Vegas, NV) 2021
#> 183                           224 UC Davis 74, 193 Hawaii 66 (Davis, CA) 2021
#> 184       12 Loyola Chicago 73, 191 Southern Illinois 49 (St. Louis, MO) 2021
#> 185        159 North Dakota St. 89, 171 South Dakota 77 (Vermillion, SD) 2021
#> 186               151 Ball St. 100, 262 Eastern Michigan 65 (Muncie, IN) 2021
#> 187      187 Northern Kentucky 70, 141 Detroit 69 (Highland Heights, KY) 2021
#> 188                       89 Colgate 105, 266 Bucknell 75 (Hamilton, NY) 2021
#> 189                          48 Utah St. 74, 164 UNLV 53 (Las Vegas, NV) 2021
#> 190       122 Eastern Washington 66, 331 Northern Arizona 60 (Boise, ID) 2021
#> 191                  130 Grand Canyon 81, 223 Seattle 47 (Las Vegas, NV) 2021
#> 192             199 Hartford 64, 222 UMass Lowell 50 (West Hartford, CT) 2021
#> 193     108 UNC Greensboro 77, 124 East Tennessee St. 65 (Asheville, NC) 2021
#> 194        128 East Tennessee St. 63, 152 Chattanooga 53 (Asheville, NC) 2021
#> 195                         225 Radford 67, 325 Hampton 52 (Radford, VA) 2021
#> 196                          73 Buffalo 81, 88 Kent St. 67 (Buffalo, NY) 2021
#> 197               199 Army 57, 265 Boston University 55 (West Point, NY) 2021
#> 198   299 North Alabama 96, 276 Florida Gulf Coast 81 (Jacksonville, FL) 2021
#> 199            155 New Mexico St. 78, 205 Utah Valley 62 (Las Vegas, NV) 2021
#> 200 336 Northern Illinois 79, 263 Central Michigan 74 (Mt. Pleasant, MI) 2021
#> 201               216 Saint Peter's 75, 313 Rider 60 (Atlantic City, NJ) 2021
#> 202        219 Appalachian St. 76, 182 Texas St. 73 (OT) (Pensacola, FL) 2021
#> 203                     310 Troy 91, 242 UT Arlington 86 (Pensacola, FL) 2021
#> 204               221 Campbell 63, 174 Gardner Webb 57 (Buies Creek, NC) 2021
# }
# \donttest{
try(kp_referee(referee = 714363, year = 2021))
#>    game_number       date  time_et
#> 1           74  Mon Apr 5  9:20 PM
#> 2           73 Sat Mar 27  7:25 PM
#> 3           72 Mon Mar 22  8:45 PM
#> 4           71 Sat Mar 20  3:30 PM
#> 5           70 Fri Mar 19  1:15 PM
#> 6           69 Sat Mar 13  6:00 PM
#> 7           68 Thu Mar 11 11:30 AM
#> 8           67 Wed Mar 10  9:30 PM
#> 9           66  Sun Mar 7  4:00 PM
#> 10          65  Sat Mar 6  5:00 PM
#> 11          64  Fri Mar 5  8:00 PM
#> 12          63  Thu Mar 4  7:00 PM
#> 13          62  Wed Mar 3  9:00 PM
#> 14          61  Tue Mar 2  7:00 PM
#> 15          60  Mon Mar 1  9:00 PM
#> 16          59 Sat Feb 27 12:00 PM
#> 17          58 Fri Feb 26  8:00 PM
#> 18          57 Thu Feb 25  8:56 PM
#> 19          56 Wed Feb 24  6:30 PM
#> 20          55 Tue Feb 23  7:00 PM
#> 21          54 Mon Feb 22  7:00 PM
#> 22          53 Sun Feb 21  1:00 PM
#> 23          52 Sat Feb 20 12:00 PM
#> 24          51 Sun Feb 14  1:00 PM
#> 25          50 Sat Feb 13  1:00 PM
#> 26          49 Fri Feb 12  6:00 PM
#> 27          48 Wed Feb 10  9:00 PM
#> 28          47  Tue Feb 9  9:00 PM
#> 29          46  Mon Feb 8  9:00 PM
#> 30          45  Sat Feb 6  3:00 PM
#> 31          44  Tue Feb 2  7:00 PM
#> 32          43  Mon Feb 1  9:00 PM
#> 33          42 Sat Jan 30  2:00 PM
#> 34          41 Thu Jan 28  7:00 PM
#> 35          40 Wed Jan 27  9:00 PM
#> 36          39 Tue Jan 26  9:00 PM
#> 37          38 Mon Jan 25  7:00 PM
#> 38          37 Sat Jan 23 12:00 PM
#> 39          36 Mon Jan 18  7:00 PM
#> 40          35 Sun Jan 17  5:00 PM
#> 41          34 Sat Jan 16  3:00 PM
#> 42          33 Wed Jan 13  9:00 PM
#> 43          32  Sat Jan 9  4:00 PM
#> 44          31  Fri Jan 8  8:00 PM
#> 45          30  Wed Jan 6  9:00 PM
#> 46          29  Tue Jan 5 10:00 PM
#> 47          28  Sun Jan 3  6:00 PM
#> 48          27  Sat Jan 2  4:00 PM
#> 49          26  Fri Jan 1  6:00 PM
#> 50          25 Wed Dec 30  6:30 PM
#> 51          24 Tue Dec 29  9:07 PM
#> 52          23 Mon Dec 28  8:00 PM
#> 53          22 Sat Dec 26  4:00 PM
#> 54          21 Fri Dec 25  2:30 PM
#> 55          20 Wed Dec 23  5:00 PM
#> 56          19 Mon Dec 21  3:00 PM
#> 57          18 Sun Dec 20  4:00 PM
#> 58          17 Sat Dec 19 12:00 PM
#> 59          16 Thu Dec 17  7:00 PM
#> 60          15 Wed Dec 16  8:00 PM
#> 61          14 Tue Dec 15  9:00 PM
#> 62          13 Sun Dec 13 12:00 PM
#> 63          12 Sat Dec 12  3:00 PM
#> 64          11 Fri Dec 11  7:00 PM
#> 65          10  Tue Dec 8 10:00 PM
#> 66           9  Mon Dec 7  7:00 PM
#> 67           8  Thu Dec 3  8:00 PM
#> 68           7  Wed Dec 2 10:00 PM
#> 69           6 Mon Nov 30  8:00 PM
#> 70           5 Sun Nov 29  5:30 PM
#> 71           4 Sat Nov 28  7:30 PM
#> 72           3 Fri Nov 27  8:30 PM
#> 73           2 Thu Nov 26  8:00 PM
#> 74           1 Wed Nov 25  4:00 PM
#>                                                  game            location
#> 1                           2 Baylor 86, 1 Gonzaga 70    Indianapolis, IN
#> 2                 15 Arkansas 72, 128 Oral Roberts 70    Indianapolis, IN
#> 3                        8 Alabama 96, 30 Maryland 77    Indianapolis, IN
#> 4             20 Creighton 63, 71 UC Santa Barbara 62    Indianapolis, IN
#> 5                        3 Illinois 78, 145 Drexel 49    Indianapolis, IN
#> 6                     25 Texas 91, 30 Oklahoma St. 86     Kansas City, MO
#> 7             37 Oklahoma St. 72, 25 West Virginia 69     Kansas City, MO
#> 8                     38 Oklahoma 79, 179 Iowa St. 73     Kansas City, MO
#> 9                       3 Baylor 88, 20 Texas Tech 73            Waco, TX
#> 10                 183 Kansas St. 61, 175 Iowa St. 56       Manhattan, KS
#> 11                      114 UAB 65, 62 North Texas 51          Denton, TX
#> 12                    20 West Virginia 76, 127 TCU 67      Morgantown, WV
#> 13                 72 Northwestern 60, 26 Maryland 55        Evanston, IL
#> 14                       6 Illinois 76, 2 Michigan 53       Ann Arbor, MI
#> 15                 36 Oklahoma St. 79, 33 Oklahoma 75      Stillwater, OK
#> 16                      25 Texas Tech 68, 22 Texas 59         Lubbock, TX
#> 17         173 New Mexico St. 78, 311 Tarleton St. 51    Stephenville, TX
#> 18  245 Texas Southern 79, 351 Arkansas Pine Bluff 65         Houston, TX
#> 19                    71 N.C. State 68, 9 Virginia 61 Charlottesville, VA
#> 20                 51 Louisville 69, 56 Notre Dame 57      Louisville, KY
#> 21                         31 Duke 85, 53 Syracuse 71          Durham, NC
#> 22                       4 Michigan 92, 6 Ohio St. 87        Columbus, OH
#> 23                56 Georgia Tech 87, 129 Miami FL 60    Coral Gables, FL
#> 24                       92 Cincinnati 69, 105 UCF 68      Cincinnati, OH
#> 25          23 Oklahoma 91, 16 West Virginia 90 (2OT)      Morgantown, WV
#> 26           72 Marshall 107, 261 Middle Tennessee 79      Huntington, WV
#> 27              48 Saint Louis 67, 74 Rhode Island 60       St. Louis, MO
#> 28                  20 Creighton 63, 96 Georgetown 48      Washington, DC
#> 29  357 Mississippi Valley St. 68, 352 Alabama St. 65      Montgomery, AL
#> 30              38 Oklahoma St. 75, 12 Texas 67 (2OT)      Stillwater, OK
#> 31                61 Clemson 63, 37 North Carolina 50         Clemson, SC
#> 32                   12 Texas Tech 57, 20 Oklahoma 52         Lubbock, TX
#> 33                 25 Florida 85, 16 West Virginia 80      Morgantown, WV
#> 34                           204 UTSA 86, 171 UTEP 79     San Antonio, TX
#> 35                    50 Clemson 54, 38 Louisville 50         Clemson, SC
#> 36                     34 Duke 75, 58 Georgia Tech 68          Durham, NC
#> 37                      9 Virginia 81, 36 Syracuse 58 Charlottesville, VA
#> 38                       26 Oklahoma 75, 14 Kansas 68          Norman, OK
#> 39                23 Florida St. 78, 31 Louisville 65      Louisville, KY
#> 40               134 Santa Clara 69, 180 San Diego 63       San Diego, CA
#> 41                     14 Colorado 77, 45 Stanford 64         Boulder, CO
#> 42                    62 Boise St. 90, 198 Wyoming 70         Laramie, WY
#> 43                   14 Texas Tech 91, 87 Iowa St. 64            Ames, IA
#> 44      89 Western Kentucky 66, 112 Louisiana Tech 64   Bowling Green, KY
#> 45                        2 Baylor 76, 44 Oklahoma 61            Waco, TX
#> 46                            12 Kansas 93, 63 TCU 64      Fort Worth, TX
#> 47             73 Georgia Tech 70, 117 Wake Forest 54         Atlanta, GA
#> 48             27 North Carolina 66, 92 Notre Dame 65     Chapel Hill, NC
#> 49                295 Troy 69, 197 Appalachian St. 56           Boone, NC
#> 50                    16 Ohio St. 90, 116 Nebraska 54        Columbus, OH
#> 51                      5 Iowa 87, 53 Northwestern 72       Iowa City, IA
#> 52                42 Minnesota 81, 31 Michigan St. 56     Minneapolis, MN
#> 53                       7 Illinois 69, 21 Indiana 60       Champaign, IL
#> 54                       33 Purdue 73, 47 Maryland 70  West Lafayette, IN
#> 55                 7 Tennessee 80, 303 USC Upstate 60       Knoxville, TN
#> 56                    261 Rice 73, 316 New Orleans 62         Houston, TX
#> 57           183 UTSA 102, NR Our Lady of the Lake 70     San Antonio, TX
#> 58                            1 Gonzaga 99, 4 Iowa 88     Sioux Falls, SD
#> 59                       9 Kansas 58, 8 Texas Tech 57         Lubbock, TX
#> 60                 5 Texas 79, 309 Sam Houston St. 63          Austin, TX
#> 61                  155 Kansas St. 74, 78 Iowa St. 65            Ames, IA
#> 62         82 Western Kentucky 68, 73 Rhode Island 65   Bowling Green, KY
#> 63             46 Oklahoma St. 67, 101 Wichita St. 64         Wichita, KS
#> 64                   13 Creighton 98, 111 Nebraska 74           Omaha, NE
#> 65                    68 Saint Mary's 73, 197 UTEP 61          Moraga, CA
#> 66                118 Nevada 86, NR William Jessup 64            Reno, NV
#> 67                 57 TCU 74, 274 Northwestern St. 68      Fort Worth, TX
#> 68                        2 Baylor 82, 22 Illinois 69    Indianapolis, IN
#> 69           58 SMU 91, 315 Texas A&M Corpus Chris 54          Dallas, TX
#> 70                     17 Houston 64, 5 Texas Tech 53      Fort Worth, TX
#> 71                             57 TCU 70, 93 Tulsa 65     Kansas City, MO
#> 72                  58 Colorado 76, 127 Kansas St. 58       Manhattan, KS
#> 73 105 North Texas 116, 357 Mississippi Valley St. 62          Denton, TX
#> 74            34 Oklahoma St. 75, 159 UT Arlington 68       Arlington, TX
#>                               venue conference thrill_score referee_name
#> 1                 Lucas Oil Stadium       NCAA         88.4 Keith Kimble
#> 2           Bankers Life Fieldhouse       NCAA         36.5 Keith Kimble
#> 3           Bankers Life Fieldhouse       NCAA         74.3 Keith Kimble
#> 4                 Lucas Oil Stadium       NCAA         62.0 Keith Kimble
#> 5          Indiana Farmers Coliseum       NCAA         26.4 Keith Kimble
#> 6                   T-Mobile Center      B12-T         79.0 Keith Kimble
#> 7                   T-Mobile Center      B12-T         77.9 Keith Kimble
#> 8                   T-Mobile Center      B12-T         30.6 Keith Kimble
#> 9                    Ferrell Center        B12         65.8 Keith Kimble
#> 10           Fred Bramlage Coliseum        B12         37.7 Keith Kimble
#> 11                    The Super Pit       CUSA         44.3 Keith Kimble
#> 12                     WVU Coliseum        B12         32.5 Keith Kimble
#> 13                 Welsh-Ryan Arena        B10         68.0 Keith Kimble
#> 14                   Crisler Center        B10         76.5 Keith Kimble
#> 15              Gallagher-Iba Arena        B12         73.2 Keith Kimble
#> 16        United Supermarkets Arena        B12         76.3 Keith Kimble
#> 17                 Wisdom Gymnasium        WAC         26.5 Keith Kimble
#> 18               Health & PE Center       SWAC         11.8 Keith Kimble
#> 19            John Paul Jones Arena        ACC         47.9 Keith Kimble
#> 20                  KFC Yum! Center        ACC         66.5 Keith Kimble
#> 21           Cameron Indoor Stadium        ACC         67.6 Keith Kimble
#> 22                 Value City Arena        B10         87.2 Keith Kimble
#> 23                    Watsco Center        ACC         52.8 Keith Kimble
#> 24                Fifth Third Arena       Amer         49.1 Keith Kimble
#> 25                     WVU Coliseum        B12         75.1 Keith Kimble
#> 26                 Henderson Center       CUSA         14.9 Keith Kimble
#> 27                   Chaifetz Arena        A10         57.8 Keith Kimble
#> 28                  McDonough Arena         BE         58.8 Keith Kimble
#> 29              Dunn-Oliver Acadome       SWAC         10.2 Keith Kimble
#> 30              Gallagher-Iba Arena        B12         77.3 Keith Kimble
#> 31              Littlejohn Coliseum        ACC         69.0 Keith Kimble
#> 32        United Supermarkets Arena        B12         74.4 Keith Kimble
#> 33                     WVU Coliseum                    72.7 Keith Kimble
#> 34          UTSA Convocation Center       CUSA         37.5 Keith Kimble
#> 35              Littlejohn Coliseum        ACC         68.5 Keith Kimble
#> 36           Cameron Indoor Stadium        ACC         63.7 Keith Kimble
#> 37            John Paul Jones Arena        ACC         63.8 Keith Kimble
#> 38               Lloyd Noble Center        B12         78.3 Keith Kimble
#> 39                  KFC Yum! Center        ACC         75.0 Keith Kimble
#> 40             Jenny Craig Pavilion        WCC         39.2 Keith Kimble
#> 41                 CU Events Center        P12         63.4 Keith Kimble
#> 42                 Arena-Auditorium        MWC         34.3 Keith Kimble
#> 43                  Hilton Coliseum        B12         60.6 Keith Kimble
#> 44                     Diddle Arena       CUSA         45.9 Keith Kimble
#> 45                   Ferrell Center        B12         53.1 Keith Kimble
#> 46                Schollmaier Arena        B12         67.1 Keith Kimble
#> 47                McCamish Pavilion        ACC         42.1 Keith Kimble
#> 48             Dean E. Smith Center        ACC         45.9 Keith Kimble
#> 49        Holmes Convocation Center         SB         23.6 Keith Kimble
#> 50                 Value City Arena        B10         33.6 Keith Kimble
#> 51             Carver-Hawkeye Arena        B10         59.5 Keith Kimble
#> 52                   Williams Arena        B10         74.7 Keith Kimble
#> 53                State Farm Center        B10         72.6 Keith Kimble
#> 54                     Mackey Arena        B10         66.8 Keith Kimble
#> 55            Thompson-Boling Arena                     9.8 Keith Kimble
#> 56                 Tudor Fieldhouse                    25.4 Keith Kimble
#> 57          UTSA Convocation Center                     0.0 Keith Kimble
#> 58                 Sanford Pentagon                    85.7 Keith Kimble
#> 59        United Supermarkets Arena        B12         77.4 Keith Kimble
#> 60                     Erwin Center                     9.9 Keith Kimble
#> 61                  Hilton Coliseum        B12         32.0 Keith Kimble
#> 62                E.A. Diddle Arena                    59.6 Keith Kimble
#> 63               Charles Koch Arena                    56.3 Keith Kimble
#> 64          CHI Health Center Omaha                    33.8 Keith Kimble
#> 65 University Credit Union Pavilion                    23.0 Keith Kimble
#> 66             Lawlor Events Center                     0.0 Keith Kimble
#> 67                Schollmaier Arena                    12.8 Keith Kimble
#> 68          Bankers Life Fieldhouse                    73.9 Keith Kimble
#> 69                   Moody Coliseum                    10.9 Keith Kimble
#> 70                    Dickies Arena                    78.1 Keith Kimble
#> 71                  T-Mobile Center                    54.0 Keith Kimble
#> 72                Bramlage Coliseum                    49.4 Keith Kimble
#> 73                    The Super Pit                     6.4 Keith Kimble
#> 74              College Park Center                    36.3 Keith Kimble
#>    ref_rank year
#> 1         4 2021
#> 2         4 2021
#> 3         4 2021
#> 4         4 2021
#> 5         4 2021
#> 6         4 2021
#> 7         4 2021
#> 8         4 2021
#> 9         4 2021
#> 10        4 2021
#> 11        4 2021
#> 12        4 2021
#> 13        4 2021
#> 14        4 2021
#> 15        4 2021
#> 16        4 2021
#> 17        4 2021
#> 18        4 2021
#> 19        4 2021
#> 20        4 2021
#> 21        4 2021
#> 22        4 2021
#> 23        4 2021
#> 24        4 2021
#> 25        4 2021
#> 26        4 2021
#> 27        4 2021
#> 28        4 2021
#> 29        4 2021
#> 30        4 2021
#> 31        4 2021
#> 32        4 2021
#> 33        4 2021
#> 34        4 2021
#> 35        4 2021
#> 36        4 2021
#> 37        4 2021
#> 38        4 2021
#> 39        4 2021
#> 40        4 2021
#> 41        4 2021
#> 42        4 2021
#> 43        4 2021
#> 44        4 2021
#> 45        4 2021
#> 46        4 2021
#> 47        4 2021
#> 48        4 2021
#> 49        4 2021
#> 50        4 2021
#> 51        4 2021
#> 52        4 2021
#> 53        4 2021
#> 54        4 2021
#> 55        4 2021
#> 56        4 2021
#> 57        4 2021
#> 58        4 2021
#> 59        4 2021
#> 60        4 2021
#> 61        4 2021
#> 62        4 2021
#> 63        4 2021
#> 64        4 2021
#> 65        4 2021
#> 66        4 2021
#> 67        4 2021
#> 68        4 2021
#> 69        4 2021
#> 70        4 2021
#> 71        4 2021
#> 72        4 2021
#> 73        4 2021
#> 74        4 2021
# }
# \donttest{
try(kp_hca())
#>                       team conf hca hca_rk   pf pf_rk  pts pts_rk  nst nst_rk
#> 1            West Virginia  B12 4.6      1 -5.7     1 11.7      2 -1.9     13
#> 2                     Utah  B12 4.5      2 -3.1    73 13.3      1 -1.4     53
#> 3               Texas Tech  B12 4.3      3 -5.6     2  7.7     78 -1.8     20
#> 4              Wake Forest  ACC 4.2      4 -5.2     4  9.7     16 -1.3     69
#> 5                  Bradley  MVC 4.1      5 -4.9     8  9.9     12 -1.4     55
#> 6                      TCU  B12 4.1      6 -5.6     3  8.1     59 -2.1      5
#> 7                 Utah St.  P12 4.1      7 -3.7    37  9.4     20 -0.8    156
#> 8             Oklahoma St.  B12 4.0      8 -4.8     9  9.8     13 -1.9     12
#> 9                   Nevada  MWC 4.0      9 -4.2    20  8.3     52 -1.2     83
#> 10                     BYU  B12 4.0     10 -3.6    42  9.6     17 -0.8    182
#> 11                Colorado  B12 4.0     11 -2.8    94 10.8      3 -0.2    295
#> 12             Saint Louis  A10 4.0     12 -5.1     5  8.8     32 -1.0    117
#> 13              Cincinnati  B12 4.0     13 -5.0     7  8.4     46 -1.1     98
#> 14              New Mexico  MWC 4.0     14 -3.4    54  8.6     37 -0.8    150
#> 15                Oklahoma  SEC 3.9     15 -4.2    18 10.2      7 -1.1     86
#> 16                 Rutgers  B10 3.9     16 -5.0     6  8.4     48 -1.5     40
#> 17              Evansville  MVC 3.8     17 -4.7    10  7.2     94 -1.4     47
#> 18                Iowa St.  B12 3.8     18 -3.6    40 10.4      4 -1.6     33
#> 19          North Carolina  ACC 3.8     19 -4.0    21  8.6     41 -1.8     17
#> 20            Illinois St.  MVC 3.8     20 -3.5    45  9.9     11 -1.9     10
#> 21         St. Bonaventure  A10 3.7     21 -3.9    29  7.9     70 -0.8    161
#> 22                  Kansas  B12 3.7     22 -4.0    21  9.0     30 -0.9    130
#> 23        Middle Tennessee CUSA 3.7     23 -3.8    30 10.0     10 -0.7    204
#> 24            Colorado St.  P12 3.7     24 -2.7   103  8.0     63 -0.4    268
#> 25              Kansas St.  B12 3.7     25 -4.3    14  6.6    122 -2.0      8
#> 26                  Auburn  SEC 3.7     26 -3.0    77  8.8     34 -1.3     66
#> 27         Mississippi St.  SEC 3.6     27 -3.7    37  9.3     24 -0.1    326
#> 28                  Baylor  B12 3.6     28 -4.6    11  6.4    132 -1.2     77
#> 29                  Xavier   BE 3.6     29 -4.2    16  6.2    142 -2.5      2
#> 30                Arkansas  SEC 3.6     30 -4.4    13  8.0     63  0.2    352
#> 31                 Wyoming  MWC 3.6     31 -2.3   151  5.0    220 -1.5     37
#> 32               Tennessee  SEC 3.6     32 -2.4   137  8.9     31 -2.8      1
#> 33          Nebraska Omaha  Sum 3.6     33 -3.2    65  8.3     52 -1.5     42
#> 34               Marquette   BE 3.6     34 -4.0    23  8.1     59 -0.9    143
#> 35             Connecticut   BE 3.5     35 -4.2    19  6.5    126 -1.1    102
#> 36                Kentucky  SEC 3.5     36 -3.5    45  7.8     75 -1.2     72
#> 37                 Alabama  SEC 3.5     37 -3.5    51  9.3     25 -0.5    257
#> 38                   Tulsa Amer 3.5     38 -2.8    97  9.7     15 -1.3     60
#> 39             Utah Valley   BW 3.5     39 -1.2   270 10.3      5 -0.7    196
#> 40          Washington St.  P12 3.5     40 -2.5   124  9.4     21 -0.7    191
#> 41                Virginia  ACC 3.5     41 -3.7    33  7.1    103 -0.8    182
#> 42                 Memphis Amer 3.5     42 -3.4    53  8.0     66 -1.5     40
#> 43           Virginia Tech  ACC 3.5     43 -3.7    34  7.2     94 -1.1    108
#> 44        South Dakota St.  Sum 3.5     44 -2.5   128  9.7     14 -1.2     77
#> 45                 Arizona  B12 3.5     45 -2.7   107  8.3     50 -0.8    176
#> 46             Indiana St.  MVC 3.5     46 -3.7    34  7.6     80 -1.6     33
#> 47            Grand Canyon  MWC 3.5     47 -3.4    54  7.6     81 -0.8    150
#> 48                Maryland  B10 3.4     48 -4.0    26  8.5     43 -0.1    309
#> 49               Charlotte Amer 3.4     49 -3.3    63  7.4     86 -1.0    115
#> 50                    UTEP  MWC 3.4     50 -2.6   109  5.9    158 -1.9     10
#> 51                    UCLA  B10 3.4     51 -2.3   149  9.1     28 -1.4     51
#> 52           Tennessee St.  OVC 3.4     52 -2.8    97  7.5     84 -1.6     26
#> 53              Oregon St.  P12 3.4     53 -3.5    49  8.2     57 -0.9    145
#> 54                  Dayton  A10 3.4     54 -4.5    12  5.2    208 -0.6    226
#> 55          Loyola Chicago  A10 3.4     55 -3.4    60  9.1     29 -0.8    163
#> 56        Western Kentucky CUSA 3.4     56 -3.4    58  5.7    171 -2.5      3
#> 57            George Mason  A10 3.4     57 -4.3    15  5.5    183 -1.8     18
#> 58                Missouri  SEC 3.4     58 -3.8    30  6.7    121 -0.4    270
#> 59                  Denver  WCC 3.4     59 -2.5   130  7.1    103 -0.8    150
#> 60          New Mexico St. CUSA 3.4     60 -3.0    87  6.1    147 -0.7    204
#> 61           San Diego St.  P12 3.4     61 -3.2    69  8.1     61 -0.7    191
#> 62               Boise St.  P12 3.4     62 -3.0    85  6.9    108 -0.9    125
#> 63                  Howard MEAC 3.3     63 -2.5   121  6.9    112 -2.3      4
#> 64            Missouri St. CUSA 3.3     64 -3.5    48  5.8    168 -1.0    117
#> 65                 Clemson  ACC 3.3     65 -4.0    25  5.3    201 -0.4    264
#> 66              Louisville  ACC 3.3     66 -4.2    16  5.8    164 -0.9    125
#> 67                Nebraska  B10 3.3     67 -3.1    75  8.3     52 -1.0    117
#> 68                   Texas  SEC 3.3     68 -3.6    41  6.0    154 -1.1     86
#> 69               Creighton   BE 3.3     69 -2.4   144  8.7     36 -0.4    260
#> 70               Weber St. BSky 3.3     70 -1.5   230  7.3     90 -0.2    295
#> 71                   Drake  MVC 3.3     71 -3.3    61  5.5    183 -1.9     14
#> 72               Villanova   BE 3.3     72 -3.7    34  6.7    119 -1.3     66
#> 73  North Carolina Central MEAC 3.3     73 -1.6   218 10.3      5 -1.6     36
#> 74           Northern Iowa  MVC 3.3     74 -3.8    32  5.2    211 -1.1     98
#> 75                Stanford  ACC 3.3     75 -2.6   112  9.6     19 -0.6    220
#> 76               Milwaukee Horz 3.3     76 -2.8    97  6.7    119 -1.2     72
#> 77                 Georgia  SEC 3.3     77 -2.1   158  8.1     58 -1.3     57
#> 78                     SMU  ACC 3.2     78 -2.6   117  8.5     44 -0.6    210
#> 79            Michigan St.  B10 3.2     79 -2.0   183  9.6     17 -0.6    218
#> 80                Penn St.  B10 3.2     80 -2.8    92  8.0     66 -0.8    156
#> 81                La Salle  A10 3.2     81 -4.0    27  5.5    190 -0.3    287
#> 82                    Iowa  B10 3.2     82 -2.6   114  8.6     38 -0.5    257
#> 83                  Oregon  B10 3.2     83 -2.4   141  8.3     52 -1.1    111
#> 84                     UCF  B12 3.2     84 -2.4   137  8.8     32 -0.7    204
#> 85                     FIU CUSA 3.2     85 -1.8   192 10.0      9 -1.4     55
#> 86             Montana St. BSky 3.2     86 -1.9   186  6.5    130 -0.3    287
#> 87             Arizona St.  B12 3.2     87 -2.2   154  7.3     91 -1.7     23
#> 88             Wichita St. Amer 3.2     88 -2.7   106  4.7    230 -0.9    135
#> 89                 Houston  B12 3.2     89 -2.9    88  8.0     62 -1.1     86
#> 90              N.C. State  ACC 3.2     90 -3.4    54  4.8    223 -2.0      9
#> 91          Boston College  ACC 3.2     91 -3.0    76  6.7    118 -1.1     86
#> 92            Oral Roberts  Sum 3.2     92 -3.2    69  7.1    100 -0.8    168
#> 93                 Indiana  B10 3.2     93 -2.8    90  8.2     56 -0.3    280
#> 94             Cal Baptist   BW 3.2     94 -2.7   107  7.4     86 -1.2     76
#> 95            Tarleton St.  UAC 3.2     95 -1.9   191  8.3     51 -1.2     71
#> 96                    Duke  ACC 3.2     96 -4.0    28  4.7    229 -0.6    220
#> 97                     USC  B10 3.2     97 -2.3   147  7.4     88 -2.1      5
#> 98                Southern SWAC 3.2     98 -2.0   171  8.4     48 -0.5    253
#> 99                Ohio St.  B10 3.2     99 -3.5    47  6.8    115  0.0    337
#> 100             California  ACC 3.1    100 -2.8    97  8.6     38 -0.2    295
#> 101              Air Force  MWC 3.1    101 -2.6   117  1.9    348 -0.5    248
#> 102                   UNLV  MWC 3.1    102 -3.0    78  4.8    224 -0.3    287
#> 103                 Purdue  B10 3.1    103 -2.4   134  7.7     77 -1.1    102
#> 104       Eastern Kentucky  UAC 3.1    104 -2.4   134  7.1     99  0.1    341
#> 105                    UAB Amer 3.1    105 -4.0    23  3.1    307 -0.5    253
#> 106          Massachusetts  MAC 3.1    106 -3.3    61  6.5    126 -0.7    196
#> 107                 DePaul   BE 3.1    107 -3.6    44  3.5    288 -1.1     98
#> 108                Hampton  CAA 3.1    108 -2.6   109  8.5     42  0.0    330
#> 109             St. Thomas  Sum 3.1    109 -1.7   215  9.3     22 -0.8    162
#> 110         Saint Joseph's  A10 3.1    110 -3.0    83  7.2     98 -1.1     94
#> 111       Eastern Michigan  MAC 3.1    111 -3.1    74  5.3    199 -0.9    145
#> 112                   Ohio  MAC 3.1    112 -2.0   179  9.3     23 -0.8    182
#> 113           Kennesaw St. CUSA 3.1    113 -2.7   102  5.9    158 -1.0    117
#> 114           South Dakota  Sum 3.1    114 -2.0   180  8.8     35 -0.3    280
#> 115 Maryland Eastern Shore MEAC 3.1    115 -2.4   137  7.1    101 -1.2     79
#> 116              Wisconsin  B10 3.1    116 -2.8    97  7.2     94 -0.7    191
#> 117             Providence   BE 3.1    117 -3.6    43  4.5    237 -0.8    176
#> 118             Vanderbilt  SEC 3.1    118 -3.5    51  5.2    206 -0.9    135
#> 119         Louisiana Tech   SB 3.1    119 -3.0    79  4.2    253 -1.8     15
#> 120            North Texas Amer 3.1    120 -3.0    85  5.7    172 -0.8    150
#> 121            Norfolk St. MEAC 3.1    121 -1.1   272 10.1      8 -1.3     60
#> 122     North Carolina A&T  CAA 3.1    122 -2.7   105  6.0    152 -1.2     83
#> 123             Valparaiso  MVC 3.1    123 -3.4    58  5.7    172 -0.4    264
#> 124               Miami OH  MAC 3.1    124 -2.2   154  6.5    129 -0.9    130
#> 125        Sam Houston St. CUSA 3.1    125 -2.4   144  6.3    138 -1.4     45
#> 126                  Lamar Slnd 3.0    126 -2.4   141  6.5    130 -0.9    135
#> 127         William & Mary  CAA 3.0    127 -2.8    95  5.7    175 -0.6    230
#> 128               Marshall   SB 3.0    128 -1.8   195  7.8     74 -1.3     60
#> 129          Southern Utah BSky 3.0    129 -1.2   266  5.6    176 -0.5    234
#> 130              Texas A&M  SEC 3.0    130 -3.2    69  3.9    270 -2.1      5
#> 131           Delaware St. MEAC 3.0    131 -2.5   125  6.4    136 -0.8    176
#> 132      Northern Kentucky Horz 3.0    132 -1.8   192  5.3    196 -1.8     15
#> 133    Cal St. Bakersfield   BW 3.0    133 -2.1   165  7.4     85 -1.0    112
#> 134               Syracuse  ACC 3.0    134 -3.0    79  5.5    190  0.0    327
#> 135             Notre Dame  ACC 3.0    135 -2.6   120  5.6    180 -0.6    210
#> 136             St. John's   BE 3.0    136 -2.6   112  6.0    155 -0.8    156
#> 137                    LSU  SEC 3.0    137 -3.5    49  5.0    214 -0.2    300
#> 138              Minnesota  B10 3.0    138 -3.0    79  5.2    204 -0.9    130
#> 139            Alabama A&M SWAC 3.0    139 -1.5   230  7.5     83 -1.4     51
#> 140       Western Carolina   SC 3.0    140 -2.0   171  5.3    198 -1.2     79
#> 141          Southern Miss   SB 3.0    141 -2.4   144  7.3     91 -0.2    305
#> 142       Coastal Carolina   SB 2.9    142 -2.8    92  6.3    138 -0.9    145
#> 143      George Washington  A10 2.9    143 -3.2    69  5.2    204 -1.6     33
#> 144           San Jose St.  MWC 2.9    144 -2.4   141  6.1    144 -0.8    176
#> 145          Cleveland St. Horz 2.9    145 -3.0    79  5.6    178  0.0    327
#> 146                 Drexel  CAA 2.9    146 -2.1   167  7.8     72 -0.7    204
#> 147     Southeast Missouri  OVC 2.9    147 -2.5   121  6.0    155 -0.7    201
#> 148           Rhode Island  A10 2.9    148 -3.0    83  4.5    238 -0.4    260
#> 149               Richmond  A10 2.9    149 -2.7   103  5.5    186 -1.3     69
#> 150       Florida Atlantic Amer 2.9    150 -1.1   276  9.1     26 -0.9    135
#> 151            Georgia St.   SB 2.9    151 -1.8   202  7.3     91 -0.5    234
#> 152            Little Rock  UAC 2.9    152 -3.2    67  5.1    212 -0.7    204
#> 153                Florida  SEC 2.9    153 -1.4   250  8.4     47 -1.0    121
#> 154         Youngstown St. Horz 2.9    154 -2.1   159  5.4    193 -0.7    191
#> 155                   Iona   MC 2.9    155 -1.8   195  6.7    117 -0.6    220
#> 156         South Carolina  SEC 2.9    156 -2.0   171  6.2    141 -1.8     18
#> 157               Michigan  B10 2.9    157 -1.9   186  6.3    140 -1.2     79
#> 158                Seattle  WCC 2.9    158 -2.1   159  8.0     63  0.1    346
#> 159             Seton Hall   BE 2.9    159 -3.7    37  2.8    321 -1.5     42
#> 160               Illinois  B10 2.9    160 -3.2    65  3.9    270 -0.9    125
#> 161                    VCU  A10 2.9    161 -2.5   130  7.2     94 -0.2    298
#> 162                Gonzaga  P12 2.9    162 -1.8   204  5.8    166 -1.1     94
#> 163             Washington  B10 2.9    163 -2.2   153  7.0    105 -0.5    237
#> 164          East Carolina Amer 2.9    164 -2.0   178  4.9    222 -1.3     57
#> 165         Tennessee Tech   SC 2.9    165 -1.6   220  7.3     89 -0.2    300
#> 166           Old Dominion   SB 2.9    166 -2.1   166  6.8    113 -0.8    163
#> 167             Pittsburgh  ACC 2.9    167 -2.6   114  4.4    241 -0.2    305
#> 168           Portland St. BSky 2.9    168 -0.7   319  9.1     26 -0.8    182
#> 169      Abilene Christian  UAC 2.9    169 -0.1   349  7.6     82 -1.6     28
#> 170                 Butler   BE 2.9    170 -2.9    89  3.7    280 -0.5    237
#> 171      Southern Illinois  MVC 2.8    171 -1.7   213  6.1    148 -1.6     24
#> 172          James Madison   SB 2.8    172 -1.6   228  5.5    186 -1.3     60
#> 173     South Carolina St. MEAC 2.8    173 -2.5   125  3.9    269 -0.8    168
#> 174               Monmouth  CAA 2.8    174 -1.8   195  6.0    150 -1.6     30
#> 175           Jacksonville ASun 2.8    175 -2.6   117  4.5    239 -0.6    230
#> 176            Florida St.  ACC 2.8    176 -1.9   185  5.0    217 -1.6     30
#> 177             Morgan St. MEAC 2.8    177 -2.0   180  6.0    155 -0.6    215
#> 178              Utah Tech BSky 2.8    178 -0.8   304  7.9     69 -0.1    320
#> 179       Western Illinois  OVC 2.8    179 -2.5   125  5.7    170 -0.1    313
#> 180          North Alabama  UAC 2.8    180 -1.3   258  5.9    162 -0.9    142
#> 181             Murray St.  MVC 2.8    181 -1.5   235  6.9    108 -0.6    215
#> 182      Stephen F. Austin Slnd 2.8    182 -1.2   266  5.2    207 -1.1     86
#> 183               Cal Poly   BW 2.8    183 -1.7   216  7.0    105 -0.9    135
#> 184                Montana BSky 2.8    184 -0.7   319  6.6    122 -0.1    318
#> 185                 Bryant   AE 2.8    185 -1.4   245  7.9     68  0.1    348
#> 186             Wright St. Horz 2.8    186 -2.6   109  5.3    196 -0.5    241
#> 187                Samford   SC 2.8    187 -0.8   317  7.8     75 -1.2     79
#> 188      Northern Colorado BSky 2.8    188 -1.3   259  3.5    292  0.0    337
#> 189            Austin Peay  UAC 2.8    189 -0.9   300  8.6     38 -0.1    313
#> 190       Northern Arizona BSky 2.8    190 -0.3   344  3.4    298 -0.5    234
#> 191             Alcorn St. SWAC 2.8    191 -2.1   167  4.2    255 -0.9    135
#> 192                   SIUE  OVC 2.7    192 -1.7   213  6.0    152 -0.3    287
#> 193               Duquesne  A10 2.7    193 -2.6   114  2.4    332 -1.6     24
#> 194          Detroit Mercy Horz 2.7    194 -2.3   149  5.5    190 -0.3    284
#> 195                Liberty CUSA 2.7    195 -2.2   154  4.0    266 -1.1    105
#> 196     Florida Gulf Coast ASun 2.7    196 -1.6   225  6.5    125 -0.5    237
#> 197               Ball St.  MAC 2.7    197 -2.8    91  3.3    302 -0.8    168
#> 198             High Point BSth 2.7    198 -0.8   312  7.7     79 -0.5    253
#> 199           West Georgia  UAC 2.7    199 -1.3   261  5.5    182 -0.5    256
#> 200             Fresno St.  P12 2.7    200 -1.6   225  5.7    174 -1.2     83
#> 201            Kansas City  Sum 2.7    201 -1.5   238  4.7    230 -1.1     98
#> 202                 Queens ASun 2.7    202 -2.1   163  3.8    275 -0.4    263
#> 203              Green Bay Horz 2.7    203 -3.2    68  1.0    360 -0.9    130
#> 204                Belmont  MVC 2.7    204 -1.1   280  7.1    101 -1.2     72
#> 205          Robert Morris Horz 2.7    205 -0.8   312  5.6    181 -0.3    287
#> 206         Texas Southern SWAC 2.7    206 -1.5   238  6.8    116  0.0    330
#> 207           Georgia Tech  ACC 2.7    207 -3.4    54  2.4    333 -0.8    168
#> 208          South Florida Amer 2.7    208 -2.0   171  3.6    282 -1.5     39
#> 209          Bowling Green  MAC 2.7    209 -1.4   245  4.4    240 -1.6     30
#> 210                 Towson  CAA 2.7    210 -2.2   157  4.3    247 -0.8    156
#> 211           Morehead St.  OVC 2.7    211 -1.6   220  3.5    286 -0.1    309
#> 212                McNeese Slnd 2.7    212 -2.0   169  4.0    262 -1.4     53
#> 213                   Troy   SB 2.7    213 -0.8   315  6.9    111 -0.1    313
#> 214               Miami FL  ACC 2.7    214 -2.5   121  3.4    295 -1.0    112
#> 215       Central Arkansas  UAC 2.7    215 -0.6   331  5.4    193 -1.4     46
#> 216              Idaho St. BSky 2.7    216  0.2   357  5.9    161  0.3    356
#> 217                 Temple Amer 2.7    217 -1.7   210  5.3    201 -0.9    130
#> 218       Central Michigan  MAC 2.6    218 -0.9   298  6.3    137 -1.1     86
#> 219            Florida A&M SWAC 2.6    219 -1.3   259  6.5    126 -0.3    287
#> 220           Northwestern  B10 2.6    220 -2.0   171  5.0    219 -0.3    284
#> 221       Loyola Marymount  WCC 2.6    221 -1.5   233  6.4    132 -0.3    275
#> 222            Mississippi  SEC 2.6    222 -1.6   220  4.8    227 -0.7    199
#> 223                 Mercer   SC 2.6    223 -1.5   235  5.0    220 -1.1     94
#> 224             Georgetown   BE 2.6    224 -3.3    64  2.2    337 -0.8    182
#> 225                 Furman   SC 2.6    225 -2.5   130  3.2    303 -0.5    248
#> 226               Campbell  CAA 2.6    226 -1.6   220  5.9    158 -0.4    270
#> 227                   UTSA Amer 2.6    227 -0.7   324  8.5     45 -0.8    150
#> 228               Nicholls Slnd 2.6    228 -2.1   159  4.0    266 -1.8     20
#> 229            The Citadel   SC 2.6    229 -2.1   164  4.2    258 -1.0    121
#> 230             Binghamton   AE 2.6    230 -1.8   207  5.2    208 -0.1    319
#> 231          Saint Peter's   MC 2.6    231 -1.7   209  6.1    145 -0.1    317
#> 232                Vermont   AE 2.6    232 -1.8   207  5.0    217 -0.9    125
#> 233                  Maine   AE 2.6    233 -2.5   128  4.2    251 -0.6    230
#> 234            Chicago St.  NEC 2.6    234 -2.0   169  3.1    307 -1.3     60
#> 235             Charleston  CAA 2.6    235 -2.2   152  4.2    251 -0.7    201
#> 236       Illinois Chicago  MVC 2.6    236 -2.4   133  2.1    340 -1.3     57
#> 237         UNC Wilmington  CAA 2.6    237 -2.4   137  3.5    288 -0.8    156
#> 238                  Siena   MC 2.6    238 -0.8   317  6.9    108 -0.5    257
#> 239        Appalachian St.   SB 2.6    239 -1.2   262  2.5    331 -0.8    182
#> 240           North Dakota  Sum 2.6    240 -2.1   159  4.2    257 -0.8    168
#> 241       Western Michigan  MAC 2.6    241 -1.4   252  5.5    188 -1.3     60
#> 242          UNC Asheville BSth 2.6    242 -1.0   286  4.8    224 -0.8    168
#> 243         Sacramento St.   BW 2.6    243 -0.2   347  7.0    107 -0.6    210
#> 244 Southeastern Louisiana Slnd 2.6    244 -1.9   188  3.0    315 -1.8     20
#> 245                 Hawaii  MWC 2.6    245 -1.8   199  5.0    215  0.0    330
#> 246          New Hampshire   AE 2.6    246 -1.1   280  5.8    165 -0.8    176
#> 247 Texas A&M Corpus Chris Slnd 2.6    247 -1.6   229  3.8    278 -1.2     72
#> 248           UC Riverside   BW 2.6    248 -1.0   286  5.6    176 -0.2    300
#> 249           Saint Mary's  WCC 2.6    249 -1.4   252  6.8    113 -0.1    321
#> 250                  Idaho BSky 2.6    250 -1.4   248  2.0    345 -0.9    135
#> 251           Arkansas St.   SB 2.6    251 -1.2   262  4.7    228 -0.6    226
#> 252               Kent St.  MAC 2.6    252 -1.4   250  3.6    281 -1.1     86
#> 253                   CSUN   BW 2.6    253 -1.4   243  4.4    242  0.1    348
#> 254            Jackson St. SWAC 2.5    254 -1.2   268  5.4    193  0.2    352
#> 255               Davidson  A10 2.5    255 -2.0   171  3.3    299 -0.5    237
#> 256       Louisiana Monroe   SB 2.5    256 -0.4   338  7.8     72 -0.6    220
#> 257                IU Indy Horz 2.5    257 -1.8   192  3.8    274 -1.1     86
#> 258      Purdue Fort Wayne Horz 2.5    258 -2.0   180  3.0    312 -0.5    241
#> 259           UMass Lowell   AE 2.5    259 -1.0   284  6.0    151 -0.5    241
#> 260       North Dakota St.  Sum 2.5    260 -2.8    95  2.0    345 -0.6    220
#> 261          Grambling St. SWAC 2.5    261 -1.6   225  2.4    334 -0.6    230
#> 262             Bellarmine ASun 2.5    262 -1.5   232  3.9    272 -0.5    252
#> 263         Incarnate Word Slnd 2.5    263 -0.9   291  4.6    236 -1.4     48
#> 264     East Tennessee St.   SC 2.5    264 -1.5   238  2.5    330 -0.9    145
#> 265       Northwestern St. Slnd 2.5    265 -0.9   298  6.0    149 -1.5     37
#> 266       Southern Indiana  OVC 2.5    266 -1.7   212  2.8    325 -1.1    110
#> 267                   Penn  Ivy 2.5    267 -2.0   183  3.2    306 -1.1    105
#> 268                 Marist   MC 2.5    268 -1.3   255  3.4    297 -1.1    102
#> 269       Prairie View A&M SWAC 2.5    269 -0.9   294  4.1    259 -0.8    182
#> 270            USC Upstate BSth 2.5    270 -1.5   235  4.0    268  0.0    327
#> 271       Georgia Southern   SB 2.5    271 -1.1   274  6.4    135 -0.1    321
#> 272               Lipscomb ASun 2.5    272 -1.4   243  5.6    178  0.1    340
#> 273              Louisiana   SB 2.5    273 -1.9   188  4.4    246 -0.2    308
#> 274          San Francisco  WCC 2.5    274 -2.3   148  2.1    343 -0.3    275
#> 275                 Tulane Amer 2.4    275 -1.5   238  4.7    230 -0.7    190
#> 276              UC Irvine   BW 2.4    276 -1.1   276  3.5    287 -1.6     26
#> 277      Houston Christian Slnd 2.4    277 -0.9   291  5.3    199 -0.3    294
#> 278             Mercyhurst  NEC 2.4    278 -0.9   303  5.5    189  0.0    333
#> 279             Lindenwood  OVC 2.4    279 -0.9   297  4.4    245 -1.4     50
#> 280 Mississippi Valley St. SWAC 2.4    280 -1.2   268  4.2    255 -0.9    123
#> 281                   Yale  Ivy 2.4    281 -0.4   333  5.9    163 -0.8    163
#> 282          North Florida ASun 2.4    283 -1.4   245  4.4    242 -0.3    280
#> 283               Bucknell   PL 2.4    284 -1.1   279  4.3    248 -0.6    210
#> 284               Winthrop BSth 2.4    285 -1.8   199  3.0    317 -0.6    226
#> 285           UT Arlington  UAC 2.4    286 -0.7   323  4.0    263 -1.4     48
#> 286                    LIU  NEC 2.4    287 -0.3   344  6.1    145 -0.1    321
#> 287            Alabama St. SWAC 2.4    288 -1.5   233  3.9    273 -0.1    321
#> 288              Dartmouth  Ivy 2.4    289 -0.2   348  6.6    124 -0.5    241
#> 289            Stony Brook  CAA 2.4    290 -0.6   326  5.8    166 -0.6    226
#> 290       Tennessee Martin  OVC 2.4    291 -1.7   210  2.1    340 -0.6    218
#> 291              Texas St.  P12 2.4    292 -0.6   326  5.5    183 -0.3    275
#> 292                Buffalo  MAC 2.4    293 -1.8   199  1.6    355 -1.3     68
#> 293               Longwood BSth 2.4    294 -1.1   280  4.1    260 -0.3    287
#> 294           Presbyterian BSth 2.4    295 -0.8   309  5.0    215 -0.2    300
#> 295             Quinnipiac   MC 2.4    296 -1.8   204  3.5    288 -0.7    204
#> 296        Bethune Cookman SWAC 2.4    297 -1.6   219  4.3    250 -0.4    268
#> 297              Fairfield   MC 2.4    298 -1.2   262  4.6    233 -0.4    264
#> 298                Pacific  WCC 2.4    299 -1.2   262  3.3    300 -0.2    299
#> 299                   Elon  CAA 2.4    300 -1.1   276  1.9    348 -0.8    182
#> 300      Boston University   PL 2.4    301 -1.4   252  2.8    321 -1.0    112
#> 301       UC Santa Barbara   BW 2.3    302 -2.0   171  3.8    276  0.7    362
#> 302            Santa Clara  WCC 2.3    303 -2.4   134  2.1    340  0.1    343
#> 303       Jacksonville St. CUSA 2.3    304 -1.7   216  2.1    338 -0.8    150
#> 304      Northern Illinois Horz 2.3    305 -1.8   204  1.1    359 -1.6     28
#> 305          South Alabama   SB 2.3    306 -0.7   325  6.2    143  0.7    363
#> 306   UT Rio Grande Valley Slnd 2.3    307 -1.5   238  4.0    265 -0.1    309
#> 307                Cornell  Ivy 2.3    308  0.8   364  7.8     71 -0.4    267
#> 308                  Akron  MAC 2.3    309 -1.3   255  2.8    324 -0.5    248
#> 309                 Toledo  MAC 2.3    310 -0.8   307  3.1    309 -1.5     42
#> 310               Le Moyne  NEC 2.3    311 -0.8   306  5.2    210  0.2    355
#> 311                Oakland Horz 2.3    312 -1.8   202  1.3    358 -0.1    309
#> 312        LSU New Orleans Slnd 2.3    313 -1.9   188  1.9    350 -0.8    176
#> 313               Canisius   MC 2.3    314 -0.4   335  4.6    234 -0.9    143
#> 314           Northeastern  CAA 2.3    315 -0.8   309  4.6    234 -0.8    168
#> 315       Eastern Illinois  OVC 2.3    316 -0.9   294  2.9    320 -1.1    108
#> 316            Chattanooga   SC 2.3    317 -1.6   224  0.6    362 -1.1     94
#> 317           Sacred Heart   MC 2.3    318 -0.3   339  5.1    212 -0.3    280
#> 318                   Rice Amer 2.3    319 -1.3   257  3.5    294 -0.7    199
#> 319         UNC Greensboro   SC 2.2    320 -0.4   336  2.9    318 -1.0    115
#> 320                Fordham  A10 2.2    321 -1.4   248  2.0    344 -0.4    270
#> 321                  Rider   MC 2.2    322 -0.9   300  3.0    316 -0.8    163
#> 322              Stonehill  NEC 2.2    323 -1.0   283  3.8    277  0.1    347
#> 323                Niagara   MC 2.2    324  0.0   352  5.3    203 -0.6    220
#> 324                    VMI   SC 2.2    325 -0.6   326  3.1    309 -0.8    163
#> 325              Princeton  Ivy 2.2    326  0.1   353  5.8    168 -0.9    145
#> 326               Delaware CUSA 2.2    327 -0.4   333  3.0    311 -0.7    191
#> 327                Wofford   SC 2.2    328 -1.0   286  1.8    352 -0.4    260
#> 328                   NJIT   AE 2.1    329 -1.8   195  1.4    357 -0.8    168
#> 329                Radford BSth 2.1    330 -1.0   290  1.0    361 -0.6    210
#> 330             Holy Cross   PL 2.1    331 -0.3   339  3.8    278 -0.3    284
#> 331              New Haven  NEC 2.1    332 -0.3   341  4.4    244  0.0    336
#> 332      Cal St. Fullerton   BW 2.1    333 -0.3   342  4.2    254 -0.5    241
#> 333                   Navy   PL 2.1    334 -1.0   289  2.7    327 -0.9    123
#> 334                Colgate   PL 2.1    335  0.1   355  4.8    226 -0.3    275
#> 335         Long Beach St.   BW 2.1    336 -0.9   291  3.2    304  0.2    350
#> 336             Coppin St. MEAC 2.1    337 -1.0   284  2.8    321  0.1    342
#> 337                Stetson ASun 2.1    338 -0.8   309  3.6    284  0.0    334
#> 338                 Lehigh   PL 2.1    339 -0.9   300  3.6    285  0.1    345
#> 339     Eastern Washington BSky 2.1    340 -0.3   343  1.7    354 -0.5    248
#> 340       Mount St. Mary's   MC 2.1    341 -0.7   319  3.2    304 -0.5    241
#> 341         East Texas A&M Slnd 2.1    342 -0.8   314  2.7    328  0.0    335
#> 342    Charleston Southern BSth 2.1    343 -0.6   326  4.3    248  0.5    361
#> 343             Pepperdine  WCC 2.1    344 -0.4   336  4.1    261  0.3    356
#> 344                Hofstra  CAA 2.0    345 -0.8   308  2.6    329 -0.9    125
#> 345               American   PL 2.0    346 -0.3   346  1.9    351 -0.6    215
#> 346           Gardner Webb BSth 2.0    347 -0.6   330  3.5    293  0.1    343
#> 347              San Diego  WCC 2.0    348 -0.7   319  3.3    301  0.5    360
#> 348              Merrimack   MC 2.0    349 -1.1   273  0.3    363 -0.5    247
#> 349    Arkansas Pine Bluff SWAC 2.0    350 -0.5   332  2.1    339 -1.1    105
#> 350                Harvard  Ivy 2.0    351  0.1   353  3.5    288 -0.3    274
#> 351                 Albany   AE 2.0    352 -1.1   274  1.4    356 -0.7    201
#> 352               Columbia  Ivy 1.9    353 -0.1   351  3.6    282  0.3    359
#> 353               Portland  WCC 1.9    354  1.0   365  6.4    134  0.3    358
#> 354           UC San Diego   BW 1.9    355  0.3   360  2.7    326 -0.4    273
#> 355                   Army   PL 1.8    356  0.2   356  4.0    263  0.2    352
#> 356              Manhattan   MC 1.8    357  0.4   361  3.4    296 -0.3    275
#> 357              Loyola MD   PL 1.8    358 -0.1   349  2.2    336  0.2    350
#> 358               UC Davis  MWC 1.8    359 -0.8   305  2.4    335  1.1    365
#> 359              Lafayette   PL 1.8    360 -0.9   294  0.3    364 -0.1    313
#> 360                 Wagner  NEC 1.8    361  0.6   363  3.0    312  0.0    337
#> 361                  Brown  Ivy 1.8    362  0.3   358  1.7    353 -0.7    196
#> 362    Fairleigh Dickinson  NEC 1.7    363  0.3   359  3.0    312  0.8    364
#> 363    Central Connecticut  NEC 1.7    364  0.4   361  2.0    347 -0.2    300
#> 364                   UMBC   AE 1.7    365 -0.8   315 -0.1    365 -0.1    321
#>      blk blk_rk elev elev_rk
#> 1    1.3     92 1000      60
#> 2    2.0     13 4800      10
#> 3    1.2    110 3200      20
#> 4    1.5     61 1000      60
#> 5    1.9     20  500     175
#> 6    0.9    192  600     142
#> 7    1.6     51 4800      10
#> 8    0.6    273  900      71
#> 9    0.9    197 4600      15
#> 10   1.2    122 4700      14
#> 11   1.8     27 5400       5
#> 12   1.6     51  500     175
#> 13   1.6     51  800      95
#> 14   1.6     56 5100       7
#> 15   1.1    151 1100      50
#> 16   1.5     61    0     320
#> 17   1.8     33  400     196
#> 18   0.8    241  900      71
#> 19   1.5     64  400     196
#> 20   0.8    229  800      95
#> 21   1.9     21 1400      39
#> 22   1.0    164  900      71
#> 23   1.1    155  600     142
#> 24   1.8     33 5000       8
#> 25   1.0    170 1100      50
#> 26   2.5      3  700     118
#> 27   2.0     10  400     196
#> 28   1.3    106  400     196
#> 29   0.7    264  600     142
#> 30   1.0    181 1300      42
#> 31   1.6     56 7200       1
#> 32   1.4     81  900      71
#> 33   1.4     81 1000      60
#> 34   0.8    216  600     142
#> 35   1.5     66  600     142
#> 36   1.2    110 1000      60
#> 37   1.5     60  200     244
#> 38   1.3     97  800      95
#> 39   1.6     46 4600      15
#> 40   1.1    140 2600      25
#> 41   2.0     14  500     175
#> 42   1.3     92  200     244
#> 43   0.2    336 2200      29
#> 44   0.9    201 1600      38
#> 45   1.4     77 2400      28
#> 46   0.5    308  500     175
#> 47   1.3    104 1100      50
#> 48   0.8    241  100     272
#> 49   1.6     46  700     118
#> 50   0.9    207 3800      19
#> 51   1.9     16  400     196
#> 52   2.0     10  500     175
#> 53   1.0    181  200     244
#> 54   1.3     97  700     118
#> 55   0.3    330  600     142
#> 56   1.3     94  500     175
#> 57   0.4    314  400     196
#> 58   1.4     68  700     118
#> 59   0.0    359 5300       6
#> 60   0.8    216 4000      18
#> 61   1.3    104  400     196
#> 62   0.7    268 2700      23
#> 63   1.9     26  100     272
#> 64   1.1    130 1300      42
#> 65   1.5     64  700     118
#> 66   0.3    322  400     196
#> 67   0.2    340 1100      50
#> 68   1.1    147  500     175
#> 69   1.7     40 1000      60
#> 70   1.7     39 4800      10
#> 71   1.0    176  900      71
#> 72   0.2    344  400     196
#> 73   1.1    155  400     196
#> 74   0.9    195  900      71
#> 75   0.7    258  100     272
#> 76   1.7     36  600     142
#> 77   1.6     51  700     118
#> 78   1.1    136  600     142
#> 79   1.3     97  800      95
#> 80   0.5    302 1200      45
#> 81   1.4     81  200     244
#> 82   1.0    176  700     118
#> 83   1.4     89  400     196
#> 84   1.4     89  100     272
#> 85   0.9    201    0     320
#> 86   0.9    197 4900       9
#> 87   1.0    170 1200      45
#> 88   2.6      2 1400      39
#> 89   0.4    321    0     320
#> 90   0.8    219  400     196
#> 91   0.9    201  200     244
#> 92   0.3    322  600     142
#> 93   0.5    302  800      95
#> 94   0.6    292  800      95
#> 95   1.0    163 1300      42
#> 96   1.1    155  400     196
#> 97   0.7    258  200     244
#> 98   2.1      8  100     272
#> 99   0.5    308  700     118
#> 100  0.7    268  200     244
#> 101  0.9    192 7000       2
#> 102  1.6     45 2000      32
#> 103  0.8    236  600     142
#> 104  2.0     14 1000      60
#> 105  1.8     31  600     142
#> 106  0.6    287  200     244
#> 107  1.7     42  600     142
#> 108  1.0    170    0     320
#> 109  0.8    225  900      71
#> 110  0.1    346  300     222
#> 111  1.2    120  800      95
#> 112  0.5    302  600     142
#> 113  1.1    151 1100      50
#> 114  0.9    207 1200      45
#> 115  1.4     81    0     320
#> 116  0.4    317  900      71
#> 117  1.4     68    0     320
#> 118  0.7    264  500     175
#> 119  1.6     56  300     222
#> 120  1.1    147  700     118
#> 121  1.1    130    0     320
#> 122  0.9    201  800      95
#> 123  0.5    308  800      95
#> 124  1.5     66  900      71
#> 125  1.2    126  400     196
#> 126  1.7     36    0     320
#> 127  1.8     29  100     272
#> 128  1.0    187  500     175
#> 129  0.6    273 5800       4
#> 130  0.5    297  400     196
#> 131  1.5     61    0     320
#> 132  1.9     19  800      95
#> 133  0.9    213  400     196
#> 134  1.4     74  600     142
#> 135  1.4     68  700     118
#> 136  1.3     97  100     272
#> 137  1.0    181    0     320
#> 138  0.3    322  800      95
#> 139  1.0    187  700     118
#> 140  0.9    213 2100      30
#> 141  1.0    176  200     244
#> 142  0.4    319    0     320
#> 143 -0.3    364  100     272
#> 144  1.3    106  100     272
#> 145  0.7    248  700     118
#> 146  0.6    281  100     272
#> 147  0.8    219  500     175
#> 148  1.6     55  100     272
#> 149  0.5    302  200     244
#> 150  1.2    122    0     320
#> 151  0.9    197 1000      60
#> 152  0.2    337  300     222
#> 153  1.0    181  200     244
#> 154  1.4     68 1000      60
#> 155  1.9     21    0     320
#> 156  0.6    285  200     244
#> 157  0.8    226  900      71
#> 158  0.7    252  300     222
#> 159  0.4    314    0     320
#> 160  0.3    330  800      95
#> 161  0.3    322  200     244
#> 162  0.7    268 1900      33
#> 163  0.7    252  100     272
#> 164  1.9     25  100     272
#> 165  1.0    164 1100      50
#> 166  0.7    252    0     320
#> 167  1.3     94 1100      50
#> 168  1.4     74  200     244
#> 169  1.8     29 1700      35
#> 170  1.2    110  800      95
#> 171  0.8    232  400     196
#> 172  1.1    155 1400      39
#> 173  1.7     36  300     222
#> 174  0.8    216    0     320
#> 175  1.4     74    0     320
#> 176  1.2    126  100     272
#> 177  1.2    122  200     244
#> 178  0.5    312 2700      23
#> 179  0.5    302  600     142
#> 180  1.9     24  600     142
#> 181  1.0    164  500     175
#> 182  2.5      4  300     222
#> 183  0.4    317  300     222
#> 184  1.2    122 3200      20
#> 185  1.1    142  400     196
#> 186 -0.2    363  900      71
#> 187  1.0    170  700     118
#> 188  1.4     81 4800      10
#> 189  1.2    126  500     175
#> 190  1.3    106 6900       3
#> 191  1.6     44  300     222
#> 192  1.3     97  500     175
#> 193  0.8    229  800      95
#> 194  0.5    297  600     142
#> 195  0.8    236  900      71
#> 196  1.1    130    0     320
#> 197  0.3    330  900      71
#> 198  1.1    151  900      71
#> 199  1.7     43 1000      60
#> 200  0.8    219  300     222
#> 201  1.4     77  900      71
#> 202  1.6     49  600     142
#> 203  1.2    117  600     142
#> 204  0.3    328  600     142
#> 205  2.4      5 1200      45
#> 206  1.3     97    0     320
#> 207 -0.3    365  900      71
#> 208  1.1    130  100     272
#> 209  1.2    126  700     118
#> 210  0.8    241  400     196
#> 211  2.6      1  800      95
#> 212  0.9    207    0     320
#> 213  1.9     21  500     175
#> 214  0.7    248    0     320
#> 215  2.3      7  300     222
#> 216  1.9     16 4600      15
#> 217  0.8    219  100     272
#> 218  0.9    213  800      95
#> 219  1.3    106  100     272
#> 220  0.6    273  600     142
#> 221  0.8    219  100     272
#> 222  1.2    117  500     175
#> 223  0.9    207  500     175
#> 224  0.3    322    0     320
#> 225  0.6    287 1000      60
#> 226  0.8    232  200     244
#> 227  0.1    349  300     222
#> 228  0.1    350    0     320
#> 229  0.8    241    0     320
#> 230  0.8    219  900      71
#> 231  0.6    273  100     272
#> 232  0.5    308  400     196
#> 233  0.2    337  100     272
#> 234  0.8    236  600     142
#> 235  0.6    281    0     320
#> 236  0.8    229  600     142
#> 237  0.6    273    0     320
#> 238  1.4     77  100     272
#> 239  1.4     81 3200      20
#> 240  0.1    352  800      95
#> 241  0.0    356  800      95
#> 242  0.7    248 2100      30
#> 243  2.1      8    0     320
#> 244  1.0    181  100     272
#> 245  1.1    130    0     320
#> 246  1.1    136  100     272
#> 247  1.4     77    0     320
#> 248  1.1    130 1100      50
#> 249  0.1    354  600     142
#> 250  1.4     68 2600      25
#> 251  1.6     46  300     222
#> 252  0.9    192 1200      45
#> 253  1.7     40  900      71
#> 254  1.8     33  300     222
#> 255  0.8    236  800      95
#> 256  0.8    226  100     272
#> 257  0.1    346  700     118
#> 258  1.0    187  800      95
#> 259  1.0    187  100     272
#> 260  0.1    350  900      71
#> 261  2.4      5  300     222
#> 262  1.3     91  500     175
#> 263  0.9    207  700     118
#> 264  1.2    110 1700      35
#> 265  0.1    346  100     272
#> 266  1.2    119  500     175
#> 267  0.7    264    0     320
#> 268  1.6     50  100     272
#> 269  1.9     16  300     222
#> 270  1.2    115  900      71
#> 271  0.5    297  200     244
#> 272  0.3    330  600     142
#> 273  0.6    287    0     320
#> 274  1.1    142  300     222
#> 275  0.5    297    0     320
#> 276  1.1    136  100     272
#> 277  1.3     97  100     272
#> 278  1.1    146  800      95
#> 279  0.7    262  600     142
#> 280  1.0    170  100     272
#> 281  1.2    110  100     272
#> 282  1.0    181    0     320
#> 283  1.0    170  500     175
#> 284  0.6    287  700     118
#> 285  1.1    142  600     142
#> 286  1.8     27    0     320
#> 287  1.0    164  300     222
#> 288  0.9    201  500     175
#> 289  0.9    197  100     272
#> 290  1.4     81  400     196
#> 291  0.9    201  700     118
#> 292  0.8    226  600     142
#> 293  1.3     94  400     196
#> 294  1.0    187  700     118
#> 295  0.1    353  400     196
#> 296  0.2    340    0     320
#> 297  0.6    273    0     320
#> 298  1.8     31    0     320
#> 299  2.0     12  700     118
#> 300  1.1    151    0     320
#> 301  0.6    292  100     272
#> 302  0.6    287  100     272
#> 303  0.6    281  700     118
#> 304  0.3    330  900      71
#> 305  1.1    147  200     244
#> 306  0.4    314  100     272
#> 307  1.1    155  900      71
#> 308  0.6    292 1100      50
#> 309  0.7    252  600     142
#> 310  0.7    263  600     142
#> 311  1.2    115  900      71
#> 312  0.7    258    0     320
#> 313  0.8    232  600     142
#> 314  0.6    292    0     320
#> 315  0.8    241  700     118
#> 316  1.1    136  700     118
#> 317  1.1    155  300     222
#> 318  0.3    330    0     320
#> 319  1.2    120  900      71
#> 320  1.1    142  100     272
#> 321  1.0    176  100     272
#> 322  0.9    212  100     272
#> 323  0.7    252  600     142
#> 324  0.6    273 1000      60
#> 325  0.3    328  100     272
#> 326  1.5     59  100     272
#> 327  1.1    155  800      95
#> 328  0.0    359  100     272
#> 329  0.8    241 1700      35
#> 330  0.8    236  700     118
#> 331  0.9    196  200     244
#> 332  0.6    285  200     244
#> 333  0.2    340    0     320
#> 334  0.5    313 1100      50
#> 335  0.8    241    0     320
#> 336  0.7    268  200     244
#> 337  0.5    302  100     272
#> 338  0.3    327  300     222
#> 339  0.6    281 2500      27
#> 340  0.1    354  500     175
#> 341  0.7    251  600     142
#> 342  0.7    252    0     320
#> 343  0.7    264  300     222
#> 344  0.0    356  100     272
#> 345  1.4     68  400     196
#> 346  0.0    359  800      95
#> 347  0.5    296  200     244
#> 348  1.1    150  200     244
#> 349  0.2    339  200     244
#> 350  1.0    176    0     320
#> 351 -0.2    362  200     244
#> 352  0.8    232  100     272
#> 353  0.7    268  200     244
#> 354  1.0    169  400     196
#> 355  0.0    356  400     196
#> 356  0.5    297  100     272
#> 357  0.6    273  300     222
#> 358  0.2    345  100     272
#> 359  0.2    340  300     222
#> 360  1.0    164  200     244
#> 361  0.7    258  100     272
#> 362  1.1    140    0     320
#> 363  1.1    155  100     272
#> 364  0.4    319  200     244
# }
# \donttest{
try(kp_arenas(year = 2021))
#>      rk                   team conf
#> 1     1               Syracuse  ACC
#> 2     2             Louisville  ACC
#> 3     3         North Carolina  ACC
#> 4     4              Tennessee  SEC
#> 5     5               Kentucky  SEC
#> 6     6             N.C. State  ACC
#> 7     7               Arkansas  SEC
#> 8     8               Ohio St.  B10
#> 9     9                    BYU  WCC
#> 10   10                Memphis Amer
#> 11   11             Bellarmine ASun
#> 12   12         South Carolina  SEC
#> 13   12                   UNLV  MWC
#> 14   14               Maryland  B10
#> 15   15              Marquette   BE
#> 16   16                Indiana  B10
#> 17   17              Creighton   BE
#> 18   18              Wisconsin  B10
#> 19   19                  Texas  B12
#> 20   20                 Kansas  B12
#> 21   21             Fresno St.  MWC
#> 22   22               Illinois  B10
#> 23   23             New Mexico  MWC
#> 24   24               Penn St.  B10
#> 25   25             Texas Tech  B12
#> 26   26               Missouri  SEC
#> 27   27                   Iowa  B10
#> 28   28               Nebraska  B10
#> 29   28                   Utah  P12
#> 30   30                 Purdue  B10
#> 31   31           Michigan St.  B10
#> 32   32            Wake Forest  ACC
#> 33   33                Arizona  P12
#> 34   34              Minnesota  B10
#> 35   35               Virginia  ACC
#> 36   36                Alabama  SEC
#> 37   37               Iowa St.  B12
#> 38   38             Vanderbilt  SEC
#> 39   39          West Virginia  B12
#> 40   40                   UCLA  P12
#> 41   41           Oklahoma St.  B12
#> 42   42                 Dayton  A10
#> 43   43                    LSU  SEC
#> 44   44                   Ohio  MAC
#> 45   45              Texas A&M  SEC
#> 46   46               Michigan  B10
#> 47   47                 Oregon  P12
#> 48   48             Kansas St.  B12
#> 49   49             Pittsburgh  ACC
#> 50   50         New Mexico St.  WAC
#> 51   51              Boise St.  MWC
#> 52   52          San Diego St.  MWC
#> 53   53             Providence   BE
#> 54   54              Louisiana   SB
#> 55   55            Florida St.  ACC
#> 56   56             Cincinnati Amer
#> 57   57                   UTEP CUSA
#> 58   58             California  P12
#> 59   59         Washington St.  P12
#> 60   60               Oklahoma  B12
#> 61   61                 Nevada  MWC
#> 62   62       Middle Tennessee CUSA
#> 63   63               Ball St.  MAC
#> 64   63              Weber St. BSky
#> 65   65                Wyoming  MWC
#> 66   66               Colorado  P12
#> 67   67                Bradley  MVC
#> 68   68           Missouri St.  MVC
#> 69   69            Chattanooga   SC
#> 70   70              Milwaukee Horz
#> 71   71            Arizona St.  P12
#> 72   72            Saint Louis  A10
#> 73   73        Mississippi St.  SEC
#> 74   73           Oral Roberts  Sum
#> 75   75                Georgia  SEC
#> 76   76            Wichita St. Amer
#> 77   77            North Texas CUSA
#> 78   77          Tennessee St.  OVC
#> 79   79             Seton Hall   BE
#> 80   80             Wright St. Horz
#> 81   81          South Florida Amer
#> 82   82                 DePaul   BE
#> 83   83                 Hawaii   BW
#> 84   84                 Baylor  B12
#> 85   85               Utah St.  MWC
#> 86   86                    USC  P12
#> 87   87                 Xavier   BE
#> 88   88                 Temple Amer
#> 89   89           Illinois St.  MVC
#> 90   89            Indiana St.  MVC
#> 91   91            Connecticut   BE
#> 92   92                Florida  SEC
#> 93   93                  Lamar Slnd
#> 94   94           Arkansas St.   SB
#> 95   95          South Alabama   SB
#> 96   95                    UCF Amer
#> 97   97              Green Bay Horz
#> 98   98             Oregon St.  P12
#> 99   99            Mississippi  SEC
#> 100 100          Massachusetts  A10
#> 101 101      Northern Kentucky Horz
#> 102 102                   Duke  ACC
#> 103 103             Washington  P12
#> 104 104             Notre Dame  ACC
#> 105 105                 Auburn  SEC
#> 106 106              Charlotte CUSA
#> 107 107                 Butler   BE
#> 108 107      Northern Illinois  MAC
#> 109 109               Marshall CUSA
#> 110 110                Clemson  ACC
#> 111 110            Florida A&M MEAC
#> 112 112             Evansville  MVC
#> 113 113          Virginia Tech  ACC
#> 114 114            New Orleans Slnd
#> 115 115       Eastern Michigan  MAC
#> 116 116                   Penn  Ivy
#> 117 117         Boston College  ACC
#> 118 118           Georgia Tech  ACC
#> 119 118             Murray St.  OVC
#> 120 118         William & Mary  CAA
#> 121 121          Cleveland St. Horz
#> 122 121          James Madison  CAA
#> 123 121 Texas A&M Corpus Chris Slnd
#> 124 121                    UAB CUSA
#> 125 125           Old Dominion CUSA
#> 126 126                  Tulsa Amer
#> 127 127      Southern Illinois  MVC
#> 128 128        Appalachian St.   SB
#> 129 129                Detroit Horz
#> 130 130         Texas Southern SWAC
#> 131 131          Southern Miss CUSA
#> 132 132           Colorado St.  MWC
#> 133 133          East Carolina Amer
#> 134 133       Illinois Chicago Horz
#> 135 133            Jackson St. SWAC
#> 136 133         Louisiana Tech CUSA
#> 137 133                Rutgers  B10
#> 138 138               Miami FL  ACC
#> 139 139         Nebraska Omaha  Sum
#> 140 140           George Mason  A10
#> 141 141       Western Carolina   SC
#> 142 142           Rhode Island  A10
#> 143 143                    VCU  A10
#> 144 144         UNC Greensboro   SC
#> 145 145       Western Kentucky CUSA
#> 146 146 Southeastern Louisiana Slnd
#> 147 146               Southern SWAC
#> 148 146         Tennessee Tech  OVC
#> 149 146            Utah Valley  WAC
#> 150 150            Alabama St. SWAC
#> 151 151               Stanford  P12
#> 152 152                Montana BSky
#> 153 153                 Toledo  MAC
#> 154 154          Northern Iowa  MVC
#> 155 155            Austin Peay  OVC
#> 156 156      Stephen F. Austin Slnd
#> 157 157               Richmond  A10
#> 158 158                Hampton BSth
#> 159 158              Texas St.   SB
#> 160 160                  Drake  MVC
#> 161 161               UC Davis   BW
#> 162 162           Northwestern  B10
#> 163 163                Houston Amer
#> 164 164             Alcorn St. SWAC
#> 165 164           Grand Canyon  WAC
#> 166 164                  Idaho BSky
#> 167 164       Louisiana Monroe   SB
#> 168 164                    SMU Amer
#> 169 164 Southeast Missouri St.  OVC
#> 170 164           UT Arlington   SB
#> 171 171              Princeton  Ivy
#> 172 172                  IUPUI Horz
#> 173 172                    TCU  B12
#> 174 174            Montana St. BSky
#> 175 175     North Carolina A&T MEAC
#> 176 176     East Tennessee St.   SC
#> 177 176       Eastern Kentucky  OVC
#> 178 176           Morehead St.  OVC
#> 179 176              Villanova   BE
#> 180 180               Miami OH  MAC
#> 181 180         Youngstown St. Horz
#> 182 182               Kent St.  MAC
#> 183 183            Norfolk St. MEAC
#> 184 184                Pacific  WCC
#> 185 185        Sam Houston St. Slnd
#> 186 186                Buffalo  MAC
#> 187 186         UNC Wilmington  CAA
#> 188 186               Winthrop BSth
#> 189 189       South Dakota St.  Sum
#> 190 190            Alabama A&M SWAC
#> 191 190                Gonzaga  WCC
#> 192 190           South Dakota  Sum
#> 193 190            The Citadel   SC
#> 194 190       UC Santa Barbara   BW
#> 195 195              Air Force  MWC
#> 196 196                  Maine   AE
#> 197 196          North Florida ASun
#> 198 198                   Navy  Pat
#> 199 199       North Dakota St.  Sum
#> 200 200             St. John's   BE
#> 201 201                 Lehigh  Pat
#> 202 201            Little Rock   SB
#> 203 203                  Akron  MAC
#> 204 203       Central Arkansas Slnd
#> 205 203 Maryland Eastern Shore MEAC
#> 206 203                   Troy   SB
#> 207 207        St. Bonaventure  A10
#> 208 208       Western Michigan  MAC
#> 209 209       Central Michigan  MAC
#> 210 209       Eastern Illinois  OVC
#> 211 209          Southern Utah BSky
#> 212 212               Davidson  A10
#> 213 213                   Rice CUSA
#> 214 214                 Towson  CAA
#> 215 215             Binghamton   AE
#> 216 216       Western Illinois  Sum
#> 217 217             Charleston  CAA
#> 218 217                   Elon  CAA
#> 219 217              San Diego  WCC
#> 220 220           Northeastern  CAA
#> 221 221            Cal Baptist  WAC
#> 222 222                Hofstra  CAA
#> 223 223                   Army  Pat
#> 224 224                    VMI   SC
#> 225 225               Lipscomb ASun
#> 226 226                Belmont  OVC
#> 227 226            Chicago St.  WAC
#> 228 226               Delaware  CAA
#> 229 226     Eastern Washington BSky
#> 230 226                    FIU CUSA
#> 231 226                 Furman   SC
#> 232 226                Samford   SC
#> 233 226           San Jose St.  MWC
#> 234 226              UC Irvine   BW
#> 235 226             Valparaiso  MVC
#> 236 236               Portland  WCC
#> 237 237              Dixie St.  WAC
#> 238 238                   UMBC   AE
#> 239 239           Kennesaw St. ASun
#> 240 240                 Albany   AE
#> 241 241    Arkansas Pine Bluff SWAC
#> 242 241     Florida Gulf Coast ASun
#> 243 241             Morgan St. MEAC
#> 244 241            Santa Clara  WCC
#> 245 245         Loyola Chicago  MVC
#> 246 246                Cornell  Ivy
#> 247 247       Georgia Southern   SB
#> 248 248          Bowling Green  MAC
#> 249 249      George Washington  A10
#> 250 250       Tennessee Martin  OVC
#> 251 251         Long Beach St.   BW
#> 252 251            McNeese St. Slnd
#> 253 251         Saint Joseph's  A10
#> 254 251          San Francisco  WCC
#> 255 255       Loyola Marymount  WCC
#> 256 256             Coppin St. MEAC
#> 257 256               Monmouth MAAC
#> 258 258                   UTSA CUSA
#> 259 259            Stony Brook   AE
#> 260 260               Bucknell  Pat
#> 261 260      Cal St. Fullerton   BW
#> 262 260                Liberty ASun
#> 263 260          North Alabama ASun
#> 264 260                Oakland Horz
#> 265 260          Robert Morris Horz
#> 266 260       SIU Edwardsville  OVC
#> 267 260                Stetson ASun
#> 268 260           UC San Diego   BW
#> 269 260   UT Rio Grande Valley  WAC
#> 270 270    Cal St. Bakersfield   BW
#> 271 271           Nicholls St. Slnd
#> 272 272       Coastal Carolina   SB
#> 273 272             Holy Cross  Pat
#> 274 272       Northwestern St. Slnd
#> 275 272                 Tulane Amer
#> 276 276               Hartford   AE
#> 277 277               Duquesne  A10
#> 278 277           Gardner Webb BSth
#> 279 277       Jacksonville St.  OVC
#> 280 277                   NJIT   AE
#> 281 277       Prairie View A&M SWAC
#> 282 277           Saint Mary's  WCC
#> 283 277         St. Francis PA  NEC
#> 284 284            Georgia St.   SB
#> 285 284               La Salle  A10
#> 286 284                Wofford   SC
#> 287 287                Vermont   AE
#> 288 288             Quinnipiac MAAC
#> 289 289    Central Connecticut  NEC
#> 290 289                Fordham  A10
#> 291 289                 Marist MAAC
#> 292 289                 Mercer   SC
#> 293 289                Radford BSth
#> 294 289          Saint Peter's MAAC
#> 295 289     South Carolina St. MEAC
#> 296 289          UNC Asheville BSth
#> 297 297       Mount St. Mary's  NEC
#> 298 298 North Carolina Central MEAC
#> 299 299             Pepperdine  WCC
#> 300 300               Campbell BSth
#> 301 301           Portland St. BSky
#> 302 302           North Dakota  Sum
#> 303 303              Idaho St. BSky
#> 304 304               Cal Poly   BW
#> 305 305        Bethune Cookman MEAC
#> 306 305          Grambling St. SWAC
#> 307 305          New Hampshire   AE
#> 308 305           Tarleton St.  WAC
#> 309 309      Northern Colorado BSky
#> 310 310               American  Pat
#> 311 311                  Brown  Ivy
#> 312 312           UC Riverside   BW
#> 313 313               Columbia  Ivy
#> 314 313                 Howard MEAC
#> 315 313 Mississippi Valley St. SWAC
#> 316 316              Lafayette  Pat
#> 317 317                   Iona MAAC
#> 318 318                 Bryant  NEC
#> 319 319                 Drexel  CAA
#> 320 319                   Yale  Ivy
#> 321 321                 Denver  Sum
#> 322 321       Florida Atlantic CUSA
#> 323 321             Georgetown   BE
#> 324 321              Manhattan MAAC
#> 325 325              Fairfield MAAC
#> 326 326                Niagara MAAC
#> 327 327           Presbyterian BSth
#> 328 328     Cal St. Northridge   BW
#> 329 329                Harvard  Ivy
#> 330 330               Canisius MAAC
#> 331 331                  Siena MAAC
#> 332 332              Dartmouth  Ivy
#> 333 332              Loyola MD  Pat
#> 334 332           Sacred Heart  NEC
#> 335 332           UMass Lowell   AE
#> 336 332                 Wagner  NEC
#> 337 337           Delaware St. MEAC
#> 338 337    Fairleigh Dickinson  NEC
#> 339 337         Incarnate Word Slnd
#> 340 337                    LIU  NEC
#> 341 341               Longwood BSth
#> 342 342      Boston University  Pat
#> 343 342      Purdue Fort Wayne Horz
#> 344 344                Colgate  Pat
#> 345 345             High Point BSth
#> 346 346                  Rider MAAC
#> 347 347                   UMKC  Sum
#> 348 348           Jacksonville ASun
#> 349 349       Northern Arizona BSky
#> 350 350              Merrimack  NEC
#> 351 350         St. Francis NY  NEC
#> 352 352         Sacramento St. BSky
#> 353 353      Abilene Christian Slnd
#> 354 353        Houston Baptist Slnd
#> 355 355                Seattle  WAC
#> 356 356    Charleston Southern BSth
#> 357 357            USC Upstate BSth
#>                                              arena
#> 1                            Carrier Dome (35,642)
#> 2                         KFC Yum! Center (22,090)
#> 3                    Dean E. Smith Center (21,750)
#> 4                   Thompson Boling Arena (21,678)
#> 5                              Rupp Arena (20,500)
#> 6                               PNC Arena (19,700)
#> 7                        Bud Walton Arena (19,200)
#> 8                        Value City Arena (19,049)
#> 9                         Marriott Center (18,987)
#> 10                             FedExForum (18,400)
#> 11                           Freedom Hall (18,252)
#> 12                    Colonial Life Arena (18,000)
#> 13                   Thomas & Mack Center (18,000)
#> 14                         Xfinity Center (17,950)
#> 15                           Fiserv Forum (17,600)
#> 16                          Assembly Hall (17,472)
#> 17                CHI Health Center Omaha (17,352)
#> 18                            Kohl Center (17,287)
#> 19                           Erwin Center (16,540)
#> 20                       Allen Fieldhouse (16,300)
#> 21                       Save Mart Center (15,596)
#> 22                      State Farm Center (15,544)
#> 23                       Dreamstyle Arena (15,411)
#> 24                    Bryce Jordan Center (15,261)
#> 25              United Supermarkets Arena (15,098)
#> 26                           Mizzou Arena (15,061)
#> 27                   Carver Hawkeye Arena (15,056)
#> 28                    Pinnacle Bank Arena (15,000)
#> 29                        Huntsman Center (15,000)
#> 30                           Mackey Arena (14,804)
#> 31                         Breslin Center (14,797)
#> 32                          Joel Coliseum (14,665)
#> 33                 McKale Memorial Center (14,644)
#> 34                         Williams Arena (14,625)
#> 35                  John Paul Jones Arena (14,623)
#> 36                       Coleman Coliseum (14,474)
#> 37                        Hilton Coliseum (14,384)
#> 38                           Memorial Gym (14,316)
#> 39                           WVU Coliseum (14,000)
#> 40                        Pauley Pavilion (13,800)
#> 41                    Gallagher Iba Arena (13,611)
#> 42             University of Dayton Arena (13,455)
#> 43               Maravich Assembly Center (13,215)
#> 44                     Convocation Center (13,080)
#> 45                             Reed Arena (12,989)
#> 46                         Crisler Center (12,707)
#> 47                           Knight Arena (12,541)
#> 48                      Bramlage Coliseum (12,528)
#> 49                 Petersen Events Center (12,508)
#> 50                    Pan American Center (12,482)
#> 51                        ExtraMile Arena (12,480)
#> 52                           Viejas Arena (12,414)
#> 53                  Dunkin' Donuts Center (12,410)
#> 54                              Cajundome (12,362)
#> 55                Donald L. Tucker Center (12,100)
#> 56                      Fifth Third Arena (12,012)
#> 57                     Don Haskins Center (11,892)
#> 58                          Haas Pavilion (11,877)
#> 59                       Beasley Coliseum (11,671)
#> 60                     Lloyd Noble Center (11,562)
#> 61                   Lawlor Events Center (11,536)
#> 62                          Murphy Center (11,520)
#> 63                          Worthen Arena (11,500)
#> 64                      Dee Events Center (11,500)
#> 65                       Arena Auditorium (11,445)
#> 66                       CU Events Center (11,064)
#> 67                           Carver Arena (11,060)
#> 68                              JQH Arena (11,000)
#> 69                         McKenzie Arena (10,995)
#> 70                      UWM Panther Arena (10,783)
#> 71                 Desert Financial Arena (10,754)
#> 72                         Chaifetz Arena (10,600)
#> 73                      Humphrey Coliseum (10,575)
#> 74                           Mabee Center (10,575)
#> 75                      Stegeman Coliseum (10,523)
#> 76                     Charles Koch Arena (10,506)
#> 77                          The Super Pit (10,500)
#> 78                          Gentry Center (10,500)
#> 79                      Prudential Center (10,481)
#> 80                          Nutter Center (10,449)
#> 81                       Yuengling Center (10,411)
#> 82                         Wintrust Arena (10,387)
#> 83                    Stan Sheriff Center (10,300)
#> 84                         Ferrell Center (10,284)
#> 85                Dee Glen Smith Spectrum (10,270)
#> 86                           Galen Center (10,258)
#> 87                          Cintas Center (10,224)
#> 88                   The Liacouras Center (10,206)
#> 89                          Redbird Arena (10,200)
#> 90                          Hulman Center (10,200)
#> 91                        Gampel Pavilion (10,167)
#> 92                         Exactech Arena (10,151)
#> 93                        Montagne Center (10,080)
#> 94              First National Bank Arena (10,038)
#> 95                        Mitchell Center (10,000)
#> 96               Addition Financial Arena (10,000)
#> 97                            Resch Center (9,729)
#> 98                           Gill Coliseum (9,604)
#> 99                The Pavilion at Ole Miss (9,500)
#> 100                         Mullins Center (9,493)
#> 101                             BB&T Arena (9,400)
#> 102                 Cameron Indoor Stadium (9,314)
#> 103                  Alaska Airlines Arena (9,268)
#> 104                           Joyce Center (9,149)
#> 105                           Auburn Arena (9,121)
#> 106                           Halton Arena (9,105)
#> 107                      Hinkle Fieldhouse (9,100)
#> 108                     Convocation Center (9,100)
#> 109                       Henderson Center (9,043)
#> 110                    Littlejohn Coliseum (9,000)
#> 111                          Lawson Center (9,000)
#> 112                            Ford Center (8,930)
#> 113                       Cassell Coliseum (8,925)
#> 114                        Lakefront Arena (8,785)
#> 115                     Convocation Center (8,754)
#> 116                           The Palestra (8,722)
#> 117                            Conte Forum (8,606)
#> 118                      McCamish Pavilion (8,600)
#> 119                            CFSB Center (8,600)
#> 120                           Kaplan Arena (8,600)
#> 121                        Wolstein Center (8,500)
#> 122             Atlantic Union Bank Center (8,500)
#> 123                   American Bank Center (8,500)
#> 124                           Bartow Arena (8,500)
#> 125            Constant Convocation Center (8,472)
#> 126                        Reynolds Center (8,355)
#> 127                        Banterra Center (8,339)
#> 128                          Holmes Center (8,325)
#> 129                           Calihan Hall (8,295)
#> 130                      Health & PE Arena (8,100)
#> 131                    Reed Green Coliseum (8,095)
#> 132                             Moby Arena (8,083)
#> 133      Williams Arena at Minges Coliseum (8,000)
#> 134                   Credit Union 1 Arena (8,000)
#> 135                        Williams Center (8,000)
#> 136                 Thomas Assembly Center (8,000)
#> 137                Rutgers Athletic Center (8,000)
#> 138                          Watsco Center (7,972)
#> 139                           Baxter Arena (7,898)
#> 140                        EagleBank Arena (7,860)
#> 141                          Ramsey Center (7,826)
#> 142                            Ryan Center (7,657)
#> 143                          Siegel Center (7,637)
#> 144                    Greensboro Coliseum (7,617)
#> 145                      E.A. Diddle Arena (7,523)
#> 146                      University Center (7,500)
#> 147                  Clark Activity Center (7,500)
#> 148                           Eblen Center (7,500)
#> 149                            UCCU Center (7,500)
#> 150                    Dunn-Oliver Acadome (7,400)
#> 151                        Maples Pavilion (7,329)
#> 152                         Dahlberg Arena (7,322)
#> 153                           Savage Arena (7,300)
#> 154                          McLeod Center (7,293)
#> 155                   Winfield Dunn Center (7,275)
#> 156                       Johnson Coliseum (7,203)
#> 157                          Robins Center (7,201)
#> 158             Hampton Convocation Center (7,200)
#> 159                       Strahan Coliseum (7,200)
#> 160                           Knapp Center (7,152)
#> 161                           The Pavilion (7,100)
#> 162                       Welsh-Ryan Arena (7,039)
#> 163                        Fertitta Center (7,035)
#> 164                        Whitney Complex (7,000)
#> 165                              GCU Arena (7,000)
#> 166                         Cowan Spectrum (7,000)
#> 167                    Fant-Ewing Coliseum (7,000)
#> 168                         Moody Coliseum (7,000)
#> 169                         Show Me Center (7,000)
#> 170                    College Park Center (7,000)
#> 171                       Jadwin Gymnasium (6,854)
#> 172               Indiana Farmers Coliseum (6,800)
#> 173                      Schollmaier Arena (6,800)
#> 174                      Worthington Arena (6,772)
#> 175                  Corbett Sports Center (6,700)
#> 176              Freedom Hall Civic Center (6,500)
#> 177                         McBrayer Arena (6,500)
#> 178                          Johnson Arena (6,500)
#> 179                      Finneran Pavilion (6,500)
#> 180                           Millett Hall (6,400)
#> 181                         Beeghly Center (6,400)
#> 182 Memorial Athletic & Convocation Center (6,327)
#> 183                            Echols Hall (6,191)
#> 184                          Spanos Center (6,150)
#> 185                       Johnson Coliseum (6,110)
#> 186                           Alumni Arena (6,100)
#> 187                         Trask Coliseum (6,100)
#> 188                      Winthrop Coliseum (6,100)
#> 189                            Frost Arena (6,063)
#> 190                       Elmore Gymnasium (6,000)
#> 191              McCarthey Athletic Center (6,000)
#> 192           Sanford Coyote Sports Center (6,000)
#> 193                  McAlister Field House (6,000)
#> 194                            Thunderdome (6,000)
#> 195                            Clune Arena (5,843)
#> 196                 Cross Insurance Center (5,800)
#> 197                              UNF Arena (5,800)
#> 198                            Alumni Hall (5,710)
#> 199                         Scheels Center (5,644)
#> 200                       Carnesecca Arena (5,602)
#> 201                          Stabler Arena (5,600)
#> 202                        Stephens Center (5,600)
#> 203                           Rhodes Arena (5,500)
#> 204                          Farris Center (5,500)
#> 205                 Hytche Athletic Center (5,500)
#> 206                           Trojan Arena (5,500)
#> 207                          Reilly Center (5,480)
#> 208                       University Arena (5,421)
#> 209                          McGuirk Arena (5,300)
#> 210                            Lantz Arena (5,300)
#> 211             America First Event Center (5,300)
#> 212                             Belk Arena (5,223)
#> 213                       Tudor Fieldhouse (5,208)
#> 214                             SECU Arena (5,200)
#> 215                          Events Center (5,142)
#> 216                           Western Hall (5,139)
#> 217                               TD Arena (5,100)
#> 218                           Schar Center (5,100)
#> 219                   Jenny Craig Pavilion (5,100)
#> 220                         Matthews Arena (5,066)
#> 221                      CBU Events Center (5,050)
#> 222                    Mack Sports Complex (5,045)
#> 223                          Christl Arena (5,043)
#> 224                           Cameron Hall (5,029)
#> 225                            Allen Arena (5,028)
#> 226                      Curb Event Center (5,000)
#> 227               Jones Convocation Center (5,000)
#> 228                   Bob Carpenter Center (5,000)
#> 229                            Reese Court (5,000)
#> 230          Ocean Bank Convocation Center (5,000)
#> 231                          Timmons Arena (5,000)
#> 232                           Hanna Center (5,000)
#> 233    Provident Credit Union Event Center (5,000)
#> 234                     Bren Events Center (5,000)
#> 235            Athletics Recreation Center (5,000)
#> 236                          Chiles Center (4,854)
#> 237                            Burns Arena (4,779)
#> 238                      UMBC Event Center (4,753)
#> 239                 KSU Convocation Center (4,600)
#> 240                            SEFCU Arena (4,538)
#> 241                         Clemmons Arena (4,500)
#> 242                            Alico Arena (4,500)
#> 243                       Hill Field House (4,500)
#> 244                          Leavey Center (4,500)
#> 245                          Gentile Arena (4,486)
#> 246                           Newman Arena (4,473)
#> 247                      Hanner Fieldhouse (4,358)
#> 248                           Stroh Center (4,347)
#> 249                Charles E. Smith Center (4,338)
#> 250                            Elam Center (4,300)
#> 251                     The Walter Pyramid (4,200)
#> 252                           H&HP Complex (4,200)
#> 253                            Hagan Arena (4,200)
#> 254     War Memorial at the Sobrato Center (4,200)
#> 255                       Gersten Pavilion (4,156)
#> 256             Physical Education Complex (4,100)
#> 257                 OceanFirst Bank Center (4,100)
#> 258                UTSA Convocation Center (4,080)
#> 259                   Island Federal Arena (4,009)
#> 260                         Sojka Pavilion (4,000)
#> 261                              Titan Gym (4,000)
#> 262                          Liberty Arena (4,000)
#> 263                           Flowers Hall (4,000)
#> 264                Athletics Center O'Rena (4,000)
#> 265                     UPMC Events Center (4,000)
#> 266                  First Community Arena (4,000)
#> 267                         Edmunds Center (4,000)
#> 268                            Rimac Arena (4,000)
#> 269                       UTRGV Fieldhouse (4,000)
#> 270                          Icardo Center (3,880)
#> 271                            Stopher Gym (3,800)
#> 272                             HTC Center (3,600)
#> 273                            Hart Center (3,600)
#> 274                       Prather Coliseum (3,600)
#> 275                         Fogelman Arena (3,600)
#> 276                            Chase Arena (3,508)
#> 277                 UPMC Cooper Fieldhouse (3,500)
#> 278                      Paul Porter Arena (3,500)
#> 279                       Mathews Coliseum (3,500)
#> 280             Wellness and Events Center (3,500)
#> 281                 William Nicks Building (3,500)
#> 282       University Credit Union Pavilion (3,500)
#> 283                            DeGol Arena (3,500)
#> 284                       GSU Sports Arena (3,400)
#> 285                         Tom Gola Arena (3,400)
#> 286              Richardson Indoor Stadium (3,400)
#> 287                      Patrick Gymnasium (3,266)
#> 288                 People's United Center (3,254)
#> 289                      Detrick Gymnasium (3,200)
#> 290                          Rose Hill Gym (3,200)
#> 291                          McCann Center (3,200)
#> 292                          Hawkins Arena (3,200)
#> 293                          Dedmon Center (3,200)
#> 294                       Yanitelli Center (3,200)
#> 295         Smith Hammond Middleton Center (3,200)
#> 296                           Kimmel Arena (3,200)
#> 297                            Knott Arena (3,121)
#> 298           McLendon-McDougald Gymnasium (3,116)
#> 299                   Firestone Fieldhouse (3,104)
#> 300                Pope Convocation Center (3,095)
#> 301                        Viking Pavilion (3,094)
#> 302           Betty Engelstad Sioux Center (3,064)
#> 303                               Reed Gym (3,040)
#> 304                  Mott Athletics Center (3,032)
#> 305                              Moore Gym (3,000)
#> 306                        Assembly Center (3,000)
#> 307                     Lundholm Gymnasium (3,000)
#> 308                       Wisdom Gymnasium (3,000)
#> 309                 Bank of Colorado Arena (2,977)
#> 310                           Bender Arena (2,930)
#> 311                Pizzitola Sports Center (2,800)
#> 312                              SRC Arena (2,750)
#> 313                       Levien Gymnasium (2,700)
#> 314                             Burr Arena (2,700)
#> 315                       Harrison Complex (2,700)
#> 316                    Kirby Sports Center (2,644)
#> 317                 Hynes Athletics Center (2,611)
#> 318                  Chace Athletic Center (2,600)
#> 319             Daskalakis Athletic Center (2,532)
#> 320                       Lee Amphitheater (2,532)
#> 321                     Hamilton Gymnasium (2,500)
#> 322                              FAU Arena (2,500)
#> 323                        McDonough Arena (2,500)
#> 324                       Draddy Gymnasium (2,500)
#> 325                            Alumni Hall (2,479)
#> 326                       Gallagher Center (2,400)
#> 327                  Templeton P.E. Center (2,300)
#> 328                               Matadome (2,200)
#> 329                      Lavietes Pavilion (2,195)
#> 330               Koessler Athletic Center (2,176)
#> 331                             UHY Center (2,148)
#> 332                            Leede Arena (2,100)
#> 333                            Reitz Arena (2,100)
#> 334                            Pitt Center (2,100)
#> 335               Costello Athletic Center (2,100)
#> 336                    Spiro Sports Center (2,100)
#> 337                          Memorial Hall (2,000)
#> 338                         Rothman Center (2,000)
#> 339           McDermott Convocation Center (2,000)
#> 340              Steinberg Wellness Center (2,000)
#> 341                           Willett Hall (1,807)
#> 342                               Case Gym (1,800)
#> 343                    Gates Sports Center (1,800)
#> 344                        Cotterell Court (1,782)
#> 345 Millis Athletic and Convocation Center (1,750)
#> 346                       Alumni Gymnasium (1,650)
#> 347              Swinney Recreation Center (1,600)
#> 348                      Swisher Gymnasium (1,500)
#> 349                 Rolle Activity Center  (1,210)
#> 350                           Hammel Court (1,200)
#> 351                       Pope P.E. Center (1,200)
#> 352                               The Nest (1,012)
#> 353           Teague Special Events Center (1,000)
#> 354                              Sharp Gym (1,000)
#> 355                           Redhawk Center (999)
#> 356                    Buccaneer Field House (881)
#> 357                             Hodge Center (837)
#>                          alternate year
#> 1                                  2021
#> 2                                  2021
#> 3                                  2021
#> 4                                  2021
#> 5                                  2021
#> 6                                  2021
#> 7                                  2021
#> 8                                  2021
#> 9                                  2021
#> 10                                 2021
#> 11                                 2021
#> 12                                 2021
#> 13                                 2021
#> 14                                 2021
#> 15                                 2021
#> 16                                 2021
#> 17                                 2021
#> 18                                 2021
#> 19                                 2021
#> 20                                 2021
#> 21                                 2021
#> 22                                 2021
#> 23                                 2021
#> 24                                 2021
#> 25                                 2021
#> 26                                 2021
#> 27                                 2021
#> 28                                 2021
#> 29                                 2021
#> 30                                 2021
#> 31                                 2021
#> 32                                 2021
#> 33                                 2021
#> 34                                 2021
#> 35                                 2021
#> 36                                 2021
#> 37                                 2021
#> 38                                 2021
#> 39                                 2021
#> 40                                 2021
#> 41                                 2021
#> 42                                 2021
#> 43                                 2021
#> 44                                 2021
#> 45                                 2021
#> 46                                 2021
#> 47                                 2021
#> 48                                 2021
#> 49                                 2021
#> 50                                 2021
#> 51                                 2021
#> 52                                 2021
#> 53                                 2021
#> 54                                 2021
#> 55                                 2021
#> 56                                 2021
#> 57                                 2021
#> 58                                 2021
#> 59                                 2021
#> 60                                 2021
#> 61                                 2021
#> 62                                 2021
#> 63                                 2021
#> 64                                 2021
#> 65                                 2021
#> 66                                 2021
#> 67                                 2021
#> 68                                 2021
#> 69                                 2021
#> 70                                 2021
#> 71                                 2021
#> 72                                 2021
#> 73                                 2021
#> 74                                 2021
#> 75                                 2021
#> 76                                 2021
#> 77                                 2021
#> 78                                 2021
#> 79                                 2021
#> 80                                 2021
#> 81                                 2021
#> 82                                 2021
#> 83                                 2021
#> 84                                 2021
#> 85                                 2021
#> 86                                 2021
#> 87                                 2021
#> 88                                 2021
#> 89                                 2021
#> 90                                 2021
#> 91              XL Center (15,564) 2021
#> 92                                 2021
#> 93                                 2021
#> 94                                 2021
#> 95                                 2021
#> 96                                 2021
#> 97     Kress Events Center (4,018) 2021
#> 98                                 2021
#> 99                                 2021
#> 100                                2021
#> 101                                2021
#> 102                                2021
#> 103                                2021
#> 104                                2021
#> 105                                2021
#> 106                                2021
#> 107                                2021
#> 108                                2021
#> 109                                2021
#> 110                                2021
#> 111                                2021
#> 112                                2021
#> 113                                2021
#> 114                                2021
#> 115                                2021
#> 116                                2021
#> 117                                2021
#> 118                                2021
#> 119                                2021
#> 120                                2021
#> 121                                2021
#> 122                                2021
#> 123                                2021
#> 124                                2021
#> 125                                2021
#> 126                                2021
#> 127                                2021
#> 128                                2021
#> 129                                2021
#> 130                                2021
#> 131                                2021
#> 132                                2021
#> 133                                2021
#> 134                                2021
#> 135                                2021
#> 136                                2021
#> 137                                2021
#> 138                                2021
#> 139                                2021
#> 140                                2021
#> 141                                2021
#> 142                                2021
#> 143                                2021
#> 144                                2021
#> 145                                2021
#> 146                                2021
#> 147                                2021
#> 148                                2021
#> 149                                2021
#> 150                                2021
#> 151                                2021
#> 152                                2021
#> 153                                2021
#> 154                                2021
#> 155                                2021
#> 156                                2021
#> 157                                2021
#> 158                                2021
#> 159                                2021
#> 160                                2021
#> 161                                2021
#> 162                                2021
#> 163                                2021
#> 164                                2021
#> 165                                2021
#> 166                                2021
#> 167                                2021
#> 168                                2021
#> 169                                2021
#> 170                                2021
#> 171                                2021
#> 172                                2021
#> 173                                2021
#> 174                                2021
#> 175                                2021
#> 176                                2021
#> 177                                2021
#> 178                                2021
#> 179    Wells Fargo Center (20,478) 2021
#> 180                                2021
#> 181                                2021
#> 182                                2021
#> 183                                2021
#> 184                                2021
#> 185                                2021
#> 186                                2021
#> 187                                2021
#> 188                                2021
#> 189                                2021
#> 190                                2021
#> 191                                2021
#> 192                                2021
#> 193                                2021
#> 194                                2021
#> 195                                2021
#> 196                                2021
#> 197                                2021
#> 198                                2021
#> 199                                2021
#> 200 Madison Square Garden (19,786) 2021
#> 201                                2021
#> 202                                2021
#> 203                                2021
#> 204                                2021
#> 205                                2021
#> 206                                2021
#> 207                                2021
#> 208                                2021
#> 209                                2021
#> 210                                2021
#> 211                                2021
#> 212                                2021
#> 213                                2021
#> 214                                2021
#> 215                                2021
#> 216                                2021
#> 217                                2021
#> 218                                2021
#> 219                                2021
#> 220                                2021
#> 221                                2021
#> 222                                2021
#> 223                                2021
#> 224                                2021
#> 225                                2021
#> 226                                2021
#> 227                                2021
#> 228                                2021
#> 229                                2021
#> 230                                2021
#> 231                                2021
#> 232                                2021
#> 233                                2021
#> 234                                2021
#> 235                                2021
#> 236                                2021
#> 237                                2021
#> 238                                2021
#> 239                                2021
#> 240                                2021
#> 241                                2021
#> 242                                2021
#> 243                                2021
#> 244                                2021
#> 245                                2021
#> 246                                2021
#> 247                                2021
#> 248                                2021
#> 249                                2021
#> 250                                2021
#> 251                                2021
#> 252                                2021
#> 253                                2021
#> 254                                2021
#> 255                                2021
#> 256                                2021
#> 257                                2021
#> 258                                2021
#> 259                                2021
#> 260                                2021
#> 261                                2021
#> 262                                2021
#> 263                                2021
#> 264                                2021
#> 265                                2021
#> 266                                2021
#> 267                                2021
#> 268                                2021
#> 269                                2021
#> 270                                2021
#> 271                                2021
#> 272                                2021
#> 273                                2021
#> 274                                2021
#> 275                                2021
#> 276                                2021
#> 277                                2021
#> 278                                2021
#> 279                                2021
#> 280                                2021
#> 281                                2021
#> 282                                2021
#> 283                                2021
#> 284                                2021
#> 285                                2021
#> 286                                2021
#> 287                                2021
#> 288                                2021
#> 289                                2021
#> 290                                2021
#> 291                                2021
#> 292                                2021
#> 293                                2021
#> 294                                2021
#> 295                                2021
#> 296                                2021
#> 297                                2021
#> 298                                2021
#> 299                                2021
#> 300                                2021
#> 301                                2021
#> 302                                2021
#> 303                                2021
#> 304                                2021
#> 305                                2021
#> 306                                2021
#> 307                                2021
#> 308                                2021
#> 309                                2021
#> 310                                2021
#> 311                                2021
#> 312                                2021
#> 313                                2021
#> 314                                2021
#> 315                                2021
#> 316                                2021
#> 317                                2021
#> 318                                2021
#> 319                                2021
#> 320                                2021
#> 321                                2021
#> 322                                2021
#> 323                                2021
#> 324                                2021
#> 325    Webster Bank Arena (10,000) 2021
#> 326                                2021
#> 327                                2021
#> 328                                2021
#> 329                                2021
#> 330                                2021
#> 331                                2021
#> 332                                2021
#> 333                                2021
#> 334                                2021
#> 335         Tsongas Center (6,111) 2021
#> 336                                2021
#> 337                                2021
#> 338                                2021
#> 339                                2021
#> 340                                2021
#> 341                                2021
#> 342                                2021
#> 343                                2021
#> 344                                2021
#> 345                                2021
#> 346                                2021
#> 347                                2021
#> 348                                2021
#> 349                                2021
#> 350                                2021
#> 351                                2021
#> 352                                2021
#> 353                                2021
#> 354                                2021
#> 355                                2021
#> 356                                2021
#> 357                                2021
# }
# \donttest{
try(kp_game_attrs(year = 2021, attr = "Excitement"))
#>      rk       data                                                         game
#> 1     1 Wed Nov 25               108 Georgia St. 123, 72 Georgia Tech 120 (4OT)
#> 2     2  Sun Dec 6          184 Western Carolina 76, 321 Tennessee Tech 75 (OT)
#> 3     3 Sun Dec 27                         63 Providence 95, 86 DePaul 90 (2OT)
#> 4     4  Sat Jan 2                   25 Arizona 86, 132 Washington St. 82 (2OT)
#> 5     5  Mon Feb 8                          157 Mercer 89, 251 Samford 82 (2OT)
#> 6     6 Sat Feb 27                 328 Lamar 88, 153 Stephen F. Austin 83 (2OT)
#> 7     7 Fri Nov 27                          109 Santa Clara 66, 205 UC Davis 63
#> 8     8 Sun Dec 13                      96 Georgetown 97, 86 St. John's 94 (OT)
#> 9     9 Sat Feb 20                       231 Milwaukee 89, 214 Oakland 87 (2OT)
#> 10   10 Fri Nov 27                                30 Syracuse 85, 312 Bryant 84
#> 11   11 Wed Feb 24                       134 Mercer 81, 152 Chattanooga 77 (OT)
#> 12   12 Sat Feb 27                      40 Oklahoma St. 94, 31 Oklahoma 90 (OT)
#> 13   13  Tue Mar 2                        3 Baylor 94, 19 West Virginia 89 (OT)
#> 14   14 Fri Nov 27                         40 UCLA 107, 100 Pepperdine 98 (3OT)
#> 15   15  Sat Jan 9                                  25 Alabama 94, 81 Auburn 90
#> 16   16  Sat Feb 6                        38 Oklahoma St. 75, 12 Texas 67 (2OT)
#> 17   17 Sat Feb 13                    23 Oklahoma 91, 16 West Virginia 90 (2OT)
#> 18   18  Sun Jan 3               75 Rhode Island 85, 178 Saint Joseph's 77 (OT)
#> 19   19 Sat Jan 16        177 Eastern Kentucky 93, 226 Eastern Illinois 85 (OT)
#> 20   20 Sat Feb 20                  102 Washington St. 85, 57 Stanford 76 (3OT)
#> 21   21 Sat Jan 30                 86 UC Santa Barbara 89, 214 UC Davis 86 (OT)
#> 22   22 Fri Jan 15                      259 Utah Valley 93, 282 Seattle 92 (OT)
#> 23   23  Fri Jan 1       253 Long Beach St. 90, 159 Cal St. Bakersfield 89 (OT)
#> 24   24  Sat Jan 2                            175 Wyoming 78, 180 Fresno St. 74
#> 25   25  Fri Jan 8                        274 Green Bay 84, 270 Oakland 81 (OT)
#> 26   26  Wed Jan 6                                26 LSU 94, 91 Georgia 92 (OT)
#> 27   27  Sat Feb 6                       217 Charleston 90, 272 Towson 88 (2OT)
#> 28   28 Sat Jan 30                            80 Wichita St. 93, 96 UCF 88 (OT)
#> 29   29 Sat Dec 12                    62 Dayton 85, 79 Mississippi St. 82 (2OT)
#> 30   30 Wed Dec 30              139 George Mason 93, 120 Massachusetts 92 (2OT)
#> 31   31 Sat Feb 13                     225 Lafayette 97, 251 Loyola MD 94 (3OT)
#> 32   32  Sat Jan 2                         292 Lehigh 90, 230 Lafayette 89 (OT)
#> 33   33 Fri Mar 12               250 Texas Southern 84, 275 Jackson St. 81 (OT)
#> 34   34  Tue Mar 2       153 Cleveland St. 108, 277 Purdue Fort Wayne 104 (3OT)
#> 35   35 Fri Feb 26                     251 UT Arlington 73, 252 Arkansas St. 71
#> 36   36 Sun Jan 17                         335 Coppin St. 89, 266 Morgan St. 79
#> 37   37 Thu Feb 25             288 Purdue Fort Wayne 89, 236 Green Bay 84 (2OT)
#> 38   38 Fri Jan 22               221 Illinois Chicago 67, 261 Youngstown St. 66
#> 39   39 Thu Nov 26                     66 Auburn 96, 164 Saint Joseph's 91 (OT)
#> 40   40 Fri Nov 27                                  16 Illinois 77, 128 Ohio 75
#> 41   41  Fri Mar 5               108 UC Riverside 72, 284 Cal St. Northridge 68
#> 42   42  Sat Feb 6                    35 Virginia Tech 80, 118 Miami FL 76 (OT)
#> 43   43 Thu Jan 28                    181 Fresno St. 64, 281 New Mexico 62 (OT)
#> 44   44  Fri Mar 5                 112 UC Irvine 71, 278 Long Beach St. 68 (OT)
#> 45   45 Fri Mar 12                229 Montana St. 80, 138 Southern Utah 77 (OT)
#> 46   46 Sat Feb 27               201 Nicholls St. 105, 300 New Orleans 101 (OT)
#> 47   47  Thu Jan 7        176 Eastern Kentucky 69, 230 Jacksonville St. 66 (OT)
#> 48   48  Fri Jan 1                                     256 Rice 95, 174 UTSA 86
#> 49   49  Sat Jan 9                 168 UT Arlington 75, 295 Louisiana Monroe 74
#> 50   50 Wed Nov 25                146 Loyola Marymount 85, 187 Southern Utah 83
#> 51   51 Sun Jan 24                      255 American 81, 247 Loyola MD 79 (3OT)
#> 52   52 Sun Dec 20                      63 Providence 80, 46 Seton Hall 77 (OT)
#> 53   53 Wed Nov 25                       71 St. John's 76, 186 Saint Peter's 75
#> 54   54  Sun Mar 7         222 Appalachian St. 64, 166 Coastal Carolina 61 (OT)
#> 55   55  Mon Mar 8                            20 BYU 82, 116 Pepperdine 77 (OT)
#> 56   56 Wed Mar 10                    115 Arizona St. 64, 107 Washington St. 59
#> 57   57 Sat Jan 16                              145 Akron 95, 68 Toledo 94 (OT)
#> 58   58 Wed Feb 24                              105 Cincinnati 70, 111 Tulsa 69
#> 59   59  Fri Jan 8                           212 Lipscomb 77, 263 Bellarmine 72
#> 60   60 Sat Feb 13      199 Nicholls St. 86, 330 Southeastern Louisiana 84 (OT)
#> 61   61 Thu Feb 18                  326 Tennessee St. 91, 325 Tennessee Tech 86
#> 62   62 Sat Feb 20                               239 The Citadel 75, 151 VMI 74
#> 63   63 Sun Jan 17                 234 Norfolk St. 83, 352 Delaware St. 79 (OT)
#> 64   64 Sat Feb 27              169 Northern Iowa 94, 193 Illinois St. 87 (2OT)
#> 65   65  Tue Mar 2                   147 Miami OH 84, 115 Bowling Green 79 (OT)
#> 66   66 Wed Feb 24               270 Western Carolina 81, 106 UNC Greensboro 80
#> 67   67 Wed Jan 13                                   134 Wofford 80, 244 VMI 78
#> 68   68  Sat Apr 3                                1 Gonzaga 93, 15 UCLA 90 (OT)
#> 69   69 Sat Dec 12                         105 South Florida 58, 135 Wofford 56
#> 70   70 Thu Dec 10                      281 Portland 87, 122 Oregon St. 86 (OT)
#> 71   71 Mon Feb 22 328 Southeastern Louisiana 78, 337 Texas A&M Corpus Chris 75
#> 72   72  Sat Jan 2                         63 Boise St. 87, 314 San Jose St. 86
#> 73   73  Tue Dec 8                   44 Minnesota 85, 85 Boston College 80 (OT)
#> 74   74 Sat Jan 30                    307 Fairleigh Dickinson 81, 178 Bryant 79
#> 75   75 Sat Feb 20                  213 Saint Joseph's 91, 186 La Salle 82 (OT)
#> 76   76 Sat Feb 27                  232 Prairie View A&M 55, 347 Alabama A&M 54
#> 77   77 Sat Feb 13                  212 UC Davis 78, 275 Long Beach St. 76 (OT)
#> 78   78 Sat Nov 28             141 Washington St. 71, 143 Eastern Washington 68
#> 79   79 Sun Mar 14                                      8 Alabama 80, 29 LSU 79
#> 80   80 Sat Jan 30                           32 Oklahoma St. 81, 34 Arkansas 77
#> 81   81 Sat Dec 12                   211 South Alabama 76, 307 Southern Miss 75
#> 82   82  Sat Dec 5              157 Eastern Illinois 93, 278 Green Bay 91 (2OT)
#> 83   83  Fri Feb 5                      315 North Dakota 85, 340 Denver 82 (OT)
#> 84   84 Sun Nov 29                           343 Alabama A&M 78, 309 Samford 76
#> 85   85 Sun Jan 24                                137 Washington 83, 72 Utah 79
#> 86   86 Sat Feb 13                          25 Arkansas 86, 38 Missouri 81 (OT)
#> 87   87  Sat Jan 2                                     5 Iowa 77, 19 Rutgers 75
#> 88   88 Sat Feb 27                         316 Nebraska Omaha 80, 345 Denver 76
#> 89   89 Thu Jan 21                             30 Arizona 84, 73 Arizona St. 82
#> 90   90 Mon Dec 14                              126 Nevada 79, 158 San Diego 72
#> 91   91  Fri Feb 5             253 Youngstown St. 84, 268 Robert Morris 78 (OT)
#> 92   92  Sat Mar 6       285 New Orleans 81, 336 Southeastern Louisiana 76 (OT)
#> 93   93  Sat Jan 2                   324 Northern Arizona 83, 342 Idaho 78 (OT)
#> 94   94 Mon Nov 30                   63 Xavier 99, 204 Eastern Kentucky 96 (OT)
#> 95   95  Mon Feb 1                  232 Western Carolina 76, 290 The Citadel 75
#> 96   96 Sat Jan 30                              47 BYU 95, 132 Pacific 87 (2OT)
#> 97   97  Sat Feb 6                      342 Denver 85, 314 North Dakota 81 (OT)
#> 98   98 Tue Dec 15            304 St. Francis NY 91, 338 Central Connecticut 86
#> 99   99  Tue Jan 5                         32 North Carolina 67, 65 Miami FL 65
#> 100 100 Sun Dec 20                      14 Creighton 76, 45 Connecticut 74 (OT)
#>                                               location   conf excitement year
#> 1                      Atlanta, GA (McCamish Pavilion)              4.74 2021
#> 2                        Cullowhee, NC (Ramsey Center)              3.84 2021
#> 3                         Providence, RI (Alumni Hall)     BE       3.67 2021
#> 4                       Pullman, WA (Beasley Coliseum)    P12       3.65 2021
#> 5                            Macon, GA (Hawkins Arena)     SC       3.63 2021
#> 6                       Beaumont, TX (Montagne Center)   Slnd       3.59 2021
#> 7                      Santa Clara, CA (Leavey Center)              3.58 2021
#> 8                     Washington, DC (McDonough Arena)     BE       3.53 2021
#> 9                    Milwaukee, WI (UWM Panther Arena)   Horz       3.49 2021
#> 10                         Syracuse, NY (Carrier Dome)              3.46 2021
#> 11                           Macon, GA (Hawkins Arena)     SC       3.44 2021
#> 12                     Norman, OK (Lloyd Noble Center)    B12       3.44 2021
#> 13                       Morgantown, WV (WVU Coliseum)    B12       3.44 2021
#> 14                        San Diego, CA (Viejas Arena)              3.42 2021
#> 15                           Auburn, AL (Auburn Arena)    SEC       3.41 2021
#> 16                Stillwater, OK (Gallagher-Iba Arena)    B12       3.41 2021
#> 17                       Morgantown, WV (WVU Coliseum)    B12       3.40 2021
#> 18                          Kingston, RI (Ryan Center)    A10       3.39 2021
#> 19                        Charleston, IL (Lantz Arena)    OVC       3.39 2021
#> 20                      Pullman, WA (Beasley Coliseum)    P12       3.36 2021
#> 21                            Davis, CA (The Pavilion)     BW       3.36 2021
#> 22                        Seattle, WA (Redhawk Center)    WAC       3.35 2021
#> 23                 Long Beach, CA (The Walter Pyramid)     BW       3.33 2021
#> 24                       Fresno, CA (Save Mart Center)    MWC       3.32 2021
#> 25                        Green Bay, WI (Resch Center)   Horz       3.32 2021
#> 26          Baton Rouge, LA (Maravich Assembly Center)    SEC       3.31 2021
#> 27                           Charleston, SC (TD Arena)    CAA       3.29 2021
#> 28                    Wichita, KS (Charles Koch Arena)   Amer       3.28 2021
#> 29                      Atlanta, GA (State Farm Arena)              3.26 2021
#> 30                        Amherst, MA (Mullins Center)    A10       3.25 2021
#> 31                    Easton, PA (Kirby Sports Center)    Pat       3.24 2021
#> 32                       Bethlehem, PA (Stabler Arena)    Pat       3.23 2021
#> 33                       Birmingham, AL (Bartow Arena) SWAC-T       3.23 2021
#> 34                     Cleveland, OH (Wolstein Center) Horz-T       3.23 2021
#> 35                 Arlington, TX (College Park Center)     SB       3.23 2021
#> 36                    Baltimore, MD (Hill Field House)   MEAC       3.19 2021
#> 37                        Green Bay, WI (Resch Center) Horz-T       3.19 2021
#> 38  Youngstown, OH (Beeghly Physical Education Center)   Horz       3.18 2021
#> 39        Fort Myers, FL (Suncoast Credit Union Arena)              3.18 2021
#> 40                   Champaign, IL (State Farm Center)              3.16 2021
#> 41                           Northridge, CA (Matadome)     BW       3.16 2021
#> 42                    Coral Gables, FL (Watsco Center)    ACC       3.16 2021
#> 43                       Fresno, CA (Save Mart Center)    MWC       3.15 2021
#> 44                 Long Beach, CA (The Walter Pyramid)     BW       3.15 2021
#> 45                     Boise, ID (Idaho Central Arena) BSky-T       3.15 2021
#> 46                   New Orleans, LA (Lakefront Arena)   Slnd       3.15 2021
#> 47                       Richmond, KY (McBrayer Arena)    OVC       3.14 2021
#> 48                      Houston, TX (Tudor Fieldhouse)   CUSA       3.14 2021
#> 49                    Monroe, LA (Fant-Ewing Coliseum)     SB       3.13 2021
#> 50                  Los Angeles, CA (Gersten Pavilion)              3.12 2021
#> 51                         Baltimore, MD (Reitz Arena)    Pat       3.12 2021
#> 52                      Newark, NJ (Prudential Center)     BE       3.11 2021
#> 53                      Jamaica, NY (Carnesecca Arena)              3.11 2021
#> 54                Pensacola, FL (Pensacola Bay Center)   SB-T       3.11 2021
#> 55                       Las Vegas, NV (Orleans Arena)  WCC-T       3.10 2021
#> 56                      Las Vegas, NV (T-Mobile Arena)  P12-T       3.10 2021
#> 57                            Akron, OH (Rhodes Arena)    MAC       3.09 2021
#> 58                         Tulsa, OK (Reynolds Center)   Amer       3.09 2021
#> 59                       Louisville, KY (Freedom Hall)   ASun       3.09 2021
#> 60                     Hammond, LA (University Center)   Slnd       3.09 2021
#> 61                       Nashville, TN (Gentry Center)    OVC       3.09 2021
#> 62              Charleston, SC (McAlister Field House)     SC       3.05 2021
#> 63                           Dover, DE (Memorial Hall)   MEAC       3.05 2021
#> 64                          Normal, IL (Redbird Arena)    MVC       3.04 2021
#> 65                    Bowling Green, OH (Stroh Center)    MAC       3.04 2021
#> 66                Greensboro, NC (Greensboro Coliseum)     SC       3.03 2021
#> 67                        Lexington, VA (Cameron Hall)     SC       3.03 2021
#> 68                Indianapolis, IN (Lucas Oil Stadium)   NCAA       3.02 2021
#> 69                      Atlanta, GA (State Farm Arena)              3.02 2021
#> 70                       Corvallis, OR (Gill Coliseum)              3.01 2021
#> 71           Corpus Christi, TX (American Bank Center)   Slnd       2.98 2021
#> 72                             Phoeniz, AZ (GCU Arena)    MWC       2.98 2021
#> 73                    Minneapolis, MN (Williams Arena)              2.97 2021
#> 74                        Teaneck, NJ (Rothman Center)    NEC       2.95 2021
#> 75       Philadelphia, PA (Michael J. Hagan '85 Arena)    A10       2.95 2021
#> 76                       Normal, AL (Elmore Gymnasium)   SWAC       2.94 2021
#> 77                            Davis, CA (The Pavilion)     BW       2.94 2021
#> 78                      Pullman, WA (Beasley Coliseum)              2.94 2021
#> 79                   Nashville, TN (Bridgestone Arena)  SEC-T       2.94 2021
#> 80                Stillwater, OK (Gallagher-Iba Arena)              2.94 2021
#> 81               Hattiesburg, MS (Reed Green Coliseum)              2.94 2021
#> 82                        Green Bay, WI (Resch Center)              2.94 2021
#> 83                     Denver, CO (Hamilton Gymnasium)    Sum       2.94 2021
#> 84                         Homewood, AL (Hanna Center)              2.94 2021
#> 85                 Seattle, WA (Alaska Airlines Arena)    P12       2.93 2021
#> 86                         Columbia, MO (Mizzou Arena)    SEC       2.93 2021
#> 87            Piscataway, NJ (Rutgers Athletic Center)    B10       2.93 2021
#> 88                     Denver, CO (Hamilton Gymnasium)    Sum       2.92 2021
#> 89                  Tempe, AZ (Desert Financial Arena)    P12       2.91 2021
#> 90                San Diego, CA (Jenny Craig Pavilion)              2.90 2021
#> 91              Moon Township, PA (UPMC Events Center)   Horz       2.90 2021
#> 92                   New Orleans, LA (Lakefront Arena)   Slnd       2.90 2021
#> 93                           Moscow, ID (Memorial Gym)   BSky       2.90 2021
#> 94                      Cincinnati, OH (Cintas Center)              2.90 2021
#> 95                       Cullowhee, NC (Ramsey Center)     SC       2.89 2021
#> 96                         Provo, UT (Marriott Center)    WCC       2.89 2021
#> 97                     Denver, CO (Hamilton Gymnasium)    Sum       2.88 2021
#> 98                 New Britain, CT (Detrick Gymnasium)    NEC       2.88 2021
#> 99                    Coral Gables, FL (Watsco Center)    ACC       2.88 2021
#> 100                       Storrs, CT (Gampel Pavilion)     BE       2.88 2021
# }
# \donttest{
try(kp_fanmatch(date = "2022-02-22"))
#> # A tibble: 28 × 20
#>    prediction          time_et location thrill_score comeback excitement road_rk
#>    <chr>               <chr>   <chr>           <dbl>    <dbl>      <dbl>   <dbl>
#>  1 Connecticut 68-67 … "box\n… "Hartfo…         78.6        5       2.83      NA
#>  2 Arkansas 69-68 (52… "box\n… "Gaines…         69.9        8       1.97      NA
#>  3 Alabama 77-74 (60%) "box\n… "Nashvi…         67.7        9       1.85      NA
#>  4 Boise St. 59-56 (5… "box\n… "Boise,…         65.3        6       1.98      NA
#>  5 Iowa 81-75 (71%)    "box\n… "Iowa C…         65.2        2      -0.1       NA
#>  6 UNLV 75-74 (51%)    "box\n… "Reno, …         53.7        6       1.3       NA
#>  7 Texas Tech 70-60 (… "box\n… "Lubboc…         51.5        0      -0.09      NA
#>  8 Miami FL 72-68 (65… "box\n… "Pittsb…         46.1        0      -0.3       NA
#>  9 Kansas 78-66 (86%)  "box\n… "Lawren…         45.6        3       0.3       NA
#> 10 Tennessee 71-60 (8… "box\n… "Columb…         41.9        4       0.35      NA
#> # ℹ 18 more rows
#> # ℹ 13 more variables: road_team <chr>, home_rk <dbl>, home_team <chr>,
#> #   win_rk <dbl>, win_team <chr>, win_score <dbl>, loss_rk <dbl>,
#> #   loss_team <chr>, loss_score <dbl>, poss <dbl>, mvp <chr>, event <chr>,
#> #   date <chr>
# }
```
