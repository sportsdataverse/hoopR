# **FIBA GDAP: team staff**

Coaches of every team of a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapteamstaffbycompetitionid`

## Usage

``` r
fiba_gdap_team_staff(comp, return_parsed = TRUE)
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
| team_id | integer | FIBA team id (Int64), one per team per competition; the team the coach is registered with. |
| team_name | character | Team name the coach is registered with. |
| team_code | character | Team code (GER, USA...) the coach is registered with. |
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
| final_roster_member_status_code | character | Roster entry status; always null in the samples, values unverified. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_team_staff(comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
