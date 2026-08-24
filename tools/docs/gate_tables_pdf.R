## gate_tables_pdf.R
## ------------------
## Lever 1 of the win-builder manual-build time reduction: gate large
## roxygen markdown @return / @details column tables (>= GATE_MIN_ROWS
## data rows) out of the PDF manual while keeping them in HTML help +
## pkgdown. Small tables (< GATE_MIN_ROWS rows) are left as plain
## markdown -- roxygen2 renders those to a normal (ungated) Rd
## \tabular{} block that still shows in the PDF, which is fine at that
## size.
##
## Mechanics: a gated table is emitted as raw Rd (roxygen2 (markdown =
## TRUE) passes through Rd macros/backslash markup verbatim -- verified
## against real \code{}/\verb{} usage already present in this repo's
## table cells, and against a pilot conversion of espn_wbb_coach.R):
##
##   \if{html}{\tabular{lll}{
##      col_name \tab types \tab description \cr
##      ...
##   }}
##   \if{latex}{See the HTML help or pkgdown reference for the column table.}
##
## Rather than re-deriving roxygen2's markdown-to-Rd escaping rules by
## hand (backtick code-spans -> \verb{}, literal \%, \{, \} escaping --
## all already exercised correctly by the *existing* markdown pipeline),
## this script ROUND-TRIPS through the already-correct, already-committed
## man/*.Rd: for each qualifying source table block it locates the
## positionally-matching \tabular{}{} block already sitting in the
## function's current .Rd (from a normal, pre-gating `devtools::document()`
## pass) and splices that exact, already-escaped text into the gated
## wrapper. This guarantees byte-identical table content pre/post gating.
##
## Usage (from the package root, after ensuring man/ is in sync):
##   Rscript tools/docs/gate_tables_pdf.R            # sweep R/*.R in place
##   Rscript tools/docs/gate_tables_pdf.R --dry-run   # report only
##
## Idempotent: a doc-block whose @return/@details already contains
## \if{html}{ has all of its table blocks skipped (nothing left to gate).
## Also honors the existing dedup guard: a doc-block containing a
## [..._schema] link has its table blocks skipped (there aren't any --
## those are link lines, not tables -- but the guard is kept for parity
## with tools/docs/markdown_man_table_helper.R).

GATE_MIN_ROWS <- 8L

args <- commandArgs(trailingOnly = TRUE)
dry_run <- "--dry-run" %in% args

is_table_row <- function(s) grepl("^#'\\s*\\|[^|]+\\|[^|]+\\|", s, perl = TRUE)
is_separator <- function(s) grepl("^#'\\s*\\|[-: ]+\\|", s, perl = TRUE)
is_roxy      <- function(s) grepl("^#'", s)

## ---- doc-block boundaries (contiguous runs of `#'` lines) ----
doc_blocks <- function(lines) {
  n <- length(lines)
  out <- list()
  k <- 1
  while (k <= n) {
    if (is_roxy(lines[k])) {
      bstart <- k
      while (k <= n && is_roxy(lines[k])) k <- k + 1
      bend <- k - 1
      out[[length(out) + 1]] <- c(bstart, bend)
    } else {
      k <- k + 1
    }
  }
  out
}

## Falls back to the name of the function immediately following the
## doc-block when there is no explicit @rdname/@name tag (roxygen2's own
## fallback rule for topic naming).
block_rdname <- function(block_lines, all_lines, bend) {
  m <- regmatches(block_lines, regexpr("(?<=@rdname\\s)\\S+", block_lines, perl = TRUE))
  m <- m[nzchar(m)]
  if (length(m) > 0) return(m[1])
  m <- regmatches(block_lines, regexpr("(?<=@name\\s)\\S+", block_lines, perl = TRUE))
  m <- m[nzchar(m)]
  if (length(m) > 0) return(m[1])
  n <- length(all_lines)
  i <- bend + 1L
  while (i <= n && !nzchar(trimws(all_lines[i]))) i <- i + 1L
  if (i <= n) {
    fm <- regmatches(all_lines[i], regexpr("^([A-Za-z0-9_.]+)(?=\\s*<-\\s*function)", all_lines[i], perl = TRUE))
    if (length(fm) > 0 && nzchar(fm[1])) return(fm[1])
  }
  NA_character_
}

block_already_gated <- function(block_lines) {
  any(grepl("\\\\if\\{html\\}", block_lines))
}

block_schema_guarded <- function(block_lines) {
  any(grepl("\\[[A-Za-z0-9_.]+_schema\\]", block_lines))
}

## ---- table blocks (contiguous `#' |a|b|` runs) within a doc-block ----
## Returns a list of c(start, end) line indices (relative to the full file).
find_table_blocks <- function(lines, bstart, bend) {
  out <- list()
  i <- bstart
  while (i <= bend) {
    if (is_table_row(lines[i])) {
      j <- i
      while (j <= bend && is_table_row(lines[j])) j <- j + 1
      out[[length(out) + 1]] <- c(i, j - 1)
      i <- j
    } else {
      i <- i + 1
    }
  }
  out
}

data_row_count <- function(block) {
  rows <- block[!vapply(block, is_separator, logical(1))]
  max(0L, length(rows) - 1L)  ## minus header row
}

