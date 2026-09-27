# **Load conference and division lineages (MBB / NBA) from the data repo**

Loads one row per group lineage – the league or subdivision, each
conference, and each division – with the first and last season each had
at least one member. A lineage keeps one `group_id` across renames that
keep continuity (American Athletic to American stays `mbb:american`); a
new body gets a new id. `load_mbb_groups()` reads the `mbb_groups`
release tag and `load_nba_groups()` the `nba_groups` tag.

See
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md)
for per-season names and parents,
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md)
for the names and ids other sources use, and
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)
for team membership.

## Usage

``` r
load_mbb_groups(..., dbConnection = NULL, tablename = NULL)

load_nba_groups(..., dbConnection = NULL, tablename = NULL)
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

Returns a `hoopR_data` tibble with one row per group lineage.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| group_id | character | SDV group id, `{league}:{slug}` (e.g. `mbb:big-east`, `nba:atlantic`); one id per lineage across renames. |
| level | character | Group level: `league` (NBA), `subdivision` (MBB Division I), `conference`, or `division`. |
| first_season | integer | First season (ending year) with at least one member. |
| last_season | integer | Last season (ending year) with at least one member. |
| notes | character | Lineage decisions and source caveats. |

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md),
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md),
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_groups())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 64 × 6
#>    league group_id             level      first_season last_season notes        
#>    <chr>  <chr>                <chr>             <int>       <int> <chr>        
#>  1 mbb    mbb:acc              conference         2002        2027 NA           
#>  2 mbb    mbb:america-east     conference         2002        2027 NA           
#>  3 mbb    mbb:american         conference         2014        2027 New body in …
#>  4 mbb    mbb:asun             conference         2002        2027 Trans Americ…
#>  5 mbb    mbb:asun-east        division           2022        2022 ESPN divisio…
#>  6 mbb    mbb:asun-west        division           2022        2022 ESPN divisio…
#>  7 mbb    mbb:atlantic-10      conference         2002        2027 NA           
#>  8 mbb    mbb:atlantic-10-east division           2002        2005 ESPN divisio…
#>  9 mbb    mbb:atlantic-10-west division           2002        2005 ESPN divisio…
#> 10 mbb    mbb:big-12           conference         2002        2027 NA           
#> # ℹ 54 more rows
# }
# \donttest{
  try(load_nba_groups())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 10 × 6
#>    league group_id      level      first_season last_season notes               
#>    <chr>  <chr>         <chr>             <int>       <int> <chr>               
#>  1 nba    nba:atlantic  division           1971        2027 One lineage 1970-71…
#>  2 nba    nba:central   division           1971        2027 One lineage 1970-71…
#>  3 nba    nba:east      conference         1971        2027 stats.nba.com says …
#>  4 nba    nba:midwest   division           1971        2004 Dissolved in the 20…
#>  5 nba    nba:nba       league             1971        2027 SDV coverage starts…
#>  6 nba    nba:northwest division           2005        2027 New in 2004-05.     
#>  7 nba    nba:pacific   division           1971        2027 One lineage 1970-71…
#>  8 nba    nba:southeast division           2005        2027 New in 2004-05. ESP…
#>  9 nba    nba:southwest division           2005        2027 New in 2004-05.     
#> 10 nba    nba:west      conference         1971        2027 stats.nba.com says …
# }
```
