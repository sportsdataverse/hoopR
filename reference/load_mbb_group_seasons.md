# **Load conference and division names by season (MBB / NBA) from the data repo**

Loads one row per group per season it existed, with the group's name,
short name, abbreviation, and parent group **as of that season** rather
than today's labels, plus its member count. `load_mbb_group_seasons()`
reads the `mbb_groups` release tag and `load_nba_group_seasons()` the
`nba_groups` tag.

## Usage

``` r
load_mbb_group_seasons(..., dbConnection = NULL, tablename = NULL)

load_nba_group_seasons(..., dbConnection = NULL, tablename = NULL)
```

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

Returns a `hoopR_data` tibble with one row per group-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| group_id | character | SDV group id, `{league}:{slug}`. |
| season | integer | Season (ending year; 2025 = 2024-25). |
| level | character | Group level: `league`, `subdivision`, `conference`, or `division`. |
| name | character | Group name as of that season. |
| short_name | character | Group short name as of that season. |
| abbreviation | character | Group abbreviation as of that season. |
| parent_group_id | character | Parent group id as of that season (division to conference to subdivision or league). |
| n_teams | integer | Number of member teams that season. |

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md),
[`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md),
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_group_seasons())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 1,025 × 9
#>    league group_id season level    name  short_name abbreviation parent_group_id
#>    <chr>  <chr>     <int> <chr>    <chr> <chr>      <chr>        <chr>          
#>  1 mbb    mbb:acc    2002 confere… Atla… ACC        ACC          mbb:d1         
#>  2 mbb    mbb:acc    2003 confere… Atla… ACC        ACC          mbb:d1         
#>  3 mbb    mbb:acc    2004 confere… Atla… ACC        ACC          mbb:d1         
#>  4 mbb    mbb:acc    2005 confere… Atla… ACC        ACC          mbb:d1         
#>  5 mbb    mbb:acc    2006 confere… Atla… ACC        ACC          mbb:d1         
#>  6 mbb    mbb:acc    2007 confere… Atla… ACC        ACC          mbb:d1         
#>  7 mbb    mbb:acc    2008 confere… Atla… ACC        ACC          mbb:d1         
#>  8 mbb    mbb:acc    2009 confere… Atla… ACC        ACC          mbb:d1         
#>  9 mbb    mbb:acc    2010 confere… Atla… ACC        ACC          mbb:d1         
#> 10 mbb    mbb:acc    2011 confere… Atla… ACC        ACC          mbb:d1         
#> # ℹ 1,015 more rows
#> # ℹ 1 more variable: n_teams <int>
# }
# \donttest{
  try(load_nba_group_seasons())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 445 × 9
#>    league group_id    season level name  short_name abbreviation parent_group_id
#>    <chr>  <chr>        <int> <chr> <chr> <chr>      <chr>        <chr>          
#>  1 nba    nba:atlant…   1971 divi… Atla… Atlantic   AT           nba:east       
#>  2 nba    nba:atlant…   1972 divi… Atla… Atlantic   AT           nba:east       
#>  3 nba    nba:atlant…   1973 divi… Atla… Atlantic   AT           nba:east       
#>  4 nba    nba:atlant…   1974 divi… Atla… Atlantic   AT           nba:east       
#>  5 nba    nba:atlant…   1975 divi… Atla… Atlantic   AT           nba:east       
#>  6 nba    nba:atlant…   1976 divi… Atla… Atlantic   AT           nba:east       
#>  7 nba    nba:atlant…   1977 divi… Atla… Atlantic   AT           nba:east       
#>  8 nba    nba:atlant…   1978 divi… Atla… Atlantic   AT           nba:east       
#>  9 nba    nba:atlant…   1979 divi… Atla… Atlantic   AT           nba:east       
#> 10 nba    nba:atlant…   1980 divi… Atla… Atlantic   AT           nba:east       
#> # ℹ 435 more rows
#> # ℹ 1 more variable: n_teams <int>
# }
```
