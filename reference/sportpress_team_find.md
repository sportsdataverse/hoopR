# **Get BNXT League Team**

One competition team with its season scoring averages.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/find/{competition_team_id}`

## Usage

``` r
sportpress_team_find(competition_team_id)
```

## Arguments

- competition_team_id:

  (required) Competition-team id (integer): a team in ONE competition,
  so new every season (e.g. 541 = Antwerp in 2026-27); from
  [`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md).

## Value

A `hoopR_data` tibble: One competition team with its season scoring
averages. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sportsdataverse-py `sportpress_team_find`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year of the team's competition. |
| competition_name | character | Competition name, 'BNXT League 2026-2027'. |
| uu_team_id | integer | Stable club key across seasons (key space: sportpress clubs-as-teams); competition_team_id changes every season, this does not. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
| club_name | character | Country name in English, Belgium or Netherlands. |
| average_score_for | double | Points scored per game by the team over the season; null for a team with no statistics. |
| average_score_against | double | Points conceded per game; null for a team with no statistics. |
| field_goal_percent | double | Team field-goal percentage 0-100; null for a team with no statistics. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

     sportpress_team_find(competition_team_id = 541)

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.
