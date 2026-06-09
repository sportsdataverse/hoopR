#' @title
#' **HoopsHype Player Salaries**
#' @description
#' **Get NBA player salaries from [HoopsHype](https://hoopshype.com).**
#'
#' Returns the full league's player salaries, one row per player per contract
#' season (current plus future seasons HoopsHype lists). No API key is required;
#' dollar figures are returned as numeric.
#'
#' HoopsHype is a Next.js app whose single salaries page paginates client-side,
#' but each team's salary page (`/salaries/{team}/`) embeds that team's complete
#' roster in its `__NEXT_DATA__` payload. This function iterates the 30 team
#' pages and stitches them together (≈30 requests per call) using a team-by-team
#' approach.
#' @return A `hoopR_data` tibble with one row per player-season:
#'
#'    |col_name         |types     |description                                   |
#'    |:----------------|:---------|:---------------------------------------------|
#'    |player_id        |character |HoopsHype player id.                          |
#'    |player           |character |Player name.                                  |
#'    |first_name       |character |Player first name.                            |
#'    |last_name        |character |Player last name.                            |
#'    |team_id          |character |HoopsHype team id.                            |
#'    |team             |character |Team name.                                    |
#'    |season           |integer   |Contract season (4-digit ending year).        |
#'    |salary           |numeric   |Salary for the season (USD).                  |
#'    |cap_allocation   |numeric   |Cap allocation for the season (USD).          |
#'    |team_option      |logical   |Whether the season is a team option.          |
#'    |player_option    |logical   |Whether the season is a player option.        |
#'    |two_way          |logical   |Whether it is a two-way contract.             |
#'    |qualifying_offer |logical   |Whether it is a qualifying offer.             |
#'
#' @keywords Salaries
#' @importFrom dplyr as_tibble
#' @importFrom data.table rbindlist
#' @family Salary & Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(hoopshype_salaries())
#' }
hoopshype_salaries <- function() {
  .args <- .capture_args()

  teams <- c(
    "atlanta_hawks", "boston_celtics", "brooklyn_nets", "charlotte_hornets",
    "chicago_bulls", "cleveland_cavaliers", "dallas_mavericks", "denver_nuggets",
    "detroit_pistons", "golden_state_warriors", "houston_rockets", "indiana_pacers",
    "los_angeles_clippers", "los_angeles_lakers", "memphis_grizzlies", "miami_heat",
    "milwaukee_bucks", "minnesota_timberwolves", "new_orleans_pelicans",
    "new_york_knicks", "oklahoma_city_thunder", "orlando_magic", "philadelphia_76ers",
    "phoenix_suns", "portland_trail_blazers", "sacramento_kings", "san_antonio_spurs",
    "toronto_raptors", "utah_jazz", "washington_wizards"
  )

  df <- data.frame()

  tryCatch(
    expr = {
      # locate the contracts array within a page's __NEXT_DATA__ React Query cache
      contracts_of <- function(nd) {
        queries <- nd$props$pageProps$dehydratedState$queries
        for (q in queries) {
          d <- q$state$data
          if (is.list(d) && !is.null(d$contracts) && is.list(d$contracts) &&
              !is.null(d$contracts$contracts)) {
            return(d$contracts$contracts)
          }
        }
        list()
      }

      rows <- list()
      for (slug in teams) {
        team_rows <- tryCatch({
          doc <- .ext_html(paste0("https://hoopshype.com/salaries/", slug, "/"))
          contracts <- contracts_of(.next_data(doc))
          do.call(c, lapply(contracts, function(ct) {
            pl <- ct$player
            lapply(ct$seasons, function(se) list(
              player_id     = .na(ct$playerID),
              player        = .na(ct$playerName),
              first_name    = .na(pl$firstName),
              last_name     = .na(pl$lastName),
              team_id       = .na(pl$team$id),
              team          = trimws(paste(.na(pl$team$location), .na(pl$team$nickname))),
              season        = .na(se$season),
              salary        = .na(se$salary),
              cap_allocation= .na(se$capAllocation),
              team_option   = .na(se$teamOption),
              player_option = .na(se$playerOption),
              two_way       = .na(se$twoWayContract),
              qualifying_offer = .na(se$qualifyingOffer)
            ))
          }))
        }, error = function(e) NULL)
        if (!is.null(team_rows)) rows <- c(rows, team_rows)
      }

      df <- data.table::rbindlist(rows, use.names = TRUE, fill = TRUE)
      df <- dplyr::as_tibble(df)
      if ("team" %in% colnames(df)) df[["team"]][df[["team"]] %in% c("NA NA", "NA", "")] <- NA_character_
      df <- make_hoopR_data(df, "Player salaries from hoopshype.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No HoopsHype salary data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching HoopsHype salaries", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
