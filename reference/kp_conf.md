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
#> 2026-03-26 14:51:16.529399: Invalid arguments or no conference data for 2020 ACC available!
#> Error in kp_conf(year = 2020, conf = "ACC") : object 'kenpom' not found
# }
```
