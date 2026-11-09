## Release summary

This is a minor release (3.2.0), an update to 3.1.0 (CRAN, 2026-08-25). The
full list of changes is in NEWS.md. The main additions:

* International basketball: the EuroLeague and EuroCup family and 23 new
  league families (FIBA, ACB, LBA, VTB, B.LEAGUE, NBL, KBL, CBA and others)
  plus per-competition shortcuts for FIBA, Genius Sports and Sportradar
  Atrium competitions. Each family waits at least 1 s between requests to a
  host and raises classed conditions (`hoopR_no_data`, `hoopR_asset_fetch`,
  `hoopR_bad_request`) instead of returning an empty result.
* NBA officiating reports from official.nba.com (`nba_l2m()`,
  `nba_l2m_games()`, `nba_referee_assignments()`), new `load_*()` loaders
  and new CollegeBasketballData endpoints.
* Fixes for ESPN play-by-play, the NBA CDN and G League feeds, Torvik,
  KenPom, `nba_gamerotation()` and `nba_pbp()` on-court players.
  `build_mbb_db()` and `build_nba_db()` now stop, leaving the existing table
  as it was, when the games index cannot be read.
* Dependencies: Rcpp and RcppParallel (unused; the package has no compiled
  code), magrittr and lubridate are no longer imported; glmnet, Matrix and
  stringdist moved to Suggests; withr and xml2 are now imported.
* The package now ships its `inst/CITATION` file, and three datasets:
  `parameter_descriptions` (10 KB), `mbb_team_names` (6 KB) and
  `return_columns` (238 KB, xz): the returned columns of 959 functions.
  The NBA and men's college basketball help pages keep their column
  tables; the other 647 pages point to `return_columns` instead.
* `ByteCompile: false`: the package is no longer byte-compiled at install
  (the byte code was 2.5 MB of the installed size); R's JIT compiles each
  function on first use.

## Test environments

* Local Windows 10 x64 (build 19045), R 4.6.0 (ucrt),
  `R CMD check --as-cran --timings --run-donttest` with the PDF manual, on
  the tarball built from `git archive` of 0ca5dbda, 2026-11-09, with
  `_R_CHECK_CRAN_INCOMING_REMOTE_=true` and an empty user `.Renviron` (no
  API keys; NOT_CRAN and every live-test variable unset). The commits after
  it change only NEWS.md, CLAUDE.md and this file.
* The same package code (f59b9a52, before the last three example-only
  commits), `R CMD check --run-donttest --no-tests --no-manual`
  with every request sent to a dead proxy (no network): every example ran
  and none errored.
* GitHub Actions: R release on Ubuntu, macOS and Windows, R-devel and
  R oldrel-1 on Ubuntu. All passed on f02a9e62, an earlier commit (before
  the return-columns and `ByteCompile` changes).
* R-hub v2, 2026-11-06 (linux, macos, macos-arm64 and windows, all R-devel):
  all passed. That run was on an earlier commit, 414571b2, not on 0ca5dbda.
* win-builder (devel and release): to be run before submission.

## R CMD check results

0 errors | 0 warnings | 2 notes

Tests: 0 failures (184 s in the check; `devtools::test()` with the same
empty `.Renviron`: 0 failures, 503 skips, 27,528 passes). The PDF and HTML
manuals build.

* checking CRAN incoming feasibility ... NOTE

  ```
  Found the following (possibly) invalid URLs:
    URL: https://hoopR.sportsdataverse.org/articles/return-columns.html
      Status: 404
  ```

  The new "Return Columns" article; the package website is rebuilt from
  `main` and the page exists once that deploy runs. Re-check before
  submission: the NOTE should be gone.

* checking examples ... NOTE

  ```
  Examples with CPU (user + system) or elapsed time > 5s
                   user system elapsed
  atrium_box_score 0.12      0   12.39
  ```

  Network wait only (0.12 s CPU). `atrium_box_score` is the first
  Sportradar Atrium example the check runs, and the host was slow to
  answer that first request; run on its own, twice, with
  `example(..., run.donttest = TRUE)` from the installed build it takes
  0.1 / 0.2 s CPU and 0.9 / 0.6 s elapsed. Every example whose CPU time
  came near 5 s in earlier runs on this (loaded) machine now runs only
  interactively; see Examples below. CRAN does not run `\donttest{}`
  examples by default.

