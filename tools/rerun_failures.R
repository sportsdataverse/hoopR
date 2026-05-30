#!/usr/bin/env Rscript
# Re-run only the previously-failing examples and report status.
#
# Update the `fails` vector after the initial `run_examples.R` batch to
# triage only the subset that needs investigation. Port of wehoop's
# tools/rerun_failures.R; same workflow.
fails <- c(
  # Fill in after running tools/run_examples.R for the first time.
  # Example:
  #   "espn_nba_athlete_info", "espn_mbb_athlete_info"
)

if (length(fails) == 0L) {
  cat("No failing scripts specified. Edit `fails` in tools/rerun_failures.R\n")
  quit(status = 0)
}

cat(sprintf("%-42s | %s\n", "name", "result"))
cat(strrep("-", 95), "\n", sep = "")
for (nm in fails) {
  scr <- file.path("tools/example_runs", paste0(nm, ".R"))
  if (!file.exists(scr)) { cat(sprintf("%-42s | (no script)\n", nm)); next }
  out <- tryCatch(
    system2("Rscript", c("--no-save", scr),
            stdout = TRUE, stderr = TRUE, timeout = 60),
    error = function(e) paste("RUNNER-ERROR:", conditionMessage(e))
  )
  res_idx <- grep("^---RESULT---", out)
  summary <- if (length(res_idx))
              paste(out[(res_idx[1] + 1):length(out)], collapse = " | ")
              else paste("ERR:", paste(tail(out, 2), collapse = " "))
  cat(sprintf("%-42s | %s\n", nm, substr(summary, 1, 200)))
}
