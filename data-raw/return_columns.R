# Build `return_columns`: one row per column of every data frame a hoopR
# function returns, from data-raw/return_columns.csv.
#
# Run from the package root:
#   Rscript data-raw/return_columns.R            # CSV -> data/return_columns.rda
#   Rscript data-raw/return_columns.R --extract  # re-run the one-off extraction
# Needs roxygen2 (for --extract) and usethis. Makes no network calls.
#
# data-raw/return_columns.csv is the source of truth. It feeds
#   * data/return_columns.rda (this script), and
#   * every function's `@return` section: `@eval .returns_rd("fn")` in R/
#     renders the column table from the CSV at devtools::document() time
#     (R/families.R), or, with `inline = FALSE`, a pointer to the dataset.
# A new or changed function gets its rows here, then re-run both steps.
#
# --extract recreates the CSV from the hand-written `@return` tables as they
# stood at commit 2261aa10b (the last commit before the migration), so the
# extraction stays reproducible after those tables were removed. It parses each
# roxygen block's `@return` with roxygen2, converts it to Rd and reads every
# `\tabular` in it. A table's component is the bold heading above it (`NA` for
# a single data frame); "Same columns as the **X** table above." copies X's
# rows, and a link to a shared `*_schema` topic (R/hoopR_schemas.R) copies that
# topic's table. Descriptions keep their inline code as `backticks`.

args <- commandArgs(trailingOnly = TRUE)
csv_path <- "data-raw/return_columns.csv"

# ---- Rd text helpers -----------------------------------------------------------
# Index of the brace that closes the one opening at `open` (a "{"), skipping
# escaped characters.
match_brace <- function(ch, open) {
  depth <- 0L
  i <- open
  while (i <= length(ch)) {
    c1 <- ch[i]
    if (c1 == "\\") {
      i <- i + 2L
      next
    }
    if (c1 == "{") depth <- depth + 1L
    if (c1 == "}") {
      depth <- depth - 1L
      if (depth == 0L) return(i)
    }
    i <- i + 1L
  }
  stop("unbalanced braces", call. = FALSE)
}

# Rd fragment -> plain text with markdown inline code: \code{x}/\verb{x} ->
# `x`, a function link -> [x()], \emph{x}/\strong{x} -> x (the cells use
# literal asterisks), then unescape.
rd_to_text <- function(s) {
  wrap <- c(code = "`", verb = "`", emph = "", strong = "", link = "")
  s <- gsub("\\\\code\\{\\\\link\\[=[^]]+\\]\\{([^{}]+)\\}\\}", "[\\1]", s)
  s <- gsub("\\\\link\\[=[^]]+\\]\\{([^{}]+)\\}", "[\\1]", s)
  repeat {
    m <- regexpr("\\\\(code|verb|emph|strong|link)\\{", s, perl = TRUE)
    if (m < 0) break
    macro <- sub("^\\\\(\\w+)\\{$", "\\1", regmatches(s, m))
    ch <- strsplit(s, "")[[1]]
    open <- m + attr(m, "match.length") - 1L
    close <- match_brace(ch, open)
    inner <- if (close > open + 1L) paste(ch[(open + 1L):(close - 1L)], collapse = "") else ""
    if (macro %in% c("code", "verb")) inner <- gsub("\\\\([%{}\\\\])", "\\1", inner)
    rep <- if (macro == "link") paste0("[", inner, "]") else paste0(wrap[[macro]], inner, wrap[[macro]])
    s <- paste0(substr(s, 1L, m - 1L), rep, substr(s, close + 1L, nchar(s)))
  }
  s <- gsub("\\\\([%{}])", "\\1", s)
  s <- gsub("\\\\\\\\", "\\\\", s)
  if (grepl("\\\\[a-zA-Z]", s)) stop("unhandled Rd markup in: ", s, call. = FALSE)
  trimws(gsub("\\s+", " ", s))
}

