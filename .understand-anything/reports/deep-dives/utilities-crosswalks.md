# Layer deep-dive — Utilities & Crosswalks

Shared package utilities (utils.R, data.R) and ID crosswalk builders (crosswalk_basketball, mbb_crosswalk) used across the scraping and loader surfaces.

**4 files** · 0 functions/classes

## Dependencies

**Depends on:** — (leaf)

**Depended on by:** NBA Stats API (2), Vignettes & Docs (2), Data Loaders (1)

## Files

### `R/crosswalk_basketball.R`  _(utility, crosswalk, normalization, fuzzy-matching)_

Internal, deterministic normalization engine for NBA/MBB cross-source crosswalks: name/team normalizers, timezone conversion, and fuzzy matching used to reproduce cached crosswalk artifacts exactly.

### `R/mbb_crosswalk.R`  _(crosswalk, college-basketball, data-reconciliation, fuzzy-match)_

Builds MBB cross-source crosswalks (team / schedule / player) by reconciling ESPN, Fox, Barttorvik, and KenPom identities through normalization, alias tables, and fuzzy matching atop the shared .bb_* crosswalk engine.

### `R/utils.R`  _(utility, core, season-helpers, data-loader)_

Package-wide utility module: KenPom login/credential handling, cached CSV/RDS loaders from URLs, season/year helpers (most_recent_mbb_season, year_to_season), team-name normalization, progress messaging, and the hoopR_data S3 class with its print method.

### `R/data.R`  _(data-documentation, kenpom, mbb, reference-data)_

Roxygen dataset documentation for teams_links, the men's college basketball KenPom team-link reference dictionary (357 rows, 6 variables) bundled with the package.

