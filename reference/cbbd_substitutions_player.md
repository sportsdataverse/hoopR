# **CBD Substitutions by Player**

**Get substitution data for a single player from the
CollegeBasketballData API.**

## Usage

``` r
cbbd_substitutions_player(player_id, season = most_recent_mbb_season())
```

## Arguments

- player_id:

  (*integer* required): Athlete id.

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per substitution (same columns as
[`cbbd_substitutions_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_game.md)).

## See also

Other CBD Substitutions Functions:
[`cbbd_substitutions_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_game.md),
[`cbbd_substitutions_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_team.md)

## Examples

``` r
# \donttest{
  try(cbbd_substitutions_player(player_id = 160, season = 2024))
#> ✖ 2026-06-09 19:58:34.705689: Invalid arguments or no substitution data available for player 160!
#> ✖ Args: player_id = 160, season = 2024
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
