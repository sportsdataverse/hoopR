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
* The NBA crosswalk loaders return the NBA Stats team and player ids as
  integer, like the `load_nba_stats_*()` loaders, and every release
  loader's help page links the release tag it reads.
* Changes that alter what 3.1.0 code gets back (listed under "Breaking
  changes" in NEWS.md): `load_nba_stats_player_game_logs()` returns player
  rows (team rows moved to `load_nba_stats_team_game_logs()`); the NBA
  Stats wrappers default `season` to the previous season; `nba_rapm()`
  fits a different model; `update_*_db()` default `dbdir` is
  `tools::R_user_dir("hoopR", "data")`, not the working directory; the
  pbp loaders return the play `id` as exact character; the roster and
  crosswalk loaders return integer join ids.
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
  the tarball built from `git archive` of a50d3bc7 (2026-11-24), with
  `_R_CHECK_CRAN_INCOMING_REMOTE_=true` and an empty user `.Renviron` (no
  API keys; NOT_CRAN and every live-test variable unset). The commits after
  a50d3bc7 change only this file and CLAUDE.md, neither of which is in the
  tarball.
* The same tarball with R 4.6.0 (ucrt) on the same machine and settings:
  Status: OK (0 errors, 0 warnings, 0 notes), with the same test counts;
  no example over 5 s (the slowest, `espn_mbb_team`, took 4.6 s elapsed),
  and no `'NULL'` directory.
* GitHub Actions: R release on Ubuntu, macOS and Windows, R-devel and
  R oldrel-1 on Ubuntu, `--as-cran`: all passed with 0 errors, 0 warnings
  and 0 notes on c5dfb1aa, the commit before this release's documentation
  and DESCRIPTION Suggests changes.
* R-hub v2 (linux, macos, macos-arm64 and windows, all R-devel): dispatched
  2026-11-24 on the final commit, results pending.
* win-builder (devel and release): submitted 2026-11-24, results pending.

## R CMD check results

0 errors | 0 warnings | 2 notes (the R 4.6.1 run; the R 4.6.0 run has 0 notes)

Tests: 0 failures (216 s in the check: 16,352 passes, 1,330 skips; the
skipped tests need the network, credentials, or files that are not in the
tarball). The PDF and HTML manuals build, and the CRAN incoming
feasibility check (with the remote URL checks) is OK.

* checking examples ... NOTE

  ```
  Examples with CPU (user + system) or elapsed time > 5s
                        user system elapsed
  espn_mbb_team         1.98   0.11    6.19
  load_ncaa_mbb_lineups 0.30   0.01    5.14
  ```

  Network wait: both are `\donttest{}` examples, which CRAN does not run
  by default, and both are under 2.1 s of CPU. `?espn_mbb_team` holds the
  eight ESPN team examples. `?load_ncaa_mbb_lineups` is
  the shared page of the NCAA loaders, and the time is the downloads of the
  seven small loaders that still run there; the six large ones are
  interactive-only (see Examples below).

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
  the tarballs built from the v3.1.0 tag and from a50d3bc7 is 4.4 MB for
  3.1.0 (help 2.4 MB) and 6.5 MB for 3.2.0 (help 3.9 MB). To keep the growth down:
  - The 22 largest families link to one family index page instead of
    listing every other member in each page's "See also" (n^2 links per
    family).
  - The return-column tables of 647 functions outside the NBA and men's
    college basketball families moved from their help pages to the
    `return_columns` dataset.
  - `ByteCompile: false` in DESCRIPTION: the byte code more than doubled
    the `R/` directory (4.2 MB to 1.7 MB). The functions are mostly HTTP
    wrappers and parsers whose time goes to the network; R's JIT compiler
    still compiles each function the first time it is called.

  An install that keeps source references (`R_KEEP_PKG_SOURCE=yes`, as on
  GitHub Actions) is 8.4 MB, because `R/` then holds them as well (3.6 MB).

  The tarball is 3.81 MB (3,811,905 bytes; 3.1.0 was 0.88 MB), most of the
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
