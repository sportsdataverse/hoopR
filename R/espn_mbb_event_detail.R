# espn_mbb_event_detail.R
# Public MBB shims for ESPN event-detail endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_event_helpers.R.

# ---------------------------------------------------------------------------
# espn_mbb_game_odds
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Odds**
#' @name espn_mbb_game_odds
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Odds**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A tibble with one row per odds provider (typically empty for MBB
#'   because ESPN does not carry NCAA basketball betting lines).
#'
#'    Columns as documented in the shared [espn_mbb_game_odds_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_odds(event_id = "401256760")
#' }
espn_mbb_game_odds <- function(event_id, ...) {
  .espn_basketball_event_odds(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_game_probabilities
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Event Win Probabilities**
#' @name espn_mbb_game_probabilities
NULL
#' @title
#' **Get ESPN Women's College Basketball Event Win Probabilities**
#' @rdname espn_mbb_game_probabilities
#' @author Saiem Gilani
#' @param event_id ESPN event/game identifier (character or numeric).
#' @param limit integer. Maximum number of probability rows to return.
#'   Defaults to `200`. Pagination is handled internally.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per play-level win-probability entry.
#'
#'    Columns as documented in the shared [espn_mbb_game_probabilities_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_probabilities(event_id = "401256760", limit = 50)
#' }
espn_mbb_game_probabilities <- function(event_id, limit = 200, ...) {
  .espn_basketball_event_probabilities(
    league   = "mens-college-basketball",
    event_id = event_id,
    limit    = limit,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_game_officials
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Event Officials**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @return A tibble with one row per official assigned to the game.
#'
#'    Columns as documented in the shared [espn_mbb_game_officials_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_officials(event_id = "401256760")
#' }
espn_mbb_game_officials <- function(event_id, ...) {
  .espn_basketball_event_officials(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_game_broadcasts
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Event Broadcasts**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @return A tibble with one row per broadcast outlet for the game.
#'
#'    Columns as documented in the shared [espn_mbb_game_broadcasts_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_broadcasts(event_id = "401256760")
#' }
espn_mbb_game_broadcasts <- function(event_id, ...) {
  .espn_basketball_event_broadcasts(
    league   = "mens-college-basketball",
    event_id = event_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_game_situation
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Situation (Live)**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @description
#' Returns the live game situation for one MBB event: timeouts remaining,
#' team fouls, fouls to give, bonus state, and a `$ref` to the last play.
#' During a live game this reflects current state; after the game ends
#' the values are frozen.
#'
#' @return A single-row tibble with timeouts + fouls for both teams.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_situation(event_id = 401256760)
#' }
espn_mbb_game_situation <- function(event_id, ...) {
  .espn_basketball_event_situation(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_predictor
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Predictor (Pre-game)**
#' @name espn_mbb_game_predictor
#' @title
#' **Get ESPN MBB Event Predictor (Pre-game)**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @description
#' Returns pre-game predictor statistics for one MBB event in long
#' format: one row per (team × statistic). Typical stats include
#' matchup quality, predicted score, win probability, and team
#' strength metrics. Returns empty for events without predictor data
#' (often the case for already-played games).
#'
#' @return A long tibble with rows for both home and away teams.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_predictor(event_id = 401256760)
#' }
espn_mbb_game_predictor <- function(event_id, ...) {
  .espn_basketball_event_predictor(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_powerindex
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Power Index Index**
#' @name espn_mbb_game_powerindex
#' @title
#' **Get ESPN MBB Event Power Index Index**
#' @rdname espn_mbb_game_odds
#' @author Saiem Gilani
#' @description
#' Returns the per-team power-index `$ref` URLs for one MBB event.
#' Coverage is sparse — many events return zero items.
#'
#' @return A tibble with one row per team-game power-index entry.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_powerindex(event_id = 401256760)
#' }
espn_mbb_game_powerindex <- function(event_id, ...) {
  .espn_basketball_event_powerindex(league = "mens-college-basketball", event_id = event_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_propbets
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Prop Bets (Long Format)**
#' @name espn_mbb_game_propbets
#' @title
#' **Get ESPN MBB Event Prop Bets (Long Format)**
#' @rdname espn_mbb_game_propbets
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
#'   100 = Caesars). Look up via [espn_mbb_game_odds()].
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (athlete × prop type).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_propbets(event_id = 401256760, provider_id = 58)
#' }
espn_mbb_game_propbets <- function(event_id, provider_id, ...) {
  .espn_basketball_event_propbets(league = "mens-college-basketball", event_id = event_id,
                                    provider_id = provider_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_linescores
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**
#' @name espn_mbb_game_team_linescores
NULL
#' @title
#' **Get ESPN MBB Event Competitor Linescores (Per-Quarter)**
#' @rdname espn_mbb_game_team_linescores
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
#'   espn_mbb_game_team_linescores(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_linescores <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_linescores(league = "mens-college-basketball",
                                                  event_id = event_id,
                                                  team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_leaders
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Competitor Leaders (Top Performers)**
#' @rdname espn_mbb_game_team_linescores
#' @author Saiem Gilani
#' @description
#' Returns the per-team statistical leaders for one MBB event in long
#' format: one row per (category x athlete rank). Categories typically
#' include points, rebounds, assists, and rating.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x rank).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_leaders(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_leaders <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_leaders(league = "mens-college-basketball",
                                              event_id = event_id,
                                              team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_roster
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Competitor Roster (Game-Day)**
#' @rdname espn_mbb_game_team_linescores
#' @author Saiem Gilani
#' @description
#' Returns the game-day roster index for one team in one MBB event.
#' Each row carries the athlete id and the core-v2 `$ref` URL — use
#' the ref to dereference athlete-game splits or biographical data.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per active athlete.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_roster(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_roster <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_roster(league = "mens-college-basketball",
                                             event_id = event_id,
                                             team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_statistics
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Competitor Team Statistics (Long Format)**
#' @rdname espn_mbb_game_team_linescores
#' @author Saiem Gilani
#' @description
#' Returns full team-game statistics for one team in one MBB event in
#' long format: one row per (category x stat). Covers offensive,
#' defensive, and general categories with both raw values and display
#' strings.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x stat).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_statistics(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_statistics <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_statistics(league = "mens-college-basketball",
                                                 event_id = event_id,
                                                 team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_records
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Competitor Records (At-Game Breakdown)**
#' @rdname espn_mbb_game_team_linescores
#' @author Saiem Gilani
#' @description
#' Returns team records as of the given MBB event: overall, home,
#' away, conference, and division breakdowns where available. One row
#' per record type.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per record type.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_records(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_records <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_records(league = "mens-college-basketball",
                                              event_id = event_id,
                                              team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_player_box
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Player Box Score (Long Format)**
#' @name espn_mbb_game_player_box
NULL
#' @title
#' **Get ESPN MBB Event Player Box Score (Long Format)**
#' @rdname espn_mbb_game_player_box
#' @author Saiem Gilani
#' @description
#' Returns the long-format per-game box score for a single athlete in one
#' MBB event. One row per (category x stat). Same shape as
#' [espn_mbb_game_team_statistics()] but scoped to a single
#' athlete-in-event instead of the full team. `stat_type` defaults to 0
#' (regular-season aggregate as ESPN tags it for finished events).
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier (the competitor the athlete played for).
#' @param athlete_id ESPN athlete identifier.
#' @param stat_type Integer stat-type segment. Defaults to 0 (the only type
#'   commonly populated for finished events).
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x stat).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_player_box(event_id = 401256760, team_id = 52,
#'                                athlete_id = 4593919)
#' }
espn_mbb_game_player_box <- function(event_id, team_id, athlete_id,
                                        stat_type = 0L, ...) {
  .espn_basketball_event_player_box(league = "mens-college-basketball",
                                       event_id = event_id,
                                       team_id = team_id,
                                       athlete_id = athlete_id,
                                       stat_type = stat_type, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_roster_entry
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Competitor Roster Entry (Per-Athlete Game-Day Row)**
#' @name espn_mbb_game_team_roster_entry
NULL
#' @title
#' **Get ESPN MBB Event Competitor Roster Entry (Per-Athlete Game-Day Row)**
#' @rdname espn_mbb_game_team_roster_entry
#' @author Saiem Gilani
#' @description
#' Returns a single-row tibble describing one athlete's game-day roster
#' entry for one MBB event. Carries the **starter** flag, **didNotPlay**
#' flag with reason, ejection flag, and the substitution slot if the
#' athlete came in for another player. Pair with
#' [espn_mbb_game_team_roster()] to enumerate the roster.
#'
#' @param event_id ESPN event identifier.
#' @param team_id ESPN team identifier.
#' @param athlete_id ESPN athlete identifier.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_roster_entry(event_id = 401256760,
#'                                             team_id = 150,
#'                                             athlete_id = 4593919)
#' }
espn_mbb_game_team_roster_entry <- function(event_id, team_id,
                                                     athlete_id, ...) {
  .espn_basketball_event_competitor_roster_entry(league = "mens-college-basketball",
                                                   event_id = event_id,
                                                   team_id = team_id,
                                                   athlete_id = athlete_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_play
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Play Detail (Single Play)**
#' @name espn_mbb_game_play
NULL
#' @title
#' **Get ESPN MBB Event Play Detail (Single Play)**
#' @rdname espn_mbb_game_play
#' @author Saiem Gilani
#' @description
#' Returns the rich detail block for a single MBB play: sequence, period,
#' clock, text, scoring/shooting flags, current home/away score, team
#' `$ref`, and shot coordinates if applicable. Complements the bulk
#' [espn_mbb_pbp()] output by exposing the canonical core-v2 play record.
#'
#' @param event_id ESPN event identifier.
#' @param play_id ESPN play identifier (visible in `pbp()` output as
#'   `play_id` or extractable from `plays[].$ref`).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_play(event_id = 401256760, play_id = 401256760101805901)
#' }
espn_mbb_game_play <- function(event_id, play_id, ...) {
  .espn_basketball_event_play(league = "mens-college-basketball",
                                event_id = event_id,
                                play_id = play_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_play_personnel
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Play Personnel (On-Court Lineup at Play)**
#' @name espn_mbb_game_play_personnel
NULL
#' @title
#' **Get ESPN MBB Event Play Personnel (On-Court Lineup at Play)**
#' @rdname espn_mbb_game_play_personnel
#' @author Saiem Gilani
#' @description
#' Returns the players on court at a specific MBB play in long format
#' (one row per athlete entry across both competitors). Foundation for
#' lineup analysis. ESPN coverage is sparse — many plays return zero
#' rows; the wrapper returns a typed empty tibble in that case.
#'
#' @param event_id ESPN event identifier.
#' @param play_id ESPN play identifier.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per on-court athlete.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_play_personnel(event_id = 401256760, play_id = 401256760101805901)
#' }
espn_mbb_game_play_personnel <- function(event_id, play_id, ...) {
  .espn_basketball_event_play_personnel(league = "mens-college-basketball",
                                          event_id = event_id,
                                          play_id = play_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_team_score
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Event Competitor Score (Single Row)**
#' @rdname espn_mbb_game_team_linescores
#' @author Saiem Gilani
#' @description
#' Returns a one-row tibble with one team's final score for one MBB event:
#' numeric `value`, display string, `winner` flag, and source metadata.
#' Quick-lookup wrapper — use [espn_mbb_game_team_linescores()] for
#' per-period detail.
#'
#' @param event_id ESPN event identifier.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_team_score(event_id = 401256760, team_id = 52)
#' }
espn_mbb_game_team_score <- function(event_id, team_id, ...) {
  .espn_basketball_event_competitor_score(league = "mens-college-basketball",
                                            event_id = event_id,
                                            team_id = team_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_game_official_detail
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Event Official Detail (Single Official)**
#' @name espn_mbb_game_official_detail
NULL
#' @title
#' **Get ESPN MBB Event Official Detail (Single Official)**
#' @rdname espn_mbb_game_official_detail
#' @author Saiem Gilani
#' @description
#' Returns a single-row tibble for one referee assigned to one MBB event,
#' with their name, position (Referee / Crew Chief / Umpire), and crew
#' order. Pair with [espn_mbb_game_officials()] to enumerate the crew.
#'
#' @param event_id ESPN event identifier.
#' @param order Crew order index (1 = first official). Pair with the `order` column from event_officials().
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_game_official_detail(event_id = 401256760, order = 1)
#' }
espn_mbb_game_official_detail <- function(event_id, order, ...) {
  .espn_basketball_event_official_detail(league = "mens-college-basketball",
                                           event_id = event_id,
                                           order = order, ...)
}

