# **CBD Plays by Date**

**Get play-by-play data for all games on a date from the
CollegeBasketballData API.**

## Usage

``` r
cbbd_plays_date(date, shooting_plays_only = FALSE, utc_offset = NULL)
```

## Arguments

- date:

  (*character* required): Date-time in ISO 8601 format (e.g.
  `2024-02-01T00:00:00.000Z`).

- shooting_plays_only:

  (*logical* optional): If `TRUE`, return only shooting plays. Defaults
  to `FALSE`.

- utc_offset:

  (*numeric* optional): UTC offset (hours) for the date.

## Value

A `hoopR_data` tibble with one row per play (same columns as
[`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md)).

## See also

Other CBD Plays Functions:
[`cbbd_play_types()`](https://hoopR.sportsdataverse.org/reference/cbbd_play_types.md),
[`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md),
[`cbbd_plays_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_player.md),
[`cbbd_plays_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_team.md),
[`cbbd_plays_tournament()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_tournament.md)

## Examples

``` r
# \donttest{
  try(cbbd_plays_date(date = "2024-02-01T00:00:00.000Z"))
#> ✖ 2026-06-09 11:14:44.700941: Invalid arguments or no play data available for 2024-02-01T00:00:00.000Z!
#> ✖ Args: date = "2024-02-01T00:00:00.000Z", shooting_plays_only = FALSE, utc_offset = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
