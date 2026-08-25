# **Get KPoY Leaders Tables**

**Get KPoY Leaders Tables**

## Usage

``` r
kp_kpoy(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year of data to pull (earliest year of data available: 2011)

## Value

Returns a list of tibbles: "kPoYRatings", "GameMVPs"

**KPoYRatings**

|             |           |                                                |
|-------------|-----------|------------------------------------------------|
| col_name    | types     | description                                    |
| rk          | integer   | Rk.                                            |
| player      | character | Player.                                        |
| kpoy_rating | numeric   | Kpoy rating.                                   |
| team        | character | Team-side label or team identifier.            |
| hgt         | character | Hgt.                                           |
| wgt         | numeric   | Wgt.                                           |
| exp         | character | Exp.                                           |
| home_town   | character | Home team's town.                              |
| year        | numeric   | 4-digit year.                                  |
| group       | character | Group identifier (e.g. conference 'group_id'). |

**GameMVPs**

|            |           |                                                |
|------------|-----------|------------------------------------------------|
| col_name   | types     | description                                    |
| rk         | numeric   | Rk.                                            |
| player     | character | Player.                                        |
| game_mv_ps | numeric   | Game mv ps.                                    |
| team       | character | Team-side label or team identifier.            |
| hgt        | character | Hgt.                                           |
| wgt        | numeric   | Wgt.                                           |
| exp        | character | Exp.                                           |
| home_town  | character | Home team's town.                              |
| year       | numeric   | 4-digit year.                                  |
| group      | character | Group identifier (e.g. conference 'group_id'). |

## See also

Other KenPom Ratings Functions:
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md)

## Examples

``` r
# \donttest{
try(kp_kpoy(year = 2026))
#> ✖ 2026-08-25 01:42:46.581476: Invalid arguments or no KenPom player of the year data for 2026 available!
#> ✖ Args: year = 2026
#> ✖ Error: HTTP 403 Forbidden.
#> NULL
# }
```
