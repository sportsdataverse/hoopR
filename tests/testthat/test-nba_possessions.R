## Tests for NBA possession event-classification helpers.
##
## These test internal (unexported) helpers — access them via
## hoopR:::.is_last_ft() / hoopR:::.offense_from_events() after
## devtools::load_all().

# ---------------------------------------------------------------------------
# .is_last_ft — NBA/WNBA "N of N" + G-League "{N}PT" contract
# ---------------------------------------------------------------------------

test_that(".is_last_ft matches the NBA/WNBA + G-League free-throw contract", {
  # NBA/WNBA "N of N" sequence labels — last FT of sequence → TRUE
  expect_true(.is_last_ft("Free Throw 2 of 2"))
  expect_true(.is_last_ft("Free Throw 1 of 1"))
  expect_true(.is_last_ft("Free Throw 3 of 3"))
  expect_true(.is_last_ft("Free Throw Flagrant 3 of 3"))

  # NBA/WNBA mid-sequence — not last → FALSE
  expect_false(.is_last_ft("Free Throw 1 of 2"))
  expect_false(.is_last_ft("Free Throw 2 of 3"))

  # Technical FT: no "N of N" substring → FALSE
  expect_false(.is_last_ft("Free Throw Technical"))

  # G-League single-FT (point-value) format — standalone trip → always last → TRUE
  expect_true(.is_last_ft("Free Throw 1PT"))
  expect_true(.is_last_ft("Free Throw 2PT"))
  expect_true(.is_last_ft("Free Throw 3PT"))

  # G-League case-sensitivity contract (mirrors sdv-py _FT_GL_PT_RE which is case-sensitive):
  # lowercase 'pt' must NOT match
  expect_false(.is_last_ft("Free Throw 2pt"))
  # optional-space variant (regex \s* tolerates the space)
  expect_true(.is_last_ft("Free Throw 2 PT"))

  # NA / empty → FALSE (safe for vectorized per-row usage)
  expect_false(.is_last_ft(NA_character_))
  expect_false(.is_last_ft(""))
})

# ---------------------------------------------------------------------------
# .offense_from_events — two-pass offense attribution
# ---------------------------------------------------------------------------

test_that(".offense_from_events returns correct offense team from scoring events", {
  home_id <- 1610612738L  # BOS
  away_id <- 1610612755L  # PHX

  # Pass 1: first scoring/shooting/turnover event with location wins
  events_away_scores <- list(
    list(event_type = "1", location = "v", team_id = away_id),  # away made shot
    list(event_type = "4", location = "h", team_id = home_id)   # home rebound (not seeding)
  )
  expect_equal(.offense_from_events(events_away_scores, home_id, away_id), away_id)

  events_home_scores <- list(
    list(event_type = "1", location = "h", team_id = home_id),  # home made shot
    list(event_type = "4", location = "v", team_id = away_id)   # away rebound
  )
  expect_equal(.offense_from_events(events_home_scores, home_id, away_id), home_id)

  # Pass 1: free throw (event_type "3") seeds offense
  events_ft <- list(
    list(event_type = "3", location = "v", team_id = away_id)  # away free throw
  )
  expect_equal(.offense_from_events(events_ft, home_id, away_id), away_id)

  # Pass 1: turnover (event_type "5") seeds offense
  events_to <- list(
    list(event_type = "5", location = "h", team_id = home_id)  # home turnover
  )
  expect_equal(.offense_from_events(events_to, home_id, away_id), home_id)

  # Pass 2 fallback: no scoring events but non-admin event has location
  events_fallback <- list(
    list(event_type = "4", location = "h", team_id = home_id)  # rebound — not in seeding set
  )
  expect_equal(.offense_from_events(events_fallback, home_id, away_id), home_id)

  # No attributable event → 0
  events_no_loc <- list(
    list(event_type = "12", location = "", team_id = 0L),  # StartPeriod, no location
    list(event_type = "13", location = "", team_id = 0L)   # EndPeriod, no location
  )
  expect_equal(.offense_from_events(events_no_loc, home_id, away_id), 0L)

  # Empty event list → 0
  expect_equal(.offense_from_events(list(), home_id, away_id), 0L)
})

# ---------------------------------------------------------------------------
# .OFFENSE_SEEDING_EVENT_TYPES — allowlist constant
# ---------------------------------------------------------------------------

test_that(".OFFENSE_SEEDING_EVENT_TYPES contains only shot/turnover event_type codes", {
  # Must include MadeShot("1"), MissedShot("2"), FreeThrow("3"), Turnover("5")
  expect_true("1" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # MadeShot
  expect_true("2" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # MissedShot
  expect_true("3" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # FreeThrow
  expect_true("5" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # Turnover

  # Admin/non-seeding types must NOT be included
  expect_false("4"  %in% .OFFENSE_SEEDING_EVENT_TYPES)  # Rebound
  expect_false("6"  %in% .OFFENSE_SEEDING_EVENT_TYPES)  # Foul
  expect_false("8"  %in% .OFFENSE_SEEDING_EVENT_TYPES)  # Sub
  expect_false("12" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # StartPeriod
  expect_false("13" %in% .OFFENSE_SEEDING_EVENT_TYPES)  # EndPeriod

  # Exactly 4 elements
  expect_equal(length(.OFFENSE_SEEDING_EVENT_TYPES), 4L)
})
