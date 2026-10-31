# **Get KBL Rounds**

The season's round calendar (the KBL plays six rounds) with each round's
first and last date.

Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}/team-tracks`

## Usage

``` r
kbl_rounds(season, division = "kbl", game_code = "01")
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

A `hoopR_data` tibble: The season's round calendar (the KBL plays six
rounds) with each round's first and last date. The columns are always
these, in this order (sportsdataverse-py `kbl_rounds`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the season routes. |
| round | integer | Round number of the season (the KBL plays six rounds). |
| from_date | Date | First date of the round, YYYYMMDD. |
| to_date | Date | Last date of the round, YYYYMMDD. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

     kbl_rounds(season = 2025)

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
[`kbl_round_mvps()`](https://hoopR.sportsdataverse.org/reference/kbl_round_mvps.md),
[`kbl_schedule()`](https://hoopR.sportsdataverse.org/reference/kbl_schedule.md),
[`kbl_score_track()`](https://hoopR.sportsdataverse.org/reference/kbl_score_track.md),
[`kbl_season_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_season_leaders.md),
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)
