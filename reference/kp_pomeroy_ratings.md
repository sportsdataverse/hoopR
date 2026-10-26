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
#>     year  rk                   team conf   w_l adj_em adj_o adj_o_rk adj_d
#> 1   2021   1                Gonzaga  WCC  31-1  36.48 126.4        1  89.9
#> 2   2021   2                 Baylor  B12  28-2  33.87 125.0        2  91.1
#> 3   2021   3               Michigan  B10  23-5  29.67 117.6        9  87.9
#> 4   2021   4               Illinois  B10  24-7  29.06 118.0        8  88.9
#> 5   2021   5                Houston Amer  28-4  28.75 118.3        7  89.6
#> 6   2021   6                    USC  P12  25-8  27.58 115.7       14  88.1
#> 7   2021   7                   Iowa  B10  22-9  26.87 123.5        3  96.7
#> 8   2021   8               Colorado  P12  23-9  25.10 116.3       13  91.2
#> 9   2021   9                Alabama  SEC  26-7  25.09 112.9       30  87.8
#> 10  2021  10         Loyola Chicago  MVC  26-5  24.32 111.3       41  87.0
#> 11  2021  11               Ohio St.  B10 21-10  23.58 120.7        4  97.1
#> 12  2021  12              Villanova   BE  18-7  23.02 119.0        6  96.0
#> 13  2021  13                   UCLA  P12 22-10  22.43 116.9       11  94.5
#> 14  2021  14              Wisconsin  B10 18-13  22.40 113.0       29  90.6
#> 15  2021  15            Florida St.  ACC  18-7  22.12 114.9       16  92.8
#> 16  2021  16                 Oregon  P12  21-7  21.85 117.2       10  95.4
#> 17  2021  17             Texas Tech  B12 18-11  21.81 112.7       32  90.9
#> 18  2021  18               Arkansas  SEC  25-7  21.56 111.1       43  89.6
#> 19  2021  19               Virginia  ACC  18-7  21.42 114.7       17  93.3
#> 20  2021  20                    BYU  WCC  20-7  21.12 113.7       23  92.5
#> 21  2021  21            Connecticut   BE  15-8  20.61 113.1       27  92.5
#> 22  2021  22              Creighton   BE  22-9  20.59 113.4       25  92.8
#> 23  2021  23          West Virginia  B12 19-10  20.51 116.8       12  96.3
#> 24  2021  24                    LSU  SEC 19-10  20.35 120.1        5  99.8
#> 25  2021  25                 Purdue  B10 18-10  20.33 113.3       26  92.9
#> 26  2021  26                  Texas  B12  19-8  20.31 113.1       28  92.8
#> 27  2021  27                 Kansas  B12  21-9  19.98 110.1       54  90.2
#> 28  2021  28              Tennessee  SEC  18-9  19.95 108.0       85  88.1
#> 29  2021  29                Arizona  P12  17-9  19.92 115.6       15  95.7
#> 30  2021  30          San Diego St.  MWC  23-5  19.88 111.0       45  91.1
#> 31  2021  31                Memphis Amer  20-8  19.11 105.5      117  86.4
#> 32  2021  32        St. Bonaventure  A10  16-5  19.04 110.0       55  91.0
#> 33  2021  33           Oklahoma St.  B12  21-9  18.95 109.6       60  90.7
#> 34  2021  34         North Carolina  ACC 18-11  18.62 110.3       52  91.7
#> 35  2021  35               Maryland  B10 17-14  17.63 111.8       37  94.1
#> 36  2021  36                   Duke  ACC 13-11  17.56 114.5       18  97.0
#> 37  2021  37           Georgia Tech  ACC  17-9  17.50 113.7       22  96.2
#> 38  2021  38                Rutgers  B10 16-12  17.48 108.1       82  90.6
#> 39  2021  39               Oklahoma  B12 16-11  17.06 112.1       35  95.1
#> 40  2021  40               Penn St.  B10 11-14  17.03 112.2       34  95.2
#> 41  2021  41                Florida  SEC 15-10  16.95 111.0       44  94.1
#> 42  2021  42               Syracuse  ACC 18-10  16.75 113.7       24  96.9
#> 43  2021  43             Oregon St.  P12 20-13  16.40 112.1       36  95.7
#> 44  2021  44                   Utah  P12 12-13  15.78 112.7       31  97.0
#> 45  2021  45                Clemson  ACC  16-8  15.48 106.4      107  90.9
#> 46  2021  46               Utah St.  MWC  20-9  15.34 104.8      126  89.5
#> 47  2021  47               Missouri  SEC 16-10  15.14 110.6       49  95.5
#> 48  2021  48                    VCU  A10  19-7  15.04 105.2      122  90.2
#> 49  2021  49               Kentucky  SEC  9-16  14.97 108.0       84  93.1
#> 50  2021  50                Indiana  B10 12-15  14.95 109.1       70  94.2
#> 51  2021  51            Mississippi  SEC 16-12  14.67 106.1      109  91.4
#> 52  2021  52          Virginia Tech  ACC  15-7  14.44 109.7       59  95.3
#> 53  2021  53            Saint Louis  A10  14-7  14.37 110.4       50  96.0
#> 54  2021  54             Seton Hall   BE 14-13  14.36 110.3       51  95.9
#> 55  2021  55                  Drake  MVC  26-5  14.27 112.5       33  98.2
#> 56  2021  56                    SMU Amer  11-6  14.07 110.8       47  96.8
#> 57  2021  57               Stanford  P12 14-13  13.78 106.0      110  92.2
#> 58  2021  58       UC Santa Barbara   BW  22-5  13.63 109.9       56  96.2
#> 59  2021  59             Louisville  ACC  13-7  13.54 107.7       92  94.2
#> 60  2021  60                 Auburn  SEC 13-14  13.20 111.6       38  98.4
#> 61  2021  61              Boise St.  MWC  19-9  13.13 109.1       69  96.0
#> 62  2021  62              Minnesota  B10 14-15  12.97 108.4       76  95.4
#> 63  2021  63             Georgetown   BE 13-13  12.91 107.9       87  95.0
#> 64  2021  64           Michigan St.  B10 15-13  12.90 107.1       98  94.2
#> 65  2021  65               Richmond  A10  14-9  12.78 110.9       46  98.1
#> 66  2021  66                 Xavier   BE  13-8  12.73 110.6       48  97.9
#> 67  2021  67        Mississippi St.  SEC 18-15  12.37 107.7       93  95.3
#> 68  2021  68            Wichita St. Amer  16-6  12.30 109.5       61  97.2
#> 69  2021  69             St. John's   BE 16-11  12.26 111.2       42  98.9
#> 70  2021  70               Davidson  A10  13-9  12.11 113.9       20 101.8
#> 71  2021  71             N.C. State  ACC 14-11  12.02 109.4       63  97.4
#> 72  2021  72            North Texas CUSA 18-10  11.76 106.7      101  95.0
#> 73  2021  73             Wright St. Horz  18-6  11.73 108.3       80  96.6
#> 74  2021  74                 Toledo  MAC  21-9  11.71 114.3       19 102.6
#> 75  2021  75           Saint Mary's  WCC 14-10  11.68 101.8      178  90.2
#> 76  2021  76           Colorado St.  MWC  20-8  11.52 108.1       83  96.6
#> 77  2021  77                Buffalo  MAC  16-9  11.30 107.4       95  96.1
#> 78  2021  78         Washington St.  P12 14-13  11.10 102.4      167  91.3
#> 79  2021  79           Northwestern  B10  9-15  10.97 104.3      132  93.4
#> 80  2021  80             Providence   BE 13-13  10.70 107.3       96  96.6
#> 81  2021  81                   Ohio  MAC  17-8  10.47 111.4       40 100.9
#> 82  2021  82         Louisiana Tech CUSA  24-8  10.46 104.2      133  93.7
#> 83  2021  83              Marquette   BE 13-14  10.40 107.5       94  97.1
#> 84  2021  84      Abilene Christian Slnd  24-5  10.11 101.7      184  91.6
#> 85  2021  85             Notre Dame  ACC 11-15  10.03 113.8       21 103.7
#> 86  2021  86            Arizona St.  P12 11-14   9.85 108.4       75  98.5
#> 87  2021  87                 Dayton  A10 14-10   9.69 108.3       77  98.6
#> 88  2021  88           Missouri St.  MVC  17-7   9.32 107.8       90  98.5
#> 89  2021  89                Colgate  Pat  14-2   9.25 110.3       53 101.0
#> 90  2021  90             Pepperdine  WCC 15-12   9.04 108.3       79  99.3
#> 91  2021  91                 Nevada  MWC 16-10   8.98 108.8       72  99.9
#> 92  2021  92               Marshall CUSA  15-7   8.89 109.2       67 100.3
#> 93  2021  93          San Francisco  WCC 11-14   8.86 106.9      100  98.0
#> 94  2021  94       Loyola Marymount  WCC  13-9   8.80 107.8       89  99.0
#> 95  2021  95                Georgia  SEC 14-12   8.69 107.9       86  99.2
#> 96  2021  96                 Furman   SC  16-9   8.64 109.8       57 101.1
#> 97  2021  97             Pittsburgh  ACC 10-12   8.64 108.2       81  99.5
#> 98  2021  98                Liberty ASun  23-6   8.60 109.8       58 101.2
#> 99  2021  99       Western Kentucky CUSA  21-8   8.57 106.6      102  98.0
#> 100 2021 100                    UCF Amer 11-12   8.54 106.5      103  97.9
#> 101 2021 101               Winthrop BSth  23-2   8.48 105.0      124  96.5
#> 102 2021 102                    UAB CUSA  22-7   8.44 103.5      153  95.0
#> 103 2021 103           Grand Canyon  WAC  17-7   8.32 105.4      121  97.1
#> 104 2021 104             Vanderbilt  SEC  9-16   8.25 108.9       71 100.6
#> 105 2021 105     Eastern Washington BSky  16-8   8.19 109.5       62 101.3
#> 106 2021 106           UC Riverside   BW  14-8   8.03 103.6      147  95.6
#> 107 2021 107              UC Irvine   BW  18-9   7.88 101.3      192  93.4
#> 108 2021 108         UNC Greensboro   SC  21-9   7.79 103.6      146  95.8
#> 109 2021 109               Nebraska  B10  7-20   7.76 101.8      179  94.1
#> 110 2021 110                Belmont  OVC  26-4   7.43 109.4       64 102.0
#> 111 2021 111           Rhode Island  A10 10-15   7.21 104.7      127  97.5
#> 112 2021 112                  Akron  MAC  15-8   7.14 108.6       73 101.5
#> 113 2021 113       South Dakota St.  Sum  16-7   6.85 111.5       39 104.6
#> 114 2021 114             California  P12  9-20   6.43 105.5      119  99.0
#> 115 2021 115               Kent St.  MAC  15-8   6.34 105.8      113  99.5
#> 116 2021 116             Cincinnati Amer 12-11   6.06 103.6      148  97.5
#> 117 2021 117                Pacific  WCC   9-9   5.48 103.5      150  98.1
#> 118 2021 118          Massachusetts  A10   8-7   5.40 105.4      120 100.0
#> 119 2021 119            Indiana St.  MVC 15-10   5.35 102.6      166  97.3
#> 120 2021 120                 Butler   BE 10-15   5.34 102.7      164  97.4
#> 121 2021 121                  Tulsa Amer 11-12   5.09 102.6      165  97.5
#> 122 2021 122              Weber St. BSky  17-6   4.98 107.7       91 102.7
#> 123 2021 123                   Yale  Ivy   0-0   4.98 107.1       99 102.1
#> 124 2021 124         South Carolina  SEC  6-15   4.96 103.9      139  98.9
#> 125 2021 125           Oral Roberts  Sum 18-11   4.83 109.3       66 104.4
#> 126 2021 126               Duquesne  A10   9-9   4.74 101.7      183  97.0
#> 127 2021 127                Wofford   SC  15-9   4.39 106.4      106 102.0
#> 128 2021 128     East Tennessee St.   SC 13-12   3.99 103.2      159  99.2
#> 129 2021 129             Washington  P12  5-21   3.65 104.0      135 100.4
#> 130 2021 130          Bowling Green  MAC 14-12   3.62 105.5      116 101.9
#> 131 2021 131                 Mercer   SC 18-11   3.43 106.2      108 102.8
#> 132 2021 132    Cal St. Bakersfield   BW 15-11   3.28 104.6      129 101.4
#> 133 2021 133                Vermont   AE  10-5   3.22 105.5      118 102.2
#> 134 2021 134           Morehead St.  OVC  23-8   3.19 100.6      205  97.4
#> 135 2021 135          Southern Utah BSky  20-4   3.13 108.5       74 105.4
#> 136 2021 136                   UTEP CUSA 12-12   3.09 103.3      156 100.2
#> 137 2021 137              Texas A&M  SEC  8-10   3.05 101.9      175  98.9
#> 138 2021 138               Miami FL  ACC 10-17   3.01 102.1      172  99.1
#> 139 2021 139       North Dakota St.  Sum 15-12   2.84 103.7      144 100.9
#> 140 2021 140                    TCU  B12 12-14   2.81 104.7      128 101.9
#> 141 2021 141                 DePaul   BE  5-14   2.80  97.6      257  94.8
#> 142 2021 142           George Mason  A10  13-9   2.73 101.1      195  98.4
#> 143 2021 143                 Temple Amer  5-11   2.70 101.5      189  98.8
#> 144 2021 144                 Tulane Amer 10-13   1.95  99.8      225  97.8
#> 145 2021 145            Santa Clara  WCC  12-8   1.94 100.4      208  98.5
#> 146 2021 146                Bradley  MVC 12-16   1.87 103.5      149 101.7
#> 147 2021 147             Kansas St.  B12  9-20   1.47  99.6      226  98.1
#> 148 2021 148         Boston College  ACC  4-16   1.47 105.1      123 103.6
#> 149 2021 149               Ball St.  MAC 10-13   1.44 103.4      154 101.9
#> 150 2021 150         New Mexico St.  WAC  12-8   1.40 104.1      134 102.7
#> 151 2021 151      Stephen F. Austin Slnd  16-5   1.29 103.5      152 102.2
#> 152 2021 152           Old Dominion CUSA  15-8   1.20 101.0      196  99.9
#> 153 2021 153                    VMI   SC 13-12   1.09 107.8       88 106.7
#> 154 2021 154            Georgia St.   SB  16-6   0.86 105.7      115 104.8
#> 155 2021 155          East Carolina Amer  8-11   0.74  99.3      232  98.6
#> 156 2021 156            Chattanooga   SC  18-8   0.71 103.0      161 102.3
#> 157 2021 157               Miami OH  MAC 12-11   0.70 106.0      111 105.3
#> 158 2021 158                 Drexel  CAA  12-8   0.67 106.5      104 105.8
#> 159 2021 159           South Dakota  Sum 14-11   0.64 107.3       97 106.6
#> 160 2021 160                   UTSA CUSA 15-11   0.57 106.5      105 105.9
#> 161 2021 161                Detroit Horz 12-10   0.51 109.3       65 108.8
#> 162 2021 162       Jacksonville St.  OVC  18-9   0.44 104.9      125 104.5
#> 163 2021 163          Northern Iowa  MVC 10-15   0.34 103.3      155 103.0
#> 164 2021 164                Wyoming  MWC 14-11   0.17 109.1       68 109.0
#> 165 2021 165              Princeton  Ivy   0-0   0.03 104.0      138 103.9
#> 166 2021 166                   Navy  Pat  15-3   0.02 103.7      145 103.7
#> 167 2021 167             Bellarmine ASun  14-8  -0.02 108.3       78 108.3
#> 168 2021 168           Northeastern  CAA  10-9  -0.10  98.5      242  98.6
#> 169 2021 169          Cleveland St. Horz  19-8  -0.13 100.6      206 100.7
#> 170 2021 170          South Florida Amer  9-13  -0.14 100.8      200 101.0
#> 171 2021 171               Iowa St.  B12  2-22  -0.14 100.3      213 100.4
#> 172 2021 172                   UMBC   AE  14-6  -0.15 100.6      203 100.8
#> 173 2021 173             Murray St.  OVC 13-13  -0.17 103.3      158 103.5
#> 174 2021 174       Eastern Kentucky  OVC  22-7  -0.56 101.0      197 101.5
#> 175 2021 175            Wake Forest  ACC  6-16  -0.64 101.3      191 101.9
#> 176 2021 176                   UNLV  MWC 12-15  -0.66 103.7      143 104.4
#> 177 2021 177          James Madison  CAA  13-7  -0.69 103.5      151 104.2
#> 178 2021 178                   Iona MAAC  12-6  -0.78 100.2      217 101.0
#> 179 2021 179       Coastal Carolina   SB  18-8  -0.86  99.3      231 100.2
#> 180 2021 180        Sam Houston St. Slnd  19-9  -1.06 101.3      193 102.3
#> 181 2021 181       Florida Atlantic CUSA 13-10  -1.14 101.9      174 103.1
#> 182 2021 182           Gardner Webb BSth 11-15  -1.18 104.5      130 105.6
#> 183 2021 183              Texas St.   SB  18-7  -1.23  99.6      228 100.8
#> 184 2021 184                Harvard  Ivy   0-0  -1.31 101.9      177 103.2
#> 185 2021 185                 Bryant  NEC  15-7  -1.50 103.2      160 104.7
#> 186 2021 186                  Siena MAAC  12-5  -2.05  99.8      224 101.8
#> 187 2021 187                 Hawaii   BW 11-10  -2.20 101.7      185 103.9
#> 188 2021 188                   Rice CUSA 15-13  -2.31 103.9      141 106.2
#> 189 2021 189                Montana BSky 15-13  -2.35  98.8      239 101.2
#> 190 2021 190                Hofstra  CAA 13-10  -2.55 105.9      112 108.4
#> 191 2021 191             Fresno St.  MWC 12-12  -2.64  99.6      227 102.2
#> 192 2021 192      Southern Illinois  MVC 12-14  -2.89 100.0      219 102.8
#> 193 2021 193             Valparaiso  MVC 10-18  -2.94  96.6      275  99.5
#> 194 2021 194               Hartford   AE  15-9  -2.98  97.0      271 100.0
#> 195 2021 195              San Diego  WCC  3-11  -3.22  97.4      259 100.7
#> 196 2021 196           Nicholls St. Slnd  18-7  -3.35 100.4      209 103.7
#> 197 2021 197                   Army  Pat 12-10  -3.47  98.1      250 101.6
#> 198 2021 198           Illinois St.  MVC  7-18  -3.62  98.7      240 102.3
#> 199 2021 199            Utah Valley  WAC 11-11  -3.75 100.5      207 104.3
#> 200 2021 200               La Salle  A10  9-16  -3.83 101.8      181 105.6
#> 201 2021 201              Louisiana   SB  17-9  -3.89 100.3      211 104.2
#> 202 2021 202         Saint Joseph's  A10  5-15  -3.98 101.2      194 105.1
#> 203 2021 203                   UMKC  Sum 11-13  -3.99  96.2      278 100.2
#> 204 2021 204             Evansville  MVC  9-16  -4.12 105.8      114 109.9
#> 205 2021 205                   Elon  CAA  10-9  -4.14  96.7      274 100.9
#> 206 2021 206      Northern Kentucky Horz 14-11  -4.17 103.8      142 108.0
#> 207 2021 207            Montana St. BSky 13-10  -4.19  99.4      230 103.6
#> 208 2021 208         Texas Southern SWAC  17-9  -4.37  99.8      221 104.2
#> 209 2021 209               UC Davis   BW  10-8  -4.37  98.0      253 102.3
#> 210 2021 210            Norfolk St. MEAC  17-8  -4.47  99.1      234 103.6
#> 211 2021 211               Campbell BSth 17-10  -4.64 102.9      162 107.6
#> 212 2021 212        Appalachian St.   SB 17-12  -4.71  98.4      245 103.1
#> 213 2021 213                Seattle  WAC 12-11  -4.96  98.6      241 103.5
#> 214 2021 214              Loyola MD  Pat  6-11  -5.02  96.8      272 101.8
#> 215 2021 215            Austin Peay  OVC 14-13  -5.04 104.0      137 109.0
#> 216 2021 216              Milwaukee Horz 10-12  -5.05 101.8      180 106.9
#> 217 2021 217          South Alabama   SB 17-11  -5.08 103.3      157 108.4
#> 218 2021 218            The Citadel   SC 13-12  -5.13 104.0      136 109.1
#> 219 2021 219                   Penn  Ivy   0-0  -5.13 100.2      216 105.3
#> 220 2021 220                Cornell  Ivy   0-0  -5.20 101.3      190 106.5
#> 221 2021 221                Oakland Horz 12-18  -5.28 103.9      140 109.2
#> 222 2021 222          Saint Peter's MAAC 14-11  -5.37  90.4      339  95.8
#> 223 2021 223             Morgan St. MEAC  14-8  -5.71 100.0      218 105.7
#> 224 2021 224                 Wagner  NEC  13-7  -5.72 100.8      201 106.5
#> 225 2021 225               Delaware  CAA   7-8  -6.08  97.0      269 103.1
#> 226 2021 226               Monmouth MAAC  12-8  -6.09  99.0      237 105.1
#> 227 2021 227      George Washington  A10  5-12  -6.17 101.6      187 107.8
#> 228 2021 228      Northern Colorado BSky 11-11  -6.19  99.0      238 105.1
#> 229 2021 229            Cal Baptist  WAC 13-10  -6.23 104.3      131 110.6
#> 230 2021 230           UMass Lowell   AE 11-12  -6.29  99.8      223 106.1
#> 231 2021 231           UC San Diego   BW  7-10  -6.29 101.7      182 108.0
#> 232 2021 232             Charleston  CAA  9-10  -6.35 102.2      170 108.6
#> 233 2021 233                Stetson ASun 12-15  -6.46 100.3      212 106.8
#> 234 2021 234              Charlotte CUSA  9-16  -6.49  97.3      261 103.8
#> 235 2021 235       Prairie View A&M SWAC  16-5  -6.51  94.6      299 101.2
#> 236 2021 236            Stony Brook   AE  9-14  -6.61  94.7      295 101.3
#> 237 2021 237       Mount St. Mary's  NEC 12-11  -6.62  94.5      301 101.1
#> 238 2021 238               Lipscomb ASun 15-12  -6.74 100.9      198 107.7
#> 239 2021 239            Little Rock   SB 11-15  -6.86  98.4      243 105.3
#> 240 2021 240                 Albany   AE   7-9  -6.91  97.3      263 104.2
#> 241 2021 241       Western Carolina   SC 11-16  -7.07  99.9      220 106.9
#> 242 2021 242         Long Beach St.   BW  6-12  -7.12  97.6      256 104.7
#> 243 2021 243                Radford BSth 15-12  -7.12  97.7      255 104.8
#> 244 2021 244          UNC Asheville BSth 10-10  -7.13 100.6      204 107.8
#> 245 2021 245           Portland St. BSky  9-13  -7.17  93.1      314 100.3
#> 246 2021 246         Youngstown St. Horz 15-12  -7.31 102.2      171 109.5
#> 247 2021 247               Longwood BSth 12-17  -7.33  98.0      251 105.4
#> 248 2021 248         UNC Wilmington  CAA  7-10  -7.42 102.1      173 109.5
#> 249 2021 249                  Brown  Ivy   0-0  -7.70  95.2      288 102.9
#> 250 2021 250                Niagara MAAC  9-11  -7.71  99.8      222 107.5
#> 251 2021 251               Canisius MAAC   7-6  -7.82  99.1      235 107.0
#> 252 2021 252           Arkansas St.   SB 11-13  -7.84  99.2      233 107.0
#> 253 2021 253           UT Arlington   SB 13-13  -7.87  98.2      246 106.1
#> 254 2021 254         Sacramento St. BSky  8-12  -7.93 102.4      168 110.3
#> 255 2021 255      Cal St. Fullerton   BW  6-10  -8.09 101.6      188 109.6
#> 256 2021 256          Southern Miss CUSA  8-17  -8.19  92.9      317 101.1
#> 257 2021 257              Green Bay Horz  8-17  -8.28 102.3      169 110.6
#> 258 2021 258              Idaho St. BSky 13-11  -8.54  93.7      306 102.2
#> 259 2021 259     Cal St. Northridge   BW  9-13  -8.79 101.7      186 110.4
#> 260 2021 260      Boston University  Pat  7-11  -8.93 100.3      210 109.3
#> 261 2021 261           Tarleton St.  WAC 10-10  -8.95  97.0      270 105.9
#> 262 2021 262              Lafayette  Pat   9-6  -9.08 102.9      163 112.0
#> 263 2021 263                  IUPUI Horz  8-10  -9.37  96.2      279 105.5
#> 264 2021 264                Samford   SC  6-13  -9.49  96.5      276 106.0
#> 265 2021 265            Jackson St. SWAC  12-6  -9.62  88.1      349  97.7
#> 266 2021 266                 Marist MAAC  12-9  -9.69  91.6      328 101.3
#> 267 2021 267               American  Pat   4-6  -9.74  96.5      277 106.2
#> 268 2021 268          New Hampshire   AE  10-9  -9.83  96.0      282 105.8
#> 269 2021 269 Southeast Missouri St.  OVC 11-16 -10.05  95.5      287 105.5
#> 270 2021 270       Georgia Southern   SB 13-13 -10.11  94.1      305 104.2
#> 271 2021 271                    LIU  NEC   9-9 -10.34  93.4      310 103.7
#> 272 2021 272           North Dakota  Sum  9-17 -10.39  97.7      254 108.1
#> 273 2021 273          North Alabama ASun 13-11 -10.48  94.7      297 105.2
#> 274 2021 274       Western Michigan  MAC  5-16 -10.48  94.7      294 105.2
#> 275 2021 275              Dartmouth  Ivy   0-0 -10.70  94.8      292 105.5
#> 276 2021 276               Bucknell  Pat   5-7 -10.71  97.3      262 108.0
#> 277 2021 277            Florida A&M MEAC  8-12 -10.72  90.2      341 100.9
#> 278 2021 278            New Orleans Slnd 10-15 -10.73  97.3      260 108.1
#> 279 2021 279     Florida Gulf Coast ASun  10-8 -10.92  93.5      309 104.4
#> 280 2021 280      Purdue Fort Wayne Horz  8-15 -10.97 100.3      214 111.2
#> 281 2021 281       Central Michigan  MAC  7-16 -11.04 100.2      215 111.3
#> 282 2021 282   UT Rio Grande Valley  WAC  9-10 -11.05  91.8      325 102.8
#> 283 2021 283     North Carolina A&T MEAC 11-10 -11.09  95.6      284 106.7
#> 284 2021 284             High Point BSth  9-15 -11.20  96.1      280 107.3
#> 285 2021 285             Quinnipiac MAAC  9-13 -11.21  89.6      345 100.8
#> 286 2021 286               Columbia  Ivy   0-0 -11.25  94.7      298 105.9
#> 287 2021 287              Merrimack  NEC   9-9 -11.37  90.7      336 102.1
#> 288 2021 288       Illinois Chicago Horz  9-13 -11.42  93.1      315 104.5
#> 289 2021 289       Eastern Michigan  MAC  6-12 -11.42  97.1      268 108.5
#> 290 2021 290       Western Illinois  Sum  7-15 -11.43  98.0      252 109.4
#> 291 2021 291             Coppin St. MEAC  9-13 -11.69  91.0      334 102.6
#> 292 2021 292                    FIU CUSA  9-17 -11.81  97.3      264 109.1
#> 293 2021 293           Jacksonville ASun 11-13 -11.85  93.7      307 105.5
#> 294 2021 294             New Mexico  MWC  6-16 -11.86  91.6      327 103.5
#> 295 2021 295                   NJIT   AE  7-12 -12.08  94.2      303 106.2
#> 296 2021 296       Louisiana Monroe   SB  7-19 -12.16  93.2      313 105.4
#> 297 2021 297          North Florida ASun  8-15 -12.34 101.9      176 114.2
#> 298 2021 298                 Towson  CAA  4-14 -12.35  99.0      236 111.4
#> 299 2021 299    Fairleigh Dickinson  NEC  9-15 -12.39 100.7      202 113.1
#> 300 2021 300         Nebraska Omaha  Sum  5-20 -12.44  94.6      300 107.0
#> 301 2021 301         St. Francis NY  NEC  9-10 -12.46 100.9      199 113.4
#> 302 2021 302         William & Mary  CAA  7-10 -12.46  94.8      291 107.3
#> 303 2021 303          Robert Morris Horz  4-15 -12.51  98.1      249 110.6
#> 304 2021 304             Holy Cross  Pat  5-11 -12.55  97.2      265 109.8
#> 305 2021 305                   Troy   SB 11-17 -12.62  92.4      322 105.0
#> 306 2021 306       Middle Tennessee CUSA  5-18 -12.66  91.2      332 103.9
#> 307 2021 307                  Lamar Slnd 10-18 -12.82  93.1      316 105.9
#> 308 2021 308               Southern SWAC  8-11 -12.84  91.5      329 104.3
#> 309 2021 309              Fairfield MAAC 10-17 -12.92  94.9      290 107.8
#> 310 2021 310                Fordham  A10  2-12 -12.93  86.3      352  99.3
#> 311 2021 311       Eastern Illinois  OVC  9-18 -13.22  95.5      286 108.7
#> 312 2021 312         St. Francis PA  NEC  6-16 -13.27  94.7      296 108.0
#> 313 2021 313         Tennessee Tech  OVC  5-22 -13.90  96.0      281 109.9
#> 314 2021 314                 Howard MEAC   1-4 -13.94  98.2      247 112.2
#> 315 2021 315              Manhattan MAAC  7-13 -14.18  89.5      346 103.7
#> 316 2021 316                  Rider MAAC  6-17 -14.19  99.5      229 113.7
#> 317 2021 317       Northwestern St. Slnd 11-18 -14.21  96.7      273 110.9
#> 318 2021 318          Grambling St. SWAC 12-12 -14.24  92.1      324 106.3
#> 319 2021 319       Northern Arizona BSky  6-16 -14.31  98.4      244 112.7
#> 320 2021 320          Tennessee St.  OVC  4-19 -14.65  90.2      340 104.9
#> 321 2021 321               Portland  WCC  6-15 -14.72  97.1      267 111.8
#> 322 2021 322            USC Upstate BSth  5-18 -14.75  94.8      293 109.5
#> 323 2021 323       SIU Edwardsville  OVC  9-17 -14.80  92.6      319 107.4
#> 324 2021 324           Sacred Heart  NEC   9-9 -15.26  98.2      248 113.5
#> 325 2021 325             Binghamton   AE  4-14 -15.31  97.2      266 112.5
#> 326 2021 326           Presbyterian BSth  7-15 -15.46  90.6      337 106.1
#> 327 2021 327                Hampton BSth 11-14 -15.71  94.9      289 110.6
#> 328 2021 328              Dixie St.  WAC  8-13 -15.71  91.3      330 107.0
#> 329 2021 329               Cal Poly   BW  4-20 -15.85  90.1      343 105.9
#> 330 2021 330 North Carolina Central MEAC   5-9 -16.21  93.3      311 109.5
#> 331 2021 331       Central Arkansas Slnd  5-19 -16.26  97.6      258 113.8
#> 332 2021 332              Air Force  MWC  5-20 -16.51  94.4      302 110.9
#> 333 2021 333           San Jose St.  MWC  5-16 -16.79  95.5      285 112.3
#> 334 2021 334                 Lehigh  Pat  4-11 -17.39  91.6      326 109.0
#> 335 2021 335           Kennesaw St. ASun  5-19 -17.57  87.8      350 105.4
#> 336 2021 336 Southeastern Louisiana Slnd  8-18 -17.92  92.9      318 110.8
#> 337 2021 337      Northern Illinois  MAC  3-16 -17.94  93.3      312 111.2
#> 338 2021 338                 Denver  Sum  2-19 -18.40  94.2      304 112.6
#> 339 2021 339    Charleston Southern BSth  3-18 -18.49  89.8      344 108.3
#> 340 2021 340            McNeese St. Slnd 10-14 -18.77  95.7      283 114.5
#> 341 2021 341        Houston Baptist Slnd  6-19 -18.90  92.5      321 111.4
#> 342 2021 342             Alcorn St. SWAC  6-13 -19.09  91.1      333 110.2
#> 343 2021 343         Incarnate Word Slnd  8-14 -19.09  93.6      308 112.7
#> 344 2021 344 Texas A&M Corpus Chris Slnd  5-19 -19.44  89.4      347 108.8
#> 345 2021 345    Central Connecticut  NEC  5-16 -19.46  92.5      320 112.0
#> 346 2021 346                  Maine   AE   2-7 -20.00  85.9      353 105.9
#> 347 2021 347       Tennessee Martin  OVC  8-16 -21.00  92.3      323 113.3
#> 348 2021 348            Alabama A&M SWAC   6-9 -21.04  84.8      354 105.8
#> 349 2021 349        Bethune Cookman MEAC   0-0 -22.53  90.1      342 112.7
#> 350 2021 350                  Idaho BSky  1-21 -23.01  90.6      338 113.6
#> 351 2021 351    Arkansas Pine Bluff SWAC  4-21 -23.47  91.2      331 114.7
#> 352 2021 352           Delaware St. MEAC  3-16 -24.53  90.9      335 115.4
#> 353 2021 353     South Carolina St. MEAC  1-17 -25.23  87.2      351 112.4
#> 354 2021 354            Alabama St. SWAC  4-14 -25.94  84.4      355 110.3
#> 355 2021 355 Maryland Eastern Shore MEAC   0-0 -27.60  83.9      356 111.5
#> 356 2021 356            Chicago St.  WAC   0-9 -29.85  88.3      348 118.1
#> 357 2021 357 Mississippi Valley St. SWAC  2-22 -41.29  79.4      357 120.7
#> 358 2020   1                 Kansas  B12  28-3  30.23 115.8        8  85.5
#> 359 2020   2                Gonzaga  WCC  31-2  26.95 121.3        1  94.4
#> 360 2020   3                 Baylor  B12  26-4  25.49 113.5       17  88.1
#> 361 2020   4                 Dayton  A10  29-2  24.93 119.1        2  94.1
#> 362 2020   5                   Duke  ACC  25-6  24.62 115.7        9  91.1
#> 363 2020   6          San Diego St.  MWC  30-2  24.48 115.1       11  90.6
#> 364 2020   7           Michigan St.  B10  22-9  24.03 115.2       10  91.2
#> 365 2020   8               Ohio St.  B10 21-10  22.23 114.3       13  92.0
#> 366 2020   9             Louisville  ACC  24-7  21.36 114.5       12  93.1
#> 367 2020  10          West Virginia  B12 21-10  21.26 108.3       67  87.1
#> 368 2020  11               Maryland  B10  24-7  21.12 113.5       18  92.4
#> 369 2020  12              Creighton   BE  24-7  20.93 118.2        3  97.3
#> 370 2020  13                    BYU  WCC  24-8  20.68 116.3        7  95.6
#> 371 2020  14                Houston Amer  23-8  20.39 112.7       22  92.3
#> 372 2020  15            Florida St.  ACC  26-5  20.22 111.7       32  91.5
#> 373 2020  16               Michigan  B10 19-12  20.12 113.2       20  93.0
#> 374 2020  17                 Oregon  P12  24-7  20.00 117.1        6  97.1
#> 375 2020  18              Villanova   BE  24-7  19.98 113.9       15  94.0
#> 376 2020  19                Arizona  P12 21-11  19.60 111.0       35  91.4
#> 377 2020  20             Seton Hall   BE  21-9  19.54 112.3       29  92.7
#> 378 2020  21             Texas Tech  B12 18-13  19.28 109.8       47  90.5
#> 379 2020  22              Wisconsin  B10 21-10  18.95 110.8       40  91.9
#> 380 2020  23                   Iowa  B10 20-11  18.65 117.3        5  98.6
#> 381 2020  24                 Purdue  B10 16-15  18.57 109.3       50  90.8
#> 382 2020  25                 Butler   BE  22-9  18.39 112.6       25  94.2
#> 383 2020  26               Penn St.  B10 21-10  17.91 110.3       43  92.4
#> 384 2020  27              Minnesota  B10 15-16  17.83 112.1       30  94.2
#> 385 2020  28                Rutgers  B10 20-11  17.72 107.9       72  90.2
#> 386 2020  29               Kentucky  SEC  25-6  17.60 112.7       24  95.1
#> 387 2020  30               Illinois  B10 21-10  17.23 110.9       38  93.7
#> 388 2020  31              Marquette   BE 18-12  17.19 114.0       14  96.9
#> 389 2020  32                Florida  SEC 19-12  16.79 112.5       27  95.7
#> 390 2020  33                 Auburn  SEC  25-6  15.91 111.4       33  95.5
#> 391 2020  34                Indiana  B10 20-12  15.73 108.5       65  92.7
#> 392 2020  35               Colorado  P12 21-11  15.71 109.1       54  93.4
#> 393 2020  36               Oklahoma  B12 19-12  15.70 108.8       58  93.1
#> 394 2020  37                    LSU  SEC 21-10  15.62 118.1        4 102.4
#> 395 2020  38           Saint Mary's  WCC  26-8  15.19 113.7       16  98.5
#> 396 2020  39            Wichita St. Amer  23-8  15.19 105.6      117  90.4
#> 397 2020  40             Providence   BE 19-12  15.00 107.8       75  92.8
#> 398 2020  41               Utah St.  MWC  26-8  14.92 109.5       49  94.6
#> 399 2020  42               Virginia  ACC  23-7  14.22  99.3      234  85.1
#> 400 2020  43               Stanford  P12 20-12  14.11 104.4      143  90.3
#> 401 2020  44             Cincinnati Amer 20-10  14.02 108.8       59  94.7
#> 402 2020  45                 Xavier   BE 19-13  13.90 106.1      103  92.2
#> 403 2020  46               Richmond  A10  24-7  13.87 109.2       53  95.3
#> 404 2020  47               Arkansas  SEC 20-12  13.59 109.1       55  95.5
#> 405 2020  48        Mississippi St.  SEC 20-11  13.57 113.4       19  99.8
#> 406 2020  49          Northern Iowa  MVC  25-6  13.43 112.7       23  99.3
#> 407 2020  50             N.C. State  ACC 20-12  13.39 110.7       42  97.3
#> 408 2020  51               Syracuse  ACC 18-14  13.28 112.8       21  99.6
#> 409 2020  52            Connecticut Amer 19-12  12.97 108.6       64  95.6
#> 410 2020  53           Oklahoma St.  B12 18-14  12.73 107.2       84  94.5
#> 411 2020  54             Washington  P12 15-17  12.67 105.8      112  93.1
#> 412 2020  55                    USC  P12  22-9  12.35 104.3      145  92.0
#> 413 2020  56     East Tennessee St.   SC  30-4  12.23 108.2       69  96.0
#> 414 2020  57             Notre Dame  ACC 20-12  12.09 110.7       41  98.6
#> 415 2020  58                   Yale  Ivy  23-7  11.57 107.9       73  96.4
#> 416 2020  59                Memphis Amer 21-10  11.53 100.6      210  89.1
#> 417 2020  60                Alabama  SEC 16-15  11.50 111.0       37  99.5
#> 418 2020  61                  Texas  B12 19-12  11.46 104.1      153  92.6
#> 419 2020  62            Saint Louis  A10  23-8  11.41 105.8      111  94.4
#> 420 2020  63            Arizona St.  P12 20-11  11.30 106.0      108  94.7
#> 421 2020  64           Georgia Tech  ACC 17-14  11.26 103.1      171  91.8
#> 422 2020  65           Rhode Island  A10  21-9  11.06 105.2      126  94.2
#> 423 2020  66             St. John's   BE 17-15  10.92 106.1      104  95.2
#> 424 2020  67             Georgetown   BE 15-17  10.82 111.0       36 100.2
#> 425 2020  68              Tennessee  SEC 17-14  10.80 106.6       96  95.8
#> 426 2020  69         South Carolina  SEC 18-13  10.66 105.4      122  94.7
#> 427 2020  70               Davidson  A10 16-14  10.62 112.5       26 101.9
#> 428 2020  71         Louisiana Tech CUSA  22-8  10.47 108.7       60  98.2
#> 429 2020  72                Clemson  ACC 16-15  10.42 103.9      155  93.5
#> 430 2020  73                    VCU  A10 18-13  10.29 104.7      138  94.4
#> 431 2020  74          San Francisco  WCC 22-12  10.13 108.3       68  98.2
#> 432 2020  75      Northern Colorado BSky  22-9  10.12 110.2       45 100.1
#> 433 2020  76                Vermont   AE  26-7  10.10 106.5       98  96.4
#> 434 2020  77            North Texas CUSA 20-11   9.97 111.2       34 101.2
#> 435 2020  78                   UCLA  P12 19-12   9.92 109.3       51  99.4
#> 436 2020  79                Liberty ASun  30-4   9.68 106.1      107  96.4
#> 437 2020  80                  Tulsa Amer 21-10   9.65 103.2      168  93.6
#> 438 2020  81                 Furman   SC  25-7   9.59 107.7       78  98.1
#> 439 2020  82                  Akron  MAC  24-7   9.54 108.5       66  98.9
#> 440 2020  83              Boise St.  MWC 20-12   9.40 107.0       88  97.6
#> 441 2020  84         North Carolina  ACC 14-19   9.36 107.7       77  98.4
#> 442 2020  85                 Nevada  MWC 19-12   9.32 110.3       44 101.0
#> 443 2020  86                    TCU  B12 16-16   9.31 105.5      119  96.1
#> 444 2020  87             Oregon St.  P12 18-13   8.93 110.9       39 102.0
#> 445 2020  88                    SMU Amer 19-11   8.62 112.4       28 103.8
#> 446 2020  89               Iowa St.  B12 12-20   8.35 109.6       48 101.2
#> 447 2020  90             Kansas St.  B12 11-21   8.25 102.5      177  94.2
#> 448 2020  91         New Mexico St.  WAC  25-6   8.14 107.6       80  99.4
#> 449 2020  92         UNC Greensboro   SC  23-9   8.12 103.7      160  95.5
#> 450 2020  93              Texas St.   SB 21-11   7.91 106.3      101  98.3
#> 451 2020  94                 DePaul   BE 16-16   7.90 103.4      165  95.5
#> 452 2020  95               Duquesne  A10  21-9   7.58 106.6       94  99.0
#> 453 2020  96                Georgia  SEC 16-16   7.44 108.2       71 100.8
#> 454 2020  97               Missouri  SEC 15-16   7.44 104.1      150  96.7
#> 455 2020  98                   UNLV  MWC 17-15   7.28 107.9       74 100.6
#> 456 2020  99           Colorado St.  MWC 20-12   7.15 109.3       52 102.1
#> 457 2020 100      Stephen F. Austin Slnd  28-3   7.00 104.1      152  97.1
#> 458 2020 101         Loyola Chicago  MVC 21-11   6.87 103.7      159  96.8
#> 459 2020 102            Mississippi  SEC 15-17   6.72 103.7      158  97.0
#> 460 2020 103            Wake Forest  ACC 13-18   6.70 108.7       61 102.0
#> 461 2020 104               Miami FL  ACC 15-16   6.39 107.7       79 101.3
#> 462 2020 105          Virginia Tech  ACC 16-16   6.33 104.3      147  98.0
#> 463 2020 106              UC Irvine   BW 21-11   6.11 105.4      121  99.3
#> 464 2020 107                Bradley  MVC 23-11   6.09 106.8       92 100.7
#> 465 2020 108                Hofstra  CAA  26-8   6.06 108.7       62 102.6
#> 466 2020 109                Belmont  OVC  26-7   6.02 106.5       97 100.5
#> 467 2020 110                Harvard  Ivy  21-8   5.69 104.7      137  99.0
#> 468 2020 111             Pittsburgh  ACC 16-17   5.65 104.0      154  98.3
#> 469 2020 112       North Dakota St.  Sum  25-8   5.56 106.8       91 101.2
#> 470 2020 113       Western Kentucky CUSA 20-10   5.56 108.9       56 103.3
#> 471 2020 114                   Utah  P12 16-15   5.56 106.3      100 100.8
#> 472 2020 115                 Temple Amer 14-17   5.49 100.1      217  94.6
#> 473 2020 116               Ball St.  MAC 18-13   5.25  99.2      235  94.0
#> 474 2020 117                    UCF Amer 16-14   4.88 103.5      162  98.6
#> 475 2020 118                Colgate  Pat  25-9   4.73 107.2       86 102.5
#> 476 2020 119       South Dakota St.  Sum 22-10   4.72 110.0       46 105.3
#> 477 2020 120                Pacific  WCC 23-10   4.70 103.8      156  99.1
#> 478 2020 121           Missouri St.  MVC 16-17   4.69 104.8      133 100.2
#> 479 2020 122            Indiana St.  MVC 18-12   4.59 105.8      113 101.2
#> 480 2020 123        St. Bonaventure  A10 19-12   4.37 106.6       95 102.2
#> 481 2020 124     Eastern Washington BSky  23-8   4.32 105.4      120 101.1
#> 482 2020 125          South Florida Amer 14-17   4.29 100.2      214  95.9
#> 483 2020 126            Georgia St.   SB 19-13   4.29 105.6      115 101.4
#> 484 2020 127         Washington St.  P12 16-16   4.22 102.2      182  98.0
#> 485 2020 128               Kent St.  MAC 20-12   4.06 106.1      105 102.1
#> 486 2020 129            Little Rock   SB 21-10   3.93 106.4       99 102.5
#> 487 2020 130           UT Arlington   SB 14-18   3.87 102.3      180  98.4
#> 488 2020 131              Texas A&M  SEC 16-14   3.77 101.0      203  97.2
#> 489 2020 132           Northwestern  B10  8-23   3.61 104.9      131 101.3
#> 490 2020 133             Wright St. Horz  25-7   3.47 104.9      132 101.4
#> 491 2020 134       Georgia Southern   SB 20-13   3.39 102.2      184  98.8
#> 492 2020 135           Oral Roberts  Sum 17-14   3.34 108.2       70 104.9
#> 493 2020 136             Murray St.  OVC  23-9   3.15 102.4      178  99.3
#> 494 2020 137                Montana BSky 18-13   3.08 103.2      169 100.1
#> 495 2020 138             New Mexico  MWC 19-14   2.88 105.3      125 102.4
#> 496 2020 139             Pepperdine  WCC 16-16   2.87 107.2       85 104.4
#> 497 2020 140               Winthrop BSth 24-10   2.65 104.7      136 102.1
#> 498 2020 141                   Penn  Ivy 16-11   2.63 103.4      163 100.8
#> 499 2020 142           Northeastern  CAA 17-16   2.19 105.4      123 103.2
#> 500 2020 143               Marshall CUSA 17-15   2.11 101.2      199  99.1
#> 501 2020 144      Northern Kentucky Horz  23-9   2.11 102.0      191  99.8
#> 502 2020 145                  Siena MAAC 20-10   2.06 107.2       87 105.1
#> 503 2020 146             Valparaiso  MVC 19-16   2.06 104.5      141 102.5
#> 504 2020 147            Chattanooga   SC 20-13   1.87 106.6       93 104.8
#> 505 2020 148                Buffalo  MAC 20-12   1.84 104.1      151 102.3
#> 506 2020 149                    FIU CUSA 19-13   1.58 103.7      157 102.1
#> 507 2020 150              Princeton  Ivy 14-13   1.50 107.0       89 105.5
#> 508 2020 151            Santa Clara  WCC 20-13   1.22 102.6      176 101.3
#> 509 2020 152                 Toledo  MAC 17-15   1.14 106.3      102 105.1
#> 510 2020 153             California  P12 14-18   1.10 101.5      195 100.4
#> 511 2020 154                Wofford   SC 19-16   1.08 104.5      142 103.4
#> 512 2020 155          South Alabama   SB 20-11   1.05 104.9      130 103.9
#> 513 2020 156       Western Carolina   SC 19-12   1.04 107.3       83 106.3
#> 514 2020 157             Fresno St.  MWC 11-19   1.03 105.1      127 104.1
#> 515 2020 158                 Towson  CAA 19-13   0.87 105.7      114 104.8
#> 516 2020 159      Boston University  Pat 21-13   0.78 103.3      166 102.6
#> 517 2020 160       UC Santa Barbara   BW 21-10   0.76 106.1      106 105.3
#> 518 2020 161          Southern Utah BSky 17-15   0.70  98.8      240  98.1
#> 519 2020 162               Nebraska  B10  7-25   0.64 102.0      190 101.3
#> 520 2020 163                  Drake  MVC 20-14   0.62 102.0      189 101.3
#> 521 2020 164              Charlotte CUSA 16-13   0.45  98.5      247  98.0
#> 522 2020 165          Massachusetts  A10 14-17   0.43 102.9      174 102.5
#> 523 2020 166          North Florida ASun 21-12   0.37 112.0       31 111.6
#> 524 2020 167                   Ohio  MAC 17-15   0.36 103.6      161 103.3
#> 525 2020 168          Bowling Green  MAC 21-10   0.33 104.3      146 104.0
#> 526 2020 169             Vanderbilt  SEC 11-21   0.14 104.7      139 104.5
#> 527 2020 170             Charleston  CAA 17-14   0.08 105.0      129 104.9
#> 528 2020 171           Old Dominion CUSA 13-19  -0.02  98.3      249  98.3
#> 529 2020 172            Austin Peay  OVC 21-12  -0.02 106.9       90 107.0
#> 530 2020 173           Portland St. BSky 18-14  -0.03 108.8       57 108.8
#> 531 2020 174           George Mason  A10 17-15  -0.04 101.3      197 101.3
#> 532 2020 175        Appalachian St.   SB 18-15  -0.27  99.9      220 100.2
#> 533 2020 176         St. Francis PA  NEC 22-10  -0.32 107.6       81 107.9
#> 534 2020 177           South Dakota  Sum 20-12  -0.36 108.6       63 108.9
#> 535 2020 178      Southern Illinois  MVC 16-16  -0.41  98.2      252  98.6
#> 536 2020 179         Boston College  ACC 13-19  -0.68  99.6      228 100.3
#> 537 2020 180               Delaware  CAA 22-11  -0.78 105.6      116 106.4
#> 538 2020 181               La Salle  A10 15-15  -0.81  99.6      226 100.4
#> 539 2020 182      Northern Illinois  MAC 18-13  -1.03  99.8      222 100.8
#> 540 2020 183         Sacramento St. BSky 16-14  -1.10  97.1      268  98.2
#> 541 2020 184      Abilene Christian Slnd 20-11  -1.14  99.1      239 100.2
#> 542 2020 185                 Tulane Amer 12-18  -1.15 101.9      192 103.1
#> 543 2020 186                Radford BSth 21-11  -1.17 105.6      118 106.8
#> 544 2020 187                  Rider MAAC 18-12  -1.19 100.9      204 102.1
#> 545 2020 188                   UTEP CUSA 17-15  -1.28  96.9      273  98.2
#> 546 2020 189                    UAB CUSA 19-13  -1.32 100.8      205 102.1
#> 547 2020 190       Coastal Carolina   SB 16-17  -1.33 104.8      134 106.2
#> 548 2020 191       Florida Atlantic CUSA 17-15  -1.66  99.7      225 101.3
#> 549 2020 192            Stony Brook   AE 20-13  -1.74  97.7      260  99.4
#> 550 2020 193           Nicholls St. Slnd 21-10  -1.82  99.7      223 101.5
#> 551 2020 194          Saint Peter's MAAC 18-12  -1.98  95.4      300  97.3
#> 552 2020 195         William & Mary  CAA 21-11  -2.17 103.3      167 105.5
#> 553 2020 196       Eastern Michigan  MAC 16-16  -2.34  94.2      318  96.6
#> 554 2020 197              Air Force  MWC 12-20  -2.49 107.8       76 110.3
#> 555 2020 198                 Mercer   SC 17-15  -2.61 100.1      216 102.7
#> 556 2020 199                   Rice CUSA 15-17  -2.62 105.8      110 108.4
#> 557 2020 200           Sacred Heart  NEC 20-13  -2.64 102.2      185 104.8
#> 558 2020 201               Monmouth MAAC 18-13  -2.72  99.1      238 101.8
#> 559 2020 202            Cal Baptist  WAC 21-10  -2.73 105.3      124 108.1
#> 560 2020 203               American  Pat 16-14  -2.88 101.1      202 104.0
#> 561 2020 204       Illinois Chicago Horz 18-17  -3.14  96.4      280  99.5
#> 562 2020 205              Dartmouth  Ivy 12-17  -3.18  96.7      276  99.9
#> 563 2020 206           Arkansas St.   SB 16-16  -3.29 104.2      148 107.5
#> 564 2020 207          Robert Morris  NEC 20-14  -3.29 100.5      212 103.8
#> 565 2020 208                 Hawaii   BW 17-13  -3.34  97.6      261 101.0
#> 566 2020 209       Loyola Marymount  WCC 11-21  -3.42 100.6      209 104.0
#> 567 2020 210                   UTSA CUSA 13-19  -3.84 104.2      149 108.0
#> 568 2020 211           UC Riverside   BW 17-15  -3.97  95.8      294  99.8
#> 569 2020 212        Sam Houston St. Slnd 18-13  -4.13  99.5      229 103.7
#> 570 2020 213       Prairie View A&M SWAC 19-13  -4.16  96.3      282 100.5
#> 571 2020 214                Seattle  WAC 14-15  -4.34 101.2      200 105.5
#> 572 2020 215       Northern Arizona BSky 16-14  -4.35 102.3      179 106.7
#> 573 2020 216       Central Michigan  MAC 14-18  -4.40 102.0      187 106.4
#> 574 2020 217          East Carolina Amer 11-20  -4.42  99.6      227 104.0
#> 575 2020 218           Gardner Webb BSth 16-16  -4.48 102.2      181 106.7
#> 576 2020 219         Nebraska Omaha  Sum 16-16  -4.50 103.2      170 107.7
#> 577 2020 220           Illinois St.  MVC 10-21  -4.55  98.4      248 102.9
#> 578 2020 221                   Iona MAAC 12-17  -4.56 101.6      194 106.1
#> 579 2020 222            Montana St. BSky 16-15  -4.60  97.0      270 101.6
#> 580 2020 223              Green Bay Horz 17-16  -4.64 105.8      109 110.5
#> 581 2020 224                  Brown  Ivy 15-12  -4.69  96.4      278 101.1
#> 582 2020 225               UC Davis   BW 14-18  -4.77 104.7      140 109.4
#> 583 2020 226              Louisiana   SB 14-19  -4.89 101.3      196 106.2
#> 584 2020 227              Merrimack  NEC 20-11  -4.89  93.9      325  98.8
#> 585 2020 228              Lafayette  Pat 19-12  -4.91 100.6      211 105.5
#> 586 2020 229               Miami OH  MAC 13-19  -4.99 102.0      188 107.0
#> 587 2020 230              San Diego  WCC  9-23  -5.38  94.4      315  99.8
#> 588 2020 231           North Dakota  Sum 15-18  -5.49 102.2      183 107.7
#> 589 2020 232         Youngstown St. Horz 18-15  -5.59 103.0      173 108.5
#> 590 2020 233     Cal St. Northridge   BW 15-17  -5.86 107.4       82 113.3
#> 591 2020 234                 Bryant  NEC 15-17  -6.03  97.8      257 103.8
#> 592 2020 235                   UMKC  WAC 16-14  -6.09  97.5      263 103.6
#> 593 2020 236                  Lamar Slnd 17-15  -6.16  96.3      283 102.5
#> 594 2020 237       Western Michigan  MAC 13-19  -6.35  99.4      232 105.7
#> 595 2020 238       Eastern Illinois  OVC 17-15  -6.36  98.2      253 104.5
#> 596 2020 239                Oakland Horz 14-19  -6.47  98.6      246 105.0
#> 597 2020 240           Jacksonville ASun 14-18  -6.52  96.0      290 102.5
#> 598 2020 241      George Washington  A10 12-20  -6.54  99.2      236 105.8
#> 599 2020 242               Bucknell  Pat 14-20  -6.68  96.2      285 102.9
#> 600 2020 243               Hartford   AE 18-15  -6.72  94.4      312 101.1
#> 601 2020 244                 Drexel  CAA 14-19  -6.76 100.0      219 106.7
#> 602 2020 245                Fordham  A10  9-22  -6.79  89.1      347  95.9
#> 603 2020 246                Wyoming  MWC  9-24  -6.79  94.1      322 100.9
#> 604 2020 247               Lipscomb ASun 16-16  -6.86 101.2      201 108.0
#> 605 2020 248          New Hampshire   AE 15-15  -7.11  95.0      304 102.1
#> 606 2020 249   UT Rio Grande Valley  WAC 14-16  -7.32  98.7      244 106.0
#> 607 2020 250               Southern SWAC 17-15  -7.57  97.2      267 104.8
#> 608 2020 251             Quinnipiac MAAC 15-15  -7.65 100.7      207 108.3
#> 609 2020 252       Louisiana Monroe   SB  9-20  -7.68  96.1      287 103.7
#> 610 2020 253            Utah Valley  WAC 11-19  -7.74  96.5      277 104.2
#> 611 2020 254            Norfolk St. MEAC 16-15  -7.76  94.2      321 101.9
#> 612 2020 255                   Navy  Pat 14-16  -7.90  98.1      254 106.0
#> 613 2020 256                   UMBC   AE 16-17  -7.93  97.8      258 105.7
#> 614 2020 257                    VMI   SC  9-24  -7.96 100.2      215 108.1
#> 615 2020 258               Canisius MAAC 12-20  -7.97  97.7      259 105.7
#> 616 2020 259          Tennessee St.  OVC 18-15  -8.15  96.4      279 104.6
#> 617 2020 260         Saint Joseph's  A10  6-26  -8.34 101.9      193 110.2
#> 618 2020 261      Purdue Fort Wayne  Sum 14-19  -8.43  95.4      299 103.8
#> 619 2020 262               Campbell BSth 15-16  -8.50  96.8      275 105.3
#> 620 2020 263      Cal St. Fullerton   BW 11-20  -8.54  95.9      292 104.5
#> 621 2020 264                   Army  Pat 15-15  -8.63  98.8      242 107.4
#> 622 2020 265           Grand Canyon  WAC 13-17  -8.68 103.4      164 112.1
#> 623 2020 266    Cal St. Bakersfield  WAC 12-19  -8.70  96.2      286 104.9
#> 624 2020 267                    LIU  NEC 15-18  -8.71  97.4      265 106.1
#> 625 2020 268              Loyola MD  Pat 15-17  -8.75 100.4      213 109.1
#> 626 2020 269              Manhattan MAAC 13-18  -8.76  92.8      331 101.6
#> 627 2020 270       Northwestern St. Slnd 15-15  -8.87  98.3      251 107.1
#> 628 2020 271              Milwaukee Horz 12-19  -8.89  96.0      288 104.9
#> 629 2020 272 North Carolina Central MEAC 18-13  -9.00  94.2      319 103.2
#> 630 2020 273              Weber St. BSky 12-20  -9.09  98.8      241 107.9
#> 631 2020 274                Cornell  Ivy  7-20  -9.10 101.2      198 110.3
#> 632 2020 275           UMass Lowell   AE 13-19  -9.15 104.4      144 113.6
#> 633 2020 276            McNeese St. Slnd 15-17  -9.32 103.0      172 112.3
#> 634 2020 277                   Elon  CAA 13-21  -9.35 100.6      208 110.0
#> 635 2020 278         Texas Southern SWAC 16-16  -9.42  99.1      237 108.6
#> 636 2020 279          Southern Miss CUSA  9-22  -9.44  94.4      313 103.8
#> 637 2020 280       Eastern Kentucky  OVC 16-17  -9.46  95.4      297 104.9
#> 638 2020 281            Jackson St. SWAC 15-17  -9.55  92.8      333 102.3
#> 639 2020 282                 Albany   AE 14-18  -9.55  94.3      316 103.9
#> 640 2020 283       Central Arkansas Slnd 10-21  -9.56  98.0      256 107.6
#> 641 2020 284          North Alabama ASun 13-17  -9.57  96.0      289 105.6
#> 642 2020 285       Jacksonville St.  OVC 13-19  -9.67  95.8      293 105.5
#> 643 2020 286               Portland  WCC  9-23  -9.93  94.4      314 104.3
#> 644 2020 287     North Carolina A&T MEAC 17-15 -10.07  92.3      335 102.4
#> 645 2020 288                Stetson ASun 16-17 -10.22  98.1      255 108.3
#> 646 2020 289    Fairleigh Dickinson  NEC 11-19 -10.23 102.1      186 112.4
#> 647 2020 290           San Jose St.  MWC  7-24 -10.31  97.5      262 107.8
#> 648 2020 291              Idaho St. BSky  8-22 -10.37 100.8      206 111.1
#> 649 2020 292        Bethune Cookman MEAC 16-14 -10.39  95.4      298 105.8
#> 650 2020 293                   Troy   SB  9-22 -10.43  96.2      284 106.6
#> 651 2020 294             Evansville  MVC  9-23 -10.56  96.9      274 107.4
#> 652 2020 295       Middle Tennessee CUSA  8-23 -10.66  97.5      264 108.2
#> 653 2020 296                   NJIT ASun  9-21 -11.07  94.7      307 105.8
#> 654 2020 297         Long Beach St.   BW 11-21 -11.08  94.2      320 105.3
#> 655 2020 298       Mount St. Mary's  NEC 11-21 -11.10  96.4      281 107.5
#> 656 2020 299               Columbia  Ivy  6-24 -11.27  95.2      302 106.5
#> 657 2020 300                Niagara MAAC 12-20 -11.54 100.1      218 111.6
#> 658 2020 301              Fairfield MAAC 12-20 -11.59  90.1      344 101.6
#> 659 2020 302          UNC Asheville BSth 15-16 -11.61  98.7      243 110.3
#> 660 2020 303 Texas A&M Corpus Chris Slnd 14-18 -11.71  94.3      317 106.0
#> 661 2020 304                 Lehigh  Pat 11-21 -11.72  97.0      269 108.8
#> 662 2020 305                 Denver  Sum  7-24 -11.75  95.0      303 106.8
#> 663 2020 306                Detroit Horz  8-23 -11.84  99.9      221 111.7
#> 664 2020 307         St. Francis NY  NEC 13-18 -11.90  94.6      308 106.5
#> 665 2020 308                Hampton BSth 15-19 -11.95 104.8      135 116.7
#> 666 2020 309          Grambling St. SWAC 17-15 -11.99  93.1      328 105.1
#> 667 2020 310     Florida Gulf Coast ASun 10-22 -12.02  91.2      340 103.3
#> 668 2020 311          James Madison  CAA  9-21 -12.11  99.5      230 111.6
#> 669 2020 312         UNC Wilmington  CAA 10-22 -12.40  92.1      337 104.5
#> 670 2020 313          Cleveland St. Horz 11-21 -12.83  92.9      329 105.7
#> 671 2020 314            Florida A&M MEAC 12-15 -12.85  94.4      311 107.3
#> 672 2020 315               Cal Poly   BW  7-23 -13.25  95.2      301 108.5
#> 673 2020 316           Morehead St.  OVC 13-19 -13.52  94.6      309 108.1
#> 674 2020 317                 Marist MAAC  7-23 -13.59  90.2      343 103.8
#> 675 2020 318    Charleston Southern BSth 14-18 -13.61  95.4      296 109.1
#> 676 2020 319               Longwood BSth 14-18 -13.82  91.3      339 105.1
#> 677 2020 320                  Maine   AE  9-22 -13.91  92.9      330 106.8
#> 678 2020 321                Samford   SC 10-23 -14.01  98.6      245 112.6
#> 679 2020 322             Morgan St. MEAC 15-16 -14.26  93.2      327 107.5
#> 680 2020 323                  Idaho BSky  8-24 -14.29  92.8      332 107.1
#> 681 2020 324             Alcorn St. SWAC 15-15 -14.36  96.9      271 111.3
#> 682 2020 325            USC Upstate BSth 13-20 -15.34  95.5      295 110.8
#> 683 2020 326            New Orleans Slnd  9-21 -15.51  99.3      233 114.8
#> 684 2020 327             Coppin St. MEAC 11-20 -15.66  89.6      346 105.3
#> 685 2020 328                  IUPUI Horz  7-25 -16.18  99.4      231 115.6
#> 686 2020 329                 Wagner  NEC  8-21 -16.64  97.3      266 113.9
#> 687 2020 330       Western Illinois  Sum  5-21 -16.68  98.3      250 115.0
#> 688 2020 331         Tennessee Tech  OVC  9-22 -16.73  92.5      334 109.3
#> 689 2020 332            Alabama St. SWAC  8-24 -17.19  86.2      350 103.4
#> 690 2020 333             Binghamton   AE 10-19 -17.22  99.7      224 116.9
#> 691 2020 334            The Citadel   SC  6-24 -17.25  94.9      305 112.2
#> 692 2020 335           Presbyterian BSth 10-22 -17.47  96.9      272 114.4
#> 693 2020 336 Southeastern Louisiana Slnd  8-23 -17.62  92.0      338 109.6
#> 694 2020 337       SIU Edwardsville  OVC  8-23 -17.72  92.3      336 110.0
#> 695 2020 338       Tennessee Martin  OVC  9-20 -17.82 105.1      128 122.9
#> 696 2020 339     South Carolina St. MEAC 11-18 -18.29  94.9      306 113.2
#> 697 2020 340 Southeast Missouri St.  OVC  7-24 -19.00  94.0      324 113.0
#> 698 2020 341             High Point BSth  9-23 -19.07  94.5      310 113.6
#> 699 2020 342        Houston Baptist Slnd  4-25 -19.38 102.9      175 122.3
#> 700 2020 343            Alabama A&M SWAC  8-22 -20.22  87.9      348 108.2
#> 701 2020 344             Holy Cross  Pat  3-29 -21.34  95.9      291 117.3
#> 702 2020 345         Incarnate Word Slnd  9-22 -22.46  90.3      341 112.8
#> 703 2020 346           Delaware St. MEAC  6-26 -23.11  94.1      323 117.2
#> 704 2020 347    Central Connecticut  NEC  4-27 -23.67  90.3      342 114.0
#> 705 2020 348    Arkansas Pine Bluff SWAC  4-26 -25.63  79.0      353 104.6
#> 706 2020 349 Maryland Eastern Shore MEAC  5-27 -26.14  81.7      352 107.8
#> 707 2020 350                 Howard MEAC  4-29 -26.15  93.6      326 119.7
#> 708 2020 351 Mississippi Valley St. SWAC  4-27 -27.87  89.8      345 117.6
#> 709 2020 352           Kennesaw St. ASun  1-28 -28.71  83.5      351 112.2
#> 710 2020 353            Chicago St.  WAC  4-25 -33.99  86.9      349 120.8
#>     adj_d_rk adj_t adj_t_rk   luck luck_rk sos_adj_em sos_adj_em_rk sos_opp_o
#> 1         11  73.8        7  0.022     127      11.35            72     108.1
#> 2         22  67.4      213  0.046      80      13.25            54     108.7
#> 3          4  66.6      256  0.007     156      16.44            19     111.7
#> 4          7  70.5       79  0.022     128      18.17             5     112.3
#> 5          9  64.4      332  0.018     133       9.21            90     105.7
#> 6          6  67.0      235  0.001     171      16.27            21     111.1
#> 7         75  69.9       93 -0.027     244      16.41            20     110.4
#> 8         23  66.1      276 -0.025     237      15.43            28     110.3
#> 9          3  73.3       11  0.020     131      14.80            33     110.1
#> 10         2  63.7      342 -0.024     233       6.27           112     105.6
#> 11        82  66.7      251 -0.012     212      17.90             9     111.6
#> 12        66  64.2      336 -0.007     200      13.66            47     109.3
#> 13        46  63.8      341  0.028     110      17.38            11     111.3
#> 14        15  64.6      328 -0.052     289      18.13             6     112.1
#> 15        33  69.9       90  0.002     167      13.48            50     109.5
#> 16        55  67.2      226  0.049      72      15.20            30     110.6
#> 17        18  65.1      316 -0.099     340      12.84            59     108.5
#> 18        10  72.6       19  0.064      51      12.69            63     109.4
#> 19        36  59.9      357  0.025     118      12.05            69     109.8
#> 20        30  67.6      206  0.037      91      12.31            65     109.1
#> 21        29  65.5      309 -0.068     310      12.99            57     108.2
#> 22        32  68.7      144  0.017     137      13.19            55     108.8
#> 23        70  69.2      122 -0.056     294      15.18            31     109.6
#> 24       124  70.6       70 -0.007     201      14.77            35     108.7
#> 25        34  66.1      278  0.010     148      16.61            17     111.2
#> 26        31  68.6      146 -0.004     190      14.52            38     109.2
#> 27        12  68.2      174  0.070      44      15.83            24     110.7
#> 28         5  67.1      232 -0.013     215      13.11            56     108.9
#> 29        59  67.7      198 -0.017     220      13.38            51     109.3
#> 30        21  65.5      307  0.027     114       7.22           103     106.4
#> 31         1  71.3       48 -0.068     311       8.72            96     105.9
#> 32        20  64.8      320  0.016     140       8.53            98     106.6
#> 33        17  72.4       24  0.038      90      15.52            27     111.1
#> 34        27  71.5       43 -0.005     194      14.79            34     110.9
#> 35        42  64.7      321 -0.024     234      17.10            13     110.2
#> 36        79  68.5      152 -0.109     347      12.27            67     109.1
#> 37        68  67.3      223 -0.005     193      12.70            61     108.7
#> 38        16  67.4      214  0.027     113      17.99             7     112.4
#> 39        51  67.1      228 -0.025     238      14.29            43     109.5
#> 40        52  69.1      125 -0.050     286      19.38             1     112.2
#> 41        41  68.3      167 -0.004     188      14.72            36     109.9
#> 42        77  68.6      151  0.029     109      12.94            58     109.4
#> 43        60  65.5      306  0.072      40      16.72            16     111.2
#> 44        78  67.6      203 -0.077     319      15.67            25     110.5
#> 45        19  64.0      337  0.100      18      14.39            41     109.7
#> 46         8  68.6      149 -0.037     262       5.64           120     105.4
#> 47        57  68.4      163  0.070      43      15.85            23     110.2
#> 48        14  69.6      107  0.035      97       8.57            97     106.5
#> 49        35  68.1      181 -0.148     354      16.91            15     110.9
#> 50        43  65.9      289 -0.053     290      18.33             3     111.4
#> 51        25  64.9      318 -0.063     301      10.75            78     107.9
#> 52        53  65.7      298  0.043      82       9.69            85     107.9
#> 53        65  68.0      184 -0.037     263       5.58           121     104.7
#> 54        63  66.5      264 -0.027     245      14.43            40     109.7
#> 55       101  66.3      271  0.102      17       3.98           137     104.1
#> 56        76  68.8      141 -0.012     210       8.72            95     105.0
#> 57        28  69.2      120  0.022     126      16.46            18     111.2
#> 58        69  65.6      301  0.030     108       1.80           168     102.8
#> 59        44  65.7      300  0.118       9      13.29            53     109.9
#> 60       103  71.0       54 -0.044     275      14.54            37     109.3
#> 61        64  69.1      128 -0.026     242       6.12           115     105.4
#> 62        56  69.9       88  0.011     147      17.03            14     111.4
#> 63        49  69.7      101  0.008     154      14.96            32     110.6
#> 64        45  68.3      164  0.090      22      17.72            10     112.5
#> 65        99  68.2      169 -0.061     298       9.22            89     107.2
#> 66        94  67.9      186  0.003     165      10.29            82     107.9
#> 67        54  65.8      296 -0.011     207      12.31            66     107.5
#> 68        84  67.0      234  0.089      23      10.47            81     106.4
#> 69       112  73.4       10  0.014     144      11.04            74     107.6
#> 70       164  62.5      353 -0.074     316       6.91           106     104.7
#> 71        87  67.8      193 -0.011     209      10.91            75     109.1
#> 72        48  62.7      350 -0.018     222       6.35           109     105.0
#> 73        73  71.1       52 -0.078     321      -3.35           251     102.7
#> 74       182  68.7      143 -0.024     236       3.03           150     104.8
#> 75        13  62.9      348  0.037      92      10.85            76     108.8
#> 76        72  69.0      133  0.045      81       5.44           122     104.3
#> 77        67  73.1       16 -0.098     339       3.27           145     105.6
#> 78        24  67.6      207 -0.010     203      12.08            68     108.9
#> 79        37  68.4      160 -0.091     331      19.18             2     112.9
#> 80        74  66.3      270  0.001     170      13.51            49     109.4
#> 81       145  69.2      123  0.031     104       5.23           126     106.1
#> 82        39  69.4      112  0.055      62       3.02           151     103.2
#> 83        83  67.4      216 -0.007     199      14.12            44     109.7
#> 84        26  69.3      115  0.009     150      -5.43           298      99.4
#> 85       203  67.2      227 -0.029     248      14.31            42     110.7
#> 86       106  72.5       21  0.026     116      16.04            22     110.9
#> 87       109  65.5      305  0.006     160       8.46            99     105.1
#> 88       104  69.1      127  0.039      87       3.85           140     104.0
#> 89       148  72.2       26  0.048      74      -5.80           305      99.6
#> 90       120  71.4       47  0.002     169       9.52            86     107.1
#> 91       125  69.8       95 -0.012     213       6.26           113     104.7
#> 92       133  72.6       20 -0.068     312       1.45           172     102.9
#> 93        96  67.7      197 -0.104     342       8.22           101     106.8
#> 94       114  66.0      284  0.033      99       8.41           100     105.6
#> 95       118  73.2       13  0.048      75      12.37            64     107.9
#> 96       151  67.7      200 -0.086     324       2.56           160     104.3
#> 97       122  68.3      165 -0.068     309      10.58            80     108.3
#> 98       153  63.1      347 -0.023     231      -4.82           287      99.5
#> 99        97  67.4      219  0.083      27       4.32           133     103.6
#> 100       95  67.2      225  0.053      64      12.76            60     107.1
#> 101       71  73.1       14  0.036      96      -5.62           302      99.6
#> 102       50  67.0      238  0.005     162      -1.59           216     100.1
#> 103       81  64.9      319 -0.061     299      -1.44           211     102.0
#> 104      136  68.6      147 -0.128     352      12.70            62     107.9
#> 105      156  72.2       27 -0.085     323      -0.43           195     102.0
#> 106       58  66.7      254 -0.066     305       0.84           182     102.6
#> 107       38  67.4      222  0.031     103       3.13           147     103.6
#> 108       62  68.0      183  0.003     166       1.48           171     103.8
#> 109       40  71.8       35 -0.128     351      18.30             4     112.4
#> 110      170  70.7       64  0.050      69      -5.84           307      98.9
#> 111       89  69.0      134 -0.109     344       9.40            87     106.6
#> 112      159  68.5      153 -0.001     183       4.26           134     105.8
#> 113      222  70.9       59  0.008     153       1.43           173     103.6
#> 114      115  64.7      322 -0.067     308      15.58            26     110.7
#> 115      121  69.8       98  0.023     123       3.94           138     106.5
#> 116       90  70.7       66  0.115      11      11.11            73     107.3
#> 117       98  67.0      237  0.021     130       9.97            84     107.6
#> 118      128  71.6       41 -0.057     297       3.71           141     103.1
#> 119       85  66.9      244  0.079      31       6.51           108     105.7
#> 120       86  64.6      326  0.069      45      14.50            39     109.9
#> 121       91  65.6      303 -0.024     235       8.99            93     105.6
#> 122      185  71.9       33 -0.028     246      -3.07           246     101.0
#> 123      172  67.9      185  0.000     173     -99.00           348       0.0
#> 124      113  74.6        3 -0.055     293      15.42            29     109.7
#> 125      219  71.4       46  0.023     125       4.09           135     105.2
#> 126       80  69.0      135  0.007     159       6.63           107     105.0
#> 127      171  65.9      291  0.025     119       3.38           144     105.0
#> 128      117  65.4      311 -0.063     302       3.87           139     104.9
#> 129      134  71.0       53 -0.061     300      17.97             8     112.0
#> 130      168  69.8       96 -0.037     260       3.46           143     105.5
#> 131      186  67.7      196 -0.002     184       2.05           165     104.1
#> 132      158  63.6      344 -0.024     232       1.53           170     102.7
#> 133      177  66.4      267 -0.069     313      -7.92           332      96.4
#> 134       88  65.2      314  0.146       4      -1.10           204     102.1
#> 135      240  69.9       92  0.082      28      -3.56           255     100.9
#> 136      131  67.8      191 -0.065     304       5.18           127     104.0
#> 137      111  64.3      334  0.018     135       9.10            91     107.0
#> 138      116  67.8      190  0.019     132      11.91            70     109.2
#> 139      143  64.6      327 -0.033     254       1.30           176     104.4
#> 140      166  66.6      258  0.089      24      11.88            71     107.9
#> 141       47  70.6       72 -0.048     280      13.30            52     109.0
#> 142      102  68.1      176  0.046      77       3.26           146     104.5
#> 143      110  68.6      148 -0.092     332       8.84            94     105.8
#> 144       93  67.4      221  0.013     145       7.32           102     104.4
#> 145      105  70.4       81  0.147       3       5.78           119     104.5
#> 146      162  65.9      288 -0.086     325       5.85           118     105.5
#> 147      100  65.5      308  0.026     117      14.05            45     109.9
#> 148      200  70.9       58 -0.097     337      13.86            46     110.5
#> 149      167  70.7       67 -0.049     283       4.48           130     106.1
#> 150      184  64.6      325 -0.066     306      -2.44           231     100.5
#> 151      174  69.7      102  0.047      76      -7.61           329      98.1
#> 152      126  67.4      217  0.140       5       2.72           157     102.8
#> 153      269  69.9       89 -0.048     279       2.95           153     104.6
#> 154      226  70.5       78  0.076      35      -1.79           217     101.2
#> 155      107  67.9      187 -0.016     218       6.22           114     104.7
#> 156      178  66.4      269  0.102      16       0.68           185     103.3
#> 157      234  65.8      293  0.002     168       2.88           154     104.8
#> 158      248  63.9      340  0.007     158      -2.28           227     101.2
#> 159      267  68.9      136 -0.015     216       0.22           191     103.3
#> 160      252  71.8       37  0.021     129       3.10           148     102.6
#> 161      299  67.1      230 -0.051     287      -1.93           221     103.6
#> 162      220  65.8      292  0.017     139      -2.68           239     101.1
#> 163      190  68.8      139 -0.022     229       7.13           104     105.2
#> 164      301  69.0      129  0.046      78       1.30           175     102.4
#> 165      209  66.6      257  0.000     173     -99.00           348       0.0
#> 166      201  65.9      286  0.179       2      -5.28           294      98.2
#> 167      293  65.1      315 -0.015     217      -3.95           268     100.1
#> 168      108  67.0      236  0.056      58       3.03           149     105.2
#> 169      138  66.1      279  0.199       1      -0.83           202     105.1
#> 170      147  66.8      247  0.049      73      10.01            83     106.1
#> 171      135  69.9       91 -0.120     349      17.29            12     111.6
#> 172      139  67.5      208 -0.013     214      -4.60           283      98.8
#> 173      195  66.2      275 -0.177     356      -5.03           290      99.6
#> 174      160  74.8        2  0.085      26      -5.34           297      99.8
#> 175      169  67.0      241 -0.109     345      13.51            48     110.4
#> 176      217  66.1      281 -0.037     261       5.30           125     104.3
#> 177      210  71.8       36 -0.048     278      -1.91           220     101.1
#> 178      146  67.7      199  0.030     107      -5.67           303      98.3
#> 179      130  71.1       51 -0.020     226      -5.02           289      99.8
#> 180      179  70.9       57  0.092      20      -2.65           238     100.4
#> 181      192  68.1      177 -0.098     338      -1.50           212     101.2
#> 182      246  66.7      252 -0.165     355      -3.83           266     100.3
#> 183      141  62.4      354  0.072      41      -5.94           308      98.6
#> 184      194  68.1      180  0.000     173     -99.00           348       0.0
#> 185      223  74.0        6 -0.044     273      -7.65           330      98.2
#> 186      163  66.2      273 -0.057     296      -7.28           325      96.7
#> 187      208  66.9      245 -0.020     225       0.65           186     101.8
#> 188      261  69.3      114  0.039      88       2.38           162     102.1
#> 189      154  65.7      299  0.009     149       2.56           159     104.7
#> 190      295  68.1      179  0.052      65      -1.31           210     101.6
#> 191      176  65.8      295  0.065      48       4.63           129     104.5
#> 192      188  66.2      274  0.075      37       4.76           128     104.4
#> 193      123  67.0      239 -0.028     247       6.33           110     105.7
#> 194      127  66.9      243  0.081      30      -5.09           291      99.2
#> 195      137  70.2       84 -0.025     239      10.79            77     108.1
#> 196      204  71.6       42  0.121       8      -6.96           320      98.6
#> 197      161  68.4      157  0.034      98      -1.17           208     103.3
#> 198      180  69.0      132 -0.112     348       5.34           123     105.4
#> 199      215  70.2       85  0.007     157       0.60           189     103.2
#> 200      245  68.5      155 -0.012     211       7.06           105     104.7
#> 201      214  71.0       56  0.096      19      -3.74           265     100.4
#> 202      230  72.1       30  0.027     115      10.62            79     107.8
#> 203      129  62.5      352 -0.074     317       1.37           174     104.6
#> 204      315  62.0      355  0.011     146       4.00           136     103.5
#> 205      142  66.5      265  0.014     142      -1.59           215     102.1
#> 206      286  64.7      323  0.056      59      -2.82           242     102.2
#> 207      198  68.2      168  0.055      61      -1.12           205     102.4
#> 208      212  71.5       45  0.059      54      -7.73           331      95.5
#> 209      181  69.2      119  0.087      25      -1.01           203     101.7
#> 210      199  67.5      211  0.090      21      -7.09           322      98.1
#> 211      281  63.9      338  0.064      49      -5.23           293      99.0
#> 212      191  65.5      310  0.039      86      -2.83           243     100.4
#> 213      197  68.8      140 -0.036     258      -1.24           209     102.7
#> 214      165  68.4      162 -0.190     357      -4.36           276     101.9
#> 215      302  66.8      249 -0.071     315      -5.33           296      98.6
#> 216      271  69.8       97 -0.010     204      -2.14           225     101.9
#> 217      294  66.5      261  0.043      84      -3.09           247      99.2
#> 218      305  74.2        4  0.064      50       2.53           161     104.2
#> 219      236  69.2      124  0.000     173     -99.00           348       0.0
#> 220      266  66.8      246  0.000     173     -99.00           348       0.0
#> 221      306  69.6      104  0.046      79       2.29           164     105.4
#> 222       61  66.7      253 -0.006     197      -6.37           316      98.3
#> 223      247  71.9       32 -0.037     259      -8.44           335      95.8
#> 224      265  65.5      304  0.068      46      -8.56           336      97.8
#> 225      193  66.5      262 -0.069     314      -4.03           269     101.9
#> 226      229  74.2        5  0.050      71      -6.16           312      96.9
#> 227      285  67.8      188 -0.094     335       0.63           187      99.9
#> 228      231  67.8      189 -0.004     192      -2.05           222     100.8
#> 229      321  70.5       76 -0.016     219      -4.46           277      99.8
#> 230      259  69.0      131  0.055      60      -1.81           218     100.3
#> 231      289  69.7       99  0.023     124       6.01           116     104.0
#> 232      297  63.5      345 -0.030     249      -2.06           223     101.5
#> 233      270  67.8      194 -0.006     196      -2.07           224     101.7
#> 234      206  62.7      351 -0.032     251       0.99           180     102.5
#> 235      152  69.2      121  0.111      12     -13.88           346      93.3
#> 236      157  66.4      268 -0.090     330      -3.12           248     100.2
#> 237      150  61.6      356 -0.004     191      -6.45           317      99.4
#> 238      282  66.0      282  0.024     120      -3.63           259     100.2
#> 239      235  67.0      240 -0.040     266      -2.76           241      99.8
#> 240      211  69.6      108 -0.079     322      -4.50           280      98.9
#> 241      272  70.5       77  0.031     105       1.92           166     104.4
#> 242      224  73.7        8 -0.011     208       0.68           184     102.4
#> 243      225  63.5      346  0.023     122      -4.51           281     100.1
#> 244      283  68.2      170 -0.008     202      -5.46           299      99.4
#> 245      132  69.2      116 -0.135     353      -2.41           230     101.1
#> 246      310  67.6      202  0.032     101      -4.05           271     102.0
#> 247      237  65.0      317 -0.027     243      -4.04           270     100.4
#> 248      309  69.0      130 -0.122     350      -4.61           284     100.1
#> 249      189  69.7      100  0.000     173     -99.00           348       0.0
#> 250      280  64.5      329 -0.041     268      -5.72           304      96.5
#> 251      273  70.6       74  0.058      56      -5.54           301      96.0
#> 252      276  67.6      201 -0.041     270      -3.60           257      99.4
#> 253      260  69.2      118  0.051      67      -2.71           240      99.8
#> 254      318  65.3      313 -0.030     250       0.63           188     103.2
#> 255      313  71.8       39 -0.044     274      -0.03           193     102.3
#> 256      149  67.4      218 -0.078     320       1.08           178     102.1
#> 257      324  65.9      285 -0.042     271      -1.16           207     103.2
#> 258      175  64.2      335  0.000     172      -2.49           234     101.1
#> 259      320  70.1       86  0.059      55       1.03           179     102.3
#> 260      307  65.6      302  0.008     152      -2.16           226     102.5
#> 261      256  64.4      331 -0.052     288       0.81           183     102.0
#> 262      335  68.6      145  0.062      53      -8.82           338      96.6
#> 263      243  72.1       28  0.076      36      -2.49           233     102.1
#> 264      257  72.7       17 -0.035     255       2.79           155     104.1
#> 265       92  68.4      159  0.111      13     -12.38           344      93.8
#> 266      155  66.1      280  0.082      29      -7.36           327      97.2
#> 267      262  67.4      215  0.065      47      -1.53           213     101.0
#> 268      249  66.4      266  0.056      57      -6.27           314      97.3
#> 269      242  68.4      158 -0.003     185      -4.48           278      99.9
#> 270      213  66.6      255  0.032     102      -3.37           253     100.4
#> 271      205  73.7        9 -0.021     228      -9.13           340      98.2
#> 272      291  67.1      229  0.077      33       0.98           181     104.3
#> 273      232  70.6       75  0.051      66      -4.68           285     100.6
#> 274      233  66.0      283 -0.036     257       4.37           131     106.4
#> 275      244  66.6      259  0.000     173     -99.00           348       0.0
#> 276      288  71.8       34 -0.018     224      -6.93           319      99.8
#> 277      144  68.4      161 -0.011     206      -6.24           313      98.8
#> 278      290  72.4       23 -0.093     333      -8.05           333      98.7
#> 279      218  70.6       69  0.072      39      -6.14           311      99.0
#> 280      329  69.5      109 -0.025     240      -3.72           264     102.2
#> 281      330  72.1       29 -0.046     276       1.08           177     103.7
#> 282      187  69.6      103 -0.050     285      -3.66           262      99.8
#> 283      268  70.6       73  0.078      32      -4.98           288      97.8
#> 284      277  66.1      277 -0.033     253      -4.75           286      99.8
#> 285      140  72.0       31 -0.042     272      -7.27           323      97.6
#> 286      255  68.9      137  0.000     173     -99.00           348       0.0
#> 287      173  66.5      263  0.014     143      -9.01           339      98.6
#> 288      221  68.2      175  0.050      68      -3.33           250     102.4
#> 289      296  68.1      178 -0.039     264       5.33           124     106.9
#> 290      308  71.5       44 -0.010     205      -0.67           198     104.0
#> 291      183  76.8        1  0.073      38      -2.62           236     101.4
#> 292      304  70.3       82 -0.090     328      -0.33           194     101.9
#> 293      241  67.6      204  0.050      70      -4.53           282     100.4
#> 294      196  67.7      195 -0.039     265       3.60           142     104.6
#> 295      263  68.2      171  0.024     121      -4.29           275      98.8
#> 296      239  67.1      231 -0.040     267      -3.63           258      99.7
#> 297      352  66.5      260  0.036      94      -1.84           219     100.7
#> 298      332  65.8      294 -0.022     230      -0.50           196     102.4
#> 299      345  70.6       68  0.017     138      -6.04           309      98.9
#> 300      275  70.7       65 -0.017     221       2.38           163     104.3
#> 301      347  72.5       22  0.030     106      -8.66           337      97.1
#> 302      278  68.1      182  0.106      14      -0.79           201     103.1
#> 303      323  67.3      224 -0.053     291      -0.61           197     104.7
#> 304      314  69.1      126 -0.047     277      -2.51           235     102.0
#> 305      228  68.2      173  0.036      93      -0.78           199     101.2
#> 306      207  69.2      117 -0.035     256       2.63           158     102.6
#> 307      254  67.5      210  0.009     151      -4.23           274      99.3
#> 308      216  70.6       71 -0.075     318     -12.47           345      93.4
#> 309      284  64.3      333  0.005     163      -5.31           295      96.9
#> 310      119  63.7      343  0.018     136       6.28           111     105.8
#> 311      298  68.9      138 -0.004     189      -3.67           263     100.9
#> 312      287  68.5      154 -0.066     307      -5.49           300      99.9
#> 313      316  68.8      142 -0.055     292       0.13           192     102.4
#> 314      337  69.5      110  0.102      15      -1.12           206     103.6
#> 315      202  67.1      233 -0.006     195      -7.27           324      96.6
#> 316      350  67.6      205 -0.041     269      -4.09           273      97.4
#> 317      327  70.8       62  0.077      34      -3.41           254     101.1
#> 318      264  69.8       94  0.036      95     -10.43           342      94.0
#> 319      344  63.9      339  0.038      89       1.69           169     103.4
#> 320      227  71.2       49 -0.103     341      -3.65           261     100.7
#> 321      334  71.0       55  0.054      63       9.28            88     106.9
#> 322      312  68.3      166 -0.032     252      -2.37           229     100.6
#> 323      279  68.2      172  0.008     155      -2.48           232     101.3
#> 324      348  66.2      272  0.130       6      -7.28           326      98.1
#> 325      340  65.9      290 -0.095     336      -4.07           272      98.4
#> 326      258  65.7      297 -0.057     295      -6.62           318      99.0
#> 327      322  70.4       80  0.118      10      -7.39           328      98.6
#> 328      274  73.1       15  0.070      42      -2.34           228     101.3
#> 329      253  66.8      248  0.015     141       2.76           156     103.0
#> 330      311  65.9      287  0.033     100      -6.13           310      96.5
#> 331      351  70.9       61 -0.018     223       1.85           167     102.8
#> 332      326  62.8      349  0.028     111       4.35           132     104.6
#> 333      338  71.8       38  0.006     161       5.92           117     104.0
#> 334      303  70.0       87  0.063      52      -5.82           306     101.0
#> 335      238  69.3      113 -0.088     327      -1.56           214     102.9
#> 336      325  68.6      150  0.043      83      -5.13           292     100.2
#> 337      328  65.4      312 -0.003     187       2.98           152     105.4
#> 338      341  70.9       60 -0.105     343      -2.88           244     101.5
#> 339      292  69.6      106 -0.049     284      -3.32           249     100.8
#> 340      353  68.5      156 -0.090     329      -9.21           341      97.6
#> 341      331  72.6       18 -0.003     186      -2.99           245     100.6
#> 342      317  69.5      111 -0.026     241      -8.11           334      96.1
#> 343      342  64.7      324 -0.049     281      -7.08           321      98.2
#> 344      300  69.6      105 -0.093     334      -3.59           256      99.1
#> 345      336  70.3       83  0.003     164      -6.27           315      99.0
#> 346      251  64.5      330  0.028     112      -0.78           200     100.9
#> 347      346  67.4      220  0.122       7      -2.64           237     101.2
#> 348      250  67.5      209  0.018     134     -11.82           343      93.6
#> 349      343  72.3       25  0.000     173     -99.00           348       0.0
#> 350      349  66.8      250 -0.021     227       0.42           190     102.9
#> 351      354  67.0      242 -0.086     326      -3.36           252      97.6
#> 352      355  73.3       12 -0.064     303      -3.65           260      98.9
#> 353      339  71.6       40 -0.109     346      -4.49           279      98.3
#> 354      319  70.8       63 -0.049     282     -14.36           347      91.6
#> 355      333  67.8      192  0.000     173     -99.00           348       0.0
#> 356      356  67.5      212 -0.006     198       9.06            92     106.6
#> 357      357  71.1       50  0.040      85      -3.93           267      97.7
#> 358        2  67.3      233  0.040      79      12.66             2     107.4
#> 359       43  71.9       35  0.050      50       2.42           109     103.5
#> 360        4  66.2      277  0.016     144      10.20            27     106.4
#> 361       38  67.6      220  0.002     180       2.74           105     104.1
#> 362       12  72.0       34 -0.009     209       7.28            54     106.0
#> 363       10  64.6      332 -0.008     204       2.98           101     105.3
#> 364       13  69.1      130 -0.012     217      12.04             7     108.6
#> 365       19  66.2      280 -0.038     280      11.10            16     108.0
#> 366       30  67.1      242 -0.003     193       7.10            58     105.3
#> 367        3  69.4      112 -0.028     260      11.28            15     107.2
#> 368       22  67.0      245  0.037      87      11.35            13     107.9
#> 369       78  68.3      178  0.072      23      10.72            21     107.9
#> 370       60  69.5      108 -0.028     259       6.06            74     106.0
#> 371       21  65.7      300 -0.052     308       6.33            68     104.2
#> 372       15  69.9       89  0.065      37       7.96            48     106.3
#> 373       28  68.7      150 -0.048     301      12.79             1     110.2
#> 374       76  65.0      319  0.023     120       8.15            42     105.6
#> 375       36  66.2      275  0.082      16      10.88            17     108.2
#> 376       14  69.3      115 -0.077     327       7.72            50     106.5
#> 377       25  69.8       93  0.006     169      11.48            12     108.4
#> 378        9  67.3      236 -0.113     346       8.74            37     106.0
#> 379       17  63.7      342  0.031     102      11.74            10     108.7
#> 380       97  70.2       77  0.005     172      12.28             4     108.6
#> 381       11  64.6      333 -0.104     342      12.19             6     108.4
#> 382       42  63.7      341  0.032     101      10.22            26     107.6
#> 383       23  70.9       54  0.014     149      10.72            22     108.1
#> 384       41  66.8      257 -0.130     351      12.38             3     108.6
#> 385        6  67.4      231 -0.042     286       9.88            31     107.4
#> 386       52  67.7      215  0.018     138       6.37            66     105.9
#> 387       35  66.0      288  0.022     123      10.38            25     107.7
#> 388       73  70.7       60 -0.046     293      10.78            20     107.6
#> 389       61  64.9      326 -0.047     296       8.82            36     107.8
#> 390       55  69.2      127  0.103       7       6.70            62     107.0
#> 391       26  67.9      206  0.016     143      10.71            23     108.3
#> 392       32  68.2      188 -0.010     213       7.42            52     105.5
#> 393       29  69.6       98  0.031     103      12.22             5     107.5
#> 394      179  70.0       84 -0.020     237       7.18            56     105.8
#> 395       96  63.9      339  0.055      46       4.46            88     105.4
#> 396        8  69.5      101  0.041      78       4.78            81     103.7
#> 397       27  68.4      171 -0.008     205       8.85            35     106.7
#> 398       48  67.4      229  0.034      94       3.09           100     105.0
#> 399        1  59.4      353  0.109       6       6.93            60     105.6
#> 400        7  68.3      183 -0.080     330       4.97            79     104.2
#> 401       51  68.0      199 -0.013     220       6.52            65     104.4
#> 402       20  68.1      191 -0.013     222       9.93            30     108.3
#> 403       54  69.3      124  0.044      69       1.86           115     104.2
#> 404       57  71.2       45 -0.047     298       6.53            64     106.7
#> 405      119  66.2      276 -0.001     187       6.27            70     106.0
#> 406      108  65.8      299  0.019     134       0.97           124     102.6
#> 407       79  69.5      103 -0.020     236       7.04            59     105.4
#> 408      116  68.3      179 -0.060     315       6.70            61     105.6
#> 409       59  68.5      167 -0.077     325       4.52            86     103.1
#> 410       46  68.4      173  0.034      96      11.31            14     107.1
#> 411       31  69.8       96 -0.157     353       7.60            51     105.4
#> 412       18  68.9      139  0.083      15       6.32            69     105.2
#> 413       65  66.1      281  0.067      33      -1.96           201     103.0
#> 414      100  68.1      190 -0.021     239       5.02            78     104.9
#> 415       67  67.4      227 -0.026     253       0.22           143     102.1
#> 416        5  72.6       28  0.025     116       4.81            80     104.5
#> 417      114  74.8        4 -0.076     324       7.83            49     106.9
#> 418       24  65.9      292  0.089      12      10.04            29     106.9
#> 419       44  67.6      219  0.026     111       1.83           116     103.1
#> 420       49  73.2       14  0.069      28       8.22            41     106.4
#> 421       16  70.0       88 -0.006     200       9.42            34     107.0
#> 422       39  71.2       46  0.068      32       4.64            83     105.0
#> 423       53  72.9       21 -0.037     278       8.27            40     106.3
#> 424      125  70.0       87 -0.049     302      10.86            18     108.1
#> 425       62  65.2      313 -0.020     235       8.11            45     106.2
#> 426       50  73.1       17 -0.023     247       6.10            72     105.4
#> 427      163  64.8      330 -0.094     339       3.66            93     103.1
#> 428       90  66.5      266 -0.023     246      -1.65           192     101.7
#> 429       33  66.0      290 -0.043     289       8.15            44     106.3
#> 430       45  69.0      134 -0.064     320       3.55            94     104.2
#> 431       88  68.7      155 -0.006     201       2.96           102     104.4
#> 432      122  65.0      320 -0.035     274      -2.29           213     101.1
#> 433       68  66.3      273 -0.027     257      -5.44           280      98.7
#> 434      146  62.9      350 -0.032     268       1.92           113     102.5
#> 435      112  64.9      325  0.047      59       7.16            57     105.5
#> 436       69  61.5      352  0.023     119      -9.00           345      98.3
#> 437       34  65.8      297  0.076      19       3.19            98     103.5
#> 438       85  68.2      187  0.041      75      -0.81           170     102.9
#> 439      103  69.4      110  0.022     124      -1.21           180     101.3
#> 440       81  69.1      133  0.025     115       4.28            89     105.0
#> 441       94  70.4       67 -0.050     304      10.39            24     107.9
#> 442      141  71.0       50 -0.007     203       2.68           106     104.3
#> 443       66  65.1      318 -0.005     199       9.71            32     105.6
#> 444      165  65.6      305 -0.002     191       5.06            77     104.6
#> 445      202  64.8      331  0.004     173       2.60           107     102.2
#> 446      147  69.9       90 -0.092     337      11.89             9     107.0
#> 447       40  67.2      239 -0.129     348      10.83            19     106.4
#> 448      113  63.5      343  0.060      42      -4.86           261      99.7
#> 449       58  67.8      210 -0.009     208      -1.77           196     102.2
#> 450       93  65.2      312 -0.050     303      -0.69           167     102.0
#> 451       56  70.6       63  0.022     126      10.11            28     108.1
#> 452      104  67.8      211  0.049      54       0.52           133     102.8
#> 453      136  70.5       64 -0.017     232       8.15            43     106.9
#> 454       71  66.5      267 -0.057     313       7.22            55     106.0
#> 455      133  67.0      247 -0.019     234       3.75            92     104.6
#> 456      172  69.3      116  0.045      66       2.91           104     104.4
#> 457       75  71.8       39  0.042      73      -8.13           338      98.6
#> 458       72  65.3      311  0.006     167      -0.19           150     102.4
#> 459       74  68.0      196 -0.042     285       6.58            63     106.1
#> 460      166  70.1       79 -0.034     271       8.52            38     106.0
#> 461      149  68.3      180  0.034      92       9.57            33     106.3
#> 462       82  65.5      309 -0.040     283       6.34            67     105.3
#> 463      109  67.7      212 -0.064     319      -2.29           212     101.1
#> 464      134  67.1      244  0.036      89      -0.51           161     101.6
#> 465      187  67.9      202  0.064      39      -4.37           248     101.1
#> 466      132  70.5       65  0.012     155      -7.08           324      99.0
#> 467      105  68.8      148  0.039      80      -0.95           175     102.0
#> 468       91  65.5      308  0.001     182       7.32            53     105.4
#> 469      148  66.0      287  0.032      99      -3.91           239     101.8
#> 470      196  68.3      176  0.023     122       0.85           126     102.3
#> 471      135  66.7      260  0.029     107       8.33            39     107.1
#> 472       47  70.3       73 -0.052     307       6.19            71     104.8
#> 473       37  68.0      200 -0.089     335      -2.22           208     101.1
#> 474       98  67.8      208  0.002     179       3.18            99     103.3
#> 475      182  68.5      168  0.020     132      -6.14           300     100.6
#> 476      241  68.0      201 -0.022     242      -4.79           259     100.7
#> 477      107  64.9      323  0.072      24      -1.29           182     101.9
#> 478      124  68.3      181 -0.083     333       0.84           127     103.0
#> 479      145  66.4      270  0.043      72       2.19           112     103.7
#> 480      174  65.7      301  0.052      49       1.24           123     102.6
#> 481      142  73.1       18  0.121       4      -1.53           190     102.0
#> 482       63  64.9      324 -0.047     297       4.52            85     103.4
#> 483      156  73.0       19 -0.035     273       0.56           132     102.7
#> 484       83  70.8       59 -0.002     192       4.53            84     103.6
#> 485      167  68.9      143 -0.011     214      -1.26           181     102.1
#> 486      184  69.3      125  0.069      29      -0.59           162     102.1
#> 487       95  67.7      214 -0.130     349       2.34           111     104.7
#> 488       77  64.5      334  0.098      10       6.10            73     105.8
#> 489      150  66.7      259 -0.087     334      11.64            11     107.5
#> 490      157  72.1       31  0.033      97      -6.80           315      99.7
#> 491      102  71.8       41  0.005     170      -0.35           157     102.9
#> 492      231  70.4       68 -0.103     341      -0.49           160     104.4
#> 493      110  68.9      144 -0.030     263      -7.75           329      99.1
#> 494      123  68.2      185  0.019     137      -1.01           176     102.1
#> 495      178  71.8       38  0.044      70       1.50           118     105.0
#> 496      217  70.8       57  0.034      95       3.22            97     104.3
#> 497      169  71.9       36 -0.044     292      -8.04           336      99.9
#> 498      137  70.2       76  0.025     117       0.42           134     102.6
#> 499      192  65.9      291 -0.113     345      -3.51           233     102.0
#> 500      106  74.9        3 -0.037     277      -0.16           149     102.8
#> 501      120  65.7      304  0.074      20      -5.16           270     100.0
#> 502      236  66.7      261 -0.001     189      -5.42           277      98.3
#> 503      181  69.3      123  0.020     128       1.39           120     103.0
#> 504      225  67.0      248  0.025     114      -1.70           194     101.6
#> 505      175  73.9        8  0.045      64      -0.62           164     102.4
#> 506      170  72.2       30  0.010     161      -0.82           171     101.6
#> 507      243  66.3      274 -0.025     251      -0.66           165     101.7
#> 508      154  71.6       42  0.049      52      -1.84           199     101.7
#> 509      237  68.1      193 -0.057     312      -1.36           186     101.4
#> 510      130  65.2      315  0.090      11       8.03            46     106.4
#> 511      197  65.9      293 -0.019     233      -1.03           178     102.3
#> 512      209  65.3      310  0.063      40      -1.01           177     102.0
#> 513      263  71.5       43  0.049      53      -0.93           174     102.2
#> 514      214  64.2      338 -0.117     347       2.92           103     105.2
#> 515      226  65.1      317  0.014     152      -2.19           207     102.5
#> 516      186  66.3      272  0.002     177      -4.98           264     100.6
#> 517      242  64.5      335  0.022     125      -4.63           253     100.0
#> 518       86  69.3      118 -0.063     317      -1.85           200     101.9
#> 519      152  73.1       16 -0.047     299      11.96             8     108.1
#> 520      155  67.9      204  0.065      36       0.39           135     102.9
#> 521       84  65.5      307  0.008     164      -1.31           183     102.0
#> 522      185  68.6      161  0.012     153       4.20            90     103.6
#> 523      324  69.4      111  0.034      93      -4.23           245      99.8
#> 524      195  68.0      195 -0.010     212      -0.67           166     102.2
#> 525      210  70.1       81  0.142       1      -0.24           151     102.3
#> 526      221  69.4      109 -0.061     316       5.97            75     105.9
#> 527      229  65.9      295 -0.004     196      -1.32           184     102.8
#> 528       92  66.4      268 -0.091     336       0.03           146     102.3
#> 529      275  67.8      209  0.032     100      -5.29           273     100.1
#> 530      306  71.8       40  0.000     183      -1.81           197     101.5
#> 531      153  67.0      246  0.056      44       0.32           138     102.4
#> 532      127  67.2      240  0.041      77       0.64           130     103.1
#> 533      290  68.9      138  0.037      86      -6.85           317      99.0
#> 534      307  70.0       85  0.011     159      -3.99           241     101.4
#> 535       99  64.2      337 -0.002     190       0.28           142     102.8
#> 536      128  69.3      120  0.065      38       8.02            47     106.0
#> 537      265  68.3      182  0.074      21      -4.18           243     101.4
#> 538      129  69.1      131  0.057      43       1.36           121     102.8
#> 539      138  64.8      329  0.044      68      -2.25           209     101.7
#> 540       87  63.9      340 -0.026     252      -2.36           214     101.7
#> 541      126  68.4      172 -0.023     245      -7.05           323      99.6
#> 542      191  68.7      154 -0.014     225       3.24            96     102.8
#> 543      272  64.3      336  0.026     112      -5.96           293     100.9
#> 544      171  71.1       49  0.036      90      -5.29           272      98.3
#> 545       89  67.5      224 -0.005     197      -0.61           163     101.7
#> 546      173  65.7      302  0.048      57      -2.46           216     100.1
#> 547      261  72.8       26 -0.033     270      -0.29           154     102.3
#> 548      151  68.8      146 -0.001     188      -1.38           188     101.4
#> 549      111  69.8       92  0.021     127      -4.66           255      99.2
#> 550      158  68.7      158  0.050      51      -6.25           303      99.9
#> 551       80  68.0      197  0.023     121      -5.99           296      99.1
#> 552      244  67.5      222  0.132       3      -3.09           226     102.2
#> 553       70  66.8      254  0.028     109       1.46           119     103.7
#> 554      316  68.8      147 -0.059     314       2.40           110     103.9
#> 555      188  68.1      192  0.014     148      -2.16           206     101.8
#> 556      301  70.1       80 -0.004     194      -0.91           173     101.7
#> 557      227  68.7      152  0.019     136      -7.26           326      99.3
#> 558      162  72.6       27  0.061      41      -5.21           271      98.7
#> 559      295  68.6      162  0.029     104      -7.75           328      98.5
#> 560      212  68.7      159 -0.033     269      -6.03           299     100.2
#> 561      115  69.5      105 -0.004     195      -4.74           257     100.1
#> 562      121  65.8      298 -0.081     331      -1.62           191     101.1
#> 563      284  67.3      237  0.042      74      -0.47           159     102.4
#> 564      205  66.1      282  0.027     110      -6.38           308      99.7
#> 565      140  68.4      170  0.029     106      -4.49           251     100.9
#> 566      211  63.0      349 -0.022     240       3.40            95     105.0
#> 567      293  72.8       24 -0.047     295       0.33           137     101.6
#> 568      118  63.2      347 -0.029     261      -4.74           258     100.5
#> 569      200  71.1       48 -0.028     258      -5.71           290     100.1
#> 570      131  70.7       61 -0.001     186      -7.97           333      96.3
#> 571      247  69.9       91 -0.051     306      -4.72           256     100.1
#> 572      269  66.6      265  0.071      25      -2.00           202     101.9
#> 573      264  73.6       11 -0.036     276       0.65           129     102.7
#> 574      213  70.6       62 -0.010     210       1.25           122     101.5
#> 575      270  66.2      279 -0.047     294      -5.61           288     101.1
#> 576      286  69.2      126  0.077      18      -0.24           152     104.0
#> 577      190  68.5      169 -0.005     198       1.91           114     103.6
#> 578      260  68.7      156 -0.077     326      -5.10           268      98.4
#> 579      159  67.3      234  0.056      45      -1.39           189     102.4
#> 580      319  74.0        7  0.045      67      -2.95           221     100.9
#> 581      143  69.4      113  0.120       5      -1.19           179     101.6
#> 582      311  68.0      194 -0.024     250      -2.55           218     100.7
#> 583      262  71.8       37  0.020     131      -0.38           158     102.6
#> 584      101  63.2      348  0.137       2      -5.75           291      99.7
#> 585      246  66.9      251  0.101       8      -5.07           267     101.0
#> 586      276  67.1      243 -0.022     243      -0.30           155     102.4
#> 587      117  70.2       78 -0.032     267       4.48            87     105.4
#> 588      287  68.9      145  0.038      83       0.35           136     104.2
#> 589      303  66.4      269  0.038      84      -5.48           283      99.9
#> 590      336  70.3       74  0.071      26      -0.70           168     102.5
#> 591      206  70.3       71 -0.055     310      -6.58           313      98.9
#> 592      199  64.9      327  0.048      56      -3.70           236     101.8
#> 593      180  69.6       99  0.003     176      -6.24           302     100.1
#> 594      251  67.4      228  0.043      71       0.31           140     102.4
#> 595      220  69.1      129 -0.050     305      -8.64           342      99.0
#> 596      233  66.1      285 -0.014     223      -3.24           231     101.4
#> 597      183  66.6      262 -0.072     322      -5.52           285      99.7
#> 598      253  66.6      264  0.020     133       0.31           139     101.8
#> 599      189  69.5      107  0.004     174      -3.13           228     101.7
#> 600      144  68.2      184  0.048      58      -6.45           310      99.2
#> 601      271  67.3      235  0.002     178      -2.50           217     101.8
#> 602       64  64.8      328 -0.100     340      -2.59           219     101.2
#> 603      139  66.7      258 -0.017     231       3.99            91     105.9
#> 604      292  68.7      153  0.053      48      -3.92           240      99.9
#> 605      168  68.6      163  0.011     157      -5.88           292      99.1
#> 606      256  70.4       66 -0.013     221      -3.20           229     101.5
#> 607      224  66.8      256  0.006     168      -8.34           340      96.6
#> 608      300  68.9      141  0.028     108      -6.46           311      98.0
#> 609      201  64.9      322 -0.056     311       0.58           131     103.1
#> 610      215  70.4       69 -0.092     338      -3.73           237     100.9
#> 611      164  67.5      225 -0.052     309      -9.57           349      97.0
#> 612      258  62.5      351  0.018     140      -5.44           281      99.7
#> 613      252  66.8      255  0.011     158      -4.23           247      99.7
#> 614      296  67.9      203 -0.143     352      -2.27           211     102.2
#> 615      249  70.0       86 -0.040     282      -4.41           249      99.1
#> 616      222  69.3      121  0.054      47      -6.32           307      99.5
#> 617      315  71.2       47  0.009     162       5.48            76     105.0
#> 618      204  67.9      205 -0.006     202      -2.76           220     103.7
#> 619      239  65.6      306 -0.047     300      -8.04           335      99.6
#> 620      218  69.3      114  0.010     160      -1.83           198     101.5
#> 621      281  69.5      106  0.046      60      -6.82           316      99.9
#> 622      327  68.0      198  0.020     130      -5.37           274      99.1
#> 623      228  64.9      321 -0.063     318      -3.58           234     101.9
#> 624      259  72.8       23  0.017     141      -6.28           305     100.1
#> 625      309  71.0       52  0.018     139      -6.87           318      99.9
#> 626      160  65.8      296 -0.011     215      -5.62           289      98.6
#> 627      278  72.4       29  0.015     147      -7.15           325     100.0
#> 628      232  69.5      102 -0.015     227      -5.12           269     100.6
#> 629      193  66.6      263  0.065      35      -8.95           344      97.3
#> 630      291  67.6      216  0.015     145       0.04           145     102.3
#> 631      317  65.2      314 -0.105     343      -0.05           148     101.7
#> 632      337  70.3       72 -0.036     275      -6.19           301      97.8
#> 633      330  69.0      137 -0.039     281      -6.68           314      99.2
#> 634      313  66.2      278 -0.013     219      -2.08           204     102.2
#> 635      304  72.9       22  0.086      13      -5.49           284      97.6
#> 636      207  67.2      238 -0.010     211       2.47           108     104.7
#> 637      230  74.5        6  0.070      27      -5.40           276      99.9
#> 638      176  68.7      157 -0.012     218      -7.80           330      97.1
#> 639      208  68.5      166  0.011     156      -5.60           287      99.1
#> 640      285  73.2       15 -0.021     238      -2.02           203     101.9
#> 641      248  70.1       83 -0.011     216      -5.38           275      99.5
#> 642      245  68.1      189 -0.078     328      -8.00           334      98.9
#> 643      216  69.3      122 -0.015     226       1.74           117     103.7
#> 644      177  73.7        9  0.068      30      -8.66           343      97.1
#> 645      299  63.2      344  0.083      14      -5.43           279      99.4
#> 646      331  68.9      142 -0.027     255      -4.93           263      99.4
#> 647      289  73.3       13  0.009     163       4.69            82     106.0
#> 648      321  67.4      230  0.008     165      -0.26           153     102.4
#> 649      254  73.0       20  0.012     154      -9.66           350      96.1
#> 650      268  69.3      119 -0.027     256      -0.83           172     102.3
#> 651      280  67.6      217  0.015     146       0.30           141     103.0
#> 652      298  69.8       95  0.003     175       0.97           125     102.7
#> 653      255  66.9      249 -0.079     329      -4.00           242     100.5
#> 654      238  70.9       55  0.080      17       0.81           128     102.8
#> 655      283  63.2      345 -0.074     323      -6.02           298      99.8
#> 656      267  69.1      132 -0.130     350      -0.80           169     101.6
#> 657      325  66.0      289  0.068      31      -2.97           222      99.4
#> 658      161  63.2      346  0.045      65      -4.52           252      99.6
#> 659      318  71.0       51  0.017     142      -9.29           347      99.5
#> 660      257  65.7      303  0.029     105      -6.58           312      99.6
#> 661      305  68.4      174  0.046      62      -2.26           210     102.2
#> 662      274  70.9       53 -0.044     291      -1.67           193     103.2
#> 663      326  69.3      117 -0.031     265      -2.12           205     101.7
#> 664      266  70.3       70  0.024     118      -7.00           322      98.8
#> 665      345  70.9       56  0.041      76      -5.58           286      99.8
#> 666      235  68.7      151  0.046      61      -9.04           346      96.6
#> 667      194  66.1      286 -0.032     266      -3.89           238     100.2
#> 668      323  72.1       32 -0.016     230      -3.35           232     100.8
#> 669      219  68.5      165  0.019     135      -1.37           187     103.2
#> 670      250  67.1      241  0.048      55      -2.37           215     101.8
#> 671      279  68.6      160  0.100       9      -6.28           304      97.9
#> 672      302  68.3      175 -0.038     279      -0.34           156     103.0
#> 673      294  67.3      232 -0.001     184      -7.49           327      98.6
#> 674      203  65.2      316 -0.105     344      -6.90           319      97.8
#> 675      308  66.9      250  0.033      98      -7.88           331      99.6
#> 676      234  67.8      207 -0.001     185      -9.51           348      98.4
#> 677      273  65.9      294 -0.030     264      -3.08           225      99.6
#> 678      332  72.8       25  0.008     166       0.07           144     103.5
#> 679      282  69.6      100  0.039      81     -10.67           353      96.2
#> 680      277  68.9      140 -0.023     244      -1.35           185     102.2
#> 681      322  70.1       82  0.037      85      -8.46           341      95.1
#> 682      320  69.2      128  0.036      88      -6.31           306     100.4
#> 683      342  69.8       94 -0.044     290      -4.21           244     100.6
#> 684      240  73.4       12  0.038      82      -7.96           332      97.5
#> 685      344  70.8       58 -0.068     321      -3.07           224     100.5
#> 686      339  67.5      223 -0.024     249      -5.43           278      98.9
#> 687      343  71.3       44 -0.082     332      -3.06           223     102.5
#> 688      310  66.9      252  0.025     113      -5.01           265     100.6
#> 689      198  69.7       97 -0.022     241      -5.47           282      98.7
#> 690      346  68.6      164  0.073      22      -4.46           250      99.6
#> 691      328  73.7       10  0.020     129       0.01           147     103.2
#> 692      341  66.9      253  0.005     171      -6.95           321      99.5
#> 693      312  72.1       33 -0.008     206      -4.86           262     100.3
#> 694      314  69.0      136 -0.034     272      -5.97           294     100.5
#> 695      353  68.7      149  0.045      63      -4.80           260     100.1
#> 696      335  67.4      226  0.014     151     -10.23           351      95.9
#> 697      334  67.6      218 -0.016     229      -5.99           295      99.7
#> 698      338  66.4      271  0.035      91      -5.06           266     101.0
#> 699      352  76.1        2  0.002     181      -3.12           227     101.0
#> 700      297  67.7      213  0.014     150      -8.13           337      96.3
#> 701      348  68.3      177 -0.042     288      -3.21           230     100.7
#> 702      333  66.1      283  0.066      34      -6.92           320      99.3
#> 703      347  74.7        5 -0.042     284     -10.56           352      95.0
#> 704      340  69.5      104 -0.014     224      -4.23           246     100.1
#> 705      223  66.1      284 -0.008     207      -4.63           254      98.7
#> 706      288  67.5      221 -0.024     248      -6.40           309      97.6
#> 707      350  70.2       75 -0.015     228      -8.29           339      96.7
#> 708      349  77.1        1 -0.027     254      -6.01           297      97.8
#> 709      329  68.2      186 -0.042     287      -1.74           195     102.0
#> 710      351  69.0      135 -0.029     262      -3.64           235     100.6
#>     sos_opp_o_rk sos_opp_d sos_opp_d_rk ncsos_adj_em ncsos_adj_em_rk ncaa_seed
#> 1             70      96.8           74         6.21             112         1
#> 2             64      95.5           44        -2.83             258         1
#> 3              9      95.3           39         2.51             178         1
#> 4              5      94.1           13        10.44              59         1
#> 5            105      96.5           67         2.11             187         2
#> 6             19      94.8           28         6.28             111         6
#> 7             31      94.0            9        -4.90             285         2
#> 8             32      94.9           31         3.82             157         5
#> 9             35      95.3           41         9.45              71         2
#> 10           110      99.4          123         4.81             139         8
#> 11            10      93.7            5         3.47             164         2
#> 12            51      95.7           50         8.12              89         5
#> 13            14      93.9            6         9.87              66        11
#> 14             7      93.9            8         1.24             199         9
#> 15            46      96.0           60         4.42             145         4
#> 16            26      95.4           43         3.72             160         7
#> 17            67      95.7           51        -4.88             283         6
#> 18            49      96.7           73        -4.09             272         3
#> 19            40      97.8           96         0.24             211         4
#> 20            57      96.8           76        10.05              65         6
#> 21            69      95.2           33        -1.27             240         7
#> 22            63      95.6           49        -0.73             230         5
#> 23            45      94.4           20        13.77              29         3
#> 24            66      93.9            7         1.13             202         8
#> 25            16      94.6           22         5.71             122         4
#> 26            54      94.7           23         8.20              85         3
#> 27            25      94.8           29        10.43              60         3
#> 28            60      95.8           53        -0.34             221         5
#> 29            52      95.9           56        -4.01             271        NA
#> 30            97      99.2          117        13.66              31         6
#> 31           101      97.2           82         1.45             198         1
#> 32            92      98.0          103         2.44             180         9
#> 33            18      95.6           47         5.81             121         4
#> 34            21      96.1           62         8.20              87         8
#> 35            34      93.1            2        -1.11             236        10
#> 36            58      96.8           77         5.59             127        NA
#> 37            65      96.0           58        -0.96             233         9
#> 38             3      94.4           19        -5.69             294        10
#> 39            47      95.2           34         1.93             192         8
#> 40             6      92.8            1        11.55              47        NA
#> 41            36      95.2           35         8.88              76         7
#> 42            48      96.5           66         2.09             188        11
#> 43            15      94.5           21        -4.52             278        12
#> 44            29      94.8           27        -5.46             290        NA
#> 45            43      95.3           38        11.60              46         7
#> 46           118      99.7          130         8.20              86        11
#> 47            33      94.4           17        11.39              50         9
#> 48            93      98.0           99         5.66             124        10
#> 49            22      94.0           10        15.29              23        NA
#> 50            13      93.1            3         9.18              72        NA
#> 51            75      97.2           81        -6.82             302         1
#> 52            72      98.2          106         0.63             207        10
#> 53           133      99.1          116        -1.43             244         1
#> 54            41      95.3           40        11.86              44        NA
#> 55           155     100.1          137        -8.21             309        11
#> 56           127      96.2           64        -8.32             310         3
#> 57            17      94.7           25         9.76              67        NA
#> 58           187     101.0          145         4.03             151        12
#> 59            39      96.6           69         7.71              95        NA
#> 60            53      94.7           24         6.37             109        NA
#> 61           114      99.3          121        15.51              20         2
#> 62            12      94.4           18         0.16             214        NA
#> 63            27      95.6           48         4.64             142        12
#> 64             2      94.8           26        -1.03             234        11
#> 65            83      97.9           98        10.89              54         2
#> 66            74      97.6           92         2.03             190        NA
#> 67            81      95.2           36        -1.44             245         4
#> 68            96      96.0           57        13.71              30        11
#> 69            79      96.6           68        -2.94             259        NA
#> 70           137      97.8           95         1.16             201         2
#> 71            56      98.2          105        -6.18             299         3
#> 72           126      98.6          111         6.16             113        13
#> 73           190     106.0          336         5.39             130        NA
#> 74           130     101.7          172         5.90             118         3
#> 75            62      98.0          100         2.91             168         2
#> 76           149      98.9          114         2.76             172         1
#> 77           111     102.3          192         2.40             182         4
#> 78            61      96.8           75        -8.58             312        NA
#> 79             1      93.7            4       -18.34             328        NA
#> 80            50      95.9           54         7.01             103        NA
#> 81            99     100.9          142         1.20             200        13
#> 82           175     100.2          138        -8.57             311         4
#> 83            42      95.6           46         7.66              96        NA
#> 84           287     104.8          300         4.93             137        14
#> 85            24      96.4           65        13.83              28        NA
#> 86            20      94.9           30         9.16              73        NA
#> 87           123      96.7           72         4.29             148         4
#> 88           162     100.1          136       -12.01             320        NA
#> 89           282     105.4          316       -99.00             331        14
#> 90            84      97.6           90         9.71              68        NA
#> 91           132      98.5          108         7.37              98        NA
#> 92           184     101.4          157         0.58             209        NA
#> 93            89      98.5          110         5.87             120        NA
#> 94           108      97.2           84         6.76             105        NA
#> 95            76      95.5           45        -6.05             297        NA
#> 96           151     101.8          173         2.70             173        NA
#> 97            68      97.7           94        -4.78             281        NA
#> 98           283     104.3          272         1.58             195        13
#> 99           166      99.3          120        10.37              61         3
#> 100           85      94.3           16        24.70               1        NA
#> 101          281     105.2          311         4.18             149        12
#> 102          265     101.7          168       -12.09             321        NA
#> 103          211     103.5          238         2.54             177        15
#> 104           73      95.2           37        -3.13             260        NA
#> 105          212     102.4          195        21.28               5        14
#> 106          192     101.8          174         0.78             204        NA
#> 107          167     100.5          141         6.68             107        NA
#> 108          163     102.3          190        -2.78             257        13
#> 109            4      94.1           12         5.60             126        NA
#> 110          298     104.8          299        -5.87             296        NA
#> 111           90      97.2           85        11.37              51        NA
#> 112          104     101.5          159        20.90               7        NA
#> 113          165     102.2          184         8.01              92        NA
#> 114           23      95.1           32         3.18             166        NA
#> 115           94     102.6          202         8.03              90        NA
#> 116           82      96.2           63         9.57              70        NA
#> 117           80      97.6           89         5.11             134        NA
#> 118          180      99.3          122         0.22             212        NA
#> 119          107      99.2          118         8.52              83        NA
#> 120           38      95.4           42        -0.56             227        NA
#> 121          109      96.7           70        -3.27             261        NA
#> 122          240     104.0          264         6.57             108        NA
#> 123          348     200.0          348       -99.00             331        NA
#> 124           44      94.2           14         9.09              74        NA
#> 125          120     101.1          149        22.06               4        15
#> 126          124      98.4          107         2.39             183        NA
#> 127          125     101.6          165         6.31             110        NA
#> 128          128     101.0          147         4.67             140        NA
#> 129            8      94.0           11        11.85              45        NA
#> 130          113     102.0          178         1.52             197        NA
#> 131          156     102.0          179         1.56             196        NA
#> 132          188     101.2          153         3.80             159        NA
#> 133          337     104.3          274       -99.00             331        NA
#> 134          209     103.2          228        16.21              16        14
#> 135          243     104.5          282        -0.64             228        NA
#> 136          160      98.8          113        20.55               8        NA
#> 137           86      97.9           97        -5.63             293        NA
#> 138           55      97.3           86        -7.27             304        NA
#> 139          148     103.1          222        10.84              55        NA
#> 140           77      96.0           59         0.60             208        NA
#> 141           59      95.7           52        -8.60             313        NA
#> 142          144     101.2          154        -4.89             284        NA
#> 143          102      97.0           79       -13.51             324        NA
#> 144          145      97.1           80       -14.54             325        NA
#> 145          143      98.7          112         0.73             205        NA
#> 146          112      99.7          129         6.06             114        NA
#> 147           37      95.9           55        -1.47             247        NA
#> 148           28      96.7           71        12.89              38        NA
#> 149          100     101.6          162         3.81             158        NA
#> 150          252     103.0          218        -3.53             267        NA
#> 151          319     105.7          325        -2.05             250        NA
#> 152          185     100.1          135         5.55             128        NA
#> 153          140     101.7          169         5.01             136        NA
#> 154          230     103.0          219         4.62             144        NA
#> 155          135      98.5          109        -6.89             303        NA
#> 156          174     102.6          208        -3.51             266        NA
#> 157          129     101.9          175        -0.46             222        NA
#> 158          229     103.5          241        -5.75             295        16
#> 159          173     103.1          226        10.69              57        NA
#> 160          191      99.5          127         5.87             119        NA
#> 161          169     105.5          322         8.53              82        NA
#> 162          235     103.8          255         4.66             141        NA
#> 163          121      98.0          101        14.82              25        NA
#> 164          197     101.1          151       -11.70             318        NA
#> 165          348     200.0          348       -99.00             331        NA
#> 166          316     103.5          240         7.37              99        NA
#> 167          266     104.0          263         7.14             102        NA
#> 168          119     102.2          183        15.12              24        NA
#> 169          122     106.0          335        20.35               9        15
#> 170           98      96.1           61         2.23             185        NA
#> 171           11      94.3           15         4.15             150        NA
#> 172          301     103.4          235        -3.40             264        NA
#> 173          280     104.7          295        -3.47             265        NA
#> 174          272     105.2          309        -7.97             307        NA
#> 175           30      96.9           78       -17.91             327        NA
#> 176          150      99.0          115        13.13              33        NA
#> 177          236     103.0          220        -0.26             220        NA
#> 178          312     103.9          260        -0.54             225        15
#> 179          274     104.8          301       -13.04             322        NA
#> 180          255     103.1          223        15.53              19        NA
#> 181          232     102.7          209        -0.22             218        NA
#> 182          260     104.2          268        12.76              41        NA
#> 183          305     104.6          289        -7.87             306        NA
#> 184          348     200.0          348       -99.00             331        NA
#> 185          314     105.9          328         4.63             143        NA
#> 186          332     104.0          262       -99.00             331        NA
#> 187          220     101.1          150       -99.00             331        NA
#> 188          207      99.7          131       -11.86             319        NA
#> 189          136     102.1          181        19.82              10        NA
#> 190          223     102.9          216         5.15             133        NA
#> 191          142      99.9          132       -99.00             331        NA
#> 192          147      99.7          128        -4.30             274        NA
#> 193          106      99.4          124         5.09             135        NA
#> 194          289     104.3          275        -0.17             217        16
#> 195           71      97.3           87         9.58              69        NA
#> 196          304     105.6          323         8.56              80        NA
#> 197          172     104.5          286         2.78             171        NA
#> 198          116     100.1          134         1.99             191        NA
#> 199          176     102.6          207        12.48              43        NA
#> 200          134      97.6           93         5.97             116        NA
#> 201          257     104.1          267        -1.65             248        NA
#> 202           78      97.2           83        15.47              21        NA
#> 203          141     103.2          229        11.29              52        NA
#> 204          170      99.5          125        -4.40             276        NA
#> 205          206     103.7          249        -4.32             275        NA
#> 206          205     105.0          306         3.87             154        NA
#> 207          196     103.6          243         5.66             123        NA
#> 208          341     103.2          230        14.62              27        16
#> 209          222     102.7          210        -0.67             229        NA
#> 210          318     105.2          310        -0.76             231        16
#> 211          292     104.3          271        -1.81             249        NA
#> 212          254     103.3          231         5.52             129        16
#> 213          189     103.9          259        -1.33             242        NA
#> 214          218     106.3          339       -99.00             331        NA
#> 215          307     103.9          258        -1.46             246        NA
#> 216          216     104.1          265         0.69             206        NA
#> 217          290     102.3          189        -1.13             238        NA
#> 218          154     101.6          167       -10.53             317        NA
#> 219          348     200.0          348       -99.00             331        NA
#> 220          348     200.0          348       -99.00             331        NA
#> 221          115     103.1          227        19.69              12        NA
#> 222          311     104.6          294         3.94             153        NA
#> 223          340     104.3          273         0.09             215        NA
#> 224          320     106.4          340        19.76              11        NA
#> 225          219     105.9          330        -2.15             252        NA
#> 226          330     103.1          224        -3.73             268        NA
#> 227          269      99.2          119        -6.36             300        NA
#> 228          245     102.9          215        14.75              26        NA
#> 229          278     104.2          269        -8.93             314        NA
#> 230          259     102.1          182        12.68              42        NA
#> 231          159      98.0          102         6.01             115        NA
#> 232          225     103.6          245         2.49             179        NA
#> 233          221     103.8          252         8.03              91        NA
#> 234          194     101.5          160        -4.60             280        NA
#> 235          346     107.2          345         7.32             100        NA
#> 236          262     103.3          232         2.20             186        NA
#> 237          285     105.9          329        11.14              53        16
#> 238          263     103.8          254         3.14             167        NA
#> 239          275     102.6          203         3.86             155        NA
#> 240          297     103.4          236        -3.88             270        NA
#> 241          146     102.5          197        -3.78             269        NA
#> 242          199     101.7          171         4.92             138        NA
#> 243          267     104.6          291         8.22              84        NA
#> 244          286     104.9          303        -4.57             279        NA
#> 245          234     103.6          242        10.17              63        NA
#> 246          214     106.0          337        -9.99             315        NA
#> 247          253     104.5          285         1.92             193        NA
#> 248          264     104.7          297        -2.07             251        NA
#> 249          348     200.0          348       -99.00             331        NA
#> 250          335     102.2          185        10.14              64        NA
#> 251          339     101.6          161       -99.00             331        NA
#> 252          284     103.0          221         8.54              81        NA
#> 253          276     102.5          196        12.89              37        NA
#> 254          178     102.5          199         4.37             147        NA
#> 255          203     102.3          191        -1.35             243        NA
#> 256          208     101.0          146        -5.63             292        NA
#> 257          177     104.3          278        13.51              32        NA
#> 258          237     103.6          244         5.63             125        NA
#> 259          202     101.3          155         3.97             152        NA
#> 260          195     104.6          293       -99.00             331        NA
#> 261          213     101.2          152        11.46              49        NA
#> 262          333     105.4          318       -99.00             331        NA
#> 263          210     104.5          288       -15.79             326        NA
#> 264          157     101.3          156        -3.32             262        NA
#> 265          343     106.2          338        13.02              36        NA
#> 266          328     104.5          287       -13.45             323        NA
#> 267          239     102.5          200       -99.00             331        NA
#> 268          327     103.6          246        -4.42             277        NA
#> 269          270     104.3          277        -0.50             224        NA
#> 270          258     103.7          250        -1.33             241        NA
#> 271          313     107.4          346       -99.00             331        NA
#> 272          152     103.3          233         5.95             117        NA
#> 273          251     105.3          313         2.80             170        NA
#> 274           95     102.1          180         5.17             132        NA
#> 275          348     200.0          348       -99.00             331        NA
#> 276          273     106.7          341       -99.00             331        NA
#> 277          302     105.0          307        13.05              35        NA
#> 278          303     106.8          342         2.41             181        NA
#> 279          295     105.1          308        -5.02             286        NA
#> 280          204     105.9          333       -19.28             329        NA
#> 281          164     102.6          205        -6.06             298        NA
#> 282          277     103.4          237        -1.17             239        NA
#> 283          321     102.8          212         2.87             169        NA
#> 284          271     104.6          292         0.18             213        NA
#> 285          324     104.9          302        -5.16             287        NA
#> 286          348     200.0          348       -99.00             331        NA
#> 287          308     107.6          347       -99.00             331        NA
#> 288          198     105.8          327        -1.09             235        NA
#> 289           87     101.6          164        18.07              13        NA
#> 290          158     104.7          298        -0.24             219        NA
#> 291          226     104.0          261         7.19             101        NA
#> 292          217     102.2          187        -7.66             305        NA
#> 293          256     104.9          305        -4.87             282        NA
#> 294          139     101.0          148        -4.14             273        NA
#> 295          300     103.1          225        -0.50             223        NA
#> 296          279     103.3          234        -2.77             256        NA
#> 297          247     102.5          201         4.38             146        NA
#> 298          201     102.9          214         8.63              78        NA
#> 299          299     104.9          304         3.84             156        NA
#> 300          153     101.9          176        10.20              62        NA
#> 301          329     105.7          326        -6.68             301        NA
#> 302          179     103.8          257         0.32             210        NA
#> 303          131     105.3          315         8.17              88        NA
#> 304          215     104.5          283       -99.00             331        NA
#> 305          231     102.0          177         3.59             162        NA
#> 306          193      99.9          133         0.99             203        NA
#> 307          288     103.5          239         2.64             176        NA
#> 308          345     105.9          331        17.22              14        NA
#> 309          331     102.2          186        -0.56             226        NA
#> 310          103      99.5          126       -99.00             331        NA
#> 311          242     104.6          290         2.66             175        NA
#> 312          268     105.4          320        13.07              34        NA
#> 313          200     102.2          188        10.77              56        NA
#> 314          168     104.7          296        -1.12             237        NA
#> 315          334     103.8          256       -19.54             330        NA
#> 316          326     101.4          158        10.52              58        NA
#> 317          238     104.5          284        15.36              22        NA
#> 318          342     104.4          281         8.61              79        NA
#> 319          171     101.7          170        12.79              40        NA
#> 320          248     104.3          276        -2.67             255        NA
#> 321           88      97.6           91         3.26             165        NA
#> 322          250     103.0          217         7.84              93        NA
#> 323          228     103.8          251         3.48             163        NA
#> 324          317     105.4          319        22.79               2        NA
#> 325          309     102.4          194        -8.19             308        NA
#> 326          293     105.6          324       -10.52             316        NA
#> 327          306     106.0          334        -3.36             263        NA
#> 328          227     103.7          248        -2.47             254        NA
#> 329          181     100.2          139        -0.10             216        NA
#> 330          336     102.6          206        12.85              39        NA
#> 331          186     101.0          144        21.14               6        NA
#> 332          138     100.3          140        -2.18             253        NA
#> 333          161      98.1          104         2.69             174        NA
#> 334          241     106.8          343       -99.00             331        NA
#> 335          183     104.4          280         8.80              77        NA
#> 336          261     105.4          317         5.34             131        NA
#> 337          117     102.4          193        -5.23             288        NA
#> 338          224     104.4          279        -5.27             289        NA
#> 339          246     104.1          266         1.74             194        NA
#> 340          323     106.8          344         6.78             104        NA
#> 341          249     103.6          247        11.53              48        NA
#> 342          338     104.2          270        22.33               3        NA
#> 343          315     105.3          314         7.53              97        NA
#> 344          291     102.7          211         3.71             161        NA
#> 345          294     105.2          312         7.82              94        NA
#> 346          244     101.6          166         6.69             106        NA
#> 347          233     103.8          253        -0.86             232        NA
#> 348          344     105.4          321        -5.52             291        NA
#> 349          348     200.0          348       -99.00             331        NA
#> 350          182     102.5          198        15.56              18        NA
#> 351          325     100.9          143        15.77              17        NA
#> 352          296     102.6          204         2.33             184        NA
#> 353          310     102.8          213         2.06             189        NA
#> 354          347     105.9          332       -99.00             331        NA
#> 355          348     200.0          348       -99.00             331        NA
#> 356           91      97.6           88         9.06              75        NA
#> 357          322     101.6          163        16.42              15        NA
#> 358           26      94.7            1         9.58              10         1
#> 359          115     101.0           99        -2.09             245         1
#> 360           39      96.2           11         1.38             132         1
#> 361          103     101.3          105        -0.74             203         1
#> 362           53      98.7           58         2.60              85         3
#> 363           76     102.3          136        -1.80             239         2
#> 364            5      96.5           14         1.83             109         3
#> 365           15      96.9           20        -1.31             225         5
#> 366           75      98.2           48        -1.09             216         4
#> 367           27      95.9            8         5.80              32         6
#> 368           16      96.6           15        -0.44             192         3
#> 369           18      97.2           22         2.69              81         2
#> 370           49     100.0           86         7.40              20         5
#> 371           99      97.9           38         2.56              88         7
#> 372           44      98.4           53         1.22             140         2
#> 373            1      97.4           27         2.00             105         6
#> 374           62      97.4           30         4.11              54         4
#> 375           10      97.3           25         4.22              51         2
#> 376           38      98.8           62         2.41              92         7
#> 377            7      96.9           19         4.86              41         3
#> 378           51      97.3           24        -3.87             296        10
#> 379            2      96.9           21         1.61             120         4
#> 380            3      96.3           13         2.40              93         6
#> 381            6      96.3           12         2.78              77        NA
#> 382           22      97.4           28         1.07             144         5
#> 383           11      97.4           29        -4.20             304         6
#> 384            4      96.2           10         2.88              76        NA
#> 385           25      97.5           32        -4.44             309         9
#> 386           57      99.6           78        -0.87             207         4
#> 387           20      97.3           26        -5.83             333         7
#> 388           21      96.9           18         2.13             100         9
#> 389           19      98.9           67         6.92              23         9
#> 390           32     100.3           90         1.38             133         5
#> 391            8      97.6           35        -0.60             198        10
#> 392           66      98.0           43         2.77              78         8
#> 393           24      95.3            3         5.86              30        10
#> 394           61      98.6           55         2.01             103         8
#> 395           70     100.9           97        -0.32             188         8
#> 396          109      98.9           66        -1.25             223        11
#> 397           37      97.8           37        -1.12             217         8
#> 398           81     101.9          122         1.55             124        11
#> 399           63      98.7           57        -3.70             292         7
#> 400          101      99.2           71        -4.02             301        NA
#> 401           94      97.9           39         3.60              64        12
#> 402            9      98.4           52         1.74             112        NA
#> 403           98     102.4          142        -0.95             211        11
#> 404           36     100.2           88         1.28             136        NA
#> 405           50      99.7           83         0.07             178        NA
#> 406          146     101.6          114         1.26             138        NA
#> 407           73      98.3           50        -2.93             271        11
#> 408           65      98.9           64        -1.28             224        NA
#> 409          124      98.6           54        -1.69             233        NA
#> 410           28      95.8            5         4.17              53        NA
#> 411           72      97.8           36         1.03             148        NA
#> 412           78      98.8           63        -1.48             229         9
#> 413          129     105.0          273        -0.64             199        11
#> 414           85      99.9           84        -8.69             348        NA
#> 415          179     101.9          120         3.64              63        12
#> 416           91      99.7           81        -2.18             247        NA
#> 417           33      99.1           69         3.96              59        NA
#> 418           35      96.8           17        -0.30             187        NA
#> 419          125     101.2          101        -1.72             236        NA
#> 420           41      98.1           47         2.65              82        10
#> 421           31      97.6           34         4.04              58        NA
#> 422           79     100.4           92         4.07              57        NA
#> 423           46      98.0           42        -5.52             328        NA
#> 424           14      97.2           23         1.50             126        NA
#> 425           47      98.1           45         2.75              79        NA
#> 426           68      99.3           72        -0.56             196        NA
#> 427          122      99.5           74         2.91              74        NA
#> 428          206     103.3          187        -4.54             312        NA
#> 429           45      98.1           46        -1.70             235        NA
#> 430          102     100.6           94        -1.01             213        NA
#> 431           92     101.5          110        -1.43             226        NA
#> 432          229     103.4          193         1.74             113        NA
#> 433          319     104.2          234         1.80             110        13
#> 434          152     100.6           93         6.11              28        13
#> 435           67      98.3           49        -0.73             202        11
#> 436          331     107.3          347        -5.13             322        12
#> 437          116     100.3           89        -4.68             315        NA
#> 438          132     103.8          207         1.74             114        NA
#> 439          224     102.5          151        -1.88             242        13
#> 440           82     100.7           95         1.32             135        NA
#> 441           17      97.5           33         7.39              21        NA
#> 442           97     101.6          115         2.00             104        NA
#> 443           64      95.9            6        -1.05             214        NA
#> 444           90      99.5           76        -5.88             334        NA
#> 445          169      99.6           80        -4.81             317        NA
#> 446           30      95.2            2         2.61              84        NA
#> 447           40      95.5            4         1.48             127        NA
#> 448          284     104.6          254         1.26             139        13
#> 449          168     104.0          224        -1.46             228        NA
#> 450          184     102.7          162         0.28             173        NA
#> 451           12      98.0           41        -2.38             252        NA
#> 452          138     102.3          137        -5.04             320        NA
#> 453           34      98.7           59         1.66             117        NA
#> 454           52      98.8           61         0.12             175        NA
#> 455           89     100.9           96         1.02             150        NA
#> 456           93     101.5          112         1.71             115        NA
#> 457          325     106.7          337         0.55             162        12
#> 458          153     102.6          155        -3.32             281        NA
#> 459           48      99.5           77        -3.68             291        NA
#> 460           55      97.4           31         0.91             153        NA
#> 461           43      96.8           16         1.07             145        NA
#> 462           74      99.0           68        -9.83             351        NA
#> 463          230     103.4          192         2.91              75        14
#> 464          209     102.2          129        -4.10             303        14
#> 465          228     105.5          295        -4.39             308        14
#> 466          314     106.0          315        -2.73             262        14
#> 467          186     102.9          168         0.30             168        NA
#> 468           71      98.1           44        -4.01             300        NA
#> 469          193     105.7          308        -1.84             240        15
#> 470          161     101.4          106         1.02             149        NA
#> 471           29      98.8           60         2.26              98        NA
#> 472           86      98.6           56         2.93              73        NA
#> 473          226     103.4          190        -4.52             311        NA
#> 474          118     100.1           87        -3.56             286        NA
#> 475          246     106.7          341        -0.89             209        NA
#> 476          242     105.5          291        -3.54             285        NA
#> 477          190     103.2          179        -7.90             346        NA
#> 478          127     102.2          132        -1.22             222        NA
#> 479          110     101.5          108         2.74              80        NA
#> 480          147     101.3          104        -0.71             200        NA
#> 481          185     103.5          197         3.14              71        15
#> 482          117      98.9           65        -2.74             263        NA
#> 483          142     102.2          130         4.84              42        NA
#> 484          112      99.1           70        -8.19             347        NA
#> 485          178     103.4          191        -3.61             289        NA
#> 486          180     102.7          156         1.35             134        15
#> 487           87     102.4          141        11.60               8        NA
#> 488           60      99.7           82        -3.20             278        NA
#> 489           23      95.9            7        -2.56             258        NA
#> 490          286     106.5          332        -5.49             327        NA
#> 491          133     103.3          181         1.11             142        NA
#> 492           95     104.9          268        12.03               6        NA
#> 493          311     106.8          342        -5.57             329        NA
#> 494          177     103.1          174         5.25              35        NA
#> 495           80     103.5          198        -3.24             280        NA
#> 496           96     101.1          100         0.30             170        NA
#> 497          274     107.9          351         3.54              65        16
#> 498          148     102.1          128         3.20              70        NA
#> 499          181     105.6          297        -2.89             269        NA
#> 500          139     103.0          169         0.60             160        NA
#> 501          267     105.2          279        -0.21             185        15
#> 502          329     103.7          205         0.29             171        16
#> 503          128     101.6          116         0.08             177        NA
#> 504          210     103.3          188        -3.57             287        NA
#> 505          155     103.1          172        -1.49             230        NA
#> 506          212     102.4          145        -4.61             314        NA
#> 507          200     102.4          143         0.27             174        NA
#> 508          202     103.6          199       -11.52             352        NA
#> 509          219     102.8          165        -2.00             243        NA
#> 510           42      98.3           51         1.84             108        NA
#> 511          163     103.3          185        -1.80             238        NA
#> 512          182     103.1          171        -0.54             195        NA
#> 513          171     103.2          177        -1.67             232        NA
#> 514           77     102.3          138         0.40             165        NA
#> 515          149     104.7          259         0.97             151        NA
#> 516          245     105.6          300         0.04             180        16
#> 517          266     104.7          258        -2.90             270        NA
#> 518          189     103.8          206         2.51              91        NA
#> 519           13      96.1            9        -1.05             215        NA
#> 520          134     102.5          147        -5.30             324        NA
#> 521          183     103.3          189        -5.42             326        NA
#> 522          111      99.4           73         1.15             141        NA
#> 523          277     104.1          228         6.98              22        NA
#> 524          173     102.9          167        -1.18             219        NA
#> 525          165     102.5          149        -2.44             254        NA
#> 526           58     100.0           85        -5.62             330        NA
#> 527          135     104.2          233         3.69              62        NA
#> 528          167     102.2          133         1.39             131        NA
#> 529          264     105.4          284         3.47              67        NA
#> 530          217     103.3          184         0.30             169        NA
#> 531          160     102.0          125        -6.46             341        NA
#> 532          126     102.4          146         1.61             121        NA
#> 533          312     105.9          314         0.03             181        NA
#> 534          221     105.4          286        -2.78             268        NA
#> 535          140     102.5          148        -3.73             293        NA
#> 536           56      97.9           40        -1.74             237        NA
#> 537          222     105.6          299        -5.78             332        NA
#> 538          136     101.5          109        -3.54             284        NA
#> 539          204     104.0          220        -5.93             335        NA
#> 540          201     104.1          230        -0.32             189        NA
#> 541          292     106.6          335         5.58              33        NA
#> 542          137      99.6           79        -5.36             325        NA
#> 543          238     106.8          343         7.52              19        NA
#> 544          330     103.6          202        -0.94             210        NA
#> 545          199     102.4          140         1.55             125        NA
#> 546          259     102.6          154        -5.65             331        NA
#> 547          166     102.6          152        -3.87             295        NA
#> 548          223     102.7          163        -3.81             294        NA
#> 549          305     103.8          211         1.61             119        NA
#> 550          269     106.2          322        11.95               7        NA
#> 551          307     105.1          276        -3.63             290        NA
#> 552          175     105.3          283        -1.14             218        NA
#> 553          106     102.2          135         3.13              72        NA
#> 554          105     101.5          111        -3.00             273        NA
#> 555          194     104.0          221        -4.91             319        NA
#> 556          208     102.6          153        -0.86             206        NA
#> 557          302     106.5          333        -3.97             298        NA
#> 558          320     103.9          217        -1.21             221        NA
#> 559          326     106.2          323        -6.96             344        NA
#> 560          255     106.2          324        -3.00             274        NA
#> 561          258     104.9          267        -0.51             193        NA
#> 562          231     102.7          161        -2.54             256        NA
#> 563          159     102.8          166        -0.17             183        NA
#> 564          279     106.1          319         1.65             118        16
#> 565          237     105.4          287        -3.06             275        NA
#> 566           83     101.6          113        -2.23             249        NA
#> 567          211     101.3          103         1.42             128        NA
#> 568          251     105.2          281        -3.90             297        NA
#> 569          257     105.9          312         4.54              47        NA
#> 570          348     104.3          243         9.36              11        16
#> 571          260     104.8          265        -2.76             267        NA
#> 572          191     103.9          216         0.29             172        NA
#> 573          144     102.0          126         1.94             107        NA
#> 574          215     100.3           91        -9.14             350        NA
#> 575          227     106.7          340         6.08              29        NA
#> 576          104     104.3          238         4.54              48        NA
#> 577          113     101.7          117         0.47             164        NA
#> 578          328     103.5          195         0.72             155        NA
#> 579          157     103.8          210         0.73             154        NA
#> 580          236     103.8          214         5.00              39        NA
#> 581          214     102.8          164        -2.12             246        NA
#> 582          241     103.2          180         0.63             159        NA
#> 583          145     103.0          170        -1.69             234        NA
#> 584          285     105.4          289         0.40             166        NA
#> 585          233     106.1          316        -2.99             272        NA
#> 586          158     102.7          158        -3.35             282        NA
#> 587           69     101.0           98         1.42             130        NA
#> 588          100     103.8          212         6.91              24        NA
#> 589          271     105.4          285        -2.75             266        NA
#> 590          150     103.2          178         4.63              46        NA
#> 591          317     105.5          293        -2.20             248        NA
#> 592          195     105.5          294         2.57              86        NA
#> 593          261     106.3          327         2.31              96        NA
#> 594          154     102.1          127        -1.46             227        NA
#> 595          313     107.7          350        -6.08             337        NA
#> 596          220     104.6          255         3.71              61        NA
#> 597          282     105.2          280        -2.41             253        NA
#> 598          197     101.5          107        -6.19             339        NA
#> 599          205     104.8          263         2.63              83        NA
#> 600          303     105.7          303        -5.11             321        NA
#> 601          196     104.3          241        -1.01             212        NA
#> 602          225     103.8          208       -13.52             353        NA
#> 603           59     101.9          121        -3.15             277        NA
#> 604          270     103.8          213         2.56              87        NA
#> 605          306     105.0          275        -3.57             288        NA
#> 606          216     104.7          261         4.75              43        NA
#> 607          345     105.0          272         6.45              26        NA
#> 608          332     104.5          251        -6.81             343        NA
#> 609          123     102.5          150         1.79             111        NA
#> 610          235     104.7          256        -0.71             201        NA
#> 611          343     106.6          334         2.04             102        NA
#> 612          281     105.2          277        -4.06             302        NA
#> 613          280     104.0          219        -0.17             184        NA
#> 614          174     104.5          250        -6.37             340        NA
#> 615          308     103.5          196        -0.87             208        NA
#> 616          297     105.8          309        -0.38             191        NA
#> 617           84      99.5           75         4.70              45        NA
#> 618          107     106.5          331        -2.54             255        NA
#> 619          293     107.6          349        -4.59             313        NA
#> 620          218     103.3          183         2.33              95        NA
#> 621          272     106.7          336        -6.73             342        NA
#> 622          310     104.4          247        -2.57             259        NA
#> 623          192     105.4          290         2.55              89        NA
#> 624          263     106.4          328        -0.08             182        NA
#> 625          275     106.7          338        -7.30             345        NA
#> 626          323     104.3          239        -4.38             307        NA
#> 627          268     107.2          346         5.85              31        NA
#> 628          248     105.7          305        -3.09             276        NA
#> 629          340     106.3          326         6.55              25        16
#> 630          162     102.2          134         5.18              36        NA
#> 631          203     101.8          119        -0.27             186        NA
#> 632          336     104.0          223        -5.29             323        NA
#> 633          304     105.9          313         7.69              17        NA
#> 634          170     104.3          244         1.10             143        NA
#> 635          338     103.1          175        14.38               2        NA
#> 636           88     102.2          131         9.01              13        NA
#> 637          273     105.3          282         1.05             146        NA
#> 638          341     104.9          271         7.60              18        NA
#> 639          309     104.7          257        -4.51             310        NA
#> 640          188     104.0          222        12.93               4        NA
#> 641          296     104.9          266         0.59             161        NA
#> 642          316     106.9          345        -2.74             265        NA
#> 643          108     102.0          124        -4.31             305        NA
#> 644          342     105.7          307         4.11              55        NA
#> 645          299     104.8          262        -2.55             257        NA
#> 646          298     104.3          245         3.47              66        NA
#> 647           54     101.3          102         2.30              97        NA
#> 648          156     102.7          159         4.22              52        NA
#> 649          350     105.7          306         1.58             122        NA
#> 650          164     103.1          173        -2.74             264        NA
#> 651          131     102.7          157        -4.81             318        NA
#> 652          143     101.7          118         4.27              50        NA
#> 653          249     104.5          252         0.65             158        NA
#> 654          141     101.9          123         7.78              16        NA
#> 655          278     105.8          310        -2.64             261        NA
#> 656          213     102.4          144        -2.23             250        NA
#> 657          300     102.3          139         3.87              60        NA
#> 658          287     104.2          235        -1.19             220        NA
#> 659          295     108.8          353        -3.42             283        NA
#> 660          290     106.2          321         0.37             167        NA
#> 661          176     104.4          248         5.40              34        NA
#> 662          119     104.9          269        -0.59             197        NA
#> 663          207     103.8          209         4.31              49        NA
#> 664          318     105.8          311        -5.94             336        NA
#> 665          276     105.4          288         1.66             116        NA
#> 666          346     105.6          301         5.03              38        NA
#> 667          256     104.1          225         1.03             147        NA
#> 668          239     104.1          231        -3.99             299        NA
#> 669          120     104.5          253         1.96             106        NA
#> 670          198     104.1          232         3.41              69        NA
#> 671          333     104.2          237         8.42              14        NA
#> 672          130     103.3          186         6.25              27        NA
#> 673          324     106.1          318        -4.35             306        NA
#> 674          335     104.7          260        -8.93             349        NA
#> 675          291     107.5          348         0.67             157        NA
#> 676          327     107.9          352        -6.18             338        NA
#> 677          288     102.7          160         0.48             163        NA
#> 678          114     103.4          194         0.08             176        NA
#> 679          349     106.9          344        -0.52             194        NA
#> 680          172     103.6          201        -1.61             231        NA
#> 681          352     103.6          200         9.06              12        NA
#> 682          253     106.7          339         1.57             123        NA
#> 683          243     104.8          264        15.78               1        NA
#> 684          339     105.5          292         2.53              90        NA
#> 685          250     103.6          203         1.27             137        NA
#> 686          315     104.4          246         2.13              99        NA
#> 687          151     105.5          296        -4.75             316        NA
#> 688          247     105.6          302         2.09             101        NA
#> 689          321     104.2          236        10.67               9        NA
#> 690          289     104.1          227        -1.86             241        NA
#> 691          121     103.1          176        -2.59             260        NA
#> 692          294     106.4          329        -2.03             244        NA
#> 693          254     105.2          278         4.94              40        NA
#> 694          252     106.5          330        -0.36             190        NA
#> 695          262     104.9          270         4.71              44        NA
#> 696          351     106.1          320         0.68             156        NA
#> 697          283     105.7          304        -0.78             205        NA
#> 698          232     106.1          317         3.44              68        NA
#> 699          234     104.1          229        13.24               3        NA
#> 700          347     104.5          249         2.36              94        NA
#> 701          240     103.9          218         0.04             179        NA
#> 702          301     106.3          325        -2.27             251        NA
#> 703          353     105.6          298        -3.21             279        NA
#> 704          265     104.3          242         1.42             129        NA
#> 705          322     103.3          182        12.03               5        NA
#> 706          337     104.1          226         7.78              15        NA
#> 707          344     105.0          274         0.96             152        NA
#> 708          334     103.9          215         5.14              37        NA
#> 709          187     103.7          204         4.10              56        NA
#> 710          244     104.3          240        -0.75             204        NA
# }
# \donttest{
try(kp_efficiency(min_year = 2020, max_year = 2021))
#> ✖ 2026-10-26 19:18:29.900934: Invalid arguments or no efficiency data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf  AdjT AdjT.Rk RawT RawT.Rk AvgPossLengthOff
#> 1   Mississippi Valley St. SWAC  89.8   -12.6  345    86.7              349
#> 2          Houston Baptist Slnd 102.9     0.5  175   102.5              140
#> 3                 Marshall CUSA 101.2    -1.2  199   100.1              193
#> 4                  Alabama  SEC 111.0     8.6   37   106.0               71
#> 5             Delaware St. MEAC  94.1    -8.3  323    94.7              310
#> 6         Eastern Kentucky  OVC  95.4    -7.0  297    95.7              287
#> 7                Green Bay Horz 105.8     3.4  109   105.4               79
#> 8                  Buffalo  MAC 104.1     1.7  151   103.3              123
#> 9       North Carolina A&T MEAC  92.3   -10.1  335    93.3              323
#> 10             The Citadel   SC  94.9    -7.5  305    94.2              317
#> 11        Central Michigan  MAC 102.0    -0.4  187   100.8              175
#> 12              Coppin St. MEAC  89.6   -12.8  346    90.5              342
#> 13            San Jose St.  MWC  97.5    -4.9  262    93.2              324
#> 14             Arizona St.  P12 106.0     3.6  108   100.1              191
#> 15        Central Arkansas Slnd  98.0    -4.4  256    96.4              273
#> 16                Nebraska  B10 102.0    -0.4  190    94.3              316
#> 17          South Carolina  SEC 105.4     3.0  122   100.8              176
#> 18      Eastern Washington BSky 105.4     3.0  120   105.0               88
#> 19             Georgia St.   SB 105.6     3.3  115   104.1              107
#> 20         Bethune Cookman MEAC  95.4    -7.0  298    96.6              267
#> 21              St. John's   BE 106.1     3.7  104   100.4              183
#> 22          Texas Southern SWAC  99.1    -3.3  237    96.7              264
#> 23                     LIU  NEC  97.4    -5.0  265   100.0              195
#> 24                    UTSA CUSA 104.2     1.8  149   101.2              168
#> 25                 Samford   SC  98.6    -3.8  245    97.5              244
#> 26        Coastal Carolina   SB 104.8     2.4  134   103.6              112
#> 27                Monmouth MAAC  99.1    -3.3  238    98.5              222
#> 28                 Memphis Amer 100.6    -1.8  210    97.4              250
#> 29        Northwestern St. Slnd  98.3    -4.1  251   100.1              192
#> 30                     FIU CUSA 103.7     1.3  157   102.1              149
#> 31              Wright St. Horz 104.9     2.5  132   107.9               39
#> 32           James Madison  CAA  99.5    -2.9  230    99.1              210
#> 33  Southeastern Louisiana Slnd  92.0   -10.4  338    92.2              332
#> 34                    Duke  ACC 115.7    13.3    9   111.9                6
#> 35                 Gonzaga  WCC 121.3    18.9    1   120.1                1
#> 36                Winthrop BSth 104.7     2.3  136   108.9               26
#> 37               Louisiana   SB 101.3    -1.1  196    99.5              199
#> 38              New Mexico  MWC 105.3     2.9  125   104.9               91
#> 39       Stephen F. Austin Slnd 104.1     1.7  152   106.3               65
#> 40            Portland St. BSky 108.8     6.4   57   107.9               40
#> 41        Georgia Southern   SB 102.2    -0.2  184   101.3              162
#> 42             Santa Clara  WCC 102.6     0.2  176   101.6              157
#> 43        Western Carolina   SC 107.3     4.9   83   106.6               60
#> 44        Western Illinois  Sum  98.3    -4.1  250    99.0              212
#> 45                Arkansas  SEC 109.1     6.7   55   104.7               95
#> 46            Rhode Island  A10 105.2     2.9  126   101.2              167
#> 47          Saint Joseph's  A10 101.9    -0.5  193    96.5              270
#> 48         Sam Houston St. Slnd  99.5    -2.9  229   101.6              158
#> 49                   Rider MAAC 100.9    -1.5  204   100.0              196
#> 50                  Nevada  MWC 110.3     7.9   44   107.1               52
#> 51           UNC Asheville BSth  98.7    -3.7  243   103.8              110
#> 52               Loyola MD  Pat 100.4    -2.0  213   102.2              145
#> 53                  Denver  Sum  95.0    -7.3  303    95.3              297
#> 54                Penn St.  B10 110.3     8.0   43   105.0               86
#> 55          Long Beach St.   BW  94.2    -8.2  320    92.2              333
#> 56                 Hampton BSth 104.8     2.4  135   105.6               75
#> 57              Pepperdine  WCC 107.2     4.8   85   104.3              104
#> 58                   IUPUI Horz  99.4    -3.0  231    97.7              239
#> 59          Washington St.  P12 102.2    -0.2  182    97.5              243
#> 60               Marquette   BE 114.0    11.7   14   107.2               51
#> 61        Prairie View A&M SWAC  96.3    -6.1  282    96.2              278
#> 62           East Carolina Amer  99.6    -2.8  227    95.6              292
#> 63                  DePaul   BE 103.4     1.0  165    97.3              251
#> 64                 Georgia  SEC 108.2     5.8   71   103.5              117
#> 65                 Belmont  OVC 106.5     4.1   97   109.0               25
#> 66    UT Rio Grande Valley  WAC  98.7    -3.7  244    98.7              218
#> 67          North Carolina  ACC 107.7     5.3   77   100.9              173
#> 68            Oral Roberts  Sum 108.2     5.9   70   109.8               18
#> 69             Utah Valley  WAC  96.5    -5.9  277    96.8              261
#> 70          St. Francis NY  NEC  94.6    -7.8  308    96.0              281
#> 71                  Bryant  NEC  97.8    -4.6  257    99.0              213
#> 72            UMass Lowell   AE 104.4     2.0  144   103.5              119
#> 73                  Temple Amer 100.1    -2.3  217    95.2              299
#> 74      Cal St. Northridge   BW 107.4     5.0   82   105.5               78
#> 75                  Howard MEAC  93.6    -8.8  326    94.5              313
#> 76                    Penn  Ivy 103.4     1.0  163   101.7              154
#> 77                    Iowa  B10 117.3    14.9    5   110.3               14
#> 78               San Diego  WCC  94.4    -8.0  315    90.6              340
#> 79             Wake Forest  ACC 108.7     6.3   61   101.9              152
#> 80                    Rice CUSA 105.8     3.4  110   102.9              131
#> 81           Bowling Green  MAC 104.3     1.9  146   102.8              133
#> 82              Alcorn St. SWAC  96.9    -5.4  271    95.8              285
#> 83           North Alabama ASun  96.0    -6.4  289    96.3              276
#> 84                     LSU  SEC 118.1    15.7    4   112.8                4
#> 85            South Dakota  Sum 108.6     6.2   63   109.4               21
#> 86                Canisius MAAC  97.7    -4.7  259    97.5              245
#> 87              Georgetown   BE 111.0     8.6   36   104.5              100
#> 88            Georgia Tech  ACC 103.1     0.7  171    96.0              282
#> 89             Florida St.  ACC 111.7     9.3   32   107.1               53
#> 90                Iowa St.  B12 109.6     7.2   48   101.4              160
#> 91                 Seattle  WAC 101.2    -1.2  200   101.0              169
#> 92             Stony Brook   AE  97.7    -4.7  260    97.4              249
#> 93              Seton Hall   BE 112.3     9.9   29   105.4               80
#> 94             New Orleans Slnd  99.3    -3.1  233    98.8              216
#> 95        Middle Tennessee CUSA  97.5    -4.9  264    95.0              305
#> 96              Washington  P12 105.8     3.4  112    99.9              197
#> 97             Alabama St. SWAC  86.2   -16.1  350    86.7              348
#> 98                Oklahoma  B12 108.8     6.4   58   100.7              179
#> 99                   Lamar Slnd  96.3    -6.1  283    98.3              228
#> 100             Morgan St. MEAC  93.2    -9.2  327    95.6              291
#> 101            Wichita St. Amer 105.6     3.2  117   100.7              177
#> 102              Milwaukee Horz  96.0    -6.4  288    97.7              237
#> 103             N.C. State  ACC 110.7     8.3   42   105.2               82
#> 104    Central Connecticut  NEC  90.3   -12.1  342    88.5              346
#> 105       Illinois Chicago Horz  96.4    -6.0  280    97.0              258
#> 106                   Army  Pat  98.8    -3.6  242   100.7              178
#> 107               Bucknell  Pat  96.2    -6.2  285    96.9              260
#> 108                    BYU  WCC 116.3    13.9    7   112.1                5
#> 109             Vanderbilt  SEC 104.7     2.3  139   101.4              161
#> 110                  Akron  MAC 108.5     6.1   66   106.8               58
#> 111          North Florida ASun 112.0     9.6   31   111.2                8
#> 112          West Virginia  B12 108.3     5.9   67   100.9              172
#> 113                  Brown  Ivy  96.4    -6.0  278    95.0              303
#> 114      Cal St. Fullerton   BW  95.9    -6.5  292    94.4              314
#> 115                Arizona  P12 111.0     8.6   35   107.6               49
#> 116           Colorado St.  MWC 109.3     6.9   52   106.1               69
#> 117                Detroit Horz  99.9    -2.5  221    99.1              209
#> 118          Southern Utah BSky  98.8    -3.5  240    98.9              215
#> 119                   Troy   SB  96.2    -6.2  284    94.6              312
#> 120         Boston College  ACC  99.6    -2.8  228    92.5              329
#> 121          Tennessee St.  OVC  96.4    -6.0  279    98.5              223
#> 122               Portland  WCC  94.4    -8.0  314    92.7              328
#> 123             Valparaiso  MVC 104.5     2.1  141   101.9              151
#> 124               Richmond  A10 109.2     6.8   53   107.8               43
#> 125            Little Rock   SB 106.4     4.1   99   104.2              106
#> 126         Nebraska Omaha  Sum 103.2     0.8  170   102.5              139
#> 127                 Auburn  SEC 111.4     9.0   33   108.3               33
#> 128            USC Upstate BSth  95.5    -6.9  295    97.2              255
#> 129       Eastern Illinois  OVC  98.2    -4.2  253   102.0              150
#> 130           Michigan St.  B10 115.2    12.9   10   109.3               22
#> 131               La Salle  A10  99.6    -2.8  226    96.5              271
#> 132               Columbia  Ivy  95.2    -7.2  302    93.5              321
#> 133              Boise St.  MWC 107.0     4.7   88   104.5               99
#> 134                    VCU  A10 104.7     2.3  138   101.7              155
#> 135            Chicago St.  WAC  86.9   -15.5  349    83.8              350
#> 136       SIU Edwardsville  OVC  92.3   -10.1  336    94.3              315
#> 137            McNeese St. Slnd 103.0     0.6  172   104.9               90
#> 138         St. Francis PA  NEC 107.6     5.2   81   109.1               24
#> 139                    USC  P12 104.3     1.9  145    99.3              206
#> 140                  Idaho BSky  92.8    -9.6  332    91.4              337
#> 141             Quinnipiac MAAC 100.7    -1.7  207   101.3              163
#> 142    Fairleigh Dickinson  NEC 102.1    -0.2  186   102.2              147
#> 143               Kent St.  MAC 106.1     3.7  105   106.0               70
#> 144             Murray St.  OVC 102.4     0.0  178   105.6               77
#> 145           North Dakota  Sum 102.2    -0.2  183   101.7              156
#> 146       Florida Atlantic CUSA  99.7    -2.7  225    98.4              225
#> 147              Air Force  MWC 107.8     5.4   76   104.9               89
#> 148                Harvard  Ivy 104.7     2.3  137   103.8              111
#> 149       Tennessee Martin  OVC 105.1     2.7  128   105.8               74
#> 150               Michigan  B10 113.2    10.8   20   106.8               57
#> 151          Grambling St. SWAC  93.1    -9.3  328    94.7              311
#> 152           Sacred Heart  NEC 102.2    -0.2  185   104.3              102
#> 153               Lipscomb ASun 101.2    -1.2  201   100.2              189
#> 154                 Tulane Amer 101.9    -0.4  192    97.7              236
#> 155          San Francisco  WCC 108.3     5.9   68   106.1               68
#> 156                   Iona MAAC 101.6    -0.8  194   101.0              171
#> 157            Jackson St. SWAC  92.8    -9.6  333    93.4              322
#> 158           Nicholls St. Slnd  99.7    -2.7  223   101.2              166
#> 159               American  Pat 101.1    -1.2  202   103.5              120
#> 160            Florida A&M MEAC  94.4    -8.0  311    93.1              325
#> 161          Massachusetts  A10 102.9     0.6  174    98.2              229
#> 162            Cal Baptist  WAC 105.3     3.0  124   108.3               34
#> 163          New Hampshire   AE  95.0    -7.4  304    95.7              289
#> 164             Binghamton   AE  99.7    -2.7  224    97.6              240
#> 165         UNC Wilmington  CAA  92.1   -10.3  337    92.4              330
#> 166                 Albany   AE  94.3    -8.1  316    94.8              308
#> 167            Connecticut Amer 108.6     6.2   64   102.9              132
#> 168                Colgate  Pat 107.2     4.8   86   109.9               17
#> 169           Illinois St.  MVC  98.4    -4.0  248    96.2              277
#> 170                 Hawaii   BW  97.6    -4.8  261    99.4              205
#> 171             Providence   BE 107.8     5.4   75   102.2              146
#> 172      Abilene Christian Slnd  99.1    -3.3  239   101.5              159
#> 173           Oklahoma St.  B12 107.2     4.9   84    98.7              219
#> 174                 Lehigh  Pat  97.0    -5.4  269    97.0              257
#> 175               Cal Poly   BW  95.2    -7.2  301    93.6              320
#> 176       Western Kentucky CUSA 108.9     6.5   56   106.3               63
#> 177             Holy Cross  Pat  95.9    -6.4  291    95.2              300
#> 178              Creighton   BE 118.2    15.8    3   111.1               10
#> 179               Syracuse  ACC 112.8    10.5   21   107.9               42
#> 180               Miami FL  ACC 107.7     5.3   79   101.0              170
#> 181           Missouri St.  MVC 104.8     2.4  133   102.5              138
#> 182               Delaware  CAA 105.6     3.2  116   107.1               54
#> 183               Stanford  P12 104.4     2.1  143   100.5              182
#> 184               Hartford   AE  94.4    -8.0  312    95.7              288
#> 185                Montana BSky 103.2     0.8  169   101.3              165
#> 186           Kennesaw St. ASun  83.5   -18.9  351    81.2              352
#> 187                 Furman   SC 107.7     5.3   78   108.2               35
#> 188               Colorado  P12 109.1     6.7   54   103.4              122
#> 189       Jacksonville St.  OVC  95.8    -6.6  293    98.5              224
#> 190             Notre Dame  ACC 110.7     8.3   41   106.9               56
#> 191                 Xavier   BE 106.1     3.8  103   100.3              186
#> 192                 Mercer   SC 100.1    -2.3  216   100.3              187
#> 193                 Toledo  MAC 106.3     3.9  102   105.9               73
#> 194               UC Davis   BW 104.7     2.3  140   103.1              128
#> 195                   Ohio  MAC 103.6     1.2  161   102.2              148
#> 196            Mississippi  SEC 103.7     1.3  158    99.5              201
#> 197          Saint Peter's MAAC  95.4    -7.0  300    96.5              272
#> 198           Grand Canyon  WAC 103.4     1.0  164   103.3              124
#> 199             Cincinnati Amer 108.8     6.4   59   102.3              142
#> 200               Ball St.  MAC  99.2    -3.2  235   100.2              190
#> 201       South Dakota St.  Sum 110.0     7.6   46   110.8               11
#> 202                Hofstra  CAA 108.7     6.3   62   110.2               15
#> 203                    VMI   SC 100.2    -2.2  215   100.5              181
#> 204                  Drake  MVC 102.0    -0.4  189   100.4              185
#> 205      Purdue Fort Wayne  Sum  95.4    -7.0  299    97.7              238
#> 206                Indiana  B10 108.5     6.1   65   103.2              126
#> 207               Longwood BSth  91.3   -11.1  339    95.5              295
#> 208                    UCF Amer 103.5     1.1  162    99.4              204
#> 209            Austin Peay  OVC 106.9     4.5   90   108.4               31
#> 210         UNC Greensboro   SC 103.7     1.3  160   103.4              121
#> 211               Duquesne  A10 106.6     4.2   94   104.7               94
#> 212              UC Irvine   BW 105.4     3.0  121   104.8               93
#> 213            Alabama A&M SWAC  87.9   -14.5  348    88.2              347
#> 214           UT Arlington   SB 102.3    -0.1  180   100.4              184
#> 215               Kentucky  SEC 112.7    10.3   24   108.0               37
#> 216              Weber St. BSky  98.8    -3.6  241    95.5              294
#> 217             Evansville  MVC  96.9    -5.5  274    95.0              302
#> 218 Southeast Missouri St.  OVC  94.0    -8.4  324    95.3              296
#> 219            Saint Louis  A10 105.8     3.4  111   103.1              129
#> 220                 Dayton  A10 119.1    16.7    2   116.4                2
#> 221 Maryland Eastern Shore MEAC  81.7   -20.7  352    81.2              351
#> 222         William & Mary  CAA 103.3     0.9  167   104.3              103
#> 223                 Wagner  NEC  97.3    -5.1  266    97.2              254
#> 224                   UTEP CUSA  96.9    -5.5  273    95.6              290
#> 225            Norfolk St. MEAC  94.2    -8.2  321    96.8              263
#> 226     South Carolina St. MEAC  94.9    -7.5  306    96.6              269
#> 227                   Yale  Ivy 107.9     5.6   73   106.2               67
#> 228       Western Michigan  MAC  99.4    -3.0  232    97.4              248
#> 229               Utah St.  MWC 109.5     7.2   49   108.0               38
#> 230              Idaho St. BSky 100.8    -1.6  206    99.5              202
#> 231                Rutgers  B10 107.9     5.6   72   101.9              153
#> 232           Morehead St.  OVC  94.6    -7.8  309    96.3              275
#> 233                 Kansas  B12 115.8    13.4    8   108.6               28
#> 234            Montana St. BSky  97.0    -5.4  270    96.6              268
#> 235                 Drexel  CAA 100.0    -2.4  219    99.7              198
#> 236             Texas Tech  B12 109.8     7.4   47   103.8              109
#> 237           Arkansas St.   SB 104.2     1.8  148   102.5              137
#> 238          Southern Miss CUSA  94.4    -8.0  313    92.3              331
#> 239             Kansas St.  B12 102.5     0.1  177    95.0              304
#> 240        Appalachian St.   SB  99.9    -2.5  220    98.2              230
#> 241          Cleveland St. Horz  92.9    -9.5  329    91.9              335
#> 242             Louisville  ACC 114.5    12.1   12   109.7               20
#> 243               Miami OH  MAC 102.0    -0.4  188   100.3              188
#> 244                Bradley  MVC 106.8     4.4   92   105.0               85
#> 245               Maryland  B10 113.5    11.2   18   106.3               64
#> 246           George Mason  A10 101.3    -1.1  197    99.0              214
#> 247                   UNLV  MWC 107.9     5.5   74   104.3              101
#> 248            Chattanooga   SC 106.6     4.2   93   105.4               81
#> 249                   NJIT ASun  94.7    -7.7  307    94.8              309
#> 250    Charleston Southern BSth  95.4    -6.9  296    97.3              253
#> 251              Lafayette  Pat 100.6    -1.8  211   102.7              135
#> 252         Tennessee Tech  OVC  92.5    -9.9  334    92.9              327
#> 253           Presbyterian BSth  96.9    -5.5  272    97.9              232
#> 254       Eastern Michigan  MAC  94.2    -8.2  318    91.6              336
#> 255                   UMBC   AE  97.8    -4.6  258    96.8              262
#> 256               Southern SWAC  97.2    -5.2  267    97.5              246
#> 257              Minnesota  B10 112.1     9.7   30   104.6               96
#> 258                Wyoming  MWC  94.1    -8.3  322    90.7              339
#> 259           Northwestern  B10 104.9     2.5  131    96.7              265
#> 260                   Utah  P12 106.3     3.9  100   102.3              143
#> 261                  Siena MAAC 107.2     4.8   87   106.5               61
#> 262           Jacksonville ASun  96.0    -6.4  290    96.4              274
#> 263 North Carolina Central MEAC  94.2    -8.2  319    95.9              284
#> 264      George Washington  A10  99.2    -3.2  236    96.0              280
#> 265       Northern Arizona BSky 102.3    -0.1  179   102.2              144
#> 266         Louisiana Tech CUSA 108.7     6.3   60   107.7               47
#> 267               Missouri  SEC 104.1     1.8  150    99.5              203
#> 268           Old Dominion CUSA  98.3    -4.1  249    96.2              279
#> 269         Youngstown St. Horz 103.0     0.6  173   103.5              118
#> 270            Indiana St.  MVC 105.8     3.4  113   103.3              125
#> 271             High Point BSth  94.5    -7.9  310    95.5              293
#> 272      Boston University  Pat 103.3     1.0  166   104.6               97
#> 273                Vermont   AE 106.5     4.1   98   106.5               62
#> 274              Princeton  Ivy 107.0     4.6   89   105.2               83
#> 275              Villanova   BE 113.9    11.5   15   107.8               44
#> 276        Mississippi St.  SEC 113.4    11.0   19   109.2               23
#> 277                 Baylor  B12 113.5    11.2   17   106.3               66
#> 278                   Elon  CAA 100.6    -1.8  208   100.0              194
#> 279           Gardner Webb BSth 102.2    -0.2  181   104.6               98
#> 280               Ohio St.  B10 114.3    11.9   13   108.1               36
#> 281     East Tennessee St.   SC 108.2     5.9   69   109.7               19
#> 282          Robert Morris  NEC 100.5    -1.9  212   102.8              134
#> 283         Incarnate Word Slnd  90.3   -12.1  341    92.0              334
#> 284    Arkansas Pine Bluff SWAC  79.0   -23.4  353    78.2              353
#> 285                Oakland Horz  98.6    -3.8  246    98.4              226
#> 286     Florida Gulf Coast ASun  91.2   -11.1  340    90.8              338
#> 287       North Dakota St.  Sum 106.8     4.4   91   108.4               30
#> 288               Illinois  B10 110.9     8.5   38   105.1               84
#> 289                Niagara MAAC 100.1    -2.3  218    97.8              235
#> 290                Clemson  ACC 103.9     1.5  155    98.6              220
#> 291           Northeastern  CAA 105.4     3.0  123   107.7               45
#> 292                  Texas  B12 104.1     1.7  153    97.0              259
#> 293                Wofford   SC 104.5     2.1  142   104.3              105
#> 294                  Maine   AE  92.9    -9.5  330    90.3              343
#> 295             Charleston  CAA 105.0     2.6  129   105.0               87
#> 296              Manhattan MAAC  92.8    -9.6  331    93.1              326
#> 297                  Tulsa Amer 103.2     0.8  168    99.5              200
#> 298              Dartmouth  Ivy  96.7    -5.7  276    95.3              298
#> 299          Northern Iowa  MVC 112.7    10.3   23   110.7               12
#> 300                Houston Amer 112.7    10.3   22   107.7               48
#> 301        St. Bonaventure  A10 106.6     4.2   95   103.6              115
#> 302                    UAB CUSA 100.8    -1.6  205    99.3              207
#> 303 Texas A&M Corpus Chris Slnd  94.3    -8.1  317    96.0              283
#> 304      Northern Kentucky Horz 102.0    -0.4  191   103.6              116
#> 305             Oregon St.  P12 110.9     8.5   39   106.7               59
#> 306               Campbell BSth  96.8    -5.6  275   100.5              180
#> 307              Charlotte CUSA  98.5    -3.9  247    98.1              231
#> 308             Pittsburgh  ACC 104.0     1.6  154    98.3              227
#> 309          Virginia Tech  ACC 104.3     1.9  147   101.3              164
#> 310          South Alabama   SB 104.9     2.5  130   104.0              108
#> 311         Loyola Chicago  MVC 103.7     1.3  159   102.6              136
#> 312              Texas St.   SB 106.3     3.9  101   104.8               92
#> 313              Tennessee  SEC 106.6     4.2   96   100.8              174
#> 314                Cornell  Ivy 101.2    -1.2  198    98.8              217
#> 315             California  P12 101.5    -0.8  195    95.1              301
#> 316                 Marist MAAC  90.2   -12.2  343    90.6              341
#> 317                 Towson  CAA 105.7     3.3  114   105.6               76
#> 318                    TCU  B12 105.5     3.1  119    97.5              242
#> 319                 Oregon  P12 117.1    14.7    6   111.9                7
#> 320      Northern Colorado BSky 110.2     7.8   45   110.3               13
#> 321    Cal St. Bakersfield  WAC  96.2    -6.2  286    97.6              241
#> 322       Louisiana Monroe   SB  96.1    -6.3  287    93.7              318
#> 323                Pacific  WCC 103.8     1.4  156   102.4              141
#> 324          South Florida Amer 100.2    -2.2  214    95.0              306
#> 325                   UCLA  P12 109.3     6.9   51   103.6              114
#> 326                Florida  SEC 112.5    10.1   27   107.3               50
#> 327                   UMKC  WAC  97.5    -4.9  263    98.5              221
#> 328                Fordham  A10  89.1   -13.3  347    88.6              345
#> 329      Northern Illinois  MAC  99.8    -2.6  222    99.1              211
#> 330               Davidson  A10 112.5    10.1   26   108.6               27
#> 331                    SMU Amer 112.4    10.0   28   108.3               32
#> 332          San Diego St.  MWC 115.1    12.7   11   112.8                3
#> 333                 Purdue  B10 109.3     7.0   50   102.9              130
#> 334              Texas A&M  SEC 101.0    -1.4  203    95.8              286
#> 335       UC Santa Barbara   BW 106.1     3.7  106   107.0               55
#> 336                Radford BSth 105.6     3.2  118   108.5               29
#> 337      Southern Illinois  MVC  98.2    -4.1  252    96.6              266
#> 338             Fresno St.  MWC 105.1     2.7  127   103.2              127
#> 339           Saint Mary's  WCC 113.7    11.3   16   111.2                9
#> 340         Sacramento St. BSky  97.1    -5.3  268    97.1              256
#> 341                 Butler   BE 112.6    10.2   25   105.9               72
#> 342              Wisconsin  B10 110.8     8.4   40   103.6              113
#> 343         New Mexico St.  WAC 107.6     5.2   80   107.9               41
#> 344                Stetson ASun  98.1    -4.3  255    97.9              233
#> 345       Mount St. Mary's  NEC  96.4    -6.0  281    97.9              234
#> 346              Fairfield MAAC  90.1   -12.3  344    90.2              344
#> 347           UC Riverside   BW  95.8    -6.6  294    97.3              252
#> 348              Merrimack  NEC  93.9    -8.5  325    94.9              307
#> 349       Loyola Marymount  WCC 100.6    -1.8  209    97.4              247
#> 350            North Texas CUSA 111.2     8.8   34   107.7               46
#> 351                   Navy  Pat  98.1    -4.3  254    99.2              208
#> 352                Liberty ASun 106.1     3.7  107   109.9               16
#> 353               Virginia  ACC  99.3    -3.1  234    93.6              319
#>     AvgPossLengthOff.Rk AvgPossLengthDef AvgPossLengthDef.Rk  AdjO AdjO.Rk RawO
#> 1                 117.6             15.3                 349 112.7     343 77.1
#> 2                 122.3             19.9                 352 120.0     352 76.1
#> 3                  99.1             -3.3                 106  97.8     107 74.9
#> 4                  99.5             -2.9                 114 102.2     221 74.8
#> 5                 117.2             14.8                 347 109.6     329 74.7
#> 6                 104.9              2.5                 230 101.7     202 74.5
#> 7                 110.5              8.1                 319 107.9     317 74.0
#> 8                 102.3             -0.1                 175 101.0     187 73.9
#> 9                 102.4              0.0                 177  96.6      83 73.7
#> 10                112.2              9.8                 328 111.7     340 73.7
#> 11                106.4              4.0                 264 105.4     283 73.6
#> 12                105.3              2.9                 240  99.2     143 73.4
#> 13                107.8              5.4                 289 110.5     335 73.3
#> 14                 94.7             -7.7                  49  96.1      64 73.2
#> 15                107.6              5.2                 285 107.1     310 73.2
#> 16                101.3             -1.1                 152 105.5     287 73.1
#> 17                 94.7             -7.7                  50  95.4      54 73.1
#> 18                101.1             -1.3                 142  99.7     156 73.1
#> 19                101.4             -1.0                 156  99.9     162 73.0
#> 20                105.8              3.4                 254  98.3     122 73.0
#> 21                 95.2             -7.2                  53  96.9      91 72.9
#> 22                108.6              6.2                 304 102.2     220 72.9
#> 23                106.1              3.7                 259 103.1     241 72.8
#> 24                108.0              5.6                 293 106.1     296 72.8
#> 25                112.6             10.3                 332 113.2     345 72.8
#> 26                106.2              3.8                 261 104.5     270 72.8
#> 27                101.8             -0.6                 162  97.3     101 72.6
#> 28                 89.1            -13.3                   5  88.5       2 72.6
#> 29                107.1              4.7                 278 104.1     265 72.4
#> 30                102.1             -0.3                 170  99.8     159 72.2
#> 31                101.4             -1.0                 157  96.2      71 72.1
#> 32                111.6              9.2                 323 108.5     324 72.1
#> 33                109.6              7.2                 312 106.3     300 72.1
#> 34                 91.1            -11.3                  12  91.4      11 72.0
#> 35                 94.4             -8.0                  43  93.3      23 71.9
#> 36                102.1             -0.3                 169  98.3     125 71.9
#> 37                106.2              3.8                 262 105.2     282 71.8
#> 38                102.4              0.0                 178 103.8     256 71.8
#> 39                 97.1             -5.3                  75  91.8      14 71.8
#> 40                108.8              6.4                 306 106.6     304 71.8
#> 41                 98.8             -3.6                 102  98.0     115 71.8
#> 42                101.3             -1.0                 154  99.7     155 71.6
#> 43                106.3              3.9                 263 104.9     277 71.5
#> 44                115.0             12.6                 343 114.7     349 71.3
#> 45                 95.5             -6.9                  57  96.2      68 71.2
#> 46                 94.2             -8.2                  39  95.0      47 71.2
#> 47                110.2              7.9                 315 111.3     338 71.2
#> 48                103.7              1.3                 200  99.8     161 71.1
#> 49                102.1             -0.3                 171  96.6      80 71.1
#> 50                101.0             -1.4                 141 100.8     183 71.0
#> 51                110.3              7.9                 318 106.7     305 71.0
#> 52                109.1              6.7                 309 105.4     285 71.0
#> 53                106.8              4.4                 274 106.6     302 70.9
#> 54                 92.4            -10.0                  23  95.8      59 70.9
#> 55                105.3              2.9                 238 105.6     288 70.9
#> 56                116.7             14.3                 345 114.3     348 70.9
#> 57                104.4              2.0                 217 105.4     286 70.8
#> 58                115.6             13.2                 344 114.0     347 70.8
#> 59                 98.0             -4.4                  83  97.4     102 70.8
#> 60                 96.9             -5.5                  73  99.0     137 70.7
#> 61                100.5             -1.9                 131  93.3      22 70.7
#> 62                104.0              1.6                 213 101.9     213 70.6
#> 63                 95.5             -6.9                  56  99.2     144 70.6
#> 64                100.8             -1.6                 136 103.4     249 70.5
#> 65                100.5             -1.9                 132  94.3      38 70.5
#> 66                106.0              3.6                 256 103.4     247 70.4
#> 67                 98.4             -4.0                  94 102.1     219 70.4
#> 68                104.9              2.5                 231 105.0     279 70.4
#> 69                104.2              1.8                 215 101.5     197 70.4
#> 70                106.5              4.1                 266 101.7     204 70.3
#> 71                103.8              1.5                 206  98.7     130 70.3
#> 72                113.6             11.2                 337 107.4     313 70.3
#> 73                 94.6             -7.8                  47  95.1      51 70.3
#> 74                113.3             10.9                 336 112.6     342 70.3
#> 75                119.7             17.4                 350 113.9     346 70.2
#> 76                100.8             -1.6                 137  99.7     157 70.2
#> 77                 98.6             -3.8                  97 102.4     225 70.2
#> 78                 99.8             -2.6                 117 101.8     206 70.2
#> 79                102.0             -0.4                 166 104.0     263 70.1
#> 80                108.4              6.1                 301 106.0     295 70.1
#> 81                104.0              1.6                 210 102.3     222 70.1
#> 82                111.3              8.9                 322 103.0     239 70.1
#> 83                105.6              3.2                 248 100.8     185 70.1
#> 84                102.4              0.1                 179 102.6     231 70.0
#> 85                108.9              6.6                 307 106.3     299 70.0
#> 86                105.7              3.3                 249 100.8     181 70.0
#> 87                100.2             -2.2                 125 103.6     251 70.0
#> 88                 91.8            -10.6                  16  94.2      36 70.0
#> 89                 91.5            -10.9                  15  93.6      24 69.9
#> 90                101.2             -1.2                 147 103.5     250 69.9
#> 91                105.5              3.1                 247 101.3     193 69.9
#> 92                 99.4             -3.0                 111  94.5      42 69.8
#> 93                 92.7             -9.7                  25  96.1      65 69.8
#> 94                114.8             12.4                 342 111.8     341 69.8
#> 95                108.2              5.8                 298 107.8     315 69.8
#> 96                 93.1             -9.3                  31  93.9      30 69.8
#> 97                103.4              1.0                 198 100.7     178 69.7
#> 98                 93.1             -9.3                  29  96.8      89 69.6
#> 99                102.5              0.1                 180  99.3     151 69.6
#> 100               107.5              5.1                 282 100.8     182 69.6
#> 101                90.4            -12.0                   8  89.7       5 69.5
#> 102               104.9              2.5                 232 102.4     227 69.5
#> 103                97.3             -5.1                  79  98.5     127 69.5
#> 104               114.0             11.6                 340 110.6     336 69.5
#> 105                99.5             -2.8                 115  96.8      87 69.5
#> 106               107.4              5.1                 281 104.0     262 69.5
#> 107               102.9              0.5                 189 101.6     200 69.5
#> 108                95.6             -6.8                  60  97.0      92 69.5
#> 109               104.5              2.1                 221 106.3     301 69.4
#> 110                98.9             -3.4                 103  95.6      57 69.4
#> 111               111.6              9.2                 324 107.1     311 69.4
#> 112                87.1            -15.3                   3  89.5       4 69.4
#> 113               101.1             -1.3                 143  99.3     148 69.4
#> 114               104.5              2.1                 218 102.0     217 69.3
#> 115                91.4            -11.0                  14  92.4      15 69.3
#> 116               102.1             -0.3                 172 102.4     229 69.3
#> 117               111.7              9.4                 326 110.1     333 69.3
#> 118                98.1             -4.2                  86  95.5      55 69.3
#> 119               106.6              4.2                 268 105.4     284 69.3
#> 120               100.3             -2.1                 128 101.4     195 69.3
#> 121               104.6              2.2                 222 100.3     172 69.3
#> 122               104.3              1.9                 216 104.5     272 69.3
#> 123               102.5              0.1                 181 101.6     198 69.3
#> 124                95.3             -7.1                  54  95.2      52 69.3
#> 125               102.5              0.1                 184  99.8     160 69.3
#> 126               107.7              5.3                 286 108.2     319 69.2
#> 127                95.5             -6.9                  55  97.7     106 69.2
#> 128               110.8              8.5                 320 108.5     323 69.2
#> 129               104.5              2.1                 220  98.9     133 69.1
#> 130                91.2            -11.2                  13  93.8      27 69.1
#> 131               100.4             -2.0                 129  99.1     142 69.1
#> 132               106.5              4.1                 267 104.3     268 69.1
#> 133                97.6             -4.7                  81  99.1     141 69.1
#> 134                94.4             -8.0                  45  93.8      28 69.0
#> 135               120.8             18.4                 351 120.5     353 69.0
#> 136               110.0              7.6                 314 106.8     307 69.0
#> 137               112.3              9.9                 330 108.3     320 69.0
#> 138               107.9              5.5                 290 102.9     236 68.9
#> 139                92.0            -10.4                  18  93.0      21 68.9
#> 140               107.1              4.7                 277 106.1     297 68.9
#> 141               108.3              5.9                 300 102.8     234 68.9
#> 142               112.4             10.0                 331 108.3     321 68.9
#> 143               102.1             -0.3                 167 100.0     163 68.9
#> 144                99.3             -3.1                 110  94.1      33 68.9
#> 145               107.7              5.3                 287 108.6     325 68.9
#> 146               101.3             -1.1                 151  99.0     138 68.8
#> 147               110.3              7.9                 316 110.0     332 68.8
#> 148                99.0             -3.3                 105  97.0      93 68.8
#> 149               122.9             20.5                 353 119.9     351 68.7
#> 150                93.0             -9.4                  28  97.6     103 68.7
#> 151               105.1              2.7                 235  98.6     129 68.7
#> 152               104.8              2.4                 227 100.5     174 68.7
#> 153               108.0              5.6                 292 104.1     266 68.7
#> 154               103.1              0.7                 191 101.8     209 68.7
#> 155                98.2             -4.2                  88  99.3     147 68.7
#> 156               106.1              3.8                 260 101.5     196 68.7
#> 157               102.3             -0.1                 176  96.6      81 68.7
#> 158               101.5             -0.9                 158  97.8     111 68.7
#> 159               104.0              1.6                 212 100.2     168 68.7
#> 160               107.3              4.9                 279 101.4     194 68.6
#> 161               102.5              0.1                 185 102.0     218 68.6
#> 162               108.1              5.7                 295 101.9     214 68.6
#> 163               102.1             -0.3                 168  97.8     108 68.6
#> 164               116.9             14.5                 346 112.9     344 68.6
#> 165               104.5              2.1                 219 104.7     276 68.5
#> 166               103.9              1.5                 208  99.1     139 68.5
#> 167                95.6             -6.8                  59  94.1      34 68.5
#> 168               102.5              0.1                 182  99.6     153 68.5
#> 169               102.9              0.6                 190 103.1     240 68.5
#> 170               101.0             -1.4                 140  98.3     123 68.4
#> 171                92.8             -9.6                  27  94.9      46 68.4
#> 172               100.2             -2.2                 126  96.1      67 68.4
#> 173                94.5             -7.9                  46  96.7      86 68.4
#> 174               108.8              6.4                 305 107.4     314 68.4
#> 175               108.5              6.1                 302 107.8     316 68.3
#> 176               103.3              0.9                 196 101.7     203 68.3
#> 177               117.3             14.9                 348 115.0     350 68.3
#> 178                97.3             -5.1                  78 100.6     176 68.3
#> 179                99.6             -2.8                 116 100.4     173 68.3
#> 180               101.3             -1.1                 149 104.0     264 68.3
#> 181               100.2             -2.2                 124  98.8     131 68.3
#> 182               106.4              4.0                 265 103.7     255 68.3
#> 183                90.3            -12.1                   7  90.5       9 68.3
#> 184               101.1             -1.3                 144  97.0      95 68.2
#> 185               100.1             -2.3                 123  97.9     114 68.2
#> 186               112.2              9.8                 329 110.8     337 68.2
#> 187                98.1             -4.3                  85  96.4      79 68.2
#> 188                93.4             -9.0                  32  93.9      31 68.2
#> 189               105.5              3.1                 245 101.2     191 68.1
#> 190                98.6             -3.7                 100  98.9     134 68.1
#> 191                92.2            -10.1                  20  96.2      69 68.1
#> 192               102.7              0.3                 188 101.0     188 68.1
#> 193               105.1              2.7                 237 102.3     223 68.1
#> 194               109.4              7.0                 311 106.2     298 68.0
#> 195               103.3              0.9                 195 101.7     201 68.0
#> 196                97.0             -5.4                  74  98.8     132 68.0
#> 197                97.3             -5.0                  80  93.0      20 68.0
#> 198               112.1              9.7                 327 106.8     308 68.0
#> 199                94.7             -7.6                  51  94.4      40 68.0
#> 200                94.0             -8.4                  37  91.5      12 68.0
#> 201               105.3              2.9                 241 101.2     192 68.0
#> 202               102.6              0.2                 187 100.0     165 67.9
#> 203               108.1              5.7                 296 106.6     303 67.9
#> 204               101.3             -1.0                 155 100.6     175 67.9
#> 205               103.8              1.4                 204 104.6     275 67.9
#> 206                92.7             -9.6                  26  97.3      99 67.9
#> 207               105.1              2.7                 234 100.0     164 67.8
#> 208                98.6             -3.8                  98  98.0     116 67.8
#> 209               107.0              4.6                 275 103.7     253 67.8
#> 210                95.5             -6.9                  58  92.9      18 67.8
#> 211                99.0             -3.4                 104  97.0      96 67.8
#> 212                99.3             -3.1                 109  96.2      72 67.7
#> 213               108.2              5.8                 297 101.9     216 67.7
#> 214                98.4             -4.0                  95  99.2     145 67.7
#> 215                95.1             -7.3                  52  96.2      70 67.7
#> 216               107.9              5.5                 291 107.2     312 67.6
#> 217               107.4              5.0                 280 106.8     309 67.6
#> 218               113.0             10.6                 334 109.2     328 67.6
#> 219                94.4             -8.0                  44  93.9      29 67.6
#> 220                94.1             -8.3                  38  93.7      25 67.6
#> 221               107.8              5.4                 288 103.8     257 67.5
#> 222               105.5              3.1                 244 103.7     252 67.5
#> 223               113.9             11.5                 339 109.6     330 67.5
#> 224                98.2             -4.2                  89  96.1      66 67.5
#> 225               101.9             -0.5                 164  95.0      48 67.5
#> 226               113.2             10.8                 335 106.8     306 67.4
#> 227                96.4             -6.0                  67  94.3      37 67.4
#> 228               105.7              3.3                 251 105.0     278 67.4
#> 229                94.6             -7.8                  48  94.1      35 67.4
#> 230               111.1              8.8                 321 109.9     331 67.4
#> 231                90.2            -12.2                   6  92.9      19 67.4
#> 232               108.1              5.7                 294 102.8     235 67.3
#> 233                85.5            -16.9                   2  89.3       3 67.3
#> 234               101.6             -0.8                 159 100.1     166 67.3
#> 235               106.7              4.3                 271 104.6     274 67.3
#> 236                90.5            -11.9                   9  91.7      13 67.3
#> 237               107.5              5.1                 284 105.8     292 67.3
#> 238               103.8              1.5                 207 105.6     290 67.2
#> 239                94.2             -8.2                  40  96.3      76 67.2
#> 240               100.2             -2.2                 127  99.2     146 67.2
#> 241               105.7              3.3                 250 104.2     267 67.1
#> 242                93.1             -9.3                  30  94.0      32 67.1
#> 243               107.0              4.6                 276 105.6     289 67.1
#> 244               100.7             -1.7                 134  97.8     110 67.1
#> 245                92.4            -10.0                  22  95.7      58 67.0
#> 246               101.3             -1.1                 153 100.2     167 67.0
#> 247               100.6             -1.8                 133 101.8     207 67.0
#> 248               104.8              2.4                 225 102.5     230 67.0
#> 249               105.8              3.4                 255 102.6     232 66.9
#> 250               109.1              6.7                 308 105.9     293 66.9
#> 251               105.5              3.1                 246 102.7     233 66.9
#> 252               109.3              6.9                 310 105.9     294 66.9
#> 253               114.4             12.0                 341 110.3     334 66.9
#> 254                96.6             -5.8                  70  96.9      90 66.8
#> 255               105.7              3.3                 252 101.9     211 66.8
#> 256               104.8              2.4                 224  97.8     109 66.8
#> 257                94.2             -8.2                  41  98.1     118 66.8
#> 258               100.9             -1.5                 139 102.9     237 66.7
#> 259               101.3             -1.1                 150 104.5     273 66.7
#> 260               100.8             -1.6                 135 103.2     243 66.7
#> 261               105.1              2.7                 236  99.4     152 66.7
#> 262               102.5              0.1                 183  97.9     112 66.6
#> 263               103.2              0.8                 193  97.7     105 66.6
#> 264               105.8              3.4                 253 103.7     254 66.6
#> 265               106.7              4.3                 269 105.6     291 66.6
#> 266                98.2             -4.2                  90  94.7      44 66.5
#> 267                96.7             -5.7                  71  96.7      85 66.5
#> 268                98.3             -4.0                  92  96.3      74 66.4
#> 269               108.5              6.2                 303 104.4     269 66.4
#> 270               101.2             -1.2                 145 100.9     186 66.4
#> 271               113.6             11.2                 338 111.4     339 66.4
#> 272               102.6              0.2                 186  99.6     154 66.3
#> 273                96.4             -6.0                  68  90.1       8 66.3
#> 274               105.5              3.1                 243 103.8     258 66.3
#> 275                94.0             -8.4                  36  98.3     121 66.2
#> 276                99.8             -2.6                 119 101.1     189 66.2
#> 277                88.1            -14.3                   4  90.1       7 66.2
#> 278               110.0              7.6                 313 108.3     322 66.2
#> 279               106.7              4.3                 270 103.9     260 66.2
#> 280                92.0            -10.3                  19  94.5      41 66.2
#> 281                96.0             -6.4                  65  95.9      62 66.1
#> 282               103.8              1.4                 205 100.2     169 66.1
#> 283               112.8             10.4                 333 109.0     327 66.1
#> 284               104.6              2.2                 223 100.8     180 66.1
#> 285               105.0              2.6                 233 102.3     224 66.1
#> 286               103.3              0.9                 194  99.7     158 66.1
#> 287               101.2             -1.1                 148  99.3     150 66.0
#> 288                93.7             -8.7                  35  97.2      98 66.0
#> 289               111.6              9.2                 325 107.9     318 66.0
#> 290                93.5             -8.9                  33  95.2      53 66.0
#> 291               103.2              0.8                 192 100.7     179 65.9
#> 292                92.6             -9.8                  24  95.6      56 65.9
#> 293               103.4              1.0                 197 102.4     228 65.9
#> 294               106.8              4.4                 273 103.1     242 65.9
#> 295               104.9              2.5                 229 103.3     246 65.9
#> 296               101.6             -0.8                 160  96.4      78 65.8
#> 297                93.6             -8.8                  34  92.8      17 65.8
#> 298                99.9             -2.5                 121  96.7      84 65.8
#> 299                99.3             -3.1                 108  97.9     113 65.8
#> 300                92.3            -10.0                  21  92.7      16 65.7
#> 301               102.2             -0.2                 174 100.8     184 65.7
#> 302               102.1             -0.3                 173  98.5     128 65.7
#> 303               106.0              3.6                 257 101.9     210 65.7
#> 304                99.8             -2.5                 120  96.3      75 65.7
#> 305               102.0             -0.4                 165 101.8     208 65.6
#> 306               105.3              2.9                 239 100.7     177 65.6
#> 307                98.0             -4.3                  84  95.8      60 65.5
#> 308                98.3             -4.1                  91  99.1     140 65.5
#> 309                98.0             -4.4                  82  98.4     126 65.5
#> 310               103.9              1.5                 209 102.4     226 65.3
#> 311                96.8             -5.6                  72  94.8      45 65.3
#> 312                98.3             -4.0                  93  96.4      77 65.2
#> 313                95.8             -6.6                  62  96.8      88 65.2
#> 314               110.3              7.9                 317 108.8     326 65.2
#> 315               100.4             -2.0                 130 103.9     261 65.2
#> 316               103.8              1.4                 203  98.2     119 65.2
#> 317               104.8              2.4                 226 103.2     244 65.1
#> 318                96.1             -6.2                  66  98.2     120 65.1
#> 319                97.1             -5.3                  76  98.3     124 65.0
#> 320               100.1             -2.3                 122  97.0      94 65.0
#> 321               104.9              2.5                 228 103.4     248 64.9
#> 322               103.7              1.4                 201 103.2     245 64.9
#> 323                99.1             -3.3                 107  97.1      97 64.9
#> 324                95.9             -6.5                  63  95.0      49 64.9
#> 325                99.4             -3.0                 112 101.1     190 64.9
#> 326                95.7             -6.7                  61  99.0     136 64.9
#> 327               103.6              1.2                 199 101.9     215 64.9
#> 328                95.9             -6.5                  64  93.7      26 64.8
#> 329               100.8             -1.6                 138  98.1     117 64.8
#> 330               101.9             -0.5                 163 100.3     170 64.8
#> 331               103.8              1.4                 202 101.7     205 64.8
#> 332                90.6            -11.8                  10  91.0      10 64.6
#> 333                90.8            -11.6                  11  94.3      39 64.6
#> 334                97.2             -5.2                  77  99.0     135 64.5
#> 335               105.3              2.9                 242 101.6     199 64.5
#> 336               106.8              4.4                 272 103.9     259 64.3
#> 337                98.6             -3.7                  99  97.3     100 64.2
#> 338               104.1              1.7                 214 105.1     280 64.2
#> 339                98.5             -3.9                  96 100.3     171 63.9
#> 340                98.2             -4.2                  87  95.8      61 63.9
#> 341                94.2             -8.1                  42  95.9      63 63.7
#> 342                91.9            -10.5                  17  96.3      73 63.7
#> 343                99.4             -2.9                 113  94.6      43 63.5
#> 344               108.3              5.9                 299 104.5     271 63.2
#> 345               107.5              5.1                 283 102.9     238 63.2
#> 346               101.6             -0.7                 161  97.7     104 63.2
#> 347                99.8             -2.6                 118  96.6      82 63.2
#> 348                98.8             -3.6                 101  95.0      50 63.2
#> 349               104.0              1.6                 211 105.2     281 63.0
#> 350               101.2             -1.2                 146  99.3     149 62.9
#> 351               106.0              3.6                 258 101.9     212 62.5
#> 352                96.4             -6.0                  69  89.8       6 61.5
#> 353                85.1            -17.3                   1  85.9       1 59.4
#>     RawO.Rk AdjD AdjD.Rk RawD RawD.Rk NCAA_Seed Year
#> 1       8.7    1    78.9    1    15.6        NA 2020
#> 2       7.7    2    77.9    2    14.8        NA 2020
#> 3       6.5    3    75.2    7    14.8        NA 2020
#> 4       6.4    4    76.1    4    15.2        NA 2020
#> 5       6.3    5    76.2    3    15.3        NA 2020
#> 6       6.1    6    75.6    6    15.8        NA 2020
#> 7       5.7    7    74.2   14    14.4        NA 2020
#> 8       5.6    8    74.6    8    14.9        NA 2020
#> 9       5.4    9    74.6    9    16.0        NA 2020
#> 10      5.4   10    74.3   13    15.9        NA 2020
#> 11      5.3   11    74.4   11    15.6        NA 2020
#> 12      5.0   12    74.4   10    15.4        NA 2020
#> 13      4.9   13    74.0   19    16.3        NA 2020
#> 14      4.9   14    73.6   23    15.8        10 2020
#> 15      4.8   15    75.9    5    15.8        NA 2020
#> 16      4.8   16    72.8   33    15.1        NA 2020
#> 17      4.7   17    72.5   37    15.3        NA 2020
#> 18      4.7   18    73.6   24    15.3        15 2020
#> 19      4.7   19    73.7   21    15.8        NA 2020
#> 20      4.6   20    74.0   18    15.6        NA 2020
#> 21      4.5   21    74.1   16    15.5        NA 2020
#> 22      4.5   22    74.4   12    16.0        NA 2020
#> 23      4.5   23    73.3   26    16.1        NA 2020
#> 24      4.4   24    73.0   30    16.2        NA 2020
#> 25      4.4   25    74.0   17    15.9        NA 2020
#> 26      4.4   26    73.3   27    16.4        NA 2020
#> 27      4.3   27    72.0   44    15.6        NA 2020
#> 28      4.2   28    73.1   29    15.6        NA 2020
#> 29      4.0   29    74.1   15    16.3        NA 2020
#> 30      3.8   30    72.5   38    15.2        NA 2020
#> 31      3.8   31    73.1   28    15.7        NA 2020
#> 32      3.8   32    71.6   57    15.8        NA 2020
#> 33      3.7   33    73.9   20    15.8        NA 2020
#> 34      3.6   34    72.8   31    16.2         3 2020
#> 35      3.6   35    72.6   36    15.2         1 2020
#> 36      3.5   36    71.7   55    15.4        16 2020
#> 37      3.5   37    72.4   39    16.7        NA 2020
#> 38      3.5   38    72.6   35    16.3        NA 2020
#> 39      3.5   39    73.7   22    16.4        12 2020
#> 40      3.4   40    71.8   50    16.4        NA 2020
#> 41      3.4   41    72.7   34    15.8        NA 2020
#> 42      3.2   42    72.8   32    15.3        NA 2020
#> 43      3.1   43    72.3   41    16.7        NA 2020
#> 44      3.0   44    72.0   45    17.1        NA 2020
#> 45      2.8   45    71.4   61    16.7        NA 2020
#> 46      2.8   46    71.9   47    16.1        NA 2020
#> 47      2.8   47    71.2   66    16.5        NA 2020
#> 48      2.8   48    73.4   25    16.0        NA 2020
#> 49      2.7   49    71.8   52    16.6        NA 2020
#> 50      2.7   50    71.7   56    16.3        NA 2020
#> 51      2.7   51    70.8   79    16.5        NA 2020
#> 52      2.6   52    71.2   68    16.7        NA 2020
#> 53      2.6   53    71.5   60    16.5        NA 2020
#> 54      2.6   54    71.4   62    16.2         6 2020
#> 55      2.5   55    71.3   64    16.6        NA 2020
#> 56      2.5   56    70.7   86    16.5        NA 2020
#> 57      2.5   57    71.8   51    15.8        NA 2020
#> 58      2.4   58    71.2   70    16.5        NA 2020
#> 59      2.4   59    71.1   71    16.7        NA 2020
#> 60      2.3   60    71.4   63    16.5         9 2020
#> 61      2.3   61    72.4   40    16.3        16 2020
#> 62      2.2   62    70.7   87    16.6        NA 2020
#> 63      2.2   63    71.7   53    15.5        NA 2020
#> 64      2.1   64    71.9   48    16.3        NA 2020
#> 65      2.1   65    72.3   42    15.7        14 2020
#> 66      2.1   66    70.5   99    15.9        NA 2020
#> 67      2.0   67    70.4  106    16.6        NA 2020
#> 68      2.0   68    71.8   49    16.1        NA 2020
#> 69      2.0   69    70.3  111    16.8        NA 2020
#> 70      2.0   70    70.6   92    17.1        NA 2020
#> 71      1.9   71    70.2  116    17.2        NA 2020
#> 72      1.9   72    70.8   78    16.2        NA 2020
#> 73      1.9   73    70.6   89    16.1        NA 2020
#> 74      1.9   74    70.9   74    16.9        NA 2020
#> 75      1.9   75    71.9   46    16.9        NA 2020
#> 76      1.9   76    71.0   72    16.8        NA 2020
#> 77      1.9   77    70.6   93    16.2         6 2020
#> 78      1.8   78    70.7   85    17.0        NA 2020
#> 79      1.8   79    70.8   81    16.6        NA 2020
#> 80      1.7   80    71.3   65    16.9        NA 2020
#> 81      1.7   81    70.9   76    16.6        NA 2020
#> 82      1.7   82    72.1   43    16.8        NA 2020
#> 83      1.7   83    69.8  124    16.9        NA 2020
#> 84      1.7   84    70.8   80    16.8         8 2020
#> 85      1.6   85    71.0   73    16.8        NA 2020
#> 86      1.6   86    70.3  110    17.1        NA 2020
#> 87      1.6   87    71.6   58    15.9        NA 2020
#> 88      1.6   88    70.5   96    17.0        NA 2020
#> 89      1.5   89    69.6  139    16.7         2 2020
#> 90      1.5   90    70.4  102    16.4        NA 2020
#> 91      1.5   91    70.4  103    17.4        NA 2020
#> 92      1.5   92    69.8  128    17.0        NA 2020
#> 93      1.4   93    70.9   75    16.9         3 2020
#> 94      1.4   94    71.7   54    16.4        NA 2020
#> 95      1.4   95    70.5   94    16.5        NA 2020
#> 96      1.4   96    70.3  113    16.1        NA 2020
#> 97      1.3   97    70.8   83    17.0        NA 2020
#> 98      1.3   98    69.7  135    16.2        10 2020
#> 99      1.2   99    71.2   67    16.6        NA 2020
#> 100     1.2  100    70.9   77    17.1        NA 2020
#> 101     1.2  101    70.6   88    17.3        11 2020
#> 102     1.2  102    70.3  112    16.6        NA 2020
#> 103     1.2  103    70.6   91    16.6        11 2020
#> 104     1.1  104    70.5   97    16.8        NA 2020
#> 105     1.1  105    70.6   90    17.3        NA 2020
#> 106     1.1  106    69.7  132    15.8        NA 2020
#> 107     1.1  107    69.8  126    16.5        NA 2020
#> 108     1.1  108    69.7  133    17.0         5 2020
#> 109     1.1  109    70.0  120    17.8        NA 2020
#> 110     1.1  110    70.1  118    16.4        13 2020
#> 111     1.1  111    69.2  161    16.7        NA 2020
#> 112     1.1  112    69.4  148    17.5         6 2020
#> 113     1.0  113    69.9  121    17.3        NA 2020
#> 114     1.0  114    69.2  168    16.6        NA 2020
#> 115     1.0  115    70.3  109    16.3         7 2020
#> 116     1.0  116    69.7  134    16.7        NA 2020
#> 117     1.0  117    70.5   95    17.6        NA 2020
#> 118     1.0  118    69.5  147    17.1        NA 2020
#> 119     0.9  119    70.4  108    17.1        NA 2020
#> 120     0.9  120    69.6  138    17.1        NA 2020
#> 121     0.9  121    70.4  104    17.1        NA 2020
#> 122     0.9  122    70.2  115    16.8        NA 2020
#> 123     0.9  123    69.2  164    16.6        NA 2020
#> 124     0.9  124    69.3  159    16.7        11 2020
#> 125     0.9  125    70.2  117    17.6        15 2020
#> 126     0.9  126    70.8   82    16.6        NA 2020
#> 127     0.9  127    70.5  100    16.4         5 2020
#> 128     0.8  128    69.3  156    17.8        NA 2020
#> 129     0.8  129    70.4  101    17.4        NA 2020
#> 130     0.8  130    69.3  157    16.6         3 2020
#> 131     0.8  131    69.7  129    17.3        NA 2020
#> 132     0.7  132    69.4  151    16.7        NA 2020
#> 133     0.7  133    69.7  131    17.0        NA 2020
#> 134     0.7  134    69.2  162    16.0        NA 2020
#> 135     0.6  135    69.4  150    17.9        NA 2020
#> 136     0.6  136    69.9  122    17.4        NA 2020
#> 137     0.6  137    71.2   69    17.3        NA 2020
#> 138     0.6  138    69.7  130    16.3        NA 2020
#> 139     0.6  139    70.0  119    16.9         9 2020
#> 140     0.5  140    69.0  175    17.5        NA 2020
#> 141     0.5  141    68.9  184    17.1        NA 2020
#> 142     0.5  142    69.0  174    16.8        NA 2020
#> 143     0.5  143    69.6  140    17.3        NA 2020
#> 144     0.5  144    69.5  143    17.0        NA 2020
#> 145     0.5  145    70.2  114    17.9        NA 2020
#> 146     0.4  146    69.6  141    16.1        NA 2020
#> 147     0.4  147    68.9  183    17.6        NA 2020
#> 148     0.4  148    68.8  186    16.9        NA 2020
#> 149     0.4  149    69.7  136    18.1        NA 2020
#> 150     0.4  150    69.4  152    17.1         6 2020
#> 151     0.4  151    70.5   98    17.0        NA 2020
#> 152     0.3  152    69.5  145    17.8        NA 2020
#> 153     0.3  153    68.1  232    17.4        NA 2020
#> 154     0.3  154    69.4  154    16.7        NA 2020
#> 155     0.3  155    69.0  176    17.0        NA 2020
#> 156     0.3  156    68.6  203    17.0        NA 2020
#> 157     0.3  157    70.4  107    17.5        NA 2020
#> 158     0.3  158    71.5   59    17.1        NA 2020
#> 159     0.3  159    68.9  181    17.9        NA 2020
#> 160     0.3  160    70.8   84    17.3        NA 2020
#> 161     0.2  161    69.2  169    18.0        NA 2020
#> 162     0.2  162    69.4  149    16.7        NA 2020
#> 163     0.2  163    69.5  146    18.1        NA 2020
#> 164     0.2  164    68.9  182    17.4        NA 2020
#> 165     0.1  165    68.4  216    16.8        NA 2020
#> 166     0.1  166    69.4  153    17.6        NA 2020
#> 167     0.1  167    69.0  179    17.5        NA 2020
#> 168     0.1  168    68.6  201    17.2        NA 2020
#> 169     0.1  169    68.2  229    16.4        NA 2020
#> 170     0.1  170    69.1  172    17.9        NA 2020
#> 171     0.1  171    69.6  142    17.3         8 2020
#> 172     0.0  172    70.4  105    17.0        NA 2020
#> 173     0.0  173    68.4  214    17.3        NA 2020
#> 174     0.0  174    68.7  199    17.7        NA 2020
#> 175     0.0  175    68.2  228    17.6        NA 2020
#> 176     0.0  176    69.5  144    17.3        NA 2020
#> 177    -0.1  177    68.7  195    17.9        NA 2020
#> 178    -0.1  178    69.8  127    16.5         2 2020
#> 179    -0.1  179    68.4  220    16.8        NA 2020
#> 180    -0.1  180    68.7  193    18.1        NA 2020
#> 181    -0.1  181    68.6  207    17.6        NA 2020
#> 182    -0.1  182    68.5  209    17.5        NA 2020
#> 183    -0.1  183    68.7  194    17.4        NA 2020
#> 184    -0.1  184    68.5  211    18.2        NA 2020
#> 185    -0.1  185    69.2  163    17.0        NA 2020
#> 186    -0.1  186    68.1  230    18.3        NA 2020
#> 187    -0.2  187    69.2  166    17.2        NA 2020
#> 188    -0.2  188    68.1  231    17.5         8 2020
#> 189    -0.2  189    69.1  171    18.2        NA 2020
#> 190    -0.2  190    69.0  177    16.8        NA 2020
#> 191    -0.3  191    69.2  167    17.7        NA 2020
#> 192    -0.3  192    69.8  125    17.5        NA 2020
#> 193    -0.3  193    69.3  160    17.2        NA 2020
#> 194    -0.3  194    67.8  241    17.3        NA 2020
#> 195    -0.3  195    68.8  189    18.1        NA 2020
#> 196    -0.3  196    68.8  191    17.4        NA 2020
#> 197    -0.4  197    68.6  204    17.8        NA 2020
#> 198    -0.4  198    67.5  254    17.8        NA 2020
#> 199    -0.4  199    68.8  185    17.0        12 2020
#> 200    -0.4  200    69.1  173    17.9        NA 2020
#> 201    -0.4  201    69.8  123    17.1        NA 2020
#> 202    -0.4  202    68.4  221    16.8        14 2020
#> 203    -0.4  203    68.7  196    16.9        NA 2020
#> 204    -0.5  204    67.3  262    17.8        NA 2020
#> 205    -0.5  205    68.9  180    16.9        NA 2020
#> 206    -0.5  206    68.7  200    17.5        10 2020
#> 207    -0.5  207    68.5  213    16.8        NA 2020
#> 208    -0.5  208    68.7  197    17.6        NA 2020
#> 209    -0.6  209    69.1  170    17.6        NA 2020
#> 210    -0.6  210    68.6  205    17.0        NA 2020
#> 211    -0.6  211    67.7  247    17.9        NA 2020
#> 212    -0.6  212    68.4  218    17.5        14 2020
#> 213    -0.6  213    69.6  137    17.5        NA 2020
#> 214    -0.6  214    68.7  198    17.2        NA 2020
#> 215    -0.7  215    68.5  212    17.4         4 2020
#> 216    -0.7  216    67.9  236    17.9        NA 2020
#> 217    -0.8  217    67.8  243    18.1        NA 2020
#> 218    -0.8  218    68.6  202    16.9        NA 2020
#> 219    -0.8  219    68.4  215    17.5        NA 2020
#> 220    -0.8  220    68.0  233    17.1         1 2020
#> 221    -0.8  221    69.3  158    17.9        NA 2020
#> 222    -0.9  222    67.9  239    18.2        NA 2020
#> 223    -0.9  223    68.8  192    18.1        NA 2020
#> 224    -0.9  224    68.4  219    17.4        NA 2020
#> 225    -0.9  225    69.3  155    17.5        NA 2020
#> 226    -0.9  226    69.2  165    18.3        NA 2020
#> 227    -0.9  227    67.9  237    18.2        12 2020
#> 228    -1.0  228    68.4  217    17.8        NA 2020
#> 229    -1.0  229    68.0  234    17.3        11 2020
#> 230    -1.0  230    67.6  250    18.3        NA 2020
#> 231    -1.0  231    67.6  253    17.4         9 2020
#> 232    -1.0  232    68.8  188    17.4        NA 2020
#> 233    -1.0  233    67.6  248    17.0         1 2020
#> 234    -1.0  234    67.8  242    17.6        NA 2020
#> 235    -1.0  235    67.7  244    18.4        NA 2020
#> 236    -1.0  236    68.3  223    17.4        10 2020
#> 237    -1.1  237    68.3  225    17.0        NA 2020
#> 238    -1.1  238    68.2  226    18.2        NA 2020
#> 239    -1.2  239    67.3  267    17.5        NA 2020
#> 240    -1.2  240    68.3  222    17.2        NA 2020
#> 241    -1.2  241    69.0  178    17.9        NA 2020
#> 242    -1.2  242    67.2  269    17.3         4 2020
#> 243    -1.3  243    68.8  190    17.8        NA 2020
#> 244    -1.3  244    67.1  271    17.4        14 2020
#> 245    -1.3  245    67.6  249    17.6         3 2020
#> 246    -1.3  246    67.4  261    17.9        NA 2020
#> 247    -1.4  247    67.3  266    18.0        NA 2020
#> 248    -1.4  248    68.2  227    18.1        NA 2020
#> 249    -1.4  249    66.6  291    18.2        NA 2020
#> 250    -1.4  250    67.9  238    17.7        NA 2020
#> 251    -1.5  251    67.5  255    17.8        NA 2020
#> 252    -1.5  252    68.5  210    17.5        NA 2020
#> 253    -1.5  253    67.0  279    18.4        NA 2020
#> 254    -1.5  254    67.7  245    17.3        NA 2020
#> 255    -1.6  255    67.3  265    17.5        NA 2020
#> 256    -1.6  256    68.5  208    18.0        NA 2020
#> 257    -1.6  257    67.3  264    17.9        NA 2020
#> 258    -1.7  258    67.4  260    18.0        NA 2020
#> 259    -1.7  259    66.7  287    17.6        NA 2020
#> 260    -1.7  260    67.6  252    18.1        NA 2020
#> 261    -1.7  261    67.2  270    17.6        16 2020
#> 262    -1.7  262    66.7  285    17.7        NA 2020
#> 263    -1.7  263    68.8  187    17.2        16 2020
#> 264    -1.8  264    66.7  283    18.9        NA 2020
#> 265    -1.8  265    67.1  273    18.2        NA 2020
#> 266    -1.8  266    67.7  246    17.7        NA 2020
#> 267    -1.9  267    67.0  277    17.7        NA 2020
#> 268    -1.9  268    67.5  257    18.2        NA 2020
#> 269    -1.9  269    68.0  235    17.9        NA 2020
#> 270    -1.9  270    66.2  305    18.4        NA 2020
#> 271    -2.0  271    67.0  275    18.7        NA 2020
#> 272    -2.0  272    66.5  299    17.9        16 2020
#> 273    -2.1  273    66.5  298    18.1        13 2020
#> 274    -2.1  274    67.1  272    18.1        NA 2020
#> 275    -2.1  275    67.6  251    18.1         2 2020
#> 276    -2.1  276    67.3  263    18.2        NA 2020
#> 277    -2.2  277    66.6  289    18.2         1 2020
#> 278    -2.2  278    66.5  301    18.0        NA 2020
#> 279    -2.2  279    66.8  281    17.9        NA 2020
#> 280    -2.2  280    66.7  286    18.1         5 2020
#> 281    -2.3  281    67.5  258    18.2        11 2020
#> 282    -2.3  282    67.1  274    17.4        16 2020
#> 283    -2.3  283    68.6  206    18.4        NA 2020
#> 284    -2.3  284    67.5  259    18.9        NA 2020
#> 285    -2.3  285    67.2  268    18.8        NA 2020
#> 286    -2.3  286    66.2  307    18.5        NA 2020
#> 287    -2.3  287    67.5  256    18.7        15 2020
#> 288    -2.3  288    67.0  278    18.6         7 2020
#> 289    -2.4  289    66.5  300    18.2        NA 2020
#> 290    -2.4  290    66.6  294    17.6        NA 2020
#> 291    -2.4  291    65.8  320    18.2        NA 2020
#> 292    -2.4  292    66.2  310    18.1        NA 2020
#> 293    -2.5  293    66.6  296    18.0        NA 2020
#> 294    -2.5  294    66.0  317    18.8        NA 2020
#> 295    -2.5  295    66.6  288    18.1        NA 2020
#> 296    -2.5  296    66.2  306    17.7        NA 2020
#> 297    -2.6  297    67.0  276    17.6        NA 2020
#> 298    -2.6  298    66.3  303    18.2        NA 2020
#> 299    -2.6  299    65.7  323    18.4        NA 2020
#> 300    -2.6  300    66.8  282    18.4         7 2020
#> 301    -2.6  301    66.2  309    18.3        NA 2020
#> 302    -2.6  302    67.0  280    18.6        NA 2020
#> 303    -2.7  303    68.3  224    18.4        NA 2020
#> 304    -2.7  304    67.9  240    18.1        15 2020
#> 305    -2.7  305    66.6  295    18.2        NA 2020
#> 306    -2.8  306    66.6  292    18.3        NA 2020
#> 307    -2.8  307    66.6  290    18.5        NA 2020
#> 308    -2.9  308    66.0  314    18.3        NA 2020
#> 309    -2.9  309    66.1  311    18.0        NA 2020
#> 310    -3.0  310    66.7  284    17.6        NA 2020
#> 311    -3.1  311    65.5  328    17.9        NA 2020
#> 312    -3.2  312    66.6  293    18.7        NA 2020
#> 313    -3.2  313    66.6  297    18.0        NA 2020
#> 314    -3.2  314    65.8  319    18.8        NA 2020
#> 315    -3.2  315    65.7  322    19.1        NA 2020
#> 316    -3.2  316    65.5  327    18.9        NA 2020
#> 317    -3.2  317    65.4  332    19.3        NA 2020
#> 318    -3.3  318    65.6  326    18.6        NA 2020
#> 319    -3.4  319    66.2  308    17.9         4 2020
#> 320    -3.4  320    65.5  331    19.0        NA 2020
#> 321    -3.4  321    65.5  330    18.8        NA 2020
#> 322    -3.4  322    66.1  313    19.2        NA 2020
#> 323    -3.4  323    65.9  318    19.3        NA 2020
#> 324    -3.5  324    65.5  329    18.5        NA 2020
#> 325    -3.5  325    66.3  302    18.6        11 2020
#> 326    -3.5  326    66.2  304    17.9         9 2020
#> 327    -3.5  327    65.6  324    18.8        NA 2020
#> 328    -3.5  328    65.2  333    18.8        NA 2020
#> 329    -3.6  329    66.1  312    18.1        NA 2020
#> 330    -3.6  330    65.6  325    18.9        NA 2020
#> 331    -3.6  331    66.0  315    18.4        NA 2020
#> 332    -3.8  332    66.0  316    17.5         2 2020
#> 333    -3.8  333    64.7  338    18.6        NA 2020
#> 334    -3.8  334    65.7  321    18.8        NA 2020
#> 335    -3.9  335    64.9  337    18.7        NA 2020
#> 336    -4.1  336    64.9  336    19.2        NA 2020
#> 337    -4.1  337    64.1  346    19.6        NA 2020
#> 338    -4.2  338    65.0  334    18.8        NA 2020
#> 339    -4.5  339    65.0  335    19.9         8 2020
#> 340    -4.5  340    64.4  341    19.5        NA 2020
#> 341    -4.6  341    64.5  339    19.7         5 2020
#> 342    -4.7  342    64.5  340    19.9         4 2020
#> 343    -4.9  343    64.3  342    19.7        13 2020
#> 344    -5.1  344    63.9  349    19.8        NA 2020
#> 345    -5.1  345    64.3  344    19.5        NA 2020
#> 346    -5.2  346    63.6  350    20.2        NA 2020
#> 347    -5.2  347    64.1  347    20.1        NA 2020
#> 348    -5.2  348    64.0  348    18.5        NA 2020
#> 349    -5.4  349    64.3  343    20.1        NA 2020
#> 350    -5.4  350    64.2  345    19.0        13 2020
#> 351    -5.9  351    62.2  351    19.9        NA 2020
#> 352    -6.9  352    61.3  352    20.6        12 2020
#> 353    -8.9  353    60.3  353    20.8         7 2020
# }
# \donttest{
try(kp_fourfactors(min_year = 2020, max_year = 2021))
#> ✖ 2026-10-26 19:18:41.006322: Invalid arguments or no four factors data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf AdjT AdjT.Rk  AdjO AdjO.Rk Off.eFG.Pct
#> 1                  Gonzaga  WCC 71.9      35 121.3       1        57.5
#> 2                   Dayton  A10 67.6     220 119.1       2        59.7
#> 3                Creighton   BE 68.3     178 118.2       3        55.2
#> 4                      LSU  SEC 70.0      84 118.1       4        52.7
#> 5                     Iowa  B10 70.2      77 117.3       5        51.6
#> 6                   Oregon  P12 65.0     319 117.1       6        54.3
#> 7                      BYU  WCC 69.5     108 116.3       7        58.1
#> 8                   Kansas  B12 67.3     233 115.8       8        53.7
#> 9                     Duke  ACC 72.0      34 115.7       9        52.6
#> 10            Michigan St.  B10 69.1     130 115.2      10        52.6
#> 11           San Diego St.  MWC 64.6     332 115.1      11        54.6
#> 12              Louisville  ACC 67.1     242 114.5      12        52.5
#> 13                Ohio St.  B10 66.2     280 114.3      13        52.3
#> 14               Marquette   BE 70.7      60 114.0      14        51.6
#> 15               Villanova   BE 66.2     275 113.9      15        52.6
#> 16            Saint Mary's  WCC 63.9     339 113.7      16        54.1
#> 17                  Baylor  B12 66.2     277 113.5      17        49.4
#> 18                Maryland  B10 67.0     245 113.5      18        48.6
#> 19         Mississippi St.  SEC 66.2     276 113.4      19        51.5
#> 20                Michigan  B10 68.7     150 113.2      20        52.8
#> 21                Syracuse  ACC 68.3     179 112.8      21        50.5
#> 22                 Houston Amer 65.7     300 112.7      22        48.0
#> 23           Northern Iowa  MVC 65.8     299 112.7      23        54.8
#> 24                Kentucky  SEC 67.7     215 112.7      24        50.7
#> 25                  Butler   BE 63.7     341 112.6      25        52.3
#> 26                Davidson  A10 64.8     330 112.5      26        53.4
#> 27                 Florida  SEC 64.9     326 112.5      27        52.1
#> 28                     SMU Amer 64.8     331 112.4      28        52.1
#> 29              Seton Hall   BE 69.8      93 112.3      29        51.4
#> 30               Minnesota  B10 66.8     257 112.1      30        49.4
#> 31           North Florida ASun 69.4     111 112.0      31        54.6
#> 32             Florida St.  ACC 69.9      89 111.7      32        51.9
#> 33                  Auburn  SEC 69.2     127 111.4      33        50.0
#> 34             North Texas CUSA 62.9     350 111.2      34        55.3
#> 35                 Arizona  P12 69.3     115 111.0      35        50.7
#> 36              Georgetown   BE 70.0      87 111.0      36        49.1
#> 37                 Alabama  SEC 74.8       4 111.0      37        52.2
#> 38                Illinois  B10 66.0     288 110.9      38        48.3
#> 39              Oregon St.  P12 65.6     305 110.9      39        51.6
#> 40               Wisconsin  B10 63.7     342 110.8      40        50.3
#> 41              Notre Dame  ACC 68.1     190 110.7      41        50.4
#> 42              N.C. State  ACC 69.5     103 110.7      42        50.9
#> 43                Penn St.  B10 70.9      54 110.3      43        49.5
#> 44                  Nevada  MWC 71.0      50 110.3      44        52.9
#> 45       Northern Colorado BSky 65.0     320 110.2      45        54.7
#> 46        South Dakota St.  Sum 68.0     201 110.0      46        55.8
#> 47              Texas Tech  B12 67.3     236 109.8      47        51.7
#> 48                Iowa St.  B12 69.9      90 109.6      48        49.8
#> 49                Utah St.  MWC 67.4     229 109.5      49        51.8
#> 50                  Purdue  B10 64.6     333 109.3      50        47.8
#> 51                    UCLA  P12 64.9     325 109.3      51        48.4
#> 52            Colorado St.  MWC 69.3     116 109.3      52        53.9
#> 53                Richmond  A10 69.3     124 109.2      53        53.4
#> 54                Colorado  P12 68.2     188 109.1      54        50.5
#> 55                Arkansas  SEC 71.2      45 109.1      55        50.9
#> 56        Western Kentucky CUSA 68.3     176 108.9      56        51.3
#> 57            Portland St. BSky 71.8      40 108.8      57        49.6
#> 58                Oklahoma  B12 69.6      98 108.8      58        48.2
#> 59              Cincinnati Amer 68.0     199 108.8      59        50.3
#> 60          Louisiana Tech CUSA 66.5     266 108.7      60        53.3
#> 61             Wake Forest  ACC 70.1      79 108.7      61        49.0
#> 62                 Hofstra  CAA 67.9     202 108.7      62        51.7
#> 63            South Dakota  Sum 70.0      85 108.6      63        54.6
#> 64             Connecticut Amer 68.5     167 108.6      64        47.8
#> 65                 Indiana  B10 67.9     206 108.5      65        49.3
#> 66                   Akron  MAC 69.4     110 108.5      66        51.7
#> 67           West Virginia  B12 69.4     112 108.3      67        46.5
#> 68           San Francisco  WCC 68.7     155 108.3      68        51.3
#> 69      East Tennessee St.   SC 66.1     281 108.2      69        53.5
#> 70            Oral Roberts  Sum 70.4      68 108.2      70        50.9
#> 71                 Georgia  SEC 70.5      64 108.2      71        50.9
#> 72                 Rutgers  B10 67.4     231 107.9      72        48.9
#> 73                    Yale  Ivy 67.4     227 107.9      73        53.8
#> 74                    UNLV  MWC 67.0     247 107.9      74        49.7
#> 75              Providence   BE 68.4     171 107.8      75        47.3
#> 76               Air Force  MWC 68.8     147 107.8      76        52.9
#> 77          North Carolina  ACC 70.4      67 107.7      77        46.4
#> 78                  Furman   SC 68.2     187 107.7      78        54.6
#> 79                Miami FL  ACC 68.3     180 107.7      79        48.8
#> 80          New Mexico St.  WAC 63.5     343 107.6      80        52.7
#> 81          St. Francis PA  NEC 68.9     138 107.6      81        51.5
#> 82      Cal St. Northridge   BW 70.3      74 107.4      82        51.6
#> 83        Western Carolina   SC 71.5      43 107.3      83        54.6
#> 84            Oklahoma St.  B12 68.4     173 107.2      84        47.8
#> 85              Pepperdine  WCC 70.8      57 107.2      85        50.0
#> 86                 Colgate  Pat 68.5     168 107.2      86        52.8
#> 87                   Siena MAAC 66.7     261 107.2      87        51.8
#> 88               Boise St.  MWC 69.1     133 107.0      88        51.1
#> 89               Princeton  Ivy 66.3     274 107.0      89        53.6
#> 90             Austin Peay  OVC 67.8     209 106.9      90        51.3
#> 91        North Dakota St.  Sum 66.0     287 106.8      91        51.9
#> 92                 Bradley  MVC 67.1     244 106.8      92        49.5
#> 93             Chattanooga   SC 67.0     248 106.6      93        52.5
#> 94                Duquesne  A10 67.8     211 106.6      94        51.2
#> 95         St. Bonaventure  A10 65.7     301 106.6      95        49.1
#> 96               Tennessee  SEC 65.2     313 106.6      96        48.8
#> 97                 Belmont  OVC 70.5      65 106.5      97        54.8
#> 98                 Vermont   AE 66.3     273 106.5      98        51.6
#> 99             Little Rock   SB 69.3     125 106.4      99        52.8
#> 100                   Utah  P12 66.7     260 106.3     100        51.3
#> 101              Texas St.   SB 65.2     312 106.3     101        48.9
#> 102                 Toledo  MAC 68.1     193 106.3     102        50.9
#> 103                 Xavier   BE 68.1     191 106.1     103        49.0
#> 104             St. John's   BE 72.9      21 106.1     104        45.9
#> 105               Kent St.  MAC 68.9     143 106.1     105        52.3
#> 106       UC Santa Barbara   BW 64.5     335 106.1     106        51.1
#> 107                Liberty ASun 61.5     352 106.1     107        54.4
#> 108            Arizona St.  P12 73.2      14 106.0     108        48.8
#> 109              Green Bay Horz 74.0       7 105.8     109        50.8
#> 110                   Rice CUSA 70.1      80 105.8     110        51.5
#> 111            Saint Louis  A10 67.6     219 105.8     111        50.1
#> 112             Washington  P12 69.8      96 105.8     112        50.4
#> 113            Indiana St.  MVC 66.4     270 105.8     113        51.7
#> 114                 Towson  CAA 65.1     317 105.7     114        48.7
#> 115            Georgia St.   SB 73.0      19 105.6     115        50.3
#> 116               Delaware  CAA 68.3     182 105.6     116        54.4
#> 117            Wichita St. Amer 69.5     101 105.6     117        47.1
#> 118                Radford BSth 64.3     336 105.6     118        52.6
#> 119                    TCU  B12 65.1     318 105.5     119        49.4
#> 120     Eastern Washington BSky 73.1      18 105.4     120        52.0
#> 121              UC Irvine   BW 67.7     212 105.4     121        51.6
#> 122         South Carolina  SEC 73.1      17 105.4     122        48.6
#> 123           Northeastern  CAA 65.9     291 105.4     123        54.9
#> 124            Cal Baptist  WAC 68.6     162 105.3     124        50.8
#> 125             New Mexico  MWC 71.8      38 105.3     125        52.2
#> 126           Rhode Island  A10 71.2      46 105.2     126        46.9
#> 127             Fresno St.  MWC 64.2     338 105.1     127        49.8
#> 128       Tennessee Martin  OVC 68.7     149 105.1     128        50.9
#> 129             Charleston  CAA 65.9     295 105.0     129        51.1
#> 130          South Alabama   SB 65.3     310 104.9     130        51.4
#> 131           Northwestern  B10 66.7     259 104.9     131        46.9
#> 132             Wright St. Horz 72.1      31 104.9     132        51.0
#> 133           Missouri St.  MVC 68.3     181 104.8     133        49.8
#> 134       Coastal Carolina   SB 72.8      26 104.8     134        50.1
#> 135                Hampton BSth 70.9      56 104.8     135        50.2
#> 136               Winthrop BSth 71.9      36 104.7     136        53.0
#> 137                Harvard  Ivy 68.8     148 104.7     137        51.2
#> 138                    VCU  A10 69.0     134 104.7     138        49.7
#> 139             Vanderbilt  SEC 69.4     109 104.7     139        50.2
#> 140               UC Davis   BW 68.0     194 104.7     140        52.3
#> 141             Valparaiso  MVC 69.3     123 104.5     141        50.7
#> 142                Wofford   SC 65.9     293 104.5     142        53.3
#> 143               Stanford  P12 68.3     183 104.4     143        53.5
#> 144           UMass Lowell   AE 70.3      72 104.4     144        51.6
#> 145                    USC  P12 68.9     139 104.3     145        49.5
#> 146          Bowling Green  MAC 70.1      81 104.3     146        47.6
#> 147          Virginia Tech  ACC 65.5     309 104.3     147        50.3
#> 148           Arkansas St.   SB 67.3     237 104.2     148        48.9
#> 149                   UTSA CUSA 72.8      24 104.2     149        48.1
#> 150               Missouri  SEC 66.5     267 104.1     150        47.0
#> 151                Buffalo  MAC 73.9       8 104.1     151        48.8
#> 152      Stephen F. Austin Slnd 71.8      39 104.1     152        53.3
#> 153                  Texas  B12 65.9     292 104.1     153        49.9
#> 154             Pittsburgh  ACC 65.5     308 104.0     154        45.1
#> 155                Clemson  ACC 66.0     290 103.9     155        50.1
#> 156                Pacific  WCC 64.9     323 103.8     156        49.5
#> 157                    FIU CUSA 72.2      30 103.7     157        51.7
#> 158            Mississippi  SEC 68.0     196 103.7     158        48.6
#> 159         Loyola Chicago  MVC 65.3     311 103.7     159        54.9
#> 160         UNC Greensboro   SC 67.8     210 103.7     160        48.8
#> 161                   Ohio  MAC 68.0     195 103.6     161        51.3
#> 162                    UCF Amer 67.8     208 103.5     162        49.4
#> 163                   Penn  Ivy 70.2      76 103.4     163        52.3
#> 164           Grand Canyon  WAC 68.0     198 103.4     164        50.7
#> 165                 DePaul   BE 70.6      63 103.4     165        47.9
#> 166      Boston University  Pat 66.3     272 103.3     166        51.3
#> 167         William & Mary  CAA 67.5     222 103.3     167        53.5
#> 168                  Tulsa Amer 65.8     297 103.2     168        49.6
#> 169                Montana BSky 68.2     185 103.2     169        52.3
#> 170         Nebraska Omaha  Sum 69.2     126 103.2     170        49.9
#> 171           Georgia Tech  ACC 70.0      88 103.1     171        49.8
#> 172            McNeese St. Slnd 69.0     137 103.0     172        54.9
#> 173         Youngstown St. Horz 66.4     269 103.0     173        47.4
#> 174          Massachusetts  A10 68.6     161 102.9     174        49.2
#> 175        Houston Baptist Slnd 76.1       2 102.9     175        50.3
#> 176            Santa Clara  WCC 71.6      42 102.6     176        52.2
#> 177             Kansas St.  B12 67.2     239 102.5     177        47.5
#> 178             Murray St.  OVC 68.9     144 102.4     178        52.7
#> 179       Northern Arizona BSky 66.6     265 102.3     179        49.7
#> 180           UT Arlington   SB 67.7     214 102.3     180        47.3
#> 181           Gardner Webb BSth 66.2     279 102.2     181        51.8
#> 182         Washington St.  P12 70.8      59 102.2     182        45.8
#> 183           North Dakota  Sum 68.9     145 102.2     183        50.5
#> 184       Georgia Southern   SB 71.8      41 102.2     184        50.2
#> 185           Sacred Heart  NEC 68.7     152 102.2     185        49.1
#> 186    Fairleigh Dickinson  NEC 68.9     142 102.1     186        51.1
#> 187       Central Michigan  MAC 73.6      11 102.0     187        47.5
#> 188               Miami OH  MAC 67.1     243 102.0     188        48.4
#> 189                  Drake  MVC 67.9     204 102.0     189        51.7
#> 190               Nebraska  B10 73.1      16 102.0     190        46.8
#> 191      Northern Kentucky Horz 65.7     304 102.0     191        49.5
#> 192                 Tulane Amer 68.7     154 101.9     192        47.8
#> 193         Saint Joseph's  A10 71.2      47 101.9     193        46.6
#> 194                   Iona MAAC 68.7     156 101.6     194        51.0
#> 195             California  P12 65.2     315 101.5     195        46.9
#> 196              Louisiana   SB 71.8      37 101.3     196        48.0
#> 197           George Mason  A10 67.0     246 101.3     197        47.6
#> 198                Cornell  Ivy 65.2     314 101.2     198        49.8
#> 199               Marshall CUSA 74.9       3 101.2     199        50.2
#> 200                Seattle  WAC 69.9      91 101.2     200        45.3
#> 201               Lipscomb ASun 68.7     153 101.2     201        50.1
#> 202               American  Pat 68.7     159 101.1     202        51.6
#> 203              Texas A&M  SEC 64.5     334 101.0     203        46.4
#> 204                  Rider MAAC 71.1      49 100.9     204        49.1
#> 205                    UAB CUSA 65.7     302 100.8     205        49.7
#> 206              Idaho St. BSky 67.4     230 100.8     206        50.0
#> 207             Quinnipiac MAAC 68.9     141 100.7     207        50.9
#> 208                   Elon  CAA 66.2     278 100.6     208        49.5
#> 209       Loyola Marymount  WCC 63.0     349 100.6     209        51.0
#> 210                Memphis Amer 72.6      28 100.6     210        49.7
#> 211              Lafayette  Pat 66.9     251 100.6     211        52.1
#> 212          Robert Morris  NEC 66.1     282 100.5     212        51.4
#> 213              Loyola MD  Pat 71.0      52 100.4     213        52.7
#> 214          South Florida Amer 64.9     324 100.2     214        46.6
#> 215                    VMI   SC 67.9     203 100.2     215        50.4
#> 216                 Mercer   SC 68.1     192 100.1     216        51.0
#> 217                 Temple Amer 70.3      73 100.1     217        46.0
#> 218                Niagara MAAC 66.0     289 100.1     218        49.7
#> 219                 Drexel  CAA 67.3     235 100.0     219        50.5
#> 220        Appalachian St.   SB 67.2     240  99.9     220        48.4
#> 221                Detroit Horz 69.3     117  99.9     221        46.2
#> 222      Northern Illinois  MAC 64.8     329  99.8     222        47.2
#> 223           Nicholls St. Slnd 68.7     158  99.7     223        49.5
#> 224             Binghamton   AE 68.6     164  99.7     224        47.9
#> 225       Florida Atlantic CUSA 68.8     146  99.7     225        48.5
#> 226               La Salle  A10 69.1     131  99.6     226        48.4
#> 227          East Carolina Amer 70.6      62  99.6     227        46.7
#> 228         Boston College  ACC 69.3     120  99.6     228        46.5
#> 229        Sam Houston St. Slnd 71.1      48  99.5     229        50.7
#> 230          James Madison  CAA 72.1      32  99.5     230        48.2
#> 231                  IUPUI Horz 70.8      58  99.4     231        47.9
#> 232       Western Michigan  MAC 67.4     228  99.4     232        48.2
#> 233            New Orleans Slnd 69.8      94  99.3     233        48.4
#> 234               Virginia  ACC 59.4     353  99.3     234        46.9
#> 235               Ball St.  MAC 68.0     200  99.2     235        50.4
#> 236      George Washington  A10 66.6     264  99.2     236        49.0
#> 237         Texas Southern SWAC 72.9      22  99.1     237        45.9
#> 238               Monmouth MAAC 72.6      27  99.1     238        47.1
#> 239      Abilene Christian Slnd 68.4     172  99.1     239        49.6
#> 240          Southern Utah BSky 69.3     118  98.8     240        48.7
#> 241              Weber St. BSky 67.6     216  98.8     241        48.7
#> 242                   Army  Pat 69.5     106  98.8     242        52.9
#> 243          UNC Asheville BSth 71.0      51  98.7     243        52.5
#> 244   UT Rio Grande Valley  WAC 70.4      66  98.7     244        46.8
#> 245                Samford   SC 72.8      25  98.6     245        48.0
#> 246                Oakland Horz 66.1     285  98.6     246        48.1
#> 247              Charlotte CUSA 65.5     307  98.5     247        51.6
#> 248           Illinois St.  MVC 68.5     169  98.4     248        49.9
#> 249           Old Dominion CUSA 66.4     268  98.3     249        45.3
#> 250       Western Illinois  Sum 71.3      44  98.3     250        48.5
#> 251       Northwestern St. Slnd 72.4      29  98.3     251        49.7
#> 252      Southern Illinois  MVC 64.2     337  98.2     252        49.5
#> 253       Eastern Illinois  OVC 69.1     129  98.2     253        50.5
#> 254                   Navy  Pat 62.5     351  98.1     254        46.1
#> 255                Stetson ASun 63.2     344  98.1     255        49.6
#> 256       Central Arkansas Slnd 73.2      15  98.0     256        48.5
#> 257                 Bryant  NEC 70.3      71  97.8     257        47.9
#> 258                   UMBC   AE 66.8     255  97.8     258        48.3
#> 259               Canisius MAAC 70.0      86  97.7     259        48.5
#> 260            Stony Brook   AE 69.8      92  97.7     260        47.7
#> 261                 Hawaii   BW 68.4     170  97.6     261        48.8
#> 262           San Jose St.  MWC 73.3      13  97.5     262        45.2
#> 263                   UMKC  WAC 64.9     327  97.5     263        50.5
#> 264       Middle Tennessee CUSA 69.8      95  97.5     264        47.5
#> 265                    LIU  NEC 72.8      23  97.4     265        51.4
#> 266                 Wagner  NEC 67.5     223  97.3     266        46.5
#> 267               Southern SWAC 66.8     256  97.2     267        47.9
#> 268         Sacramento St. BSky 63.9     340  97.1     268        45.4
#> 269                 Lehigh  Pat 68.4     174  97.0     269        49.7
#> 270            Montana St. BSky 67.3     234  97.0     270        49.0
#> 271             Alcorn St. SWAC 70.1      82  96.9     271        47.3
#> 272           Presbyterian BSth 66.9     253  96.9     272        50.2
#> 273                   UTEP CUSA 67.5     224  96.9     273        47.3
#> 274             Evansville  MVC 67.6     217  96.9     274        48.6
#> 275               Campbell BSth 65.6     306  96.8     275        52.6
#> 276              Dartmouth  Ivy 65.8     298  96.7     276        49.6
#> 277            Utah Valley  WAC 70.4      69  96.5     277        49.2
#> 278                  Brown  Ivy 69.4     113  96.4     278        44.9
#> 279          Tennessee St.  OVC 69.3     121  96.4     279        53.0
#> 280       Illinois Chicago Horz 69.5     105  96.4     280        50.8
#> 281       Mount St. Mary's  NEC 63.2     345  96.4     281        46.2
#> 282       Prairie View A&M SWAC 70.7      61  96.3     282        47.4
#> 283                  Lamar Slnd 69.6      99  96.3     283        48.0
#> 284                   Troy   SB 69.3     119  96.2     284        46.1
#> 285               Bucknell  Pat 69.5     107  96.2     285        49.3
#> 286    Cal St. Bakersfield  WAC 64.9     321  96.2     286        46.5
#> 287       Louisiana Monroe   SB 64.9     322  96.1     287        47.7
#> 288              Milwaukee Horz 69.5     102  96.0     288        46.8
#> 289          North Alabama ASun 70.1      83  96.0     289        47.9
#> 290           Jacksonville ASun 66.6     262  96.0     290        48.0
#> 291             Holy Cross  Pat 68.3     177  95.9     291        49.3
#> 292      Cal St. Fullerton   BW 69.3     114  95.9     292        47.7
#> 293       Jacksonville St.  OVC 68.1     189  95.8     293        48.7
#> 294           UC Riverside   BW 63.2     347  95.8     294        49.8
#> 295            USC Upstate BSth 69.2     128  95.5     295        47.4
#> 296    Charleston Southern BSth 66.9     250  95.4     296        48.4
#> 297       Eastern Kentucky  OVC 74.5       6  95.4     297        46.5
#> 298        Bethune Cookman MEAC 73.0      20  95.4     298        46.4
#> 299      Purdue Fort Wayne  Sum 67.9     205  95.4     299        49.4
#> 300          Saint Peter's MAAC 68.0     197  95.4     300        46.0
#> 301               Cal Poly   BW 68.3     175  95.2     301        47.3
#> 302               Columbia  Ivy 69.1     132  95.2     302        46.1
#> 303                 Denver  Sum 70.9      53  95.0     303        49.1
#> 304          New Hampshire   AE 68.6     163  95.0     304        46.8
#> 305            The Citadel   SC 73.7      10  94.9     305        49.7
#> 306     South Carolina St. MEAC 67.4     226  94.9     306        46.1
#> 307                   NJIT ASun 66.9     249  94.7     307        45.3
#> 308         St. Francis NY  NEC 70.3      70  94.6     308        46.4
#> 309           Morehead St.  OVC 67.3     232  94.6     309        47.2
#> 310             High Point BSth 66.4     271  94.5     310        45.7
#> 311            Florida A&M MEAC 68.6     160  94.4     311        45.4
#> 312               Hartford   AE 68.2     184  94.4     312        48.6
#> 313          Southern Miss CUSA 67.2     238  94.4     313        47.8
#> 314               Portland  WCC 69.3     122  94.4     314        48.6
#> 315              San Diego  WCC 70.2      78  94.4     315        45.9
#> 316                 Albany   AE 68.5     166  94.3     316        48.0
#> 317 Texas A&M Corpus Chris Slnd 65.7     303  94.3     317        51.5
#> 318       Eastern Michigan  MAC 66.8     254  94.2     318        46.2
#> 319 North Carolina Central MEAC 66.6     263  94.2     319        50.2
#> 320         Long Beach St.   BW 70.9      55  94.2     320        48.2
#> 321            Norfolk St. MEAC 67.5     225  94.2     321        47.0
#> 322                Wyoming  MWC 66.7     258  94.1     322        48.0
#> 323           Delaware St. MEAC 74.7       5  94.1     323        47.0
#> 324 Southeast Missouri St.  OVC 67.6     218  94.0     324        47.0
#> 325              Merrimack  NEC 63.2     348  93.9     325        48.5
#> 326                 Howard MEAC 70.2      75  93.6     326        48.2
#> 327             Morgan St. MEAC 69.6     100  93.2     327        45.9
#> 328          Grambling St. SWAC 68.7     151  93.1     328        47.6
#> 329          Cleveland St. Horz 67.1     241  92.9     329        44.5
#> 330                  Maine   AE 65.9     294  92.9     330        46.3
#> 331              Manhattan MAAC 65.8     296  92.8     331        45.7
#> 332                  Idaho BSky 68.9     140  92.8     332        47.6
#> 333            Jackson St. SWAC 68.7     157  92.8     333        45.2
#> 334         Tennessee Tech  OVC 66.9     252  92.5     334        47.6
#> 335     North Carolina A&T MEAC 73.7       9  92.3     335        47.1
#> 336       SIU Edwardsville  OVC 69.0     136  92.3     336        46.9
#> 337         UNC Wilmington  CAA 68.5     165  92.1     337        45.8
#> 338 Southeastern Louisiana Slnd 72.1      33  92.0     338        46.8
#> 339               Longwood BSth 67.8     207  91.3     339        48.1
#> 340     Florida Gulf Coast ASun 66.1     286  91.2     340        47.2
#> 341         Incarnate Word Slnd 66.1     283  90.3     341        45.7
#> 342    Central Connecticut  NEC 69.5     104  90.3     342        44.7
#> 343                 Marist MAAC 65.2     316  90.2     343        45.9
#> 344              Fairfield MAAC 63.2     346  90.1     344        43.1
#> 345 Mississippi Valley St. SWAC 77.1       1  89.8     345        43.0
#> 346             Coppin St. MEAC 73.4      12  89.6     346        45.9
#> 347                Fordham  A10 64.8     328  89.1     347        45.0
#> 348            Alabama A&M SWAC 67.7     213  87.9     348        42.4
#> 349            Chicago St.  WAC 69.0     135  86.9     349        45.5
#> 350            Alabama St. SWAC 69.7      97  86.2     350        44.6
#> 351           Kennesaw St. ASun 68.2     186  83.5     351        39.3
#> 352 Maryland Eastern Shore MEAC 67.5     221  81.7     352        40.5
#> 353    Arkansas Pine Bluff SWAC 66.1     284  79.0     353        43.1
#>     Off.eFG.Pct.Rk Off.TO.Pct Off.TO.Pct.Rk Off.OR.Pct Off.OR.Pct.Rk Off.FTRate
#> 1                3       15.3            12       33.6            30       38.8
#> 2                1       18.0           109       26.4           225       33.9
#> 3                6       15.9            25       23.9           295       28.8
#> 4               43       17.6            83       35.1            15       35.4
#> 5               82       17.1            60       32.0            52       34.4
#> 6               20       17.5            79       32.7            39       28.9
#> 7                2       15.5            16       20.6           344       23.4
#> 8               24       18.7           166       32.6            41       35.8
#> 9               50       17.8            95       34.8            17       35.6
#> 10              47       18.1           116       32.8            37       30.8
#> 11              14       16.2            32       28.2           166       28.3
#> 12              53       17.9           105       32.0            55       32.2
#> 13              59       19.1           197       31.1            75       36.7
#> 14              86       18.8           176       30.0           113       39.2
#> 15              46       16.0            29       25.8           247       26.9
#> 16              21       14.9             6       25.2           266       30.8
#> 17             188       17.8            97       35.7             8       30.8
#> 18             217       16.7            49       31.5            66       37.7
#> 19              87       20.6           292       37.0             4       39.5
#> 20              40       15.3            11       25.0           273       26.7
#> 21             128       16.5            40       29.6           121       35.7
#> 22             249       17.8            90       38.7             2       32.9
#> 23              11       18.6           158       28.9           145       27.6
#> 24             123       18.1           122       30.8            81       40.8
#> 25              58       17.3            70       29.4           127       29.4
#> 26              29       16.5            42       24.6           285       31.5
#> 27              63       17.8            94       31.1            74       34.0
#> 28              65       19.8           243       34.1            23       31.7
#> 29              91       18.6           159       29.2           133       34.8
#> 30             186       16.7            48       31.3            70       27.5
#> 31              13       17.3            67       26.9           206       28.6
#> 32              68       18.9           187       33.5            31       30.1
#> 33             152       17.9            98       35.3            13       43.8
#> 34               5       20.5           284       29.3           130       29.4
#> 35             121       16.7            47       30.7            85       36.7
#> 36             199       18.9           190       32.5            42       33.9
#> 37              61       19.2           206       29.9           114       36.8
#> 38             235       17.9           102       35.6            11       32.2
#> 39              80       17.3            72       26.5           224       38.8
#> 40             138       15.4            13       24.1           291       26.9
#> 41             132       14.2             3       26.9           207       25.0
#> 42             113       16.9            53       28.7           149       28.5
#> 43             177       15.7            20       29.2           134       31.0
#> 44              37       16.7            50       25.2           263       28.3
#> 45              12       15.4            14       25.0           274       25.3
#> 46               4       18.4           141       28.2           162       32.3
#> 47              77       19.7           237       28.0           172       34.5
#> 48             158       18.7           167       29.2           131       28.5
#> 49              70       18.2           130       30.7            88       36.3
#> 50             261       17.4            73       34.9            16       25.8
#> 51             230       19.5           224       34.5            20       37.6
#> 52              22       18.6           157       26.3           229       39.2
#> 53              30       15.6            17       22.6           321       27.8
#> 54             129       19.2           208       30.3           101       36.2
#> 55             112       15.9            24       21.5           333       42.5
#> 56             100       17.7            88       25.5           258       39.6
#> 57             175       17.7            86       35.9             6       30.8
#> 58             237       16.0            26       23.3           306       31.2
#> 59             140       20.2           263       32.0            54       39.6
#> 60              33       18.5           148       30.2           105       29.3
#> 61             200       19.7           238       28.6           153       41.0
#> 62              73       16.5            41       29.8           116       34.3
#> 63              15       15.1             7       19.2           351       40.8
#> 64             259       19.9           249       34.1            25       34.6
#> 65             191       18.3           135       32.4            44       39.2
#> 66              72       17.9           108       27.4           195       35.5
#> 67             308       20.7           297       40.1             1       40.5
#> 68              97       17.3            71       29.0           137       29.4
#> 69              28       18.2           128       31.8            59       36.9
#> 70             114       13.9             2       29.0           138       28.2
#> 71             116       20.1           255       31.6            64       33.6
#> 72             204       17.9           104       32.0            53       29.1
#> 73              23       18.5           153       25.8           245       31.2
#> 74             169       19.3           217       34.0            26       34.1
#> 75             278       19.3           212       33.7            29       35.9
#> 76              38       18.1           117       22.5           322       35.0
#> 77             309       18.1           119       35.3            12       33.5
#> 78              16       16.6            46       23.5           302       31.6
#> 79             211       17.2            61       26.0           236       28.1
#> 80              45       20.6           290       34.5            21       31.9
#> 81              90       17.5            78       32.7            40       32.6
#> 82              79       16.3            34       25.2           267       30.4
#> 83              17       19.8           240       28.4           159       38.4
#> 84             260       19.5           222       29.5           123       35.2
#> 85             151       17.4            77       26.9           209       33.0
#> 86              41       15.7            21       27.9           173       24.8
#> 87              71       19.2           204       31.9            58       36.3
#> 88             104       17.8            89       25.5           256       36.0
#> 89              25       18.3           133       24.6           282       27.8
#> 90              99       18.4           139       32.9            35       37.3
#> 91              67       14.7             5       22.4           324       33.3
#> 92             182       17.3            68       31.5            65       32.2
#> 93              52       17.5            80       25.9           238       29.2
#> 94             102       18.5           146       29.5           122       32.8
#> 95             197       17.4            76       30.9            80       27.2
#> 96             207       20.5           280       30.5            96       37.2
#> 97              10       16.0            27       24.7           278       22.9
#> 98              78       17.2            63       27.5           187       31.3
#> 99              39       22.1           333       30.1           106       45.3
#> 100             95       19.7           236       29.0           139       35.8
#> 101            206       16.6            44       29.6           120       35.2
#> 102            111       17.6            82       27.8           180       36.7
#> 103            202       19.8           241       32.2            47       30.9
#> 104            323       15.1             9       30.2           102       29.9
#> 105             57       18.4           144       30.0           111       28.9
#> 106            103       18.3           134       31.3            68       37.2
#> 107             19       15.2            10       23.9           294       32.0
#> 108            209       17.9           101       26.5           223       32.4
#> 109            119       16.2            31       25.8           242       31.6
#> 110             89       18.8           174       24.6           284       34.4
#> 111            147       18.8           168       34.2            22       39.8
#> 112            135       21.3           314       27.4           192       37.9
#> 113             76       16.9            57       23.6           298       32.3
#> 114            216       18.1           123       32.4            45       34.9
#> 115            136       18.9           191       30.9            79       31.3
#> 116             18       18.6           160       23.8           296       32.3
#> 117            285       17.9           106       31.7            62       33.7
#> 118             49       16.4            38       30.4           100       32.5
#> 119            187       21.5           320       32.2            48       27.1
#> 120             66       17.7            85       27.3           199       29.6
#> 121             84       20.2           262       34.1            24       28.0
#> 122            218       18.1           118       32.1            51       36.8
#> 123              8       18.0           110       24.4           289       25.6
#> 124            120       17.8            93       31.0            77       35.3
#> 125             60       19.5           226       27.9           174       37.2
#> 126            294       16.4            36       30.4            99       37.1
#> 127            160       19.4           218       30.5            97       29.5
#> 128            117       18.5           150       30.4            98       32.5
#> 129            105       16.3            33       22.7           319       32.3
#> 130             92       18.3           137       25.5           255       40.6
#> 131            293       15.6            18       22.0           329       25.8
#> 132            107       16.6            45       31.9            56       37.8
#> 133            159       19.7           235       31.9            57       28.8
#> 134            148       21.9           328       35.9             7       34.7
#> 135            145       15.7            19       27.4           193       41.0
#> 136             35       19.1           196       34.8            18       36.3
#> 137            101       19.7           234       30.0           110       32.6
#> 138            170       17.8            96       27.5           190       33.0
#> 139            144       18.4           145       25.4           259       41.4
#> 140             56       18.8           178       22.9           313       31.8
#> 141            125       18.2           125       26.1           233       26.8
#> 142             32       17.9           103       25.2           265       25.7
#> 143             27       20.7           298       22.1           328       31.0
#> 144             81       18.9           188       27.6           185       38.2
#> 145            181       20.4           277       30.6            91       35.4
#> 146            268       15.1             8       28.2           163       28.1
#> 147            139       14.6             4       21.0           340       22.9
#> 148            205       19.0           194       28.9           141       48.1
#> 149            241       17.0            59       26.7           214       26.4
#> 150            287       20.9           302       31.4            67       35.7
#> 151            210       18.3           138       34.7            19       27.4
#> 152             31       23.6           349       37.3             3       44.0
#> 153            154       20.5           278       26.6           218       22.0
#> 154            342       18.4           140       32.8            38       35.1
#> 155            149       18.5           149       23.3           307       28.9
#> 156            179       18.2           126       33.0            33       34.0
#> 157             75       20.4           273       30.2           104       29.3
#> 158            221       18.9           183       26.4           226       36.8
#> 159              9       19.4           220       21.4           335       38.9
#> 160            208       16.5            43       33.0            34       24.9
#> 161             96       18.7           163       26.6           219       29.6
#> 162            189       19.9           251       28.8           146       30.9
#> 163             54       17.3            69       22.7           320       24.6
#> 164            122       16.9            54       23.2           308       37.5
#> 165            254       20.4           272       31.3            71       33.3
#> 166             98       16.9            56       29.4           125       27.3
#> 167             26       18.8           170       24.6           281       30.6
#> 168            176       19.7           239       26.3           230       39.8
#> 169             55       16.9            51       20.1           347       26.1
#> 170            156       17.0            58       27.2           202       27.6
#> 171            157       22.9           345       29.2           135       34.8
#> 172              7       22.7           342       30.1           108       35.7
#> 173            274       17.8            91       35.6             9       30.0
#> 174            193       18.8           179       25.8           243       29.9
#> 175            137       21.4           318       32.1            50       38.0
#> 176             62       18.7           164       21.2           338       35.9
#> 177            270       21.2           312       29.6           118       34.7
#> 178             42       19.9           248       28.9           144       40.1
#> 179            163       17.2            62       26.8           211       31.3
#> 180            280       16.1            30       26.5           222       29.0
#> 181             69       18.1           124       27.4           194       34.8
#> 182            330       17.2            64       27.8           179       30.7
#> 183            127       19.0           193       24.7           279       36.7
#> 184            141       18.3           136       26.0           237       36.2
#> 185            196       20.4           274       36.1             5       34.8
#> 186            106       18.5           155       26.5           221       29.8
#> 187            271       17.7            87       27.5           189       33.7
#> 188            229       16.4            37       25.1           272       26.9
#> 189             74       19.2           205       23.5           301       30.4
#> 190            297       16.0            28       22.3           327       29.0
#> 191            184       18.0           113       29.7           117       33.4
#> 192            258       16.9            55       22.3           326       34.2
#> 193            303       18.2           131       26.3           231       29.1
#> 194            108       20.5           279       25.1           270       33.7
#> 195            295       19.2           210       25.1           271       36.0
#> 196            248       19.1           198       28.6           152       35.0
#> 197            266       20.1           256       33.1            32       34.4
#> 198            161       17.9            99       24.5           287       26.8
#> 199            142       19.3           213       27.9           177       28.6
#> 200            339       13.6             1       26.8           212       34.8
#> 201            150       18.9           184       26.6           220       28.7
#> 202             85       17.9           100       26.7           216       28.6
#> 203            311       21.3           316       31.3            69       41.1
#> 204            198       19.6           232       30.6            93       40.8
#> 205            168       22.2           334       31.8            60       35.1
#> 206            152       20.3           269       29.2           136       35.7
#> 207            115       19.9           250       27.0           205       28.2
#> 208            180       17.3            66       22.8           316       28.0
#> 209            110       21.9           329       27.3           197       34.8
#> 210            164       22.3           338       30.0           112       39.9
#> 211             64       17.8            92       23.4           304       23.8
#> 212             94       18.7           165       28.2           161       26.0
#> 213             44       19.1           200       25.7           250       42.5
#> 214            302       22.2           335       32.4            43       37.5
#> 215            133       18.5           151       26.8           210       21.8
#> 216            109       21.0           308       30.5            95       26.5
#> 217            322       18.1           121       25.9           240       33.3
#> 218            167       15.8            22       17.7           352       24.4
#> 219            130       21.4           319       29.8           115       28.8
#> 220            233       19.5           223       26.9           208       41.2
#> 221            315       19.1           203       30.8            82       32.1
#> 222            283       18.0           112       30.5            94       27.4
#> 223            178       19.3           216       29.4           126       25.8
#> 224            256       17.7            84       25.7           249       22.5
#> 225            224       18.8           172       28.7           151       26.9
#> 226            232       20.8           301       28.9           143       33.1
#> 227            301       19.3           211       27.3           200       36.8
#> 228            307       19.6           230       25.4           261       29.1
#> 229            124       18.8           175       27.3           198       32.1
#> 230            236       17.2            65       25.8           246       37.2
#> 231            253       18.8           169       28.7           150       32.2
#> 232            239       18.8           180       24.8           277       35.4
#> 233            231       20.3           267       27.6           186       40.3
#> 234            291       20.1           257       26.4           228       26.6
#> 235            134       19.5           225       25.5           254       30.9
#> 236            201       19.4           219       23.0           311       32.8
#> 237            328       21.0           306       31.8            61       41.1
#> 238            284       17.6            81       25.5           257       35.6
#> 239            174       20.6           288       28.8           147       41.1
#> 240            215       19.2           207       27.3           196       35.9
#> 241            213       17.4            75       21.4           334       26.5
#> 242             36       16.9            52       20.2           346       25.7
#> 243             51       16.4            39       23.0           312       35.2
#> 244            298       18.0           111       27.6           183       35.1
#> 245            247       20.8           300       28.3           160       34.9
#> 246            243       19.9           254       28.5           155       37.4
#> 247             83       20.6           291       21.5           332       38.0
#> 248            155       21.0           307       25.2           264       25.2
#> 249            337       18.1           115       30.8            83       28.8
#> 250            225       15.5            15       21.2           339       21.7
#> 251            166       21.6           322       30.7            84       33.9
#> 252            183       19.4           221       20.6           345       33.6
#> 253            131       17.4            74       28.2           164       29.4
#> 254            317       18.8           182       33.8            28       32.1
#> 255            172       21.8           326       30.6            92       39.1
#> 256            223       23.0           346       28.8           148       39.9
#> 257            252       20.5           286       31.0            78       31.0
#> 258            234       18.5           147       25.6           253       33.7
#> 259            226       20.4           271       28.9           140       30.2
#> 260            262       20.7           294       28.4           156       33.3
#> 261            212       18.6           162       27.6           184       32.2
#> 262            341       18.5           154       24.5           286       34.1
#> 263            126       19.8           244       24.0           293       30.3
#> 264            272       20.5           283       27.1           203       30.6
#> 265             93       19.0           192       21.6           331       33.4
#> 266            306       19.6           231       30.1           109       29.6
#> 267            255       20.3           266       31.6            63       34.5
#> 268            335       19.1           202       32.2            49       32.1
#> 269            165       19.9           253       25.7           248       26.1
#> 270            203       20.6           293       22.4           325       38.4
#> 271            279       20.6           287       27.7           181       31.1
#> 272            146       21.9           327       26.4           227       35.7
#> 273            277       19.6           229       23.3           305       33.0
#> 274            219       18.4           142       19.9           349       32.4
#> 275             48       19.2           209       21.9           330       25.3
#> 276            173       18.9           189       21.3           337       27.4
#> 277            194       19.8           247       23.7           297       34.1
#> 278            344       21.2           313       32.8            36       32.4
#> 279             34       24.7           350       30.7            86       32.0
#> 280            118       22.5           339       27.7           182       29.4
#> 281            314       17.9           107       29.3           129       32.6
#> 282            275       20.2           264       27.9           175       40.5
#> 283            250       20.2           261       28.9           142       34.9
#> 284            319       19.9           252       29.5           124       29.2
#> 285            190       19.0           195       24.4           288       28.4
#> 286            305       20.8           299       35.2            14       30.7
#> 287            263       20.5           285       25.6           252       32.2
#> 288            296       18.8           181       29.2           132       30.4
#> 289            251       21.4           317       28.0           171       39.7
#> 290            246       20.3           270       29.4           128       30.1
#> 291            192       20.5           281       25.3           262       24.6
#> 292            264       18.5           152       22.8           317       37.6
#> 293            214       20.7           295       31.0            76       29.1
#> 294            162       20.5           282       26.8           213       27.5
#> 295            273       18.0           114       25.1           269       34.2
#> 296            228       18.8           173       22.8           318       25.3
#> 297            304       18.8           177       24.9           276       32.5
#> 298            310       20.1           258       29.6           119       37.4
#> 299            185       20.3           265       28.4           157       24.5
#> 300            321       23.4           348       35.6            10       38.0
#> 301            276       19.1           199       22.8           314       33.7
#> 302            320       15.9            23       20.1           348       22.5
#> 303            195       19.3           215       20.8           342       36.3
#> 304            300       18.4           143       28.2           167       25.8
#> 305            171       20.1           259       20.8           341       30.9
#> 306            318       20.4           276       30.6            89       39.3
#> 307            338       16.4            35       25.1           268       31.1
#> 308            312       18.2           127       27.2           201       27.2
#> 309            281       18.1           120       27.9           176       31.5
#> 310            332       21.6           321       31.2            73       40.5
#> 311            336       21.2           311       31.2            72       38.7
#> 312            220       19.6           227       22.8           315       30.3
#> 313            257       22.0           332       26.7           215       23.5
#> 314            222       19.8           246       19.3           350       33.5
#> 315            327       20.2           260       24.7           280       31.4
#> 316            244       19.6           233       24.2           290       33.7
#> 317             88       26.6           353       30.6            90       33.4
#> 318            316       21.7           325       25.4           260       42.4
#> 319            143       22.8           343       28.4           158       35.6
#> 320            240       22.0           331       24.6           283       33.2
#> 321            289       20.9           304       30.7            87       33.3
#> 322            245       18.6           156       14.2           353       30.5
#> 323            290       19.8           245       26.0           234       33.5
#> 324            288       19.6           228       25.9           241       34.3
#> 325            227       18.6           161       23.0           309       25.9
#> 326            238       20.7           296       25.7           251       33.1
#> 327            325       22.6           341       33.8            27       40.8
#> 328            267       20.3           268       28.1           169       38.8
#> 329            347       22.2           336       32.2            46       38.7
#> 330            313       22.9           344       28.2           165       26.8
#> 331            331       20.9           303       30.1           107       34.1
#> 332            265       21.0           309       24.0           292       30.5
#> 333            340       18.2           132       26.6           217       35.6
#> 334            269       21.6           323       28.1           168       21.9
#> 335            286       20.6           289       28.5           154       41.4
#> 336            292       19.8           242       27.5           188       30.1
#> 337            329       18.9           186       23.0           310       32.4
#> 338            299       22.2           337       28.0           170       31.4
#> 339            242       19.3           214       22.4           323       32.6
#> 340            282       23.3           347       27.8           178       23.0
#> 341            333       21.9           330       27.5           191       31.1
#> 342            345       20.4           275       23.4           303       29.3
#> 343            324       20.9           305       25.9           239       29.7
#> 344            348       21.3           315       30.2           103       35.9
#> 345            350       18.2           129       23.5           300       22.9
#> 346            326       19.1           201       23.6           299       32.7
#> 347            343       18.9           185       21.4           336       27.0
#> 348            351       18.8           171       24.9           275       32.7
#> 349            334       26.5           352       20.6           343       42.2
#> 350            346       22.6           340       26.0           235       35.7
#> 351            353       21.6           324       25.8           243       32.5
#> 352            352       21.1           310       26.2           232       25.7
#> 353            349       26.2           351       27.1           204       37.4
#>     Off.FTRate.Rk  AdjD AdjD.Rk Def.eFG.Pct Def.eFG.Pct.Rk Def.TO.Pct
#> 1              43  94.4      43        47.6             88       18.4
#> 2             143  94.1      38        46.6             53       18.7
#> 3             274  97.3      78        48.4            122       17.6
#> 4             102 102.4     179        49.4            172       16.6
#> 5             128  98.6      97        49.4            171       17.6
#> 6             272  97.1      76        47.3             79       19.8
#> 7             343  95.6      60        49.0            143       18.2
#> 8              89  85.5       2        43.7              4       18.6
#> 9              99  91.1      12        45.7             26       20.2
#> 10            226  91.2      13        43.3              3       15.8
#> 11            284  90.6      10        45.3             18       21.2
#> 12            193  93.1      30        45.1             14       17.4
#> 13             73  92.0      19        46.2             35       18.3
#> 14             37  96.9      73        46.8             57       15.1
#> 15            309  94.0      36        48.2            114       16.9
#> 16            229  98.5      96        50.8            243       17.7
#> 17            228  88.1       4        45.2             15       22.7
#> 18             54  92.4      22        46.1             34       17.3
#> 19             34  99.8     119        48.1            107       17.1
#> 20            313  93.0      28        46.9             62       16.1
#> 21             93  99.6     116        48.3            116       20.3
#> 22            169  92.3      21        43.9              5       18.2
#> 23            295  99.3     108        48.5            123       15.6
#> 24             18  95.1      52        45.3             19       17.3
#> 25            254  94.2      42        45.8             27       17.9
#> 26            207 101.9     163        49.3            165       17.3
#> 27            139  95.7      61        47.9            102       19.2
#> 28            204 103.8     202        49.2            157       18.7
#> 29            117  92.7      25        45.7             23       19.5
#> 30            296  94.2      41        45.6             22       15.8
#> 31            279 111.6     324        50.3            223       15.7
#> 32            242  91.5      15        47.0             67       23.7
#> 33              4  95.5      55        47.1             70       18.7
#> 34            258 101.2     146        49.8            195       20.7
#> 35             76  91.4      14        45.3             17       20.6
#> 36            141 100.2     125        50.8            241       18.8
#> 37             69  99.5     114        47.9             99       18.2
#> 38            191  93.7      35        47.0             66       16.6
#> 39             42 102.0     165        49.4            169       18.6
#> 40            307  91.9      17        46.4             48       16.9
#> 41            334  98.6     100        47.5             85       16.8
#> 42            282  97.3      79        47.8             97       20.1
#> 43            221  92.4      23        46.4             42       18.6
#> 44            285 101.0     141        46.9             64       15.2
#> 45            332 100.1     122        48.5            126       16.8
#> 46            188 105.3     241        48.1            108       15.3
#> 47            127  90.5       9        46.2             37       23.0
#> 48            281 101.2     147        51.8            282       20.6
#> 49             77  94.6      48        46.4             45       17.5
#> 50            323  90.8      11        47.1             69       20.4
#> 51             56  99.4     112        50.9            248       19.4
#> 52             38 102.1     172        51.6            271       17.6
#> 53            293  95.3      54        47.7             92       19.9
#> 54             82  93.4      32        46.9             63       19.4
#> 55              5  95.5      57        47.3             78       22.1
#> 56             32 103.3     196        50.2            219       19.3
#> 57            227 108.8     306        52.9            313       20.3
#> 58            214  93.1      29        46.7             55       16.7
#> 59             33  94.7      51        45.7             25       19.8
#> 60            261  98.2      90        47.2             73       20.7
#> 61             15 102.0     166        49.7            191       15.2
#> 62            132 102.6     187        50.4            226       19.8
#> 63             20 108.9     307        52.2            289       14.9
#> 64            125  95.6      59        46.4             44       21.9
#> 65             36  92.7      26        47.9            101       17.8
#> 66            101  98.9     103        45.9             29       18.4
#> 67             23  87.1       3        44.5              8       22.4
#> 68            256  98.2      88        50.2            221       18.5
#> 69             68  96.0      65        49.8            194       22.3
#> 70            287 104.9     231        51.6            276       18.1
#> 71            151 100.8     136        50.7            237       17.9
#> 72            264  90.2       6        45.1             13       18.9
#> 73            215  96.4      67        46.5             49       16.6
#> 74            138 100.6     133        49.2            159       17.4
#> 75             88  92.8      27        47.4             83       21.4
#> 76            112 110.3     316        56.2            349       16.4
#> 77            154  98.4      94        49.1            148       16.0
#> 78            206  98.1      85        50.7            238       23.0
#> 79            288 101.3     149        50.2            220       17.6
#> 80            202  99.4     113        49.6            181       20.9
#> 81            175 107.9     290        50.9            246       19.2
#> 82            237 113.3     336        54.7            340       17.3
#> 83             47 106.3     263        50.5            231       16.5
#> 84            108  94.5      46        46.7             56       20.5
#> 85            166 104.4     217        52.8            311       19.0
#> 86            336 102.5     182        49.8            196       17.3
#> 87             80 105.1     236        48.4            121       17.2
#> 88             84  97.6      81        51.1            256       19.2
#> 89            292 105.5     243        52.3            293       17.2
#> 90             62 107.0     275        53.1            318       20.5
#> 91            162 101.2     148        49.2            160       14.6
#> 92            192 100.7     134        46.4             47       17.9
#> 93            263 104.8     225        51.1            255       16.9
#> 94            170  99.0     104        48.0            105       20.2
#> 95            303 102.2     174        49.3            161       17.6
#> 96             65  95.8      62        45.9             30       19.6
#> 97            346 100.5     132        47.8             95       19.5
#> 98            212  96.4      68        44.8             11       19.1
#> 99              2 102.5     184        49.0            144       19.6
#> 100            90 100.8     135        50.3            222       17.7
#> 101           107  98.3      93        46.9             60       21.2
#> 102            74 105.1     237        48.7            130       16.3
#> 103           225  92.2      20        46.4             41       18.6
#> 104           246  95.2      53        48.2            113       22.7
#> 105           271 102.1     167        48.0            103       19.4
#> 106            66 105.3     242        51.0            251       19.0
#> 107           201  96.4      69        45.6             20       19.4
#> 108           184  94.7      49        49.1            152       22.3
#> 109           205 110.5     319        51.4            261       18.2
#> 110           130 108.4     301        52.9            314       17.6
#> 111            29  94.4      44        46.2             36       19.6
#> 112            52  93.1      31        44.1              6       19.3
#> 113           189 101.2     145        50.6            234       19.1
#> 114           116 104.8     226        48.7            136       15.7
#> 115           213 101.4     156        46.9             59       20.8
#> 116           187 106.4     265        49.8            199       16.7
#> 117           145  90.4       8        44.4              7       20.0
#> 118           178 106.8     272        50.1            218       16.3
#> 119           304  96.1      66        49.3            163       21.0
#> 120           252 101.1     142        49.1            151       18.5
#> 121           290  99.3     109        44.9             12       16.4
#> 122            70  94.7      50        45.2             16       21.3
#> 123           329 103.2     192        51.7            278       19.7
#> 124           105 108.1     295        47.6             89       14.0
#> 125            63 102.4     178        52.7            306       20.0
#> 126            67  94.2      39        47.4             80       20.9
#> 127           253 104.1     214        49.7            190       15.4
#> 128           180 122.9     353        58.4            353       16.9
#> 129           186 104.9     229        49.1            150       17.7
#> 130            21 103.9     209        51.5            264       20.1
#> 131           322 101.3     150        49.2            156       15.8
#> 132            53 101.4     157        46.6             51       19.0
#> 133           276 100.2     124        49.6            183       18.2
#> 134           124 106.2     261        50.0            207       18.4
#> 135            16 116.7     345        53.6            326       15.1
#> 136            79 102.1     169        50.7            235       20.0
#> 137           176  99.0     105        47.3             77       17.5
#> 138           167  94.4      45        48.1            111       24.5
#> 139             9 104.5     221        52.7            305       19.6
#> 140           203 109.4     311        54.1            336       19.7
#> 141           312 102.5     181        51.8            281       20.0
#> 142           328 103.4     197        51.5            268       17.8
#> 143           220  90.3       7        45.6             21       22.4
#> 144            48 113.6     337        53.3            320       18.6
#> 145           104  92.0      18        44.6              9       18.1
#> 146           289 104.0     210        48.9            139       16.4
#> 147           347  98.0      82        48.5            125       17.6
#> 148             1 107.5     284        52.0            285       19.9
#> 149           317 108.0     293        52.2            288       18.1
#> 150            91  96.7      71        46.3             39       20.9
#> 151           298 102.3     175        48.9            140       19.1
#> 152             3  97.1      75        49.6            184       27.8
#> 153           350  92.6      24        46.9             61       20.8
#> 154           110  98.3      91        49.8            192       23.3
#> 155           270  93.5      33        48.3            118       20.0
#> 156           140  99.1     107        48.1            112       18.1
#> 157           259 102.1     170        47.9             98       21.3
#> 158            71  97.0      74        47.6             90       19.6
#> 159            40  96.8      72        52.2            291       23.6
#> 160           335  95.5      58        50.0            204       24.9
#> 161           251 103.3     195        49.1            147       18.1
#> 162           224  98.6      98        47.8             96       20.6
#> 163           337 100.8     137        47.6             86       16.9
#> 164            57 112.1     327        51.0            249       16.1
#> 165           159  95.5      56        48.8            138       22.1
#> 166           301 102.6     186        49.7            185       17.2
#> 167           233 105.5     244        49.5            177       14.3
#> 168            30  93.6      34        46.7             54       21.5
#> 169           319 100.1     123        48.7            135       20.5
#> 170           294 107.7     286        52.6            300       16.0
#> 171           119  91.8      16        44.7             10       19.3
#> 172            96 112.3     330        51.6            270       17.6
#> 173           245 108.5     303        50.1            213       16.5
#> 174           247 102.5     185        51.0            250       20.3
#> 175            49 122.3     352        58.1            352       16.7
#> 176            87 101.3     154        48.7            131       18.9
#> 177           123  94.2      40        49.6            180       24.3
#> 178            26  99.3     110        46.4             46       18.5
#> 179           211 106.7     269        53.5            324       18.4
#> 180           269  98.4      95        46.9             58       17.5
#> 181           121 106.7     270        49.4            167       17.6
#> 182           230  98.0      83        49.9            202       20.9
#> 183            75 107.7     287        52.4            297       15.2
#> 184            81  98.8     102        49.5            175       20.7
#> 185           120 104.8     227        47.6             87       15.7
#> 186           248 112.4     331        52.5            299       18.0
#> 187           149 106.4     264        54.5            338       21.1
#> 188           306 107.0     276        51.9            284       17.9
#> 189           238 101.3     155        50.1            210       17.9
#> 190           268 101.3     152        51.5            266       18.7
#> 191           156  99.8     120        46.5             50       20.2
#> 192           134 103.1     191        52.7            308       23.0
#> 193           265 110.2     315        52.7            309       14.3
#> 194           146 106.1     260        49.4            168       18.7
#> 195            83 100.4     130        49.9            200       17.3
#> 196           113 106.2     262        51.6            272       18.7
#> 197           129 101.3     153        49.6            179       18.9
#> 198           310 110.3     317        53.1            317       18.3
#> 199           280  99.1     106        46.3             40       20.0
#> 200           118 105.5     247        48.7            132       18.8
#> 201           277 108.0     292        51.6            273       17.6
#> 202           278 104.0     212        49.7            188       19.9
#> 203            14  97.2      77        49.2            154       22.4
#> 204            17 102.1     171        49.1            153       19.1
#> 205           111 102.1     173        49.3            164       18.3
#> 206            92 111.1     321        53.8            329       16.2
#> 207           286 108.3     300        48.8            137       14.1
#> 208           291 110.0     313        52.6            301       17.4
#> 209           122 104.0     211        51.8            283       18.6
#> 210            27  89.1       5        41.2              1       20.2
#> 211           341 105.5     246        48.9            142       14.3
#> 212           320 103.8     205        50.4            227       21.4
#> 213             6 109.1     309        50.9            244       17.8
#> 214            58  95.9      63        51.0            252       23.3
#> 215           352 108.1     296        50.8            239       17.5
#> 216           316 102.7     188        49.6            182       17.7
#> 217           161  94.6      47        46.4             43       18.5
#> 218           340 111.6     325        52.8            310       20.7
#> 219           273 106.7     271        50.1            212       16.0
#> 220            11 100.2     127        49.8            198       20.3
#> 221           199 111.7     326        53.1            316       17.0
#> 222           299 100.8     138        47.2             75       17.0
#> 223           324 101.5     158        49.8            197       24.8
#> 224           349 116.9     346        53.3            321       14.2
#> 225           308 101.3     151        50.5            230       20.7
#> 226           165 100.4     129        48.5            124       20.3
#> 227            72 104.0     213        50.1            211       18.7
#> 228           266 100.3     128        50.5            232       20.7
#> 229           197 103.7     200        50.5            229       24.3
#> 230            64 111.6     323        52.7            307       15.9
#> 231           195 115.6     344        54.4            337       17.1
#> 232           103 105.7     251        50.1            216       16.2
#> 233            25 114.8     342        56.1            348       20.6
#> 234           314  85.1       1        43.1              2       19.3
#> 235           223  94.0      37        45.7             24       19.6
#> 236           171 105.8     253        50.1            215       15.7
#> 237            12 108.6     304        50.3            224       19.6
#> 238           100 101.8     162        49.5            173       22.4
#> 239            13 100.2     126        50.4            225       26.1
#> 240            86  98.1      86        45.8             28       16.8
#> 241           315 107.9     291        52.2            290       16.6
#> 242           326 107.4     281        51.6            277       17.0
#> 243           106 110.3     318        56.9            350       22.5
#> 244           109 106.0     256        53.1            319       23.5
#> 245           115 112.6     332        55.7            346       18.2
#> 246            60 105.0     233        49.3            166       17.7
#> 247            50  98.0      84        50.4            228       20.3
#> 248           333 102.9     190        51.5            269       19.4
#> 249           275  98.3      92        48.1            110       18.5
#> 250           353 115.0     343        55.7            345       15.1
#> 251           142 107.1     278        48.1            109       17.8
#> 252           150  98.6      99        49.1            149       21.0
#> 253           255 104.5     220        49.1            145       21.4
#> 254           198 106.0     258        50.7            236       18.1
#> 255            39 108.3     299        50.8            242       17.7
#> 256            28 107.6     285        52.4            296       17.8
#> 257           219 103.8     206        47.0             68       16.5
#> 258           147 105.7     252        49.7            186       18.9
#> 259           241 105.7     249        51.8            280       21.9
#> 260           158  99.4     111        46.3             38       18.4
#> 261           194 101.0     140        49.2            155       19.1
#> 262           136 107.8     289        54.1            335       17.6
#> 263           240 103.6     199        49.5            176       21.1
#> 264           232 108.2     298        54.7            339       19.4
#> 265           157 106.1     259        50.0            208       18.7
#> 266           250 113.9     339        54.0            334       18.7
#> 267           126 104.8     224        48.7            133       19.7
#> 268           196  98.2      87        48.0            106       21.7
#> 269           318 108.8     305        52.5            298       17.0
#> 270            46 101.6     159        48.3            115       15.9
#> 271           216 111.3     322        51.4            263       18.0
#> 272            94 114.4     341        53.8            328       16.9
#> 273           168  98.2      89        47.4             82       19.2
#> 274           185 107.4     280        52.8            312       17.2
#> 275           331 105.3     239        49.8            193       19.6
#> 276           300  99.9     121        49.2            158       16.8
#> 277           137 104.2     215        47.8             93       17.1
#> 278           183 101.1     143        49.7            189       19.7
#> 279           200 104.6     222        47.0             65       17.1
#> 280           257  99.5     115        46.1             33       17.7
#> 281           174 107.5     283        50.0            205       17.3
#> 282            24 100.5     131        47.8             94       23.7
#> 283           114 102.5     180        50.9            247       22.6
#> 284           262 106.6     268        52.3            294       20.0
#> 285           283 102.9     189        51.5            265       19.8
#> 286           231 104.9     228        50.9            245       19.3
#> 287           190 103.7     201        48.3            117       16.8
#> 288           236 104.9     232        50.8            240       20.8
#> 289            31 105.6     248        50.0            203       19.4
#> 290           243 102.5     183        46.6             52       16.0
#> 291           338 117.3     348        55.9            347       15.4
#> 292            55 104.5     218        50.1            214       18.2
#> 293           267 105.5     245        52.1            287       19.4
#> 294           297  99.8     118        47.2             71       16.1
#> 295           133 110.8     320        53.5            323       18.9
#> 296           330 109.1     308        52.6            302       18.6
#> 297           179 104.9     230        51.7            279       23.3
#> 298            61 105.8     254        48.3            119       20.4
#> 299           339 103.8     204        53.5            325       18.1
#> 300            51  97.3      80        46.1             32       22.0
#> 301           148 108.5     302        52.6            303       18.4
#> 302           348 106.5     267        52.3            295       16.3
#> 303            78 106.8     274        52.0            286       17.5
#> 304           325 102.1     168        47.2             72       16.3
#> 305           222 112.2     328        54.9            342       17.3
#> 306            35 113.2     335        52.6            304       17.8
#> 307           218 105.8     255        50.6            233       18.3
#> 308           302 106.5     266        49.5            174       19.1
#> 309           208 108.1     294        49.7            187       17.3
#> 310            22 113.6     338        55.6            344       17.8
#> 311            44 107.3     279        51.4            262       21.6
#> 312           239 101.1     144        46.0             31       18.7
#> 313           342 103.8     207        51.3            260       17.6
#> 314           152 104.3     216        51.6            274       18.2
#> 315           210  99.8     117        50.1            209       17.9
#> 316           144 103.9     208        49.4            170       18.3
#> 317           155 106.0     257        48.7            134       19.1
#> 318             7  96.6      70        49.5            178       23.1
#> 319            98 103.2     193        47.9            100       22.7
#> 320           163 105.3     238        52.2            292       19.7
#> 321           160 101.9     164        47.2             76       21.6
#> 322           235 100.9     139        50.1            217       18.9
#> 323           153 117.2     347        54.0            333       18.7
#> 324           131 113.0     334        54.7            341       18.6
#> 325           321  98.8     101        48.0            104       25.9
#> 326           164 119.7     350        53.9            330       18.5
#> 327            19 107.5     282        47.4             81       18.8
#> 328            41 105.1     235        48.5            127       20.0
#> 329            45 105.7     250        50.0            206       20.6
#> 330           311 106.8     273        49.9            201       18.6
#> 331           135 101.6     160        47.5             84       22.3
#> 332           234 107.1     277        51.6            275       16.0
#> 333            97 102.3     176        48.6            129       22.8
#> 334           351 109.3     310        53.9            331       19.6
#> 335            10 102.4     177        47.7             91       21.4
#> 336           244 110.0     314        51.2            257       18.3
#> 337           182 104.5     219        51.0            254       17.9
#> 338           209 109.6     312        53.7            327       22.3
#> 339           177 105.1     234        51.5            267       20.3
#> 340           344 103.3     194        49.1            146       19.8
#> 341           217 112.8     333        53.0            315       20.5
#> 342           260 114.0     340        53.4            322       18.0
#> 343           249 103.8     203        49.3            162       20.5
#> 344            85 101.6     161        48.3            120       19.4
#> 345           345 117.6     349        54.0            332       17.6
#> 346           172 105.3     240        48.6            128       19.7
#> 347           305  95.9      64        47.2             74       21.0
#> 348           173 108.2     297        51.3            259       18.2
#> 349             8 120.8     351        57.6            351       16.0
#> 350            95 103.4     198        51.3            258       20.4
#> 351           181 112.2     329        55.3            343       18.5
#> 352           327 107.8     288        51.0            253       20.4
#> 353            59 104.6     223        48.9            141       20.6
#>     Def.TO.Pct.Rk Def.OR.Pct Def.OR.Pct.Rk Def.FTRate Def.FTRate.Rk NCAA_Seed
#> 1             196       22.7            16       21.8             7         1
#> 2             167       26.6           115       30.9           149         1
#> 3             246       30.2           280       23.4            13         2
#> 4             302       28.5           197       26.4            42         8
#> 5             258       29.5           253       26.8            49         6
#> 6             109       31.1           307       29.5           109         4
#> 7             206       24.1            35       27.9            65         5
#> 8             178       26.4           108       23.2            12         1
#> 9              91       28.0           176       30.9           145         3
#> 10            331       26.0            91       29.3           100         3
#> 11             49       25.4            63       30.6           140         2
#> 12            265       25.0            50       29.0            91         4
#> 13            200       25.5            72       29.3           101         5
#> 14            345       26.0            92       34.8           238         9
#> 15            292       24.5            42       23.6            16         2
#> 16            242       23.6            22       28.0            68         8
#> 17             22       29.8           261       30.8           141         1
#> 18            274       26.6           116       24.2            22         3
#> 19            283       28.3           189       31.6           165        NA
#> 20            320       25.5            70       26.4            41         6
#> 21             86       32.2           331       30.2           128        NA
#> 22            209       25.3            61       41.6           324         7
#> 23            336       22.5            12       25.8            32        NA
#> 24            268       28.5           196       32.1           181         4
#> 25            231       25.4            67       30.9           148         5
#> 26            272       24.9            48       32.6           196        NA
#> 27            146       27.4           150       33.7           218         9
#> 28            175       29.0           227       28.2            74        NA
#> 29            129       30.4           289       32.4           190         3
#> 30            330       27.9           169       28.0            66        NA
#> 31            332       31.8           323       28.1            71        NA
#> 32              9       30.2           281       34.4           229         2
#> 33            170       27.4           148       33.9           219         5
#> 34             68       27.7           155       38.8           300        13
#> 35             74       25.9            82       35.2           242         7
#> 36            164       28.7           209       26.6            46        NA
#> 37            214       30.8           300       35.9           257        NA
#> 38            304       25.7            80       23.9            20         7
#> 39            186       29.0           222       30.9           144        NA
#> 40            291       25.9            88       25.3            29         4
#> 41            298       28.1           180       19.7             2        NA
#> 42             96       30.9           302       35.4           252        11
#> 43            180       27.6           154       31.8           172         6
#> 44            341       24.4            41       36.5           268        NA
#> 45            296       24.0            28       24.9            26        NA
#> 46            339       27.1           140       26.0            34        NA
#> 47             17       29.3           237       35.4           250        10
#> 48             70       31.6           314       28.0            67        NA
#> 49            259       22.5            11       26.8            50        11
#> 50             80       27.2           142       31.9           178        NA
#> 51            133       25.4            64       35.2           245        11
#> 52            255       23.8            24       24.1            21        NA
#> 53            107       26.3           104       30.2           129        11
#> 54            137       23.9            27       26.1            37         8
#> 55             35       31.4           312       40.9           320        NA
#> 56            141       31.1           306       21.0             4        NA
#> 57             87       34.3           347       32.1           182        NA
#> 58            300       27.4           147       19.7             1        10
#> 59            112       28.8           214       29.2            97        12
#> 60             65       26.8           127       32.6           194        NA
#> 61            340       26.0            90       35.2           244        NA
#> 62            111       29.4           242       20.3             3        14
#> 63            346       22.1            10       32.2           186        NA
#> 64             37       29.4           247       34.6           234        NA
#> 65            237       24.5            44       32.6           195        10
#> 66            195       29.2           233       29.1            93        13
#> 67             29       27.7           159       37.0           280         6
#> 68            190       24.1            33       31.9           175        NA
#> 69             33       26.2            98       33.1           206        11
#> 70            215       26.8           132       31.7           166        NA
#> 71            228       30.1           272       31.5           164        NA
#> 72            163       25.4            68       27.5            59         9
#> 73            305       21.3             5       25.7            31        12
#> 74            266       24.0            30       40.6           316        NA
#> 75             44       28.4           192       37.4           284         8
#> 76            309       22.8            17       29.8           119        NA
#> 77            322       24.2            37       29.2            94        NA
#> 78             19       28.4           191       26.8            51        NA
#> 79            253       31.9           324       22.9            10        NA
#> 80             57       21.7             8       32.0           180        13
#> 81            147       29.5           252       27.6            64        NA
#> 82            271       32.0           327       29.0            92        NA
#> 83            307       25.6            77       31.2           157        NA
#> 84             76       29.0           223       33.1           205        NA
#> 85            155       27.8           161       34.7           235        NA
#> 86            269       26.3            99       23.8            18        NA
#> 87            279       26.0            93       26.9            52        16
#> 88            144       22.6            13       29.8           118        NA
#> 89            277       24.0            31       26.5            45        NA
#> 90             75       27.9           175       32.5           191        NA
#> 91            347       19.0             1       26.6            47        15
#> 92            230       25.9            87       31.2           156        14
#> 93            290       24.6            45       27.3            57        NA
#> 94             94       30.5           291       29.2            98        NA
#> 95            247       26.6           117       33.0           200        NA
#> 96            126       30.1           279       35.3           248        NA
#> 97            128       26.7           122       24.3            23        14
#> 98            152       22.6            14       31.4           163        13
#> 99            120       28.7           211       34.4           230        15
#> 100           239       26.9           136       23.0            11        NA
#> 101            50       29.8           263       39.0           302        NA
#> 102           315       27.8           162       26.5            43        NA
#> 103           179       27.6           153       28.9            89        NA
#> 104            21       31.4           313       36.2           264        NA
#> 105           132       30.4           288       34.4           228        NA
#> 106           157       25.7            78       30.1           127        NA
#> 107           130       21.3             4       28.6            83        12
#> 108            31       28.6           204       34.2           224        10
#> 109           212       31.6           317       33.0           202        NA
#> 110           250       26.7           124       29.8           117        NA
#> 111           119       25.2            57       36.6           269        NA
#> 112           140       31.8           320       31.4           159        NA
#> 113           151       25.7            79       33.5           214        NA
#> 114           333       26.8           133       31.0           150        NA
#> 115            62       32.9           334       47.0           345        NA
#> 116           301       26.8           130       29.0            90        NA
#> 117            98       24.1            34       38.4           297        11
#> 118           314       26.6           118       34.3           225        NA
#> 119            55       29.6           255       30.8           142        NA
#> 120           189       27.0           138       33.7           216        15
#> 121           311       25.3            60       36.0           261        14
#> 122            47       28.6           200       53.1           353        NA
#> 123           114       24.1            36       30.6           138        NA
#> 124           353       25.6            75       30.6           139        NA
#> 125           102       30.1           275       24.4            24        NA
#> 126            58       28.6           205       28.5            79        NA
#> 127           337       26.6           119       28.2            75        NA
#> 128           288       34.4           348       28.2            72        NA
#> 129           241       29.3           239       32.5           193        NA
#> 130            95       29.6           256       26.6            48        NA
#> 131           329       29.2           235       28.6            84        NA
#> 132           156       29.4           246       27.2            55        NA
#> 133           210       22.7            15       33.2           208        NA
#> 134           199       27.8           163       45.8           340        NA
#> 135           344       31.0           304       38.1           291        NA
#> 136           103       24.1            32       41.9           327        16
#> 137           260       25.0            51       31.4           160        NA
#> 138             6       30.1           273       35.9           258        NA
#> 139           123       29.4           243       36.8           276        NA
#> 140           113       27.8           164       35.9           259        NA
#> 141           100       27.4           151       31.7           167        NA
#> 142           236       24.3            39       31.8           171        NA
#> 143            27       27.8           167       31.8           173        NA
#> 144           183       29.5           251       28.8            87        NA
#> 145           217       27.9           174       28.0            69         9
#> 146           310       26.8           128       33.5           215        NA
#> 147           254       25.5            71       26.1            38        NA
#> 148           106       29.1           229       43.1           332        NA
#> 149           219       26.3           106       38.0           289        NA
#> 150            59       27.7           160       47.8           346        NA
#> 151           154       28.8           213       30.4           133        NA
#> 152             1       26.8           129       44.6           338        12
#> 153            60       32.2           330       35.3           246        NA
#> 154            14       34.5           349       26.0            33        NA
#> 155            99       24.5            43       28.7            85        NA
#> 156           220       21.3             3       41.6           323        NA
#> 157            48       35.5           350       30.5           136        NA
#> 158           125       27.8           165       40.6           317        NA
#> 159            11       23.6            21       23.5            14        NA
#> 160             4       27.0           139       36.8           275        NA
#> 161           218       24.8            46       32.8           198        NA
#> 162            69       30.5           292       29.4           104        NA
#> 163           289       28.6           203       25.0            27        NA
#> 164           319       28.6           206       29.9           121        NA
#> 165            34       30.2           282       35.4           251        NA
#> 166           278       25.1            52       26.1            39        16
#> 167           350       23.8            26       26.5            44        NA
#> 168            42       28.0           177       28.3            77        NA
#> 169            78       25.4            65       46.3           343        NA
#> 170           323       26.7           121       29.5           107        NA
#> 171           143       28.9           219       35.8           255        NA
#> 172           257       31.6           316       29.6           113        NA
#> 173           306       29.5           254       30.9           146        NA
#> 174            89       30.3           284       33.5           213        NA
#> 175           299       32.1           329       36.7           273        NA
#> 176           158       26.5           114       37.8           288        NA
#> 177             8       30.1           278       38.8           299        NA
#> 178           187       24.8            47       32.2           185        NA
#> 179           194       26.2            96       28.0            70        NA
#> 180           262       29.0           226       35.8           256        NA
#> 181           251       30.0           269       31.4           162        NA
#> 182            56       25.9            89       32.3           187        NA
#> 183           342       25.5            69       29.8           116        NA
#> 184            64       28.7           207       27.6            63        NA
#> 185           334       28.2           182       23.6            17        NA
#> 186           222       31.7           318       31.9           177        NA
#> 187            51       28.9           217       29.2            95        NA
#> 188           229       28.1           181       36.9           277        NA
#> 189           227       23.4            20       30.5           135        NA
#> 190           173       33.0           335       21.8             6        NA
#> 191            92       31.9           326       31.0           151        15
#> 192            18       31.2           311       29.6           114        NA
#> 193           348       29.0           224       32.0           179        NA
#> 194           177       31.7           319       34.2           223        NA
#> 195           275       26.3           102       37.0           278        NA
#> 196           171       29.8           264       32.8           197        NA
#> 197           161       27.8           168       30.6           137        NA
#> 198           201       29.9           266       31.8           174        NA
#> 199           104       32.1           328       37.6           286        NA
#> 200           165       27.9           173       41.7           325        NA
#> 201           248       27.7           156       27.1            54        NA
#> 202           105       29.4           248       36.6           272        NA
#> 203            28       31.8           322       26.0            36        NA
#> 204           149       24.0            29       30.3           131        NA
#> 205           203       24.3            40       27.0            53        NA
#> 206           317       28.6           201       26.0            35        NA
#> 207           352       26.2            97       23.6            15        NA
#> 208           264       25.9            83       42.1           329        NA
#> 209           184       27.8           166       38.2           292        NA
#> 210            93       29.4           244       35.0           240        NA
#> 211           349       27.2           141       22.1             8        NA
#> 212            46       29.3           241       31.7           169        16
#> 213           232       29.8           262       32.4           188        NA
#> 214            15       25.2            56       34.5           231        NA
#> 215           261       28.5           198       39.3           305        NA
#> 216           240       26.9           135       35.3           247        NA
#> 217           191       26.7           125       29.5           108        NA
#> 218            66       35.8           351       27.6            62        NA
#> 219           326       26.5           112       29.6           112        NA
#> 220            88       27.7           157       27.3            56        NA
#> 221           286       30.5           294       31.8           170        NA
#> 222           284       24.3            38       32.2           183        NA
#> 223             5       34.1           343       39.7           310        NA
#> 224           351       31.6           315       30.3           132        NA
#> 225            67       26.9           134       29.3           103        NA
#> 226            90       28.4           190       40.1           311        NA
#> 227           168       26.5           111       40.2           312        NA
#> 228            63       30.7           296       29.9           122        NA
#> 229             7       30.8           299       44.7           339        NA
#> 230           328       26.0            94       29.3            99        NA
#> 231           281       33.5           339       29.5           111        NA
#> 232           316       29.3           240       31.7           168        NA
#> 233            71       34.2           346       39.7           309        NA
#> 234           142       23.3            18       21.6             5         7
#> 235           121       25.1            54       28.5            82        NA
#> 236           335       26.7           126       31.1           155        NA
#> 237           124       30.4           287       34.3           226        NA
#> 238            26       28.8           215       41.7           326        NA
#> 239             2       29.5           250       48.9           349        NA
#> 240           294       23.3            19       37.0           279        NA
#> 241           303       28.9           221       22.5             9        NA
#> 242           287       25.9            84       23.9            19        NA
#> 243            25       29.4           249       38.3           294        NA
#> 244            12       30.0           268       44.2           337        NA
#> 245           211       33.5           340       24.5            25        NA
#> 246           244       30.3           283       26.2            40        NA
#> 247            84       23.7            23       27.6            61        NA
#> 248           134       27.3           144       31.0           152        NA
#> 249           193       21.7             7       34.0           221        NA
#> 250           343       26.2            95       35.0           241        NA
#> 251           238       32.5           333       37.2           283        NA
#> 252            53       29.9           265       25.3            28        NA
#> 253            45       28.8           216       33.9           220        NA
#> 254           221       25.9            81       30.1           125        NA
#> 255           245       28.5           194       31.0           153        NA
#> 256           233       28.9           220       34.8           237        NA
#> 257           308       28.2           186       29.9           123        NA
#> 258           160       27.6           152       33.7           217        NA
#> 259            38       29.2           236       35.7           254        NA
#> 260           197       27.3           143       27.4            58        NA
#> 261           150       25.9            86       32.5           192        NA
#> 262           256       30.4           286       34.4           227        NA
#> 263            52       30.0           270       48.4           347        NA
#> 264           135       28.2           187       39.7           308        NA
#> 265           176       31.2           310       28.5            80        NA
#> 266           174       29.2           234       45.9           341        NA
#> 267           116       25.3            62       48.8           348        NA
#> 268            39       25.9            85       35.3           249        NA
#> 269           285       26.8           131       32.4           189        NA
#> 270           327       25.0            49       30.8           143        NA
#> 271           224       28.2           184       37.1           282        NA
#> 272           293       27.4           149       37.1           281        NA
#> 273           145       26.4           109       33.0           201        NA
#> 274           276       25.5            74       33.3           210        NA
#> 275           122       27.7           158       40.5           313        NA
#> 276           295       20.8             2       29.7           115        NA
#> 277           282       27.9           170       34.5           232        NA
#> 278           118       26.4           110       29.3           102        NA
#> 279           280       27.9           171       38.2           293        NA
#> 280           243       28.2           183       36.6           271        NA
#> 281           267       27.9           172       30.1           126        NA
#> 282            10       28.2           185       49.2           351        16
#> 283            24       32.5           332       27.6            60        NA
#> 284            97       29.9           267       37.4           285        NA
#> 285           110       26.6           120       38.3           295        NA
#> 286           139       25.3            59       49.1           350        NA
#> 287           297       30.5           290       34.0           222        NA
#> 288            61       29.7           257       43.8           336        NA
#> 289           138       26.3           105       40.8           319        NA
#> 290           321       26.5           113       28.7            86        NA
#> 291           338       29.3           238       31.4           161        NA
#> 292           208       26.7           123       35.4           253        NA
#> 293           131       25.5            73       28.4            78        NA
#> 294           318       21.8             9       32.2           184        NA
#> 295           159       29.4           245       39.5           306        NA
#> 296           182       30.1           276       28.8            88        NA
#> 297            13       33.6           341       36.3           265        NA
#> 298            82       30.9           301       38.8           301        NA
#> 299           216       23.8            25       29.5           110        NA
#> 300            36       27.4           146       40.8           318        NA
#> 301           198       28.6           199       43.4           333        NA
#> 302           313       25.1            55       25.7            30        NA
#> 303           263       25.4            66       38.1           290        NA
#> 304           312       21.4             6       39.1           303        NA
#> 305           270       30.7           297       28.3            76        NA
#> 306           234       28.0           178       38.6           298        NA
#> 307           202       27.3           145       33.4           212        NA
#> 308           153       29.1           231       36.5           267        NA
#> 309           273       28.3           188       29.2            96        NA
#> 310           235       28.7           210       36.0           262        NA
#> 311            40       31.8           321       41.1           321        NA
#> 312           172       31.0           305       29.5           106        NA
#> 313           249       26.3           103       33.0           203        NA
#> 314           207       30.6           295       31.2           158        NA
#> 315           226       28.0           179       31.9           176        NA
#> 316           204       25.6            76       28.2            73        NA
#> 317           148       29.1           228       41.3           322        NA
#> 318            16       30.5           293       30.9           147        NA
#> 319            23       33.2           337       33.3           211        16
#> 320           117       31.2           309       29.9           124        NA
#> 321            41       28.8           212       40.5           314        NA
#> 322           162       28.6           202       36.8           274        NA
#> 323           169       30.0           271       43.8           335        NA
#> 324           181       28.9           218       34.6           233        NA
#> 325             3       34.2           345       37.8           287        NA
#> 326           188       36.9           353       34.7           236        NA
#> 327           166       29.0           225       49.3           352        NA
#> 328           101       29.2           232       36.4           266        NA
#> 329            73       33.1           336       39.5           307        NA
#> 330           185       28.4           193       32.8           199        NA
#> 331            30       30.1           277       46.0           342        NA
#> 332           325       26.3           107       29.4           105        NA
#> 333            20       29.7           258       43.6           334        NA
#> 334           127       28.5           195       28.5            81        NA
#> 335            43       30.4           285       42.0           328        NA
#> 336           205       29.8           259       40.6           315        NA
#> 337           225       29.1           230       33.1           204        NA
#> 338            32       34.0           342       42.5           330        NA
#> 339            85       25.1            53       35.0           239        NA
#> 340           108       30.1           274       29.8           120        NA
#> 341            79       34.1           344       36.0           260        NA
#> 342           223       33.4           338       33.2           209        NA
#> 343            77       25.2            58       39.1           304        NA
#> 344           136       26.3           100       31.1           154        NA
#> 345           252       35.9           352       36.1           263        NA
#> 346           115       28.7           208       30.2           130        NA
#> 347            54       26.3           101       33.1           206        NA
#> 348           213       27.0           137       35.2           243        NA
#> 349           324       31.9           325       42.5           330        NA
#> 350            83       29.8           260       38.3           296        NA
#> 351           192       31.2           308       30.4           134        NA
#> 352            81       31.0           303       36.6           270        NA
#> 353            72       30.7           298       46.3           344        NA
#>     Year
#> 1   2020
#> 2   2020
#> 3   2020
#> 4   2020
#> 5   2020
#> 6   2020
#> 7   2020
#> 8   2020
#> 9   2020
#> 10  2020
#> 11  2020
#> 12  2020
#> 13  2020
#> 14  2020
#> 15  2020
#> 16  2020
#> 17  2020
#> 18  2020
#> 19  2020
#> 20  2020
#> 21  2020
#> 22  2020
#> 23  2020
#> 24  2020
#> 25  2020
#> 26  2020
#> 27  2020
#> 28  2020
#> 29  2020
#> 30  2020
#> 31  2020
#> 32  2020
#> 33  2020
#> 34  2020
#> 35  2020
#> 36  2020
#> 37  2020
#> 38  2020
#> 39  2020
#> 40  2020
#> 41  2020
#> 42  2020
#> 43  2020
#> 44  2020
#> 45  2020
#> 46  2020
#> 47  2020
#> 48  2020
#> 49  2020
#> 50  2020
#> 51  2020
#> 52  2020
#> 53  2020
#> 54  2020
#> 55  2020
#> 56  2020
#> 57  2020
#> 58  2020
#> 59  2020
#> 60  2020
#> 61  2020
#> 62  2020
#> 63  2020
#> 64  2020
#> 65  2020
#> 66  2020
#> 67  2020
#> 68  2020
#> 69  2020
#> 70  2020
#> 71  2020
#> 72  2020
#> 73  2020
#> 74  2020
#> 75  2020
#> 76  2020
#> 77  2020
#> 78  2020
#> 79  2020
#> 80  2020
#> 81  2020
#> 82  2020
#> 83  2020
#> 84  2020
#> 85  2020
#> 86  2020
#> 87  2020
#> 88  2020
#> 89  2020
#> 90  2020
#> 91  2020
#> 92  2020
#> 93  2020
#> 94  2020
#> 95  2020
#> 96  2020
#> 97  2020
#> 98  2020
#> 99  2020
#> 100 2020
#> 101 2020
#> 102 2020
#> 103 2020
#> 104 2020
#> 105 2020
#> 106 2020
#> 107 2020
#> 108 2020
#> 109 2020
#> 110 2020
#> 111 2020
#> 112 2020
#> 113 2020
#> 114 2020
#> 115 2020
#> 116 2020
#> 117 2020
#> 118 2020
#> 119 2020
#> 120 2020
#> 121 2020
#> 122 2020
#> 123 2020
#> 124 2020
#> 125 2020
#> 126 2020
#> 127 2020
#> 128 2020
#> 129 2020
#> 130 2020
#> 131 2020
#> 132 2020
#> 133 2020
#> 134 2020
#> 135 2020
#> 136 2020
#> 137 2020
#> 138 2020
#> 139 2020
#> 140 2020
#> 141 2020
#> 142 2020
#> 143 2020
#> 144 2020
#> 145 2020
#> 146 2020
#> 147 2020
#> 148 2020
#> 149 2020
#> 150 2020
#> 151 2020
#> 152 2020
#> 153 2020
#> 154 2020
#> 155 2020
#> 156 2020
#> 157 2020
#> 158 2020
#> 159 2020
#> 160 2020
#> 161 2020
#> 162 2020
#> 163 2020
#> 164 2020
#> 165 2020
#> 166 2020
#> 167 2020
#> 168 2020
#> 169 2020
#> 170 2020
#> 171 2020
#> 172 2020
#> 173 2020
#> 174 2020
#> 175 2020
#> 176 2020
#> 177 2020
#> 178 2020
#> 179 2020
#> 180 2020
#> 181 2020
#> 182 2020
#> 183 2020
#> 184 2020
#> 185 2020
#> 186 2020
#> 187 2020
#> 188 2020
#> 189 2020
#> 190 2020
#> 191 2020
#> 192 2020
#> 193 2020
#> 194 2020
#> 195 2020
#> 196 2020
#> 197 2020
#> 198 2020
#> 199 2020
#> 200 2020
#> 201 2020
#> 202 2020
#> 203 2020
#> 204 2020
#> 205 2020
#> 206 2020
#> 207 2020
#> 208 2020
#> 209 2020
#> 210 2020
#> 211 2020
#> 212 2020
#> 213 2020
#> 214 2020
#> 215 2020
#> 216 2020
#> 217 2020
#> 218 2020
#> 219 2020
#> 220 2020
#> 221 2020
#> 222 2020
#> 223 2020
#> 224 2020
#> 225 2020
#> 226 2020
#> 227 2020
#> 228 2020
#> 229 2020
#> 230 2020
#> 231 2020
#> 232 2020
#> 233 2020
#> 234 2020
#> 235 2020
#> 236 2020
#> 237 2020
#> 238 2020
#> 239 2020
#> 240 2020
#> 241 2020
#> 242 2020
#> 243 2020
#> 244 2020
#> 245 2020
#> 246 2020
#> 247 2020
#> 248 2020
#> 249 2020
#> 250 2020
#> 251 2020
#> 252 2020
#> 253 2020
#> 254 2020
#> 255 2020
#> 256 2020
#> 257 2020
#> 258 2020
#> 259 2020
#> 260 2020
#> 261 2020
#> 262 2020
#> 263 2020
#> 264 2020
#> 265 2020
#> 266 2020
#> 267 2020
#> 268 2020
#> 269 2020
#> 270 2020
#> 271 2020
#> 272 2020
#> 273 2020
#> 274 2020
#> 275 2020
#> 276 2020
#> 277 2020
#> 278 2020
#> 279 2020
#> 280 2020
#> 281 2020
#> 282 2020
#> 283 2020
#> 284 2020
#> 285 2020
#> 286 2020
#> 287 2020
#> 288 2020
#> 289 2020
#> 290 2020
#> 291 2020
#> 292 2020
#> 293 2020
#> 294 2020
#> 295 2020
#> 296 2020
#> 297 2020
#> 298 2020
#> 299 2020
#> 300 2020
#> 301 2020
#> 302 2020
#> 303 2020
#> 304 2020
#> 305 2020
#> 306 2020
#> 307 2020
#> 308 2020
#> 309 2020
#> 310 2020
#> 311 2020
#> 312 2020
#> 313 2020
#> 314 2020
#> 315 2020
#> 316 2020
#> 317 2020
#> 318 2020
#> 319 2020
#> 320 2020
#> 321 2020
#> 322 2020
#> 323 2020
#> 324 2020
#> 325 2020
#> 326 2020
#> 327 2020
#> 328 2020
#> 329 2020
#> 330 2020
#> 331 2020
#> 332 2020
#> 333 2020
#> 334 2020
#> 335 2020
#> 336 2020
#> 337 2020
#> 338 2020
#> 339 2020
#> 340 2020
#> 341 2020
#> 342 2020
#> 343 2020
#> 344 2020
#> 345 2020
#> 346 2020
#> 347 2020
#> 348 2020
#> 349 2020
#> 350 2020
#> 351 2020
#> 352 2020
#> 353 2020
# }
# \donttest{
try(kp_pointdist(min_year = 2020, max_year = 2021))
#> ✖ 2026-10-26 19:18:52.066578: Invalid arguments or no point distribution data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf Off.FT.Pct Off.FT.Pct.Rk Off.FG_2.Pct
#> 1             Arkansas St.   SB       26.2             1         48.9
#> 2              Chicago St.  WAC       25.2             2         47.8
#> 3                 Kentucky  SEC       24.3             3         55.3
#> 4           Texas Southern SWAC       24.2             4         54.2
#> 5       South Carolina St. MEAC       24.2             5         55.3
#> 6              Wake Forest  ACC       23.8             6         49.3
#> 7              New Orleans Slnd       23.6             7         55.7
#> 8               Morgan St. MEAC       23.6             8         54.8
#> 9               High Point BSth       23.5             9         48.4
#> 10       Abilene Christian Slnd       23.5            10         49.8
#> 11                Arkansas  SEC       23.4            11         46.6
#> 12             Little Rock   SB       23.3            12         51.3
#> 13        Prairie View A&M SWAC       23.3            13         57.1
#> 14        Western Kentucky CUSA       23.3            14         49.3
#> 15               Texas A&M  SEC       23.1            15         47.0
#> 16           Saint Peter's MAAC       23.0            16         49.1
#> 17                Missouri  SEC       22.9            17         47.6
#> 18                 Seattle  WAC       22.9            18         47.0
#> 19        Central Arkansas Slnd       22.9            19         46.9
#> 20                  Auburn  SEC       22.8            20         46.0
#> 21           Cleveland St. Horz       22.5            21         60.9
#> 22            Kennesaw St. ASun       22.5            22         54.8
#> 23             Montana St. BSky       22.5            23         53.2
#> 24                Maryland  B10       22.5            24         45.5
#> 25               Fairfield MAAC       22.5            25         55.3
#> 26         Mississippi St.  SEC       22.4            26         56.4
#> 27           South Alabama   SB       22.4            27         55.5
#> 28              Vanderbilt  SEC       22.4            28         43.4
#> 29       Stephen F. Austin Slnd       22.3            29         55.0
#> 30           North Alabama ASun       22.3            30         48.2
#> 31        Eastern Michigan  MAC       22.3            31         52.0
#> 32               Tennessee  SEC       22.2            32         50.8
#> 33                 Hampton BSth       22.2            33         54.3
#> 34         Appalachian St.   SB       22.2            34         49.7
#> 35           East Carolina Amer       22.1            35         54.9
#> 36                   Tulsa Amer       22.1            36         51.9
#> 37              California  P12       22.1            37         54.2
#> 38               Marquette   BE       22.0            38         39.3
#> 39              Oregon St.  P12       22.0            39         52.3
#> 40         Houston Baptist Slnd       22.0            40         50.1
#> 41         Bethune Cookman MEAC       22.0            41         52.7
#> 42            South Dakota  Sum       21.9            42         50.7
#> 43           West Virginia  B12       21.8            43         56.8
#> 44                    UCLA  P12       21.8            44         52.0
#> 45                  Towson  CAA       21.8            45         50.0
#> 46              Pittsburgh  ACC       21.7            46         53.9
#> 47             Mississippi  SEC       21.6            47         52.3
#> 48            North Dakota  Sum       21.6            48         47.7
#> 49           Grambling St. SWAC       21.6            49         57.9
#> 50            Grand Canyon  WAC       21.6            50         52.3
#> 51    UT Rio Grande Valley  WAC       21.5            51         54.3
#> 52             Cal Baptist  WAC       21.5            52         42.1
#> 53                 Memphis Amer       21.4            53         51.2
#> 54        UC Santa Barbara   BW       21.4            54         50.7
#> 55              Washington  P12       21.4            55         49.4
#> 56                Monmouth MAAC       21.4            56         47.8
#> 57                 Samford   SC       21.4            57         51.5
#> 58                 Detroit Horz       21.3            58         42.4
#> 59               Louisiana   SB       21.3            59         46.4
#> 60             Florida A&M MEAC       21.3            60         61.1
#> 61            San Jose St.  MWC       21.3            61         42.9
#> 62               Texas St.   SB       21.3            62         56.9
#> 63                   Rider MAAC       21.3            63         53.1
#> 64            Oklahoma St.  B12       21.3            64         52.5
#> 65                 Indiana  B10       21.3            65         55.6
#> 66                  Toledo  MAC       21.2            66         43.1
#> 67             Connecticut Amer       21.2            67         50.1
#> 68                 Oakland Horz       21.2            68         51.3
#> 69                Utah St.  MWC       21.1            69         50.2
#> 70      North Carolina A&T MEAC       21.1            70         55.0
#> 71              Murray St.  OVC       21.1            71         52.7
#> 72            Rhode Island  A10       21.1            72         55.7
#> 73              Georgetown   BE       21.1            73         53.1
#> 74                   Brown  Ivy       21.0            74         48.4
#> 75              Cincinnati Amer       21.0            75         51.9
#> 76        Central Michigan  MAC       21.0            76         49.6
#> 77           Southern Utah BSky       21.0            77         54.8
#> 78                 Arizona  P12       20.9            78         50.5
#> 79               Boise St.  MWC       20.9            79         46.3
#> 80                   Akron  MAC       20.9            80         42.3
#> 81                Ohio St.  B10       20.9            81         44.0
#> 82                Colorado  P12       20.9            82         47.3
#> 83             Jackson St. SWAC       20.8            83         59.3
#> 84              Providence   BE       20.8            84         48.7
#> 85                    UTEP CUSA       20.8            85         48.6
#> 86                 Stetson ASun       20.8            86         53.9
#> 87        Western Michigan  MAC       20.8            87         48.4
#> 88            UMass Lowell   AE       20.8            88         51.6
#> 89       Cal St. Fullerton   BW       20.8            89         52.2
#> 90           South Florida Amer       20.7            90         49.0
#> 91                Syracuse  ACC       20.7            91         46.6
#> 92              Pepperdine  WCC       20.7            92         47.9
#> 93                   Lamar Slnd       20.7            93         53.9
#> 94                 Hofstra  CAA       20.7            94         46.6
#> 95            Sacred Heart  NEC       20.6            95         48.5
#> 96             Austin Peay  OVC       20.6            96         52.0
#> 97               Charlotte CUSA       20.6            97         50.6
#> 98             Alabama A&M SWAC       20.5            98         54.4
#> 99                     LSU  SEC       20.5            99         54.1
#> 100 Southeast Missouri St.  OVC       20.4           100         51.3
#> 101              Loyola MD  Pat       20.4           101         52.5
#> 102             New Mexico  MWC       20.4           102         52.2
#> 103         Sacramento St. BSky       20.4           103         56.1
#> 104                 Denver  Sum       20.4           104         56.8
#> 105           Presbyterian BSth       20.3           105         51.7
#> 106                   Iona MAAC       20.3           106         46.6
#> 107                 Tulane Amer       20.3           107         46.0
#> 108       North Dakota St.  Sum       20.3           108         42.2
#> 109                   Utah  P12       20.3           109         49.8
#> 110            Norfolk St. MEAC       20.3           110         46.5
#> 111    Arkansas Pine Bluff SWAC       20.3           111         58.7
#> 112            Santa Clara  WCC       20.2           112         51.0
#> 113         UNC Wilmington  CAA       20.2           113         53.0
#> 114       Eastern Kentucky  OVC       20.2           114         48.3
#> 115            Stony Brook   AE       20.1           115         43.9
#> 116         Incarnate Word Slnd       20.1           116         51.8
#> 117             Texas Tech  B12       20.1           117         49.8
#> 118          James Madison  CAA       20.1           118         47.5
#> 119                    UAB CUSA       20.1           119         57.4
#> 120                Houston Amer       20.0           120         51.0
#> 121                 Albany   AE       20.0           121         44.1
#> 122                   Iowa  B10       20.0           122         49.6
#> 123            Wichita St. Amer       20.0           123         47.1
#> 124       Western Carolina   SC       20.0           124         43.2
#> 125           George Mason  A10       20.0           125         53.6
#> 126         Washington St.  P12       20.0           126         48.2
#> 127       Northwestern St. Slnd       19.9           127         48.8
#> 128             Wright St. Horz       19.9           128         51.9
#> 129            Alabama St. SWAC       19.9           129         48.3
#> 130               Oklahoma  B12       19.9           130         49.2
#> 131                 Temple Amer       19.9           131         50.6
#> 132      Southern Illinois  MVC       19.9           132         46.0
#> 133            Utah Valley  WAC       19.9           133         52.6
#> 134       Coastal Carolina   SB       19.9           134         52.0
#> 135            USC Upstate BSth       19.8           135         50.3
#> 136                  Siena MAAC       19.8           136         52.8
#> 137           Colorado St.  MWC       19.8           137         48.1
#> 138             Alcorn St. SWAC       19.7           138         46.8
#> 139         North Carolina  ACC       19.7           139         57.4
#> 140                Alabama  SEC       19.7           140         40.9
#> 141           Delaware St. MEAC       19.6           141         49.2
#> 142       Mount St. Mary's  NEC       19.6           142         49.1
#> 143       Georgia Southern   SB       19.6           143         49.8
#> 144               Southern SWAC       19.6           144         56.9
#> 145                   Duke  ACC       19.6           145         55.0
#> 146             Evansville  MVC       19.5           146         46.7
#> 147               Illinois  B10       19.5           147         57.3
#> 148             Seton Hall   BE       19.5           148         48.6
#> 149               Cal Poly   BW       19.5           149         51.4
#> 150     East Tennessee St.   SC       19.5           150         50.5
#> 151                   Rice CUSA       19.5           151         40.1
#> 152             Charleston  CAA       19.4           152         47.4
#> 153             Kansas St.  B12       19.4           153         49.5
#> 154       Tennessee Martin  OVC       19.4           154         50.4
#> 155                   Navy  Pat       19.4           155         50.6
#> 156              Air Force  MWC       19.3           156         45.0
#> 157               Longwood BSth       19.3           157         38.5
#> 158                 Howard MEAC       19.3           158         48.2
#> 159                Bradley  MVC       19.3           159         52.1
#> 160               UC Davis   BW       19.3           160         46.9
#> 161         St. Francis PA  NEC       19.2           161         55.4
#> 162         Long Beach St.   BW       19.2           162         54.5
#> 163         South Carolina  SEC       19.2           163         57.8
#> 164              Green Bay Horz       19.2           164         52.2
#> 165                   UNLV  MWC       19.2           165         49.5
#> 166              Idaho St. BSky       19.2           166         53.1
#> 167      Northern Kentucky Horz       19.1           167         46.8
#> 168                    USC  P12       19.1           168         53.3
#> 169                Florida  SEC       19.1           169         51.2
#> 170           Georgia Tech  ACC       19.0           170         58.5
#> 171        Sam Houston St. Slnd       19.0           171         51.5
#> 172               Portland  WCC       19.0           172         50.4
#> 173            McNeese St. Slnd       19.0           173         51.4
#> 174                 Hawaii   BW       19.0           174         49.8
#> 175      George Washington  A10       18.9           175         47.3
#> 176                   NJIT ASun       18.9           176         54.2
#> 177       Loyola Marymount  WCC       18.9           177         56.4
#> 178                 Wagner  NEC       18.8           178         51.6
#> 179                    SMU Amer       18.8           179         48.8
#> 180                Georgia  SEC       18.8           180         53.3
#> 181                Gonzaga  WCC       18.8           181         55.6
#> 182              Manhattan MAAC       18.8           182         48.4
#> 183                Wyoming  MWC       18.8           183         43.8
#> 184 North Carolina Central MEAC       18.8           184         54.0
#> 185                    LIU  NEC       18.8           185         44.4
#> 186                    VCU  A10       18.8           186         49.6
#> 187           Gardner Webb BSth       18.8           187         47.9
#> 188              San Diego  WCC       18.8           188         53.3
#> 189            Georgia St.   SB       18.8           189         48.5
#> 190           UT Arlington   SB       18.8           190         48.5
#> 191            Arizona St.  P12       18.8           191         51.5
#> 192         Loyola Chicago  MVC       18.7           192         56.4
#> 193              Milwaukee Horz       18.7           193         48.8
#> 194                Pacific  WCC       18.7           194         57.8
#> 195             St. John's   BE       18.6           195         54.7
#> 196       Louisiana Monroe   SB       18.6           196         51.4
#> 197                 DePaul   BE       18.6           197         57.3
#> 198 Texas A&M Corpus Chris Slnd       18.5           198         46.9
#> 199               La Salle  A10       18.5           199         46.2
#> 200            Saint Louis  A10       18.5           200         58.9
#> 201             Coppin St. MEAC       18.5           201         46.4
#> 202 Southeastern Louisiana Slnd       18.4           202         53.5
#> 203               Duquesne  A10       18.4           203         48.7
#> 204               Delaware  CAA       18.4           204         51.3
#> 205           Portland St. BSky       18.3           205         56.2
#> 206             Louisville  ACC       18.3           206         48.3
#> 207               Davidson  A10       18.3           207         44.3
#> 208                 Kansas  B12       18.3           208         56.4
#> 209       Northern Arizona BSky       18.2           209         52.2
#> 210                Harvard  Ivy       18.2           210         51.9
#> 211            Indiana St.  MVC       18.2           211         51.4
#> 212                    UCF Amer       18.2           212         50.9
#> 213    Central Connecticut  NEC       18.2           213         51.7
#> 214                   UMBC   AE       18.2           214         52.2
#> 215          UNC Asheville BSth       18.2           215         51.2
#> 216          Bowling Green  MAC       18.1           216         49.4
#> 217    Cal St. Bakersfield  WAC       18.1           217         59.4
#> 218         Saint Joseph's  A10       18.1           218         42.9
#> 219               Hartford   AE       18.1           219         46.7
#> 220         Youngstown St. Horz       18.0           220         51.7
#> 221           Michigan St.  B10       18.0           221         51.5
#> 222           Old Dominion CUSA       18.0           222         55.7
#> 223       SIU Edwardsville  OVC       18.0           223         56.7
#> 224               Miami FL  ACC       17.9           224         52.3
#> 225                 Bryant  NEC       17.9           225         46.6
#> 226            Florida St.  ACC       17.9           226         52.6
#> 227                  IUPUI Horz       17.9           227         48.5
#> 228                Vermont   AE       17.9           228         47.9
#> 229               Winthrop BSth       17.8           229         47.3
#> 230               Canisius MAAC       17.8           230         55.8
#> 231               Penn St.  B10       17.8           231         50.1
#> 232           Missouri St.  MVC       17.8           232         52.6
#> 233         New Mexico St.  WAC       17.7           233         44.5
#> 234                 Baylor  B12       17.7           234         50.0
#> 235       Middle Tennessee CUSA       17.7           235         46.0
#> 236           Saint Mary's  WCC       17.7           236         50.7
#> 237               Ball St.  MAC       17.6           237         43.0
#> 238     Cal St. Northridge   BW       17.6           238         52.1
#> 239                  Idaho BSky       17.6           239         60.3
#> 240         St. Francis NY  NEC       17.6           240         55.3
#> 241            The Citadel   SC       17.6           241         43.9
#> 242               Iowa St.  B12       17.6           242         52.9
#> 243                   UTSA CUSA       17.6           243         44.6
#> 244         William & Mary  CAA       17.6           244         50.8
#> 245          Massachusetts  A10       17.6           245         49.2
#> 246           Morehead St.  OVC       17.5           246         57.9
#> 247             Fresno St.  MWC       17.5           247         41.4
#> 248                   Troy   SB       17.5           248         44.7
#> 249           Oral Roberts  Sum       17.4           249         52.7
#> 250             Quinnipiac MAAC       17.4           250         38.0
#> 251    Fairleigh Dickinson  NEC       17.4           251         51.4
#> 252                 Marist MAAC       17.3           252         45.8
#> 253                Liberty ASun       17.3           253         50.8
#> 254                  Drake  MVC       17.3           254         50.4
#> 255           Jacksonville ASun       17.3           255         54.1
#> 256                   Yale  Ivy       17.2           256         47.0
#> 257       Jacksonville St.  OVC       17.2           257         54.0
#> 258                   Elon  CAA       17.2           258         39.3
#> 259                 Xavier   BE       17.2           259         55.4
#> 260                  Maine   AE       17.1           260         50.2
#> 261         Boston College  ACC       17.1           261         49.5
#> 262                   UMKC  WAC       17.1           262         52.3
#> 263       South Dakota St.  Sum       17.0           263         54.3
#> 264                 Butler   BE       17.0           264         53.1
#> 265                 Dayton  A10       17.0           265         52.9
#> 266          San Francisco  WCC       17.0           266         47.9
#> 267            North Texas CUSA       17.0           267         48.5
#> 268              Wisconsin  B10       17.0           268         44.3
#> 269        St. Bonaventure  A10       16.9           269         54.1
#> 270               Stanford  P12       16.9           270         52.5
#> 271                 Furman   SC       16.9           271         46.3
#> 272               Virginia  ACC       16.9           272         53.3
#> 273               Richmond  A10       16.8           273         51.2
#> 274                 Drexel  CAA       16.8           274         50.9
#> 275               Kent St.  MAC       16.8           275         50.8
#> 276           Northwestern  B10       16.7           276         55.1
#> 277                 Nevada  MWC       16.7           277         44.4
#> 278               Miami OH  MAC       16.7           278         47.3
#> 279          North Florida ASun       16.7           279         38.2
#> 280 Maryland Eastern Shore MEAC       16.7           280         52.7
#> 281          San Diego St.  MWC       16.7           281         46.7
#> 282                Radford BSth       16.6           282         51.1
#> 283             N.C. State  ACC       16.6           283         55.5
#> 284                Fordham  A10       16.6           284         46.6
#> 285              UC Irvine   BW       16.6           285         57.6
#> 286                   Ohio  MAC       16.6           286         47.7
#> 287               Lipscomb ASun       16.5           287         53.8
#> 288                Clemson  ACC       16.5           288         46.9
#> 289    Charleston Southern BSth       16.5           289         47.4
#> 290               Bucknell  Pat       16.5           290         47.1
#> 291         Nebraska Omaha  Sum       16.5           291         57.7
#> 292              Weber St. BSky       16.5           292         55.9
#> 293          Tennessee St.  OVC       16.5           293         52.2
#> 294            Chattanooga   SC       16.4           294         48.1
#> 295      Northern Illinois  MAC       16.4           295         50.6
#> 296       Illinois Chicago Horz       16.4           296         52.0
#> 297     Eastern Washington BSky       16.4           297         48.4
#> 298              Creighton   BE       16.3           298         46.0
#> 299               American  Pat       16.3           299         54.9
#> 300       Florida Atlantic CUSA       16.3           300         49.0
#> 301              Villanova   BE       16.2           301         43.2
#> 302           Nicholls St. Slnd       16.2           302         52.7
#> 303              Minnesota  B10       16.1           303         48.9
#> 304                Buffalo  MAC       16.1           304         53.3
#> 305                Rutgers  B10       16.1           305         60.5
#> 306           UC Riverside   BW       16.1           306         46.8
#> 307                 Lehigh  Pat       16.1           307         58.5
#> 308       Eastern Illinois  OVC       16.0           308         56.5
#> 309              Princeton  Ivy       16.0           309         47.1
#> 310          Northern Iowa  MVC       16.0           310         47.3
#> 311               Marshall CUSA       16.0           311         53.4
#> 312                Cornell  Ivy       16.0           312         51.8
#> 313             Valparaiso  MVC       15.9           313         49.9
#> 314                 Mercer   SC       15.8           314         51.9
#> 315               Nebraska  B10       15.7           315         50.3
#> 316                 Oregon  P12       15.7           316         50.0
#> 317              Dartmouth  Ivy       15.7           317         52.7
#> 318                 Purdue  B10       15.7           318         52.7
#> 319           Northeastern  CAA       15.6           319         50.0
#> 320                Niagara MAAC       15.6           320         49.8
#> 321          New Hampshire   AE       15.5           321         46.6
#> 322                    FIU CUSA       15.5           322         49.9
#> 323         Louisiana Tech CUSA       15.4           323         51.2
#> 324             Notre Dame  ACC       15.4           324         45.5
#> 325               Michigan  B10       15.3           325         52.8
#> 326              Merrimack  NEC       15.3           326         47.7
#> 327                Montana BSky       15.2           327         60.3
#> 328               Columbia  Ivy       15.1           328         55.1
#> 329       Western Illinois  Sum       15.1           329         49.0
#> 330          Southern Miss CUSA       15.1           330         61.0
#> 331           Illinois St.  MVC       15.0           331         46.2
#> 332                Colgate  Pat       15.0           332         45.4
#> 333               Campbell BSth       14.9           333         51.1
#> 334                    TCU  B12       14.8           334         45.8
#> 335 Mississippi Valley St. SWAC       14.7           335         49.2
#> 336                Wofford   SC       14.6           336         46.2
#> 337      Boston University  Pat       14.6           337         57.9
#> 338          Robert Morris  NEC       14.6           338         49.8
#> 339             Binghamton   AE       14.5           339         43.6
#> 340     Florida Gulf Coast ASun       14.5           340         50.6
#> 341             Holy Cross  Pat       14.4           341         53.8
#> 342              Lafayette  Pat       14.4           342         49.7
#> 343      Purdue Fort Wayne  Sum       14.3           343         49.0
#> 344          Virginia Tech  ACC       13.9           344         43.0
#> 345         UNC Greensboro   SC       13.7           345         50.4
#> 346                   Penn  Ivy       13.5           346         51.0
#> 347      Northern Colorado BSky       13.5           347         46.5
#> 348         Tennessee Tech  OVC       13.5           348         48.4
#> 349                    VMI   SC       13.2           349         41.4
#> 350                  Texas  B12       13.1           350         49.5
#> 351                   Army  Pat       13.0           351         57.5
#> 352                Belmont  OVC       12.9           352         50.9
#> 353                    BYU  WCC       12.3           353         48.5
#>     Off.FG_2.Pct.Rk Off.FG_3.Pct Off.FG_3.Pct.Rk Def.FT.Pct Def.FT.Pct.Rk
#> 1               230         24.8             307       23.1            26
#> 2               263         27.0             269       21.4            68
#> 3                51         20.4             349       19.6           131
#> 4                69         21.6             342       19.7           124
#> 5                50         20.5             347       19.8           118
#> 6               218         26.9             272       19.9           113
#> 7                40         20.7             346       20.5            88
#> 8                61         21.6             341       27.1             4
#> 9               245         28.0             241       18.3           202
#> 10              204         26.7             275       26.3             7
#> 11              299         30.0             189       23.2            24
#> 12              152         25.3             302       19.6           130
#> 13               25         19.6             351       26.4             6
#> 14              219         27.4             260       13.4           346
#> 15              281         29.9             193       16.6           272
#> 16              224         27.9             246       24.1            18
#> 17              268         29.6             210       27.3             2
#> 18              280         30.1             188       23.9            20
#> 19              283         30.2             184       19.2           147
#> 20              313         31.3             152       20.5            91
#> 21                3         16.6             353       22.2            48
#> 22               60         22.7             331       15.4           323
#> 23               90         24.3             312       18.3           197
#> 24              316         32.1             131       15.5           318
#> 25               52         22.3             337       18.7           176
#> 26               35         21.2             344       19.4           138
#> 27               46         22.1             339       15.4           321
#> 28              333         34.2              87       20.5            90
#> 29               55         22.6             332       24.6            15
#> 30              256         29.5             211       22.1            52
#> 31              129         25.8             290       18.0           216
#> 32              171         27.0             270       21.4            69
#> 33               66         23.5             321       20.1           109
#> 34              207         28.1             238       16.5           279
#> 35               59         23.0             327       21.2            75
#> 36              131         26.0             286       17.8           224
#> 37               71         23.7             318       21.4            67
#> 38              350         38.7              23       19.8           119
#> 39              114         25.7             291       18.6           177
#> 40              192         27.9             245       18.9           162
#> 41              103         25.3             300       21.1            77
#> 42              173         27.3             263       18.5           185
#> 43               28         21.3             343       22.9            33
#> 44              126         26.1             284       20.0           110
#> 45              194         28.2             235       19.1           153
#> 46               79         24.4             311       15.7           311
#> 47              117         26.1             285       24.0            19
#> 48              266         30.7             164       17.5           245
#> 49               15         20.5             348       20.4            99
#> 50              116         26.1             283       17.5           238
#> 51               67         24.2             313       23.2            25
#> 52              344         36.4              48       18.2           207
#> 53              160         27.4             261       22.6            38
#> 54              174         27.9             244       17.4           252
#> 55              217         29.2             218       20.4           100
#> 56              264         30.8             162       23.0            31
#> 57              143         27.1             265       13.1           350
#> 58              341         36.3              51       17.8           223
#> 59              303         32.3             126       19.0           158
#> 60                1         17.6             352       21.3            70
#> 61              339         35.7              62       18.1           210
#> 62               26         21.8             340       23.0            30
#> 63               93         25.7             292       17.4           251
#> 64              111         26.2             282       20.4            94
#> 65               43         23.1             326       18.8           168
#> 66              336         35.7              64       16.1           297
#> 67              191         28.7             227       21.6            63
#> 68              154         27.6             253       15.1           327
#> 69              189         28.6             228       16.9           264
#> 70               56         23.9             317       21.9            57
#> 71              106         26.2             281       19.4           139
#> 72               41         23.2             325       17.5           246
#> 73               92         25.9             287       16.1           295
#> 74              247         30.5             174       17.5           237
#> 75              134         27.1             266       18.9           163
#> 76              211         29.4             217       16.0           300
#> 77               62         24.2             314       22.2            46
#> 78              182         28.6             231       22.2            51
#> 79              305         32.8             110       17.4           250
#> 80              342         36.8              40       17.4           253
#> 81              328         35.0              75       18.0           214
#> 82              275         31.9             134       16.5           276
#> 83                8         19.8             350       24.3            17
#> 84              236         30.5             175       21.8            60
#> 85              238         30.6             169       19.8           122
#> 86               78         25.3             304       17.4           249
#> 87              250         30.8             163       17.9           218
#> 88              141         27.7             250       16.2           292
#> 89              119         27.0             267       20.7            85
#> 90              229         30.3             181       18.8           170
#> 91              296         32.7             116       18.6           181
#> 92              260         31.3             149       19.0           156
#> 93               77         25.4             299       15.8           307
#> 94              295         32.7             114       12.7           352
#> 95              243         30.9             159       14.5           332
#> 96              130         27.4             257       17.7           227
#> 97              180         28.9             222       15.6           313
#> 98               65         25.0             305       18.5           189
#> 99               72         25.4             297       15.5           319
#> 100             155         28.3             233       18.0           212
#> 101             110         27.0             268       18.8           171
#> 102             123         27.4             259       13.8           341
#> 103              37         23.5             320       22.1            53
#> 104              29         22.8             329       21.8            58
#> 105             138         27.9             243       19.7           123
#> 106             294         33.1             106       18.3           196
#> 107             309         33.7              96       16.3           288
#> 108             343         37.5              31       16.3           287
#> 109             200         29.9             195       14.4           336
#> 110             300         33.2             104       22.6            39
#> 111              10         21.0             345       24.3            16
#> 112             165         28.8             224       22.0            55
#> 113              95         26.8             274       18.2           208
#> 114             253         31.5             147       20.4            97
#> 115             330         36.0              55       17.0           261
#> 116             137         28.1             239       20.5            89
#> 117             203         30.1             186       21.0            78
#> 118             269         32.5             119       16.9           266
#> 119              22         22.5             334       16.2           293
#> 120             163         28.9             221       24.7            14
#> 121             327         35.9              60       16.6           274
#> 122             209         30.4             178       16.4           281
#> 123             277         32.9             108       23.1            27
#> 124             334         36.8              42       18.4           194
#> 125              82         26.4             277       17.0           263
#> 126             254         31.8             138       18.2           206
#> 127             234         31.3             151       21.6            65
#> 128             133         28.2             236       17.2           256
#> 129             251         31.8             140       19.7           127
#> 130             221         30.9             161       13.1           349
#> 131             176         29.5             214       18.5           186
#> 132             311         34.1              89       15.2           326
#> 133             108         27.5             254       21.3            71
#> 134             128         28.1             237       24.9            11
#> 135             187         29.8             198       21.0            79
#> 136              99         27.4             262       17.1           257
#> 137             257         32.1             132       14.5           333
#> 138             289         33.5              98       18.6           178
#> 139              21         22.8             330       18.3           198
#> 140             347         39.4              13       21.7            61
#> 141             223         31.2             156       22.4            42
#> 142             225         31.2             153       17.5           242
#> 143             202         30.6             170       16.5           277
#> 144              27         23.5             319       25.5             9
#> 145              57         25.4             294       18.5           191
#> 146             292         33.8              95       19.1           154
#> 147              23         23.2             324       15.5           317
#> 148             237         31.9             135       19.9           114
#> 149             150         29.1             219       23.1            28
#> 150             181         30.0             190       18.9           166
#> 151             348         40.5              10       16.2           294
#> 152             270         33.1             105       19.8           121
#> 153             215         31.1             158       21.5            66
#> 154             186         30.2             183       14.4           335
#> 155             178         30.0             191       16.8           268
#> 156             319         35.6              66       16.0           301
#> 157             351         42.2               6       18.8           167
#> 158             255         32.5             117       18.2           205
#> 159             125         28.6             229       20.1           107
#> 160             285         33.8              93       19.2           145
#> 161              47         25.3             301       16.4           286
#> 162              64         26.3             280       17.0           262
#> 163              16         22.9             328       30.0             1
#> 164             121         28.6             230       19.5           134
#> 165             213         31.3             150       22.9            34
#> 166              94         27.8             249       15.6           315
#> 167             287         34.0              91       18.4           195
#> 168              86         27.5             255       18.0           215
#> 169             159         29.8             203       20.4            95
#> 170              11         22.5             336       22.2            45
#> 171             144         29.5             215       24.7            13
#> 172             185         30.6             172       16.7           271
#> 173             149         29.6             206       17.8           225
#> 174             201         31.2             155       19.3           140
#> 175             274         33.8              94       17.6           235
#> 176              70         26.9             273       19.3           142
#> 177              34         24.7             308       21.2            73
#> 178             142         29.6             208       23.1            29
#> 179             232         32.4             122       17.5           243
#> 180              87         27.9             248       17.1           259
#> 181              44         25.6             293       13.8           342
#> 182             246         32.7             112       24.9            12
#> 183             331         37.4              32       20.3           103
#> 184              75         27.2             264       19.7           125
#> 185             324         36.8              41       16.9           265
#> 186             210         31.6             144       20.8            81
#> 187             261         33.3             101       18.5           190
#> 188              89         27.9             242       18.5           187
#> 189             239         32.7             115       26.6             5
#> 190             240         32.7             113       20.7            84
#> 191             146         29.8             202       19.2           149
#> 192              33         24.9             306       13.1           348
#> 193             233         32.5             118       23.7            21
#> 194              17         23.5             322       23.5            23
#> 195              63         26.6             276       20.4            98
#> 196             148         30.0             192       20.1           108
#> 197              24         24.1             315       21.3            72
#> 198             286         34.6              81       23.6            22
#> 199             308         35.3              70       22.8            36
#> 200               9         22.6             333       21.6            64
#> 201             302         35.1              73       17.5           239
#> 202              83         28.0             240       22.9            35
#> 203             235         32.9             109       16.7           270
#> 204             153         30.3             179       18.2           203
#> 205              36         25.4             295       17.8           220
#> 206             252         33.3             102       19.0           159
#> 207             326         37.4              34       19.0           157
#> 208              32         25.3             303       15.1           328
#> 209             118         29.5             213       16.1           296
#> 210             132         29.9             197       18.9           165
#> 211             151         30.5             177       18.8           169
#> 212             167         30.9             160       18.7           175
#> 213             139         30.2             185       17.8           221
#> 214             120         29.6             204       20.2           105
#> 215             158         30.7             165       18.2           204
#> 216             216         32.4             121       19.1           155
#> 217               7         22.5             335       26.1             8
#> 218             340         39.0              19       18.0           211
#> 219             290         35.2              72       18.3           199
#> 220             140         30.3             180       17.7           232
#> 221             145         30.5             176       19.2           146
#> 222              42         26.3             279       20.2           104
#> 223              30         25.4             298       22.5            40
#> 224             114         29.8             201       14.0           340
#> 225             297         35.5              68       17.8           226
#> 226             109         29.5             212       21.2            76
#> 227             242         33.7              97       16.4           282
#> 228             262         34.3              86       20.0           112
#> 229             276         34.9              77       21.7            62
#> 230              39         26.4             278       19.6           132
#> 231             193         32.1             130       19.0           160
#> 232             107         29.6             207       19.2           148
#> 233             322         37.8              29       19.1           152
#> 234             197         32.3             125       19.0           161
#> 235             312         36.3              50       20.4            96
#> 236             175         31.7             141       16.5           278
#> 237             337         39.3              15       17.7           229
#> 238             124         30.3             182       16.1           298
#> 239               6         22.1             338       16.4           280
#> 240              49         27.0             271       20.8            83
#> 241             329         38.5              24       15.4           322
#> 242              97         29.6             209       15.8           309
#> 243             321         37.8              28       20.6            87
#> 244             172         31.7             142       16.0           299
#> 245             220         33.2             103       18.6           182
#> 246              13         24.6             309       17.2           255
#> 247             346         41.1               8       17.7           231
#> 248             320         37.8              27       20.2           106
#> 249             104         29.9             196       18.5           192
#> 250             353         44.5               3       14.1           338
#> 251             147         31.2             154       17.5           240
#> 252             314         36.8              38       22.4            41
#> 253             169         31.8             137       17.9           219
#> 254             184         32.2             128       18.4           193
#> 255              73         28.6             232       18.0           213
#> 256             282         35.8              61       16.8           267
#> 257              76         28.8             223       15.9           305
#> 258             349         43.5               4       22.9            32
#> 259              48         27.5             256       18.5           188
#> 260             190         32.7             111       19.9           115
#> 261             212         33.4              99       17.5           244
#> 262             113         30.6             166       27.2             3
#> 263              68         28.7             226       15.5           316
#> 264              91         29.9             194       19.5           135
#> 265              96         30.1             187       17.6           234
#> 266             259         35.1              74       18.6           184
#> 267             244         34.6              83       21.2            74
#> 268             325         38.8              21       15.8           306
#> 269              74         29.0             220       18.7           172
#> 270             112         30.6             167       19.6           133
#> 271             304         36.8              43       16.0           302
#> 272              88         29.8             200       14.7           330
#> 273             156         32.0             133       17.7           230
#> 274             168         32.4             123       18.3           201
#> 275             170         32.4             120       20.7            86
#> 276              54         28.2             234       17.0           260
#> 277             323         38.8              20       21.8            59
#> 278             272         35.9              57       19.7           129
#> 279             352         45.1               2       16.4           284
#> 280             101         30.6             171       20.0           111
#> 281             291         36.6              46       19.7           126
#> 282             161         32.2             127       18.7           173
#> 283              45         27.9             246       20.3           101
#> 284             298         36.8              38       19.3           141
#> 285              19         25.8             288       22.2            49
#> 286             265         35.7              63       20.9            80
#> 287              81         29.6             205       15.3           324
#> 288             284         36.5              47       17.5           241
#> 289             271         36.1              53       16.4           285
#> 290             279         36.4              49       20.5            93
#> 291              18         25.8             289       17.1           258
#> 292              38         27.6             251       13.5           345
#> 293             122         31.4             148       22.7            37
#> 294             258         35.5              67       15.8           308
#> 295             177         33.0             107       19.8           120
#> 296             127         31.6             145       20.8            82
#> 297             248         35.2              71       19.4           136
#> 298             310         37.6              30       14.5           334
#> 299              58         28.8             225       20.5            92
#> 300             226         34.7              79       16.8           269
#> 301             335         40.6               9       14.7           331
#> 302             105         31.1             157       22.4            43
#> 303             231         35.0              76       17.8           222
#> 304              85         30.5             173       18.6           183
#> 305               4         23.4             323       17.9           217
#> 306             288         37.1              35       19.3           143
#> 307              12         25.4             296       18.3           200
#> 308              31         27.4             258       20.3           102
#> 309             278         36.9              37       16.2           290
#> 310             273         36.7              44       15.4           320
#> 311              84         30.6             168       22.0            54
#> 312             136         32.2             129       17.6           236
#> 313             199         34.2              88       17.4           248
#> 314             135         32.3             124       19.2           151
#> 315             188         34.0              92       12.4           353
#> 316             196         34.3              85       18.6           180
#> 317             100         31.6             145       16.2           291
#> 318             102         31.6             143       19.4           137
#> 319             195         34.4              84       17.7           233
#> 320             205         34.7              80       15.6           312
#> 321             293         37.8              26       22.2            47
#> 322             198         34.6              82       18.9           164
#> 323             157         33.4             100       19.7           128
#> 324             317         39.1              18       13.0           351
#> 325              98         31.9             136       16.3           289
#> 326             267         37.1              36       21.9            56
#> 327               5         24.5             310       25.5            10
#> 328              53         29.8             199       14.2           337
#> 329             227         35.9              58       19.2           144
#> 330               2         24.0             316       19.2           150
#> 331             306         38.8              22       17.7           228
#> 332             318         39.6              12       13.5           344
#> 333             162         34.1              90       22.4            44
#> 334             315         39.4              14       17.3           254
#> 335             222         36.0              54       18.6           179
#> 336             307         39.2              16       18.1           209
#> 337              14         27.6             252       14.9           329
#> 338             206         35.7              65       18.7           174
#> 339             332         41.9               7       15.8           310
#> 340             179         34.9              78       17.4           247
#> 341              80         31.8             139       16.5           275
#> 342             208         35.9              56       13.3           347
#> 343             228         36.7              45       16.4           283
#> 344             338         43.1               5       15.6           314
#> 345             183         35.9              59       19.8           117
#> 346             164         35.5              69       15.9           303
#> 347             301         40.0              11       15.3           325
#> 348             249         38.1              25       15.9           304
#> 349             345         45.4               1       22.2            50
#> 350             214         37.4              33       19.9           116
#> 351              20         29.4             216       13.7           343
#> 352             166         36.2              52       14.1           339
#> 353             241         39.2              17       16.6           273
#>     Def.FG_2.Pct Def.FG_2.Pct.Rk Def.FG_3.Pct Def.FG_3.Pct.Rk NCAA_Seed Year
#> 1           51.1             151         25.7             310        NA 2020
#> 2           45.0             326         33.6              85        NA 2020
#> 3           49.1             218         31.3             153         4 2020
#> 4           51.1             152         29.2             228        NA 2020
#> 5           53.5              77         26.7             295        NA 2020
#> 6           51.6             132         28.4             255        NA 2020
#> 7           53.3              87         26.2             300        NA 2020
#> 8           44.4             332         28.5             251        NA 2020
#> 9           41.7             349         40.0               6        NA 2020
#> 10          51.6             134         22.1             348        NA 2020
#> 11          54.7              51         22.1             349        NA 2020
#> 12          47.7             266         32.7             105        15 2020
#> 13          48.9             227         24.8             324        16 2020
#> 14          56.8              20         29.8             199        NA 2020
#> 15          41.5             352         41.9               1        NA 2020
#> 16          47.3             278         28.5             250        NA 2020
#> 17          47.0             289         25.7             314        NA 2020
#> 18          50.9             157         25.2             319        NA 2020
#> 19          48.5             237         32.3             122        NA 2020
#> 20          49.7             201         29.8             198         5 2020
#> 21          47.3             277         30.5             177        NA 2020
#> 22          52.5             109         32.2             127        NA 2020
#> 23          48.6             233         33.0              99        NA 2020
#> 24          50.4             173         34.1              72         3 2020
#> 25          48.8             229         32.5             113        NA 2020
#> 26          52.2             117         28.4             257        NA 2020
#> 27          43.7             338         40.9               3        NA 2020
#> 28          52.6             105         26.9             288        NA 2020
#> 29          45.7             312         29.7             201        12 2020
#> 30          50.9             158         27.0             284        NA 2020
#> 31          42.2             348         39.8               7        NA 2020
#> 32          49.2             214         29.4             214        NA 2020
#> 33          48.5             238         31.4             148        NA 2020
#> 34          51.8             124         31.7             139        NA 2020
#> 35          44.8             329         34.0              73        NA 2020
#> 36          45.8             310         36.4              26        NA 2020
#> 37          46.0             309         32.6             109        NA 2020
#> 38          51.3             146         28.9             242         9 2020
#> 39          50.2             187         31.2             156        NA 2020
#> 40          54.1              67         27.0             285        NA 2020
#> 41          55.2              38         23.7             340        NA 2020
#> 42          52.1             118         29.3             218        NA 2020
#> 43          49.0             221         28.1             266         6 2020
#> 44          45.7             311         34.3              66        11 2020
#> 45          45.3             318         35.6              42        NA 2020
#> 46          50.2             188         34.2              70        NA 2020
#> 47          51.8             125         24.2             335        NA 2020
#> 48          55.3              37         27.2             282        NA 2020
#> 49          48.3             246         31.3             152        NA 2020
#> 50          48.5             240         34.0              75        NA 2020
#> 51          47.2             284         29.5             208        NA 2020
#> 52          57.5              14         24.4             333        NA 2020
#> 53          48.6             234         28.8             245        NA 2020
#> 54          52.6             104         30.0             194        NA 2020
#> 55          47.3             279         32.3             118        NA 2020
#> 56          44.5             330         32.5             114        NA 2020
#> 57          46.7             296         40.3               4        NA 2020
#> 58          49.1             217         33.1              97        NA 2020
#> 59          51.6             135         29.4             213        NA 2020
#> 60          54.0              68         24.6             328        NA 2020
#> 61          53.3              83         28.5             254        NA 2020
#> 62          48.7             231         28.3             260        NA 2020
#> 63          46.7             294         35.9              36        NA 2020
#> 64          45.7             314         33.9              78        NA 2020
#> 65          49.6             205         31.6             142        10 2020
#> 66          50.6             166         33.4              91        NA 2020
#> 67          53.4              81         25.0             321        NA 2020
#> 68          48.8             230         36.1              32        NA 2020
#> 69          46.7             295         36.4              27        11 2020
#> 70          50.4             170         27.7             276        NA 2020
#> 71          51.3             144         29.3             220        NA 2020
#> 72          53.3              84         29.2             229        NA 2020
#> 73          46.2             307         37.7              13        NA 2020
#> 74          51.6             131         30.8             167        NA 2020
#> 75          50.0             195         31.1             160        12 2020
#> 76          48.9             225         35.1              48        NA 2020
#> 77          50.4             175         27.4             280        NA 2020
#> 78          47.6             271         30.3             186         7 2020
#> 79          54.2              65         28.4             256        NA 2020
#> 80          53.7              74         29.0             238        13 2020
#> 81          47.6             270         34.4              61         5 2020
#> 82          54.2              66         29.3             219         8 2020
#> 83          50.4             176         25.3             318        NA 2020
#> 84          49.8             197         28.4             258         8 2020
#> 85          52.6             106         27.7             275        NA 2020
#> 86          42.4             345         40.2               5        NA 2020
#> 87          51.3             147         30.8             166        NA 2020
#> 88          54.5              57         29.3             222        NA 2020
#> 89          53.2              91         26.2             301        NA 2020
#> 90          49.3             212         31.9             134        NA 2020
#> 91          42.4             344         39.0               9        NA 2020
#> 92          49.0             222         32.0             132        NA 2020
#> 93          51.6             133         32.6             107        NA 2020
#> 94          58.0               8         29.2             227        14 2020
#> 95          54.7              49         30.8             168        NA 2020
#> 96          53.3              85         28.9             240        NA 2020
#> 97          52.4             111         32.0             133        NA 2020
#> 98          54.5              58         27.0             286        NA 2020
#> 99          47.9             259         36.6              22         8 2020
#> 100         51.0             156         31.0             162        NA 2020
#> 101         50.1             190         31.2             159        NA 2020
#> 102         49.8             200         36.4              25        NA 2020
#> 103         54.3              62         23.6             342        NA 2020
#> 104         47.2             285         31.0             164        NA 2020
#> 105         44.1             337         36.2              30        NA 2020
#> 106         46.3             304         35.3              45        NA 2020
#> 107         48.6             235         35.1              47        NA 2020
#> 108         58.1               7         25.6             315        15 2020
#> 109         53.9              69         31.8             138        NA 2020
#> 110         46.5             302         31.0             163        NA 2020
#> 111         49.0             219         26.6             297        NA 2020
#> 112         51.1             153         27.0             287        NA 2020
#> 113         51.7             127         30.1             192        NA 2020
#> 114         53.7              76         25.9             308        NA 2020
#> 115         45.2             322         37.8              12        NA 2020
#> 116         52.8             101         26.7             293        NA 2020
#> 117         50.7             164         28.3             259        10 2020
#> 118         47.5             272         35.6              40        NA 2020
#> 119         47.7             268         36.1              31        NA 2020
#> 120         46.2             306         29.1             232         7 2020
#> 121         48.9             224         34.5              60        NA 2020
#> 122         51.0             155         32.5             112         6 2020
#> 123         49.3             213         27.6             277        11 2020
#> 124         50.4             177         31.3             155        NA 2020
#> 125         52.9              99         30.2             191        NA 2020
#> 126         57.1              17         24.8             325        NA 2020
#> 127         48.2             250         30.3             188        NA 2020
#> 128         57.1              16         25.7             313        NA 2020
#> 129         53.7              75         26.7             294        NA 2020
#> 130         49.3             210         37.6              14        10 2020
#> 131         47.2             282         34.2              67        NA 2020
#> 132         55.5              35         29.3             215        NA 2020
#> 133         54.6              53         24.1             338        NA 2020
#> 134         41.5             353         33.6              84        NA 2020
#> 135         47.7             267         31.4             150        NA 2020
#> 136         54.4              61         28.5             252        16 2020
#> 137         49.2             216         36.3              28        NA 2020
#> 138         55.6              31         25.7             312        NA 2020
#> 139         47.1             287         34.6              57        NA 2020
#> 140         51.7             129         26.6             298        NA 2020
#> 141         46.9             291         30.7             172        NA 2020
#> 142         50.2             180         32.3             121        NA 2020
#> 143         54.8              45         28.7             247        NA 2020
#> 144         51.3             143         23.1             345        NA 2020
#> 145         60.2               4         21.4             350         3 2020
#> 146         56.8              21         24.2             337        NA 2020
#> 147         55.5              33         28.9             239         7 2020
#> 148         51.1             154         29.0             235         3 2020
#> 149         47.9             260         29.0             236        NA 2020
#> 150         51.5             137         29.6             207        11 2020
#> 151         52.5             110         31.4             149        NA 2020
#> 152         49.6             203         30.6             175        NA 2020
#> 153         47.0             288         31.5             147        NA 2020
#> 154         49.8             198         35.8              38        NA 2020
#> 155         48.8             228         34.4              62        NA 2020
#> 156         42.9             341         41.1               2        NA 2020
#> 157         45.1             323         36.0              34        NA 2020
#> 158         52.1             121         29.7             203        NA 2020
#> 159         44.3             333         35.6              41        14 2020
#> 160         50.8             160         30.0             195        NA 2020
#> 161         51.3             148         32.4             116        NA 2020
#> 162         48.3             245         34.7              54        NA 2020
#> 163         42.6             343         27.4             278        NA 2020
#> 164         48.3             247         32.2             126        NA 2020
#> 165         43.4             339         33.7              82        NA 2020
#> 166         63.2               3         21.2             351        NA 2020
#> 167         55.1              40         26.5             299        15 2020
#> 168         48.0             257         34.0              74         9 2020
#> 169         50.7             162         28.9             243         9 2020
#> 170         53.4              82         24.4             332        NA 2020
#> 171         45.0             327         30.3             184        NA 2020
#> 172         49.8             199         33.5              86        NA 2020
#> 173         47.4             276         34.8              51        NA 2020
#> 174         57.7              11         22.9             346        NA 2020
#> 175         57.7              12         24.7             326        NA 2020
#> 176         52.1             120         28.6             249        NA 2020
#> 177         44.4             331         34.3              64        NA 2020
#> 178         42.4             346         34.6              58        NA 2020
#> 179         45.3             319         37.2              16        NA 2020
#> 180         55.6              32         27.3             281        NA 2020
#> 181         56.6              23         29.6             206         1 2020
#> 182         48.0             256         27.1             283        NA 2020
#> 183         46.6             297         33.1              96        NA 2020
#> 184         50.8             159         29.5             209        16 2020
#> 185         53.5              78         29.6             205        NA 2020
#> 186         50.2             184         29.0             237        NA 2020
#> 187         46.9             290         34.6              58        NA 2020
#> 188         56.8              19         24.6             329        NA 2020
#> 189         48.4             241         25.0             323        NA 2020
#> 190         53.2              89         26.1             304        NA 2020
#> 191         49.6             204         31.2             157        10 2020
#> 192         47.4             274         39.4               8        NA 2020
#> 193         48.1             254         28.2             262        NA 2020
#> 194         47.7             264         28.8             246        NA 2020
#> 195         46.5             303         33.1              94        NA 2020
#> 196         50.4             171         29.5             210        NA 2020
#> 197         45.3             317         33.4              89        NA 2020
#> 198         50.7             163         25.7             311        NA 2020
#> 199         50.4             172         26.7             291        NA 2020
#> 200         45.5             316         32.9             102        NA 2020
#> 201         47.9             262         34.6              56        NA 2020
#> 202         51.6             130         25.5             316        NA 2020
#> 203         54.4              60         28.9             241        NA 2020
#> 204         48.4             242         33.4              88        NA 2020
#> 205         57.9              10         24.3             334        NA 2020
#> 206         47.7             263         33.3              92         4 2020
#> 207         50.8             161         30.2             190        NA 2020
#> 208         48.3             248         36.6              21         1 2020
#> 209         52.3             114         31.6             143        NA 2020
#> 210         50.5             168         30.6             173        NA 2020
#> 211         53.1              96         28.2             265        NA 2020
#> 212         51.5             136         29.7             200        NA 2020
#> 213         48.4             243         33.8              80        NA 2020
#> 214         44.2             334         35.6              43        NA 2020
#> 215         56.5              25         25.4             317        NA 2020
#> 216         49.2             215         31.7             140        NA 2020
#> 217         41.6             351         32.2             124        NA 2020
#> 218         53.2              92         28.8             244        NA 2020
#> 219         53.8              72         27.9             272        NA 2020
#> 220         53.8              71         28.5             253        NA 2020
#> 221         50.4             174         30.3             181         3 2020
#> 222         41.7             350         38.0              11        NA 2020
#> 223         46.8             292         30.7             170        NA 2020
#> 224         55.8              30         30.3             187        NA 2020
#> 225         53.2              93         29.1             234        NA 2020
#> 226         46.7             293         32.1             128         2 2020
#> 227         49.7             202         33.9              77        NA 2020
#> 228         45.0             325         35.0              49        13 2020
#> 229         50.2             181         28.0             267        16 2020
#> 230         51.3             145         29.1             231        NA 2020
#> 231         53.1              95         28.0             271         6 2020
#> 232         48.9             226         31.9             135        NA 2020
#> 233         51.1             150         29.7             202        13 2020
#> 234         51.8             126         29.3             223         1 2020
#> 235         51.4             141         28.2             264        NA 2020
#> 236         56.8              22         26.8             290         8 2020
#> 237         54.2              63         28.0             269        NA 2020
#> 238         47.6             269         36.3              29        NA 2020
#> 239         52.7             102         30.9             165        NA 2020
#> 240         51.3             142         27.9             273        NA 2020
#> 241         50.3             178         34.3              63        NA 2020
#> 242         52.0             122         32.2             123        NA 2020
#> 243         47.4             275         32.0             131        NA 2020
#> 244         51.9             123         32.1             129        NA 2020
#> 245         56.3              28         25.1             320        NA 2020
#> 246         52.4             112         30.4             178        NA 2020
#> 247         45.0             324         37.3              15        NA 2020
#> 248         48.7             232         31.2             158        NA 2020
#> 249         50.2             185         31.3             151        NA 2020
#> 250         52.5             107         33.4              90        NA 2020
#> 251         49.9             196         32.6             111        NA 2020
#> 252         42.8             342         34.7              53        NA 2020
#> 253         50.2             182         31.9             136        12 2020
#> 254         45.6             315         36.0              35        NA 2020
#> 255         50.2             186         31.8             137        NA 2020
#> 256         50.2             179         32.9             101        12 2020
#> 257         53.8              70         30.3             183        NA 2020
#> 258         43.3             340         33.8              81        NA 2020
#> 259         52.4             113         29.1             230        NA 2020
#> 260         45.0             328         35.1              46        NA 2020
#> 261         52.1             119         30.4             179        NA 2020
#> 262         50.2             183         22.6             347        NA 2020
#> 263         54.5              55         29.9             196        NA 2020
#> 264         47.5             273         33.0             100         5 2020
#> 265         53.3              86         29.1             233         1 2020
#> 266         54.7              50         26.7             292        NA 2020
#> 267         48.1             253         30.7             171        13 2020
#> 268         54.9              42         29.3             223         4 2020
#> 269         44.2             335         37.1              17        NA 2020
#> 270         51.2             149         29.2             225        NA 2020
#> 271         51.4             140         32.6             108        NA 2020
#> 272         48.2             249         37.0              18         7 2020
#> 273         50.0             194         32.3             117        11 2020
#> 274         58.1               6         23.6             341        NA 2020
#> 275         49.0             223         30.4             180        NA 2020
#> 276         46.5             301         36.5              24        NA 2020
#> 277         45.2             321         32.9             104        NA 2020
#> 278         47.3             280         33.1              98        NA 2020
#> 279         64.3               2         19.3             352        NA 2020
#> 280         49.3             209         30.7             169        NA 2020
#> 281         46.3             305         34.0              76         2 2020
#> 282         45.2             320         36.1              33        NA 2020
#> 283         53.7              73         26.0             306        11 2020
#> 284         44.1             336         36.5              23        NA 2020
#> 285         47.3             281         30.6             176        14 2020
#> 286         46.6             299         32.6             110        NA 2020
#> 287         50.0             193         34.7              52        NA 2020
#> 288         45.7             313         36.8              20        NA 2020
#> 289         54.2              64         29.4             212        NA 2020
#> 290         54.6              54         25.0             322        NA 2020
#> 291         49.0             220         33.9              79        NA 2020
#> 292         56.3              29         30.3             189        NA 2020
#> 293         48.0             258         29.3             217        NA 2020
#> 294         54.9              43         29.3             216        NA 2020
#> 295         46.1             308         34.2              71        NA 2020
#> 296         50.5             167         28.7             248        NA 2020
#> 297         54.5              55         26.0             305        15 2020
#> 298         53.2              88         32.3             119         2 2020
#> 299         55.3              36         24.2             336        NA 2020
#> 300         51.7             128         31.5             144        NA 2020
#> 301         57.9               9         27.4             279         2 2020
#> 302         52.9              98         24.7             327        NA 2020
#> 303         56.4              27         25.8             309        NA 2020
#> 304         54.7              52         26.8             289        NA 2020
#> 305         46.6             298         35.5              44         9 2020
#> 306         50.1             189         30.6             174        NA 2020
#> 307         48.5             239         33.3              93        NA 2020
#> 308         51.5             139         28.2             263        NA 2020
#> 309         57.6              13         26.1             302        NA 2020
#> 310         52.2             116         32.4             115        NA 2020
#> 311         50.0             192         28.0             267        NA 2020
#> 312         48.2             252         34.3              65        NA 2020
#> 313         52.2             115         30.3             182        NA 2020
#> 314         49.6             206         31.3             154        NA 2020
#> 315         54.5              59         33.1              95        NA 2020
#> 316         47.2             286         34.2              68         4 2020
#> 317         47.9             261         35.9              37        NA 2020
#> 318         47.7             265         32.9             103        NA 2020
#> 319         52.5             108         29.8             197        NA 2020
#> 320         49.4             208         35.0              50        NA 2020
#> 321         48.3             244         29.5             211        NA 2020
#> 322         55.1              39         26.0             307        NA 2020
#> 323         48.0             255         32.3             120        NA 2020
#> 324         53.4              80         33.5              87        NA 2020
#> 325         59.2               5         24.5             330         6 2020
#> 326         54.8              46         23.2             344        NA 2020
#> 327         50.7             165         23.9             339        NA 2020
#> 328         53.2              90         32.6             106        NA 2020
#> 329         51.5             138         29.2             225        NA 2020
#> 330         42.3             347         38.6              10        NA 2020
#> 331         50.0             191         32.2             125        NA 2020
#> 332         54.8              44         31.7             141        NA 2020
#> 333         53.1              94         24.5             331        NA 2020
#> 334         53.4              79         29.3             221        NA 2020
#> 335         54.7              48         26.7             296        NA 2020
#> 336         47.2             283         34.6              55        NA 2020
#> 337         54.8              47         30.3             185        16 2020
#> 338         53.0              97         28.3             261        16 2020
#> 339         52.8             100         31.5             146        NA 2020
#> 340         50.5             169         32.1             130        NA 2020
#> 341         55.5              34         28.0             270        NA 2020
#> 342         56.6              24         30.0             193        NA 2020
#> 343         49.4             207         34.2              69        NA 2020
#> 344         48.6             235         35.8              39        NA 2020
#> 345         46.5             300         33.6              83        NA 2020
#> 346         56.4              26         27.7             274        NA 2020
#> 347         67.1               1         17.6             353        NA 2020
#> 348         52.6             103         31.5             145        NA 2020
#> 349         48.2             251         29.7             204        NA 2020
#> 350         56.9              18         23.2             343        NA 2020
#> 351         49.3             211         37.0              19        NA 2020
#> 352         54.9              41         31.0             161        14 2020
#> 353         57.3              15         26.1             303         5 2020
# }
# \donttest{
try(kp_height(min_year = 2020, max_year = 2021))
#> ✖ 2026-10-26 19:19:03.186808: Invalid arguments or no height data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf Avg.Hgt Avg.Hgt.Rk Eff.Hgt Eff.Hgt.Rk C.Hgt
#> 1              Florida St.  ACC    79.0          1     1.4         27   1.6
#> 2         Eastern Michigan  MAC    78.8          2     2.3          4   2.4
#> 3                  Gonzaga  WCC    78.8          3     2.0          7   1.7
#> 4               Washington  P12    78.7          4     1.4         33   0.5
#> 5               Seton Hall   BE    78.7          5     3.2          1   4.6
#> 6             Northwestern  B10    78.7          6     1.9         14   1.0
#> 7          Mississippi St.  SEC    78.7          7     1.9         15   1.7
#> 8                Villanova   BE    78.6          8     0.8         67   0.0
#> 9         Central Arkansas Slnd    78.6          9     1.6         20   2.5
#> 10                Utah St.  MWC    78.4         10     0.9         59   2.0
#> 11                Syracuse  ACC    78.4         11     1.5         24   1.1
#> 12                 Arizona  P12    78.3         12     1.9          9   2.1
#> 13              Oregon St.  P12    78.3         13     1.4         30   2.8
#> 14                  Purdue  B10    78.3         14     2.2          5   2.8
#> 15                 Harvard  Ivy    78.3         15     1.2         41   1.1
#> 16              Notre Dame  ACC    78.3         16     1.5         22   1.4
#> 17             Santa Clara  WCC    78.3         17     1.3         39   0.9
#> 18              Cincinnati Amer    78.3         18     2.1          6   3.2
#> 19                 Indiana  B10    78.3         19     1.3         38   1.2
#> 20          North Carolina  ACC    78.3         20     1.2         44   0.6
#> 21                   Maine   AE    78.2         21     0.3        112  -0.5
#> 22                    Duke  ACC    78.2         22     1.1         50   0.9
#> 23                  Xavier   BE    78.2         23     0.7         75   0.0
#> 24                  Kansas  B12    78.2         24     1.3         37   2.4
#> 25          South Carolina  SEC    78.2         25     0.9         63   2.0
#> 26          Long Beach St.   BW    78.2         26     1.9         12   1.9
#> 27        Loyola Marymount  WCC    78.2         27    -0.3        227  -1.0
#> 28                    Utah  P12    78.1         28     1.6         21   1.7
#> 29                     USC  P12    78.1         29     2.0          8   1.7
#> 30              New Mexico  MWC    78.1         30     0.8         69   0.3
#> 31                Kentucky  SEC    78.0         31     1.8         17   1.7
#> 32                Davidson  A10    78.0         32     0.4        103   0.4
#> 33                    UCLA  P12    78.0         33     1.5         26   0.8
#> 34                 Rutgers  B10    78.0         34     0.3        110   1.0
#> 35               Boise St.  MWC    78.0         35     0.7         76   0.8
#> 36            San Jose St.  MWC    77.9         36     0.5         97   0.5
#> 37            Oklahoma St.  B12    77.9         37     0.4        108   0.5
#> 38               Tennessee  SEC    77.9         38    -0.3        222  -0.2
#> 39          Boston College  ACC    77.9         39     0.7         79   0.4
#> 40                Delaware  CAA    77.9         40     0.6         91   1.2
#> 41           East Carolina Amer    77.9         41     0.1        140   0.1
#> 42                Missouri  SEC    77.9         42     1.0         57   1.0
#> 43                  Hawaii   BW    77.8         43     1.3         35   1.5
#> 44           San Francisco  WCC    77.8         44     1.9         11   2.1
#> 45         St. Bonaventure  A10    77.8         45     0.9         61   0.8
#> 46        Tennessee Martin  OVC    77.8         46     0.5         95   1.0
#> 47               Minnesota  B10    77.8         47     1.1         45   0.8
#> 48                     TCU  B12    77.8         48     0.4        101   1.4
#> 49                Oklahoma  B12    77.8         49     0.2        120   0.2
#> 50                Virginia  ACC    77.8         50     2.4          3   2.9
#> 51                Stanford  P12    77.8         51     0.8         68   0.3
#> 52             Montana St. BSky    77.7         52     1.0         56   1.0
#> 53                    Iowa  B10    77.7         53     1.6         19   1.8
#> 54                  Oregon  P12    77.7         54     0.1        147  -0.2
#> 55          William & Mary  CAA    77.7         55     1.9         10   2.6
#> 56                   Texas  B12    77.7         56     1.1         48   1.0
#> 57           James Madison  CAA    77.7         57    -0.4        238  -1.0
#> 58                 Wyoming  MWC    77.7         58    -0.3        220  -0.3
#> 59                    UTEP CUSA    77.7         59     0.8         70   0.8
#> 60           Grambling St. SWAC    77.7         60     1.5         23   1.9
#> 61                    Ohio  MAC    77.6         61     0.9         60   0.9
#> 62           West Virginia  B12    77.6         62     0.8         66   0.9
#> 63                     UCF Amer    77.6         63     0.4        104   1.8
#> 64            UC Riverside   BW    77.6         64     1.9         13   2.8
#> 65                Michigan  B10    77.6         65     2.6          2   3.2
#> 66               Fairfield MAAC    77.6         66     0.2        133  -0.2
#> 67            North Dakota  Sum    77.6         67     0.6         92   0.0
#> 68        Northern Arizona BSky    77.6         68    -0.1        172  -0.2
#> 69            Missouri St.  MVC    77.6         69    -0.1        178  -1.0
#> 70              Georgetown   BE    77.5         70     1.6         18   2.6
#> 71            Michigan St.  B10    77.5         71     0.3        116  -0.2
#> 72              Coppin St. MEAC    77.5         72     1.1         46   2.3
#> 73               Idaho St. BSky    77.5         73    -0.8        287  -1.2
#> 74                     BYU  WCC    77.5         74    -0.3        223  -0.7
#> 75        UC Santa Barbara   BW    77.5         75     1.4         34   1.0
#> 76              Providence   BE    77.5         76     0.4        107   0.3
#> 77           Southern Utah BSky    77.5         77     0.4        105   0.4
#> 78                     LSU  SEC    77.5         78    -0.7        271  -0.6
#> 79       Purdue Fort Wayne  Sum    77.5         79     0.1        152   0.6
#> 80                  Lehigh  Pat    77.5         80     0.2        125   0.5
#> 81                 Clemson  ACC    77.5         81     0.0        164  -0.2
#> 82        Louisiana Monroe   SB    77.5         82     1.4         28   1.7
#> 83                    Rice CUSA    77.5         83     0.2        122  -0.5
#> 84                Illinois  B10    77.4         84     1.0         55   2.1
#> 85           Massachusetts  A10    77.4         85     0.5         96   0.2
#> 86          Saint Joseph's  A10    77.4         86    -0.1        181  -0.1
#> 87                  Toledo  MAC    77.4         87     0.8         71   1.9
#> 88                 Florida  SEC    77.4         88     0.1        149   1.1
#> 89                   Siena MAAC    77.4         89    -0.2        205  -0.6
#> 90                 Belmont  OVC    77.4         90     1.0         54   1.8
#> 91            Georgia Tech  ACC    77.4         91     1.4         29   1.0
#> 92                Marshall CUSA    77.4         92     1.0         51   0.7
#> 93          Washington St.  P12    77.4         93    -0.1        173   0.3
#> 94              Pittsburgh  ACC    77.4         94    -0.2        194   0.3
#> 95                     SMU Amer    77.4         95     0.6         94  -0.1
#> 96                 Houston Amer    77.4         96    -0.3        213  -0.3
#> 97                Maryland  B10    77.4         97     0.3        119   0.7
#> 98                  Towson  CAA    77.3         98     0.1        146  -0.4
#> 99               Texas A&M  SEC    77.3         99     0.1        144   0.0
#> 100                 DePaul   BE    77.3        100     0.9         62   0.4
#> 101                Oakland Horz    77.3        101     0.3        114   0.4
#> 102               Colorado  P12    77.3        102     0.5         98   0.5
#> 103           Old Dominion CUSA    77.3        103    -0.2        198  -0.4
#> 104                 Auburn  SEC    77.3        104     0.0        161   0.1
#> 105      Boston University  Pat    77.3        105     0.1        155   0.0
#> 106              San Diego  WCC    77.3        106    -0.1        190  -0.5
#> 107              UC Irvine   BW    77.3        107     1.4         32   1.1
#> 108                   Yale  Ivy    77.3        108     1.2         40   0.8
#> 109                   UMBC   AE    77.3        109     1.1         49   0.8
#> 110             N.C. State  ACC    77.3        110     1.0         53   1.4
#> 111             St. John's   BE    77.3        111    -0.5        249  -0.6
#> 112             Holy Cross  Pat    77.2        112     0.2        137   0.2
#> 113               Penn St.  B10    77.2        113     0.4        109   0.0
#> 114                 Butler   BE    77.2        114     0.0        163  -0.1
#> 115            Wake Forest  ACC    77.2        115     1.4         31   1.9
#> 116                 Temple Amer    77.2        116     0.4        102   0.0
#> 117                  Tulsa Amer    77.2        117    -0.2        195  -0.5
#> 118                Pacific  WCC    77.2        118     0.0        159   1.0
#> 119          Northern Iowa  MVC    77.2        119     0.2        136   0.5
#> 120            Mississippi  SEC    77.2        120     0.2        128   0.2
#> 121                 Marist MAAC    77.2        121    -0.5        250  -0.7
#> 122             Quinnipiac MAAC    77.2        122     0.6         93   0.4
#> 123             Kansas St.  B12    77.2        123     0.3        115   0.0
#> 124              Marquette   BE    77.2        124     0.7         73   0.8
#> 125                   Iona MAAC    77.1        125     0.7         88   0.2
#> 126                Vermont   AE    77.1        126    -0.5        239  -0.1
#> 127              Wisconsin  B10    77.1        127     1.2         43   1.6
#> 128         UNC Greensboro   SC    77.1        128     1.0         52   0.8
#> 129             California  P12    77.1        129     0.9         65   0.6
#> 130              Air Force  MWC    77.1        130    -0.6        256  -1.3
#> 131            Arizona St.  P12    77.1        131     0.3        118  -0.6
#> 132      Cal St. Fullerton   BW    77.1        132    -0.5        245  -0.6
#> 133               Bucknell  Pat    77.1        133    -0.8        281  -0.8
#> 134                    VCU  A10    77.1        134    -1.1        312  -1.5
#> 135           Saint Mary's  WCC    77.1        135     0.0        167  -0.5
#> 136                Alabama  SEC    77.1        136     0.2        126   0.0
#> 137       Illinois Chicago Horz    77.1        137     0.5        100   0.1
#> 138            Cal Baptist  WAC    77.1        138     0.5         99   0.9
#> 139              Lafayette  Pat    77.0        139     0.7         77   0.4
#> 140           Illinois St.  MVC    77.0        140    -0.2        196  -0.4
#> 141              Milwaukee Horz    77.0        141     0.1        148  -0.4
#> 142               Nebraska  B10    77.0        142    -0.4        233  -0.5
#> 143      George Washington  A10    77.0        143     0.1        151  -0.2
#> 144               Iowa St.  B12    77.0        144     0.4        106   0.4
#> 145         Loyola Chicago  MVC    77.0        145    -0.1        184  -0.1
#> 146            Connecticut Amer    77.0        146     1.2         42   1.0
#> 147       Central Michigan  MAC    77.0        147    -0.6        260  -1.2
#> 148             Evansville  MVC    77.0        148     0.0        162  -0.7
#> 149             Louisville  ACC    77.0        149     0.7         85   1.1
#> 150           Nicholls St. Slnd    77.0        150    -0.3        221  -0.8
#> 151       Florida Atlantic CUSA    77.0        151     1.1         47   1.4
#> 152               Miami FL  ACC    77.0        152     1.8         16   2.1
#> 153                Colgate  Pat    77.0        153     1.5         25   1.0
#> 154                    UAB CUSA    77.0        154     0.9         64   1.0
#> 155                Hampton BSth    77.0        155    -0.9        291  -1.2
#> 156             Texas Tech  B12    76.9        156    -1.3        326  -1.8
#> 157           UMass Lowell   AE    76.9        157    -1.1        311  -2.0
#> 158                 Drexel  CAA    76.9        158    -0.2        203  -0.4
#> 159                Cornell  Ivy    76.9        159     0.1        143  -0.7
#> 160             Vanderbilt  SEC    76.9        160     0.7         86   0.5
#> 161          South Florida Amer    76.9        161     0.7         82   2.0
#> 162                 Albany   AE    76.9        162    -0.1        182  -0.4
#> 163         St. Francis PA  NEC    76.9        163    -0.1        183   0.1
#> 164                Stetson ASun    76.9        164     0.1        141   0.3
#> 165       South Dakota St.  Sum    76.9        165    -0.5        241  -1.2
#> 166                 Tulane Amer    76.9        166     0.3        117   0.5
#> 167          North Florida ASun    76.9        167    -0.8        278  -1.8
#> 168             Fresno St.  MWC    76.9        168     0.2        132   0.4
#> 169    Cal St. Bakersfield  WAC    76.9        169    -0.2        201  -0.3
#> 170                 Nevada  MWC    76.9        170     0.7         74   0.8
#> 171              Princeton  Ivy    76.9        171    -0.1        189  -0.5
#> 172                   Elon  CAA    76.9        172    -1.3        329  -1.9
#> 173                 Howard MEAC    76.9        173    -0.5        246  -0.6
#> 174          New Hampshire   AE    76.9        174    -1.9        349  -2.3
#> 175           Rhode Island  A10    76.9        175    -0.1        176  -1.0
#> 176          Tennessee St.  OVC    76.9        176     0.7         87   0.0
#> 177             Murray St.  OVC    76.9        177     0.0        168   0.1
#> 178     Florida Gulf Coast ASun    76.9        178    -1.0        303  -0.8
#> 179                 Denver  Sum    76.9        179     0.7         83   0.6
#> 180               La Salle  A10    76.8        180    -0.6        259  -0.4
#> 181                 Baylor  B12    76.8        181     0.1        150   0.4
#> 182          Bowling Green  MAC    76.8        182    -0.1        191   0.3
#> 183            Wichita St. Amer    76.8        183     0.2        123   1.3
#> 184          Saint Peter's MAAC    76.8        184    -0.4        230  -0.6
#> 185               Ohio St.  B10    76.8        185    -0.3        215  -0.2
#> 186                   UNLV  MWC    76.8        186     0.0        166   1.0
#> 187                   UTSA CUSA    76.8        187     0.2        127   0.8
#> 188       Jacksonville St.  OVC    76.8        188     0.2        130   0.4
#> 189         Sacramento St. BSky    76.8        189    -0.9        290  -1.2
#> 190            Little Rock   SB    76.8        190     0.8         72   1.0
#> 191                 Dayton  A10    76.8        191     0.0        160   0.4
#> 192                  Rider MAAC    76.8        192     0.0        165  -0.4
#> 193   UT Rio Grande Valley  WAC    76.8        193    -0.5        240  -0.8
#> 194              Green Bay Horz    76.8        194    -0.3        217  -0.3
#> 195        Appalachian St.   SB    76.8        195     0.7         80   0.0
#> 196               Cal Poly   BW    76.8        196    -0.7        276  -0.1
#> 197              Manhattan MAAC    76.8        197    -0.2        207  -0.7
#> 198               Winthrop BSth    76.8        198    -0.1        187  -0.6
#> 199               Kent St.  MAC    76.7        199     0.0        169  -0.3
#> 200          San Diego St.  MWC    76.7        200     0.2        131   1.0
#> 201       Coastal Carolina   SB    76.7        201    -0.2        192  -0.6
#> 202          Southern Miss CUSA    76.7        202    -0.5        243  -0.7
#> 203       Middle Tennessee CUSA    76.7        203    -1.0        300  -0.8
#> 204                Montana BSky    76.7        204    -1.4        333  -1.1
#> 205            Stony Brook   AE    76.7        205    -0.2        199   0.8
#> 206          UNC Asheville BSth    76.7        206    -0.9        297  -0.2
#> 207               Monmouth MAAC    76.7        207    -0.5        251  -0.5
#> 208                Bradley  MVC    76.7        208     0.7         84   1.8
#> 209            Chicago St.  WAC    76.7        209    -0.1        180  -0.1
#> 210       North Dakota St.  Sum    76.7        210    -0.3        224   0.2
#> 211     South Carolina St. MEAC    76.6        211    -0.1        175  -1.0
#> 212              Charlotte CUSA    76.6        212    -0.3        218  -0.1
#> 213                Seattle  WAC    76.6        213     0.1        154   0.3
#> 214                Georgia  SEC    76.6        214     0.2        129   0.1
#> 215             Morgan St. MEAC    76.6        215     0.0        158  -0.1
#> 216                    FIU CUSA    76.6        216    -0.6        258  -0.1
#> 217                 Wagner  NEC    76.6        217    -1.1        309  -1.0
#> 218                Detroit Horz    76.6        218    -0.7        275  -1.4
#> 219               American  Pat    76.6        219    -0.6        257  -0.1
#> 220               Hartford   AE    76.6        220     0.7         81   0.6
#> 221             Valparaiso  MVC    76.6        221    -0.2        197  -0.7
#> 222              Weber St. BSky    76.5        222    -0.1        179   0.1
#> 223                Memphis Amer    76.5        223     0.7         78   0.2
#> 224     Eastern Washington BSky    76.5        224    -0.3        214  -0.8
#> 225            North Texas CUSA    76.5        225    -0.3        219   0.2
#> 226      Southern Illinois  MVC    76.5        226    -0.5        247  -0.2
#> 227                  Akron  MAC    76.5        227     1.0         58   0.5
#> 228            Chattanooga   SC    76.5        228    -0.2        209  -0.7
#> 229                   Penn  Ivy    76.5        229    -0.8        288  -1.0
#> 230 Southeastern Louisiana Slnd    76.5        230     0.0        170  -0.3
#> 231                 Mercer   SC    76.5        231    -0.8        282   0.4
#> 232            Utah Valley  WAC    76.5        232     0.3        113   0.4
#> 233           Portland St. BSky    76.5        233    -1.0        305  -1.5
#> 234      Stephen F. Austin Slnd    76.5        234    -0.8        289  -1.4
#> 235              Creighton   BE    76.5        235    -1.5        340  -1.3
#> 236               Lipscomb ASun    76.5        236    -1.1        315  -1.3
#> 237       Eastern Kentucky  OVC    76.5        237     0.2        121  -0.3
#> 238 Southeast Missouri St.  OVC    76.5        238    -0.2        211  -1.0
#> 239             Alcorn St. SWAC    76.4        239    -0.7        273   0.6
#> 240        Houston Baptist Slnd    76.4        240    -0.8        283  -0.3
#> 241           Kennesaw St. ASun    76.4        241     0.3        111   0.0
#> 242       Georgia Southern   SB    76.4        242    -1.4        332  -1.2
#> 243                  Brown  Ivy    76.4        243    -1.0        301  -0.8
#> 244               Campbell BSth    76.4        244    -0.9        294  -0.8
#> 245               Ball St.  MAC    76.4        245    -0.3        226  -1.0
#> 246              Texas St.   SB    76.3        246    -0.3        225  -1.0
#> 247            Florida A&M MEAC    76.3        247    -0.9        293  -0.3
#> 248             Charleston  CAA    76.3        248    -0.6        255  -0.4
#> 249             Binghamton   AE    76.3        249    -0.6        266  -0.3
#> 250       Western Illinois  Sum    76.3        250    -0.1        188  -0.4
#> 251            Georgia St.   SB    76.3        251    -0.2        202   0.2
#> 252           South Dakota  Sum    76.3        252    -0.3        228   0.3
#> 253         Youngstown St. Horz    76.3        253    -1.1        317  -1.2
#> 254     North Carolina A&T MEAC    76.3        254    -0.1        186  -0.5
#> 255              Loyola MD  Pat    76.3        255    -0.2        206   0.7
#> 256           Grand Canyon  WAC    76.3        256     0.2        134   0.5
#> 257                   UMKC  WAC    76.3        257    -0.7        272  -0.5
#> 258              Louisiana   SB    76.3        258     0.2        135  -0.1
#> 259        Bethune Cookman MEAC    76.2        259    -0.7        270  -0.6
#> 260             Wright St. Horz    76.2        260    -0.7        274  -0.7
#> 261                  Lamar Slnd    76.2        261    -0.2        200  -0.2
#> 262         New Mexico St.  WAC    76.2        262    -0.4        229  -0.9
#> 263              Dartmouth  Ivy    76.2        263    -1.5        338  -2.0
#> 264      Northern Colorado BSky    76.2        264    -0.6        254  -0.1
#> 265         Texas Southern SWAC    76.2        265     0.0        156  -0.1
#> 266            Norfolk St. MEAC    76.2        266    -0.4        231  -0.2
#> 267           Arkansas St.   SB    76.2        267    -0.1        174  -0.5
#> 268                Samford   SC    76.2        268    -0.2        193  -1.0
#> 269         UNC Wilmington  CAA    76.2        269    -1.1        308  -1.5
#> 270     East Tennessee St.   SC    76.1        270    -0.5        242   0.9
#> 271    Arkansas Pine Bluff SWAC    76.1        271    -0.2        210  -0.4
#> 272             Pepperdine  WCC    76.1        272    -0.4        236  -0.6
#> 273               Columbia  Ivy    76.1        273    -0.9        295  -1.0
#> 274          Cleveland St. Horz    76.1        274    -0.6        263  -0.5
#> 275               Canisius MAAC    76.1        275     0.6         90   0.2
#> 276               Portland  WCC    76.1        276     1.3         36   1.7
#> 277                   Navy  Pat    76.1        277    -0.7        268  -1.3
#> 278               Arkansas  SEC    76.1        278    -1.8        346  -1.9
#> 279             High Point BSth    76.1        279     0.0        171  -0.7
#> 280                Fordham  A10    76.1        280    -0.1        185   0.9
#> 281           George Mason  A10    76.1        281    -0.4        235  -0.9
#> 282           Jacksonville ASun    76.0        282    -0.4        234  -0.2
#> 283 Texas A&M Corpus Chris Slnd    76.0        283    -0.3        216  -0.2
#> 284            McNeese St. Slnd    76.0        284    -0.9        296  -1.0
#> 285       Western Kentucky CUSA    76.0        285    -1.9        348  -1.9
#> 286           Sacred Heart  NEC    76.0        286    -0.6        261   0.2
#> 287               Duquesne  A10    76.0        287    -0.1        177   0.8
#> 288           Presbyterian BSth    76.0        288    -0.6        264  -0.7
#> 289         Nebraska Omaha  Sum    76.0        289    -0.7        269  -1.0
#> 290       SIU Edwardsville  OVC    76.0        290    -0.9        292  -2.0
#> 291         Tennessee Tech  OVC    76.0        291    -1.3        330  -1.2
#> 292           Northeastern  CAA    75.9        292    -1.1        316  -1.5
#> 293      Northern Illinois  MAC    75.9        293    -0.2        204  -0.3
#> 294            Indiana St.  MVC    75.9        294    -0.8        279  -1.4
#> 295                   Troy   SB    75.9        295    -1.2        322  -1.1
#> 296                    VMI   SC    75.9        296    -1.2        319   0.0
#> 297                  Drake  MVC    75.9        297    -0.4        237   1.5
#> 298            The Citadel   SC    75.9        298    -1.5        341  -1.3
#> 299    Fairleigh Dickinson  NEC    75.9        299    -0.8        286  -1.1
#> 300    Central Connecticut  NEC    75.9        300    -1.6        344  -2.0
#> 301               Richmond  A10    75.8        301     0.2        124   0.5
#> 302                  Idaho BSky    75.8        302    -1.2        323  -0.3
#> 303           Oral Roberts  Sum    75.8        303    -0.3        212  -1.0
#> 304          South Alabama   SB    75.8        304    -2.1        352  -3.0
#> 305                Hofstra  CAA    75.8        305    -1.4        335  -1.4
#> 306                Buffalo  MAC    75.8        306    -1.3        327  -1.2
#> 307       Prairie View A&M SWAC    75.8        307    -1.6        345  -1.6
#> 308                Wofford   SC    75.8        308    -1.2        324  -1.0
#> 309               Southern SWAC    75.8        309     0.1        142   0.5
#> 310       Western Michigan  MAC    75.8        310    -0.2        208  -0.7
#> 311           Colorado St.  MWC    75.8        311     0.1        153   1.3
#> 312           UT Arlington   SB    75.7        312    -1.0        307  -0.9
#> 313           Morehead St.  OVC    75.7        313    -0.8        285  -0.7
#> 314            Saint Louis  A10    75.7        314    -0.8        284  -0.9
#> 315            Jackson St. SWAC    75.7        315    -1.4        334  -2.0
#> 316           Gardner Webb BSth    75.7        316    -0.8        280  -0.7
#> 317    Charleston Southern BSth    75.7        317    -0.9        298  -0.7
#> 318                 Furman   SC    75.7        318    -0.5        248  -1.2
#> 319            USC Upstate BSth    75.7        319    -0.7        267  -0.5
#> 320       Mount St. Mary's  NEC    75.7        320     0.6         89   0.0
#> 321       Western Carolina   SC    75.7        321    -1.2        321  -1.4
#> 322          Robert Morris  NEC    75.7        322    -0.6        253  -1.0
#> 323                 Bryant  NEC    75.7        323    -0.6        262  -0.5
#> 324               Longwood BSth    75.6        324    -1.0        306  -0.9
#> 325           Delaware St. MEAC    75.6        325    -1.0        302  -1.3
#> 326            New Orleans Slnd    75.6        326    -1.4        336  -2.0
#> 327         Louisiana Tech CUSA    75.6        327    -1.1        314  -0.9
#> 328                Liberty ASun    75.5        328    -1.0        299  -1.4
#> 329                  IUPUI Horz    75.5        329    -1.1        310  -1.1
#> 330                    LIU  NEC    75.5        330     0.2        138   0.4
#> 331            Alabama St. SWAC    75.5        331    -1.8        347  -1.9
#> 332                   Army  Pat    75.5        332     0.1        145  -0.2
#> 333       Eastern Illinois  OVC    75.5        333    -2.4        353  -3.1
#> 334     Cal St. Northridge   BW    75.5        334    -0.5        244  -0.8
#> 335               UC Davis   BW    75.4        335    -1.4        337  -0.5
#> 336            Austin Peay  OVC    75.4        336    -1.2        320  -0.6
#> 337                Radford BSth    75.4        337    -0.6        265  -0.8
#> 338                   NJIT ASun    75.4        338     0.1        139   0.0
#> 339               Miami OH  MAC    75.4        339    -1.0        304  -0.8
#> 340 North Carolina Central MEAC    75.4        340    -1.3        325  -1.7
#> 341            Alabama A&M SWAC    75.3        341    -0.4        232  -0.6
#> 342      Abilene Christian Slnd    75.3        342     0.0        157   0.8
#> 343         Incarnate Word Slnd    75.3        343    -1.5        342  -0.7
#> 344          Virginia Tech  ACC    75.3        344    -1.3        331  -1.3
#> 345       Northwestern St. Slnd    75.3        345    -0.6        252  -0.7
#> 346              Merrimack  NEC    75.2        346    -2.1        350  -2.4
#> 347        Sam Houston St. Slnd    75.2        347    -1.6        343  -1.0
#> 348      Northern Kentucky Horz    75.2        348    -1.5        339  -1.9
#> 349          North Alabama ASun    75.1        349    -1.2        318  -1.6
#> 350 Maryland Eastern Shore MEAC    75.0        350    -1.3        328  -1.8
#> 351         St. Francis NY  NEC    74.9        351    -1.1        313  -1.1
#> 352 Mississippi Valley St. SWAC    74.9        352    -0.7        277  -1.0
#> 353                Niagara MAAC    74.1        353    -2.1        351  -1.2
#>     C.Hgt.Rk PF.Hgt PF.Hgt.Rk SF.Hgt SF.Hgt.Rk SG.Hgt SG.Hgt.Rk PG.Hgt
#> 1         36    1.2        46    2.3         3    2.4         5    3.4
#> 2         11    2.2         4    1.4        32    1.9        20    2.2
#> 3         35    2.4         2    1.6        23    1.5        39    2.6
#> 4        106    2.2         5    2.7         1    2.9         3    1.2
#> 5          1    1.9        13    0.8        68    0.8        95    1.4
#> 6         58    2.7         1    2.2         6    1.8        23    1.7
#> 7         32    2.0         8    1.8        18    1.7        30    2.0
#> 8        156    1.7        20    2.5         2    2.2         9    2.5
#> 9         10    0.7        92    2.2         6    3.2         1    0.1
#> 10        20   -0.1       187    1.1        55    2.1        10    3.1
#> 11        50    1.9        12    1.3        35    2.7         4    0.7
#> 12        16    1.8        17    0.9        60    1.3        52    1.4
#> 13         7    0.0       172    0.5       100    2.1        10    2.2
#> 14         5    1.5        26    0.7        86    1.0        85    1.5
#> 15        49    1.4        40    1.8        17    1.8        27    1.4
#> 16        42    1.6        22    1.2        38    0.7       100    2.4
#> 17        68    1.6        24    1.9        11    1.7        31    1.2
#> 18         2    1.1        59    0.2       128    1.2        58    1.6
#> 19        47    1.4        35    2.2         6    1.1        65    1.4
#> 20        95    1.7        18    1.9        12    1.1        64    1.9
#> 21       231    1.2        46    2.2         5    1.8        21    2.3
#> 22        69    1.2        51    1.3        34    1.8        28    1.8
#> 23       156    1.5        27    1.9        10    1.1        66    2.3
#> 24        12    0.2       157    0.2       128    2.1        10    1.9
#> 25        19   -0.1       196    1.1        51    1.3        51    2.3
#> 26        22    1.9        10    0.8        74    1.0        83    1.0
#> 27       283    0.3       120    1.4        33    3.1         2    2.8
#> 28        33    1.4        32    1.2        38    2.4         6   -0.3
#> 29        34    2.3         3    1.2        36    0.6       118    0.6
#> 30       132    1.3        42    0.9        63    1.6        33    2.1
#> 31        31    1.9        11    0.0       194    0.1       168    2.4
#> 32       110    0.4       112    0.2       128    2.1        10    3.0
#> 33        88    2.2         5    1.4        31    1.8        22   -0.4
#> 34        54   -0.3       222    1.2        38    1.5        37    2.4
#> 35        84    0.7        95    1.9         9    1.5        38    0.9
#> 36       101    0.5       109    1.2        38    1.6        34    1.7
#> 37       100    0.2       152    1.2        38    1.2        57    2.4
#> 38       190   -0.4       229    1.2        38    2.4         7    2.5
#> 39       113    1.0        61    1.1        52    0.4       132    2.4
#> 40        46    0.0       173    0.2       128    2.1        10    1.8
#> 41       151    0.2       135    1.7        22    2.2         8    1.0
#> 42        58    1.0        66    0.2       128    1.2        56    1.8
#> 43        38    1.1        56    0.0       187    0.1       168    2.4
#> 44        17    1.8        16    0.2       126    0.1       165    0.9
#> 45        82    1.1        60    0.1       183    0.7       103    2.4
#> 46        66    0.1       165    0.3       115    1.5        42    2.0
#> 47        75    1.4        29   -0.1       200    1.1        66    1.6
#> 48        43   -0.5       240    0.4       108    1.6        36    1.9
#> 49       136    0.3       129    0.7        85    2.1        10    1.6
#> 50         4    1.8        14    2.2         4    1.0        77   -3.3
#> 51       133    1.4        34    1.5        28    0.0       188    1.4
#> 52        67    1.0        63    0.0       195    1.1        66    1.6
#> 53        25    1.4        38    0.7        87    0.4       133    0.3
#> 54       192    0.4       111    1.0        57    1.6        35    1.6
#> 55         9    1.3        41   -0.8       272    1.1        66    0.2
#> 56        53    1.1        55    0.1       173    0.5       123    1.6
#> 57       283    0.1       159    0.2       128    1.8        24    3.1
#> 58       205   -0.3       211    0.9        61    2.1        10    1.9
#> 59        86    0.8        78   -0.2       211    0.4       134    2.4
#> 60        21    1.1        54    1.5        29    0.2       148   -0.6
#> 61        72    1.0        64   -0.3       232    0.4       125    2.0
#> 62        74    0.8        74    1.8        20    0.2       156    0.4
#> 63        27   -1.0       295    0.2       128    1.1        63    1.9
#> 64         6    0.9        67   -0.7       265    0.2       146    0.6
#> 65         3    2.0         7    1.6        26   -2.3       346   -0.6
#> 66       183    0.6       102    0.2       128    1.4        44    1.9
#> 67       156    1.2        50    0.4       109    0.2       155    2.1
#> 68       187    0.1       168    0.7        80    1.5        41    1.6
#> 69       283    0.8        75    0.6        94    1.6        32    1.6
#> 70         8    0.7        94   -1.2       311    0.1       168    1.6
#> 71       182    0.7        88    1.7        21    1.1        62    0.2
#> 72        13   -0.1       186    1.0        56    0.4       136    0.0
#> 73       312   -0.5       238    0.8        75    2.0        18    2.4
#> 74       259    0.1       164    0.7        84    1.4        46    1.8
#> 75        58    1.7        19    0.1       181    0.7        96   -0.1
#> 76       127    0.4       113    1.4        30    1.4        45   -0.3
#> 77       114    0.4       118    0.8        71    1.4        49    0.4
#> 78       241   -0.8       269    0.3       119    1.2        55    3.2
#> 79        94   -0.5       239    0.2       128    1.7        29    1.2
#> 80       107    0.0       174    0.4       112    1.0        79    1.4
#> 81       188    0.2       130    0.4       106    1.0        78    1.7
#> 82        30    1.1        53    0.4       107   -0.3       219    0.2
#> 83       224    1.0        65    0.1       166    0.4       127    2.1
#> 84        15   -0.2       200    0.1       170   -0.4       229    1.4
#> 85       140    0.8        77    0.1       172    0.6       114    1.3
#> 86       179    0.0       181    0.2       128    1.4        48    1.7
#> 87        24   -0.3       213    0.3       120    1.4        50   -0.2
#> 88        51   -0.9       290    0.2       128    1.5        43    1.2
#> 89       244    0.1       158    0.6        90    1.3        54    1.6
#> 90        28    0.2       131    0.1       180    0.1       158    0.8
#> 91        58    1.8        15    1.6        25    0.4       128   -1.9
#> 92        91    1.4        33    1.1        53    1.0        80   -1.3
#> 93       128   -0.5       235    0.8        76    0.8        90    1.3
#> 94       126   -0.7       255    0.6        96    0.7       107    1.8
#> 95       170    1.2        46    0.8        70    1.1        66   -0.3
#> 96       207   -0.2       207    0.2       128    1.8        25    1.2
#> 97        90   -0.2       199    0.6        92    1.9        19   -0.3
#> 98       215    0.6        98    0.2       128    1.4        47    0.8
#> 99       153    0.2       135    1.2        49    0.7       105    0.5
#> 100      116    1.5        28    1.8        19    0.5       122   -1.6
#> 101      119    0.2       135    0.5        97    0.6       117    0.8
#> 102      102    0.5       108    1.9        15   -0.1       193   -0.3
#> 103      211    0.0       176    0.8        66    2.0        17    0.0
#> 104      146   -0.1       188    0.9        59    1.1        59    0.2
#> 105      155    0.1       167    0.6        93    0.2       143    1.4
#> 106      222    0.2       153    0.9        64    0.4       131    1.3
#> 107       52    1.6        23   -0.4       247   -0.8       256    0.8
#> 108       80    1.7        21    0.2       128   -0.1       201   -0.3
#> 109       87    1.4        39   -0.1       205    0.1       168    0.2
#> 110       41    0.6        99    0.2       128    0.2       157   -0.2
#> 111      237   -0.5       237    1.0        58    0.5       124    1.8
#> 112      144    0.1       161    0.2       128    0.9        88    0.6
#> 113      165    0.8        86   -0.5       252    0.8        94    1.1
#> 114      177    0.2       154    1.2        48    0.2       145    0.6
#> 115       23    0.8        76   -0.7       268    0.1       168   -0.2
#> 116      166    0.9        69    1.5        27    1.1        60   -1.6
#> 117      225    0.1       162    0.8        69    0.5       120    0.9
#> 118       57   -0.9       289   -0.4       246    1.1        66    1.1
#> 119      109   -0.1       195    0.0       196    1.1        66    0.5
#> 120      137    0.2       135    0.9        62   -0.9       271    1.4
#> 121      258   -0.4       228   -0.5       254    1.0        82    2.4
#> 122      121    0.8        85    0.1       176    0.1       168    0.4
#> 123      156    0.6       100   -0.3       226    0.9        87    0.4
#> 124       83    0.7        93    0.2       123    0.6       109   -0.8
#> 125      134    1.1        57    0.2       125    0.3       138   -0.4
#> 126      176   -0.8       269    0.8        67    0.7        97    0.8
#> 127       37    0.8        81   -0.8       272    0.1       161   -0.2
#> 128       77    1.2        45   -0.1       199   -0.3       211   -0.3
#> 129       96    1.2        46   -0.3       235   -0.1       200    0.0
#> 130      322    0.2       150   -0.1       203    1.1        66    1.5
#> 131      242    1.1        52    1.1        54    0.1       163   -0.3
#> 132      246   -0.4       230    0.4       113    0.6       110    1.3
#> 133      266   -0.8       279    0.2       128    0.3       141    2.4
#> 134      330   -0.7       254    0.2       127    1.3        53    1.9
#> 135      230    0.5       104    1.2        38   -0.4       225    0.4
#> 136      156    0.5       107   -0.3       229    0.1       168    1.0
#> 137      149    0.8        80    0.5        99    0.5       119   -0.8
#> 138       70    0.0       171   -0.6       263    0.1       168    0.8
#> 139      122    1.1        58    0.7        83   -1.4       309    0.4
#> 140      209    0.0       177   -0.2       215    0.9        89    0.8
#> 141      212    0.6       101    0.3       117   -0.5       235    1.1
#> 142      223   -0.3       218    0.0       189    0.5       121    1.4
#> 143      189    0.3       121    0.5       101    0.1       167    0.4
#> 144      117    0.4       119   -0.4       239   -0.2       207    0.9
#> 145      175   -0.1       193    0.1       167    0.7        99    0.4
#> 146       55    1.4        36   -0.8       271   -0.7       252    0.1
#> 147      305    0.0       175    0.2       128    0.6       116    1.4
#> 148      250    0.7        90    0.1       164    1.0        84   -0.2
#> 149       48    0.2       135    0.5        98   -0.4       221   -0.6
#> 150      267    0.2       149    0.1       177    1.1        66    0.4
#> 151       40    0.7        89    0.8        72   -1.5       310   -0.6
#> 152       14    1.5        25   -0.3       227    0.1       166   -2.6
#> 153       58    2.0         9    0.0       193   -1.5       318   -0.6
#> 154       58    0.8        73    0.1       160    0.1       159   -1.4
#> 155      309   -0.6       244    1.2        38    1.1        61    0.1
#> 156      338   -0.8       269   -0.3       237    1.1        66    2.4
#> 157      344   -0.1       197    0.2       128    1.0        81    1.5
#> 158      210   -0.1       190    1.2        38    0.2       154   -0.4
#> 159      251    0.9        68    0.4       110   -0.9       260    0.7
#> 160       98    0.8        79   -0.6       261   -0.9       271    0.7
#> 161       18   -0.6       251   -0.5       253   -0.9       259    0.4
#> 162      217    0.2       132   -0.1       208    0.1       168    0.7
#> 163      150   -0.3       219    0.0       185    0.1       185    0.6
#> 164      131    0.0       179   -0.2       214    0.4       129   -0.1
#> 165      306    0.2       135    0.8        77    1.1        66   -0.4
#> 166      108    0.1       166    0.1       174    0.6       108   -0.9
#> 167      337    0.2       135    1.9        13   -0.5       236    0.6
#> 168      115    0.0       180   -0.4       248    0.0       191    0.4
#> 169      196   -0.2       203   -0.2       220    0.6       115    0.4
#> 170       81    0.7        96   -0.3       225    0.7       106   -1.6
#> 171      227    0.2       135    1.2        37   -0.1       198   -0.6
#> 172      340   -0.8       269    0.3       122    0.8        93    1.9
#> 173      235   -0.5       234    1.2        38    0.8        91   -0.8
#> 174      350   -1.4       325    0.2       128    1.8        26    2.0
#> 175      283    0.9        72    1.6        24    0.8        92   -2.0
#> 176      156    1.4        37    1.9        14   -0.4       228   -2.6
#> 177      145   -0.2       205    0.1       162   -0.6       244    0.7
#> 178      269   -1.2       311   -0.3       228    0.7        98    1.7
#> 179       97    0.8        82   -0.1       204    0.1       168   -1.2
#> 180      208   -0.8       266    0.7        88    0.7       101   -0.2
#> 181      123   -0.2       210   -1.8       336    0.1       168    1.6
#> 182      125   -0.7       253    0.0       188   -0.6       247    1.0
#> 183       45   -0.8       277   -0.5       250   -0.3       217    0.3
#> 184      245   -0.1       194   -0.4       241    0.4       135    0.8
#> 185      193   -0.3       217   -0.1       202   -0.1       199    0.7
#> 186       56   -1.0       298   -0.4       240   -0.8       254    0.9
#> 187       85   -0.3       223   -0.5       251    0.1       168   -0.2
#> 188      124    0.1       169    0.2       128    0.2       144   -1.1
#> 189      315   -0.5       236    0.1       161   -0.1       196    1.4
#> 190       58    0.5       103    1.8        16    0.6       112   -4.2
#> 191      112   -0.4       227    0.2       128   -0.9       264    0.4
#> 192      213    0.4       110    0.6        91   -0.5       234   -0.4
#> 193      271   -0.1       189    0.3       116    0.7       102   -0.4
#> 194      201   -0.3       215   -0.7       266   -0.5       233    1.4
#> 195      156    1.4        30   -0.1       206   -0.5       239   -1.1
#> 196      173   -1.4       323    0.0       184    0.3       142    0.8
#> 197      256    0.2       135    0.5       102   -0.1       195   -0.3
#> 198      239    0.3       122    0.4       105    0.2       150   -0.8
#> 199      199    0.2       134   -0.3       230    0.2       149   -0.3
#> 200       58   -0.6       250    0.0       191   -1.3       295    0.4
#> 201      243    0.3       125    0.7        82   -0.5       240   -0.4
#> 202      252   -0.3       216   -0.2       219    0.1       160    0.5
#> 203      268   -1.1       308    0.2       128    0.4       126    0.7
#> 204      302   -1.7       336   -0.3       223    0.7       104    1.7
#> 205       76   -1.2       318   -0.5       257   -0.2       206    0.4
#> 206      195   -1.6       335    0.1       182   -0.3       213    1.4
#> 207      229   -0.6       246   -0.4       243    0.2       151    0.5
#> 208       26   -0.5       233    0.8        78   -0.9       261   -2.1
#> 209      169   -0.1       192   -0.1       201    0.1       168   -0.7
#> 210      142   -0.8       269    0.5       103    0.2       147   -1.0
#> 211      283    0.9        71    0.8        65   -0.4       223   -1.2
#> 212      178   -0.4       232   -0.7       269    0.0       192    0.4
#> 213      129   -0.2       208   -0.2       217   -0.8       258   -0.1
#> 214      148    0.3       123    0.2       128   -0.1       197   -1.6
#> 215      174    0.2       155   -0.2       213   -1.3       301    0.4
#> 216      167   -1.1       305    0.2       128    0.3       137   -0.5
#> 217      298   -1.1       304    0.2       128    1.5        40   -0.8
#> 218      325    0.0       182    1.1        50   -0.4       224   -0.6
#> 219      180   -1.0       293   -0.9       291   -0.6       243    1.4
#> 220       92    0.8        83   -0.2       212   -1.4       308   -1.0
#> 221      248    0.3       128    0.2       128    0.3       139   -1.4
#> 222      147   -0.3       220   -1.3       312   -0.5       238    0.6
#> 223      143    1.3        44   -0.3       236   -0.3       218   -2.2
#> 224      265    0.2       133   -0.6       260   -0.9       271    0.7
#> 225      141   -0.8       278   -0.8       272    0.0       187   -0.1
#> 226      194   -0.8       269   -0.2       218   -0.9       271    0.8
#> 227       99    1.4        31    0.4       111    0.2       152   -4.0
#> 228      257    0.2       135    0.1       163   -0.8       255   -0.3
#> 229      283   -0.7       256    0.6        89    0.0       189   -0.5
#> 230      202    0.2       135    0.1       169   -1.6       323    0.1
#> 231      118   -2.0       345   -0.9       292   -0.5       231    1.4
#> 232      111    0.2       135    0.5       104   -1.2       292   -1.4
#> 233      329   -0.6       248    0.2       159   -0.2       209    0.5
#> 234      324   -0.3       224    0.6        95    0.1       162   -0.5
#> 235      316   -1.8       338    0.1       179    0.6       113    0.8
#> 236      317   -1.0       291    0.2       128    0.0       190    0.4
#> 237      198    0.8        84   -0.9       293   -0.9       269   -0.3
#> 238      283    0.5       105    0.1       165   -0.9       267   -0.6
#> 239       93   -2.0       346   -1.3       315    0.1       168    0.7
#> 240      197   -1.3       321   -0.7       264    0.3       140    0.0
#> 241      164    0.7        87    0.4       114   -0.4       230   -2.6
#> 242      307   -1.5       332   -0.8       272    0.9        86    0.6
#> 243      272   -1.1       307   -0.3       233   -0.4       220    0.6
#> 244      264   -1.1       302   -0.6       259    0.6       111   -0.3
#> 245      283    0.4       117    0.2       158   -1.9       332    0.0
#> 246      283    0.4       114   -0.1       198   -0.2       203   -1.6
#> 247      206   -1.5       330   -0.8       285   -0.4       222    0.6
#> 248      216   -0.7       257   -1.3       316   -0.6       246    0.6
#> 249      204   -1.0       292   -0.9       297    0.1       168   -0.3
#> 250      214    0.1       163   -0.3       231   -1.5       312   -0.4
#> 251      138   -0.7       258   -0.8       287   -0.4       227   -0.9
#> 252      130   -1.0       297   -0.6       262   -0.2       205   -1.1
#> 253      313   -1.1       303    0.2       128    0.4       130   -0.9
#> 254      232    0.3       126   -0.7       267   -0.9       271   -0.8
#> 255       89   -1.2       313   -0.8       272   -0.1       194   -1.3
#> 256      103   -0.1       198   -0.9       294   -0.9       271   -1.2
#> 257      220   -0.9       288   -1.1       306    0.1       168   -0.3
#> 258      168    0.4       115   -0.9       296   -1.0       280   -1.2
#> 259      240   -0.8       267    0.8        79    0.1       164   -2.4
#> 260      260   -0.7       259    0.8        73   -0.1       202   -2.2
#> 261      181   -0.3       214    0.1       171   -0.5       237   -2.2
#> 262      276    0.1       160    0.2       124   -1.4       305   -1.2
#> 263      348   -0.9       285   -0.5       249    0.2       153    0.2
#> 264      172   -1.0       299   -1.7       332   -0.9       266    0.6
#> 265      171    0.2       156    0.1       168   -1.5       314   -1.9
#> 266      186   -0.6       245   -1.7       331   -1.2       289    0.4
#> 267      219    0.3       124   -1.5       322   -1.2       290   -0.4
#> 268      283    0.7        91    0.3       118   -0.7       249   -2.6
#> 269      331   -0.6       252   -0.8       270   -0.3       210   -0.2
#> 270       73   -1.8       344   -1.0       298   -1.3       298   -0.2
#> 271      218   -0.1       184    0.0       186   -0.7       251   -2.3
#> 272      236   -0.3       212    0.3       121   -1.3       299   -1.6
#> 273      282   -0.8       282    0.2       128   -0.3       214   -1.6
#> 274      228   -0.8       264   -1.0       305   -0.6       241   -0.7
#> 275      139    1.0        62   -0.2       210   -2.0       339   -2.6
#> 276       29    0.9        70   -0.8       272   -1.5       316   -3.9
#> 277      318   -0.1       183   -1.6       326   -0.3       216   -0.3
#> 278      341   -1.6       333   -0.4       238   -0.3       215    0.6
#> 279      262    0.7        97   -0.2       216   -1.7       327   -1.5
#> 280       71   -1.2       310   -1.4       321   -0.7       248   -1.2
#> 281      275    0.0       170    0.1       175   -1.4       303   -1.6
#> 282      185   -0.6       249   -0.8       272   -0.6       242   -1.7
#> 283      191   -0.3       221   -0.9       289   -1.9       335   -0.6
#> 284      283   -0.8       281   -0.1       207   -1.5       313   -0.6
#> 285      343   -1.8       338   -0.4       244   -0.6       245    0.7
#> 286      135   -1.4       327   -1.8       338   -1.4       306    0.3
#> 287       79   -1.0       294   -0.1       197   -1.1       283   -2.9
#> 288      253   -0.6       247   -0.8       272   -1.0       281   -1.1
#> 289      283   -0.3       225   -1.0       300   -1.3       293   -0.6
#> 290      344    0.2       135    0.7        81   -1.1       284   -2.1
#> 291      311   -1.5       329   -0.2       209   -0.9       262   -0.6
#> 292      332   -0.8       269    0.1       178   -1.9       333   -0.3
#> 293      203   -0.2       202   -2.2       348   -1.2       288   -0.6
#> 294      323   -0.2       206   -0.3       222   -0.7       250   -2.1
#> 295      303   -1.3       322   -1.0       301   -0.9       263   -0.3
#> 296      154   -2.4       350   -0.8       272   -0.9       268   -0.6
#> 297       39   -2.4       349   -1.9       342   -0.9       271   -1.0
#> 298      321   -1.8       337   -1.8       338   -0.3       212    0.4
#> 299      304   -0.6       243   -1.2       310   -1.4       304   -0.6
#> 300      344   -1.2       316   -0.8       272   -0.4       226   -0.4
#> 301      104    0.0       178   -0.8       272   -1.2       291   -3.3
#> 302      200   -2.2       348   -1.0       304   -0.8       257   -0.6
#> 303      283    0.5       106   -1.6       328   -1.9       334   -0.9
#> 304      352   -1.2       317   -0.8       272    0.0       186    0.0
#> 305      326   -1.4       328    0.0       190   -0.7       253   -1.5
#> 306      308   -1.4       324   -1.9       341   -0.9       271    0.3
#> 307      333   -1.6       334   -1.4       318   -0.9       265    0.3
#> 308      297   -1.5       331   -0.8       288   -1.5       315   -0.4
#> 309      105   -0.2       209   -2.0       344   -1.5       319   -2.0
#> 310      255    0.2       151   -1.0       302   -1.9       336   -1.8
#> 311       44   -1.2       315   -0.4       242   -2.9       351   -2.1
#> 312      277   -1.2       314   -1.0       303   -0.2       208   -2.1
#> 313      261   -0.9       286   -1.0       299   -1.5       317   -1.3
#> 314      278   -0.7       262   -1.4       319   -1.1       287   -1.4
#> 315      347   -0.8       269   -0.4       245   -0.2       204   -2.2
#> 316      249   -0.9       287   -0.9       290   -1.5       311   -1.8
#> 317      247   -1.2       319   -1.2       308   -1.7       325   -1.0
#> 318      314    0.2       135   -0.3       224   -2.9       350   -1.6
#> 319      233   -0.8       268   -1.5       325   -1.6       322   -1.4
#> 320      156    1.3        43   -1.3       314   -1.7       328   -4.1
#> 321      327   -1.0       296   -1.9       343   -1.9       336    0.4
#> 322      283   -0.1       191   -2.4       350   -1.8       329   -0.6
#> 323      226   -0.8       263   -1.2       309   -2.2       345   -1.2
#> 324      279   -1.1       309   -1.8       337   -1.3       297   -0.8
#> 325      319   -0.7       261   -1.5       323   -1.0       282   -1.6
#> 326      349   -0.8       280   -0.8       284    0.1       168   -2.6
#> 327      280   -1.2       320   -1.4       317   -1.1       286   -1.6
#> 328      328   -0.5       241   -0.3       234   -1.1       285   -3.1
#> 329      301   -1.0       301   -2.2       347   -1.4       307   -0.7
#> 330      120   -0.1       185   -2.0       345   -2.9       351   -2.0
#> 331      339   -1.8       338    0.0       192   -0.9       270   -2.1
#> 332      184    0.4       116   -2.8       352   -2.7       348   -1.6
#> 333      353   -1.8       338   -0.5       258   -0.5       232   -1.0
#> 334      270   -0.2       204   -0.2       221   -1.3       294   -4.3
#> 335      221   -2.4       352   -1.3       313   -1.4       302   -1.4
#> 336      234   -1.8       343   -1.4       320   -1.3       300   -1.9
#> 337      274   -0.4       231   -1.7       334   -1.9       336   -2.1
#> 338      152    0.3       127   -1.7       333   -2.2       343   -3.4
#> 339      273   -1.2       312   -0.9       295   -1.6       321   -2.7
#> 340      335   -0.9       284   -1.6       327   -1.3       296   -1.9
#> 341      238   -0.2       201   -3.7       353   -2.4       347   -0.6
#> 342       78   -0.8       265   -2.2       349   -2.2       344   -3.2
#> 343      254   -2.4       351   -1.9       340   -2.1       341   -0.6
#> 344      320   -1.4       326   -1.8       335   -1.8       331   -1.5
#> 345      263   -0.3       226   -1.1       307   -0.9       271   -4.6
#> 346      351   -1.8       338   -0.5       255   -2.1       342   -1.3
#> 347      299   -2.1       347   -2.1       346   -1.6       320   -1.2
#> 348      342   -1.0       300   -0.8       286   -1.8       330   -2.7
#> 349      334   -0.7       260   -1.5       324   -1.7       326   -2.9
#> 350      336   -0.9       283   -0.5       256   -2.1       340   -3.9
#> 351      300   -1.1       306   -1.6       330   -1.6       324   -4.1
#> 352      281   -0.5       242   -1.6       329   -2.8       349   -3.7
#> 353      310   -3.0       353   -2.7       351   -3.6       353   -3.1
#>     PG.Hgt.Rk Experience Experience.Rk Bench Bench.Rk Continuity Continuity.Rk
#> 1           1       1.41           210  38.5       24       41.4           222
#> 2          26       0.96           313  30.9      155       24.4           323
#> 3           7       2.06            50  23.6      313       23.4           331
#> 4          91       0.90           319  28.4      222       25.3           315
#> 5          70       2.17            30  33.0      107       68.9            23
#> 6          48       1.03           303  32.2      127       31.7           297
#> 7          33       1.65           138  22.6      320       55.3           115
#> 8           8       1.10           288  18.9      345       46.5           183
#> 9         177       1.37           222  30.8      156       48.3           173
#> 10          4       1.94            65  27.6      247       66.4            37
#> 11        116       1.34           232  18.0      349       40.7           231
#> 12         68       1.36           228  31.0      153       25.1           317
#> 13         25       2.18            28  24.7      295       68.3            25
#> 14         67       1.71           117  35.7       72       49.6           158
#> 15         83       2.15            36  36.6       53       75.4            10
#> 16         13       2.39            13  21.8      333       85.4             2
#> 17         90       1.51           180  32.5      121       57.5            87
#> 18         55       2.05            55  29.2      203       44.8           192
#> 19         69       1.44           202  37.1       42       53.0           133
#> 20         38       1.56           166  31.5      140       24.3           325
#> 21         24       1.57           164  32.6      118       42.5           209
#> 22         44       0.83           328  35.6       75       41.3           224
#> 23         23       2.42            10  25.2      290       55.5           114
#> 24         41       1.61           153  23.6      312       43.1           200
#> 25         22       1.54           170  35.8       67       40.2           236
#> 26         97       0.76           333  36.1       62       22.9           334
#> 27          6       0.99           309  34.4       87       19.2           340
#> 28        205       0.70           339  29.5      194       33.5           284
#> 29        129       2.03            58  32.1      129       38.0           249
#> 30         27       1.88            81  32.8      114       49.8           157
#> 31         13       1.12           284  25.7      281       36.8           259
#> 32          5       2.08            48  27.9      238       62.6            55
#> 33        217       1.06           297  35.8       68       54.2           122
#> 34         21       1.79            96  36.5       55       58.8            79
#> 35        101       2.13            40  30.2      171       63.1            54
#> 36         50       0.81           329  36.0       65       44.9           191
#> 37         12       2.08            47  32.3      125       66.8            33
#> 38          9       1.42           205  25.7      280       32.6           291
#> 39         13       1.73           113  33.9       94       42.5           211
#> 40         46       1.68           132  17.8      350       34.6           279
#> 41         96       0.49           347  31.9      133       16.8           346
#> 42         45       1.41           209  36.4       57       54.7           117
#> 43         13       1.53           175  22.4      325       56.3           102
#> 44        103       1.94            68  30.4      167       60.3            69
#> 45         13       1.16           275  28.1      235       46.2           184
#> 46         30       0.96           312  22.9      316       29.6           303
#> 47         63       1.60           155  21.9      330       32.8           289
#> 48         34       2.08            46  31.2      149       38.4           245
#> 49         62       1.59           159  22.5      323       41.5           221
#> 50        342       1.47           191  22.5      322       39.3           240
#> 51         70       1.36           225  25.0      293       51.9           142
#> 52         64       1.44           199  28.2      231       40.6           232
#> 53        168       1.66           136  29.0      204       46.5           182
#> 54         56       1.87            82  31.2      146       36.3           267
#> 55        172       1.54           172  29.4      196       35.6           273
#> 56         58       1.61           149  32.8      113       53.3           130
#> 57          3       1.82            91  27.1      257       66.9            32
#> 58         36       1.14           280  30.6      162       57.4            88
#> 59         13       1.50           183  30.5      165       24.4           322
#> 60        233       1.50           182  37.5       34       49.2           163
#> 61         31       1.41           208  22.8      317       28.8           306
#> 62        163       1.01           305  42.8        5       49.6           159
#> 63         37       1.87            83  37.5       36       21.6           337
#> 64        131       1.76           105  43.2        3       46.8           180
#> 65        233       1.47           192  30.0      181       52.9           134
#> 66         39       1.58           161  33.0      108       56.6            98
#> 67         29       1.61           151  17.7      351       56.9            94
#> 68         60       1.69           126  25.6      283       68.4            24
#> 69         54       1.60           154  38.9       21       32.3           293
#> 70         61       2.32            19  21.4      334       39.3           241
#> 71        171       1.44           200  32.0      132       54.5           119
#> 72        184       1.83            88  27.6      249       28.9           305
#> 73         11       1.16           273  27.0      260       36.4           263
#> 74         43       2.53             4  27.7      244       51.6           146
#> 75        189       2.15            35  27.8      243       66.6            34
#> 76        201       2.40            11  30.7      159       65.4            43
#> 77        161       1.62           144  32.5      122       56.7            97
#> 78          2       1.52           176  22.6      321       55.8           109
#> 79         89       1.48           186  31.7      137       49.0           165
#> 80         70       1.41           212  30.1      176       44.5           193
#> 81         53       1.46           195  29.5      195       32.9           288
#> 82        173       1.37           223  36.1       61       40.3           234
#> 83         28       1.57           165  31.9      135       71.1            17
#> 84         70       1.59           160  26.9      261       75.5             9
#> 85         85       1.11           286  27.6      250       38.6           244
#> 86         52       1.24           261  32.8      115       18.0           342
#> 87        193       1.94            67  18.8      347       51.2           150
#> 88         92       1.39           216  24.2      300       42.4           212
#> 89         59       1.27           252  25.6      282       32.1           294
#> 90        109       1.75           107  29.7      185       59.7            73
#> 91        312       2.06            52  26.5      267       64.5            49
#> 92        282       1.36           227  29.5      193       51.0           151
#> 93         86       1.09           290  32.9      110       43.0           205
#> 94         42       1.24           259  24.0      303       51.7           145
#> 95        204       1.31           242  27.8      242       41.0           228
#> 96         88       1.25           256  36.9       47       39.1           243
#> 97        215       2.05            54  18.8      346       77.1             7
#> 98        113       1.47           194  33.6       98       58.6            80
#> 99        140       1.52           177  32.5      120       50.3           156
#> 100       301       1.66           137  22.4      324       32.4           292
#> 101       111       1.11           287  30.1      174       37.4           254
#> 102       213       2.03            57  31.2      147       83.9             3
#> 103       185       1.23           263  32.2      128       47.4           176
#> 104       170       1.36           224  29.4      199       36.4           264
#> 105        70       1.62           146  33.5      100       67.7            28
#> 106        87       1.29           246  28.4      223       28.4           307
#> 107       112       1.84            87  37.5       35       44.1           195
#> 108       207       1.55           167  21.8      332       44.3           194
#> 109       174       1.42           207  30.1      177       47.4           177
#> 110       196       2.44             8  27.0      259       65.7            41
#> 111        47       1.79            99  36.9       46       28.3           308
#> 112       127       0.97           310  28.8      211       31.8           296
#> 113        95       2.02            59  34.4       89       63.1            53
#> 114       130       2.34            16  27.4      252       61.9            60
#> 115       190       2.29            22  35.7       71       59.7            74
#> 116       295       2.24            24  29.6      189       65.1            47
#> 117       102       1.70           121  33.2      103       51.6           147
#> 118        93       1.40           214  47.0        2       27.2           309
#> 119       142       2.16            32  19.9      342       67.4            30
#> 120        70       1.65           140  25.5      287       56.2           103
#> 121        13       0.66           342  31.9      134       16.9           345
#> 122       147       1.72           114  30.2      169       51.2           149
#> 123       148       1.62           148  33.1      105       48.6           168
#> 124       257       2.34            17  31.2      145       54.2           123
#> 125       218       2.13            39  25.1      292       50.9           153
#> 126       105       1.80            95  34.6       83       65.7            42
#> 127       195       2.17            31  28.9      209       68.1            27
#> 128       209       1.73           112  36.6       54       59.9            70
#> 129       181       1.90            76  26.6      265       47.6           175
#> 130        65       2.05            56  28.5      220       86.0             1
#> 131       203       1.87            84  34.0       92       57.2            90
#> 132        84       2.13            42  28.6      218       45.7           186
#> 133        13       1.50           181  30.1      179       57.7            84
#> 134        35       2.01            60  38.2       29       70.0            21
#> 135       146       2.12            43  23.8      310       75.8             8
#> 136        98       1.55           169  28.7      212       52.0           140
#> 137       258       2.42             9  33.9       93       63.5            52
#> 138       110       1.90            75  30.7      161       48.6           169
#> 139       149       1.88            79  34.5       86       66.2            38
#> 140       107       1.25           257  35.9       66       23.6           328
#> 141        94       1.28           249  28.1      232       39.9           238
#> 142        70       1.33           236  30.1      178        4.1           352
#> 143       149       1.38           218  28.1      234       36.1           269
#> 144       104       1.83            90  34.9       80       33.1           287
#> 145       149       1.18           269  29.0      205       38.3           246
#> 146       178       1.58           162  38.5       25       53.8           124
#> 147        70       1.72           116  28.6      216       55.7           110
#> 148       194       1.71           118  37.7       32       60.6            68
#> 149       233       2.14            37  32.9      111       65.7            40
#> 150       164       1.75           108  31.0      152       41.2           225
#> 151       233       1.16           276  36.5       56       52.4           137
#> 152       334       1.82            92  32.4      123       42.4           213
#> 153       233       2.10            45  20.2      341       70.5            19
#> 154       286       0.83           327  32.6      117       39.9           239
#> 155       176       1.48           189  22.3      326       34.0           283
#> 156        10       1.54           173  27.3      253       25.5           313
#> 157        66       1.73           110  22.7      318       52.6           136
#> 158       223       0.96           311  26.3      271       46.9           179
#> 159       118       1.37           221  34.4       88       45.2           190
#> 160       125       1.19           268  31.5      141       39.2           242
#> 161       149       1.83            89  28.7      213       69.1            22
#> 162       117       1.32           239  30.2      170       65.3            44
#> 163       134       2.50             6  31.3      143       64.3            50
#> 164       187       0.85           324  28.3      227       35.1           277
#> 165       225       0.60           345  28.9      208       23.5           330
#> 166       262       1.69           127  23.9      304       10.2           349
#> 167       137       2.31            20  26.4      269       72.3            14
#> 168       149       1.09           289  31.2      148       41.3           223
#> 169       144       1.40           215  38.3       28       35.9           271
#> 170       294       2.14            38  30.7      160       15.7           348
#> 171       231       1.15           277  30.4      166       57.5            86
#> 172        40       1.03           302  30.1      172       36.7           261
#> 173       254       1.58           163  31.8      136       43.2           199
#> 174        32       1.24           260  21.9      329       56.9            95
#> 175       315       2.18            29  23.8      307       73.0            12
#> 176       330       0.92           317  31.7      138       17.8           343
#> 177       121       0.93           316  24.1      301       36.3           266
#> 178        49       0.72           336  35.7       70       24.1           327
#> 179       273       1.07           296  27.9      239       42.6           208
#> 180       191       1.31           241  39.5       17       50.5           155
#> 181        57       1.76           104  26.1      274       57.1            93
#> 182        99       1.73           111  35.6       76       62.4            59
#> 183       165       0.88           321  38.4       26       49.3           162
#> 184       115       1.09           291  49.1        1       37.9           251
#> 185       124       1.61           152  30.5      163       59.7            72
#> 186       100       1.74           109  35.1       79       40.1           237
#> 187       198       1.98            63  31.0      154       59.2            77
#> 188       269       0.75           334  39.6       15       26.4           311
#> 189        70       2.06            51  28.9      210       75.1            11
#> 190       351       0.91           318  26.2      272       37.6           252
#> 191       149       2.13            41  25.9      278       63.8            51
#> 192       224       2.30            21  27.9      241       56.4           101
#> 193       221       1.33           235  39.6       14       44.0           196
#> 194        70       1.77           103  29.8      184       53.2           131
#> 195       270       2.05            53  25.9      277       61.6            62
#> 196       106       1.22           265  42.6        8       25.6           312
#> 197       200       1.27           250  34.7       81       68.2            26
#> 198       253       1.07           294  36.7       52       41.5           219
#> 199       206       1.63           142  26.4      270       42.4           214
#> 200       149       2.20            26  24.7      296       37.9           250
#> 201       220       0.71           337  39.2       18       35.7           272
#> 202       143       0.89           320  20.4      340       35.4           274
#> 203       122       1.79            97  30.1      175       53.5           128
#> 204        51       1.69           129  24.3      298       37.1           257
#> 205       149       1.53           174  27.9      240       53.4           129
#> 206        70       1.29           245  21.1      338       58.8            78
#> 207       141       1.70           122  37.2       41       72.3            15
#> 208       319       2.15            34  29.6      192       54.6           118
#> 209       251       0.08           352  40.3       13        5.9           351
#> 210       264       1.98            62  32.1      130       79.4             5
#> 211       276       2.36            14  35.8       69       57.2            91
#> 212       149       1.40           213  25.6      284       32.0           295
#> 213       188       2.15            33  27.7      246       81.0             4
#> 214       300       1.28           247  33.8       95       34.3           282
#> 215       149       1.55           168  29.3      201       55.7           111
#> 216       229       1.38           219  33.1      106       57.6            85
#> 217       255       1.35           231  29.3      200       20.6           339
#> 218       232       1.11           285  35.2       77       36.5           262
#> 219        70       1.99            61  28.1      233       61.3            64
#> 220       268       1.12           283  25.7      279        7.5           350
#> 221       288       1.29           244  35.6       74       41.5           220
#> 222       133       2.11            44  26.5      266       48.7           167
#> 223       323       0.46           350  37.3       40       23.5           329
#> 224       123       1.38           220  26.8      262       42.0           216
#> 225       186       1.35           229  28.5      221       43.0           204
#> 226       114       1.21           267  28.5      219       18.8           341
#> 227       348       1.61           150  23.9      305       53.1           132
#> 228       211       1.59           158  28.3      225       43.1           202
#> 229       228       1.94            66  23.8      308       40.8           229
#> 230       179       1.00           307  34.6       82       40.8           230
#> 231        70       1.28           248  33.1      104       38.2           247
#> 232       289       1.08           292  33.3      101       21.4           338
#> 233       139       1.91            73  34.5       84       37.2           256
#> 234       230       1.23           262  37.3       39       36.4           265
#> 235       108       1.88            80  19.4      343       55.5           113
#> 236       145       1.17           271  29.6      188       30.2           301
#> 237       202       1.16           272  30.8      157       37.5           253
#> 238       233       1.05           299  33.0      109       51.5           148
#> 239       119       1.75           106  29.2      202       50.9           152
#> 240       182       1.41           211  37.4       37       52.9           135
#> 241       330       1.33           234  37.5       33       46.6           181
#> 242       136       1.92            72  27.1      255       67.6            29
#> 243       138       2.06            49  29.7      187       57.3            89
#> 244       216       1.44           201  36.2       60       45.3           188
#> 245       183       1.70           123  27.2      254       48.4           172
#> 246       296       1.68           134  34.0       91       49.4           161
#> 247       135       1.24           258  29.4      197       51.7           143
#> 248       126       1.86            85  27.5      251       61.4            63
#> 249       208       0.74           335  22.1      327       25.2           316
#> 250       227       1.95            64  24.5      297       58.3            82
#> 251       261       1.39           217  30.5      164       33.3           285
#> 252       271       2.56             3  21.1      336       65.2            45
#> 253       263       1.91            74  29.7      186       70.7            18
#> 254       256       1.25           254  33.6       96       34.3           281
#> 255       284       1.78           100  32.8      116       66.6            35
#> 256       277       1.44           203  21.9      331       25.0           318
#> 257       214       1.68           131  37.3       38       48.8           166
#> 258       278       1.32           237  26.8      263       30.9           299
#> 259       328       1.51           178  29.0      206       48.6           170
#> 260       326       1.70           124  27.9      237       43.8           197
#> 261       324       0.79           330  22.6      319       24.9           319
#> 262       274       1.69           128  36.9       48       54.4           120
#> 263       175       1.65           139  28.2      230       65.1            46
#> 264       132       1.93            69  26.1      276       65.0            48
#> 265       309       0.99           308  39.6       16       37.4           255
#> 266       149       1.06           298  34.1       90       22.0           336
#> 267       222       1.30           243  32.6      119       41.2           226
#> 268       330       1.70           125  29.0      207       55.9           105
#> 269       197       0.70           340  32.9      112       22.7           335
#> 270       192       1.60           156  29.6      190       67.2            31
#> 271       327       0.84           326  38.7       23       36.7           260
#> 272       298       1.70           120  24.2      299       56.1           104
#> 273       297       1.64           141  25.5      286       43.3           198
#> 274       250       1.07           295  35.1       78       29.7           302
#> 275       330       1.60           157  26.1      273       43.1           201
#> 276       346       1.46           196  36.1       63       40.2           235
#> 277       212       1.35           230  28.7      214       55.0           116
#> 278       128       2.18            27  23.7      311       65.8            39
#> 279       293       0.84           325  36.8       50       31.1           298
#> 280       280       1.44           204  41.6       10       53.7           125
#> 281       299       1.34           233  25.5      285       48.2           174
#> 282       306       0.68           341  33.6       97       36.0           270
#> 283       233       1.13           281  36.9       45       42.5           210
#> 284       233       1.16           274  26.4      268       29.5           304
#> 285       120       2.51             5  19.2      344       53.6           126
#> 286       167       1.62           147  25.4      289       71.8            16
#> 287       337       1.49           185  28.0      236       55.8           108
#> 288       272       1.00           306  36.8       51       38.1           248
#> 289       233       1.88            78  26.7      264       59.9            71
#> 290       317       1.22           266  36.8       49       47.1           178
#> 291       233       0.70           338  37.9       31       33.1           286
#> 292       210       1.92            71  23.8      309       42.1           215
#> 293       233       1.72           115  28.3      226       49.4           160
#> 294       318       1.92            70  28.3      224       60.8            66
#> 295       199       0.63           344  41.8        9       30.7           300
#> 296       233       1.45           198  31.4      142       57.1            92
#> 297       267       1.15           279  26.1      275       50.8           154
#> 298       162       1.47           193  29.9      182       25.4           314
#> 299       233       1.90            77  24.0      302       62.6            56
#> 300       226       0.47           349  42.7        7       24.4           321
#> 301       343       2.39            12  29.4      198       66.5            36
#> 302       249       1.26           253  40.6       12       32.6           290
#> 303       260       1.77           102  29.8      183       42.0           217
#> 304       180       2.88             1  21.1      337       54.4           121
#> 305       291       2.32            18  14.2      353       60.8            65
#> 306       169       1.48           188  25.4      288       35.3           275
#> 307       166       0.87           322  42.8        4       49.1           164
#> 308       219       1.85            86  34.5       85       51.7           144
#> 309       313       0.86           323  39.0       20       16.4           347
#> 310       308       1.15           278  33.3      102       34.8           278
#> 311       321       1.71           119  28.7      215       59.3            76
#> 312       320       0.93           315  37.1       43       55.6           112
#> 313       283       1.77           101  32.4      124       41.9           218
#> 314       290       1.42           206  24.9      294       36.2           268
#> 315       325       1.12           282  31.3      144       40.3           233
#> 316       307       1.62           145  27.1      256       62.6            57
#> 317       266       1.51           179  28.2      228       55.9           106
#> 318       301       1.80            94  20.8      339       72.5            13
#> 319       285       0.78           331  32.3      126       45.3           189
#> 320       350       1.54           171  21.1      335       79.3             6
#> 321       149       1.79            98  25.1      291       56.6            99
#> 322       233       1.68           133  27.7      245       58.5            81
#> 323       279       1.67           135  33.6       99       35.2           276
#> 324       259       1.32           238  38.8       22       53.6           127
#> 325       301       1.46           197  27.0      258       42.8           206
#> 326       329       1.69           130  31.1      150       52.3           138
#> 327       301       2.35            15  32.0      131       56.8            96
#> 328       339       2.48             7  23.5      314       70.1            20
#> 329       252       1.62           143  18.2      348       36.9           258
#> 330       314       2.71             2  23.9      306       61.8            61
#> 331       322       1.22           264  38.1       30       48.5           171
#> 332       301       2.23            25  17.2      352       59.4            75
#> 333       265       1.27           251  30.2      168       58.0            83
#> 334       352       1.49           184  29.6      191       60.7            67
#> 335       287       1.02           304  36.2       58       45.3           187
#> 336       311       1.05           300  23.1      315       24.4           324
#> 337       316       2.25            23  30.0      180       62.6            58
#> 338       344       1.80            93  22.1      328       51.9           141
#> 339       335       1.48           187  40.8       11       55.9           107
#> 340       310       1.25           255  35.6       73       23.4           332
#> 341       233       0.77           332  30.1      173       27.1           310
#> 342       341       1.17           270  38.3       27       42.7           207
#> 343       233       0.49           348  31.6      139       23.0           333
#> 344       292       0.64           343  30.8      158       24.9           320
#> 345       353       0.56           346  39.1       19       24.2           326
#> 346       281       0.00           353  28.2      229        0.0             0
#> 347       275       1.32           240  36.2       59       41.2           227
#> 348       336       1.47           190  31.0      151       56.4           100
#> 349       338       0.94           314  27.6      248       52.0           139
#> 350       347       1.04           301  42.8        6       43.1           203
#> 351       349       1.36           226  28.6      217       45.9           185
#> 352       345       0.40           351  37.0       44       17.5           344
#> 353       340       1.07           293  36.0       64       34.5           280
#>     NCAA_Seed Year
#> 1           2 2020
#> 2          NA 2020
#> 3           1 2020
#> 4          NA 2020
#> 5           3 2020
#> 6          NA 2020
#> 7          NA 2020
#> 8           2 2020
#> 9          NA 2020
#> 10         11 2020
#> 11         NA 2020
#> 12          7 2020
#> 13         NA 2020
#> 14         NA 2020
#> 15         NA 2020
#> 16         NA 2020
#> 17         NA 2020
#> 18         12 2020
#> 19         10 2020
#> 20         NA 2020
#> 21         NA 2020
#> 22          3 2020
#> 23         NA 2020
#> 24          1 2020
#> 25         NA 2020
#> 26         NA 2020
#> 27         NA 2020
#> 28         NA 2020
#> 29          9 2020
#> 30         NA 2020
#> 31          4 2020
#> 32         NA 2020
#> 33         11 2020
#> 34          9 2020
#> 35         NA 2020
#> 36         NA 2020
#> 37         NA 2020
#> 38         NA 2020
#> 39         NA 2020
#> 40         NA 2020
#> 41         NA 2020
#> 42         NA 2020
#> 43         NA 2020
#> 44         NA 2020
#> 45         NA 2020
#> 46         NA 2020
#> 47         NA 2020
#> 48         NA 2020
#> 49         10 2020
#> 50          7 2020
#> 51         NA 2020
#> 52         NA 2020
#> 53          6 2020
#> 54          4 2020
#> 55         NA 2020
#> 56         NA 2020
#> 57         NA 2020
#> 58         NA 2020
#> 59         NA 2020
#> 60         NA 2020
#> 61         NA 2020
#> 62          6 2020
#> 63         NA 2020
#> 64         NA 2020
#> 65          6 2020
#> 66         NA 2020
#> 67         NA 2020
#> 68         NA 2020
#> 69         NA 2020
#> 70         NA 2020
#> 71          3 2020
#> 72         NA 2020
#> 73         NA 2020
#> 74          5 2020
#> 75         NA 2020
#> 76          8 2020
#> 77         NA 2020
#> 78          8 2020
#> 79         NA 2020
#> 80         NA 2020
#> 81         NA 2020
#> 82         NA 2020
#> 83         NA 2020
#> 84          7 2020
#> 85         NA 2020
#> 86         NA 2020
#> 87         NA 2020
#> 88          9 2020
#> 89         16 2020
#> 90         14 2020
#> 91         NA 2020
#> 92         NA 2020
#> 93         NA 2020
#> 94         NA 2020
#> 95         NA 2020
#> 96          7 2020
#> 97          3 2020
#> 98         NA 2020
#> 99         NA 2020
#> 100        NA 2020
#> 101        NA 2020
#> 102         8 2020
#> 103        NA 2020
#> 104         5 2020
#> 105        16 2020
#> 106        NA 2020
#> 107        14 2020
#> 108        12 2020
#> 109        NA 2020
#> 110        11 2020
#> 111        NA 2020
#> 112        NA 2020
#> 113         6 2020
#> 114         5 2020
#> 115        NA 2020
#> 116        NA 2020
#> 117        NA 2020
#> 118        NA 2020
#> 119        NA 2020
#> 120        NA 2020
#> 121        NA 2020
#> 122        NA 2020
#> 123        NA 2020
#> 124         9 2020
#> 125        NA 2020
#> 126        13 2020
#> 127         4 2020
#> 128        NA 2020
#> 129        NA 2020
#> 130        NA 2020
#> 131        10 2020
#> 132        NA 2020
#> 133        NA 2020
#> 134        NA 2020
#> 135         8 2020
#> 136        NA 2020
#> 137        NA 2020
#> 138        NA 2020
#> 139        NA 2020
#> 140        NA 2020
#> 141        NA 2020
#> 142        NA 2020
#> 143        NA 2020
#> 144        NA 2020
#> 145        NA 2020
#> 146        NA 2020
#> 147        NA 2020
#> 148        NA 2020
#> 149         4 2020
#> 150        NA 2020
#> 151        NA 2020
#> 152        NA 2020
#> 153        NA 2020
#> 154        NA 2020
#> 155        NA 2020
#> 156        10 2020
#> 157        NA 2020
#> 158        NA 2020
#> 159        NA 2020
#> 160        NA 2020
#> 161        NA 2020
#> 162        NA 2020
#> 163        NA 2020
#> 164        NA 2020
#> 165        NA 2020
#> 166        NA 2020
#> 167        NA 2020
#> 168        NA 2020
#> 169        NA 2020
#> 170        NA 2020
#> 171        NA 2020
#> 172        NA 2020
#> 173        NA 2020
#> 174        NA 2020
#> 175        NA 2020
#> 176        NA 2020
#> 177        NA 2020
#> 178        NA 2020
#> 179        NA 2020
#> 180        NA 2020
#> 181         1 2020
#> 182        NA 2020
#> 183        11 2020
#> 184        NA 2020
#> 185         5 2020
#> 186        NA 2020
#> 187        NA 2020
#> 188        NA 2020
#> 189        NA 2020
#> 190        15 2020
#> 191         1 2020
#> 192        NA 2020
#> 193        NA 2020
#> 194        NA 2020
#> 195        NA 2020
#> 196        NA 2020
#> 197        NA 2020
#> 198        16 2020
#> 199        NA 2020
#> 200         2 2020
#> 201        NA 2020
#> 202        NA 2020
#> 203        NA 2020
#> 204        NA 2020
#> 205        NA 2020
#> 206        NA 2020
#> 207        NA 2020
#> 208        14 2020
#> 209        NA 2020
#> 210        15 2020
#> 211        NA 2020
#> 212        NA 2020
#> 213        NA 2020
#> 214        NA 2020
#> 215        NA 2020
#> 216        NA 2020
#> 217        NA 2020
#> 218        NA 2020
#> 219        NA 2020
#> 220        NA 2020
#> 221        NA 2020
#> 222        NA 2020
#> 223        NA 2020
#> 224        15 2020
#> 225        13 2020
#> 226        NA 2020
#> 227        13 2020
#> 228        NA 2020
#> 229        NA 2020
#> 230        NA 2020
#> 231        NA 2020
#> 232        NA 2020
#> 233        NA 2020
#> 234        12 2020
#> 235         2 2020
#> 236        NA 2020
#> 237        NA 2020
#> 238        NA 2020
#> 239        NA 2020
#> 240        NA 2020
#> 241        NA 2020
#> 242        NA 2020
#> 243        NA 2020
#> 244        NA 2020
#> 245        NA 2020
#> 246        NA 2020
#> 247        NA 2020
#> 248        NA 2020
#> 249        NA 2020
#> 250        NA 2020
#> 251        NA 2020
#> 252        NA 2020
#> 253        NA 2020
#> 254        NA 2020
#> 255        NA 2020
#> 256        NA 2020
#> 257        NA 2020
#> 258        NA 2020
#> 259        NA 2020
#> 260        NA 2020
#> 261        NA 2020
#> 262        13 2020
#> 263        NA 2020
#> 264        NA 2020
#> 265        NA 2020
#> 266        NA 2020
#> 267        NA 2020
#> 268        NA 2020
#> 269        NA 2020
#> 270        11 2020
#> 271        NA 2020
#> 272        NA 2020
#> 273        NA 2020
#> 274        NA 2020
#> 275        NA 2020
#> 276        NA 2020
#> 277        NA 2020
#> 278        NA 2020
#> 279        NA 2020
#> 280        NA 2020
#> 281        NA 2020
#> 282        NA 2020
#> 283        NA 2020
#> 284        NA 2020
#> 285        NA 2020
#> 286        NA 2020
#> 287        NA 2020
#> 288        NA 2020
#> 289        NA 2020
#> 290        NA 2020
#> 291        NA 2020
#> 292        NA 2020
#> 293        NA 2020
#> 294        NA 2020
#> 295        NA 2020
#> 296        NA 2020
#> 297        NA 2020
#> 298        NA 2020
#> 299        NA 2020
#> 300        NA 2020
#> 301        11 2020
#> 302        NA 2020
#> 303        NA 2020
#> 304        NA 2020
#> 305        14 2020
#> 306        NA 2020
#> 307        16 2020
#> 308        NA 2020
#> 309        NA 2020
#> 310        NA 2020
#> 311        NA 2020
#> 312        NA 2020
#> 313        NA 2020
#> 314        NA 2020
#> 315        NA 2020
#> 316        NA 2020
#> 317        NA 2020
#> 318        NA 2020
#> 319        NA 2020
#> 320        NA 2020
#> 321        NA 2020
#> 322        16 2020
#> 323        NA 2020
#> 324        NA 2020
#> 325        NA 2020
#> 326        NA 2020
#> 327        NA 2020
#> 328        12 2020
#> 329        NA 2020
#> 330        NA 2020
#> 331        NA 2020
#> 332        NA 2020
#> 333        NA 2020
#> 334        NA 2020
#> 335        NA 2020
#> 336        NA 2020
#> 337        NA 2020
#> 338        NA 2020
#> 339        NA 2020
#> 340        16 2020
#> 341        NA 2020
#> 342        NA 2020
#> 343        NA 2020
#> 344        NA 2020
#> 345        NA 2020
#> 346        NA 2020
#> 347        NA 2020
#> 348        15 2020
#> 349        NA 2020
#> 350        NA 2020
#> 351        NA 2020
#> 352        NA 2020
#> 353        NA 2020
# }
# \donttest{
try(kp_foul_trouble(min_year = 2020, max_year = most_recent_mbb_season()))
#> ✖ 2026-10-26 19:19:14.213275: Invalid arguments or no foul trouble data for 2020 - 2027 available!
#> ✖ Args: min_year = 2020, max_year = 2027
#> ✖ Error: subscript out of bounds
#>                       Team Conf TwoFoulParticpation.Pct
#> 1             Georgia Tech  ACC                    68.7
#> 2                 Ball St.  MAC                    61.2
#> 3                 Delaware  CAA                    57.3
#> 4              Little Rock   SB                    56.4
#> 5                  Oakland Horz                    55.8
#> 6                 Syracuse  ACC                    54.0
#> 7                Merrimack  NEC                    53.6
#> 8         Eastern Michigan  MAC                    52.7
#> 9                     Army  Pat                    52.3
#> 10      Eastern Washington BSky                    52.1
#> 11              Binghamton   AE                    51.3
#> 12           Southern Miss CUSA                    50.9
#> 13              Washington  P12                    49.7
#> 14              Coppin St. MEAC                    49.6
#> 15             McNeese St. Slnd                    48.8
#> 16           San Francisco  WCC                    48.3
#> 17           North Florida ASun                    48.1
#> 18                   IUPUI Horz                    48.0
#> 19               Minnesota  B10                    47.7
#> 20             Florida A&M MEAC                    47.3
#> 21       Northern Kentucky Horz                    46.8
#> 22        Central Michigan  MAC                    45.6
#> 23          Washington St.  P12                    45.0
#> 24                 Fordham  A10                    44.7
#> 25               Louisiana   SB                    44.1
#> 26              New Mexico  MWC                    43.8
#> 27                   Brown  Ivy                    43.7
#> 28                 Detroit Horz                    43.5
#> 29            South Dakota  Sum                    43.2
#> 30          Incarnate Word Slnd                    42.6
#> 31                     FIU CUSA                    42.2
#> 32          Sacramento St. BSky                    42.2
#> 33                  Toledo  MAC                    42.1
#> 34                    Penn  Ivy                    41.8
#> 35        Tennessee Martin  OVC                    41.8
#> 36            Colorado St.  MWC                    41.4
#> 37         Bethune Cookman MEAC                    41.2
#> 38                 Alabama  SEC                    40.7
#> 39     Cal St. Bakersfield  WAC                    40.6
#> 40             The Citadel   SC                    40.4
#> 41              Texas Tech  B12                    38.5
#> 42             Mississippi  SEC                    38.3
#> 43           North Alabama ASun                    38.2
#> 44                 Hampton BSth                    37.9
#> 45                 Seattle  WAC                    37.7
#> 46                  Howard MEAC                    37.4
#> 47                     LIU  NEC                    36.9
#> 48      Cal St. Northridge   BW                    36.6
#> 49                  Tulane Amer                    36.4
#> 50              Pepperdine  WCC                    35.9
#> 51            Rhode Island  A10                    35.7
#> 52                 Cornell  Ivy                    35.5
#> 53                  Furman   SC                    35.4
#> 54                 Georgia  SEC                    35.3
#> 55  North Carolina Central MEAC                    35.3
#> 56        Central Arkansas Slnd                    34.3
#> 57                    NJIT ASun                    34.1
#> 58             Santa Clara  WCC                    34.1
#> 59                  Kansas  B12                    34.0
#> 60                    UTSA CUSA                    33.8
#> 61        Prairie View A&M SWAC                    33.3
#> 62  Mississippi Valley St. SWAC                    33.0
#> 63            North Dakota  Sum                    32.9
#> 64                  Bryant  NEC                    32.9
#> 65           Grambling St. SWAC                    32.7
#> 66          Tennessee Tech  OVC                    32.3
#> 67        Western Carolina   SC                    32.2
#> 68                   Akron  MAC                    32.0
#> 69            Sacred Heart  NEC                    31.6
#> 70                Duquesne  A10                    31.4
#> 71          North Carolina  ACC                    31.4
#> 72                     LSU  SEC                    31.1
#> 73     Arkansas Pine Bluff SWAC                    30.9
#> 74                Lipscomb ASun                    30.8
#> 75                   Maine   AE                    30.3
#> 76                Portland  WCC                    30.1
#> 77             Chicago St.  WAC                    30.0
#> 78              Notre Dame  ACC                    30.0
#> 79            Northeastern  CAA                    30.0
#> 80                    UMBC   AE                    29.6
#> 81          Saint Joseph's  A10                    29.6
#> 82                    UNLV  MWC                    29.5
#> 83            Kennesaw St. ASun                    29.5
#> 84     Fairleigh Dickinson  NEC                    29.4
#> 85          St. Francis PA  NEC                    29.4
#> 86           UNC Asheville BSth                    29.3
#> 87               San Diego  WCC                    29.2
#> 88        Northwestern St. Slnd                    29.2
#> 89            Grand Canyon  WAC                    29.1
#> 90                Utah St.  MWC                    29.1
#> 91            UMass Lowell   AE                    29.0
#> 92               Boise St.  MWC                    28.9
#> 93                  Wagner  NEC                    28.9
#> 94        Northern Arizona BSky                    28.8
#> 95             Alabama A&M SWAC                    28.7
#> 96                  Auburn  SEC                    28.4
#> 97        Georgia Southern   SB                    28.2
#> 98                Canisius MAAC                    28.2
#> 99              Holy Cross  Pat                    28.0
#> 100                  Texas  B12                    28.0
#> 101                   Ohio  MAC                    28.0
#> 102             Fresno St.  MWC                    27.7
#> 103       Louisiana Monroe   SB                    27.7
#> 104          Robert Morris  NEC                    27.7
#> 105      George Washington  A10                    27.5
#> 106               American  Pat                    27.4
#> 107           Presbyterian BSth                    27.4
#> 108              Green Bay Horz                    27.3
#> 109                 Xavier   BE                    27.2
#> 110                 Baylor  B12                    27.1
#> 111             Murray St.  OVC                    27.0
#> 112                Montana BSky                    26.8
#> 113 Southeastern Louisiana Slnd                    26.8
#> 114               Iowa St.  B12                    26.5
#> 115              Creighton   BE                    26.3
#> 116            New Orleans Slnd                    26.3
#> 117               UC Davis   BW                    26.1
#> 118             Pittsburgh  ACC                    26.0
#> 119            Saint Louis  A10                    26.0
#> 120              Tennessee  SEC                    25.9
#> 121           Saint Mary's  WCC                    25.6
#> 122             Quinnipiac MAAC                    25.5
#> 123                Colgate  Pat                    25.5
#> 124         Boston College  ACC                    25.4
#> 125      Cal St. Fullerton   BW                    25.4
#> 126          Cleveland St. Horz                    25.3
#> 127            Cal Baptist  WAC                    25.2
#> 128                 Butler   BE                    25.2
#> 129               Miami FL  ACC                    25.2
#> 130 Texas A&M Corpus Chris Slnd                    25.2
#> 131                Harvard  Ivy                    25.1
#> 132            Jackson St. SWAC                    25.1
#> 133                 Nevada  MWC                    25.1
#> 134          South Alabama   SB                    24.9
#> 135                  Lamar Slnd                    24.8
#> 136               Southern SWAC                    24.8
#> 137       Mount St. Mary's  NEC                    24.7
#> 138       Coastal Carolina   SB                    24.5
#> 139          New Hampshire   AE                    24.4
#> 140 Maryland Eastern Shore MEAC                    24.2
#> 141          Virginia Tech  ACC                    23.8
#> 142               Nebraska  B10                    23.7
#> 143           Portland St. BSky                    23.6
#> 144               Arkansas  SEC                    23.3
#> 145          Tennessee St.  OVC                    23.1
#> 146             Georgetown   BE                    23.1
#> 147             Evansville  MVC                    22.9
#> 148             California  P12                    22.9
#> 149         Long Beach St.   BW                    22.8
#> 150              Villanova   BE                    22.8
#> 151    Charleston Southern BSth                    22.8
#> 152           Oral Roberts  Sum                    22.5
#> 153                  Drake  MVC                    22.4
#> 154           San Jose St.  MWC                    22.4
#> 155         Youngstown St. Horz                    22.3
#> 156              Manhattan MAAC                    22.2
#> 157            Chattanooga   SC                    22.1
#> 158                   Troy   SB                    21.9
#> 159               Monmouth MAAC                    21.9
#> 160             Seton Hall   BE                    21.9
#> 161               Ohio St.  B10                    21.9
#> 162     East Tennessee St.   SC                    21.8
#> 163                   Duke  ACC                    21.6
#> 164             Providence   BE                    21.6
#> 165                   Elon  CAA                    21.5
#> 166             Kansas St.  B12                    21.4
#> 167             Morgan St. MEAC                    21.4
#> 168            North Texas CUSA                    21.3
#> 169                Gonzaga  WCC                    21.2
#> 170              Loyola MD  Pat                    21.1
#> 171             Charleston  CAA                    21.0
#> 172           Missouri St.  MVC                    20.9
#> 173               Missouri  SEC                    20.8
#> 174                Vermont   AE                    20.8
#> 175       Western Kentucky CUSA                    20.6
#> 176               Winthrop BSth                    20.6
#> 177            Connecticut Amer                    20.4
#> 178            Arizona St.  P12                    20.3
#> 179                  Rider MAAC                    20.0
#> 180                Arizona  P12                    20.0
#> 181                 Temple Amer                    20.0
#> 182           Delaware St. MEAC                    19.9
#> 183      Boston University  Pat                    19.9
#> 184              Texas A&M  SEC                    19.8
#> 185                Samford   SC                    19.8
#> 186      Northern Colorado BSky                    19.8
#> 187      Southern Illinois  MVC                    19.8
#> 188               Hartford   AE                    19.6
#> 189                    VMI   SC                    19.4
#> 190              Wisconsin  B10                    19.4
#> 191                   Utah  P12                    19.4
#> 192                Buffalo  MAC                    19.0
#> 193       Western Michigan  MAC                    18.6
#> 194      Abilene Christian Slnd                    18.6
#> 195       Middle Tennessee CUSA                    18.4
#> 196                 Mercer   SC                    18.3
#> 197                 DePaul   BE                    18.3
#> 198        Mississippi St.  SEC                    18.2
#> 199                 Dayton  A10                    18.2
#> 200                Wyoming  MWC                    18.1
#> 201               Penn St.  B10                    17.8
#> 202           Northwestern  B10                    17.6
#> 203                 Towson  CAA                    17.6
#> 204    Central Connecticut  NEC                    17.6
#> 205                Wofford   SC                    17.5
#> 206                  Idaho BSky                    17.5
#> 207                 Denver  Sum                    17.5
#> 208           Morehead St.  OVC                    17.1
#> 209                Pacific  WCC                    17.1
#> 210      Northern Illinois  MAC                    17.0
#> 211              Princeton  Ivy                    17.0
#> 212           Jacksonville ASun                    16.8
#> 213              Milwaukee Horz                    16.6
#> 214                Bradley  MVC                    16.6
#> 215               Stanford  P12                    16.6
#> 216               Kentucky  SEC                    16.5
#> 217           Arkansas St.   SB                    16.5
#> 218         UNC Wilmington  CAA                    16.5
#> 219                   Iona MAAC                    16.4
#> 220          James Madison  CAA                    16.3
#> 221               Kent St.  MAC                    16.3
#> 222                 Purdue  B10                    16.2
#> 223            Stony Brook   AE                    16.0
#> 224               Columbia  Ivy                    16.0
#> 225                Hofstra  CAA                    16.0
#> 226         UNC Greensboro   SC                    15.6
#> 227           Old Dominion CUSA                    15.6
#> 228                 Hawaii   BW                    15.6
#> 229           Gardner Webb BSth                    15.2
#> 230            Austin Peay  OVC                    15.2
#> 231                    UAB CUSA                    15.1
#> 232            Wake Forest  ACC                    15.0
#> 233                Clemson  ACC                    15.0
#> 234              Lafayette  Pat                    14.9
#> 235           Illinois St.  MVC                    14.9
#> 236         Loyola Chicago  MVC                    14.9
#> 237             N.C. State  ACC                    14.7
#> 238        St. Bonaventure  A10                    14.6
#> 239                    BYU  WCC                    14.6
#> 240          Southern Utah BSky                    14.5
#> 241               Longwood BSth                    14.5
#> 242             Valparaiso  MVC                    14.4
#> 243                 Drexel  CAA                    14.2
#> 244             Vanderbilt  SEC                    14.2
#> 245                    TCU  B12                    14.2
#> 246             Cincinnati Amer                    14.0
#> 247        Sam Houston St. Slnd                    14.0
#> 248         Nebraska Omaha  Sum                    14.0
#> 249                 Lehigh  Pat                    13.9
#> 250              Weber St. BSky                    13.8
#> 251               Oklahoma  B12                    13.7
#> 252                   UMKC  WAC                    13.5
#> 253               Bucknell  Pat                    13.4
#> 254           UT Arlington   SB                    13.4
#> 255         Texas Southern SWAC                    13.4
#> 256                 Oregon  P12                    13.3
#> 257                   UCLA  P12                    13.3
#> 258      Stephen F. Austin Slnd                    13.2
#> 259       Eastern Kentucky  OVC                    13.1
#> 260            USC Upstate BSth                    12.9
#> 261                    SMU Amer                    12.8
#> 262               Marshall CUSA                    12.8
#> 263             St. John's   BE                    12.8
#> 264                Stetson ASun                    12.8
#> 265             Wright St. Horz                    12.7
#> 266                    USC  P12                    12.6
#> 267               Miami OH  MAC                    12.6
#> 268           Nicholls St. Slnd                    12.4
#> 269               Maryland  B10                    12.4
#> 270        Appalachian St.   SB                    12.4
#> 271            Georgia St.   SB                    12.3
#> 272            Indiana St.  MVC                    12.2
#> 273           George Mason  A10                    12.2
#> 274          Northern Iowa  MVC                    12.1
#> 275         William & Mary  CAA                    12.1
#> 276              Texas St.   SB                    12.0
#> 277           Oklahoma St.  B12                    12.0
#> 278               Cal Poly   BW                    11.7
#> 279              Idaho St. BSky                    11.7
#> 280             Louisville  ACC                    11.7
#> 281       Loyola Marymount  WCC                    11.7
#> 282                   Yale  Ivy                    11.6
#> 283                  Siena MAAC                    11.6
#> 284       Florida Atlantic CUSA                    11.4
#> 285   UT Rio Grande Valley  WAC                    11.4
#> 286     South Carolina St. MEAC                    11.3
#> 287          San Diego St.  MWC                    11.1
#> 288                Indiana  B10                    11.0
#> 289                Rutgers  B10                    10.9
#> 290              Air Force  MWC                    10.9
#> 291            Utah Valley  WAC                    10.9
#> 292          West Virginia  B12                    10.8
#> 293                 Albany   AE                    10.7
#> 294                   Rice CUSA                    10.7
#> 295     North Carolina A&T MEAC                    10.5
#> 296             Alcorn St. SWAC                    10.3
#> 297                    VCU  A10                    10.1
#> 298                  Tulsa Amer                     9.9
#> 299         Louisiana Tech CUSA                     9.8
#> 300                   Iowa  B10                     9.4
#> 301            Alabama St. SWAC                     9.2
#> 302        Houston Baptist Slnd                     9.1
#> 303         St. Francis NY  NEC                     9.0
#> 304       UC Santa Barbara   BW                     9.0
#> 305                   UTEP CUSA                     8.7
#> 306                Niagara MAAC                     8.5
#> 307                 Marist MAAC                     8.4
#> 308           UC Riverside   BW                     8.3
#> 309       South Dakota St.  Sum                     8.3
#> 310       SIU Edwardsville  OVC                     8.3
#> 311       Jacksonville St.  OVC                     8.2
#> 312                Radford BSth                     8.2
#> 313       Illinois Chicago Horz                     8.0
#> 314              UC Irvine   BW                     8.0
#> 315              Marquette   BE                     7.9
#> 316         South Carolina  SEC                     7.8
#> 317          Massachusetts  A10                     7.8
#> 318                Liberty ASun                     7.6
#> 319               Colorado  P12                     7.5
#> 320 Southeast Missouri St.  OVC                     7.2
#> 321             Oregon St.  P12                     7.0
#> 322            Norfolk St. MEAC                     6.4
#> 323      Purdue Fort Wayne  Sum                     6.2
#> 324          Saint Peter's MAAC                     6.2
#> 325             High Point BSth                     6.1
#> 326              Dartmouth  Ivy                     6.1
#> 327               Virginia  ACC                     6.0
#> 328            Montana St. BSky                     6.0
#> 329               Illinois  B10                     6.0
#> 330               La Salle  A10                     5.9
#> 331                Houston Amer                     5.8
#> 332                Memphis Amer                     5.7
#> 333              Charlotte CUSA                     5.7
#> 334              Fairfield MAAC                     5.7
#> 335         New Mexico St.  WAC                     5.6
#> 336                Florida  SEC                     5.3
#> 337       North Dakota St.  Sum                     5.3
#> 338               Richmond  A10                     4.9
#> 339               Michigan  B10                     4.9
#> 340     Florida Gulf Coast ASun                     4.9
#> 341            Florida St.  ACC                     4.4
#> 342                Belmont  OVC                     4.3
#> 343          Bowling Green  MAC                     4.2
#> 344                   Navy  Pat                     4.2
#> 345               Davidson  A10                     4.0
#> 346       Eastern Illinois  OVC                     4.0
#> 347                    UCF Amer                     3.6
#> 348          South Florida Amer                     3.2
#> 349          East Carolina Amer                     3.1
#> 350            Wichita St. Amer                     2.6
#> 351               Campbell BSth                     2.5
#> 352           Michigan St.  B10                     2.1
#> 353       Western Illinois  Sum                     1.7
#>     TwoFoulParticpation.Pct.Rk Adj2FP Adj2FP.Rk TwoFoulTotalTime
#> 1                            1   45.2         1           334:36
#> 2                            2   39.0         2           173:06
#> 3                            3   33.6         4           269:13
#> 4                            4   32.0         7           395:19
#> 5                            5   32.4         6           276:14
#> 6                            6   34.1         3           342:08
#> 7                            7   32.6         5           275:21
#> 8                            8   29.7        10           225:56
#> 9                            9   30.0         8           160:07
#> 10                          10   30.0         9           261:18
#> 11                          11   28.7        11           160:45
#> 12                          12   28.6        12           164:15
#> 13                          13   25.9        16           340:00
#> 14                          14   28.2        13           297:24
#> 15                          15   25.1        18           266:50
#> 16                          16   26.4        14           263:50
#> 17                          17   25.3        17           318:53
#> 18                          18   26.1        15           375:07
#> 19                          19   22.1        22           277:50
#> 20                          20   24.8        19           308:27
#> 21                          21   23.2        20           354:41
#> 22                          22   23.0        21           161:17
#> 23                          23   20.3        26           285:39
#> 24                          24   21.1        25           269:16
#> 25                          25   21.9        23           471:23
#> 26                          26   21.6        24           215:57
#> 27                          27   19.4        29           123:25
#> 28                          28   19.6        28           243:49
#> 29                          29   19.1        33           265:36
#> 30                          30   19.3        31           282:29
#> 31                          31   15.8        42           177:27
#> 32                          32   19.3        30           280:25
#> 33                          33   19.2        32           141:25
#> 34                          34   15.5        43           145:34
#> 35                          35   19.1        34           210:25
#> 36                          36   18.2        35           184:14
#> 37                          37   17.9        37           244:42
#> 38                          38   17.3        38           275:04
#> 39                          39   18.1        36           225:09
#> 40                          40   19.8        27           197:31
#> 41                          41   16.2        41           301:01
#> 42                          42   16.3        40           447:05
#> 43                          43   14.0        49           228:31
#> 44                          44   12.9        54           298:21
#> 45                          45   15.2        45           321:42
#> 46                          46   16.4        39           204:23
#> 47                          47   13.4        50           281:35
#> 48                          48   15.3        44           272:52
#> 49                          49   13.2        51           225:53
#> 50                          50   13.0        53           380:20
#> 51                          51   12.3        55           331:25
#> 52                          52   15.0        46           216:30
#> 53                          53   14.3        48           362:33
#> 54                          54   14.7        47           354:30
#> 55                          55   13.1        52           323:55
#> 56                          56   10.6        62           335:12
#> 57                          57   11.0        59           226:06
#> 58                          58   10.8        60           352:31
#> 59                          59    8.8        70           205:32
#> 60                          60   10.1        65           277:27
#> 61                          61   11.1        57           303:26
#> 62                          62   11.6        56           279:23
#> 63                          63    8.4        71           268:47
#> 64                          64   11.0        58           242:43
#> 65                          65   10.8        61           219:00
#> 66                          66    7.7        74           169:37
#> 67                          67    6.2        86           216:18
#> 68                          68    9.5        66           234:16
#> 69                          69    9.0        69           283:37
#> 70                          70   10.1        64           204:51
#> 71                          71    9.4        67           316:51
#> 72                          72    6.4        85           238:19
#> 73                          73    9.1        68           340:33
#> 74                          74   10.3        63           183:07
#> 75                          75    6.9        79           254:39
#> 76                          76    7.2        77           320:57
#> 77                          77    8.2        72           311:49
#> 78                          78    7.6        75           146:02
#> 79                          79    5.9        93           271:43
#> 80                          80    6.6        81           229:56
#> 81                          81    4.8       104           154:13
#> 82                          82    7.8        73           372:09
#> 83                          83    5.6        96           247:02
#> 84                          84    5.6        97           187:42
#> 85                          85    6.0        88           230:31
#> 86                          86    5.0       101           395:35
#> 87                          87    6.7        80           217:35
#> 88                          88    7.0        78           228:52
#> 89                          89    5.6        95           203:50
#> 90                          90    6.2        87           228:26
#> 91                          91    5.9        92           232:57
#> 92                          92    7.5        76           208:32
#> 93                          93    6.0        89           250:56
#> 94                          94    4.9       103           137:06
#> 95                          95    4.2       110           107:14
#> 96                          96    5.5        98           258:53
#> 97                          97    4.8       105           223:29
#> 98                          98    4.5       107           307:57
#> 99                          99    6.6        82           408:27
#> 100                        100    6.4        84           325:32
#> 101                        101    6.5        83           242:35
#> 102                        102    3.2       114           279:32
#> 103                        103    6.0        90           174:32
#> 104                        104    4.5       108           263:14
#> 105                        105    5.9        91           186:26
#> 106                        106    5.1       100           215:52
#> 107                        107    5.3        99           232:44
#> 108                        108    4.2       109           311:39
#> 109                        109    2.9       119           244:20
#> 110                        110    1.8       126           259:02
#> 111                        111    2.2       122           190:31
#> 112                        112    4.7       106           327:18
#> 113                        113    2.7       120           313:41
#> 114                        114    3.0       118           204:17
#> 115                        115    5.8        94           128:32
#> 116                        116    3.3       111           246:43
#> 117                        117    4.9       102           208:34
#> 118                        118    1.1       131           274:14
#> 119                        119    3.0       116           289:12
#> 120                        120    1.0       134           303:15
#> 121                        121    3.2       112           289:25
#> 122                        122    0.3       143           127:02
#> 123                        123    3.2       113           187:12
#> 124                        124   -0.1       145           243:31
#> 125                        125    1.0       133           234:51
#> 126                        126   -1.0       157           314:51
#> 127                        127    2.2       121           233:29
#> 128                        128    1.1       132           215:21
#> 129                        129    3.0       117            93:42
#> 130                        130    1.9       124           325:58
#> 131                        131   -0.2       146           190:11
#> 132                        132   -0.4       152           289:40
#> 133                        133    3.2       115           276:24
#> 134                        134    0.8       135           288:16
#> 135                        135    0.5       138           314:35
#> 136                        136    0.8       136           408:54
#> 137                        137    1.3       130           220:18
#> 138                        138    1.8       125           403:55
#> 139                        139    0.4       141           352:24
#> 140                        140    1.9       123           168:45
#> 141                        141   -0.3       149           164:30
#> 142                        142    0.1       144           196:27
#> 143                        143   -0.9       156           289:42
#> 144                        144   -1.2       160           305:15
#> 145                        145    1.6       129           329:25
#> 146                        146    0.4       140           282:00
#> 147                        147   -0.2       148           239:53
#> 148                        148    1.7       127           363:32
#> 149                        149   -2.0       171           366:29
#> 150                        150   -0.4       153           208:49
#> 151                        151    0.5       139           232:34
#> 152                        152   -1.7       167           208:16
#> 153                        153   -0.4       151           234:00
#> 154                        154   -0.8       155           209:53
#> 155                        155    0.6       137           228:11
#> 156                        156   -2.1       172           310:43
#> 157                        157    1.6       128           158:57
#> 158                        158   -3.0       181           207:39
#> 159                        159   -2.9       179           259:35
#> 160                        160   -0.2       147           219:39
#> 161                        161   -1.6       165           268:02
#> 162                        162   -1.4       161           368:33
#> 163                        163   -2.5       176           251:20
#> 164                        164   -1.1       158           294:26
#> 165                        165   -0.3       150           376:12
#> 166                        166   -1.2       159           382:18
#> 167                        167    0.4       142           265:42
#> 168                        168   -1.8       168           194:28
#> 169                        169   -4.9       200           165:29
#> 170                        170   -1.5       163           214:21
#> 171                        171   -3.5       185           135:39
#> 172                        172   -3.1       182           320:44
#> 173                        173   -0.6       154           352:29
#> 174                        174   -1.9       169           315:37
#> 175                        175   -3.6       186           152:03
#> 176                        176   -4.0       189           255:25
#> 177                        177   -1.6       166           310:46
#> 178                        178   -6.0       209           179:00
#> 179                        179   -2.1       173           267:39
#> 180                        180   -5.3       203           212:19
#> 181                        181   -1.5       164           190:38
#> 182                        182   -1.4       162           297:50
#> 183                        183   -4.4       194           100:13
#> 184                        184   -3.1       183           140:05
#> 185                        185   -3.0       180           299:18
#> 186                        186   -2.5       177           193:42
#> 187                        187   -3.8       187           216:06
#> 188                        188   -4.8       198           404:54
#> 189                        189   -4.4       192           160:12
#> 190                        190   -2.4       175           173:28
#> 191                        191   -3.3       184           148:33
#> 192                        192   -4.3       190           261:28
#> 193                        193   -3.8       188           308:33
#> 194                        194   -7.1       223           270:49
#> 195                        195   -5.3       204           279:20
#> 196                        196   -5.7       208           245:40
#> 197                        197   -6.3       213           294:04
#> 198                        198   -4.4       193           243:31
#> 199                        199   -7.0       220           217:47
#> 200                        200   -4.7       197           368:55
#> 201                        201   -7.2       224           280:30
#> 202                        202   -5.5       205           231:53
#> 203                        203   -4.9       201           251:17
#> 204                        204   -6.0       210           303:01
#> 205                        205   -2.3       174           192:04
#> 206                        206   -2.7       178           260:02
#> 207                        207   -4.6       195           287:24
#> 208                        208   -7.1       221           196:08
#> 209                        209   -2.0       170           206:50
#> 210                        210   -6.3       214           165:44
#> 211                        211   -8.1       234           133:04
#> 212                        212   -7.7       230           123:00
#> 213                        213   -7.7       229           230:33
#> 214                        214  -10.1       261           238:37
#> 215                        215   -8.5       240           190:46
#> 216                        216   -6.5       216           323:31
#> 217                        217   -5.3       202           450:15
#> 218                        218   -6.7       219           279:43
#> 219                        219   -6.5       217           330:45
#> 220                        220   -6.7       218           242:00
#> 221                        221   -8.0       233           241:33
#> 222                        222   -6.1       211           200:47
#> 223                        223   -4.6       196           192:10
#> 224                        224   -4.3       191           218:31
#> 225                        225   -4.9       199           221:43
#> 226                        226   -7.8       231           183:01
#> 227                        227   -9.1       248           250:57
#> 228                        228   -5.6       206           215:42
#> 229                        229  -11.2       275           188:34
#> 230                        230  -10.0       259           281:40
#> 231                        231   -8.8       245           146:24
#> 232                        232   -8.5       239           239:57
#> 233                        233   -9.4       250           168:26
#> 234                        234   -8.6       244           111:35
#> 235                        235   -8.3       235           208:16
#> 236                        236  -13.4       298           144:32
#> 237                        237   -8.4       236           278:21
#> 238                        238   -6.2       212           226:44
#> 239                        239   -9.7       254           156:23
#> 240                        240   -7.1       222           297:59
#> 241                        241   -7.4       226           186:52
#> 242                        242   -9.2       249           292:49
#> 243                        243   -9.6       253           183:33
#> 244                        244   -8.6       243           408:16
#> 245                        245  -10.0       260           164:08
#> 246                        246   -8.6       242           211:41
#> 247                        247   -7.6       227           365:33
#> 248                        248   -6.5       215           311:52
#> 249                        249   -8.9       247           186:08
#> 250                        250   -9.4       251           191:54
#> 251                        251  -13.5       300            83:38
#> 252                        252   -9.9       257           312:42
#> 253                        253   -8.4       237           356:48
#> 254                        254  -11.7       279           211:34
#> 255                        255  -10.8       268           216:23
#> 256                        256   -8.4       238           211:32
#> 257                        257  -10.3       263           292:00
#> 258                        258   -9.5       252           223:37
#> 259                        259  -10.8       270           337:40
#> 260                        260   -9.8       255           258:48
#> 261                        261  -12.3       284           196:12
#> 262                        262   -5.6       207           198:35
#> 263                        263  -12.0       281           293:10
#> 264                        264   -7.8       232           180:33
#> 265                        265  -12.1       283           200:40
#> 266                        266  -11.3       276           234:29
#> 267                        267  -10.2       262           243:14
#> 268                        268   -8.8       246           361:26
#> 269                        269   -7.7       228           177:17
#> 270                        270  -12.5       286           172:15
#> 271                        271   -8.5       241           261:08
#> 272                        272  -11.0       272           226:26
#> 273                        273  -10.9       271           293:49
#> 274                        274  -12.6       287           150:27
#> 275                        275  -13.3       295           193:54
#> 276                        276  -10.4       265           236:33
#> 277                        277  -10.0       258           264:19
#> 278                        278   -9.9       256           279:03
#> 279                        279  -15.1       307           142:37
#> 280                        280  -12.9       293           145:04
#> 281                        281  -11.7       278           234:49
#> 282                        282  -15.6       313           120:30
#> 283                        283  -10.8       269           253:04
#> 284                        284  -10.4       266           110:33
#> 285                        285  -13.6       302           183:02
#> 286                        286  -12.4       285           109:34
#> 287                        287  -13.3       294           287:34
#> 288                        288  -13.4       299           233:52
#> 289                        289   -7.3       225           170:30
#> 290                        290  -11.1       274           240:28
#> 291                        291  -11.8       280           233:23
#> 292                        292  -10.6       267           260:51
#> 293                        293  -11.3       277           209:17
#> 294                        294  -15.7       315           158:14
#> 295                        295  -12.7       290           306:00
#> 296                        296  -11.1       273           229:50
#> 297                        297  -14.2       304           196:33
#> 298                        298  -17.2       332           171:00
#> 299                        299  -12.9       292           203:56
#> 300                        300  -15.7       316           152:31
#> 301                        301  -12.1       282           337:03
#> 302                        302  -12.6       288           285:17
#> 303                        303  -16.3       322           263:59
#> 304                        304  -12.7       289           213:33
#> 305                        305  -14.9       306           238:51
#> 306                        306  -12.8       291           184:27
#> 307                        307  -13.4       296           256:33
#> 308                        308  -15.9       317           174:33
#> 309                        309  -16.3       324           244:01
#> 310                        310  -14.1       303           235:48
#> 311                        311  -10.3       264           104:33
#> 312                        312  -13.6       301           117:36
#> 313                        313  -15.5       311           301:57
#> 314                        314  -16.5       326           248:34
#> 315                        315  -16.5       327           271:57
#> 316                        316  -15.5       310           304:11
#> 317                        317  -16.2       321           246:58
#> 318                        318  -15.6       312           149:36
#> 319                        319  -13.4       297           189:46
#> 320                        320  -15.2       308           311:47
#> 321                        321  -17.6       335           199:29
#> 322                        322  -16.7       328           153:21
#> 323                        323  -17.9       337           170:24
#> 324                        324  -14.3       305           267:50
#> 325                        325  -17.5       334           274:20
#> 326                        326  -19.0       343           142:57
#> 327                        327  -15.7       314           142:54
#> 328                        328  -16.1       320           222:52
#> 329                        329  -16.9       331           241:52
#> 330                        330  -15.3       309           268:03
#> 331                        331  -16.7       329           329:50
#> 332                        332  -18.6       341           344:23
#> 333                        333  -19.1       344           104:53
#> 334                        334  -18.0       338           185:33
#> 335                        335  -16.4       325           206:06
#> 336                        336  -16.3       323           327:17
#> 337                        337  -17.3       333           211:45
#> 338                        338  -18.3       340           113:44
#> 339                        339  -19.4       347           178:12
#> 340                        340  -16.7       330           185:31
#> 341                        341  -18.7       342           208:34
#> 342                        342  -22.2       352           143:04
#> 343                        343  -16.1       319           241:38
#> 344                        344  -18.2       339           146:07
#> 345                        345  -21.3       350           156:33
#> 346                        346  -17.7       336           216:32
#> 347                        347  -15.9       318           312:37
#> 348                        348  -21.2       349           271:52
#> 349                        349  -19.1       345           301:02
#> 350                        350  -20.3       348           236:19
#> 351                        351  -24.8       353           109:59
#> 352                        352  -22.0       351           205:31
#> 353                        353  -19.4       346           195:34
#>     TwoFoulTotalTime.Rk TwoFoulTimeOn TwoFoulTimeOn.Rk Bench.Pct Bench.Pct.Rk
#> 1                    36        229:52                1      26.5          267
#> 2                   294        105:56               40      27.2          254
#> 3                   123        154:20                9      17.8          350
#> 4                    10        223:04                2      26.2          272
#> 5                   112        154:13               10      30.1          174
#> 6                    30        184:45                4      18.0          349
#> 7                   113        147:33               13      28.2          229
#> 8                   203        119:04               27      30.9          155
#> 9                   310         83:47               65      17.2          352
#> 10                  137        136:13               16      26.8          262
#> 11                  308         82:29               69      22.1          327
#> 12                  305         83:36               67      20.4          340
#> 13                   32        169:05                7      28.4          222
#> 14                   80        147:40               12      27.6          249
#> 15                  129        130:20               18      26.4          268
#> 16                  134        127:23               21      30.4          167
#> 17                   50        153:27               11      26.4          269
#> 18                   14        180:02                5      18.2          348
#> 19                  109        132:34               17      21.9          330
#> 20                   65        145:49               14      29.4          197
#> 21                   24        165:55                8      31.0          151
#> 22                  307         73:34               95      28.6          216
#> 23                   94        128:25               19      32.9          110
#> 24                  122        120:25               24      41.6           10
#> 25                    1        207:43                3      26.8          263
#> 26                  221         94:38               50      32.8          114
#> 27                  339         53:59              155      29.7          187
#> 28                  161        106:04               39      35.2           77
#> 29                  131        114:46               33      21.1          336
#> 30                   97        120:21               25      31.6          139
#> 31                  289         74:57               90      33.1          106
#> 32                  102        118:20               28      28.9          210
#> 33                  332         59:30              134      18.8          347
#> 34                  325         60:53              131      23.8          308
#> 35                  232         88:00               58      22.9          316
#> 36                  281         76:21               87      28.7          215
#> 37                  158        100:53               45      29.0          206
#> 38                  114        111:59               37      28.7          212
#> 39                  205         91:27               54      38.3           28
#> 40                  255         79:44               78      29.9          182
#> 41                   75        116:01               30      27.3          253
#> 42                    3        171:21                6      25.5          287
#> 43                  197         87:20               60      27.6          248
#> 44                   77        113:00               36      22.3          326
#> 45                   47        121:20               23      27.7          246
#> 46                  247         76:22               86      31.8          136
#> 47                  100        103:57               42      23.9          306
#> 48                  117         99:55               46      29.6          191
#> 49                  204         82:18               70      23.9          304
#> 50                   12        136:37               15      24.2          299
#> 51                   37        118:13               29      23.8          307
#> 52                  217         76:52               85      34.4           88
#> 53                   21        128:10               20      20.8          339
#> 54                   25        125:12               22      33.8           95
#> 55                   45        114:14               35      35.6           73
#> 56                   35        115:05               32      30.8          156
#> 57                  202         77:01               84      22.1          328
#> 58                   26        120:03               26      32.5          121
#> 59                  244         69:59              107      23.6          312
#> 60                  110         93:47               51      31.0          154
#> 61                   70        101:07               44      42.8            4
#> 62                  105         92:14               53      37.0           44
#> 63                  124         88:27               57      17.7          351
#> 64                  165         79:48               76      33.6           99
#> 65                  212         71:41              103      37.5           34
#> 66                  299         54:50              148      37.9           31
#> 67                  219         69:44              108      25.1          291
#> 68                  183         74:52               91      23.9          305
#> 69                   96         89:31               56      25.4          289
#> 70                  246         64:24              124      28.0          236
#> 71                   51         99:34               47      31.5          140
#> 72                  176         74:01               94      22.6          321
#> 73                   31        105:24               41      38.7           23
#> 74                  283         56:19              145      29.6          188
#> 75                  147         77:11               83      32.6          118
#> 76                   48         96:38               49      36.1           63
#> 77                   59         93:34               52      40.3           13
#> 78                  324         43:48              191      21.8          333
#> 79                  120         81:24               73      23.8          309
#> 80                  194         68:01              112      30.1          177
#> 81                  315         45:34              183      32.8          115
#> 82                   15        109:46               38      35.1           79
#> 83                  154         72:47               99      37.5           33
#> 84                  273         55:08              146      24.0          302
#> 85                  193         67:39              114      31.3          143
#> 86                    9        115:57               31      21.1          338
#> 87                  215         63:34              127      28.4          223
#> 88                  196         66:47              117      39.1           19
#> 89                  250         59:23              136      21.9          331
#> 90                  198         66:33              120      27.6          247
#> 91                  188         67:31              115      22.7          318
#> 92                  238         60:20              132      30.2          171
#> 93                  152         72:36              101      29.3          200
#> 94                  334         39:25              207      25.6          283
#> 95                  348         30:46              243      30.1          173
#> 96                  143         73:33               96      29.4          199
#> 97                  207         63:08              129      27.1          255
#> 98                   66         86:46               61      26.1          273
#> 99                    5        114:29               34      28.8          211
#> 100                  44         91:11               55      32.8          113
#> 101                 166         67:49              113      22.8          317
#> 102                 104         77:31               82      31.2          148
#> 103                 292         48:21              172      36.1           61
#> 104                 135         72:49               98      27.7          245
#> 105                 276         51:13              166      28.1          234
#> 106                 222         59:12              138      28.1          233
#> 107                 189         63:44              125      36.8           51
#> 108                  61         85:12               63      29.8          184
#> 109                 159         66:34              119      25.2          290
#> 110                 142         70:19              106      26.1          274
#> 111                 269         51:31              163      24.1          301
#> 112                  41         87:51               59      24.3          298
#> 113                  55         84:03               64      34.6           82
#> 114                 248         54:10              153      34.9           80
#> 115                 337         33:51              223      19.4          343
#> 116                 156         64:58              123      31.1          150
#> 117                 237         54:26              149      36.2           58
#> 118                 116         71:12              104      24.0          303
#> 119                  90         75:05               89      24.9          294
#> 120                  71         78:42               80      25.7          280
#> 121                  89         74:11               93      23.8          310
#> 122                 338         32:22              232      30.2          169
#> 123                 274         47:40              176      20.2          341
#> 124                 163         61:45              130      33.9           94
#> 125                 180         59:32              133      28.6          218
#> 126                  53         79:47               77      35.1           78
#> 127                 186         58:51              139      30.7          161
#> 128                 224         54:15              152      27.4          252
#> 129                 352         23:36              278      32.4          123
#> 130                  43         82:01               71      36.9           45
#> 131                 270         47:49              175      36.6           53
#> 132                  88         72:44              100      31.3          144
#> 133                 111         69:24              109      30.7          160
#> 134                  91         71:49              102      21.1          337
#> 135                  54         78:01               81      22.6          319
#> 136                   4        101:12               43      39.0           20
#> 137                 210         54:24              151      21.1          335
#> 138                   8         99:02               48      39.2           18
#> 139                  28         85:51               62      21.9          329
#> 140                 300         40:54              202      42.8            6
#> 141                 304         39:05              209      30.8          158
#> 142                 257         46:38              180      30.1          178
#> 143                  87         68:25              111      34.5           84
#> 144                  68         71:10              105      23.7          311
#> 145                  40         76:06               88      31.7          138
#> 146                  98         65:05              122      21.4          334
#> 147                 173         54:57              147      37.7           32
#> 148                  20         83:10               68      26.6          265
#> 149                  18         83:36               66      36.1           62
#> 150                 235         47:38              177      18.9          345
#> 151                 190         52:59              160      28.2          228
#> 152                 240         46:56              179      29.8          183
#> 153                 184         52:29              162      26.1          275
#> 154                 233         47:01              178      36.0           65
#> 155                 199         50:53              167      29.7          186
#> 156                  63         68:56              110      34.7           81
#> 157                 311         35:07              221      28.3          225
#> 158                 241         45:35              182      41.8            9
#> 159                 141         56:53              144      37.2           41
#> 160                 211         48:04              173      33.0          107
#> 161                 126         58:37              140      30.5          163
#> 162                  17         80:15               75      29.6          190
#> 163                 149         54:24              150      35.6           75
#> 164                  81         63:42              126      30.7          159
#> 165                  13         81:03               74      30.1          172
#> 166                  11         81:59               72      33.1          105
#> 167                 130         56:54              143      29.3          201
#> 168                 261         41:27              199      28.5          221
#> 169                 303         35:09              220      23.6          313
#> 170                 225         45:14              185      32.8          116
#> 171                 335         28:32              253      27.5          251
#> 172                  49         66:56              116      38.9           21
#> 173                  27         73:18               97      36.4           57
#> 174                  52         65:29              121      34.6           83
#> 175                 318         31:22              238      19.2          344
#> 176                 146         52:32              161      36.7           52
#> 177                  62         63:15              128      38.5           25
#> 178                 287         36:23              215      34.0           92
#> 179                 128         53:33              157      27.9          241
#> 180                 227         42:26              196      31.0          153
#> 181                 268         38:05              213      29.6          189
#> 182                  79         59:23              135      27.0          258
#> 183                 351         19:57              297      33.5          100
#> 184                 333         27:46              259      32.5          120
#> 185                  76         59:16              137      29.0          207
#> 186                 263         38:19              212      26.1          276
#> 187                 220         42:41              195      28.5          219
#> 188                   7         79:18               79      25.7          279
#> 189                 309         31:10              239      31.4          142
#> 190                 293         33:36              225      28.9          209
#> 191                 321         28:45              250      29.5          194
#> 192                 136         49:43              171      25.4          288
#> 193                  64         57:32              142      33.3          102
#> 194                 121         50:24              168      38.3           27
#> 195                 106         51:21              164      30.1          175
#> 196                 157         44:53              187      33.1          104
#> 197                  82         53:42              156      22.4          324
#> 198                 162         44:19              189      22.6          320
#> 199                 214         39:33              204      25.9          278
#> 200                  16         66:40              118      30.6          162
#> 201                 101         49:54              170      34.4           89
#> 202                 191         40:56              200      32.2          127
#> 203                 150         44:15              190      33.6           98
#> 204                  72         53:10              159      42.7            7
#> 205                 265         33:39              224      34.5           85
#> 206                 140         45:26              184      40.6           12
#> 207                  93         50:12              169      27.9          239
#> 208                 259         33:28              227      32.4          124
#> 209                 242         35:17              219      47.0            2
#> 210                 302         28:13              256      28.3          226
#> 211                 336         22:38              283      30.4          166
#> 212                 340         20:41              294      33.6           97
#> 213                 192         38:19              211      28.1          232
#> 214                 175         39:39              203      29.6          192
#> 215                 267         31:38              236      25.0          293
#> 216                  46         53:30              158      25.7          281
#> 217                   2         74:27               92      32.6          119
#> 218                 103         46:03              181      32.9          112
#> 219                  38         54:09              154      25.1          292
#> 220                 167         39:32              205      27.1          257
#> 221                 170         39:27              206      26.4          270
#> 222                 251         32:35              231      35.7           72
#> 223                 264         30:46              242      27.9          240
#> 224                 213         34:58              222      25.5          286
#> 225                 209         35:26              218      14.2          353
#> 226                 285         28:36              252      36.6           54
#> 227                 151         39:05              208      32.2          128
#> 228                 223         33:35              226      22.4          325
#> 229                 272         28:36              251      27.1          256
#> 230                  99         42:41              194      23.1          315
#> 231                 322         22:04              286      32.6          117
#> 232                 172         36:02              216      35.7           71
#> 233                 301         25:13              273      29.5          195
#> 234                 344         16:41              312      34.5           86
#> 235                 239         31:02              240      35.9           66
#> 236                 327         21:29              290      29.0          205
#> 237                 108         40:54              201      27.0          259
#> 238                 200         33:11              229      28.1          235
#> 239                 314         22:45              282      27.7          244
#> 240                  78         43:10              193      32.5          122
#> 241                 275         27:04              262      38.8           22
#> 242                  85         42:10              198      35.6           74
#> 243                 282         26:07              265      26.3          271
#> 244                   6         58:01              141      31.5          141
#> 245                 306         23:19              280      31.2          149
#> 246                 229         29:41              245      29.2          203
#> 247                  19         51:15              165      36.2           59
#> 248                  58         43:43              192      26.7          264
#> 249                 277         25:57              267      30.1          176
#> 250                 266         26:25              263      26.5          266
#> 251                 353         11:27              327      22.5          323
#> 252                  56         42:20              197      37.3           38
#> 253                  23         47:54              174      30.1          179
#> 254                 230         28:21              254      37.1           43
#> 255                 218         28:56              249      39.6           16
#> 256                 231         28:11              257      31.2          146
#> 257                  86         38:46              210      35.8           68
#> 258                 206         29:31              247      37.3           39
#> 259                  33         44:23              188      30.8          157
#> 260                 144         33:20              228      32.3          126
#> 261                 258         25:13              272      27.8          242
#> 262                 254         25:30              269      29.5          193
#> 263                  84         37:30              214      36.9           46
#> 264                 286         23:03              281      28.3          227
#> 265                 252         25:26              270      27.9          237
#> 266                 182         29:33              246      32.1          129
#> 267                 164         30:37              244      40.8           11
#> 268                  22         45:00              186      31.0          152
#> 269                 290         22:02              287      18.8          346
#> 270                 295         21:24              291      25.9          277
#> 271                 138         32:03              234      30.5          164
#> 272                 201         27:43              260      28.3          224
#> 273                  83         35:52              217      25.5          285
#> 274                 319         18:11              306      19.9          342
#> 275                 262         23:26              279      29.4          196
#> 276                 177         28:21              255      34.0           91
#> 277                 132         31:37              237      32.3          125
#> 278                 107         32:44              230      42.6            8
#> 279                 331         16:41              311      27.0          260
#> 280                 326         16:58              308      32.9          111
#> 281                 181         27:24              261      34.4           87
#> 282                 341         14:01              321      21.8          332
#> 283                 148         29:14              248      25.6          282
#> 284                 345         12:38              324      36.5           56
#> 285                 284         20:54              292      39.6           14
#> 286                 347         12:24              325      35.8           69
#> 287                  92         31:58              235      24.7          296
#> 288                 185         25:45              268      37.1           42
#> 289                 297         18:38              305      36.5           55
#> 290                 171         26:14              264      28.5          220
#> 291                 187         25:23              271      33.3          101
#> 292                 139         28:04              258      42.8            5
#> 293                 234         22:25              284      30.2          170
#> 294                 312         16:53              309      31.9          135
#> 295                  67         32:09              233      33.6           96
#> 296                 195         23:36              277      29.2          202
#> 297                 256         19:51              298      38.2           29
#> 298                 296         16:52              310      33.2          103
#> 299                 249         20:00              296      32.0          131
#> 300                 317         14:23              319      29.0          204
#> 301                  34         30:50              241      38.1           30
#> 302                  95         26:03              266      37.4           37
#> 303                 133         23:51              276      28.6          217
#> 304                 226         19:12              304      27.8          243
#> 305                 174         20:43              293      30.5          165
#> 306                 280         15:41              316      36.0           64
#> 307                 145         21:33              289      31.9          134
#> 308                 291         14:33              317      43.2            3
#> 309                 160         20:18              295      28.9          208
#> 310                 179         19:35              301      36.8           49
#> 311                 350          8:33              344      39.6           15
#> 312                 342          9:37              335      30.0          180
#> 313                  73         24:04              274      33.9           93
#> 314                 153         19:45              299      37.5           35
#> 315                 118         21:35              288      31.2          145
#> 316                  69         23:53              275      35.8           67
#> 317                 155         19:12              303      27.6          250
#> 318                 320         11:22              328      23.5          314
#> 319                 271         14:15              320      31.2          147
#> 320                  60         22:23              285      33.0          109
#> 321                 253         14:00              322      24.7          295
#> 322                 316          9:46              334      34.1           90
#> 323                 298         10:38              331      31.7          137
#> 324                 127         16:37              314      49.1            1
#> 325                 115         16:40              313      36.8           50
#> 326                 329          8:40              341      28.2          230
#> 327                 330          8:36              343      22.5          322
#> 328                 208         13:20              323      28.2          231
#> 329                 168         14:23              318      26.9          261
#> 330                 125         15:44              315      39.5           17
#> 331                  39         19:16              302      36.9           47
#> 332                  29         19:42              300      37.3           40
#> 333                 349          5:59              349      25.6          284
#> 334                 278         10:31              332      33.0          108
#> 335                 243         11:33              326      36.9           48
#> 336                  42         17:24              307      24.2          300
#> 337                 228         11:12              330      32.1          130
#> 338                 343          5:37              350      29.4          198
#> 339                 288          8:44              340      30.0          181
#> 340                 279          9:01              338      35.7           70
#> 341                 236          9:08              337      38.5           24
#> 342                 328          6:12              347      29.7          185
#> 343                 169         10:16              333      35.6           76
#> 344                 323          6:11              348      28.7          214
#> 345                 313          6:20              345      27.9          238
#> 346                 216          8:38              342      30.2          168
#> 347                  57         11:20              329      37.5           36
#> 348                 119          8:49              339      28.7          213
#> 349                  74          9:25              336      31.9          133
#> 350                 178          6:13              346      38.4           26
#> 351                 346          2:45              353      36.2           60
#> 352                 245          4:17              351      32.0          132
#> 353                 260          3:15              352      24.5          297
#>     NCAA_Seed Year
#> 1          NA 2020
#> 2          NA 2020
#> 3          NA 2020
#> 4          15 2020
#> 5          NA 2020
#> 6          NA 2020
#> 7          NA 2020
#> 8          NA 2020
#> 9          NA 2020
#> 10         15 2020
#> 11         NA 2020
#> 12         NA 2020
#> 13         NA 2020
#> 14         NA 2020
#> 15         NA 2020
#> 16         NA 2020
#> 17         NA 2020
#> 18         NA 2020
#> 19         NA 2020
#> 20         NA 2020
#> 21         15 2020
#> 22         NA 2020
#> 23         NA 2020
#> 24         NA 2020
#> 25         NA 2020
#> 26         NA 2020
#> 27         NA 2020
#> 28         NA 2020
#> 29         NA 2020
#> 30         NA 2020
#> 31         NA 2020
#> 32         NA 2020
#> 33         NA 2020
#> 34         NA 2020
#> 35         NA 2020
#> 36         NA 2020
#> 37         NA 2020
#> 38         NA 2020
#> 39         NA 2020
#> 40         NA 2020
#> 41         10 2020
#> 42         NA 2020
#> 43         NA 2020
#> 44         NA 2020
#> 45         NA 2020
#> 46         NA 2020
#> 47         NA 2020
#> 48         NA 2020
#> 49         NA 2020
#> 50         NA 2020
#> 51         NA 2020
#> 52         NA 2020
#> 53         NA 2020
#> 54         NA 2020
#> 55         16 2020
#> 56         NA 2020
#> 57         NA 2020
#> 58         NA 2020
#> 59          1 2020
#> 60         NA 2020
#> 61         16 2020
#> 62         NA 2020
#> 63         NA 2020
#> 64         NA 2020
#> 65         NA 2020
#> 66         NA 2020
#> 67         NA 2020
#> 68         13 2020
#> 69         NA 2020
#> 70         NA 2020
#> 71         NA 2020
#> 72          8 2020
#> 73         NA 2020
#> 74         NA 2020
#> 75         NA 2020
#> 76         NA 2020
#> 77         NA 2020
#> 78         NA 2020
#> 79         NA 2020
#> 80         NA 2020
#> 81         NA 2020
#> 82         NA 2020
#> 83         NA 2020
#> 84         NA 2020
#> 85         NA 2020
#> 86         NA 2020
#> 87         NA 2020
#> 88         NA 2020
#> 89         NA 2020
#> 90         11 2020
#> 91         NA 2020
#> 92         NA 2020
#> 93         NA 2020
#> 94         NA 2020
#> 95         NA 2020
#> 96          5 2020
#> 97         NA 2020
#> 98         NA 2020
#> 99         NA 2020
#> 100        NA 2020
#> 101        NA 2020
#> 102        NA 2020
#> 103        NA 2020
#> 104        16 2020
#> 105        NA 2020
#> 106        NA 2020
#> 107        NA 2020
#> 108        NA 2020
#> 109        NA 2020
#> 110         1 2020
#> 111        NA 2020
#> 112        NA 2020
#> 113        NA 2020
#> 114        NA 2020
#> 115         2 2020
#> 116        NA 2020
#> 117        NA 2020
#> 118        NA 2020
#> 119        NA 2020
#> 120        NA 2020
#> 121         8 2020
#> 122        NA 2020
#> 123        NA 2020
#> 124        NA 2020
#> 125        NA 2020
#> 126        NA 2020
#> 127        NA 2020
#> 128         5 2020
#> 129        NA 2020
#> 130        NA 2020
#> 131        NA 2020
#> 132        NA 2020
#> 133        NA 2020
#> 134        NA 2020
#> 135        NA 2020
#> 136        NA 2020
#> 137        NA 2020
#> 138        NA 2020
#> 139        NA 2020
#> 140        NA 2020
#> 141        NA 2020
#> 142        NA 2020
#> 143        NA 2020
#> 144        NA 2020
#> 145        NA 2020
#> 146        NA 2020
#> 147        NA 2020
#> 148        NA 2020
#> 149        NA 2020
#> 150         2 2020
#> 151        NA 2020
#> 152        NA 2020
#> 153        NA 2020
#> 154        NA 2020
#> 155        NA 2020
#> 156        NA 2020
#> 157        NA 2020
#> 158        NA 2020
#> 159        NA 2020
#> 160         3 2020
#> 161         5 2020
#> 162        11 2020
#> 163         3 2020
#> 164         8 2020
#> 165        NA 2020
#> 166        NA 2020
#> 167        NA 2020
#> 168        13 2020
#> 169         1 2020
#> 170        NA 2020
#> 171        NA 2020
#> 172        NA 2020
#> 173        NA 2020
#> 174        13 2020
#> 175        NA 2020
#> 176        16 2020
#> 177        NA 2020
#> 178        10 2020
#> 179        NA 2020
#> 180         7 2020
#> 181        NA 2020
#> 182        NA 2020
#> 183        16 2020
#> 184        NA 2020
#> 185        NA 2020
#> 186        NA 2020
#> 187        NA 2020
#> 188        NA 2020
#> 189        NA 2020
#> 190         4 2020
#> 191        NA 2020
#> 192        NA 2020
#> 193        NA 2020
#> 194        NA 2020
#> 195        NA 2020
#> 196        NA 2020
#> 197        NA 2020
#> 198        NA 2020
#> 199         1 2020
#> 200        NA 2020
#> 201         6 2020
#> 202        NA 2020
#> 203        NA 2020
#> 204        NA 2020
#> 205        NA 2020
#> 206        NA 2020
#> 207        NA 2020
#> 208        NA 2020
#> 209        NA 2020
#> 210        NA 2020
#> 211        NA 2020
#> 212        NA 2020
#> 213        NA 2020
#> 214        14 2020
#> 215        NA 2020
#> 216         4 2020
#> 217        NA 2020
#> 218        NA 2020
#> 219        NA 2020
#> 220        NA 2020
#> 221        NA 2020
#> 222        NA 2020
#> 223        NA 2020
#> 224        NA 2020
#> 225        14 2020
#> 226        NA 2020
#> 227        NA 2020
#> 228        NA 2020
#> 229        NA 2020
#> 230        NA 2020
#> 231        NA 2020
#> 232        NA 2020
#> 233        NA 2020
#> 234        NA 2020
#> 235        NA 2020
#> 236        NA 2020
#> 237        11 2020
#> 238        NA 2020
#> 239         5 2020
#> 240        NA 2020
#> 241        NA 2020
#> 242        NA 2020
#> 243        NA 2020
#> 244        NA 2020
#> 245        NA 2020
#> 246        12 2020
#> 247        NA 2020
#> 248        NA 2020
#> 249        NA 2020
#> 250        NA 2020
#> 251        10 2020
#> 252        NA 2020
#> 253        NA 2020
#> 254        NA 2020
#> 255        NA 2020
#> 256         4 2020
#> 257        11 2020
#> 258        12 2020
#> 259        NA 2020
#> 260        NA 2020
#> 261        NA 2020
#> 262        NA 2020
#> 263        NA 2020
#> 264        NA 2020
#> 265        NA 2020
#> 266         9 2020
#> 267        NA 2020
#> 268        NA 2020
#> 269         3 2020
#> 270        NA 2020
#> 271        NA 2020
#> 272        NA 2020
#> 273        NA 2020
#> 274        NA 2020
#> 275        NA 2020
#> 276        NA 2020
#> 277        NA 2020
#> 278        NA 2020
#> 279        NA 2020
#> 280         4 2020
#> 281        NA 2020
#> 282        12 2020
#> 283        16 2020
#> 284        NA 2020
#> 285        NA 2020
#> 286        NA 2020
#> 287         2 2020
#> 288        10 2020
#> 289         9 2020
#> 290        NA 2020
#> 291        NA 2020
#> 292         6 2020
#> 293        NA 2020
#> 294        NA 2020
#> 295        NA 2020
#> 296        NA 2020
#> 297        NA 2020
#> 298        NA 2020
#> 299        NA 2020
#> 300         6 2020
#> 301        NA 2020
#> 302        NA 2020
#> 303        NA 2020
#> 304        NA 2020
#> 305        NA 2020
#> 306        NA 2020
#> 307        NA 2020
#> 308        NA 2020
#> 309        NA 2020
#> 310        NA 2020
#> 311        NA 2020
#> 312        NA 2020
#> 313        NA 2020
#> 314        14 2020
#> 315         9 2020
#> 316        NA 2020
#> 317        NA 2020
#> 318        12 2020
#> 319         8 2020
#> 320        NA 2020
#> 321        NA 2020
#> 322        NA 2020
#> 323        NA 2020
#> 324        NA 2020
#> 325        NA 2020
#> 326        NA 2020
#> 327         7 2020
#> 328        NA 2020
#> 329         7 2020
#> 330        NA 2020
#> 331         7 2020
#> 332        NA 2020
#> 333        NA 2020
#> 334        NA 2020
#> 335        13 2020
#> 336         9 2020
#> 337        15 2020
#> 338        11 2020
#> 339         6 2020
#> 340        NA 2020
#> 341         2 2020
#> 342        14 2020
#> 343        NA 2020
#> 344        NA 2020
#> 345        NA 2020
#> 346        NA 2020
#> 347        NA 2020
#> 348        NA 2020
#> 349        NA 2020
#> 350        11 2020
#> 351        NA 2020
#> 352         3 2020
#> 353        NA 2020
# }
# \donttest{
try(kp_teamstats(min_year = 2019, max_year = 2021))
#> ✖ 2026-10-26 19:19:20.301574: Invalid arguments or no team stats data for 2019 - 2021 available!
#> ✖ Args: min_year = 2019, max_year = 2021
#> ✖ Error: subscript out of bounds
#> NULL
# }
# \donttest{
try(kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2021))
#>     rk                 player                   team e_fg  hgt wgt yr year
#> 1    1             Aher Uguak         Loyola Chicago 69.8  6-7 225 Sr 2021
#> 2    1         Osinachi Smart             Charleston 66.7  6-8 240 Sr 2021
#> 3    1        Ahsan Asadullah               Lipscomb 62.6  6-8 260 Jr 2021
#> 4    1      Asbjorn Midtgaard           Grand Canyon 69.7  7-0 270 Sr 2021
#> 5    1         Darien Jackson                  Tulsa 63.0  6-3 203 Sr 2021
#> 6    1       David Kachelries      Stephen F. Austin 64.0  6-1 170 Sr 2021
#> 7    1          Dwight Wilson                   Ohio 74.6  6-8 250 Sr 2021
#> 8    1        Jeremiah Tilmon               Missouri 63.1 6-10 260 Sr 2021
#> 9    1        Matt Dentlinger       South Dakota St. 68.3  6-8 240 Jr 2021
#> 10   1          Mitch Ballock              Creighton 65.8  6-5 205 Sr 2021
#> 11   1             Nick Finke                   Army 63.4  6-7 223 Sr 2021
#> 12   1          Flynn Cameron           UC Riverside 64.2  6-5 210 Jr 2021
#> 13   1         Nate Laszewski             Notre Dame 67.0 6-10 227 Jr 2021
#> 14   1           Jared Butler                 Baylor 62.7  6-3 195 Jr 2021
#> 15   1           Kyle Cardaci             Coppin St. 65.3  6-2 190 So 2021
#> 16   1          Adrian Nelson      Northern Kentucky 72.0  6-7 220 Jr 2021
#> 17   1            DJ Mitchell               Hartford 64.8  6-0 160 Jr 2021
#> 18   1         Jayden Saddler               Southern 67.9  6-1 195 Jr 2021
#> 19   1         Jamison Battle      George Washington 61.5  6-7 225 So 2021
#> 20   1          Kofi Cockburn               Illinois 66.4  7-0 285 So 2021
#> 21   1           Jubrile Belo            Montana St. 66.0  6-9 240 Jr 2021
#> 22   1            Isiah Small              Texas St. 66.9  6-8 170 Sr 2021
#> 23   1           Seth Pinkney             Quinnipiac 79.2  7-1 200 So 2021
#> 24   1            Max Fiedler                   Rice 73.8 6-11 235 So 2021
#> 25   1         Michael Moreno       Eastern Kentucky 69.3  6-7 220 So 2021
#> 26   1           Chris Duarte                 Oregon 63.5  6-6 190 Sr 2021
#> 27   1          Chris Shelton                Hampton 70.9  6-4 190 So 2021
#> 28   1           Caleb Lohner                    BYU 70.2  6-8 230 Fr 2021
#> 29   1           Jaron Rillie                Samford 76.5  6-3 175 Fr 2021
#> 30   1          Xavier DuSell                Wyoming 65.9  6-4 190 Fr 2021
#> 31   1          Mike Sixsmith           Sacred Heart 77.1  6-0 170 Fr 2021
#> 32   2          Brendan Barry                 Temple 59.9  6-2 180 Sr 2021
#> 33   2       Damien Jefferson              Creighton 61.2  6-5 220 Sr 2021
#> 34   2             Gorjok Gak            Cal Baptist 59.6 6-11 235 Sr 2021
#> 35   2           Jeriah Horne               Colorado 62.0  6-7 220 Sr 2021
#> 36   2          Romello White            Mississippi 62.4  6-8 235 Sr 2021
#> 37   2      Spencer Littleson                 Toledo 71.7  6-4 200 Sr 2021
#> 38   2            Alex Hunter                 Furman 63.3 5-11 180 Sr 2021
#> 39   2           Ayo Akinwole         Nebraska Omaha 63.1  6-0 165 Sr 2021
#> 40   2      Da'Monte Williams               Illinois 65.6  6-3 215 Sr 2021
#> 41   2        Davion Mitchell                 Baylor 60.9  6-2 205 Jr 2021
#> 42   2            Gabe Hadley           UC San Diego 66.2  6-4 200 Sr 2021
#> 43   2          Gavin Kensmil      Stephen F. Austin 63.5  6-7 260 Sr 2021
#> 44   2         Grayson Murphy                Belmont 65.2  6-2 175 Jr 2021
#> 45   2           Jamir Harris               American 61.7  6-2 198 Sr 2021
#> 46   2         Jordan Schakel          San Diego St. 65.8  6-6 200 Sr 2021
#> 47   2          Lewis Djonkam                Radford 66.4  6-9 245 Jr 2021
#> 48   2          Tanner Groves     Eastern Washington 62.1  6-9 235 Jr 2021
#> 49   2        Zachary Simmons            North Texas 69.2 6-10 239 Sr 2021
#> 50   2         Jackson Stormo                  Siena 64.8  6-9 247 Jr 2021
#> 51   2            Theo Akwuba              Louisiana 61.6 6-11 225 Jr 2021
#> 52   2           Grant Basile             Wright St. 65.1  6-9 225 So 2021
#> 53   2            Zach Walton                 Drexel 64.5  6-6 205 Sr 2021
#> 54   2        Jayden Martinez          New Hampshire 58.9  6-7 215 Jr 2021
#> 55   2           Matthew Hurt                   Duke 66.0  6-9 235 So 2021
#> 56   2           Hyunjung Lee               Davidson 60.9  6-7 210 So 2021
#> 57   2             Drew Timme                Gonzaga 69.5 6-10 235 So 2021
#> 58   2           Cyrus Largie     Florida Gulf Coast 61.8  6-3 204 So 2021
#> 59   2         Justin Webster                 Hawaii 61.5  6-3 180 So 2021
#> 60   2         Jawaun Daniels       Prairie View A&M 66.2  6-7 190 Jr 2021
#> 61   2           Hall Elisias                 Bryant 63.6  6-8 230 Sr 2021
#> 62   2        Lagio Grantsaan             Morgan St. 59.9  6-8 235 Sr 2021
#> 63   3         Bobby Planutis      Purdue Fort Wayne 64.0  6-8 200 Jr 2021
#> 64   3          Corey Kispert                Gonzaga 62.3  6-7 220 Sr 2021
#> 65   3             John Petty                Alabama 61.7  6-5 184 Sr 2021
#> 66   3          Keaton Hervey           Missouri St. 61.5  6-7 200 Jr 2021
#> 67   3           Kevin Samuel                    TCU 59.6 6-11 255 Jr 2021
#> 68   3              Matt Pile         Nebraska Omaha 60.8  6-8 240 Sr 2021
#> 69   3          Myles Johnson                Rutgers 64.3 6-11 255 Jr 2021
#> 70   3            Nate Watson             Providence 59.5 6-10 260 Sr 2021
#> 71   3         Nelly Cummings                Colgate 59.5  6-0 180 Jr 2021
#> 72   3            Prince Moss          Grambling St. 61.0  6-7 180 Sr 2021
#> 73   3           Tajion Jones          UNC Asheville 61.8  6-5 190 Jr 2021
#> 74   3            Manny Bates             N.C. State 64.9 6-11 230 So 2021
#> 75   3            Jose Placer          North Florida 61.0  6-1 174 So 2021
#> 76   3       Adam Thistlewood           Colorado St. 65.0  6-6 212 Jr 2021
#> 77   3            Andre Kelly             California 60.8  6-8 255 Jr 2021
#> 78   3            KJ Williams             Murray St. 60.5 6-10 245 Jr 2021
#> 79   3          Jalen Slawson                 Furman 62.6  6-7 218 Jr 2021
#> 80   3          Andrew Taylor               Marshall 67.6  6-3 188 So 2021
#> 81   3           Darius Brown     Cal St. Northridge 61.2  6-2 195 Jr 2021
#> 82   3        Lester Quinones                Memphis 58.7  6-5 205 So 2021
#> 83   3            Elijah Ford                 Wagner 61.5  6-5 205 Sr 2021
#> 84   3           Kvonn Cramer                Hofstra 63.5  6-6 205 Fr 2021
#> 85   3           Jalen Thomas            Georgia St. 59.3 6-10 235 So 2021
#> 86   3   Seikou Sisoho Jawara              Weber St. 61.1  6-3 195 So 2021
#> 87   3         Miroslav Stafl               Hartford 57.7 6-10 235 So 2021
#> 88   3          Rodney Carson            New Orleans 62.6  6-3 180 So 2021
#> 89   3    Nelly Junior Joseph                   Iona 62.9  6-9 230 Fr 2021
#> 90   3             JT Shumate                 Toledo 68.8  6-7 210 Jr 2021
#> 91   3           Nendah Tarke             Coppin St. 57.1  6-4 190 Fr 2021
#> 92   3         Montre' Gipson           Tarleton St. 58.5 5-11 200 Jr 2021
#> 93   3         Mustapha Amzil                 Dayton 59.0 6-10 220 Fr 2021
#> 94   4          Anthony Tarke             Coppin St. 56.9  6-6 220 Sr 2021
#> 95   4          Elijah Thomas            Cal Baptist 57.4  6-5 220 Sr 2021
#> 96   4            Isaiah Ross                   Iona 59.6  6-3 200 Sr 2021
#> 97   4            Isiah Brown              Weber St. 59.1  6-2 185 Sr 2021
#> 98   4               Jay Huff               Virginia 64.1  7-1 240 Sr 2021
#> 99   4          Ross Cummings                 Mercer 62.4  6-3 180 Sr 2021
#> 100  4         Carter Collins               Davidson 58.8  6-3 190 Sr 2021
#> 101  4        Elyjah Williams    Fairleigh Dickinson 59.8  6-7 220 Sr 2021
#> 102  4           Evan Kuhlman             Evansville 61.0  6-8 220 Sr 2021
#> 103  4            James Lewis        Appalachian St. 58.3  6-8 215 Jr 2021
#> 104  4           Jason Strong           Northeastern 62.4  6-8 210 Jr 2021
#> 105  4             Joel Ayayi                Gonzaga 62.0  6-5 180 Jr 2021
#> 106  4        Justin Mazzulla                Vermont 57.4  6-3 195 Sr 2021
#> 107  4             Sean Price    Charleston Southern 60.5  6-4 210 Jr 2021
#> 108  4              Alex King                   Army 59.4  6-8 200 Sr 2021
#> 109  4             Feron Hunt                    SMU 57.8  6-8 195 Jr 2021
#> 110  4            Darius Days                    LSU 61.3  6-7 245 Jr 2021
#> 111  4          Kyler Edwards             Texas Tech 58.1  6-4 195 Jr 2021
#> 112  4           Joe Wieskamp                   Iowa 62.1  6-6 212 Jr 2021
#> 113  4          Spencer Jones               Stanford 59.5  6-7 225 So 2021
#> 114  4            Thomas Bell            North Texas 65.8  6-6 190 Sr 2021
#> 115  4           Ben Roderick                   Ohio 60.8  6-5 205 So 2021
#> 116  4       Terrell Williams               Southern 58.2  6-5 200 Fr 2021
#> 117  4            David Roddy           Colorado St. 59.6  6-5 252 So 2021
#> 118  4              Max Abmas           Oral Roberts 60.7  6-1 165 So 2021
#> 119  4           Ben Sheppard                Belmont 60.1  6-6 185 So 2021
#> 120  4            Qudus Wahab             Georgetown 57.5 6-11 237 So 2021
#> 121  4         Carlos Rosario            McNeese St. 62.4  6-8 220 Sr 2021
#> 122  4          Micah Parrish                Oakland 63.1  6-6 188 Fr 2021
#> 123  4            Jadon Jones         Long Beach St. 61.2  6-5 170 Fr 2021
#> 124  5               DJ Jones            Florida A&M 54.8  6-9 200 Sr 2021
#> 125  5          Justin Gorham                Houston 57.1  6-7 225 Sr 2021
#> 126  5             Mark Crowe               Cal Poly 59.3  6-5 205 Sr 2021
#> 127  5             Mark Vital                 Baylor 57.4  6-5 250 Sr 2021
#> 128  5           Michael Henn               Portland 61.7  6-8 225 Sr 2021
#> 129  5             Peter Kiss                 Bryant 58.8  6-5 200 Jr 2021
#> 130  5             Sam Hauser               Virginia 64.1  6-8 218 Sr 2021
#> 131  5       Alessandro Lever           Grand Canyon 57.1 6-10 235 Sr 2021
#> 132  5       Brandon McKissic                   UMKC 60.2  6-3 195 Sr 2021
#> 133  5           Donald Carey             Georgetown 57.0  6-5 187 Sr 2021
#> 134  5              Dre Marin          Southern Utah 58.9  6-0 175 Sr 2021
#> 135  5          Jalon Pipkins      Purdue Fort Wayne 61.7  6-4 195 Sr 2021
#> 136  5             Kyle Young               Ohio St. 60.9  6-8 225 Sr 2021
#> 137  5          Maxwell Evans             Vanderbilt 59.8  6-2 190 Sr 2021
#> 138  5           Tervell Beck               Kent St. 60.5  6-7 230 Sr 2021
#> 139  5         Dominick Welch        St. Bonaventure 57.7  6-5 200 Jr 2021
#> 140  5        Elijah McCadden       Georgia Southern 57.8  6-4 210 Jr 2021
#> 141  5      Berrick JeanLouis                   Iona 58.0  6-4 195 Jr 2021
#> 142  5         Charles Bassey       Western Kentucky 64.9 6-11 235 Jr 2021
#> 143  5             Nevin Zink            USC Upstate 60.0  6-9 230 Jr 2021
#> 144  5          Neemias Queta               Utah St. 58.4  7-0 245 Jr 2021
#> 145  5             Gaige Prim           Missouri St. 60.7  6-8 235 Sr 2021
#> 146  5           Chico Carter             Murray St. 59.8  6-2 190 So 2021
#> 147  5          Isaiah Powell                Vermont 56.8  6-6 220 Jr 2021
#> 148  5       Demarkus Lampley        Sam Houston St. 60.0  6-2 170 Sr 2021
#> 149  5            Xander Rice               Bucknell 58.8  6-3 184 So 2021
#> 150  5           Justin Amadi          James Madison 61.0  6-7 220 Fr 2021
#> 151  5            Trey Bonham                    VMI 60.9  6-0 170 Fr 2021
#> 152  5          Alex Peterson           Kennesaw St. 59.0  6-7 217 Jr 2021
#> 153  5     Bennedict Mathurin                Arizona 57.8  6-7 195 Fr 2021
#> 154  5           Samkelo Cele               Southern 54.8  6-5 210 Jr 2021
#> 155  6         Ethan Claycomb             Bellarmine 56.8  6-7 205 Sr 2021
#> 156  6        Jordan Bohannon                   Iowa 59.9  6-1 175 Sr 2021
#> 157  6           MaCio Teague                 Baylor 56.6  6-4 195 Sr 2021
#> 158  6        Shandon Goldman         Tennessee Tech 58.9 6-10 225 Sr 2021
#> 159  6           Travis Atson         St. Francis NY 58.8  6-5 200 Sr 2021
#> 160  6          Bryan Trimble                  Akron 59.7  6-2 185 Jr 2021
#> 161  6          Bryce Moragne            Florida A&M 52.8  6-5 220 Sr 2021
#> 162  6    Cheikh Mbacke Diong                   UNLV 58.3 6-11 235 Sr 2021
#> 163  6          Josh Nicholas       Louisiana Monroe 57.6  6-3 190 Sr 2021
#> 164  6              Kim Aiken     Eastern Washington 58.7  6-7 215 Jr 2021
#> 165  6              LJ Thorpe          UNC Asheville 59.3  6-5 215 Jr 2021
#> 166  6            Taylor Funk         Saint Joseph's 57.5  6-8 215 Jr 2021
#> 167  6              Theo John              Marquette 56.5  6-9 245 Sr 2021
#> 168  6              Trey Wade            Wichita St. 54.7  6-6 221 Sr 2021
#> 169  6           George Papas               Monmouth 57.9  6-5 175 Sr 2021
#> 170  6        Colin Castleton                Florida 58.1 6-11 231 Jr 2021
#> 171  6        Michael Forrest       Florida Atlantic 61.4  6-0 175 Jr 2021
#> 172  6            Trey Murphy               Virginia 62.5  6-9 206 Jr 2021
#> 173  6       Guglielmo Caruso            Santa Clara 58.2 6-11 210 Jr 2021
#> 174  6             Amadou Sow       UC Santa Barbara 58.6  6-9 235 Jr 2021
#> 175  6         Josh Alexander               American 57.8  6-8 243 Jr 2021
#> 176  6      Jayveous McKinnis            Jackson St. 54.0  6-7 220 Jr 2021
#> 177  6           Ebby Asamoah               Delaware 60.9  6-4 200 So 2021
#> 178  6          Keith Clemons         Loyola Chicago 60.7  6-1 180 Sr 2021
#> 179  6            Dan Petcash             Binghamton 56.2  6-4 190 So 2021
#> 180  6        Trenton Massner       Northwestern St. 59.4  6-2 170 Jr 2021
#> 181  6         Daniel Oladapo                Oakland 61.5  6-7 222 Jr 2021
#> 182  6            Xavier Cork       Western Carolina 60.1  6-9 235 So 2021
#> 183  6          Pelle Larsson                   Utah 57.4  6-5 215 Fr 2021
#> 184  6          Xavier Fuller           South Dakota 59.5  6-4 170 Jr 2021
#> 185  6           Emeka Udenyi                Seattle 55.6  6-6 225 Jr 2021
#> 186  7        Carson Williams       Western Kentucky 60.0  6-5 240 Sr 2021
#> 187  7           Grant Golden               Richmond 57.1 6-10 255 Sr 2021
#> 188  7           James Butler                 Drexel 60.5  6-8 242 Sr 2021
#> 189  7               Ty Groce       Eastern Michigan 57.6  6-8 215 Sr 2021
#> 190  7          Austin Butler             Holy Cross 56.6  6-5 212 Sr 2021
#> 191  7       Cameron Christon          Grambling St. 53.4  6-6 190 Jr 2021
#> 192  7       Greg Kuakumensah                Niagara 56.6  6-6 200 Sr 2021
#> 193  7           Joe Quintana       Loyola Marymount 57.5  6-2 170 Jr 2021
#> 194  7          Jose Alvarado           Georgia Tech 61.0  6-0 179 Sr 2021
#> 195  7              Nik Mains       Northern Arizona 58.6  6-9 205 Jr 2021
#> 196  7         Oscar da Silva               Stanford 57.1  6-9 230 Sr 2021
#> 197  7              Eral Penn                    LIU 58.4  6-7 210 Jr 2021
#> 198  7      Marcus Zegarowski              Creighton 56.1  6-2 180 Jr 2021
#> 199  7            Tray Maddox      Cal St. Fullerton 57.2  6-6 200 Jr 2021
#> 200  7               LJ Owens                   UMBC 56.2  6-3 165 Jr 2021
#> 201  7       Sherwyn Devonish             Morgan St. 52.6  6-1 192 Jr 2021
#> 202  7               Bul Kuol                Detroit 61.1  6-7 205 Sr 2021
#> 203  7            Sean McNeil          West Virginia 56.3  6-3 210 Jr 2021
#> 204  7       Messiah Thompson               Campbell 59.0  5-8 165 So 2021
#> 205  7          Caleb Asberry              Texas St. 57.3  6-3 170 Jr 2021
#> 206  7          Stephen Clark            The Citadel 58.7  6-8 200 So 2021
#> 207  7             Ralph Agee           San Jose St. 58.2  6-8 235 Sr 2021
#> 208  7           Franz Wagner               Michigan 57.7  6-9 220 So 2021
#> 209  7          Josiah Allick                   UMKC 59.4  6-8 225 So 2021
#> 210  7           Reed Nottage            Cal Baptist 55.2  6-6 215 So 2021
#> 211  7        Jaylin Williams                 Auburn 57.1  6-8 230 So 2021
#> 212  7             Rienk Mast                Bradley 60.1  6-9 240 Fr 2021
#> 213  7              Eric Reed Southeast Missouri St. 58.7  6-2 190 Jr 2021
#> 214  7           Donte Powers        Sam Houston St. 59.3  6-2 180 Jr 2021
#> 215  7             Sion James                 Tulane 54.4  6-5 205 Fr 2021
#> 216  7             CJ Fleming             Bellarmine 55.0  6-0 180 Sr 2021
#> 217  8         Johnny McCants         New Mexico St. 55.2  6-7 235 Sr 2021
#> 218  8            Marcus Burk                  IUPUI 57.9  6-3 195 Sr 2021
#> 219  8            Alex Arians       South Dakota St. 58.5  6-4 210 Jr 2021
#> 220  8         Casdon Jardine                 Hawaii 56.1  6-7 215 Sr 2021
#> 221  8        De'Vondre Perry                 Temple 53.5  6-7 220 Sr 2021
#> 222  8             Jamal Cain              Marquette 55.4  6-7 200 Sr 2021
#> 223  8            James Baker           Morehead St. 58.4  6-6 205 Sr 2021
#> 224  8        Jhivvan Jackson                   UTSA 58.4  6-0 170 Sr 2021
#> 225  8       Ledarrius Brewer     East Tennessee St. 57.9  6-5 190 Jr 2021
#> 226  8           Matt Johnson      Northern Colorado 58.5  6-2 180 Jr 2021
#> 227  8               PJ Horne                Georgia 57.1  6-6 230 Sr 2021
#> 228  8           Trevor Moore             Morgan St. 52.4  6-5 195 Jr 2021
#> 229  8        Sukhmail Mathon      Boston University 55.7 6-10 225 Sr 2021
#> 230  8           Umoja Gibson               Oklahoma 55.7  6-1 176 Jr 2021
#> 231  8        Warren Williams              Manhattan 56.0  6-9 240 Jr 2021
#> 232  8        Antonio Rizzuto                 Albany 53.6  6-3 195 Jr 2021
#> 233  8         Luka Brajkovic               Davidson 56.7 6-10 250 Jr 2021
#> 234  8          Dravon Mangum                Radford 58.7  6-8 200 So 2021
#> 235  8          Nolan Bertain Texas A&M Corpus Chris 58.8  6-4 185 Sr 2021
#> 236  8           Ivan Alipiev       Loyola Marymount 57.2  6-8 215 Jr 2021
#> 237  8         Tremell Murphy                  Drake 59.6  6-6 210 Sr 2021
#> 238  8              AJ Walker              Air Force 57.5  6-2 191 Jr 2021
#> 239  8         TJ Bickerstaff                 Drexel 60.0  6-9 207 So 2021
#> 240  8           Brandon Rush    Fairleigh Dickinson 58.1  6-3 175 So 2021
#> 241  8        Donovan Gregory        Appalachian St. 55.4  6-5 190 So 2021
#> 242  8          Jalen Johnson            Alabama A&M 53.3  6-7 230 So 2021
#> 243  8      Giovanni Santiago               Kent St. 57.5  6-1 155 So 2021
#> 244  8         Hunter Cattoor          Virginia Tech 60.4  6-3 200 So 2021
#> 245  8            Evan Mobley                    USC 57.0  7-0 215 Fr 2021
#> 246  8       Hunter Dickinson               Michigan 56.9  7-1 255 Fr 2021
#> 247  9           Austin Phyfe          Northern Iowa 59.5  6-9 250 Jr 2021
#> 248  9           Brock Miller               Utah St. 56.2  6-5 200 Jr 2021
#> 249  9         Cedric Russell              Louisiana 55.4  6-2 190 Sr 2021
#> 250  9            Jabari Rice         New Mexico St. 53.7  6-4 180 Jr 2021
#> 251  9           Jalen Adaway        St. Bonaventure 56.4  6-5 210 Jr 2021
#> 252  9       Jermaine Samuels              Villanova 55.3  6-7 230 Sr 2021
#> 253  9           Matt Coleman                  Texas 55.4  6-2 180 Sr 2021
#> 254  9           Pedro Castro        Houston Baptist 58.3  6-6 185 Jr 2021
#> 255  9             Stef Smith                Vermont 53.4  6-2 190 Sr 2021
#> 256  9        Tydus Verhoeven                   UTEP 57.7  6-9 225 Jr 2021
#> 257  9             Tyree Eady       North Dakota St. 58.3  6-5 210 Jr 2021
#> 258  9           Melik Martin               Monmouth 53.8  6-6 200 Sr 2021
#> 259  9        Andrew Nembhard                Gonzaga 56.9  6-5 193 Jr 2021
#> 260  9            LJ Figueroa                 Oregon 56.5  6-6 200 Sr 2021
#> 261  9           Miles Norris       UC Santa Barbara 56.0 6-10 220 Jr 2021
#> 262  9             Myja White               Miami OH 56.9  6-1 185 So 2021
#> 263  9      Maurice Commander       Illinois Chicago 57.8  6-0 175 Jr 2021
#> 264  9          Ricky Clemons               Campbell 58.3  6-2 205 Jr 2021
#> 265  9            Ryan Larson                Wofford 57.7  6-1 175 Jr 2021
#> 266  9        Malik Jefferson       Mount St. Mary's 56.0  6-9 230 Jr 2021
#> 267  9         Cameron Parker                Montana 56.3  6-2 170 Jr 2021
#> 268  9      Jeremiah Gambrell       Prairie View A&M 52.5  6-3 180 So 2021
#> 269  9             Tolu Smith        Mississippi St. 56.8 6-10 245 So 2021
#> 270  9        Jae'Lyn Withers             Louisville 58.2  6-8 230 Fr 2021
#> 271  9          Quirin Emanga           Northeastern 59.5  6-5 220 So 2021
#> 272  9         Chase Johnston                Stetson 54.5  6-2 185 Fr 2021
#> 273  9           Santi Aldama              Loyola MD 55.7 6-11 215 So 2021
#> 274  9            Donta Scott               Maryland 56.4  6-7 230 So 2021
#> 275  9        Rahsaan Edwards     South Carolina St. 52.3  6-0 200 So 2021
#> 276  9     Jeremiah Davenport             Cincinnati 53.2  6-7 205 So 2021
#> 277  9           Johni Broome           Morehead St. 58.0 6-10 235 Fr 2021
#> 278  9         Jace Roquemore           UC San Diego 60.0  6-5 160 Fr 2021
#> 279 10             Jalen Tate               Arkansas 56.7  6-6 175 Sr 2021
#> 280 10         Justin Hopkins         Texas Southern 52.2  6-5 205 Sr 2021
#> 281 10             Tahj Eaddy                    USC 55.7  6-2 165 Sr 2021
#> 282 10            Aamir Simms                Clemson 57.8  6-8 245 Sr 2021
#> 283 10       Collin Gillespie              Villanova 54.9  6-3 190 Sr 2021
#> 284 10         Darnell Brodie                  Drake 59.3 6-10 275 Jr 2021
#> 285 10      Garrett Covington         Youngstown St. 57.8  6-5 200 Sr 2021
#> 286 10           Jacob Rigoni             Quinnipiac 53.6  6-6 190 Sr 2021
#> 287 10        Jaheam Cornwall           Gardner Webb 58.1  6-0 175 Sr 2021
#> 288 10            James Reese            North Texas 57.6  6-4 167 Sr 2021
#> 289 10           Javon Greene           George Mason 56.4  6-2 190 Sr 2021
#> 290 10        David McCormack                 Kansas 53.9 6-10 250 Jr 2021
#> 291 10          RJ Eytle-Rock                   UMBC 52.5  6-3 225 Jr 2021
#> 292 10             Pete Nance           Northwestern 56.1 6-10 225 Jr 2021
#> 293 10           Kendle Moore           Colorado St. 56.2 5-10 151 Jr 2021
#> 294 10          Finn Sullivan              San Diego 56.9  6-4 175 Jr 2021
#> 295 10       DeAndre Williams                Memphis 53.0  6-9 190 Jr 2021
#> 296 10         Pedro Bradshaw             Bellarmine 53.9  6-7 185 Jr 2021
#> 297 10       Derek St Hilaire            New Orleans 58.1  6-0 180 Sr 2021
#> 298 10         Maizen Fausett          Southern Utah 56.1  6-6 225 Jr 2021
#> 299 10           Kevin Obanor           Oral Roberts 58.2  6-8 225 Jr 2021
#> 300 10           Walter Ellis               Bucknell 55.1  6-5 190 Jr 2021
#> 301 10          B Artis White       Western Michigan 56.8  6-0 150 So 2021
#> 302 10          Charles Pride                 Bryant 55.4  6-4 185 So 2021
#> 303 10          Ruot Monyyong            Little Rock 55.2 6-10 215 Sr 2021
#> 304 10         Kamdyn Curfman                    VMI 56.6  6-1 186 So 2021
#> 305 10         Jaron Williams       Tennessee Martin 57.6  6-6 210 Jr 2021
#> 306 10         Darius Burford                   Elon 58.6  6-0 160 Fr 2021
#> 307 10       Alex Merkviladze     Cal St. Northridge 54.7  6-9 225 Fr 2021
#> 308 10       Hunter Schofield              Dixie St. 53.3  6-8 225 Sr 2021
#> 309 10            Jalen Speer            Florida A&M 52.3  6-1 172 Fr 2021
#> 310 11         Derrick Alston              Boise St. 56.0  6-9 190 Sr 2021
#> 311 11             Ibi Watson                 Dayton 56.1  6-5 195 Sr 2021
#> 312 11     JaQuori McLaughlin       UC Santa Barbara 52.8  6-4 190 Sr 2021
#> 313 11       Michael Weathers         Texas Southern 51.8  6-3 175 Sr 2021
#> 314 11        Cameron Krutwig         Loyola Chicago 57.6  6-9 255 Sr 2021
#> 315 11          Dalonte Brown               Miami OH 56.2  6-7 205 Sr 2021
#> 316 11              Evan Cole            Utah Valley 52.6 6-10 230 Sr 2021
#> 317 11              MJ Walker            Florida St. 56.7  6-5 213 Sr 2021
#> 318 11             Myles Cale             Seton Hall 54.8  6-6 210 Sr 2021
#> 319 11           Storm Murphy                Wofford 56.5  6-0 180 Sr 2021
#> 320 11            Tevin Brown             Murray St. 55.4  6-5 175 Jr 2021
#> 321 11       Jordan Whitfield               Campbell 57.8  6-1 175 Sr 2021
#> 322 11          Brandon Mahan                    UCF 53.0  6-5 205 Sr 2021
#> 323 11            Eli Parquet               Colorado 55.2  6-3 195 Jr 2021
#> 324 11            John Knight          Southern Utah 55.6  6-3 205 Sr 2021
#> 325 11          Bentiu Panoam           North Dakota 57.5  6-2 168 Sr 2021
#> 326 11         Jarred Godfrey      Purdue Fort Wayne 57.0  6-5 185 Jr 2021
#> 327 11      Tucker Richardson                Colgate 54.7  6-5 205 Jr 2021
#> 328 11          Dwight Murray                  Rider 52.5  6-0 180 Jr 2021
#> 329 11        Nick Guadarrama          New Hampshire 52.0  6-5 250 Jr 2021
#> 330 11           Malik Miller             Morgan St. 52.2  6-4 191 Jr 2021
#> 331 11         De'Vion Harmon               Oklahoma 53.7  6-2 198 So 2021
#> 332 11          Dru Kuxhausen            McNeese St. 57.1  6-0 180 Sr 2021
#> 333 11           Paul Mulcahy                Rutgers 56.1  6-6 210 So 2021
#> 334 11            Marko Lukic            Little Rock 54.9  6-7 195 So 2021
#> 335 11            Joe Pridgen         UNC Wilmington 58.3  6-5 210 So 2021
#> 336 11        Isaiah Crawford         Louisiana Tech 57.1  6-6 220 So 2021
#> 337 11       Pierre Crockrell                Pacific 55.6  6-0 175 So 2021
#> 338 11         Emanuel Miller              Texas A&M 55.0  6-7 208 So 2021
#> 339 11          Mykel Derring              Merrimack 55.1  6-2 180 So 2021
#> 340 11            Juston Betz             Bellarmine 53.8  6-3 190 Jr 2021
#> 341 12              Abdul Ado        Mississippi St. 54.0 6-11 255 Sr 2021
#> 342 12             Ben Coupet            Little Rock 54.7  6-7 185 Sr 2021
#> 343 12          DeJon Jarreau                Houston 52.9  6-5 185 Sr 2021
#> 344 12             Jock Perry           UC Riverside 52.6  7-1 250 Sr 2021
#> 345 12             Mike Smith               Michigan 55.4 5-11 185 Sr 2021
#> 346 12           Jon Williams          Robert Morris 57.0  6-1 185 Sr 2021
#> 347 12           Kellan Grady               Davidson 55.7  6-5 205 Sr 2021
#> 348 12      Shaquille Walters           Northeastern 58.2  6-6 200 Jr 2021
#> 349 12          Terrell Gomez          San Diego St. 55.2  5-8 165 Sr 2021
#> 350 12        Tristan Jarrett            Jackson St. 50.9  6-4 195 Sr 2021
#> 351 12           Ochai Agbaji                 Kansas 52.7  6-5 215 Jr 2021
#> 352 12          Jawaun Newton             Evansville 57.3  6-3 170 Jr 2021
#> 353 12         Uche Dibiamaka   UT Rio Grande Valley 51.6  6-4 195 Jr 2021
#> 354 12           Dalvin White            USC Upstate 56.8 5-10 170 Jr 2021
#> 355 12          Tyler Bertram             Binghamton 51.1  6-3 185 So 2021
#> 356 12          Kyonze Chavis            Norfolk St. 51.2  6-4 195 Sr 2021
#> 357 12          Al-Amir Dawes                Clemson 56.4  6-2 180 So 2021
#> 358 12          Gabe Quinnett                  Idaho 55.6  6-4 201 So 2021
#> 359 12              Ty Gordon           Nicholls St. 57.0  6-1 200 Sr 2021
#> 360 12        Alfonso Plummer                   Utah 55.0  6-1 182 Sr 2021
#> 361 12            Travis Evee                   Rice 55.8  6-1 180 So 2021
#> 362 12            Sean Conway                    VMI 56.2  6-5 215 So 2021
#> 363 12        Tasos Kamateros           South Dakota 57.0  6-8 240 So 2021
#> 364 12            Jordan King                  Siena 51.7  6-0 175 So 2021
#> 365 12          Keli Leaupepe       Loyola Marymount 54.4  6-6 248 So 2021
#> 366 12            Carlos Paez            Austin Peay 54.6 5-10 180 So 2021
#> 367 12          Mikey Watkins              Merrimack 53.3 5-11 175 Jr 2021
#> 368 12        Romeao Ferguson               Lipscomb 53.5  6-5 195 Sr 2021
#> 369 12          Dawson Garcia              Marquette 54.1 6-11 235 Fr 2021
#> 370 12           Kyle Jenkins              Lafayette 54.0  6-7 213 Fr 2021
#> 371 13    Jalen Coleman-Lands               Iowa St. 52.7  6-4 187 Sr 2021
#> 372 13             Ben Shungu                Vermont 51.0  6-2 200 Sr 2021
#> 373 13      Cainan McClelland            Jackson St. 50.6  6-4 180 Sr 2021
#> 374 13              Dru Smith               Missouri 53.1  6-3 203 Sr 2021
#> 375 13              Eli Scott       Loyola Marymount 54.1  6-6 232 Sr 2021
#> 376 13            Greg Parham                    VMI 56.1  6-4 176 Sr 2021
#> 377 13          Isaiah Livers               Michigan 54.9  6-7 230 Sr 2021
#> 378 13        Justin Jaworski              Lafayette 53.4  6-3 196 Sr 2021
#> 379 13           Mladen Armus              Boise St. 54.8 6-10 232 Jr 2021
#> 380 13               PJ Pipes              Green Bay 56.9  6-2 190 Sr 2021
#> 381 13              TJ Starks     Cal St. Northridge 52.3  6-2 196 Jr 2021
#> 382 13            Alex Watson           Sacred Heart 52.7  6-3 170 Sr 2021
#> 383 13      Payton Youngblood          North Alabama 53.5  6-5 200 Sr 2021
#> 384 13          Michael Devoe           Georgia Tech 56.2  6-5 197 Jr 2021
#> 385 13              Jamal Bey             Washington 54.9  6-6 210 Jr 2021
#> 386 13          Fardaws Aimaq            Utah Valley 50.8 6-11 245 So 2021
#> 387 13         Skyelar Potter           Morehead St. 54.6  6-3 198 Jr 2021
#> 388 13         Eddy Kayouloud       Central Arkansas 56.8  6-7 220 Jr 2021
#> 389 13         Landers Nolley                Memphis 52.6  6-7 220 So 2021
#> 390 13            Kobi Nwandu                Niagara 50.8  6-6 210 Sr 2021
#> 391 13        Luke Bumbalough               Ball St. 54.8  6-1 180 So 2021
#> 392 13               DJ Horne           Illinois St. 56.5  6-1 175 So 2021
#> 393 13           Tyler Burton               Richmond 55.7  6-7 215 So 2021
#> 394 13             Kyle Owens                Montana 55.2  6-8 205 So 2021
#> 395 13              DJ Carton              Marquette 52.1  6-2 200 So 2021
#> 396 13         Brice Williams              Charlotte 55.3  6-7 215 So 2021
#> 397 13          AJ Plitzuweit           South Dakota 56.8  6-2 170 So 2021
#> 398 13          Garrick Green       Coastal Carolina 54.4  6-6 215 Sr 2021
#> 399 13          Davion Warren                Hampton 54.6  6-6 210 Sr 2021
#> 400 13            Andrew Carr               Delaware 58.2  6-9 210 Fr 2021
#> 401 13             Bryce Pope           UC San Diego 55.6  6-3 185 Fr 2021
#> 402 13           Themus Fulks     South Carolina St. 50.0  6-1 185 Fr 2021
#> 403 14           Andrew Jones                  Texas 52.6  6-4 192 Jr 2021
#> 404 14    David Jean-Baptiste            Chattanooga 56.0  6-1 193 Sr 2021
#> 405 14           Josh Parrish              San Diego 54.0  6-4 215 Sr 2021
#> 406 14            Loudon Love             Wright St. 56.3  6-8 260 Sr 2021
#> 407 14           Tareq Coburn                Hofstra 55.9  6-5 205 Sr 2021
#> 408 14         Dajour Dickens                Hampton 53.8  7-0 215 Jr 2021
#> 409 14         Jalen Crutcher                 Dayton 55.4  6-1 175 Sr 2021
#> 410 14           Jordan Usher           Georgia Tech 55.7  6-7 213 Sr 2021
#> 411 14       Keyshawn Feazell            McNeese St. 56.5  6-9 235 Sr 2021
#> 412 14              Lat Mayen               Nebraska 54.0  6-9 205 Jr 2021
#> 413 14          Mike Adewunmi       SIU Edwardsville 53.9  6-5 205 Sr 2021
#> 414 14        Troymain Crosby             Alcorn St. 50.3  6-4 200 Sr 2021
#> 415 14             Tyreke Key            Indiana St. 56.2  6-3 205 Sr 2021
#> 416 14          Tyrese Martin            Connecticut 52.0  6-6 215 Jr 2021
#> 417 14            Jake Wojcik              Fairfield 50.3  6-5 190 Jr 2021
#> 418 14             Noah Locke                Florida 52.5  6-3 203 Jr 2021
#> 419 14            Tavin Lovan                    UAB 55.1  6-4 210 Jr 2021
#> 420 14            Kur Jockuch      Northern Colorado 54.5  6-9 220 Jr 2021
#> 421 14          Mason Harrell              Texas St. 53.9  5-9 145 Jr 2021
#> 422 14             Joe Bryant            Norfolk St. 49.6  6-1 225 Jr 2021
#> 423 14          Josh Caldwell                   Army 53.3  6-2 185 Jr 2021
#> 424 14          Dae Dae Grant               Miami OH 54.7  6-2 185 So 2021
#> 425 14          Will Martinez                 Wagner 52.7  6-5 190 Sr 2021
#> 426 14            Darin Green                    UCF 52.4  6-4 185 So 2021
#> 427 14         Connor Withers           UMass Lowell 50.8  6-7 195 So 2021
#> 428 14           Jaime Jaquez                   UCLA 53.7  6-6 220 So 2021
#> 429 14      Baylor Scheierman       South Dakota St. 56.2  6-6 180 So 2021
#> 430 14          Elijah Pepper               UC Davis 52.2  6-4 200 So 2021
#> 431 14          Tre Armstrong            Cal Baptist 50.4  6-5 210 So 2021
#> 432 14            Tre Coleman                 Nevada 54.6  6-7 185 Fr 2021
#> 433 15          Dylan Painter               Delaware 55.9 6-10 235 Sr 2021
#> 434 15            Troy Baxter             Morgan St. 49.4  6-9 200 Sr 2021
#> 435 15        Ben Vander Plas                   Ohio 54.2  6-8 232 Jr 2021
#> 436 15           Darius Perry                    UCF 51.3  6-2 185 Sr 2021
#> 437 15       Dominick Pickett           UC Riverside 52.2  6-3 210 Sr 2021
#> 438 15           RaiQuan Gray            Florida St. 55.4  6-8 260 Jr 2021
#> 439 15           Terry Taylor            Austin Peay 53.6  6-5 230 Sr 2021
#> 440 15       Trevion Williams                 Purdue 53.9 6-10 265 Jr 2021
#> 441 15   Tyreek Scott-Grayson                    UAB 54.8  6-5 180 Sr 2021
#> 442 15          Trey Woodbury            Utah Valley 50.4  6-4 200 Jr 2021
#> 443 15          Jake Stephens                    VMI 55.9 6-10 266 Jr 2021
#> 444 15           Koreem Ozier       Louisiana Monroe 52.5  6-1 180 Jr 2021
#> 445 15          Brandon Swaby         Incarnate Word 55.8  6-3 170 So 2021
#> 446 15           Tykei Greene            Stony Brook 50.4  6-4 205 Jr 2021
#> 447 15               KC Ndefo          Saint Peter's 50.0  6-7 195 Jr 2021
#> 448 15             KJ Johnson               Lipscomb 52.6  6-2 170 So 2021
#> 449 15      Julian Champagnie             St. John's 51.8  6-8 220 So 2021
#> 450 15          Christian Ray               La Salle 54.9  6-6 215 So 2021
#> 451 15            Golden Dike              Loyola MD 53.0 6-10 250 So 2021
#> 452 15      Kruz Perrott-Hunt           South Dakota 56.2  6-3 195 So 2021
#> 453 15         Allen Flanigan                 Auburn 52.5  6-6 215 So 2021
#> 454 15         Isaiah Stevens           Colorado St. 53.8  6-0 180 So 2021
#> 455 15       Terreon Randolph          Grambling St. 50.0  6-8 220 Sr 2021
#> 456 15           Zahir Porter              Weber St. 54.3  6-6 180 Jr 2021
#> 457 15        Cade Cunningham           Oklahoma St. 51.8  6-8 220 Fr 2021
#> 458 15         Demarcus Sharp           Missouri St. 56.1  6-3 170 Jr 2021
#> 459 15        Marques Warrick      Northern Kentucky 55.7  6-2 170 Fr 2021
#> 460 15     D'Maurian Williams           Gardner Webb 53.6  6-5 195 Fr 2021
#> 461 15            Josh Reaves       Mount St. Mary's 52.3  6-4 205 Fr 2021
#> 462 15        Azuolas Tubelis                Arizona 52.7 6-11 245 Fr 2021
#> 463 15          Latrell Jones               Portland 53.9  6-5 175 Jr 2021
#> 464 16           Darian Adams       Jacksonville St. 53.1  6-3 200 Sr 2021
#> 465 16     Justin Edler-Davis    Cal St. Bakersfield 52.0  6-4 220 Sr 2021
#> 466 16        Austin Williams               Hartford 50.3  6-4 200 Sr 2021
#> 467 16        Galen Alexander         Texas Southern 49.5  6-6 220 Sr 2021
#> 468 16            Isaac Kante                Hofstra 55.1  6-7 240 Jr 2021
#> 469 16          Isaiah Whaley            Connecticut 51.7  6-9 230 Sr 2021
#> 470 16            Jarrod West               Marshall 53.8 5-11 181 Sr 2021
#> 471 16            John Harrar               Penn St. 53.9  6-9 240 Sr 2021
#> 472 16            Justin Bean               Utah St. 53.2  6-7 210 Jr 2021
#> 473 16           Luke Johnson              Loyola MD 52.3  6-3 180 Sr 2021
#> 474 16        Marreon Jackson                 Toledo 54.0  6-1 200 Sr 2021
#> 475 16          Reggie Miller      Abilene Christian 55.4  6-0 150 Sr 2021
#> 476 16           Stefan Kenic            Chattanooga 55.3  6-9 223 Sr 2021
#> 477 16          Logan Johnson           Saint Mary's 53.5  6-2 170 Jr 2021
#> 478 16         Quentin Grimes                Houston 50.5  6-5 205 Jr 2021
#> 479 16           Alan Griffin               Syracuse 55.0  6-5 190 Jr 2021
#> 480 16          Jules Bernard                   UCLA 52.0  6-6 205 Jr 2021
#> 481 16        Michael Meadows     Eastern Washington 53.9  6-2 175 So 2021
#> 482 16        Spencer Rodgers           Kennesaw St. 51.9  6-4 178 Jr 2021
#> 483 16          Javonte Smart                    LSU 52.4  6-4 205 Jr 2021
#> 484 16        Majesty Brandon               Canisius 49.6  6-0 170 Sr 2021
#> 485 16         Deonte Billups      Purdue Fort Wayne 55.6  6-4 200 So 2021
#> 486 16        Jamison Overton            Utah Valley 50.0  6-6 190 Sr 2021
#> 487 16           Jaren Holmes        St. Bonaventure 54.7  6-4 215 Jr 2021
#> 488 16            Sam Griffin           UT Arlington 52.5  6-3 180 So 2021
#> 489 16      Ville Tahvanainen                Bradley 54.9  6-4 210 So 2021
#> 490 16           Omar Croskey     South Carolina St. 49.3  6-5 200 So 2021
#> 491 16           Chris Childs                 Bryant 52.0  6-2 180 Jr 2021
#> 492 16          Rondel Walker           Oklahoma St. 51.5  6-4 170 Fr 2021
#> 493 16           Jordan Sears           Gardner Webb 53.5 5-11 175 Fr 2021
#> 494 16            Will Carius       Western Illinois 56.1  6-7 225 Sr 2021
#> 495 17              Bryce Nze                 Butler 50.9  6-7 230 Sr 2021
#> 496 17        Jeremy Sheppard           Rhode Island 54.7  6-1 165 Sr 2021
#> 497 17           Oscar Frayer           Grand Canyon 49.3  6-6 195 Sr 2021
#> 498 17             Ty Flowers                    LIU 51.5  6-9 200 Sr 2021
#> 499 17          Alex Barcello                    BYU 53.5  6-2 180 Sr 2021
#> 500 17        Brandon Horvath                   UMBC 50.0 6-10 210 Sr 2021
#> 501 17          Elijah Joiner                  Tulsa 50.0  6-3 201 Sr 2021
#> 502 17          Marcus Shaver              Boise St. 52.9  6-2 185 Jr 2021
#> 503 17           Moses Wright           Georgia Tech 54.6  6-9 233 Sr 2021
#> 504 17            Noah Gurley                 Furman 54.3  6-8 210 Jr 2021
#> 505 17              Yves Pons              Tennessee 52.1  6-6 215 Sr 2021
#> 506 17      Riley Abercrombie                   Rice 53.0 6-10 210 So 2021
#> 507 17        De'Torrion Ware             Morgan St. 49.0  6-4 200 Jr 2021
#> 508 17                Jr Clay         Tennessee Tech 52.7  6-0 170 Jr 2021
#> 509 17          Jalen Pickett                  Siena 49.3  6-4 202 Jr 2021
#> 510 17           Greg Summers                   Navy 52.1  6-4 200 Jr 2021
#> 511 17        Christian Braun                 Kansas 51.0  6-6 210 So 2021
#> 512 17         Brayden Parker              Idaho St. 53.1  6-8 250 So 2021
#> 513 17       Cedric Henderson               Campbell 53.1  6-6 190 Jr 2021
#> 514 17          Tanner Holden             Wright St. 55.5  6-6 185 So 2021
#> 515 17             EJ Liddell               Ohio St. 53.8  6-7 240 So 2021
#> 516 17         Douglas Wilson       South Dakota St. 53.7  6-7 210 Sr 2021
#> 517 17        Cameron Johnson      Stephen F. Austin 54.7  6-4 216 Sr 2021
#> 518 17             Ben Krikke             Valparaiso 54.8  6-9 230 So 2021
#> 519 17            Jonas James            Jackson St. 49.0  6-0 160 Sr 2021
#> 520 17            Zyon Pullin           UC Riverside 52.0  6-4 195 So 2021
#> 521 17         Kayo Goncalves          South Alabama 52.4  6-8 212 Sr 2021
#> 522 17      Michael O'Connell               Stanford 51.9  6-2 185 Fr 2021
#> 523 17         Meikkel Murray       Central Michigan 53.4  6-6 190 Jr 2021
#> 524 17         Connor Kochera         William & Mary 55.0  6-5 200 Fr 2021
#> 525 17             Dylan Penn             Bellarmine 51.8  6-3 190 Jr 2021
#> 526 18            Clay Mounce                 Furman 54.3  6-7 210 Sr 2021
#> 527 18            Corey Allen            Georgia St. 52.2  6-2 210 Sr 2021
#> 528 18         John Fulkerson              Tennessee 51.9  6-9 215 Sr 2021
#> 529 18            Jordan Bell                Pacific 52.8  6-8 221 Sr 2021
#> 530 18       Chauncey Hawkins         St. Francis NY 51.1  5-8 172 Sr 2021
#> 531 18         Darnell Rogers                   UMBC 49.5  5-2 150 Sr 2021
#> 532 18          David Jenkins                   UNLV 51.3  6-2 195 Jr 2021
#> 533 18          Elijah Cuffee                Liberty 51.1  6-4 185 Sr 2021
#> 534 18          Holland Woods            Arizona St. 51.5  6-1 180 Sr 2021
#> 535 18           Justyn Mutts          Virginia Tech 54.4  6-7 230 Jr 2021
#> 536 18          Kamron Reaves            Florida A&M 48.0  6-2 170 Sr 2021
#> 537 18             Luka Garza                   Iowa 53.7 6-11 265 Sr 2021
#> 538 18               Matt Faw             Holy Cross 51.9  6-9 223 Sr 2021
#> 539 18           Paul Scruggs                 Xavier 50.7  6-4 196 Sr 2021
#> 540 18          Rocky Kreuser       North Dakota St. 53.2 6-10 245 Sr 2021
#> 541 18            Taj Benning              Fairfield 48.3  6-4 202 Sr 2021
#> 542 18            Collin Welp              UC Irvine 51.8  6-9 225 Jr 2021
#> 543 18         Taevion Kinsey               Marshall 52.9  6-5 185 Jr 2021
#> 544 18             Bodie Hume      Northern Colorado 52.6  6-7 190 Jr 2021
#> 545 18            Mekhi Lairy               Miami OH 53.2  5-8 140 Jr 2021
#> 546 18       Chandler Vaudrin               Winthrop 52.2  6-7 210 Sr 2021
#> 547 18 Tremont Robinson-White          East Carolina 50.0  6-1 190 Jr 2021
#> 548 18              Roti Ware      Stephen F. Austin 54.3  6-3 187 Sr 2021
#> 549 18       Terrence Shannon             Texas Tech 51.0  6-6 210 So 2021
#> 550 18       Charles Thompson                 Towson 54.9  6-7 235 So 2021
#> 551 18         Brandon Battle            Alabama St. 47.6  6-8 215 Sr 2021
#> 552 18         Craig Beaudion          Cleveland St. 55.1  6-3 170 Sr 2021
#> 553 18     Steven Verplancken      Southern Illinois 54.8  6-4 205 So 2021
#> 554 18       Darrion Trammell                Seattle 46.9 5-10 165 So 2021
#> 555 18            Tyler Kolek           George Mason 54.6  6-3 190 Fr 2021
#> 556 18       Damaria Franklin         Tennessee Tech 52.0  6-4 210 Jr 2021
#> 557 19              KJ Walton               Ball St. 52.9  6-3 200 Sr 2021
#> 558 19            Brad Greene              UC Irvine 51.7 6-11 270 Sr 2021
#> 559 19         DeJuan Clayton             Coppin St. 47.1  6-2 185 Sr 2021
#> 560 19       Jannson Williams               Marshall 52.9  6-9 219 Sr 2021
#> 561 19          Solomon Young               Iowa St. 50.4  6-8 255 Sr 2021
#> 562 19          Damion Rosser            New Orleans 53.7  6-4 220 Jr 2021
#> 563 19           Devon Cooper           Morehead St. 51.9  6-4 201 Jr 2021
#> 564 19         Justice Sueing               Ohio St. 53.3  6-7 215 Jr 2021
#> 565 19             Ryan Allen               Delaware 53.7  6-2 200 Sr 2021
#> 566 19  Sandro Mamukelashvili             Seton Hall 50.0 6-11 240 Sr 2021
#> 567 19          Stacy Beckton               American 51.5  6-4 186 Sr 2021
#> 568 19            Alex Rivera                    LIU 51.1  6-1 185 So 2021
#> 569 19        Brandon Younger           Presbyterian 51.9  6-7 190 Jr 2021
#> 570 19            Jarius Cook       North Dakota St. 53.1  6-3 180 So 2021
#> 571 19          Malachi Smith            Chattanooga 54.2  6-4 205 So 2021
#> 572 19         DeVante' Jones       Coastal Carolina 52.0  6-1 200 Jr 2021
#> 573 19            Jamie Ahale       Illinois Chicago 54.9  6-5 205 Sr 2021
#> 574 19              Rob Perry                Stetson 50.8  6-4 210 So 2021
#> 575 19     Samuell Williamson             Louisville 54.2  6-7 210 So 2021
#> 576 19          Isiaih Mosley           Missouri St. 54.8  6-5 201 So 2021
#> 577 19         Dylan van Eyck                   Iona 48.2  6-8 210 Sr 2021
#> 578 19          Jordan Wright             Vanderbilt 51.7  6-6 226 So 2021
#> 579 19           Kwane Marble                Wyoming 51.3  6-6 195 So 2021
#> 580 19        Nah'Shon Hyland                    VCU 54.0  6-3 173 So 2021
#> 581 19          Broc Finstuen                Pacific 52.3  6-4 200 Sr 2021
#> 582 19            Jarod Lucas             Oregon St. 51.0  6-3 195 So 2021
#> 583 19          Khalid Thomas           Portland St. 52.6 6-10 210 Sr 2021
#> 584 19           Caleb Hunter Mississippi Valley St. 47.1 5-10 185 So 2021
#> 585 19       Mika Adams-Woods             Cincinnati 50.0  6-3 185 So 2021
#> 586 19           Jamel Horton                 Albany 49.5  6-4 190 Jr 2021
#> 587 19         Cameron Gooden              Dixie St. 46.2 5-11 175 Jr 2021
#> 588 20           John Pettway          South Alabama 52.0  6-3 189 Sr 2021
#> 589 20          Keon Clergeot Southeastern Louisiana 52.5  6-1 190 Sr 2021
#> 590 20            Caleb Green              Fairfield 48.1 5-10 175 Jr 2021
#> 591 20            Colbey Ross             Pepperdine 52.3  6-1 185 Sr 2021
#> 592 20         Darryl Morsell               Maryland 52.4  6-5 200 Sr 2021
#> 593 20           Felipe Haase                 Mercer 54.1  6-9 253 Jr 2021
#> 594 20        Kimani Lawrence            Arizona St. 50.9  6-8 210 Sr 2021
#> 595 20        Kameron Langley     North Carolina A&T 46.8  6-2 165 Sr 2021
#> 596 20              Tae Hardy          Southern Miss 51.9  6-3 175 Jr 2021
#> 597 20           Tevian Jones          Southern Utah 52.5  6-7 190 Jr 2021
#> 598 20        Dontarius James           Jacksonville 50.6  6-8 228 Jr 2021
#> 599 20         Garrett Sturtz                  Drake 54.8  6-3 175 Jr 2021
#> 600 20          Taelyr Gatlin                 Denver 52.5  6-3 180 Jr 2021
#> 601 20              Nic Lynch                 Lehigh 51.3 6-11 250 Jr 2021
#> 602 20          Riley Grigsby                Seattle 45.9  6-6 220 Jr 2021
#> 603 20             Shaun Doss    Arkansas Pine Bluff 45.8  6-5 185 Jr 2021
#> 604 20          Miles McBride          West Virginia 49.8  6-2 200 So 2021
#> 605 20      Justin Champagnie             Pittsburgh 53.5  6-6 200 So 2021
#> 606 20          Tyson Etienne            Wichita St. 49.7  6-2 200 So 2021
#> 607 20           Tyson Walker           Northeastern 53.6  6-0 170 So 2021
#> 608 20          Cameron Brown         Saint Joseph's 54.0  6-5 220 So 2021
#> 609 20          Chance Hunter         Long Beach St. 50.5  6-6 190 Jr 2021
#> 610 20        Devan Cambridge                 Auburn 51.6  6-6 215 So 2021
#> 611 20        Keondre Kennedy                   UMBC 48.6  6-6 180 Jr 2021
#> 612 20             Ziggy Reid              Merrimack 50.9  6-6 235 So 2021
#> 613 20           Winston Hill           Presbyterian 51.4  6-7 230 Jr 2021
#> 614 20            Jalen Finch       Jacksonville St. 51.8  6-1 165 Jr 2021
#> 615 20           Chuck Harris                 Butler 50.0  6-2 190 Fr 2021
#> 616 20           Ryan Rollins                 Toledo 52.7  6-4 180 Fr 2021
#> 617 20          Trey Townsend                Oakland 54.5  6-6 222 Fr 2021
#> 618 20        Glen McClintock              Air Force 50.8  6-2 185 Fr 2021
#> 619 21       Brandon Averette                    BYU 52.3 5-11 185 Sr 2021
#> 620 21         Eugene Omoruyi                 Oregon 50.5  6-6 235 Sr 2021
#> 621 21            Jacob Young                Rutgers 52.2  6-2 185 Sr 2021
#> 622 21          Payton Willis             Charleston 53.3  6-4 190 Sr 2021
#> 623 21      Desmond Cambridge                 Nevada 50.6  6-4 180 Jr 2021
#> 624 21      Isaiah Washington         Long Beach St. 48.6  6-1 195 Sr 2021
#> 625 21         Jahlil Jenkins    Fairleigh Dickinson 50.6  6-0 160 Sr 2021
#> 626 21          Javante McCoy      Boston University 50.9  6-5 180 Sr 2021
#> 627 21             Javon Levi   UT Rio Grande Valley 45.5 5-11 175 Sr 2021
#> 628 21            Koby Thomas             Coppin St. 46.7  6-6 190 Sr 2021
#> 629 21          Marek Dolezaj               Syracuse 52.9 6-10 201 Sr 2021
#> 630 21         Matt Halvorsen       Western Carolina 54.0  6-1 183 Sr 2021
#> 631 21          Stanley Umude           South Dakota 52.3  6-6 210 Sr 2021
#> 632 21             Troy Green            New Orleans 52.4  6-3 215 Sr 2021
#> 633 21          Tyree Appleby                Florida 51.5  6-1 170 Jr 2021
#> 634 21          Kendric Davis                    SMU 49.7 5-11 180 Jr 2021
#> 635 21         Shamar Givance             Evansville 54.3 5-10 155 Jr 2021
#> 636 21         Jordan Gilliam         Texas Southern 45.3  6-5 175 Jr 2021
#> 637 21          Antoine Davis                Detroit 54.4  6-1 165 Jr 2021
#> 638 21          Bryce Workman           Jacksonville 49.5  6-7 230 Jr 2021
#> 639 21         Micheal Anumba               Winthrop 50.6  6-4 220 Jr 2021
#> 640 21         Avery Anderson           Oklahoma St. 49.7  6-3 170 So 2021
#> 641 21        Tyler Robertson     Eastern Washington 52.4  6-6 200 So 2021
#> 642 21      Keishawn Davidson         Tennessee Tech 51.7  6-2 175 So 2021
#> 643 21 Jeremiah Robinson-Earl              Villanova 50.0  6-9 230 So 2021
#> 644 21            Malik Curry           Old Dominion 51.2  6-1 180 Sr 2021
#> 645 21            Matthew Lee          Saint Peter's 48.0  6-0 160 So 2021
#> 646 21             Duke Miles                   Troy 51.9  6-2 175 Fr 2021
#> 647 21          Ronnie DeGray          Massachusetts 54.0  6-7 220 Fr 2021
#> 648 21         LeChaun DuHart                  Maine 48.6 5-11 175 Fr 2021
#> 649 21             Mark Sears                   Ohio 51.8  6-1 185 Fr 2021
#> 650 22        Brandon Johnson              Minnesota 51.7  6-8 220 Sr 2021
#> 651 22          Chyree Walker                Radford 50.5  6-5 200 Jr 2021
#> 652 22         Ethan Igbanugo           North Dakota 51.5  6-3 191 Jr 2021
#> 653 22        Ishmael El-Amin               Ball St. 50.9  6-3 180 Sr 2021
#> 654 22         Marcus Garrett                 Kansas 49.7  6-5 205 Sr 2021
#> 655 22          Matt Mitchell          San Diego St. 50.3  6-6 235 Sr 2021
#> 656 22            Remy Martin            Arizona St. 50.4  6-0 175 Sr 2021
#> 657 22    San Antonio Brinson                   NJIT 47.8  6-8 210 Sr 2021
#> 658 22       Steffon Mitchell         Boston College 52.6  6-8 220 Sr 2021
#> 659 22         Tray Hollowell                Wofford 54.0  6-3 185 Sr 2021
#> 660 22           Myles Carter           Delaware St. 46.1  6-1 170 Sr 2021
#> 661 22               Tre King       Eastern Kentucky 51.5  6-9 225 Jr 2021
#> 662 22       DeAndre Gholston              Milwaukee 54.0  6-5 215 Jr 2021
#> 663 22           Tyrone Perry              Lafayette 50.5  6-2 165 Jr 2021
#> 664 22             Dre Fuller                    UCF 48.5  6-5 215 So 2021
#> 665 22             Trey Sides           Jacksonville 49.2  6-1 170 So 2021
#> 666 22           Alex Morales                 Wagner 50.4  6-6 180 Sr 2021
#> 667 22            Noah Carter          Northern Iowa 54.1  6-6 229 So 2021
#> 668 22         Noah Fernandes          Massachusetts 53.9 5-11 175 So 2021
#> 669 22               Tre Mann                Florida 51.4  6-5 190 So 2021
#> 670 22         Bryan Greenlee       Florida Atlantic 51.0  6-0 195 So 2021
#> 671 22           Allen Powell                  Rider 47.4  6-2 165 So 2021
#> 672 22         Sedrick Altman             Pepperdine 51.9  6-2 180 So 2021
#> 673 22    William FitzPatrick         Sacramento St. 51.2  6-3 200 Sr 2021
#> 674 22          Jamaure Gregg       Northwestern St. 52.3  6-7 232 Sr 2021
#> 675 22           Jason Gibson                 Towson 53.2  6-1 165 So 2021
#> 676 22           Junior Madut                 Hawaii 47.1  6-6 180 Jr 2021
#> 677 22       Gedi Juozapaitis       Georgia Southern 51.4  6-4 210 Jr 2021
#> 678 22         Posh Alexander             St. John's 50.0  6-0 190 Fr 2021
#> 679 22          Shamir Bogues           Tarleton St. 44.9  6-4 190 Fr 2021
#> 680 22          Terry Collins Mississippi Valley St. 44.6  6-3 180 Jr 2021
#> 681 23           Traci Carter               Hartford 47.8  6-1 175 Sr 2021
#> 682 23              Josh Hall      Cal St. Fullerton 44.6  6-7 213 Sr 2021
#> 683 23        Marcus Weathers               Duquesne 53.7  6-5 215 Sr 2021
#> 684 23              Abu Kigab              Boise St. 50.3  6-7 220 Sr 2021
#> 685 23             Nana Opoku       Mount St. Mary's 49.6  6-9 210 Jr 2021
#> 686 23          Torrey Patton          Cleveland St. 53.9  6-5 195 Sr 2021
#> 687 23             Tyler Maye     North Carolina A&T 45.5  6-1 175 Sr 2021
#> 688 23     Carter Hendricksen          North Florida 49.0  6-7 217 Jr 2021
#> 689 23          Isaiah Mucius            Wake Forest 52.6  6-8 200 Jr 2021
#> 690 23            Ayo Dosunmu               Illinois 51.1  6-5 200 Jr 2021
#> 691 23         Luis Rodriguez            Mississippi 51.0  6-6 210 So 2021
#> 692 23            Mac McClung             Texas Tech 49.3  6-2 185 Jr 2021
#> 693 23            Sam Griesel       North Dakota St. 50.7  6-6 215 Jr 2021
#> 694 23           Adrian Delph        Appalachian St. 50.9  6-3 185 Jr 2021
#> 695 23          Camren Wynter                 Drexel 52.6  6-2 175 Jr 2021
#> 696 23        Neftali Alvarez                 Mercer 53.4  6-2 165 So 2021
#> 697 23     Jeenathan Williams                Buffalo 50.8  6-5 206 Jr 2021
#> 698 23        Warith Alatishe             Oregon St. 50.3  6-7 200 Jr 2021
#> 699 23        Tyler Stevenson          Southern Miss 51.0  6-8 225 Jr 2021
#> 700 23              Ty Rowell            Cal Baptist 44.9  6-2 190 Jr 2021
#> 701 23           Josh Vazquez                Montana 50.5  6-3 180 So 2021
#> 702 23            Evan Taylor                 Lehigh 50.0  6-6 200 So 2021
#> 703 23          Garrett Hicks            Alabama A&M 44.0  6-0 160 So 2021
#> 704 23          Joseph Yesufu                  Drake 54.1  6-0 180 So 2021
#> 705 23     Emmanuel Bandoumel                    SMU 48.2  6-4 180 Jr 2021
#> 706 23             Luke Smith                Belmont 51.4  6-0 175 Jr 2021
#> 707 23            Colby Jones                 Xavier 49.3  6-5 195 Fr 2021
#> 708 23            Jacob Falko           Gardner Webb 50.3  6-2 180 Jr 2021
#> 709 23         Ricardo Wright                 Marist 46.9  6-4 185 Fr 2021
#> 710 23            Jalen Suggs                Gonzaga 51.7  6-4 205 Fr 2021
#> 711 23         Kasen Harrison                  Lamar 52.1  6-1 190 Fr 2021
#> 712 24            Andre Jones           Nicholls St. 51.6  6-4 200 Sr 2021
#> 713 24         Michael Hughes               Duquesne 52.9  6-8 240 Sr 2021
#> 714 24            Mikey Dixon           Grand Canyon 43.8  6-2 165 Sr 2021
#> 715 24          Unique McLean         St. Francis NY 49.5  6-2 182 Sr 2021
#> 716 24               DJ Heath            Alabama St. 43.7  6-0 185 Sr 2021
#> 717 24            EJ Stephens              Lafayette 49.7  6-3 176 Sr 2021
#> 718 24           Hayden Brown            The Citadel 53.2  6-5 225 Jr 2021
#> 719 24         Jamaree Bouyea          San Francisco 51.3  6-2 180 Sr 2021
#> 720 24      Keaton Van Soelen              Air Force 50.0  6-7 190 Sr 2021
#> 721 24             Matt Lewis          James Madison 52.2  6-5 200 Sr 2021
#> 722 24           Nana Akenten Southeast Missouri St. 51.2  6-6 215 Jr 2021
#> 723 24           Trey Jemison                    UAB 50.9  7-0 260 Jr 2021
#> 724 24        Emanuel Littles          North Alabama 48.1  6-7 215 Jr 2021
#> 725 24           DeShaun Wade               Longwood 50.3  6-2 200 Jr 2021
#> 726 24            Bryce Daley           UMass Lowell 47.4  6-4 190 So 2021
#> 727 24       Duane Washington               Ohio St. 51.0  6-3 210 Jr 2021
#> 728 24           Rasir Bolton               Iowa St. 49.2  6-3 185 Jr 2021
#> 729 24           Bryce Golden                 Butler 49.0  6-9 260 Jr 2021
#> 730 24          Daylen Kountz      Northern Colorado 50.0  6-4 191 Jr 2021
#> 731 24         Jaiden Delaire               Stanford 49.8  6-9 210 Jr 2021
#> 732 24          Jase Townsend                 Denver 50.5  6-3 175 Jr 2021
#> 733 24        Keyshawn Bryant         South Carolina 50.8  6-6 195 Jr 2021
#> 734 24           Ronaldo Segu                Buffalo 50.3  6-0 160 Jr 2021
#> 735 24            MJ Randolph            Florida A&M 44.0  6-4 170 Jr 2021
#> 736 24           Nikola Maric            Little Rock 50.8 6-10 250 Jr 2021
#> 737 24          Marcus Sasser                Houston 48.0  6-1 190 So 2021
#> 738 24             Tarik Cool              Idaho St. 50.0  6-4 180 Sr 2021
#> 739 24           Tre Williams            Indiana St. 53.3  6-7 250 So 2021
#> 740 24            Josh Thomas              Milwaukee 53.6  6-4 205 Sr 2021
#> 741 24            Ezra Manjon               UC Davis 43.7 5-11 170 So 2021
#> 742 24           Jeremy Roach                   Duke 52.5  6-1 175 Fr 2021
#> 743 25              CJ Keyser North Carolina Central 43.7  6-3 190 Sr 2021
#> 744 25         Devearl Ramsey       UC Santa Barbara 42.8  6-0 185 Sr 2021
#> 745 25           Najee Garvin           Nicholls St. 51.1  6-7 210 Jr 2021
#> 746 25          Caleb Daniels              Villanova 48.6  6-4 210 Jr 2021
#> 747 25          Jamal Johnson                 Auburn 50.6  6-4 195 Jr 2021
#> 748 25         Keaton Wallace                   UTSA 50.0  6-4 195 Sr 2021
#> 749 25       Sasha Stefanovic                 Purdue 51.0  6-5 200 Jr 2021
#> 750 25         Lonnie Grayson                   Army 48.7  6-0 180 Sr 2021
#> 751 25         Jayden Gardner          East Carolina 47.8  6-7 235 Jr 2021
#> 752 25        Jeremiah Bailey                Pacific 50.9  6-6 220 Sr 2021
#> 753 25          Filip Rebraca           North Dakota 50.4  6-9 222 Jr 2021
#> 754 25           Matt Herasme                 Marist 46.2  6-3 180 Jr 2021
#> 755 25              Tim Finke             Wright St. 53.5  6-6 215 So 2021
#> 756 25          Buddy Boeheim               Syracuse 52.2  6-6 195 Jr 2021
#> 757 25         Courtney Ramey                  Texas 48.5  6-3 185 Jr 2021
#> 758 25           Joel Soriano                Fordham 52.8 6-11 250 So 2021
#> 759 25            Trent Brown      Southern Illinois 52.8  6-2 175 So 2021
#> 760 25        Grant Sherfield                 Nevada 48.9  6-2 189 So 2021
#> 761 25          Ta'lon Cooper           Morehead St. 50.0  6-4 190 So 2021
#> 762 25               Cam Mack       Prairie View A&M 41.9  6-2 170 Jr 2021
#> 763 25          Nick Stampley                   Troy 50.6  6-6 210 Sr 2021
#> 764 25         Owen McCormack           Presbyterian 50.0  6-9 230 So 2021
#> 765 25        Damari Monsanto     East Tennessee St. 52.7  6-6 215 Fr 2021
#> 766 25           Jalen Warren     Florida Gulf Coast 47.9  6-3 162 Sr 2021
#> 767 25          Johnny Juzang                   UCLA 49.5  6-6 210 So 2021
#> 768 25           Devin Jensen              Merrimack 49.2  6-5 220 Sr 2021
#> 769 25   Juan Felix Rodriguez            Stony Brook 47.2  6-0 190 Jr 2021
#> 770 25          Kaden Metheny          Bowling Green 50.0 5-11 180 Fr 2021
#> 771 25         Jamahri Harvey         UNC Wilmington 52.0  6-5 175 Fr 2021
#> 772 25           Frank Staine              Dixie St. 43.4  6-6 205 So 2021
# }
# \donttest{
try(kp_kpoy(year = 2026))
#> $KPoYRatings
#>    rk            player kpoy_rating          team hgt wgt exp        home_town
#> 1   1    Cameron Boozer       2.951          Duke 6-9 250  Fr        Miami, FL
#> 2   2  Joshua Jefferson       1.758      Iowa St. 6-9 240  Sr    Las Vegas, NV
#> 3   3   Yaxel Lendeborg       1.690      Michigan 6-9 240  Sr   Pennsauken, NJ
#> 4   4 Kingston Flemings       1.685       Houston 6-4 190  Fr  San Antonio, TX
#> 5   5     Keaton Wagler       1.642      Illinois 6-6 185  Fr      Shawnee, KS
#> 6   6       AJ Dybantsa       1.596           BYU 6-9 212  Fr     Brockton, MA
#> 7   7      Jeremy Fears       1.563  Michigan St. 6-2 190  So       Joliet, IL
#> 8   8      Zuby Ejiofor       1.556    St. John's 6-9 245  Sr      Garland, TX
#> 9   9      Braden Smith       1.503        Purdue 6-0 170  Sr    Westfield, IN
#> 10 10      Tyler Tanner       1.502    Vanderbilt 6-0 173  So    Brentwood, TN
#>    year       group
#> 1  2026 kPoY Rating
#> 2  2026 kPoY Rating
#> 3  2026 kPoY Rating
#> 4  2026 kPoY Rating
#> 5  2026 kPoY Rating
#> 6  2026 kPoY Rating
#> 7  2026 kPoY Rating
#> 8  2026 kPoY Rating
#> 9  2026 kPoY Rating
#> 10 2026 kPoY Rating
#> 
#> $GameMVPs
#>    rk            player game_mv_ps               team  hgt wgt exp
#> 1   1    Cameron Boozer         25               Duke  6-9 250  Fr
#> 2   2      Zuby Ejiofor         18         St. John's  6-9 245  Sr
#> 3   2 Kingston Flemings         18            Houston  6-4 190  Fr
#> 4   4   Nick Martinelli         16       Northwestern  6-7 225  Sr
#> 5   4      Tyler Tanner         16         Vanderbilt  6-0 173  So
#> 6   4      Ebuka Okorie         16           Stanford  6-2 185  Fr
#> 7   7    Bennett Stirtz         15               Iowa  6-4 190  Sr
#> 8   8        Graham Ike         14            Gonzaga  6-9 250  Sr
#> 9   8     Camren Hunter         14   Central Arkansas  6-3 205  Sr
#> 10  8     Keon Thompson         14  Stephen F. Austin  6-1 200  Sr
#> 11  8       Tarris Reed         14        Connecticut 6-11 265  Sr
#> 12  8    Bruce Thornton         14           Ohio St.  6-2 215  Sr
#> 13  8        Gavin Doty         14              Siena  6-5 190  So
#>            home_town year            group
#> 1          Miami, FL 2026 Game MVP Leaders
#> 2        Garland, TX 2026 Game MVP Leaders
#> 3    San Antonio, TX 2026 Game MVP Leaders
#> 4       Glenview, IL 2026 Game MVP Leaders
#> 5      Brentwood, TN 2026 Game MVP Leaders
#> 6         Nashua, NH 2026 Game MVP Leaders
#> 7        Liberty, MO 2026 Game MVP Leaders
#> 8         Aurora, CO 2026 Game MVP Leaders
#> 9         Bryant, AR 2026 Game MVP Leaders
#> 10  Merrillville, IN 2026 Game MVP Leaders
#> 11     St. Louis, MO 2026 Game MVP Leaders
#> 12      Fairburn, GA 2026 Game MVP Leaders
#> 13        Fulton, NY 2026 Game MVP Leaders
#> 
# }
```
