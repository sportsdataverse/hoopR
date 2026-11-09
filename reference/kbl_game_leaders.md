# **Get KBL Game Leaders**

Each team's leader per category (points, rebounds, assists, steals,
blocks) in a final game.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`

## Usage

``` r
kbl_game_leaders(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Each team's leader per category (points,
rebounds, assists, steals, blocks) in a final game. The columns are
always these, in this order (sportsdataverse-py `kbl_game_leaders`); an
empty valid answer raises `hoopR_no_data`, a valid body with no rows for
this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
| part | character | Category code: score points, rb rebounds, ast assists, stl steals, bs blocks. |
| side | character | Side of the leader: home or away. |
| pcode | character | KBL player code (six-digit string) of the team's leader in the category. |
| player_name | character | Leader's name in Korean (foreign players in Hangul transliteration). |
| player_name_en | character | Leader's name in English / romanized. |
| team_name | character | The leader's team short name (Korean). |
| value | double | The leader's total in the category in this game. |
| play_min | integer | Minutes the leader played this game; add play_sec seconds. |
| play_sec | integer | Seconds part of the leader's playing time (0-59). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_game_leaders(gmkey = "S47G01N49")

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
