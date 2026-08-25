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

|              |           |                             |
|--------------|-----------|-----------------------------|
| col_name     | types     | description                 |
| game_number  | integer   | Game number.                |
| date         | character | Date in YYYY-MM-DD format.  |
| time_et      | character | Time et.                    |
| game         | character | Game.                       |
| location     | character | Location.                   |
| venue        | character | Venue name.                 |
| conference   | character | Conference.                 |
| thrill_score | numeric   | Thrill score.               |
| referee_name | character | Referee name.               |
| ref_rank     | numeric   | League/season rank for ref. |
| year         | numeric   | 4-digit year.               |

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
#> ✖ 2026-08-25 01:42:48.616701: Invalid arguments or no referee data for 714363 in 2021 available!
#> ✖ Args: referee = 714363, year = 2021
#> ✖ Error: HTTP 429 Too Many Requests.
#> NULL
# }
```
