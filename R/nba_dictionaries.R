# ---------------------------------------------------------------------------
# Player / team dictionaries and CDN picture-URL helpers
# ---------------------------------------------------------------------------

# Static NBA conference / division lookup keyed by stats.nba.com team
# abbreviation. Merged into nba_team_dict(); a missing/changed abbreviation
# simply yields NA for that team rather than an error.
.nba_conf_div <- data.frame(
  team_abbreviation = c("BOS","BKN","NYK","PHI","TOR",
                        "CHI","CLE","DET","IND","MIL",
                        "ATL","CHA","MIA","ORL","WAS",
                        "DEN","MIN","OKC","POR","UTA",
                        "GSW","LAC","LAL","PHX","SAC",
                        "DAL","HOU","MEM","NOP","SAS"),
  conference = c(rep("Eastern", 15), rep("Western", 15)),
  division = c(rep("Atlantic", 5), rep("Central", 5), rep("Southeast", 5),
               rep("Northwest", 5), rep("Pacific", 5), rep("Southwest", 5)),
  stringsAsFactors = FALSE
)

#' @title **NBA Player Headshot URL**
#' @description Build the official NBA CDN headshot URL(s) for one or more player
#'   ids. Vectorized -- pass a vector of ids to get a vector of URLs.
#' @param player_id Player id(s) (`PERSON_ID`), numeric or character.
#' @param size Image size: `"1040x760"` (default, large) or `"260x190"` (small).
#' @return A character vector of headshot URLs.
#' @family NBA Dictionary Functions
#' @export
#' @examples
#' nba_player_headshot_url(player_id = 201939)            # Stephen Curry
#' nba_player_headshot_url(c(2544, 201939), size = "260x190")
nba_player_headshot_url <- function(player_id, size = "1040x760") {
  paste0("https://cdn.nba.com/headshots/nba/latest/", size, "/", player_id, ".png")
}

#' @title **NBA Team Logo URL**
#' @description Build the official NBA CDN logo URL(s) for one or more team ids.
#'   Vectorized.
#' @param team_id Team id(s) (`TEAM_ID`, the 10-digit form e.g. `1610612744`).
#' @param variant Logo variant: `"primary"` (default), `"secondary"` or `"global"`.
#' @return A character vector of SVG logo URLs.
#' @family NBA Dictionary Functions
#' @export
#' @examples
#' nba_team_logo_url(team_id = 1610612744)                # Golden State Warriors
nba_team_logo_url <- function(team_id, variant = "primary") {
  paste0("https://cdn.nba.com/logos/nba/", team_id, "/", variant, "/L/logo.svg")
}

