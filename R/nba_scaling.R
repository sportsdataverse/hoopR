# ---------------------------------------------------------------------------
# Box-score scaling / enrichment helpers (operate on a data frame)
# ---------------------------------------------------------------------------

# Return the first column name in `df` matching any candidate (case-insensitive),
# or NULL.
.find_col <- function(df, candidates) {
  nm <- tolower(names(df))
  hit <- which(nm %in% tolower(candidates))
  if (length(hit)) names(df)[hit[1]] else NULL
}

#' @title **Scale Box-Score Counting Stats Per N Minutes**
#' @description Rescale counting stats to a per-minute basis (defaults to the
#'   familiar per-36). Adds one `"{col}_per_{per}"` column per requested stat;
#'   the original columns are left untouched.
#' @param df A data frame / tibble of box-score rows.
#' @param cols Character vector of counting-stat columns to rescale
#'   (e.g. `c("pts", "reb", "ast")`).
#' @param minutes Name of the minutes column. Defaults to `"min"`.
#' @param per Minutes to scale to. Defaults to `36`.
#' @return `df` with the added per-minute columns.
#' @importFrom cli cli_abort
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' box <- data.frame(player = c("A", "B"), min = c(36, 24),
#'                   pts = c(18, 8), reb = c(9, 6), ast = c(7, 2))
#' nba_per_minutes(box, cols = c("pts", "reb", "ast"))
nba_per_minutes <- function(df, cols, minutes = "min", per = 36) {
  stopifnot(is.data.frame(df))
  if (!minutes %in% names(df)) {
    cli::cli_abort("Minutes column {.val {minutes}} not found in {.arg df}.")
  }
  m <- suppressWarnings(as.numeric(df[[minutes]]))
  for (col in cols) {
    if (!col %in% names(df)) next
    df[[paste0(col, "_per_", per)]] <-
      suppressWarnings(as.numeric(df[[col]])) / .nz(m) * per
  }
  df
}

#' @title **Scale Box-Score Counting Stats Per N Possessions**
#' @description Rescale counting stats to a per-possession basis (defaults to the
#'   familiar per-100). Adds one `"{col}_per_{per}"` column per requested stat.
#' @param df A data frame / tibble of box-score rows.
#' @param cols Character vector of counting-stat columns to rescale.
#' @param possessions Name of the possessions column. Defaults to `"poss"`.
#' @param per Possessions to scale to. Defaults to `100`.
#' @return `df` with the added per-possession columns.
#' @importFrom cli cli_abort
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' box <- data.frame(team = c("A", "B"), poss = c(98, 102),
#'                   pts = c(112, 109), tov = c(13, 11))
#' nba_per_possessions(box, cols = c("pts", "tov"))
nba_per_possessions <- function(df, cols, possessions = "poss", per = 100) {
  stopifnot(is.data.frame(df))
  if (!possessions %in% names(df)) {
    cli::cli_abort("Possessions column {.val {possessions}} not found in {.arg df}.")
  }
  p <- suppressWarnings(as.numeric(df[[possessions]]))
  for (col in cols) {
    if (!col %in% names(df)) next
    df[[paste0(col, "_per_", per)]] <-
      suppressWarnings(as.numeric(df[[col]])) / .nz(p) * per
  }
  df
}

#' @title **Append Advanced Metrics to a Box Score**
#' @description Detects the standard hoopR / stats.nba.com box-score columns
#'   present in `df` and appends the advanced metrics it can compute from them
#'   (true-shooting %, effective field-goal %, free-throw rate, turnover %,
#'   assist-to-turnover ratio and Hollinger game score). Columns are matched
#'   case-insensitively against common aliases; metrics whose inputs are absent
#'   are skipped (reported via a message), so it is safe to pass any box score.
#' @param df A data frame / tibble of player or team box-score rows.
#' @return `df` with the available advanced-metric columns appended.
#' @importFrom cli cli_inform
#' @family Basketball Analytics Utilities
#' @export
#' @examples
#' box <- data.frame(player = "A", pts = 30, fgm = 10, fga = 20,
#'                   fg3m = 4, ftm = 7, fta = 8, oreb = 1, dreb = 6,
#'                   ast = 8, stl = 2, blk = 1, pf = 2, tov = 3)
#' nba_add_advanced_metrics(box)
nba_add_advanced_metrics <- function(df) {
  stopifnot(is.data.frame(df))
  g <- function(cands) {
    h <- .find_col(df, cands)
    if (is.null(h)) NULL else suppressWarnings(as.numeric(df[[h]]))
  }
  pts  <- g(c("pts", "points"))
  fgm  <- g(c("fgm", "fg", "fgmade"))
  fga  <- g(c("fga"))
  fg3m <- g(c("fg3m", "fg3_m", "tpm", "x3pm", "fg3"))
  ftm  <- g(c("ftm", "ft"))
  fta  <- g(c("fta"))
  oreb <- g(c("oreb", "o_reb", "orb", "offensive_rebounds"))
  dreb <- g(c("dreb", "d_reb", "drb", "defensive_rebounds"))
  ast  <- g(c("ast", "assists"))
  stl  <- g(c("stl", "steals"))
  blk  <- g(c("blk", "blocks"))
  pf   <- g(c("pf", "fouls", "personal_fouls"))
  tov  <- g(c("tov", "to", "turnovers"))

  added <- character(0); skipped <- character(0)
  add_if <- function(name, inputs, value) {
    if (all(vapply(inputs, Negate(is.null), logical(1)))) {
      df[[name]] <<- value(); added <<- c(added, name)
    } else {
      skipped <<- c(skipped, name)
    }
  }

  add_if("ts_pct",     list(pts, fga, fta),                 function() nba_true_shooting_pct(pts, fga, fta))
  add_if("efg_pct",    list(fgm, fg3m, fga),                function() nba_effective_fg_pct(fgm, fg3m, fga))
  add_if("ft_rate",    list(fta, fga),                      function() nba_ft_rate(fta, fga))
  add_if("tov_pct",    list(tov, fga, fta),                 function() nba_turnover_pct(tov, fga, fta))
  add_if("ast_to",     list(ast, tov),                      function() nba_assist_to_turnover(ast, tov))
  add_if("game_score", list(pts, fgm, fga, fta, ftm, oreb, dreb, stl, ast, blk, pf, tov),
         function() nba_game_score(pts, fgm, fga, fta, ftm, oreb, dreb, stl, ast, blk, pf, tov))

  if (length(added)) cli::cli_inform("Added advanced metrics: {.field {added}}.")
  if (length(skipped)) cli::cli_inform("Skipped (missing inputs): {.field {skipped}}.")
  df
}
