# **Get ESPN Women's College Basketball Team Detail**

Era-correct team identity for a men's college basketball program in a
specific season, plus the available `$ref` URLs for deeper resources
(record, statistics, leaders, athletes/roster, coaches, college, etc.).
Backed by the core-v2 endpoint
`sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/teams/{team_id}`.

Historical depth goes back to **1939** at ESPN. Older seasons return
fewer `$ref` keys; missing refs become `NA`.

Era-correct team identity for an NBA franchise in a specific season,
plus the available `$ref` URLs for deeper resources (record, statistics,
leaders, coaches, etc.). Backed by the core-v2 endpoint
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/teams/{team_id}`.

Historical depth goes back to **1947** (NBA founding). Older seasons
return fewer `$ref` keys; missing refs become `NA`.

## Usage

``` r
espn_mbb_team(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_roster(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_leaders(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_season_profile(team_id, season = most_recent_mbb_season(), ...)

espn_nba_team(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_roster(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_leaders(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_season_profile(team_id, season = most_recent_nba_season(), ...)
```

## Arguments

- team_id:

  ESPN team identifier (character or numeric).

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of data frames: `Info`, `Record`, `NextEvent`,
`StandingSummary`, `Coaches`.

**Info**

Columns as documented in the shared
[espn_mbb_team_info_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_info_schema.md)
table.

**Record**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| type     | character | Record type / category. |
| summary  | character |                         |
| stats    | list      |                         |

**NextEvent**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**StandingSummary**

|                  |           |             |
|------------------|-----------|-------------|
| col_name         | types     | description |
| standing_summary | character |             |

**Coaches**

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| id         | character | Id.                               |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| experience | integer   | Years of professional experience. |

A single tibble with one row per athlete.

Columns as documented in the shared
[espn_mbb_team_roster_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster_schema.md)
table.

A single long-format tibble (one row per category-rank-athlete).

Columns as documented in the shared
[espn_mbb_team_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders_schema.md)
table.

A single-row tibble with team identity scalars and `_ref` URL columns.
Selected columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN team identifier. |
| guid | character | Stable cross-league team GUID. |
| uid | character | ESPN UID string. |
| slug | character | URL-safe identifier. |
| location | character | School/program location (e.g. "Duke"). |
| name | character | Team name (e.g. "Blue Devils"). |
| nickname | character | Common nickname (often same as location). |
| abbreviation | character | Short abbreviation (e.g. "DUKE"). |
| display_name | character | Full display name. |
| short_display_name | character | Short display name. |
| color | character | Primary color (hex, no leading '#'). |
| alternate_color | character | Alternate color (hex, no leading '#'). |
| is_active | logical | Whether the team was active in this season. |
| season | integer | Season year. |
| logo | character | Primary logo URL. |
| logo_dark | character | Dark-mode logo URL. |
| record_ref | character | `$ref` to team record resource. |
| statistics_ref | character | `$ref` to team statistics resource. |
| athletes_ref | character | `$ref` to team roster resource (college-only). |
| college_ref | character | `$ref` to college (institution) resource. |
| coaches_ref | character | `$ref` to team coaches resource. |
| franchise_ref | character | `$ref` to franchise resource. |

A named list of data frames: `Info`, `Record`, `NextEvent`,
`StandingSummary`, `Coaches`.

**Info**

Columns as documented in the shared
[espn_mbb_team_info_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_info_schema.md)
table.

**Record**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| type     | character | Record type / category. |
| summary  | character |                         |
| stats    | list      |                         |

**NextEvent**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**StandingSummary**

|                  |           |             |
|------------------|-----------|-------------|
| col_name         | types     | description |
| standing_summary | character |             |

**Coaches**

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| id         | character | Id.                               |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| experience | integer   | Years of professional experience. |

A single tibble with one row per athlete.

Columns as documented in the shared
[espn_mbb_team_roster_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster_schema.md)
table.

A single long-format tibble (one row per category-rank-athlete).

Columns as documented in the shared
[espn_mbb_team_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders_schema.md)
table.

A single-row tibble with team identity scalars and `_ref` URL columns.
Selected columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN team identifier. |
| guid | character | Stable cross-league team GUID. |
| uid | character | ESPN UID string. |
| slug | character | URL-safe identifier. |
| location | character | Team city/region (e.g. "Los Angeles"). |
| name | character | Team name (e.g. "Lakers"). |
| abbreviation | character | Short abbreviation (e.g. "LAL"). |
| display_name | character | Full display name. |
| short_display_name | character | Short display name. |
| color | character | Primary color (hex, no leading '#'). |
| alternate_color | character | Alternate color (hex, no leading '#'). |
| is_active | logical | Whether the team was active in this season. |
| season | integer | Season year. |
| logo | character | Primary logo URL. |
| logo_dark | character | Dark-mode logo URL. |
| record_ref | character | `$ref` to team record resource (if present). |
| statistics_ref | character | `$ref` to team statistics resource (if present). |
| leaders_ref | character | `$ref` to team leaders resource (if present). |
| coaches_ref | character | `$ref` to team coaches resource (if present). |
| depth_charts_ref | character | `$ref` to depth chart resource (NBA-only). |
| events_ref | character | `$ref` to team events resource (if present). |
| transactions_ref | character | `$ref` to team transactions resource (if present). |
| franchise_ref | character | `$ref` to franchise resource. |

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
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
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
[`espn_mbb_player_overview()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_overview.md),
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
  espn_mbb_team(team_id = "150", season = 2025)
#> $Info
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Info from ESPN.com ───────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:32 UTC
#> # A tibble: 1 × 13
#>   id    uid    slug  abbreviation display_name short_display_name name  nickname
#>   <chr> <chr>  <chr> <chr>        <chr>        <chr>              <chr> <chr>   
#> 1 150   s:40~… duke… DUKE         Duke Blue D… Duke               Blue… Duke    
#> # ℹ 5 more variables: location <chr>, color <chr>, alternate_color <chr>,
#> #   logo <chr>, logo_dark <chr>
#> 
#> $Record
#> data frame with 0 columns and 0 rows
#> 
#> $NextEvent
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Next Event from ESPN.com ─── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:32 UTC
#> # A tibble: 1 × 4
#>   id        date              name                                   short_name 
#>   <chr>     <chr>             <chr>                                  <chr>      
#> 1 401909562 2026-11-02T05:00Z Army Black Knights at Duke Blue Devils ARMY @ DUKE
#> 
#> $StandingSummary
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Standing Summary from ESPN.com ────────────
#> ℹ Data updated: 2026-08-27 17:47:32 UTC
#> # A tibble: 1 × 1
#>   standing_summary
#>   <chr>           
#> 1 1st in ACC      
#> 
#> $Coaches
#> data frame with 0 columns and 0 rows
#> 
# }
# \donttest{
  espn_mbb_team_roster(team_id = "150", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Roster from ESPN.com ─────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 11 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 5041937    Cayden B… 2      G               Guard         "6' 4… 205 l… NA   
#>  2 5341547    Brock Da… 50     G               Guard         "6' 4… 195 l… NA   
#>  3 4711256    Caleb Fo… 1      G               Guard         "6' 5… 205 l… NA   
#>  4 4873107    Darren H… 8      G               Guard         "6' 5… 195 l… NA   
#>  5 5144124    Nikolas … 14     G               Guard         "6' 8… 215 l… NA   
#>  6 4873209    Patrick … 21     C               Center        "6' 1… 250 l… NA   
#>  7 5287474    Dame Sarr 7      G               Guard         "6' 8… 190 l… NA   
#>  8 4888720    Jack Sco… 20     G               Guard         "6' 6… 220 l… NA   
#>  9 4432321    Cameron … 13     G               Guard         "6' 6… 205 l… NA   
#> 10 5107141    Ifeanyi … 15     C               Center        "6' 1… 240 l… NA   
#> 11 5144150    Sebastia… 5      G               Guard         "6' 8… 220 l… NA   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
# }
# \donttest{
  espn_mbb_team_leaders(team_id = "150", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_team_season_profile(team_id = "150", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Season Profile from ESPN.com ──────────────
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 1 × 35
#>   id    guid       uid   slug  location name  nickname abbreviation display_name
#>   <chr> <chr>      <chr> <chr> <chr>    <chr> <chr>    <chr>        <chr>       
#> 1 150   c4430c6c-… s:40… duke… Duke     Blue… Duke     DUKE         Duke Blue D…
#> # ℹ 26 more variables: short_display_name <chr>, color <chr>,
#> #   alternate_color <chr>, is_active <lgl>, is_all_star <lgl>, season <int>,
#> #   logo <chr>, logo_dark <chr>, record_ref <chr>, venue_ref <chr>,
#> #   groups_ref <chr>, ranks_ref <chr>, statistics_ref <chr>, leaders_ref <chr>,
#> #   injuries_ref <chr>, notes_ref <chr>, against_the_spread_records_ref <chr>,
#> #   awards_ref <chr>, franchise_ref <chr>, depth_charts_ref <chr>,
#> #   events_ref <chr>, transactions_ref <chr>, coaches_ref <chr>, …
# }
# \donttest{
  espn_nba_team(team_id = "13", season = 2025)
#> $Info
#> ── ESPN NBA Team Info from ESPN.com ───────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 1 × 12
#>   id    uid    slug  abbreviation display_name short_display_name name  location
#>   <chr> <chr>  <chr> <chr>        <chr>        <chr>              <chr> <chr>   
#> 1 13    s:40~… los-… LAL          Los Angeles… Lakers             Lake… Los Ang…
#> # ℹ 4 more variables: color <chr>, alternate_color <chr>, logo <chr>,
#> #   logo_dark <chr>
#> 
#> $Record
#> data frame with 0 columns and 0 rows
#> 
#> $NextEvent
#> ── ESPN NBA Team Next Event from ESPN.com ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 1 × 4
#>   id        date              name                                   short_name
#>   <chr>     <chr>             <chr>                                  <chr>     
#> 1 401898716 2026-10-06T02:00Z Los Angeles Lakers at Sacramento Kings LAL @ SAC 
#> 
#> $StandingSummary
#> ── ESPN NBA Team Standing Summary from ESPN.com ───────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 1 × 1
#>   standing_summary       
#>   <chr>                  
#> 1 1st in Pacific Division
#> 
#> $Coaches
#> data frame with 0 columns and 0 rows
#> 
# }
# \donttest{
  espn_nba_team_roster(team_id = "13", season = 2025)
#> ── ESPN NBA Team Roster from ESPN.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 18 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 5113969    Cameron … NA     G               Guard         "6' 5… 184 l… 21   
#>  2 3945274    Luka Don… 77     G               Guard         "6' 8… 230 l… 27   
#>  3 4397014    Quentin … NA     G               Guard         "6' 4… 210 l… 26   
#>  4 4868423    Jaden Ha… NA     G               Guard         "6' 3… 198 l… 24   
#>  5 4683774    Bronny J… 9      G               Guard         "6' 2… 210 l… 21   
#>  6 4433136    Walker K… NA     C               Center        "7' 2… 245 l… 25   
#>  7 4897943    Dalton K… 4      F               Forward       "6' 6… 215 l… 25   
#>  8 4592691    Jake LaR… 12     F               Forward       "6' 7… 235 l… 24   
#>  9 3155535    Kevon Lo… NA     F               Forward       "6' 9… 222 l… 30   
#> 10 4278580    Sandro M… NA     F               Forward       "6' 9… 240 l… 27   
#> 11 4702972    Chris Ma… 30     G               Guard         "6' 4… 209 l… 24   
#> 12 5114350    AK Okere… NA     F               Forward       "6' 7… 244 l… 23   
#> 13 4066457    Austin R… 15     G               Guard         "6' 5… 197 l… 28   
#> 14 4277811    Collin S… NA     G               Guard         "6' 3… 190 l… 27   
#> 15 5060631    Adou Thi… 1      F               Forward       "6' 8… 220 l… 22   
#> 16 3907498    Matisse … NA     G               Guard         "6' 5… 202 l… 29   
#> 17 4278077    Jarred V… 2      F               Forward       "6' 8… 214 l… 27   
#> 18 4433137    Ziaire W… NA     F               Forward       "6' 9… 185 l… 24   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
# }
# \donttest{
  espn_nba_team_leaders(team_id = "13", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_team_season_profile(team_id = "13", season = 2025)
#> ── ESPN NBA Team Season Profile from ESPN.com ─────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-27 17:47:33 UTC
#> # A tibble: 1 × 35
#>   id    guid       uid   slug  location name  nickname abbreviation display_name
#>   <chr> <chr>      <chr> <chr> <chr>    <chr> <lgl>    <chr>        <chr>       
#> 1 13    2876e98b-… s:40… los-… Los Ang… Lake… NA       LAL          Los Angeles…
#> # ℹ 26 more variables: short_display_name <chr>, color <chr>,
#> #   alternate_color <chr>, is_active <lgl>, is_all_star <lgl>, season <int>,
#> #   logo <chr>, logo_dark <chr>, record_ref <chr>, venue_ref <chr>,
#> #   groups_ref <chr>, ranks_ref <chr>, statistics_ref <chr>, leaders_ref <chr>,
#> #   injuries_ref <chr>, notes_ref <chr>, against_the_spread_records_ref <chr>,
#> #   awards_ref <chr>, franchise_ref <chr>, depth_charts_ref <chr>,
#> #   events_ref <chr>, transactions_ref <chr>, coaches_ref <chr>, …
# }
```
