# **NBADraft.net Mock Draft**

**Get the latest mock draft from
[NBADraft.net](https://www.nbadraft.net).**

Returns the current consensus mock draft (both rounds), one row per
pick. No API key is required.

## Usage

``` r
nbadraft_mock_draft(year = NULL)
```

## Arguments

- year:

  (*integer* optional): Draft year (e.g. `2025`). Defaults to the site's
  current mock; older years use the `/{year}/` path when available.

## Value

A `hoopR_data` tibble with one row per mock-draft pick. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbadraft_mock_draft")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Salary & Draft Functions:
[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(nbadraft_mock_draft())
#> ── Mock draft from nbadraft.net ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-26 22:42:36 UTC
#> # A tibble: 60 × 9
#>     pick team        player            height weight position school class round
#>    <int> <chr>       <chr>             <chr>   <int> <chr>    <chr>  <chr> <int>
#>  1     1 Milwaukee   Quentin Coleman   6-4       180 PG/SG    Illin… Fr.       1
#>  2     2 Sacramento  Alijah Arenas     6-6       195 SG       USC    So.       1
#>  3     3 Utah        Bruce Branch      6-7       195 SF       BYU    Fr.       1
#>  4     4 Brooklyn    Tyran Stokes      6-8       230 SF/PF    Kansas Fr.       1
#>  5     5 Charlotte   Jason Crowe       6-4       190 PG       Misso… Fr.       1
#>  6     6 LA Clippers Amari Allen       6-6       205 SG/SF    Alaba… So.       1
#>  7     7 New Orleans Stefan Joksimovic 6-4       190 SG       Slove… Intl.     1
#>  8     8 Indiana     Adonis Ratliff    6-11      215 PF       USC    Fr.       1
#>  9     9 Chicago     Braylon Mullins   6-5       180 SG       UConn  So.       1
#> 10    10 Toronto     Kanon Catchings   6-9       210 SF       Georg… Jr.       1
#> # ℹ 50 more rows
# }
```
