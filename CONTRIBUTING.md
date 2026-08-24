# Contributing to hoopR

**Table of Contents** *generated with
[DocToc](https://github.com/thlorenz/doctoc)*

- [Contributing to hoopR](#contributing-to-hoopr)
- [Development Setup](#development-setup)
- [Workflow](#workflow)
- [Naming Conventions](#naming-conventions)
- [Documentation Maintenance](#documentation-maintenance)
- [Commit Messages](#commit-messages)
- [Pull Requests](#pull-requests)
- [Testing](#testing)
- [CI / GitHub Actions](#ci-github-actions)
- [Reporting Issues](#reporting-issues)
- [License](#license)

Thank you for your interest in contributing to hoopR! This guide will
help you get started.

## Development Setup

1.  **Fork and clone** the repository
2.  **Install dependencies**: Open the project in RStudio and run
    `devtools::install_deps(dependencies = TRUE)`
3.  **Create a feature branch** from `devel`:
    `git checkout -b feat/your-feature devel`

## Workflow

### Making Changes

1.  Edit source code in `R/`
2.  Regenerate docs: `devtools::document()`
3.  Run tests: `devtools::test()`
4.  Check the package: `devtools::check()`

### Adding a New NBA Stats API Endpoint

1.  **Create the function** in the appropriate `R/nba_stats_*.R` file
    following the existing pattern:
    - Use `nba_endpoint()` +
      [`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
      for HTTP
    - Parse response with
      [`purrr::pluck()`](https://purrr.tidyverse.org/reference/pluck.html)
      -\> [`data.frame()`](https://rdrr.io/r/base/data.frame.html) -\>
      [`janitor::clean_names()`](https://sfirke.github.io/janitor/reference/clean_names.html)
      -\> `make_hoopR_data()`
    - Use `%||%` (rlang) for null safety on every extracted field
2.  **Add roxygen docs** with `@export`, `@family`, `@return` (including
    column markdown tables), and `@details` example
3.  **Create a test** in `tests/testthat/` with `skip_on_cran()`,
    `skip_on_ci()`, `skip_nba_stats_test()` guards
4.  **Update NEWS.md** with a description of the new function
5.  Run `devtools::document()` to update NAMESPACE

## Naming Conventions

### Function Names

| Data Source | Prefix | Example |
|----|----|----|
| NBA Stats API | `nba_` | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md), [`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md) |
| ESPN API | `espn_nba_` / `espn_mbb_` | [`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md), [`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md) |
| KenPom | `kp_` | [`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md), [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md) |
| NBA G-League | `nbagl_` | [`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md), [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md) |
| NCAA | `ncaa_mbb_` | [`ncaa_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_teams.md) |
| Data loaders | `load_nba_` / `load_mbb_` | [`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md), [`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md) |

### General Naming Rules

- **snake_case** for all function names, variables, and parameters
- **Internal helpers** (not exported) are prefixed with `.` (e.g.,
  [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md))
- **Parameter names** use `snake_case` in R, mapped to `PascalCase` for
  the NBA Stats API (e.g., `game_id` -\> `GameID`)
- **Game IDs** must always be passed through `pad_id()` before API calls
  (zero-pads to 10 digits)
- **File names** follow the pattern `R/nba_stats_*.R`, `R/espn_*.R`,
  `R/kp_*.R`

### V2 vs V3 API Patterns

- **V2 endpoints** (e.g., `boxscoretraditionalv2`): Return
  `resultSets[].headers[] + rowSet[][]`. Parsed via
  `nba_stats_map_result_sets()`.
- **V3 endpoints** (e.g., `boxscoretraditionalv3`): Return nested JSON.
  Parsed via
  [`purrr::pluck()`](https://purrr.tidyverse.org/reference/pluck.html)
  -\> [`data.frame()`](https://rdrr.io/r/base/data.frame.html) -\>
  pipeline.
- **V3-style leader/standings endpoints** (e.g., `dunkscoreleaders`,
  `gravityleaders`, `iststandings`): Return flat nested JSON arrays.
  Parse via `purrr::pluck("key")` -\>
  [`dplyr::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)
  -\> `dplyr::mutate(across(everything(), as.character))`.

### Data Processing Pipeline

All returned data frames must pass through:

``` r

raw_data %>%
  data.frame(stringsAsFactors = FALSE) %>%
  dplyr::as_tibble() %>%
  janitor::clean_names() %>%
  make_hoopR_data("Description from NBA.com", Sys.time())
```

### Roxygen Documentation

Every exported function needs:

- `@name` and `@rdname` tags with `NULL` object preceding the function
- `@title` with bold markdown description
- `@author` tag
- `@param` for every parameter (including `...`)
- `@return` with markdown tables documenting column names and types
- `@importFrom` for specific function imports
- `@export`
- `@family` for grouping in pkgdown (e.g., `"NBA PBP Functions"`,
  `"NBA Boxscore V3 Functions"`)
- `@details` with a runnable example code block

### Code Style

- Follow [tidyverse style](https://style.tidyverse.org/): `snake_case`,
  2-space indentation
- Internal helpers start with `.` (e.g.,
  [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md))
- Game IDs must be passed through `pad_id()` before API calls
- Use `%||%` (rlang) for null-safe defaults when parsing API responses

## Documentation Maintenance

Two regeneration steps are part of the commit workflow whenever the
relevant sources change. Both are mechanical — never edit the generated
regions by hand.

### Markdown TOCs (doctoc)

`NEWS.md`, `CLAUDE.md`, `CONTRIBUTING.md`,
`.github/copilot-instructions.md`, and
`.github/PULL_REQUEST_TEMPLATE.md` carry a doctoc-generated table of
contents inside the standard marker comments. After editing any of those
files, regenerate the TOC before committing:

``` sh
Rscript tools/run_doctoc.R --maxlevel 2 \
  NEWS.md CLAUDE.md CONTRIBUTING.md \
  .github/copilot-instructions.md .github/PULL_REQUEST_TEMPLATE.md
```

`cran-comments.md` is intentionally excluded — it is a short
release-notes file submitted to CRAN and does not need a TOC.

`tools/run_doctoc.R` is a no-deps R replacement for the npm `doctoc` CLI
— it produces output indistinguishable from the upstream tool, is
idempotent (a no-op if no headings changed), and runs without Node.js.
Use `--maxlevel 2` so the TOC only lists `#` and `##` headings; level-3
sub-entries crowd the nav.

### README.md (rmarkdown)

`README.md` is rendered from `README.Rmd`. The Rmd carries
`output: github_document: { toc: true, toc_depth: 2 }`, so the README
has its own auto-generated TOC. After editing `README.Rmd`, re-render
before committing:

``` r

devtools::build_readme()
```

Commit `README.Rmd` and the regenerated `README.md` together. Never
hand-edit `README.md`.

### DESCRIPTION (usethis)

After editing `DESCRIPTION` (adding/removing packages, bumping versions,
updating `Authors@R`, etc.), normalize formatting before committing:

``` r

usethis::use_tidy_description()
```

This re-orders fields, alphabetizes `Imports`/`Suggests`, and reflows
long lines so subsequent diffs stay minimal. Run it even for one-line
edits.

### Release notes triad: NEWS.md / cran-comments.md / \_pkgdown.yml

Three files describe the same release at different audiences. Whenever
you add a `NEWS.md` bullet, **think through all three before
committing**:

- **`NEWS.md`** — authoritative changelog for downstream users; rendered
  into the pkgdown changelog. **All new bullets go under the most recent
  unreleased version heading** (currently `# **hoopR 3.0.0**`). Do NOT
  create a new version section ahead of release. Add to or extend an
  existing subsection (`### Bug Fixes`, `### Deprecations`,
  `### Stability and Test Robustness`, etc.) instead of starting a new
  one when the change is incremental. Once `3.0.0` ships to CRAN, the
  development version gets its own heading and the rule rolls forward.

- **`cran-comments.md`** — what gets submitted to CRAN. Every behavioral
  or user-visible change you add to `NEWS.md` should also be reflected
  in `cran-comments.md` before submission. The two files are not
  duplicates: `NEWS.md` is the long-form changelog, `cran-comments.md`
  is the short-form release summary. If a `NEWS.md` bullet is purely
  internal (refactor, test infrastructure, dev tooling) it can be
  omitted from `cran-comments.md`.

- **`_pkgdown.yml`** — the pkgdown reference index. New exported
  functions need to land in the right `reference:` section. The existing
  hoopR config uses `starts_with("nba_")` / `starts_with("espn_")` /
  `starts_with("kp_")` / `starts_with("ncaa_")` selectors so new
  functions matching those prefixes are picked up automatically;
  explicitly-listed functions need a manual entry. Functions deprecated
  via
  [`lifecycle::deprecate_stop()`](https://lifecycle.r-lib.org/reference/deprecate_soft.html) +
  `@keywords internal` are excluded from the rendered index by default —
  preview with
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
  when in doubt.

When the change touches the API surface (new export, deprecation,
removal), include a one-line note in your commit message confirming
you’ve checked all three files.

## Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

    feat: add nba_playbyplayv3() endpoint wrapper
    fix: handle NULL response in boxscore parsing
    docs: update roxygen for nba_pbp() version param
    test: add column validation for V3 endpoints
    refactor: extract clock parsing into helper
    chore: update .Rbuildignore
    ci: update GitHub Actions workflow versions

## Pull Requests

- Target the `devel` branch for development work
- Include a clear description of what changed and why
- Ensure `devtools::check()` passes with no errors or warnings
- Add tests for new functions
- Update NEWS.md

## Testing

### Environment Variables

Tests for different API sources are gated behind environment variables.
Set them before running tests:

``` r

# Enable specific test suites
Sys.setenv(NBA_STATS_TESTS = "1")     # NBA Stats API tests
Sys.setenv(ESPN_TESTS = "1")          # ESPN API tests
Sys.setenv(NBAGL_STATS_TESTS = "1")   # NBA G-League Stats tests
Sys.setenv(NCAA_MBB_TESTS = "1")      # NCAA MBB tests
Sys.setenv(KP_USER = "your_email")    # KenPom credentials
Sys.setenv(KP_PW = "your_password")   # KenPom credentials

# Run all tests
devtools::test()

# Run a single test file
testthat::test_file("tests/testthat/test-nba_playbyplayv3.R")
```

| Variable            | Description                               | Default  |
|---------------------|-------------------------------------------|----------|
| `NBA_STATS_TESTS`   | Enable NBA Stats API tests (set to `"1"`) | Disabled |
| `ESPN_TESTS`        | Enable ESPN API tests (set to `"1"`)      | Disabled |
| `NBAGL_STATS_TESTS` | Enable NBA G-League tests (set to `"1"`)  | Disabled |
| `NCAA_MBB_TESTS`    | Enable NCAA MBB tests (set to `"1"`)      | Disabled |
| `KP_USER`           | KenPom account email                      | Not set  |
| `KP_PW`             | KenPom account password                   | Not set  |

**Note**: All API tests are skipped on CRAN (`skip_on_cran()`) and CI
(`skip_on_ci()`) by default. They require network access and valid API
responses.

### Test Pattern

When writing tests for NBA Stats API endpoints, follow this pattern:

``` r

test_that("NBA Endpoint Name", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_function(param = "value")

  cols_x1 <- c("col1", "col2", ...)
  expect_equal(sort(colnames(x$Component)), sort(cols_x1))
  expect_s3_class(x$Component, "data.frame")

  Sys.sleep(3)  # Rate limiting - NBA API limit is ~590 req/10 min
})
```

### Rate Limiting

The NBA Stats API has a rate limit of approximately 590 requests per 10
minutes. Always add `Sys.sleep(3)` at the end of each NBA Stats API test
to avoid hitting rate limits during test runs.

## CI / GitHub Actions

The repository uses GitHub Actions for R CMD check and pkgdown site
deployment. The following secrets should be configured at the repository
or organization level:

| Secret         | Used By       | Description                                |
|----------------|---------------|--------------------------------------------|
| `GITHUB_TOKEN` | All workflows | Auto-provided by GitHub                    |
| `KP_USER`      | R-CMD-check   | KenPom email (for KP tests, if enabled)    |
| `KP_PW`        | R-CMD-check   | KenPom password (for KP tests, if enabled) |

**Note**: NBA Stats API, ESPN, and G-League tests are currently skipped
on CI via `skip_on_ci()`. If you want to enable them in CI, you would
need to add the corresponding environment variables as secrets and
remove the `skip_on_ci()` guard.

## Reporting Issues

When filing a bug report, please include:

1.  A minimal **reprex** (reproducible example) using `reprex::reprex()`
2.  The **game ID** or parameters used
3.  Your [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html)
    output
4.  The specific **error message** or unexpected output

## License

By contributing, you agree that your contributions will be licensed
under the [MIT License](https://hoopR.sportsdataverse.org/LICENSE).
