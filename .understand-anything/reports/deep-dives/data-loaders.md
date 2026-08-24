# Layer deep-dive — Data Loaders

Pre-processed data loaders (load_mbb_*/load_nba_*/load_hoopR/load_crosswalk) that pull cached SportsDataverse release parquet/RDS assets.

**4 files** · 0 functions/classes

## Dependencies

**Depends on:** NBA Stats API (1), Utilities & Crosswalks (1)

**Depended on by:** — (none)

## Files

### `R/load_crosswalk.R`  _(loader, crosswalk, data-loader, nba)_

Loaders that download pre-built cross-source crosswalk tables (team / schedule / player) for NBA and MBB from the sportsdataverse-data releases, validating seasons and tagging results.

### `R/load_hoopR.R`  _(documentation, overview, loader, barrel)_

Documentation-only overview hub for the hoopR data loaders, cataloguing the load_nba_* and load_mbb_* season loaders that pull pre-scraped data from the hoopR-{nba,mbb}-data releases.

### `R/load_mbb.R`  _(loader, data-loader, college-basketball, play-by-play)_

Season-level MBB data loaders pulling pre-scraped play-by-play, box scores, schedules, rosters, stats, standings, and officials from sportsdataverse-data releases, with parallel download, optional progressr progress, and DBI database build/update helpers.

### `R/load_nba.R`  _(loader, data-loader, nba, play-by-play)_

Season-level NBA data loaders pulling pre-scraped play-by-play, box scores, schedules, rosters, stats, standings, draft, and officials from sportsdataverse-data releases, with parallel download and DBI database build/update helpers.

