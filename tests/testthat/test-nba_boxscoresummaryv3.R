test_that("NBA Boxscore Summary V3", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    x <- nba_boxscoresummaryv3(game_id = "0022200021")

    # GameSummary
    cols_game_summary <- c(
        "game_id",
        "game_code",
        "game_status",
        "game_status_text",
        "period",
        "game_clock",
        "game_time_utc",
        "game_et",
        "away_team_id",
        "home_team_id",
        "duration",
        "attendance",
        "sellout"
    )
    expect_in(sort(cols_game_summary), sort(colnames(x$GameSummary)))
    expect_s3_class(x$GameSummary, "data.frame")

    # GameInfo
    cols_game_info <- c(
        "game_id",
        "game_date",
        "attendance",
        "game_duration"
    )
    expect_in(sort(cols_game_info), sort(colnames(x$GameInfo)))
    expect_s3_class(x$GameInfo, "data.frame")

    # ArenaInfo
    cols_arena_info <- c(
        "game_id",
        "arena_id",
        "arena_name",
        "arena_city",
        "arena_state",
        "arena_country",
        "arena_timezone"
    )
    expect_in(sort(cols_arena_info), sort(colnames(x$ArenaInfo)))
    expect_s3_class(x$ArenaInfo, "data.frame")

    # Officials
    cols_officials <- c(
        "game_id",
        "person_id",
        "name",
        "name_i",
        "first_name",
        "family_name",
        "jersey_num"
    )
    expect_in(sort(cols_officials), sort(colnames(x$Officials)))
    expect_s3_class(x$Officials, "data.frame")

    # LineScore
    cols_line_score <- c(
        "game_id",
        "team_id",
        "team_city",
        "team_name",
        "team_tricode",
        "team_slug",
        "team_wins",
        "team_losses",
        "period1_score",
        "period2_score",
        "period3_score",
        "period4_score",
        "score"
    )
    expect_in(sort(cols_line_score), sort(colnames(x$LineScore)))
    expect_s3_class(x$LineScore, "data.frame")
    expect_equal(nrow(x$LineScore), 2)

    # InactivePlayers
    cols_inactive <- c(
        "game_id",
        "team_id",
        "person_id",
        "first_name",
        "family_name",
        "jersey_num"
    )
    expect_in(sort(cols_inactive), sort(colnames(x$InactivePlayers)))
    expect_s3_class(x$InactivePlayers, "data.frame")

    # LastFiveMeetings
    cols_meetings <- c(
        "recency_order",
        "game_id",
        "game_time_utc",
        "game_et",
        "game_status",
        "game_status_text",
        "away_team_id",
        "away_team_city",
        "away_team_name",
        "away_team_tricode",
        "away_team_score",
        "away_team_wins",
        "away_team_losses",
        "home_team_id",
        "home_team_city",
        "home_team_name",
        "home_team_tricode",
        "home_team_score",
        "home_team_wins",
        "home_team_losses"
    )
    expect_in(sort(cols_meetings), sort(colnames(x$LastFiveMeetings)))
    expect_s3_class(x$LastFiveMeetings, "data.frame")

    # OtherStats
    cols_other <- c(
        "game_id",
        "team_id",
        "team_city",
        "team_name",
        "team_tricode",
        "points",
        "rebounds_total",
        "assists",
        "steals",
        "blocks",
        "turnovers",
        "field_goals_percentage",
        "three_pointers_percentage",
        "free_throws_percentage",
        "points_in_the_paint",
        "points_second_chance",
        "points_fast_break",
        "biggest_lead",
        "lead_changes",
        "times_tied",
        "biggest_scoring_run",
        "turnovers_team",
        "turnovers_total",
        "rebounds_team",
        "points_from_turnovers",
        "bench_points"
    )
    expect_in(sort(cols_other), sort(colnames(x$OtherStats)))
    expect_s3_class(x$OtherStats, "data.frame")
    expect_equal(nrow(x$OtherStats), 2)

    # AvailableVideo
    cols_video <- c(
        "game_id",
        "video_available_flag",
        "pt_available",
        "pt_xyz_available",
        "wh_status",
        "hustle_status",
        "historical_status"
    )
    expect_in(sort(cols_video), sort(colnames(x$AvailableVideo)))
    expect_s3_class(x$AvailableVideo, "data.frame")

    # Verify named list structure
    expect_equal(length(x), 9)
    expect_equal(names(x), c(
        "GameSummary", "GameInfo", "ArenaInfo", "Officials",
        "LineScore", "InactivePlayers", "LastFiveMeetings",
        "OtherStats", "AvailableVideo"
    ))

    Sys.sleep(3)
})
