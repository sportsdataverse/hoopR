## build_column_descriptions.R
## ---------------------------
## One-shot builder for `tools/docs/column_descriptions.csv` — the
## lookup table used by markdown_man_table_helper.R to augment
## roxygen @return tables with a `description` column.
##
## Five sources are combined, in this precedence order
## (first match wins):
##   (1) Hand-curated descriptions in
##       tools/docs/column_descriptions_curated.csv. This file is the
##       authoritative human-edit surface: re-running the builder
##       never overwrites it, and new entries here always supersede
##       mined / API / heuristic outputs.
##   (2) ESPN-API-mined descriptions in
##       tools/docs/column_descriptions_api.csv — domain-rich
##       descriptions harvested by tools/docs/mine_api_descriptions.R
##       from ESPN endpoints that self-document their stat columns
##       (e.g. core-v2 athlete / team statistics return
##       `splits.categories[].stats[].description`). Re-generate by
##       running `Rscript tools/docs/mine_api_descriptions.R`.
##   (3) Curated descriptions mined from existing `\describe{...}`
##       blocks in R/*.R (hand-authored years ago).
##   (4) Overlap with the `parameter_descriptions` dataset (some
##       column names happen to be parameter names too).
##   (5) Heuristic descriptions inferred from column-name suffixes
##       (e.g. `*_id` → "Unique identifier for ..."), used as
##       fallback for columns nothing else covers.
##
## The CSV columns are:
##   - col_name      : snake_case column name (the join key)
##   - description   : one-line description (markdown-safe)
##   - source        : "describe" | "parameter_descriptions" | "heuristic"
##   - needs_review  : TRUE for heuristic rows, FALSE for mined rows
##
## Run from package root:
##   Rscript tools/docs/build_column_descriptions.R

options(warn = 1)
suppressPackageStartupMessages({
  library(stringr)
  library(dplyr)
  library(tibble)
  library(readr)
})

## ----- (1) Mine \describe{\item{name}{desc}} blocks from R/*.R -----

mine_describe_blocks <- function(r_files) {
  out <- list()
  for (f in r_files) {
    lines <- readLines(f, warn = FALSE)
    ## Patterns:
    ##   `#' \item{name}{description}`         (load_wbb.R style)
    ##   `#'   \item{\code{name}}{description}` (R/data.R style)
    m <- regmatches(
      lines,
      regexec(
        "^#'\\s*\\\\item\\{(?:\\\\code\\{)?([A-Za-z0-9_.]+)\\}{1,2}\\{(.+)\\}\\s*$",
        lines,
        perl = TRUE
      )
    )
    for (i in seq_along(m)) {
      if (length(m[[i]]) == 3) {
        out[[length(out) + 1]] <- tibble(
          col_name    = tolower(m[[i]][2]),
          description = trimws(m[[i]][3]),
          source      = paste0("describe:", basename(f)),
          needs_review = FALSE
        )
      }
    }
  }
  bind_rows(out)
}

r_describe_files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
mined <- mine_describe_blocks(r_describe_files)

cat("Mined ", nrow(mined), " describe-block entries from ",
    length(r_describe_files), " R files (",
    length(unique(mined$col_name)), " unique col_names).\n", sep = "")

## ----- (2) Inferred descriptions from common basketball column patterns -----

