## markdown_man_table_helper.R
## ----------------------------
## Two-section file:
##   (A) Legacy paste-snippet hand-tools — designed for interactive
##       use in RStudio when a free `x` is bound in the global env.
##       Wrapped in `if (FALSE) {}` so the file is safely sourceable.
##   (B) Programmatic three-column @return table tooling — loads a
##       column-description dictionary built by
##       tools/docs/build_column_descriptions.R and augments existing
##       roxygen tables from |col_name|types| to |col_name|types|description|.
##
## High-level usage of (B):
##
##   source("tools/docs/markdown_man_table_helper.R")
##   dict <- load_column_descriptions()
##
##   # Live: just got `x` back from a wrapper, want a fresh 3-col block
##   roxygenize_return(x, dict, lead = "Returns a named list of data frames:")
##
##   # Augment one R file in place
##   augment_return_tables_in_file("R/wnba_stats_boxscore_v3.R", dict,
##                                 in_place = TRUE)
##
##   # Sweep every R/*.R file
##   augment_all_r_files(dict, in_place = TRUE)
##
## Idempotent: re-running augment is safe — already-3-col tables are
## refreshed from the dictionary rather than gaining a fourth column.

## =====================================================================
## (A) Legacy paste-snippet hand-tools — reference only, never executes.
## =====================================================================

if (FALSE) {

cat(colnames(x), sep = '",\n"')
df <- data.frame(col_name = colnames(x), types = sapply(x, function(y){class(y)[1]}))
df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE)

x %>% knitr::kable()

testy <- function(func) {
  # Extract the parameters of the given function
  params <- formals(func)

  # Loop through each parameter and assign it to the global environment
  for (param_name in names(params)) {
    # Use 'assign' to put each parameter in the global environment
    assign(param_name, eval(params[[param_name]]), envir = .GlobalEnv)
  }

  cat("Parameters have been assigned to the global environment.\n")
}

## WNBA Stats Tests Helper
purrr::walk(names(x), function(y){

  print(glue::glue("\n\n {y} \n\n"))
  # cat('c(\n"')
  cat(colnames(x[[y]]), sep = '",\n"')
  # cat('\n')
  # cat('\n')
})

cat(names(x), sep = ', ')
## WNBA Stats Roxygen Docs Helper
purrr::walk(names(x), function(y){

  print(glue::glue("\n\n **{y}** "))
  if (length(x[[y]]) > 0) {
    df <- data.frame(col_name = colnames(x[[y]]), types = sapply(x[[y]], function(y){class(y)[1]}))
    df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE) %>%
      print()
  }
})

} ## end legacy paste-snippet reference block

## =====================================================================
## (B) Programmatic three-column @return table tooling.
## =====================================================================

suppressPackageStartupMessages({
  library(stringr)
  library(dplyr)
  library(readr)
})

## ----- Dictionary load -----

load_column_descriptions <- function(
    path = "tools/docs/column_descriptions.csv") {
  if (!file.exists(path)) {
    stop("Dictionary not found at ", path,
         ". Run tools/docs/build_column_descriptions.R first.")
  }
  read_csv(path, show_col_types = FALSE)
}

## ----- Description lookup -----

lookup_description <- function(col_name, dict, fallback = "") {
  cn <- tolower(col_name)
  hit <- dict$description[dict$col_name == cn]
  if (length(hit) == 0) return(fallback)
  hit[1]
}

## ----- Fresh table generator (live, three-column) -----
##
## Given a data frame `x`, returns a character vector of lines in the
## form
##     #'    |col_name |types     |description |
## ready to paste into a roxygen @return block.
make_return_table_md <- function(
    x,
    dict   = load_column_descriptions(),
    prefix = "#'    ") {
  stopifnot(is.data.frame(x))
  if (ncol(x) == 0) return(paste0(prefix, "(empty)"))

  col_names <- colnames(x)
  types     <- vapply(x, function(col) class(col)[1], character(1))
  desc      <- vapply(col_names, lookup_description,
                      dict = dict, character(1))

  w_n <- max(nchar(c("col_name",    col_names)))
  w_t <- max(nchar(c("types",       types)))
  w_d <- max(nchar(c("description", desc)))

  pad <- function(s, w) format(s, width = w)
  hdr <- paste0(prefix, "|", pad("col_name", w_n), " |",
                pad("types", w_t), " |",
                pad("description", w_d), " |")
  sep <- paste0(prefix, "|:", strrep("-", w_n), "|:",
                strrep("-", w_t), "|:",
                strrep("-", w_d), "|")
  rows <- vapply(seq_along(col_names), function(i) {
    paste0(prefix, "|", pad(col_names[i], w_n), " |",
           pad(types[i], w_t), " |",
           pad(desc[i],  w_d), " |")
  }, character(1))

  c(hdr, sep, rows)
}

