# **Get men's college basketball AP and Coaches Poll rankings from ESPN**

**Get men's college basketball AP and Coaches Poll rankings from ESPN**

## Usage

``` r
espn_mbb_rankings()
```

## Value

A `hoopR_data` tibble with one row per ranked team.

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | integer | Id. |
| name | character | Display name. |
| short_name | character | Short display name. |
| type | character | Record type / category. |
| headline | character | News headline. |
| short_headline | character | Short news headline. |
| current | integer | Current. |
| previous | integer | Previous. |
| points | numeric | Points scored. |
| first_place_votes | integer | First place votes. |
| trend | character | Trend. |
| date | character | Date in YYYY-MM-DD format. |
| last_updated | character | Last updated. |
| record_summary | character | Win-loss record summary string. |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_nickname | character | Team nickname. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| occurrence_number | integer | Occurrence number. |
| occurrence_type | character | Occurrence type. |
| occurrence_last | logical | Occurrence last. |
| occurrence_value | character | Occurrence value. |
| occurrence_display_value | character | Occurrence display value. |
| season_year | integer | Season year string ('YYYY-YY' format). |
| season_start_date | character | Date in YYYY-MM-DD format. |
| season_end_date | character | Date in YYYY-MM-DD format. |
| season_display_name | character | Season display label. |
| season_type_type | integer | Season type type. |
| season_type_name | character | Season type name. |
| season_type_abbreviation | character | Season type abbreviation. |
| season_futures_ref | character | Season futures ref. |
| first_occurrence_type | character | First occurrence type. |
| first_occurrence_value | character | First occurrence value. |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# Get current AP and Coaches Poll rankings
# \donttest{
try(espn_mbb_rankings())
#> ── ESPN MBB Rankings Information from ESPN.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:31 UTC
#> # A tibble: 84 × 38
#>       id name   short_name type  headline short_headline current previous points
#>    <int> <chr>  <chr>      <chr> <chr>    <chr>            <int>    <int>  <dbl>
#>  1     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        1        1   1490
#>  2     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        2        2   1432
#>  3     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        3        3   1366
#>  4     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        4        4   1339
#>  5     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        5        6   1222
#>  6     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        6        9   1161
#>  7     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        7        7   1092
#>  8     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        8       10    947
#>  9     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2        9       22    925
#> 10     1 AP To… AP Poll    ap    2027 NC… 2027 : Week 2       10       11    901
#> # ℹ 74 more rows
#> # ℹ 29 more variables: first_place_votes <int>, trend <chr>, date <chr>,
#> #   last_updated <chr>, record_summary <chr>, team_id <int>, team_uid <chr>,
#> #   team_location <chr>, team_name <chr>, team_nickname <chr>,
#> #   team_abbreviation <chr>, team_color <chr>, team_logos <list>,
#> #   team_logo <chr>, occurrence_number <int>, occurrence_type <chr>,
#> #   occurrence_last <lgl>, occurrence_value <chr>, …
# }
```