#' @title **NBA Player Dictionary**
#' @description A tidy player dictionary (id, name, team, bio, headshot URL)
#'   sourced from the stats.nba.com player index. Handy for joining player ids to
#'   names/teams and for fetching headshots.
#' @param season Season in `"YYYY-YY"` form. Defaults to the most recent
#'   completed season.
#' @param ... Additional arguments passed to [nba_playerindex()] (e.g. `proxy`).
#' @return A `hoopR_data` tibble with one row per player:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_id \tab character \tab Player id (\code{PERSON_ID}). \cr
#'       player_name \tab character \tab Full name. \cr
#'       player_slug \tab character \tab URL-safe player slug. \cr
#'       team_id \tab character \tab Team id. \cr
#'       team_abbreviation \tab character \tab Team abbreviation. \cr
#'       team_name \tab character \tab Full team name. \cr
#'       position \tab character \tab Listed position. \cr
#'       jersey_number \tab character \tab Jersey number. \cr
#'       height \tab character \tab Listed height. \cr
#'       weight \tab character \tab Listed weight. \cr
#'       country \tab character \tab Country. \cr
#'       draft_year \tab character \tab Draft year. \cr
#'       from_year \tab character \tab First season. \cr
#'       to_year \tab character \tab Most recent season. \cr
#'       headshot_url \tab character \tab NBA CDN headshot URL. \cr
#'       season \tab character \tab Season (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords NBA Dictionary
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble tibble
#' @family NBA Dictionary Functions
#' @export
#' @examples
#' \donttest{
#'   try(nba_player_dict())
#' }
nba_player_dict <- function(season = year_to_season(most_recent_nba_season() - 1), ...) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      res <- nba_playerindex(season = season, ...)
      pi <- res[["PlayerIndex"]]
      if (is.null(pi) || nrow(pi) == 0) stop("No player index returned", call. = FALSE)
      pi <- janitor::clean_names(pi)
      col <- function(nm) if (nm %in% names(pi)) pi[[nm]] else rep(NA_character_, nrow(pi))
      out <- dplyr::tibble(
        player_id         = col("person_id"),
        player_name       = trimws(paste(col("player_first_name"), col("player_last_name"))),
        player_slug       = col("player_slug"),
        team_id           = col("team_id"),
        team_abbreviation = col("team_abbreviation"),
        team_name         = trimws(paste(col("team_city"), col("team_name"))),
        position          = col("position"),
        jersey_number     = col("jersey_number"),
        height            = col("height"),
        weight            = col("weight"),
        country           = col("country"),
        draft_year        = col("draft_year"),
        from_year         = col("from_year"),
        to_year           = col("to_year"),
        headshot_url      = nba_player_headshot_url(col("person_id"))
      )
      out[["season"]] <- season
      df <- make_hoopR_data(out, "NBA player dictionary from stats.nba.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No NBA player dictionary for {season} available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning building NBA player dictionary", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title **NBA Team Dictionary**
#' @description A tidy team dictionary (id, abbreviation, name, conference,
#'   division, logo URL) derived from the stats.nba.com player index plus a
#'   static conference/division map.
#' @param season Season in `"YYYY-YY"` form. Defaults to the most recent
#'   completed season.
#' @param ... Additional arguments passed to [nba_playerindex()] (e.g. `proxy`).
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab character \tab Team id. \cr
#'       team_abbreviation \tab character \tab Team abbreviation. \cr
#'       team_city \tab character \tab Team city / region. \cr
#'       team_name \tab character \tab Team nickname. \cr
#'       team_full \tab character \tab Full team name. \cr
#'       conference \tab character \tab Conference (\code{Eastern} / \code{Western}). \cr
#'       division \tab character \tab Division. \cr
#'       logo_url \tab character \tab NBA CDN primary logo URL. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords NBA Dictionary
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble distinct left_join
#' @family NBA Dictionary Functions
#' @export
#' @examples
#' \donttest{
#'   try(nba_team_dict())
#' }
nba_team_dict <- function(season = year_to_season(most_recent_nba_season() - 1), ...) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      # historical = 0 -> current franchises only (30 teams), not all-time
      res <- nba_playerindex(season = season, historical = 0, ...)
      pi <- res[["PlayerIndex"]]
      if (is.null(pi) || nrow(pi) == 0) stop("No player index returned", call. = FALSE)
      pi <- janitor::clean_names(pi)
      teams <- dplyr::distinct(pi[, c("team_id", "team_city", "team_name", "team_abbreviation"),
                                  drop = FALSE])
      teams <- teams[!is.na(teams$team_id) & teams$team_id != "0" &
                       !is.na(teams$team_abbreviation) & teams$team_abbreviation != "", , drop = FALSE]
      teams$team_full <- trimws(paste(teams$team_city, teams$team_name))
      teams <- dplyr::left_join(teams, .nba_conf_div, by = "team_abbreviation")
      teams$logo_url <- nba_team_logo_url(teams$team_id)
      teams <- teams[, c("team_id", "team_abbreviation", "team_city", "team_name",
                         "team_full", "conference", "division", "logo_url"), drop = FALSE]
      teams <- teams[order(teams$conference, teams$division, teams$team_city), , drop = FALSE]
      df <- make_hoopR_data(dplyr::as_tibble(teams), "NBA team dictionary from stats.nba.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No NBA team dictionary available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning building NBA team dictionary", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
