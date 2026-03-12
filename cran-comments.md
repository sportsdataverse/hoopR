## Release summary

This is a major release (v3.0.0) with the following changes:

### NBA Play-by-Play V3
- `nba_playbyplayv3()` function added -- dedicated wrapper for the NBA Stats PlayByPlayV3 endpoint.
- `nba_pbp()` and `nba_pbps()` now default to `version = "v3"` (previously `"v2"`).
- `.players_on_court_v3()` internal helper added for enriching V3 play-by-play data with on-court player IDs.

### NBA Boxscore Summary V3
- `nba_boxscoresummaryv3()` function added -- returns 9 data frames including GameSummary, Officials, LineScore, etc.

### New NBA Stats API Endpoint Wrappers
- `nba_commonteamyears()` function added.
- `nba_dunkscoreleaders()` function added.
- `nba_gravityleaders()` function added.
- `nba_iststandings()` function added.
- `nba_scheduleleaguev2int()` function added.
- `nba_teamandplayersvsplayers()` function added.
- `nba_videoeventsasset()` function added.

### ESPN Functions
- `espn_nba_team_current_roster()` function added.
- `espn_mbb_team_current_roster()` function added.
- `nbagl_live_pbp()` function added.
- `nbagl_live_boxscore()` function added.

### Bug Fixes
- Fixed `helper-skip.R` test guard functions to use proper string comparison.
- Fixed empty parameter bug in `nba_dunkscoreleaders()`.
- Fixed V3-style data.frame parsing for leader/standings endpoints.
- Fixed `nba_iststandings()` nested games column flattening.

### Infrastructure
- Updated GitHub Actions to v4.
- Cleaned up `.Rbuildignore`.
- Added comprehensive CONTRIBUTING.md with naming conventions and test environment documentation.

## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  - New submission (major version bump from 2.1.0 to 3.0.0)

## revdepcheck results

We checked 0 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
