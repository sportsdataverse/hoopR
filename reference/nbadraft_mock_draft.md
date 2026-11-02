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

A `hoopR_data` tibble with one row per mock-draft pick:

|          |           |                                                   |
|----------|-----------|---------------------------------------------------|
| col_name | types     | description                                       |
| round    | integer   | Draft round (1 or 2).                             |
| pick     | integer   | Pick number within the round.                     |
| team     | character | Projected team (`*` traded-pick marker stripped). |
| player   | character | Projected player.                                 |
| height   | character | Player height.                                    |
| weight   | character | Player weight.                                    |
| position | character | Player position.                                  |
| school   | character | Player school / pre-draft team.                   |
| class    | character | Player class / draft eligibility.                 |

## See also

Other Salary & Draft Functions:
[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(nbadraft_mock_draft())
#> ── Mock draft from nbadraft.net ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:55:40 UTC
#> # A tibble: 60 × 9
#>     pick team        player            height weight position school class round
#>    <int> <chr>       <chr>             <chr>   <int> <chr>    <chr>  <chr> <int>
#>  1     1 Washington  Alijah Arenas     6-6       195 SG       USC    So.       1
#>  2     2 Indiana     Jason Crowe       6-4       190 PG       Misso… Fr.       1
#>  3     3 Brooklyn    Jordan Smith      6-2       205 PG/SG    Arkan… Fr.       1
#>  4     4 Utah        Kanon Catchings   6-9       210 SF       Georg… Jr.       1
#>  5     5 Sacramento  Tyran Stokes      6-8       230 SG       Kansas Fr.       1
#>  6     6 Memphis     Stefan Joksimovic 6-4       190 SG       Slove… Intl.     1
#>  7     7 Dallas      Amari Allen       6-6       205 SG/SF    Alaba… So.       1
#>  8     8 New Orleans Davis Fogle       6-7       200 SG       Gonza… So.       1
#>  9     9 Chicago     Braylon Mullins   6-5       180 SG       UConn  So.       1
#> 10    10 Milwaukee   Caleb Holt        6-5       215 PG/SG    Arizo… Fr.       1
#> # ℹ 50 more rows
# }
```
