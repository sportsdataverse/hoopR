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
