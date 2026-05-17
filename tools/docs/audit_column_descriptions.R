## audit_column_descriptions.R
## ---------------------------
## Diagnostic for the @return column-description dictionary built by
## tools/docs/build_column_descriptions.R. Reports two things:
##
##   (A) Frequency-weighted coverage — what fraction of @return table
##       rows in R/*.R have a hand-quality description (curated /
##       mined / parameter) vs a heuristic fallback. This is the
##       metric the user actually experiences in `?function` help.
##
##   (B) Top heuristic-only columns ranked by how often they appear in
##       tables — the highest-leverage curation targets when you want
##       to upgrade the dictionary further.
##
## Run from package root:
##   Rscript tools/docs/audit_column_descriptions.R

suppressPackageStartupMessages({
  library(stringr); library(dplyr); library(readr); library(tibble)
})

dict <- read_csv("tools/docs/column_descriptions.csv", show_col_types = FALSE)
files <- list.files("R", pattern = "\\.R$", full.names = TRUE)

extract <- function(f) {
  lines <- readLines(f, warn = FALSE)
  m <- str_match(lines, "^#'\\s+\\|\\s*([a-z0-9_]+)\\s*\\|\\s*([A-Za-z]+)\\s*\\|")
  keep <- !is.na(m[, 2]) & m[, 2] != "col_name" & !grepl("^-", m[, 2])
  m[keep, 2]
}

all_cols <- unlist(lapply(files, extract))
freq <- tibble(col_name = all_cols) |>
  count(col_name, sort = TRUE) |>
  left_join(dict |> select(col_name, description, source), by = "col_name") |>
  mutate(quality = case_when(
    source == "curated"                ~ "hand_quality",
    source == "espn_api"               ~ "hand_quality",
    grepl("^describe:", source)        ~ "hand_quality",
    source == "parameter_descriptions" ~ "hand_quality",
    TRUE                                ~ "heuristic"
  ))

## ----- (A) Coverage stats -----

per_col <- freq |> count(quality, name = "unique_cols")
per_row <- freq |> group_by(quality) |> summarise(table_rows = sum(n), .groups = "drop")

total_unique <- sum(per_col$unique_cols)
total_rows   <- sum(per_row$table_rows)

cat("=== Coverage stats ===\n\n")
cat("Unique column names:\n")
for (r in seq_len(nrow(per_col))) {
  cat(sprintf("  %-13s : %4d (%.1f%%)\n",
              per_col$quality[r], per_col$unique_cols[r],
              100 * per_col$unique_cols[r] / total_unique))
}
cat(sprintf("  %-13s : %4d (100%%)\n", "TOTAL", total_unique))

cat("\nTable-row occurrences (frequency-weighted, what `?fn` readers see):\n")
for (r in seq_len(nrow(per_row))) {
  cat(sprintf("  %-13s : %4d (%.1f%%)\n",
              per_row$quality[r], per_row$table_rows[r],
              100 * per_row$table_rows[r] / total_rows))
}
cat(sprintf("  %-13s : %4d (100%%)\n", "TOTAL", total_rows))

## ----- (B) Top heuristic-only columns -----

heur <- freq |> filter(quality == "heuristic") |> arrange(desc(n))

cat("\n\n=== Top 40 heuristic-only columns by frequency ===\n")
cat("(Highest-leverage curation targets — adding any of these to\n")
cat(" tools/docs/column_descriptions_curated.csv lifts their description\n")
cat(" everywhere they appear.)\n\n")
print(heur |> head(40), n = 40)
