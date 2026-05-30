#!/usr/bin/env Rscript
# Gen-2 fix on top of patch_return_var_init.R.
#
# patch_return_var_init.R injected `<var> <- NULL` to prevent the worse
# "object '<var>' not found" runtime error when the tryCatch error handler
# fires. That left a softer bug: tibble-returning functions silently
# return NULL on API failure, breaking downstream `bind_rows()` and the
# canonical skip-guard pattern.
#
# CLAUDE.md "Return-Value Initialization": "initialize to data.frame()
# for tibble returns". This script converts `<var> <- NULL` to
# `<var> <- data.frame()` ONLY for functions whose body calls
# `make_hoopR_data(` -- i.e. tibble returns. List-returning functions
# (named-list aggregators like `espn_*_team()`, `espn_*_game_all()`,
# `espn_*_athlete_info()`) keep their NULL init because `list()` would
# also be fine but is a separate semantic.

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

  patched <- character(0)

  for (bounds in rev(bounds_list)) {
    body <- lines[bounds$open:bounds$end]

    # Identify the return variable (must be simple identifier).
    m <- regmatches(body, regexec("^\\s*return\\(([A-Za-z_.][A-Za-z0-9_.]*)\\)\\s*$", body))
    hits <- which(vapply(m, function(x) length(x) > 0, logical(1)))
    if (length(hits) == 0) next
    last_hit <- tail(hits, 1)
    var <- m[[last_hit]][2]

    # Only tibble returns: body must call make_hoopR_data(.
    if (!any(grepl("make_hoopR_data\\(", body, perl = TRUE))) next

    # Find the outer init line: `<spaces><var> <- NULL` BEFORE the first tryCatch.
    trycatch_rel <- grep("^\\s*tryCatch\\s*\\(", body)
    if (length(trycatch_rel) == 0) next
    trycatch_first <- trycatch_rel[1]

    before_block_idx <- seq_len(trycatch_first - 1L)
    null_pat <- paste0("^(\\s*)", var, "\\s*<-\\s*NULL\\s*$")
    init_matches <- which(grepl(null_pat, body[before_block_idx], perl = TRUE))
    if (length(init_matches) == 0) next

    # Replace the LAST such init (in case there are multiple — shouldn't be).
    init_rel <- tail(init_matches, 1)
    init_abs <- bounds$open + init_rel - 1L
    indent <- sub("[^ ].*$", "", lines[init_abs])
    lines[init_abs] <- paste0(indent, var, " <- data.frame()")
    patched <- c(patched, var)
  }

  if (length(patched) > 0L) writeLines(lines, f)
  patched
}

files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
total <- 0L
per_file <- list()
for (f in files) {
  names_patched <- tryCatch(patch_file(f), error = function(e) {
    message("ERROR in ", f, ": ", conditionMessage(e)); character(0)
  })
  if (length(names_patched) > 0L) {
    cat(f, "->", paste(names_patched, collapse = ", "), "\n")
    total <- total + length(names_patched)
    per_file[[f]] <- names_patched
  }
}
cat("\nTotal tibble-return inits converted (NULL -> data.frame()):", total, "\n")
