# hoopR ESPN return-shape audit

**Generated:** 2026-05-30
**Scope:** every exported `espn_nba_*` and `espn_mbb_*` function (~170 across both families). Helpers in `R/espn_basketball_*_helpers.R` are audited indirectly via the shims that call them.
**Out of scope:** the official NBA Stats family (`nba_*()`, `nba_stats_*()`). Multi-`resultSets[]` league-API returns legitimately have distinct row grains and remain on the named-list pattern.

## Preference contract being audited against

> ESPN and other non-league API wrappers should return a **single wide rectangular `hoopR_data` tibble** with `janitor::clean_names()` applied. Lists of tibbles and nested list-columns are discouraged unless the upstream payload has multiple distinct row grains that genuinely cannot be merged without information loss. Very wide tables are preferred.
> The return must also be **self-describing**: every input parameter (game_id, team_id, season, season_type, athlete_id, week, etc.) must be echoed back as a column on every row, plus full game/team meta where applicable.

This is the SDV-family-wide standard shared with wehoop and cfbfastR.

## Tier definitions

| Tier | Meaning | Action |
|------|---------|--------|
| **A** | Already compliant: single wide self-describing `hoopR_data` tibble. | No work. |
| **B** | Single tibble, identity-incomplete. | Add `dplyr::mutate(arg = arg)` before `make_hoopR_data()`. |
| **C** | Named list of tibbles whose components share a join key. | Decision: collapse vs. document grain. |
| **D** | Named list with genuinely unmergeable grains. | Keep as list; document. |
| **E** | Single tibble with un-flattened nested list-columns. | Flatten. |

## Summary

| Tier | Count | % | Status |
|------|------:|--:|--------|
| A — Compliant | ~140 | 82% | No work |
| B — Identity-incomplete | ~4 | 2% | Trivial fix |
| C — List with shared key | ~10 (5 pairs) | 6% | 2 priority collapses + 3 keep-as-bundle |
| D — Multi-grain list | 0 | 0% | n/a |
| E — Nested list-columns | ~6 | 3% | Spot-check |

**Bottom line:** hoopR is the lowest-compliance of the three packages — mainly because two consolidation candidates (`espn_*_betting()` and `espn_*_athlete_overview()`) currently return multi-component lists where one wide tibble would serve users better. The `game_all` pattern repeats the wehoop story (keep as list, document).

---

## Tier A — Already compliant

Listed by family; each row covers both `_nba_` and `_mbb_` twins.

