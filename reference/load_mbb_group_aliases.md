# **Load conference and division aliases (MBB / NBA) from the data repo**

Loads every name and id that a source (ESPN, NCAA, KenPom, NBA Stats,
SDV) uses for a group, with the seasons each alias is valid for. Use it
to map a source's conference id or name onto an SDV `group_id`.
`load_mbb_group_aliases()` reads the `mbb_groups` release tag and
`load_nba_group_aliases()` the `nba_groups` tag.

## Usage

``` r
load_mbb_group_aliases(..., dbConnection = NULL, tablename = NULL)

load_nba_group_aliases(..., dbConnection = NULL, tablename = NULL)
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

Returns a `hoopR_data` tibble with one row per alias.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| group_id | character | SDV group id, `{league}:{slug}`. |
| source | character | Source that uses the alias: `espn`, `ncaa`, `kenpom` or `sdv` (MBB); `espn`, `nba_stats` or `sdv` (NBA). |
| source_id | character | The source's own id for the group (e.g. ESPN group id, NCAA conference id), when it has one. |
| name_kind | character | Kind of alias: `name`, `short_name`, `abbreviation`, `slug`, or `code`. |
| value | character | The alias itself. |
| valid_from | integer | First season (ending year) the alias applies, inclusive; `NA` means unbounded. |
| valid_to | integer | Last season (ending year) the alias applies, inclusive; `NA` means unbounded. |

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md),
[`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md),
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_group_aliases())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 467 × 8
#>    league group_id         source source_id name_kind  value valid_from valid_to
#>    <chr>  <chr>            <chr>  <chr>     <chr>      <chr>      <int>    <int>
#>  1 mbb    mbb:acc          espn   2         abbreviat… acc         2002     2027
#>  2 mbb    mbb:acc          espn   2         name       Atla…       2002     2027
#>  3 mbb    mbb:acc          espn   2         short_name ACC         2002     2027
#>  4 mbb    mbb:acc          espn   2         slug       atla…       2002     2027
#>  5 mbb    mbb:acc          kenpom NA        code       ACC         2002     2026
#>  6 mbb    mbb:acc          ncaa   821       short_name ACC         2018     2026
#>  7 mbb    mbb:acc          sdv    NA        abbreviat… ACC           NA       NA
#>  8 mbb    mbb:acc          sdv    NA        name       Atla…         NA       NA
#>  9 mbb    mbb:acc          sdv    NA        short_name ACC           NA       NA
#> 10 mbb    mbb:america-east espn   1         abbreviat… aeast       2002     2027
#> # ℹ 457 more rows
# }
# \donttest{
  try(load_nba_group_aliases())
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 66 × 8
#>    league group_id     source    source_id name_kind   value valid_from valid_to
#>    <chr>  <chr>        <chr>     <chr>     <chr>       <chr>      <int>    <int>
#>  1 nba    nba:atlantic espn      1         abbreviati… AT          1985       NA
#>  2 nba    nba:atlantic espn      1         name        Atla…       1985       NA
#>  3 nba    nba:atlantic espn      1         slug        atla…       1985       NA
#>  4 nba    nba:atlantic nba_stats NA        name        Atla…       1997       NA
#>  5 nba    nba:atlantic sdv       NA        abbreviati… AT          1971       NA
#>  6 nba    nba:atlantic sdv       NA        name        Atla…       1971       NA
#>  7 nba    nba:atlantic sdv       NA        short_name  Atla…       1971       NA
#>  8 nba    nba:central  espn      2         abbreviati… CE          1985       NA
#>  9 nba    nba:central  espn      2         name        Cent…       1985       NA
#> 10 nba    nba:central  espn      2         slug        cent…       1985       NA
#> # ℹ 56 more rows
# }
```
