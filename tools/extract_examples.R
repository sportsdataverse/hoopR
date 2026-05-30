#!/usr/bin/env Rscript
# Extract \donttest{} examples from man/*.Rd into a single runnable file per Rd.
# Usage: Rscript tools/extract_examples.R <pattern> <out_dir>
#
# Default pattern matches hoopR's ESPN wrapper families (espn_nba_*, espn_mbb_*).
# Port of the wehoop equivalent at c:/.../wehoop/tools/extract_examples.R; see
# tools/example_runs/README.md for the surrounding workflow.
args <- commandArgs(trailingOnly = TRUE)
pat  <- if (length(args) >= 1) args[[1]] else "espn_(nba|mbb)_"
outd <- if (length(args) >= 2) args[[2]] else "tools/example_runs"
dir.create(outd, recursive = TRUE, showWarnings = FALSE)

rd_files <- list.files("man", pattern = "\\.Rd$", full.names = TRUE)
rd_files <- rd_files[grepl(pat, basename(rd_files))]

extract_examples <- function(path) {
  txt <- readLines(path, warn = FALSE)
  start <- grep("^\\\\examples\\{", txt)
  if (length(start) == 0) return(NULL)
  end <- which(txt == "}")
  end <- end[end > start[1]][1]
  if (is.na(end)) return(NULL)
  block <- txt[(start[1] + 1):(end - 1)]
  block <- sub("^\\s*\\\\donttest\\{\\s*$", "", block)
  block <- sub("^\\s*\\}\\s*$", "", block)
  paste(block, collapse = "\n")
}

manifest <- data.frame(name = character(), file = character(), stringsAsFactors = FALSE)
for (rd in rd_files) {
  ex <- extract_examples(rd)
  if (is.null(ex) || !nzchar(trimws(ex))) next
  fn_name <- sub("\\.Rd$", "", basename(rd))
  out_file <- file.path(outd, paste0(fn_name, ".R"))
  writeLines(c(
    "options(error = function() { traceback(2); quit(status = 1) })",
    "suppressMessages(devtools::load_all('.', quiet = TRUE))",
    "result <- tryCatch({",
    ex,
    "}, error = function(e) { cat('ERROR:', conditionMessage(e), '\\n'); quit(status = 2) })",
    "cat('---RESULT---\\n')",
    "if (is.data.frame(result)) {",
    "  cat('class:', paste(class(result), collapse=','), '\\n')",
    "  cat('dim:', nrow(result), 'x', ncol(result), '\\n')",
    "  cat('cols:', paste(head(colnames(result), 12), collapse=', '), if(ncol(result) > 12) ' ...' else '', '\\n')",
    "} else if (is.list(result)) {",
    "  cat('list with', length(result), 'elements:', paste(head(names(result), 10), collapse=', '), '\\n')",
    "  for (nm in head(names(result), 5)) {",
    "    el <- result[[nm]]",
    "    if (is.data.frame(el)) cat(' ', nm, ':', nrow(el), 'x', ncol(el), '\\n')",
    "    else cat(' ', nm, ':', class(el)[1], 'len=', length(el), '\\n')",
    "  }",
    "} else {",
    "  cat('class:', paste(class(result), collapse=','), '\\n')",
    "  cat('length:', length(result), '\\n')",
    "}"
  ), out_file)
  manifest <- rbind(manifest, data.frame(name = fn_name, file = out_file, stringsAsFactors = FALSE))
}
write.csv(manifest, file.path(outd, "_manifest.csv"), row.names = FALSE)
cat("Extracted", nrow(manifest), "example scripts to", outd, "\n")
