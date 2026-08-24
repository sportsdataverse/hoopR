# hoopR — Health & Tech-Debt Report

> Coupling, centrality, and risk signals derived from the knowledge graph.

## Circular dependencies

**None.** ✅ The file-level import graph is a DAG — every dependency flows one way.

## Coupling — most-depended-upon (afferent) files

| File | Afferent (Ca) | Efferent (Ce) | Instability I=Ce/(Ca+Ce) |
|---|--:|--:|--:|
| `R/cbbd_api_key.R` | 13 | 0 | 0.00 |
| `R/bref_utils.R` | 7 | 0 | 0.00 |
| `R/realgm_utils.R` | 7 | 0 | 0.00 |
| `R/torvik_utils.R` | 6 | 0 | 0.00 |
| `R/crosswalk_basketball.R` | 2 | 0 | 0.00 |
| `data-raw/pull_team_page.R` | 1 | 0 | 0.00 |
| `R/espn_basketball_athlete_helpers.R` | 1 | 0 | 0.00 |
| `R/espn_mbb_data.R` | 1 | 0 | 0.00 |
| `R/nba_metrics.R` | 1 | 0 | 0.00 |
| `R/nba_stats_pbp.R` | 1 | 0 | 0.00 |
| `R/salary_draft_utils.R` | 1 | 0 | 0.00 |
| `data-raw/get_exported_functions.R` | 0 | 0 | — |

## God-file candidates (most members in one file)

| File | Members | Layer |
|---|--:|---|

## Generated / boilerplate & deprecated surface

- **2 files tagged `generated`** — codegen wrapper modules; edit templates, not these.
- **1 deprecated files** (e.g. legacy alias namespaces).

## Orphans (no graph edges)

48 file(s): `get_exported_functions.R`, `markdown_man_table_helper.R`, `mbb_teams.R`, `pull_nba_teams.R`, `sdv_author_helpers.R`, `data.R`, `espn_basketball_athlete_career_helpers.R`, `espn_basketball_awards_helpers.R`, `espn_basketball_coach_helpers.R`, `espn_basketball_draft_helpers.R`, `espn_basketball_franchise_helpers.R`, `espn_basketball_injuries_helpers.R`, `espn_basketball_news_helpers.R`, `espn_basketball_position_helpers.R`, `espn_basketball_tournaments_helpers.R`, `espn_mbb_coach.R`, `espn_mbb_franchise.R`, `espn_mbb_futures.R`, `espn_mbb_injuries.R`, `espn_mbb_news.R`, `espn_mbb_positions.R`, `espn_mbb_powerindex.R`, `espn_mbb_tournaments.R`, `espn_nba_calendar.R`, `espn_nba_coach.R`, `espn_nba_franchise.R`, `espn_nba_futures.R`, `espn_nba_injuries.R`, `espn_nba_news.R`, `espn_nba_positions.R`, `espn_nba_powerindex.R`, `espn_nba_tournaments.R`, `espn_nba_transactions.R`, `fox_basketball.R`, `hoopshype_salaries.R`, `nba_data_pbp.R`, `nba_stats_cume.R`, `nba_stats_draft.R`, `nba_stats_franchise.R`, `nba_stats_roster.R`, `nba_stats_scoreboard.R`, `nba_stats_shotchart.R`, `nba_stats_video.R`, `nbadraft_mock_draft.R`, `ncaa_mbb_data.R`, `rotowire_injuries.R`, `cbbd-college-basketball-data.Rmd`, `espn-endpoints.Rmd`.

## High-complexity units (58)

`CLAUDE.md`, `NEWS.md`, `pull_team_page.R`, `cbbd_games.R`, `cbbd_plays.R`, `cbbd_recruiting.R`, `cbbd_stats.R`, `crosswalk_basketball.R`, `espn_basketball_athlete_career_helpers.R`, `espn_basketball_athlete_helpers.R`, `espn_basketball_draft_helpers.R`, `espn_basketball_event_competitor_helpers.R`, `espn_basketball_event_helpers.R`, `espn_basketball_league_helpers.R`, `espn_basketball_season_meta_helpers.R`, `espn_basketball_team_deep_helpers.R`, `espn_basketball_team_helpers.R`, `espn_mbb_athletes.R`, `espn_mbb_data.R`, `espn_mbb_event_detail.R`