# Split an Rd fragment into a list of segments: list(type = "text", text) or
# list(type = "table", rows = <character matrix, header first>).
rd_segments <- function(rd) {
  segs <- list()
  repeat {
    m <- regexpr("\\\\tabular\\{l+\\}\\{", rd, perl = TRUE)
    if (m < 0) break
    ch <- strsplit(rd, "")[[1]]
    open <- m + attr(m, "match.length") - 1L
    close <- match_brace(ch, open)
    body <- paste(ch[(open + 1L):(close - 1L)], collapse = "")
    rows <- trimws(strsplit(body, "\\\\cr")[[1]])
    rows <- rows[nzchar(rows)]
    cells <- lapply(rows, function(r) trimws(strsplit(paste0(r, " "), "\\\\tab")[[1]]))
    ncell <- lengths(cells)
    if (length(unique(ncell)) != 1L) stop("ragged table: ", substr(body, 1, 200), call. = FALSE)
    segs[[length(segs) + 1L]] <- list(type = "text", text = substr(rd, 1L, m - 1L))
    segs[[length(segs) + 1L]] <- list(type = "table", rows = do.call(rbind, cells))
    rd <- substr(rd, close + 1L, nchar(rd))
  }
  segs[[length(segs) + 1L]] <- list(type = "text", text = rd)
  segs
}

table_df <- function(rows) {
  hdr <- tolower(rows[1, ])
  body <- rows[-1, , drop = FALSE]
  # A row with no name continues the description of the row above.
  cont <- which(!nzchar(body[, 1]))
  for (i in rev(cont)) body[i - 1L, ncol(body)] <- paste(body[i - 1L, ncol(body)], body[i, ncol(body)])
  if (length(cont)) body <- body[-cont, , drop = FALSE]
  if (hdr[1] != "col_name") stop("table header is not col_name: ", paste(hdr, collapse = "|"), call. = FALSE)
  pick <- function(nms) {
    j <- which(hdr %in% nms)
    if (length(j)) vapply(body[, j[1]], rd_to_text, "") else rep(NA_character_, nrow(body))
  }
  data.frame(
    col_name = vapply(body[, 1], rd_to_text, ""),
    type = pick(c("type", "types")),
    description = pick("description"),
    stringsAsFactors = FALSE, row.names = NULL
  )
}

# The component a heading line names, or NA. A heading is a bold line, alone
# or followed by " -- <note>" or " (<note>)" ("**calls** -- one row per
# graded play"); "**teams: one row per team**" names `teams`. A bare
# identifier on a line of its own ("PlayerStats") is a heading too.
heading <- function(ln) {
  if (grepl("^[A-Za-z][A-Za-z0-9_]*$", ln)) return(ln)
  if (!startsWith(ln, "\\strong{")) return(NA_character_)
  ch <- strsplit(ln, "")[[1]]
  close <- match_brace(ch, nchar("\\strong{"))
  rest <- trimws(substr(ln, close + 1L, nchar(ln)))
  if (nzchar(rest) && !grepl("^(--|\\()", rest)) return(NA_character_)
  h <- rd_to_text(substr(ln, nchar("\\strong{") + 1L, close - 1L))
  sub("^([A-Za-z][A-Za-z0-9_]*): .*$", "\\1", h)
}

