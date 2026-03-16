test_that("NBA PlayByPlay V3", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    x <- nba_playbyplayv3(game_id = "0022201086")

    cols_pbp <- c(
        "game_id",
        "action_number",
        "clock",
        "period",
        "team_id",
        "team_tricode",
        "person_id",
        "player_name",
        "player_name_i",
        "x_legacy",
        "y_legacy",
        "shot_distance",
        "shot_result",
        "is_field_goal",
        "score_home",
        "score_away",
        "points_total",
        "location",
        "description",
        "action_type",
        "sub_type",
        "video_available",
        "shot_value",
        "action_id"
    )

    expect_in(sort(cols_pbp), sort(colnames(x$PlayByPlay)))
    expect_s3_class(x$PlayByPlay, "hoopR_data")
    expect_gt(nrow(x$PlayByPlay), 0)

    expect_s3_class(x$AvailableVideo, "hoopR_data")
    expect_true("video_available" %in% colnames(x$AvailableVideo))
})

test_that("NBA PBP V3 via nba_pbp()", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    x <- nba_pbp(game_id = "0022201086", on_court = FALSE, version = "v3")

    expect_s3_class(x, "hoopR_data")
    expect_gt(nrow(x), 0)
    expect_true("action_type" %in% colnames(x))
    expect_true("game_id" %in% colnames(x))
})

test_that("NBA PBP V3 with on_court", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    x <- nba_pbp(game_id = "0022201086", on_court = TRUE, version = "v3")

    expect_gt(nrow(x), 0)

    on_court_cols <- c(
        "away_player1", "away_player2", "away_player3",
        "away_player4", "away_player5",
        "home_player1", "home_player2", "home_player3",
        "home_player4", "home_player5"
    )
    expect_true(all(on_court_cols %in% colnames(x)))
})
