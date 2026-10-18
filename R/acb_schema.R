# acb_schema.R -- field tables and code tables of the ACB (Liga Endesa) frames.
#
# Copied from sdv-py origin/main e3d232ebc9: `FIELDS` of sportsdataverse/basketball/acb/acb_parsers.py
# (column, type letter, source path inside the record; NA = the extractor derives it) and the
# PLAY_TYPES / PLAY_TAGS / COUNTRIES tables of acb_codes.py. Type letters: i integer, f double,
# s character, b logical, t UTC instant (POSIXct), d DD-MM-YYYY date, m 'mm:ss' -> integer seconds,
# p display percent -> double, j list joined with '; '. Change them in sdv-py first, then copy here.

#' One field table: columns, type letters (one per column) and source paths.
#' @noRd
.acb_ft <- function(col, type, path) {
  list(col = col, type = strsplit(type, "", fixed = TRUE)[[1]], path = path)
}

#' Field tables per frame (sdv-py `acb_parsers.FIELDS`).
#' @noRd
.acb_fields <- list(
  match_header = .acb_ft(
    c(
      "match_id", "competition_id", "start", "status", "is_on_half_time", "time_left", "current_quarter",
      "home_score", "away_score", "home_bonus", "away_bonus", "home_team_id", "home_club_id", "home_team",
      "home_team_abbr", "away_team_id", "away_club_id", "away_team", "away_team_abbr", "edition_id", "season",
      "has_overview", "has_play_by_play", "has_boxscore", "has_advanced", "highlights_url"
    ),
    "iitsbsiiiiiiissiissiibbbbs",
    c(
      "matchId", "competitionId", "start", "matchStatus", "isOnHalfTime", "timeLeft", "currentQuarter",
      "currentHomeScore", "currentAwayScore", "currentHomeBonus", "currentAwayBonus", "teams.home.id",
      "teams.home.clubId", "teams.home.fullName", "teams.home.abbreviatedName", "teams.away.id",
      "teams.away.clubId", "teams.away.fullName", "teams.away.abbreviatedName", "teams.home.editionId", NA,
      "availableContent.overview", "availableContent.playbyplay", "availableContent.boxscore",
      "availableContent.advanced", "highLightsVideoURL"
    )
  ),
  period_scores = .acb_ft(
    c(
      "match_id", "quarter", "home_score", "away_score"
    ),
    "iiii",
    c(
      NA, "quarter", "homeScore", "awayScore"
    )
  ),
  player_box = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr", "quarter",
      "player_id", "player_name", "first_name", "last_name", "shirt_number", "game_role", "on_court",
      "play_time", "seconds_played", "is_starter", "points", "free_throws_made", "free_throws_attempted",
      "two_pointers_made", "two_pointers_attempted", "three_pointers_made", "three_pointers_attempted",
      "assists", "off_rebounds", "def_rebounds", "total_rebounds", "steals", "turnovers", "blocks",
      "received_blocks", "dunks", "personal_fouls", "fouls_drawn", "plus_minus", "rating"
    ),
    "iiisiissiisssssbsmbiiiiiiiiiiiiiiiiiiii",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, "player.id", "player.nickname", "player.firstName",
      "player.lastName", "player.shirtNumber", "player.gameRole", "onCourt", "playTime", "playTime",
      "isStarted", "points", "freeThrowsMade", "freeThrowsAttempted", "twoPointersMade",
      "twoPointersAttempted", "threePointersMade", "threePointersAttempted", "assists", "offRebounds",
      "defRebounds", "totalRebounds", "steals", "turnovers", "blocks", "receivedBlocks", "dunks",
      "personalFouls", "foulsDrawn", "plusMinus", "rating"
    )
  ),
  team_box = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr", "quarter",
      "scope", "points", "free_throws_made", "free_throws_attempted", "two_pointers_made",
      "two_pointers_attempted", "three_pointers_made", "three_pointers_attempted", "assists", "off_rebounds",
      "def_rebounds", "total_rebounds", "steals", "turnovers", "blocks", "received_blocks", "dunks",
      "personal_fouls", "fouls_drawn", "plus_minus", "rating"
    ),
    "iiisiissisiiiiiiiiiiiiiiiiiiii",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "points", "freeThrowsMade", "freeThrowsAttempted",
      "twoPointersMade", "twoPointersAttempted", "threePointersMade", "threePointersAttempted", "assists",
      "offRebounds", "defRebounds", "totalRebounds", "steals", "turnovers", "blocks", "receivedBlocks",
      "dunks", "personalFouls", "foulsDrawn", "plusMinus", "rating"
    )
  ),
  box_info = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr",
      "head_coach", "assistant_coaches", "arena", "attendance", "referees"
    ),
    "iiisiisssjsij",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, "headCoach", "assistantCoaches", NA, NA, NA
    )
  ),
  pbp = .acb_ft(
    c(
      "match_id", "edition_id", "season", "play_index", "order", "quarter", "minute", "second",
      "clock_seconds", "play_type", "play_name", "play_tag", "turnover_type", "is_home", "score_home",
      "score_away", "license_type", "player_id", "player_name", "shirt_number", "run_points",
      "run_free_throws_made", "run_free_throws_attempted", "run_two_pointers_made",
      "run_two_pointers_attempted", "run_three_pointers_made", "run_three_pointers_attempted", "run_assists",
      "run_off_rebounds", "run_def_rebounds", "run_total_rebounds", "run_steals", "run_turnovers",
      "run_blocks", "run_personal_fouls", "run_fouls_drawn", "series_wins", "series_losses"
    ),
    "iiiiiiiiiisisbiiiissiiiiiiiiiiiiiiiiii",
    c(
      NA, NA, NA, NA, "order", "quarter", "minute", "second", NA, "playType", NA, "playTag", NA, "local",
      "scoreHome", "scoreAway", "licenseType", "playerLicenseId", "playerName", "playerNumber",
      "playerStats.points", "playerStats.freeThrowsMade", "playerStats.freeThrowsAttempted",
      "playerStats.twoPointersMade", "playerStats.twoPointersAttempted", "playerStats.threePointersMade",
      "playerStats.threePointersAttempted", "playerStats.assists", "playerStats.offRebounds",
      "playerStats.defRebounds", "playerStats.totalRebounds", "playerStats.steals", "playerStats.turnovers",
      "playerStats.blocks", "playerStats.personalFouls", "playerStats.foulsDrawn", "matchesWon",
      "matchesLost"
    )
  ),
  shots = .acb_ft(
    c(
      "match_id", "edition_id", "season", "shot_id", "pos_x", "pos_y", "coord_system", "x_basket_m",
      "y_basket_m", "quarter", "minute", "second", "clock_seconds", "play_type", "play_name", "is_home",
      "score_home", "score_away", "player_id", "player_name", "shirt_number", "zone", "made", "points"
    ),
    "iiiiiisffiiiiisbiiisssbi",
    c(
      NA, NA, NA, "id", "posX", "posY", NA, NA, NA, "quarter", "minute", "second", NA, "playType", NA,
      "local", "scoreHome", "scoreAway", "playerLicenseId", NA, NA, "zone", "made", "points"
    )
  ),
  lead_tracker = .acb_ft(
    c(
      "match_id", "edition_id", "season", "quarter", "minute", "second", "clock_seconds", "home_score",
      "away_score", "margin"
    ),
    "iiiiiiiiii",
    c(
      NA, NA, NA, "quarter", "minute", "second", NA, "home", "away", NA
    )
  ),
  lead_stats = .acb_ft(
    c(
      "match_id", "stat", "side", "value", "bar_progress", "is_highlighted"
    ),
    "isssfb",
    c(
      NA, NA, NA, "title", "progress", "isBarHighLighted"
    )
  ),
  lineup = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr",
      "lineup_order", "player_id", "player_name", "short_name", "shirt_number", "play_time", "seconds_played",
      "is_playing", "points", "rebounds", "assists", "fouls", "differential", "rating"
    ),
    "iiisiissiissssmbiiiiii",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, "id", "nickname", "firstInitialAndLastName", "shirtNumber",
      "playtime", "playtime", "isPlaying", "points", "rebounds", "assists", "fouls", "differential", "rating"
    )
  ),
  team_comparison = .acb_ft(
    c(
      "match_id", "quarter", "stat", "home_value", "away_value", "home_made", "home_attempted", "away_made",
      "away_attempted", "home_is_highlighted", "away_is_highlighted"
    ),
    "iisppiiiibb",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
    )
  ),
  serie = .acb_ft(
    c(
      "requested_match_id", "phase_id", "subphase_id", "series_home_team_id", "series_home_club_id",
      "series_away_team_id", "series_away_club_id", "series_home_wins", "series_away_wins", "series_finished",
      "best_of", "edition_id", "season", "match_id", "home_team_id", "away_team_id", "home_score",
      "away_score", "start", "status", "is_on_half_time", "current_quarter"
    ),
    "iiiiiiiiibiiiiiiiitsbi",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "id", "homeTeamId", "awayTeamId", "homeScore",
      "awayScore", "startDateTime", "matchStatus", "isOnHalfTime", "currentQuarter"
    )
  ),
  quickfacts = .acb_ft(
    c(
      "match_id", "team_side", "team_id", "club_id", "team", "team_abbr", "edition_id", "season", "standing",
      "wins", "losses", "last_results"
    ),
    "isiissiiiiij",
    c(
      NA, NA, "team.id", "team.clubId", "team.fullName", "team.abbreviatedName", "team.editionId", NA,
      "standing", "currentWins", "currentLoses", "lastResults"
    )
  ),
  match_advanced_stats = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr", "group",
      "stat", "match_value", "season_value", "win_value", "loss_value", "season_diff", "win_diff",
      "loss_diff"
    ),
    "iiisiissssfffffff",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "partido", "temporada", "win", "loss", "temporadaDiff",
      "winDiff", "lossDiff"
    )
  ),
  matchlist = .acb_ft(
    c(
      "match_id", "round_type", "round_id", "round_number", "group_id", "subphase_id", "subphase_number",
      "week_id", "status", "is_on_half_time", "current_quarter", "home_score", "away_score", "start",
      "home_wins", "home_losses", "away_wins", "away_losses", "home_team_id", "home_club_id", "home_team",
      "home_team_abbr", "away_team_id", "away_club_id", "away_team", "away_team_abbr", "competition_id",
      "edition_id", "season", "is_selected_local", "match_grouping"
    ),
    "isiiiiiisbiiitiiiiiissiissiiibs",
    c(
      "id", "roundType", "roundId", "roundNumber", "groupId", "subphaseId", "subphaseNumber", "weekId",
      "matchStatus", "isOnHalfTime", "currentQuarter", "homeScore", "awayScore", "startDateTime",
      "homeCurrentWins", "homeCurrentLosses", "awayCurrentWins", "awayCurrentLosses", "homeTeam.id",
      "homeTeam.clubId", "homeTeam.fullName", "homeTeam.abbreviatedName", "awayTeam.id", "awayTeam.clubId",
      "awayTeam.fullName", "awayTeam.abbreviatedName", "homeTeam.competitionId", "homeTeam.editionId", NA,
      "isSelectedLocal", NA
    )
  ),
  competition_editions = .acb_ft(
    c(
      "competition_id", "competition_name", "edition_id", "season_start_year", "season", "n_rounds",
      "n_weeks"
    ),
    "isiiiii",
    c(
      NA, NA, "id", "seasonStartYear", "seasonEndYear", NA, NA
    )
  ),
  competition_rounds = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "round_id", "round_number", "subphase_id", "subphase_number"
    ),
    "iiiiiii",
    c(
      NA, NA, NA, "id", "roundNumber", "subphaseId", "subphaseNumber"
    )
  ),
  competition_weeks = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "week_id", "description", "start_date"
    ),
    "iiiist",
    c(
      NA, NA, NA, "id", "description", "startDate"
    )
  ),
  competition_current = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "week_id", "round_id", "match_grouping", "match_id", "status",
      "start", "home_team_id", "home_club_id", "home_team", "home_team_abbr", "away_team_id", "away_club_id",
      "away_team", "away_team_abbr"
    ),
    "iiiiisistiissiiss",
    c(
      "currentCompetitionId", "currentEditionId", NA, "currentWeekId", "currentRoundId",
      "currentMatchGrouping", "currentMatch.id", "currentMatch.matchStatus", "currentMatch.startDateTime",
      "currentMatch.homeTeam.id", "currentMatch.homeTeam.clubId", "currentMatch.homeTeam.fullName",
      "currentMatch.homeTeam.abbreviatedName", "currentMatch.awayTeam.id", "currentMatch.awayTeam.clubId",
      "currentMatch.awayTeam.fullName", "currentMatch.awayTeam.abbreviatedName"
    )
  ),
  round_matches = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "round_id", "round_number", "subphase_id", "subphase_number",
      "week_id", "match_id", "home_team_id", "away_team_id", "home_score", "away_score", "start", "status",
      "is_on_half_time", "current_quarter", "home_club_id", "home_team", "home_team_abbr", "away_club_id",
      "away_team", "away_team_abbr", "ticketing_link", "broadcasters"
    ),
    "iiiiiiiiiiiiitsbiississsj",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, "id", "homeTeamId", "awayTeamId", "homeScore", "awayScore",
      "startDateTime", "matchStatus", "isOnHalfTime", "currentQuarter", NA, NA, NA, NA, NA, NA,
      "ticketingLink", NA
    )
  ),
  calendar = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "round_id", "round_number", "subphase_id", "subphase_number",
      "week_id", "match_id", "home_team_id", "away_team_id", "home_score", "away_score", "start", "status",
      "is_on_half_time", "current_quarter", "home_club_id", "home_team", "home_team_abbr", "away_club_id",
      "away_team", "away_team_abbr", "ticketing_link", "broadcasters"
    ),
    "iiiiiiiiiiiiitsbiississsj",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, "id", "homeTeamId", "awayTeamId", "homeScore", "awayScore",
      "startDateTime", "matchStatus", "isOnHalfTime", "currentQuarter", NA, NA, NA, NA, NA, NA,
      "ticketingLink", NA
    )
  ),
  standings = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "round_id", "total_rounds", "team_id", "club_id", "team",
      "team_abbr", "position", "position_trend", "played", "wins", "losses", "win_pct", "points_for",
      "points_against", "plus_minus", "home_wins", "home_losses", "away_wins", "away_losses"
    ),
    "iiiiiiissiiiiifiiiiiii",
    c(
      NA, NA, NA, NA, NA, "teamId", NA, NA, NA, "position", "positionTrend", "matchesPlayed", "wins", "loses",
      "winPercentage", "pointsFor", "pointsAgainst", "plusMinus", "localBalanceWins", "localBalanceLosses",
      "awayBalanceWins", "awayBalanceLosses"
    )
  ),
  standings_rounds = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "team_id", "club_id", "team", "team_abbr", "round_id",
      "round_number", "subphase_id", "subphase_number", "position", "match_id"
    ),
    "iiiiissiiiiii",
    c(
      NA, NA, NA, NA, NA, NA, NA, "roundData.id", "roundData.roundNumber", "roundData.subphaseId",
      "roundData.subphaseNumber", "position", "matchData.id"
    )
  ),
  bracket = .acb_ft(
    c(
      "stage", "phase_id", "subphase_id", "home_team_id", "home_club_id", "home_team", "home_team_abbr",
      "away_team_id", "away_club_id", "away_team", "away_team_abbr", "home_wins", "away_wins", "finished",
      "best_of", "n_games", "edition_id", "season"
    ),
    "siiiissiissiibiiii",
    c(
      NA, "phaseId", "subphaseId", "homeTeam.id", "homeTeam.clubId", "homeTeam.fullName",
      "homeTeam.abbreviatedName", "awayTeam.id", "awayTeam.clubId", "awayTeam.fullName",
      "awayTeam.abbreviatedName", "homeScore", "awayScore", "finished", "bestOf", NA, "homeTeam.editionId",
      NA
    )
  ),
  bracket_games = .acb_ft(
    c(
      "stage", "phase_id", "subphase_id", "series_home_team_id", "series_home_club_id", "series_away_team_id",
      "series_away_club_id", "series_home_wins", "series_away_wins", "series_finished", "best_of",
      "edition_id", "season", "match_id", "home_team_id", "away_team_id", "home_score", "away_score", "start",
      "status", "is_on_half_time", "current_quarter"
    ),
    "siiiiiiiibiiiiiiiitsbi",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "id", "homeTeamId", "awayTeamId", "homeScore",
      "awayScore", "startDateTime", "matchStatus", "isOnHalfTime", "currentQuarter"
    )
  ),
  league_zones = .acb_ft(
    c(
      "competition_id", "edition_id", "season", "phase_id", "zone", "attempts", "made", "points_scored"
    ),
    "iiiisiii",
    c(
      NA, NA, NA, NA, "zone", "attempts", "made", "pointsScored"
    )
  ),
  teams = .acb_ft(
    c(
      "team_id", "club_id", "team", "team_abbr", "competition_id", "edition_id", "season", "latest_team_id",
      "latest_team"
    ),
    "iissiiiis",
    c(
      "selected.id", "selected.clubId", "selected.fullName", "selected.abbreviatedName",
      "selected.competitionId", "selected.editionId", NA, "latest.id", "latest.fullName"
    )
  ),
  club_data = .acb_ft(
    c(
      "team_id", "club_id", "team", "team_abbr", "competition_id", "edition_id", "season", "stadium_name",
      "stadium_address", "stadium_capacity", "president", "foundation_year", "web_url", "ticketing_url",
      "merchandising_url", "instagram_url", "twitter_url", "facebook_url", "youtube_url", "tiktok_url",
      "validated", "temporary_roster"
    ),
    "iissiiissisissssssssbb",
    c(
      "team.id", "team.clubId", "team.fullName", "team.abbreviatedName", "team.competitionId",
      "team.editionId", NA, "stadiumName", "stadiumAddress", "stadiumCapacity", "presidentName",
      "foundationYear", "webUrl", "ticketingUrl", "merchanUrl", "instagramUrl", "twitterUrl", "facebookUrl",
      "youtubeUrl", "tikTokUrl", "validated", "temporaryRoster"
    )
  ),
  current_roster = .acb_ft(
    c(
      "club_id", "role", "person_id", "person_name", "first_name", "last_name", "shirt_number", "game_role",
      "licensing", "age", "nationality", "nationality_iso", "height_cm", "is_license_active", "edition_id",
      "season", "temporary_roster"
    ),
    "isissssssissibiib",
    c(
      NA, NA, "person.id", "person.nickname", "person.firstName", "person.lastName", "person.shirtNumber",
      "person.gameRole", "licensing", "age", "nationalityCountry", NA, "height", "isLicenseActive",
      "person.editionId", NA, NA
    )
  ),
  team_leaders = .acb_ft(
    c(
      "club_id", "competition_id", "edition_id", "season", "scope", "metric", "rank", "value", "player_id",
      "player_name", "first_name", "last_name", "shirt_number", "game_role"
    ),
    "iiiissifisssss",
    c(
      NA, NA, NA, NA, NA, NA, NA, "value", "player.id", "player.nickname", "player.firstName",
      "player.lastName", "player.shirtNumber", "player.gameRole"
    )
  ),
  team_stats = .acb_ft(
    c(
      "club_id", "team_id", "edition_id", "season", "player_id", "player_name", "first_name", "last_name",
      "shirt_number", "game_role", "total_num_games", "total_time_played", "total_starter", "total_points",
      "total_max_points", "total_three_pointers_made", "total_three_pointers_attempted",
      "total_three_pointers_percentage", "total_two_pointers_made", "total_two_pointers_attempted",
      "total_two_pointers_percentage", "total_free_throws_made", "total_free_throws_attempted",
      "total_free_throws_percentage", "total_rebounds", "total_offensive_rebounds",
      "total_defensive_rebounds", "total_assists", "total_steals", "total_turnovers", "total_blocks",
      "total_shots_rejected", "total_dunks", "total_personal_fouls", "total_fouls_received", "total_rating",
      "total_plus_minus", "total_wins", "total_losses", "avg_num_games", "avg_time_played", "avg_starter",
      "avg_points", "avg_max_points", "avg_three_pointers_made", "avg_three_pointers_attempted",
      "avg_three_pointers_percentage", "avg_two_pointers_made", "avg_two_pointers_attempted",
      "avg_two_pointers_percentage", "avg_free_throws_made", "avg_free_throws_attempted",
      "avg_free_throws_percentage", "avg_rebounds", "avg_offensive_rebounds", "avg_defensive_rebounds",
      "avg_assists", "avg_steals", "avg_turnovers", "avg_blocks", "avg_shots_rejected", "avg_dunks",
      "avg_personal_fouls", "avg_fouls_received", "avg_rating", "avg_plus_minus", "avg_wins", "avg_losses",
      "per40_num_games", "per40_time_played", "per40_starter", "per40_points", "per40_max_points",
      "per40_three_pointers_made", "per40_three_pointers_attempted", "per40_three_pointers_percentage",
      "per40_two_pointers_made", "per40_two_pointers_attempted", "per40_two_pointers_percentage",
      "per40_free_throws_made", "per40_free_throws_attempted", "per40_free_throws_percentage",
      "per40_rebounds", "per40_offensive_rebounds", "per40_defensive_rebounds", "per40_assists",
      "per40_steals", "per40_turnovers", "per40_blocks", "per40_shots_rejected", "per40_dunks",
      "per40_personal_fouls", "per40_fouls_received", "per40_rating", "per40_plus_minus", "per40_wins",
      "per40_losses"
    ),
    "iiiiisssssiiiiiiifiifiifiiiiiiiiiiiiiiiffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
    c(
      NA, NA, NA, NA, "player.id", "player.nickname", "player.firstName", "player.lastName",
      "player.shirtNumber", "player.gameRole", "totals.numGames", "totals.timePlayed", "totals.starter",
      "totals.points", "totals.maxPoints", "totals.threePointersMade", "totals.threePointersAttempted",
      "totals.threePointersPercentage", "totals.twoPointersMade", "totals.twoPointersAttempted",
      "totals.twoPointersPercentage", "totals.freeThrowsMade", "totals.freeThrowsAttempted",
      "totals.freeThrowsPercentage", "totals.rebounds", "totals.offensiveRebounds",
      "totals.defensiveRebounds", "totals.assists", "totals.steals", "totals.turnovers", "totals.blocks",
      "totals.shotsRejected", "totals.dunks", "totals.personalFouls", "totals.foulsReceived", "totals.rating",
      "totals.plusMinus", "totals.wins", "totals.losses", "averages.numGames", "averages.timePlayed",
      "averages.starter", "averages.points", "averages.maxPoints", "averages.threePointersMade",
      "averages.threePointersAttempted", "averages.threePointersPercentage", "averages.twoPointersMade",
      "averages.twoPointersAttempted", "averages.twoPointersPercentage", "averages.freeThrowsMade",
      "averages.freeThrowsAttempted", "averages.freeThrowsPercentage", "averages.rebounds",
      "averages.offensiveRebounds", "averages.defensiveRebounds", "averages.assists", "averages.steals",
      "averages.turnovers", "averages.blocks", "averages.shotsRejected", "averages.dunks",
      "averages.personalFouls", "averages.foulsReceived", "averages.rating", "averages.plusMinus",
      "averages.wins", "averages.losses", "per40.numGames", "per40.timePlayed", "per40.starter",
      "per40.points", "per40.maxPoints", "per40.threePointersMade", "per40.threePointersAttempted",
      "per40.threePointersPercentage", "per40.twoPointersMade", "per40.twoPointersAttempted",
      "per40.twoPointersPercentage", "per40.freeThrowsMade", "per40.freeThrowsAttempted",
      "per40.freeThrowsPercentage", "per40.rebounds", "per40.offensiveRebounds", "per40.defensiveRebounds",
      "per40.assists", "per40.steals", "per40.turnovers", "per40.blocks", "per40.shotsRejected",
      "per40.dunks", "per40.personalFouls", "per40.foulsReceived", "per40.rating", "per40.plusMinus",
      "per40.wins", "per40.losses"
    )
  ),
  team_totals = .acb_ft(
    c(
      "club_id", "team_id", "edition_id", "season", "total_num_games", "total_time_played", "total_starter",
      "total_points", "total_max_points", "total_three_pointers_made", "total_three_pointers_attempted",
      "total_three_pointers_percentage", "total_two_pointers_made", "total_two_pointers_attempted",
      "total_two_pointers_percentage", "total_free_throws_made", "total_free_throws_attempted",
      "total_free_throws_percentage", "total_rebounds", "total_offensive_rebounds",
      "total_defensive_rebounds", "total_assists", "total_steals", "total_turnovers", "total_blocks",
      "total_shots_rejected", "total_dunks", "total_personal_fouls", "total_fouls_received", "total_rating",
      "total_plus_minus", "total_wins", "total_losses", "avg_num_games", "avg_time_played", "avg_starter",
      "avg_points", "avg_max_points", "avg_three_pointers_made", "avg_three_pointers_attempted",
      "avg_three_pointers_percentage", "avg_two_pointers_made", "avg_two_pointers_attempted",
      "avg_two_pointers_percentage", "avg_free_throws_made", "avg_free_throws_attempted",
      "avg_free_throws_percentage", "avg_rebounds", "avg_offensive_rebounds", "avg_defensive_rebounds",
      "avg_assists", "avg_steals", "avg_turnovers", "avg_blocks", "avg_shots_rejected", "avg_dunks",
      "avg_personal_fouls", "avg_fouls_received", "avg_rating", "avg_plus_minus", "avg_wins", "avg_losses",
      "per40_num_games", "per40_time_played", "per40_starter", "per40_points", "per40_max_points",
      "per40_three_pointers_made", "per40_three_pointers_attempted", "per40_three_pointers_percentage",
      "per40_two_pointers_made", "per40_two_pointers_attempted", "per40_two_pointers_percentage",
      "per40_free_throws_made", "per40_free_throws_attempted", "per40_free_throws_percentage",
      "per40_rebounds", "per40_offensive_rebounds", "per40_defensive_rebounds", "per40_assists",
      "per40_steals", "per40_turnovers", "per40_blocks", "per40_shots_rejected", "per40_dunks",
      "per40_personal_fouls", "per40_fouls_received", "per40_rating", "per40_plus_minus", "per40_wins",
      "per40_losses"
    ),
    "iiiiiiiiiiifiifiifiiiiiiiiiiiiiiiffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
    c(
      NA, "teamEditionId", NA, NA, "totals.numGames", "totals.timePlayed", "totals.starter", "totals.points",
      "totals.maxPoints", "totals.threePointersMade", "totals.threePointersAttempted",
      "totals.threePointersPercentage", "totals.twoPointersMade", "totals.twoPointersAttempted",
      "totals.twoPointersPercentage", "totals.freeThrowsMade", "totals.freeThrowsAttempted",
      "totals.freeThrowsPercentage", "totals.rebounds", "totals.offensiveRebounds",
      "totals.defensiveRebounds", "totals.assists", "totals.steals", "totals.turnovers", "totals.blocks",
      "totals.shotsRejected", "totals.dunks", "totals.personalFouls", "totals.foulsReceived", "totals.rating",
      "totals.plusMinus", "totals.wins", "totals.losses", "averages.numGames", "averages.timePlayed",
      "averages.starter", "averages.points", "averages.maxPoints", "averages.threePointersMade",
      "averages.threePointersAttempted", "averages.threePointersPercentage", "averages.twoPointersMade",
      "averages.twoPointersAttempted", "averages.twoPointersPercentage", "averages.freeThrowsMade",
      "averages.freeThrowsAttempted", "averages.freeThrowsPercentage", "averages.rebounds",
      "averages.offensiveRebounds", "averages.defensiveRebounds", "averages.assists", "averages.steals",
      "averages.turnovers", "averages.blocks", "averages.shotsRejected", "averages.dunks",
      "averages.personalFouls", "averages.foulsReceived", "averages.rating", "averages.plusMinus",
      "averages.wins", "averages.losses", "per40.numGames", "per40.timePlayed", "per40.starter",
      "per40.points", "per40.maxPoints", "per40.threePointersMade", "per40.threePointersAttempted",
      "per40.threePointersPercentage", "per40.twoPointersMade", "per40.twoPointersAttempted",
      "per40.twoPointersPercentage", "per40.freeThrowsMade", "per40.freeThrowsAttempted",
      "per40.freeThrowsPercentage", "per40.rebounds", "per40.offensiveRebounds", "per40.defensiveRebounds",
      "per40.assists", "per40.steals", "per40.turnovers", "per40.blocks", "per40.shotsRejected",
      "per40.dunks", "per40.personalFouls", "per40.foulsReceived", "per40.rating", "per40.plusMinus",
      "per40.wins", "per40.losses"
    )
  ),
  team_records = .acb_ft(
    c(
      "club_id", "stat", "value", "game_id", "game_date", "player_id", "player_name", "first_name",
      "last_name", "shirt_number", "game_role", "local_team_id", "local_club_id", "local_team",
      "local_team_abbr", "visitor_team_id", "visitor_club_id", "visitor_team", "visitor_team_abbr"
    ),
    "isfitisssssiissiiss",
    c(
      NA, NA, "value", "gameId", "gameDate", "player.id", "player.nickname", "player.firstName",
      "player.lastName", "player.shirtNumber", "player.gameRole", "localTeam.id", "localTeam.clubId",
      "localTeam.fullName", "localTeam.abbreviatedName", "visitorTeam.id", "visitorTeam.clubId",
      "visitorTeam.fullName", "visitorTeam.abbreviatedName"
    )
  ),
  player_data = .acb_ft(
    c(
      "player_id", "player_name", "first_name", "last_name", "shirt_number", "game_role", "is_license_active",
      "licensing", "birth_date", "birth_place", "birth_country", "birth_country_iso", "nationality",
      "nationality_iso", "height_m", "player_number", "team_id", "club_id", "team", "team_abbr", "edition_id",
      "season", "instagram", "twitter", "facebook", "youtube", "tiktok", "pronunciation_url"
    ),
    "isssssbsdsssssfiiissiissssss",
    c(
      "player.id", "player.nickname", "player.firstName", "player.lastName", "player.shirtNumber",
      "player.gameRole", "isLicenseActive", "licensing", "birthDate", "birthPlace", "birthCountry", NA,
      "nationality", NA, "height", "playerNumber", "currentTeam.id", "currentTeam.clubId",
      "currentTeam.fullName", "currentTeam.abbreviatedName", "player.editionId", NA, "instagram", "twitter",
      "facebook", "youtube", "tiktok", "pronunciationUrl"
    )
  ),
  player_stats = .acb_ft(
    c(
      "player_id", "team_id", "competition_id", "edition_id", "season", "edition_year", "club_id", "team",
      "team_abbr", "total_num_games", "total_time_played", "total_starter", "total_points",
      "total_max_points", "total_three_pointers_made", "total_three_pointers_attempted",
      "total_three_pointers_percentage", "total_two_pointers_made", "total_two_pointers_attempted",
      "total_two_pointers_percentage", "total_free_throws_made", "total_free_throws_attempted",
      "total_free_throws_percentage", "total_rebounds", "total_offensive_rebounds",
      "total_defensive_rebounds", "total_assists", "total_steals", "total_turnovers", "total_blocks",
      "total_shots_rejected", "total_dunks", "total_personal_fouls", "total_fouls_received", "total_rating",
      "total_plus_minus", "total_wins", "total_losses", "avg_num_games", "avg_time_played", "avg_starter",
      "avg_points", "avg_max_points", "avg_three_pointers_made", "avg_three_pointers_attempted",
      "avg_three_pointers_percentage", "avg_two_pointers_made", "avg_two_pointers_attempted",
      "avg_two_pointers_percentage", "avg_free_throws_made", "avg_free_throws_attempted",
      "avg_free_throws_percentage", "avg_rebounds", "avg_offensive_rebounds", "avg_defensive_rebounds",
      "avg_assists", "avg_steals", "avg_turnovers", "avg_blocks", "avg_shots_rejected", "avg_dunks",
      "avg_personal_fouls", "avg_fouls_received", "avg_rating", "avg_plus_minus", "avg_wins", "avg_losses",
      "per40_num_games", "per40_time_played", "per40_starter", "per40_points", "per40_max_points",
      "per40_three_pointers_made", "per40_three_pointers_attempted", "per40_three_pointers_percentage",
      "per40_two_pointers_made", "per40_two_pointers_attempted", "per40_two_pointers_percentage",
      "per40_free_throws_made", "per40_free_throws_attempted", "per40_free_throws_percentage",
      "per40_rebounds", "per40_offensive_rebounds", "per40_defensive_rebounds", "per40_assists",
      "per40_steals", "per40_turnovers", "per40_blocks", "per40_shots_rejected", "per40_dunks",
      "per40_personal_fouls", "per40_fouls_received", "per40_rating", "per40_plus_minus", "per40_wins",
      "per40_losses"
    ),
    "iiiiisissiiiiiiifiifiifiiiiiiiiiiiiiiiffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
    c(
      NA, "teamEditionId", "competitionId", "editionId", NA, "editionYear", "team.selected.clubId",
      "team.selected.fullName", "team.selected.abbreviatedName", "totals.numGames", "totals.timePlayed",
      "totals.starter", "totals.points", "totals.maxPoints", "totals.threePointersMade",
      "totals.threePointersAttempted", "totals.threePointersPercentage", "totals.twoPointersMade",
      "totals.twoPointersAttempted", "totals.twoPointersPercentage", "totals.freeThrowsMade",
      "totals.freeThrowsAttempted", "totals.freeThrowsPercentage", "totals.rebounds",
      "totals.offensiveRebounds", "totals.defensiveRebounds", "totals.assists", "totals.steals",
      "totals.turnovers", "totals.blocks", "totals.shotsRejected", "totals.dunks", "totals.personalFouls",
      "totals.foulsReceived", "totals.rating", "totals.plusMinus", "totals.wins", "totals.losses",
      "averages.numGames", "averages.timePlayed", "averages.starter", "averages.points", "averages.maxPoints",
      "averages.threePointersMade", "averages.threePointersAttempted", "averages.threePointersPercentage",
      "averages.twoPointersMade", "averages.twoPointersAttempted", "averages.twoPointersPercentage",
      "averages.freeThrowsMade", "averages.freeThrowsAttempted", "averages.freeThrowsPercentage",
      "averages.rebounds", "averages.offensiveRebounds", "averages.defensiveRebounds", "averages.assists",
      "averages.steals", "averages.turnovers", "averages.blocks", "averages.shotsRejected", "averages.dunks",
      "averages.personalFouls", "averages.foulsReceived", "averages.rating", "averages.plusMinus",
      "averages.wins", "averages.losses", "per40.numGames", "per40.timePlayed", "per40.starter",
      "per40.points", "per40.maxPoints", "per40.threePointersMade", "per40.threePointersAttempted",
      "per40.threePointersPercentage", "per40.twoPointersMade", "per40.twoPointersAttempted",
      "per40.twoPointersPercentage", "per40.freeThrowsMade", "per40.freeThrowsAttempted",
      "per40.freeThrowsPercentage", "per40.rebounds", "per40.offensiveRebounds", "per40.defensiveRebounds",
      "per40.assists", "per40.steals", "per40.turnovers", "per40.blocks", "per40.shotsRejected",
      "per40.dunks", "per40.personalFouls", "per40.foulsReceived", "per40.rating", "per40.plusMinus",
      "per40.wins", "per40.losses"
    )
  ),
  player_totals = .acb_ft(
    c(
      "player_id", "player_name", "first_name", "last_name", "shirt_number", "game_role", "total_num_games",
      "total_time_played", "total_starter", "total_points", "total_max_points", "total_three_pointers_made",
      "total_three_pointers_attempted", "total_three_pointers_percentage", "total_two_pointers_made",
      "total_two_pointers_attempted", "total_two_pointers_percentage", "total_free_throws_made",
      "total_free_throws_attempted", "total_free_throws_percentage", "total_rebounds",
      "total_offensive_rebounds", "total_defensive_rebounds", "total_assists", "total_steals",
      "total_turnovers", "total_blocks", "total_shots_rejected", "total_dunks", "total_personal_fouls",
      "total_fouls_received", "total_rating", "total_plus_minus", "total_wins", "total_losses",
      "avg_num_games", "avg_time_played", "avg_starter", "avg_points", "avg_max_points",
      "avg_three_pointers_made", "avg_three_pointers_attempted", "avg_three_pointers_percentage",
      "avg_two_pointers_made", "avg_two_pointers_attempted", "avg_two_pointers_percentage",
      "avg_free_throws_made", "avg_free_throws_attempted", "avg_free_throws_percentage", "avg_rebounds",
      "avg_offensive_rebounds", "avg_defensive_rebounds", "avg_assists", "avg_steals", "avg_turnovers",
      "avg_blocks", "avg_shots_rejected", "avg_dunks", "avg_personal_fouls", "avg_fouls_received",
      "avg_rating", "avg_plus_minus", "avg_wins", "avg_losses", "per40_num_games", "per40_time_played",
      "per40_starter", "per40_points", "per40_max_points", "per40_three_pointers_made",
      "per40_three_pointers_attempted", "per40_three_pointers_percentage", "per40_two_pointers_made",
      "per40_two_pointers_attempted", "per40_two_pointers_percentage", "per40_free_throws_made",
      "per40_free_throws_attempted", "per40_free_throws_percentage", "per40_rebounds",
      "per40_offensive_rebounds", "per40_defensive_rebounds", "per40_assists", "per40_steals",
      "per40_turnovers", "per40_blocks", "per40_shots_rejected", "per40_dunks", "per40_personal_fouls",
      "per40_fouls_received", "per40_rating", "per40_plus_minus", "per40_wins", "per40_losses"
    ),
    "isssssiiiiiiifiifiifiiiiiiiiiiiiiiiffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
    c(
      "player.id", "player.nickname", "player.firstName", "player.lastName", "player.shirtNumber",
      "player.gameRole", "totals.numGames", "totals.timePlayed", "totals.starter", "totals.points",
      "totals.maxPoints", "totals.threePointersMade", "totals.threePointersAttempted",
      "totals.threePointersPercentage", "totals.twoPointersMade", "totals.twoPointersAttempted",
      "totals.twoPointersPercentage", "totals.freeThrowsMade", "totals.freeThrowsAttempted",
      "totals.freeThrowsPercentage", "totals.rebounds", "totals.offensiveRebounds",
      "totals.defensiveRebounds", "totals.assists", "totals.steals", "totals.turnovers", "totals.blocks",
      "totals.shotsRejected", "totals.dunks", "totals.personalFouls", "totals.foulsReceived", "totals.rating",
      "totals.plusMinus", "totals.wins", "totals.losses", "averages.numGames", "averages.timePlayed",
      "averages.starter", "averages.points", "averages.maxPoints", "averages.threePointersMade",
      "averages.threePointersAttempted", "averages.threePointersPercentage", "averages.twoPointersMade",
      "averages.twoPointersAttempted", "averages.twoPointersPercentage", "averages.freeThrowsMade",
      "averages.freeThrowsAttempted", "averages.freeThrowsPercentage", "averages.rebounds",
      "averages.offensiveRebounds", "averages.defensiveRebounds", "averages.assists", "averages.steals",
      "averages.turnovers", "averages.blocks", "averages.shotsRejected", "averages.dunks",
      "averages.personalFouls", "averages.foulsReceived", "averages.rating", "averages.plusMinus",
      "averages.wins", "averages.losses", "per40.numGames", "per40.timePlayed", "per40.starter",
      "per40.points", "per40.maxPoints", "per40.threePointersMade", "per40.threePointersAttempted",
      "per40.threePointersPercentage", "per40.twoPointersMade", "per40.twoPointersAttempted",
      "per40.twoPointersPercentage", "per40.freeThrowsMade", "per40.freeThrowsAttempted",
      "per40.freeThrowsPercentage", "per40.rebounds", "per40.offensiveRebounds", "per40.defensiveRebounds",
      "per40.assists", "per40.steals", "per40.turnovers", "per40.blocks", "per40.shotsRejected",
      "per40.dunks", "per40.personalFouls", "per40.foulsReceived", "per40.rating", "per40.plusMinus",
      "per40.wins", "per40.losses"
    )
  ),
  career_stints = .acb_ft(
    c(
      "player_id", "initial_year", "end_year", "team_id", "club_id", "team", "team_abbr", "edition_id",
      "n_editions", "has_no_validated_data"
    ),
    "iiiiissiib",
    c(
      NA, "initialYear", "endYear", "team.id", "team.clubId", "team.fullName", "team.abbreviatedName",
      "team.editionId", NA, "hasNoValidatedData"
    )
  ),
  career_trophies = .acb_ft(
    c(
      "player_id", "competition_id", "times_champion", "times_runner_up"
    ),
    "iiii",
    c(
      NA, "competitionId", "timesChampion", "timesRunnerUp"
    )
  ),
  player_matches = .acb_ft(
    c(
      "player_id", "match_id", "round_type", "round_number", "date", "home_team_id", "home_club_id",
      "home_team", "home_team_abbr", "away_team_id", "away_club_id", "away_team", "away_team_abbr",
      "edition_id", "season", "is_selected_local", "has_won", "play_time", "seconds_played", "points",
      "three_pointers_made", "three_pointers_attempted", "three_pointers_percentage", "two_pointers_made",
      "two_pointers_attempted", "two_pointers_percentage", "free_throws_made", "free_throws_attempted",
      "free_throws_percentage", "rebounds", "offensive_rebounds", "defensive_rebounds", "assists", "steals",
      "turnovers", "blocks", "shots_rejected", "dunks", "personal_fouls", "fouls_received", "rating",
      "plus_minus"
    ),
    "iisitiissiissiibbsmiiifiifiifiiiiiiiiiiiii",
    c(
      NA, "id", "roundType", "roundNumber", "date", "homeTeam.id", "homeTeam.clubId", "homeTeam.fullName",
      "homeTeam.abbreviatedName", "awayTeam.id", "awayTeam.clubId", "awayTeam.fullName",
      "awayTeam.abbreviatedName", "homeTeam.editionId", NA, "isSelectedLocal", "hasWon", "stats.timePlayed",
      "stats.timePlayed", "stats.points", "stats.threePointersMade", "stats.threePointersAttempted",
      "stats.threePointersPercentage", "stats.twoPointersMade", "stats.twoPointersAttempted",
      "stats.twoPointersPercentage", "stats.freeThrowsMade", "stats.freeThrowsAttempted",
      "stats.freeThrowsPercentage", "stats.rebounds", "stats.offensiveRebounds", "stats.defensiveRebounds",
      "stats.assists", "stats.steals", "stats.turnovers", "stats.blocks", "stats.shotsRejected",
      "stats.dunks", "stats.personalFouls", "stats.foulsReceived", "stats.rating", "stats.plusMinus"
    )
  ),
  search = .acb_ft(
    c(
      "kind", "person_id", "name", "short_name", "first_name", "last_name", "shirt_number", "game_role",
      "is_license_active", "club_id", "edition_id", "season"
    ),
    "sissssssbiii",
    c(
      NA, "id", NA, "firstInitialAndLastName", "firstName", "lastName", "shirtNumber", "gameRole",
      "isLicenseActive", "clubId", "editionId", NA
    )
  ),
  match_leaders = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr", "metric",
      "rank", "value", "player_id", "player_name", "first_name", "last_name", "shirt_number", "game_role"
    ),
    "iiisiisssifisssss",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "value", "player.id", "player.nickname", "player.firstName",
      "player.lastName", "player.shirtNumber", "player.gameRole"
    )
  ),
  season_leaders = .acb_ft(
    c(
      "match_id", "edition_id", "season", "team_side", "team_id", "club_id", "team", "team_abbr", "metric",
      "rank", "value", "player_id", "player_name", "first_name", "last_name", "shirt_number", "game_role"
    ),
    "iiisiisssifisssss",
    c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "value", "player.id", "player.nickname", "player.firstName",
      "player.lastName", "player.shirtNumber", "player.gameRole"
    )
  ),
  next_matches = .acb_ft(
    c(
      "match_id", "round_type", "round_id", "round_number", "group_id", "subphase_id", "subphase_number",
      "week_id", "status", "is_on_half_time", "current_quarter", "home_score", "away_score", "start",
      "home_wins", "home_losses", "away_wins", "away_losses", "home_team_id", "home_club_id", "home_team",
      "home_team_abbr", "away_team_id", "away_club_id", "away_team", "away_team_abbr", "competition_id",
      "edition_id", "season", "is_selected_local"
    ),
    "isiiiiiisbiiitiiiiiissiissiiib",
    c(
      "id", "roundType", "roundId", "roundNumber", "groupId", "subphaseId", "subphaseNumber", "weekId",
      "matchStatus", "isOnHalfTime", "currentQuarter", "homeScore", "awayScore", "startDateTime",
      "homeCurrentWins", "homeCurrentLosses", "awayCurrentWins", "awayCurrentLosses", "homeTeam.id",
      "homeTeam.clubId", "homeTeam.fullName", "homeTeam.abbreviatedName", "awayTeam.id", "awayTeam.clubId",
      "awayTeam.fullName", "awayTeam.abbreviatedName", "homeTeam.competitionId", "homeTeam.editionId", NA,
      "isSelectedLocal"
    )
  ),
  team_matches = .acb_ft(
    c(
      "match_id", "round_type", "round_id", "round_number", "group_id", "subphase_id", "subphase_number",
      "week_id", "status", "is_on_half_time", "current_quarter", "home_score", "away_score", "start",
      "home_wins", "home_losses", "away_wins", "away_losses", "home_team_id", "home_club_id", "home_team",
      "home_team_abbr", "away_team_id", "away_club_id", "away_team", "away_team_abbr", "competition_id",
      "edition_id", "season", "is_selected_local"
    ),
    "isiiiiiisbiiitiiiiiissiissiiib",
    c(
      "id", "roundType", "roundId", "roundNumber", "groupId", "subphaseId", "subphaseNumber", "weekId",
      "matchStatus", "isOnHalfTime", "currentQuarter", "homeScore", "awayScore", "startDateTime",
      "homeCurrentWins", "homeCurrentLosses", "awayCurrentWins", "awayCurrentLosses", "homeTeam.id",
      "homeTeam.clubId", "homeTeam.fullName", "homeTeam.abbreviatedName", "awayTeam.id", "awayTeam.clubId",
      "awayTeam.fullName", "awayTeam.abbreviatedName", "homeTeam.competitionId", "homeTeam.editionId", NA,
      "isSelectedLocal"
    )
  ),
  player_advanced_stats = .acb_ft(
    c(
      "match_id", "player_id", "group", "stat", "match_value", "season_value", "win_value", "loss_value",
      "season_diff", "win_diff", "loss_diff"
    ),
    "iissfffffff",
    c(
      NA, NA, NA, NA, "partido", "temporada", "win", "loss", "temporadaDiff", "winDiff", "lossDiff"
    )
  )
)

