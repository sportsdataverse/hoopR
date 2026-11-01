# **Get ACB Standings**

League table after a round (default: the current round).

One row per team: position, record, points for and against, home and
away records. `round_id` is the round the table is as of; `total_rounds`
the rounds in the phase.

Endpoint:
`GET https://api2.acb.com/api/seasondata/Competition/standings`

## Usage

``` r
acb_standings(competition_id = NULL, season = NULL, round_id = NULL)
```

## Arguments

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

- round_id:

  (default `NULL`) Standings after this round. Round id (integer):
  global across seasons, not the round number (6017 = Liga 2026-27 round
  3). List them with `acb_competition_rounds` or `acb_calendar`. Omitted
  = the current (or last) round. A whole number; a whole double is
  accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| round_id | integer | Round the table is as of (the selected round). |
| total_rounds | integer | Rounds in the phase. |
| team_id | integer | Season-team entry id (new every season). |
| club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
| team | character | Team name as registered for that season (sponsor names change; the club id does not). |
| team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
| position | integer | Table position (standings row) |
| position_trend | integer | Change in position since the previous round: positive = up (meaning of the sign unverified). |
| played | integer | Games played (standings row) |
| wins | integer | Wins (standings row) |
| losses | integer | Losses (the key is misspelt by the API) |
| win_pct | double | Win percentage, 0-100. |
| points_for | integer | Points scored (standings row) |
| points_against | integer | Points allowed (standings row) |
| plus_minus | integer | Point differential (points for minus points against). |
| home_wins | integer | Wins at home (the API's localBalanceWins). |
| home_losses | integer | Losses at home. |
| away_wins | integer | Wins away from home (the API's awayBalanceWins). |
| away_losses | integer | Losses away from home (the API's awayBalanceLosses). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

Other ACB Functions:
[`acb_box_info()`](https://hoopR.sportsdataverse.org/reference/acb_box_info.md),
[`acb_bracket()`](https://hoopR.sportsdataverse.org/reference/acb_bracket.md),
[`acb_bracket_games()`](https://hoopR.sportsdataverse.org/reference/acb_bracket_games.md),
[`acb_calendar()`](https://hoopR.sportsdataverse.org/reference/acb_calendar.md),
[`acb_career_stints()`](https://hoopR.sportsdataverse.org/reference/acb_career_stints.md),
[`acb_career_trophies()`](https://hoopR.sportsdataverse.org/reference/acb_career_trophies.md),
[`acb_club_data()`](https://hoopR.sportsdataverse.org/reference/acb_club_data.md),
[`acb_competition_current()`](https://hoopR.sportsdataverse.org/reference/acb_competition_current.md),
[`acb_competition_editions()`](https://hoopR.sportsdataverse.org/reference/acb_competition_editions.md),
[`acb_competition_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_competition_rounds.md),
[`acb_competition_weeks()`](https://hoopR.sportsdataverse.org/reference/acb_competition_weeks.md),
[`acb_current_roster()`](https://hoopR.sportsdataverse.org/reference/acb_current_roster.md),
[`acb_lead_stats()`](https://hoopR.sportsdataverse.org/reference/acb_lead_stats.md),
[`acb_lead_tracker()`](https://hoopR.sportsdataverse.org/reference/acb_lead_tracker.md),
[`acb_league_zones()`](https://hoopR.sportsdataverse.org/reference/acb_league_zones.md),
[`acb_lineup()`](https://hoopR.sportsdataverse.org/reference/acb_lineup.md),
[`acb_match_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_match_advanced_stats.md),
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md),
[`acb_match_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_match_leaders.md),
[`acb_matchlist()`](https://hoopR.sportsdataverse.org/reference/acb_matchlist.md),
[`acb_next_matches()`](https://hoopR.sportsdataverse.org/reference/acb_next_matches.md),
[`acb_pbp()`](https://hoopR.sportsdataverse.org/reference/acb_pbp.md),
[`acb_period_scores()`](https://hoopR.sportsdataverse.org/reference/acb_period_scores.md),
[`acb_player_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_advanced_stats.md),
[`acb_player_box()`](https://hoopR.sportsdataverse.org/reference/acb_player_box.md),
[`acb_player_data()`](https://hoopR.sportsdataverse.org/reference/acb_player_data.md),
[`acb_player_matches()`](https://hoopR.sportsdataverse.org/reference/acb_player_matches.md),
[`acb_player_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_stats.md),
[`acb_player_totals()`](https://hoopR.sportsdataverse.org/reference/acb_player_totals.md),
[`acb_quickfacts()`](https://hoopR.sportsdataverse.org/reference/acb_quickfacts.md),
[`acb_round_matches()`](https://hoopR.sportsdataverse.org/reference/acb_round_matches.md),
[`acb_search()`](https://hoopR.sportsdataverse.org/reference/acb_search.md),
[`acb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_season_leaders.md),
[`acb_serie()`](https://hoopR.sportsdataverse.org/reference/acb_serie.md),
[`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md),
[`acb_standings_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_standings_rounds.md),
[`acb_team_box()`](https://hoopR.sportsdataverse.org/reference/acb_team_box.md),
[`acb_team_comparison()`](https://hoopR.sportsdataverse.org/reference/acb_team_comparison.md),
[`acb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_team_leaders.md),
[`acb_team_matches()`](https://hoopR.sportsdataverse.org/reference/acb_team_matches.md),
[`acb_team_records()`](https://hoopR.sportsdataverse.org/reference/acb_team_records.md),
[`acb_team_stats()`](https://hoopR.sportsdataverse.org/reference/acb_team_stats.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_standings(season = 2027))
#> ── ACB Standings from api2.acb.com ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:44:49 UTC
#> # A tibble: 18 × 22
#>    competition_id edition_id season round_id total_rounds team_id club_id team  
#>             <int>      <int>  <int>    <int>        <int>   <int>   <int> <chr> 
#>  1              1         91   2027     6020           34    4475       4 Surne…
#>  2              1         91   2027     6020           34    4471      10 Kids&…
#>  3              1         91   2027     6020           34    4466      22 MoraB…
#>  4              1         91   2027     6020           34    4479      57 Monbu…
#>  5              1         91   2027     6020           34    4467       2 Barça 
#>  6              1         91   2027     6020           34    4480     657 Leyma…
#>  7              1         91   2027     6020           34    4464      25 Río B…
#>  8              1         91   2027     6020           34    4473       8 Asisa…
#>  9              1         91   2027     6020           34    4469     549 Recol…
#> 10              1         91   2027     6020           34    4463       3 Kosne…
#> 11              1         91   2027     6020           34    4478      28 La La…
#> 12              1         91   2027     6020           34    4474      16 Casad…
#> 13              1         91   2027     6020           34    4470     591 FIATC…
#> 14              1         91   2027     6020           34    4468      12 UCAM …
#> 15              1         91   2027     6020           34    4472      13 Valen…
#> 16              1         91   2027     6020           34    4465     658 iLERN…
#> 17              1         91   2027     6020           34    4476       9 Real …
#> 18              1         91   2027     6020           34    4477      14 Unica…
#> # ℹ 14 more variables: team_abbr <chr>, position <int>, position_trend <int>,
#> #   played <int>, wins <int>, losses <int>, win_pct <dbl>, points_for <int>,
#> #   points_against <int>, plus_minus <int>, home_wins <int>, home_losses <int>,
#> #   away_wins <int>, away_losses <int>
# }
```
