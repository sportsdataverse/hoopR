test_that("NBA Video Events Asset", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    x <- nba_videoeventsasset(game_id = "0021700807", game_event_id = 10)

    # videoeventsasset has no predefined result set structure,
    # so we just verify the call doesn't error and returns something

    expect_true(!is.null(x))

    Sys.sleep(3)
})
