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

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | FIBA competition id (Int64) the final ranking belongs to; the comp argument. |
| final_rank | integer | Final rank in the competition. |
| team_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
| team_short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
| team_profile | character | Team profile; null in this route. |
| team_status_code | character | Team entry status; always null in the samples, values unverified. |
| team_status_name | character | Team entry status label; always null in the samples, values unverified. |
| team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |

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
#> ℹ Data updated: 2026-11-09 12:05:19 UTC
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
