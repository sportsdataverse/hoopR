# **Get KZS Matches**

Matches of a competition (optionally inside a from/to window) with the
Genius LiveStats id.

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/`

## Usage

``` r
kzs_matches(competition_id, date_from = NULL, date_to = NULL)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

- date_from:

  Earliest tip-off, an ISO instant such as 2025-10-01T00:00:00.000Z (a
  bare date is a 400). Omitted = the whole competition.

- date_to:

  Latest tip-off, an ISO instant such as 2025-10-31T23:59:59.000Z.
  Omitted = the whole competition.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_matches")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_matches(
    competition_id = 579, date_from = "2025-10-01T00:00:00.000Z",
    date_to = "2025-10-31T23:59:59.000Z"
  ))
#> ── KZS Matches from api.kzs.si ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:12:44 UTC
#> # A tibble: 21 × 69
#>    match_id competition_id competition_name competition_type
#>       <int>          <int> <chr>            <chr>           
#>  1   101846            579 Liga OTP banka   LEAGUE          
#>  2   101842            579 Liga OTP banka   LEAGUE          
#>  3   101843            579 Liga OTP banka   LEAGUE          
#>  4   101844            579 Liga OTP banka   LEAGUE          
#>  5   101845            579 Liga OTP banka   LEAGUE          
#>  6   101848            579 Liga OTP banka   LEAGUE          
#>  7   101847            579 Liga OTP banka   LEAGUE          
#>  8   101849            579 Liga OTP banka   LEAGUE          
#>  9   101851            579 Liga OTP banka   LEAGUE          
#> 10   101850            579 Liga OTP banka   LEAGUE          
#> # ℹ 11 more rows
#> # ℹ 65 more variables: competition_phase_id <int>,
#> #   competition_phase_name <chr>, transferred <lgl>, season_id <int>,
#> #   season <int>, genius_match_id <int>, organiser_team_id <int>, round <int>,
#> #   fiba_live_stats_url <chr>, game_index <int>, date_time <chr>,
#> #   attendance <int>, sport_hall_name <chr>, sport_hall_address <chr>,
#> #   sport_hall_id <int>, first_team_id <int>, first_team_team_id <int>, …
# }
```
