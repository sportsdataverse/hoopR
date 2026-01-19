# **Get KenPom Win Probability**

**Get KenPom Win Probability**

## Usage

``` r
kp_winprob(game_id, year)
```

## Arguments

- game_id:

  Game id of game to pull

- year:

  Year of game to pull

## Value

Returns a named list of tibbles: winprob_dataset, game_data, runs

**winprob_dataset**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| period            | integer   |
| wp                | numeric   |
| time_left         | numeric   |
| visitor_score     | integer   |
| home_score        | integer   |
| visitor_scoring   | integer   |
| home_scoring      | integer   |
| possession_team   | character |
| possession_number | character |
| game_id           | numeric   |
| year              | numeric   |

**game_data**

|                        |           |
|------------------------|-----------|
| col_name               | types     |
| game_id                | character |
| year                   | integer   |
| full_date              | character |
| date                   | character |
| game_time              | character |
| venue                  | character |
| city                   | character |
| team1                  | character |
| team1score             | integer   |
| team1_rk               | character |
| team2                  | character |
| team2score             | integer   |
| team2_rk               | character |
| dominance_season_rk    | character |
| tension_season_rk      | character |
| excitement_season_rk   | character |
| lead_changes_season_rk | character |
| minimum_wp_season_rk   | character |
| dominance_rk           | character |
| tension_rk             | character |
| excitement_rk          | character |
| lead_changes_rk        | character |
| minimum_wp_rk          | character |
| dominance              | character |
| tension                | character |
| excitement             | character |
| favchg                 | character |
| min_wp                 | character |

**runs**

|          |         |
|----------|---------|
| col_name | types   |
| start    | numeric |
| end      | numeric |
| visitor  | integer |
| home     | integer |

## See also

Other KenPom Boxscore Functions:
[`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md)

## Examples

``` r
# \donttest{
  try(kp_winprob(game_id = 1238, year = 2020))
#> Error in kp_winprob(game_id = 1238, year = 2020) : 
#>   object 'kenpom' not found
# }
```
