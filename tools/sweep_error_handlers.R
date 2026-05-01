#!/usr/bin/env Rscript
# Sweep every R/*.R wrapper that uses tryCatch:
#   1. Inject `.args <- mget(setdiff(names(formals()), "..."))` near the top
#      of the function body if not already present.
#   2. Rewrite each `error = function(e) { ... }` handler to call
#      `.report_api_error(e, hint = "<extracted friendly message>",
#      args = .args)`.
#
# Idempotent: re-running modifies 0 files.
#
# Skips lines whose `error = function(e)` token is preceded by a `#` on the
# same line (i.e. they're inside a commented-out function body) — those are
# disabled deprecation stubs we don't want to touch.

count_char <- function(s, ch) {
  m <- gregexpr(ch, s, fixed = TRUE)[[1]]
  if (length(m) == 1L && m[1] == -1L) 0L else length(m)
}

# Returns TRUE if the `error = function(e)` token starts inside a comment
# (i.e. there's a `#` to its left on the same line, before the `e`).
is_commented_line <- function(line) {
  m <- regexpr("error\\s*=\\s*function\\s*\\(\\s*e\\s*\\)", line)
  if (m[1] == -1L) return(FALSE)
  prefix <- substr(line, 1L, m[1] - 1L)
  grepl("#", prefix, fixed = TRUE)
}

find_close_brace <- function(lines, from, start_depth = 1L) {
  depth <- start_depth
  n <- length(lines)
  for (j in from:n) {
    depth <- depth + count_char(lines[j], "{") - count_char(lines[j], "}")
    if (depth <= 0L) return(j)
  }
  NA_integer_
}

extract_first_alert_string <- function(body) {
  # Skip any commented-out lines.
  body_eff <- body[!grepl("^\\s*#", body)]
  joined <- paste(body_eff, collapse = "\n")
  # Try several friendly-message patterns in order of preference.
  patterns <- c(
    "cli::cli_alert_danger\\s*\\(\\s*\"",
    "message\\s*\\(\\s*glue::glue\\s*\\(\\s*\"",
    "message\\s*\\(\\s*glue\\s*\\(\\s*\"",
    "message\\s*\\(\\s*\""
  )
  for (pat in patterns) {
    m <- regexpr(pat, joined, perl = TRUE)
    if (m[1] != -1L) {
      start_pos <- m[1] + attr(m, "match.length")
      s <- substring(joined, start_pos)
      buf <- character(0)
      i <- 1L
      n <- nchar(s)
      escaped <- FALSE
      while (i <= n) {
        ch <- substr(s, i, i)
        if (escaped) {
          buf <- c(buf, ch)
          escaped <- FALSE
        } else if (ch == "\\") {
          buf <- c(buf, ch)
          escaped <- TRUE
        } else if (ch == "\"") {
          break
        } else {
          buf <- c(buf, ch)
        }
        i <- i + 1L
      }
      if (i > n) next
      return(paste(buf, collapse = ""))
    }
  }
  NA_character_
}

find_function_open_braces <- function(lines) {
  n <- length(lines)
  starts <- grep("^[A-Za-z_.][A-Za-z0-9_.]*\\s*<-\\s*function\\s*\\(", lines)
  out <- integer(0)
  for (s in starts) {
    j <- s
    while (j <= n && count_char(lines[j], "{") == 0L) j <- j + 1L
    if (j <= n) out <- c(out, j)
  }
  out
}

function_has_trycatch <- function(lines, open, close) {
  if (close <= open + 1L) return(FALSE)
  body <- lines[(open + 1L):(close - 1L)]
  # Only count uncommented tryCatch.
  body_eff <- body[!grepl("^\\s*#", body)]
  any(grepl("tryCatch\\s*\\(", body_eff))
}

function_has_args_capture <- function(lines, open, close) {
  body <- lines[(open + 1L):(close - 1L)]
  any(grepl("\\.args\\s*<-\\s*mget\\(", body))
}

inject_args_capture <- function(lines, open) {
  inj <- paste0("  .args <- mget(setdiff(names(formals()), \"...\"))")
  c(lines[seq_len(open)], inj, lines[(open + 1L):length(lines)])
}