## ----- Live multi-resultset @return block builder -----
##
## Given a named list of data frames (what a typical V3 wnba_*() call
## returns), produces the full @return block including bold headers
## per result set.
roxygenize_return <- function(
    x,
    dict   = load_column_descriptions(),
    lead   = NULL,
    prefix = "#'") {
  stopifnot(is.list(x))
  out <- character()
  if (!is.null(lead)) {
    out <- c(out,
             paste0(prefix, " @return ", lead),
             paste0(prefix, " ", paste(names(x), collapse = ", ")),
             paste0(prefix, ""))
  }
  for (nm in names(x)) {
    df <- x[[nm]]
    if (!is.data.frame(df) || ncol(df) == 0) next
    out <- c(
      out,
      paste0(prefix, "    **", nm, "**"),
      paste0(prefix, ""),
      paste0(prefix, ""),
      make_return_table_md(df, dict, prefix = paste0(prefix, "    ")),
      paste0(prefix, "")
    )
  }
  out
}

## ----- Parse + augment EXISTING tables in an R file -----
##
## Walks a single R/*.R file. For every block of consecutive roxygen
## table lines (`#'    |col_name ... |types ... |`), parses it, looks
## up descriptions from the dictionary, and re-emits the block with a
## third column. Non-table lines (prose, code, blank `#'` lines) are
## preserved verbatim.
augment_return_tables_in_file <- function(
    file_path,
    dict     = load_column_descriptions(),
    in_place = FALSE,
    verbose  = TRUE) {
  lines <- readLines(file_path, warn = FALSE)
  out   <- character()
  i     <- 1
  n     <- length(lines)
  block_count <- 0L

  is_table_row <- function(s) {
    grepl("^#'\\s+\\|[^|]+\\|[^|]+\\|", s, perl = TRUE)
  }
  is_separator <- function(s) {
    grepl("^#'\\s+\\|[-: ]+\\|", s, perl = TRUE)
  }

  while (i <= n) {
    if (is_table_row(lines[i])) {
      start <- i
      j <- i
      while (j <= n && is_table_row(lines[j])) j <- j + 1
      block <- lines[start:(j - 1)]

      data_rows <- block[!vapply(block, is_separator, logical(1))]
      if (length(block) < 3 || length(data_rows) < 2) {
        out <- c(out, block); i <- j; next
      }

      hdr <- data_rows[1]
      prefix_match <- regmatches(
        hdr,
        regexec("^(#'\\s+)\\|", hdr, perl = TRUE)
      )[[1]]
      if (length(prefix_match) < 2) {
        out <- c(out, block); i <- j; next
      }
      prefix <- prefix_match[2]

      ## Strip leading "#'    " (or whatever the indent is) up through
      ## the first `|`, then strip the trailing `|` so split produces
      ## exactly N cells for an N-column table.
      strip_borders <- function(s) {
        body <- sub("^[^|]*\\|", "", s)
        sub("\\|\\s*$", "", body)
      }
      cells <- trimws(strsplit(strip_borders(hdr), "\\|")[[1]])
      if (length(cells) < 2 || cells[1] != "col_name") {
        out <- c(out, block); i <- j; next
      }

      parse_row <- function(s) trimws(strsplit(strip_borders(s), "\\|")[[1]])

      parsed <- lapply(data_rows[-1], parse_row)
      ok <- vapply(parsed, function(p) length(p) >= 2, logical(1))
      if (!all(ok)) {
        out <- c(out, block); i <- j; next
      }

      col_names <- vapply(parsed, function(p) p[1], character(1))
      types     <- vapply(parsed, function(p) p[2], character(1))
      descs     <- vapply(col_names, lookup_description,
                          dict = dict, character(1))

      w_n <- max(nchar(c("col_name",    col_names)))
      w_t <- max(nchar(c("types",       types)))
      w_d <- max(nchar(c("description", descs)))
      pad <- function(s, w) format(s, width = w)

      new_block <- c(
        paste0(prefix, "|", pad("col_name", w_n), " |",
               pad("types", w_t), " |",
               pad("description", w_d), " |"),
        paste0(prefix, "|:", strrep("-", w_n), "|:",
               strrep("-", w_t), "|:",
               strrep("-", w_d), "|"),
        vapply(seq_along(col_names), function(k) {
          paste0(prefix, "|", pad(col_names[k], w_n), " |",
                 pad(types[k],     w_t), " |",
                 pad(descs[k],     w_d), " |")
        }, character(1))
      )

      out <- c(out, new_block)
      block_count <- block_count + 1L
      i <- j
    } else {
      out <- c(out, lines[i]); i <- i + 1
    }
  }

  if (verbose) {
    cat(sprintf("[%s] augmented %d table block(s).\n",
                basename(file_path), block_count))
  }
  if (in_place && block_count > 0) {
    writeLines(out, file_path)
  }
  invisible(out)
}

