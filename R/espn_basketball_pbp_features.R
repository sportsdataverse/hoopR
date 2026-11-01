# Clock, period and timeout columns shared by helper_espn_mbb_pbp() and helper_espn_nba_pbp().
# R mirror of the play-derived features sportsdataverse-py adds in
# helper_{mbb,nba}_pbp_features (mbb/mbb_pbp.py, nba/nba_pbp.py) and
# _espn_basketball_pbp.{team_timeout_called,period_end_seconds}, so live hoopR plays carry
# the same columns as the load_{mbb,nba}_pbp releases. Change both sides together.
#
# Not ported (still release-only): the pickcenter line (game_spread, home_favorite,
# game_spread_available, home_team_spread), home/away_team_name_alt and athlete_name_1..3.

# ESPN's team-timeout play types.
.team_timeout_types <- c(
  "RegularTimeOut", "ShortTimeOut", "Full Timeout", "Short Timeout", "No Timeout", "Reset Timeout"
)

# TRUE on a team-timeout play the given team called. The play's own team_id decides; only a
# play without one falls back to a team name appearing as a whole word in the text.
.timeout_called <- function(plays, team_id, names) {
  names <- unique(setdiff(as.character(names), c("", NA)))
  by_name <- if (length(names) && "text" %in% names(plays)) {
    alternation <- paste(gsub("([][{}()+*^$|\\\\?.])", "\\\\\\1", sort(names)), collapse = "|")
    grepl(paste0("(?i)(?:^|\\W)(?:", alternation, ")(?:\\W|$)"), plays$text, perl = TRUE) &
      !is.na(plays$text)
  } else {
    rep(FALSE, nrow(plays))
  }
  play_team <- if ("team_id" %in% names(plays)) suppressWarnings(as.integer(plays$team_id)) else NA_integer_
  by_team <- ifelse(is.na(play_team), by_name, play_team %in% as.integer(team_id))
  (plays$type_text %in% .team_timeout_types) & by_team
}

# end_<scope>_seconds_remaining is the next row's start; the last row of a period ends at
# 0:00 on its period clock instead (its next row's clock starts over), the game's last row NA.
.end_seconds <- function(plays, period_scope, scopes) {
  nxt <- dplyr::lead(plays$period_number)
  ends_period <- !is.na(nxt) & plays$period_number != nxt
  left <- plays[[paste0("start_", period_scope, "_seconds_remaining")]]
  for (s in c(period_scope, scopes)) {
    start <- plays[[paste0("start_", s, "_seconds_remaining")]]
    plays[[paste0("end_", s, "_seconds_remaining")]] <- ifelse(ends_period, start - left, dplyr::lead(start))
  }
  plays
}

.espn_pbp_features <- function(plays, league, home_id, away_id, home_names, away_names) {
  if (nrow(plays) == 0L || !all(c("period_number", "clock_display_value") %in% names(plays))) {
    return(plays)
  }
  period <- as.integer(plays$period_number)
  clock <- as.character(plays$clock_display_value)
  # a bare sub-minute clock ("23.4") reads as 0:23.4
  mmss <- ifelse(grepl(":", clock, fixed = TRUE), clock, paste0("0:", clock))
  mmss[is.na(clock)] <- NA_character_
  part <- function(i) vapply(strsplit(mmss, ":", fixed = TRUE), function(x) x[i], character(1))
  minutes <- as.integer(suppressWarnings(as.numeric(part(1L))))
  seconds <- suppressWarnings(as.numeric(part(2L)))
  left <- 60L * minutes + seconds

  plays$game_play_number <- seq_len(nrow(plays))
  plays$home_timeout_called <- .timeout_called(plays, home_id, home_names)
  plays$away_timeout_called <- .timeout_called(plays, away_id, away_names)
  if (league == "mbb") {
    # two 20-minute halves; the period is the half
    seconds <- as.integer(seconds)
    left <- 60L * minutes + seconds
    plays$half <- period
    plays$time <- clock
    plays$clock_minutes <- minutes
    plays$clock_seconds <- seconds
    plays$lag_period <- dplyr::lag(period)
    plays$lead_period <- dplyr::lead(period)
    plays$lag_half <- dplyr::lag(period)
    plays$lead_half <- dplyr::lead(period)
    plays$start_period_seconds_remaining <- left
    plays$start_game_seconds_remaining <- ifelse(period %in% 1L, 1200L + left, left)
    plays <- .end_seconds(plays, "period", "game")
  } else {
    # four 12-minute quarters
    half <- ifelse(period %in% c(1L, 2L), 1L, 2L)
    plays$qtr <- period
    plays$time <- mmss
    plays$clock_minutes <- minutes
    plays$clock_seconds <- seconds
    plays$half <- half
    plays$game_half <- half
    plays$lag_qtr <- dplyr::lag(period)
    plays$lead_qtr <- dplyr::lead(period)
    plays$lag_half <- dplyr::lag(half)
    plays$lead_half <- dplyr::lead(half)
    plays$start_quarter_seconds_remaining <- left
    plays$start_half_seconds_remaining <- ifelse(period %in% c(1L, 3L), 720 + left, left)
    plays$start_game_seconds_remaining <- left + ifelse(period %in% 1L, 2160, ifelse(period %in% 2L, 1440, ifelse(period %in% 3L, 720, 0)))
    plays <- .end_seconds(plays, "quarter", c("half", "game"))
    plays$period <- period
  }
  plays
}
