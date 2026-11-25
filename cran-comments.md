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
  and new CollegeBasketballData endpoints. After the data releases'
  2026-11 backfill the MBB and NBA loaders accept the newly published
  seasons (MBB player season stats from 2003, NBA game rosters and
  officials and team season stats from 1994), each published as `.rds`, so no loader needs arrow
  for an older season. New loaders read the static stats.ncaa.org to ESPN
  team crosswalk tables (`load_mbb_ncaa_espn_*()`), and the MBB schedule and
  player crosswalks carry stats.ncaa.org ids (player crosswalk from 2004).
* Sixteen new NBA release loaders (Synergy play types, hustle, player
  matchups, injury reports, draft combine, metric curves, rolling windows,
  ESPN depth charts, current impact), one for each data release that had no
  hoopR loader.
* Fixes for ESPN play-by-play, game rosters and prop bets, ESPN wrappers
  that a harmless parse warning emptied, Fox odds, the NBA CDN and G League
  feeds, Torvik, KenPom, `nba_gamerotation()` and `nba_pbp()` on-court players.
  `build_mbb_db()` and `build_nba_db()` now stop, leaving the existing table
  as it was, when the games index cannot be read.
  The wrappers that make their own request (ESPN win probability, the NBA
  and G League CDN feeds, `nba_schedule()`, `ncaa_mbb_teams()`, RotoWire,
  Torvik tournament results) report an HTTP error status instead of parsing
  the error body. A stats.nba.com result set with headers and no rows keeps
  its columns. `nba_defensehub()` and the two box score similarity wrappers
  are defunct: their endpoints answer HTTP 500 or 400 for every parameter set.
