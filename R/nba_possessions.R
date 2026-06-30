#' @importFrom stringr str_detect str_match
#' @importFrom dplyr bind_rows mutate if_else

# ---------------------------------------------------------------------------
# NBA possession event-classification helpers
#
# These internal functions are the R port of the sdv-py Python helpers in
# sportsdataverse/nba/nba_possessions.py.  Behavior is validated by tests;
# they are adapted to hoopR's V2/V3 schema rather than being a literal
# line-for-line translation.
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Small utilities
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Coerce a possibly-NA / NULL / length-0 scalar to the empty string `""`.
#' Guards the `location` reads so a NA `location` does not stringify to the
#' literal `"NA"` (which has `nchar == 2 > 0` and would be mistaken for a
#' real "h"/"v" location on real-world data).
.na_to_empty <- function(x) {
  if (length(x) == 0L || is.null(x) || is.na(x)) "" else as.character(x)
}


# ---------------------------------------------------------------------------
# Offense-seeding allowlist
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Event type codes (hoopR V2 `event_type` column) that reliably identify the
#' team in possession of the ball for offense-attribution purposes.
#'
#' ALLOWLIST rationale (mirrors Python `_OFFENSE_SEEDING_TYPES`):
#'   "1" = MadeShot, "2" = MissedShot, "3" = FreeThrow, "5" = Turnover
#'
#' Administrative events such as Rebound ("4"), Foul ("6"), Substitution ("8"),
#' StartPeriod ("12"), and EndPeriod ("13") carry a `location` column but do
#' NOT reliably tell us who is on offense — a rebound, for example, belongs to
#' whichever team grabbed the ball, not the ball-holding team.  Including them
#' in the seed set mis-labels subsequent possessions (e.g. marks a defensive
#' rebound as belonging to the wrong offense).
.OFFENSE_SEEDING_EVENT_TYPES <- c("1", "2", "3", "5")


# ---------------------------------------------------------------------------
# .is_last_ft
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Return `TRUE` if `sub_type` represents the **final free throw of a trip**.
#'
#' Two sub-formats are recognized (mirrors Python `_is_last_ft`):
#'
#' **NBA / WNBA "N of N"** — the `sub_type` contains a substring of the form
#' `"<num> of <num>"` where both numbers are equal:
#'   - `"Free Throw 2 of 2"` → TRUE  (last of a 2-shot trip)
#'   - `"Free Throw 1 of 1"` → TRUE  (single technical-free-throw trip)
#'   - `"Free Throw Flagrant 3 of 3"` → TRUE
#'   - `"Free Throw 1 of 2"` → FALSE (first of a 2-shot trip)
#'   - `"Free Throw Technical"` → FALSE (no "N of N" substring)
#'
#' **G-League single-FT (point-value) format** — the regex
#' `"Free Throw \\d+\\s*PT\\b"` (case-SENSITIVE) matches strings like
#' `"Free Throw 1PT"`, `"Free Throw 2PT"`, `"Free Throw 3PT"`, and the
#' optional-space variant `"Free Throw 2 PT"`.  Each G-League single-FT event
#' is a standalone trip, so it is always the last (and only) FT of its trip.
#' Lowercase variants (`"Free Throw 2pt"`) do NOT match.
#'
#' `NA` and `""` return `FALSE` (safe for per-row vectorized use).
#'
#' @param sub_type A length-1 character string (the V3 `sub_type` column value).
#' @return A length-1 logical.
.is_last_ft <- function(sub_type) {
  # Treat NA / empty as FALSE
  if (is.na(sub_type) || nchar(sub_type) == 0L) return(FALSE)

  # G-League single-FT point-value format (case-SENSITIVE — do NOT add ignore.case)
  # Mirrors Python: re.compile(r"Free Throw \d+\s*PT\b")
  if (stringr::str_detect(sub_type, "Free Throw \\d+\\s*PT\\b")) return(TRUE)

  # NBA/WNBA "N of N" — both captured groups must be equal
  # Mirrors Python: re.compile(r"(\d+)\s+of\s+(\d+)")
  m <- stringr::str_match(sub_type, "(\\d+)\\s+of\\s+(\\d+)")
  if (!is.na(m[1L, 1L]) && m[1L, 2L] == m[1L, 3L]) return(TRUE)

  FALSE
}


