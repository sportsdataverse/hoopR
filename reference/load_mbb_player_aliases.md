# **Load provider player id aliases (MBB / NBA) from the data repo**

Loads every player id another source uses for an ESPN athlete, with the
ESPN team the athlete was on and the seasons the id held. Use it to map
an NCAA (stats.ncaa.org), Fox, Yahoo, KenPom or NBA Stats player id onto
the ESPN `athlete_id`. stats.ncaa.org roster ids are new every season,
so an NCAA player has one row per season. Unmatched provider ids are not
included. `load_mbb_player_aliases()` reads the `mbb_groups` release tag
and `load_nba_player_aliases()` the `nba_groups` tag.

See
[`load_mbb_team_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_aliases.md)
for team ids and names.

## Usage

``` r
load_mbb_player_aliases(..., dbConnection = NULL, tablename = NULL)

load_nba_player_aliases(..., dbConnection = NULL, tablename = NULL)
```

## Source

The `mbb_groups` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/mbb_groups>.

The `nba_groups` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_groups>.

## Arguments

- ...:

  Additional arguments passed to an underlying function that writes the
  data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per player alias.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| athlete_id | character | ESPN athlete id. |
| athlete_id_source | character | Id system of `athlete_id`: `espn`. |
| source | character | Source of the player id: `ncaa`, `fox`, `yahoo` or `kenpom` (MBB); `nba_stats`, `fox` or `yahoo` (NBA). |
| source_player_id | character | The source's own player id (e.g. `nba.p.5637`, `76284`). |
| team_id | character | ESPN team id of the team the athlete was on when matched. |
| source_team_id | character | The source's own team id when it gives one (the season's stats.ncaa.org team id), else `NA`. |
| valid_from | integer | First season (ending year) the id is on that team, inclusive. |
| valid_to | integer | Last season (ending year) the id is on that team, inclusive; a gap or a change of match method splits the window into two rows. |
| match_method | character | How the id was matched: the source leg's own method (`exact_name`, `fuzzy_jw`; NCAA `name_jersey`, `name`, `last_jersey`, `jaro_winkler`), `crosswalk` (a leg that names none), `propagated` (carried from the same id's match in another season) or `override` (a hand-verified fix). |
| match_confidence | numeric | The leg's own confidence where it gives one (the lowest in the window; NCAA tiers score 1, 0.95, 0.9 and 0.85), else `NA`. |
| evidence | character | The asset or file the row came from. |

`NULL` instead, after appending the rows to `tablename`, when
`dbConnection` and `tablename` are both given.

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md),
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md),
[`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md),
[`load_mbb_team_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_aliases.md),
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_player_aliases())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 110,539 × 12
#>    league athlete_id athlete_id_source source source_player_id team_id
#>    <chr>  <chr>      <chr>             <chr>  <chr>            <chr>  
#>  1 mbb    11145      espn              ncaa   3356339          77     
#>  2 mbb    11145      espn              ncaa   3606159          77     
#>  3 mbb    12906      espn              ncaa   4166126          2110   
#>  4 mbb    12906      espn              ncaa   4392863          2110   
#>  5 mbb    17852      espn              ncaa   4997749          2612   
#>  6 mbb    2229314    espn              ncaa   3839672          16     
#>  7 mbb    2229314    espn              ncaa   4343020          16     
#>  8 mbb    2229314    espn              ncaa   4688539          16     
#>  9 mbb    2229314    espn              ncaa   4885139          16     
#> 10 mbb    22308      espn              ncaa   3353864          328    
#> # ℹ 110,529 more rows
#> # ℹ 6 more variables: source_team_id <chr>, valid_from <int>, valid_to <int>,
#> #   match_method <chr>, match_confidence <dbl>, evidence <chr>
# }
# \donttest{
  try(load_nba_player_aliases())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 19,875 × 12
#>    league athlete_id athlete_id_source source    source_player_id team_id
#>    <chr>  <chr>      <chr>             <chr>     <chr>            <chr>  
#>  1 nba    10         espn              fox       1010             14     
#>  2 nba    10         espn              fox       1010             30     
#>  3 nba    10         espn              fox       1010             4      
#>  4 nba    10         espn              fox       1010             17     
#>  5 nba    10         espn              fox       1010             6      
#>  6 nba    10         espn              fox       1010             15     
#>  7 nba    10         espn              fox       1010             7      
#>  8 nba    10         espn              fox       1010             19     
#>  9 nba    10         espn              nba_stats 2124             14     
#> 10 nba    10         espn              nba_stats 2124             30     
#> # ℹ 19,865 more rows
#> # ℹ 6 more variables: source_team_id <chr>, valid_from <int>, valid_to <int>,
#> #   match_method <chr>, match_confidence <dbl>, evidence <chr>
# }
```