* checking installed package size ... INFO

  ```
  installed size is  6.3Mb
  sub-directories of 1Mb or more:
    R      1.7Mb
    help   3.8Mb
  ```

  The package documents more than 1,300 exported functions. For this
  release the installed size went from 11.5 MB to 6.3 MB:
  - The 22 largest families link to one family index page instead of
    listing every other member in each page's "See also" (n^2 links per
    family): 11.5 MB to 10.4 MB.
  - The return-column tables of 647 functions outside the NBA and men's
    college basketball families moved from their help pages to the
    `return_columns` dataset: help 5.6 MB to 3.8 MB.
  - `ByteCompile: false` in DESCRIPTION: the byte code roughly doubled the
    `R/` directory (4.2 MB to 1.7 MB). The functions are mostly HTTP
    wrappers and parsers whose time goes to the network; R's JIT compiler
    still compiles each function the first time it is called.

  The tarball is 3.75 MB. Five test-fixture folders whose tests skip when
  the folder is absent are left out of it.

## Examples

These examples run only in interactive sessions (`@examplesIf interactive()`):

* Hosts that refuse or stall requests from data-centre machines:
  Basketball-Reference (the nine `bref_*()` pages), and the stats.nba.com
  helpers `nba_player_dict()`, `nba_team_dict()`, `nba_tidy_boxscore()`,
  `nba_tidy_franchise_history()`, `nba_tidy_player_profile()`,
  `nba_tracking_aggregate()` and `nba_shot_zones()`. The `nba_*()`
  stats.nba.com endpoint wrappers show their usage in Details and have no
  runnable examples.
* KenPom (the 11 `kp_*()` pages): the site needs a paid subscription login.
* Crosswalk builders, which build a whole season from several sources:
  `mbb_team_crosswalk()` (one Fox request per conference),
  `mbb_schedule_crosswalk()`, `mbb_player_crosswalk()` (every team's
  roster), `nba_team_crosswalk()`, `nba_schedule_crosswalk()` and
  `nba_player_crosswalk()` (it also calls stats.nba.com for each team's
  roster).
* Large downloads: the release loaders whose one-season file is 7 to 80 MB
  (`load_mbb_pbp()`, `load_mbb_player_box()`, `load_mbb_shots()`,
  `load_nba_stats_pbp()`, and the NCAA MBB pbp, shots, lineups,
  matchup-stints, possessions and player-box loaders).
* Shared pages: `?load_nba_stats_coaches` documents 17 one-season
  `load_nba_stats_*()` loaders; `load_nba_stats_coaches()` and
  `load_nba_stats_draft()` still run (0.5 s each), the other 15 are
  interactive-only (together they took 9.6 s elapsed).
* Slow parsing (2-5 s of CPU): `torvik_game_schedule()` and
  `torvik_game_stats()` (a whole season each), `espn_mbb_powerindex()`,
  `atrium_player_stats()`, `espn_mbb_game_all()`, `aba_box_players()`,
  `aba_box_teams()` and `aba_pbp()`.
* Slow host: `aba_calendar()` and `aba_game()` (aba-liga.com took 23-30 s
  to answer the first request of a check run, three runs out of five).
* Many requests: `espn_mbb_teams()` (ESPN's directory of about 360 teams,
  7 s), `lkl_results()` (pages through a whole season), the
  `espn_*_game_rosters()` examples (one request per athlete), and the
  `espn_*_pbp()`, `espn_*_team_box()` and `espn_*_player_box()` examples,
  which make the same summary request as `espn_*_game_all()`;
  `espn_nba_game_all()` still runs.

The RealGM examples are in `\dontrun{}`: RealGM serves its pages behind a
Cloudflare JavaScript challenge, so the functions read them through headless
Chrome (`chromote`, in Suggests), which CRAN machines do not have.

All other networked examples are in `\donttest{}`. Without network access
the ESPN, `load_*()`, CollegeBasketballData, Torvik, G League and Fox
functions return an empty data frame with a warning. The international
families raise classed conditions (`hoopR_fetch_error`, `hoopR_asset_fetch`)
that name the URL; their examples are wrapped in `try()`. Without an API
key, as on CRAN, the CollegeBasketballData examples stop at once with a
message inside `try()`.

`update_mbb_db()`, `update_nba_db()` and `update_nba_stats_db()` no longer
default to the working directory: `dbdir` now defaults to
`tools::R_user_dir("hoopR", "data")`. No example runs them.

## Tests

Every test that needs the network is off on CRAN. Each source has an opt-in
environment variable (`ESPN_TESTS`, `NBA_STATS_TESTS`, ...) that CRAN does
not set; most of those tests also call `skip_on_cran()`, and a few rely on
the environment variable alone. The tests that run on CRAN read committed
fixtures and mock the HTTP layer.

## URLs

kenpom.com and the www.nba.com stats pages answer HTTP 403 to non-browser
clients (bot protection); the links work in a browser and were present in
3.1.0. The help pages name Basketball-Reference without linking to it: the
site answers automated requests (such as the incoming URL check) with HTTP
503.

## Reverse dependencies

There are no reverse dependencies on CRAN
(`tools::package_dependencies("hoopR", reverse = TRUE, which = "all")`,
2026-11-09).