# ---------------------------------------------------------------------------
# .offense_from_events
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Determine the **offense team ID** for a possession from its accumulated
#' event rows.
#'
#' Mirrors the two-pass logic of Python `_offense_from_events`:
#'
#' **Pass 1 — scoring/shooting/turnover with location.**  Scans `events` for
#' the first row whose `event_type` is in `.OFFENSE_SEEDING_EVENT_TYPES`
#' (`"1"` MadeShot / `"2"` MissedShot / `"3"` FreeThrow / `"5"` Turnover)
#' AND whose `location` is non-empty.  Returns `home_id` if `location == "h"`,
#' `away_id` if `location == "v"`.
#'
#' **Pass 2 — any non-admin event with location.**  Scans for the first row
#' with a non-empty `location` whose `event_type` is not one of the
#' administrative denylist codes: Foul ("6"), StartPeriod ("12"),
#' EndPeriod ("13"), Sub ("8"), Timeout ("9").
#'
#' Returns `0L` if attribution is impossible (e.g. period-boundary-only
#' groups that carry no location-bearing events).
#'
#' @param events  A list of named lists, each representing one PBP row.
#'   Required fields per element: `event_type` (character), `location`
#'   (character, "h"/"v"/""), `team_id` (integer — not used for attribution
#'   here; location is the reliable signal).
#' @param home_id Integer team ID of the home team.
#' @param away_id Integer team ID of the away team.
#' @return A length-1 integer: `home_id`, `away_id`, or `0L`.
.offense_from_events <- function(events, home_id, away_id) {
  if (length(events) == 0L) return(0L)

  # Helper: map location string to team id
  loc_to_team <- function(loc) {
    if (identical(loc, "h")) home_id
    else if (identical(loc, "v")) away_id
    else 0L
  }

  # Admin event_type codes that do NOT identify the offense (denylist for pass 2)
  # Foul="6", Sub="8", Timeout="9", StartPeriod="12", EndPeriod="13"
  .ADMIN_TYPES <- c("6", "8", "9", "12", "13")

  # Pass 1: first scoring/shooting/turnover event with non-empty location
  for (ev in events) {
    et  <- ev[["event_type"]] %||% ""
    loc <- .na_to_empty(ev[["location"]])
    if (et %in% .OFFENSE_SEEDING_EVENT_TYPES && nchar(loc) > 0L) {
      team <- loc_to_team(loc)
      if (team != 0L) return(team)
    }
  }

  # Pass 2: first non-admin event with a non-empty location
  for (ev in events) {
    et  <- ev[["event_type"]] %||% ""
    loc <- .na_to_empty(ev[["location"]])
    if (nchar(loc) > 0L && !(et %in% .ADMIN_TYPES)) {
      team <- loc_to_team(loc)
      if (team != 0L) return(team)
    }
  }

  0L
}


