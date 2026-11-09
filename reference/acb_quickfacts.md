# **Get ACB Quick Facts**

Pre-match facts per team: standing, record, recent results.

One row per team (`team_side` home then away): `standing` is the league
position, `wins` / `losses` the record before the game, `last_results`
the recent results joined with `'; '` (`WIN` / `LOSS`).

Endpoint: `GET https://api2.acb.com/api/matchdata/Preview/quickfacts`

## Usage

``` r
acb_quickfacts(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_quickfacts`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id (new every season). |
| club_id | integer | Stable club id (2 = Barca, 9 = Real Madrid). |
| team | character | Team name for the season. |
| team_abbr | character | Three-letter team abbreviation. |
| edition_id | integer | Season id (START year - 1935). |
| season | integer | Season END year (edition_id + 1936). |
| standing | integer | League position before the game. |
| wins | integer | Wins before the game. |
| losses | integer | Losses before the game (the API's currentLoses). |
| last_results | character | Recent results joined with '; ' (WIN / LOSS), in the order the API sends them. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_quickfacts(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
