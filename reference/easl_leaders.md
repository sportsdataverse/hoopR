# **Get EASL Leaders**

Tournament top-5 player leaders in nine categories (points, rebounds,
assists, steals, blocks, shooting).

Endpoint: `GET https://easl.joshricha.com/api/v1/leaders`

## Usage

``` r
easl_leaders(season = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble: Tournament top-5 player leaders in nine
categories (points, rebounds, assists, steals, blocks, shooting). An
empty answer raises `hoopR_no_data`; the columns are always these, in
this order (sportsdataverse-py `easl_leaders`):

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
| team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
| team_code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
| team_code_local | character | Alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_leaders(season = 2026)

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
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
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