# ---------------------------------------------------------------------------
# .build_possessions
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Build one row per possession from a hoopR play-by-play data frame.
#'
#' Mirrors the stateful row-loop of Python `build_possessions` /
#' `_build_possession_groups`, adapted to hoopR's V2 `event_type` codes and
#' column names (`home_score` / `away_score` already forward-filled running
#' totals, `sub_type` for FT trip labels).
#'
#' **Possession boundaries (when to flush the current group):**
#' - Made field goal (`event_type == "1"`)
#' - Turnover (`event_type == "5"`)
#' - Defensive rebound (`event_type == "4"` by the team NOT on offense)
#' - Made last free throw of a trip (`event_type == "3"` AND `.is_last_ft(sub_type)`
#'   AND NOT a technical FT AND score is present)
#' - Period change (period increments between rows)
#'
#' **Non-boundary events** (just accumulate, never flush on their own):
#' Foul ("6"), Sub ("8"), Timeout ("9"), JumpBall ("10"),
#' StartPeriod ("12"), EndPeriod ("13"), Other/Replay ("18").
#'
#' **Offense seeding:** only `.OFFENSE_SEEDING_EVENT_TYPES` ("1","2","3","5")
#' may seed `current_offense` — rebounding/admin events do not seed it.
#'
#' **Points:** offense team's `home_score`/`away_score` delta across the group.
#' Groups with `offense_team_id == 0` are attributed by score direction so the
#' per-team total always reconciles to the boxscore.
#'
#' @param pbp A data frame with hoopR V2/V3 PBP columns: `event_type`,
#'   `sub_type`, `location`, `team_id`, `home_score`, `away_score`, `period`,
#'   `game_id`, and optionally `start_event_idx` / `end_event_idx`.
#' @return A tibble with columns:
#'   `game_id`, `period`, `possession_number`, `offense_team_id`,
#'   `defense_team_id`, `points`, `start_event_idx`, `end_event_idx`,
#'   `second_chance` (logical — TRUE if the possession was extended by an
#'   offensive rebound; mirrors Python `is_second_chance`).
.build_possessions <- function(pbp) {
  if (is.null(pbp) || nrow(pbp) == 0L) {
    return(
      data.frame(
        game_id = character(), period = integer(),
        possession_number = integer(),
        offense_team_id = integer(), defense_team_id = integer(),
        points = integer(),
        start_event_idx = integer(), end_event_idx = integer(),
        second_chance = logical(),
        stringsAsFactors = FALSE
      )
    )
  }

  # ── Resolve home / away team IDs from location column ──────────────────────
  home_rows <- pbp[!is.na(pbp$location) & pbp$location == "h" &
                     !is.na(pbp$team_id) & pbp$team_id != 0L, ]
  away_rows <- pbp[!is.na(pbp$location) & pbp$location == "v" &
                     !is.na(pbp$team_id) & pbp$team_id != 0L, ]
  if (nrow(home_rows) == 0L || nrow(away_rows) == 0L) {
    return(
      data.frame(
        game_id = character(), period = integer(),
        possession_number = integer(),
        offense_team_id = integer(), defense_team_id = integer(),
        points = integer(),
        start_event_idx = integer(), end_event_idx = integer(),
        second_chance = logical(),
        stringsAsFactors = FALSE
      )
    )
  }
  home_id <- home_rows$team_id[1L]
  away_id <- away_rows$team_id[1L]

  game_id <- as.character(pbp$game_id[1L])

  # ── Event-type codes (hoopR V2 strings) ────────────────────────────────────
  # Non-boundary: foul, sub, timeout, jump_ball, start/end period, other/replay
  .NON_BOUNDARY <- c("6", "8", "9", "10", "12", "13", "18")

  # ── Stateful row loop ───────────────────────────────────────────────────────
  n <- nrow(pbp)
  records    <- vector("list", n)          # pre-allocate; trim at end
  rec_idx    <- 0L

  current         <- vector("list", n)     # accumulator for current group
  cur_n           <- 0L
  current_offense <- 0L
  is_sc           <- FALSE
  prev_period     <- NA_integer_
  poss_num        <- 0L

  # Forward-fill home_score / away_score (they may be NA between scoring events)
  hs_vec <- as.numeric(pbp$home_score)
  as_vec <- as.numeric(pbp$away_score)
  last_home <- 0.0
  last_away <- 0.0
  ff_home   <- numeric(n)
  ff_away   <- numeric(n)
  for (i in seq_len(n)) {
    v <- hs_vec[i]
    if (!is.na(v) && v > 0) last_home <- v
    ff_home[i] <- last_home
    v <- as_vec[i]
    if (!is.na(v) && v > 0) last_away <- v
    ff_away[i] <- last_away
  }

  # Score at the start of the current group (updated on flush)
  prev_home <- 0.0
  prev_away <- 0.0

  # Helper: flush current group into records
  flush_group <- function() {
    if (cur_n == 0L) return()

    off <- .offense_from_events(current[seq_len(cur_n)], home_id, away_id)

    end_home <- current[[cur_n]][["._home"]]
    end_away <- current[[cur_n]][["._away"]]

    if (off == 0L) {
      # Unattributable group — attribute by score direction so totals reconcile
      hd <- end_home - prev_home
      ad <- end_away - prev_away
      if (hd <= 0 && ad <= 0) {
        # No score change: skip (update anchors but don't emit a possession)
        prev_home <<- end_home
        prev_away <<- end_away
        # Reset state
        cur_n           <<- 0L
        current_offense <<- 0L
        is_sc           <<- FALSE
        return()
      }
      off <- if (hd > 0) home_id else away_id
    }

    def <- if (off == home_id) away_id else home_id

    pts <- if (off == home_id) {
      as.integer(end_home - prev_home)
    } else {
      as.integer(end_away - prev_away)
    }

    poss_num  <<- poss_num + 1L
    rec_idx   <<- rec_idx + 1L
    records[[rec_idx]] <<- list(
      game_id           = game_id,
      period            = current[[1L]][["period"]],
      possession_number = poss_num,
      offense_team_id   = as.integer(off),
      defense_team_id   = as.integer(def),
      points            = pts,
      start_event_idx   = current[[1L]][["._idx"]],
      end_event_idx     = current[[cur_n]][["._idx"]],
      second_chance     = is_sc
    )

    prev_home <<- end_home
    prev_away <<- end_away
    cur_n           <<- 0L
    current_offense <<- 0L
    is_sc           <<- FALSE
  }

  for (i in seq_len(n)) {
    et       <- as.character(pbp$event_type[i] %||% "")
    loc      <- .na_to_empty(pbp$location[i])
    sub_type <- as.character(pbp$sub_type[i]   %||% "")
    period   <- as.integer(pbp$period[i]        %||% 0L)
    tid      <- as.integer(pbp$team_id[i]       %||% 0L)
    if (is.na(tid)) tid <- 0L

    # Period change → flush before appending current row
    if (!is.na(prev_period) && period != prev_period) {
      flush_group()
    }
    prev_period <- period

    # Append row to current group
    cur_n <- cur_n + 1L
    current[[cur_n]] <- list(
      event_type = et,
      location   = loc,
      sub_type   = sub_type,
      team_id    = tid,
      period     = period,
      "._home"   = ff_home[i],
      "._away"   = ff_away[i],
      "._idx"    = i
    )

    # Seed current_offense from allowlist events only
    if (current_offense == 0L && et %in% .OFFENSE_SEEDING_EVENT_TYPES) {
      ev_team <- if (loc == "h") home_id else if (loc == "v") away_id else 0L
      if (ev_team != 0L) current_offense <- ev_team
    }

    # Non-boundary events: just accumulate
    if (et %in% .NON_BOUNDARY) next

    # Boundary detection
    ends_possession <- FALSE

    if (et == "1") {
      # Made field goal → always ends possession
      ends_possession <- TRUE

    } else if (et == "5") {
      # Turnover → ends possession
      ends_possession <- TRUE

    } else if (et == "4") {
      # Rebound: offensive (extends) vs defensive (ends)
      reb_team <- tid
      if (reb_team == 0L) {
        # Team rebound — use location
        reb_team <- if (loc == "h") home_id else if (loc == "v") away_id else 0L
      }
      if (current_offense != 0L && reb_team != 0L) {
        if (reb_team == current_offense) {
          # Offensive rebound → extend, mark second chance
          is_sc <- TRUE
        } else {
          # Defensive rebound → ends possession
          ends_possession <- TRUE
        }
      }

    } else if (et == "3") {
      # Free throw: technical FTs don't end a trip;
      # last FT of a regular trip that was MADE ends possession.
      # Missed last FT → defensive rebound ends it naturally.
      is_tech <- grepl("Technical", sub_type, fixed = TRUE) ||
                   grepl("technical", sub_type, fixed = TRUE)
      if (!is_tech && .is_last_ft(sub_type)) {
        # Check if score is present (non-zero forward-filled score means
        # a scoring event has happened — the score column is non-NA/non-zero)
        has_score <- ff_home[i] > 0 || ff_away[i] > 0
        if (has_score) {
          ends_possession <- TRUE
        }
      }
    }

    if (ends_possession) flush_group()
  }

  # Flush remaining events
  flush_group()

  if (rec_idx == 0L) {
    return(
      data.frame(
        game_id = character(), period = integer(),
        possession_number = integer(),
        offense_team_id = integer(), defense_team_id = integer(),
        points = integer(),
        start_event_idx = integer(), end_event_idx = integer(),
        second_chance = logical(),
        stringsAsFactors = FALSE
      )
    )
  }

  # Assemble result
  do.call(rbind, lapply(records[seq_len(rec_idx)], as.data.frame,
                        stringsAsFactors = FALSE))
}


