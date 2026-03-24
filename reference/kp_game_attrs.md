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

|            |           |
|------------|-----------|
| col_name   | types     |
| rk         | integer   |
| data       | character |
| game       | character |
| location   | character |
| conf       | character |
| excitement | numeric   |
| year       | numeric   |

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
#> 2026-03-24 01:20:56.241534: Invalid arguments or no game attributes data for Excitement available!
#> Error in kp_game_attrs(year = 2021, attr = "Excitement") : 
#>   object 'kenpom' not found
# }
```
