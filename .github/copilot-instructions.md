<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [hoopR Copilot Instructions](#hoopr-copilot-instructions)
  - [Project Context](#project-context)
  - [Code Style](#code-style)
  - [Function Naming](#function-naming)
  - [Roxygen Documentation](#roxygen-documentation)
  - [Testing](#testing)
    - [Environment Variables](#environment-variables)
  - [Conventional Commits](#conventional-commits)
  - [V3 API Notes](#v3-api-notes)
  - [Common Pitfalls](#common-pitfalls)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# hoopR Copilot Instructions

## Project Context

hoopR is an R package (v3.0.0 dev) that wraps the NBA Stats API, ESPN API, and KenPom. It exports 270+ functions and uses roxygen2 for documentation, testthat for testing, and pkgdown for the documentation site.

## Code Style

- Follow tidyverse style: snake_case for variables/functions, 2-space indentation.
- All NBA Stats API functions use `request_with_proxy()` for HTTP calls with required NBA headers.
- Use `%||%` (rlang) for null-safe defaults when parsing API responses.
- All returned data frames must pass through `janitor::clean_names()` then `make_hoopR_data()`.
- Use `pad_id()` for game IDs before passing to the API.
- Internal/non-exported helpers are prefixed with `.` (e.g., `.players_on_court_v3()`).

## Function Naming

| Data Source | Prefix | Example |
|---|---|---|
| NBA Stats API | `nba_` | `nba_leagueleaders()`, `nba_boxscoretraditionalv3()` |
| ESPN API | `espn_nba_` / `espn_mbb_` | `espn_nba_pbp()`, `espn_mbb_teams()` |
| KenPom | `kp_` | `kp_pomeroy_ratings()`, `kp_box()` |
| NBA G-League | `nbagl_` | `nbagl_schedule()`, `nbagl_standings()` |
| NCAA | `ncaa_mbb_` | `ncaa_mbb_teams()` |
| Data loaders | `load_nba_` / `load_mbb_` | `load_nba_pbp()`, `load_mbb_team_box()` |

## Roxygen Documentation

Every exported function needs:

- `@name` and `@rdname` tags with `NULL` object
- `@title` with bold markdown description
- `@author` tag
- `@param` for every parameter (including `...`) with descriptive text (e.g., `@param game_id Game ID - 10-digit zero-padded ID (e.g., '0022200021')`)
- `@return` with markdown tables documenting column names and types for each data frame returned
- `@importFrom` for specific function imports
- `@export`
- `@family` for grouping in pkgdown (e.g., "NBA PBP Functions", "NBA Boxscore V3 Functions")
- `@details` with runnable example code block

## Testing

- Use `skip_on_cran()`, `skip_on_ci()`, and `skip_nba_stats_test()` guards.
- Validate columns with `expect_in(sort(expected_cols), sort(colnames(x)))` (subset check, not exact match).
- For dynamic columns, use `expect_true(all(core_cols %in% colnames(x)))`.
- Add `Sys.sleep(3)` at the end of NBA Stats API tests for rate limiting (~590 req/10 min).
- Test game ID: `"0022200021"` or `"0022201086"` for known completed games.
- Handle empty API responses gracefully in tests (V2 endpoints may return empty for old games).

### Environment Variables

| Variable | Description |
|---|---|
| `NBA_STATS_TESTS=1` | Enable NBA Stats API tests |
| `ESPN_TESTS=1` | Enable ESPN API tests |
| `NBAGL_STATS_TESTS=1` | Enable NBA G-League tests |
| `NCAA_MBB_TESTS=1` | Enable NCAA MBB tests |
| `KP_USER` / `KP_PW` | KenPom credentials |

## Conventional Commits

Use the format: `type: description`

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `style`, `perf`, `ci`

**Important**: Never include AI agents or assistants (e.g., Claude, Copilot) as co-authors on commits. Omit all `Co-Authored-By` trailers referencing AI tools.

## V3 API Notes

- V3 endpoints return nested JSON -- use `purrr::pluck()` for extraction.
- V3 PBP clock format is `"PT10M30.00S"` not `"MM:SS"`.
- V3 PBP substitutions have single `personId` (incoming) with outgoing parsed from description.
- V3 boxscore endpoints namespace: `boxscoretraditionalv3`, `boxscoreadvancedv3`, etc.
- V3-style leader/standings endpoints (dunkscoreleaders, gravityleaders, iststandings) return flat nested JSON arrays. Parse via `purrr::pluck("key")` -> `dplyr::as_tibble()` -> `dplyr::mutate(across(everything(), as.character))` -> `janitor::clean_names()`.
- V3-style schedule endpoint (scheduleleaguev2int) follows the same nested structure as `nba_schedule()`.

## Common Pitfalls

- Always initialize `df_list <- list()` before `tryCatch` blocks.
- ESPN API columns change over time -- use subset validation in tests.
- V3-style leader endpoints return mixed types -- coerce to `as.character()` with `%||% NA_character_`.
- IST Standings has dynamic game columns -- use `expect_true(all(core_cols %in% colnames()))`.
