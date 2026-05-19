# espn_mbb_event_detail.R
# Public MBB shims for ESPN event-detail endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_event_helpers.R.

# ---------------------------------------------------------------------------
# espn_mbb_event_odds
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Odds**
#' @name espn_mbb_event_odds
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Odds**
#' @rdname espn_mbb_event_odds
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A tibble with one row per odds provider (typically empty for MBB
#'   because ESPN does not carry NCAA basketball betting lines).
#'
#'    |col_name             |types     |description                            |
#'    |:--------------------|:---------|:--------------------------------------|
#'    |event_id             |character |Unique event / game identifier (ESPN). |
#'    |provider_id          |character |Unique identifier for provider.        |
#'    |provider_name        |character |Provider name.                         |
#'    |details              |character |Details.                               |
#'    |over_under           |numeric   |Over under.                            |
#'    |spread               |numeric   |Spread.                                |
#'    |home_money_line      |integer   |                                       |
#'    |away_money_line      |integer   |                                       |
#'    |home_team_odds_open  |numeric   |                                       |
#'    |home_team_odds_close |numeric   |                                       |
#'    |away_team_odds_open  |numeric   |                                       |
#'    |away_team_odds_close |numeric   |                                       |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_odds(event_id = "401735229")
#' }
espn_mbb_event_odds <- function(event_id, ...) {
  .espn_basketball_event_odds(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_event_probabilities
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Win Probabilities**
#' @name espn_mbb_event_probabilities
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Win Probabilities**
#' @rdname espn_mbb_event_probabilities
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param limit integer. Maximum number of probability rows to return.
#'   Defaults to `200`. Pagination is handled internally.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per play-level win-probability entry.
#'
#'    |col_name              |types     |description                                              |
#'    |:---------------------|:---------|:--------------------------------------------------------|
#'    |event_id              |character |Unique event / game identifier (ESPN).                   |
#'    |sequence_number       |character |Sequence number representing a shot-possession (V3 PBP). |
#'    |play_id               |character |Unique play identifier within a game.                    |
#'    |period                |integer   |Period of the game (1-4 quarters; 5+ for OT).            |
#'    |clock                 |character |Game clock value.                                        |
#'    |home_win_percentage   |numeric   |Home win percentage (0-1 decimal).                       |
#'    |away_win_percentage   |numeric   |Away win percentage (0-1 decimal).                       |
#'    |tie_percentage        |numeric   |Tie percentage (0-1 decimal).                            |
#'    |secs_to_end_of_period |numeric   |                                                         |
#'    |secs_to_end_of_game   |numeric   |                                                         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_probabilities(event_id = "401735229", limit = 50)
#' }
espn_mbb_event_probabilities <- function(event_id, limit = 200, ...) {
  .espn_basketball_event_probabilities(
    league   = "mens-college-basketball",
    event_id = event_id,
    limit    = limit,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_event_officials
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Officials**
#' @name espn_mbb_event_officials
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Officials**
#' @rdname espn_mbb_event_officials
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per official assigned to the game.
#'
#'    |col_name      |types     |description                                            |
#'    |:-------------|:---------|:------------------------------------------------------|
#'    |event_id      |character |Unique event / game identifier (ESPN).                 |
#'    |official_id   |character |Unique official / referee identifier.                  |
#'    |full_name     |character |Player's full name.                                    |
#'    |display_name  |character |Display name.                                          |
#'    |position_id   |character |Unique position identifier.                            |
#'    |position_name |character |Listed roster position ('Guard', 'Forward', 'Center'). |
#'    |position_type |character |                                                       |
#'    |order         |integer   |Display order within the result set.                   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_officials(event_id = "401735229")
#' }
espn_mbb_event_officials <- function(event_id, ...) {
  .espn_basketball_event_officials(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_event_broadcasts
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Broadcasts**
#' @name espn_mbb_event_broadcasts
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Broadcasts**
#' @rdname espn_mbb_event_broadcasts
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per broadcast outlet for the game.
#'
#'    |col_name        |types     |description                            |
#'    |:---------------|:---------|:--------------------------------------|
#'    |event_id        |character |Unique event / game identifier (ESPN). |
#'    |broadcast_id    |character |                                       |
#'    |type_id         |character |Type identifier (numeric).             |
#'    |type_short_name |character |                                       |
#'    |type_long_name  |character |                                       |
#'    |market_id       |character |                                       |
#'    |market_type     |character |                                       |
#'    |names           |character |                                       |
#'    |lang            |character |                                       |
#'    |region          |character |Region label.                          |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_broadcasts(event_id = "401735229")
#' }
espn_mbb_event_broadcasts <- function(event_id, ...) {
  .espn_basketball_event_broadcasts(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_event_situation
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Situation (Live)**
#' @name espn_mbb_event_situation
NULL
#' @title
#' **Get ESPN MBB Event Situation (Live)**
#' @rdname espn_mbb_event_situation
#' @author Saiem Gilani
#' @description
#' Returns the live game situation for one MBB event: timeouts remaining,
#' team fouls, fouls to give, bonus state, and a `$ref` to the last play.
#' During a live game this reflects current state; after the game ends
#' the values are frozen.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble with timeouts + fouls for both teams.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_situation(event_id = 401812680)
#' }
espn_mbb_event_situation <- function(event_id, ...) {
  .espn_basketball_event_situation(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_predictor
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Predictor (Pre-game)**
#' @name espn_mbb_event_predictor
#' @title
#' **Get ESPN MBB Event Predictor (Pre-game)**
#' @rdname espn_mbb_event_predictor
#' @author Saiem Gilani
#' @description
#' Returns pre-game predictor statistics for one MBB event in long
#' format: one row per (team × statistic). Typical stats include
#' matchup quality, predicted score, win probability, and team
#' strength metrics. Returns empty for events without predictor data
#' (often the case for already-played games).
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with rows for both home and away teams.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_predictor(event_id = 401812680)
#' }
espn_mbb_event_predictor <- function(event_id, ...) {
  .espn_basketball_event_predictor(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_powerindex
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Power Index Index**
#' @name espn_mbb_event_powerindex
#' @title
#' **Get ESPN MBB Event Power Index Index**
#' @rdname espn_mbb_event_powerindex
#' @author Saiem Gilani
#' @description
#' Returns the per-team power-index `$ref` URLs for one MBB event.
#' Coverage is sparse — many events return zero items.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per team-game power-index entry.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_powerindex(event_id = 401812680)
#' }
espn_mbb_event_powerindex <- function(event_id, ...) {
  .espn_basketball_event_powerindex(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_propbets
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Prop Bets (Long Format)**
#' @name espn_mbb_event_propbets
#' @title
#' **Get ESPN MBB Event Prop Bets (Long Format)**
#' @rdname espn_mbb_event_propbets
#' @author Saiem Gilani
#' @description
#' Returns prop-bet markets for one MBB event + provider in long format:
#' one row per (athlete × prop type). Each row has american / decimal /
#' fraction odds plus the current target (e.g. over/under line). Hits the
#' core-v2 `competitions/{id}/odds/{provider_id}/propBets` endpoint and
#' auto-paginates.
#'
#' @param event_id ESPN event identifier.
#' @param provider_id Sportsbook provider id (e.g. 58 = ESPN BET,
#'   100 = Caesars). Look up via [espn_mbb_event_odds()].
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (athlete × prop type).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_propbets(event_id = 401812680, provider_id = 58)
#' }
espn_mbb_event_propbets <- function(event_id, provider_id, ...) {
  .espn_basketball_event_propbets(league = "mens-college-basketball", event_id = event_id,
                                    provider_id = provider_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_competitor_linescores
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**
#' @name espn_mbb_event_competitor_linescores
NULL
#' @title
#' **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**
#' @rdname espn_mbb_event_competitor_linescores
#' @author Saiem Gilani
#' @description
#' Returns the per-quarter scoring breakdown for one team in one NBA
#' event. One row per period (regulation quarters + any overtime
#' periods).
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier (the competitor whose linescore
#'   to fetch).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per period.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_competitor_linescores(event_id = 401812680, team_id = 150)
#' }
espn_mbb_event_competitor_linescores <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_linescores(league = "mens-college-basketball",
                                                  event_id = event_id,
                                                  team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_competitor_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Leaders (Top Performers)**
#' @name espn_mbb_event_competitor_leaders
NULL
#' @title
#' **Get ESPN MBB Event Competitor Leaders (Top Performers)**
#' @rdname espn_mbb_event_competitor_leaders
#' @author Saiem Gilani
#' @description
#' Returns the per-team statistical leaders for one MBB event in long
#' format: one row per (category x athlete rank). Categories typically
#' include points, rebounds, assists, and rating.
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x rank).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_competitor_leaders(event_id = 401812680, team_id = 150)
#' }
espn_mbb_event_competitor_leaders <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_leaders(league = "mens-college-basketball",
                                              event_id = event_id,
                                              team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_competitor_roster
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Roster (Game-Day)**
#' @name espn_mbb_event_competitor_roster
NULL
#' @title
#' **Get ESPN MBB Event Competitor Roster (Game-Day)**
#' @rdname espn_mbb_event_competitor_roster
#' @author Saiem Gilani
#' @description
#' Returns the game-day roster index for one team in one MBB event.
#' Each row carries the athlete id and the core-v2 `$ref` URL — use
#' the ref to dereference athlete-game splits or biographical data.
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per active athlete.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_competitor_roster(event_id = 401812680, team_id = 150)
#' }
espn_mbb_event_competitor_roster <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_roster(league = "mens-college-basketball",
                                             event_id = event_id,
                                             team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_competitor_statistics
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Team Statistics (Long Format)**
#' @name espn_mbb_event_competitor_statistics
NULL
#' @title
#' **Get ESPN MBB Event Competitor Team Statistics (Long Format)**
#' @rdname espn_mbb_event_competitor_statistics
#' @author Saiem Gilani
#' @description
#' Returns full team-game statistics for one team in one MBB event in
#' long format: one row per (category x stat). Covers offensive,
#' defensive, and general categories with both raw values and display
#' strings.
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x stat).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_competitor_statistics(event_id = 401812680, team_id = 150)
#' }
espn_mbb_event_competitor_statistics <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_statistics(league = "mens-college-basketball",
                                                 event_id = event_id,
                                                 team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_event_competitor_records
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Records (At-Game Breakdown)**
#' @name espn_mbb_event_competitor_records
NULL
#' @title
#' **Get ESPN MBB Event Competitor Records (At-Game Breakdown)**
#' @rdname espn_mbb_event_competitor_records
#' @author Saiem Gilani
#' @description
#' Returns team records as of the given MBB event: overall, home,
#' away, conference, and division breakdowns where available. One row
#' per record type.
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per record type.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_event_competitor_records(event_id = 401812680, team_id = 150)
#' }
espn_mbb_event_competitor_records <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_records(league = "mens-college-basketball",
                                              event_id = event_id,
                                              team_id = team_id, ...)
}
