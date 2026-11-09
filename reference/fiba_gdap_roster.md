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

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_code | character | Team code (FIBA country code or club abbreviation). |
| team_name | character | Team name (the country for a national team, the club for a club team). |
| organisation_id | integer | Stable federation or club id (Int64), the same in every competition and season (64 = Germany). |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
| date_of_birth | character | Date of birth, YYYY-MM-DD. |
| uniform_number | character | Jersey number (a string). |
| uniform_name | character | Name printed on the jersey. |
| position | character | Playing position (roster: Point Guard...; game page: PG, SG, SF, PF, C). |
| height_in_cm | integer | Player height in centimetres. |
| height_in_feet_inches | character | Height, feet and inches string (6'7"). |
| nationality | character | FIBA code of the main nationality. |
| is_on_final_roster | logical | True when on the final (12-player) roster. |
| games_played | integer | Games played in the competition. |
| club_id | integer | Organisation id of the player's club (organisationId key space). |
| club_name | character | Club at the time of the competition. |
| country_fiba_code | character | FIBA code of the country the person represents. |
| club_country_fiba_code | character | FIBA code of the club's country. |
| is_captain | logical | True for the team captain. |
| is_player_free_agent | logical | True when the player had no club. |
| final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |

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
#> ℹ Data updated: 2026-11-09 12:05:25 UTC
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
