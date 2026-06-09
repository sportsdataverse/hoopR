# **CBD Play Types**

**Get the list of play types from the CollegeBasketballData API.**

## Usage

``` r
cbbd_play_types()
```

## Value

A `hoopR_data` tibble with one row per play type:

|          |           |                 |
|----------|-----------|-----------------|
| col_name | types     | description     |
| id       | integer   | Play type id.   |
| name     | character | Play type name. |

## See also

Other CBD Plays Functions:
[`cbbd_plays_date()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_date.md),
[`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md),
[`cbbd_plays_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_player.md),
[`cbbd_plays_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_team.md),
[`cbbd_plays_tournament()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_tournament.md)

## Examples

``` r
# \donttest{
  try(cbbd_play_types())
#> ✖ 2026-06-09 19:07:02.753627: Invalid arguments or no play types available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
