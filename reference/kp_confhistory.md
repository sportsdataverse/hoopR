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

|                  |           |                                          |
|------------------|-----------|------------------------------------------|
| col_name         | types     | description                              |
| year             | integer   | 4-digit year.                            |
| rank             | character | Rank.                                    |
| tempo            | numeric   | Tempo.                                   |
| efficiency       | numeric   | Efficiency.                              |
| e_fg_pct         | numeric   | E field goals percentage (0-1 decimal).  |
| to_pct           | numeric   | To percentage (0-1 decimal).             |
| or_pct           | numeric   | Or percentage (0-1 decimal).             |
| ft_rate          | numeric   | Ft rate.                                 |
| fg_2_pct         | numeric   | Field goals 2 percentage (0-1 decimal).  |
| fg_3_pct         | numeric   | Field goals 3 percentage (0-1 decimal).  |
| ft_pct           | numeric   | Free throw percentage (0-1).             |
| fg_3a_pct        | numeric   | Field goals 3a percentage (0-1 decimal). |
| a_pct            | numeric   | A percentage (0-1 decimal).              |
| blk_pct          | numeric   | Blocks percentage (0-1 decimal).         |
| stl_pct          | numeric   | Steals percentage (0-1 decimal).         |
| home_record      | character | Home win-loss record.                    |
| bids             | character | Bids.                                    |
| s16              | character | S16.                                     |
| f4               | character | F4.                                      |
| ch               | character | Ch.                                      |
| reg_season_champ | character | Reg season champ.                        |
| tourney_champ    | character | Tourney champ.                           |
| best_team        | character | Best team.                               |

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
#> ✖ 2026-08-26 19:09:57.093355: Invalid arguments or no conference history data for ACC available!
#> ✖ Args: conf = "ACC"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