## Heuristic generator: short, mechanical, marked needs_review = TRUE so
## maintainers can find and upgrade them.
## Friendly noun substitutions used by suffix rules so column stems
## render as readable English (e.g. `fast_break_pts_made` →
## "Number of fast break points made.").
.friendly_noun <- function(stem) {
  stem <- gsub("_", " ", stem, fixed = TRUE)
  stem <- gsub("\\bpts\\b",  "points",        stem)
  stem <- gsub("\\bfg\\b",   "field goals",   stem)
  stem <- gsub("\\bfg3\\b",  "three-pointers",stem)
  stem <- gsub("\\bft\\b",   "free throws",   stem)
  stem <- gsub("\\boreb\\b", "offensive rebounds", stem)
  stem <- gsub("\\bdreb\\b", "defensive rebounds", stem)
  stem <- gsub("\\breb\\b",  "rebounds",      stem)
  stem <- gsub("\\bast\\b",  "assists",       stem)
  stem <- gsub("\\bstl\\b",  "steals",        stem)
  stem <- gsub("\\bblk\\b",  "blocks",        stem)
  stem <- gsub("\\btov\\b",  "turnovers",     stem)
  stem <- gsub("\\bpf\\b",   "personal fouls",stem)
  stem <- gsub("\\busg\\b",  "usage",         stem)
  stem <- gsub("\\btm\\b",   "team",          stem)
  stem <- gsub("\\bopp\\b",  "opponent",      stem)
  stem <- gsub("\\bw\\b",    "wins",          stem)
  stem <- gsub("\\bl\\b",    "losses",        stem)
  stem
}

infer_description <- function(col_name) {
  cn <- tolower(col_name)
  fr <- .friendly_noun

  ## Identifier specials (most-recurring, hand-authored)
  if (cn == "game_id")      return("Unique game identifier.")
  if (cn == "team_id")      return("Unique team identifier.")
  if (cn == "player_id")    return("Unique player identifier.")
  if (cn == "person_id")    return("Unique player identifier (V3 endpoints).")
  if (cn == "season_id")    return("Unique season identifier.")
  if (cn == "league_id")    return("League identifier ('10' = WNBA).")
  if (cn == "athlete_id")   return("Unique athlete identifier (ESPN).")

  ## Per-N suffixes (per_36, per_40, per_48, per_75, per_100, per_game)
  m <- regmatches(cn, regexec("^(.*?)_per_([0-9]+|game)$", cn))[[1]]
  if (length(m) == 3 && nzchar(m[2]) && nzchar(m[3])) {
    unit <- m[3]
    label <- if (unit == "game") "per game" else paste0("per ", unit, " minutes/possessions")
    return(sprintf("%s %s.", paste0(toupper(substr(fr(m[2]), 1, 1)), substring(fr(m[2]), 2)), label))
  }

  ## Suffix rules — order matters: more specific first
  if (str_detect(cn, "_id$"))            return(sprintf("Unique identifier for %s.", fr(str_replace(cn, "_id$", ""))))
  if (str_detect(cn, "_pct$|_percentage$|_pct_rank$"))
                                          return(sprintf("%s percentage (0-1 decimal).",
                                                         paste0(toupper(substr(fr(str_replace(cn, "_(pct|percentage|pct_rank)$", "")), 1, 1)),
                                                                substring(fr(str_replace(cn, "_(pct|percentage|pct_rank)$", "")), 2))))
  if (str_detect(cn, "_rank$"))          return(sprintf("League/season rank for %s.", fr(str_replace(cn, "_rank$", ""))))
  if (str_detect(cn, "^pct_"))           return(sprintf("Percentage of %s.", fr(str_replace(cn, "^pct_", ""))))
  if (str_detect(cn, "_made$"))          return(sprintf("Number of %s made.", fr(str_replace(cn, "_made$", ""))))
  if (str_detect(cn, "_attempted$|^[a-z_]*_attempts$"))
                                          return(sprintf("Number of %s attempted.", fr(str_replace(cn, "_(attempted|attempts)$", ""))))
  if (str_detect(cn, "^.*_count$|^count$")) return(sprintf("Count of %s.", fr(str_replace(cn, "_count$", ""))))
  if (str_detect(cn, "_record$|^record$"))   return(sprintf("Win-loss record for %s.", fr(str_replace(cn, "_record$|^record$", ""))))
  if (str_detect(cn, "_seconds$"))         return(sprintf("%s in seconds.", paste0(toupper(substr(fr(str_replace(cn, "_seconds$", "")), 1, 1)), substring(fr(str_replace(cn, "_seconds$", "")), 2))))
  if (str_detect(cn, "^min(utes)?$"))    return("Minutes played.")
  if (str_detect(cn, "^pts$|^points$"))  return("Points scored.")
  if (str_detect(cn, "^reb$|^rebounds$|^rebounds_total$"))
                                          return("Total rebounds.")
  if (str_detect(cn, "^ast$|^assists$")) return("Assists.")
  if (str_detect(cn, "^stl$|^steals$"))  return("Steals.")
  if (str_detect(cn, "^blk$|^blocks$"))  return("Blocks.")
  if (str_detect(cn, "^tov$|^turnovers$")) return("Turnovers.")
  if (str_detect(cn, "^pf$|^fouls_personal$")) return("Personal fouls.")
  if (str_detect(cn, "^plus_minus|^plus_minus_points$")) return("Plus/minus score differential while on court.")
  if (str_detect(cn, "_date$|^date$"))   return("Date in YYYY-MM-DD format.")
  if (str_detect(cn, "_time$|^time$"))   return("Time / clock value.")
  if (str_detect(cn, "_name$|^name$"))   return(sprintf("%s name.", paste0(toupper(substr(fr(str_replace(cn, "_name$|^name$", "")), 1, 1)), substring(fr(str_replace(cn, "_name$|^name$", "")), 2))))
  if (str_detect(cn, "_abbrev$|^abbreviation$")) return(sprintf("Abbreviation for %s.", fr(str_replace(cn, "_abbrev$|^abbreviation$", ""))))
  if (str_detect(cn, "_url$|_href$"))    return(sprintf("URL for %s.", fr(str_replace(cn, "_(url|href)$", ""))))
  if (str_detect(cn, "_logo$"))          return(sprintf("Logo image URL for %s.", fr(str_replace(cn, "_logo$", ""))))
  if (str_detect(cn, "_color$"))         return(sprintf("Color code (hex) for %s.", fr(str_replace(cn, "_color$", ""))))
  if (cn == "season")                    return("Season (4-digit year or 'YYYY-YY' string).")
  if (cn == "season_type")               return("Season type (Regular Season / Playoffs / Pre Season / All Star).")
  if (str_detect(cn, "^home_"))          return(sprintf("Home team's %s.", fr(str_replace(cn, "^home_", ""))))
  if (str_detect(cn, "^away_"))          return(sprintf("Away team's %s.", fr(str_replace(cn, "^away_", ""))))
  if (str_detect(cn, "^opp_|^opponent_")) return(sprintf("Opponent %s.", fr(str_replace(cn, "^opp(onent)?_", ""))))
  ## Last-resort: humanize the snake_case
  hum <- str_replace_all(cn, "_", " ")
  paste0(toupper(substr(hum, 1, 1)), substring(hum, 2), ".")
}

