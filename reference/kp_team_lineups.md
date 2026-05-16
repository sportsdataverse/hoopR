# **Get Lineups Last 5 Games from Team Page**

**Get Lineups Last 5 Games from Team Page**

## Usage

``` r
kp_team_lineups(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| year                 | numeric   |
| team                 | character |
| min_pct              | numeric   |
| pg_number            | numeric   |
| pg_player_first_name | character |
| pg_player_last_name  | character |
| pg_hgt               | character |
| pg_wgt               | numeric   |
| pg_yr                | character |
| sg_number            | numeric   |
| sg_player_first_name | character |
| sg_player_last_name  | character |
| sg_hgt               | character |
| sg_wgt               | numeric   |
| sg_yr                | character |
| sf_number            | numeric   |
| sf_player_first_name | character |
| sf_player_last_name  | character |
| sf_hgt               | character |
| sf_wgt               | numeric   |
| sf_yr                | character |
| pf_number            | numeric   |
| pf_player_first_name | character |
| pf_player_last_name  | character |
| pf_hgt               | character |
| pf_wgt               | numeric   |
| pf_yr                | character |
| c_number             | numeric   |
| c_player_first_name  | character |
| c_player_last_name   | character |
| c_hgt                | character |
| c_wgt                | numeric   |
| c_yr                 | character |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_lineups(team = 'Florida St.', year = 2021))
#>    year        team min_pct pg_number pg_player_first_name pg_player_last_name
#> 1  2021 Florida St.   0.131        23                   MJ              Walker
#> 2  2021 Florida St.   0.110        23                   MJ              Walker
#> 3  2021 Florida St.   0.077        23                   MJ              Walker
#> 4  2021 Florida St.   0.046        23                   MJ              Walker
#> 5  2021 Florida St.   0.045         4              Scottie              Barnes
#> 6  2021 Florida St.   0.030        23                   MJ              Walker
#> 7  2021 Florida St.   0.028        23                   MJ              Walker
#> 8  2021 Florida St.   0.027         4              Scottie              Barnes
#> 9  2021 Florida St.   0.024        23                   MJ              Walker
#> 10 2021 Florida St.   0.022         4              Scottie              Barnes
#> 11 2021 Florida St.   0.032        NA              UNKNOWN                <NA>
#>    pg_hgt pg_wgt pg_yr sg_number sg_player_first_name sg_player_last_name
#> 1     6-5    213    Sr         2              Anthony              Polite
#> 2     6-5    213    Sr         0              RayQuan               Evans
#> 3     6-5    213    Sr         2              Anthony              Polite
#> 4     6-5    213    Sr         2              Anthony              Polite
#> 5     6-9    227    Fr        24              Sardaar             Calhoun
#> 6     6-5    213    Sr        24              Sardaar             Calhoun
#> 7     6-5    213    Sr         2              Anthony              Polite
#> 8     6-9    227    Fr        24              Sardaar             Calhoun
#> 9     6-5    213    Sr         0              RayQuan               Evans
#> 10    6-9    227    Fr        24              Sardaar             Calhoun
#> 11   <NA>     NA              NA                 <NA>                <NA>
#>    sg_hgt sg_wgt sg_yr sf_number sf_player_first_name sf_player_last_name
#> 1     6-6    215    Jr         4              Scottie              Barnes
#> 2     6-4    210    Sr         2              Anthony              Polite
#> 3     6-6    215    Jr         4              Scottie              Barnes
#> 4     6-6    215    Jr         4              Scottie              Barnes
#> 5     6-6    220    Jr         2              Anthony              Polite
#> 6     6-6    220    Jr         4              Scottie              Barnes
#> 7     6-6    215    Jr         4              Scottie              Barnes
#> 8     6-6    220    Jr         2              Anthony              Polite
#> 9     6-4    210    Sr         2              Anthony              Polite
#> 10    6-6    220    Jr         2              Anthony              Polite
#> 11   <NA>     NA              NA                 <NA>                <NA>
#>    sf_hgt sf_wgt sf_yr pf_number pf_player_first_name pf_player_last_name
#> 1     6-9    227    Fr         1              RaiQuan                Gray
#> 2     6-6    215    Jr         1              RaiQuan                Gray
#> 3     6-9    227    Fr        10                Malik             Osborne
#> 4     6-9    227    Fr        10                Malik             Osborne
#> 5     6-6    215    Jr        10                Malik             Osborne
#> 6     6-9    227    Fr         1              RaiQuan                Gray
#> 7     6-9    227    Fr         1              RaiQuan                Gray
#> 8     6-6    215    Jr        10                Malik             Osborne
#> 9     6-6    215    Jr         4              Scottie              Barnes
#> 10    6-6    215    Jr        10                Malik             Osborne
#> 11   <NA>     NA              NA                 <NA>                <NA>
#>    pf_hgt pf_wgt pf_yr c_number c_player_first_name c_player_last_name c_hgt
#> 1     6-8    260    Jr        5               Balsa          Koprivica   7-1
#> 2     6-8    260    Jr        5               Balsa          Koprivica   7-1
#> 3     6-9    225    Jr        1             RaiQuan               Gray   6-8
#> 4     6-9    225    Jr        5               Balsa          Koprivica   7-1
#> 5     6-9    225    Jr       34               Tanor               Ngom   7-2
#> 6     6-8    260    Jr        5               Balsa          Koprivica   7-1
#> 7     6-8    260    Jr       34               Tanor               Ngom   7-2
#> 8     6-9    225    Jr        5               Balsa          Koprivica   7-1
#> 9     6-9    227    Fr        1             RaiQuan               Gray   6-8
#> 10    6-9    225    Jr        1             RaiQuan               Gray   6-8
#> 11   <NA>     NA             NA                <NA>               <NA>  <NA>
#>    c_wgt c_yr
#> 1    240   So
#> 2    240   So
#> 3    260   Jr
#> 4    240   So
#> 5    236   Sr
#> 6    240   So
#> 7    236   Sr
#> 8    240   So
#> 9    260   Jr
#> 10   260   Jr
#> 11    NA <NA>
  # }
```
