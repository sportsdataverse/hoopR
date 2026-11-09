# **Get ACB Career Stints**

A player's club stints, one row per stint.

One row per stint: first and last year, the club's team entry for the
stint and how many editions it spans (`n_editions`).

Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/career`

## Usage

``` r
acb_career_stints(player_id)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_career_stints`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ACB licence number asked for. |
| initial_year | integer | Year the stint starts. |
| end_year | integer | Year the stint ends (the season's END year). |
| team_id | integer | Team entry of the stint's latest edition. |
| club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| team | character | Team name that season (sponsor names change) |
| team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| edition_id | integer | Season id of the stint's team entry (START year - 1935). |
| n_editions | integer | Editions the stint spans. |
| has_no_validated_data | logical | True when the stint has no validated data. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_career_stints(player_id = 20209407)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
