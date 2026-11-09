# **Get KBL Season Leaders**

Current season leaders per category (no parameter): points, rebounds,
assists, steals, blocks, shooting.

Endpoint: `GET https://api.kbl.or.kr/league/season-leader`

## Usage

``` r
kbl_season_leaders()
```

## Value

A `hoopR_data` tibble: Current season leaders per category (no
parameter): points, rebounds, assists, steals, blocks, shooting. The
columns are always these, in this order (sportsdataverse-py
`kbl_season_leaders`); an empty valid answer raises `hoopR_no_data`, a
valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| part | character | Leader category code: score, rb, ast, bs, stl, fgt, threep, ftR, fgtR, threepR or dk. |
| part_label | character | English meaning of part (kbl_codes.LEADER_PARTS), e.g. score = points per game. |
| rank | integer | Rank in the category. |
| value | double | The player's value in the category: a per-game average, or a percentage for the \*R categories. |
| game_count | integer | Games played this season. |
| pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
| player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
| player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| back_num | character | Jersey number (string). |
| pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
| player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_season_leaders()

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
