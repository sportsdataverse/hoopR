# **Get ESPN conference names and IDs**

**Get ESPN conference names and IDs**

**Get ESPN NBA Conferences**

**Get ESPN NBA Conferences**

## Usage

``` r
espn_mbb_conferences()

espn_nba_conferences()
```

## Value

A `hoopR_data` tibble with one row per conference.

|  |  |  |
|----|----|----|
| col_name | types | description |
| group_id | integer | Group identifier (e.g. conference group_id). |
| conference_short_name | character | Conference short name (e.g. 'ACC'). |
| conference_uid | character | ESPN universal conference identifier. |
| conference_name | character | Full conference name. |
| conference_logo | character | Logo image URL for conference. |
| parent_group_id | integer | Unique identifier for parent group. |
| conference_id | integer | Conference identifier. |

A `hoopR_data` tibble with one row per conference.

|  |  |  |
|----|----|----|
| col_name | types | description |
| group_id | integer | Group identifier (e.g. conference group_id). |
| conference_short_name | character | Conference short name (e.g. 'ACC'). |
| conference_uid | character | ESPN universal conference identifier. |
| conference_name | character | Full conference name. |
| conference_logo | character | Logo image URL for conference. |
| parent_group_id | integer | Unique identifier for parent group. |
| conference_id | integer | Conference identifier. |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_conferences())
#> ── ESPN MBB Conferences Information from ESPN.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:01 UTC
#> # A tibble: 32 × 7
#>    group_id conference_name conference_short_name conference_uid conference_logo
#>       <int> <chr>           <chr>                 <chr>          <chr>          
#>  1        3 Atlantic 10 Co… A-10                  s:40~l:41~g:3  https://a.espn…
#>  2        2 Atlantic Coast… ACC                   s:40~l:41~g:2  https://a.espn…
#>  3        1 America East C… Am. East              s:40~l:41~g:1  https://a.espn…
#>  4       62 American Confe… American              s:40~l:41~g:62 NA             
#>  5       46 Atlantic Sun C… Atlantic Sun          s:40~l:41~g:46 https://a.espn…
#>  6        8 Big 12 Confere… Big 12                s:40~l:41~g:8  https://a.espn…
#>  7        4 Big East Confe… Big East              s:40~l:41~g:4  https://a.espn…
#>  8        5 Big Sky Confer… Big Sky               s:40~l:41~g:5  https://a.espn…
#>  9        6 Big South Conf… Big South             s:40~l:41~g:6  https://a.espn…
#> 10        7 Big Ten Confer… Big Ten               s:40~l:41~g:7  https://a.espn…
#> # ℹ 22 more rows
#> # ℹ 2 more variables: parent_group_id <int>, conference_id <int>
# }
# \donttest{
  try(espn_nba_conferences())
#> ✖ 2026-11-09 21:12:01.988578: Invalid arguments or no conferences info available!
#> ✖ Error: `select()` doesn't handle lists.
#> ── ESPN NBA Conferences Information from ESPN.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:01 UTC
#> # A tibble: 0 × 7
#> # ℹ 7 variables: group_id <chr>, conference_short_name <chr>,
#> #   conference_uid <chr>, conference_name <chr>, conference_logo <chr>,
#> #   parent_group_id <chr>, conference_id <chr>
# }
```
