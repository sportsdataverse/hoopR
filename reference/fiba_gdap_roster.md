# **FIBA GDAP: roster**

A team's roster at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`

## Usage

``` r
fiba_gdap_roster(team_id, discipline_format = NULL, return_parsed = TRUE)
```

## Arguments

- team_id:

  (integer, required) Required. Competition team id: one per team per
  competition (teamA.teamId of a game row; Germany is 279569 at the 2023
  World Cup and 281545 at Paris 2024). Not the federation organisationId

- discipline_format:

  (character, optional) Optional; the site passes its discipline format.
  5x5 answers the same as omitting it (verified on awards and rosters)

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_roster")`) and in the
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
  try(fiba_gdap_roster(team_id = 279569))
#> ── FIBA gdap_roster from fiba.basketball ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:55 UTC
#> # A tibble: 12 × 25
#>    team_id team_code team_name organisation_id competition_id person_id
#>      <int> <chr>     <chr>               <int>          <int>     <int>
#>  1  279569 GER       Germany                64         208182    211501
#>  2  279569 GER       Germany                64         208182    155956
#>  3  279569 GER       Germany                64         208182    269000
#>  4  279569 GER       Germany                64         208182    204689
#>  5  279569 GER       Germany                64         208182    188675
#>  6  279569 GER       Germany                64         208182    196287
#>  7  279569 GER       Germany                64         208182    189145
#>  8  279569 GER       Germany                64         208182    181996
#>  9  279569 GER       Germany                64         208182    198299
#> 10  279569 GER       Germany                64         208182    188677
#> 11  279569 GER       Germany                64         208182    227403
#> 12  279569 GER       Germany                64         208182    210175
#> # ℹ 19 more variables: first_name <chr>, last_name <chr>, gender <chr>,
#> #   date_of_birth <chr>, uniform_number <chr>, uniform_name <chr>,
#> #   position <chr>, height_in_cm <int>, height_in_feet_inches <chr>,
#> #   nationality <chr>, is_on_final_roster <lgl>, games_played <int>,
#> #   club_id <int>, club_name <chr>, country_fiba_code <chr>,
#> #   club_country_fiba_code <chr>, is_captain <lgl>, is_player_free_agent <lgl>,
#> #   final_roster_member_status_code <chr>
# }
```
