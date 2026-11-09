# **FIBA GDAP: nominations**

Officials nominated for a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionnominationsbyid`

## Usage

``` r
fiba_gdap_nominations(comp, level = "competition", return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- level:

  (character, default `"competition"`) competition = officials nominated
  for the whole competition (the only value the site sends)

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_level | character | Level the nomination is attached to: Competition. |
| competition_level_id | integer | Id of the object the nomination is attached to: the competitionId when competitionLevel is Competition. |
| competition_role | character | Role label at competition level; null in every sample. |
| role | character | Role: Referee, FIBA Table Officials, FIBA Certified Statisticians, FIBA Technical Delegate, FIBA Referee Instructor. |
| role_code | character | Role code (REF, FIBATDEL...). |
| game_assignment_role | character | Role on a game assignment; null at competition level. |
| game_assignment_role_code | character | Code of gameAssignmentRole; null at competition level. |
| game_assignment_role_order | character | Order of gameAssignmentRole; null at competition level. |
| person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
| nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
| license_nationality | character | FIBA code of the federation that licenses the official. |
| affiliated_national_federation_country_code | character | FIBA code of the federation the official is affiliated to. |
| affiliated_national_federation_country_name | character | Country of the federation the official is affiliated to. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_nominations(comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
