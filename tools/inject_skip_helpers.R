# tools/inject_skip_helpers.R
#
# Injects env-var-gated skip helpers into every test file in tests/testthat/.
# Idempotent: re-running does not duplicate injections.
#
# Mapping:
#   test-nba_*.R         -> skip_nba_stats_test()
#   test-espn_nba_*.R    -> skip_espn_test()
#   test-espn_mbb_*.R    -> skip_espn_test()
#   test-kp_*.R          -> skip_kenpom_test()
#   test-nbagl_*.R       -> skip_nbagl_stats_test()
#   test-ncaa_mbb_*.R    -> skip_ncaa_mbb_test()
#
# Insertion point: immediately after the existing `skip_on_ci()` line, with
# matching indentation. Falls back to `skip_on_cran()` if `skip_on_ci()` is
# missing. If neither is present, the file is left untouched.
#
# Run from package root:
#   Rscript tools/inject_skip_helpers.R

files <- list.files("tests/testthat", pattern = "^test-.*\\.R$", full.names = TRUE)

modified <- character()

for (f in files) {
  lines <- readLines(f, warn = FALSE)
  base <- basename(f)

  helper <- if (grepl("^test-espn_(nba|mbb)_", base)) {
    "skip_espn_test()"
  } else if (grepl("^test-nbagl_", base)) {
    "skip_nbagl_stats_test()"
  } else if (grepl("^test-nba_", base)) {
    "skip_nba_stats_test()"
  } else if (grepl("^test-kp_", base)) {
    "skip_kenpom_test()"
  } else if (grepl("^test-ncaa_mbb_", base)) {
    "skip_ncaa_mbb_test()"
  } else {
    next
  }

  helper_name <- sub("\\(\\)$", "", helper)
  if (any(grepl(paste0("\\b", helper_name, "\\("), lines))) next

  sk_idx <- grep("skip_on_ci\\(\\)", lines)
  if (length(sk_idx) == 0) {
    sk_idx <- grep("skip_on_cran\\(\\)", lines)
  }
  if (length(sk_idx) == 0) next

  insert_at <- sk_idx[1]
  indent <- sub("[^ ].*$", "", lines[insert_at])
  lines <- append(lines, paste0(indent, helper), after = insert_at)
  writeLines(lines, f)
  modified <- c(modified, f)
}

cat(sprintf("Modified %d test file(s).\n", length(modified)))