augment_all_r_files <- function(
    dict     = load_column_descriptions(),
    r_dir    = "R",
    in_place = FALSE) {
  files <- list.files(r_dir, pattern = "\\.R$", full.names = TRUE)
  for (f in files) {
    augment_return_tables_in_file(f, dict, in_place = in_place,
                                  verbose = TRUE)
  }
}

## =====================================================================
## (C) ESPN API description miner.
## =====================================================================
## Several ESPN endpoints self-document their columns inside the
## response payload — most usefully `sports.core.api.espn.com/v2/...
## /athletes/{id}/statistics` and the corresponding team-statistics
## endpoint, both of which expose a
## `splits.categories[].stats[].{name, displayName, description}`
## structure. `mine_espn_api_descriptions()` fetches one such URL and
## returns a tibble of `(col_name, description)` rows keyed by
## `{category_name}_{stat_name}` in snake_case, matching the column
## naming convention used elsewhere in wehoop.
##
## Usage:
##
##   rows <- mine_espn_api_descriptions(
##     paste0("https://sports.core.api.espn.com/v2/sports/basketball/",
##            "leagues/wnba/seasons/2025/types/2/athletes/3149391/statistics")
##   )
##   # rows has columns: col_name, description
##
## Combine results from multiple endpoints with `dplyr::bind_rows()`
## then `dplyr::distinct(col_name, .keep_all = TRUE)` to dedupe.

.mtth_snake <- function(s) {
  s <- gsub("([a-z])([A-Z])", "\\1_\\2", s, perl = TRUE)
  s <- gsub("[^A-Za-z0-9]+", "_", s)
  s <- gsub("^_|_$", "", s)
  tolower(s)
}

.mtth_or <- function(a, b) if (is.null(a)) b else a

