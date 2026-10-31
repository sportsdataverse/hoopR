# **Get EASL Team Leaders**

A team's top-5 player leaders per category in one season, shaped like
easl_leaders.

Endpoint:
`GET https://easl.joshricha.com/api/v1/teams/{team_id}/leaders`

## Usage

``` r
easl_team_leaders(team_id, season = NULL)
```

## Arguments

- team_id:

  (required) DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list.

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble: A team's top-5 player leaders per category in one
season, shaped like easl_leaders. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `easl_team_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when the body is parsed bare. |
| season_id | character | DataCore season UUID v1 of the leader row. |
| category | character | Leader category, the wire key of the group: pointsPerGame, reboundsPerGame, assistsPerGame, stealsPerGame, blocksPerGame, pointsThreeMade, pointsThreePercentage, fieldGoalsPercentage or freeThrowsPercentage. |
| rank | integer | Rank inside the category, 1 = best, in the delivered order (the server lists the top 5). |
| value | double | The leader's value in the category: a per-game average, a count (pointsThreeMade) or a percentage (0-100). Float64. |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| jersey_number | character | Jersey number as a string ('00', '0' and '75' are distinct). |
| position | character | Playing position: G, F, C, PG, SG, SF, PF or GF (guard-forward). |
| player_status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
| team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
| team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. |
| team_code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
| team_code_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_team_leaders(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
