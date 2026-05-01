#!/usr/bin/env Rscript
# Local replacement for `doctoc` (https://github.com/thlorenz/doctoc).
# Generates a Markdown table-of-contents inside the standard doctoc marker
# comments. Idempotent. Writes nothing if the rendered TOC matches what's
# already between the markers.
#
# Usage:
#   Rscript tools/run_doctoc.R [--maxlevel 3] file1.md [file2.md ...]
#
# If a target file lacks doctoc markers, they will be inserted near the top:
# below any leading YAML front-matter (`--- ... ---`) or, if absent, at the
# very top of the file. The generated block reproduces doctoc's exact
# wrapping comments so the next run is a no-op when no headings have changed.

# ---------- argument parsing ----------
args <- commandArgs(trailingOnly = TRUE)
maxlevel <- 3L
i <- 1L
files <- character(0)
while (i <= length(args)) {
  a <- args[i]
  if (a %in% c("--maxlevel", "-d")) {
    maxlevel <- as.integer(args[i + 1L])
    i <- i + 2L
  } else if (startsWith(a, "--maxlevel=")) {
    maxlevel <- as.integer(sub("^--maxlevel=", "", a))
    i <- i + 1L
  } else {
    files <- c(files, a)
    i <- i + 1L
  }
}
if (length(files) == 0L) {
  message("usage: Rscript tools/run_doctoc.R [--maxlevel N] file1.md [...]")
  quit(status = 0L)
}

# ---------- helpers ----------

`%||%` <- function(a, b) if (is.null(a)) b else a

# GitHub anchor: lowercase, spaces -> '-', drop most punctuation but keep
# alphanumerics, '-', and '_'. `seen` must be an environment; the function
# mutates it to track duplicate anchors and append '-1', '-2', etc.
make_anchor <- function(text, seen) {
  raw <- gsub("`", "", text, fixed = TRUE)
  raw <- gsub("\\*+", "", raw)
  raw <- gsub("\\[([^\\]]*)\\]\\([^\\)]*\\)", "\\1", raw, perl = TRUE)
  raw <- tolower(raw)
  raw <- gsub("[^[:alnum:][:space:]_-]", "", raw, perl = TRUE)
  raw <- gsub("\\s+", "-", raw, perl = TRUE)
  raw <- gsub("^-+|-+$", "", raw, perl = TRUE)

  count <- if (exists(raw, envir = seen, inherits = FALSE)) {
    get(raw, envir = seen, inherits = FALSE)
  } else 0L
  assign(raw, count + 1L, envir = seen)
  if (count > 0L) raw <- paste0(raw, "-", count)
  raw
}

# Walk lines, return list(level, text) for each ATX heading outside fenced
# code blocks. Includes every heading at level <= maxlevel; matches the npm
# doctoc CLI's default behavior. (An earlier revision of this script skipped
# the first level-1 heading as a page title, which mis-handled NEWS.md where
# the top heading is itself a release entry that belongs in the TOC.)
extract_headings <- function(lines, maxlevel) {
  in_fence <- FALSE
  fence_marker <- ""
  out <- vector("list", 0L)
  for (ln in lines) {
    fence_match <- regmatches(ln, regexpr("^\\s*(```+|~~~+)", ln, perl = TRUE))
    if (length(fence_match) > 0L) {
      m <- sub("^\\s*", "", fence_match)
      if (!in_fence) {
        in_fence <- TRUE
        fence_marker <- m
      } else if (startsWith(ln, paste0(strsplit(fence_marker, "")[[1]][1]))) {
        in_fence <- FALSE
        fence_marker <- ""
      }
      next
    }
    if (in_fence) next
    m <- regmatches(ln, regexpr("^(#+)\\s+(.+?)\\s*#*\\s*$", ln, perl = TRUE))
    if (length(m) == 0L) next
    pieces <- regmatches(ln, regexec("^(#+)\\s+(.+?)\\s*#*\\s*$", ln, perl = TRUE))[[1]]
    if (length(pieces) < 3L) next
    hashes <- pieces[2]
    text <- pieces[3]
    level <- nchar(hashes)
    if (level > maxlevel) next
    out[[length(out) + 1L]] <- list(level = level, text = text)
  }
  out
}

