# **Get ESPN MBB Per-Week Ranking Detail**

Returns the long-format ranked teams for one (season x season-type x
week x ranking-source). Typically 25 rows for MBB (AP Top 25).

## Usage

``` r
espn_mbb_week_ranking(
  ranking_id,
  week,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- ranking_id:

  Ranking source id (1 = AP, 2 = Coaches, etc.).

- week:

  Week number.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per ranked team (typically 25).

|                   |           |                                              |
|-------------------|-----------|----------------------------------------------|
| col_name          | types     | description                                  |
| league            | character | League slug.                                 |
| season            | integer   | Season year.                                 |
| season_type       | integer   | Season-type id.                              |
| week              | integer   | Week number.                                 |
| ranking_id        | character | ESPN ranking id.                             |
| name              | character | Ranking name (e.g. "AP Top 25").             |
| short_name        | character | Short name.                                  |
| type              | character | Ranking type code.                           |
| headline          | character | Full headline.                               |
| date              | character | Date of the ranking.                         |
| current           | integer   | Current rank.                                |
| previous          | integer   | Previous-week rank.                          |
| points            | numeric   | Voting points.                               |
| first_place_votes | integer   | First-place vote count.                      |
| trend             | character | Trend indicator (e.g. "+3", "-2", "-").      |
| record_summary    | character | Team's record at time of poll (e.g. "20-2"). |
| team_id           | character | ESPN team id.                                |
| team_ref          | character | `$ref` to the team-in-season resource.       |
| last_updated      | character | Last-updated timestamp.                      |

## Details

**Get ESPN MBB Per-Week Ranking Detail**

## See also

Other ESPN MBB Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_broadcasts.md),
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_officials.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_powerindex.md),
[`espn_mbb_game_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_predictor.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_game_situation()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_situation.md),
[`espn_mbb_game_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_leaders.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_records.md),
[`espn_mbb_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_game_team_score()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_score.md),
[`espn_mbb_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_statistics.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_gamelog.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_splits.md),
[`espn_mbb_player_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_statisticslog.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_player_stats_v3()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats_v3.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
[`espn_mbb_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children.md),
[`espn_mbb_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams.md),
[`espn_mbb_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_groups.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md),
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md),
[`espn_mbb_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_rankings.md),
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md),
[`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md),
[`espn_mbb_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_week.md),
[`espn_mbb_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_weeks.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_profile.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_week_ranking(ranking_id = 1, week = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Week Ranking Detail ───────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 17:40:47 UTC
#> # A tibble: 25 × 19
#>    league    season season_type  week ranking_id name  short_name type  headline
#>    <chr>      <int>       <int> <int> <chr>      <chr> <chr>      <chr> <chr>   
#>  1 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  2 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  3 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  4 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  5 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  6 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  7 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  8 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  9 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#> 10 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#> # ℹ 15 more rows
#> # ℹ 10 more variables: date <chr>, current <int>, previous <int>, points <dbl>,
#> #   first_place_votes <int>, trend <chr>, record_summary <chr>, team_id <chr>,
#> #   team_ref <chr>, last_updated <chr>
# }
```