rewrite_error_handlers <- function(lines, file) {
  unhandled <- character(0)
  i <- 1L
  while (i <= length(lines)) {
    matched <- grepl("error\\s*=\\s*function\\s*\\(\\s*e\\s*\\)\\s*\\{", lines[i])
    if (matched && !is_commented_line(lines[i])) {
      brace_pos <- regexpr("\\{", lines[i])
      after_brace <- substring(lines[i], brace_pos + 1L)
      depth <- 1L + count_char(after_brace, "{") - count_char(after_brace, "}")
      if (depth <= 0L) {
        i <- i + 1L
        next
      }
      end <- find_close_brace(lines, i + 1L, start_depth = depth)
      if (is.na(end)) {
        unhandled <- c(unhandled, paste0(file, ":", i, " | unbalanced brace"))
        i <- i + 1L
        next
      }
      body <- lines[(i + 1L):(end - 1L)]
      hint_str <- extract_first_alert_string(body)
      indent <- sub("[^ ].*$", "", lines[i])

      if (is.na(hint_str)) {
        unhandled <- c(unhandled, paste0(file, ":", i, " | no extractable hint"))
        i <- end + 1L
        next
      }

      hint_clean <- sub("^\\{Sys\\.time\\(\\)\\}:\\s*", "", hint_str)

      new_lines <- c(
        paste0(indent, "error = function(e) .report_api_error("),
        paste0(indent, "  e,"),
        paste0(indent, "  hint = \"", hint_clean, "\","),
        paste0(indent, "  args = .args"),
        paste0(indent, ")")
      )
      tail_after_close <- {
        ln <- lines[end]
        m <- regexpr("\\}", ln)
        if (m[1] == -1L) "" else substring(ln, m[1] + 1L)
      }
      if (nzchar(tail_after_close)) {
        new_lines[length(new_lines)] <- paste0(new_lines[length(new_lines)],
                                               tail_after_close)
      }
      lines <- c(lines[seq_len(i - 1L)], new_lines, lines[(end + 1L):length(lines)])
      i <- i + length(new_lines)
    } else {
      i <- i + 1L
    }
  }
  list(lines = lines, unhandled = unhandled)
}

# ---- Main sweep ----

files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
files <- setdiff(files, "R/utils.R")

n_args_injected <- 0L
n_handlers_rewritten <- 0L
all_unhandled <- character(0)

for (f in files) {
  lines <- readLines(f, warn = FALSE)
  orig <- lines

  rr <- rewrite_error_handlers(lines, f)
  lines <- rr$lines
  if (!identical(orig, lines)) {
    n_old <- sum(grepl("error\\s*=\\s*function\\s*\\(\\s*e\\s*\\)\\s*\\{", orig) &
                 !sapply(orig, is_commented_line))
    n_new <- sum(grepl("error\\s*=\\s*function\\s*\\(\\s*e\\s*\\)\\s*\\{", lines) &
                 !sapply(lines, is_commented_line))
    n_handlers_rewritten <- n_handlers_rewritten + (n_old - n_new)
  }
  if (length(rr$unhandled) > 0) all_unhandled <- c(all_unhandled, rr$unhandled)

  open_braces <- find_function_open_braces(lines)
  for (ob in rev(open_braces)) {
    cb <- find_close_brace(lines, ob + 1L,
                           start_depth = count_char(lines[ob], "{") - count_char(lines[ob], "}"))
    if (is.na(cb)) next
    if (!function_has_trycatch(lines, ob, cb)) next
    if (function_has_args_capture(lines, ob, cb)) next
    lines <- inject_args_capture(lines, ob)
    n_args_injected <- n_args_injected + 1L
  }

  if (!identical(orig, lines)) writeLines(lines, f)
}

cat("== Sweep summary ==\n")
cat("Handlers rewritten:    ", n_handlers_rewritten, "\n")
cat(".args lines injected: ", n_args_injected, "\n")
cat("Unhandled handlers:   ", length(all_unhandled), "\n")
if (length(all_unhandled) > 0) {
  cat("\n== Unhandled (need manual fix) ==\n")
  for (u in all_unhandled) cat(u, "\n")
}
