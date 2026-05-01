#!/usr/bin/env Rscript
# Walk every R/*.R file and try parse(); report any that fail.
files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
n_err <- 0L
for (f in files) {
  err <- tryCatch({
    parse(file = f)
    NULL
  }, error = function(e) conditionMessage(e))
  if (!is.null(err)) {
    n_err <- n_err + 1L
    cat("PARSE ERROR in", f, "\n  ", err, "\n", sep = "")
  }
}
cat("\nFiles checked: ", length(files), "\n", sep = "")
cat("Parse errors:  ", n_err, "\n", sep = "")
