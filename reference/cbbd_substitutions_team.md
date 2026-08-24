# **CBD Substitutions by Team**

**Get substitution data for a team-season from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_substitutions_team(season = most_recent_mbb_season(), team)
```

## Arguments

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* required): Team name (e.g. `Duke`).

## Value

A `hoopR_data` tibble with one row per substitution (same columns as
[`cbbd_substitutions_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_game.md)).

## See also

Other CBD Substitutions Functions:
[`cbbd_substitutions_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_game.md),
[`cbbd_substitutions_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_player.md)

## Examples

``` r
# \donttest{
  try(cbbd_substitutions_team(season = 2024, team = "Duke"))
#> ✖ 2026-08-24 20:39:08.723367: Invalid arguments or no substitution data available for Duke!
#> ✖ Args: season = 2024, team = "Duke"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
