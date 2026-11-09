# Family index pages.
#
# roxygen's `@family` writes every member of a family into the "See also" of
# every other member, so a family of n pages carries n^2 links. For the large
# families that was over 1.2 MB of the installed help (ESPN MBB alone: 590 KB).
# Their members carry `@concept <family>` and one `@seealso` link to the
# family's index page below instead; the index lists the family once, built at
# document() time from the `@concept` tags in R/.

#' Roxygen lines listing every function whose roxygen block carries
#' `@concept <family>` (roxygen `@eval`, run by `devtools::document()` from the
#' package root).
#'
#' A function counts when its block is followed by its definition
#' (`name <- function`), whether it has a page of its own or shares one through
#' `@rdname`.
#'
#' @param family The family name, exactly as in the `@concept` tags.
#' @return Character vector of roxygen lines.
#' @noRd
.family_index <- function(family) {
  fns <- character()
  for (path in sort(list.files("R", "[.][Rr]$", full.names = TRUE))) {
    l <- readLines(path, warn = FALSE)
    for (i in which(l == paste0("#' @concept ", family))) {
      j <- i
      while (j <= length(l) && startsWith(l[j], "#'")) j <- j + 1L
      m <- regmatches(l[j], regexec("^`?([A-Za-z][A-Za-z0-9._]*)`? *<- *function", l[j]))[[1]]
      if (length(m)) fns <- c(fns, m[2])
    }
  }
  fns <- sort(unique(fns))
  if (!length(fns)) stop("no function carries `@concept ", family, "`", call. = FALSE)
  c("@description",
    paste0("Every function in the ", family, " family (", length(fns), "):"),
    "",
    paste0("* [", fns, "()]"))
}

# Return-column tables.
#
# Every function's returned columns live in data-raw/return_columns.csv (the
# source of the `return_columns` dataset). `@eval .returns_rd("fn")` renders a
# function's `@return` from it at document() time: the column tables inline,
# or, with `inline = FALSE`, a short pointer to the dataset and the article.

.returns_cache <- new.env(parent = emptyenv())

#' Roxygen `@return` lines for one function, built from
#' data-raw/return_columns.csv (roxygen `@eval`, run by `devtools::document()`
#' from the package root).
#'
#' @param fn Function name, as in the CSV's `fn` column.
#' @param inline `TRUE` renders the column tables; `FALSE` points to the
#'   `return_columns` dataset and the return-columns article instead.
#' @param unit What one row is ("player", "game", ...), for a single data
#'   frame.
#' @param class `"hoopR_data"` (default), `"tibble"` or `"data frame"`.
#' @return Character vector of roxygen lines.
#' @noRd
.returns_rd <- function(fn, inline = TRUE, unit = NULL, class = "hoopR_data") {
  if (is.null(.returns_cache$rc)) {
    .returns_cache$rc <- utils::read.csv("data-raw/return_columns.csv", stringsAsFactors = FALSE,
                                          na.strings = "", colClasses = "character", encoding = "UTF-8")
  }
  rc <- .returns_cache$rc
  rows <- rc[rc$fn == fn, , drop = FALSE]
  if (!nrow(rows)) stop("no return_columns rows for `", fn, "`", call. = FALSE)
  noun <- switch(class, hoopR_data = "`hoopR_data` tibble", tibble = "tibble", "data frame" = "data frame",
                 stop("unknown class ", class, call. = FALSE))
  comps <- unique(rows$component)
  variant <- all(grepl("^`\\w+ = .*`$", comps))
  per <- if (is.null(unit)) "" else paste0(" with one row per ", unit)
  if (anyNA(comps)) {
    lead <- paste0("A ", noun, per, ".")
  } else if (variant) {
    arg <- unique(sub("^`(\\w+) = .*$", "\\1", comps))
    lead <- paste0("A ", noun, per, ". Its columns depend on `", arg, "`: ",
                   paste(sub("^`\\w+ = (.*)`$", "`\\1`", comps), collapse = ", "), ".")
  } else {
    elems <- trimws(unlist(strsplit(comps, " / ", fixed = TRUE)))
    lead <- paste0("A named list of ", noun, "s: ", paste0("`", elems, "`", collapse = ", "), ".")
  }
  if (!inline) {
    sub_call <- paste0("`subset(return_columns, fn == \"", fn, "\")`")
    article <- "[return columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)"
    ptr <- if (!anyNA(comps) && !variant) {
      c("Their column names and types are in [return_columns], e.g.",
        paste0(sub_call, ", and in the searchable"), article, "article.")
    } else {
      c("Its columns are listed in [return_columns]",
        paste0("(", sub_call, ") and in the searchable"), paste(article, "article."))
    }
    return(c(paste("@return", lead), paste0("  ", ptr)))
  }
  out <- c(paste("@return", lead), "")
  seen <- list()
  for (cp in comps) {
    df <- rows[if (is.na(cp)) is.na(rows$component) else rows$component %in% cp, c("col_name", "type", "description")]
    rownames(df) <- NULL
    if (!is.na(cp)) out <- c(out, paste0("**", cp, "**"), "")
    same <- names(Filter(function(x) identical(x, df), seen))
    if (length(same)) {
      out <- c(out, paste0("Same columns as the **", same[1], "** table above."), "")
      next
    }
    if (!is.na(cp)) seen[[cp]] <- df
    cell <- function(x) vapply(x, .returns_rd_text, "")
    out <- c(out,
             "\\if{html}{\\tabular{lll}{",
             "  col_name \\tab types \\tab description \\cr",
             paste0("  ", cell(df$col_name), " \\tab ", cell(df$type), " \\tab ", cell(df$description), " \\cr"),
             "}}",
             "\\if{latex}{See the HTML help or pkgdown reference for the column table.}",
             "")
  }
  out
}

