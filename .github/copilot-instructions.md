<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents** _generated with [DocToc](https://github.com/thlorenz/doctoc)_

- [hoopR Copilot Instructions](#hoopr-copilot-instructions)
  - [Project Context](#project-context)
  - [Code Style](#code-style)
  - [Function Naming](#function-naming)
  - [HTTP Layer](#http-layer)
  - [Messaging Layer](#messaging-layer)
  - [Roxygen Documentation](#roxygen-documentation)
  - [Testing](#testing)
    - [Environment Variables](#environment-variables)
  - [Conventional Commits](#conventional-commits)
  - [V3 API Notes](#v3-api-notes)
  - [Common Pitfalls](#common-pitfalls)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# hoopR Copilot Instructions

## Project Context

hoopR is an R package (v3.0.0) that wraps the NBA Stats API, ESPN API, and KenPom. It exports 270+ functions and uses roxygen2 for documentation, testthat for testing, and pkgdown for the documentation site.

When there is any conflict between this file and repository contributor docs, follow `CONTRIBUTING.md` and the current helper/test implementations under `tests/testthat/` as the source of truth.

## Repository Workflow

- Use feature branches for changes.
- `main` is the default branch and release branch. `devel` may be used for active development staging; confirm PR target branch in GitHub before opening a PR.
- For any change to exported functions, update tests and documentation in the same PR.

## Code Style

- Follow tidyverse style: snake_case for variables/functions, 2-space indentation.
- All NBA Stats API functions use `request_with_proxy()` for HTTP calls with required NBA headers.
- Use `%||%` (rlang) for null-safe defaults when parsing API responses.
- All returned data frames must pass through `janitor::clean_names()` then `make_hoopR_data()`.
- Use `pad_id()` for game IDs before passing to the API.
- Internal/non-exported helpers are prefixed with `.` (e.g., `.players_on_court_v3()`).
- Keep imports minimal and explicit; remove unused imports (for example, avoid `@import furrr` unless the file actually uses it).

## HTTP Layer

All HTTP requests use `httr2` as the sole backend. The `httr` package is no longer a dependency.

- `request_with_proxy()` in `utils_nba_stats.R` uses `.retry_request()` (an `httr2` wrapper) with required NBA headers (`x-nba-stats-origin`, `x-nba-stats-token`, `Referer`).
- Shared internal helpers in `utils.R`: `.retry_request()`, `.resp_text()`, `check_status()`.
- KenPom functions use `httr2`-based helpers: `login()` (cookie jar auth), `.kp_get_page()`, `.kp_request()`.
- `nba_endpoint()` builds URLs via `glue::glue('https://stats.nba.com/stats/{endpoint}')` -- does NOT validate against its internal endpoint list.

## Messaging Layer

All user-facing messages use `cli`. The `usethis` package is in `Suggests` only (retained for `usethis::edit_r_environ()` documentation references).

- Internal helpers: `message_completed()` wraps `cli::cli_alert_success()`; `user_message()` dispatches to `cli::cli_alert_success()` / `cli::cli_ul()` / `cli::cli_alert_info()` / `cli::cli_alert_danger()`.
- Inline markup: `{.val x}` for values, `{.file x}` for paths, `{.code x}` for code.

## Function Naming

| Data Source   | Prefix                    | Example                                              |
| ------------- | ------------------------- | ---------------------------------------------------- |
| NBA Stats API | `nba_`                    | `nba_leagueleaders()`, `nba_boxscoretraditionalv3()` |
| ESPN API      | `espn_nba_` / `espn_mbb_` | `espn_nba_pbp()`, `espn_mbb_teams()`                 |
| KenPom        | `kp_`                     | `kp_pomeroy_ratings()`, `kp_box()`                   |
| NBA G-League  | `nbagl_`                  | `nbagl_schedule()`, `nbagl_standings()`              |
| NCAA          | `ncaa_mbb_`               | `ncaa_mbb_teams()`                                   |
| Data loaders  | `load_nba_` / `load_mbb_` | `load_nba_pbp()`, `load_mbb_team_box()`              |

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
- For deprecated endpoints, document with `@description` lifecycle badge and provide replacement guidance.

## Testing

- Use `skip_on_cran()`, `skip_on_ci()`, and `skip_nba_stats_test()` guards.
- Use source-specific guards when applicable: `skip_espn_test()`, `skip_nbagl_stats_test()`, `skip_ncaa_mbb_test()`, `skip_ncaa_wbb_test()`, and `skip_kenpom_test()`.
- Validate columns with `expect_in(sort(expected_cols), sort(colnames(x)))` (subset check, not exact match).
- For dynamic columns, use `expect_true(all(core_cols %in% colnames(x)))`.
- For intermittent endpoints, add explicit skip-on-empty guards before indexing `x[[1]]` or asserting columns.
- For deprecated wrappers, prefer explicit test skips with a replacement note rather than brittle live assertions.
- Add `Sys.sleep(3)` at the end of NBA Stats API tests for rate limiting (~590 req/10 min).
- Test game ID: `"0022200021"` or `"0022201086"` for known completed games.
- Handle empty API responses gracefully in tests (V2 endpoints may return empty for old games).

### Environment Variables

| Variable              | Description                |
| --------------------- | -------------------------- |
| `NBA_STATS_TESTS=1`   | Enable NBA Stats API tests |
| `ESPN_TESTS=1`        | Enable ESPN API tests      |
| `NBAGL_STATS_TESTS=1` | Enable NBA G-League tests  |
| `NCAA_MBB_TESTS=1`    | Enable NCAA MBB tests      |
| `NCAA_WBB_TESTS=1`    | Enable NCAA WBB tests      |
| `KP_USER` / `KP_PW`   | KenPom credentials         |

On CI, most live API tests are additionally guarded with `skip_on_ci()`. Setting env vars alone will not run those tests unless that guard is intentionally relaxed.

### CI Secrets

Current CI workflows rely on:

| Secret         | Description                                  |
| -------------- | -------------------------------------------- |
| `GITHUB_TOKEN` | Auto-provided token for workflow operations  |
| `KP_USER`      | KenPom username/email for credentialed tests |
| `KP_PW`        | KenPom password for credentialed tests       |

Optional env-var secrets (`NBA_STATS_TESTS`, `NBAGL_STATS_TESTS`, `ESPN_TESTS`, `NCAA_MBB_TESTS`) only have effect if corresponding `skip_on_ci()` guards are intentionally adjusted.

## Conventional Commits

Use the format: `type: description`

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `style`, `perf`, `ci`

- Optional scope is encouraged for clarity (e.g., `docs(instructions): ...`, `refactor(espn): ...`).
- Use `type!:` or a `BREAKING CHANGE:` footer for breaking changes.
- Keep commits logically grouped (docs-only, tests-only, refactor-only) so each commit is easy to review and revert.

**Important**: Never include AI agents or assistants (e.g., Claude, Copilot) as co-authors on commits. Omit all `Co-Authored-By` trailers referencing AI tools.

## V3 API Notes

- V3 endpoints return nested JSON -- use `purrr::pluck()` for extraction.
- V3 PBP clock format is `"PT10M30.00S"` not `"MM:SS"`. Parsed with base R `regexec()`/`regmatches()`.
- V3 PBP substitutions: `personId` = outgoing player, incoming parsed from "SUB: IncomingPlayer FOR OutgoingPlayer" in description.
- V3-to-V2 conversion pipeline (`nba_pbp()` V3 path): `nba_playbyplayv3()` -> `.build_player_roster()` -> `.v3_to_v2_format()` -> `.players_on_court_v3()`. Produces V2-compatible columns while retaining V3-only columns (x_legacy, y_legacy, shot_distance, shot_result, is_field_goal, points_total, shot_value).
- `.players_on_court_v3()` uses `nba_gamerotation()` stint data with interval mapping (not substitution-event parsing like V2).
- V3 boxscore endpoints namespace: `boxscoretraditionalv3`, `boxscoreadvancedv3`, etc.
- V3-style leader/standings endpoints (dunkscoreleaders, gravityleaders, iststandings) return flat nested JSON arrays. Parse via `purrr::pluck("key")` -> `dplyr::as_tibble()` -> `dplyr::mutate(across(everything(), as.character))` -> `janitor::clean_names()`.
- V3-style schedule endpoint (scheduleleaguev2int) follows the same nested structure as `nba_schedule()`.
- NBAGL wrappers can follow NBA Stats-backed payloads. In particular, `nbagl_players()` and `nbagl_standings()` may return named lists of data frames (e.g., `PlayerIndex`, `Standings`) rather than a single flat data frame.

## Common Pitfalls

- Always initialize `df_list <- list()` (or `data <- data.frame()` / `data <- list()`) before `tryCatch` blocks.
- ESPN API columns change over time -- use subset validation in tests.
- V3-style leader endpoints return mixed types -- coerce to `as.character()` with `%||% NA_character_`.
- IST Standings has dynamic game columns -- use `expect_true(all(core_cols %in% colnames()))`.
- NBAGL legacy schemas are no longer stable references for tests. Prefer validating core columns from current API payloads and handle named-list returns explicitly in tests.
- Local editor/worktree artifacts (e.g., `.vscode`, `.claude`, temp logs) can cause `R CMD check` notes/warnings if included in source checks.
- Never edit `NAMESPACE` or `man/` files by hand; regenerate with `devtools::document()`.
