test_that("CBD - API Key Info", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_api_key_info()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No API key info returned at test time")

  cols <- c("patron_level", "tier_name", "monthly_limit", "remaining_calls", "used_calls", "reset_at")
  expect_in(sort(cols), sort(colnames(x)))
  expect_equal(nrow(x), 1L)

  Sys.sleep(1)
})

test_that("cbbd_api_key_info() parses the recorded response into one documented row", {
  skip_on_cran()
  local_http_fixtures()

  x <- cbbd_api_key_info()
  expect_s3_class(x, "hoopR_data")
  expect_equal(nrow(x), 1L)
  expect_identical(colnames(x), return_columns$col_name[return_columns$fn == "cbbd_api_key_info"])
  # the products array is one cell, not one row per product
  expect_identical(x$products, "cfb; cbb")
})
