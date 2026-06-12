# Changelog

## **hoopR 3.1.0**

Development release on top of the CRAN-shipped 3.0.0 (commit
[b76100b3](https://github.com/sportsdataverse/hoopR/commit/b76100b36467b8ec12045f1ca0871028aa06714b)).
Headline change is a **58-wrapper ESPN endpoint expansion** that brings
hoopR’s ESPN coverage to parity with wehoop — athlete coverage, team
detail, event detail, league catalog, news, calendar, injuries, plus
draft / freeagents / transactions for the NBA. Also includes bug fixes
for endpoint behavior that drifted after CRAN submission, the
package-wide `@return` documentation upgrade, and a proxy-support
restoration that addresses a regression introduced by the 3.0.0 `httr` →
`httr2` migration.

#### **Fox Sports basketball wrappers (`fox_nba_*` / `fox_mbb_*`)**

Read-only Fox Sports “Bifrost” basketball wrappers over
`api.foxsports.com/bifrost/v1/{nba,cbk}/*`, complementing the
`espn_nba_*` / `espn_mbb_*` families. Eight wrappers per league flatten
Fox’s layout-oriented JSON (sections → tables → rows → cells) into tidy
`hoopR_data` tibbles: `fox_<lg>_pbp` (period-based play-by-play),
`_boxscore`, `_odds`, `_team_roster`, `_team_stats`, `_team_gamelog`,
`_standings`, `_league_leaders`. A shared internal layer backs both
leagues. Verified live; reverse-engineering notes + an OpenAPI 3.1 spec
live in the `sdv-internal-refs` repo. Parallels the cfbfastR /
sportsdataverse-py `fox_*` families.

#### **CollegeBasketballData API (`cbbd_*`)**

New `cbbd_*()` function family wrapping the [CollegeBasketballData
API](https://api.collegebasketballdata.com) (the men’s college
basketball sibling of CollegeFootballData, which `cfbfastR` wraps with
`cfbd_*`). 38 endpoint wrappers cover the full v1 surface across 13
categories:

- **Games**:
  [`cbbd_games()`](https://hoopR.sportsdataverse.org/reference/cbbd_games.md),
  [`cbbd_games_media()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_media.md),
  [`cbbd_games_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_teams.md),
  [`cbbd_games_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_games_players.md),
  [`cbbd_scoreboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_scoreboard.md)
- **Plays**:
  [`cbbd_plays_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_game.md),
  [`cbbd_plays_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_player.md),
  [`cbbd_plays_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_team.md),
  [`cbbd_plays_date()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_date.md),
  [`cbbd_plays_tournament()`](https://hoopR.sportsdataverse.org/reference/cbbd_plays_tournament.md),
  [`cbbd_play_types()`](https://hoopR.sportsdataverse.org/reference/cbbd_play_types.md)
- **Substitutions**:
  [`cbbd_substitutions_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_game.md),
  [`cbbd_substitutions_player()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_player.md),
  [`cbbd_substitutions_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_substitutions_team.md)
- **Stats**:
  [`cbbd_stats_team_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_season.md),
  [`cbbd_stats_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_leaderboard.md),
  [`cbbd_stats_team_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_team_shooting_season.md),
  [`cbbd_stats_player_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_season.md),
  [`cbbd_stats_player_shooting_season()`](https://hoopR.sportsdataverse.org/reference/cbbd_stats_player_shooting_season.md)
- **Lineups**:
  [`cbbd_lineups_team()`](https://hoopR.sportsdataverse.org/reference/cbbd_lineups_team.md),
  [`cbbd_lineups_game()`](https://hoopR.sportsdataverse.org/reference/cbbd_lineups_game.md)
- **Ratings**:
  [`cbbd_ratings_srs()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_srs.md),
  [`cbbd_ratings_adjusted()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_adjusted.md),
  [`cbbd_ratings_elo()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_elo.md)
- **Rankings**:
  [`cbbd_rankings()`](https://hoopR.sportsdataverse.org/reference/cbbd_rankings.md)
- **Lines**:
  [`cbbd_lines()`](https://hoopR.sportsdataverse.org/reference/cbbd_lines.md),
  [`cbbd_lines_providers()`](https://hoopR.sportsdataverse.org/reference/cbbd_lines_providers.md)
- **Recruiting**:
  [`cbbd_recruiting_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_players.md),
  [`cbbd_recruiting_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_teams.md),
  [`cbbd_recruiting_portal()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_portal.md)
- **Draft**:
  [`cbbd_draft_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_teams.md),
  [`cbbd_draft_positions()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_positions.md),
  [`cbbd_draft_picks()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_picks.md)
- **Teams / Venues / Conferences**:
  [`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md),
  [`cbbd_teams_roster()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_roster.md),
  [`cbbd_venues()`](https://hoopR.sportsdataverse.org/reference/cbbd_venues.md),
  [`cbbd_conferences()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences.md),
  [`cbbd_conferences_history()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences_history.md)

The API requires a free Bearer-token key stored in the `CBBD_API_KEY`
environment variable; see
[`?register_cbbd`](https://hoopR.sportsdataverse.org/reference/register_cbbd.md).
Helpers
[`cbbd_key()`](https://hoopR.sportsdataverse.org/reference/register_cbbd.md),
[`has_cbbd_key()`](https://hoopR.sportsdataverse.org/reference/register_cbbd.md)
and
[`check_cbbd_key()`](https://hoopR.sportsdataverse.org/reference/register_cbbd.md)
mirror the `cfbfastR` key pattern. Every wrapper returns a `hoopR_data`
tibble with a 3-column `@return` table, routes through hoopR’s shared
`httr2` request layer (retries / timeouts / proxy), and reports errors
via the standard `cli` reporters.

#### **Bart Torvik / T-Rank (`torvik_*`)**

New `torvik_*()` function family pulling publicly available men’s
college basketball data directly from
[barttorvik.com](https://barttorvik.com) — no account or API key
required (analogous to how `kp_*` scrapes KenPom). These wrap the
auth-free, self-describing data files (the interactive `.php` pages
behind barttorvik’s JavaScript browser check are intentionally avoided):

- **[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md)**
  — year-end / current T-Rank team ratings: adjusted offensive/defensive
  efficiency, `barthag`, projected record, SOS, wins above bubble,
  adjusted tempo (`{year}_team_results.csv`).
- **[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)**
  — team four factors and shooting splits: eFG%, TOV%, OREB%/DREB%, FT
  rate, 2P/3P/FT splits and assist rates, each with its national rank
  (`{year}_fffinal.csv`).
- **[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md)**
  — full game-by-game schedule and results with pre-game predictions and
  post-game quality metrics (`{year}_super_sked.json`).
- **[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md)**
  — historical NCAA tournament performance by team, coach, conference or
  seed, including PASE / PAKE and round-by-round counts
  (`cgi-bin/ncaat.cgi`).
- **[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md)**
  — every player’s advanced season stat line: offensive rating, usage,
  shooting splits, rebounding/assist/turnover rates, box plus/minus and
  per-game box averages (`getadvstats.php`).
- **[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md)**
  — per-team-game stats: adjusted and raw offensive/defensive
  efficiency, four factors on both ends, tempo, result and pre-game win
  probability (`getgamestats.php`).

Requests route through hoopR’s shared
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
layer with a browser User-Agent; every wrapper returns a `hoopR_data`
tibble with a 3-column `@return` table and reports errors via the
standard `cli` reporters. (Note: the `cbbdata`/`api.cbbdata.com` service
that previously brokered Torvik data is defunct, so these wrap
barttorvik.com directly.)

#### **Basketball-Reference (`bref_*`)**

New `bref_*()` function family scraping publicly available NBA data from
[Basketball-Reference](https://www.basketball-reference.com) — a source
hoopR previously did not cover at all (no account or API key required):

- **[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md)**
  — league-wide player season stats; pick the table with
  `table = "per_game"` / `"totals"` / `"advanced"` / `"per_minute"` /
  `"per_poss"`.
- **[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)**
  — team season stats (`per_game`, `totals`, `per_poss`, `advanced`,
  `opponent`).
- **[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md)**
  — end-of-season conference standings with SRS and a playoff flag.
- **[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md)**
  — draft results paired with each pick’s career totals and advanced
  metrics.
- **[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md)**
  — end-of-season award voting (MVP, ROY, DPOY, SMOY, MIP, Clutch POY,
  COY) in one tidy tibble.
- **[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md)**
  — a team’s season roster.
- **[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md)**
  — a player’s game-by-game log for a season (by Basketball-Reference
  player-id slug, e.g. `jokicni01`).
- **[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md)**
  — the player index for a starting letter (career span, position,
  height/weight, birth date, college) plus each player’s
  Basketball-Reference id slug — a ready-made player **dictionary**.
- **[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md)**
  — the current Basketball-Reference NBA injury report.

Two Sports-Reference quirks are handled centrally: secondary tables
hidden in HTML comments are un-commented, and columns are read from each
cell’s `data-stat` attribute (so the multi-row “over-headers” don’t
mangle column names). Routes through hoopR’s shared
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
with a browser User-Agent. **Basketball-Reference rate-limits aggressive
scraping (~20 requests/minute)** — space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html). Tests are gated
behind `BREF_TESTS=1`. No new dependencies (`rvest` already in
`Imports`).

#### **Salary & mock-draft sources (Spotrac / HoopsHype / NBADraft.net)**

New wrappers for third-party NBA salary and mock-draft sites, all public
HTML, no key required:

- **[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)**
  — team salary-cap allocations, cap space, active players and average
  age from [Spotrac](https://www.spotrac.com).

- **[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md)**
  — the **full league’s** player salaries (one row per player-season,
  current + future contract years) from
  [HoopsHype](https://hoopshype.com). HoopsHype is now a Next.js app
  whose single salaries page paginates client-side, but each team page
  embeds that team’s complete roster in its `__NEXT_DATA__` payload — so
  this iterates the 30 team pages and stitches them together (~600
  players) via a team-by-team approach.

- **[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md)**
  — the current consensus mock draft (both rounds) from
  [NBADraft.net](https://www.nbadraft.net).

**Basketball Insiders** was evaluated but **not** wrapped: its old
salary-widget backend (`hw-files.com`) is offline, and the surviving
page only exposes a team-cap summary redundant with
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md).
For league-wide player salaries,
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md)
remains the most complete source.

#### **RealGM (`realgm_*`) — Cloudflare-challenge bypass via headless Chrome**

[RealGM](https://basketball.realgm.com) sits behind a Cloudflare
JavaScript challenge (`cf-mitigated: challenge`) that returns **HTTP
403** to every libcurl-based client (`httr2`, `httr`, `rvest`)
regardless of headers — Cloudflare fingerprints the TLS handshake (JA3)
*and* demands a JavaScript proof-of-work to mint the `cf_clearance`
cookie. An earlier source audit recorded RealGM as **dead** on that
basis. It is **not** dead — it is reachable with a real browser engine,
and 17 `realgm_*()` wrappers now cover the NBA endpoint surface:

*Players & personnel*

- **[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)**
  — active NBA player index (position, ht/wt, age, current team, years
  of service, pre-draft team / international club, nationality).
- **[`realgm_players_abroad()`](https://hoopR.sportsdataverse.org/reference/realgm_players_abroad.md)**
  — NBA-affiliated players on international rosters, with NBA-rights
  status (a view no first-party feed provides).
- **[`realgm_future_free_agents()`](https://hoopR.sportsdataverse.org/reference/realgm_future_free_agents.md)**
  — projected free-agent classes with Bird / veteran status, production,
  and the player’s listed **agent**.
- **[`realgm_coaches()`](https://hoopR.sportsdataverse.org/reference/realgm_coaches.md)**
  /
  **[`realgm_gms()`](https://hoopR.sportsdataverse.org/reference/realgm_gms.md)**
  — current head coaches / general managers with tenure and nationality.

*Standings, teams & stats*

- **[`realgm_standings()`](https://hoopR.sportsdataverse.org/reference/realgm_standings.md)**
  — both conferences with record, streak, splits.
- **[`realgm_teams()`](https://hoopR.sportsdataverse.org/reference/realgm_teams.md)**
  — team index with division and conference.
- **`realgm_player_stats(season, stat_type, season_type)`** —
  qualified-player leaderboards (Averages / Totals / Per-X / Advanced /
  Misc, across Regular Season / Playoffs / Preseason / Summer League).
- **`realgm_team_stats(season, stat_type, season_type)`** — team
  statistics.
- **[`realgm_individual_seasons()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_seasons.md)**
  /
  **[`realgm_individual_games()`](https://hoopR.sportsdataverse.org/reference/realgm_individual_games.md)**
  — all-time best individual season / single-game leaderboards.

*Draft & salary*

- **`realgm_draft(year)`** — past-draft results (rounds 1–2 +
  undrafted), with pre-draft team and nationality.
- **[`realgm_draft_prospects()`](https://hoopR.sportsdataverse.org/reference/realgm_draft_prospects.md)**
  — current draft-prospect statistics.
- **[`realgm_early_entry()`](https://hoopR.sportsdataverse.org/reference/realgm_early_entry.md)**
  — early-entrant / withdrawal list.
- **[`realgm_salary_cap()`](https://hoopR.sportsdataverse.org/reference/realgm_salary_cap.md)**
  — salary-cap history & projections (cap, tax, aprons, exceptions).
- **[`realgm_rookie_scale()`](https://hoopR.sportsdataverse.org/reference/realgm_rookie_scale.md)**
  — rookie-scale contract amounts by pick.

*Transactions*

- **[`realgm_transactions()`](https://hoopR.sportsdataverse.org/reference/realgm_transactions.md)**
  — the league transactions log (RealGM publishes it as a dated
  narrative, not a table, so this parses the page DOM into one row per
  transaction with a real `Date`).

Self-describing returns carry their query parameters back as columns
([`realgm_player_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_player_stats.md)/[`realgm_team_stats()`](https://hoopR.sportsdataverse.org/reference/realgm_team_stats.md)
echo `season`/`stat_type`/ `season_type`;
[`realgm_draft()`](https://hoopR.sportsdataverse.org/reference/realgm_draft.md)
echoes `draft_year` and a `round` label). Every wrapper drives headless
Chrome through the optional
[`chromote`](https://rstudio.github.io/chromote/) package (Chrome solves
the challenge natively in ~2 seconds). `chromote` + Google Chrome are
therefore a **Suggests-level** requirement for the `realgm_*` family
only; every other hoopR source still works with the standard HTTP stack.

#### **NBA injury reports (`rotowire_injuries()` / `bref_injuries()`)**

RotoWorld (`rotoworld.com`) was a long-standing NBA injuries source, but
NBC has since shut it down (it now 301-redirects to
`nbcsports.com/fantasy`; the injuries tool is gone). Two live
replacements:

- **[`rotowire_injuries()`](https://hoopR.sportsdataverse.org/reference/rotowire_injuries.md)**
  — the current NBA injury report from
  [RotoWire](https://www.rotowire.com) (a separate, live company).
  RotoWire renders the grid client-side from a JSON table endpoint, so
  this reads that JSON directly (player, team, position, injury, status,
  RotoWire player URL). The projected return date is subscriber-only and
  comes back as `NA`.
- **[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md)**
  — a second source, the Basketball-Reference injury report (see above).

#### **Basketball analytics utilities (`nba_*`, no network)**

A set of pure, vectorized basketball-math helpers — standard efficiency
/ rating / four-factor calculators. All return `NA` (not `Inf`/`NaN`) on
a zero denominator and are league-agnostic (NBA / WNBA / college box
scores):

- Shooting:
  [`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
  [`nba_effective_fg_pct()`](https://hoopR.sportsdataverse.org/reference/nba_effective_fg_pct.md),
  [`nba_ft_rate()`](https://hoopR.sportsdataverse.org/reference/nba_ft_rate.md).
- Rating / pace:
  [`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
  [`nba_pace()`](https://hoopR.sportsdataverse.org/reference/nba_pace.md),
  [`nba_offensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_offensive_rating.md),
  [`nba_defensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_defensive_rating.md),
  [`nba_net_rating()`](https://hoopR.sportsdataverse.org/reference/nba_net_rating.md).
- Player rate stats:
  [`nba_game_score()`](https://hoopR.sportsdataverse.org/reference/nba_game_score.md)
  (Hollinger),
  [`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md),
  [`nba_assist_pct()`](https://hoopR.sportsdataverse.org/reference/nba_assist_pct.md),
  [`nba_assist_to_turnover()`](https://hoopR.sportsdataverse.org/reference/nba_assist_to_turnover.md),
  [`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
  [`nba_oreb_pct()`](https://hoopR.sportsdataverse.org/reference/nba_oreb_pct.md),
  and
  [`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md)
  (a tidy four-factors tibble).
- Scaling / enrichment:
  [`nba_per_minutes()`](https://hoopR.sportsdataverse.org/reference/nba_per_minutes.md)
  (per-36 by default),
  [`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md)
  (per-100), and
  [`nba_add_advanced_metrics()`](https://hoopR.sportsdataverse.org/reference/nba_add_advanced_metrics.md),
  which detects the standard box-score columns present in a data frame
  and appends the advanced metrics it can compute.

#### **NBA player / team dictionaries & media (`nba_*`)**

- **[`nba_player_dict()`](https://hoopR.sportsdataverse.org/reference/nba_player_dict.md)**
  /
  **[`nba_team_dict()`](https://hoopR.sportsdataverse.org/reference/nba_team_dict.md)**
  — tidy player and team dictionaries (ids, names, teams,
  conference/division) for joining ids to names and fetching media, with
  headshot / logo URLs attached.
- **[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md)**
  /
  **[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)**
  — vectorized builders for the official NBA CDN headshot and logo URLs.

#### **NBA result-set helpers (`nba_bind_sets()` / `nba_join_sets()` / `nba_nest_sets()`)**

hoopR’s NBA Stats wrappers return the endpoint’s `resultSets` verbatim
as a *named list of tibbles* (structure-faithful, lossless). These three
pure helpers reduce that list to a single tibble on demand — making
explicit, and composable, the three common result-set reductions:

- **`nba_bind_sets(tag_column = )`** — row-bind the sets into one long
  tibble, tagging each row with its origin (tactic **B**); columns
  absent from a set fill with `NA`. For sets that share a schema, or to
  stack with a tag.
- **`nba_join_sets(join_key = )`** — successively left-join the sets
  into one wide tibble on a shared key (tactic **C**). For different
  facets of one entity (e.g. `PlayerStats` + `TeamStats` on `GAME_ID`).
- **`nba_nest_sets(keep_cols = , nest_col = )`** — keep the key
  column(s) wide and nest every other column into a list-column,
  preserving the set origin (tactic **D**). For heterogeneous sets that
  can’t be bound or joined (e.g. a player profile’s season totals /
  career totals / awards).

All three take a named list of tibbles (an `nba_*()` return) and always
return a tibble. The default hoopR return (the list itself) is the “keep
them all” option.

#### **NBA combined-dataset wrappers (`nba_tidy_*()`)**

The per-dataset equivalent of the result-set helpers: each fetches a
specific multi-result-set endpoint and applies its canonical reduction
in one call, so you get the munged tibble directly. All are resilient to
the empty / partial sets stats.nba.com occasionally returns.

- **[`nba_tidy_franchise_history()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_franchise_history.md)**
  — \[nba_franchisehistory()\]’s active + defunct sets row-bound into
  one franchise timeline, tagged `active` / `defunct` (tactic **B**).
- **`nba_tidy_boxscore(game_id)`** — a traditional player box score with
  each player’s team totals joined on by `GAME_ID` + `TEAM_ID` (team
  columns suffixed `_team`) (tactic **C**).
- **`nba_tidy_player_profile(player_id)`** — \[nba_playerprofilev2()\]’s
  many `PLAYER_ID`-keyed tables (season/career totals, highs, rankings)
  nested into a `.data` list-column, one row per table (tactic **D**).

#### **ESPN endpoint naming convention (game\_*/player\_*)**

The 3.1.0 ESPN wrappers are renamed to the shared sportsdataverse
taxonomy used by cfbfastR (and mirrored in wehoop):
`event_competitor* → game_team*`, `event_competition → game`,
`event_* → game_*`, and `athlete_* → player_*` (60 functions). These
wrappers are new in this dev cycle and were never on CRAN, so the rename
is applied directly (no deprecation shims). The web-common-v3
`/athletes/{id}/stats` wrapper becomes `*_player_stats_v3` (kept
alongside the core-v2 `*_player_stats`, a different endpoint).

#### **New data loaders**

13 new `load_*()` loaders bring NBA and MBB dataset coverage toward
parity with the wehoop `load_wnba_*()` / `load_wbb_*()` families,
reading the corresponding `espn_nba_*` /
`espn_mens_college_basketball_*` release tags on `sportsdataverse-data`:

- **NBA (7):**
  [`load_nba_standings()`](https://hoopR.sportsdataverse.org/reference/load_nba_standings.md),
  [`load_nba_draft()`](https://hoopR.sportsdataverse.org/reference/load_nba_draft.md),
  [`load_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_stats.md),
  [`load_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_stats.md),
  [`load_nba_rosters()`](https://hoopR.sportsdataverse.org/reference/load_nba_rosters.md),
  [`load_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/load_nba_game_rosters.md),
  [`load_nba_officials()`](https://hoopR.sportsdataverse.org/reference/load_nba_officials.md).
- **MBB (6):**
  [`load_mbb_rosters()`](https://hoopR.sportsdataverse.org/reference/load_mbb_rosters.md),
  [`load_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_stats.md),
  [`load_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_stats.md),
  [`load_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/load_mbb_standings.md),
  [`load_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/load_mbb_game_rosters.md),
  [`load_mbb_officials()`](https://hoopR.sportsdataverse.org/reference/load_mbb_officials.md).

Player/team season-stats loaders return long-format frames (averages /
totals / miscellaneous categories). Draft is NBA-only. All accept a
`seasons` vector (min 2002, draft min 2003) and the same `dbConnection`
/ `tablename` dots used by the `update_*_db()` helpers.

#### **New exported functions**

58 new ESPN wrappers added across 8 domains (29 per league × 2 leagues +
4 NBA-only). All built on shared internal helpers in
`R/espn_basketball_*_helpers.R` so each MBB / NBA pair stays DRY — one
bugfix in the helper propagates to both public wrappers. Same
internal-helpers-plus-thin-shims pattern wehoop uses for its WBB / WNBA
pair.

##### *Athlete coverage (×8 per league)*

| Function | Endpoint family | Description |
|----|----|----|
| `espn_mbb_athlete_info()` / `espn_nba_athlete_info()` | site-v2 | Athlete bio / team / position / status / college / draft info. |
| `espn_mbb_athlete_overview()` / `espn_nba_athlete_overview()` | web-common-v3 | Season overview + last-5-games + news + rotowire notes. |
| `espn_mbb_athlete_stats()` / `espn_nba_athlete_stats()` | web-common-v3 | Per-category stats as a named list (averages / totals). |
| `espn_mbb_athlete_gamelog()` / `espn_nba_athlete_gamelog()` | web-common-v3 | Game-by-game log. |
| `espn_mbb_athlete_splits()` / `espn_nba_athlete_splits()` | web-common-v3 | Long-format home / away / opponent splits. |
| `espn_mbb_athlete_eventlog()` / `espn_nba_athlete_eventlog()` | core-v2 | Per-event log. `statistics.$ref` URLs returned as `statistics_ref` character column (not auto-resolved). |
| `espn_mbb_athlete_awards()` / `espn_nba_athlete_awards()` | core-v2 | Awards (sparse / often empty); empty payload returns a canonical-shape empty tibble. |
| `espn_mbb_athlete_statisticslog()` / `espn_nba_athlete_statisticslog()` | core-v2 | Per-season statistics log. |

##### *Team detail (×5 per league)*

| Function | Description |
|----|----|
| [`espn_mbb_team()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team.md) / [`espn_nba_team()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team.md) | Single-team info as a named list (`Info`, `Record`, `NextEvent`, `StandingSummary`, `Coaches`). |
| [`espn_mbb_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster.md) / [`espn_nba_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_roster.md) | Roster (one row per athlete with position, height, weight, headshot). |
| [`espn_mbb_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_schedule.md) / [`espn_nba_team_schedule()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_schedule.md) | Schedule (one row per event with opponent, venue, broadcast, result). |
| [`espn_mbb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders.md) / [`espn_nba_team_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_leaders.md) | Statistical leaders in long format per category-rank-athlete. |
| [`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md) / [`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md) | Team-scoped news feed. |

##### *Event detail (×4 per league)*

| Function | Description |
|----|----|
| `espn_mbb_event_odds()` / `espn_nba_event_odds()` | Game-level odds (one row per provider). |
| `espn_mbb_event_probabilities()` / `espn_nba_event_probabilities()` | Paginated play-level win probabilities (page loop capped at 50 pages; respects `limit`). |
| `espn_mbb_event_officials()` / `espn_nba_event_officials()` | Per-game officials. |
| `espn_mbb_event_broadcasts()` / `espn_nba_event_broadcasts()` | Broadcast outlets. |

##### *League catalog (×6 per league)*

| Function | Description |
|----|----|
| [`espn_mbb_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_leaders.md) / [`espn_nba_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_leaders.md) | League leaders (web-common-v3 `statistics/byathlete`). |
| [`espn_mbb_venues()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_venues.md) / [`espn_nba_venues()`](https://hoopR.sportsdataverse.org/reference/espn_nba_venues.md) | Venue catalog. |
| [`espn_mbb_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coaches.md) / [`espn_nba_coaches()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coaches.md) | Coach roster. |
| [`espn_mbb_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_athletes_index.md) / [`espn_nba_athletes_index()`](https://hoopR.sportsdataverse.org/reference/espn_nba_athletes_index.md) | Paginated athlete index with progress messages. |
| [`espn_mbb_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_seasons.md) / [`espn_nba_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_seasons.md) | Season list. |
| [`espn_mbb_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_info.md) / [`espn_nba_season_info()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_info.md) | Single-season info. |

##### *News + calendar (×2 per league)*

| Function | Description |
|----|----|
| [`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md) / [`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md) | League-level news feed (site-v2 `/news`). |
| [`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md) / [`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md) | Scoreboard calendar blocks (site-v2 `/scoreboard?dates={season}`). |

##### *Injuries (×2 per league)*

| Function | Description |
|----|----|
| [`espn_mbb_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_injuries.md) / [`espn_nba_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_injuries.md) | League-wide injury feed (site-v2 `/injuries`). |
| [`espn_mbb_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries.md) / [`espn_nba_team_injuries()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_injuries.md) | Team-scoped injury feed (site-v2 `/teams/{id}/injuries`). |

MBB injury data is typically sparse on ESPN; both variants return an
empty tibble (rather than erroring) when no injuries are reported.

##### *NBA-only ESPN endpoints*

| Function | Description |
|----|----|
| [`espn_nba_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft.md) | Paginates core-v2 `/seasons/{year}/draft` (up to 20 pages); flat tibble of picks. |
| [`espn_nba_freeagents()`](https://hoopR.sportsdataverse.org/reference/espn_nba_freeagents.md) | Wraps core-v2 `/seasons/{year}/freeagents`; returns an empty tibble outside the off-season free-agent window. |
| [`espn_nba_transactions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_transactions.md) | Wraps site-v2 `/transactions?season={year}&limit={limit}` with null-safe `to_team_id` for release transactions. |
| [`espn_nba_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_nba_conferences.md) | NBA-side analog of [`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md), against the NBA scoreboard-conferences endpoint. |

##### *Tier 1 core-v2 expansion (crawler-driven)*

22 new wrappers across 9 resource families, surfaced by an internal
`$ref`-following crawler that mapped the reachable basketball API
surface (21,962 fetches, 1,570 unique templates across all 4 basketball
leagues). Each wrapper is a thin shim over a shared
`.espn_basketball_*()` helper. WNBA + WBB siblings ship in wehoop’s
matching release.

| Function | Description |
|----|----|
| [`espn_nba_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_profile.md) / [`espn_mbb_team_season_profile()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_profile.md) | Era-correct team identity in a specific season plus `$ref` URLs for deeper resources (record, statistics, leaders, coaches, etc.). Historical depth back to **1947** (NBA) / **1939** (MBB). |
| [`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchise.md) / [`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md) | Franchise-level metadata. IDs are stable across relocations and rebrands. |
| [`espn_nba_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_nba_franchises.md) / [`espn_mbb_franchises()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchises.md) | Index of franchise IDs in the league. |
| `espn_nba_athlete_contracts()` | Index of contract seasons recorded for an NBA athlete (NBA-only — WNBA athletes return empty). |
| `espn_nba_athlete_contract()` | Salary, cap-rule flags, Bird status, and trade protections for one (athlete × season). |
| [`espn_nba_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_awards.md) / [`espn_mbb_season_awards()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_awards.md) | Index of award IDs given out in a season. |
| [`espn_nba_award()`](https://hoopR.sportsdataverse.org/reference/espn_nba_award.md) / [`espn_mbb_award()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_award.md) | Award detail with winners (one row per winner; multi-recipient awards like All-NBA return 5 rows). |
| [`espn_nba_futures()`](https://hoopR.sportsdataverse.org/reference/espn_nba_futures.md) / [`espn_mbb_futures()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_futures.md) | Per-season futures betting board in long format (one row per market × team × sportsbook). |
| [`espn_nba_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournaments.md) / [`espn_mbb_tournaments()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournaments.md) | Index of league-tracked tournaments. |
| [`espn_nba_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament.md) / [`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md) | Single tournament metadata + seasons-list `$ref`. |
| [`espn_nba_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_seasons.md) / [`espn_mbb_tournament_seasons()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_seasons.md) | Seasons in which a given tournament was held. |
| [`espn_nba_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record.md) / [`espn_mbb_team_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record.md) | Long-format record breakdown for one team in one season-type (Overall / Home / Road / vs Conference / etc.). |
| [`espn_nba_coach()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach.md) / [`espn_mbb_coach()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach.md) | Single-coach biography, current team / college refs, and counts of career-record + per-season coaching entries. |
| [`espn_nba_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_nba_powerindex.md) / [`espn_mbb_powerindex()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_powerindex.md) | Per-season Basketball Power Index and related metrics, long format (one row per team × stat). |

##### *Tier 2A core-v2 expansion — season metadata*

10 new wrappers across 5 resource families covering season-level
metadata: season types, the per-(season × season-type) leaderboards, and
(mostly college-only) season rankings. Backed by a shared
`R/espn_basketball_season_meta_helpers.R`. WNBA + WBB siblings ship in
wehoop’s matching release.

| Function | Description |
|----|----|
| [`espn_nba_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_types.md) / [`espn_mbb_season_types()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_types.md) | Index of season-type IDs that exist for one season (1 = preseason, 2 = regular, 3 = postseason, 4 = off-season). |
| [`espn_nba_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_type.md) / [`espn_mbb_season_type()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_type.md) | Single season-type detail (start / end dates, has-groups / has-standings / has-legs flags, `$ref` URLs to deeper resources). |
| [`espn_nba_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_leaders.md) / [`espn_mbb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_leaders.md) | Per-(season × season-type) leaderboards in long format (one row per category × rank). 14–15 categories × 25 leaders ≈ 350 rows. |
| [`espn_nba_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_rankings.md) / [`espn_mbb_season_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_rankings.md) | Index of season-level rankings recorded for a season (NBA / WNBA return zero; MBB / WBB return AP Top 25 + Coaches Poll). |
| [`espn_nba_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_ranking.md) / [`espn_mbb_season_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_ranking.md) | Per-week snapshot index for one ranking source — each row resolves to a per-week ranked-teams endpoint. |

##### *Tier 2A core-v2 expansion — weeks + per-week rankings*

8 new wrappers across 4 resource families covering the week structure of
a season. Backed by a shared `R/espn_basketball_week_helpers.R`. WNBA +
WBB siblings ship in wehoop’s matching release.

| Function | Description |
|----|----|
| [`espn_nba_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_weeks.md) / [`espn_mbb_season_weeks()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_weeks.md) | Index of weeks within one (season × season-type). Typical: ~20 weeks for regular season. NBA / WNBA also have weeks; rankings only populate for MBB / WBB. |
| [`espn_nba_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_week.md) / [`espn_mbb_season_week()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_week.md) | Single-week metadata (number, start / end dates, text label, `$ref` to the per-week rankings endpoint). |
| [`espn_nba_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_rankings.md) / [`espn_mbb_week_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_rankings.md) | Index of ranking sources for one week (NBA returns zero; MBB returns AP + Coaches). |
| [`espn_nba_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_nba_week_ranking.md) / [`espn_mbb_week_ranking()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_week_ranking.md) | The ranked teams (typically 25 rows) for one (season-type × week × source). Includes current / previous rank, points, first-place votes, trend, record summary, team `$ref`. |

##### *Tier 2A core-v2 expansion — groups (conferences and divisions)*

8 new wrappers across 4 resource families covering the per-season group
hierarchy (conferences, divisions, and member teams). Backed by a shared
`R/espn_basketball_group_helpers.R`. WNBA + WBB siblings ship in
wehoop’s matching release.

| Function | Description |
|----|----|
| [`espn_nba_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_groups.md) / [`espn_mbb_season_groups()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_groups.md) | Index of group IDs (conferences / divisions) for one (season × season-type). |
| [`espn_nba_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group.md) / [`espn_mbb_season_group()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group.md) | Single-group metadata (name, abbreviation, midsize / short name, `is_conference` flag) plus `$ref` URLs to parent, children, member teams, and standings. |
| [`espn_nba_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_children.md) / [`espn_mbb_season_group_children()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children.md) | Index of child groups (e.g. divisions inside a conference, or conferences inside the NCAA Division I umbrella group). |
| [`espn_nba_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_group_teams.md) / [`espn_mbb_season_group_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams.md) | Index of team IDs that belong to the group for that (season × season-type). |

##### *Tier 2A core-v2 expansion — team deep + coach-in-season*

7 new wrappers across 4 resource families covering deeper per-team and
per-coach core-v2 endpoints. Backed by a shared
`R/espn_basketball_team_deep_helpers.R`. WNBA + WBB siblings (where
applicable) ship in wehoop’s matching release.

| Function | Description |
|----|----|
| [`espn_nba_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_odds_records.md) / [`espn_mbb_team_odds_records()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records.md) | Long-format odds-records breakdown (Money Line / ATS / O/U × Overall / Home / Road × W/L/Push). Sparse — many (team × season-type) combinations return empty. Default `season_type = 0` (all-types aggregate, where ESPN actually populates). |
| [`espn_nba_team_depthchart()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_depthchart.md) | NBA-only long-format depth chart (one row per position × rank × athlete). |
| [`espn_nba_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_roster.md) / [`espn_mbb_team_season_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_roster.md) | Per-season roster (core-v2 `seasons/{y}/teams/{id}/athletes`). Distinct from the existing site-v2 `espn_*_team_roster()`: era-correct, available back to the league’s earliest season. |
| [`espn_nba_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_season.md) / [`espn_mbb_coach_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_season.md) | Single-coach metadata for one (coach × season). Includes name, birth info, and `$ref`s to person / college / team. Sparse coverage — many combinations 404. |

##### *Tier 2A core-v2 expansion — athlete career + draft pick*

5 new wrappers across 3 resource families covering career-level athlete
endpoints and the single-draft-pick lookup. Backed by
`R/espn_basketball_athlete_career_helpers.R` and
`R/espn_basketball_draft_helpers.R`.

| Function | Description |
|----|----|
| `espn_nba_athlete_seasons()` / `espn_mbb_athlete_seasons()` | List of seasons an athlete appeared in. |
| `espn_nba_athlete_career_stats()` / `espn_mbb_athlete_career_stats()` | Long-format career stats. Default `stat_type = 0L` fetches the standard “All Splits” / regular-season view; pass a vector like `c(0L, 1L, 2L)` to bind multiple types (postseason / career aggregate) via a `stat_type_id` column. Coverage of types 1 and 2 is sparse — many athletes only populate type 0. |
| [`espn_nba_draft_pick()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_pick.md) | Single NBA draft-pick detail (defaults to most-recent NBA season, round 1, pick 1). MBB has no draft endpoint, so this wrapper is NBA-only on the hoopR side. |

##### *Tier 2B core-v2 expansion — athlete event log + draft completion*

5 new wrappers across 2 resource families. Extends the athlete and draft
endpoint coverage with the remaining per-season core-v2 endpoints.

| Function | Description |
|----|----|
| `espn_nba_athlete_eventlog_v2()` / `espn_mbb_athlete_eventlog_v2()` | Per-season event log from core-v2 (`seasons/{y}/athletes/{id}/eventlog`). One row per (event × team) appearance with `played` flag + event/competition `$ref`s. Distinct from the existing `espn_*_athlete_eventlog()` which hits the web-common-v3 gamelog endpoint with stats per game. |
| [`espn_nba_draft_rounds()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_rounds.md) | Round-level summary for one NBA draft year (one row per round with pick count + completion status). |
| [`espn_nba_draft_athletes()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athletes.md) | Index of every athlete in a given NBA draft year (~102 entries: 60 picks + undrafted invitees). |
| [`espn_nba_draft_status()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_status.md) | Single-row snapshot of one draft year’s current state. |

##### *Tier 2B core-v2 expansion — event meta endpoints*

8 new wrappers across 4 resource families. Each wraps
`events/{eid}/competitions/{cid}/...` and is added to both NBA and MBB
shim files (16 new public functions across both leagues per package = 8
each).

| Function | Description |
|----|----|
| `espn_nba_event_situation()` / `espn_mbb_event_situation()` | Live game situation: timeouts, fouls, fouls-to-give, bonus state, last-play `$ref`. Single-row tibble. |
| `espn_nba_event_predictor()` / `espn_mbb_event_predictor()` | Pre-game predictor statistics in long format (one row per team × stat). Stats include matchup quality, predicted score, win pct, team-predicted MoV. Returns empty for events without predictor data. |
| `espn_nba_event_powerindex()` / `espn_mbb_event_powerindex()` | Per-event power-index `$ref` index. Coverage is sparse — most events return zero items. |
| `espn_nba_event_propbets()` / `espn_mbb_event_propbets()` | Per-(event × provider) prop-bet markets in long format. One row per (athlete × prop type) with american / decimal / fraction odds + current target line. Auto-paginates. |

##### *Tier 2B core-v2 expansion — event competitor sub-resources*

5 new resource families under
`events/{eid}/competitions/{cid}/competitors/{team_id}/`, each shimmed
for NBA and MBB (10 new public functions per package). Pair the team_id
with the event_id from `espn_*_schedule()` (or any
`boxscore.teams[].id`).

| Function | Description |
|----|----|
| `espn_nba_event_competitor_linescores()` / `espn_mbb_event_competitor_linescores()` | Per-quarter scoring for one team in one event. One row per period (regulation + overtime). |
| `espn_nba_event_competitor_leaders()` / `espn_mbb_event_competitor_leaders()` | Top performers per team in long format: one row per (category × athlete rank). Categories typically include points, rebounds, assists, and rating. |
| `espn_nba_event_competitor_roster()` / `espn_mbb_event_competitor_roster()` | Game-day roster index for one team. Returns athlete ids + core-v2 `$ref` URLs for deferred dereferencing. |
| `espn_nba_event_competitor_statistics()` / `espn_mbb_event_competitor_statistics()` | Full team-game statistics in long format (one row per category × stat) with both numeric values and display strings. |
| `espn_nba_event_competitor_records()` / `espn_mbb_event_competitor_records()` | Team records as of the event: overall / home / away / conference / division breakdowns. |

##### *Tier 2F core-v2 expansion — typed-detail companions*

5 new resource families completing index/detail pairs for existing
wrappers. NBA-only or 3-league coverage where the underlying ESPN
endpoint isn’t symmetric:

| Function | Description |
|----|----|
| `espn_nba_event_official_detail()` / `espn_mbb_event_official_detail()` | Per-official details (name, position, order) for one event. **Note**: the URL segment is the *crew order* (1-indexed) not the ESPN stable official_id — the wrapper takes `order =` to match `event_officials()$order`. |
| [`espn_nba_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_record_detail.md) / [`espn_mbb_team_record_detail()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_record_detail.md) | Per-record stat array in long format. Use `team_record()` to enumerate `record_id` values (overall / home / away / conference / per-opponent). Returns 21 rows × 15 cols for one NBA record. |
| [`espn_nba_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_nba_coach_record.md) / [`espn_mbb_coach_record()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_coach_record.md) / `espn_wbb_coach_record()` | Coach career record by type in long format. Types: 0 = Total, 1 = Pre Season, 2 = Regular Season, 3 = Post Season. |
| [`espn_nba_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_nba_tournament_season.md) / [`espn_mbb_tournament_season()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament_season.md) | Single tournament-year detail (id, displayName, numberOfRounds, bracketology `$ref`). |
| [`espn_nba_draft_athlete_detail()`](https://hoopR.sportsdataverse.org/reference/espn_nba_draft_athlete_detail.md) | Rich single-row drafted-player record: height/weight, position, pick (overall/round/team), athlete `$ref`. |

##### *Tier 2E.2 core-v2 expansion — team-season stats + quick lookups*

3 new resource families across NBA + MBB (5 new exports — season_draft
is NBA-only). Surfaces the full team-season stat sheet (with league rank
per stat), a quick-lookup wrapper for a single team’s final score in one
event, and the draft-year top-level metadata.

| Function | Description |
|----|----|
| [`espn_nba_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_season_statistics.md) / [`espn_mbb_team_season_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_season_statistics.md) | **Full team-season-type stat sheet in long format** (one row per category × stat). Each row carries `rank` + `rank_display_value` for league ranking per stat. Smoke-tested: 109 rows × 13 cols for one NBA team. |
| `espn_nba_event_competitor_score()` / `espn_mbb_event_competitor_score()` | Single-row final score for one team in one event: `value`, `display_value`, `winner` flag, source metadata. |
| [`espn_nba_season_draft()`](https://hoopR.sportsdataverse.org/reference/espn_nba_season_draft.md) | Draft-year top-level metadata: `year`, `number_of_rounds`, `display_name`, plus sub-refs to athletes/rounds/status. |

##### *Tier 2E.1 core-v2 expansion — event-scoped player + play deep dives*

4 new resource families covering per-game player stats, starter/DNP
metadata, single-play detail, and on-court personnel (8 new public
functions per package).

| Function | Description |
|----|----|
| `espn_nba_event_player_box()` / `espn_mbb_event_player_box()` | **Per-game box score for one athlete** in long format (one row per category × stat). Same shape as `event_competitor_statistics()` but scoped to a single athlete-in-event. Smoke-tested: 99 rows × 12 cols for one NBA athlete. |
| `espn_nba_event_competitor_roster_entry()` / `espn_mbb_event_competitor_roster_entry()` | Per-athlete game-day roster row: `starter` flag, `did_not_play` + `reason`, `ejected`, `period` of entry, `for_player_id` if a substitution. |
| `espn_nba_event_play()` / `espn_mbb_event_play()` | Rich single-play detail: sequence, period, clock, type, text, scoring/shooting flags, score, team `$ref`, shot coordinates. |
| `espn_nba_event_play_personnel()` / `espn_mbb_event_play_personnel()` | Players on court at a specific play in long format. Coverage is sparse — many plays return zero rows; wrapper returns a typed empty tibble. |

##### *Tier 2D core-v2 expansion — position dictionary*

2 new resource families for the league-specific position dictionary (4
new public functions). Position ids are **not** shared across the
basketball family — id `1` resolves to `Point Guard` in NBA and `Center`
in MBB. These wrappers make the dictionary explicit so users can
disambiguate position `$ref` URLs in athlete records.

| Function | Description |
|----|----|
| [`espn_nba_positions()`](https://hoopR.sportsdataverse.org/reference/espn_nba_positions.md) / [`espn_mbb_positions()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_positions.md) | League position dictionary index. One row per position with id + canonical `$ref`. |
| [`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_nba_position.md) / [`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md) | Single-position detail: id, name, displayName, abbreviation, leaf flag, parent `$ref`. |

#### **Behavior changes to existing functions**

##### *Bug fixes*

| Function | Fix |
|----|----|
| [`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md) | Migrated off the retired `stats.nba.com/stats/scheduleleaguev2` endpoint (returns `Connection was reset` across multiple client environments; issues [\#184](https://github.com/sportsdataverse/hoopR/issues/184) and [\#187](https://github.com/sportsdataverse/hoopR/issues/187)) to the public CDN at `cdn.nba.com/static/json/staticData/scheduleLeagueV2.json`. Same `leagueSchedule.gameDates[].games[]` payload, no authentication or special headers, stays current with the live season. G-League schedules now come from the `_2`-suffixed variant on the same CDN. For historical seasons (CDN only serves the current season) the function emits a [`message()`](https://rdrr.io/r/base/message.html) directing users at `load_nba_schedule(seasons = ...)`. Also initializes `games <- NULL` before `tryCatch` (issue [\#184](https://github.com/sportsdataverse/hoopR/issues/184)). Verified 2026-05-16: returns 1,398 NBA games × 52 cols for 2025-26. |
| [`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamelog.md) | Reordered query-string parameter ordering to put `LeagueID` first. As of 2026 the NBA Stats API rejects the alphabetical ordering (`Counter, DateFrom, DateTo, Direction, LeagueID, ...`) with a Cloudflare HTML error page; `LeagueID`-first matches the nba.com client and parses successfully. Verified 2026-05-16: returns 2,460 NBA rows with `SEASON_ID=22025`. Parallel fix to the WNBA equivalent in `wehoop`. |
| [`ncaa_mbb_NET_rankings()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_NET_rankings.md) | Hardened against NCAA.com column drift. The function now uses `dplyr::rename(dplyr::any_of(...))` so renamed / added columns (e.g. new `Quad 1..4` headers) no longer break the documented schema; existing consumers keep working and new columns ride along untouched. |
| ESPN wrappers | Moved [`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md) and [`check_status()`](https://hoopR.sportsdataverse.org/reference/check_status.md) *inside* `tryCatch` so transient HTTP errors surface as `cli_alert_danger()` + empty fallback rather than escaping the function. Affects every `espn_nba_*` / `espn_mbb_*` wrapper. |
| [`ncaa_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_teams.md) | No longer returns `NA` ids. `stats.ncaa.org` migrated team links from the legacy `/team/{team_id}/{season_id}` pair to a single modern `/teams/{season_team_id}` resource, so the previous `str_extract("(\\d+)/(\\d+)")` matched nothing. The function now extracts ids from whichever url shape is present (legacy rows populate `team_id`/`season_id`; modern rows populate the new `season_team_id` column), so the id columns are never all-`NA` when the site flips formats. |

#### **Documentation improvements**

##### *@return column descriptions on every exported function*

Every `@return` markdown table across the 39 R source files is upgraded
from two columns (`col_name | types`) to three columns
(`col_name | types | description`). **6,039 total table rows** touched;
every result set on every function now ships a per-column description in
`?<function>` help, the pkgdown reference, and the rendered man pages.

**Coverage** — frequency-weighted, what `?fn` readers actually see —
**58.4% of the 6,039 [@return](https://github.com/return) table rows now
carry a hand-quality description** (curated + ESPN-API + mined). The
remaining 41.6% are heuristic-fallback rows; the heuristic generator’s
snake_case expansion + suffix rules cover most of those acceptably, and
the long tail is dominated by single-occurrence columns from low-traffic
NBA Stats endpoints.

**Description sources** (precedence order, first match wins):

1.  `tools/docs/column_descriptions_curated.csv` — 619 hand-authored
    entries covering high-traffic columns and basketball / ESPN domain
    conventions.
2.  `tools/docs/column_descriptions_api.csv` — 188 ESPN-authored
    descriptions mined live from 14 endpoints per league across both
    `nba` and `mens-college-basketball`, covering 9 endpoint families:
    core-v2 athlete statistics (per-season, post-season, career),
    core-v2 team statistics, core-v2 statisticslog, core-v2 leaders,
    web-v3 athlete stats / splits / gamelog / overview, and web-v3
    statistics/byathlete leaderboards. Three response shapes are
    recognized: nested categories with stats objects, parallel arrays
    under categories, and top-level parallel-array shapes (splits /
    gamelog).
3.  Mined `\item{...}{...}` lines from existing `\describe{}` blocks.
4.  Heuristic patterns driven by column-name suffixes (`*_id`, `*_pct`,
    `*_made`, `*_attempted`, `*_per_36`, etc.) with basketball-friendly
    noun substitution.

**New tooling under `tools/docs/`** (`.Rbuildignore`’d via the existing
`^tools$` rule):

| File | Purpose |
|----|----|
| `build_column_descriptions.R` | One-shot dictionary builder. |
| `column_descriptions_curated.csv` | Hand-edit surface; overrides API / mined / heuristic outputs. |
| `column_descriptions_api.csv` | ESPN-API-mined descriptions, regenerated by `mine_api_descriptions.R`. |
| `column_descriptions.csv` | Generated dictionary (1,956 rows; 619 curated, 168 ESPN-API, 5 mined, 0 parameter-overlap, 1,164 heuristic). |
| `mine_api_descriptions.R` | Driver that probes the ESPN endpoints which self-document their stat columns. |
| `audit_column_descriptions.R` | Coverage / leverage diagnostic. |
| `markdown_man_table_helper.R` | Programmatic helpers (`load_column_descriptions()`, `make_return_table_md()`, `roxygenize_return()`, `augment_return_tables_in_file()`, `augment_all_r_files()`, `mine_espn_api_descriptions(url)`). |
| `espn_endpoints_catalog.md` | Basketball-scoped ESPN endpoint reference used to scope the miner. |

The sweep is idempotent and offline (no API calls needed for the
augmentation itself; existing `|col_name|types|` tables in each
`@return` block are the parse input).

#### **Internals**

##### *HTTP layer — proxy support restored*

When the package migrated from `httr` to `httr2` in 3.0.0, the legacy
[`httr::use_proxy()`](https://httr.r-lib.org/reference/use_proxy.html)
plumbing was dropped and
[`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
quietly stopped honoring proxies (its `...` was preserved purely for
source compatibility). Both
[`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
and the lower-level
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
now accept a `proxy =` argument:

- `proxy = NULL` (default) — libcurl reads `http_proxy` / `https_proxy`
  / `no_proxy` env vars automatically.
- `proxy = "http://host:port"` — string form, forwarded to
  `httr2::req_proxy(url = ...)`.
- `proxy = list(url=, port=, username=, password=, auth=)` — named list
  spread into
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  for authenticated proxies.

Resolution order in
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md):
explicit `proxy =` arg → `getOption("hoopR.proxy")` → libcurl env vars.
The `...` thread works for NBA Stats wrappers (which forward into
[`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md));
ESPN / KenPom / NBA G-League wrappers call
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
directly without `...`, so use `options(hoopR.proxy = ...)` at the top
of the session to cover those without per-function plumbing.

##### *Error-handling consolidation*

| Helper | Role |
|----|----|
| `.report_api_error(e, hint, args)` | Standardized `tryCatch` error handler — emits a `cli_alert_danger()` with hint text plus the captured arg list, then returns an empty fallback. |
| `.report_api_warning(w, args)` | Companion warning handler. |
| [`.interp_braces()`](https://hoopR.sportsdataverse.org/reference/dot-interp_braces.md) | Internal helper for safely interpolating `{var}` syntax in cli alerts when the variable might contain braces of its own. |
| [`.capture_args()`](https://hoopR.sportsdataverse.org/reference/dot-capture_args.md) | Helper used at the top of arg-less wrappers (i.e. those whose only formal is `...`) so the error/warning reporters still see the call args. Equivalent to `mget(setdiff(names(formals()), "..."))` for wrappers with formals. |

Every `tryCatch(expr = ...)` block in ESPN, NBA Stats, and KenPom
wrappers now uses these helpers instead of hand-rolled
`cli::cli_alert_danger("{Sys.time()}: ...")` strings. Behavior is the
same; the message includes the captured args, which makes failed-call
debugging much faster.

##### *Dependency cleanup*

- Removed `glue` from `Imports`; demoted to `Suggests` (retained only
  for downstream package-level references).
- Replaced `glue::glue(...)` call-sites with
  [`sprintf()`](https://rdrr.io/r/base/sprintf.html) /
  [`paste0()`](https://rdrr.io/r/base/paste.html) / base R in URL
  builders, `pad_id()`, `pad_time()`, and `cli` alert strings.
- Replaced
  [`glue::glue_sql()`](https://glue.tidyverse.org/reference/glue_sql.html)
  with parameterized
  [`DBI::dbExecute()`](https://dbi.r-dbi.org/reference/dbExecute.html) /
  [`DBI::dbGetQuery()`](https://dbi.r-dbi.org/reference/dbGetQuery.html)
  calls in `load_*` family functions.

##### *Tooling*

- Ported wehoop’s `tools/` patch scripts (`patch_df_list_init.R`,
  `patch_return_var_init.R`, `flip_expect_equal_cols.R`,
  `inject_skip_guard.R`, `inject_skip_helpers.R`,
  `sweep_error_handlers.R`, `find_parse_errors.R`) for future audit /
  sweep work.
- Added `tools/run_doctoc.R` — a no-deps R replacement for the npm
  `doctoc` CLI, used to regenerate the NEWS.md / CONTRIBUTING.md TOCs.
  Run with
  `Rscript tools/run_doctoc.R --maxlevel 2 NEWS.md CONTRIBUTING.md`.

##### *Test infrastructure*

- Live API test env vars enabled by default in the R CMD check workflow
  (previously had to be set per-job).
- Additional test-suite hardening sweeps applied via the ported `tools/`
  scripts: return-value init guards on edge-case wrappers,
  subset-direction column assertions, skip-on-empty guards where
  wrappers can legitimately return empty.

#### **Release / CRAN preparation**

- Added `cph` (copyright holder) role to `Saiem Gilani` in `Authors@R`
  (CRAN strict requirement caught between releases).
- DESCRIPTION normalized via
  [`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html)
  — field order, alphabetized Imports/Suggests, reflowed long lines.
- `.gitignore` anchored from bare `docs` to `/docs` so only the
  repo-root pkgdown output is ignored (the bare pattern was also
  matching `tools/docs/`).

## **hoopR 3.0.0**

CRAN release: 2026-03-24

#### **New exported functions**

##### *NBA Play-by-Play V3*

| Function / change | Description |
|----|----|
| [`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md) | Dedicated wrapper for the NBA Stats PlayByPlayV3 endpoint. |
| [`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md) default flip | Now defaults to `version = "v3"` (was `"v2"`). Pass `version = "v2"` for the previous behavior. |
| [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md) default flip | Same default flip applies. |
| [`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md) `p` parameter | Now optional (default `NULL`) — previously required even when not using progress tracking. |

Internal V3→V2 compatibility pipeline backs
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md) so
callers keep V2-compatible columns while gaining V3-only columns
(`x_legacy`, `y_legacy`, `shot_distance`, `shot_result`,
`is_field_goal`, `points_total`, `shot_value`):

| Helper (internal) | Role |
|----|----|
| [`.v3_to_v2_format()`](https://hoopR.sportsdataverse.org/reference/dot-v3_to_v2_format.md) | Converts V3 play-by-play data to V2-compatible column format with mapped event types and player resolution. |
| [`.build_player_roster()`](https://hoopR.sportsdataverse.org/reference/dot-build_player_roster.md) | Retrieves player roster from [`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md) for name-to-ID resolution during V3-to-V2 conversion. |
| [`.players_on_court_v3()`](https://hoopR.sportsdataverse.org/reference/dot-players_on_court_v3.md) | Rewritten — uses [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md) stint data with interval mapping for robust on-court determination (replaces the previous substitution-parsing approach). |

Removed
[`stringr::str_match`](https://stringr.tidyverse.org/reference/str_match.html)
import from NAMESPACE — V3 clock parsing now uses base R regex
functions.

##### *NBA Boxscore Summary V3*

| Function | Description |
|----|----|
| [`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md) | Returns a named list of 9 data frames: `GameSummary`, `GameInfo`, `ArenaInfo`, `Officials`, `LineScore`, `InactivePlayers`, `LastFiveMeetings`, `OtherStats`, `AvailableVideo`. |

##### *New NBA Stats API endpoint wrappers*

| Function | Description |
|----|----|
| [`nba_commonteamyears()`](https://hoopR.sportsdataverse.org/reference/nba_commonteamyears.md) | Team IDs with their active year ranges. |
| [`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md) | Dunk tracking data with biomechanics, scores, and style metrics. |
| [`nba_gravityleaders()`](https://hoopR.sportsdataverse.org/reference/nba_gravityleaders.md) | Gravity scores — how much defensive attention each player draws. |
| [`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md) | In-Season Tournament (NBA Cup) standings. |
| [`nba_scheduleleaguev2int()`](https://hoopR.sportsdataverse.org/reference/nba_scheduleleaguev2int.md) | International schedule data with broadcaster information. |
| [`nba_teamandplayersvsplayers()`](https://hoopR.sportsdataverse.org/reference/nba_teamandplayersvsplayers.md) | Team and player lineup comparison stats (5 datasets). |
| [`nba_videoeventsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videoeventsasset.md) | Video event asset data for a given game event. |

##### *ESPN & G-League functions*

| Function | Description |
|----|----|
| [`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md) | Current NBA team roster from ESPN. |
| [`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md) | Current MBB team roster from ESPN. |
| [`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md) | Live G-League play-by-play. |
| [`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md) | Live G-League box score. |

#### **Behavior changes to existing functions**

##### *Bug fixes*

| Function | Fix |
|----|----|
| [`nba_iststandings()`](https://hoopR.sportsdataverse.org/reference/nba_iststandings.md) | Nested games column now properly flattened. |
| [`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md) | HTTP 400 error caused by empty-string parameters now resolved. |
| [`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md) | Avoids on-court enrichment dependency failures for G-League game IDs by using the stable core play-by-play path. |
| [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md) | Referee link extraction updated — CSS selectors now match current KenPom HTML structure (`div.refline` with href-based filtering). |
| [`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md) | CSS selector updated to `table#player-table`; team name assignment now uses the display name instead of the URL slug. |
| [`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md) example | Year bumped from 2021 to 2026 for current-season relevance. |

**Return-value initialization sweep.** Fixed `df_list` not initialized
before `tryCatch` in **147 NBA Stats API wrapper functions**, preventing
crashes on API errors. Same pattern applied to: \*
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md)
(`plays_df` init). \*
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md)
and
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md)
(`data` init). \* NBAGL wrappers (return-object init across error
paths).

**Other fixes:** \* `helper-skip.R` test guard functions now use string
comparison (`!= "1"`) instead of numeric comparison (`== 0`). \*
V3-style data.frame parsing fixed for leader/standings endpoints. \*
`%||%` import added for R \< 4.4.0 compatibility. \* `teams_links`
dataset updated with 2026 season team data.

#### **Deprecations**

Calling any of these now errors with a structured
`lifecycleDeprecatedError` that names a replacement. All deprecations
were prompted by unstable / partial / empty endpoint responses observed
in production.

| Deprecated function | Replacement | Reason |
|----|----|----|
| [`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md) | [`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md) | Unstable/partial V2 responses |
| [`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md) | [`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md) | Unstable/partial V2 responses |
| [`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md) | [`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md) | Unstable/partial V2 responses |
| [`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md) | [`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md) | Unstable/partial V2 responses |
| [`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md) | [`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md) | Unstable/partial V2 responses |
| [`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md) | [`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md) | Unstable/partial V2 responses |
| [`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md) | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md) | Unstable/empty responses |
| [`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md) | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md) | Unstable/empty responses |
| [`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md) | [`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md) | Unstable/empty responses |
| [`nba_teamgamestreakfinder()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamestreakfinder.md) | [`nba_teamgamelogs()`](https://hoopR.sportsdataverse.org/reference/nba_teamgamelogs.md) | Unstable/empty responses |
| [`nba_teamhistoricalleaders()`](https://hoopR.sportsdataverse.org/reference/nba_teamhistoricalleaders.md) | [`nba_franchiseleaders()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaders.md) | Unstable/empty responses |
| [`nba_videodetails()`](https://hoopR.sportsdataverse.org/reference/nba_videodetails.md) | [`nba_videodetailsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videodetailsasset.md) | Unstable/empty responses |
| [`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md) | [`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md) | Unstable/empty responses |
| [`nba_playercareerbycollege()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollege.md) | [`nba_playercareerbycollegerollup()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerbycollegerollup.md) / [`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md) | Unstable/empty responses |
| [`nba_playernextngames()`](https://hoopR.sportsdataverse.org/reference/nba_playernextngames.md) | [`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md) | Unstable/empty responses |
| [`nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboard.md) | [`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md) | Unstable/empty responses |
| [`nba_scoreboardv2()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv2.md) | [`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md) | Unstable/partial responses |

#### **Internals**

##### *HTTP backend migration (httr → httr2)*

**Breaking change**: `httr` is replaced with `httr2` as the HTTP backend
for every API call across the package, and `httr` is removed from
`Imports`. Migration map:

| Aspect | Before (2.1.0 and earlier) | After (3.0.0) |
|----|----|----|
| HTTP client backend | `httr` | `httr2` |
| `httr` package availability | Auto-imported with `hoopR` | Removed from `Imports` — [`library(httr)`](https://httr.r-lib.org/) yourself if your downstream code still needs it |
| [`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md) body | [`rvest::session()`](https://rvest.tidyverse.org/reference/session.html) + [`httr::config()`](https://httr.r-lib.org/reference/config.html) arguments | [`httr2::request()`](https://httr2.r-lib.org/reference/request.html) + retry pipeline |
| All ESPN / NBA Stats / NBA G-League / NCAA / KenPom HTTP calls | Mixed direct backend calls | Routed through shared internal helpers ([`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md), [`.resp_text()`](https://hoopR.sportsdataverse.org/reference/dot-resp_text.md)) backed by `httr2` |
| [`check_status()`](https://hoopR.sportsdataverse.org/reference/check_status.md) internal | [`httr::status_code()`](https://httr.r-lib.org/reference/status_code.html) | [`httr2::resp_status()`](https://httr2.r-lib.org/reference/resp_status.html) |
| KenPom session authentication | [`rvest::session()`](https://rvest.tidyverse.org/reference/session.html) with `httr` cookies | `httr2` cookie-jar via [`login()`](https://hoopR.sportsdataverse.org/reference/kp_user_pw.md) / [`.kp_get_page()`](https://hoopR.sportsdataverse.org/reference/dot-kp_get_page.md) / [`.kp_request()`](https://hoopR.sportsdataverse.org/reference/dot-kp_request.md) helpers |
| libcurl \>= 8.x / curl R \>= 7.0.0 segfaults | Triggered | Resolved (`httr2` does not have the affected code path) |

*Note: proxy plumbing on
[`request_with_proxy()`](https://hoopR.sportsdataverse.org/reference/request_with_proxy.md)
was quietly dropped during this migration. The restoration shipped in
`3.1.0` — see above.*

##### *Messaging migration (usethis → cli)*

- Replaced all `usethis::ui_*()` messaging calls in database builder and
  loader functions with `cli` equivalents.

| Old call | New call |
|----|----|
| [`usethis::ui_stop()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html) |
| [`usethis::ui_oops()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | [`cli::cli_alert_danger()`](https://cli.r-lib.org/reference/cli_alert.html) |
| [`usethis::ui_todo()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | [`cli::cli_ul()`](https://cli.r-lib.org/reference/cli_ul.html) |
| [`usethis::ui_info()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | [`cli::cli_alert_info()`](https://cli.r-lib.org/reference/cli_alert.html) |
| [`usethis::ui_value()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | `{.val}` inline markup |
| [`usethis::ui_path()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | `{.file}` inline markup |
| [`usethis::ui_code()`](https://usethis.r-lib.org/reference/ui-legacy-functions.html) | `{.code}` inline markup |

- Moved `usethis` from `Imports` to `Suggests` (retained for
  [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)
  documentation references).

##### *Stability and test robustness*

- Hardened API-facing tests against live schema drift and intermittent
  empty payloads.
- Added explicit skip-on-empty guards for lineup and NCAA teams tests to
  avoid false negatives when upstream endpoints return no rows.
- Updated expected columns for currently active payloads in key NBA
  endpoints (including
  [`nba_playercareerstats()`](https://hoopR.sportsdataverse.org/reference/nba_playercareerstats.md),
  [`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
  and
  [`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md)).
- Improved
  [`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_playerprofilev2.md)
  assertions to validate core columns while tolerating empty optional
  result sets.
- Converted 400+ `expect_equal(colnames())` assertions to `expect_in()`
  for subset validation, preventing test failures when APIs add new
  columns.
- Added tests for all new endpoints with column validation and rate
  limiting.
- Added `skip_ncaa_mbb_test()` and `skip_ncaa_wbb_test()` helpers.
- Updated ESPN test expectations for current API responses.
- Updated NBAGL tests to validate NBA Stats-backed return shapes
  ([`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md)
  and
  [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)
  named-list returns, and current schedule/PBP core columns).

##### *Dependency changes*

Dependency status before / after the release. Users with strict
dependency pinning or downstream packages that re-export hoopR
functionality should review this table.

| Dependency | Before (2.1.0) | After (3.0.0) | Why |
|----|----|----|----|
| `httr` | `Imports` | Removed | Replaced by `httr2` (see HTTP migration above) |
| `httr2` | — | `Imports` | New HTTP backend |
| `usethis` | `Imports` | `Suggests` | Messaging migration to `cli`; retained only for [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html) doc references |
| `furrr` | `Imports` | `Suggests` | Optional parallel features only; not required for core functionality |
| `future` | `Imports` | `Suggests` | Same as `furrr` — optional parallel features |
| `lifecycle` | — | `Imports` | Required for the new [`lifecycle::deprecate_stop()`](https://lifecycle.r-lib.org/reference/deprecate_soft.html) deprecation pattern |
| `qs` | `Imports` | Removed | No longer used by any code path |

##### *CI, build, and contribution improvements*

- Added workflow-level concurrency and explicit permissions to GitHub
  Actions workflows.
- Clarified optional environment variable usage in CI for live API test
  toggles.
- Updated package build ignores to exclude local development folders
  from source checks.
- Updated GitHub Actions to v4.
- Cleaned up `.Rbuildignore` duplicates.
- Internal `nba_endpoint()` registry updated with all V3 boxscore
  endpoints and `boxscoresummaryv3`.
- Added comprehensive `CONTRIBUTING.md` with naming conventions and test
  environment documentation.

##### *Social branding (Twitter → X)*

- Updated all social media links and badges from Twitter to X across
  README, pkgdown site, and vignettes.
- Shields.io badge `logo=twitter` → `logo=x`; profile URLs `twitter.com`
  → `x.com`.
- pkgdown navbar icon updated from `fa-twitter` to `fa-x-twitter`.

## **hoopR 2.1.0**

CRAN release: 2023-11-25

- `load_nba_*()` functions now use `sportsdataverse-data` releases url
  instead of `hoopR-data` repository URL
- `load_mbb_*()` functions now use `sportsdataverse-data` releases url
  instead of `hoopR-data` repository URL
- [`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md)
  and
  [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md)
  functions add parameter `on_court` (default `TRUE`) to return on-court
  players for each play event, courtesy of
  [@shufinskiy](https://github.com/shufinskiy)

## **hoopR 2.0.0**

#### **NBA Stats API Live Endpoints**

- [`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md)
  function added.
- [`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md)
  function added.
- [`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)
  function added.

#### **NBA Boxscore V3 (and V3-styled) Endpoints Added**

- [`nba_scoreboardv3()`](https://hoopR.sportsdataverse.org/reference/nba_scoreboardv3.md)
  function added.
- [`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
  function added.
- [`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md)
  function added.
- [`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md)
  function added.
- [`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md)
  function added.
- [`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)
  function added.
- [`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md)
  function added.
- [`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md)
  function added.
- [`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md)
  function added.
- [`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md)
  function added.
- [`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md)
  function added.

#### **Other NBA Stats API functions added**

- [`nba_shotchartlineupdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartlineupdetail.md)
  function added.
- [`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md)
  function added.
- [`nba_franchiseleaderswrank()`](https://hoopR.sportsdataverse.org/reference/nba_franchiseleaderswrank.md)
  function added.
- [`nba_videodetailsasset()`](https://hoopR.sportsdataverse.org/reference/nba_videodetailsasset.md)
  function added.
- [`nba_infographicfanduelplayer()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)
  function added.
- [`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teams.md)
  function added.

#### **Other Functions Added**

- [`ncaa_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_teams.md)
  function added.

#### **Proxy Capability Added and Other Notes**

- Add rlang dots option for passing
  [`httr::use_proxy()`](https://httr.r-lib.org/reference/use_proxy.html)
  option to `nba_*()` functions
- Returns documentation added for all working NBA Stats API endpoints
  and ESPN functions
- Tests added for all working NBA Stats API endpoints and ESPN
  functions, over 1000 tests when run locally

## **hoopR 1.9.1**

- Updates under-the-hood urls to the ESPN site API v2 summary endpoints

## **hoopR 1.9.0**

- Takes care of tidyselect deprecation of data masking for certain tidyr
  and dplyr functions.
- Regular minor maintenance on `kp_*` functions
- [`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md)
  function added.
- [`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md)
  function added.

## **hoopR 1.8.1**

- [`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md)
  function exported properly.
- [`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md)
  function exported properly.
- Fixing headers for `kp_` functions.

## **hoopR 1.8.0**

CRAN release: 2022-06-17

- [`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md)
  function added.
- [`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md)
  function added.
- [`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md)
  function added.
- [`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md)
  function added.

## **hoopR 1.7.0**

- [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md)
  function added, courtesy of
  [@papagorgio23](https://github.com/papagorgio23).
- [`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md)
  function added, courtesy of
  [@billyfryer](https://github.com/billyfryer).
- [`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md)
  function added, courtesy of
  [@billyfryer](https://github.com/billyfryer).
- [`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md)
  function added, courtesy of
  [@billyfryer](https://github.com/billyfryer).
- [`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)
  function added, courtesy of
  [@billyfryer](https://github.com/billyfryer).
- [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md)
  function added.

## **hoopR 1.6.0**

- [`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md)
  function added.
- [`nba_playerheadshot()`](https://hoopR.sportsdataverse.org/reference/nba_playerheadshot.md)
  function added.
- [`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)
  function added.

## **hoopR 1.5.0**

CRAN release: 2021-11-10

- Major documentation update to include names of returned lists of data
  frames for all exported NBA Stats API, ESPN API, KenPom, NCAA and Data
  repository functions.

## **hoopR 1.4.5**

- Add
  [`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md)
  function

## **hoopR 1.4.4**

- Remove referee ranks from
  [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md)
  function

## **hoopR 1.4.3**

- Option configs changed to revert to user options

## **hoopR 1.4.2**

- Implement additional boxscore function parameters for
  `nba_boxscore(.*)` functions

## **hoopR 1.4.1**

- Update `teams_links` internal dataset for 2022 (need a better solve
  here)
- Added `nba_teams` dataset for working with the NBA Stats API

## **hoopR 1.4.0**

- [`hoopR::espn_mbb_betting()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_betting.html)
  function added
- [`hoopR::espn_nba_betting()`](https://hoopr.sportsdataverse.org/reference/espn_nba_betting.html)
  function added

## **hoopR 1.3.1**

- Fix
  [`kp_winprob`](https://hoopr.sportsdataverse.org/reference/kp_winprob.html)
  function, adding runs as third output

## **hoopR 1.3.0**

#### **Add Full Coverage for NBA Stats API**

Adding roughly 127 functions

| Function                              | File Location             |
|---------------------------------------|---------------------------|
| nba_alltimeleadersgrids               | R/nba_stats_leaders.R     |
| nba_assistleaders                     | R/nba_stats_leaders.R     |
| nba_assisttracker                     | R/nba_stats_leaders.R     |
| nba_boxscoreadvancedv2                | R/nba_stats_boxscore.R    |
| nba_boxscoredefensive                 | R/nba_stats_boxscore.R    |
| nba_boxscorefourfactorsv2             | R/nba_stats_boxscore.R    |
| nba_boxscorematchups                  | R/nba_stats_boxscore.R    |
| nba_boxscoremiscv2                    | R/nba_stats_boxscore.R    |
| nba_boxscoreplayertrackv2             | R/nba_stats_boxscore.R    |
| nba_boxscorescoringv2                 | R/nba_stats_boxscore.R    |
| nba_boxscoresimilarityscore           | R/nba_stats_boxscore.R    |
| nba_boxscoresummaryv2                 | R/nba_stats_boxscore.R    |
| nba_boxscoretraditionalv2             | R/nba_stats_boxscore.R    |
| nba_boxscoreusagev2                   | R/nba_stats_boxscore.R    |
| nba_commonallplayers                  | R/nba_stats_roster.R      |
| nba_commonplayerinfo                  | R/nba_stats_roster.R      |
| nba_commonplayoffseries               | R/nba_stats_roster.R      |
| nba_commonteamroster                  | R/nba_stats_roster.R      |
| nba_cumestatsplayer                   | R/nba_stats_cume.R        |
| nba_cumestatsplayergames              | R/nba_stats_cume.R        |
| nba_cumestatsteam                     | R/nba_stats_cume.R        |
| nba_cumestatsteamgames                | R/nba_stats_cume.R        |
| nba_defensehub                        | R/nba_stats_leaders.R     |
| nba_draftboard                        | R/nba_stats_draft.R       |
| nba_draftcombinedrillresults          | R/nba_stats_draft.R       |
| nba_draftcombinenonstationaryshooting | R/nba_stats_draft.R       |
| nba_draftcombineplayeranthro          | R/nba_stats_draft.R       |
| nba_draftcombinespotshooting          | R/nba_stats_draft.R       |
| nba_draftcombinestats                 | R/nba_stats_draft.R       |
| nba_fantasywidget                     | R/nba_stats_lineups.R     |
| nba_franchisehistory                  | R/nba_stats_franchise.R   |
| nba_franchiseleaders                  | R/nba_stats_franchise.R   |
| nba_franchiseplayers                  | R/nba_stats_franchise.R   |
| nba_glalumboxscoresimilarityscore     | R/nba_stats_boxscore.R    |
| nba_homepageleaders                   | R/nba_stats_leaders.R     |
| nba_homepagev2                        | R/nba_stats_leaders.R     |
| nba_hustlestatsboxscore               | R/nba_stats_boxscore.R    |
| nba_leaderstiles                      | R/nba_stats_leaders.R     |
| nba_leaguedashlineups                 | R/nba_stats_lineups.R     |
| nba_leaguedashoppptshot               | R/nba_stats_league_dash.R |
| nba_leaguedashplayerbiostats          | R/nba_stats_league_dash.R |
| nba_leaguedashplayerclutch            | R/nba_stats_league_dash.R |
| nba_leaguedashplayerptshot            | R/nba_stats_league_dash.R |
| nba_leaguedashplayershotlocations     | R/nba_stats_league_dash.R |
| nba_leaguedashplayerstats             | R/nba_stats_league_dash.R |
| nba_leaguedashptdefend                | R/nba_stats_league_dash.R |
| nba_leaguedashptstats                 | R/nba_stats_league_dash.R |
| nba_leaguedashptteamdefend            | R/nba_stats_league_dash.R |
| nba_leaguedashteamclutch              | R/nba_stats_league_dash.R |
| nba_leaguedashteamptshot              | R/nba_stats_league_dash.R |
| nba_leaguedashteamshotlocations       | R/nba_stats_league_dash.R |
| nba_leaguedashteamstats               | R/nba_stats_league_dash.R |
| nba_leaguegamefinder                  | R/nba_stats_league.R      |
| nba_leaguegamelog                     | R/nba_stats_league.R      |
| nba_leaguehustlestatsplayer           | R/nba_stats_hustle.R      |
| nba_leaguehustlestatsplayerleaders    | R/nba_stats_hustle.R      |
| nba_leaguehustlestatsteam             | R/nba_stats_hustle.R      |
| nba_leaguehustlestatsteamleaders      | R/nba_stats_hustle.R      |
| nba_leagueleaders                     | R/nba_stats_leaders.R     |
| nba_leaguelineupviz                   | R/nba_stats_lineups.R     |
| nba_leagueplayerondetails             | R/nba_stats_lineups.R     |
| nba_leagueseasonmatchups              | R/nba_stats_lineups.R     |
| nba_leaguestandings                   | R/nba_stats_league.R      |
| nba_leaguestandingsv3                 | R/nba_stats_league.R      |
| nba_matchupsrollup                    | R/nba_stats_lineups.R     |
| nba_pbp                               | R/nba_stats_pbp.R         |
| nba_playerawards                      | R/nba_stats_player.R      |
| nba_playercareerbycollege             | R/nba_stats_player.R      |
| nba_playercareerbycollegerollup       | R/nba_stats_player.R      |
| nba_playercareerstats                 | R/nba_stats_player.R      |
| nba_playercompare                     | R/nba_stats_player.R      |
| nba_playerdashboardbyclutch           | R/nba_stats_player_dash.R |
| nba_playerdashboardbygamesplits       | R/nba_stats_player_dash.R |
| nba_playerdashboardbygeneralsplits    | R/nba_stats_player_dash.R |
| nba_playerdashboardbylastngames       | R/nba_stats_player_dash.R |
| nba_playerdashboardbyopponent         | R/nba_stats_player_dash.R |
| nba_playerdashboardbyshootingsplits   | R/nba_stats_player_dash.R |
| nba_playerdashboardbyteamperformance  | R/nba_stats_player_dash.R |
| nba_playerdashboardbyyearoveryear     | R/nba_stats_player_dash.R |
| nba_playerdashptpass                  | R/nba_stats_player_dash.R |
| nba_playerdashptreb                   | R/nba_stats_player_dash.R |
| nba_playerdashptshotdefend            | R/nba_stats_player_dash.R |
| nba_playerdashptshots                 | R/nba_stats_player_dash.R |
| nba_playerestimatedmetrics            | R/nba_stats_player.R      |
| nba_playerfantasyprofile              | R/nba_stats_player.R      |
| nba_playerfantasyprofilebargraph      | R/nba_stats_player.R      |
| nba_playergamelog                     | R/nba_stats_player.R      |
| nba_playergamelogs                    | R/nba_stats_player.R      |
| nba_playergamestreakfinder            | R/nba_stats_player.R      |
| nba_playernextngames                  | R/nba_stats_player.R      |
| nba_playerprofilev2                   | R/nba_stats_player.R      |
| nba_playervsplayer                    | R/nba_stats_player.R      |
| nba_playoffpicture                    | R/nba_stats_league.R      |
| nba_schedule                          | R/nba_stats_pbp.R         |
| nba_scoreboard                        | R/nba_stats_scoreboard.R  |
| nba_scoreboardv2                      | R/nba_stats_scoreboard.R  |
| nba_shotchartdetail                   | R/nba_stats_shotchart.R   |
| nba_shotchartleaguewide               | R/nba_stats_shotchart.R   |
| nba_teamdashboardbyclutch             | R/nba_stats_team_dash.R   |
| nba_teamdashboardbygamesplits         | R/nba_stats_team_dash.R   |
| nba_teamdashboardbygeneralsplits      | R/nba_stats_team_dash.R   |
| nba_teamdashboardbylastngames         | R/nba_stats_team_dash.R   |
| nba_teamdashboardbyopponent           | R/nba_stats_team_dash.R   |
| nba_teamdashboardbyshootingsplits     | R/nba_stats_team_dash.R   |
| nba_teamdashboardbyteamperformance    | R/nba_stats_team_dash.R   |
| nba_teamdashboardbyyearoveryear       | R/nba_stats_team_dash.R   |
| nba_teamdashlineups                   | R/nba_stats_team_dash.R   |
| nba_teamdashptpass                    | R/nba_stats_team_dash.R   |
| nba_teamdashptreb                     | R/nba_stats_team_dash.R   |
| nba_teamdashptshots                   | R/nba_stats_team_dash.R   |
| nba_teamdetails                       | R/nba_stats_team.R        |
| nba_teamestimatedmetrics              | R/nba_stats_team.R        |
| nba_teamgamelog                       | R/nba_stats_team.R        |
| nba_teamgamelogs                      | R/nba_stats_team.R        |
| nba_teamgamestreakfinder              | R/nba_stats_team.R        |
| nba_teamhistoricalleaders             | R/nba_stats_team.R        |
| nba_teaminfocommon                    | R/nba_stats_team.R        |
| nba_teamplayerdashboard               | R/nba_stats_team.R        |
| nba_teamplayeronoffdetails            | R/nba_stats_team.R        |
| nba_teamplayeronoffsummary            | R/nba_stats_team.R        |
| nba_teamvsplayer                      | R/nba_stats_team.R        |
| nba_teamyearbyyearstats               | R/nba_stats_team.R        |
| nba_videodetails                      | R/nba_stats_video.R       |
| nba_videoevents                       | R/nba_stats_video.R       |
| nba_videostatus                       | R/nba_stats_video.R       |
| nba_winprobabilitypbp                 | R/nba_stats_scoreboard.R  |

## **hoopR 1.2.0**

#### **Add schedule loaders**

- [`hoopR::load_mbb_schedule()`](https://hoopr.sportsdataverse.org/reference/load_mbb_schedule.html)
  function added
- [`hoopR::load_nba_schedule()`](https://hoopr.sportsdataverse.org/reference/load_nba_schedule.html)
  function added

## **hoopR 1.1.0**

#### **Add team box score loaders**

- [`hoopR::load_mbb_team_box()`](https://hoopr.sportsdataverse.org/reference/load_mbb_team_box.html)
  function added
- [`hoopR::load_nba_team_box()`](https://hoopr.sportsdataverse.org/reference/load_nba_team_box.html)
  function added

#### **Add player box score loaders**

- [`hoopR::load_mbb_player_box()`](https://hoopr.sportsdataverse.org/reference/load_mbb_player_box.html)
  function added
- [`hoopR::load_nba_player_box()`](https://hoopr.sportsdataverse.org/reference/load_nba_player_box.html)
  function added

## **hoopR 1.0.5**

#### **Standings functions**

- [`hoopR::espn_nba_standings()`](https://hoopr.sportsdataverse.org/reference/espn_nba_standings.html)
- [`hoopR::espn_mbb_standings()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_standings.html)

## **hoopR 1.0.4**

#### **Add retry**

- Adding [`httr::retry()`](https://httr.r-lib.org/reference/RETRY.html)
  to all function calls to more naturally navigate rejected/failed
  requests from the API.

## **hoopR 1.0.2-3**

#### **Quick fix for update db functions**

## **hoopR 1.0.1-4**

#### **Dependency pruning**

This update is a non-user facing change to package dependencies to
shrink the list of dependencies.

## **hoopR 1.0.0**

#### **Package renamed to hoopR**

To reflect that the package is no longer just a men’s college basketball
and KenPom package, but also an NBA package.

#### **Clean names and team returns**

- All functions have now been given the
  [`janitor::clean_names()`](https://rdrr.io/cran/janitor/man/clean_names.html)
  treatment
- [`hoopR::espn_mbb_teams()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_teams.html)
  has updated the returns to be more identity information related only
- [`hoopR::espn_nba_teams()`](https://hoopr.sportsdataverse.org/reference/espn_nba_teams.html)
  to be more identity information related only
- All tests were updated

#### **Loading capabilities added to the package**

- [`hoopR::load_mbb_pbp()`](https://hoopr.sportsdataverse.org/reference/load_mbb_pbp.html)
  and
  [`hoopR::update_mbb_db()`](https://hoopr.sportsdataverse.org/reference/update_mbb_db.html)
  functions added
- [`hoopR::load_nba_pbp()`](https://hoopr.sportsdataverse.org/reference/load_nba_pbp.html)
  and
  [`hoopR::update_nba_db()`](https://hoopr.sportsdataverse.org/reference/update_nba_db.html)
  functions added

## **hoopR 0.4**

- Added support for ESPN’s NBA play-by-play endpoints with the addition
  of the following functions:
- [`hoopR::espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md) -
  a convenience wrapper function around the following three functions
  (returns the results as a list of three data frames)
- [`hoopR::espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md)
- [`hoopR::espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md)
- [`hoopR::espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md)
- [`hoopR::espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md)
- [`hoopR::espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md)

## **hoopR 0.3.0**

#### **Dependencies**

- `R` version 3.5.0 or greater dependency added
- `purrr` version 0.3.0 or greater dependency added
- `rvest` version 1.0.0 or greater dependency added
- `progressr` version 0.6.0 or greater dependency added
- `usethis` version 1.6.0 or greater dependency added
- `xgboost` version 1.1.0 or greater dependency added
- `tidyr` version 1.0.0 or greater dependency added
- `stringr` version 1.3.0 or greater dependency added
- `tibble` version 3.0.0 or greater dependency added
- `furrr` dependency added
- `future` dependency added

#### **Test coverage**

- Added tests for all KP and ESPN functions

##### **Function Naming Convention Change**

- All functions sourced from [kenpom.com](https://kenpom.com/) will
  start with `kp_` as opposed to `get_`
- Similarly, data and metrics sourced from ESPN will begin with `espn_`
  as opposed to `cbb_`. Moreover, all references to `cbb_` have been
  changed to `mbb_` as appropriate.
- Data sourced directly from the NCAA website will start the function
  with `ncaa_`

## **hoopR 0.2.0-3**

- Added support for ESPN’s men’s college basketball play-by-play
  endpoints with the addition of the following functions:
- [`hoopR::espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md) -
  a convenience wrapper function around the following three functions
  (returns the results as a list of three data frames)
- [`hoopR::espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md)
- [`hoopR::espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md)
- [`hoopR::espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md)
- [`hoopR::espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md)
  (bumps to v0.2.1)
- [`hoopR::espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md)
  (bumps to v0.2.1)
- [`hoopR::espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md)
  (bumps to v0.2.2)
- [`hoopR::ncaa_mbb_NET_rankings()`](https://hoopR.sportsdataverse.org/reference/ncaa_mbb_NET_rankings.md)
  (bumps to v0.2.3)
- [`hoopR::espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md)
  (bumps to v0.2.3)

## **hoopR 0.1.0**

- Minor fixes

## **hoopR 0.0.0.9**

Initial Commits, remaining tasks:

- Game Prep Tables
- ~~Player Career Tables~~
- ~~Game Box Scores~~
- ~~Argument assertions~~