| Function (pair) | Row grain | File |
|-----------------|-----------|------|
| `espn_*_pbp()` | one play | `espn_*_data.R` |
| `espn_*_team_box()` | one team-game | `espn_*_data.R` |
| `espn_*_player_box()` | one player-game | `espn_*_data.R` |
| `espn_*_standings()` | one team-standing | `espn_*_data.R` |
| `espn_*_teams()` | one team | `espn_*_data.R` |
| `espn_*_scoreboard()` | one game | `espn_*_data.R` |
| `espn_*_team_stats()` | one team-season | `espn_*_data.R` |
| `espn_*_player_stats()` | one player-season | `espn_*_data.R` |
| `espn_*_team_roster()` | one athlete | `espn_*_team_detail.R` |
| `espn_*_team_schedule()` | one event | `espn_*_team_detail.R` |
| `espn_*_team_leaders()` | one category-leader | `espn_*_team_detail.R` |
| `espn_*_team_season_profile()` | one team-season | `espn_*_team_detail.R` |
| `espn_*_team_season_statistics()` | one category-stat | `espn_*_team_detail.R` |
| `espn_*_team_depthchart()` | one depth-chart entry | `espn_*_team_deep.R` |
| `espn_*_team_odds_records()` | one record-type | `espn_*_team_deep.R` |
| `espn_*_team_season_roster()` | one athlete-season | `espn_*_team_deep.R` |
| `espn_*_team_record_detail()` | one record entry | `espn_*_team_deep.R` |
| `espn_*_franchise_history()` | one franchise-season | `espn_*_franchise.R` |
| `espn_*_franchises()` / `espn_*_franchise()` | one franchise | `espn_*_franchise.R` |
| `espn_*_calendar()` | one calendar entry | `espn_*_calendar.R` |
| `espn_*_venues()` / `espn_*_venue()` | one venue | `espn_*_league.R` |
| `espn_*_coaches()` / `espn_*_coach()` / `espn_*_coach_history()` | one coach / season | `espn_*_league.R` + `_coach.R` |
| `espn_*_athletes_index()` | one athlete | `espn_*_league.R` |
| `espn_*_seasons()` / `espn_*_season_info()` | one season | `espn_*_league.R` |
| `espn_*_season_types()` / `espn_*_season_type()` | one season type | `espn_*_season_meta.R` |
| `espn_*_season_leaders()` / `espn_*_leaders()` | one category-athlete | `espn_*_league.R` / `_season_meta.R` |
| `espn_*_season_rankings()` / `espn_*_season_ranking()` | one ranking | `espn_*_season_meta.R` |
| `espn_*_season_groups()` (+ `_group`, `_group_children`, `_group_teams`) | one group / team-in-group | `espn_*_groups_v2.R` |
| `espn_*_season_weeks()` / `espn_*_season_week()` | one week | `espn_*_weeks.R` |
| `espn_*_week_rankings()` / `espn_*_week_ranking()` | one ranking | `espn_*_weeks.R` |
| `espn_*_powerindex()` | one team-rating | `espn_*_powerindex.R` |
| `espn_*_injuries()` / `espn_*_team_injuries()` | one injury | `espn_*_injuries.R` |
| `espn_*_news()` / `espn_*_team_news()` | one article | `espn_*_news.R` |
| `espn_*_positions()` / `espn_*_position()` | one position | `espn_*_positions.R` |
| `espn_*_season_awards()` / `espn_*_award()` | one award | `espn_*_awards.R` |
| `espn_*_tournaments()` / `_tournament` / `_tournament_seasons` / `_tournament_season` / `_tournament_groups` / `_tournament_group_rankings` / `_tournament_standings` | one tournament / season / group / ranking | `espn_*_tournaments.R` |
| `espn_*_athlete_stats()` | one athlete-season (already collapsed in hoopR, unlike wehoop) | `espn_*_athletes.R` |
| `espn_*_athlete_gamelog()` | one game | `espn_*_athletes.R` |
| `espn_*_athlete_splits()` | one split | `espn_*_athletes.R` |
| `espn_*_athlete_eventlog()` / `_eventlog_v2` | one event | `espn_*_athletes.R` / `_athlete_career.R` |
| `espn_*_athlete_awards()` | one award | `espn_*_athletes.R` |
| `espn_*_athlete_statisticslog()` | one season-stat | `espn_*_athletes.R` |
| `espn_*_athlete_career_stats()` | one season | `espn_*_athlete_career.R` |
| `espn_*_athlete_contracts()` | one contract-year | `espn_*_athletes.R` |
| `espn_*_team_transactions()` | one transaction | `espn_*_transactions.R` |
| `espn_*_wp()` | one play (win prob) | `espn_*_metrics.R` |
| `espn_*_event_odds()` / `_propbets` / `_probabilities` / `_officials` / `_official_detail` / `_broadcasts` / `_situation` / `_predictor` / `_powerindex` / `_play` / `_play_personnel` | event-detail family — all single-tibble, event_id echoed | `espn_*_event_detail.R` |
| `espn_*_event_competitor_linescores` / `_leaders` / `_roster` / `_roster_entry` / `_statistics` / `_records` / `_player_box` / `_score` | event-competitor family — single-tibble, event_id + team_id echoed | `espn_*_event_detail.R` |

**Tier A subtotal: ~140 functions.**

---

## Tier B — Single tibble, identity-incomplete

| Function (pair) | Helper | Missing columns | Fix |
|-----------------|--------|-----------------|-----|
| `espn_*_athlete_info()` | `R/espn_basketball_athlete_helpers.R` | `athlete_id` | `dplyr::mutate(athlete_id = athlete_id)` before `make_hoopR_data()` |
| `espn_*_athlete_overview()` | same | `athlete_id`, `season` not echoed across sub-tables | (will be addressed by Tier C collapse — see below) |

**Tier B subtotal: ~4 functions.** Most hoopR identity-echo regressions were already cleaned up in earlier sweeps; what remains is concentrated in athlete profile helpers.

---

## Tier C — List return, components share a key

