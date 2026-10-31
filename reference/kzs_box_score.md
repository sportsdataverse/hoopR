# **Get KZS Player Box Score**

Box score of a final game (2015/16 on): one row per player of both
teams.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`

## Usage

``` r
kzs_box_score(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: Box score of a final game (2015/16 on): one row
per player of both teams. An empty valid answer raises `hoopR_no_data`;
the columns are always these, in this order (sportsdataverse-py
`kzs_box_score`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
| team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
| team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
| team_name | character | Name of the team for the season, sponsor included. |
| minutes | double | The player's minutes played, decimal minutes (39.67 = 39 min 40 s); the team line sums its players (225.0 = 5 x 45 with overtime). |
| two_pm | integer | The player's two-point field goals made. |
| two_pa | integer | The player's two-point field goals attempted. |
| two_p_perc | double | The player's two-point percentage, 0-100. |
| three_pm | integer | The player's three-point field goals made. |
| three_pa | integer | The player's three-point field goals attempted. |
| three_p_perc | double | The player's three-point percentage, 0-100. |
| f_tm | integer | The player's free throws made. |
| f_ta | integer | The player's free throws attempted. |
| f_t_perc | double | The player's free-throw percentage, 0-100. |
| fg_m | integer | The player's field goals made. |
| fg_a | integer | The player's field goals attempted. |
| fg_perc | double | The player's field-goal percentage, 0-100. |
| offensive_rebounds | integer | The player's offensive rebounds. |
| defensive_rebounds | integer | The player's defensive rebounds. |
| total_rebounds | integer | The player's total rebounds. |
| assists | integer | The player's assists. |
| steals | integer | The player's steals. |
| turnovers | integer | The player's turnovers. |
| blocks_in_favor | integer | The player's shots blocked (blocks made). |
| blocks_against | integer | The player's own shots that were blocked. |
| foul_commited | integer | The player's fouls committed. |
| foul_received | integer | The player's fouls drawn. |
| p_ir | integer | The player's PIR, performance index rating ((points + rebounds + assists + steals + blocks + fouls drawn) - (missed field goals + missed free throws + turnovers + shots blocked + fouls committed)). |
| plus_minus | integer | The player's plus-minus: points scored minus allowed while on court (team line: the final margin). |
| assists_turnover_ratio | double | The player's assist-to-turnover ratio (0 in every sample: not computed). |
| defensive_rating | double | The player's defensive rating (0 in every sample: not computed). |
| efficiency | integer | The player's efficiency as the feed computes it (equal to `pIR` on 2025-26 team lines). |
| points | integer | The player's points. |
| efficiency_custom | double | The player's custom efficiency as the federation computes it (equal to `efficiency` on player rows; 0 on team lines). |
| efficiency_game_score | double | The player's game score (0 in every sample: not computed). |
| fast_break_points_attempted | integer | The player's fast-break attempts (0 in every sample: not computed). |
| fast_break_points_made | integer | The player's fast-break makes (0 in every sample: not computed). |
| usage_percentage | double | The player's usage percentage (0 in every sample: not computed). |
| m_vp_votes | integer | The player's MVP votes (0 in every sample). |
| minus | integer | The player's points allowed on court (0 in every sample: not computed). |
| offensive_rating | double | The player's offensive rating (0 in every sample: not computed). |
| p_er | double | The player's PER (0 in every sample: not computed). |
| plus | integer | The player's points scored on court (0 in every sample: not computed). |
| points_fast_break | integer | The player's fast-break points. |
| points_in_the_paint | integer | The player's points in the paint. |
| points_in_the_paint_attempted | integer | The player's paint attempts (0 in every sample: not computed). |
| points_in_the_paint_made | integer | The player's paint makes (0 in every sample: not computed). |
| points_second_chance | integer | The player's second-chance points. |
| second_chance_points_attempted | integer | The player's second-chance attempts (0 in every sample: not computed). |
| second_chance_points_made | integer | The player's second-chance makes (0 in every sample: not computed). |
| true_shooting_attempts | integer | The player's true-shooting attempts (0 in every sample: not computed). |
| true_shooting_percentage | double | The player's true-shooting percentage (0 in every sample: not computed). |
| player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| match_team_player_firstname | character | The player's given name, as entered for this match (lower-case n in this route). |
| match_team_player_lastname | character | The player's family name, as entered for this match (lower-case n in this route). |
| match_team_player_year_of_birth | character | Birth year from the match entry, sent as a string ('2002'); the profile `person.yearOfBirth` is an integer. |
| jersey_number | character | Shirt number worn, sent as a string ('1', '55'). |
| starting_lineup | logical | True when the player started. |
| captain | logical | Games as captain. |
| played | logical | True when the player got on court. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

Other KZS Functions:
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
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_box_score(match_id = 101839))
#> ── KZS Player Box Score from api.kzs.si ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:31:13 UTC
#> # A tibble: 23 × 61
#>    match_id team_side team_id team_name         minutes two_pm two_pa two_p_perc
#>       <int> <chr>       <int> <chr>               <dbl>  <int>  <int>      <dbl>
#>  1   101839 home        17551 Perspektiva Ilir…   39.7       5      8       62.5
#>  2   101839 home        17551 Perspektiva Ilir…    5.68      0      0        0  
#>  3   101839 home        17551 Perspektiva Ilir…    0         0      0        0  
#>  4   101839 home        17551 Perspektiva Ilir…   24.5       0      3        0  
#>  5   101839 home        17551 Perspektiva Ilir…   36.9       5      9       55.6
#>  6   101839 home        17551 Perspektiva Ilir…   37.4       6      7       85.7
#>  7   101839 home        17551 Perspektiva Ilir…    4.76      3      3      100  
#>  8   101839 home        17551 Perspektiva Ilir…   31.7       5      5      100  
#>  9   101839 home        17551 Perspektiva Ilir…   16.6       1      2       50  
#> 10   101839 home        17551 Perspektiva Ilir…   20.2       1      5       20  
#> # ℹ 13 more rows
#> # ℹ 53 more variables: three_pm <int>, three_pa <int>, three_p_perc <dbl>,
#> #   f_tm <int>, f_ta <int>, f_t_perc <dbl>, fg_m <int>, fg_a <int>,
#> #   fg_perc <dbl>, offensive_rebounds <int>, defensive_rebounds <int>,
#> #   total_rebounds <int>, assists <int>, steals <int>, turnovers <int>,
#> #   blocks_in_favor <int>, blocks_against <int>, foul_commited <int>,
#> #   foul_received <int>, p_ir <int>, plus_minus <int>, …
# }
```
