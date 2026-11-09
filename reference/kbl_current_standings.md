# **Get KBL Current Standings**

Current standings of the active season (no parameter): record, games
behind, streaks, splits.

Endpoint: `GET https://api.kbl.or.kr/league/rank/team`

## Usage

``` r
kbl_current_standings()
```

## Value

A `hoopR_data` tibble: Current standings of the active season (no
parameter): record, games behind, streaks, splits. The columns are
always these, in this order (sportsdataverse-py
`kbl_current_standings`); an empty valid answer raises `hoopR_no_data`,
a valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| rank | integer | Standing (1 = first). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| team_name_full | character | Team full name (Korean, e.g. Changwon LG Sakers). |
| wins | integer | Wins (a count on this route; on `/league/rank/{glkey}` win is a boolean about the latest game). |
| losses | integer | Losses (a count on this route). |
| draws | integer | Draws (always 0 in basketball). |
| win_diff | double | Games behind the leader. |
| home_wins | integer | Wins in the team's home games. |
| home_losses | integer | Losses in the team's home games. |
| away_wins | integer | Wins in the team's away games. |
| away_losses | integer | Losses in the team's away games. |
| conti_win | integer | Current winning streak (0 when the last game was a loss). |
| conti_loss | integer | Current losing streak (0 when the last game was a win). |
| max_win | integer | Longest winning streak of the season. |
| max_loss | integer | Longest losing streak of the season. |
| last_five | character | The last five results as a comma-separated string, most recent first: 1 win, 0 loss. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_current_standings()

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.
