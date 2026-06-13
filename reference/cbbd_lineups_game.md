# **CBD Game Lineups**

**Get lineup statistics for a single game from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_lineups_game(game_id)
```

## Arguments

- game_id:

  (*integer* required): CollegeBasketballData game id. See
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md).

## Value

A `hoopR_data` tibble with one row per lineup (same columns as
[`cbbd_lineups_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_lineups_team.md)).

## See also

Other CBD Lineups Functions:
[`cbbd_lineups_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_lineups_team.md)

## Examples

``` r
# \donttest{
  try(cbbd_lineups_game(game_id = 5881))
#> ✖ 2026-06-13 02:22:16.563193: Invalid arguments or no lineup data available for 5881!
#> ✖ Args: game_id = 5881
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
