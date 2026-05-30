test_that("ESPN - NBA Venues", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_venues()

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_venues at test time")
  }

  cols_x <- c(
    "venue_id", "name", "full_name",
    "address_city", "address_state",
    "capacity", "indoor", "grass", "images_url"
  )

  expect_in(sort(cols_x), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
