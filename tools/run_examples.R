#!/usr/bin/env Rscript
# Run each extracted example script in a fresh R subprocess with timeout.
# Captures stdout+stderr; classifies result as OK / ERROR / EMPTY / TIMEOUT.
#
# Port of wehoop's tools/run_examples.R. Package-agnostic: reads paths from
# tools/example_runs/_manifest.csv produced by tools/extract_examples.R.
manifest <- read.csv("tools/example_runs/_manifest.csv", stringsAsFactors = FALSE)
log_file <- "tools/example_runs/_results.csv"
detail_dir <- "tools/example_runs/output"
dir.create(detail_dir, recursive = TRUE, showWarnings = FALSE)

results <- data.frame(
  name = character(), status = character(), summary = character(),
  duration_s = numeric(), stringsAsFactors = FALSE
)

for (i in seq_len(nrow(manifest))) {
  nm <- manifest$name[i]
  scr <- manifest$file[i]
  cat(sprintf("[%2d/%d] %s ... ", i, nrow(manifest), nm))
  t0 <- Sys.time()
  out <- tryCatch(
    system2("Rscript", c("--no-save", scr),
            stdout = TRUE, stderr = TRUE, timeout = 90),
    error = function(e) paste("RUNNER-ERROR:", conditionMessage(e))
  )
  dt <- as.numeric(difftime(Sys.time(), t0, units = "secs"))
  ec <- attr(out, "status")
  writeLines(out, file.path(detail_dir, paste0(nm, ".log")))

  status <- if (!is.null(ec) && ec != 0) "ERROR" else "OK"
  res_idx <- grep("^---RESULT---", out)
  summary <- ""
  if (length(res_idx)) {
    tail_lines <- out[(res_idx[1] + 1):length(out)]
    summary <- paste(tail_lines, collapse = " | ")
    if (any(grepl("^dim: 0 x 0", tail_lines)) ||
        any(grepl("^list with 0 elements", tail_lines))) {
      status <- "EMPTY"
    }
  } else {
    err_idx <- grep("^ERROR:", out)
    if (length(err_idx)) summary <- out[err_idx[1]]
    else summary <- paste(tail(out, 3), collapse = " | ")
  }

  results <- rbind(results, data.frame(
    name = nm, status = status,
    summary = substr(summary, 1, 250),
    duration_s = round(dt, 1), stringsAsFactors = FALSE
  ))
  cat(status, sprintf("(%.1fs)\n", dt))
  flush.console()
}
write.csv(results, log_file, row.names = FALSE)
cat("\n=== Summary ===\n")
print(table(results$status))
cat("\nFailures:\n")
fails <- results[results$status != "OK", c("name", "status", "summary")]
for (i in seq_len(nrow(fails))) {
  cat(sprintf("  %-40s [%s] %s\n", fails$name[i], fails$status[i],
              substr(fails$summary[i], 1, 120)))
}
