# Base-R date helpers that replaced lubridate. Expected values match what
# lubridate::ymd_hm() |> with_tz(), lubridate::mdy() and as_datetime() gave.

test_that(".espn_utc_to_et parses ESPN UTC stamps into America/New_York", {
  x <- c("2023-10-24T23:30", "2024-03-10T06:59", "2024-03-10T07:00",
         "2024-11-03T05:30", "2024-11-03T06:30", "2024-02-29T04:00", NA, "")
  out <- .espn_utc_to_et(x)
  expect_s3_class(out, "POSIXct")
  expect_identical(attr(out, "tzone"), "America/New_York")
  expect_identical(
    format(out, "%Y-%m-%d %H:%M %Z"),
    c("2023-10-24 19:30 EDT", "2024-03-10 01:59 EST", "2024-03-10 03:00 EDT",
      "2024-11-03 01:30 EDT", "2024-11-03 01:30 EST", "2024-02-28 23:00 EST",
      NA, NA)
  )
  expect_identical(as.numeric(out[1]), 1698190200)
  # the call sites derive game_date from the ET string
  expect_identical(as.Date(substr(out[1], 1, 10)), as.Date("2023-10-24"))
  expect_length(.espn_utc_to_et(character(0)), 0L)
})

test_that(".parse_mdy parses stats.*.com MM/DD/YYYY dates", {
  x <- substring(c("10/04/2025 00:00:00", "02/29/2024 00:00:00", NA, ""), 1, 10)
  expect_identical(.parse_mdy(x), as.Date(c("2025-10-04", "2024-02-29", NA, NA)))
})

test_that(".bb_to_eastern handles DST edges, POSIXct and no-seconds stamps", {
  expect_identical(
    .bb_to_eastern(c("2024-03-10T06:59:00Z", "2024-11-03T04:30:00Z", NA)),
    as.Date(c("2024-03-10", "2024-11-03", NA))
  )
  expect_identical(.bb_to_eastern("2024-12-26"), as.Date("2024-12-25"))
  expect_identical(.bb_to_eastern("2024-12-26T04:59Z"), as.Date("2024-12-25"))
  et <- .espn_utc_to_et(c("2024-12-26T01:30", "2024-12-26T05:00"))
  expect_identical(.bb_to_eastern(et), as.Date(c("2024-12-25", "2024-12-26")))
})
