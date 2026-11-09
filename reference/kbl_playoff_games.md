# **Get KBL Playoff Games**

The games of the playoff bracket (2024-25 on; the older bracket format
lists no games).

Endpoint: `GET https://api.kbl.or.kr/league/playoff/{season}`

## Usage

``` r
kbl_playoff_games(season)
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

## Value

A `hoopR_data` tibble: The games of the playoff bracket (2024-25 on; the
older bracket format lists no games). The columns are always these, in
this order (sportsdataverse-py `kbl_playoff_games`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code of the game (from the bracket's gmkey object). |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| game_code | character | Competition type of the game: 03 playoffs, 04 championship final. |
| game_no | integer | Game number inside the competition, from the bracket's gmkey object. |
| round | character | Playoff round: quarterfinal (the last six, seeds 3-6), semifinal (the last four) or final; on the round-MVP and rounds frames the round number of the season. |
| series_no | integer | Series number inside the round (1 or 2 for the quarterfinals and semifinals, 1 for the final). |
| game_date | Date | Game date, KST. |
| home_team_code | character | Home team code. Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
| away_team_code | character | Away team code. Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
| home_team_name | character | Home team short name (Korean). |
| away_team_name | character | Away team short name (Korean). |
| home_score | integer | Home team points. |
| away_score | integer | Away team points. |
| home_win | logical | 1 when the home team won, else 0. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_playoff_games(season = 2025)

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
