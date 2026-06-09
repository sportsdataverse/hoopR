# **CBD Plays by Player**

**Get play-by-play data for a single player from the
CollegeBasketballData API.**

## Usage

``` r
cbbd_plays_player(
  player_id,
  season = most_recent_mbb_season(),
  shooting_plays_only = FALSE
)
```

## Arguments

- player_id:

  (*integer* required): Athlete id.

- season:

  (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- shooting_plays_only:

  (*logical* optional): If `TRUE`, return only shooting plays. Defaults
  to `FALSE`.

## Value

A `hoopR_data` tibble with one row per play (same columns as
[`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md)).

## See also

Other CBD Plays Functions:
[`cbbd_play_types()`](https://hoopR.sportsdataverse.org/reference/cbbd_play_types.md),
[`cbbd_plays_date()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_date.md),
[`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md),
[`cbbd_plays_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_team.md),
[`cbbd_plays_tournament()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_tournament.md)

## Examples

``` r
# \donttest{
  try(cbbd_plays_player(player_id = 160, season = 2024))
#> ✖ 2026-06-09 16:51:48.791411: Invalid arguments or no play data available for player 160!
#> ✖ Args: player_id = 160, season = 2024, shooting_plays_only = FALSE
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
