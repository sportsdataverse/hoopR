# **Get ESPN MBB Season Rankings Index**

Returns the index of season-level rankings recorded for one MBB season.
Typical sources: AP Top 25 (id 1), Coaches Poll (id 2). Pass an
`ranking_id` to
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md)
for the ranked teams.

Returns the index of season-level rankings recorded for one NBA season.
NBA + WNBA typically return zero rankings (ranking polls are a college
concept); the wrapper is provided for symmetry across leagues. For MBB /
WBB use the matching `espn_mbb_season_rankings()` /
`espn_wbb_season_rankings()`.

## Usage

``` r
espn_mbb_season_rankings(season = most_recent_mbb_season(), ...)

espn_nba_season_rankings(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per ranking source.

|            |           |                                    |
|------------|-----------|------------------------------------|
| col_name   | types     | description                        |
| league     | character | League slug.                       |
| season     | integer   | Season year.                       |
| ranking_id | character | ESPN ranking id.                   |
| ref        | character | `$ref` URL for the ranking detail. |

A `hoopR_data` tibble with one row per ranking source.

|            |           |                                    |
|------------|-----------|------------------------------------|
| col_name   | types     | description                        |
| league     | character | League slug.                       |
| season     | integer   | Season year.                       |
| ranking_id | character | ESPN ranking id.                   |
| ref        | character | `$ref` URL for the ranking detail. |

## Details

**Get ESPN MBB Season Rankings Index**

**Get ESPN NBA Season Rankings Index**

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
  espn_mbb_season_rankings(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Rankings Index ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:58 UTC
#> # A tibble: 2 × 4
#>   league                  season ranking_id ref                                 
#>   <chr>                    <int> <chr>      <chr>                               
#> 1 mens-college-basketball   2025 1          http://sports.core.api.espn.com/v2/…
#> 2 mens-college-basketball   2025 2          http://sports.core.api.espn.com/v2/…
# }
# \donttest{
  espn_nba_season_rankings(season = 2025)
#> ── ESPN NBA Season Rankings Index ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:59 UTC
#> # A tibble: 0 × 4
#> # ℹ 4 variables: league <chr>, season <int>, ranking_id <chr>, ref <chr>
# }
```
