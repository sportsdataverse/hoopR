# **Get ACB Lineup**

Players of a game with their game line, starters first.

One row per team and player in feed order; `lineup_order` is the 1-based
position (the feed lists the starters first, then the bench).
`is_playing` is true while the player is on court (false once the game
is over). `rebounds` is total rebounds, `fouls` personal fouls
committed, `differential` the plus/minus.

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lineup`

## Usage

``` r
acb_lineup(match_id)
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
are always these, in this order (sportsdataverse-py `acb_lineup`):

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
| lineup_order | integer | 1-based position of the player in the team's list (the feed lists the starters first, then the bench). |
| player_id | integer | ACB licence number of the player. |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| short_name | character | Short display name ('T. Martin'). |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| play_time | character | Time on court in the game as 'mm:ss'. |
| seconds_played | integer | Time on court in whole seconds (play_time parsed). |
| is_playing | logical | True while the player is on court (false once the game is over). |
| points | integer | Points scored in the game. |
| rebounds | integer | Total rebounds in the game. |
| assists | integer | Assists in the game. |
| fouls | integer | Personal fouls committed in the game. |
| differential | integer | Point differential while the player was on court (plus/minus). |
| rating | integer | ACB rating (valoracion) of the game. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_lineup(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
