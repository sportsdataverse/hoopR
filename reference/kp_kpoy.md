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

|             |           |
|-------------|-----------|
| col_name    | types     |
| rk          | integer   |
| player      | character |
| kpoy_rating | numeric   |
| team        | character |
| hgt         | character |
| wgt         | numeric   |
| exp         | character |
| home_town   | character |
| year        | numeric   |
| group       | character |

**GameMVPs**

|            |           |
|------------|-----------|
| col_name   | types     |
| rk         | numeric   |
| player     | character |
| game_mv_ps | numeric   |
| team       | character |
| hgt        | character |
| wgt        | numeric   |
| exp        | character |
| home_town  | character |
| year       | numeric   |
| group      | character |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
  try(kp_kpoy(year=2021))
#> Error in kp_kpoy(year = 2021) : object 'kenpom' not found
# }
```