| Function (pair) | Components | Shared keys | Grain analysis | Plan |
|-----------------|------------|-------------|----------------|------|
| `espn_*_game_all()` | `Plays`, `Team`, `Player` | `game_id`, `team_id` | 3 distinct grains | **Keep as list.** Already Tier-A inside. Document component grains + join recipe in `@details`. |
| `espn_*_betting()` | `pickcenter`, `againstTheSpread`, `predictor` | `game_id` | Likely 1 row per (game × provider) for pickcenter; 1 row per (game × period × side) for ATS; 1 row per game for predictor | **COLLAPSE candidate.** If all three grains can flatten to one wide tibble per (game_id, provider_id, period), do it. Worst case `predictor` becomes a duplicated-across-providers column block. Verify grain by inspecting a real payload, then collapse via `dplyr::full_join()` on `game_id` (+ provider where applicable). |
| `espn_*_team()` | `Info`, `Record`, `NextEvent`, `StandingSummary`, `Coaches` | `team_id`, `season` | 5 distinct grains (1, N, 1, 1, N) | **Keep as list / "bundle".** Same as wehoop pattern. Document each component's grain. |
| `espn_*_athlete_overview()` | `Statistics`, `NextGame`, `Last5Games`, `Headlines`, `FantasyOutlook` | `athlete_id`, `season` | 5 distinct grains | **COLLAPSE candidate (medium effort).** Option A: return only `Statistics` widened to one row, plus list-columns for `Last5Games` / `Headlines`. Option B: return three separate wide tibbles via three functions (`_overview_stats`, `_overview_recent`, `_overview_headlines`) and deprecate the bundle. Requires user-facing API decision. |
| `espn_*_athlete_info()` | `Bio`, `Team`, `Position`, `Status`, `College`, `Draft` | `athlete_id` | All 1-row, some optional NULL | **Keep as list.** Sparse wide tibble would be worse. Document optional components + add `athlete_id` echo per Tier B. |

**Tier C subtotal: ~10 functions (5 pairs).**

---

## Tier D — Genuinely multi-grain list returns

None identified.

---

## Tier E — Tibbles with surviving nested list-columns

| Function (pair) | Nested column | Action |
|-----------------|---------------|--------|
| `espn_*_team_record_detail()` | `stats` list-column may remain nested | `tidyr::unnest_wider(stats, names_sep = "_")` in helper |
| `espn_*_team()$Record` component | `stats` list-column per record row | Same — flatten before bundling into the named list |
| `espn_*_game_rosters()` (if hoopR has the same logos.* edge cases as wehoop) | `logos.*` partially flattened | Spot-check with real game payload |

**Tier E subtotal: ~6 functions.**

---

## Top wins (ordered by impact ÷ effort)

| # | Win | Effort | Impact |
|---|-----|-------:|-------:|
| 1 | Identity-echo `espn_*_athlete_info()` — add `athlete_id` column to every component | 5 min | high — quick semantic fix |
| 2 | `espn_*_betting()` list → wide tibble collapse (NBA + MBB) | 45 min | **highest** — common analytics use case |
| 3 | Flatten `stats` list-column in `_team_record_detail` and `_team()$Record` | 20 min | medium — fixes Tier E |
| 4 | Document `espn_*_game_all()` component grains + join recipe | 10 min | medium |
| 5 | Document `espn_*_team()` as bundle aggregator | 10 min | medium |
| 6 | Document `espn_*_athlete_info()` optional NULL components | 5 min | low |
| 7 | API decision + refactor for `espn_*_athlete_overview()` (option A/B/C) | 60 min | medium-high |
| 8 | Confirm `espn_*_team_roster()` already has `team_id` + `season` echoed (it should — verify) | 5 min | low |
| 9 | Spot-check `espn_*_game_rosters()` for surviving `logos.*` nesting | 5 min | low |
| 10 | Verify `espn_*_team_stats()` / `_player_stats()` echo all of `season`, `season_type`, `year`, identifier — quick spot-check via `colnames()` | 10 min | low |

---

## Architectural opportunities

