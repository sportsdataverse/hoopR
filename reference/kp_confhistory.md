# **Get KenPom's historical conference ratings**

**Get KenPom's historical conference ratings**

## Usage

``` r
kp_confhistory(conf)
```

## Arguments

- conf:

  Used to limit to players in a specific conference.

  Allowed values are: 'A10', 'ACC', 'AE', 'AMER', 'ASUN', 'B10', 'B12',
  'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA', 'HORZ', 'IND', IVY',
  'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB',
  'SC', 'SEC', 'SLND', 'SUM', 'SWAC', 'WAC', 'WCC'.

  If you try to use a conference that doesn't exist for a given season,
  like 'IND' and '2018', you'll get an empty table, as kenpom.com
  doesn't serve 404 pages for invalid table queries like that. No filter
  applied by default.

## Value

A data frame with the following columns:

|                  |           |
|------------------|-----------|
| col_name         | types     |
| year             | integer   |
| rank             | character |
| tempo            | numeric   |
| efficiency       | numeric   |
| e_fg_pct         | numeric   |
| to_pct           | numeric   |
| or_pct           | numeric   |
| ft_rate          | numeric   |
| fg_2_pct         | numeric   |
| fg_3_pct         | numeric   |
| ft_pct           | numeric   |
| fg_3a_pct        | numeric   |
| a_pct            | numeric   |
| blk_pct          | numeric   |
| stl_pct          | numeric   |
| home_record      | character |
| bids             | character |
| s16              | character |
| f4               | character |
| ch               | character |
| reg_season_champ | character |
| tourney_champ    | character |
| best_team        | character |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_confhistory(conf = 'ACC'))
#> 2026-03-24 01:20:54.57675: Invalid arguments or no conference history data for ACC available!
#> Error in kp_confhistory(conf = "ACC") : object 'kenpom' not found
# }
```
