# **Get ACB Box Info**

Coaches and game facts per team: head coach, assistants, arena,
attendance, referees.

One row per team. `arena`, `attendance` and `referees` (joined with
`'; '`) describe the game and repeat on both rows; `assistant_coaches`
is joined with `'; '`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_box_info(match_id)
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
are always these, in this order (sportsdataverse-py `acb_box_info`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
| team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| head_coach | character | Head coach's name. |
| assistant_coaches | character | Assistant coaches' names joined with '; '. |
| arena | character | Arena where the game was played; repeats on both team rows. |
| attendance | integer | Announced attendance; repeats on both team rows. |
| referees | character | Referees' names joined with '; '; repeats on both team rows. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_box_info(match_id = 105401))
#> ── ACB Box Info from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:02:23 UTC
#> # A tibble: 2 × 13
#>   match_id edition_id season team_side team_id club_id team            team_abbr
#>      <int>      <int>  <int> <chr>       <int>   <int> <chr>           <chr>    
#> 1   105401         91   2027 home         4467       2 Barça           BAR      
#> 2   105401         91   2027 away         4472      13 Valencia Basket VBC      
#> # ℹ 5 more variables: head_coach <chr>, assistant_coaches <chr>, arena <chr>,
#> #   attendance <int>, referees <chr>
# }
```