* The NBA crosswalk loaders, and the new `load_nba_stats_metric_curves()`
  and `load_nba_stats_rolling_windows()`, return the NBA Stats team and
  player ids as integer, like the other `load_nba_stats_*()` loaders, and
  every release loader's help page links the release tag it reads. A column
  that no row of a release file fills now takes its documented type (the
  draft-combine and NCAA MBB loaders returned such columns as logical or
  `vctrs_unspecified`), and `spotrac_team_cap()` again parses Spotrac's
  cap table (it read two ad rows and each amount's share of the cap).
* Changes that alter what 3.1.0 code gets back (listed under "Breaking
  changes" in NEWS.md): `load_nba_stats_player_game_logs()` returns player
  rows (team rows moved to `load_nba_stats_team_game_logs()`); the NBA
  Stats wrappers default `season` to the previous season; `nba_rapm()`
  fits a different model; `update_*_db()` default `dbdir` is
  `tools::R_user_dir("hoopR", "data")`, not the working directory; the
  pbp loaders return the play `id` as exact character; the roster and
  crosswalk loaders return integer join ids; `nba_schedule()` accepts only
  `league_id` `"00"`, `"10"` and `"20"`, each read from its own CDN;
  `nba_defensehub()` and the two box score similarity wrappers are defunct.
* Dependencies: Rcpp and RcppParallel (unused; the package has no compiled
  code), magrittr and lubridate are no longer imported; glmnet, Matrix and
  stringdist moved to Suggests; withr and xml2 are now imported; ggplot2
  (used by no function, example or test) left Suggests.
* The package now ships its `inst/CITATION` file, and three datasets:
  `parameter_descriptions` (10 KB), `mbb_team_names` (6 KB) and
  `return_columns` (245 KB, xz): the returned columns of 981 functions.
  The NBA and men's college basketball help pages keep their column
  tables; the other 647 pages point to `return_columns` instead.
* `ByteCompile: false`: the package is no longer byte-compiled at install
  (the byte code was 2.5 MB of the installed size); R's JIT compiles each
  function on first use.

## Test environments

* Local Windows 10 x64 (build 19045), R 4.6.1 (ucrt),
  `R CMD check --as-cran --timings --run-donttest` with the PDF manual, on
  the tarball built from `git archive` of d83f8e30 (2026-11-24), with
  `_R_CHECK_CRAN_INCOMING_REMOTE_=true` and an empty user `.Renviron` (no
  API keys; NOT_CRAN and every live-test variable unset). The commits after
  d83f8e30 change only this file, which is not in the tarball.
* The same tarball with R 4.6.0 (ucrt) on the same machine and settings:
  0 errors, 0 warnings, 1 NOTE, and no `'NULL'` directory. The NOTE is one
  example over 5 s elapsed: `espn_mbb_coaches` (0.07 s CPU, 8.88 s
  elapsed), a network wait in a `\donttest{}` example; run again on its
  own it took 0.54 s. Same test counts.
* GitHub Actions: R release on Ubuntu, macOS and Windows, R-devel and
  R oldrel-1 on Ubuntu, `--as-cran`: all five passed on d83f8e30 (run 45468935425).
* R-hub v2 (linux, macos, macos-arm64 and windows, all R-devel), on
  d83f8e30 (run 45468934877): linux, macos and windows passed. macos-arm64
  stopped before the check, in the dependency install step; in run
  45438561596 that step failed because the Suggested package arrow did
  not compile from source on that R-devel image (`arrow/api.h` not found).
  hoopR itself was not checked there.
* win-builder (devel and release): not yet run (win-builder unreachable
  2026-11-24); to be run before submission.

## R CMD check results

0 errors | 0 warnings | 1 note (the R 4.6.1 run)

Tests: 0 failures (230 s in the check: 16,367 passes, 1,330 skips; the
skipped tests need the network, credentials, or files that are not in the
tarball). The PDF and HTML manuals build, and the CRAN incoming
feasibility check (with the remote URL checks) is OK. No example took 5 s
(the slowest, `load_nba_pbp`, took 4.68 s elapsed and 1.2 s of CPU); the
examples are networked, so their elapsed times vary from run to run.

* checking for non-standard things in the check directory ... NOTE

  ```
  Found the following files/directories:
    ''NULL''
  ```

  Not from hoopR: R 4.6.1's `--as-cran` example run leaves an empty
  directory named `'NULL'` on this machine for any package. A one-function
  package with no file access gets the same NOTE under R 4.6.1
  `--as-cran`, and none under R 4.6.1 without `--as-cran` or under R 4.6.0
  `--as-cran`.

* checking installed package size ... INFO

  ```
  installed size is  6.6Mb
  sub-directories of 1Mb or more:
    R      1.7Mb
    help   4.0Mb
  ```

  hoopR now documents 1,340 exported functions (621 in 3.1.0), most of the
  new ones the international league families. A plain `R CMD INSTALL` of
  the tarballs built from the v3.1.0 tag and from d83f8e30 is 4.4 MB for
  3.1.0 (help 2.4 MB) and 6.5 MB for 3.2.0 (help 3.9 MB). To keep the
  growth down:
  - The 22 largest families link to one family index page instead of
    listing every other member in each page's "See also" (n^2 links per
    family).
  - The return-column tables of 647 functions outside the NBA and men's
    college basketball families moved from their help pages to the
    `return_columns` dataset.
  - `ByteCompile: false` in DESCRIPTION: the byte code more than doubled
    the `R/` directory (1.7 MB without it, 4.2 MB with it). The functions
    are mostly HTTP wrappers and parsers whose time goes to the network;
    R's JIT compiler still compiles each function the first time it is
    called.

  An install that keeps source references (`R_KEEP_PKG_SOURCE=yes`, as on
  GitHub Actions) is 8.4 MB, because `R/` then holds them as well (3.6 MB).

  The tarball is 3.81 MB (3,812,859 bytes; 3.1.0 was 0.88 MB), most of the
  growth being test fixtures. Five test-fixture folders whose tests skip
  when the folder is absent are left out of it.

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
* Large downloads: the release loaders whose one-season file is 5.6 to 80 MB
  (`load_mbb_pbp()`, `load_mbb_player_box()`, `load_mbb_shots()`,
  `load_nba_stats_pbp()`, `load_nba_stats_game_matchups()`, and the NCAA
  MBB pbp, shots, lineups, matchup-stints, possessions and player-box
  loaders).
* Shared pages: `?load_nba_stats_coaches` documents 18 one-season
  `load_nba_stats_*()` loaders; `load_nba_stats_coaches()` and
  `load_nba_stats_draft()` still run (1.2 s elapsed together), the other
  16 are interactive-only. On `?load_ncaa_mbb_lineups`, the six large NCAA
  loaders listed above are interactive-only and the other seven run.
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
families raise `hoopR_asset_fetch`, and EuroLeague and the officiating
functions `hoopR_fetch_error`, classed conditions that name the URL; their
examples are wrapped in `try()`. Without an API
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
fixtures and mock the HTTP layer. The recorded-response replay tests
(`test-*_offline.R`) call `skip_on_cran()`, and their fixtures are not in the
tarball.

## URLs

kenpom.com and the www.nba.com stats pages answer HTTP 403 to non-browser
clients (bot protection); the links work in a browser and were present in
3.1.0. The help pages name Basketball-Reference without linking to it: the
site answers automated requests (such as the incoming URL check) with HTTP
503.

## Reverse dependencies

There are no reverse dependencies on CRAN
(`tools::package_dependencies("hoopR", reverse = TRUE, which = "all")`,
2026-11-24).
