# Running-score rebuild shared by helper_espn_nba_pbp() and helper_espn_mbb_pbp().
# Same code as wehoop (R/espn_basketball_running_score.R); R mirror of
# sportsdataverse-py's wbb_play_by_play._repair_running_score. Change all three together.
#
# ESPN writes each play's homeScore/awayScore from the live scoreboard when the row
# is keyed. A play keyed late (a technical free throw entered after play resumed)
# gets the right score on its own row, but rows already written are never re-based,
# so the feed runs backwards and can end short of the final (NBA 401766458: 119-95
# against 120-95). NBA/WNBA 2013-2019 feeds ship made free throws with scoreValue 0,
# and college neutral-site feeds can carry the away team's score in homeScore for a
# whole game (MBB 401829457).
#
# The rebuild sums each scoring play's points in ESPN's array order (never re-sorted:
# sequence_number is not chronological), crediting the header's home or away team by
# team_id. A made free throw with scoreValue 0 counts 1. The rebuilt pair replaces
# ESPN's on every row only when its last row equals the header final; otherwise every
# row keeps ESPN's value. score_source (appended last) records which: "rebuilt" or "espn".
.repair_running_score <- function(plays, home_id, away_id, home_final, away_final) {
  plays$score_source <- "espn"
  needed <- c("scoring_play", "score_value", "team_id", "type_text", "home_score", "away_score")
  ids <- suppressWarnings(as.integer(c(home_id, away_id)))
  final <- suppressWarnings(as.integer(c(home_final, away_final)))
  if (length(ids) != 2L || length(final) != 2L || anyNA(ids) || anyNA(final) ||
      nrow(plays) == 0L || !all(needed %in% names(plays))) {
    return(plays)
  }
  value <- suppressWarnings(as.integer(plays$score_value))
  points <- ifelse(
    !(plays$scoring_play %in% TRUE), 0L,
    ifelse(
      !is.na(value) & value > 0L, value,
      ifelse(grepl("free ?throw", plays$type_text, ignore.case = TRUE), 1L, 0L)
    )
  )
  team <- suppressWarnings(as.integer(plays$team_id))
  home <- cumsum(ifelse(team %in% ids[[1L]], points, 0L))
  away <- cumsum(ifelse(team %in% ids[[2L]], points, 0L))
  if (home[[length(home)]] != final[[1L]] || away[[length(away)]] != final[[2L]]) {
    return(plays)
  }
  plays$home_score <- home
  plays$away_score <- away
  plays$score_source <- "rebuilt"
  plays
}
