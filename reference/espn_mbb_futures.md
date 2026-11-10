# **Get ESPN MBB Season Futures (Long Format)**

Returns the full futures-betting board for a men's college basketball
season, in long format: one row per (market x team). Markets typically
cover the NCAA tournament champion and conference winners. Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/futures`.

Returns the full futures-betting board for an NBA season, in long
format: one row per (market x team). Markets include championship
winner, conference winner, division winner, MVP odds, etc. Backed by
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/futures`.

## Usage

``` r
espn_mbb_futures(season = most_recent_mbb_season(), ...)

espn_nba_futures(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per futures market entry.

|                |           |                                         |
|----------------|-----------|-----------------------------------------|
| col_name       | types     | description                             |
| season         | integer   | Season year.                            |
| league         | character | League slug.                            |
| market_id      | character | ESPN futures-market identifier.         |
| market_name    | character | Internal market name.                   |
| market_type    | character | Market type code.                       |
| market_display | character | Human-readable market name.             |
| provider_id    | character | Sportsbook provider identifier.         |
| provider_name  | character | Sportsbook provider name.               |
| team_id        | character | ESPN team id.                           |
| odds_value     | character | American odds for the team.             |
| team_ref       | character | `$ref` to the per-season team resource. |

A `hoopR_data` tibble with one row per futures market entry.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season year. |
| league | character | League slug (`"nba"`). |
| market_id | character | ESPN futures-market identifier. |
| market_name | character | Internal market name (e.g. "NBA - Winner"). |
| market_type | character | Market type code (`winLeague`, `winConference`, `winDivision`, ...). |
| market_display | character | Human-readable name (e.g. "NBA Championship Winner"). |
| provider_id | character | Sportsbook provider identifier. |
| provider_name | character | Sportsbook provider name (e.g. "ESPN BET"). |
| team_id | character | ESPN team id (parsed from `team_ref`). |
| odds_value | character | American odds for the team (e.g. "-250", "+800"). |
| team_ref | character | `$ref` to the per-season team resource. |

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
  espn_mbb_futures(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Futures ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:59:56 UTC
#> # A tibble: 1,793 × 11
#>    season league    market_id market_name market_type market_display provider_id
#>     <int> <chr>         <int> <chr>       <chr>       <chr>          <chr>      
#>  1   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  2   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  3   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  4   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  5   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  6   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  7   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  8   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#>  9   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#> 10   2025 mens-col…      6099 NCAA(B) - … NA          NCAA(B) - Wes… 58         
#> # ℹ 1,783 more rows
#> # ℹ 4 more variables: provider_name <chr>, team_id <chr>, odds_value <chr>,
#> #   team_ref <chr>
# }
# \donttest{
  espn_nba_futures(season = 2025)
#> ── ESPN NBA Season Futures ────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:59:56 UTC
#> # A tibble: 574 × 11
#>    season league market_id market_name  market_type market_display   provider_id
#>     <int> <chr>      <int> <chr>        <chr>       <chr>            <chr>      
#>  1   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  2   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  3   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  4   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  5   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  6   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  7   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  8   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#>  9   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#> 10   2025 nba         2564 NBA - Winner winLeague   NBA Championshi… 58         
#> # ℹ 564 more rows
#> # ℹ 4 more variables: provider_name <chr>, team_id <chr>, odds_value <chr>,
#> #   team_ref <chr>
# }
```
