#!/usr/bin/env Rscript
# Extended patch: any function that does `tryCatch(...)` followed by `return(<var>)`
# must initialize `<var>` before the tryCatch, or a connection error / HTTP 500
# causes the error handler to run and `return(<var>)` throws "object '<var>' not found".
#
# Safe default: init to NULL. Callers already expect the function to possibly fail
# quietly and return an empty/null result via the cli::cli_alert_danger path.

count_char <- function(s, ch) {
  m <- gregexpr(ch, s, fixed = TRUE)[[1]]
  if (length(m) == 1 && m[1] == -1) 0L else length(m)
}

patch_file <- function(f) {
  lines <- readLines(f, warn = FALSE)
  n <- length(lines)
  if (n == 0) return(character(0))

  fn_starts <- grep("^[A-Za-z_.][A-Za-z0-9_.]* <- function\\(", lines)
  if (length(fn_starts) == 0) return(character(0))

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

  patched_names <- character(0)

  for (bounds in rev(bounds_list)) {
    body <- lines[bounds$open:bounds$end]

    # Find last `return(VAR)` where VAR is a simple identifier (not VAR$x, not VAR[...]).
    m <- regmatches(body, regexec("^\\s*return\\(([A-Za-z_.][A-Za-z0-9_.]*)\\)\\s*$", body))
    hits <- which(vapply(m, function(x) length(x) > 0, logical(1)))
    if (length(hits) == 0) next
    last_hit <- tail(hits, 1)
    var <- m[[last_hit]][2]

    # Skip trivial helpers that don't use tryCatch.
    trycatch_rel <- grep("^\\s*tryCatch\\s*\\(", body)
    if (length(trycatch_rel) == 0) next
    trycatch_first <- trycatch_rel[1]

    # Check if VAR is already assigned (= or <-) BEFORE the first tryCatch.
    before_block <- body[seq_len(trycatch_first - 1L)]
    assign_pat <- paste0("(^|[^A-Za-z0-9_.])", var, "\\s*(<-|=)(?!=)")
    already <- any(vapply(
      before_block,
      function(ln) grepl(assign_pat, ln, perl = TRUE),
      logical(1)
    ))
    if (already) next

    # Skip function arguments (named parameter defaults) — those would look like "VAR = ..."
    # within the signature lines. Signature lines run from start to open-brace line.
    sig_block <- lines[bounds$start:bounds$open]
    sig_pat <- paste0("(^|[,(])\\s*", var, "\\s*=")
    if (any(grepl(sig_pat, sig_block, perl = TRUE))) next

    # Also skip if the variable is one of the common R globals or likely a helper value.
    if (var %in% c("invisible", "NULL", "NA")) next

    # Inject `VAR <- NULL` just before the first tryCatch.
    trycatch_abs <- bounds$open + trycatch_first - 1L
    indent <- sub("[^ ].*$", "", lines[trycatch_abs])
    new_line <- paste0(indent, var, " <- NULL")
    lines <- append(lines, c(new_line, ""), after = trycatch_abs - 1L)
    patched_names <- c(patched_names, var)
  }

  if (length(patched_names) > 0L) writeLines(lines, f)
  patched_names
}

files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
total <- 0L
for (f in files) {
  names_patched <- tryCatch(patch_file(f), error = function(e) {
    message("ERROR in ", f, ": ", conditionMessage(e)); character(0)
  })
  if (length(names_patched) > 0L) {
    cat(f, "->", paste(names_patched, collapse = ", "), "\n")
    total <- total + length(names_patched)
  }
}
cat("Total return-var inits added:", total, "\n")
