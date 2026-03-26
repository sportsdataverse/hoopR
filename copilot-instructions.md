# hoopR Copilot Instructions

- [hoopR Copilot Instructions](#hoopr-copilot-instructions)
  - [Project Context](#project-context)
  - [Repository Workflow](#repository-workflow)
  - [Code Style](#code-style)
  - [HTTP Layer](#http-layer)
  - [Messaging Layer](#messaging-layer)
  - [Function Naming](#function-naming)
  - [Roxygen Documentation](#roxygen-documentation)
  - [Testing](#testing)
    - [Environment Variables](#environment-variables)
    - [CI Secrets](#ci-secrets)
  - [Conventional Commits](#conventional-commits)
  - [V3 API Notes](#v3-api-notes)
  - [Common Pitfalls](#common-pitfalls)

## Project Context

hoopR is an R package (v3.0.0) that wraps the NBA Stats API, ESPN API,
and KenPom. It exports 270+ functions and uses roxygen2 for
documentation, testthat for testing, and pkgdown for the documentation
site.

When there is any conflict between this file and repository contributor
docs, follow `CONTRIBUTING.md` and the current helper/test
implementations under `tests/testthat/` as the source of truth.

## Repository Workflow

- Use feature branches for changes.
- `main` is the default branch and release branch. `devel` may be used
  for active development staging; confirm PR target branch in GitHub
  before opening a PR.
- For any change to exported functions, update tests and documentation
  in the same PR.

## Code Style

- Follow tidyverse style: snake_case for variables/functions, 2-space
  indentation.
- All NBA Stats API functions use
  [`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
  for HTTP calls with required NBA headers.
- Use `%||%` (rlang) for null-safe defaults when parsing API responses.
- All returned data frames must pass through
  [`janitor::clean_names()`](https://sfirke.github.io/janitor/reference/clean_names.html)
  then `make_hoopR_data()`.
- Use `pad_id()` for game IDs before passing to the API.
- Internal/non-exported helpers are prefixed with `.` (e.g.,
  [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md)).
- Keep imports minimal and explicit; remove unused imports (for example,
  avoid `@import furrr` unless the file actually uses it).

## HTTP Layer

All HTTP requests use `httr2` as the sole backend. The `httr` package is
no longer a dependency.

- [`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
  in `utils_nba_stats.R` uses
  [`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
  (an `httr2` wrapper) with required NBA headers (`x-nba-stats-origin`,
  `x-nba-stats-token`, `Referer`).
- Shared internal helpers in `utils.R`:
  [`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md),
  [`.resp_text()`](https://hoopR.sportsdataverse.org/reference/dot-resp_text.md),
  [`check_status()`](https://hoopR.sportsdataverse.org/reference/check_status.md).
- KenPom functions use `httr2`-based helpers:
  [`login()`](https://hoopR.sportsdataverse.org/reference/kp_user_pw.md)
  (cookie jar auth),
  [`.kp_get_page()`](https://hoopR.sportsdataverse.org/reference/dot-kp_get_page.md),
  [`.kp_request()`](https://hoopR.sportsdataverse.org/reference/dot-kp_request.md).
- `nba_endpoint()` builds URLs via
  `glue::glue('https://stats.nba.com/stats/{endpoint}')` – does NOT
  validate against its internal endpoint list.

## Messaging Layer

All user-facing messages use `cli`. The `usethis` package is in
`Suggests` only (retained for
[`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)
documentation references).

- Internal helpers: `message_completed()` wraps
  [`cli::cli_alert_success()`](https://cli.r-lib.org/reference/cli_alert.html);
  `user_message()` dispatches to
  [`cli::cli_alert_success()`](https://cli.r-lib.org/reference/cli_alert.html)
  / [`cli::cli_ul()`](https://cli.r-lib.org/reference/cli_ul.html) /
  [`cli::cli_alert_info()`](https://cli.r-lib.org/reference/cli_alert.html)
  /
  [`cli::cli_alert_danger()`](https://cli.r-lib.org/reference/cli_alert.html).
- Inline markup: `{.val x}` for values, `{.file x}` for paths,
  `{.code x}` for code.

## Function Naming

| Data Source   | Prefix                    | Example                                                                                                                                                                                              |
|---------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| NBA Stats API | `nba_`                    | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md), [`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md) |
| ESPN API      | `espn_nba_` / `espn_mbb_` | [`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md), [`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md)                                 |
| KenPom        | `kp_`                     | [`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md), [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md)                                     |
| NBA G-League  | `nbagl_`                  | [`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md), [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)                           |
| NCAA          | `ncaa_mbb_`               | [`ncaa_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_teams.md)                                                                                                                  |
| Data loaders  | `load_nba_` / `load_mbb_` | [`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md), [`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md)                           |

## Roxygen Documentation

Every exported function needs:

- `@name` and `@rdname` tags with `NULL` object
- `@title` with bold markdown description
- `@author` tag
- `@param` for every parameter (including `...`) with descriptive text
  (e.g.,
  `@param game_id Game ID - 10-digit zero-padded ID (e.g., '0022200021')`)
- `@return` with markdown tables documenting column names and types for
  each data frame returned
- `@importFrom` for specific function imports
- `@export`
- `@family` for grouping in pkgdown (e.g., “NBA PBP Functions”, “NBA
  Boxscore V3 Functions”)
- `@details` with runnable example code block
- For deprecated endpoints, document with `@description` lifecycle badge
  and provide replacement guidance.

## Testing

- Use `skip_on_cran()`, `skip_on_ci()`, and `skip_nba_stats_test()`
  guards.
- Use source-specific guards when applicable: `skip_espn_test()`,
  `skip_nbagl_stats_test()`, `skip_ncaa_mbb_test()`,
  `skip_ncaa_wbb_test()`, and `skip_kenpom_test()`.
- Validate columns with
  `expect_in(sort(expected_cols), sort(colnames(x)))` (subset check, not
  exact match).
- For dynamic columns, use
  `expect_true(all(core_cols %in% colnames(x)))`.
- For intermittent endpoints, add explicit skip-on-empty guards before
  indexing `x[[1]]` or asserting columns.
- For deprecated wrappers, prefer explicit test skips with a replacement
  note rather than brittle live assertions.
- Add `Sys.sleep(3)` at the end of NBA Stats API tests for rate limiting
  (~590 req/10 min).
- Test game ID: `"0022200021"` or `"0022201086"` for known completed
  games.
- Handle empty API responses gracefully in tests (V2 endpoints may
  return empty for old games).

### Environment Variables

| Variable              | Description                |
|-----------------------|----------------------------|
| `NBA_STATS_TESTS=1`   | Enable NBA Stats API tests |
| `ESPN_TESTS=1`        | Enable ESPN API tests      |
| `NBAGL_STATS_TESTS=1` | Enable NBA G-League tests  |
| `NCAA_MBB_TESTS=1`    | Enable NCAA MBB tests      |
| `NCAA_WBB_TESTS=1`    | Enable NCAA WBB tests      |
| `KP_USER` / `KP_PW`   | KenPom credentials         |

On CI, most live API tests are additionally guarded with `skip_on_ci()`.
Setting env vars alone will not run those tests unless that guard is
intentionally relaxed.

### CI Secrets

Current CI workflows rely on:

| Secret         | Description                                  |
|----------------|----------------------------------------------|
| `GITHUB_TOKEN` | Auto-provided token for workflow operations  |
| `KP_USER`      | KenPom username/email for credentialed tests |
| `KP_PW`        | KenPom password for credentialed tests       |

Optional env-var secrets (`NBA_STATS_TESTS`, `NBAGL_STATS_TESTS`,
`ESPN_TESTS`, `NCAA_MBB_TESTS`) only have effect if corresponding
`skip_on_ci()` guards are intentionally adjusted.

## Conventional Commits

Use the format: `type: description`

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `style`,
`perf`, `ci`

- Optional scope is encouraged for clarity (e.g.,
  `docs(instructions): ...`, `refactor(espn): ...`).
- Use `type!:` or a `BREAKING CHANGE:` footer for breaking changes.
- Keep commits logically grouped (docs-only, tests-only, refactor-only)
  so each commit is easy to review and revert.

**Important**: Never include AI agents or assistants (e.g., Claude,
Copilot) as co-authors on commits. Omit all `Co-Authored-By` trailers
referencing AI tools.

## V3 API Notes

- V3 endpoints return nested JSON – use
  [`purrr::pluck()`](https://purrr.tidyverse.org/reference/pluck.html)
  for extraction.
- V3 PBP clock format is `"PT10M30.00S"` not `"MM:SS"`. Parsed with base
  R
  [`regexec()`](https://rdrr.io/r/base/grep.html)/[`regmatches()`](https://rdrr.io/r/base/regmatches.html).
- V3 PBP substitutions: `personId` = outgoing player, incoming parsed
  from “SUB: IncomingPlayer FOR OutgoingPlayer” in description.
- V3-to-V2 conversion pipeline
  ([`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md)
  V3 path):
  [`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)
  -\>
  [`.build_player_roster()`](https://hoopR.sportsdataverse.org/reference/dot-build_player_roster.md)
  -\>
  [`.v3_to_v2_format()`](https://hoopR.sportsdataverse.org/reference/dot-v3_to_v2_format.md)
  -\>
  [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md).
  Produces V2-compatible columns while retaining V3-only columns
  (x_legacy, y_legacy, shot_distance, shot_result, is_field_goal,
  points_total, shot_value).
- [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md)
  uses
  [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md)
  stint data with interval mapping (not substitution-event parsing like
  V2).
- V3 boxscore endpoints namespace: `boxscoretraditionalv3`,
  `boxscoreadvancedv3`, etc.
- V3-style leader/standings endpoints (dunkscoreleaders, gravityleaders,
  iststandings) return flat nested JSON arrays. Parse via
  `purrr::pluck("key")` -\>
  [`dplyr::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)
  -\> `dplyr::mutate(across(everything(), as.character))` -\>
  [`janitor::clean_names()`](https://sfirke.github.io/janitor/reference/clean_names.html).
- V3-style schedule endpoint (scheduleleaguev2int) follows the same
  nested structure as
  [`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md).
- NBAGL wrappers can follow NBA Stats-backed payloads. In particular,
  [`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md)
  and
  [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)
  may return named lists of data frames (e.g., `PlayerIndex`,
  `Standings`) rather than a single flat data frame.

## Common Pitfalls

- Always initialize `df_list <- list()` (or `data <- data.frame()` /
  `data <- list()`) before `tryCatch` blocks.
- ESPN API columns change over time – use subset validation in tests.
- V3-style leader endpoints return mixed types – coerce to
  [`as.character()`](https://rdrr.io/r/base/character.html) with
  `%||% NA_character_`.
- IST Standings has dynamic game columns – use
  `expect_true(all(core_cols %in% colnames()))`.
- NBAGL legacy schemas are no longer stable references for tests. Prefer
  validating core columns from current API payloads and handle
  named-list returns explicitly in tests.
- Local editor/worktree artifacts (e.g., `.vscode`, `.claude`, temp
  logs) can cause `R CMD check` notes/warnings if included in source
  checks.
- KenPom HTML structure changes periodically – CSS selectors for tables
  (`table#player-table`), referee links (`div.refline`), and navigation
  elements are fragile and may need updating.
- Never edit `NAMESPACE` or `man/` files by hand; regenerate with
  `devtools::document()`.
