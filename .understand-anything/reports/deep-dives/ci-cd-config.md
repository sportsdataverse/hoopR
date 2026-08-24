# Layer deep-dive — CI/CD & Config

GitHub Actions workflows (R-CMD-check, pkgdown, rhub), issue/PR templates, and R package configuration (DESCRIPTION, NAMESPACE, _pkgdown.yml, Rproj, build/git settings).

**15 files** · 0 functions/classes

## Dependencies

**Depends on:** Vignettes & Docs (1)

**Depended on by:** Vignettes & Docs (2)

## Files

### `.github/workflows/pkgdown.yaml`  _(ci-cd, deployment, documentation, pkgdown)_

GitHub Actions workflow that builds the hoopR pkgdown documentation site on pushes to main/master (or manual dispatch) and deploys it via pkgdown::deploy_to_branch, installing SportsDataverse companion packages and KenPom (KP_USER/KP_PW) credentials needed to render vignettes.

### `.github/workflows/R-CMD-check.yaml`  _(ci-cd, testing, r-cmd-check, cross-platform)_

Primary CI workflow running R CMD check across a macOS/Windows/Ubuntu matrix (R release) on push, pull request, and a weekly Friday cron, with optional live-API test toggles (NBA Stats, NBA G-League, ESPN, NCAA MBB) supplied via secrets.

### `.github/workflows/rhub.yaml`  _(ci-cd, r-hub, cran, testing)_

Manually-dispatched R-hub v2 workflow that fans out R CMD check across user-selected R-hub platforms (linux containers + windows/macos) for CRAN-submission validation, with a setup job emitting the platform/container matrix consumed by the downstream check jobs.

### `.github/copilot-instructions.md`  _(documentation, ai-instructions, contributor-guide, conventions)_

GitHub Copilot guidance for the hoopR package covering project context, repository workflow, code style, the httr2 HTTP/proxy layer, cli messaging, function naming, roxygen documentation, and testing conventions.

### `.github/ISSUE_TEMPLATE/bug_report.md`  _(documentation, issue-template, github, bug-report)_

GitHub issue template for reporting bugs in hoopR, prompting for the affected function/parameters, a reprex, expected behavior, error output, and session info.

### `.github/ISSUE_TEMPLATE/feature_request.md`  _(documentation, issue-template, github, feature-request)_

GitHub issue template for proposing a new function, endpoint, or improvement, with prompts for the desired solution, NBA Stats API endpoint details, and alternatives considered.

### `.github/PULL_REQUEST_TEMPLATE.md`  _(documentation, pull-request, github, contributor-guide)_

Pull request template structuring contributions with summary, type-of-change, related issues, changes made, submission/testing checklists, and reviewer checklist sections.

### `_pkgdown.yml`  _(configuration, pkgdown, documentation-site, build-system)_

pkgdown site configuration for hoopR.sportsdataverse.org defining the Bootstrap template, navbar, authors, home metadata, and the full reference index grouping all exported functions by data-source family (hoopR loaders, crosswalks, ESPN, NBA Stats, NCAA, KenPom, CBD, Torvik, injury reports).

### `.gitattributes`  _(configuration, git, line-endings, build-system)_

Git attributes file normalizing all text/source files to LF line endings cross-platform and marking binary asset types (png, rds, rda, qs) so they are never normalized.

### `.Rbuildignore`  _(configuration, r-package, build-system)_

R CMD build ignore list excluding non-package files (data-raw, vignettes source, docs, CI config, CLAUDE.md, tooling, and dev artifacts) from the built tarball.

### `DESCRIPTION`  _(configuration, r-package, dependencies, metadata)_

R package manifest for hoopR 3.1.0 declaring metadata, authors, MIT license, R >= 4.1 dependency, and Imports/Suggests (httr2, dplyr, rvest, data.table, etc.) for ESPN/NBA Stats/KenPom access.

### `hoopR.Rproj`  _(configuration, rstudio, r-package, build-system)_

RStudio project configuration for the hoopR package setting build type, devtools usage, roxygenize outputs, and two-space-tab editing conventions.

### `NAMESPACE`  _(configuration, r-package, exports, namespace)_

Roxygen2-generated package namespace exporting 270+ hoopR functions (bref_, cbbd_, espn_, kp_, nba_, load_, torvik_, realgm_ families) and registering the print.hoopR_data S3 method.

### `README.Rmd`  _(documentation, readme, entry-point, rmarkdown)_

Source R Markdown for the package README rendered to README.md, covering hoopR's purpose, installation, quick-start usage, and documentation links.

### `.understand-anything/.understandignore`  _(configuration, knowledge-graph, tooling)_

Scoping config for the understand-anything knowledge-graph indexer that keeps R source, data-raw generators, vignettes, and CI while excluding tests, generated man pages, bundled data, and binary artifacts.

