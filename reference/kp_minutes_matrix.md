# **Get Minutes Matrix from Expanded Player Page**

**Get Minutes Matrix from Expanded Player Page**

## Usage

``` r
kp_minutes_matrix(team, year = 2021)
```

## Arguments

- team:

  Team filter to select.

- year:

  Year of data to pull

## Value

Returns a tibble of minutes matrix data

## See also

Other KenPom Team Functions:
[`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md),
[`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md),
[`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md),
[`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md),
[`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md),
[`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)

## Examples

``` r
  # \donttest{
    try(kp_minutes_matrix(team = 'Florida St.', year = 2021))
#> 2026-03-26 14:51:19.912999 - Florida St. - 2021 minutes matrix is missing
#> Error in kp_minutes_matrix(team = "Florida St.", year = 2021) : 
#>   object 'kenpom' not found
  # }

```