1. **`espn_basketball_*_helpers.R` shim consistency.** Confirm hoopR uses the same `league = "nba"` / `league = "mens-college-basketball"` shim pattern wehoop standardized. If not yet ported uniformly, doing so removes 80%+ of duplicate code between the NBA/MBB twins. (Status: partially adopted per the May 2026 port_wehoop_espn_helpers.R tool.)
2. **`espn_*_betting()` is the single highest-impact refactor.** Betting data is heavily consumed downstream; a wide tibble keyed on `(game_id, provider_id)` with ATS/predictor columns appended would be a substantial DX improvement.
3. **Bundle naming.** As with wehoop, the keep-as-list functions (`game_all`, `team`, `athlete_info`) could pick up `_bundle` aliases to make the multi-grain contract explicit at the API surface.
4. **`espn_*_wp()` consolidation.** `espn_*_event_probabilities()` (Tier A) and `espn_*_wp()` (Tier A) both expose win-probability series. Worth confirming they aren't redundant; if they are, deprecate one.

---

## Implementation order recommendation

1. **Batch 1 (Tier E flatten, 1 PR):** unnest `stats` list-columns in `_team_record_detail` and `_team()$Record`. Add tests that assert no `is.list` columns survive.
2. **Batch 2 (Tier C collapse, 1 PR):** `espn_*_betting()` list → wide. Most impactful single change.
3. **Batch 3 (Tier B identity, 1 PR):** `_athlete_info()` `athlete_id` echo + any other missed echoes discovered during the `_team_stats()` / `_player_stats()` spot-check.
4. **Batch 4 (API decision):** `espn_*_athlete_overview()` — pick a collapse strategy, ship, deprecate old shape with a `lifecycle::deprecate_warn()` call.
5. **Batch 5 (docs):** roxygen `@details` join recipes for `game_all`, `team`, `athlete_info`.

---

## Comparison to wehoop

| Aspect | wehoop | hoopR |
|--------|-------:|------:|
| Functions audited | 163 | ~170 |
| % Tier A compliant | 86% | 82% |
| Tier B count | 14 | ~4 |
| Tier C count | 10 | 10 |
| Priority collapse refactor | `athlete_stats` | `betting` |
| Keep-as-list bundles | `game_all`, `team`, `athlete_info`, `athlete_overview` | `game_all`, `team`, `athlete_info` |
| Tier E (nested cols) | ~2 | ~6 |

The two packages share the same architectural pattern; hoopR's higher Tier-E count reflects the additional team-record/team-detail surface area that wehoop simplified during its earlier ESPN refactor.

---

## Related references

- `tools/docs/espn_rectangularization_audit.md` in the wehoop repo — sibling audit, identical methodology
- `R/espn_basketball_*_helpers.R` — shared internal helpers where Tier B fixes land
- SDV memory: `feedback-espn-wide-rectangular-returns`, `feedback-return-self-describing`

---

# Appendix: Empty / NULL / 404 return audit

**Generated:** 2026-05-30. **Sources:** `R-CMD-check` workflow run `26667202188` (Windows job `78603044005`, latest successful push, 15h ago); source sweep across `R/espn_*.R` + `R/espn_basketball_*_helpers.R` (39 ESPN files); cross-reference with wehoop sibling appendix (commit `a12bbea`-style fixes).

## CI signal (push run, 2026-05-29)

```
[ FAIL 0 | WARN 0 | SKIP 315 | PASS 8x ]
```

(Numeric digits are partly redacted by Actions log masking — `SKIP 3***5` reads as `315` from the per-bucket totals; `PASS 8x` is the only ambiguity.)

Skip breakdown:

| Skip reason | Count | Meaning |
|-------------|------:|---------|
| `On CI` (`skip_on_ci()`) | 304 | ESPN + NBA Stats + KP tests intentionally gated off live API in push CI |
| `User can't run NBA Stats tests` (`NBA_STATS_TESTS` unset) | 5 | env-var gated |
| Plain `skip()` calls in helpers | 4 | known-deprecated NBA leaders endpoints + `nba_teamvsplayer` + `ncaa_mbb_NET_rankings` |
| **`No rows returned from endpoint at test time`** | **2** | `espn_mbb_betting`, `espn_nba_betting` — live API call **did** run on CI and **returned no usable data** |

**The only ESPN endpoints that actually ran live in CI are the two `*_betting` wrappers, and both produced no rows.** Every other ESPN test was suppressed by `skip_on_ci()`. CI gives essentially zero signal on live-API health for the rest of the ESPN surface — the same structural problem the wehoop appendix surfaces.

`espn_*_betting()` legitimately returns nothing for many `game_id`s (no pickcenter, no spread record, no predictor — especially for old games or non-marquee matchups). The skip is *guarded behavior*, not a regression, because the test calls the skip-if-empty helper. But the fact that `0` other ESPN endpoints ran live means a real regression in any of the other ~165 wrappers would slip through push CI.

