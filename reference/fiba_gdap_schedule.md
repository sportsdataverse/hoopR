# **FIBA GDAP: schedule**

Schedule and results of one competition (edition): one row per game.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapgamesbycompetitionid`

## Usage

``` r
fiba_gdap_schedule(comp, return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_schedule(comp = 208182))
#> ── FIBA gdap_schedule from fiba.basketball ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:58:58 UTC
#> # A tibble: 92 × 86
#>    game_id game_name game_number status_code team_a_team_id
#>      <int> <chr>     <chr>       <chr>                <int>
#>  1  100803 25284-M-1 1           VALID               279947
#>  2  100805 25284-M-2 2           VALID               279950
#>  3  100787 25284-M-3 3           VALID               279562
#>  4  100804 25284-M-4 4           VALID               279947
#>  5  100796 25284-N-1 1           VALID               279575
#>  6  100778 25284-N-2 2           VALID               279949
#>  7  100780 25284-N-3 3           VALID               279958
#>  8  100777 25284-N-4 4           VALID               279575
#>  9  100782 25284-O-1 1           VALID               279561
#> 10  100779 25284-O-2 2           VALID               279948
#> # ℹ 82 more rows
#> # ℹ 81 more variables: team_a_organisation_id <int>, team_a_code <chr>,
#> #   team_a_official_name <chr>, team_a_short_name <chr>, team_b_team_id <int>,
#> #   team_b_organisation_id <int>, team_b_code <chr>,
#> #   team_b_official_name <chr>, team_b_short_name <chr>, team_a_score <int>,
#> #   team_b_score <int>, is_live <lgl>, current_period <chr>, chrono <chr>,
#> #   live_game_status <int>, current_period_status <chr>, host_city <chr>, …
# }
```
