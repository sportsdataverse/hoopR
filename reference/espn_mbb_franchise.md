# **Get ESPN MBB Franchise Detail**

Returns franchise-level metadata for a men's college basketball program.
Franchise IDs are stable across program reorganization or rebrands.

## Usage

``` r
espn_mbb_franchise(franchise_id, ...)
```

## Arguments

- franchise_id:

  ESPN franchise identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

|                    |           |                                           |
|--------------------|-----------|-------------------------------------------|
| col_name           | types     | description                               |
| id                 | character | ESPN franchise identifier.                |
| uid                | character | ESPN UID string.                          |
| slug               | character | URL-safe identifier.                      |
| location           | character | Franchise location.                       |
| name               | character | Franchise name.                           |
| nickname           | character | Common nickname.                          |
| abbreviation       | character | Short abbreviation.                       |
| display_name       | character | Full display name.                        |
| short_display_name | character | Short display name.                       |
| color              | character | Primary color (hex, no leading '#').      |
| is_active          | logical   | Whether franchise is currently active.    |
| league             | character | League slug.                              |
| logo               | character | Primary logo URL.                         |
| logo_dark          | character | Dark-mode logo URL.                       |
| venue_ref          | character | `$ref` to franchise's primary venue.      |
| team_ref           | character | `$ref` to the current team for franchise. |

## See also

Other ESPN MBB Functions:
[`espn_mbb_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_awards.md),
[`espn_mbb_athlete_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_career_stats.md),
[`espn_mbb_athlete_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog_v2.md),
[`espn_mbb_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog.md),
[`espn_mbb_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_gamelog.md),
[`espn_mbb_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_info.md),
[`espn_mbb_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_overview.md),
[`espn_mbb_athlete_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_seasons.md),
[`espn_mbb_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_splits.md),
[`espn_mbb_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_statisticslog.md),
[`espn_mbb_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_stats.md),
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md),
[`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_broadcasts.md),
[`espn_mbb_event_competitor_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_leaders.md),
[`espn_mbb_event_competitor_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_linescores.md),
[`espn_mbb_event_competitor_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_records.md),
[`espn_mbb_event_competitor_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_roster_entry.md),
[`espn_mbb_event_competitor_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_roster.md),
[`espn_mbb_event_competitor_score()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_score.md),
[`espn_mbb_event_competitor_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_competitor_statistics.md),
[`espn_mbb_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_odds.md),
[`espn_mbb_event_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_official_detail.md),
[`espn_mbb_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_officials.md),
[`espn_mbb_event_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_play_personnel.md),
[`espn_mbb_event_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_player_box.md),
[`espn_mbb_event_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_play.md),
[`espn_mbb_event_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_powerindex.md),
[`espn_mbb_event_predictor()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_predictor.md),
[`espn_mbb_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_probabilities.md),
[`espn_mbb_event_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_propbets.md),
[`espn_mbb_event_situation()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_situation.md),
[`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md),
[`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children.md),
[`espn_mbb_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams.md),
[`espn_mbb_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_groups.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md),
[`espn_mbb_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_rankings.md),
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md),
[`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md),
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md),
[`espn_mbb_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_weeks.md),
[`espn_mbb_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_week.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_profile.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_franchise(franchise_id = 150)
#> ── ESPN MENS-COLLEGE-BASKETBALL Franchise from ESPN.com ───────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-29 18:26:07 UTC
#> # A tibble: 1 × 16
#>   id    uid             slug   location name  nickname abbreviation display_name
#>   <chr> <chr>           <chr>  <chr>    <chr> <chr>    <chr>        <chr>       
#> 1 150   s:40~l:41~f:150 duke-… Duke     Blue… Duke     DUKE         Duke Blue D…
#> # ℹ 8 more variables: short_display_name <chr>, color <chr>, is_active <lgl>,
#> #   league <chr>, logo <chr>, logo_dark <chr>, venue_ref <chr>, team_ref <chr>
# }
```