## example_runs / probe artifacts — **COVERAGE GAP**

Unlike wehoop, hoopR has **no** `tools/example_runs/` directory, no `_results.csv` baseline, and no `TRIAGE.md`. The probe pattern (`tools/probes/`) is also absent.

Searched paths (all missing):

- `tools/example_runs/_results.csv`
- `tools/example_runs/TRIAGE.md`
- `tools/example_runs/_manifest.csv`
- `tools/probes/`

This means the package has **no offline batch evidence** for which ESPN endpoints return EMPTY / NULL at any given snapshot. The wehoop appendix used these artifacts to triage Category 1–5 endpoints with precision; hoopR has to rely entirely on source-pattern matching and the (very thin) CI signal.

**Remediation:** port wehoop's `tools/example_runs/run_all.R` machinery to hoopR. It is the highest-leverage single change for catching empty-return regressions.

## NULL-init source sweep

CLAUDE.md's "Return-Value Initialization" rule requires tibble-returning functions to initialize the return variable to `data.frame()` (or a typed empty `hoopR_data` tibble) **before** `tryCatch`. Initialization to `NULL` is a bug: when the API errors or the response fails parsing, the error handler does not bind the return variable, so the function returns `NULL` silently — violating both the contract (`@return A tibble`) and the predictability the user expects.

