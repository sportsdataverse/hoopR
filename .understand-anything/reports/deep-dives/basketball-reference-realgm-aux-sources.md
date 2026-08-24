# Layer deep-dive — Basketball-Reference, RealGM & Aux Sources

Auxiliary data-source scrapers: Basketball-Reference (bref_*), RealGM (realgm_*), KenPom (kp_*), Torvik, NBA G-League (nbagl_*), salary/cap (hoopshype, spotrac, RotoWire, draft), and NCAA/Fox feeds.

**42 files** · 0 functions/classes

## Dependencies

**Depends on:** NBA Stats API (2)

**Depended on by:** Vignettes & Docs (1)

## Files

### `R/bref_awards.R`  _(data-loader, basketball-reference, web-scraping, awards)_

Exports bref_awards(), scraping end-of-season NBA award voting (MVP, ROY, DPOY, etc.) from Basketball-Reference into a tidy hoopR_data tibble with one row per candidate.

### `R/bref_draft.R`  _(data-loader, basketball-reference, web-scraping, draft)_

Exports bref_draft(), scraping NBA draft results with career totals and advanced metrics from Basketball-Reference into a tidy hoopR_data tibble, one row per pick.

### `R/bref_injuries.R`  _(web-scraper, basketball-reference, nba, injuries)_

Scrapes the current NBA injury report from Basketball-Reference and returns it as a tidy data frame via the shared bref helper layer.

### `R/bref_player_bios.R`  _(web-scraper, basketball-reference, player-bio, rvest)_

Scrapes player biographical information (height, weight, birth date, college, etc.) from a player's Basketball-Reference page.

### `R/bref_player_game_log.R`  _(web-scraper, basketball-reference, game-log, player-stats)_

Scrapes a player's per-game game log for a given season from Basketball-Reference and returns the box-score rows as a tidy frame.

### `R/bref_players_stats.R`  _(web-scraper, basketball-reference, player-stats, season-stats)_

Scrapes season-level player statistics tables (per-game, totals, advanced, etc.) from Basketball-Reference league pages.

### `R/bref_standings.R`  _(web-scraper, basketball-reference, standings, nba)_

Scrapes NBA conference/division standings for a season from Basketball-Reference and returns them as a tidy frame.

### `R/bref_team_roster.R`  _(web-scraper, basketball-reference, roster, team)_

Scrapes a team's season roster from Basketball-Reference and returns player listings as a tidy data frame.

### `R/bref_teams_stats.R`  _(web-scraper, basketball-reference, team-stats, season-stats)_

Scrapes team-level season statistics tables (per-game, opponent, advanced) from Basketball-Reference league pages.

### `R/bref_utils.R`  _(utility, basketball-reference, http, html-parsing)_

Shared internal helper layer for the Basketball-Reference scrapers: .bref_text fetches a page body, .bref_table parses an HTML table, and .bref_type_convert coerces column types.

### `R/realgm_draft.R`  _(realgm, web-scraper, draft, data-model)_

Scrapes basketball.realgm.com draft pages for historical draft results (realgm_draft) and early-entry candidate lists (realgm_early_entry), returning tidy draft data frames.

### `R/realgm_players.R`  _(realgm, web-scraper, players, data-model)_

Scrapes basketball.realgm.com player pages for the player directory (realgm_players), players abroad (realgm_players_abroad), and future free agents (realgm_future_free_agents).

### `R/realgm_salaries.R`  _(realgm, web-scraper, salaries, data-model)_

Scrapes basketball.realgm.com salary-cap pages for the league salary cap history (realgm_salary_cap) and the rookie scale tables (realgm_rookie_scale).

### `R/realgm_staff.R`  _(realgm, web-scraper, staff, data-model)_

Scrapes basketball.realgm.com staff pages for coaching staff (realgm_coaches) and general manager (realgm_gms) directories, returning tidy personnel tables.

### `R/realgm_standings.R`  _(realgm, web-scraper, standings, teams)_

Scrapes basketball.realgm.com for league standings (realgm_standings) and the team directory (realgm_teams), returning tidy standings and team-lookup data frames.

### `R/realgm_stats.R`  _(realgm, web-scraper, stats, data-model)_

Largest RealGM scraper: pulls player and team season stats, individual season/game logs, and draft-prospect stats (realgm_player_stats, realgm_team_stats, realgm_individual_seasons, realgm_individual_games, realgm_draft_prospects) from basketball.realgm.com.

### `R/realgm_transactions.R`  _(realgm, web-scraper, transactions, data-model)_

Scrapes basketball.realgm.com transaction pages via rvest (realgm_transactions), returning a tidy table of player signings, trades, and roster moves.

### `R/realgm_utils.R`  _(realgm, utility, web-scraper, shared-helpers)_

Shared internal helpers for the RealGM scrapers, providing chromote-driven page rendering, URL building, and rvest/janitor table-cleaning utilities consumed across the realgm_* modules.

### `R/kp_box_tables.R`  _(kenpom, mbb, box-score, web-scraping)_

KenPom game-level scrapers parsing box scores and in-game win-probability tables from the (subscriber-gated) kenpom.com HTML pages.

### `R/kp_historical_tables.R`  _(kenpom, mbb, ratings, web-scraping)_

KenPom historical-data scrapers for team/coach efficiency history, program ratings, the Pomeroy archive ratings, and conference statistics tables.

