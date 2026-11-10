# **Get BNXT League Team Rankings**

Team per-game leaders in nine categories (one row per team and
category).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/average-rankings/{competition_id}`

## Usage

``` r
sportpress_team_rankings(competition_id, phase_id = NULL, limit = NULL)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

- limit:

  (default `NULL`) Cap each ranking list at this many rows. Omitted =
  the complete lists.

## Value

A `hoopR_data` tibble with one row per team and category. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_team_rankings")`) and in the
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
  try(sportpress_team_rankings(competition_id = 24))
#> ── BNXT League Team Rankings from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:05:39 UTC
#> # A tibble: 162 × 7
#>    competition_id category  rank competition_team_id team  team_short_name value
#>             <int> <chr>    <int>               <int> <chr> <chr>           <dbl>
#>  1             24 efficie…     1                 506 Wind… ANT              128.
#>  2             24 efficie…     2                 528 Part… AAL              128.
#>  3             24 efficie…     3                 510 Hubo… LIM              126.
#>  4             24 efficie…     4                 504 Filo… OOS              120.
#>  5             24 efficie…     5                 526 Hero… DBO              115.
#>  6             24 efficie…     6                 536 Hous… KOR              113.
#>  7             24 efficie…     7                 522 Zorg… LEI              111.
#>  8             24 efficie…     8                 512 Dona… GRO              110.
#>  9             24 efficie…     9                 532 Brus… BRU              110.
#> 10             24 efficie…    10                 520 LWD … LWD              107.
#> # ℹ 152 more rows
# }
```