#' Play-by-play / shot `playType` names (sdv-py `acb_codes.PLAY_TYPES`).
#' @noRd
.acb_play_types <- c(
  `92` = "FREE_THROW_MADE",
  `93` = "TWO_POINTER_MADE",
  `94` = "THREE_POINTER_MADE",
  `96` = "FREE_THROW_MISSED",
  `97` = "TWO_POINTER_MISSED",
  `98` = "THREE_POINTER_MISSED",
  `100` = "DUNK",
  `101` = "OFFENSIVE_REBOUND",
  `102` = "BLOCK",
  `103` = "STEAL",
  `104` = "DEFENSIVE_REBOUND",
  `105` = "BLOCK_RECEIVED",
  `106` = "TURNOVER",
  `107` = "ASSIST_TWO_POINTS_SHOT",
  `108` = "ASSIST_THREE_POINTS_SHOT",
  `109` = "OFFENSIVE_FOUL",
  `110` = "FOUL_RECEIVED",
  `112` = "SUBSTITUTION_IN",
  `113` = "TIMEOUT",
  `115` = "SUBSTITUTION_OUT",
  `116` = "END_OF_QUARTER",
  `118` = "TIMEOUT_TV",
  `119` = "ASSIST_FOUL_RECEIVED",
  `121` = "START_OF_QUARTER",
  `122` = "START_OF_GAME",
  `123` = "END_OF_GAME",
  `130` = "FAST_BREAK_TWO_POINTS",
  `131` = "FAST_BREAK_THREE_POINTS",
  `159` = "FOUL_NO_FREE_THROW",
  `160` = "FOUL_ONE_FREE_THROW",
  `161` = "FOUL_TWO_FREE_THROW",
  `162` = "PERSONAL_FOUL_THREE_FREE_THROW",
  `163` = "DOUBLE_PERSONAL_FOUL_NO_FREE_THROW",
  `164` = "PERSONAL_FOUL_NO_TEAM_FOUL",
  `165` = "UNSPORTSMANLIKE_FOUL_ONE_FREE_THROW",
  `166` = "UNSPORTSMANLIKE_FOUL_TWO_FREE_THROW",
  `167` = "UNSPORTSMANLIKE_FOUL_THREE_FREE_THROW",
  `168` = "UNSPORTSMANLIKE_FOUL_DOUBLE_NO_FREE_THROW",
  `169` = "UNSPORTSMANLIKE_FOUL_NO_TEAM_FOUL",
  `170` = "DISQUALIFYING_FOUL",
  `171` = "DISQUALIFYING_FOUL_NO_TEAM_FOUL",
  `172` = "TECHNICAL_FOUL",
  `173` = "DOUBLE_TECHNICAL_FOUL_NO_FREE_THROW",
  `174` = "TECHNICAL_FOUL_NO_TEAM_FOUL",
  `175` = "FIGHT",
  `176` = "TECHNICAL_FOUL_COACH",
  `177` = "TECHNICAL_FOUL_BENCH",
  `178` = "WON_JUMP",
  `179` = "LOST_JUMP",
  `200` = "GAME_DISQUALIFYING",
  `405` = "INSTANT_REPLAY",
  `406` = "IR_REVIEW_CHANGED_SHOT_TYPE",
  `407` = "IR_REVIEW_SHOT_VALIDITY",
  `408` = "IR_REVIEW_POSSESSION_CLOCK",
  `409` = "IR_REVIEW_MATCH_CLOCK",
  `410` = "IR_REVIEW_FIGHT",
  `411` = "IR_REVIEW_FOUL_TYPE",
  `412` = "IR_REVIEW_RULE_VIOLATION",
  `413` = "IR_REVIEW_LAST_PLAYED_TOUCH",
  `414` = "IR_REVIEW_PLAYER_ACTION",
  `415` = "IR_REVIEW_SUBSTITUTION",
  `416` = "IR_CHALLENGE_HOME_COACH",
  `417` = "IR_CHALLENGE_AWAY_COACH",
  `533` = "DUNK_MISSED",
  `537` = "FOUL_TECHNICAL_ONE_FREE_THROW",
  `538` = "FOUL_TECHNICAL_TWO_FREE_THROW",
  `539` = "FOUL_TECHNICAL_THREE_FREE_THROW",
  `540` = "TECHNICAL_FOUL_COACH_ONE_FREE_TRHOW",
  `541` = "TECNHICAL_FOUL_COACH_TWO_FREE_THROW",
  `542` = "TECHNICAL_FOUL_COACH_THREE_FREE_THROW",
  `543` = "DOUBLE_TECHNICAL_FOUL_COACH_NO_FREE_THROW",
  `544` = "TECHNICAL_FOUL_BENCH_ONE_FREE_THROW",
  `545` = "TECHNICAL_FOUL_BENCH_TWO_FREE_THROW",
  `546` = "TECHNICAL_FOUL_BENCH_THREE_FREE_THROW",
  `547` = "DOUBLE_TECHNICAL_FOUL_BENCH_NO_FREE_THROW",
  `548` = "DISQUALIFYING_FOUL_ONE_FREE_THROW",
  `549` = "DISQUALIFYING_FOUL_TWO_FREE_THROW",
  `550` = "DISQUALIFYING_FOUL_THREE_FREE_THROW",
  `551` = "DISQUALIFYING_FOUL_NO_FREE_THROW",
  `552` = "FIGHT_ONE_FREE_THROW",
  `553` = "FIGHT_TWO_FREE_THROW",
  `554` = "FIGHT_THREE_FREE_THROW",
  `555` = "DOUBLE_FIGHT_NO_FREE_THROW",
  `556` = "FIGHT_NO_FREE_THROW",
  `559` = "TECHNICAL_FOUL_BENCH_NO_ACCUMULATE_ONE_FREE_THROW",
  `560` = "TECHNICAL_FOUL_BENCH_NO_ACCUMULATE_TWO_FREE_THROW",
  `561` = "TECHNICAL_FOUL_BENCH_NO_ACCUMULATE_THREE_FREE_THROW",
  `562` = "TECHNICAL_FOUL_BENCH_WITH_ACCUMULATE_DOUBLE",
  `563` = "TECHNICAL_FOUL_BENCH_NO_FREE_THROW",
  `599` = "STARTING_LINEUP",
  `748` = "IR_CHALLENGE_WON",
  `749` = "IR_CHALLENGE_LOST",
  `750` = "TECHNICAL_FOUL_BD_DISQUALIFYING_ONE_FREE_THROW",
  `751` = "TECHNICAL_FOUL_BD_DISQUALIFYING_TWO_FREE_THROW",
  `752` = "TECHNICAL_FOUL_BD_DISQUALIFYING_THREE_FREE_THROW",
  `753` = "TECHNICAL_FOUL_BD_DISQUALIFYING_THROW_IN",
  `754` = "DOUBLE_TECHNICAL_FOUL_BD_DISQUALIFYING",
  `755` = "DISRUPTIVE_FOUL_ONE_FREE_THROW",
  `756` = "DISRUPTIVE_FOUL_TWO_FREE_THROW",
  `757` = "DISRUPTIVE_FOUL_THREE_FREE_THROW",
  `758` = "DOUBLE_DISRUPTIVE_FOUL",
  `759` = "DISRUPTIVE_FOUL_NO_TEAM_FOUL",
  `760` = "FLAGRANT_FOUL_ONE_FREE_THROW",
  `761` = "FLAGRANT_FOUL_TWO_FREE_THROW",
  `762` = "FLAGRANT_FOUL_THREE_FREE_THROW",
  `763` = "DOUBLE_FLAGRANT_FOUL",
  `764` = "FLAGRANT_FOUL_NO_TEAM_FOUL",
  `765` = "TECHNICAL_FOUL_BD_ONE_FREE_THROW",
  `766` = "TECHNICAL_FOUL_BD_TWO_FREE_THROW",
  `767` = "TECHNICAL_FOUL_BD_THREE_FREE_THROW",
  `768` = "DOUBLE_TECHNICAL_FOUL_BD",
  `769` = "TECHNICAL_FOUL_BD_THROW_IN",
  `770` = "TECHNICAL_FOUL_BENCH_CAT1_ONE_FREE_THROW",
  `771` = "TECHNICAL_FOUL_BENCH_CAT1_TWO_FREE_THROW",
  `772` = "TECHNICAL_FOUL_BENCH_CAT1_THREE_FREE_THROW",
  `773` = "DOUBLE_TECHNICAL_FOUL_BENCH_CAT1",
  `774` = "TECHNICAL_FOUL_COACH_CAT1_ONE_FREE_THROW",
  `775` = "TECHNICAL_FOUL_COACH_CAT1_TWO_FREE_THROW",
  `776` = "TECHNICAL_FOUL_COACH_CAT1_THREE_FREE_THROW",
  `777` = "DOUBLE_TECHNICAL_FOUL_COACH_CAT1",
  `778` = "TECHNICAL_FOUL_CAT1_ONE_FREE_THROW",
  `779` = "TECHNICAL_FOUL_CAT1_TWO_FREE_THROW",
  `780` = "TECHNICAL_FOUL_CAT1_THREE_FREE_THROW",
  `781` = "DOUBLE_TECHNICAL_FOUL_CAT1",
  `782` = "TECHNICAL_FOUL_CAT1_NO_TEAM_FOUL",
  `783` = "TECHNICAL_FOUL_CAT2_ONE_FREE_THROW",
  `784` = "TECHNICAL_FOUL_CAT2_TWO_FREE_THROW",
  `785` = "TECHNICAL_FOUL_CAT2_THREE_FREE_THROW",
  `786` = "DOUBLE_TECHNICAL_FOUL_CAT2",
  `787` = "TECHNICAL_FOUL_CAT2_NO_TEAM_FOUL"
)

