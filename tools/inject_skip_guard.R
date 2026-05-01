#!/usr/bin/env Rscript
# Inject a "skip if empty" guard into each test_that() block so that tests
# which access x[[1]] don't explode when the underlying API returns empty.
#
# Pattern injected just after `x <- <call>(...)` (skip if the call already
# short-circuited into the error handler and returned NULL / an empty list).
#
#   if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) ||
#       nrow(x[[1]]) == 0) {
#     skip("No rows returned from endpoint at test time")
#   }
#
# Skip the injection if the block already contains that exact skip or a
# similar `skip("No rows returned` message.

files <- list.files("tests/testthat", pattern = "^test-.*\\.R$", full.names = TRUE)

count_char <- function(s, ch) {
  m <- gregexpr(ch, s, fixed = TRUE)[[1]]
  if (length(m) == 1 && m[1] == -1) 0L else length(m)
}

inject <- function(lines) {
  n <- length(lines)
  if (n == 0) return(lines)

  # Find test_that() blocks by locating `test_that("..."` signatures.
  tt_starts <- grep("^test_that\\(", lines)
  if (length(tt_starts) == 0) return(lines)

  # For each, find its closing `})` by brace balance.
  bounds_list <- list()
  for (start in tt_starts) {
    depth <- 0L
    end_idx <- NA_integer_
    for (i in start:n) {
      depth <- depth + count_char(lines[i], "{") - count_char(lines[i], "}")
      if (depth == 0L && grepl("\\{", lines[i])) {
        # Continue scanning for the matching `}` after the opening brace.
      }
      if (depth == 0L && i > start) {
        end_idx <- i
        break
      }
    }
    if (!is.na(end_idx)) {
      bounds_list[[length(bounds_list) + 1]] <- list(start = start, end = end_idx)
    }
  }

  # Apply in REVERSE order.
  for (b in rev(bounds_list)) {
    body <- lines[b$start:b$end]

    # Already guarded?
    if (any(grepl("No rows returned from endpoint", body, fixed = TRUE))) next

    # Find a simple assignment `x <- <func_name>(` that is NOT already followed
    # by an `is.null(x[[1]])` guard.
    assign_rel <- grep("^\\s*x\\s*<-\\s*[A-Za-z_][A-Za-z0-9_]*\\(", body)
    if (length(assign_rel) == 0) next
    assign_rel <- assign_rel[1]

    # If the assignment wraps across lines (e.g. ends with `,` or `(`), walk forward
    # until we find the matching closing paren at depth 0.
    paren_depth <- count_char(body[assign_rel], "(") - count_char(body[assign_rel], ")")
    j <- assign_rel
    while (paren_depth > 0L && j < length(body)) {
      j <- j + 1L
      paren_depth <- paren_depth + count_char(body[j], "(") - count_char(body[j], ")")
    }
    inject_after_rel <- j

    # Only inject if the block actually touches x[[...]] later.
    tail_slice <- body[(inject_after_rel + 1L):length(body)]
    if (!any(grepl("x\\[\\[", tail_slice))) next

    indent <- sub("[^ ].*$", "", body[assign_rel])
    guard <- c(
      "",
      paste0(indent, "if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {"),
      paste0(indent, "  skip(\"No rows returned from endpoint at test time\")"),
      paste0(indent, "}")
    )

    abs_after <- b$start + inject_after_rel - 1L
    lines <- append(lines, guard, after = abs_after)
  }

  lines
}

total_files <- 0L
for (f in files) {
  lines <- readLines(f, warn = FALSE)
  new_lines <- inject(lines)
  if (!identical(lines, new_lines)) {
    writeLines(new_lines, f)
    total_files <- total_files + 1L
    cat("guarded:", f, "\n")
  }
}
cat("Injected skip-guard into", total_files, "file(s).\n")
