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

Other KBL Functions:
[`kbl_game()`](https://hoopR.sportsdataverse.org/reference/kbl_game.md),
[`kbl_game_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_game_leaders.md),
[`kbl_pbp()`](https://hoopR.sportsdataverse.org/reference/kbl_pbp.md),
[`kbl_period_scores()`](https://hoopR.sportsdataverse.org/reference/kbl_period_scores.md),
[`kbl_player_box()`](https://hoopR.sportsdataverse.org/reference/kbl_player_box.md),
[`kbl_player_totals()`](https://hoopR.sportsdataverse.org/reference/kbl_player_totals.md),
[`kbl_players()`](https://hoopR.sportsdataverse.org/reference/kbl_players.md),
[`kbl_playoff_games()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_games.md),
[`kbl_playoff_seeds()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_seeds.md),
[`kbl_playoff_series()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_series.md),
[`kbl_round_mvps()`](https://hoopR.sportsdataverse.org/reference/kbl_round_mvps.md),
[`kbl_rounds()`](https://hoopR.sportsdataverse.org/reference/kbl_rounds.md),
[`kbl_schedule()`](https://hoopR.sportsdataverse.org/reference/kbl_schedule.md),
[`kbl_score_track()`](https://hoopR.sportsdataverse.org/reference/kbl_score_track.md),
[`kbl_season_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_season_leaders.md),
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)
