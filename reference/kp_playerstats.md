# **Get Player Stats Leaders by Metric**

**Get Player Stats Leaders by Metric**

## Usage

``` r
kp_playerstats(
  metric = "eFG",
  conf = NULL,
  conf_only = FALSE,
  year = most_recent_mbb_season()
)
```

## Arguments

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

## See also

Other KenPom Ratings Functions:
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md)

## Examples

``` r
# \donttest{
try(kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2021))
#> ✖ 2026-08-24 20:40:59.38915: Invalid arguments or no player stats data for 2021 eFG available!
#> ✖ Args: metric = "eFG", conf = NULL, conf_only = FALSE, year = 2021
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