# Parse one block's `@return` Rd into a data frame of rows (component,
# col_name, type, description). `schemas` maps topic name -> data frame.
parse_return <- function(rd, schemas, where) {
  segs <- rd_segments(rd)
  out <- list()
  comp <- NA_character_
  for (sg in segs) {
    if (sg$type == "table") {
      df <- table_df(sg$rows)
      out[[length(out) + 1L]] <- cbind(component = comp, df, stringsAsFactors = FALSE)
      next
    }
    for (ln in trimws(strsplit(sg$text, "\n")[[1]])) {
      h <- heading(ln)
      if (!is.na(h)) {
        comp <- h
        next
      }
      same <- regmatches(ln, regexec("Same columns as the \\\\strong\\{([^{}]+)\\} table above", ln))[[1]]
      if (length(same)) {
        prev <- do.call(rbind, out)
        src <- prev[!is.na(prev$component) & prev$component == same[2], ]
        if (!nrow(src)) stop(where, ": no earlier table ", same[2], call. = FALSE)
        src$component <- comp
        out[[length(out) + 1L]] <- src
        next
      }
      sch <- regmatches(ln, regexec("\\\\link\\{([A-Za-z0-9_.]+_schema)\\}", ln))[[1]]
      if (length(sch)) {
        df <- schemas[[sch[2]]]
        if (is.null(df)) stop(where, ": unknown schema ", sch[2], call. = FALSE)
        out[[length(out) + 1L]] <- cbind(component = comp, df, stringsAsFactors = FALSE)
      }
    }
  }
  if (!length(out)) return(NULL)
  do.call(rbind, out)
}

block_object <- function(b) {
  call <- b$call
  if (is.call(call) && (identical(call[[1]], as.name("<-")) || identical(call[[1]], as.name("="))))
    return(as.character(call[[2]]))
  NA_character_
}

extract <- function(ref = "2261aa10b") {
  src <- file.path(tempdir(), paste0("hoopR-", ref))
  dir.create(src, showWarnings = FALSE)
  tarball <- file.path(tempdir(), "r-src.tar")
  system2("git", c("archive", "--format=tar", "-o", shQuote(tarball), ref, "R"))
  utils::untar(tarball, exdir = src)
  files <- sort(list.files(file.path(src, "R"), "[.][Rr]$", full.names = TRUE))
  blocks <- unlist(lapply(files, roxygen2::parse_file, env = NULL), recursive = FALSE)

  # Shared schema topics: their table sits in the block's description.
  schemas <- list()
  for (b in blocks) {
    nm <- roxygen2::block_get_tag_value(b, "name")
    if (is.null(nm) || !grepl("_schema$", nm)) next
    raw <- paste(vapply(b$tags, function(t) if (t$tag %in% c("title", "description", "details")) t$raw else "", ""), collapse = "\n")
    segs <- rd_segments(roxygen2:::markdown(raw))
    tab <- Filter(function(s) s$type == "table", segs)
    if (length(tab) != 1L) stop("schema ", nm, " has ", length(tab), " tables", call. = FALSE)
    schemas[[nm]] <- table_df(tab[[1]]$rows)
  }

  rows <- list()
  for (b in blocks) {
    ret <- roxygen2::block_get_tags(b, c("return", "returns"))
    if (!length(ret)) next
    fn <- block_object(b)
    if (is.na(fn) || length(roxygen2::block_get_tags(b, "noRd"))) next
    rd <- roxygen2:::markdown(ret[[1]]$raw)
    df <- parse_return(rd, schemas, paste0(basename(b$file), ":", b$line, " ", fn))
    if (is.null(df)) next
    rows[[length(rows) + 1L]] <- cbind(fn = fn, df, stringsAsFactors = FALSE)
  }
  out <- do.call(rbind, rows)
  if (all(is.na(out$description))) out$description <- NULL
  out
}

if ("--extract" %in% args) {
  rc <- extract()
  utils::write.csv(rc, csv_path, row.names = FALSE, na = "")
  message("wrote ", nrow(rc), " rows for ", length(unique(rc$fn)), " functions to ", csv_path)
}

# ---- CSV -> data/return_columns.rda --------------------------------------------
return_columns <- utils::read.csv(csv_path, stringsAsFactors = FALSE, na.strings = "",
                                  colClasses = "character", encoding = "UTF-8")
return_columns <- return_columns[order(return_columns$fn, seq_len(nrow(return_columns))), ]
return_columns <- tibble::as_tibble(return_columns)
stopifnot(!anyNA(return_columns$fn), !anyNA(return_columns$col_name))
usethis::use_data(return_columns, overwrite = TRUE, compress = "xz")
