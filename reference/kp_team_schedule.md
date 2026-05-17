# **Get team schedule results**

**Get team schedule results**

## Usage

``` r
kp_team_schedule(team, year = 2022)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of team schedules

|                   |           |                                     |
|-------------------|-----------|-------------------------------------|
| col_name          | types     | description                         |
| team_rk           | numeric   | Team rk.                            |
| team              | character | Team-side label or team identifier. |
| opponent_rk       | numeric   | Opponent rk.                        |
| opponent          | character | Opponent.                           |
| result            | character | Result.                             |
| poss              | numeric   | Poss.                               |
| ot                | numeric   | Ot.                                 |
| pre_wp            | numeric   | Pre wp.                             |
| location          | character | Location.                           |
| w                 | numeric   | Wins.                               |
| l                 | numeric   | Losses.                             |
| w_conference      | numeric   | W conference.                       |
| l_conference      | numeric   | L conference.                       |
| conference_game   | logical   | Conference game.                    |
| postseason        | character | Postseason.                         |
| year              | numeric   | 4-digit year.                       |
| day_date          | character | Date in YYYY-MM-DD format.          |
| game_date         | numeric   | Game date (YYYY-MM-DD).             |
| w_proj            | numeric   | W proj.                             |
| l_proj            | numeric   | L proj.                             |
| w_conference_proj | numeric   | W conference proj.                  |
| l_conference_proj | numeric   | L conference proj.                  |
| date              | character | Date in YYYY-MM-DD format.          |
| game_id           | numeric   | Unique game identifier.             |
| tiers_of_joy      | character | Tiers of joy.                       |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md)

## Examples

``` r
# \donttest{
  try(kp_team_schedule(team = 'Florida St.', year = 2022))
