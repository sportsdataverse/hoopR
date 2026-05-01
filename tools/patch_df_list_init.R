#!/usr/bin/env Rscript
# One-off patch: inject `df_list <- list()` immediately before `tryCatch(` in any
# top-level wrapper that returns `df_list` without initializing it first.
# Prevents "object 'df_list' not found" when the API errors or returns a 500.

count_char <- function(s, ch) {
  m <- gregexpr(ch, s, fixed = TRUE)[[1]]
  if (length(m) == 1 && m[1] == -1) 0L else length(m)
}

patch_file <- function(f) {
  lines <- readLines(f, warn = FALSE)
  n <- length(lines)
  if (n == 0) return(0L)

  fn_starts <- grep("^[A-Za-z_.][A-Za-z0-9_.]* <- function\\(", lines)
  if (length(fn_starts) == 0) return(0L)

  # For each function, compute (open_line, end_line) by brace counting.
  bounds_list <- list()
  for (start in fn_starts) {
    open_idx <- NA_integer_
    for (i in start:n) {
      if (count_char(lines[i], "{") > 0) { open_idx <- i; break }
    }
    if (is.na(open_idx)) next
    depth <- 0L
    end_idx <- NA_integer_
    for (i in open_idx:n) {
      depth <- depth + count_char(lines[i], "{") - count_char(lines[i], "}")
      if (depth == 0L) { end_idx <- i; break }
    }
    if (!is.na(end_idx)) {
      bounds_list[[length(bounds_list) + 1]] <- list(start = start, open = open_idx, end = end_idx)
    }
  }

  # Apply patches in REVERSE so earlier indexes stay valid.
  patched <- 0L
  for (bounds in rev(bounds_list)) {
    body <- lines[bounds$open:bounds$end]
    if (!any(grepl("return\\(df_list\\)", body))) next
    if (any(grepl("df_list\\s*<-\\s*list\\(", body))) next
    trycatch_rel <- grep("^\\s*tryCatch\\s*\\(", body)
    if (length(trycatch_rel) == 0) next
    trycatch_abs <- bounds$open + trycatch_rel[1] - 1L
    indent <- sub("[^ ].*$", "", lines[trycatch_abs])
    new_line <- paste0(indent, "df_list <- list()")
    lines <- append(lines, c(new_line, ""), after = trycatch_abs - 1L)
    patched <- patched + 1L
  }

  if (patched > 0L) writeLines(lines, f)
  patched
}

files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
summary_tbl <- data.frame(file = character(0), patched = integer(0), stringsAsFactors = FALSE)
for (f in files) {
  n <- tryCatch(patch_file(f), error = function(e) {
    message("ERROR in ", f, ": ", conditionMessage(e)); 0L
  })
  summary_tbl <- rbind(summary_tbl, data.frame(file = f, patched = n, stringsAsFactors = FALSE))
}

cat("== df_list init patches ==\n")
print(summary_tbl[summary_tbl$patched > 0L, ], row.names = FALSE)
cat("Total functions patched:", sum(summary_tbl$patched), "\n")
