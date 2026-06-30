#' @importFrom stringr str_detect str_match

# ---------------------------------------------------------------------------
# NBA possession event-classification helpers
#
# These internal functions are the R port of the sdv-py Python helpers in
# sportsdataverse/nba/nba_possessions.py.  Behavior is validated by tests;
# they are adapted to hoopR's V2/V3 schema rather than being a literal
# line-for-line translation.
# ---------------------------------------------------------------------------

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
    loc <- ev[["location"]]   %||% ""
    if (et %in% .OFFENSE_SEEDING_EVENT_TYPES && nchar(loc) > 0L) {
      team <- loc_to_team(loc)
      if (team != 0L) return(team)
    }
  }

  # Pass 2: first non-admin event with a non-empty location
  for (ev in events) {
    et  <- ev[["event_type"]] %||% ""
    loc <- ev[["location"]]   %||% ""
    if (nchar(loc) > 0L && !(et %in% .ADMIN_TYPES)) {
      team <- loc_to_team(loc)
      if (team != 0L) return(team)
    }
  }

  0L
}