# ---------------------------------------------------------------------------
# .home_away_team_ids
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Determine the home and away team IDs from a hoopR play-by-play frame.
#'
#' Uses the `location` column ("h" = home side, "v" = visitor/away side)
#' combined with `team_id` to identify each side.  Only rows where
#' `team_id > 0` are considered (0 is the "no team" sentinel).
#'
#' @param pbp A hoopR PBP data frame with `location` and `team_id` columns.
#' @return A named integer vector `c(home = <id>, away = <id>)`.
#'   Returns `c(home = NA_integer_, away = NA_integer_)` if either side
#'   cannot be resolved.
.home_away_team_ids <- function(pbp) {
  locs <- pbp[["location"]]
  tids <- pbp[["team_id"]]

  home_mask <- !is.na(locs) & locs == "h" & !is.na(tids) & tids > 0L
  away_mask <- !is.na(locs) & locs == "v" & !is.na(tids) & tids > 0L

  home_id <- if (any(home_mask)) as.integer(tids[home_mask][1L]) else NA_integer_
  away_id <- if (any(away_mask)) as.integer(tids[away_mask][1L]) else NA_integer_

  c(home = home_id, away = away_id)
}


# ---------------------------------------------------------------------------
# .attach_possession_lineups
# ---------------------------------------------------------------------------

