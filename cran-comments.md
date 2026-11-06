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
* `nba_leaguedashplayerptshot()` and `nba_leaguedashteamptshot()` now send
  `shot_dist_range`, which they accepted but never sent. The four hustle
  wrappers deprecate `last_n_games`: stats.nba.com has no such filter, so it
  is ignored and warns when supplied.
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
* The `mbb_schedule_crosswalk()` and `mbb_player_crosswalk()` examples also
  run only in interactive sessions: each builds a whole season from several
  sources (the player crosswalk fetches every team's roster) and took 95 to
  150 s under `--run-donttest`.
* The CollegeBasketballData play examples (`?cbbd_plays_game`) now ask for one
  championship-game date and an eight-game tournament. Run on their own with
  an API key they take 12 s (41 s before); without a key, as on CRAN, each
  stops at once with a message inside `try()`.
* The RealGM examples are in `\dontrun{}`: RealGM serves its pages behind a
  Cloudflare JavaScript challenge, so the functions read them through
  headless Chrome (`chromote`, in Suggests), which CRAN machines do not have.
* All other networked examples are in `\donttest{}`. Without network access
  the ESPN, `load_*()`, CollegeBasketballData, Torvik, G League and Fox
  functions return an empty data frame with a warning (checked with every
  request routed to a dead proxy). The international families raise classed
  conditions (`hoopR_fetch_error`, `hoopR_asset_fetch`) that name the URL;
  their examples are wrapped in `try()`.
* `update_mbb_db()`, `update_nba_db()` and `update_nba_stats_db()` no longer
  default to the working directory: `dbdir` now defaults to
  `tools::R_user_dir("hoopR", "data")`. No example runs them.

## Tests

Every test that needs the network is off on CRAN. Each source has an opt-in
environment variable (`ESPN_TESTS`, `NBA_STATS_TESTS`, ...) that CRAN does not
set; most of those tests also call `skip_on_cran()`, and a few rely on the
environment variable alone. The tests that run on CRAN read committed
fixtures and mock the HTTP layer.

## Size

The package grew with the international families: the tarball is 4.1 MB
and the installed size 11.5 MB, most of it help pages (6.7 MB) and R code
(4.2 MB) for more than 1,300 documented functions. We cut the
help by 17% for this release by printing each family's shared source notes
once and linking to it from the other pages. Five test-fixture folders whose
tests skip when the folder is absent are left out of the tarball.

## URLs

kenpom.com and the www.nba.com stats pages answer HTTP
403 to non-browser clients (bot protection); the links work in a browser
and were present in 3.1.0. The help pages name Basketball-Reference without
linking to it: the site answers automated requests (such as the incoming URL
check) with HTTP 503.

## R CMD check results

0 errors | 0 warnings | 0 notes

* Local Windows 10, R 4.6.0 (ucrt), `R CMD check --as-cran --timings` on
  the tarball built from this commit, 2026-11-06, with an empty user
  `.Renviron` (no API keys; NOT_CRAN and every live-test variable unset, so
  every networked test skips). The `\donttest{}` examples were not run in
  this pass (`_R_CHECK_DONTTEST_EXAMPLES_=false`); the examples changed for
  this submission were timed on their own (see Examples).
  Status: OK. Installed size is
  reported as INFO (11.5 MB: R 4.2 MB, help 6.7 MB). Tests: 0 failures,
  618 skips, 16,155 passes in 192 s. The PDF and HTML manuals build.
* GitHub Actions (R release on Ubuntu, macOS and Windows, R-devel and
  R oldrel-1 on Ubuntu) runs on every pull request.
* win-builder (devel and release): to be run before submission.

## revdepcheck results

There are no reverse dependencies on CRAN.
