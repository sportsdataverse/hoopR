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

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_pomeroy_ratings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_efficiency")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_fourfactors")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_pointdist")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_height")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_foul_trouble")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_teamstats")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kp_playerstats")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A named list of tibbles: `KPoYRatings`, `GameMVPs`. Their column names
and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_kpoy")`, and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
try(kp_pomeroy_ratings(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_efficiency(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_fourfactors(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_pointdist(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_height(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_foul_trouble(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_teamstats(min_year = 2021, max_year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2021))
# }
}
if (FALSE) { # interactive()
# \donttest{
try(kp_kpoy(year = 2026))
# }
}
```
