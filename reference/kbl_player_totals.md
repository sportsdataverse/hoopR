# **Get KBL Player Totals**

Season player totals of one competition (every player with at least one
game).

Endpoint: `GET https://api.kbl.or.kr/leagues/{season}/stats/players`

## Usage

``` r
kbl_player_totals(season, division = "kbl", game_code = "01")
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

- division:

  'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League
  reserve league, seasonGrade 2, which has its own season codes; it
  starts with the 2009 summer edition).

- game_code:

  Competition inside the season, two digits: '01' regular season
  (default; the first stage of a D-League edition), '03' playoffs, '04'
  championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
  '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.

## Value

A `hoopR_data` tibble: Season player totals of one competition (every
player with at least one game). The columns are always these, in this
order (sportsdataverse-py `kbl_player_totals`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the season routes. |
| pcode | character | KBL player code (six-digit string). |
| player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
| player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| back_num | character | Jersey number (string). |
| pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
| player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
| game_count | integer | Games played (this season or competition). |
| start_count | integer | Meaning unverified: up to 4 x gameCount in every sampled row, so probably quarters started. |
| score | integer | Points. Season total for the competition (glkey). |
| fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). Season total for the competition (glkey). |
| fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). Season total for the competition (glkey). |
| fgt | integer | Field goals made, two- and three-point (fg + threep). Season total for the competition (glkey). |
| fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). Season total for the competition (glkey). |
| threep | integer | Three-point field goals made (action 205). Season total for the competition (glkey). |
| threep_a | integer | Three-point attempts, made + missed (205 + 206). Season total for the competition (glkey). |
| ft | integer | Free throws made (action 203). Season total for the competition (glkey). |
| ft_a | integer | Free-throw attempts, made + missed (203 + 204). Season total for the competition (glkey). |
| dk | integer | Dunks made (action 207); included in `fg`. Season total for the competition (glkey). |
| dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). Season total for the competition (glkey). |
| rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). Season total for the competition (glkey). |
| offr | integer | Offensive rebounds (action 209). Season total for the competition (glkey). |
| defr | integer | Defensive rebounds (action 210). Season total for the competition (glkey). |
| ast | integer | Assists (action 211). Season total for the competition (glkey). |
| stl | integer | Steals (action 212). Season total for the competition (glkey). |
| bs | integer | Blocked shots (action 213). Season total for the competition (glkey). |
| to | integer | Turnovers (action 214). Season total for the competition (glkey). |
| foul | integer | Personal fouls (wft + woft). Season total for the competition (glkey). |
| wft | integer | Fouls that awarded free throws (action 215). Season total for the competition (glkey). |
| woft | integer | Fouls that awarded no free throws (action 216). Season total for the competition (glkey). |
| pp | integer | Field goals made in the paint. Season total for the competition (glkey). |
| pp_a | integer | Field-goal attempts in the paint. Season total for the competition (glkey). |
| pscore | integer | Points in the paint (2 \* pp). Season total for the competition (glkey). |
| sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). Season total for the competition (glkey). |
| dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). Season total for the competition (glkey). |
| gd | integer | Good-defense plays (action 221). Season total for the competition (glkey). |
| idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). Season total for the competition (glkey). |
| fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). Season total for the competition (glkey). |
| ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). Season total for the competition (glkey). |
| tf | integer | Probably technical fouls (unverified; 0 in most rows). Season total for the competition (glkey). |
| inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. Season total for the competition (glkey). |
| inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. Season total for the competition (glkey). |
| play_min | integer | Minutes of playing time; add `playSec` seconds. Season total for the competition (glkey). |
| play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. Season total for the competition (glkey). |
| foulout | integer | Meaning unverified: values exceed games played (70 for a 40-game player with 74 fouls); possibly fouls drawn, as this route has no `fo`. |
| minutes_played | double | Playing time in minutes (play_min + play_sec / 60), derived. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_player_totals(season = 2025)

## See also

Other KBL Functions:
[`kbl_current_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_current_standings.md),
[`kbl_game()`](https://hoopR.sportsdataverse.org/reference/kbl_game.md),
[`kbl_game_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_game_leaders.md),
[`kbl_pbp()`](https://hoopR.sportsdataverse.org/reference/kbl_pbp.md),
[`kbl_period_scores()`](https://hoopR.sportsdataverse.org/reference/kbl_period_scores.md),
[`kbl_player_box()`](https://hoopR.sportsdataverse.org/reference/kbl_player_box.md),
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
