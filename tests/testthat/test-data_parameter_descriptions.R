test_that("parameter_descriptions matches the nba_*() wrappers it describes", {
  pd <- hoopR::parameter_descriptions
  expect_named(pd, c("parameter", "api_name", "description", "valid_values",
                     "default", "functions", "n_functions"))
  expect_false(anyDuplicated(pd$parameter) > 0)
  expect_true(all(nzchar(pd$api_name)))

  fns <- strsplit(pd$functions, ", ", fixed = TRUE)
  expect_equal(pd$n_functions, lengths(fns))
  # Every listed function is exported and still takes the argument; a failure
  # means the wrappers changed: rerun data-raw/parameter_descriptions.R.
  ns <- asNamespace("hoopR")
  exported <- getNamespaceExports("hoopR")
  for (i in seq_len(nrow(pd))) {
    expect_true(all(fns[[i]] %in% exported), info = pd$parameter[i])
    takes <- vapply(fns[[i]], function(f) pd$parameter[i] %in% names(formals(get(f, ns))), logical(1))
    expect_true(all(takes), info = pd$parameter[i])
  }
})
