# A slow release download used to hit R's default 60 s timeout, and the
# loader returned the other seasons with only a vague warning.

# A reader that fails `fails` times, then returns `value`; records each call.
flaky <- function(fails, value = data.frame(x = 1)) {
  calls <- 0L
  timeouts <- numeric()
  f <- function(url) {
    calls <<- calls + 1L
    timeouts <<- c(timeouts, getOption("timeout"))
    if (calls <= fails) stop("Timeout of 60 seconds was reached")
    value
  }
  list(read = f, calls = function() calls, timeouts = function() timeouts)
}

test_that("a transient failure is retried with a raised timeout, then restored", {
  withr::local_options(timeout = 60)
  r <- flaky(2)
  expect_no_warning(out <- .read_release_asset("https://x/a_2024.rds", r$read))
  expect_equal(out, data.frame(x = 1))
  expect_equal(r$calls(), 3L)
  expect_equal(r$timeouts(), rep(150, 3))
  expect_equal(getOption("timeout"), 60)
})

test_that("a larger user timeout is kept", {
  withr::local_options(timeout = 3600)
  r <- flaky(0)
  .read_release_asset("https://x/a_2024.rds", r$read)
  expect_equal(r$timeouts(), 3600)
  expect_equal(getOption("timeout"), 3600)
})

test_that("a persistent failure warns with the url and returns a try-error", {
  withr::local_options(timeout = 60)
  r <- flaky(Inf)
  expect_warning(
    out <- .read_release_asset("https://x/a_2024.rds", r$read),
    "a_2024.rds.*incomplete"
  )
  expect_s3_class(out, "try-error")
  expect_equal(r$calls(), 3L)
  expect_equal(getOption("timeout"), 60)
})

test_that("a 404 is not retried", {
  calls <- 0L
  read <- function(url) {
    calls <<- calls + 1L
    warning("cannot open URL 'u': HTTP status was '404 Not Found'")
    stop("cannot open the connection")
  }
  expect_warning(.read_release_asset("https://x/a_1800.rds", read), "a_1800.rds")
  expect_equal(calls, 1L)
})

test_that("a loader keeps the seasons that load and names the one that failed", {
  withr::local_options(timeout = 60)
  calls <- 0L
  local_mocked_bindings(.read_rds_url = function(url) {
    calls <<- calls + 1L
    if (endsWith(url, "_2026.rds")) stop("Timeout of 60 seconds was reached")
    data.frame(season = 2025L, athlete_id = 1L)
  })
  expect_warning(
    out <- load_mbb_player_stats(2025:2026),
    "player_season_stats_2026.rds", fixed = TRUE
  )
  expect_equal(nrow(out), 1L)
  expect_equal(out$season, 2025L)
  expect_equal(calls, 4L)
  expect_s3_class(out, "hoopR_data")
  expect_false("data.table" %in% class(out))
  expect_equal(getOption("timeout"), 60)
})

test_that("parquet_from_url retries a download that does not parse", {
  skip_if_not_installed("arrow")
  src <- withr::local_tempfile(fileext = ".parquet")
  arrow::write_parquet(data.frame(x = 1:2), src)
  calls <- 0L
  local_mocked_bindings(.download_url = function(url, dest) {
    calls <<- calls + 1L
    if (calls == 1L) return(writeBin(charToRaw("truncated"), dest))
    file.copy(src, dest, overwrite = TRUE)
  })
  expect_no_warning(out <- parquet_from_url("https://x/a.parquet"))
  expect_equal(out$x, 1:2)
  expect_equal(calls, 2L)
})

test_that("the low-level readers read a local file and reject an empty one", {
  withr::local_options(download.file.method = "auto")
  file_url <- function(path) {
    path <- normalizePath(path, winslash = "/")
    paste0("file://", if (!startsWith(path, "/")) "/", path)
  }
  src <- withr::local_tempfile(fileext = ".rds")
  saveRDS(data.frame(x = 1:2), src, compress = FALSE)
  expect_equal(.read_rds_url(file_url(src)), data.frame(x = 1:2))
  expect_equal(rds_from_url(file_url(src))$x, 1:2)

  dest <- withr::local_tempfile()
  .download_url(file_url(src), dest)
  expect_equal(readRDS(dest), data.frame(x = 1:2))

  empty <- withr::local_tempfile()
  file.create(empty)
  expect_error(.download_url(file_url(empty), withr::local_tempfile()), "empty")
})

test_that("warnings from a read that succeeds are passed on", {
  read <- function(url) {
    warning("a note from the reader")
    1
  }
  expect_warning(out <- .read_release_asset("https://x/a_2024.rds", read), "a note from the reader")
  expect_equal(out, 1)
})

test_that("parquet_from_url returns an empty table when the download keeps failing", {
  skip_if_not_installed("arrow")
  local_mocked_bindings(.download_url = function(url, dest) stop("Timeout of 150 seconds was reached"))
  expect_warning(out <- parquet_from_url("https://x/b_2024.parquet"), "b_2024.parquet", fixed = TRUE)
  expect_equal(nrow(out), 0L)
})

test_that("a release csv read is retried and passes its arguments on", {
  withr::local_options(timeout = 60)
  calls <- 0L
  local_mocked_bindings(csv_from_url = function(file, ...) {
    calls <<- calls + 1L
    expect_equal(getOption("timeout"), 150)
    if (calls == 1L) stop("Timeout of 60 seconds was reached")
    data.table::data.table(url = file, ...)
  })
  expect_no_warning(out <- load_nba_games())
  expect_equal(calls, 2L)
  expect_match(out$url, "nba_games_in_data_repo.csv", fixed = TRUE)
  expect_equal(.release_csv_from_url("https://x/a.csv", sep = ",")$sep, ",")
  expect_equal(getOption("timeout"), 60)
})

test_that("a release csv that keeps failing warns with the url, then raises", {
  calls <- 0L
  local_mocked_bindings(csv_from_url = function(file, ...) {
    calls <<- calls + 1L
    stop("Timeout of 150 seconds was reached")
  })
  expect_error(
    expect_warning(load_mbb_games(), "mbb_games_in_data_repo.csv", fixed = TRUE),
    "Timeout of 150 seconds"
  )
  expect_equal(calls, 3L)
})

test_that("a release csv is read from a local file", {
  withr::local_options(download.file.method = "auto")
  src <- withr::local_tempfile(fileext = ".csv")
  data.table::fwrite(data.frame(season = 2024L, game_id = 1:2), src)
  path <- normalizePath(src, winslash = "/")
  out <- .release_csv_from_url(paste0("file://", if (!startsWith(path, "/")) "/", path))
  expect_equal(out$game_id, 1:2)
})
