# **Get BNXT League Schedule**

Every game of a season for Belgian and Dutch clubs, with teams, scores,
phase and venue.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/club/{season}`

## Usage

``` r
sportpress_schedule(season, month = -1, phase_id = NULL)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

- month:

  (default `-1`) Calendar month filter; -1 (default) = the whole season
  in one body.

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_schedule(season = 2026))
#> ── BNXT League Schedule from Sportpress ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:17:41 UTC
#> # A tibble: 347 × 19
#>    game_id game_time           status  competition_id season phase_id phase_name
#>      <int> <dttm>              <chr>            <int>  <int>    <int> <chr>     
#>  1   10569 2026-04-28 20:00:00 finish…             24   2026      169 Regular S…
#>  2   10571 2026-04-08 19:30:00 finish…             24   2026      169 Regular S…
#>  3   10573 2026-03-10 20:00:00 finish…             24   2026      169 Regular S…
#>  4   10575 2026-01-06 20:00:00 finish…             24   2026      169 Regular S…
#>  5   10577 2025-09-26 20:30:00 finish…             24   2026      169 Regular S…
#>  6   10579 2025-09-27 20:00:00 finish…             24   2026      169 Regular S…
#>  7   10581 2025-09-27 20:30:00 finish…             24   2026      169 Regular S…
#>  8   10583 2025-09-27 20:30:00 finish…             24   2026      169 Regular S…
#>  9   10585 2025-09-27 20:45:00 finish…             24   2026      169 Regular S…
#> 10   10587 2025-09-28 14:00:00 finish…             24   2026      169 Regular S…
#> # ℹ 337 more rows
#> # ℹ 12 more variables: round_name <chr>, round_priority <int>,
#> #   period_name <chr>, arena <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>
# }
```
