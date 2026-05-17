## port_wehoop_espn_helpers.R
## --------------------------
## One-shot port script. Copies wehoop's espn_basketball_*_helpers.R +
## espn_wbb_/espn_wnba_ shim files into hoopR's R/ tree, applying the
## mechanical token substitutions needed to switch from
## wnba/womens-college-basketball/wbb/wehoop to nba/mens-college-basketball/
## mbb/hoopR.
##
## Idempotent: running it twice produces identical files. Run with:
##   Rscript tools/port_wehoop_espn_helpers.R
##
## After running, run devtools::document() to regenerate NAMESPACE+man/,
## then source('tools/docs/markdown_man_table_helper.R') and
## augment_all_r_files(in_place = TRUE) to add @return descriptions.

options(warn = 1)

WEHOOP <- "../../wehoop-dev/wehoop"
HOOPR  <- "."

stopifnot(file.exists(file.path(WEHOOP, "DESCRIPTION")))
stopifnot(file.exists(file.path(HOOPR, "DESCRIPTION")))

## Substitutions applied to every file we port. Order matters for
## composite tokens (longer first).
##
## NOTE: we cannot use `\b` to bound the three-letter league slugs --
## `_` is a regex word character, so `\bwnba\b` does NOT match inside
## `espn_wnba_news` (the boundary on each side is word -> word). Use
## negative lookarounds for alphanumerics instead, so `_` and `/` and
## quote chars all count as boundaries.
subs <- list(
  c("womens-college-basketball", "mens-college-basketball"),
  c("(?<![A-Za-z0-9])wbb(?![A-Za-z0-9])",  "mbb"),
  c("(?<![A-Za-z0-9])wnba(?![A-Za-z0-9])", "nba"),
  c("(?<![A-Za-z0-9])WBB(?![A-Za-z0-9])",  "MBB"),
  c("(?<![A-Za-z0-9])WNBA(?![A-Za-z0-9])", "NBA"),
  ## Package-flavored identifiers
  c("make_wehoop_data", "make_hoopR_data"),
  c("\"wehoop\\.proxy\"", "\"hoopR.proxy\""),
  c("'wehoop\\.proxy'", "'hoopR.proxy'"),
  c("\"wehoop_data\"", "\"hoopR_data\""),
  c("(?<![A-Za-z0-9])wehoop_data(?![A-Za-z0-9])", "hoopR_data"),
  c("(?<![A-Za-z0-9])wehoop(?![A-Za-z0-9])", "hoopR")
)

apply_subs <- function(txt) {
  for (s in subs) txt <- gsub(s[1], s[2], txt, perl = TRUE)
  txt
}

port_file <- function(src, dst) {
  if (!file.exists(src)) {
    cat("MISSING SRC: ", src, "\n", sep = "")
    return(invisible(FALSE))
  }
  txt <- readLines(src, warn = FALSE)
  txt <- apply_subs(txt)
  ## Don't write if identical (idempotence)
  if (file.exists(dst) && identical(readLines(dst, warn = FALSE), txt)) {
    cat("unchanged: ", basename(dst), "\n", sep = "")
    return(invisible(TRUE))
  }
  writeLines(txt, dst)
  cat("wrote: ", basename(dst), "\n", sep = "")
  invisible(TRUE)
}

## ----- (1) Port the 7 league-agnostic helper files -----

helpers <- c(
  "espn_basketball_athlete_helpers.R",
  "espn_basketball_calendar_helpers.R",
  "espn_basketball_event_helpers.R",
  "espn_basketball_injuries_helpers.R",
  "espn_basketball_league_helpers.R",
  "espn_basketball_news_helpers.R",
  "espn_basketball_team_helpers.R"
)

cat("\n== Porting league-agnostic helpers (token substitutions only) ==\n")
for (f in helpers) {
  port_file(file.path(WEHOOP, "R", f),
            file.path(HOOPR,  "R", f))
}

## ----- (2) Port per-league shim files (wbb -> mbb, wnba -> nba) -----

shim_pairs <- list(
  ## wehoop file        -> hoopR file
  c("espn_wbb_athletes.R",     "espn_mbb_athletes.R"),
  c("espn_wbb_calendar.R",     "espn_mbb_calendar.R"),
  c("espn_wbb_event_detail.R", "espn_mbb_event_detail.R"),
  c("espn_wbb_injuries.R",     "espn_mbb_injuries.R"),
  c("espn_wbb_league.R",       "espn_mbb_league.R"),
  c("espn_wbb_news.R",         "espn_mbb_news.R"),
  c("espn_wbb_team_detail.R",  "espn_mbb_team_detail.R"),
  c("espn_wnba_athletes.R",     "espn_nba_athletes.R"),
  c("espn_wnba_calendar.R",     "espn_nba_calendar.R"),
  c("espn_wnba_event_detail.R", "espn_nba_event_detail.R"),
  c("espn_wnba_injuries.R",     "espn_nba_injuries.R"),
  c("espn_wnba_league.R",       "espn_nba_league.R"),
  c("espn_wnba_news.R",         "espn_nba_news.R"),
  c("espn_wnba_team_detail.R",  "espn_nba_team_detail.R")
)

cat("\n== Porting per-league shim files ==\n")
for (p in shim_pairs) {
  port_file(file.path(WEHOOP, "R", p[1]),
            file.path(HOOPR,  "R", p[2]))
}

## ----- (3) WNBA-only extras: groups + transactions -----
## wehoop has espn_wnba_groups.R (conferences) and
## espn_wnba_transactions.R (draft / freeagents / transactions). NBA has
## a draft, free-agency window, and transactions feed too, so port these
## under nba names.

cat("\n== Porting WNBA-only extras (groups, transactions) for NBA ==\n")
port_file(file.path(WEHOOP, "R", "espn_wnba_groups.R"),
          file.path(HOOPR,  "R", "espn_nba_groups.R"))
port_file(file.path(WEHOOP, "R", "espn_wnba_transactions.R"),
          file.path(HOOPR,  "R", "espn_nba_transactions.R"))

## ----- (4) Helper-validator broadening -----
## After token substitution the team helper's .espn_bball_validate_league
## will accept c("nba", "mens-college-basketball"), which is correct for
## hoopR. But the ATHLETE helpers also rely on this validator
## indirectly. Since the validator is league-list-specific, the port
## already does the right thing -- no further patch needed.

cat("\nDone.\n")
