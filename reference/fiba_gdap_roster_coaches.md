# **FIBA GDAP: roster coaches**

A team's coaches on its roster at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`

## Usage

``` r
fiba_gdap_roster_coaches(
  team_id,
  discipline_format = NULL,
  return_parsed = TRUE
)
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
| function | character | Role: Head Coach, Coach, Assistant Coach. |
| is_head_coach | integer | 1 for the head coach, 0 otherwise (an integer flag, not a boolean). |
| is_assistant_coach | integer | 1 for an assistant coach, else null (integer flag). |
| is_accompanying_coach | logical | Accompanying-coach flag; always null in the samples, values unverified. |
| coach_display_order | integer | Display order; null when unset. |
| is_on_final_roster | logical | True when on the final (12-player) roster. |
| nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
| coach_license_organisation_name | character | Federation that issued the coaching licence. |
| coach_license_country_code | character | FIBA code of the licensing federation's country. |
| final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_roster_coaches(team_id = 279569)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
