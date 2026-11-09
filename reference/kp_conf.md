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

A named list of data frames: `Standings`, `ConferencePlayOffense`,
`ConferencePlayDefense`, `AllKenPom`, `ConferenceAggregateStats`,
`WinningTrends`, `ConferenceComparison`. Their column names and types
are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "kp_conf")`, and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
if (FALSE) { # interactive()
# \donttest{
    try(kp_conf(year = 2020, conf = 'ACC'))
# }
}
```
