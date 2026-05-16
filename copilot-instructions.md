# hoopR Copilot Instructions

**Table of Contents** *generated with
[DocToc](https://github.com/thlorenz/doctoc)*

- [hoopR Copilot Instructions](#hoopr-copilot-instructions)
- [Project Context](#project-context)
- [Repository Workflow](#repository-workflow)
- [Code Style](#code-style)
- [HTTP Layer](#http-layer)
- [Messaging Layer](#messaging-layer)
- [Function Naming](#function-naming)
- [Roxygen Documentation](#roxygen-documentation)
- [Testing](#testing)

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
  `paste0("https://stats.nba.com/stats/", endpoint)` – does NOT validate
  against its internal endpoint list.

### Proxy support

[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
resolves a proxy in this order: explicit `proxy =` arg →
`getOption("hoopR.proxy")` → libcurl env vars (`http_proxy` /
`https_proxy` / `no_proxy`).

Proxy value accepts a URL string `"http://host:port"` or a named list
`list(url=, port=, username=, password=, auth=)` spread into
[`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html).

Per-call override (`nba_foo(proxy = ...)`) only threads through NBA
Stats wrappers (which forward `...` to `request_with_proxy`). ESPN /
KenPom / NBA G-League wrappers call
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
directly without `...`, so use `options(hoopR.proxy = ...)` once at
session top — that’s the recommended pattern for any session that runs
through a proxy.

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

| Data Source | Prefix | Example |
|----|----|----|
| NBA Stats API | `nba_` | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md), [`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md) |
| ESPN API | `espn_nba_` / `espn_mbb_` | [`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md), [`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md) |
| KenPom | `kp_` | [`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md), [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md) |
| NBA G-League | `nbagl_` | [`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md), [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md) |
| NCAA | `ncaa_mbb_` | [`ncaa_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_teams.md) |
| Data loaders | `load_nba_` / `load_mbb_` | [`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md), [`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md) |

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

- **Column assertions must always use the subset direction** — expected
  ⊆ actual: `expect_in(sort(expected_cols), sort(colnames(x)))`. NBA
  Stats and ESPN APIs add columns without removing old ones, so strict
  `expect_equal(sort(colnames(x)), sort(cols))` will flag on any new
  column. The subset direction is the only pattern that survives
  upstream drift. Equivalently,
  `expect_in(sort(colnames(x)), sort(expected))` is also wrong — same
  direction problem.

- For dynamic columns, `expect_true(all(core_cols %in% colnames(x)))` is
  equivalent to the subset-direction `expect_in()`.

- **Always add a skip-if-empty guard immediately after the API call**,
  before any assertion that touches `x[[1]]`:

  ``` r

  x <- nba_func(...)
  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) ||
      nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }
  ```

  This handles transient 500s, HTTP/2 stream errors, and empty responses
  without polluting the failure report.

- For tests that assert against multiple result sets (`x[[1]]..x[[N]]`)
  where the API sometimes returns fewer elements, wrap each assertion in
  a per-index null/empty-column helper:

  ``` r

  check_cols <- function(i, cols) {
    if (length(x) < i || is.null(x[[i]]) || !is.data.frame(x[[i]]) ||
        ncol(x[[i]]) == 0) return(invisible(NULL))
    expect_in(sort(cols), sort(colnames(x[[i]])))
    expect_s3_class(x[[i]], "data.frame")
  }
  ```

  See wehoop’s `test-wnba_teamvsplayer.R` for a reference
  implementation.

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

## Documentation Maintenance

Two regeneration steps are part of the commit workflow whenever the
relevant sources change. Both are mechanical — never edit the generated
regions by hand.

- **Markdown TOCs.** `NEWS.md`, `CLAUDE.md`, `CONTRIBUTING.md`,
  `.github/copilot-instructions.md`, and
  `.github/PULL_REQUEST_TEMPLATE.md` carry a doctoc-generated TOC inside
  marker comments. (`cran-comments.md` is intentionally excluded — it is
  a short CRAN-submission file.) After editing any of them, run:

  ``` sh
  Rscript tools/run_doctoc.R --maxlevel 2 \
    NEWS.md CLAUDE.md CONTRIBUTING.md \
    .github/copilot-instructions.md .github/PULL_REQUEST_TEMPLATE.md
  ```

  `tools/run_doctoc.R` is a no-deps R replacement for the npm `doctoc`
  CLI; it is idempotent and runs without Node.js. Use `--maxlevel 2`
  (level-3 sub-entries crowd the nav).

- **README.md.** Rendered from `README.Rmd` (with
  `output: github_document: { toc: true, toc_depth: 2 }`). After editing
  the Rmd, run `devtools::build_readme()` and commit `README.Rmd` +
  `README.md` together. Never hand-edit `README.md`.

- **DESCRIPTION.** After editing `DESCRIPTION` (deps, versions,
  `Authors@R`, etc.), run
  [`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html)
  to normalize field order, alphabetize `Imports`/`Suggests`, and reflow
  long lines. Run it even for one-line edits.

- **Release notes triad — `NEWS.md` / `cran-comments.md` /
  `_pkgdown.yml`.** Whenever you add a `NEWS.md` bullet, check the other
  two:

  - `NEWS.md` — all new bullets go under the most recent **unreleased**
    version heading (currently `# **hoopR 3.0.0**`). Do NOT create a new
    version section ahead of release; extend the existing subsections
    (`### Bug Fixes`, `### Deprecations`,
    `### Stability and Test Robustness`, …). After the release ships the
    rule rolls forward to the next dev version.
  - `cran-comments.md` — every user-visible / behavioral change in
    `NEWS.md` should be reflected in `cran-comments.md` before
    submission. Internal-only changes (refactors, test infra, dev
    tooling) can be omitted.
  - `_pkgdown.yml` — new exports go in the right `reference:` section.
    `starts_with()` selectors auto-pick up `nba_*` / `espn_*` / `kp_*` /
    `ncaa_*` prefixes; explicitly-listed functions need a manual entry.
    [`lifecycle::deprecate_stop()`](https://lifecycle.r-lib.org/reference/deprecate_soft.html) +
    `@keywords internal` excludes a function from the rendered index by
    default.

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

- **Return-value initialization is mandatory**: every wrapper that
  `return(X)` where `X` is assigned only inside `tryCatch(expr = {...})`
  must initialize `X` *before* the `tryCatch`. Otherwise, when the API
  errors, `return(X)` throws `object 'X' not found` instead of the
  intended empty fallback. Applies to `df_list`, `plays_df`, `pbp`,
  `standings`, `teams`, `team_box_score`, `athlete_roster_df`, `games`,
  `conferences`, `resp`, `data`, etc. — any return variable. Initialize
  to [`list()`](https://rdrr.io/r/base/list.html) for named-list
  returns, `NULL` for single-object returns,
  [`data.frame()`](https://rdrr.io/r/base/data.frame.html) for tibble
  returns.
- When dropping a known-transient column inside a function, use
  `dplyr::select(-dplyr::any_of("colname"))` instead of
  `dplyr::select(-"colname")`. The bare form errors the moment upstream
  drops the column.
- When renaming columns after
  [`janitor::clean_names()`](https://sfirke.github.io/janitor/reference/clean_names.html),
  use `dplyr::rename(dplyr::any_of(c(new = "old")))` so the function
  survives upstream rename/drops without breaking. See
  [`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md)
  and
  [`ncaa_mbb_NET_rankings()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_NET_rankings.md)
  for examples.
- ESPN API columns change over time — **column assertions in tests must
  use the subset direction** (`expect_in(expected, actual)`).
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
- **Two-block roxygen pattern + `@noRd` trap:** when an internal helper
  uses the `@name` + `NULL` topic block above the function-block,
  putting `@noRd` only on the function block leaves the topic block to
  generate an orphan `man/dot-*.Rd` file. pkgdown’s
  `build_reference_index()` will then fail with “topics missing from
  index”. Fix: put `@keywords internal` on the topic block as well as
  `@noRd` on the function block.
- Never edit `NAMESPACE` or `man/` files by hand; regenerate with
  `devtools::document()`.
