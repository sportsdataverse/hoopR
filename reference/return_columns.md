# **Return Columns of hoopR Functions**

The columns of every data frame a hoopR function returns: one row per
column, with its type and description, for 979 functions. Most functions
outside the NBA and men's college basketball families list their columns
here rather than in their help page; the NBA and MBB functions show the
same table in their help page too. Built by `data-raw/return_columns.R`
from `data-raw/return_columns.csv`, the file every `@return` column
table is generated from. The same table is searchable in the [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Usage

``` r
return_columns
```

## Format

A data frame with 28,634 rows (one per returned column) and 5 variables:

|  |  |  |
|----|----|----|
| col_name | type | description |
| `fn` | character | Function name. |
| `component` | character | Element of the returned named list the column belongs to (`PlayerStats`, `TeamStats`, ...), or the argument value that selects the table (`kind = "streaks"`); `NA` when the function returns a single data frame. |
| `col_name` | character | Column name. |
| `type` | character | Column type (`character`, `integer`, `numeric`, ...); `NA` when the source table gave none. |
| `description` | character | What the column holds; `NA` when the source table gave none. Inline code is in backticks. |

## Source

The `@return` sections of the hoopR help pages, and the APIs they
document: <https://www.nba.com/stats/>, ESPN, KenPom and the other
sources the functions wrap.

## Examples

``` r
head(subset(return_columns, fn == "nba_boxscoretraditionalv3"))
#> # A tibble: 6 × 5
#>   fn                        component                 col_name type  description
#>   <chr>                     <chr>                     <chr>    <chr> <chr>      
#> 1 nba_boxscoretraditionalv3 home_team_player_traditi… game_id  char… Unique gam…
#> 2 nba_boxscoretraditionalv3 home_team_player_traditi… away_te… inte… Unique ide…
#> 3 nba_boxscoretraditionalv3 home_team_player_traditi… home_te… inte… Unique ide…
#> 4 nba_boxscoretraditionalv3 home_team_player_traditi… team_id  inte… Unique tea…
#> 5 nba_boxscoretraditionalv3 home_team_player_traditi… team_na… char… Full team …
#> 6 nba_boxscoretraditionalv3 home_team_player_traditi… team_ci… char… Team city …
```
