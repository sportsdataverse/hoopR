# **Get Team Points Distribution**

**Get Team Points Distribution**

## Usage

``` r
kp_pointdist(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

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

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_pointdist(min_year = 2020, max_year = 2021))
#> ✖ 2026-08-24 19:11:54.294699: Invalid arguments or no point distribution data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
