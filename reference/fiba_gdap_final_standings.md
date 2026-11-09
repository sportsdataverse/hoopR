# **FIBA GDAP: final standings**

Final ranking of a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionfinalstandingbycompetitionid`

## Usage

``` r
fiba_gdap_final_standings(comp, return_parsed = TRUE)
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
(`subset(return_columns, fn == "fiba_gdap_final_standings")`) and in the
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
  try(fiba_gdap_final_standings(comp = 208182))
#> ── FIBA gdap_final_standings from fiba.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:25 UTC
#> # A tibble: 32 × 9
#>    competition_id final_rank team_team_id team_team_code team_short_name
#>             <int>      <int>        <int> <chr>          <chr>          
#>  1         208182          1       279569 GER            Germany        
#>  2         208182          2       279961 SRB            Serbia         
#>  3         208182          3       279564 CAN            Canada         
#>  4         208182          4       279956 USA            USA            
#>  5         208182          5       279572 LAT            Latvia         
#>  6         208182          6       279574 LTU            Lithuania      
#>  7         208182          7       279576 SLO            Slovenia       
#>  8         208182          8       279571 ITA            Italy          
#>  9         208182          9       279577 ESP            Spain          
#> 10         208182         10       279563 AUS            Australia      
#> # ℹ 22 more rows
#> # ℹ 4 more variables: team_profile <chr>, team_status_code <chr>,
#> #   team_status_name <chr>, team_organisation_id <int>
# }
```
