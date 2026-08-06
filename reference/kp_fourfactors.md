# **Get Four Factors Data**

**Get Four Factors Data**

## Usage

``` r
kp_fourfactors(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of four factors ratings

|                 |           |                                             |
|-----------------|-----------|---------------------------------------------|
| col_name        | types     | description                                 |
| team            | character | Team-side label or team identifier.         |
| conf            | character | character.                                  |
| adj_t           | numeric   | Adj t.                                      |
| adj_t_rk        | numeric   | Adj t rk.                                   |
| adj_o           | numeric   | Adj o.                                      |
| adj_o_rk        | numeric   | Adj o rk.                                   |
| off_e_fg_pct    | numeric   | Off e field goals percentage (0-1 decimal). |
| off_e_fg_pct_rk | numeric   | Off e fg pct rk.                            |
| off_to_pct      | numeric   | Off to percentage (0-1 decimal).            |
| off_to_pct_rk   | numeric   | Off to pct rk.                              |
| off_or_pct      | numeric   | Off or percentage (0-1 decimal).            |
| off_or_pct_rk   | numeric   | Off or pct rk.                              |
| off_ft_rate     | numeric   | Off ft rate.                                |
| off_ft_rate_rk  | numeric   | Off ft rate rk.                             |
| adj_d           | numeric   | Adj d.                                      |
| adj_d_rk        | numeric   | Adj d rk.                                   |
| def_e_fg_pct    | numeric   | Def e field goals percentage (0-1 decimal). |
| def_e_fg_pct_rk | numeric   | Def e fg pct rk.                            |
| def_to_pct      | numeric   | Def to percentage (0-1 decimal).            |
| def_to_pct_rk   | numeric   | Def to pct rk.                              |
| def_or_pct      | numeric   | Def or percentage (0-1 decimal).            |
| def_or_pct_rk   | numeric   | Def or pct rk.                              |
| def_ft_rate     | numeric   | Def ft rate.                                |
| def_ft_rate_rk  | numeric   | Def ft rate rk.                             |
| ncaa_seed       | numeric   | Ncaa seed.                                  |
| year            | numeric   | 4-digit year.                               |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_fourfactors(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-06 04:00:51.985187: Invalid arguments or no four factors data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
