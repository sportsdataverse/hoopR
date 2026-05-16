# **Get Depth Chart Last 5 Games from Team Page**

**Get Depth Chart Last 5 Games from Team Page**

## Usage

``` r
kp_team_depth_chart(team, year = 2021)
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
| pg_number            | numeric   |
| pg_player_first_name | character |
| pg_player_last_name  | character |
| pg_hgt               | character |
| pg_wgt               | numeric   |
| pg_yr                | character |
| pg_min_pct           | numeric   |
| sg_number            | numeric   |
| sg_player_first_name | character |
| sg_player_last_name  | character |
| sg_hgt               | character |
| sg_wgt               | numeric   |
| sg_yr                | character |
| sg_min_pct           | numeric   |
| sf_number            | numeric   |
| sf_player_first_name | character |
| sf_player_last_name  | character |
| sf_hgt               | character |
| sf_wgt               | numeric   |
| sf_yr                | character |
| sf_min_pct           | numeric   |
| pf_number            | numeric   |
| pf_player_first_name | character |
| pf_player_last_name  | character |
| pf_hgt               | character |
| pf_wgt               | numeric   |
| pf_yr                | character |
| pf_min_pct           | numeric   |
| c_number             | numeric   |
| c_player_first_name  | character |
| c_player_last_name   | character |
| c_hgt                | character |
| c_wgt                | numeric   |
| c_yr                 | character |
| c_min_pct            | numeric   |
| team                 | character |
| year                 | numeric   |

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_team_depth_chart(team = 'Florida St.', year= 2021))
#>   pg_number pg_player_first_name pg_player_last_name pg_hgt pg_wgt pg_yr
#> 1        23                   MJ              Walker    6-5    213    Sr
#> 2         4              Scottie              Barnes    6-9    227    Fr
#> 3         0              RayQuan               Evans    6-4    210    Sr
#> 4        NA                 <NA>                <NA>   <NA>     NA      
#>   pg_min_pct sg_number sg_player_first_name sg_player_last_name sg_hgt sg_wgt
#> 1       0.71         2              Anthony              Polite    6-6    215
#> 2       0.22         0              RayQuan               Evans    6-4    210
#> 3       0.06        24              Sardaar             Calhoun    6-6    220
#> 4         NA        11            Nathanael                Jack    6-5    195
#>   sg_yr sg_min_pct sf_number sf_player_first_name sf_player_last_name sf_hgt
#> 1    Jr       0.35         4              Scottie              Barnes    6-9
#> 2    Sr       0.29         2              Anthony              Polite    6-6
#> 3    Jr       0.26        31                Wyatt              Wilkes    6-8
#> 4    Sr       0.08        24              Sardaar             Calhoun    6-6
#>   sf_wgt sf_yr sf_min_pct pf_number pf_player_first_name pf_player_last_name
#> 1    227    Fr       0.42        10                Malik             Osborne
#> 2    215    Jr       0.35         1              RaiQuan                Gray
#> 3    220    Jr       0.13        31                Wyatt              Wilkes
#> 4    220    Jr       0.07        NA                 <NA>                <NA>
#>   pf_hgt pf_wgt pf_yr pf_min_pct c_number c_player_first_name
#> 1    6-9    225    Jr       0.50        5               Balsa
#> 2    6-8    260    Jr       0.41        1             RaiQuan
#> 3    6-8    220    Jr       0.06       34               Tanor
#> 4   <NA>     NA               NA       NA                <NA>
#>   c_player_last_name c_hgt c_wgt c_yr c_min_pct        team year
#> 1          Koprivica   7-1   240   So      0.54 Florida St. 2021
#> 2               Gray   6-8   260   Jr      0.24 Florida St. 2021
#> 3               Ngom   7-2   236   Sr      0.18 Florida St. 2021
#> 4               <NA>  <NA>    NA             NA Florida St. 2021
  # }

```
