# **Get ACB Standings Rounds**

Standings history: each team's position after each round, with the
round's game.

One row per team and round: `position` after that round and the team's
game of the round (`match_id`).

Endpoint:
`GET https://api2.acb.com/api/seasondata/Competition/standings`

## Usage

``` r
acb_standings_rounds(competition_id = NULL, season = NULL, round_id = NULL)
```

## Arguments

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

- round_id:

  (default `NULL`) Standings after this round. Round id (integer):
  global across seasons, not the round number (6017 = Liga 2026-27 round
  3). List them with `acb_competition_rounds` or `acb_calendar`. Omitted
  = the current (or last) round. A whole number; a whole double is
  accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_standings_rounds`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| round_id | integer | Global round id of the standing. |
| round_number | integer | Round number within the phase |
| subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
| subphase_number | integer | Sub-phase number; null in the regular season |
| position | integer | The team's league position after this round. |
| match_id | integer | The team's game in this round. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_standings_rounds(season = 2027)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