#' Turnover `playTag` names (sdv-py `acb_codes.PLAY_TAGS`).
#' @noRd
.acb_play_tags <- c(
  `2` = "THREE_SECONDS_ZONE",
  `7` = "TWENTY_FOUR_SECOND_VIOLATION",
  `8` = "EIGHT_SECOND_VIOLATION",
  `9` = "FOURTEEN_SECOND_VIOLATION",
  `10` = "FIVE_SECOND_INBOUND_VIOLATION",
  `11` = "FIVE_SECOND_HELD_BALL",
  `12` = "BAD_PASS",
  `13` = "CONTROLLED_BALL",
  `14` = "DOUBLE_DRIBBLE",
  `15` = "BACKCOURT_VIOLATION"
)

#' Spanish country name -> ISO 3166-1 alpha-2 (sdv-py `acb_codes.COUNTRIES`).
#' @noRd
.acb_country_iso <- stats::setNames(
  c(
    "DE", "BR", "BG", "CV", "CZ", "CI", "HR", "US", "SI", "ES", "FI", "FR", "GR", "HU", "IT", "JM", "LV",
    "LT", "MK", "ME", "NG", "NL", "PL", "PR", "GB", "CD", "DO", "SN", "RS", "SE", "UA"
  ),
  c(
    "Alemania", "Brasil", "Bulgaria", "Cabo Verde", "Chequia", "Costa de Marfil", "Croacia", "EE.UU.",
    "Eslovenia", "Espa\u00f1a", "Finlandia", "Francia", "Grecia", "Hungr\u00eda", "Italia", "Jamaica",
    "Letonia", "Lituania", "Macedonia del Norte", "Montenegro", "Nigeria", "Pa\u00edses Bajos", "Polonia",
    "Puerto Rico", "Reino Unido", "Rep. Democr\u00e1tica del Congo", "Rep\u00fablica Dominicana", "Senegal",
    "Serbia", "Suecia", "Ucrania"
  )
)