mine_espn_api_descriptions <- function(url,
                                       key_prefix = "",
                                       user_agent = paste0(
                                         "Mozilla/5.0 (Windows NT 10.0) ",
                                         "AppleWebKit/537.36"
                                       )) {
  if (!requireNamespace("httr2",    quietly = TRUE)) stop("httr2 required")
  if (!requireNamespace("jsonlite", quietly = TRUE)) stop("jsonlite required")

  resp <- httr2::request(url) |>
    httr2::req_headers(`User-Agent` = user_agent, Accept = "application/json") |>
    httr2::req_error(is_error = function(r) FALSE) |>
    httr2::req_perform()
  if (httr2::resp_status(resp) != 200) {
    message("mine_espn_api_descriptions: HTTP ",
            httr2::resp_status(resp), " for ", url)
    return(tibble::tibble(col_name = character(), description = character()))
  }
  raw <- resp |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON(simplifyVector = FALSE)

  out <- list()

  ## ----- Shape (T): Top-level parallel arrays
  ## (`labels` / `names` / `displayNames` / `descriptions` at root)
  ## Used by web-v3 athlete `splits`, `gamelog`, and similar endpoints
  ## where every column lives at the response root with no category
  ## grouping.
  if (!is.null(raw[["names"]]) && length(raw[["names"]]) > 0) {
    names_vec   <- raw[["names"]]
    descs_vec   <- raw[["descriptions"]]
    display_vec <- raw[["displayNames"]]
    for (i in seq_along(names_vec)) {
      nm <- names_vec[[i]]
      if (is.null(nm) || !nzchar(nm)) next
      desc <- if (!is.null(descs_vec)   && length(descs_vec)   >= i) descs_vec[[i]]
              else if (!is.null(display_vec) && length(display_vec) >= i) display_vec[[i]]
              else NULL
      if (is.null(desc) || !nzchar(desc)) next
      key <- paste0(key_prefix, .mtth_snake(nm))
      if (!grepl("[.!?]$", desc)) desc <- paste0(desc, ".")
      out[[length(out) + 1]] <- tibble::tibble(
        col_name = key, description = desc
      )
    }
  }

  ## ----- Shape (G): Top-level `glossary[]` array of stat objects
  ## (statistics/byathlete leaderboard + others). Each item is
  ## `{abbreviation, displayName}` and the keys are best matched to
  ## the displayName snake-cased, so this is a complementary source
  ## rather than authoritative.
  if (!is.null(raw[["glossary"]]) && length(raw[["glossary"]]) > 0) {
    for (g in raw[["glossary"]]) {
      if (is.null(g)) next
      nm <- .mtth_or(g[["displayName"]], g[["abbreviation"]])
      desc <- .mtth_or(g[["description"]], g[["displayName"]])
      if (is.null(nm) || !nzchar(nm) || is.null(desc) || !nzchar(desc)) next
      key <- paste0(key_prefix, .mtth_snake(nm))
      if (!grepl("[.!?]$", desc)) desc <- paste0(desc, ".")
      out[[length(out) + 1]] <- tibble::tibble(
        col_name = key, description = desc
      )
    }
  }

  ## ----- Shape (A/B): `(splits.)categories[]` with stats[] or
  ## parallel-arrays (existing behavior).
  cats <- raw[["splits"]][["categories"]] %||%
    raw[["categories"]] %||%
    raw[["statCategories"]]
  if (!is.null(cats) && length(cats) > 0) for (cat in cats) {
    if (is.null(cat)) next
    cat_name <- .mtth_snake(.mtth_or(cat[["name"]], .mtth_or(cat[["displayName"]], "")))
    if (!nzchar(cat_name)) next

    ## Two payload shapes:
    ##   (a) cat$stats[]   = list of {name, displayName, description, ...}
    ##   (b) cat$names[]   + cat$descriptions[] + cat$displayNames[]
    ##       (parallel arrays, web-common-v3 style)
    stats_list <- cat[["stats"]] %||% cat[["statistics"]]
    if (!is.null(stats_list) && length(stats_list) > 0) {
      for (st in stats_list) {
        if (is.null(st)) next
        stat_name <- .mtth_or(st[["name"]],
                              .mtth_or(st[["abbreviation"]],
                                       st[["displayName"]]))
        desc <- .mtth_or(st[["description"]],
                          .mtth_or(st[["displayName"]],
                                   st[["shortDisplayName"]]))
        if (is.null(stat_name) || is.null(desc) ||
            !nzchar(stat_name)  || !nzchar(desc)) next
        key <- paste0(key_prefix, cat_name, "_", .mtth_snake(stat_name))
        if (!grepl("[.!?]$", desc)) desc <- paste0(desc, ".")
        out[[length(out) + 1]] <- tibble::tibble(
          col_name = key, description = desc
        )
      }
      next
    }

    names_vec <- cat[["names"]]
    descs_vec <- cat[["descriptions"]]
    display_vec <- cat[["displayNames"]]
    if (!is.null(names_vec) && length(names_vec) > 0) {
      for (i in seq_along(names_vec)) {
        nm <- names_vec[[i]]
        if (is.null(nm) || !nzchar(nm)) next
        desc <- if (!is.null(descs_vec) && length(descs_vec) >= i) descs_vec[[i]]
                else if (!is.null(display_vec) && length(display_vec) >= i) display_vec[[i]]
                else NULL
        if (is.null(desc) || !nzchar(desc)) next
        key <- paste0(key_prefix, cat_name, "_", .mtth_snake(nm))
        if (!grepl("[.!?]$", desc)) desc <- paste0(desc, ".")
        out[[length(out) + 1]] <- tibble::tibble(
          col_name = key, description = desc
        )
      }
    }
  }

  if (length(out) == 0) {
    return(tibble::tibble(
      col_name = character(), description = character()
    ))
  }
  do.call(rbind, out) %>% as_tibble() %>% distinct(col_name, .keep_all = TRUE)
}
