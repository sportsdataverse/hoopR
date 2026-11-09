# **Get KBL Score Track**

Lead tracker and score chart of a final game: home margin and both
scores at eight checkpoints per period.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`

## Usage

``` r
kbl_score_track(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Lead tracker and score chart of a final game:
home margin and both scores at eight checkpoints per period. The columns
are always these, in this order (sportsdataverse-py `kbl_score_track`);
an empty valid answer raises `hoopR_no_data`, a valid body with no rows
for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
| period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
| period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
| checkpoint | integer | 1-based checkpoint inside the period: eight per period, evenly spaced is assumed (every 75 s of a quarter; unverified), the last at the period's end. |
| home_margin | integer | Home margin (home minus away points) at the checkpoint. |
| home_score | integer | Home team points: cumulative at the checkpoint on the score track, the final total (all periods summed) on a game row, the full-time score in the schedule. |
| away_score | integer | Away team points: cumulative at the checkpoint on the score track, the final total (all periods summed) on a game row, the full-time score in the schedule. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_score_track(gmkey = "S47G01N49")

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
