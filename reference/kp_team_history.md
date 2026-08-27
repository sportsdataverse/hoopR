# **Get KenPom's team efficiency history**

**Get KenPom's team efficiency history**

## Usage

``` r
kp_team_history(team)
```

## Arguments

- team:

  Team filter to select.

## Value

A data frame with the following columns:

|                    |           |                                              |
|--------------------|-----------|----------------------------------------------|
| col_name           | types     | description                                  |
| year               | numeric   | 4-digit year.                                |
| team_rk            | numeric   | Team rk.                                     |
| team               | character | Team-side label or team identifier.          |
| coach              | character | Coach.                                       |
| conf               | character | character.                                   |
| adj_t              | numeric   | Adj t.                                       |
| adj_o              | numeric   | Adj o.                                       |
| adj_d              | numeric   | Adj d.                                       |
| off_e_fg_pct       | numeric   | Off e field goals percentage (0-1 decimal).  |
| off_to_pct         | numeric   | Off to percentage (0-1 decimal).             |
| off_or_pct         | numeric   | Off or percentage (0-1 decimal).             |
| off_ft_rate        | numeric   | Off ft rate.                                 |
| off_fg_2_pct       | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fg_3_pct       | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_ft_pct         | numeric   | Off free throws percentage (0-1 decimal).    |
| off_fg_3a_pct      | numeric   | Off field goals 3a percentage (0-1 decimal). |
| off_a_pct          | numeric   | Off a percentage (0-1 decimal).              |
| off_apl            | numeric   | Off apl.                                     |
| def_e_fg_pct       | numeric   | Def e field goals percentage (0-1 decimal).  |
| def_to_pct         | numeric   | Def to percentage (0-1 decimal).             |
| def_or_pct         | numeric   | Def or percentage (0-1 decimal).             |
| def_ft_rate        | numeric   | Def ft rate.                                 |
| def_fg_2_pct       | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fg_3_pct       | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_blk_pct        | numeric   | Def blocks percentage (0-1 decimal).         |
| def_fg_3a_pct      | numeric   | Def field goals 3a percentage (0-1 decimal). |
| def_a_pct          | numeric   | Def a percentage (0-1 decimal).              |
| def_apl            | numeric   | Def apl.                                     |
| foul2partic_pct    | numeric   | Foul2partic percentage (0-1 decimal).        |
| wl                 | character | Wl.                                          |
| wl_conf            | character | Wl conf.                                     |
| adj_t_rk           | numeric   | Adj t rk.                                    |
| adj_o_rk           | numeric   | Adj o rk.                                    |
| adj_d_rk           | numeric   | Adj d rk.                                    |
| off_e_fg_pct_rk    | numeric   | Off e fg pct rk.                             |
| off_to_pct_rk      | numeric   | Off to pct rk.                               |
| off_or_pct_rk      | numeric   | Off or pct rk.                               |
| off_ft_rate_rk     | numeric   | Off ft rate rk.                              |
| off_fg_2_pct_rk    | numeric   | Off fg 2 pct rk.                             |
| off_fg_3_pct_rk    | numeric   | Off fg 3 pct rk.                             |
| off_ft_pct_rk      | numeric   | Off ft pct rk.                               |
| off_fg_3a_pct_rk   | numeric   | Off fg 3a pct rk.                            |
| off_a_pct_rk       | numeric   | Off a pct rk.                                |
| off_apl_rk         | numeric   | Off apl rk.                                  |
| def_e_fg_pct_rk    | numeric   | Def e fg pct rk.                             |
| def_to_pct_rk      | numeric   | Def to pct rk.                               |
| def_or_pct_rk      | numeric   | Def or pct rk.                               |
| def_ft_rate_rk     | numeric   | Def ft rate rk.                              |
| def_fg_2_pct_rk    | numeric   | Def fg 2 pct rk.                             |
| def_fg_3_pct_rk    | numeric   | Def fg 3 pct rk.                             |
| def_blk_pct_rk     | numeric   | Def blk pct rk.                              |
| def_fg_3a_pct_rk   | numeric   | Def fg 3a pct rk.                            |
| def_a_pct_rk       | numeric   | Def a pct rk.                                |
| def_apl_rk         | numeric   | Def apl rk.                                  |
| foul2partic_pct_rk | numeric   | Foul2partic pct rk.                          |
| team_finish        | character | Team finish.                                 |
| ncaa_seed          | numeric   | Ncaa seed.                                   |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md)

## Examples

``` r
  # \donttest{
    try(kp_team_history(team = 'Florida St.'))
#> ✖ 2026-08-27 17:48:20.242028: Invalid arguments or no team history data for Florida St. available!
#> ✖ Args: team = "Florida St."
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
  # }
```
