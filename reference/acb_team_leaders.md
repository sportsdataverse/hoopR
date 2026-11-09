# **Get ACB Team Leaders**

A club's statistical leaders for an edition and all-time.

One row per scope, metric and rank. `scope` is `all_time` (club record
holders, the API's `leaders`) or `edition` (the selected season,
`seasonLeaders`); `metric` is the API's category (`points`,
`avg_points`, `played_matches`...); `value` is a total or an average
depending on the metric (Float64). The scope assignment is inferred from
the values.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-leaders`

## Usage

``` r
acb_team_leaders(
  club_id,
  number_of_players,
  competition_id = NULL,
  season = NULL
)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- number_of_players:

  (required) Leaders per statistic; 0 is refused (HTTP 400). A whole
  number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_team_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| club_id | integer | Stable club id asked for. |
| competition_id | integer | Competition of the selected edition. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| scope | character | all_time = club record holders (the API's leaders); edition = the selected season (seasonLeaders). The assignment is inferred from the values (689 games for J.C. Navarro is a career figure). |
| metric | character | Category in snake_case; avg\_\* are per-game averages, the rest totals. |
| rank | integer | Place in the category list, 1 = the leader, in the order the feed lists them. |
| value | double | The player's value in the category (a total or an average depending on the metric). |
| player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_leaders(club_id = 2, number_of_players = 3, season = 2027)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
