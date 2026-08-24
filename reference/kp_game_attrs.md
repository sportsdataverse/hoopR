# **Get Game Attributes**

**Get Game Attributes**

## Usage

``` r
kp_game_attrs(year = most_recent_mbb_season(), attr = "Excitement")
```

## Arguments

- year:

  Year of data to pull

- attr:

  Game Attribute, valid values include:  
  'Excitement', 'Tension','Dominance','MinWp','FanMatch',  
  'Upsets','Busts','Comeback','Window'

## Value

Returns a tibble with game attributes

|            |           |               |
|------------|-----------|---------------|
| col_name   | types     | description   |
| rk         | integer   | Rk.           |
| data       | character | Data.         |
| game       | character | Game.         |
| location   | character | Location.     |
| conf       | character | character.    |
| excitement | numeric   | Excitement.   |
| year       | numeric   | 4-digit year. |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_game_attrs(year = 2021, attr = "Excitement"))
#> ✖ 2026-08-24 20:40:58.283688: Invalid arguments or no game attributes data for Excitement available!
#> ✖ Args: year = 2021, attr = "Excitement"
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
