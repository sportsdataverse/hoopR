# Proposal: ESPN test allowlist for live CI coverage (hoopR)

**Status:** proposal, not yet applied. **Do not** modify tests until the allowlist is reviewed.
**Generated:** 2026-05-30
**Cross-ref:** the wehoop sibling proposal at `c:/Users/saiem/Documents/GitHub-Data/sdv-dev/wehoop-dev/wehoop/tools/docs/skip_on_ci_allowlist_proposal.md` carries the full rationale, options analysis, and implementation alternatives. This file is the hoopR-specific allowlist.

## Problem

Like wehoop, every hoopR ESPN test opens with `skip_on_ci()` — push CI runs ~zero live ESPN requests. The May 29 R-CMD-check showed only 2 ESPN endpoints actually ran live (`espn_*_betting()`), and both returned no rows.

## Prerequisite

Apply the NULL-init fix to `espn_nba_conferences()` (in [R/espn_nba_groups.R](../../R/espn_nba_groups.R)) and `espn_mbb_conferences()` (in [R/espn_mbb_data.R](../../R/espn_mbb_data.R)) **before** putting these tests on the allowlist.

A mechanical patch script is provided at `tools/patch_return_var_init_v2.R`. It was trial-run on 2026-05-30 against this repo (48 conversions across 18 files) and then reverted pending design review — the typed-empty-tibble approach (matching the success-case schema, per-function) is preferred over the literal `data.frame()` shell the script applies. See the [empty-return audit appendix](espn_rectangularization_audit.md) for the canonical pattern cfbfastR's `.attach_query_meta()` implements; that's the model to port here.

## Proposed hoopR allowlist (12 tests)

| Test | Why on the allowlist |
|------|----------------------|
| `test-espn_nba_seasons.R` | Reference data; minimal drift |
| `test-espn_mbb_seasons.R` | Same |
| `test-espn_nba_calendar.R` | Calendar; rotates yearly with stable schema |
| `test-espn_mbb_calendar.R` | Same |
| `test-espn_nba_teams.R` | 30 NBA teams; near-zero drift |
| `test-espn_mbb_teams.R` | ~360 D1 teams; stable |
| `test-espn_nba_venues.R` | Reference data |
| `test-espn_mbb_venues.R` | Reference data |
| `test-espn_nba_conferences.R` | Safe after NULL-init fix |
| `test-espn_mbb_conferences.R` | Safe after NULL-init fix |
| `test-espn_nba_news.R` | Newsfeed always populated |
| `test-espn_mbb_news.R` | Same |

## Out of scope (excluded for the same reasons as wehoop)

| Category | Excluded tests |
|----------|----------------|
| Off-season-vulnerable | `_injuries`, `_team_injuries`, `_team_leaders`, `_leaders`, `_powerindex`, `_standings`, `_scoreboard` |
| Athlete-id stale-risk | All `_athlete_*` tests |
| Event-detail | All `_event_*` tests (game_id-dependent) |
| Game-data | `_pbp`, `_team_box`, `_player_box`, `_game_all`, `_game_rosters` |
| Betting (currently 0 rows) | `_betting` — keep until upstream populates |

## Implementation

See wehoop's proposal for the full implementation options (A: remove `skip_on_ci()` per test; B: new `skip_on_ci_unless_allowlisted()` helper; C: workflow env var). Apply the same chosen option to hoopR for consistency across the SDV R family.

## Cross-package coordination

Both packages should ship the allowlist change in the same week so the live-CI signal becomes uniform across wehoop + hoopR + cfbfastR. cfbfastR already runs ~118 ESPN tests live with the inverse default (opt-out per test) — this proposal moves wehoop and hoopR toward that posture for the safe core endpoints only.

## 2026-05-30 implementation note

Verified hoopR test inventory:

- **3 of the 12 proposed allowlist tests exist** and all 3 already have NO `skip_on_ci()`: `test-espn_mbb_conferences.R`, `test-espn_mbb_teams.R`, `test-espn_nba_teams.R`. These already run live on CI.
- **9 are missing as test files**: `test-espn_{nba,mbb}_seasons.R`, `_calendar.R`, `_venues.R`, `_news.R`, plus `test-espn_nba_conferences.R`. This is a **test coverage gap**, not a skip-policy issue.

**No code changes required for the allowlist itself.** The follow-up is to *write the missing 9 test files* before they can be allowlisted. Each should mirror its wehoop sibling — small column-subset assertion + Sys.sleep + appropriate `skip_espn_test()` gate (but no `skip_on_ci()`).

Reference templates (in wehoop):

- `tests/testthat/test-espn_wbb_seasons.R` → for both `_nba_seasons` and `_mbb_seasons`
- `tests/testthat/test-espn_wbb_calendar.R` → for `_calendar` pair
- `tests/testthat/test-espn_wbb_venues.R` → for `_venues` pair
- `tests/testthat/test-espn_wbb_news.R` → for `_news` pair
- `tests/testthat/test-espn_wnba_conferences.R` → for `test-espn_nba_conferences.R`

After writing those 9 test files (a separate ~30-minute task), the live-CI coverage in hoopR would match wehoop's target (~12 endpoints).
