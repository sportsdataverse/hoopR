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
try(kp_kpoy(year = 2026))
#> $KPoYRatings
#>    rk            player kpoy_rating          team hgt wgt exp        home_town
#> 1   1    Cameron Boozer       2.951          Duke 6-9 250  Fr        Miami, FL
#> 2   2  Joshua Jefferson       1.758      Iowa St. 6-9 240  Sr    Las Vegas, NV
#> 3   3   Yaxel Lendeborg       1.690      Michigan 6-9 240  Sr   Pennsauken, NJ
#> 4   4 Kingston Flemings       1.685       Houston 6-4 190  Fr  San Antonio, TX
#> 5   5     Keaton Wagler       1.642      Illinois 6-6 185  Fr      Shawnee, KS
#> 6   6       AJ Dybantsa       1.596           BYU 6-9 212  Fr     Brockton, MA
#> 7   7      Jeremy Fears       1.563  Michigan St. 6-2 190  So       Joliet, IL
#> 8   8      Zuby Ejiofor       1.556    St. John's 6-9 245  Sr      Garland, TX
#> 9   9      Braden Smith       1.503        Purdue 6-0 170  Sr    Westfield, IN
#> 10 10      Tyler Tanner       1.502    Vanderbilt 6-0 173  So    Brentwood, TN
#>    year       group
#> 1  2026 kPoY Rating
#> 2  2026 kPoY Rating
#> 3  2026 kPoY Rating
#> 4  2026 kPoY Rating
#> 5  2026 kPoY Rating
#> 6  2026 kPoY Rating
#> 7  2026 kPoY Rating
#> 8  2026 kPoY Rating
#> 9  2026 kPoY Rating
#> 10 2026 kPoY Rating
#> 
#> $GameMVPs
#>    rk            player game_mv_ps               team  hgt wgt exp
#> 1   1    Cameron Boozer         25               Duke  6-9 250  Fr
#> 2   2      Zuby Ejiofor         18         St. John's  6-9 245  Sr
#> 3   2 Kingston Flemings         18            Houston  6-4 190  Fr
#> 4   4   Nick Martinelli         16       Northwestern  6-7 225  Sr
#> 5   4      Tyler Tanner         16         Vanderbilt  6-0 173  So
#> 6   4      Ebuka Okorie         16           Stanford  6-2 185  Fr
#> 7   7    Bennett Stirtz         15               Iowa  6-4 190  Sr
#> 8   8        Graham Ike         14            Gonzaga  6-9 250  Sr
#> 9   8     Camren Hunter         14   Central Arkansas  6-3 205  Sr
#> 10  8     Keon Thompson         14  Stephen F. Austin  6-1 200  Sr
#> 11  8       Tarris Reed         14        Connecticut 6-11 265  Sr
#> 12  8    Bruce Thornton         14           Ohio St.  6-2 215  Sr
#> 13  8        Gavin Doty         14              Siena  6-5 190  So
#>            home_town year            group
#> 1          Miami, FL 2026 Game MVP Leaders
#> 2        Garland, TX 2026 Game MVP Leaders
#> 3    San Antonio, TX 2026 Game MVP Leaders
#> 4       Glenview, IL 2026 Game MVP Leaders
#> 5      Brentwood, TN 2026 Game MVP Leaders
#> 6         Nashua, NH 2026 Game MVP Leaders
#> 7        Liberty, MO 2026 Game MVP Leaders
#> 8         Aurora, CO 2026 Game MVP Leaders
#> 9         Bryant, AR 2026 Game MVP Leaders
#> 10  Merrillville, IN 2026 Game MVP Leaders
#> 11     St. Louis, MO 2026 Game MVP Leaders
#> 12      Fairburn, GA 2026 Game MVP Leaders
#> 13        Fulton, NY 2026 Game MVP Leaders
#> 
# }
```