## ----- (3) Build the inferred-descriptions table from unique columns
##           found across all existing @return tables -----

## Parse all `|col_name|types|` lines from R/*.R and extract just the
## col_name column.
extract_table_col_names <- function(r_files) {
  out <- character()
  for (f in r_files) {
    lines <- readLines(f, warn = FALSE)
    ## Lines that look like roxygen markdown table rows:
    ##   `#'    |colname    |type     |`
    ## Skip the header row (col_name | types) and the separator
    ## (:-------|:------|).
    m <- str_match(lines, "^#'\\s*\\|\\s*([a-z0-9_]+)\\s*\\|\\s*([A-Za-z]+)\\s*\\|")
    keep <- !is.na(m[, 2]) &
      m[, 2] != "col_name" &
      m[, 2] != "" &
      !grepl("^-+$|^:", m[, 2])
    out <- c(out, m[keep, 2])
  }
  unique(out)
}

all_col_names <- extract_table_col_names(r_describe_files)
cat("Found ", length(all_col_names), " unique col_names across all @return tables.\n", sep = "")

## Heuristic table for every unique col_name not already in the mined set.
mined_keys <- unique(mined$col_name)
to_infer   <- setdiff(all_col_names, mined_keys)

heuristic <- tibble(
  col_name     = to_infer,
  description  = vapply(to_infer, infer_description, character(1)),
  source       = "heuristic",
  needs_review = TRUE
)

