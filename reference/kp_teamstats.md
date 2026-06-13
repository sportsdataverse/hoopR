# **Get Team Stats**

**Get Team Stats**

## Usage

``` r
kp_teamstats(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of team stats

|                    |           |                                              |
|--------------------|-----------|----------------------------------------------|
| col_name           | types     | description                                  |
| team               | character | Team-side label or team identifier.          |
| conf               | character | character.                                   |
| off_fg_3_pct       | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3_pct_rk    | numeric   | Off fg 3 pct rk.                             |
| off_fg_2_pct       | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fg_2_pct_rk    | numeric   | Off fg 2 pct rk.                             |
| off_ft_pct         | numeric   | Off free throws percentage (0-1 decimal).    |
| off_ft_pct_rk      | numeric   | Off ft pct rk.                               |
| off_blk_pct        | numeric   | Off blocks percentage (0-1 decimal).         |
| off_blk_pct_rk     | numeric   | Off blk pct rk.                              |
| off_stl_pct        | numeric   | Off steals percentage (0-1 decimal).         |
| off_stl_pct_rk     | numeric   | Off stl pct rk.                              |
| off_non_stl_pct    | numeric   | Off non steals percentage (0-1 decimal).     |
| off_non_stl_pct_rk | numeric   | Off non stl pct rk.                          |
| off_a_pct          | numeric   | Off a percentage (0-1 decimal).              |
| off_a_pct_rk       | numeric   | Off a pct rk.                                |
| off_fg_3a_pct      | numeric   | Off field goals 3a percentage (0-1 decimal). |
| off_fg_3a_pct_rk   | numeric   | Off fg 3a pct rk.                            |
| adj_o              | numeric   | Adj o.                                       |
| adj_o_rk           | numeric   | Adj o rk.                                    |
| ncaa_seed          | numeric   | Ncaa seed.                                   |
| year               | numeric   | 4-digit year.                                |
| def_fg_3_pct       | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3_pct_rk    | numeric   | Def fg 3 pct rk.                             |
| def_fg_2_pct       | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fg_2_pct_rk    | numeric   | Def fg 2 pct rk.                             |
| def_ft_pct         | numeric   | Def free throws percentage (0-1 decimal).    |
| def_ft_pct_rk      | numeric   | Def ft pct rk.                               |
| def_blk_pct        | numeric   | Def blocks percentage (0-1 decimal).         |
| def_blk_pct_rk     | numeric   | Def blk pct rk.                              |
| def_stl_pct        | numeric   | Def steals percentage (0-1 decimal).         |
| def_stl_pct_rk     | numeric   | Def stl pct rk.                              |
| def_non_stl_pct    | numeric   | Def non steals percentage (0-1 decimal).     |
| def_non_stl_pct_rk | numeric   | Def non stl pct rk.                          |
| def_a_pct          | numeric   | Def a percentage (0-1 decimal).              |
| def_a_pct_rk       | numeric   | Def a pct rk.                                |
| def_fg_3a_pct      | numeric   | Def field goals 3a percentage (0-1 decimal). |
| def_fg_3a_pct_rk   | numeric   | Def fg 3a pct rk.                            |
| adj_d              | numeric   | Adj d.                                       |
| adj_d_rk           | numeric   | Adj d rk.                                    |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md)

## Examples

``` r
# \donttest{
try(kp_teamstats(min_year = 2019, max_year = 2021))
#> ✖ 2026-06-13 02:28:06.366889: Invalid arguments or no team stats data for 2019 - 2021 available!
#> ✖ Args: min_year = 2019, max_year = 2021
#> ✖ Error: subscript out of bounds
#> NULL
# }
```