### `R/kp_misc_stats.R`  _(kenpom, web-scraper, college-basketball, api-handler)_

Authenticated KenPom scrapers for miscellaneous men's college-basketball pages — trends, officials/referee, home-court advantage, arenas, game attributes, and FanMatch projections. Uses an httr2 cookie-jar session plus rvest CSS-selector parsing.

### `R/kp_ratings_tables.R`  _(kenpom, web-scraper, ratings, college-basketball)_

Authenticated KenPom scrapers for season ratings tables — Pomeroy ratings, efficiency, four-factors, point distribution, height/experience, foul trouble, team/player stats, and KPOY award tracking.

### `R/kp_team_tables.R`  _(kenpom, web-scraper, college-basketball, team-data)_

Authenticated KenPom scrapers for team-level detail pages — schedule, game plan, opponent tracker, roster/players, player career, minutes matrix, per-player stats, depth chart, and lineups. The largest KenPom module in the package.

### `R/kp.R`  _(kenpom, documentation, overview, barrel)_

Documentation-only overview hub for the KenPom scraper family, cataloguing the kp_* functions and describing the httr2 cookie-jar login() auth flow that reads KP_USER/KP_PW credentials.

### `R/fox_basketball.R`  _(fox-sports, nba, mbb, play-by-play)_

Fox Sports basketball scrapers exposing parallel NBA and MBB functions for play-by-play, box scores, odds, rosters, team stats, and game logs.

### `R/hoopshype_salaries.R`  _(hoopshype, nba, salaries, web-scraping)_

Scrapes HoopsHype player salary tables, returning multi-season NBA player salary figures as a tidy data frame.

### `R/nbadraft_mock_draft.R`  _(web-scraper, draft, rvest, data-model)_

Scrapes NBADraft.net mock-draft tables via rvest and returns a tidy data frame of projected draft picks for a given draft year.

### `R/nbagl_pbp.R`  _(g-league, play-by-play, api-handler, live-data)_

Retrieves NBA G-League play-by-play (nbagl_pbp) and live feeds (nbagl_live_pbp, nbagl_live_boxscore) by reusing the NBA Stats play-by-play pipeline against G-League game IDs.

### `R/nbagl_players.R`  _(g-league, api-handler, player-index, data-model)_

Retrieves the NBA G-League player index (nbagl_players) via the NBA Stats playerindex endpoint scoped to gleague.nba.com, returning a tidy player directory.

### `R/nbagl_schedule.R`  _(g-league, api-handler, schedule, data-model)_

Retrieves the NBA G-League schedule (nbagl_schedule) from the data.nba.com schedule feed, returning a tidy season schedule with game dates and matchups.

### `R/nbagl_standings.R`  _(g-league, api-handler, standings, data-model)_

Retrieves current NBA G-League standings (nbagl_standings) via the NBA Stats standings feed on s.data.nba.com, returning a tidy team standings table.

### `R/ncaa_mbb_data.R`  _(ncaa, web-scraper, rankings, teams)_

Scrapes NCAA.com / stats.ncaa.org for men's college basketball NET rankings (ncaa_mbb_NET_rankings) and the Division I/II/III team directory (ncaa_mbb_teams) by year and division.

### `R/rotowire_injuries.R`  _(data-loader, injuries, nba, json)_

Exports rotowire_injuries(), which pulls the current NBA injury report from RotoWire's public JSON feed and returns a tidy tibble of player injury statuses.

### `R/salary_draft_utils.R`  _(utility, scraper, salary, html-parsing)_

Internal shared HTML-scraping helpers (ext_html, parse_currency, next_data) used by the HoopsHype salaries, Spotrac team-cap, and NBADraft.net mock-draft wrappers; all sources are public HTML requiring no API key.

### `R/spotrac_team_cap.R`  _(data-loader, salary, nba, scraper)_

Exports spotrac_team_cap(), scraping Spotrac's public team salary-cap pages into a tibble of per-team cap and contract figures.

### `R/torvik_game_schedule.R`  _(data-loader, torvik, mbb, schedule)_

Exports torvik_game_schedule(), retrieving Bart Torvik's men's college basketball game schedule data as a tidy tibble.

### `R/torvik_game_stats.R`  _(data-loader, torvik, mbb, box-score)_

Exports torvik_game_stats(), fetching per-game advanced statistics from barttorvik.com for men's college basketball games.

### `R/torvik_ncaa_results.R`  _(data-loader, torvik, mbb, tournament)_

Exports torvik_ncaa_results(), scraping Bart Torvik's historical NCAA tournament results tables into a tidy tibble.

### `R/torvik_player_stats.R`  _(data-loader, torvik, mbb, player-stats)_

Exports torvik_player_stats(), pulling Bart Torvik player-level season statistics for men's college basketball.

### `R/torvik_ratings.R`  _(data-loader, torvik, mbb, ratings)_

Exports torvik_ratings(), retrieving Bart Torvik's team efficiency ratings for men's college basketball as a tibble.

### `R/torvik_team_factors.R`  _(data-loader, torvik, mbb, four-factors)_

Exports torvik_team_factors(), fetching Bart Torvik four-factors and tempo-free team metrics for men's college basketball.

### `R/torvik_utils.R`  _(utility, torvik, http, internal)_

Internal shared HTTP layer (torvik_text) for the family of torvik_*() scrapers, centralizing requests to barttorvik.com which needs no account or API key.

