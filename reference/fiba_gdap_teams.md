# **FIBA GDAP: teams**

Teams of a competition with their profile (final ranking, per-game
averages).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamsbycompetitionid`

## Usage

``` r
fiba_gdap_teams(comp, return_parsed = TRUE)
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

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_teams")`) and in the
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
  try(fiba_gdap_teams(comp = 208182))
#> ── FIBA gdap_teams from fiba.basketball ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:36 UTC
#> # A tibble: 32 × 29
#>    team_id team_code short_name    profile_team_id profile_organisation_id
#>      <int> <chr>     <chr>                   <int>                   <int>
#>  1  279561 JPN       Japan                  279561                      85
#>  2  279562 PHI       Philippines            279562                     122
#>  3  279563 AUS       Australia              279563                      16
#>  4  279564 CAN       Canada                 279564                      34
#>  5  279565 CHN       China                  279565                      39
#>  6  279566 CIV       Côte d'Ivoire          279566                      44
#>  7  279567 FIN       Finland                279567                      58
#>  8  279568 FRA       France                 279568                      59
#>  9  279569 GER       Germany                279569                      64
#> 10  279570 GRE       Greece                 279570                      67
#> # ℹ 22 more rows
#> # ℹ 24 more variables: profile_name <chr>, profile_code <chr>,
#> #   profile_country_name <chr>, profile_country_code <chr>,
#> #   profile_gender <chr>, profile_facebook <chr>, profile_twitter <chr>,
#> #   profile_instagram <chr>, profile_website <chr>, profile_you_tube <chr>,
#> #   profile_final_ranking <int>, profile_points_per_game <dbl>,
#> #   profile_rebounds_per_game <dbl>, profile_assists_per_game <dbl>, …
# }
```
