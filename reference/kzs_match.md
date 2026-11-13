# **Get KZS Match Header**

Match header: teams, scores, venue, officials' names, best performers
and status.

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`

## Usage

``` r
kzs_match(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_match")`) and in the searchable
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
  try(kzs_match(match_id = 101839))
#> ── KZS Match Header from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:55:58 UTC
#> # A tibble: 1 × 98
#>   match_id competition_id competition_name competition_type competition_phase_id
#>      <int>          <int> <chr>            <chr>                           <int>
#> 1   101839            579 Liga OTP banka   LEAGUE                           5811
#> # ℹ 93 more variables: competition_phase_name <chr>, transferred <lgl>,
#> #   season_id <int>, season <int>, genius_match_id <int>,
#> #   organiser_team_id <int>, round <int>, fiba_live_stats_url <chr>,
#> #   game_index <int>, date_time <chr>, attendance <int>, first_team_id <int>,
#> #   first_team_team_id <int>, first_team_name <chr>,
#> #   first_team_home_jersey_color <chr>, first_team_guest_jersey_color <chr>,
#> #   first_team_logo_uuid <chr>, first_team_code <chr>, …
# }
```
