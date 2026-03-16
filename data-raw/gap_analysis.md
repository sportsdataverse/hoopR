<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [hoopR ↔ nba_api Gap Analysis](#hoopr-%E2%86%94-nba_api-gap-analysis)
  - [Missing from hoopR (in nba_api but no hoopR equivalent)](#missing-from-hoopr-in-nba_api-but-no-hoopr-equivalent)
  - [Deprecation Candidates](#deprecation-candidates)
  - [Extra hoopR Functions (not in nba_api)](#extra-hoopr-functions-not-in-nba_api)
  - [Summary](#summary)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# hoopR ↔ nba_api Gap Analysis

Generated from comparison of nba_api Python endpoints (142 stats + 4 live = 146) against hoopR R package exports (184 nba_* functions).

## Missing from hoopR (in nba_api but no hoopR equivalent)

| nba_api Endpoint | Priority | Notes |
|---|---|---|
| `commonteamyears` | Medium | Lists all team IDs and years active |
| `cumestatskeyplayer` | Low | Cumulative stats for key players — niche endpoint |
| `dunkscoreleaders` | Medium | Newer endpoint for dunk contest/scoring leaders |
| `gravityleaders` | Medium | Newer endpoint for player gravity stats |
| `iststandings` | High | In-Season Tournament standings — active/current feature |
| `scheduleleaguev2` | Low | hoopR has `nba_schedule()` as alternative |
| `scheduleleaguev2int` | Low | International schedule variant |
| `teamandplayersvsplayers` | Low | Niche matchup comparison endpoint |
| `teamplayerondetails` | Low | hoopR has `nba_teamplayeronoffdetails()` which is similar |
| `videoeventsasset` | Low | Video asset retrieval endpoint |
| live `odds` | Medium | Live odds data — no current hoopR equivalent |

**Total: 11 missing endpoints** (3 high/medium priority)

## Deprecation Candidates

Functions in hoopR that may be candidates for deprecation/soft-deprecation:

| hoopR Function | Reason | Replacement |
|---|---|---|
| `nba_boxscoredefensive()` | Unversioned legacy endpoint | `nba_boxscoredefensivev2()` |
| `nba_boxscorematchups()` | Unversioned legacy endpoint | `nba_boxscorematchupsv3()` |
| `nba_boxscoreplayertrackv2()` | V2 superseded by V3 | `nba_boxscoreplayertrackv3()` |
| `nba_scoreboard()` | Legacy unversioned scoreboard | `nba_scoreboardv2()` or `nba_scoreboardv3()` |
| `nba_boxscoresimilarityscore()` | Possible duplicate | `nba_glalumboxscoresimilarityscore()` |

**Note**: These should be soft-deprecated with a `.Deprecated()` call pointing users to the replacement, not immediately removed.

## Extra hoopR Functions (not in nba_api)

These are hoopR-specific utilities, composite wrappers, or parameter-variant functions:

| hoopR Function | Type |
|---|---|
| `nba_pbp()` / `nba_pbps()` | Composite wrappers (dispatch to V1/V2/V3 + on-court enrichment) |
| `nba_data_pbp()` | Data loading utility (not an API call) |
| `nba_playerheadshot()` | Headshot image URL builder |
| `nba_teams()` | Team metadata helper |
| `nba_schedule()` | Schedule data (uses different source than scheduleleaguev2) |
| `nba_live_boxscore()` / `nba_live_pbp()` | Wrappers around live API endpoints |
| `nba_todays_scoreboard()` | Wrapper around live scoreboard |
| `nba_franchiseleaderswrank()` | Franchise leaders with rank |
| `nba_leaguehustlestatsplayerleaders()` | Hustle stats leaders (player) |
| `nba_leaguehustlestatsteamleaders()` | Hustle stats leaders (team) |
| `nba_playerfantasyprofile()` | Fantasy profile endpoint |
| `nba_playerdashboardbyopponent()` | Dashboard parameter variant |
| `nba_teamdashboardbyclutch()` | Dashboard parameter variant |
| `nba_teamdashboardbygamesplits()` | Dashboard parameter variant |
| `nba_teamdashboardbylastngames()` | Dashboard parameter variant |
| `nba_teamdashboardbyopponent()` | Dashboard parameter variant |
| `nba_teamdashboardbyteamperformance()` | Dashboard parameter variant |
| `nba_teamdashboardbyyearoveryear()` | Dashboard parameter variant |

## Summary

- **Coverage**: hoopR covers ~131/142 stats endpoints (92%) and 3/4 live endpoints (75%)
- **Missing high-priority**: `iststandings` (In-Season Tournament)
- **New in v3.0.0**: `nba_playbyplayv3()`, `nba_boxscoresummaryv3()`, `.players_on_court_v3()`
- **Deprecation candidates**: 5 functions with newer replacements available
