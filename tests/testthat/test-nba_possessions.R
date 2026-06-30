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

# ---------------------------------------------------------------------------
# .build_possessions — boxscore-points reconciliation (independent oracle)
# ---------------------------------------------------------------------------

test_that("possession points reconcile to the boxscore (independent oracle)", {
  for (gid in c("0022200001", "0022300001")) {
    pbp <- readRDS(test_path("fixtures", "nba_engine", paste0("pbp_", gid, ".rds")))
    box <- readRDS(test_path("fixtures", "nba_engine", paste0("box_", gid, ".rds")))

    poss <- .build_possessions(pbp)

    # Per-team possession points
    agg <- dplyr::group_by(poss, offense_team_id)
    agg <- dplyr::summarise(agg, pts = sum(points), .groups = "drop")

    # Boxscore oracle: sum player points per team from home/away player tables
    home_df <- box[["home_team_player_traditional"]]
    away_df <- box[["away_team_player_traditional"]]
    home_tid <- unique(home_df$team_id)
    away_tid <- unique(away_df$team_id)
    home_pts <- sum(as.numeric(home_df$points), na.rm = TRUE)
    away_pts <- sum(as.numeric(away_df$points), na.rm = TRUE)
    box_pts <- c(home_pts, away_pts)
    names(box_pts) <- as.character(c(home_tid, away_tid))

    for (tid_chr in names(box_pts)) {
      expected <- as.integer(box_pts[[tid_chr]])
      tid_int  <- as.integer(tid_chr)
      actual   <- agg$pts[agg$offense_team_id == tid_int]
      if (length(actual) == 0L) actual <- 0L
      expect_equal(
        actual, expected,
        label = paste0("game=", gid, " team=", tid_chr,
                       " engine=", actual, " boxscore=", expected)
      )
    }
  }
})

# ---------------------------------------------------------------------------
# .build_possessions — second_chance flag (Python is_second_chance parity)
# ---------------------------------------------------------------------------

test_that(".build_possessions emits a logical second_chance flag", {
  for (gid in c("0022200001", "0022300001")) {
    pbp  <- readRDS(test_path("fixtures", "nba_engine", paste0("pbp_", gid, ".rds")))
    poss <- .build_possessions(pbp)

    # Column present and logical-typed
    expect_true("second_chance" %in% colnames(poss),
                label = paste0("game=", gid, " has second_chance column"))
    expect_true(is.logical(poss$second_chance),
                label = paste0("game=", gid, " second_chance is logical"))

    # Both fixture games contain offensive rebounds → at least one second-chance
    # possession, but the vast majority of possessions are not second-chance.
    expect_true(any(poss$second_chance),
                label = paste0("game=", gid, " has >=1 second-chance possession"))
    expect_false(all(poss$second_chance),
                 label = paste0("game=", gid, " not all possessions are second-chance"))
  }
})

# ---------------------------------------------------------------------------
# .attach_possession_lineups — roster-membership gate (independent oracle)
# ---------------------------------------------------------------------------

test_that("possession on-court ids are all in the boxscore roster (independent oracle)", {
  off_cols <- paste0("off_player_", 1:5)
  def_cols <- paste0("def_player_", 1:5)

  for (gid in c("0022200001", "0022300001")) {
    pbp <- readRDS(test_path("fixtures", "nba_engine", paste0("pbp_", gid, ".rds")))
    box <- readRDS(test_path("fixtures", "nba_engine", paste0("box_", gid, ".rds")))

    poss <- .attach_possession_lineups(.build_possessions(pbp), pbp)

    # Verify 10 new columns were added, all integer-typed
    for (col in c(off_cols, def_cols)) {
      expect_true(col %in% colnames(poss),
                  label = paste0("game=", gid, " column ", col, " present"))
      expect_true(is.integer(poss[[col]]),
                  label = paste0("game=", gid, " column ", col, " is integer"))
    }

    # Build independent roster oracle from boxscore person_id columns
    home_df  <- box[["home_team_player_traditional"]]
    away_df  <- box[["away_team_player_traditional"]]
    home_tid <- as.integer(home_df[["team_id"]][1L])
    away_tid <- as.integer(away_df[["team_id"]][1L])
    home_roster <- as.integer(home_df[["person_id"]])
    away_roster <- as.integer(away_df[["person_id"]])

    roster_by_team <- list()
    roster_by_team[[as.character(home_tid)]] <- home_roster
    roster_by_team[[as.character(away_tid)]] <- away_roster

    # For each possession: off_player_1..5 must be in offense team's roster,
    # def_player_1..5 must be in defense team's roster
    off_tids <- dplyr::pull(poss, offense_team_id)
    def_tids <- dplyr::pull(poss, defense_team_id)

    for (i in seq_len(nrow(poss))) {
      off_tid_chr <- as.character(off_tids[i])
      def_tid_chr <- as.character(def_tids[i])
      off_roster  <- roster_by_team[[off_tid_chr]]
      def_roster  <- roster_by_team[[def_tid_chr]]

      for (p in 1:5) {
        off_id <- poss[[paste0("off_player_", p)]][i]
        def_id <- poss[[paste0("def_player_", p)]][i]

        expect_true(
          off_id %in% off_roster,
          label = paste0("game=", gid, " poss=", i,
                         " off_player_", p, "=", off_id,
                         " in offense roster (team=", off_tid_chr, ")")
        )
        expect_true(
          def_id %in% def_roster,
          label = paste0("game=", gid, " poss=", i,
                         " def_player_", p, "=", def_id,
                         " in defense roster (team=", def_tid_chr, ")")
        )
      }
    }
  }
})