cat("Generated ", nrow(heuristic), " heuristic descriptions for unseen col_names.\n", sep = "")

## ----- (4) Also pull parameter_descriptions where parameter-name matches
##           a column name (e.g. season, season_type, league_id) -----

if (file.exists("data/parameter_descriptions.rda")) {
  load("data/parameter_descriptions.rda")
  param_overlap <- parameter_descriptions %>%
    transmute(
      col_name     = tolower(parameter),
      description  = description,
      source       = "parameter_descriptions",
      needs_review = FALSE
    ) %>%
    filter(col_name %in% all_col_names) %>%
    distinct(col_name, .keep_all = TRUE)
  cat("Found ", nrow(param_overlap),
      " overlaps with parameter_descriptions.\n", sep = "")
} else {
  param_overlap <- tibble(
    col_name = character(0), description = character(0),
    source = character(0), needs_review = logical(0)
  )
}

## ----- (5) Hand-curated descriptions (highest precedence) -----

curated_path <- "tools/docs/column_descriptions_curated.csv"
if (file.exists(curated_path)) {
  curated <- read_csv(curated_path, show_col_types = FALSE) %>%
    mutate(
      col_name     = tolower(col_name),
      source       = "curated",
      needs_review = FALSE
    ) %>%
    distinct(col_name, .keep_all = TRUE)
  cat("Loaded ", nrow(curated),
      " hand-curated descriptions from ",
      curated_path, ".\n", sep = "")
} else {
  curated <- tibble(
    col_name = character(0), description = character(0),
    source = character(0), needs_review = logical(0)
  )
  cat("No curated CSV at ", curated_path,
      "; using mined + heuristic only.\n", sep = "")
}

## ----- (5b) ESPN-API-mined descriptions -----

api_path <- "tools/docs/column_descriptions_api.csv"
if (file.exists(api_path)) {
  api_mined <- read_csv(api_path, show_col_types = FALSE) %>%
    mutate(
      col_name     = tolower(col_name),
      source       = "espn_api",
      needs_review = FALSE
    ) %>%
    distinct(col_name, .keep_all = TRUE)
  cat("Loaded ", nrow(api_mined),
      " ESPN-API-mined descriptions from ", api_path, ".\n", sep = "")
} else {
  api_mined <- tibble(
    col_name = character(0), description = character(0),
    source = character(0), needs_review = logical(0)
  )
  cat("No API-mined CSV at ", api_path,
      "; run tools/docs/mine_api_descriptions.R to generate.\n", sep = "")
}

## ----- (6) Combine: curated > api > mined > parameter > heuristic

dict <- bind_rows(curated, api_mined, mined, param_overlap, heuristic) %>%
  ## When a col_name has multiple entries, keep the FIRST (so curated
  ## wins, then api, then mined, then param, then heuristic).
  distinct(col_name, .keep_all = TRUE) %>%
  arrange(col_name)

cat("\nFinal dictionary: ", nrow(dict), " rows.\n",
    "  curated (hand-written):  ", sum(dict$source == "curated"), "\n",
    "  espn_api (mined live):   ", sum(dict$source == "espn_api"), "\n",
    "  mined (describe blocks): ", sum(grepl("^describe:", dict$source)), "\n",
    "  parameter_descriptions:  ", sum(dict$source == "parameter_descriptions"), "\n",
    "  heuristic:               ", sum(dict$source == "heuristic"), "\n",
    sep = "")

write_csv(dict, "tools/docs/column_descriptions.csv")
cat("\nWrote tools/docs/column_descriptions.csv (", nrow(dict), " rows).\n", sep = "")
