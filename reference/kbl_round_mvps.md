# **Get KBL Round MVPs**

The round MVPs of a season with their totals over the round.

Endpoint: `GET https://api.kbl.or.kr/league/round-mvp/{season}`

## Usage

``` r
kbl_round_mvps(season)
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

## Value

A `hoopR_data` tibble: The round MVPs of a season with their totals over
the round. The columns are always these, in this order
(sportsdataverse-py `kbl_round_mvps`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
| round | integer | Round number of the season (the KBL plays six rounds). |
| pcode | character | KBL player code (six-digit string) of the round MVP (the wire's playerNo). |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| player_name | character | Round MVP's name in Korean (kname). |
| player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
| game_count | integer | Games played in the round. |
| total_seconds | integer | Playing time over the round in seconds (totalHour \* 3600 + totalMinute \* 60 + totalSecond; only the seconds part is non-zero in the samples). |
| total_score | integer | Points over the round. |
| total_rebound | integer | Rebounds over the round. |
| total_assist | integer | Assists over the round. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_round_mvps(season = 2025)

## See also

Other KBL Functions:
[`kbl_current_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_current_standings.md),
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
