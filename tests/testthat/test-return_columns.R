# Offline checks on the `return_columns` dataset and the @return sections
# generated from it (data-raw/return_columns.csv -> .returns_rd()).

.rc_rd_db <- function() {
  root <- testthat::test_path("..", "..")
  if (dir.exists(file.path(root, "man")) && file.exists(file.path(root, "DESCRIPTION"))) {
    tools::Rd_db(dir = root)
  } else {
    tools::Rd_db("hoopR")
  }
}

test_that("return_columns has its documented shape", {
  rc <- hoopR::return_columns
  expect_s3_class(rc, "data.frame")
  expect_named(rc, c("fn", "component", "col_name", "type", "description"))
  expect_false(anyNA(rc$fn))
  expect_false(anyNA(rc$col_name))
  expect_false(any(duplicated(rc[, c("fn", "component", "col_name")])))
})

test_that("every return_columns function exists in the namespace", {
  ns <- asNamespace("hoopR")
  fns <- unique(hoopR::return_columns$fn)
  missing <- fns[!vapply(fns, exists, NA, envir = ns, inherits = FALSE)]
  expect_identical(missing, character())
})

test_that("every exported function with a data return documents its columns", {
  rc <- hoopR::return_columns
  db <- .rc_rd_db()
  tag <- function(x) {
    t <- attr(x, "Rd_tag")
    if (is.null(t)) "" else t
  }
  has_tab <- function(x) {
    identical(tag(x), "\\tabular") || (is.list(x) && any(vapply(x, has_tab, NA)))
  }
  txt <- function(x) if (is.list(x)) paste(vapply(x, txt, ""), collapse = "") else as.character(x)
  aliases <- lapply(db, function(rd) unlist(lapply(rd[vapply(rd, tag, "") == "\\alias"], as.character)))
  rd_of <- stats::setNames(rep(names(db), lengths(aliases)), unlist(aliases))
  value <- lapply(db, function(rd) rd[vapply(rd, tag, "") == "\\value"])

  exports <- getNamespaceExports("hoopR")
  exports <- exports[vapply(exports, function(f) is.function(getExportedValue("hoopR", f)), NA)]
  exports <- intersect(exports, names(rd_of))
  v <- value[rd_of[exports]]
  data_return <- vapply(v, function(x) {
    grepl("tibble|data frame|data\\.frame|hoopR_data|data\\.table", txt(x), ignore.case = TRUE)
  }, NA)
  documented <- vapply(v, has_tab, NA) | exports %in% rc$fn
  undocumented <- sort(exports[data_return & !documented])

  # Functions whose columns were never tabulated. The list may only shrink:
  # a new function needs its rows in data-raw/return_columns.csv.
  known <- readLines(testthat::test_path("fixtures", "return_columns_undocumented.txt"))
  expect_identical(setdiff(undocumented, known), character())
  expect_identical(intersect(known, rc$fn), character())
})
