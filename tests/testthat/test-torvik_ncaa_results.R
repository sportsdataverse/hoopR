test_that("Torvik - NCAA Tournament Results", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_ncaa_results(min_year = 2010, max_year = 2024, type = "team")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No NCAA tournament results returned at test time")

  cols <- c("rk", "pake", "pase", "wins", "loss", "r64", "f4", "champ",
            "min_year", "max_year", "type")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
