# **Get KenPom's historical conference ratings**

**Get KenPom's historical conference ratings**

## Usage

``` r
kp_confhistory(conf)
```

## Arguments

- conf:

  Used to limit to players in a specific conference.

  Allowed values are: 'A10', 'ACC', 'AE', 'AMER', 'ASUN', 'B10', 'B12',
  'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY',
  'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB',
  'SC', 'SEC', 'SLND', 'SUM', 'SWAC', 'WAC', 'WCC'.

  If you try to use a conference that doesn't exist for a given season,
  like 'IND' and '2018', you'll get an empty table, as kenpom.com
  doesn't serve 404 pages for invalid table queries like that. No filter
  applied by default.

## Value

A data frame with the following columns:

|                  |           |                                          |
|------------------|-----------|------------------------------------------|
| col_name         | types     | description                              |
| year             | integer   | 4-digit year.                            |
| rank             | character | Rank.                                    |
| tempo            | numeric   | Tempo.                                   |
| efficiency       | numeric   | Efficiency.                              |
| e_fg_pct         | numeric   | E field goals percentage (0-1 decimal).  |
| to_pct           | numeric   | To percentage (0-1 decimal).             |
| or_pct           | numeric   | Or percentage (0-1 decimal).             |
| ft_rate          | numeric   | Ft rate.                                 |
| fg_2_pct         | numeric   | Field goals 2 percentage (0-1 decimal).  |
| fg_3_pct         | numeric   | Field goals 3 percentage (0-1 decimal).  |
| ft_pct           | numeric   | Free throw percentage (0-1).             |
| fg_3a_pct        | numeric   | Field goals 3a percentage (0-1 decimal). |
| a_pct            | numeric   | A percentage (0-1 decimal).              |
| blk_pct          | numeric   | Blocks percentage (0-1 decimal).         |
| stl_pct          | numeric   | Steals percentage (0-1 decimal).         |
| home_record      | character | Home win-loss record.                    |
| bids             | character | Bids.                                    |
| s16              | character | S16.                                     |
| f4               | character | F4.                                      |
| ch               | character | Ch.                                      |
| reg_season_champ | character | Reg season champ.                        |
| tourney_champ    | character | Tourney champ.                           |
| best_team        | character | Best team.                               |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_confhistory(conf = 'ACC'))
#>    year                                                   rank tempo efficiency
#> 1  2026                                                      4  67.5      110.4
#> 2  2025                                                      5  66.4      108.6
#> 3    NA    Added: California (P12), SMU (Amer), Stanford (P12)    NA         NA
#> 4  2024                                                      5  67.8      106.7
#> 5  2023                                                      7  67.4      106.4
#> 6  2022                                                      5  66.2      105.9
#> 7  2021                                                      5  67.2      104.1
#> 8  2020                                                      4  68.0      100.9
#> 9  2019                                                      3  67.3      102.2
#> 10 2018                                                      2  67.2      105.0
#> 11 2017                                                      2  68.0      107.9
#> 12 2016                                                      2  66.4      106.0
#> 13 2015                                                      3  63.3      104.2
#> 14   NA       Dropped: Maryland (B10) Added: Louisville (Amer)    NA         NA
#> 15 2014                                                      3  61.8      105.2
#> 16   NA Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)    NA         NA
#> 17 2013                                                      6  65.5      101.6
#> 18 2012                                                      5  65.1      100.2
#> 19 2011                                                      3  67.2      101.7
#> 20 2010                                                      2  67.8      100.5
#> 21 2009                                                      5  69.8      104.2
#> 22 2008                                                      3  71.0      104.8
#> 23 2007                                                      1  68.1      105.8
#> 24 2006                                                      3  68.6      104.7
#> 25   NA                             Added: Boston College (BE)    NA         NA
#> 26 2005                                                      1  70.6      104.8
#> 27   NA               Added: Miami FL (BE), Virginia Tech (BE)    NA         NA
#> 28 2004                                                      1  70.1      103.0
#> 29 2003                                                      3  69.6      102.5
#> 30 2002                                                      3  74.2      106.3
#> 31 2001                                                      1  73.7      103.7
#> 32 2000                                                      3  70.0      102.2
#> 33 1999                                                      2  69.8      101.7
#> 34 1998                                                      1  68.7      102.5
#> 35 1997                                                      1  65.1      100.2
#>    e_fg_pct to_pct or_pct ft_rate fg_2_pct fg_3_pct ft_pct fg_3a_pct a_pct
#> 1      52.3   15.7   29.8    32.7     52.6     34.6   72.5      42.5  52.1
#> 2      51.6   16.3   29.6    31.4     51.0     35.0   74.9      38.0  51.0
#> 3        NA     NA     NA      NA       NA       NA     NA        NA    NA
#> 4      51.2   15.8   27.1    30.0     50.3     35.1   73.9      37.6  50.0
#> 5      51.2   16.0   27.2    28.4     50.6     34.8   75.0      38.2  52.4
#> 6      51.4   16.7   27.7    27.0     50.6     35.1   73.8      38.2  53.5
#> 7      51.2   17.9   28.1    27.8     50.5     34.8   72.3      37.8  53.4
#> 8      49.0   18.1   28.5    30.6     48.8     32.8   72.0      37.4  52.2
#> 9      48.8   18.0   29.9    30.8     48.2     33.2   72.2      40.0  53.5
#> 10     50.8   17.4   29.4    30.1     48.8     36.0   72.3      37.8  54.3
#> 11     52.1   17.2   29.6    32.8     50.0     37.2   72.2      35.5  52.6
#> 12     49.9   17.3   31.6    34.0     49.0     34.5   71.4      33.7  52.3
#> 13     49.1   16.9   31.4    33.8     47.7     34.7   68.5      32.6  55.0
#> 14       NA     NA     NA      NA       NA       NA     NA        NA    NA
#> 15     48.8   17.1   33.1    38.3     47.5     34.3   68.2      32.5  51.9
#> 16       NA     NA     NA      NA       NA       NA     NA        NA    NA
#> 17     49.1   18.4   30.6    33.1     47.7     34.9   68.6      31.2  49.9
#> 18     47.9   18.8   31.4    33.1     46.7     33.7   69.9      31.9  50.1
#> 19     48.4   19.0   30.7    33.4     46.8     34.6   70.6      32.1  52.5
#> 20     47.0   20.0   33.5    36.5     46.2     32.8   70.2      29.3  51.9
#> 21     49.2   19.9   34.2    34.5     47.7     35.1   72.3      31.6  51.5
#> 22     50.2   19.9   32.8    36.9     48.9     35.5   70.8      31.4  50.3
#> 23     51.0   19.9   33.4    36.8     50.0     35.4   70.0      30.0  52.3
#> 24     50.5   21.0   33.7    38.0     48.4     36.7   71.4      31.6  55.7
#> 25       NA     NA     NA      NA       NA       NA     NA        NA    NA
#> 26     50.0   20.2   33.6    38.9     48.2     35.9   69.6      32.2  51.8
#> 27       NA     NA     NA      NA       NA       NA     NA        NA    NA
#> 28     49.6   21.9   35.7    39.9     48.1     35.0   69.8      33.8  54.9
#> 29     49.3   20.9   33.2    36.1     47.9     34.9   70.6      33.0  55.0
#> 30     51.9   20.2   33.7    37.7     50.9     36.0   70.8      33.1  56.9
#> 31     49.8   19.8   33.9    37.7     47.5     36.5   69.7      30.8  54.1
#> 32     49.0   20.7   35.3    35.3     47.2     35.5   69.6      29.7  54.5
#> 33     49.7   22.3   36.1    37.6     49.3     33.7   68.8      32.0  56.0
#> 34     49.6   21.1   34.8    40.6     49.1     33.9   68.2      30.0  54.2
#> 35     48.0   21.4   36.3    35.9     47.0     33.4   68.0      30.4  54.1
#>    blk_pct stl_pct                                            home_record
#> 1      9.9     9.2                                                  94-68
#> 2      9.2     9.1                                                 113-67
#> 3       NA      NA    Added: California (P12), SMU (Amer), Stanford (P12)
#> 4      9.4     8.9                                                  92-58
#> 5      9.9     8.3                                                  96-54
#> 6      9.5     9.4                                                  83-67
#> 7     10.7     9.7                                                  80-41
#> 8     10.0     9.2                                                  91-59
#> 9     10.8     9.0                                                  80-55
#> 10    10.8     8.8                                                  85-50
#> 11    10.0     8.5                                                  93-42
#> 12     9.6     8.7                                                  89-46
#> 13    10.0     8.7                                                  76-59
#> 14      NA      NA       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15    10.1     8.5                                                  77-58
#> 16      NA      NA Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17    10.1     8.8                                                  74-34
#> 18    10.0     9.1                                                  58-38
#> 19    10.3     9.5                                                  63-33
#> 20    10.3     9.8                                                  66-30
#> 21    10.7    10.2                                                  61-35
#> 22    10.8     9.7                                                  58-38
#> 23     9.6     9.7                                                  63-33
#> 24    10.4    10.7                                                  60-36
#> 25      NA      NA                             Added: Boston College (BE)
#> 26    10.7    10.7                                                  55-33
#> 27      NA      NA               Added: Miami FL (BE), Virginia Tech (BE)
#> 28    10.9    11.0                                                  47-25
#> 29    10.7    10.5                                                  53-19
#> 30     8.0    10.2                                                  46-26
#> 31     9.4     9.5                                                  44-28
#> 32     9.8     9.8                                                  46-26
#> 33    10.4    10.6                                                  47-25
#> 34     9.8     9.7                                                  41-30
#> 35     8.9     9.9                                                  45-27
#>                                                      bids
#> 1                                                       8
#> 2                                                       4
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                                       5
#> 5                                                       5
#> 6                                                       5
#> 7                                                       7
#> 8                                                      5*
#> 9                                                       7
#> 10                                                      9
#> 11                                                      9
#> 12                                                      7
#> 13                                                      6
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                                      6
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                                      4
#> 18                                                      5
#> 19                                                      4
#> 20                                                      6
#> 21                                                      7
#> 22                                                      4
#> 23                                                      7
#> 24                                                      4
#> 25                             Added: Boston College (BE)
#> 26                                                      5
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                      6
#> 29                                                      4
#> 30                                                      4
#> 31                                                      6
#> 32                                                      3
#> 33                                                      3
#> 34                                                      5
#> 35                                                      6
#>                                                       s16
#> 1                                                       1
#> 2                                                       1
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                                       4
#> 5                                                       1
#> 6                                                       3
#> 7                                                       2
#> 8                                           No tournament
#> 9                                                       5
#> 10                                                      4
#> 11                                                      1
#> 12                                                      6
#> 13                                                      5
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                                      1
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                                      2
#> 18                                                      2
#> 19                                                      3
#> 20                                                      1
#> 21                                                      2
#> 22                                                      1
#> 23                                                      1
#> 24                                                      2
#> 25                             Added: Boston College (BE)
#> 26                                                      3
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                      3
#> 29                                                      2
#> 30                                                      2
#> 31                                                      2
#> 32                                                      2
#> 33                                                      2
#> 34                                                      3
#> 35                                                      2
#>                                                        f4
#> 1                                                       0
#> 2                                                       1
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                                       1
#> 5                                                       1
#> 6                                                       2
#> 7                                                       0
#> 8                                           No tournament
#> 9                                                       1
#> 10                                                      0
#> 11                                                      1
#> 12                                                      2
#> 13                                                      1
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                                      0
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                                      0
#> 18                                                      0
#> 19                                                      0
#> 20                                                      1
#> 21                                                      1
#> 22                                                      1
#> 23                                                      0
#> 24                                                      0
#> 25                             Added: Boston College (BE)
#> 26                                                      1
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                      2
#> 29                                                      0
#> 30                                                      1
#> 31                                                      2
#> 32                                                      1
#> 33                                                      1
#> 34                                                      1
#> 35                                                      1
#>                                                        ch
#> 1                                                       0
#> 2                                                       0
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                                       0
#> 5                                                       0
#> 6                                                       0
#> 7                                                       0
#> 8                                           No tournament
#> 9                                                       1
#> 10                                                      0
#> 11                                                      1
#> 12                                                      0
#> 13                                                      1
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                                      0
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                                      0
#> 18                                                      0
#> 19                                                      0
#> 20                                                      1
#> 21                                                      1
#> 22                                                      0
#> 23                                                      0
#> 24                                                      0
#> 25                             Added: Boston College (BE)
#> 26                                                      1
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                      0
#> 29                                                      0
#> 30                                                      1
#> 31                                                      1
#> 32                                                      0
#> 33                                                      0
#> 34                                                      0
#> 35                                                      0
#>                                          reg_season_champ
#> 1                                                  Duke 1
#> 2                                                  Duke 1
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                        North Carolina 1
#> 5                                               2-way tie
#> 6                                                  Duke 2
#> 7                                              Virginia 4
#> 8                                          Florida St. 2*
#> 9                                               2-way tie
#> 10                                             Virginia 1
#> 11                                       North Carolina 1
#> 12                                       North Carolina 1
#> 13                                             Virginia 2
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                             Virginia 1
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                             Miami FL 2
#> 18                                       North Carolina 1
#> 19                                       North Carolina 2
#> 20                                              2-way tie
#> 21                                       North Carolina 1
#> 22                                       North Carolina 1
#> 23                                              2-way tie
#> 24                                                 Duke 1
#> 25                             Added: Boston College (BE)
#> 26                                       North Carolina 1
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                 Duke 1
#> 29                                          Wake Forest 2
#> 30                                             Maryland 1
#> 31                                              2-way tie
#> 32                                                 Duke 1
#> 33                                                 Duke 1
#> 34                                                 Duke 1
#> 35                                                 Duke 2
#>                                             tourney_champ
#> 1                                                  Duke 1
#> 2                                                  Duke 1
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                           N.C. State 11
#> 5                                                  Duke 5
#> 6                                        Virginia Tech 11
#> 7                                          Georgia Tech 9
#> 8                                                        
#> 9                                                  Duke 1
#> 10                                             Virginia 1
#> 11                                                 Duke 2
#> 12                                       North Carolina 1
#> 13                                           Notre Dame 3
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                             Virginia 1
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                             Miami FL 2
#> 18                                          Florida St. 3
#> 19                                                 Duke 1
#> 20                                                 Duke 1
#> 21                                                 Duke 2
#> 22                                       North Carolina 1
#> 23                                       North Carolina 1
#> 24                                                 Duke 1
#> 25                             Added: Boston College (BE)
#> 26                                                 Duke 1
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                             Maryland 4
#> 29                                                 Duke 3
#> 30                                                 Duke 1
#> 31                                                 Duke 1
#> 32                                                 Duke 1
#> 33                                                 Duke 1
#> 34                                       North Carolina 1
#> 35                                       North Carolina 1
#>                                                 best_team
#> 1                                                  Duke 1
#> 2                                                  Duke 1
#> 3     Added: California (P12), SMU (Amer), Stanford (P12)
#> 4                                                  Duke 4
#> 5                                                  Duke 5
#> 6                                                  Duke 2
#> 7                                           Florida St. 4
#> 8                                                 Duke 3*
#> 9                                              Virginia 1
#> 10                                             Virginia 1
#> 11                                       North Carolina 1
#> 12                                       North Carolina 1
#> 13                                                 Duke 1
#> 14       Dropped: Maryland (B10) Added: Louisville (Amer)
#> 15                                             Virginia 1
#> 16 Added: Notre Dame (BE), Pittsburgh (BE), Syracuse (BE)
#> 17                                                 Duke 2
#> 18                                       North Carolina 1
#> 19                                                 Duke 1
#> 20                                                 Duke 1
#> 21                                       North Carolina 1
#> 22                                       North Carolina 1
#> 23                                       North Carolina 1
#> 24                                                 Duke 1
#> 25                             Added: Boston College (BE)
#> 26                                       North Carolina 1
#> 27               Added: Miami FL (BE), Virginia Tech (BE)
#> 28                                                 Duke 1
#> 29                                                 Duke 3
#> 30                                                 Duke 1
#> 31                                                 Duke 1
#> 32                                                 Duke 1
#> 33                                                 Duke 1
#> 34                                                 Duke 1
#> 35                                       North Carolina 1
# }
```