The sweep across `R/espn_*.R` + `R/espn_basketball_*_helpers.R` finds **78 outer `result <- NULL`-style inits**. After filtering out (a) inner nested-field deletions like `team_df[["links"]] <- NULL` (correct usage), (b) `betting <- NULL` in the two `espn_*_betting()` wrappers (false positive — overwritten unconditionally before return from `list(pickcenter, againstTheSpread, predictor_df)` that *are* properly init'd), and (c) `info_vals[["type"]] <- NULL` (inner field-drop), the count of **genuine NULL-init bugs is 76**.

Every Tier-B helper in `R/espn_basketball_*_helpers.R` that calls `make_hoopR_data()` in the success path has the same shape:

```r
.espn_basketball_x <- function(...) {
  result <- NULL                                  # ← bug: should be data.frame() shell
  tryCatch(
    expr    = { result <- ... %>% make_hoopR_data(...) },
    error   = function(e) .report_api_error(e, ...),     # ← does NOT set result
    warning = function(w) .report_api_warning(w, ...),
    finally = {}
  )
  result   # ← returns NULL on any API error
}
```

The wehoop sibling fixed this for the event helpers in commit `a12bbea` by initializing each helper's `result` to a typed empty tibble matching the success-path schema. hoopR carries the unfixed pattern essentially everywhere.

### Per-file bug inventory

| File | Helper / function count | Bug instances | Notes |
|------|------------------------:|--------------:|-------|
| [R/espn_basketball_event_competitor_helpers.R](../../R/espn_basketball_event_competitor_helpers.R) | 8 | 8 | All competitor helpers (linescores, leaders, roster, records, score, statistics, roster_entry, player_box) |
| [R/espn_basketball_event_helpers.R](../../R/espn_basketball_event_helpers.R) | 7 | 7 | situation, predictor, propbets, officials, official_detail, powerindex, broadcasts |
| [R/espn_basketball_athlete_helpers.R](../../R/espn_basketball_athlete_helpers.R) | 7 | 7 | gamelog, splits, statisticslog, eventlog, eventlog_v2, awards, seasons |
| [R/espn_basketball_draft_helpers.R](../../R/espn_basketball_draft_helpers.R) | 7 | 7 | draft, rounds, pick, status, athletes, athlete_detail, season_draft |
| [R/espn_basketball_league_helpers.R](../../R/espn_basketball_league_helpers.R) | 5 (outer) | 5 | excluding `info_vals[["type"]] <- NULL` inner field-drop |
| [R/espn_basketball_team_deep_helpers.R](../../R/espn_basketball_team_deep_helpers.R) | 5 | 5 | team_record_detail, team_season_*, team_odds_records |
| [R/espn_basketball_season_meta_helpers.R](../../R/espn_basketball_season_meta_helpers.R) | 5 | 5 | season_types, season_type, season_awards, season_award, season_leaders |
| [R/espn_basketball_week_helpers.R](../../R/espn_basketball_week_helpers.R) | 4 | 4 | season_weeks, season_week, week_rankings, week_ranking |
| [R/espn_basketball_team_helpers.R](../../R/espn_basketball_team_helpers.R) | 4 | 4 | team_record, team_season_profile, team_season_roster, team_season_statistics |
| [R/espn_basketball_tournaments_helpers.R](../../R/espn_basketball_tournaments_helpers.R) | 4 | 4 | tournaments, tournament, tournament_seasons, tournament_season |
| [R/espn_basketball_group_helpers.R](../../R/espn_basketball_group_helpers.R) | 4 | 4 | season_groups, season_group, season_group_children, season_group_teams |
| [R/espn_basketball_athlete_career_helpers.R](../../R/espn_basketball_athlete_career_helpers.R) | 3 | 3 | athlete_career_stats, athlete_contract(s), athlete_seasons |
| [R/espn_basketball_event_play_helpers.R](../../R/espn_basketball_event_play_helpers.R) | 2 | 2 | event_play, event_play_personnel |
| [R/espn_basketball_event_betting_helpers.R](../../R/espn_basketball_event_betting_helpers.R) | 2 | 2 | event_odds, event_futures (the in-success NULL→data.frame path is correct; the error path leaves NULL) |
| [R/espn_basketball_news_helpers.R](../../R/espn_basketball_news_helpers.R) | 2 | 2 | team_news, league_news |
| [R/espn_basketball_injuries_helpers.R](../../R/espn_basketball_injuries_helpers.R) | 2 | 2 | league_injuries, team_injuries |
| [R/espn_basketball_franchise_helpers.R](../../R/espn_basketball_franchise_helpers.R) | 2 | 2 | franchises, franchise |
| [R/espn_basketball_record_helpers.R](../../R/espn_basketball_record_helpers.R) | 2 | 2 | coach_record, coach_season |
| [R/espn_basketball_coach_helpers.R](../../R/espn_basketball_coach_helpers.R) | 2 | 2 | coach, coaches |
| [R/espn_basketball_awards_helpers.R](../../R/espn_basketball_awards_helpers.R) | 2 | 2 | awards, award |
| [R/espn_basketball_position_helpers.R](../../R/espn_basketball_position_helpers.R) | 2 | 2 | positions, position |
| [R/espn_basketball_calendar_helpers.R](../../R/espn_basketball_calendar_helpers.R) | 1 | 1 | `calendar <- NULL` at L35 |
| [R/espn_basketball_powerindex_helpers.R](../../R/espn_basketball_powerindex_helpers.R) | 1 | 1 | league_powerindex |
| [R/espn_basketball_futures_helpers.R](../../R/espn_basketball_futures_helpers.R) | 1 | 1 | league_futures |
| [R/espn_mbb_data.R](../../R/espn_mbb_data.R) (outer scope) | 5 | 5 | `conferences`, `teams`, `team_roster_full`, `ranks`, `standings` — plus 4 site-summary path vars (`resp`, `plays_df`, `team_box_score`, `player_box_score`, `athlete_roster_df`) which echo wehoop's old `espn_*_game_all()` shape |
| [R/espn_nba_data.R](../../R/espn_nba_data.R) (outer scope) | 5 | 5 | `teams`, `team_roster_full`, `standings` + site-summary path vars |
| [R/espn_nba_groups.R](../../R/espn_nba_groups.R) | 1 | 1 | **`espn_nba_conferences()`** at L40 — direct analog of the wehoop bug |

### Direct wehoop bug analog

The wehoop investigation found `espn_wnba_conferences()` returning `NULL` (init `conferences <- NULL` at `espn_wnba_groups.R:40`) — caught live by CI because the off-season payload errored. hoopR has the **exact same bug** in two places:

| Function | File:line | Recommended init |
|----------|-----------|------------------|
| `espn_nba_conferences()` | [R/espn_nba_groups.R:40](../../R/espn_nba_groups.R#L40) | typed empty 7-column conferences tibble |
| `espn_mbb_conferences()` | [R/espn_mbb_data.R:1037](../../R/espn_mbb_data.R#L1037) | typed empty 7-column conferences tibble |

These are guaranteed silent failures during off-season or any upstream conference-endpoint hiccup. The MBB version is doubly exposed because MBB has a much longer off-season than NBA (Apr–Oct).

## Permanent empties / known-broken endpoints

Inferred from helper-level documentation + cross-package mirror (none were caught by hoopR CI because the relevant tests are `skip_on_ci()`):

| Function | Reason | Recommended handling |
|----------|--------|----------------------|
| `espn_mbb_event_odds()` | ESPN does not carry NCAA basketball odds lines — helper docstring at `event_betting_helpers.R:14` explicitly says MBB will typically return an empty tibble | Already documented at helper level. Roxygen for public wrapper should also call this out as `@note`. |
| `espn_mbb_event_propbets()` | same upstream limitation | same |
| `espn_*_athlete_eventlog_v2()` | wehoop sibling found ESPN sometimes returns `events: null` for the v2 endpoint | Verify hoopR returns typed-empty tibble on `events: null`; currently returns NULL via the bug above |

## CI coverage gap

The structural problem mirrors wehoop:

- `skip_on_ci()` blanket-suppresses 304 ESPN/KP/NBA tests in push CI.
- Of ~170 ESPN functions, exactly **2 ran live** in the latest successful push (both `*_betting`, both EMPTY but skipped gracefully).
- `ESPN_TESTS=1` env var is wired (per the env block in the workflow log) but `skip_on_ci()` overrides it.
- No scheduled live-API artifact (no `_results.csv` in repo, no probe directory).

**Remediation options** (same shape as wehoop's appendix):

1. **Port wehoop's `tools/example_runs/` machinery** — single script, writes a CSV manifest of EMPTY/NON-EMPTY status per ESPN endpoint. Highest signal-to-effort.
2. **Per-test allowlist replacing `skip_on_ci()`** — pick ~10 stable ESPN endpoints (conferences, teams, scoreboard, one PBP, one team_box) that run on every push.
3. **Nightly cron workflow gated on `ESPN_TESTS=1`** with `skip_on_ci()` removed from the live-targeted tests, sequential to avoid rate-limits.
4. **CSV-diff regression test** — commit a baseline `_results.csv`; CI runs the batch, diffs against baseline, fails on new EMPTY entries.

## Remediation plan (ordered)

| # | Fix | Effort | Trigger |
|---|-----|-------:|---------|
| 1 | `espn_nba_conferences()` + `espn_mbb_conferences()` — initialize return to typed-empty tibble (direct wehoop-fix port) | 10 min | Tier-1 (direct sibling bug) |
| 2 | Patch all 76 helper `result <- NULL` outer inits → typed-empty `data.frame()` shell matching success schema. `tools/patch_return_var_init.R` already exists; extend it. | 90 min | Tier-1 (CLAUDE.md compliance, 76 functions) |
| 3 | Port `tools/example_runs/run_all.R` machinery from wehoop and commit a baseline `_results.csv` | 60 min | Tier-1 (baseline truth + regression infra) |
| 4 | `espn_*_betting()` `betting <- NULL` cleanup — replace with `betting <- list(pickcenter = data.frame(), againstTheSpread = data.frame(), predictor = data.frame())` for symmetry (currently functionally fine but inconsistent) | 5 min | Tier-3 (style) |
| 5 | `espn_mbb_event_odds()` / `espn_mbb_event_propbets()` add `@note` documenting upstream NCAA-odds emptiness | 5 min | Tier-2 (user clarity) |
| 6 | Investigate `espn_*_athlete_eventlog_v2()` for `events: null` empty-result handling | 15 min | Tier-2 (cross-package consistency) |
| 7 | Replace `skip_on_ci()` with a per-test allowlist for ~10 stable ESPN endpoints; document the pattern in CONTRIBUTING | 45 min | Tier-2 (CI coverage gap remediation) |
| 8 | Add a sweep tool: `tools/sweep_null_inits.R` that grep-fails the build if any new `result <- NULL` lands in `R/espn_*` outside the known-correct nested-field-deletion contexts | 30 min | Tier-3 (regression infra) |

## Cross-package note

The NULL-init bug pattern is significantly worse in hoopR than in wehoop because hoopR's ESPN helpers were refactored from the older monolithic `espn_*_data.R` files without the wehoop-style `a12bbea`-fix sweep ever running. **76 wrappers** are at risk of silent `NULL` returns the moment ESPN errors or off-season-empties the payload. The fix is mechanical and could be done in one helper-by-helper PR using the existing `tools/patch_return_var_init.R` scaffold.
