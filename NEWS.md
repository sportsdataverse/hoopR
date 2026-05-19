<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [**hoopR 3.1.0**](#hoopr-310)
- [**hoopR 3.0.0**](#hoopr-300)
- [**hoopR 2.1.0**](#hoopr-210)
- [**hoopR 2.0.0**](#hoopr-200)
- [**hoopR 1.9.1**](#hoopr-191)
- [**hoopR 1.9.0**](#hoopr-190)
- [**hoopR 1.8.1**](#hoopr-181)
- [**hoopR 1.8.0**](#hoopr-180)
- [**hoopR 1.7.0**](#hoopr-170)
- [**hoopR 1.6.0**](#hoopr-160)
- [**hoopR 1.5.0**](#hoopr-150)
- [**hoopR 1.4.5**](#hoopr-145)
- [**hoopR 1.4.4**](#hoopr-144)
- [**hoopR 1.4.3**](#hoopr-143)
- [**hoopR 1.4.2**](#hoopr-142)
- [**hoopR 1.4.1**](#hoopr-141)
- [**hoopR 1.4.0**](#hoopr-140)
- [**hoopR 1.3.1**](#hoopr-131)
- [**hoopR 1.3.0**](#hoopr-130)
- [**hoopR 1.2.0**](#hoopr-120)
- [**hoopR 1.1.0**](#hoopr-110)
- [**hoopR 1.0.5**](#hoopr-105)
- [**hoopR 1.0.4**](#hoopr-104)
- [**hoopR 1.0.2-3**](#hoopr-102-3)
- [**hoopR 1.0.1-4**](#hoopr-101-4)
- [**hoopR 1.0.0**](#hoopr-100)
- [**hoopR 0.4**](#hoopr-04)
- [**hoopR 0.3.0**](#hoopr-030)
- [**hoopR 0.2.0-3**](#hoopr-020-3)
- [**hoopR 0.1.0**](#hoopr-010)
- [**hoopR 0.0.0.9**](#hoopr-0009)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# **hoopR 3.1.0**

Development release on top of the CRAN-shipped 3.0.0 (commit
[b76100b3](https://github.com/sportsdataverse/hoopR/commit/b76100b36467b8ec12045f1ca0871028aa06714b)).
Headline change is a **58-wrapper ESPN endpoint expansion** that brings
hoopR's ESPN coverage to parity with wehoop — athlete coverage, team
detail, event detail, league catalog, news, calendar, injuries, plus
draft / freeagents / transactions for the NBA. Also includes bug fixes
for endpoint behavior that drifted after CRAN submission, the
package-wide `@return` documentation upgrade, and a proxy-support
restoration that addresses a regression introduced by the 3.0.0
`httr` → `httr2` migration.

### **New exported functions**

58 new ESPN wrappers added across 8 domains (29 per league × 2 leagues
+ 4 NBA-only). All built on shared internal helpers in
`R/espn_basketball_*_helpers.R` so each MBB / NBA pair stays DRY — one
bugfix in the helper propagates to both public wrappers. Same
internal-helpers-plus-thin-shims pattern wehoop uses for its
WBB / WNBA pair.

#### *Athlete coverage (×8 per league)*

| Function | Endpoint family | Description |
|---|---|---|
| `espn_mbb_athlete_info()` / `espn_nba_athlete_info()` | site-v2 | Athlete bio / team / position / status / college / draft info. |
| `espn_mbb_athlete_overview()` / `espn_nba_athlete_overview()` | web-common-v3 | Season overview + last-5-games + news + rotowire notes. |
| `espn_mbb_athlete_stats()` / `espn_nba_athlete_stats()` | web-common-v3 | Per-category stats as a named list (averages / totals). |
| `espn_mbb_athlete_gamelog()` / `espn_nba_athlete_gamelog()` | web-common-v3 | Game-by-game log. |
| `espn_mbb_athlete_splits()` / `espn_nba_athlete_splits()` | web-common-v3 | Long-format home / away / opponent splits. |
| `espn_mbb_athlete_eventlog()` / `espn_nba_athlete_eventlog()` | core-v2 | Per-event log. `statistics.$ref` URLs returned as `statistics_ref` character column (not auto-resolved). |
| `espn_mbb_athlete_awards()` / `espn_nba_athlete_awards()` | core-v2 | Awards (sparse / often empty); empty payload returns a canonical-shape empty tibble. |
| `espn_mbb_athlete_statisticslog()` / `espn_nba_athlete_statisticslog()` | core-v2 | Per-season statistics log. |

#### *Team detail (×5 per league)*

| Function | Description |
|---|---|
| `espn_mbb_team()` / `espn_nba_team()` | Single-team info as a named list (`Info`, `Record`, `NextEvent`, `StandingSummary`, `Coaches`). |
| `espn_mbb_team_roster()` / `espn_nba_team_roster()` | Roster (one row per athlete with position, height, weight, headshot). |
| `espn_mbb_team_schedule()` / `espn_nba_team_schedule()` | Schedule (one row per event with opponent, venue, broadcast, result). |
| `espn_mbb_team_leaders()` / `espn_nba_team_leaders()` | Statistical leaders in long format per category-rank-athlete. |
| `espn_mbb_team_news()` / `espn_nba_team_news()` | Team-scoped news feed. |

#### *Event detail (×4 per league)*

| Function | Description |
|---|---|
| `espn_mbb_event_odds()` / `espn_nba_event_odds()` | Game-level odds (one row per provider). |
| `espn_mbb_event_probabilities()` / `espn_nba_event_probabilities()` | Paginated play-level win probabilities (page loop capped at 50 pages; respects `limit`). |
| `espn_mbb_event_officials()` / `espn_nba_event_officials()` | Per-game officials. |
| `espn_mbb_event_broadcasts()` / `espn_nba_event_broadcasts()` | Broadcast outlets. |

#### *League catalog (×6 per league)*

| Function | Description |
|---|---|
| `espn_mbb_leaders()` / `espn_nba_leaders()` | League leaders (web-common-v3 `statistics/byathlete`). |
| `espn_mbb_venues()` / `espn_nba_venues()` | Venue catalog. |
| `espn_mbb_coaches()` / `espn_nba_coaches()` | Coach roster. |
| `espn_mbb_athletes_index()` / `espn_nba_athletes_index()` | Paginated athlete index with progress messages. |
| `espn_mbb_seasons()` / `espn_nba_seasons()` | Season list. |
| `espn_mbb_season_info()` / `espn_nba_season_info()` | Single-season info. |

#### *News + calendar (×2 per league)*

| Function | Description |
|---|---|
| `espn_mbb_news()` / `espn_nba_news()` | League-level news feed (site-v2 `/news`). |
| `espn_mbb_calendar()` / `espn_nba_calendar()` | Scoreboard calendar blocks (site-v2 `/scoreboard?dates={season}`). |

#### *Injuries (×2 per league)*

| Function | Description |
|---|---|
| `espn_mbb_injuries()` / `espn_nba_injuries()` | League-wide injury feed (site-v2 `/injuries`). |
| `espn_mbb_team_injuries()` / `espn_nba_team_injuries()` | Team-scoped injury feed (site-v2 `/teams/{id}/injuries`). |

MBB injury data is typically sparse on ESPN; both variants return an empty tibble (rather than erroring) when no injuries are reported.

#### *NBA-only ESPN endpoints*

| Function | Description |
|---|---|
| `espn_nba_draft()` | Paginates core-v2 `/seasons/{year}/draft` (up to 20 pages); flat tibble of picks. |
| `espn_nba_freeagents()` | Wraps core-v2 `/seasons/{year}/freeagents`; returns an empty tibble outside the off-season free-agent window. |
| `espn_nba_transactions()` | Wraps site-v2 `/transactions?season={year}&limit={limit}` with null-safe `to_team_id` for release transactions. |
| `espn_nba_conferences()` | NBA-side analog of `espn_mbb_conferences()`, against the NBA scoreboard-conferences endpoint. |

#### *Tier 1 core-v2 expansion (crawler-driven)*

22 new wrappers across 9 resource families, surfaced by an internal `$ref`-following crawler that mapped the reachable basketball API surface (21,962 fetches, 1,570 unique templates across all 4 basketball leagues). Each wrapper is a thin shim over a shared `.espn_basketball_*()` helper. WNBA + WBB siblings ship in wehoop's matching release.

| Function | Description |
|---|---|
| `espn_nba_team_season_profile()` / `espn_mbb_team_season_profile()` | Era-correct team identity in a specific season plus `$ref` URLs for deeper resources (record, statistics, leaders, coaches, etc.). Historical depth back to **1947** (NBA) / **1939** (MBB). |
| `espn_nba_franchise()` / `espn_mbb_franchise()` | Franchise-level metadata. IDs are stable across relocations and rebrands. |
| `espn_nba_franchises()` / `espn_mbb_franchises()` | Index of franchise IDs in the league. |
| `espn_nba_athlete_contracts()` | Index of contract seasons recorded for an NBA athlete (NBA-only — WNBA athletes return empty). |
| `espn_nba_athlete_contract()` | Salary, cap-rule flags, Bird status, and trade protections for one (athlete × season). |
| `espn_nba_season_awards()` / `espn_mbb_season_awards()` | Index of award IDs given out in a season. |
| `espn_nba_award()` / `espn_mbb_award()` | Award detail with winners (one row per winner; multi-recipient awards like All-NBA return 5 rows). |
| `espn_nba_futures()` / `espn_mbb_futures()` | Per-season futures betting board in long format (one row per market × team × sportsbook). |
| `espn_nba_tournaments()` / `espn_mbb_tournaments()` | Index of league-tracked tournaments. |
| `espn_nba_tournament()` / `espn_mbb_tournament()` | Single tournament metadata + seasons-list `$ref`. |
| `espn_nba_tournament_seasons()` / `espn_mbb_tournament_seasons()` | Seasons in which a given tournament was held. |
| `espn_nba_team_record()` / `espn_mbb_team_record()` | Long-format record breakdown for one team in one season-type (Overall / Home / Road / vs Conference / etc.). |
| `espn_nba_coach()` / `espn_mbb_coach()` | Single-coach biography, current team / college refs, and counts of career-record + per-season coaching entries. |
| `espn_nba_powerindex()` / `espn_mbb_powerindex()` | Per-season Basketball Power Index and related metrics, long format (one row per team × stat). |

#### *Tier 2A core-v2 expansion — season metadata*

10 new wrappers across 5 resource families covering season-level metadata: season types, the per-(season × season-type) leaderboards, and (mostly college-only) season rankings. Backed by a shared `R/espn_basketball_season_meta_helpers.R`. WNBA + WBB siblings ship in wehoop's matching release.

| Function | Description |
|---|---|
| `espn_nba_season_types()` / `espn_mbb_season_types()` | Index of season-type IDs that exist for one season (1 = preseason, 2 = regular, 3 = postseason, 4 = off-season). |
| `espn_nba_season_type()` / `espn_mbb_season_type()` | Single season-type detail (start / end dates, has-groups / has-standings / has-legs flags, `$ref` URLs to deeper resources). |
| `espn_nba_season_leaders()` / `espn_mbb_season_leaders()` | Per-(season × season-type) leaderboards in long format (one row per category × rank). 14–15 categories × 25 leaders ≈ 350 rows. |
| `espn_nba_season_rankings()` / `espn_mbb_season_rankings()` | Index of season-level rankings recorded for a season (NBA / WNBA return zero; MBB / WBB return AP Top 25 + Coaches Poll). |
| `espn_nba_season_ranking()` / `espn_mbb_season_ranking()` | Per-week snapshot index for one ranking source — each row resolves to a per-week ranked-teams endpoint. |

#### *Tier 2A core-v2 expansion — weeks + per-week rankings*

8 new wrappers across 4 resource families covering the week structure of a season. Backed by a shared `R/espn_basketball_week_helpers.R`. WNBA + WBB siblings ship in wehoop's matching release.

| Function | Description |
|---|---|
| `espn_nba_season_weeks()` / `espn_mbb_season_weeks()` | Index of weeks within one (season × season-type). Typical: ~20 weeks for regular season. NBA / WNBA also have weeks; rankings only populate for MBB / WBB. |
| `espn_nba_season_week()` / `espn_mbb_season_week()` | Single-week metadata (number, start / end dates, text label, `$ref` to the per-week rankings endpoint). |
| `espn_nba_week_rankings()` / `espn_mbb_week_rankings()` | Index of ranking sources for one week (NBA returns zero; MBB returns AP + Coaches). |
| `espn_nba_week_ranking()` / `espn_mbb_week_ranking()` | The ranked teams (typically 25 rows) for one (season-type × week × source). Includes current / previous rank, points, first-place votes, trend, record summary, team `$ref`. |

#### *Tier 2A core-v2 expansion — groups (conferences and divisions)*

8 new wrappers across 4 resource families covering the per-season group hierarchy (conferences, divisions, and member teams). Backed by a shared `R/espn_basketball_group_helpers.R`. WNBA + WBB siblings ship in wehoop's matching release.

| Function | Description |
|---|---|
| `espn_nba_season_groups()` / `espn_mbb_season_groups()` | Index of group IDs (conferences / divisions) for one (season × season-type). |
| `espn_nba_season_group()` / `espn_mbb_season_group()` | Single-group metadata (name, abbreviation, midsize / short name, `is_conference` flag) plus `$ref` URLs to parent, children, member teams, and standings. |
| `espn_nba_season_group_children()` / `espn_mbb_season_group_children()` | Index of child groups (e.g. divisions inside a conference, or conferences inside the NCAA Division I umbrella group). |
| `espn_nba_season_group_teams()` / `espn_mbb_season_group_teams()` | Index of team IDs that belong to the group for that (season × season-type). |

#### *Tier 2A core-v2 expansion — team deep + coach-in-season*

7 new wrappers across 4 resource families covering deeper per-team and per-coach core-v2 endpoints. Backed by a shared `R/espn_basketball_team_deep_helpers.R`. WNBA + WBB siblings (where applicable) ship in wehoop's matching release.

| Function | Description |
|---|---|
| `espn_nba_team_odds_records()` / `espn_mbb_team_odds_records()` | Long-format odds-records breakdown (Money Line / ATS / O/U × Overall / Home / Road × W/L/Push). Sparse — many (team × season-type) combinations return empty. Default `season_type = 0` (all-types aggregate, where ESPN actually populates). |
| `espn_nba_team_depthchart()` | NBA-only long-format depth chart (one row per position × rank × athlete). |
| `espn_nba_team_season_roster()` / `espn_mbb_team_season_roster()` | Per-season roster (core-v2 `seasons/{y}/teams/{id}/athletes`). Distinct from the existing site-v2 `espn_*_team_roster()`: era-correct, available back to the league's earliest season. |
| `espn_nba_coach_season()` / `espn_mbb_coach_season()` | Single-coach metadata for one (coach × season). Includes name, birth info, and `$ref`s to person / college / team. Sparse coverage — many combinations 404. |

#### *Tier 2A core-v2 expansion — athlete career + draft pick*

5 new wrappers across 3 resource families covering career-level athlete endpoints and the single-draft-pick lookup. Backed by `R/espn_basketball_athlete_career_helpers.R` and `R/espn_basketball_draft_helpers.R`.

| Function | Description |
|---|---|
| `espn_nba_athlete_seasons()` / `espn_mbb_athlete_seasons()` | List of seasons an athlete appeared in. |
| `espn_nba_athlete_career_stats()` / `espn_mbb_athlete_career_stats()` | Long-format career stats. Default `stat_type = 0L` fetches the standard "All Splits" / regular-season view; pass a vector like `c(0L, 1L, 2L)` to bind multiple types (postseason / career aggregate) via a `stat_type_id` column. Coverage of types 1 and 2 is sparse — many athletes only populate type 0. |
| `espn_nba_draft_pick()` | Single NBA draft-pick detail (defaults to most-recent NBA season, round 1, pick 1). MBB has no draft endpoint, so this wrapper is NBA-only on the hoopR side. |

#### *Tier 2B core-v2 expansion — athlete event log + draft completion*

5 new wrappers across 2 resource families. Extends the athlete and draft endpoint coverage with the remaining per-season core-v2 endpoints.

| Function | Description |
|---|---|
| `espn_nba_athlete_eventlog_v2()` / `espn_mbb_athlete_eventlog_v2()` | Per-season event log from core-v2 (`seasons/{y}/athletes/{id}/eventlog`). One row per (event × team) appearance with `played` flag + event/competition `$ref`s. Distinct from the existing `espn_*_athlete_eventlog()` which hits the web-common-v3 gamelog endpoint with stats per game. |
| `espn_nba_draft_rounds()` | Round-level summary for one NBA draft year (one row per round with pick count + completion status). |
| `espn_nba_draft_athletes()` | Index of every athlete in a given NBA draft year (~102 entries: 60 picks + undrafted invitees). |
| `espn_nba_draft_status()` | Single-row snapshot of one draft year's current state. |

#### *Tier 2B core-v2 expansion — event meta endpoints*

8 new wrappers across 4 resource families. Each wraps `events/{eid}/competitions/{cid}/...` and is added to both NBA and MBB shim files (16 new public functions across both leagues per package = 8 each).

| Function | Description |
|---|---|
| `espn_nba_event_situation()` / `espn_mbb_event_situation()` | Live game situation: timeouts, fouls, fouls-to-give, bonus state, last-play `$ref`. Single-row tibble. |
| `espn_nba_event_predictor()` / `espn_mbb_event_predictor()` | Pre-game predictor statistics in long format (one row per team × stat). Stats include matchup quality, predicted score, win pct, team-predicted MoV. Returns empty for events without predictor data. |
| `espn_nba_event_powerindex()` / `espn_mbb_event_powerindex()` | Per-event power-index `$ref` index. Coverage is sparse — most events return zero items. |
| `espn_nba_event_propbets()` / `espn_mbb_event_propbets()` | Per-(event × provider) prop-bet markets in long format. One row per (athlete × prop type) with american / decimal / fraction odds + current target line. Auto-paginates. |

#### *Tier 2B core-v2 expansion — event competitor sub-resources*

5 new resource families under `events/{eid}/competitions/{cid}/competitors/{team_id}/`, each shimmed for NBA and MBB (10 new public functions per package). Pair the team_id with the event_id from `espn_*_schedule()` (or any `boxscore.teams[].id`).

| Function | Description |
|---|---|
| `espn_nba_event_competitor_linescores()` / `espn_mbb_event_competitor_linescores()` | Per-quarter scoring for one team in one event. One row per period (regulation + overtime). |
| `espn_nba_event_competitor_leaders()` / `espn_mbb_event_competitor_leaders()` | Top performers per team in long format: one row per (category × athlete rank). Categories typically include points, rebounds, assists, and rating. |
| `espn_nba_event_competitor_roster()` / `espn_mbb_event_competitor_roster()` | Game-day roster index for one team. Returns athlete ids + core-v2 `$ref` URLs for deferred dereferencing. |
| `espn_nba_event_competitor_statistics()` / `espn_mbb_event_competitor_statistics()` | Full team-game statistics in long format (one row per category × stat) with both numeric values and display strings. |
| `espn_nba_event_competitor_records()` / `espn_mbb_event_competitor_records()` | Team records as of the event: overall / home / away / conference / division breakdowns. |

### **Behavior changes to existing functions**

#### *Bug fixes*

| Function | Fix |
|---|---|
| `nba_schedule()` | Migrated off the retired `stats.nba.com/stats/scheduleleaguev2` endpoint (returns `Connection was reset` across multiple client environments; issues #184 and #187) to the public CDN at `cdn.nba.com/static/json/staticData/scheduleLeagueV2.json`. Same `leagueSchedule.gameDates[].games[]` payload, no authentication or special headers, stays current with the live season. G-League schedules now come from the `_2`-suffixed variant on the same CDN. For historical seasons (CDN only serves the current season) the function emits a `message()` directing users at `load_nba_schedule(seasons = ...)`. Also initializes `games <- NULL` before `tryCatch` (issue #184). Verified 2026-05-16: returns 1,398 NBA games × 52 cols for 2025-26. |
| `nba_leaguegamelog()` | Reordered query-string parameter ordering to put `LeagueID` first. As of 2026 the NBA Stats API rejects the alphabetical ordering (`Counter, DateFrom, DateTo, Direction, LeagueID, ...`) with a Cloudflare HTML error page; `LeagueID`-first matches the nba.com client and parses successfully. Verified 2026-05-16: returns 2,460 NBA rows with `SEASON_ID=22025`. Parallel fix to the WNBA equivalent in `wehoop`. |
| `ncaa_mbb_NET_rankings()` | Hardened against NCAA.com column drift. The function now uses `dplyr::rename(dplyr::any_of(...))` so renamed / added columns (e.g. new `Quad 1..4` headers) no longer break the documented schema; existing consumers keep working and new columns ride along untouched. |
| ESPN wrappers | Moved `.retry_request()` and `check_status()` *inside* `tryCatch` so transient HTTP errors surface as `cli_alert_danger()` + empty fallback rather than escaping the function. Affects every `espn_nba_*` / `espn_mbb_*` wrapper. |

### **Documentation improvements**

#### *@return column descriptions on every exported function*

Every `@return` markdown table across the 39 R source files is upgraded from two columns (`col_name | types`) to three columns (`col_name | types | description`). **6,039 total table rows** touched; every result set on every function now ships a per-column description in `?<function>` help, the pkgdown reference, and the rendered man pages.

**Coverage** — frequency-weighted, what `?fn` readers actually see — **58.4% of the 6,039 @return table rows now carry a hand-quality description** (curated + ESPN-API + mined). The remaining 41.6% are heuristic-fallback rows; the heuristic generator's snake_case expansion + suffix rules cover most of those acceptably, and the long tail is dominated by single-occurrence columns from low-traffic NBA Stats endpoints.

**Description sources** (precedence order, first match wins):

1. `tools/docs/column_descriptions_curated.csv` — 619 hand-authored entries covering high-traffic columns and basketball / ESPN domain conventions.
2. `tools/docs/column_descriptions_api.csv` — 188 ESPN-authored descriptions mined live from 14 endpoints per league across both `nba` and `mens-college-basketball`, covering 9 endpoint families: core-v2 athlete statistics (per-season, post-season, career), core-v2 team statistics, core-v2 statisticslog, core-v2 leaders, web-v3 athlete stats / splits / gamelog / overview, and web-v3 statistics/byathlete leaderboards. Three response shapes are recognized: nested categories with stats objects, parallel arrays under categories, and top-level parallel-array shapes (splits / gamelog).
3. Mined `\item{...}{...}` lines from existing `\describe{}` blocks.
4. Heuristic patterns driven by column-name suffixes (`*_id`, `*_pct`, `*_made`, `*_attempted`, `*_per_36`, etc.) with basketball-friendly noun substitution.

**New tooling under `tools/docs/`** (`.Rbuildignore`'d via the existing `^tools$` rule):

| File | Purpose |
|---|---|
| `build_column_descriptions.R` | One-shot dictionary builder. |
| `column_descriptions_curated.csv` | Hand-edit surface; overrides API / mined / heuristic outputs. |
| `column_descriptions_api.csv` | ESPN-API-mined descriptions, regenerated by `mine_api_descriptions.R`. |
| `column_descriptions.csv` | Generated dictionary (1,956 rows; 619 curated, 168 ESPN-API, 5 mined, 0 parameter-overlap, 1,164 heuristic). |
| `mine_api_descriptions.R` | Driver that probes the ESPN endpoints which self-document their stat columns. |
| `audit_column_descriptions.R` | Coverage / leverage diagnostic. |
| `markdown_man_table_helper.R` | Programmatic helpers (`load_column_descriptions()`, `make_return_table_md()`, `roxygenize_return()`, `augment_return_tables_in_file()`, `augment_all_r_files()`, `mine_espn_api_descriptions(url)`). |
| `espn_endpoints_catalog.md` | Basketball-scoped ESPN endpoint reference used to scope the miner. |

The sweep is idempotent and offline (no API calls needed for the augmentation itself; existing `|col_name|types|` tables in each `@return` block are the parse input).

### **Internals**

#### *HTTP layer — proxy support restored*

When the package migrated from `httr` to `httr2` in 3.0.0, the legacy `httr::use_proxy()` plumbing was dropped and `request_with_proxy()` quietly stopped honoring proxies (its `...` was preserved purely for source compatibility). Both `request_with_proxy()` and the lower-level `.retry_request()` now accept a `proxy =` argument:

- `proxy = NULL` (default) — libcurl reads `http_proxy` / `https_proxy` / `no_proxy` env vars automatically.
- `proxy = "http://host:port"` — string form, forwarded to `httr2::req_proxy(url = ...)`.
- `proxy = list(url=, port=, username=, password=, auth=)` — named list spread into `httr2::req_proxy()` for authenticated proxies.

Resolution order in `.retry_request()`: explicit `proxy =` arg → `getOption("hoopR.proxy")` → libcurl env vars. The `...` thread works for NBA Stats wrappers (which forward into `request_with_proxy()`); ESPN / KenPom / NBA G-League wrappers call `.retry_request()` directly without `...`, so use `options(hoopR.proxy = ...)` at the top of the session to cover those without per-function plumbing.

#### *Error-handling consolidation*

| Helper | Role |
|---|---|
| `.report_api_error(e, hint, args)` | Standardized `tryCatch` error handler — emits a `cli_alert_danger()` with hint text plus the captured arg list, then returns an empty fallback. |
| `.report_api_warning(w, args)` | Companion warning handler. |
| `.interp_braces()` | Internal helper for safely interpolating `{var}` syntax in cli alerts when the variable might contain braces of its own. |
| `.capture_args()` | Helper used at the top of arg-less wrappers (i.e. those whose only formal is `...`) so the error/warning reporters still see the call args. Equivalent to `mget(setdiff(names(formals()), "..."))` for wrappers with formals. |

Every `tryCatch(expr = ...)` block in ESPN, NBA Stats, and KenPom wrappers now uses these helpers instead of hand-rolled `cli::cli_alert_danger("{Sys.time()}: ...")` strings. Behavior is the same; the message includes the captured args, which makes failed-call debugging much faster.

#### *Dependency cleanup*

- Removed `glue` from `Imports`; demoted to `Suggests` (retained only for downstream package-level references).
- Replaced `glue::glue(...)` call-sites with `sprintf()` / `paste0()` / base R in URL builders, `pad_id()`, `pad_time()`, and `cli` alert strings.
- Replaced `glue::glue_sql()` with parameterized `DBI::dbExecute()` / `DBI::dbGetQuery()` calls in `load_*` family functions.

#### *Tooling*

- Ported wehoop's `tools/` patch scripts (`patch_df_list_init.R`, `patch_return_var_init.R`, `flip_expect_equal_cols.R`, `inject_skip_guard.R`, `inject_skip_helpers.R`, `sweep_error_handlers.R`, `find_parse_errors.R`) for future audit / sweep work.
- Added `tools/run_doctoc.R` — a no-deps R replacement for the npm `doctoc` CLI, used to regenerate the NEWS.md / CONTRIBUTING.md TOCs. Run with `Rscript tools/run_doctoc.R --maxlevel 2 NEWS.md CONTRIBUTING.md`.

#### *Test infrastructure*

- Live API test env vars enabled by default in the R CMD check workflow (previously had to be set per-job).
- Additional test-suite hardening sweeps applied via the ported `tools/` scripts: return-value init guards on edge-case wrappers, subset-direction column assertions, skip-on-empty guards where wrappers can legitimately return empty.

### **Release / CRAN preparation**

- Added `cph` (copyright holder) role to `Saiem Gilani` in `Authors@R` (CRAN strict requirement caught between releases).
- DESCRIPTION normalized via `usethis::use_tidy_description()` — field order, alphabetized Imports/Suggests, reflowed long lines.
- `.gitignore` anchored from bare `docs` to `/docs` so only the repo-root pkgdown output is ignored (the bare pattern was also matching `tools/docs/`).

# **hoopR 3.0.0**

### **New exported functions**

#### *NBA Play-by-Play V3*

| Function / change | Description |
|---|---|
| `nba_playbyplayv3()` | Dedicated wrapper for the NBA Stats PlayByPlayV3 endpoint. |
| `nba_pbp()` default flip | Now defaults to `version = "v3"` (was `"v2"`). Pass `version = "v2"` for the previous behavior. |
| `nba_pbps()` default flip | Same default flip applies. |
| `nba_pbp()` `p` parameter | Now optional (default `NULL`) — previously required even when not using progress tracking. |

Internal V3→V2 compatibility pipeline backs `nba_pbp()` so callers keep V2-compatible columns while gaining V3-only columns (`x_legacy`, `y_legacy`, `shot_distance`, `shot_result`, `is_field_goal`, `points_total`, `shot_value`):

| Helper (internal) | Role |
|---|---|
| `.v3_to_v2_format()` | Converts V3 play-by-play data to V2-compatible column format with mapped event types and player resolution. |
| `.build_player_roster()` | Retrieves player roster from `nba_boxscoretraditionalv3()` for name-to-ID resolution during V3-to-V2 conversion. |
| `.players_on_court_v3()` | Rewritten — uses `nba_gamerotation()` stint data with interval mapping for robust on-court determination (replaces the previous substitution-parsing approach). |

Removed `stringr::str_match` import from NAMESPACE — V3 clock parsing now uses base R regex functions.

#### *NBA Boxscore Summary V3*

| Function | Description |
|---|---|
| `nba_boxscoresummaryv3()` | Returns a named list of 9 data frames: `GameSummary`, `GameInfo`, `ArenaInfo`, `Officials`, `LineScore`, `InactivePlayers`, `LastFiveMeetings`, `OtherStats`, `AvailableVideo`. |

#### *New NBA Stats API endpoint wrappers*

| Function | Description |
|---|---|
| `nba_commonteamyears()` | Team IDs with their active year ranges. |
| `nba_dunkscoreleaders()` | Dunk tracking data with biomechanics, scores, and style metrics. |
| `nba_gravityleaders()` | Gravity scores — how much defensive attention each player draws. |
| `nba_iststandings()` | In-Season Tournament (NBA Cup) standings. |
| `nba_scheduleleaguev2int()` | International schedule data with broadcaster information. |
| `nba_teamandplayersvsplayers()` | Team and player lineup comparison stats (5 datasets). |
| `nba_videoeventsasset()` | Video event asset data for a given game event. |

#### *ESPN & G-League functions*

| Function | Description |
|---|---|
| `espn_nba_team_current_roster()` | Current NBA team roster from ESPN. |
| `espn_mbb_team_current_roster()` | Current MBB team roster from ESPN. |
| `nbagl_live_pbp()` | Live G-League play-by-play. |
| `nbagl_live_boxscore()` | Live G-League box score. |

### **Behavior changes to existing functions**

#### *Bug fixes*

| Function | Fix |
|---|---|
| `nba_iststandings()` | Nested games column now properly flattened. |
| `nba_dunkscoreleaders()` | HTTP 400 error caused by empty-string parameters now resolved. |
| `nbagl_pbp()` | Avoids on-court enrichment dependency failures for G-League game IDs by using the stable core play-by-play path. |
| `kp_box()` | Referee link extraction updated — CSS selectors now match current KenPom HTML structure (`div.refline` with href-based filtering). |
| `kp_team_history()` | CSS selector updated to `table#player-table`; team name assignment now uses the display name instead of the URL slug. |
| `kp_kpoy()` example | Year bumped from 2021 to 2026 for current-season relevance. |

**Return-value initialization sweep.** Fixed `df_list` not initialized before `tryCatch` in **147 NBA Stats API wrapper functions**, preventing crashes on API errors. Same pattern applied to:
* `nba_data_pbp()` (`plays_df` init).
* `nba_playbyplayv3()` and `nba_pbp()` (`data` init).
* NBAGL wrappers (return-object init across error paths).

**Other fixes:**
* `helper-skip.R` test guard functions now use string comparison (`!= "1"`) instead of numeric comparison (`== 0`).
* V3-style data.frame parsing fixed for leader/standings endpoints.
* `%||%` import added for R < 4.4.0 compatibility.
* `teams_links` dataset updated with 2026 season team data.

### **Deprecations**

Calling any of these now errors with a structured `lifecycleDeprecatedError` that names a replacement. All deprecations were prompted by unstable / partial / empty endpoint responses observed in production.

| Deprecated function | Replacement | Reason |
|---|---|---|
| `nba_boxscorefourfactorsv2()` | `nba_boxscorefourfactorsv3()` | Unstable/partial V2 responses |
| `nba_boxscoremiscv2()` | `nba_boxscoremiscv3()` | Unstable/partial V2 responses |
| `nba_boxscorescoringv2()` | `nba_boxscorescoringv3()` | Unstable/partial V2 responses |
| `nba_boxscoreusagev2()` | `nba_boxscoreusagev3()` | Unstable/partial V2 responses |
| `nba_boxscoreplayertrackv2()` | `nba_boxscoreplayertrackv3()` | Unstable/partial V2 responses |
| `nba_boxscorehustlev2()` | `nba_hustlestatsboxscore()` | Unstable/partial V2 responses |
| `nba_homepageleaders()` | `nba_leagueleaders()` | Unstable/empty responses |
| `nba_homepagev2()` | `nba_leagueleaders()` | Unstable/empty responses |
| `nba_leaderstiles()` | `nba_leagueleaders()` | Unstable/empty responses |
| `nba_teamgamestreakfinder()` | `nba_teamgamelogs()` | Unstable/empty responses |
| `nba_teamhistoricalleaders()` | `nba_franchiseleaders()` | Unstable/empty responses |
| `nba_videodetails()` | `nba_videodetailsasset()` | Unstable/empty responses |
| `nba_winprobabilitypbp()` | `nba_playbyplayv3()` | Unstable/empty responses |
| `nba_playercareerbycollege()` | `nba_playercareerbycollegerollup()` / `nba_leaguedashplayerbiostats()` | Unstable/empty responses |
| `nba_playernextngames()` | `nba_playerprofilev2()` | Unstable/empty responses |
| `nba_scoreboard()` | `nba_scoreboardv3()` | Unstable/empty responses |
| `nba_scoreboardv2()` | `nba_scoreboardv3()` | Unstable/partial responses |

### **Internals**

#### *HTTP backend migration (httr → httr2)*

**Breaking change**: `httr` is replaced with `httr2` as the HTTP backend for every API call across the package, and `httr` is removed from `Imports`. Migration map:

| Aspect | Before (2.1.0 and earlier) | After (3.0.0) |
|---|---|---|
| HTTP client backend | `httr` | `httr2` |
| `httr` package availability | Auto-imported with `hoopR` | Removed from `Imports` — `library(httr)` yourself if your downstream code still needs it |
| `request_with_proxy()` body | `rvest::session()` + `httr::config()` arguments | `httr2::request()` + retry pipeline |
| All ESPN / NBA Stats / NBA G-League / NCAA / KenPom HTTP calls | Mixed direct backend calls | Routed through shared internal helpers (`.retry_request()`, `.resp_text()`) backed by `httr2` |
| `check_status()` internal | `httr::status_code()` | `httr2::resp_status()` |
| KenPom session authentication | `rvest::session()` with `httr` cookies | `httr2` cookie-jar via `login()` / `.kp_get_page()` / `.kp_request()` helpers |
| libcurl >= 8.x / curl R >= 7.0.0 segfaults | Triggered | Resolved (`httr2` does not have the affected code path) |

*Note: proxy plumbing on `request_with_proxy()` was quietly dropped during this migration. The restoration shipped in `3.1.0` — see above.*

#### *Messaging migration (usethis → cli)*

- Replaced all `usethis::ui_*()` messaging calls in database builder and loader functions with `cli` equivalents.

| Old call | New call |
|---|---|
| `usethis::ui_stop()` | `cli::cli_abort()` |
| `usethis::ui_oops()` | `cli::cli_alert_danger()` |
| `usethis::ui_todo()` | `cli::cli_ul()` |
| `usethis::ui_info()` | `cli::cli_alert_info()` |
| `usethis::ui_value()` | `{.val}` inline markup |
| `usethis::ui_path()` | `{.file}` inline markup |
| `usethis::ui_code()` | `{.code}` inline markup |

- Moved `usethis` from `Imports` to `Suggests` (retained for `usethis::edit_r_environ()` documentation references).

#### *Stability and test robustness*

- Hardened API-facing tests against live schema drift and intermittent empty payloads.
- Added explicit skip-on-empty guards for lineup and NCAA teams tests to avoid false negatives when upstream endpoints return no rows.
- Updated expected columns for currently active payloads in key NBA endpoints (including `nba_playercareerstats()`, `nba_playerdashptshotdefend()`, and `nba_playerprofilev2()`).
- Improved `nba_playerprofilev2()` assertions to validate core columns while tolerating empty optional result sets.
- Converted 400+ `expect_equal(colnames())` assertions to `expect_in()` for subset validation, preventing test failures when APIs add new columns.
- Added tests for all new endpoints with column validation and rate limiting.
- Added `skip_ncaa_mbb_test()` and `skip_ncaa_wbb_test()` helpers.
- Updated ESPN test expectations for current API responses.
- Updated NBAGL tests to validate NBA Stats-backed return shapes (`nbagl_players()` and `nbagl_standings()` named-list returns, and current schedule/PBP core columns).

#### *Dependency changes*

Dependency status before / after the release. Users with strict dependency pinning or downstream packages that re-export hoopR functionality should review this table.

| Dependency | Before (2.1.0) | After (3.0.0) | Why |
|---|---|---|---|
| `httr` | `Imports` | Removed | Replaced by `httr2` (see HTTP migration above) |
| `httr2` | — | `Imports` | New HTTP backend |
| `usethis` | `Imports` | `Suggests` | Messaging migration to `cli`; retained only for `usethis::edit_r_environ()` doc references |
| `furrr` | `Imports` | `Suggests` | Optional parallel features only; not required for core functionality |
| `future` | `Imports` | `Suggests` | Same as `furrr` — optional parallel features |
| `lifecycle` | — | `Imports` | Required for the new `lifecycle::deprecate_stop()` deprecation pattern |
| `qs` | `Imports` | Removed | No longer used by any code path |

#### *CI, build, and contribution improvements*

- Added workflow-level concurrency and explicit permissions to GitHub Actions workflows.
- Clarified optional environment variable usage in CI for live API test toggles.
- Updated package build ignores to exclude local development folders from source checks.
- Updated GitHub Actions to v4.
- Cleaned up `.Rbuildignore` duplicates.
- Internal `nba_endpoint()` registry updated with all V3 boxscore endpoints and `boxscoresummaryv3`.
- Added comprehensive `CONTRIBUTING.md` with naming conventions and test environment documentation.

#### *Social branding (Twitter → X)*

- Updated all social media links and badges from Twitter to X across README, pkgdown site, and vignettes.
- Shields.io badge `logo=twitter` → `logo=x`; profile URLs `twitter.com` → `x.com`.
- pkgdown navbar icon updated from `fa-twitter` to `fa-x-twitter`.

# **hoopR 2.1.0**
* ```load_nba_*()``` functions now use `sportsdataverse-data` releases url instead of `hoopR-data` repository URL
* ```load_mbb_*()``` functions now use `sportsdataverse-data` releases url instead of `hoopR-data` repository URL
- ```nba_pbp()``` and ```nba_pbps()``` functions add parameter `on_court` (default `TRUE`) to return on-court players for each play event, courtesy of [\@shufinskiy](https://github.com/shufinskiy)

# **hoopR 2.0.0**

### **NBA Stats API Live Endpoints**

- ```nba_live_pbp()``` function added.
- ```nba_live_boxscore()``` function added.
- ```nba_todays_scoreboard()``` function added.

### **NBA Boxscore V3 (and V3-styled) Endpoints Added**

- ```nba_scoreboardv3()``` function added.
- ```nba_boxscoretraditionalv3()``` function added.
- ```nba_boxscoreadvancedv3()``` function added.
- ```nba_boxscoremiscv3()``` function added.
- ```nba_boxscorescoringv3()``` function added.
- ```nba_boxscoreusagev3()``` function added.
- ```nba_boxscorefourfactorsv3()``` function added.
- ```nba_boxscoreplayertrackv3()``` function added.
- ```nba_boxscorematchupsv3()``` function added.
- ```nba_boxscorehustlev2()``` function added.
- ```nba_boxscoredefensivev2()``` function added.

### **Other NBA Stats API functions added**

- ```nba_shotchartlineupdetail()``` function added.
- ```nba_synergyplaytypes()``` function added.
- ```nba_franchiseleaderswrank()``` function added.
- ```nba_videodetailsasset()``` function added.
- ```nba_infographicfanduelplayer()``` function added.
- ```nba_teams()``` function added.

### **Other Functions Added**

- ```ncaa_mbb_teams()``` function added.

### **Proxy Capability Added and Other Notes**

- Add rlang dots option for passing ```httr::use_proxy()``` option to `nba_*()` functions
- Returns documentation added for all working NBA Stats API endpoints and ESPN functions
- Tests added for all working NBA Stats API endpoints and ESPN functions, over 1000 tests when
  run locally

# **hoopR 1.9.1**
- Updates under-the-hood urls to the ESPN site API v2 summary endpoints

# **hoopR 1.9.0**
- Takes care of tidyselect deprecation of data masking for certain tidyr and dplyr functions.
- Regular minor maintenance on `kp_*` functions
- ```espn_mbb_game_rosters()``` function added.
- ```espn_nba_game_rosters()``` function added.

# **hoopR 1.8.1**
- ```espn_mbb_player_stats()``` function exported properly.
- ```espn_nba_player_stats()``` function exported properly.
- Fixing headers for `kp_` functions.

# **hoopR 1.8.0**
- ```espn_mbb_player_stats()``` function added.
- ```espn_mbb_team_stats()``` function added.
- ```espn_nba_player_stats()``` function added.
- ```espn_nba_team_stats()``` function added.

# **hoopR 1.7.0**
- ```nba_pbps()``` function added, courtesy of [\@papagorgio23](https://github.com/papagorgio23).
- ```nbagl_players()``` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- ```nbagl_schedule()``` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- ```nbagl_pbp()``` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- ```nbagl_standings()``` function added, courtesy of [\@billyfryer](https://github.com/billyfryer).
- ```nba_gamerotation()``` function added.

# **hoopR 1.6.0**
- ```nba_playerindex()``` function added.
- ```nba_playerheadshot()``` function added.
- ```nba_drafthistory()``` function added.

# **hoopR 1.5.0**
- Major documentation update to include names of returned lists of data frames for all exported NBA Stats API, ESPN API, KenPom, NCAA and Data repository functions.

# **hoopR 1.4.5**
- Add ```kp_referee()``` function

# **hoopR 1.4.4**
- Remove referee ranks from ```kp_box()``` function

# **hoopR 1.4.3**
- Option configs changed to revert to user options

# **hoopR 1.4.2**
- Implement additional boxscore function parameters for ```nba_boxscore(.*)``` functions

# **hoopR 1.4.1**
- Update ```teams_links``` internal dataset for 2022 (need a better solve here)
- Added ```nba_teams``` dataset for working with the NBA Stats API

# **hoopR 1.4.0**
- [`hoopR::espn_mbb_betting()`](https://hoopr.sportsdataverse.org/reference/espn_mbb_betting.html)
    function added
- [`hoopR::espn_nba_betting()`](https://hoopr.sportsdataverse.org/reference/espn_nba_betting.html)
    function added

# **hoopR 1.3.1**
- Fix [```kp_winprob```](https://hoopr.sportsdataverse.org/reference/kp_winprob.html) function, adding runs as third output

# **hoopR 1.3.0**

### **Add Full Coverage for NBA Stats API**

Adding roughly 127 functions

| Function  | File Location   |
|---	|---	|
| nba_alltimeleadersgrids 	| R/nba_stats_leaders.R 	|
| nba_assistleaders 	| R/nba_stats_leaders.R 	|
| nba_assisttracker 	| R/nba_stats_leaders.R 	|
| nba_boxscoreadvancedv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscoredefensive 	| R/nba_stats_boxscore.R 	|
| nba_boxscorefourfactorsv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscorematchups 	| R/nba_stats_boxscore.R 	|
| nba_boxscoremiscv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscoreplayertrackv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscorescoringv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscoresimilarityscore 	| R/nba_stats_boxscore.R 	|
| nba_boxscoresummaryv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscoretraditionalv2 	| R/nba_stats_boxscore.R 	|
| nba_boxscoreusagev2 	| R/nba_stats_boxscore.R 	|
| nba_commonallplayers 	| R/nba_stats_roster.R 	|
| nba_commonplayerinfo 	| R/nba_stats_roster.R 	|
| nba_commonplayoffseries 	| R/nba_stats_roster.R 	|
| nba_commonteamroster 	| R/nba_stats_roster.R 	|
| nba_cumestatsplayer 	| R/nba_stats_cume.R 	|
| nba_cumestatsplayergames 	| R/nba_stats_cume.R 	|
| nba_cumestatsteam 	| R/nba_stats_cume.R 	|
| nba_cumestatsteamgames 	| R/nba_stats_cume.R 	|
| nba_defensehub 	| R/nba_stats_leaders.R 	|
| nba_draftboard 	| R/nba_stats_draft.R 	|
| nba_draftcombinedrillresults 	| R/nba_stats_draft.R 	|
| nba_draftcombinenonstationaryshooting 	| R/nba_stats_draft.R 	|
| nba_draftcombineplayeranthro 	| R/nba_stats_draft.R 	|
| nba_draftcombinespotshooting 	| R/nba_stats_draft.R 	|
| nba_draftcombinestats 	| R/nba_stats_draft.R 	|
| nba_fantasywidget 	| R/nba_stats_lineups.R 	|
| nba_franchisehistory 	| R/nba_stats_franchise.R 	|
| nba_franchiseleaders 	| R/nba_stats_franchise.R 	|
| nba_franchiseplayers 	| R/nba_stats_franchise.R 	|
| nba_glalumboxscoresimilarityscore 	| R/nba_stats_boxscore.R 	|
| nba_homepageleaders 	| R/nba_stats_leaders.R 	|
| nba_homepagev2 	| R/nba_stats_leaders.R 	|
| nba_hustlestatsboxscore 	| R/nba_stats_boxscore.R 	|
| nba_leaderstiles 	| R/nba_stats_leaders.R 	|
| nba_leaguedashlineups 	| R/nba_stats_lineups.R 	|
| nba_leaguedashoppptshot 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashplayerbiostats 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashplayerclutch 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashplayerptshot 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashplayershotlocations 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashplayerstats 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashptdefend 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashptstats 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashptteamdefend 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashteamclutch 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashteamptshot 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashteamshotlocations 	| R/nba_stats_league_dash.R 	|
| nba_leaguedashteamstats 	| R/nba_stats_league_dash.R 	|
| nba_leaguegamefinder 	| R/nba_stats_league.R 	|
| nba_leaguegamelog 	| R/nba_stats_league.R 	|
| nba_leaguehustlestatsplayer 	| R/nba_stats_hustle.R 	|
| nba_leaguehustlestatsplayerleaders 	| R/nba_stats_hustle.R 	|
| nba_leaguehustlestatsteam 	| R/nba_stats_hustle.R 	|
| nba_leaguehustlestatsteamleaders 	| R/nba_stats_hustle.R 	|
| nba_leagueleaders 	| R/nba_stats_leaders.R 	|
| nba_leaguelineupviz 	| R/nba_stats_lineups.R 	|
| nba_leagueplayerondetails 	| R/nba_stats_lineups.R 	|
| nba_leagueseasonmatchups 	| R/nba_stats_lineups.R 	|
| nba_leaguestandings 	| R/nba_stats_league.R 	|
| nba_leaguestandingsv3 	| R/nba_stats_league.R 	|
| nba_matchupsrollup 	| R/nba_stats_lineups.R 	|
| nba_pbp 	| R/nba_stats_pbp.R 	|
| nba_playerawards 	| R/nba_stats_player.R 	|
| nba_playercareerbycollege 	| R/nba_stats_player.R 	|
| nba_playercareerbycollegerollup 	| R/nba_stats_player.R 	|
| nba_playercareerstats 	| R/nba_stats_player.R 	|
| nba_playercompare 	| R/nba_stats_player.R 	|
| nba_playerdashboardbyclutch 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbygamesplits 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbygeneralsplits 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbylastngames 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbyopponent 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbyshootingsplits 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbyteamperformance 	| R/nba_stats_player_dash.R 	|
| nba_playerdashboardbyyearoveryear 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptpass 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptreb 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptshotdefend 	| R/nba_stats_player_dash.R 	|
| nba_playerdashptshots 	| R/nba_stats_player_dash.R 	|
| nba_playerestimatedmetrics 	| R/nba_stats_player.R 	|
| nba_playerfantasyprofile 	| R/nba_stats_player.R 	|
| nba_playerfantasyprofilebargraph 	| R/nba_stats_player.R 	|
| nba_playergamelog 	| R/nba_stats_player.R 	|
| nba_playergamelogs 	| R/nba_stats_player.R 	|
| nba_playergamestreakfinder 	| R/nba_stats_player.R 	|
| nba_playernextngames 	| R/nba_stats_player.R 	|
| nba_playerprofilev2 	| R/nba_stats_player.R 	|
| nba_playervsplayer 	| R/nba_stats_player.R 	|
| nba_playoffpicture 	| R/nba_stats_league.R 	|
| nba_schedule 	| R/nba_stats_pbp.R 	|
| nba_scoreboard 	| R/nba_stats_scoreboard.R 	|
| nba_scoreboardv2 	| R/nba_stats_scoreboard.R 	|
| nba_shotchartdetail 	| R/nba_stats_shotchart.R 	|
| nba_shotchartleaguewide 	| R/nba_stats_shotchart.R 	|
| nba_teamdashboardbyclutch 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbygamesplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbygeneralsplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbylastngames 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyopponent 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyshootingsplits 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyteamperformance 	| R/nba_stats_team_dash.R 	|
| nba_teamdashboardbyyearoveryear 	| R/nba_stats_team_dash.R 	|
| nba_teamdashlineups 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptpass 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptreb 	| R/nba_stats_team_dash.R 	|
| nba_teamdashptshots 	| R/nba_stats_team_dash.R 	|
| nba_teamdetails 	| R/nba_stats_team.R 	|
| nba_teamestimatedmetrics 	| R/nba_stats_team.R 	|
| nba_teamgamelog 	| R/nba_stats_team.R 	|
| nba_teamgamelogs 	| R/nba_stats_team.R 	|
| nba_teamgamestreakfinder 	| R/nba_stats_team.R 	|
| nba_teamhistoricalleaders 	| R/nba_stats_team.R 	|
| nba_teaminfocommon 	| R/nba_stats_team.R 	|
| nba_teamplayerdashboard 	| R/nba_stats_team.R 	|
| nba_teamplayeronoffdetails 	| R/nba_stats_team.R 	|
| nba_teamplayeronoffsummary 	| R/nba_stats_team.R 	|
| nba_teamvsplayer 	| R/nba_stats_team.R 	|
| nba_teamyearbyyearstats 	| R/nba_stats_team.R 	|
| nba_videodetails 	| R/nba_stats_video.R 	|
| nba_videoevents 	| R/nba_stats_video.R 	|
| nba_videostatus 	| R/nba_stats_video.R 	|
| nba_winprobabilitypbp 	| R/nba_stats_scoreboard.R 	|

# **hoopR 1.2.0**

### **Add schedule loaders**

  - [`hoopR::load_mbb_schedule()`](https://hoopr.sportsdataverse.org/reference/load_mbb_schedule.html)
    function added
  - [`hoopR::load_nba_schedule()`](https://hoopr.sportsdataverse.org/reference/load_nba_schedule.html)
    function added

# **hoopR 1.1.0**
### **Add team box score loaders**
- [```hoopR::load_mbb_team_box()```](https://hoopr.sportsdataverse.org/reference/load_mbb_team_box.html) function added
- [```hoopR::load_nba_team_box()```](https://hoopr.sportsdataverse.org/reference/load_nba_team_box.html) function added

### **Add player box score loaders**
- [```hoopR::load_mbb_player_box()```](https://hoopr.sportsdataverse.org/reference/load_mbb_player_box.html) function added
- [```hoopR::load_nba_player_box()```](https://hoopr.sportsdataverse.org/reference/load_nba_player_box.html) function added

# **hoopR 1.0.5**
### **Standings functions**
- [```hoopR::espn_nba_standings()```](https://hoopr.sportsdataverse.org/reference/espn_nba_standings.html)
- [```hoopR::espn_mbb_standings()```](https://hoopr.sportsdataverse.org/reference/espn_mbb_standings.html)

# **hoopR 1.0.4**
### **Add retry**
- Adding [```httr::retry()```](https://httr.r-lib.org/reference/RETRY.html) to all function calls to more naturally navigate rejected/failed requests from the API.

# **hoopR 1.0.2-3**
### **Quick fix for update db functions**

# **hoopR 1.0.1-4**
### **Dependency pruning**
This update is a non-user facing change to package dependencies to shrink the list of dependencies.

# **hoopR 1.0.0**
### **Package renamed to hoopR**
To reflect that the package is no longer just a men's college basketball and KenPom package, but also an NBA package.

### **Clean names and team returns**
- All functions have now been given the [```janitor::clean_names()```](https://rdrr.io/cran/janitor/man/clean_names.html) treatment
- [```hoopR::espn_mbb_teams()```](https://hoopr.sportsdataverse.org/reference/espn_mbb_teams.html) has updated the returns to be more identity information related only
- [```hoopR::espn_nba_teams()```](https://hoopr.sportsdataverse.org/reference/espn_nba_teams.html) to be more identity information related only
- All tests were updated

### **Loading capabilities added to the package**
- [```hoopR::load_mbb_pbp()```](https://hoopr.sportsdataverse.org/reference/load_mbb_pbp.html) and [```hoopR::update_mbb_db()```](https://hoopr.sportsdataverse.org/reference/update_mbb_db.html) functions added
- [```hoopR::load_nba_pbp()```](https://hoopr.sportsdataverse.org/reference/load_nba_pbp.html) and [```hoopR::update_nba_db()```](https://hoopr.sportsdataverse.org/reference/update_nba_db.html) functions added

# **hoopR 0.4**
- Added support for ESPN's NBA play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_nba_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_nba_team_box()```
- ```hoopR::espn_nba_player_box()```
- ```hoopR::espn_nba_pbp()```
- ```hoopR::espn_nba_teams()```
- ```hoopR::espn_nba_scoreboard()```

# **hoopR 0.3.0**
### **Dependencies**
- ```R``` version 3.5.0 or greater dependency added
- ```purrr``` version 0.3.0 or greater dependency added
- ```rvest``` version 1.0.0 or greater dependency added
- ```progressr``` version 0.6.0 or greater dependency added
- ```usethis``` version 1.6.0 or greater dependency added
- ```xgboost``` version 1.1.0 or greater dependency added
- ```tidyr``` version 1.0.0 or greater dependency added
- ```stringr``` version 1.3.0 or greater dependency added
- ```tibble``` version 3.0.0 or greater dependency added
- ```furrr``` dependency added
- ```future``` dependency added

### **Test coverage**
* Added tests for all KP and ESPN functions

#### **Function Naming Convention Change**
* All functions sourced from [kenpom.com](https://kenpom.com/) will start with `kp_` as opposed to `get_`
* Similarly, data and metrics sourced from ESPN will begin with `espn_` as opposed to `cbb_`. Moreover, all references to `cbb_` have been changed to `mbb_` as appropriate.
* Data sourced directly from the NCAA website will start the function with `ncaa_`


# **hoopR 0.2.0-3**
- Added support for ESPN's men's college basketball play-by-play endpoints with the addition of the following functions:
- ```hoopR::espn_mbb_game_all()``` - a convenience wrapper function around the following three functions (returns the results as a list of three data frames)
- ```hoopR::espn_mbb_team_box()```
- ```hoopR::espn_mbb_player_box()```
- ```hoopR::espn_mbb_pbp()```
- ```hoopR::espn_mbb_teams()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_conferences()``` (bumps to v0.2.1)
- ```hoopR::espn_mbb_scoreboard()``` (bumps to v0.2.2)
- ```hoopR::ncaa_mbb_NET_rankings()``` (bumps to v0.2.3)
- ```hoopR::espn_mbb_rankings()``` (bumps to v0.2.3)

# **hoopR 0.1.0**
-    Minor fixes

# **hoopR 0.0.0.9**
Initial Commits, remaining tasks:

-   Game Prep Tables
-   ~~Player Career Tables~~
-   ~~Game Box Scores~~
-   ~~Argument assertions~~
