# Shrink oversized recorded responses in place (run from the package root after
# record_fixtures.R, then re-run the offline tests):
#   Rscript data-raw/http_fixtures/trim_fixtures.R [max_kb]
#
# A body over `max_kb` (gzipped) that parses as JSON -- whatever its content type
# says (barttorvik serves JSON as text/html) -- has its arrays cut to 5 items; a
# csv body keeps its header and first 25 rows. Anything else is left alone.

`%||%` <- function(a, b) if (is.null(a)) b else a
fix_dir <- file.path("tests", "testthat", "fixtures", "http")
max_kb <- as.numeric(commandArgs(trailingOnly = TRUE)[1] %||% 60)
index <- jsonlite::read_json(file.path(fix_dir, "index.json"))

trim_json <- function(x) {
  if (!is.list(x) || length(x) == 0) return(x)
  if (is.null(names(x)) && length(x) > 5L) x <- x[1:5]
  x[] <- lapply(x, trim_json)
  x
}

for (url in names(index)) {
  path <- file.path(fix_dir, index[[url]]$file)
  if (file.size(path) / 1024 <= max_kb) next
  body <- rawToChar(memDecompress(readBin(path, "raw", file.size(path)), "gzip"))
  j <- tryCatch(jsonlite::fromJSON(body, simplifyVector = FALSE), error = function(e) NULL)
  out <- if (!is.null(j)) {
    as.character(jsonlite::toJSON(trim_json(j), auto_unbox = TRUE, null = "null", na = "null", digits = NA))
  } else if (grepl("csv", url, fixed = TRUE) || grepl("csv", index[[url]]$type, fixed = TRUE)) {
    paste(utils::head(strsplit(body, "\n", fixed = TRUE)[[1]], 26), collapse = "\n")
  }
  if (is.null(out)) next
  before <- file.size(path)
  writeBin(memCompress(charToRaw(enc2utf8(out)), "gzip"), path)
  message(sprintf("%6.0f -> %5.0f KB  %s", before / 1024, file.size(path) / 1024, url))
}