#>    team_rk        team opponent_rk          opponent    result poss ot pre_wp
#> 1       24 Florida St.         211              Penn W, 105-70   80  0     NA
#> 2       23 Florida St.          59           Florida  L, 71-55   68  0     NA
#> 3       31 Florida St.          98            Tulane  W, 59-54   63  0     NA
#> 4       32 Florida St.         203  Loyola Marymount  W, 73-45   70  0     NA
#> 5       27 Florida St.         137          Missouri  W, 81-58   67  0     NA
#> 6       23 Florida St.         218 Boston University  W, 81-80   74  1     NA
#> 7       29 Florida St.          14            Purdue  L, 93-65   68  0     NA
#> 8       32 Florida St.          69          Syracuse  L, 63-60   69  0     NA
#> 9       40 Florida St.          99    South Carolina  L, 66-65   71  0     NA
#> 10      41 Florida St.         264          Lipscomb  W, 97-60   77  0     NA
#> 11      39 Florida St.         128        N.C. State  W, 83-81   71  0     NA
#> 12      42 Florida St.          35       Wake Forest  L, 76-54   78  0     NA
#> 13      47 Florida St.         127        Louisville  W, 79-70   68  0     NA
#> 14      46 Florida St.          41          Miami FL  W, 65-64   62  0     NA
#> 15      53 Florida St.          69          Syracuse  W, 76-71   63  0     NA
#> 16      54 Florida St.           8              Duke  W, 79-78   71  1     NA
#> 17      49 Florida St.         272     North Florida  W, 86-73   72  0     NA
#> 18      53 Florida St.          41          Miami FL  W, 61-60   64  0     NA
#> 19      53 Florida St.         156      Georgia Tech  L, 75-61   66  0     NA
#> 20      71 Florida St.          19     Virginia Tech  L, 85-72   62  0     NA
#> 21      78 Florida St.          71           Clemson  L, 75-69   66  0     NA
#> 22      85 Florida St.          35       Wake Forest  L, 68-60   76  0     NA
#> 23      86 Florida St.         195        Pittsburgh  L, 56-51   66  0     NA
#> 24      95 Florida St.          16    North Carolina  L, 94-74   75  0     NA
#> 25     100 Florida St.          71           Clemson  W, 81-80   70  0     NA
#> 26     101 Florida St.           8              Duke  L, 88-70   67  0     NA
#> 27     100 Florida St.         114    Boston College  L, 71-55   67  0     NA
#> 28     110 Florida St.          72          Virginia  W, 64-63   62  0     NA
#> 29     104 Florida St.          38        Notre Dame  W, 74-70   69  0     NA
#> 30     105 Florida St.         128        N.C. State  W, 89-76   69  0     NA
#> 31     101 Florida St.          69          Syracuse  L, 96-57   71  0     NA
#>     location  w  l w_conference l_conference conference_game
#> 1       Home  1  0           NA           NA           FALSE
#> 2       Away  1  1           NA           NA           FALSE
#> 3       Home  2  1           NA           NA           FALSE
#> 4    Neutral  3  1           NA           NA           FALSE
#> 5    Neutral  4  1           NA           NA           FALSE
#> 6       Home  5  1           NA           NA           FALSE
#> 7       Away  5  2           NA           NA           FALSE
#> 8       Home  5  3            0            1            TRUE
#> 9  Semi-Away  5  4           NA           NA           FALSE
#> 10      Home  6  4           NA           NA           FALSE
#> 11      Away  7  4            1            1            TRUE
#> 12      Away  7  5            1            2            TRUE
#> 13      Home  8  5            2            2            TRUE
#> 14      Home  9  5            3            2            TRUE
#> 15      Away 10  5            4            2            TRUE
#> 16      Home 11  5            5            2            TRUE
#> 17      Home 12  5           NA           NA           FALSE
#> 18      Away 13  5            6            2            TRUE
#> 19      Away 13  6            6            3            TRUE
#> 20      Home 13  7            6            4            TRUE
#> 21      Away 13  8            6            5            TRUE
#> 22      Home 13  9            6            6            TRUE
#> 23      Home 13 10            6            7            TRUE
#> 24      Away 13 11            6            8            TRUE
#> 25      Home 14 11            7            8            TRUE
#> 26      Away 14 12            7            9            TRUE
#> 27      Away 14 13            7           10            TRUE
#> 28      Away 15 13            8           10            TRUE
#> 29      Home 16 13            9           10            TRUE
#> 30      Home 17 13           10           10            TRUE
#> 31   Neutral 17 14           NA           NA           FALSE
#>                              postseason year   day_date game_date w_proj l_proj
#> 1                               Regular 2022 Wed Nov 10  20211110      1      0
#> 2                               Regular 2022 Sun Nov 14  20211114      1      1
#> 3                               Regular 2022 Wed Nov 17  20211117      2      1
#> 4                               Regular 2022 Sun Nov 21  20211121      3      1
#> 5                               Regular 2022 Mon Nov 22  20211122      4      1
#> 6                               Regular 2022 Wed Nov 24  20211124      5      1
#> 7                               Regular 2022 Tue Nov 30  20211130      5      2
#> 8                               Regular 2022  Sat Dec 4  20211204      5      3
#> 9                               Regular 2022 Sun Dec 12  20211212      5      4
#> 10                              Regular 2022 Wed Dec 15  20211215      6      4
#> 11                              Regular 2022  Sat Jan 1  20220101      7      4
#> 12                              Regular 2022  Tue Jan 4  20220104      7      5
#> 13                              Regular 2022  Sat Jan 8  20220108      8      5
#> 14                              Regular 2022 Tue Jan 11  20220111      9      5
#> 15                              Regular 2022 Sat Jan 15  20220115     10      5
#> 16                              Regular 2022 Tue Jan 18  20220118     11      5
#> 17                              Regular 2022 Thu Jan 20  20220120     12      5
#> 18                              Regular 2022 Sat Jan 22  20220122     13      5
#> 19                              Regular 2022 Wed Jan 26  20220126     13      6
#> 20                              Regular 2022 Sat Jan 29  20220129     13      7
#> 21                              Regular 2022  Wed Feb 2  20220202     13      8
#> 22                              Regular 2022  Sat Feb 5  20220205     13      9
#> 23                              Regular 2022  Wed Feb 9  20220209     13     10
#> 24                              Regular 2022 Sat Feb 12  20220212     13     11
#> 25                              Regular 2022 Tue Feb 15  20220215     14     11
#> 26                              Regular 2022 Sat Feb 19  20220219     14     12
#> 27                              Regular 2022 Mon Feb 21  20220221     14     13
#> 28                              Regular 2022 Sat Feb 26  20220226     15     13
#> 29                              Regular 2022  Wed Mar 2  20220302     16     13
#> 30                              Regular 2022  Sat Mar 5  20220305     17     13
#> 31 Atlantic Coast Conference Tournament 2022  Wed Mar 9  20220309     17     14
#>    w_conference_proj l_conference_proj       date game_id tiers_of_joy
#> 1                  0                 0 2021-11-10     188         <NA>
#> 2                  0                 0 2021-11-14     425            A
#> 3                  0                 0 2021-11-17     574         <NA>
#> 4                  0                 0 2021-11-21     790         <NA>
#> 5                  0                 0 2021-11-22    5602         <NA>
#> 6                  0                 0 2021-11-24     945         <NA>
#> 7                  0                 0 2021-11-30    1193            A
#> 8                  0                 1 2021-12-04    1358         <NA>
#> 9                  0                 1 2021-12-12    1766            B
#> 10                 0                 1 2021-12-15    1860         <NA>
#> 11                 1                 1 2022-01-01    2443            B
#> 12                 1                 2 2022-01-04    2587            A
#> 13                 2                 2 2022-01-08    2833         <NA>
#> 14                 3                 2 2022-01-11    2936            B
#> 15                 4                 2 2022-01-15    3203            A
#> 16                 5                 2 2022-01-18    3249            A
#> 17                 5                 2 2022-01-20    2491         <NA>
#> 18                 6                 2 2022-01-22    3528            A
#> 19                 6                 3 2022-01-26    3641         <NA>
#> 20                 6                 4 2022-01-29    3842            A
#> 21                 6                 5 2022-02-02    3956            A
#> 22                 6                 6 2022-02-05    4154            B
#> 23                 6                 7 2022-02-09    4312         <NA>
#> 24                 6                 8 2022-02-12    4543            A
#> 25                 7                 8 2022-02-15    4605         <NA>
#> 26                 7                 9 2022-02-19    4798            A
#> 27                 7                10 2022-02-21    2402            B
#> 28                 8                10 2022-02-26    5236            A
#> 29                 9                10 2022-03-02    5301            B
#> 30                10                10 2022-03-05    5438         <NA>
#> 31                10                10 2022-03-09    3845            B
# }
```
