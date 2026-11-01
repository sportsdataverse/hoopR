## Release summary

This is a minor release (3.2.0) on top of 3.1.0 (CRAN, 2026-08-25). The
full list of changes is in NEWS.md. The main additions:

* International basketball: the EuroLeague and EuroCup family and 23 new
  league families (FIBA, ACB, LBA, VTB, B.LEAGUE, NBL, KBL, CBA and others) plus
  per-competition shortcuts for FIBA, Genius Sports and Sportradar Atrium
  competitions. Each family waits at least 1 s between requests to a host
  and raises classed conditions (`hoopR_no_data`, `hoopR_asset_fetch`,
  `hoopR_bad_request`) instead of returning an empty result.
* NBA officiating reports from official.nba.com (`nba_l2m()`,
  `nba_l2m_games()`, `nba_referee_assignments()`), new `load_*()` loaders
  and new CollegeBasketballData endpoints.
* Fixes for ESPN play-by-play scores and roster seasons, the NBA CDN and G
  League feeds, `ncaa_mbb_NET_rankings()`, `torvik_ratings()`, the KenPom
  team-page functions for the current season, `nba_gamerotation()` and
  `nba_pbp()` on-court players.
* ESPN play-by-play now carries the clock, period and timeout columns of the
  published play-by-play data.
* The NBA Stats wrappers now default `season` to the previous season.
* Dependencies: Rcpp and RcppParallel (unused; the package has no compiled
  code), magrittr and lubridate are no longer imported; glmnet, Matrix and
  stringdist moved to Suggests; withr and xml2 are now imported.
* The package now ships its `inst/CITATION` file (a `bibentry()`).
* New dataset `parameter_descriptions` (10 KB): the query parameters the NBA
  Stats wrappers send, with their accepted values and the functions that take
  them.
* New dataset `mbb_team_names` (6 KB): NCAA, ESPN play-by-play, Warren Nolan,
  247Sports and Sports-Reference team names keyed on the ESPN team id.
  `mbb_team_crosswalk()` adds them as six new columns, and its Torvik and
  KenPom name matching now covers more renamed schools.

## Examples

* Examples that call stats.nba.com, basketball-reference.com or kenpom.com
  run only in interactive sessions (`@examplesIf interactive()`): those
  hosts refuse or stall requests from data-centre machines, and the KenPom
  functions need a paid subscription.
* The RealGM examples are in `\dontrun{}`: RealGM serves its pages behind a
  Cloudflare JavaScript challenge, so the functions read them through
  headless Chrome (`chromote`, in Suggests), which CRAN machines do not have.
* All other networked examples are in `\donttest{}` and wrapped in `try()`,
  so they fail gracefully without network access.

## Tests

Every test that needs the network is skipped on CRAN (`skip_on_cran()` plus
an opt-in environment variable per source). The tests that run on CRAN read
committed fixtures and mock the HTTP layer.

## Size

The package grew with the international families: the tarball is about
4.0 MB and the installed size about 11.4 MB, most of it help pages (6.7 MB)
and R code (4.2 MB) for more than 1,300 documented functions. We cut the
help by 17% for this release by printing each family's shared source notes
once and linking to it from the other pages.

## URLs

kenpom.com and the www.nba.com stats pages answer HTTP
403 to non-browser clients (bot protection); the links work in a browser
and were present in 3.1.0. The basketball-reference.com link was not
checked automatically (the host blocks automated requests); it is unchanged
since 3.1.0.

## R CMD check results

0 errors | 0 warnings | 0 notes

* Local Windows 10, R 4.6.1, `R CMD check --as-cran` on the built tarball
  (NOT_CRAN unset, so every networked test skips): 0 errors, 0 warnings, 0 notes
  (installed size reported as INFO: 11.4 MB, R 4.2 MB, help 6.7 MB). The
  PDF and HTML manuals build. With `--run-donttest` the examples pass in
  18 minutes.
* GitHub Actions (R release on Ubuntu, macOS and Windows): OK.
* R-hub v2 (R-devel; linux, windows, macos, macos-arm64), 2026-11-01: linux, windows and
  macos Status OK; macos-arm64 completed successfully.
* win-builder: to be run before submission.

## revdepcheck results

There are no reverse dependencies on CRAN.