# One CSV cell as Rd: `code` -> \code{}, [fn()] -> a function link, Rd
# specials escaped.
.returns_rd_text <- function(x) {
  if (is.na(x) || !nzchar(x)) return("")
  esc <- function(s) gsub("([%{}])", "\\\\\\1", gsub("\\\\", "\\\\\\\\", s))
  parts <- regmatches(x, gregexpr("`[^`]*`", x), invert = NA)[[1]]
  vapply(parts, function(p) {
    if (startsWith(p, "`") && endsWith(p, "`") && nchar(p) >= 2L) {
      return(paste0("\\code{", esc(substr(p, 2L, nchar(p) - 1L)), "}"))
    }
    gsub("\\[([A-Za-z.][A-Za-z0-9._]*)\\(\\)\\]", "\\\\code{\\\\link[=\\1]{\\1()}}", esc(p))
  }, "", USE.NAMES = FALSE) |> paste(collapse = "")
}

#' ESPN MBB Functions: family index
#'
#' @name family_espn_mbb
#' @eval .family_index("ESPN MBB Functions")
#' @keywords internal
NULL

#' ACB Functions: family index
#'
#' @name family_acb
#' @eval .family_index("ACB Functions")
#' @keywords internal
NULL

#' VTB Functions: family index
#'
#' @name family_vtb
#' @eval .family_index("VTB Functions")
#' @keywords internal
NULL

#' FIBA Functions: family index
#'
#' @name family_fiba
#' @eval .family_index("FIBA Functions")
#' @keywords internal
NULL

#' TBF Functions: family index
#'
#' @name family_tbf
#' @eval .family_index("TBF Functions")
#' @keywords internal
NULL

#' BNXT League Functions: family index
#'
#' @name family_bnxt_league
#' @eval .family_index("BNXT League Functions")
#' @keywords internal
NULL

#' Basketligaen Functions: family index
#'
#' @name family_basketligaen
#' @eval .family_index("Basketligaen Functions")
#' @keywords internal
NULL

#' CBA Functions: family index
#'
#' @name family_cba
#' @eval .family_index("CBA Functions")
#' @keywords internal
NULL

#' NBL Rosetta Functions: family index
#'
#' @name family_nbl_rosetta
#' @eval .family_index("NBL Rosetta Functions")
#' @keywords internal
NULL

#' SCB Functions: family index
#'
#' @name family_scb
#' @eval .family_index("SCB Functions")
#' @keywords internal
NULL

#' KZS Functions: family index
#'
#' @name family_kzs
#' @eval .family_index("KZS Functions")
#' @keywords internal
NULL

#' KBL Functions: family index
#'
#' @name family_kbl
#' @eval .family_index("KBL Functions")
#' @keywords internal
NULL

#' ESPN NBA Functions: family index
#'
#' @name family_espn_nba
#' @eval .family_index("ESPN NBA Functions")
#' @keywords internal
NULL

#' P. LEAGUE+ Functions: family index
#'
#' @name family_p_league
#' @eval .family_index("P. LEAGUE+ Functions")
#' @keywords internal
NULL

#' Basketball Analytics Utilities: family index
#'
#' @name family_basketball_analytics_utilities
#' @eval .family_index("Basketball Analytics Utilities")
#' @keywords internal
NULL

#' LBA Functions: family index
#'
#' @name family_lba
#' @eval .family_index("LBA Functions")
#' @keywords internal
NULL

#' RealGM Functions: family index
#'
#' @name family_realgm
#' @eval .family_index("RealGM Functions")
#' @keywords internal
NULL

#' EASL Functions: family index
#'
#' @name family_easl
#' @eval .family_index("EASL Functions")
#' @keywords internal
NULL

#' IBBA Functions: family index
#'
#' @name family_ibba
#' @eval .family_index("IBBA Functions")
#' @keywords internal
NULL

#' Euroleague: family index
#'
#' @name family_euroleague
#' @eval .family_index("Euroleague")
#' @keywords internal
NULL

#' TPBL Functions: family index
#'
#' @name family_tpbl
#' @eval .family_index("TPBL Functions")
#' @keywords internal
NULL

#' B.LEAGUE Functions: family index
#'
#' @name family_b_league
#' @eval .family_index("B.LEAGUE Functions")
#' @keywords internal
NULL
