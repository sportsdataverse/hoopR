# **Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Overview**

**Get ESPN Women's College Basketball Athlete Stats**

**Get ESPN Women's College Basketball Athlete Gamelog**

**Get ESPN Women's College Basketball Athlete Splits**

**Get ESPN Women's College Basketball Athlete Eventlog**

**Get ESPN Women's College Basketball Athlete Statisticslog**

**Get ESPN NBA Athlete Overview**

**Get ESPN NBA Athlete Overview**

**Get ESPN NBA Athlete Stats**

**Get ESPN NBA Athlete Gamelog**

**Get ESPN NBA Athlete Splits**

**Get ESPN NBA Athlete Eventlog**

**Get ESPN NBA Athlete Statisticslog**

## Usage

``` r
espn_mbb_player_overview(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_stats_v3(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_gamelog(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_splits(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_eventlog(athlete_id, season = most_recent_mbb_season(), ...)

espn_mbb_player_statisticslog(
  athlete_id,
  season = most_recent_mbb_season(),
  ...
)

espn_nba_player_overview(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_stats_v3(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_gamelog(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_splits(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_eventlog(athlete_id, season = most_recent_nba_season(), ...)

espn_nba_player_statisticslog(
  athlete_id,
  season = most_recent_nba_season(),
  ...
)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- ...:

  Additional arguments; currently unused.

## Value

A named list of data frames: `Statistics`, `NextGame`, `Last5Games`,
`Headlines`, `FantasyOutlook`.

**Statistics**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**NextGame**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**Last5Games**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**Headlines**

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |

**FantasyOutlook**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

A named list of per-category tibbles. Default category names are
`General`, `Offensive`, `Defensive`, `Rebounding`, `Shooting`, `Misc`.
Actual names are driven by the ESPN response; additional categories may
appear. Each tibble has columns depending on the category returned by
ESPN.

A single tibble with one row per game. Column names reflect the stat
labels returned by ESPN and will vary by season and player.

A single long-format tibble. When data are present, columns include at
minimum `category` and `split_name`, plus per-stat columns driven by
ESPN labels.

A single tibble. Per-event `statistics.$ref` URLs from the ESPN core-v2
API are returned as the character column `statistics_ref` and are NOT
resolved. Similarly, `event_ref`, `competition_ref`, and `team_ref` are
returned as character columns.

Columns as documented in the shared
[espn_mbb_player_eventlog_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_schema.md)
table.

A single tibble. When resolved, each row corresponds to one statistical
entry in the core-v2 statistics log, with `event_ref` and
`statistics_ref` character columns pointing to resolvable ESPN
endpoints.

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| event_ref      | character | Reference link to the originating event. |
| statistics_ref | character |                                          |

A named list of data frames: `Statistics`, `NextGame`, `Last5Games`,
`Headlines`, `FantasyOutlook`.

**Statistics**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**NextGame**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**Last5Games**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

**Headlines**

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| headline    | character | News headline.                    |
| description | character | Long-form description text.       |
| published   | character | Publication timestamp (ISO 8601). |

**FantasyOutlook**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| (varies) | character |             |

A named list of per-category tibbles. Default category names are
`General`, `Offensive`, `Defensive`, `Rebounding`, `Shooting`, `Misc`.
Actual names are driven by the ESPN response; additional categories may
appear. Each tibble has columns depending on the category returned by
ESPN.

A single tibble with one row per game. Column names reflect the stat
labels returned by ESPN and will vary by season and player.

A single long-format tibble. When data are present, columns include at
minimum `category` and `split_name`, plus per-stat columns driven by
ESPN labels.

A single tibble. Per-event `statistics.$ref` URLs from the ESPN core-v2
API are returned as the character column `statistics_ref` and are NOT
resolved. Similarly, `event_ref`, `competition_ref`, and `team_ref` are
returned as character columns.

Columns as documented in the shared
[espn_mbb_player_eventlog_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_schema.md)
table.

A single tibble. When resolved, each row corresponds to one statistical
entry in the core-v2 statistics log, with `event_ref` and
`statistics_ref` character columns pointing to resolvable ESPN
endpoints.

|                |           |                                          |
|----------------|-----------|------------------------------------------|
| col_name       | types     | description                              |
| event_ref      | character | Reference link to the originating event. |
| statistics_ref | character |                                          |

## See also

Other ESPN MBB Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
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
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
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
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

Other ESPN NBA Functions:
[`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md),
[`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md),
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
[`espn_mbb_game_odds()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_odds.md),
[`espn_mbb_game_official_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_official_detail.md),
[`espn_mbb_game_play()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play.md),
[`espn_mbb_game_play_personnel()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_play_personnel.md),
[`espn_mbb_game_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_player_box.md),
[`espn_mbb_game_probabilities()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_probabilities.md),
[`espn_mbb_game_propbets()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_propbets.md),
[`espn_mbb_game_team_linescores()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md),
[`espn_mbb_game_team_roster_entry()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_roster_entry.md),
[`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md),
[`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md),
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md),
[`espn_mbb_player_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_awards.md),
[`espn_mbb_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_career_stats.md),
[`espn_mbb_player_eventlog_v2()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_eventlog_v2.md),
[`espn_mbb_player_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_info.md),
[`espn_mbb_player_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_seasons.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md),
[`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md),
[`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md),
[`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md),
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
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md),
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md),
[`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md),
[`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md),
[`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md),
[`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md),
[`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md),
[`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md),
[`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md),
[`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md),
[`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md),
[`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md),
[`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md),
[`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md),
[`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md),
[`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md),
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md),
[`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md),
[`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_player_overview(athlete_id = "4593919", season = 2025)
#> $Statistics
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Statistics from ESPN.com ──────
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $NextGame
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview NextGame from ESPN.com ────────
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 1 × 4
#>   id    date  name  short_name
#>   <chr> <chr> <chr> <chr>     
#> 1 NA    NA    NA    NA        
#> 
#> $Last5Games
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Last5Games from ESPN.com ──────
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Headlines
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview Headlines from ESPN.com ───────
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 13 × 5
#>    headline                                   description published byline type 
#>    <chr>                                      <chr>       <chr>     <chr>  <chr>
#>  1 Projecting every Big 12 team's floor and … "Predictin… 2026-08-… Myron… Story
#>  2 SEC draws rule to stop NFL, NBA, WNBA pla… "After the… 2026-08-… Heath… Head…
#>  3 RJ Luis Jr., '25 Big East POY, granted in… "A Louisia… 2026-08-… Myron… Head…
#>  4 SEC: Pro athletes should not 'return to c… "As LSU ho… 2026-08-… Heath… Head…
#>  5 Ex-Mizzou star Mitchell picks Kentucky af… "Former Mi… 2026-08-… Myron… Head…
#>  6 College basketball eligibility: What to k… "College b… 2026-08-… Myron… Story
#>  7 Iowa State's Toure has surgery, expected … "Iowa Stat… 2026-08-… NA     Head…
#>  8 Court halts order, denies extra year of e… "In a lega… 2026-08-… Dan M… Head…
#>  9 Kohler, eligible for fifth year after inj… "Former Mi… 2026-08-… Myron… Head…
#> 10 Jury rules New York Times defamed Alabama… "An Alabam… 2026-08-… NA     Head…
#> 11 Greg Sankey, in filing, speaks out agains… "SEC commi… 2026-08-… Dan M… Head…
#> 12 NCAA lands new deal to promote championsh… "The NCAA … 2026-08-… NA     Head…
#> 13 NBA draft: Early players to watch from th… "After a s… 2026-08-… Jerem… Story
#> 
#> $FantasyOutlook
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Overview FantasyOutlook from ESPN.com ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_stats_v3(athlete_id = "4593919", season = 2025)
#> $`Season Averages`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [18]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [18]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [18]> G       
#> 
#> $`Season Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [15]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [15]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [15]> G       
#> 
#> $`Season Misc Totals`
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 3 × 5
#>   team_id team_slug              season$year $displayName stats      position
#>   <chr>   <chr>                        <int> <chr>        <list>     <chr>   
#> 1 250     ut-arlington-mavericks        2020 2019-20      <chr [11]> G       
#> 2 250     ut-arlington-mavericks        2021 2020-21      <chr [11]> G       
#> 3 250     ut-arlington-mavericks        2022 2021-22      <chr [11]> G       
#> 
#> $General
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Stats from ESPN.com ───── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_mbb_player_gamelog(athlete_id = "4593919", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_player_splits(athlete_id = "4593919", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Splits from ESPN.com ──── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:53 UTC
#> # A tibble: 1 × 2
#>   name  display_name
#>   <chr> <chr>       
#> 1 split split       
# }
# \donttest{
  espn_mbb_player_eventlog(athlete_id = "4593919", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_player_statisticslog(athlete_id = "4593919", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Statisticslog from ESPN.com ────────────
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 3 × 2
#>   season$`$ref`                                                       statistics
#>   <chr>                                                               <list>    
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 2 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
#> 3 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-… <df>      
# }
# \donttest{
  espn_nba_player_overview(athlete_id = "1966", season = 2024)
#> $Statistics
#> ── ESPN NBA Athlete Overview Statistics from ESPN.com ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $NextGame
#> ── ESPN NBA Athlete Overview NextGame from ESPN.com ───────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 1 × 4
#>   id    date  name  short_name
#>   <chr> <chr> <chr> <chr>     
#> 1 NA    NA    NA    NA        
#> 
#> $Last5Games
#> ── ESPN NBA Athlete Overview Last5Games from ESPN.com ─────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Headlines
#> ── ESPN NBA Athlete Overview Headlines from ESPN.com ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 13 × 5
#>    headline                                   description published byline type 
#>    <chr>                                      <chr>       <chr>     <chr>  <chr>
#>  1 2026 NBA buzz: Latest free agency and tra… "We're tra… 2026-08-… ESPN   Story
#>  2 PGA Tour CEO excited to partner with LeBr… "PGA Tour … 2026-08-… NA     Media
#>  3 Cam'ron trolls Clippers' Ty Lue on LeBron… "James rea… 2026-08-… Kalan… Story
#>  4 LeBron James, PGA Tour partner on event f… "The LeBro… 2026-08-… Mark … Head…
#>  5 Shaq: It's 'championship or bust' for LeB… "Shaq: It'… 2026-08-… NA     Media
#>  6 LeBron nearly sinks his first hole-in-one  "LeBron ne… 2026-08-… NA     Media
#>  7 LeBron James launches YouTube golf ventur… "New 76ers… 2026-08-… NA     Head…
#>  8 Rory: I'd love to give LeBron a golf less… "Rory: I'd… 2026-08-… NA     Media
#>  9 Knicks-Sixers, Lakers-Warriors highlight … "A second … 2026-08-… NA     Head…
#> 10 Philly artist paints LeBron mural in Chin… "The mural… 2026-08-… Antho… Story
#> 11 Cohen: LeBron's still the face of the NBA  "Cohen: Le… 2026-08-… NA     Media
#> 12 Why Malika Andrews is excited for LeBron'… "Why Malik… 2026-08-… NA     Media
#> 13 Champion Knicks to face Sixers, LeBron in… "The NBA a… 2026-08-… Micha… Head…
#> 
#> $FantasyOutlook
#> ── ESPN NBA Athlete Overview FantasyOutlook from ESPN.com ─────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 1 × 1
#>   outlook
#>   <chr>  
#> 1 NA     
#> 
# }
# \donttest{
  espn_nba_player_stats_v3(athlete_id = "1966", season = 2024)
#> $`Regular Season Averages`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [18]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [18]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [18]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [18]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [18]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [18]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [18]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [18]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [18]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [18]> F       
#> # ℹ 13 more rows
#> 
#> $`Regular Season Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [15]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [15]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [15]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [15]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [15]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [15]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [15]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [15]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [15]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [15]> F       
#> # ℹ 13 more rows
#> 
#> $`Regular Season Misc Totals`
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 23 × 5
#>    team_id team_slug           season$year $displayName stats      position
#>    <chr>   <chr>                     <int> <chr>        <list>     <chr>   
#>  1 5       cleveland-cavaliers        2004 2003-04      <chr [10]> F       
#>  2 5       cleveland-cavaliers        2005 2004-05      <chr [10]> F       
#>  3 5       cleveland-cavaliers        2006 2005-06      <chr [10]> F       
#>  4 5       cleveland-cavaliers        2007 2006-07      <chr [10]> F       
#>  5 5       cleveland-cavaliers        2008 2007-08      <chr [10]> F       
#>  6 5       cleveland-cavaliers        2009 2008-09      <chr [10]> F       
#>  7 5       cleveland-cavaliers        2010 2009-10      <chr [10]> F       
#>  8 14      miami-heat                 2011 2010-11      <chr [10]> F       
#>  9 14      miami-heat                 2012 2011-12      <chr [10]> F       
#> 10 14      miami-heat                 2013 2012-13      <chr [10]> F       
#> # ℹ 13 more rows
#> 
#> $General
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Offensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Defensive
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Rebounding
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Shooting
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
#> $Misc
#> ── ESPN NBA Athlete Stats from ESPN.com ───────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_nba_player_gamelog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Gamelog from ESPN.com ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 82 × 24
#>    id        at_vs game_date     score home_team_id away_team_id home_team_score
#>    <chr>     <chr> <chr>         <chr> <chr>        <chr>        <chr>          
#>  1 401655085 @     2024-04-30T0… 108-… 7            13           108            
#>  2 401655084 vs    2024-04-28T0… 119-… 13           7            119            
#>  3 401655083 vs    2024-04-26T0… 112-… 13           7            105            
#>  4 401655082 @     2024-04-23T0… 101-… 7            13           101            
#>  5 401654758 @     2024-04-21T0… 114-… 7            13           114            
#>  6 401654655 @     2024-04-16T2… 110-… 3            13           106            
#>  7 401585823 @     2024-04-14T1… 124-… 3            13           108            
#>  8 401585805 @     2024-04-13T0… 123-… 29           13           120            
#>  9 401585783 vs    2024-04-10T0… 134-… 13           9            120            
#> 10 401585755 vs    2024-04-06T1… 116-… 13           5            116            
#> # ℹ 72 more rows
#> # ℹ 17 more variables: away_team_score <chr>, game_result <chr>,
#> #   league_name <chr>, league_abbreviation <chr>, league_short_name <chr>,
#> #   event_note <chr>, team_id <chr>, team_uid <chr>, team_abbreviation <chr>,
#> #   team_logo <chr>, team_is_all_star <chr>, opponent_id <chr>,
#> #   opponent_uid <chr>, opponent_display_name <chr>,
#> #   opponent_abbreviation <chr>, opponent_logo <chr>, event_id <chr>
# }
# \donttest{
  espn_nba_player_splits(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Splits from ESPN.com ──────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 6 × 3
#>   name       display_name splits       
#>   <chr>      <chr>        <list>       
#> 1 split      split        <df [6 × 3]> 
#> 2 byMonth    Month        <df [9 × 3]> 
#> 3 byResult   Result       <df [2 × 3]> 
#> 4 byPosition Position     <df [1 × 3]> 
#> 5 byDay      Day          <df [7 × 3]> 
#> 6 byOpponent Opponent     <df [28 × 3]>
# }
# \donttest{
  espn_nba_player_eventlog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Eventlog from ESPN.com ────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:54 UTC
#> # A tibble: 25 × 6
#>    event_ref              competition_ref team_ref statistics_ref team_id played
#>    <chr>                  <chr>           <chr>    <chr>          <chr>   <lgl> 
#>  1 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  2 http://sports.core.ap… http://sports.… NA       NA             13      FALSE 
#>  3 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  4 http://sports.core.ap… http://sports.… NA       NA             13      FALSE 
#>  5 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  6 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  7 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  8 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#>  9 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#> 10 http://sports.core.ap… http://sports.… NA       http://sports… 13      TRUE  
#> # ℹ 15 more rows
# }
# \donttest{
  espn_nba_player_statisticslog(athlete_id = "1966", season = 2024)
#> ── ESPN NBA Athlete Statisticslog from ESPN.com ───────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:54:55 UTC
#> # A tibble: 23 × 2
#>    season$`$ref`                                                      statistics
#>    <chr>                                                              <list>    
#>  1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  2 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  3 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  4 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  5 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  6 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  7 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  8 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#>  9 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#> 10 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/… <df>      
#> # ℹ 13 more rows
# }
```
