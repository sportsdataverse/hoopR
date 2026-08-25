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

|             |           |                                     |
|-------------|-----------|-------------------------------------|
| col_name    | types     | description                         |
| team        | character | Team-side label or team identifier. |
| overall     | character | Overall.                            |
| conf        | character | character.                          |
| adj_em      | numeric   | Adj em.                             |
| adj_em_rk   | numeric   | Adj em rk.                          |
| adj_o       | numeric   | Adj o.                              |
| adj_o_rk    | numeric   | Adj o rk.                           |
| adj_d       | numeric   | Adj d.                              |
| adj_d_rk    | numeric   | Adj d rk.                           |
| adj_t       | numeric   | Adj t.                              |
| adj_t_rk    | numeric   | Adj t rk.                           |
| conf_sos    | numeric   | Conf sos.                           |
| conf_sos_rk | numeric   | Conf sos rk.                        |
| next_game   | character | Next game date or opponent.         |
| year        | numeric   | 4-digit year.                       |

**ConferencePlayOffense**

|             |           |                                         |
|-------------|-----------|-----------------------------------------|
| col_name    | types     | description                             |
| team        | character | Team-side label or team identifier.     |
| oe          | numeric   | Oe.                                     |
| oe_rk       | numeric   | Oe rk.                                  |
| e_fg_pct    | numeric   | E field goals percentage (0-1 decimal). |
| e_fg_pct_rk | numeric   | E fg pct rk.                            |
| to_pct      | numeric   | To percentage (0-1 decimal).            |
| to_pct_rk   | numeric   | To pct rk.                              |
| or_pct      | numeric   | Or percentage (0-1 decimal).            |
| or_pct_rk   | numeric   | Or pct rk.                              |
| ft_rate     | numeric   | Ft rate.                                |
| ft_rate_rk  | numeric   | Ft rate rk.                             |
| fg_2_pct    | numeric   | Field goals 2 percentage (0-1 decimal). |
| fg_2_pct_rk | numeric   | Fg 2 pct rk.                            |
| fg_3_pct    | numeric   | Field goals 3 percentage (0-1 decimal). |
| fg_3_pct_rk | numeric   | Fg 3 pct rk.                            |
| ft_pct      | numeric   | Free throw percentage (0-1).            |
| ft_pct_rk   | numeric   | Ft pct rk.                              |
| tempo       | numeric   | Tempo.                                  |
| tempo_rk    | numeric   | Tempo rk.                               |
| year        | numeric   | 4-digit year.                           |

**ConferencePlayDefense**

|             |           |                                         |
|-------------|-----------|-----------------------------------------|
| col_name    | types     | description                             |
| team        | character | Team-side label or team identifier.     |
| de          | numeric   | De.                                     |
| de_rk       | numeric   | De rk.                                  |
| e_fg_pct    | numeric   | E field goals percentage (0-1 decimal). |
| e_fg_pct_rk | numeric   | E fg pct rk.                            |
| to_pct      | numeric   | To percentage (0-1 decimal).            |
| to_pct_rk   | numeric   | To pct rk.                              |
| or_pct      | numeric   | Or percentage (0-1 decimal).            |
| or_pct_rk   | numeric   | Or pct rk.                              |
| ft_rate     | numeric   | Ft rate.                                |
| ft_rate_rk  | numeric   | Ft rate rk.                             |
| fg_2_pct    | numeric   | Field goals 2 percentage (0-1 decimal). |
| fg_2_pct_rk | numeric   | Fg 2 pct rk.                            |
| fg_3_pct    | numeric   | Field goals 3 percentage (0-1 decimal). |
| fg_3_pct_rk | numeric   | Fg 3 pct rk.                            |
| blk_pct     | numeric   | Blocks percentage (0-1 decimal).        |
| blk_pct_rk  | numeric   | Blk pct rk.                             |
| stl_pct     | numeric   | Steals percentage (0-1 decimal).        |
| stl_pct_rk  | numeric   | Stl pct rk.                             |
| year        | numeric   | 4-digit year.                           |

**AllKenPom**

|          |           |               |
|----------|-----------|---------------|
| col_name | types     | description   |
| rk       | integer   | Rk.           |
| player   | character | Player.       |
| year     | numeric   | 4-digit year. |

**ConferenceAggregateStats**

|          |           |                                |
|----------|-----------|--------------------------------|
| col_name | types     | description                    |
| stat     | character | Stat.                          |
| value    | numeric   | Numeric or string value field. |
| rk       | numeric   | Rk.                            |
| year     | numeric   | 4-digit year.                  |

**WinningTrends**

|          |           |                                |
|----------|-----------|--------------------------------|
| col_name | types     | description                    |
| stat     | character | Stat.                          |
| count    | character | Count of count.                |
| value    | numeric   | Numeric or string value field. |
| rk       | numeric   | Rk.                            |
| year     | numeric   | 4-digit year.                  |

**ConferenceComparison**

|            |           |               |
|------------|-----------|---------------|
| col_name   | types     | description   |
| rk         | numeric   | Rk.           |
| conference | character | Conference.   |
| rating     | numeric   | Rating.       |
| year       | numeric   | 4-digit year. |

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
#> ✖ 2026-08-25 04:53:41.447154: Invalid arguments or no conference data for 2020 ACC available!
#> ✖ Args: year = 2020, conf = "ACC"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
