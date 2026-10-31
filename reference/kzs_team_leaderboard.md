# **Get KZS Team Leaderboard**

Team leaderboard of a competition for one stat category (total, per-game
average and single-game best).

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/teamStats`

## Usage

``` r
kzs_team_leaderboard(
  competition_id,
  stats_category = "PTS",
  order_type = "AVERAGE",
  sort_by = "avg",
  sort = "DESC"
)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

- stats_category:

  Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2
  two-pointers, M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field
  goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D defensive, R_O
  offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls
  committed/received, ASS_TOV and ST_TOV ratios. Competitions without
  live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of
  "PTS", "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG",
  "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D", "R_O", "ASS", "ST",
  "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".

- order_type:

  Figure the leaderboard is built on: AVERAGE (per game), SUM (season
  total) or BEST_PERFORMANCE. One of "AVERAGE", "SUM",
  "BEST_PERFORMANCE".

- sort_by:

  Row column the board is ordered by: avg (average), sum or max. The
  runtime checks the order. One of "avg", "sum", "max".

- sort:

  Sort direction. One of "ASC", "DESC".

## Value

A `hoopR_data` tibble: Team leaderboard of a competition for one stat
category (total, per-game average and single-game best). An empty valid
answer raises `hoopR_no_data`; the columns are always these, in this
order (sportsdataverse-py `kzs_team_leaderboard`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| stats_category | character | Stat category of the board (PTS points, R rebounds, ASS assists ...): the request's, the rows do not echo it. |
| club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
| club_fullname | character | Club's full legal name. |
| club_logo_uuid | character | Club logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| club_code | character | Club 3-letter code. |
| team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
| team_name | character | Team name for the season, sponsor included. |
| games_played | integer | Games the team played in the competition. |
| sum | double | Season total of the requested statsCategory. |
| average | double | Per-game average of the statsCategory. |
| max | double | Single-game best of the statsCategory. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_team_leaderboard(competition_id = 579)

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_player_leaderboard.md),
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)
