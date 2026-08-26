# **Get KenPom Ratings**

**Get KenPom Ratings**

**Get KenPom Efficiency and Tempo Summary**

**Get Four Factors Data**

**Get Team Points Distribution**

**Get Heights, Experience, Bench and Continuity Data**

**Get 2-Foul Participation Stats**

**Get Team Stats**

**Get Player Stats Leaders by Metric**

**Get KPoY Leaders Tables**

## Usage

``` r
kp_pomeroy_ratings(min_year, max_year = most_recent_mbb_season())

kp_efficiency(min_year, max_year = most_recent_mbb_season())

kp_fourfactors(min_year, max_year = most_recent_mbb_season())

kp_pointdist(min_year, max_year = most_recent_mbb_season())

kp_height(min_year, max_year = most_recent_mbb_season())

kp_foul_trouble(min_year, max_year = most_recent_mbb_season())

kp_teamstats(min_year, max_year = most_recent_mbb_season())

kp_playerstats(
  metric = "eFG",
  conf = NULL,
  conf_only = FALSE,
  year = most_recent_mbb_season()
)

kp_kpoy(year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

- metric:

  Used to get leaders for different metrics. Available values are:  
  'ORtg', 'Min', 'eFG', 'Poss', Shots', 'OR', 'DR', 'TO', 'ARate',
  'Blk',  
  'FTRate', 'Stl', 'TS', 'FC40', 'FD40', '2P', '3P', 'FT'.  
  Default is 'eFG'. 'ORtg' returns a list of four dataframes, as there
  are four tables:  
  players that used more than 28 percent of possessions, more than 24
  percent of possessions, more than 20 percent of possessions, and with
  no possession restriction.

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

- conf_only:

  Used to define whether stats should reflect conference games only.  
  Only available if specific conference is defined. Only available for
  season after 2013, FALSE by default.

- year:

  Year of data to pull (earliest year of data available: 2004)

## Value

Returns a tibble of ratings

|                 |           |                                     |
|-----------------|-----------|-------------------------------------|
| col_name        | types     | description                         |
| year            | integer   | 4-digit year.                       |
| rk              | numeric   | Rk.                                 |
| team            | character | Team-side label or team identifier. |
| conf            | character | character.                          |
| w_l             | character | W l.                                |
| adj_em          | numeric   | Adj em.                             |
| adj_o           | numeric   | Adj o.                              |
| adj_o_rk        | numeric   | Adj o rk.                           |
| adj_d           | numeric   | Adj d.                              |
| adj_d_rk        | numeric   | Adj d rk.                           |
| adj_t           | numeric   | Adj t.                              |
| adj_t_rk        | numeric   | Adj t rk.                           |
| luck            | numeric   | Luck.                               |
| luck_rk         | numeric   | Luck rk.                            |
| sos_adj_em      | numeric   | Sos adj em.                         |
| sos_adj_em_rk   | numeric   | Sos adj em rk.                      |
| sos_opp_o       | numeric   | Sos opp o.                          |
| sos_opp_o_rk    | numeric   | Sos opp o rk.                       |
| sos_opp_d       | numeric   | Sos opp d.                          |
| sos_opp_d_rk    | numeric   | Sos opp d rk.                       |
| ncsos_adj_em    | numeric   | Ncsos adj em.                       |
| ncsos_adj_em_rk | numeric   | Ncsos adj em rk.                    |
| ncaa_seed       | numeric   | Ncaa seed.                          |

Returns a tibble of efficiency and tempo ratings

|                        |           |                                     |
|------------------------|-----------|-------------------------------------|
| col_name               | types     | description                         |
| team                   | character | Team-side label or team identifier. |
| conf                   | character | character.                          |
| adj_t                  | numeric   | Adj t.                              |
| adj_t_rk               | numeric   | Adj t rk.                           |
| raw_t                  | numeric   | Raw t.                              |
| raw_t_rk               | numeric   | Raw t rk.                           |
| avg_poss_length_off    | numeric   | Avg poss length off.                |
| avg_poss_length_off_rk | numeric   | Avg poss length off rk.             |
| avg_poss_length_def    | numeric   | Avg poss length def.                |
| avg_poss_length_def_rk | numeric   | Avg poss length def rk.             |
| adj_o                  | numeric   | Adj o.                              |
| adj_o_rk               | numeric   | Adj o rk.                           |
| raw_o                  | numeric   | Raw o.                              |
| raw_o_rk               | numeric   | Raw o rk.                           |
| adj_d                  | numeric   | Adj d.                              |
| adj_d_rk               | numeric   | Adj d rk.                           |
| raw_d                  | numeric   | Raw d.                              |
| raw_d_rk               | numeric   | Raw d rk.                           |
| ncaa_seed              | numeric   | Ncaa seed.                          |
| year                   | numeric   | 4-digit year.                       |

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

Returns a tibble of team points distributions

|                 |           |                                             |
|-----------------|-----------|---------------------------------------------|
| col_name        | types     | description                                 |
| team            | character | Team-side label or team identifier.         |
| conf            | character | character.                                  |
| off_ft_pct      | numeric   | Off free throws percentage (0-1 decimal).   |
| off_ft_pct_rk   | numeric   | Off ft pct rk.                              |
| off_fg_2_pct    | numeric   | Off field goals 2 percentage (0-1 decimal). |
| off_fg_2_pct_rk | numeric   | Off fg 2 pct rk.                            |
| off_fg_3_pct    | numeric   | Off field goals 3 percentage (0-1 decimal). |
| off_fg_3_pct_rk | numeric   | Off fg 3 pct rk.                            |
| def_ft_pct      | numeric   | Def free throws percentage (0-1 decimal).   |
| def_ft_pct_rk   | numeric   | Def ft pct rk.                              |
| def_fg_2_pct    | numeric   | Def field goals 2 percentage (0-1 decimal). |
| def_fg_2_pct_rk | numeric   | Def fg 2 pct rk.                            |
| def_fg_3_pct    | numeric   | Def field goals 3 percentage (0-1 decimal). |
| def_fg_3_pct_rk | numeric   | Def fg 3 pct rk.                            |
| ncaa_seed       | numeric   | Ncaa seed.                                  |
| year            | numeric   | 4-digit year.                               |

Returns a tibble of heights

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| team          | character | Team-side label or team identifier. |
| conf          | character | character.                          |
| avg_hgt       | numeric   | Avg hgt.                            |
| avg_hgt_rk    | numeric   | Avg hgt rk.                         |
| eff_hgt       | numeric   | Eff hgt.                            |
| eff_hgt_rk    | numeric   | Eff hgt rk.                         |
| c_hgt         | numeric   | C hgt.                              |
| c_hgt_rk      | numeric   | C hgt rk.                           |
| pf_hgt        | numeric   | Pf hgt.                             |
| pf_hgt_rk     | numeric   | Pf hgt rk.                          |
| sf_hgt        | numeric   | Sf hgt.                             |
| sf_hgt_rk     | numeric   | Sf hgt rk.                          |
| sg_hgt        | numeric   | Sg hgt.                             |
| sg_hgt_rk     | numeric   | Sg hgt rk.                          |
| pg_hgt        | numeric   | Pg hgt.                             |
| pg_hgt_rk     | numeric   | Pg hgt rk.                          |
| experience    | numeric   | Years of professional experience.   |
| experience_rk | numeric   | Experience rk.                      |
| bench         | numeric   | Bench.                              |
| bench_rk      | numeric   | Bench rk.                           |
| continuity    | numeric   | Continuity.                         |
| continuity_rk | numeric   | Continuity rk.                      |
| ncaa_seed     | numeric   | Ncaa seed.                          |
| year          | integer   | 4-digit year.                       |

Returns a tibble of foul participation stats

|  |  |  |
|----|----|----|
| col_name | types | description |
| team | character | Team-side label or team identifier. |
| conf | character | character. |
| two_foul_particpation_pct | numeric | Two foul particpation percentage (0-1 decimal). |
| two_foul_particpation_pct_rk | numeric | Two foul particpation pct rk. |
| adj2fp | numeric | Adj2fp. |
| adj2fp_rk | numeric | Adj2fp rk. |
| two_foul_total_time | character | Time / clock value. |
| two_foul_total_time_rk | character | Two foul total time rk. |
| two_foul_time_on | character | Two foul time on. |
| two_foul_time_on_rk | character | Two foul time on rk. |
| bench_pct | numeric | Bench percentage (0-1 decimal). |
| bench_pct_rk | numeric | Bench pct rk. |
| ncaa_seed | numeric | Ncaa seed. |
| year | integer | 4-digit year. |

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

Returns a tibble of player stats

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| rk       | character | Rk.                                 |
| player   | character | Player.                             |
| team     | character | Team-side label or team identifier. |
| e_fg     | character | E fg.                               |
| hgt      | character | Hgt.                                |
| wgt      | character | Wgt.                                |
| yr       | character | Yr.                                 |
| year     | numeric   | 4-digit year.                       |

Returns a list of tibbles: "kPoYRatings", "GameMVPs"

**KPoYRatings**

|             |           |                                                |
|-------------|-----------|------------------------------------------------|
| col_name    | types     | description                                    |
| rk          | integer   | Rk.                                            |
| player      | character | Player.                                        |
| kpoy_rating | numeric   | Kpoy rating.                                   |
| team        | character | Team-side label or team identifier.            |
| hgt         | character | Hgt.                                           |
| wgt         | numeric   | Wgt.                                           |
| exp         | character | Exp.                                           |
| home_town   | character | Home team's town.                              |
| year        | numeric   | 4-digit year.                                  |
| group       | character | Group identifier (e.g. conference 'group_id'). |

**GameMVPs**

|            |           |                                                |
|------------|-----------|------------------------------------------------|
| col_name   | types     | description                                    |
| rk         | numeric   | Rk.                                            |
| player     | character | Player.                                        |
| game_mv_ps | numeric   | Game mv ps.                                    |
| team       | character | Team-side label or team identifier.            |
| hgt        | character | Hgt.                                           |
| wgt        | numeric   | Wgt.                                           |
| exp        | character | Exp.                                           |
| home_town  | character | Home team's town.                              |
| year       | numeric   | 4-digit year.                                  |
| group      | character | Group identifier (e.g. conference 'group_id'). |

## Examples

``` r
# \donttest{
try(kp_pomeroy_ratings(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.115546: Invalid arguments or no pomeroy ratings data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
# \donttest{
try(kp_efficiency(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.173868: Invalid arguments or no efficiency data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_fourfactors(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.231632: Invalid arguments or no four factors data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_pointdist(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.289066: Invalid arguments or no point distribution data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_height(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.345633: Invalid arguments or no height data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_foul_trouble(min_year = 2020, max_year = most_recent_mbb_season()))
#> ✖ 2026-08-26 19:56:00.40874: Invalid arguments or no foul trouble data for 2020 - 2026 available!
#> ✖ Args: min_year = 2020, max_year = 2026
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_teamstats(min_year = 2019, max_year = 2021))
#> ✖ 2026-08-26 19:56:00.466027: Invalid arguments or no team stats data for 2019 - 2021 available!
#> ✖ Args: min_year = 2019, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2021))
#> ✖ 2026-08-26 19:56:00.522486: Invalid arguments or no player stats data for 2021 eFG available!
#> ✖ Args: metric = "eFG", conf = NULL, conf_only = FALSE, year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
# \donttest{
try(kp_kpoy(year = 2026))
#> ✖ 2026-08-26 19:56:00.579651: Invalid arguments or no KenPom player of the year data for 2026 available!
#> ✖ Args: year = 2026
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
