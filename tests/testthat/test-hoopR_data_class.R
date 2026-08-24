# Regression test for #88: load_nba_schedule() (and every other in-memory
# loader / make_hoopR_data() caller) tagged its return value with a class
# vector that included "data.table" alongside "tbl_df". tail()/head() would
# dispatch data.table:::tail.data.table(), whose internal `x[i]` row-filter
# then re-dispatched to tibble:::`[.tbl_df`() (because tbl_df precedes
# data.table in the class vector) -- which treats a single-bracket index as a
# COLUMN selector, not a row filter. Result: "Can't subset columns past the
# end." Fix: drop "data.table" from the public class vector everywhere it is
# set (see #88 comment thread).

test_that("make_hoopR_data() output supports tail()/head()/print()/dplyr without error", {
  df <- data.frame(a = 1:10, b = 11:20, c = letters[1:10], stringsAsFactors = FALSE)
  out <- make_hoopR_data(df, "unit test data", Sys.time())

  expect_false("data.table" %in% class(out))
  expect_true(all(c("hoopR_data", "tbl_df", "tbl", "data.frame") %in% class(out)))

  tail_out <- tail(out)
  expect_equal(nrow(tail_out), 6L)
  expect_equal(tail_out$a, 5:10)

  head_out <- head(out)
  expect_equal(nrow(head_out), 6L)
  expect_equal(head_out$a, 1:6)

  expect_error(print(out), NA)

  if (requireNamespace("dplyr", quietly = TRUE)) {
    filtered <- dplyr::filter(out, a > 5)
    expect_equal(nrow(filtered), 5L)
    expect_equal(filtered$a, 6:10)
  }
})

test_that("production crosswalk bind path emits a tail()-safe class vector", {
  chunks <- list(
    data.frame(a = 1:5, b = 6:10),
    data.frame(a = 11:15, b = 16:20)
  )
  out <- .bind_crosswalk_chunks(chunks)

  expect_false("data.table" %in% class(out))
  expect_s3_class(out, "hoopR_data")

  tail_out <- tail(out)
  expect_equal(nrow(tail_out), 6L)
  expect_equal(tail_out$a, c(5, 11, 12, 13, 14, 15))
})