#' @noRd
#'
#' Attach on-court 5v5 lineups (10 player IDs) to each possession row.
#'
#' For each possession the starting lineup is read from the PBP row at
#' `start_event_idx` (a 1-based row index verified to have non-NA lineup
#' columns).  The 10 columns `away_player1..5` / `home_player1..5` in the
#' PBP frame are forward-filled at every row, so this is a vectorizable
#' row-index gather rather than a stateful loop.
#'
#' Assignment rule:
#' - If `offense_team_id == home_team_id` → `off_player_1..5 = home_player1..5`,
#'   `def_player_1..5 = away_player1..5`.
#' - Otherwise (offense is the away team) → assignment is swapped.
#'
#' Output ID dtype: **integer** — the player IDs are NBA `person_id` values
#' used as join keys for downstream RAPM / lineup models (Phase 6b).  The PBP
#' stores them as `numeric` (double); they are cast to `integer` here.
#'
#' @param possessions A data frame produced by `.build_possessions()` with
#'   columns `offense_team_id` and `start_event_idx`.
#' @param pbp The hoopR PBP data frame used to build `possessions`.  Must
#'   contain `away_player1`..`away_player5` and `home_player1`..`home_player5`
#'   (numeric `person_id` columns, forward-filled).
#' @return `possessions` with 10 additional integer columns appended:
#'   `off_player_1`..`off_player_5` and `def_player_1`..`def_player_5`.
.attach_possession_lineups <- function(possessions, pbp) {
  if (is.null(possessions) || nrow(possessions) == 0L) {
    possessions[, paste0(c("off_player_", "def_player_"), rep(1:5, each = 2L))] <-
      integer(0L)
    return(possessions)
  }

  # Resolve home / away team IDs
  ids     <- .home_away_team_ids(pbp)
  home_id <- ids[["home"]]
  away_id <- ids[["away"]]

  # The 10 lineup columns in the PBP frame
  home_cols <- paste0("home_player", 1:5)
  away_cols <- paste0("away_player", 1:5)

  # Vectorized row-index gather from pbp
  idx <- dplyr::pull(possessions, start_event_idx)

  # Extract home and away lineups for each possession's start row
  # pbp[idx, col] returns a length-nrow(possessions) vector
  home_mat <- vapply(
    home_cols,
    function(col) as.integer(pbp[[col]][idx]),
    integer(length(idx))
  )  # nrow x 5 matrix
  away_mat <- vapply(
    away_cols,
    function(col) as.integer(pbp[[col]][idx]),
    integer(length(idx))
  )  # nrow x 5 matrix

  # Determine offense/defense assignment per possession
  off_ids <- dplyr::pull(possessions, offense_team_id)
  is_home_offense <- off_ids == home_id

  # Build off/def matrices: select row-wise between home_mat and away_mat
  n <- length(idx)
  off_mat <- matrix(0L, nrow = n, ncol = 5L)
  def_mat <- matrix(0L, nrow = n, ncol = 5L)

  for (p in 1:5) {
    off_mat[, p] <- ifelse(is_home_offense, home_mat[, p], away_mat[, p])
    def_mat[, p] <- ifelse(is_home_offense, away_mat[, p], home_mat[, p])
  }

  # Append columns to the possession frame
  for (p in 1:5) {
    possessions[[paste0("off_player_", p)]] <- off_mat[, p]
    possessions[[paste0("def_player_", p)]] <- def_mat[, p]
  }

  possessions
}
