# **Get referee game log**

**Get referee game log**

## Usage

``` r
kp_referee(referee, year)
```

## Arguments

- referee:

  Referee ID

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|              |           |
|--------------|-----------|
| col_name     | types     |
| game_number  | integer   |
| date         | character |
| time_et      | character |
| game         | character |
| location     | character |
| venue        | character |
| conference   | character |
| thrill_score | numeric   |
| referee_name | character |
| ref_rank     | numeric   |
| year         | numeric   |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_referee(referee = 714363, year = 2021))
#> 2026-03-26 14:51:22.429159: Invalid arguments or no referee data for 714363 in 2021 available!
#> Error in kp_referee(referee = 714363, year = 2021) : 
#>   object 'kenpom' not found
# }
```
