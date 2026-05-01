#!/usr/bin/env Rscript
# Flip test assertions that do strict column-set equality to subset checks.
# Per CLAUDE.md: NBA Stats / ESPN / KenPom APIs add columns over time — tests
# that pin the exact column set are brittle. `expect_in(expected_cols,
# colnames(actual))` lets us guarantee required columns exist while tolerating
# upstream additions.

files <- list.files("tests/testthat", pattern = "\\.R$", full.names = TRUE)

changed_files <- character(0)
total_lines <- 0L

for (f in files) {
  lines <- readLines(f, warn = FALSE)
  orig  <- lines

  # Pattern 1: expect_equal(sort(colnames(<expr>)), sort(<cols_var>))
  #   -> expect_in(sort(<cols_var>), sort(colnames(<expr>)))
  lines <- sub(
    "expect_equal\\(sort\\(colnames\\((.+)\\)\\),\\s*sort\\(([^)]+)\\)\\)",
    "expect_in(sort(\\2), sort(colnames(\\1)))",
    lines
  )

  # Pattern 2: expect_equal(colnames(<expr>), <cols_var>)
  #   -> expect_in(<cols_var>, colnames(<expr>))
  lines <- sub(
    "expect_equal\\(colnames\\(([^)]+)\\),\\s*([A-Za-z_][A-Za-z0-9_]*)\\)",
    "expect_in(\\2, colnames(\\1))",
    lines
  )

  diffs <- sum(lines != orig)
  if (diffs > 0L) {
    writeLines(lines, f)
    changed_files <- c(changed_files, f)
    total_lines <- total_lines + diffs
  }
}

cat("Flipped", total_lines, "assertion(s) across", length(changed_files), "file(s).\n")
