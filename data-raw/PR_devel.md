<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Pull Request](#pull-request)
  - [Summary](#summary)
  - [Type of Change](#type-of-change)
  - [Related Issues](#related-issues)
  - [Background & Context](#background--context)
  - [Changes Made](#changes-made)
    - [New Functions (9)](#new-functions-9)
    - [Bug Fixes](#bug-fixes)
    - [Documentation](#documentation)
    - [Infrastructure](#infrastructure)
  - [Submission Checklist](#submission-checklist)
  - [Testing](#testing)
    - [New Endpoints Tested](#new-endpoints-tested)
    - [Test Robustness Improvements](#test-robustness-improvements)
    - [Environment Variables](#environment-variables)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Pull Request

## Summary

Major release (v3.0.0) adding NBA Stats V3 endpoint support, 9 new API wrappers, ESPN/G-League roster functions, 147 df_list initialization bug fixes, and significant test infrastructure improvements.

## Type of Change

- [x] `feat`: New feature
- [x] `fix`: Bug fix
- [x] `docs`: Documentation only
- [x] `test`: Adding or updating tests
- [x] `refactor`: Code refactoring (no functional change)
- [x] `chore`: Maintenance / tooling
- [x] `ci`: CI/CD improvements

## Related Issues

- Adds V3 play-by-play and boxscore summary endpoints
- Ports missing NBA Stats API endpoints (dunkscoreleaders, gravityleaders, iststandings, etc.)
- Fixes widespread `df_list` initialization bug across 147 functions

## Background & Context

The NBA Stats API has been migrating endpoints to V3, which returns nested JSON instead of the tabular `resultSets` format used by V2. This release adds V3 wrappers for play-by-play and boxscore summary, plus several previously missing NBA Stats API endpoints. The `df_list` initialization fix prevents crashes when API calls fail inside `tryCatch` blocks — previously, an uninitialized `df_list` would cause a secondary error on `return(df_list)`. Test infrastructure was overhauled to use subset validation (`expect_in()`) instead of exact column matching, making tests resilient to API column additions.

## Changes Made

| File/Resource | Change Description |
| ------------- | ------------------ |
| `R/nba_stats_pbp.R` | Added `nba_playbyplayv3()` wrapper, `.v3_to_v2_format()` V3-to-V2 converter, `.build_player_roster()` roster resolver, rewrote `.players_on_court_v3()` to use `nba_gamerotation()` stint data, changed `nba_pbp()`/`nba_pbps()` default to `version = "v3"`, made `p` parameter optional, fixed `data` init before tryCatch |
| `R/nba_stats_boxscore_v3.R` | Added `nba_boxscoresummaryv3()` returning 9 data frames |
| `R/nba_stats_roster.R` | Added `nba_commonteamyears()` |
| `R/nba_stats_leaders.R` | Added `nba_dunkscoreleaders()`, `nba_gravityleaders()` |
| `R/nba_stats_league.R` | Added `nba_iststandings()` |
| `R/nba_stats_scoreboard.R` | Added `nba_scheduleleaguev2int()` |
| `R/nba_stats_team.R` | Added `nba_teamandplayersvsplayers()` |
| `R/nba_stats_video.R` | Added `nba_videoeventsasset()` |
| `R/espn_mbb_data.R` | Added `espn_mbb_team_current_roster()` |
| `R/espn_nba_data.R` | Added `espn_nba_team_current_roster()` |
| `R/nbagl_schedule.R` | Added `nbagl_live_pbp()`, `nbagl_live_boxscore()` |
| `R/nba_stats_*.R` (147 files) | Initialized `df_list <- list()` before `tryCatch` blocks |
| `R/nba_data_pbp.R` | Initialized `plays_df` before `tryCatch` |
| `tests/testthat/helper-skip.R` | Fixed string comparison in skip guards |
| `tests/testthat/test-*.R` (100+ files) | Converted 400+ `expect_equal(colnames())` to `expect_in()` |
| `NEWS.md` | Documented all v3.0.0 changes with fix counts |
| `cran-comments.md` | Updated release summary with bug fix details |
| `CLAUDE.md` | Fixed function template (df_list init, return, @return tables, @param format), added no-coauthor commit rule, documented V3-to-V2 conversion pipeline and new helpers |
| `.github/copilot-instructions.md` | Added @param descriptive format guidance, no-coauthor rule, V3-to-V2 conversion pipeline docs, updated substitution direction note |
| `_pkgdown.yml` | Added `.players_on_court_v3`, `.v3_to_v2_format`, `.build_player_roster` to helper functions reference |
| `CONTRIBUTING.md` | Added comprehensive contributor guide |
| `.github/workflows/*.yaml` | Updated GitHub Actions to v4 |
| `.Rbuildignore` | Cleaned up duplicate patterns |
| `data-raw/PR_devel.md` | This file — comprehensive PR summary |

### New Functions (9 exported + 3 internal helpers)
- `nba_playbyplayv3()` — NBA Stats PlayByPlayV3 endpoint
- `.v3_to_v2_format()` — Internal helper converting V3 PBP to V2-compatible format with event type mapping and player resolution
- `.build_player_roster()` — Internal helper retrieving player roster from boxscore for name-to-ID resolution
- `.players_on_court_v3()` — Internal helper (rewritten) using `nba_gamerotation()` stint data for on-court player determination
- `nba_boxscoresummaryv3()` — NBA Stats BoxScoreSummaryV3 endpoint (9 data frames)
- `nba_commonteamyears()` — Team IDs with active year ranges
- `nba_dunkscoreleaders()` — Dunk tracking biomechanics data
- `nba_gravityleaders()` — Gravity scores (defensive attention metrics)
- `nba_iststandings()` — In-Season Tournament (NBA Cup) standings
- `nba_scheduleleaguev2int()` — International schedule with broadcasters
- `nba_teamandplayersvsplayers()` — Lineup comparison stats (5 datasets)
- `nba_videoeventsasset()` — Video event asset data

### Bug Fixes
- Fixed `df_list` not initialized before `tryCatch` in 147 functions (crash on API failure)
- Fixed `nba_data_pbp()` `plays_df` not initialized before `tryCatch`
- Fixed `nba_dunkscoreleaders()` HTTP 400 from empty string params
- Fixed V3-style leader/standings data.frame parsing
- Fixed `nba_iststandings()` nested games column flattening
- Fixed `helper-skip.R` string comparison for env var guards
- Fixed `%||%` import for R < 4.4.0 compatibility
- Fixed `data` not initialized before `tryCatch` in `nba_playbyplayv3()` and `nba_pbp()` (crash on API failure)
- Removed `stringr::str_match` import from NAMESPACE (replaced with base R regex)

### Documentation
- Updated function template in CLAUDE.md to match actual codebase pattern
- Added @return markdown column tables to function template
- Added descriptive @param format guidance to copilot-instructions.md
- Added no-coauthor commit rule to CLAUDE.md and copilot-instructions.md
- Updated NEWS.md and cran-comments.md with df_list fix counts and test conversion details
- Added `.players_on_court_v3` to pkgdown helper reference

### Infrastructure
- Updated GitHub Actions to v4
- Cleaned up `.Rbuildignore` duplicates
- Added comprehensive `CONTRIBUTING.md`

## Submission Checklist

- [x] Code follows tidyverse style (`snake_case`, 2-space indent)
- [x] `devtools::document()` has been run (NAMESPACE updated)
- [x] New/changed functions have roxygen docs with `@export`, `@family`, `@return` tables
- [x] Tests added/updated in `tests/testthat/`
- [x] `devtools::check()` passes with no errors or warnings
- [x] NEWS.md updated (if user-facing change)
- [x] Commit messages use conventional commit format (`type: description`)

## Testing

### New Endpoints Tested

| Function | Game ID / Parameters | Status |
|---|---|---|
| `nba_playbyplayv3()` | `game_id = "0022200021"` | Pass |
| `nba_boxscoresummaryv3()` | `game_id = "0022200021"` | Pass |
| `nba_commonteamyears()` | default | Pass |
| `nba_dunkscoreleaders()` | default | Pass |
| `nba_gravityleaders()` | default | Pass |
| `nba_iststandings()` | default | Pass |
| `nba_scheduleleaguev2int()` | default | Pass |
| `nba_teamandplayersvsplayers()` | default | Skip (NBA server-side error) |
| `nba_videoeventsasset()` | `game_id = "0022200021"`, `game_event_id = "1"` | Pass |

### Test Robustness Improvements

- Converted 400+ `expect_equal(colnames(...))` assertions to `expect_in(sort(cols), sort(colnames(...)))` for subset validation
- ESPN and NBA Stats API tests now handle empty results gracefully
- Removed "active" column from ESPN MBB player box tests (ESPN dropped the column)

### Environment Variables

All tests run locally with:
```
NBA_STATS_TESTS=1
ESPN_TESTS=1
NBAGL_STATS_TESTS=1
NCAA_MBB_TESTS=1
```
