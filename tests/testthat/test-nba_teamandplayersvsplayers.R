test_that("NBA Team and Players vs Players", {
    skip_on_cran()
    skip_on_ci()
    skip_nba_stats_test()

    # Example from nba_api docs: Cavs vs Pistons, 2019-20
    x <- nba_teamandplayersvsplayers(
        team_id = "1610612739",
        vs_team_id = "1610612765",
        player_id1 = "202681",
        player_id2 = "203078",
        player_id3 = "203507",
        player_id4 = "201567",
        player_id5 = "203954",
        vs_player_id1 = "201566",
        vs_player_id2 = "201939",
        vs_player_id3 = "201935",
        vs_player_id4 = "201142",
        vs_player_id5 = "203076",
        season = "2019-20"
    )

    skip_if(length(x) == 0, "NBA teamandplayersvsplayers endpoint unavailable")

    # Per-element guard: the API sometimes returns fewer result sets than
    # expected (or a NULL element). Skip individual asserts gracefully
    # rather than erroring on colnames(NULL). See CLAUDE.md test pattern.
    check_cols <- function(el, cols) {
      if (is.null(el) || !is.data.frame(el) || ncol(el) == 0) {
        return(invisible(NULL))
      }
      expect_in(sort(cols), sort(colnames(el)))
      expect_s3_class(el, "data.frame")
    }

    cols_pvp <- c(
        "GROUP_SET",
        "TITLE_DESCRIPTION",
        "DESCRIPTION",
        "MIN",
        "FGM",
        "FGA",
        "FG_PCT",
        "FG3M",
        "FG3A",
        "FG3_PCT",
        "FTM",
        "FTA",
        "FT_PCT",
        "OREB",
        "DREB",
        "REB",
        "AST",
        "TOV",
        "STL",
        "BLK",
        "BLKA",
        "PF",
        "PFD",
        "PTS",
        "PLUS_MINUS"
    )
    check_cols(x$PlayersVsPlayers, cols_pvp)

    cols_on <- c(
        "GROUP_SET",
        "TITLE_DESCRIPTION",
        "PLAYER_ID",
        "PLAYER_NAME",
        "MIN",
        "FGM",
        "FGA",
        "FG_PCT",
        "FG3M",
        "FG3A",
        "FG3_PCT",
        "FTM",
        "FTA",
        "FT_PCT",
        "OREB",
        "DREB",
        "REB",
        "AST",
        "TOV",
        "STL",
        "BLK",
        "BLKA",
        "PF",
        "PFD",
        "PTS",
        "PLUS_MINUS"
    )
    check_cols(x$TeamPlayersVsPlayersOn, cols_on)
    check_cols(x$TeamPlayersVsPlayersOff, cols_on)
    check_cols(x$TeamVsPlayers, cols_pvp)
    check_cols(x$TeamVsPlayersOff, cols_pvp)

    Sys.sleep(3)
})
