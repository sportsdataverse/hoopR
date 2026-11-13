# **FIBA GDAP: round standings**

Group standings of every round of a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`

## Usage

``` r
fiba_gdap_round_standings(comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_round_standings")`) and in the
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
  try(fiba_gdap_round_standings(comp = 208182))
#> ── FIBA gdap_round_standings from fiba.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:15:54 UTC
#> # A tibble: 88 × 23
#>    round_id round_name  round_code group_name group_status_code  rank
#>       <int> <chr>       <chr>      <chr>      <chr>             <int>
#>  1    25276 First Round FR         A          COMPL                 1
#>  2    25276 First Round FR         A          COMPL                 2
#>  3    25276 First Round FR         A          COMPL                 3
#>  4    25276 First Round FR         A          COMPL                 4
#>  5    25276 First Round FR         B          COMPL                 1
#>  6    25276 First Round FR         B          COMPL                 2
#>  7    25276 First Round FR         B          COMPL                 3
#>  8    25276 First Round FR         B          COMPL                 4
#>  9    25276 First Round FR         C          COMPL                 1
#> 10    25276 First Round FR         C          COMPL                 2
#> # ℹ 78 more rows
#> # ℹ 17 more variables: team_team_id <int>, team_organisation_id <int>,
#> #   team_code <chr>, team_official_name <chr>, team_short_name <chr>,
#> #   games_played <int>, games_lost <int>, games_won <int>, points <int>,
#> #   points_against <int>, points_for <int>, starting_position <int>,
#> #   final_position <int>, plus_minus <int>, penalty_points <int>,
#> #   draw_points <int>, group_game_results <chr>
# }
```
