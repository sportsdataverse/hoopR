# **Get ESPN MBB Season Rankings Index**

Returns the index of season-level rankings recorded for one MBB season.
Typical sources: AP Top 25 (id 1), Coaches Poll (id 2). Pass an
`ranking_id` to
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md)
for the ranked teams.

## Usage

``` r
espn_mbb_season_rankings(season = most_recent_mbb_season(), ...)
```

## Arguments

- season:

  Season year. Defaults to most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per ranking source.

|            |           |                                    |
|------------|-----------|------------------------------------|
| col_name   | types     | description                        |
| league     | character | League slug.                       |
| season     | integer   | Season year.                       |
| ranking_id | character | ESPN ranking id.                   |
| ref        | character | `$ref` URL for the ranking detail. |

## Details

**Get ESPN MBB Season Rankings Index**

## See also

Other ESPN MBB Functions:
[`espn_mbb_athlete_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_awards.md),
[`espn_mbb_athlete_eventlog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_eventlog.md),
[`espn_mbb_athlete_gamelog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_gamelog.md),
[`espn_mbb_athlete_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_info.md),
[`espn_mbb_athlete_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_overview.md),
[`espn_mbb_athlete_splits()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_splits.md),
[`espn_mbb_athlete_statisticslog()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_statisticslog.md),
[`espn_mbb_athlete_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athlete_stats.md),
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md),
[`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md),
[`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_event_broadcasts()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_broadcasts.md),
[`espn_mbb_event_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_odds.md),
[`espn_mbb_event_officials()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_officials.md),
[`espn_mbb_event_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_event_probabilities.md),
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md),
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
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md),
[`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md),
[`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md),
[`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md),
[`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md),
[`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_profile.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_season_rankings(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Rankings Index ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-18 17:09:50 UTC
#> # A tibble: 2 × 4
#>   league                  season ranking_id ref                                 
#>   <chr>                    <int> <chr>      <chr>                               
#> 1 mens-college-basketball   2025 1          http://sports.core.api.espn.com/v2/…
#> 2 mens-college-basketball   2025 2          http://sports.core.api.espn.com/v2/…
# }
```
