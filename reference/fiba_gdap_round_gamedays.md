# **FIBA GDAP: round gamedays**

Rounds of a competition with their game days.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionroundgamedaysbyid`

## Usage

``` r
fiba_gdap_round_gamedays(comp, return_parsed = TRUE)
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
| competition_id | integer | FIBA competition id (Int64) the rounds belong to; the comp argument. |
| round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
| round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
| round_parent_round_id | integer | roundId of the round this one belongs to; null for a top-level round. |
| round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
| round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
| round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| round_round_number | integer | Round number within the competition (1-based). |
| round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
| round_round_type_code | character | Round type code: G group, NG non-group (knockout), S super round. |
| round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
| round_start_date | character | Round start, local date-time. |
| round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
| round_has_teams_assigned | logical | True once the round's teams are known. |
| round_round_kind | character | Standard Round or Qualifiers. |
| round_standing_header_code | character | Code of the standings table the round feeds. |
| round_standing_header_name | character | Name of the standings table the round feeds. |
| round_qualified_team_information | character | Qualification note of the round; null in every sample. |
| round_round_order | integer | Display order of the round. |
| gamedays | character | Game days of the round as a JSON string; empty (null) for the competitions sampled. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_round_gamedays(comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
