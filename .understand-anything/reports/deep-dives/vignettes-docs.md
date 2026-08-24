# Layer deep-dive — Vignettes & Docs

Package documentation: Rmd vignettes, root README/NEWS/CONTRIBUTING/LICENSE markdown, and data-raw authoring/analysis scripts and notes.

**26 files** · 0 functions/classes

## Dependencies

**Depends on:** CI/CD & Config (2), Utilities & Crosswalks (2), NBA Stats API (1), Basketball-Reference, RealGM & Aux Sources (1)

**Depended on by:** CI/CD & Config (1)

## Files

### `vignettes/cbbd-college-basketball-data.Rmd`  _(documentation, vignette, cbbd, mbb)_

Vignette documenting the CollegeBasketballData (CBD/CBBD) endpoints in hoopR, including API-key registration and worked examples for conferences, teams, venues, and other reference data.

### `vignettes/espn-endpoints.Rmd`  _(documentation, vignette, espn, nba)_

Comprehensive vignette walking through hoopR's ESPN NBA and MBB endpoint surface, organized by use case with worked examples (news, scores, schedules, rosters, and more).

### `vignettes/getting-started-hoopR.Rmd`  _(documentation, vignette, getting-started, tutorial)_

Getting-started vignette covering hoopR installation, a quick-start example, and credits to authors and contributors.

### `vignettes/kenpom-example-functions.Rmd`  _(documentation, vignette, kenpom, mbb)_

Vignette demonstrating the KenPom (kp_*) ratings, team, and historical table functions in hoopR with example calls.

### `vignettes/mbb-cookbook.Rmd`  _(documentation, vignette, cookbook, mbb)_

Recipe-style men's college basketball cookbook vignette stitching together hoopR loaders (schedule, PBP, KenPom tempo-free metrics) into end-to-end analysis workflows.

### `vignettes/nba-cookbook.Rmd`  _(documentation, vignette, cookbook, nba)_

Recipe-style NBA cookbook vignette showing how to combine hoopR's ESPN and NBA Stats loaders at different levels of detail (game summary, box scores, play-by-play) into worked analysis examples.

### `CLAUDE.md`  _(documentation, development, conventions, ai-guide)_

AI/contributor development guide for hoopR documenting the package overview (270+ functions across nba_*/espn_*/kp_* families), branching/PR workflow, NBA Stats API function pattern, V2-vs-V3 differences, null-safety and return-value initialization conventions, the httr2 HTTP layer with proxy support, testing gates, and the NEWS/cran-comments/_pkgdown release triad.

### `CODE_OF_CONDUCT.md`  _(documentation, community, governance, code-of-conduct)_

Standard Contributor Covenant code of conduct defining community pledge, behavioral standards, enforcement responsibilities, scope, and a four-tier enforcement guideline (correction through permanent ban).

### `CONTRIBUTING.md`  _(documentation, development, contributing, conventions)_

Contributor onboarding guide covering development setup, the devel-branch workflow, the step-by-step recipe for adding a new NBA Stats API endpoint, function naming conventions, roxygen documentation rules, testing gates with environment variables, CI/GitHub Actions, and commit-message standards.

### `LICENSE.md`  _(documentation, license, mit, legal)_

MIT license text for the hoopR package.

### `NEWS.md`  _(documentation, changelog, release-notes, versioning)_

Full release changelog from v0.0.0.9 through v3.1.0, documenting new exported functions, behavior changes, deprecations, and internals per version — including the 3.1.0 cross-source crosswalks, Fox Sports / CBD / Torvik / Basketball-Reference / RealGM wrappers, and the 3.0.0 httr-to-httr2 and usethis-to-cli migrations.

### `README.md`  _(documentation, entry-point, overview, quick-start)_

Project landing page (rendered from README.Rmd) with badges, installation instructions, quick-start examples for loading full NBA (2002-2026) and men's college basketball (2006-2026) play-by-play seasons, documentation links, breaking-change notes, authors, contributors, and citations.

### `cran-comments.md`  _(documentation, cran, release, submission-notes)_

CRAN submission notes for v3.1.0 summarizing the release themes (NBA schedule CDN migration, proxy-support regression fix, three-column @return table upgrade), per-source wrapper additions, R CMD check results, and revdepcheck results.

### `data-raw/gap_analysis.md`  _(documentation, gap-analysis, nba-stats, api-coverage)_

Coverage gap analysis comparing the Python nba_api endpoints (146) against hoopR's nba_* exports (184), listing missing endpoints by priority, deprecation candidates, and hoopR-only extras.

### `data-raw/get_exported_functions.R`  _(script, data-prep, introspection, code-generation)_

Developer data-prep script using pkgapi to map the package, extract exported function definitions and their parameters, and write CSV manifests of exported functions and nba_ stats parameters.

### `data-raw/intro-to-hoopR.Rmd`  _(documentation, tutorial, kenpom, getting-started)_

R Markdown tutorial walking new users through acquiring KenPom men's college basketball data with hoopR, including configuring KP_USER/KP_PW credentials and the kp_ scraping functions.

### `data-raw/markdown_man_table_helper.R`  _(script, documentation-helper, roxygen, code-generation)_

Authoring helper snippets that emit column-name/type markdown tables and roxygen documentation blocks for NBA Stats data frames, easing manual @return table maintenance.

### `data-raw/mbb_teams.R`  _(script, data-prep, team-crosswalk, mbb)_

Short exploratory script joining NCAA men's basketball team listings with ESPN MBB teams to reconcile team-name keys across sources.

### `data-raw/PR_devel.md`  _(documentation, pull-request, changelog, development)_

Drafted pull-request writeup documenting a development PR's new functions, bug fixes, documentation, infrastructure changes, and testing notes for the devel branch.

### `data-raw/pull_coach_links.R`  _(script, web-scraping, kenpom, data-prep)_

KenPom scraping script that logs in and parses a team page to extract coach names and profile link references, building a coaches reference table.

### `data-raw/pull_nba_teams.R`  _(script, data-prep, nba-stats, dataset-builder)_

Data generator that pulls NBA league standings via nba_leaguestandingsv3, joins to ESPN NBA teams, and writes the bundled nba_teams dataset with usethis::use_data.

### `data-raw/pull_team_links.R`  _(script, web-scraping, kenpom, dataset-builder)_

KenPom scraping loop spanning seasons that harvests team and conference page links per year, joins against ncaahoopR dictionaries, and persists the bundled teams_links dataset.

### `data-raw/pull_team_page.R`  _(script, web-scraping, kenpom, data-prep)_

Large KenPom team-page harvester defining gather_team_pages() to scrape coaches, schedules, depth charts, and player stats per team and year into bundled data frames.

### `data-raw/sdv_author_helpers.R`  _(script, utility, introspection, metadata)_

Small helper script that summarizes installed-package authorship/maintainer fields to support SportsDataverse author/credit tabulation.

### `data-raw/selenium try.R`  _(script, web-scraping, selenium, experimental)_

Experimental RSelenium scratch script launching headless Chrome to render and scrape the KenPom rankings table as an alternative to the rvest session approach.

### `data-raw/team_page_calls.R`  _(script, web-scraping, kenpom, driver)_

Driver script that sources pull_team_page.R and invokes gather_team_pages() season-by-season (most calls commented out) against an authenticated KenPom session.

