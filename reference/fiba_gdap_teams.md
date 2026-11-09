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

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_code | character | Team abbreviation (FIBA country code or club abbreviation). |
| short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
| profile_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| profile_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| profile_name | character | Team name as registered for the competition. |
| profile_code | character | Team code (FIBA country code or club abbreviation). |
| profile_country_name | character | Country of the team, in English. |
| profile_country_code | character | Country FIBA code. |
| profile_gender | character | Men or Women: the gender of the team's competition. |
| profile_facebook | character | Facebook handle or URL; always null in the samples, values unverified. |
| profile_twitter | character | X/Twitter handle; always null in the samples, values unverified. |
| profile_instagram | character | Instagram handle; always null in the samples, values unverified. |
| profile_website | character | The team's website address. |
| profile_you_tube | character | YouTube handle; always null in the samples, values unverified. |
| profile_final_ranking | integer | Final rank in the competition. |
| profile_points_per_game | double | The team's average points per game played. |
| profile_rebounds_per_game | double | The team's average rebounds per game played. |
| profile_assists_per_game | double | The team's average assists per game played. |
| profile_rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
| profile_rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
| profile_rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |
| profile_total_games_won | integer | The team's total games won over the games played. |
| profile_total_games_lost | integer | The team's total games lost over the games played. |
| profile_social_networks | character | Social-network handles. Stored as a JSON string. |
| profile_competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| status_code | character | Team entry status: APPR approved. |
| status_name | character | Team entry status label (Approved). |
| organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |

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
#> ℹ Data updated: 2026-11-09 17:05:49 UTC
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