render_toc <- function(headings) {
  if (length(headings) == 0L) return(character(0))
  seen <- new.env(parent = emptyenv())
  # Lowest level present in the doc becomes the top of the indent; doctoc
  # however uses level-2 as the top by convention. We follow doctoc.
  base_level <- 2L
  out <- character(length(headings))
  for (i in seq_along(headings)) {
    h <- headings[[i]]
    indent <- strrep("  ", max(0L, h$level - base_level))
    anchor <- make_anchor(h$text, seen)
    # Keep heading text verbatim (preserve backticks/links so the rendered
    # nav reads naturally).
    out[i] <- paste0(indent, "- [", h$text, "](#", anchor, ")")
  }
  out
}

START_MARK <- "<!-- START doctoc generated TOC please keep comment here to allow auto update -->"
EDIT_NOTE  <- "<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->"
TOC_HDR    <- "**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*"
END_MARK   <- "<!-- END doctoc generated TOC please keep comment here to allow auto update -->"

build_block <- function(toc_lines) {
  c(
    START_MARK,
    EDIT_NOTE,
    TOC_HDR,
    "",
    toc_lines,
    "",
    END_MARK
  )
}

# Find marker line indexes in a `lines` vector. Returns NULL if not found.
find_marker_range <- function(lines) {
  s <- which(lines == START_MARK)
  e <- which(lines == END_MARK)
  if (length(s) >= 1L && length(e) >= 1L && e[1] > s[1]) {
    return(c(s[1], e[1]))
  }
  # Fallback: detect the legacy form (no exact-match line) — find by partial
  # text. Some hand-edited files drift the wrapping comments.
  s_alt <- grep("START doctoc generated TOC", lines, fixed = TRUE)
  e_alt <- grep("END doctoc generated TOC", lines, fixed = TRUE)
  if (length(s_alt) >= 1L && length(e_alt) >= 1L && e_alt[1] > s_alt[1]) {
    return(c(s_alt[1], e_alt[1]))
  }
  NULL
}

# Locate the line index immediately AFTER the leading YAML front-matter
# (`--- ... ---` at top-of-file). Returns 0L if no front-matter present.
find_yaml_end <- function(lines) {
  if (length(lines) == 0L) return(0L)
  if (!grepl("^---\\s*$", lines[1])) return(0L)
  closes <- which(grepl("^---\\s*$", lines[-1])) + 1L
  if (length(closes) == 0L) return(0L)
  closes[1]
}

process_file <- function(file, maxlevel) {
  if (!file.exists(file)) {
    message("skip (missing): ", file)
    return(invisible(FALSE))
  }
  lines <- readLines(file, warn = FALSE)
  headings <- extract_headings(lines, maxlevel)
  if (length(headings) == 0L) {
    message("skip (no headings): ", file)
    return(invisible(FALSE))
  }
  toc <- render_toc(headings)
  block <- build_block(toc)

  rng <- find_marker_range(lines)
  new_lines <- if (!is.null(rng)) {
    c(lines[seq_len(rng[1] - 1L)], block, lines[(rng[2] + 1L):length(lines)])
  } else {
    yaml_end <- find_yaml_end(lines)
    if (yaml_end > 0L) {
      c(lines[seq_len(yaml_end)], "", block, "", lines[(yaml_end + 1L):length(lines)])
    } else {
      c(block, "", lines)
    }
  }

  # Trim trailing whitespace consistency: avoid spurious diffs by collapsing
  # the inserted block into the same line endings.
  if (identical(lines, new_lines)) {
    message("ok (no change): ", file)
    return(invisible(FALSE))
  }
  writeLines(new_lines, file)
  message("updated: ", file)
  invisible(TRUE)
}

# ---------- main ----------
changed <- 0L
for (f in files) {
  if (process_file(f, maxlevel)) changed <- changed + 1L
}
cat("== run_doctoc summary ==\n")
cat("files processed: ", length(files), "\n")
cat("files updated:   ", changed, "\n")