## ---- extract \tabular{..}{ ... } blocks (brace-balanced) from Rd text ----
extract_tabular_blocks <- function(rd_text) {
  blocks <- character()
  pos <- 1L
  n <- nchar(rd_text)
  repeat {
    rel <- regexpr("\\\\tabular\\{[a-z]+\\}\\{", substring(rd_text, pos), perl = TRUE)
    if (rel == -1L) break
    start_abs <- pos + rel - 1L
    match_len <- attr(rel, "match.length")
    i <- start_abs + match_len  ## just past the content-opening '{'
    depth <- 1L
    while (depth > 0L && i <= n) {
      ch <- substr(rd_text, i, i)
      if (ch == "\\" && i < n && substr(rd_text, i + 1L, i + 1L) %in% c("{", "}")) {
        i <- i + 2L
        next
      }
      if (ch == "{") depth <- depth + 1L
      else if (ch == "}") depth <- depth - 1L
      i <- i + 1L
    }
    content_end <- i - 1L
    blocks <- c(blocks, substring(rd_text, start_abs, content_end))
    pos <- content_end + 1L
  }
  blocks
}

## ---- build the gated replacement lines for one source table block ----
gate_replacement <- function(prefix, tabular_block_text) {
  body_lines <- strsplit(tabular_block_text, "\n", fixed = TRUE)[[1]]
  body_lines[1] <- paste0("\\if{html}{", body_lines[1])
  last <- length(body_lines)
  body_lines[last] <- paste0(body_lines[last], "}")
  out <- paste0(prefix, body_lines)
  c(out,
    paste0(prefix, "\\if{latex}{See the HTML help or pkgdown reference for the column table.}"))
}

process_file <- function(r_path, man_dir = "man", dry_run = FALSE) {
  lines <- readLines(r_path, warn = FALSE)
  blocks <- doc_blocks(lines)
  edits <- list()  ## list of list(start, end, replacement)
  gated_count <- 0L

  ## Multiple doc-blocks (functions) can already share ONE rd_path -- an
  ## @rdname family merged by a previous run/session before this file was
  ## gated. extract_tabular_blocks() on that shared Rd returns ALL of the
  ## family's tables concatenated (in doc-block/file order), so each
  ## doc-block must consume the NEXT still-unclaimed slice, not restart at
  ## index 1 -- restarting silently spliced the wrong function's table
  ## into every member after the first (verified against a real corruption:
  ## load_nba_stats_draft's rendered table came back byte-identical to
  ## load_nba_stats_coaches's). Cache the parsed tabulars + a running
  ## per-rd_path cursor across the whole blocks loop.
  rd_cache <- new.env(parent = emptyenv())

  for (b in blocks) {
    bstart <- b[1]; bend <- b[2]
    block_lines <- lines[bstart:bend]
    if (block_already_gated(block_lines)) next
    if (block_schema_guarded(block_lines)) next

    tbls <- find_table_blocks(lines, bstart, bend)
    if (length(tbls) == 0) next

    rdname <- block_rdname(block_lines, lines, bend)
    if (is.na(rdname)) next
    rd_path <- file.path(man_dir, paste0(rdname, ".Rd"))
    if (!file.exists(rd_path)) next

    if (!exists(rd_path, envir = rd_cache, inherits = FALSE)) {
      rd_text <- paste(readLines(rd_path, warn = FALSE), collapse = "\n")
      assign(rd_path, list(tabulars = extract_tabular_blocks(rd_text), offset = 0L),
             envir = rd_cache)
    }
    cached <- get(rd_path, envir = rd_cache, inherits = FALSE)
    rd_tabulars <- cached$tabulars
    offset <- cached$offset
    if (length(rd_tabulars) < offset + length(tbls)) next  ## out of sync -- skip, don't guess

    for (idx in seq_along(tbls)) {
      tb <- tbls[[idx]]
      tstart <- tb[1]; tend <- tb[2]
      block <- lines[tstart:tend]
      if (data_row_count(block) < GATE_MIN_ROWS) next

      hdr <- block[!vapply(block, is_separator, logical(1))][1]
      prefix_match <- regmatches(hdr, regexec("^(#'\\s*)\\|", hdr, perl = TRUE))[[1]]
      if (length(prefix_match) < 2) next
      prefix <- prefix_match[2]

      repl <- gate_replacement(prefix, rd_tabulars[[offset + idx]])
      edits[[length(edits) + 1]] <- list(start = tstart, end = tend, repl = repl)
      gated_count <- gated_count + 1L
    }

    assign(rd_path, list(tabulars = rd_tabulars, offset = offset + length(tbls)),
           envir = rd_cache)
  }

  if (length(edits) == 0) return(0L)

  ## apply bottom-to-top so earlier indices stay valid
  ord <- order(vapply(edits, function(e) as.numeric(e$start), numeric(1)), decreasing = TRUE)
  new_lines <- lines
  for (k in ord) {
    e <- edits[[k]]
    new_lines <- c(new_lines[seq_len(e$start - 1L)],
                    e$repl,
                    new_lines[seq((e$end + 1L), length(new_lines))])
  }

  if (!dry_run) writeLines(new_lines, r_path)
  gated_count
}

main <- function() {
  r_files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
  total <- 0L
  per_file <- integer(0)
  for (f in r_files) {
    n <- process_file(f, dry_run = dry_run)
    if (n > 0) {
      per_file[basename(f)] <- n
      total <- total + n
    }
  }
  cat(sprintf("%s%d table block(s) gated across %d file(s).\n",
              if (dry_run) "[dry-run] " else "", total, length(per_file)))
  if (length(per_file) > 0) {
    for (nm in names(per_file)) cat(sprintf("  %-45s %d\n", nm, per_file[nm]))
  }
}

if (sys.nframe() == 0) main()
