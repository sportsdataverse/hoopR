# Contributing to hoopR

Thank you for your interest in contributing to hoopR! This guide will help you get started.

## Development Setup

1. **Fork and clone** the repository
2. **Install dependencies**: Open the project in RStudio and run `devtools::install_deps(dependencies = TRUE)`
3. **Create a feature branch** from `devel`: `git checkout -b feat/your-feature devel`

## Workflow

### Making Changes

1. Edit source code in `R/`
2. Regenerate docs: `devtools::document()`
3. Run tests: `devtools::test()`
4. Check the package: `devtools::check()`

### Adding a New NBA Stats API Endpoint

1. **Create the function** in the appropriate `R/nba_stats_*.R` file following the existing pattern:
   - Use `nba_endpoint()` + `request_with_proxy()` for HTTP
   - Parse response with `purrr::pluck()` -> `data.frame()` -> `janitor::clean_names()` -> `make_hoopR_data()`
   - Use `%||%` (rlang) for null safety on every extracted field
2. **Add roxygen docs** with `@export`, `@family`, `@return` (including column markdown tables), and `@details` example
3. **Create a test** in `tests/testthat/` with `skip_on_cran()`, `skip_on_ci()`, `skip_nba_stats_test()` guards
4. **Update NEWS.md** with a description of the new function
5. Run `devtools::document()` to update NAMESPACE

## Naming Conventions

### Function Names

| Data Source | Prefix | Example |
|---|---|---|
| NBA Stats API | `nba_` | `nba_leagueleaders()`, `nba_boxscoretraditionalv3()` |
| ESPN API | `espn_nba_` / `espn_mbb_` | `espn_nba_pbp()`, `espn_mbb_teams()` |
| KenPom | `kp_` | `kp_pomeroy_ratings()`, `kp_box()` |
| NBA G-League | `nbagl_` | `nbagl_schedule()`, `nbagl_standings()` |
| NCAA | `ncaa_mbb_` | `ncaa_mbb_teams()` |
| Data loaders | `load_nba_` / `load_mbb_` | `load_nba_pbp()`, `load_mbb_team_box()` |

### General Naming Rules

- **snake_case** for all function names, variables, and parameters
- **Internal helpers** (not exported) are prefixed with `.` (e.g., `.players_on_court_v3()`)
- **Parameter names** use `snake_case` in R, mapped to `PascalCase` for the NBA Stats API (e.g., `game_id` -> `GameID`)
- **Game IDs** must always be passed through `pad_id()` before API calls (zero-pads to 10 digits)
- **File names** follow the pattern `R/nba_stats_*.R`, `R/espn_*.R`, `R/kp_*.R`

### V2 vs V3 API Patterns

- **V2 endpoints** (e.g., `boxscoretraditionalv2`): Return `resultSets[].headers[] + rowSet[][]`. Parsed via `nba_stats_map_result_sets()`.
- **V3 endpoints** (e.g., `boxscoretraditionalv3`): Return nested JSON. Parsed via `purrr::pluck()` -> `data.frame()` -> pipeline.
- **V3-style leader/standings endpoints** (e.g., `dunkscoreleaders`, `gravityleaders`, `iststandings`): Return flat nested JSON arrays. Parse via `purrr::pluck("key")` -> `dplyr::as_tibble()` -> `dplyr::mutate(across(everything(), as.character))`.

### Data Processing Pipeline

All returned data frames must pass through:

```r
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
- `@family` for grouping in pkgdown (e.g., `"NBA PBP Functions"`, `"NBA Boxscore V3 Functions"`)
- `@details` with a runnable example code block

### Code Style

- Follow [tidyverse style](https://style.tidyverse.org/): `snake_case`, 2-space indentation
- Internal helpers start with `.` (e.g., `.players_on_court_v3()`)
- Game IDs must be passed through `pad_id()` before API calls
- Use `%||%` (rlang) for null-safe defaults when parsing API responses

## Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add nba_playbyplayv3() endpoint wrapper
fix: handle NULL response in boxscore parsing
docs: update roxygen for nba_pbp() version param
test: add column validation for V3 endpoints
refactor: extract clock parsing into helper
chore: update .Rbuildignore
ci: update GitHub Actions workflow versions
```

## Pull Requests

- Target the `devel` branch for development work
- Include a clear description of what changed and why
- Ensure `devtools::check()` passes with no errors or warnings
- Add tests for new functions
- Update NEWS.md

## Testing

### Environment Variables

Tests for different API sources are gated behind environment variables. Set them before running tests:

```r
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

| Variable | Description | Default |
|---|---|---|
| `NBA_STATS_TESTS` | Enable NBA Stats API tests (set to `"1"`) | Disabled |
| `ESPN_TESTS` | Enable ESPN API tests (set to `"1"`) | Disabled |
| `NBAGL_STATS_TESTS` | Enable NBA G-League tests (set to `"1"`) | Disabled |
| `NCAA_MBB_TESTS` | Enable NCAA MBB tests (set to `"1"`) | Disabled |
| `KP_USER` | KenPom account email | Not set |
| `KP_PW` | KenPom account password | Not set |

**Note**: All API tests are skipped on CRAN (`skip_on_cran()`) and CI (`skip_on_ci()`) by default. They require network access and valid API responses.

### Test Pattern

When writing tests for NBA Stats API endpoints, follow this pattern:

```r
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

The NBA Stats API has a rate limit of approximately 590 requests per 10 minutes. Always add `Sys.sleep(3)` at the end of each NBA Stats API test to avoid hitting rate limits during test runs.

## CI / GitHub Actions

The repository uses GitHub Actions for R CMD check and pkgdown site deployment. The following secrets should be configured at the repository or organization level:

| Secret | Used By | Description |
|---|---|---|
| `GITHUB_TOKEN` | All workflows | Auto-provided by GitHub |
| `KP_USER` | R-CMD-check | KenPom email (for KP tests, if enabled) |
| `KP_PW` | R-CMD-check | KenPom password (for KP tests, if enabled) |

**Note**: NBA Stats API, ESPN, and G-League tests are currently skipped on CI via `skip_on_ci()`. If you want to enable them in CI, you would need to add the corresponding environment variables as secrets and remove the `skip_on_ci()` guard.

## Reporting Issues

When filing a bug report, please include:

1. A minimal **reprex** (reproducible example) using `reprex::reprex()`
2. The **game ID** or parameters used
3. Your `sessionInfo()` output
4. The specific **error message** or unexpected output

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
