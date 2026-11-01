# **Get KZS Standings**

Standings of a competition, one row per team in each phase (and group).

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/standings`

## Usage

``` r
kzs_standings(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble: Standings of a competition, one row per team in
each phase (and group). An empty valid answer raises `hoopR_no_data`;
the columns are always these, in this order (sportsdataverse-py
`kzs_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
| phase_name | character | Phase name, Slovenian (see `phases[].name`). |
| phase_type | character | Phase format (code table). |
| group_id | integer | Group id inside the phase (null when the table is the phase's own). |
| group_name | character | Group name inside the phase (null when the table is the phase's own). |
| position | integer | 1-based position of the row in its table, in the order the API lists it (the wire has no rank column). |
| team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
| team_name | character | Team name for the season, sponsor included. |
| club_code | character | Club 3-letter code. |
| logo_uuid | character | Team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| games_played | integer | Games played in the phase. |
| won | integer | Wins in the phase. |
| lost | integer | Losses in the phase. |
| pts_plus | integer | Points scored by the team through its games played. |
| pts_minus | integer | Points allowed. |
| home_won | integer | Home games the team has won. |
| home_lost | integer | Home games the team has lost. |
| away_won | integer | Away games the team has won. |
| away_lost | integer | Away games the team has lost. |
| points | integer | Table points: 2 per win, 1 per loss (Krka 26-1 = 53). |
| draws | integer | Draws (0: basketball has none). |
| lost_points | integer | Table points deducted (0 in every sample). |
| tie_break_position | integer | Final position after tie-breaks (absent on playoff-phase rows). |
| pts_difference | integer | Point differential (scored - allowed). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

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
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_standings(competition_id = 579))
#> ── KZS Standings from api.kzs.si ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:34 UTC
#> # A tibble: 24 × 25
#>    competition_id phase_id phase_name phase_type group_id group_name position
#>             <int>    <int> <chr>      <chr>         <int> <chr>         <int>
#>  1            579     5811 Redni del  GROUP            NA NA                1
#>  2            579     5811 Redni del  GROUP            NA NA                2
#>  3            579     5811 Redni del  GROUP            NA NA                3
#>  4            579     5811 Redni del  GROUP            NA NA                4
#>  5            579     5811 Redni del  GROUP            NA NA                5
#>  6            579     5811 Redni del  GROUP            NA NA                6
#>  7            579     5811 Redni del  GROUP            NA NA                7
#>  8            579     5811 Redni del  GROUP            NA NA                8
#>  9            579     5811 Redni del  GROUP            NA NA                9
#> 10            579     5811 Redni del  GROUP            NA NA               10
#> # ℹ 14 more rows
#> # ℹ 18 more variables: team_id <int>, team_name <chr>, club_code <chr>,
#> #   logo_uuid <chr>, games_played <int>, won <int>, lost <int>, pts_plus <int>,
#> #   pts_minus <int>, home_won <int>, home_lost <int>, away_won <int>,
#> #   away_lost <int>, points <int>, draws <int>, lost_points <int>,
#> #   tie_break_position <int>, pts_difference <int>
# }
```
