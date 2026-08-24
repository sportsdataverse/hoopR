#' **Get ESPN NBA game data (Pbp, Team and Player Box)**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A named list of data frames: Plays, Team, Player
#'
#'    **Plays**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_plays_schema] table.
#'
#'    **Team**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_team_schema] table.
#'
#'    **Player**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_player_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_game_all(game_id = 401283399))
#' }
#'
espn_nba_game_all <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  pbp <- list(Plays = NULL, Team = NULL, Player = NULL)
  resp <- NULL
  plays_df <- NULL
  team_box_score <- NULL
  player_box_score <- NULL

  #---- Fetch the summary endpoint (single outer tryCatch) -------------------
  tryCatch(
    expr = {
      res <- .retry_request(full_url)
      check_status(res)
      resp <- res %>%
        .resp_text()
    },
    error = function(e) .report_api_error(
      e,
      hint = "Could not fetch game summary for game_id = {game_id}",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  if (is.null(resp)) {
    return(pbp)
  }

  #---- Play-by-Play ------
  tryCatch(
    expr = {
      plays_df <- helper_espn_nba_pbp(resp)

      if (is.null(plays_df)) {
        message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  #---- Team Box ------
  tryCatch(
    expr = {
      team_box_score <- helper_espn_nba_team_box(resp)

      if (is.null(team_box_score)) {
        message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  #---- Player Box ------
  tryCatch(
    expr = {
      player_box_score <- helper_espn_nba_player_box(resp)

      if (is.null(player_box_score)) {
        message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  pbp <- c(list(plays_df), list(team_box_score), list(player_box_score))
  names(pbp) <- c("Plays", "Team", "Player")
  return(pbp)
}


#' **Get ESPN NBA PBP data**
#' @rdname espn_nba_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A play-by-play data frame.
#'
#'    **Plays**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_plays_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA PBP
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_pbp(game_id = 401071880))
#' }
#'
espn_nba_pbp <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  plays_df <- NULL

  #---- Play-by-Play ------
  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      plays_df <- helper_espn_nba_pbp(resp)

      if (is.null(plays_df)) {
        return(message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )

  return(plays_df)
}


#' **Get ESPN NBA team box scores**
#' @rdname espn_nba_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A team boxscore data frame
#'
#'    **Team**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_team_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Team Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_team_box(game_id = 401071880))
#' }
#'
espn_nba_team_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  #---- Team Box ------
  team_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      team_box_score <- helper_espn_nba_team_box(resp)

      if (is.null(team_box_score)) {
        return(message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(team_box_score)
}
#' **Get ESPN NBA player box scores**
#' @rdname espn_nba_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A player boxscore data frame
#'
#'    **Player**
#'
#'
#'    Columns as documented in the shared [espn_nba_game_all_player_schema] table.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Player Box
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_player_box(game_id = 401071880))
#' }
#'
espn_nba_player_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  #---- Player Box ------
  player_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      player_box_score <- helper_espn_nba_player_box(resp)

      if (is.null(player_box_score)) {
        return(message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(player_box_score)
}


#' **Get ESPN NBA game rosters**
#' @rdname espn_nba_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A game rosters data frame
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab integer \tab Unique athlete identifier (ESPN). \cr
#'       athlete_uid \tab character \tab ESPN athlete UID (universal identifier). \cr
#'       athlete_guid \tab character \tab ESPN athlete GUID. \cr
#'       athlete_type \tab character \tab Athlete type / class. \cr
#'       sdr \tab integer \tab Sdr. \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       last_name \tab character \tab Player's last name. \cr
#'       full_name \tab character \tab Player's full name. \cr
#'       athlete_display_name \tab character \tab Athlete display name (full). \cr
#'       short_name \tab character \tab Short display name. \cr
#'       weight \tab integer \tab Player weight in pounds. \cr
#'       display_weight \tab character \tab Player weight in display format (e.g. '180 lbs'). \cr
#'       height \tab integer \tab Player height (string e.g. '6-2' or inches). \cr
#'       display_height \tab character \tab Player height in display format (e.g. '6-2'). \cr
#'       age \tab integer \tab Player age (in years). \cr
#'       date_of_birth \tab character \tab Date of birth (YYYY-MM-DD). \cr
#'       debut_year \tab integer \tab Year of professional debut. \cr
#'       birth_place_city \tab character \tab Birth place city. \cr
#'       birth_place_state \tab character \tab Birth place state. \cr
#'       birth_place_country \tab character \tab Birth place country. \cr
#'       slug \tab character \tab URL-safe identifier. \cr
#'       headshot_href \tab character \tab Headshot image URL. \cr
#'       headshot_alt \tab character \tab Alternative-text label for the headshot. \cr
#'       jersey \tab character \tab Jersey number worn by the player. \cr
#'       position_id \tab integer \tab Unique position identifier. \cr
#'       position_name \tab character \tab Listed roster position ('Guard', 'Forward', 'Center'). \cr
#'       position_display_name \tab character \tab Position display name. \cr
#'       position_abbreviation \tab character \tab Position abbreviation ('G' / 'F' / 'C'). \cr
#'       position_leaf \tab logical \tab Position leaf. \cr
#'       linked \tab logical \tab TRUE if the record is linked to a related entity. \cr
#'       years \tab integer \tab Years. \cr
#'       active \tab logical \tab TRUE if the row represents an active record (player / team / season). \cr
#'       contract_bird_status \tab integer \tab Contract bird status. \cr
#'       contract_active \tab logical \tab Contract active. \cr
#'       contract_active_1 \tab logical \tab Contract active 1. \cr
#'       contract_incoming_trade_value \tab integer \tab Contract incoming trade value. \cr
#'       contract_outgoing_trade_value \tab integer \tab Contract outgoing trade value. \cr
#'       contract_minimum_salary_exception \tab logical \tab Contract minimum salary exception. \cr
#'       contract_option_type \tab integer \tab Contract option type. \cr
#'       contract_salary \tab integer \tab Contract salary. \cr
#'       contract_salary_remaining \tab integer \tab Contract salary remaining. \cr
#'       contract_years_remaining \tab integer \tab Contract years remaining. \cr
#'       contract_trade_kicker_active \tab logical \tab Contract trade kicker active. \cr
#'       contract_trade_kicker_percentage \tab integer \tab Contract trade kicker percentage (0-1 decimal). \cr
#'       contract_trade_kicker_value \tab integer \tab Contract trade kicker value. \cr
#'       contract_trade_kicker_trade_value \tab integer \tab Contract trade kicker trade value. \cr
#'       contract_trade_restriction \tab logical \tab Contract trade restriction. \cr
#'       contract_unsigned_foreign_pick \tab logical \tab Contract unsigned foreign pick. \cr
#'       contract_active_2 \tab logical \tab Contract active 2. \cr
#'       draft_display_text \tab character \tab Draft display text. \cr
#'       draft_round \tab integer \tab Round of the draft selection. \cr
#'       draft_year \tab integer \tab Draft year (4-digit). \cr
#'       draft_selection \tab integer \tab Draft selection. \cr
#'       status_id \tab integer \tab Status identifier. \cr
#'       status_name \tab character \tab Status label. \cr
#'       status_type \tab character \tab Status type. \cr
#'       status_abbreviation \tab character \tab Status abbreviation. \cr
#'       starter \tab logical \tab TRUE if the player was in the starting lineup; FALSE otherwise. \cr
#'       valid \tab logical \tab Valid. \cr
#'       did_not_play \tab logical \tab TRUE if the player did not appear in the game. \cr
#'       display_name \tab character \tab Display name. \cr
#'       reason \tab character \tab Reason. \cr
#'       ejected \tab logical \tab TRUE if the player was ejected from the game. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_guid \tab character \tab ESPN team GUID. \cr
#'       team_uid \tab character \tab ESPN universal team identifier (UID format 's:40~l:...~t:...'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       team_location \tab character \tab Team city or location string. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       team_display_name \tab character \tab Full team display name. \cr
#'       team_short_display_name \tab character \tab Short team display name (e.g. 'Aces'). \cr
#'       team_color \tab character \tab Team primary color (hex without leading '#'). \cr
#'       team_alternate_color \tab character \tab Team alternate color (hex without leading '#'). \cr
#'       team_is_active \tab logical \tab TRUE if the team is currently active. \cr
#'       team_is_all_star \tab logical \tab TRUE if the row represents an All-Star team. \cr
#'       logo_href \tab character \tab Team or league logo URL. \cr
#'       logo_dark_href \tab character \tab Logo URL for dark backgrounds. \cr
#'       logos_href_2 \tab character \tab Logos href 2. \cr
#'       logos_href_3 \tab character \tab Logos href 3. \cr
#'       game_id \tab integer \tab Unique game identifier. \cr
#'       order \tab integer \tab Display order within the result set. \cr
#'       home_away \tab character \tab Game venue label ('home' or 'away'). \cr
#'       winner \tab logical \tab Winner. \cr
#'       citizenship \tab character \tab Citizenship. \cr
#'       contract_base_year_compensation_active \tab logical \tab Contract base year compensation active. \cr
#'       contract_base_year_compensation_expiration \tab character \tab Contract base year compensation expiration. \cr
#'       hand_type \tab character \tab Hand type. \cr
#'       hand_abbreviation \tab character \tab Hand abbreviation. \cr
#'       hand_display_value \tab character \tab Hand display value. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords NBA Game Roster
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_game_rosters(game_id = 401283399))
#' }
espn_nba_game_rosters <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  athlete_roster_df <- .empty_hoopR_data("ESPN NBA Game Roster Information from ESPN.com")

  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/events/",
        game_id,
        "/competitions/",
        game_id,
        "/competitors/"
      )
      game_res <- .retry_request(play_base_url)
      # Check the result
      check_status(game_res)

      game_resp <- game_res %>%
        .resp_text()
      game_df <- jsonlite::fromJSON(game_resp)[["items"]] %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename("team_statistics_href" = "statistics.$ref")

      colnames(game_df) <- gsub(".\\$ref", "_href", colnames(game_df))

      game_df <- game_df %>%
        dplyr::rename(
          "team_id" = "id",
          "team_uid" = "uid"
        )

      game_df$game_id <- game_id

      teams_df <- purrr::map_dfr(game_df$team_href, function(x) {
        res <- .retry_request(x)
        # Check the result
        check_status(res)

        team_df <- res %>%
          .resp_text() %>%
          jsonlite::fromJSON(
            simplifyDataFrame = FALSE,
            simplifyVector = FALSE,
            simplifyMatrix = FALSE
          )

        team_df[["links"]] <- NULL
        team_df[["injuries"]] <- NULL
        team_df[["record"]] <- NULL
        team_df[["athletes"]] <- NULL
        team_df[["venue"]] <- NULL
        team_df[["groups"]] <- NULL
        team_df[["ranks"]] <- NULL
        team_df[["statistics"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["links"]] <- NULL
        team_df[["notes"]] <- NULL
        team_df[["franchise"]] <- NULL
        team_df[["againstTheSpreadRecords"]] <- NULL
        team_df[["oddsRecords"]] <- NULL
        team_df[["college"]] <- NULL
        team_df[["transactions"]] <- NULL
        team_df[["leaders"]] <- NULL
        team_df[["depthCharts"]] <- NULL
        team_df[["awards"]] <- NULL
        team_df[["events"]] <- NULL

        team_df <- team_df %>%
          purrr::map_if(is.list, as.data.frame) %>%
          as.data.frame() %>%
          dplyr::select(
            -dplyr::any_of(
              c(
                "logos.width",
                "logos.height",
                "logos.alt",
                "logos.rel..full.",
                "logos.rel..default.",
                "logos.rel..scoreboard.",
                "logos.rel..scoreboard..1",
                "logos.rel..scoreboard.2",
                "logos.lastUpdated",
                "logos.width.1",
                "logos.height.1",
                "logos.alt.1",
                "logos.rel..full..1",
                "logos.rel..dark.",
                "logos.rel..dark..1",
                "logos.lastUpdated.1",
                "logos.width.2",
                "logos.height.2",
                "logos.alt.2",
                "logos.rel..full..2",
                "logos.rel..scoreboard.",
                "logos.lastUpdated.2",
                "logos.width.3",
                "logos.height.3",
                "logos.alt.3",
                "logos.rel..full..3",
                "logos.lastUpdated.3",
                "X.ref",
                "X.ref.1",
                "X.ref.2"
              )
            )
          ) %>%
          janitor::clean_names()

        colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

        team_df <- team_df %>%
          dplyr::rename(
            "logo_href" = "logos_href",
            "logo_dark_href" = "logos_href_1"
          ) %>%
          dplyr::left_join(
            game_df %>%
              dplyr::select(
                "game_id",
                "team_id",
                "team_uid",
                "order",
                "homeAway",
                "winner",
                "roster_href"
              ),
            by = c(
              "team_id" = "team_id",
              "team_uid" = "team_uid"
            )
          )
      })

      ## Inputs
      ## game_id
      team_roster_df <- purrr::map_dfr(teams_df$team_id, function(x) {
        res <- .retry_request(paste0(play_base_url, x, "/roster"))

        # Check the result
        check_status(res)

        resp <- res %>%
          .resp_text()

        raw_play_df <- jsonlite::fromJSON(resp)[["entries"]]

        raw_play_df <- raw_play_df %>%
          jsonlite::toJSON() %>%
          jsonlite::fromJSON(flatten = TRUE) %>%
          dplyr::mutate(team_id = x) %>%
          dplyr::select(-"period", -"forPlayerId", -"active")

        raw_play_df <- raw_play_df %>%
          dplyr::left_join(teams_df, by = c("team_id" = "team_id"))
      })

      colnames(team_roster_df) <- gsub(
        ".\\$ref",
        "_href",
        colnames(team_roster_df)
      )

      athlete_roster_df <- purrr::map_dfr(
        team_roster_df$athlete_href,
        function(x) {
          res <- .retry_request(x)

          # Check the result
          check_status(res)

          resp <- res %>%
            .resp_text()

          raw_play_df <- jsonlite::fromJSON(resp, flatten = TRUE)
          raw_play_df[["links"]] <- NULL
          raw_play_df[["injuries"]] <- NULL
          raw_play_df[["teams"]] <- NULL
          raw_play_df[["team"]] <- NULL
          raw_play_df[["college"]] <- NULL
          raw_play_df[["proAthlete"]] <- NULL
          raw_play_df[["statistics"]] <- NULL
          raw_play_df[["notes"]] <- NULL
          raw_play_df[["eventLog"]] <- NULL
          raw_play_df[["$ref"]] <- NULL
          raw_play_df[["position"]][["$ref"]] <- NULL

          raw_play_df2 <- raw_play_df %>%
            jsonlite::toJSON() %>%
            jsonlite::fromJSON(flatten = TRUE) %>%
            as.data.frame() %>%
            dplyr::mutate(id = as.integer(.data$id)) %>%
            dplyr::rename(
              "athlete_id" = "id",
              "athlete_uid" = "uid",
              "athlete_guid" = "guid",
              "athlete_type" = "type",
              "athlete_display_name" = "displayName",
              "athlete_jersey_number" = "jersey"
            )

          raw_play_df2 <- raw_play_df2 %>%
            dplyr::left_join(team_roster_df, by = c("athlete_id" = "playerId"))
        }
      )

      colnames(athlete_roster_df) <- gsub(
        ".\\$ref",
        "_href",
        colnames(athlete_roster_df)
      )

      athlete_roster_df <- athlete_roster_df %>%
        janitor::clean_names() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "x_ref",
            "x_ref_1",
            "contract_ref",
            "contract_ref_1",
            "contract_ref_2",
            "draft_ref",
            "draft_ref_1",
            "athlete_href",
            "position_ref",
            "position_href",
            "roster_href",
            "statistics_href"
          ))
        ) %>%
        dplyr::mutate_at(
          c(
            "game_id",
            "athlete_id",
            "team_id",
            "position_id",
            "status_id",
            "sdr"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Game Roster Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game roster data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(athlete_roster_df)
}


#' **Get ESPN NBA team names and IDs**
#' @author Saiem Gilani
#' @return A teams data frame
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       abbreviation \tab character \tab Short abbreviation. \cr
#'       display_name \tab character \tab Display name. \cr
#'       short_name \tab character \tab Short display name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       nickname \tab character \tab Team or athlete nickname. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       color \tab character \tab Primary color (hex without leading '#'). \cr
#'       alternate_color \tab character \tab Alternate color (hex without leading '#'). \cr
#'       logo \tab character \tab Team or league logo URL. \cr
#'       logo_dark \tab character \tab Logo dark. \cr
#'       logos_href_3 \tab character \tab Logos href 3. \cr
#'       logos_href_4 \tab character \tab Logos href 4. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import rvest
#' @export
#' @keywords NBA Teams
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_teams())
#' }
#'
espn_nba_teams <- function() {
  .args <- .capture_args()
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  teams_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams?limit=1000"

  teams <- .empty_hoopR_data("ESPN NBA Teams Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(teams_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      leagues <- jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][[
        "teams"
      ]][[1]][["team"]] %>%
        dplyr::group_by(.data$id) %>%
        tidyr::unnest_wider("logos", names_sep = "_") %>%
        tidyr::unnest_wider("logos_href", names_sep = "_") %>%
        dplyr::select(
          -"logos_width",
          -"logos_height",
          -"logos_alt",
          -"logos_rel"
        ) %>%
        dplyr::ungroup()

      if ("records" %in% colnames(leagues)) {
        records <- leagues$record
        records <- records %>%
          tidyr::unnest_wider("items") %>%
          tidyr::unnest_wider("stats", names_sep = "_") %>%
          dplyr::mutate(row = dplyr::row_number())
        stat <- records %>%
          dplyr::group_by(.data$row) %>%
          purrr::map_if(is.data.frame, list)
        stat <- lapply(stat$stats_1, function(x) {
          x %>%
            purrr::map_if(is.data.frame, list) %>%
            dplyr::as_tibble()
        })

        s <- lapply(stat, function(x) {
          tidyr::pivot_wider(x)
        })

        s <- tibble::tibble(g = s)
        stats <- s %>%
          tidyr::unnest_wider("g")

        records <- dplyr::bind_cols(records %>% dplyr::select("summary"), stats)
        leagues <- leagues %>%
          dplyr::select(-"record")
      }
      leagues <- leagues %>%
        dplyr::select(
          -"links",
          -"isActive",
          -"isAllStar",
          -"uid",
          -"slug"
        )
      teams <- leagues %>%
        dplyr::rename(
          "logo" = "logos_href_1",
          "logo_dark" = "logos_href_2",
          "mascot" = "name",
          "team" = "location",
          "team_id" = "id",
          "short_name" = "shortDisplayName",
          "alternate_color" = "alternateColor",
          "display_name" = "displayName"
        ) %>%
        janitor::clean_names() %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        make_hoopR_data("ESPN NBA Teams Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no teams data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(teams)
}


#' **Get ESPN NBA current team roster**
#'
#' @author Saiem Gilani
#' @param team_id Either numeric or character (YYYY)
#' @return A teams data frame
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import rvest
#' @export
#' @keywords NBA Team Roster
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_team_current_roster(team_id = 13))
#' }
espn_nba_team_current_roster <- function(team_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  team_roster_full <- .empty_hoopR_data("ESPN NBA Team Current Roster Information from ESPN.com")

  tryCatch(
    expr = {
      teams_base_url <- sprintf(
        "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/%s?enable=roster",
        team_id
      )

      res <- .retry_request(teams_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      team_roster <- resp %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("team") %>%
        purrr::discard_at(c("links", "nextEvent", "record"))

      players <- team_roster %>%
        purrr::pluck("athletes") %>%
        purrr::discard_at(c("links", "injuries", "teams")) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::as_tibble() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "headshot.width",
            "headshot.height",
            "headshot.alt",
            "headshot.rel",
            "teams",
            "flag.alt",
            "flag.rel",
            "flag.width",
            "flag.height"
          ))
        )

      colnames(players) <- paste0("athlete_", colnames(players))

      players <- players %>%
        dplyr::mutate(
          athlete_id = as.integer(.data$athlete_id),
          team_id = as.integer(team_id)
        ) %>%
        janitor::clean_names()

      conference_info <- team_roster %>%
        purrr::pluck("groups") %>%
        dplyr::as_tibble() %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename(dplyr::any_of(c(
          "group_id" = "id",
          "group_is_conference" = "isConference",
          "parent_group_id" = "parent"
        ))) %>%
        dplyr::mutate(
          group_id = as.integer(.data$group_id),
          conference_id = .data$group_id,
          parent_group_id = as.integer(.data$parent_group_id)
        )

      team_roster_full <- team_roster %>%
        purrr::discard_at(c("groups", "athletes")) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        data.frame() %>%
        dplyr::slice(1:2) %>%
        dplyr::mutate(
          logo = .data$logos.href[1],
          logo_dark = .data$logos.href[2]
        ) %>%
        dplyr::slice(1) %>%
        dplyr::select(
          -dplyr::any_of(c(
            "logos.href",
            "logos.width",
            "logos.height",
            "logos.alt",
            "logos.rel",
            "logos.lastUpdated"
          ))
        ) %>%
        dplyr::rename(dplyr::any_of(c(
          "team_id" = "id",
          "team_uid" = "uid",
          "team_guid" = "guid",
          "team_slug" = "slug",
          "team_is_active" = "isActive",
          "team_type" = "type",
          "team_display_name" = "displayName",
          "team_short_name" = "shortDisplayName",
          "team_location" = "location",
          "team_name" = "name",
          "team_nickname" = "nickname",
          "team_abbreviation" = "abbreviation",
          "team_color" = "color",
          "team_alternate_color" = "alternateColor"
        ))) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        dplyr::bind_cols(conference_info) %>%
        dplyr::left_join(players, by = c("team_id" = "team_id")) %>%
        make_hoopR_data(
          "ESPN NBA Team Current Roster Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team current roster data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(team_roster_full)
}


#' **Get ESPN NBA schedule for a specific year**
#'
#' @param season Either numeric or character (YYYYMMDD)
#' @return Returns a tibble with scoreboard data
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       matchup \tab character \tab Matchup. \cr
#'       matchup_short \tab character \tab Matchup short. \cr
#'       season \tab integer \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       season_type \tab integer \tab Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). \cr
#'       season_slug \tab character \tab Season slug. \cr
#'       game_id \tab integer \tab Unique game identifier. \cr
#'       game_uid \tab character \tab Game uid. \cr
#'       game_date \tab Date \tab Game date (YYYY-MM-DD). \cr
#'       attendance \tab integer \tab Reported attendance. \cr
#'       notes \tab logical \tab Free-form notes attached to the record. \cr
#'       status_name \tab character \tab Status label. \cr
#'       broadcasts \tab logical \tab JSON array of broadcast records. \cr
#'       start_date \tab character \tab Start date (YYYY-MM-DD). \cr
#'       geo_broadcasts \tab logical \tab Geo broadcasts. \cr
#'       game_date_time \tab POSIXct \tab Game start date/time (ISO 8601). \cr
#'       home_team_name \tab character \tab Home team name. \cr
#'       home_team_logo \tab character \tab Home team logo URL. \cr
#'       home_team_abb \tab character \tab Home team's team abb. \cr
#'       home_team_id \tab integer \tab Unique identifier for the home team. \cr
#'       home_team_location \tab character \tab Home team's team location. \cr
#'       home_team_full_name \tab character \tab Full home team name (e.g. 'Las Vegas Aces'). \cr
#'       home_team_color \tab character \tab Home team primary color (hex). \cr
#'       home_score \tab integer \tab Home team score at the time of the play. \cr
#'       home_win \tab integer \tab Home team's win. \cr
#'       home_record \tab character \tab Home win-loss record. \cr
#'       away_team_name \tab character \tab Away team name. \cr
#'       away_team_logo \tab character \tab Away team logo URL. \cr
#'       away_team_abb \tab character \tab Away team's team abb. \cr
#'       away_team_id \tab integer \tab Unique identifier for the away team. \cr
#'       away_team_location \tab character \tab Away team's team location. \cr
#'       away_team_full_name \tab character \tab Full away team name (e.g. 'Las Vegas Aces'). \cr
#'       away_team_color \tab character \tab Away team primary color (hex). \cr
#'       away_score \tab integer \tab Away team score at the time of the play. \cr
#'       away_win \tab integer \tab Away team's win. \cr
#'       away_record \tab character \tab Away win-loss record. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom lubridate with_tz ymd_hm
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @examples
#'
#' # Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
#' \donttest{
#' try(espn_nba_scoreboard(season = 20230423))
#' }
espn_nba_scoreboard <- function(season) {
  .args <- mget(setdiff(names(formals()), "..."))
  max_year <- as.integer(substr(Sys.Date(), 1, 4))

  if (!(as.integer(substr(season, 1, 4)) > 2001)) {
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  schedule_api <- sprintf(
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?limit=1000&dates=%s",
    season_dates
  )

  tryCatch(
    expr = {
      res <- .retry_request(schedule_api)

      # Check the result
      check_status(res)

      raw_sched <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      nba_data <- raw_sched[["events"]] %>%
        tibble::tibble(data = .data$.) %>%
        tidyr::unnest_wider("data") %>%
        tidyr::unchop("competitions") %>%
        dplyr::select(
          -"id",
          -"uid",
          -"date",
          -"status"
        ) %>%
        tidyr::unnest_wider("competitions") %>%
        dplyr::rename(
          "matchup" = "name",
          "matchup_short" = "shortName",
          "game_id" = "id",
          "game_uid" = "uid",
          "game_date" = "date"
        ) %>%
        tidyr::hoist("status", status_name = list("type", "name")) %>%
        dplyr::select(
          !dplyr::any_of(
            c(
              "timeValid",
              "neutralSite",
              "conferenceCompetition",
              "recent",
              "venue",
              "type"
            )
          )
        ) %>%
        tidyr::unnest_wider("season", names_sep = "_") %>%
        dplyr::rename("season" = "season_year") %>%
        dplyr::select(-dplyr::any_of("status"))

      nba_data <- nba_data %>%
        dplyr::mutate(
          game_date_time = lubridate::ymd_hm(substr(
            .data$game_date,
            1,
            nchar(.data$game_date) - 1
          )) %>%
            lubridate::with_tz(tzone = "America/New_York"),
          game_date = as.Date(substr(.data$game_date_time, 1, 10))
        )

      nba_data <- nba_data %>%
        tidyr::hoist(
          "competitors",
          homeAway = list(1, "homeAway")
        )
      nba_data <- nba_data %>%
        tidyr::hoist(
          "competitors",
          team1_team_name = list(1, "team", "name"),
          team1_team_logo = list(1, "team", "logo"),
          team1_team_abb = list(1, "team", "abbreviation"),
          team1_team_id = list(1, "team", "id"),
          team1_team_location = list(1, "team", "location"),
          team1_team_full = list(1, "team", "displayName"),
          team1_team_color = list(1, "team", "color"),
          team1_score = list(1, "score"),
          team1_win = list(1, "winner"),
          team1_record = list(1, "records", 1, "summary"),
          # away team
          team2_team_name = list(2, "team", "name"),
          team2_team_logo = list(2, "team", "logo"),
          team2_team_abb = list(2, "team", "abbreviation"),
          team2_team_id = list(2, "team", "id"),
          team2_team_location = list(2, "team", "location"),
          team2_team_full = list(2, "team", "displayName"),
          team2_team_color = list(2, "team", "color"),
          team2_score = list(2, "score"),
          team2_win = list(2, "winner"),
          team2_record = list(2, "records", 1, "summary")
        )

      nba_data <- nba_data %>%
        dplyr::mutate(
          home_team_name = ifelse(
            .data$homeAway == "home",
            .data$team1_team_name,
            .data$team2_team_name
          ),
          home_team_logo = ifelse(
            .data$homeAway == "home",
            .data$team1_team_logo,
            .data$team2_team_logo
          ),
          home_team_abb = ifelse(
            .data$homeAway == "home",
            .data$team1_team_abb,
            .data$team2_team_abb
          ),
          home_team_id = ifelse(
            .data$homeAway == "home",
            .data$team1_team_id,
            .data$team2_team_id
          ),
          home_team_location = ifelse(
            .data$homeAway == "home",
            .data$team1_team_location,
            .data$team2_team_location
          ),
          home_team_full_name = ifelse(
            .data$homeAway == "home",
            .data$team1_team_full,
            .data$team2_team_full
          ),
          home_team_color = ifelse(
            .data$homeAway == "home",
            .data$team1_team_color,
            .data$team2_team_color
          ),
          home_score = ifelse(
            .data$homeAway == "home",
            .data$team1_score,
            .data$team2_score
          ),
          home_win = ifelse(
            .data$homeAway == "home",
            .data$team1_win,
            .data$team2_win
          ),
          home_record = ifelse(
            .data$homeAway == "home",
            .data$team1_record,
            .data$team2_record
          ),
          away_team_name = ifelse(
            .data$homeAway == "away",
            .data$team1_team_name,
            .data$team2_team_name
          ),
          away_team_logo = ifelse(
            .data$homeAway == "away",
            .data$team1_team_logo,
            .data$team2_team_logo
          ),
          away_team_abb = ifelse(
            .data$homeAway == "away",
            .data$team1_team_abb,
            .data$team2_team_abb
          ),
          away_team_id = ifelse(
            .data$homeAway == "away",
            .data$team1_team_id,
            .data$team2_team_id
          ),
          away_team_location = ifelse(
            .data$homeAway == "away",
            .data$team1_team_location,
            .data$team2_team_location
          ),
          away_team_full_name = ifelse(
            .data$homeAway == "away",
            .data$team1_team_full,
            .data$team2_team_full
          ),
          away_team_color = ifelse(
            .data$homeAway == "away",
            .data$team1_team_color,
            .data$team2_team_color
          ),
          away_score = ifelse(
            .data$homeAway == "away",
            .data$team1_score,
            .data$team2_score
          ),
          away_win = ifelse(
            .data$homeAway == "away",
            .data$team1_win,
            .data$team2_win
          ),
          away_record = ifelse(
            .data$homeAway == "away",
            .data$team1_record,
            .data$team2_record
          )
        )

      nba_data <- nba_data %>%
        dplyr::mutate_at(
          c(
            "game_id",
            "home_team_id",
            "home_win",
            "away_team_id",
            "away_win",
            "home_score",
            "away_score"
          ),
          as.integer
        )
      nba_data <- nba_data %>%
        dplyr::select(
          -dplyr::any_of(dplyr::starts_with("team1")),
          -dplyr::any_of(dplyr::starts_with("team2")),
          -dplyr::any_of(c("homeAway"))
        )

      if ("leaders" %in% names(nba_data)) {
        schedule_out <- nba_data %>%
          tidyr::hoist(
            "leaders",
            # points
            points_leader_points = list(1, "leaders", 1, "value"),
            points_leader_stat = list(1, "leaders", 1, "displayValue"),
            points_leader_name = list(
              1,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            points_leader_shortname = list(
              1,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            points_leader_headshot = list(
              1,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            points_leader_team_id = list(1, "leaders", 1, "team", "id"),
            points_leader_pos = list(
              1,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
            # rebounds
            rebounds_leader_rebounds = list(2, "leaders", 1, "value"),
            rebounds_leader_stat = list(2, "leaders", 1, "displayValue"),
            rebounds_leader_name = list(
              2,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            rebounds_leader_shortname = list(
              2,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            rebounds_leader_headshot = list(
              2,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            rebounds_leader_team_id = list(2, "leaders", 1, "team", "id"),
            rebounds_leader_pos = list(
              2,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
            # assists
            assists_leader_assists = list(3, "leaders", 1, "value"),
            assists_leader_stat = list(3, "leaders", 1, "displayValue"),
            assists_leader_name = list(
              3,
              "leaders",
              1,
              "athlete",
              "displayName"
            ),
            assists_leader_shortname = list(
              3,
              "leaders",
              1,
              "athlete",
              "shortName"
            ),
            assists_leader_headshot = list(
              3,
              "leaders",
              1,
              "athlete",
              "headshot"
            ),
            assists_leader_team_id = list(3, "leaders", 1, "team", "id"),
            assists_leader_pos = list(
              3,
              "leaders",
              1,
              "athlete",
              "position",
              "abbreviation"
            ),
          )

        if (
          "broadcasts" %in%
            names(schedule_out) &&
            !any(is.na(schedule_out[["broadcasts"]]))
        ) {
          schedule_out %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        }
      } else {
        if (
          "broadcasts" %in%
            names(nba_data) &&
            !any(is.na(nba_data[["broadcasts"]]))
        ) {
          nba_data %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        } else {
          nba_data %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data(
              "ESPN NBA Scoreboard Information from ESPN.com",
              Sys.time()
            )
        }
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
}

#' **Get ESPN NBA's Standings**
#'
#' @param year Either numeric or character (YYYY)
#' @return A standings data frame
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team \tab character \tab Team-side label or team identifier. \cr
#'       avgpointsagainst \tab numeric \tab Avgpointsagainst. \cr
#'       avgpointsfor \tab numeric \tab Avgpointsfor. \cr
#'       clincher \tab numeric \tab Clincher. \cr
#'       differential \tab numeric \tab Differential. \cr
#'       divisionwinpercent \tab numeric \tab Divisionwinpercent. \cr
#'       gamesbehind \tab numeric \tab Gamesbehind. \cr
#'       leaguewinpercent \tab numeric \tab Leaguewinpercent. \cr
#'       losses \tab numeric \tab Total losses. \cr
#'       playoffseed \tab numeric \tab Playoffseed. \cr
#'       streak \tab numeric \tab Current streak (e.g. 'W3' for three-game win streak). \cr
#'       winpercent \tab numeric \tab Winpercent. \cr
#'       wins \tab numeric \tab Total wins. \cr
#'       leaguestandings \tab character \tab Leaguestandings. \cr
#'       home \tab character \tab Home. \cr
#'       road \tab character \tab Road. \cr
#'       vsdiv \tab character \tab Vsdiv. \cr
#'       vsconf \tab character \tab Vsconf. \cr
#'       lasttengames \tab character \tab Lasttengames. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @keywords NBA Standings
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_standings(year = 2021))
#' }
espn_nba_standings <- function(year) {
  .args <- mget(setdiff(names(formals()), "..."))
  standings_url <- "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings?region=us&lang=en&contentorigin=espn&type=0&level=1&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

  ## Inputs
  ## year
  full_url <- paste0(
    standings_url,
    "season=",
    year
  )

  standings <- .empty_hoopR_data("ESPN NBA Standings Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      raw_standings <- jsonlite::fromJSON(resp)[["standings"]]

      # Create a dataframe of all NBA teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]

      teams <- teams %>%
        dplyr::select("id", "displayName") %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName"
        )

      # creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <- data.table::rbindlist(
        standings_df,
        fill = TRUE,
        idcol = T
      )

      # Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <- ifelse(
        is.na(standings_data$value) & !is.na(standings_data$summary),
        standings_data$summary,
        standings_data$value
      )

      standings_data <- standings_data %>%
        dplyr::select(
          ".id",
          "type",
          "value"
        )

      # Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(names_from = "type", values_from = "value")

      standings_data <- standings_data %>%
        dplyr::select(-".id")

      # joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id)) %>%
        dplyr::mutate_at(
          c(
            "avgpointsagainst",
            "avgpointsfor",
            "clincher",
            "differential",
            "divisionwinpercent",
            "gamesbehind",
            "leaguewinpercent",
            "losses",
            "playoffseed",
            "streak",
            "winpercent",
            "wins"
          ),
          as.numeric
        )
      standings <- standings %>%
        make_hoopR_data(
          "ESPN NBA Standings Information from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no standings data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(standings)
}


#' **Get ESPN NBA's Betting information**
#'
#' @rdname espn_nba_game_all
#' @param game_id  Game ID
#' @returns Returns a named list of data frames: pickcenter, againstTheSpread, predictor
#'
#'    **pickcenter**
#'
#'
#'    Columns as documented in the shared [espn_mbb_betting_pickcenter_schema] table.
#'
#'    **againstTheSpread**
#'
#'
#'    Columns as documented in the shared [espn_mbb_betting_againstthespread_schema] table.
#'
#'    **predictor**
#'
#'
#'    Columns as documented in the shared [espn_mbb_betting_predictor_schema] table.
#'
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @export
#' @keywords NBA Betting
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_betting(game_id = 401283399))
#' }
espn_nba_betting <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=",
    game_id
  )

  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()

  betting <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      raw_summary <- jsonlite::fromJSON(resp)
      if ("pickcenter" %in% names(raw_summary)) {
        pickcenter <- jsonlite::fromJSON(
          jsonlite::toJSON(raw_summary$pickcenter),
          flatten = TRUE
        ) %>%
          janitor::clean_names() %>%
          dplyr::select(-dplyr::any_of("links")) %>%
          dplyr::mutate(game_id = as.integer(game_id)) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "provider_id",
            "away_team_odds_team_id",
            "home_team_odds_team_id"
          )), as.integer)) %>%
          make_hoopR_data(
            "ESPN NBA Pickcenter Information from ESPN.com",
            Sys.time()
          )
      }
      if ("againstTheSpread" %in% names(raw_summary)) {
        againstTheSpread <- jsonlite::fromJSON(jsonlite::toJSON(
          raw_summary$againstTheSpread
        )) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-dplyr::any_of("links")) %>%
          janitor::clean_names()
        records <- againstTheSpread$records

        teams$records <- records
        againstTheSpread <- teams %>%
          dplyr::mutate(
            game_id = as.integer(game_id),
            id = as.integer(.data$id),
            team_id = as.integer(.data$id)
          ) %>%
          make_hoopR_data(
            "ESPN NBA Against the Spread Information from ESPN.com",
            Sys.time()
          )
      }
      if ("predictor" %in% names(raw_summary)) {
        predictor_df <- data.frame(
          game_id = as.integer(game_id),
          home_team_id = as.integer(raw_summary$predictor$homeTeam$id),
          away_team_id = as.integer(raw_summary$predictor$awayTeam$id),
          away_team_game_projection = as.numeric(
            raw_summary$predictor$awayTeam$gameProjection
          ),
          away_team_chance_loss = as.numeric(
            raw_summary$predictor$awayTeam$teamChanceLoss
          )
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data(
            "ESPN NBA Predictor Information from ESPN.com",
            Sys.time()
          )
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no betting data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  if (nrow(pickcenter) == 0) {
    pickcenter <- .espn_basketball_pickcenter_fallback("nba", game_id)
  }
  betting <- c(list(pickcenter), list(againstTheSpread), list(predictor_df))
  names(betting) <- c("pickcenter", "againstTheSpread", "predictor")
  return(betting)
}


#' @title
#' **Get ESPN NBA team stats data**
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the team stats data
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_guid \tab character \tab ESPN team GUID. \cr
#'       team_uid \tab character \tab ESPN universal team identifier (UID format 's:40~l:...~t:...'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       team_location \tab character \tab Team city or location string. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       team_display_name \tab character \tab Full team display name. \cr
#'       team_short_display_name \tab character \tab Short team display name (e.g. 'Aces'). \cr
#'       team_color \tab character \tab Team primary color (hex without leading '#'). \cr
#'       team_alternate_color \tab character \tab Team alternate color (hex without leading '#'). \cr
#'       team_is_active \tab logical \tab TRUE if the team is currently active. \cr
#'       team_is_all_star \tab logical \tab TRUE if the row represents an All-Star team. \cr
#'       logo_href \tab character \tab Team or league logo URL. \cr
#'       logo_dark_href \tab character \tab Logo URL for dark backgrounds. \cr
#'       logos_href_2 \tab character \tab Logos href 2. \cr
#'       logos_href_3 \tab character \tab Logos href 3. \cr
#'       defensive_blocks \tab numeric \tab Short for blocked shot, number of times when a defensive player legally deflects a field goal attempt from an offensive player. \cr
#'       defensive_defensive_rebounds \tab numeric \tab The number of times when the defense obtains the possession of the ball after a missed shot by the offense. \cr
#'       defensive_steals \tab numeric \tab The number of times a defensive player forced a turnover by intercepting or deflecting a pass or a dribble of an offensive player. \cr
#'       defensive_turnover_points \tab numeric \tab The amount of points resulting from the possession following a turnover. \cr
#'       defensive_def_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds defensively. Rebound Rate = (Defensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Defensive Rebounds + Opponent Defensive Rebounds)). \cr
#'       defensive_avg_defensive_rebounds \tab numeric \tab The average defensive rebounds per game. \cr
#'       defensive_avg_blocks \tab numeric \tab The average blocks per game. \cr
#'       defensive_avg_steals \tab numeric \tab The average steals per game. \cr
#'       defensive_avg48defensive_rebounds \tab numeric \tab The average number of defensive rebounds per 48 minutes. \cr
#'       defensive_avg48blocks \tab numeric \tab The average number of blocks per 48 minutes. \cr
#'       defensive_avg48steals \tab numeric \tab The average number of steals per 48 minutes. \cr
#'       general_disqualifications \tab numeric \tab The number of times a player reached the foul limit. \cr
#'       general_flagrant_fouls \tab numeric \tab The number of fouls that the officials thought were unnecessary or excessive. \cr
#'       general_fouls \tab numeric \tab The number of times a player had illegal contact with the opponent. \cr
#'       general_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds. Rebound Rate = (Rebounds x Team Minutes) divided by (Player Minutes x (Team Rebounds + Opponent Rebounds)). \cr
#'       general_ejections \tab numeric \tab The number of times a player or coach is removed from the game as a result of a serious offense. \cr
#'       general_technical_fouls \tab numeric \tab The number of times an player or coach was called for a technical foul (unsportsmanlike conduct or violations). \cr
#'       general_rebounds \tab numeric \tab The total number of rebounds (offensive and defensive). \cr
#'       general_minutes \tab numeric \tab The total number of minutes played. \cr
#'       general_avg_minutes \tab numeric \tab The average number of minutes per game. \cr
#'       general_fantasy_rating \tab numeric \tab The Fantasy Rating of a player. \cr
#'       general_nba_rating \tab numeric \tab General nba rating. \cr
#'       general_plus_minus \tab numeric \tab A player's estimated on-court impact on team performance measured in point differential per 100 possessions. \cr
#'       general_avg_rebounds \tab numeric \tab The average rebounds per game. \cr
#'       general_avg_fouls \tab numeric \tab The average fouls committed per game. \cr
#'       general_avg_flagrant_fouls \tab numeric \tab The average number of flagrant fouls per game. \cr
#'       general_avg_technical_fouls \tab numeric \tab The average number of technical fouls per game. \cr
#'       general_avg_ejections \tab numeric \tab The average ejections per game. \cr
#'       general_avg_disqualifications \tab numeric \tab The average number of disqualifications per game. \cr
#'       general_assist_turnover_ratio \tab numeric \tab The average number of assists a player or team records per turnover. \cr
#'       general_steal_foul_ratio \tab numeric \tab The average number of steals a player or team records per foul committed. \cr
#'       general_block_foul_ratio \tab numeric \tab The average number of blocks a player or record per foul committed. \cr
#'       general_avg_team_rebounds \tab numeric \tab The average number of rebounds for a team per game. \cr
#'       general_total_rebounds \tab numeric \tab The total number of rebounds for a team or player. \cr
#'       general_total_technical_fouls \tab numeric \tab The total number of technical fouls for a team or player. \cr
#'       general_team_assist_turnover_ratio \tab numeric \tab The number of assists per turnover for a team. \cr
#'       general_team_rebounds \tab numeric \tab The total number of rebounds for a team. \cr
#'       general_steal_turnover_ratio \tab numeric \tab The number of steals per turnover. \cr
#'       general_avg48rebounds \tab numeric \tab The average number of rebounds per 48 minutes. \cr
#'       general_avg48fouls \tab numeric \tab The average number of fouls committed per 48 minutes. \cr
#'       general_avg48flagrant_fouls \tab numeric \tab The average number of flagrant fouls committed per 48 minutes. \cr
#'       general_avg48technical_fouls \tab numeric \tab The average number of technical fouls committed per 48 minutes. \cr
#'       general_avg48ejections \tab numeric \tab The average number of ejections per 48 minutes. \cr
#'       general_avg48disqualifications \tab numeric \tab The average number of disqualifications per 48 minutes. \cr
#'       general_r40 \tab numeric \tab Rebounds Per 40 Minutes. \cr
#'       general_games_played \tab numeric \tab Games Played. \cr
#'       general_games_started \tab numeric \tab The number of games started by an athlete. \cr
#'       general_double_double \tab numeric \tab The number of times double digit values were accumulated in 2 of the following categories: points, rebounds, assists, steals, and blocked shots. \cr
#'       general_triple_double \tab numeric \tab The number of times double digit values were accumulated in 3 of the following categories: points, rebounds, assists, steals, and blocked shots. \cr
#'       offensive_assists \tab numeric \tab The number of times a player who passes the ball to a teammate in a way that leads to a score by field goal, meaning that he or she was "assisting" in the basket. There is some judgment involved in deciding whether a passer should be credited with an assist. \cr
#'       offensive_effective_fg_pct \tab numeric \tab Offensive effective field goals percentage (0-1 decimal). \cr
#'       offensive_field_goals \tab numeric \tab Field Goal makes and attempts. \cr
#'       offensive_field_goals_attempted \tab numeric \tab The number of times a 2pt field goal was attempted. \cr
#'       offensive_field_goals_made \tab numeric \tab The number of times a 2pt field goal was made. \cr
#'       offensive_field_goal_pct \tab numeric \tab The ratio of field goals made to field goals attempted: FGM / FGA. \cr
#'       offensive_free_throws \tab numeric \tab Free Throw makes and attempts. \cr
#'       offensive_free_throw_pct \tab numeric \tab The ratio of free throws made to free throws attempted: FTM / FTA. \cr
#'       offensive_free_throws_attempted \tab numeric \tab The number of times a free throw was attempted. \cr
#'       offensive_free_throws_made \tab numeric \tab The number of times a free throw was made. \cr
#'       offensive_offensive_rebounds \tab numeric \tab The number of times when the offense obtains the possession of the ball after a missed shot. \cr
#'       offensive_points \tab numeric \tab The number of points scored. \cr
#'       offensive_turnovers \tab numeric \tab The number of times a player loses possession to the other team. \cr
#'       offensive_three_point_pct \tab numeric \tab The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA. \cr
#'       offensive_three_point_field_goals_attempted \tab numeric \tab The number of times a 3pt field goal was attempted. \cr
#'       offensive_three_point_field_goals_made \tab numeric \tab The number of times a 3pt field goal was made. \cr
#'       offensive_true_shooting_pct \tab numeric \tab What a team's shooting percentage would be if we accounted for free throws and 3-pointers. True Shooting Percentage = (Total points x 50) divided by ((FGA + (FTA x 0.44)). \cr
#'       offensive_team_turnovers \tab numeric \tab The number of turnovers for the team. \cr
#'       offensive_total_turnovers \tab numeric \tab The number of turnovers plus team turnovers for the team. \cr
#'       offensive_assist_ratio \tab numeric \tab The percentage of a team's possessions that ends in an assist. Assist Ratio = (Assists x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers). \cr
#'       offensive_points_in_paint \tab numeric \tab The amount of points scored in the area known as "the Paint"(the rectangle between the foul line and the baseline). \cr
#'       offensive_off_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds offensively. Offensive Rebound Rate = (Offensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Offensive Rebounds + Opponent Defensive Rebounds)). \cr
#'       offensive_turnover_ratio \tab numeric \tab The percentage of a team's possessions that end in a turnover. Turnover Ratio = (Turnover x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers). \cr
#'       offensive_fast_break_points \tab numeric \tab The number of points scored on fast breaks. \cr
#'       offensive_possessions \tab numeric \tab The total number of possessions for a team or player. \cr
#'       offensive_pace_factor \tab numeric \tab The number of possessions a team uses per game. \cr
#'       offensive_avg_field_goals_made \tab numeric \tab The average field goals made per game. \cr
#'       offensive_avg_field_goals_attempted \tab numeric \tab The average field goals attempted per game. \cr
#'       offensive_avg_three_point_field_goals_made \tab numeric \tab The average three point field goals made per game. \cr
#'       offensive_avg_three_point_field_goals_attempted \tab numeric \tab The average three point field goals attempted per game. \cr
#'       offensive_avg_free_throws_made \tab numeric \tab The average free throw shots made per game. \cr
#'       offensive_avg_free_throws_attempted \tab numeric \tab The average free throw shots attempted per game. \cr
#'       offensive_avg_points \tab numeric \tab The average number of points scored per game. \cr
#'       offensive_avg_offensive_rebounds \tab numeric \tab The average offensive rebounds per game. \cr
#'       offensive_avg_assists \tab numeric \tab The average assists per game. \cr
#'       offensive_avg_turnovers \tab numeric \tab The average turnovers committed per game. \cr
#'       offensive_offensive_rebound_pct \tab numeric \tab The percentage of the number of times they obtain the possession of the ball after a missed shot. \cr
#'       offensive_estimated_possessions \tab numeric \tab An estimation of the number of possessions for a team or player. \cr
#'       offensive_avg_estimated_possessions \tab numeric \tab The average number of estimated possessions per game for a team or player. \cr
#'       offensive_points_per_estimated_possessions \tab numeric \tab The number of points per estimated possession for a team or player. \cr
#'       offensive_avg_team_turnovers \tab numeric \tab The average number of turnovers for a team per game. \cr
#'       offensive_avg_total_turnovers \tab numeric \tab The average number of total turnovers for a team per game. \cr
#'       offensive_three_point_field_goal_pct \tab numeric \tab The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA. \cr
#'       offensive_two_point_field_goals_made \tab numeric \tab The number of 2-point field goals made for a team or player. \cr
#'       offensive_two_point_field_goals_attempted \tab numeric \tab The number of 2-point field goals attempted for a team or player. \cr
#'       offensive_avg_two_point_field_goals_made \tab numeric \tab The number of 2-point field goals made per game for a team or player. \cr
#'       offensive_avg_two_point_field_goals_attempted \tab numeric \tab The number of 2-point field goals attempted per game for a team or player. \cr
#'       offensive_two_point_field_goal_pct \tab numeric \tab The percentage of 2-points fields goals made by a team or player. \cr
#'       offensive_shooting_efficiency \tab numeric \tab The efficiency with which a team or player shoots the basketball. \cr
#'       offensive_scoring_efficiency \tab numeric \tab The efficiency with which a team or player scores the basketball. \cr
#'       offensive_avg48field_goals_made \tab numeric \tab The average number of fieldgoals made per 48 minutes. \cr
#'       offensive_avg48field_goals_attempted \tab numeric \tab The average number of fieldgoals attempted per 48 minutes. \cr
#'       offensive_avg48three_point_field_goals_made \tab numeric \tab The average per number of 3-Pointers made per 48 minutes. \cr
#'       offensive_avg48three_point_field_goals_attempted \tab numeric \tab The average number of 3-pointers attempted per 48 minutes. \cr
#'       offensive_avg48free_throws_made \tab numeric \tab The average number of Free Throws made per 48 minutes. \cr
#'       offensive_avg48free_throws_attempted \tab numeric \tab The average number of free throws attempted per 48 minutes. \cr
#'       offensive_avg48points \tab numeric \tab The average number of points scored per 48 minutes. \cr
#'       offensive_avg48offensive_rebounds \tab numeric \tab The average number of offenseive rebounds per 48 minutes. \cr
#'       offensive_avg48assists \tab numeric \tab The average number of assists per 48 minutes. \cr
#'       offensive_avg48turnovers \tab numeric \tab The average number of turnovers per 48 minutes. \cr
#'       offensive_p40 \tab numeric \tab Points Per 40 Minutes. \cr
#'       offensive_a40 \tab numeric \tab Assists Per 40 Minutes. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @keywords NBA Team Stats
#' @family ESPN NBA Functions
#'
#' @examples
#' \donttest{
#' try(espn_nba_team_stats(team_id = 13, year = 2020))
#' }
espn_nba_team_stats <- function(
    team_id,
    year,
    season_type = "regular",
    total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/",
    s_type,
    "/teams/",
    team_id,
    "/statistics/",
    totals
  )

  df <- data.frame()
  tryCatch(
    expr = {
      # Create the GET request and set response as res
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      # Get the content and return result as data.frame
      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_url <- df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL

      team_df <- team_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c(
              "logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"
            )
          )
        ) %>%
        janitor::clean_names()

      colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1"
        )

      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep = "_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = paste0(.data$name, "_", .data$stats_name)
        ) %>%
        dplyr::select(
          "stats_category_name",
          "stats_value"
        ) %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first
        ) %>%
        janitor::clean_names()

      df <- team_df %>%
        dplyr::bind_cols(df)

      df <- df %>%
        dplyr::mutate_at(
          c(
            "team_id"
          ),
          as.integer
        ) %>%
        make_hoopR_data("ESPN NBA Team Season Stats from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team season stats data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(df)
}

#' @title
#' **Get ESPN NBA player stats data**
#' @author Saiem Gilani
#' @param athlete_id Athlete ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @return Returns a tibble with the player stats data
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab integer \tab Unique athlete identifier (ESPN). \cr
#'       athlete_uid \tab character \tab ESPN athlete UID (universal identifier). \cr
#'       athlete_guid \tab character \tab ESPN athlete GUID. \cr
#'       athlete_type \tab character \tab Athlete type / class. \cr
#'       sdr \tab integer \tab Sdr. \cr
#'       first_name \tab character \tab Player's first name. \cr
#'       last_name \tab character \tab Player's last name. \cr
#'       full_name \tab character \tab Player's full name. \cr
#'       display_name \tab character \tab Display name. \cr
#'       short_name \tab character \tab Short display name. \cr
#'       weight \tab numeric \tab Player weight in pounds. \cr
#'       display_weight \tab character \tab Player weight in display format (e.g. '180 lbs'). \cr
#'       height \tab numeric \tab Player height (string e.g. '6-2' or inches). \cr
#'       display_height \tab character \tab Player height in display format (e.g. '6-2'). \cr
#'       age \tab integer \tab Player age (in years). \cr
#'       date_of_birth \tab character \tab Date of birth (YYYY-MM-DD). \cr
#'       slug \tab character \tab URL-safe identifier. \cr
#'       headshot_href \tab character \tab Headshot image URL. \cr
#'       headshot_alt \tab character \tab Alternative-text label for the headshot. \cr
#'       jersey \tab character \tab Jersey number worn by the player. \cr
#'       position_id \tab integer \tab Unique position identifier. \cr
#'       position_name \tab character \tab Listed roster position ('Guard', 'Forward', 'Center'). \cr
#'       position_display_name \tab character \tab Position display name. \cr
#'       position_abbreviation \tab character \tab Position abbreviation ('G' / 'F' / 'C'). \cr
#'       position_leaf \tab logical \tab Position leaf. \cr
#'       linked \tab logical \tab TRUE if the record is linked to a related entity. \cr
#'       years \tab integer \tab Years. \cr
#'       active \tab logical \tab TRUE if the row represents an active record (player / team / season). \cr
#'       contract_x_ref \tab character \tab Contract x ref. \cr
#'       contract_bird_status \tab integer \tab Contract bird status. \cr
#'       contract_active \tab logical \tab Contract active. \cr
#'       contract_active_1 \tab logical \tab Contract active 1. \cr
#'       contract_incoming_trade_value \tab integer \tab Contract incoming trade value. \cr
#'       contract_outgoing_trade_value \tab integer \tab Contract outgoing trade value. \cr
#'       contract_minimum_salary_exception \tab logical \tab Contract minimum salary exception. \cr
#'       contract_option_type \tab integer \tab Contract option type. \cr
#'       contract_salary \tab integer \tab Contract salary. \cr
#'       contract_salary_remaining \tab integer \tab Contract salary remaining. \cr
#'       contract_years_remaining \tab integer \tab Contract years remaining. \cr
#'       contract_x_ref_1 \tab character \tab Contract x ref 1. \cr
#'       contract_x_ref_2 \tab character \tab Contract x ref 2. \cr
#'       contract_trade_kicker_active \tab logical \tab Contract trade kicker active. \cr
#'       contract_trade_kicker_percentage \tab numeric \tab Contract trade kicker percentage (0-1 decimal). \cr
#'       contract_trade_kicker_value \tab integer \tab Contract trade kicker value. \cr
#'       contract_trade_kicker_trade_value \tab integer \tab Contract trade kicker trade value. \cr
#'       contract_trade_restriction \tab logical \tab Contract trade restriction. \cr
#'       contract_unsigned_foreign_pick \tab logical \tab Contract unsigned foreign pick. \cr
#'       contract_active_2 \tab logical \tab Contract active 2. \cr
#'       draft_display_text \tab character \tab Draft display text. \cr
#'       draft_round \tab integer \tab Round of the draft selection. \cr
#'       draft_year \tab integer \tab Draft year (4-digit). \cr
#'       draft_selection \tab integer \tab Draft selection. \cr
#'       draft_x_ref \tab character \tab Draft x ref. \cr
#'       draft_x_ref_1 \tab character \tab Draft x ref 1. \cr
#'       status_id \tab integer \tab Status identifier. \cr
#'       status_name \tab character \tab Status label. \cr
#'       status_type \tab character \tab Status type. \cr
#'       status_abbreviation \tab character \tab Status abbreviation. \cr
#'       defensive_blocks \tab numeric \tab Short for blocked shot, number of times when a defensive player legally deflects a field goal attempt from an offensive player. \cr
#'       defensive_defensive_rebounds \tab numeric \tab The number of times when the defense obtains the possession of the ball after a missed shot by the offense. \cr
#'       defensive_steals \tab numeric \tab The number of times a defensive player forced a turnover by intercepting or deflecting a pass or a dribble of an offensive player. \cr
#'       defensive_def_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds defensively. Rebound Rate = (Defensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Defensive Rebounds + Opponent Defensive Rebounds)). \cr
#'       defensive_avg_defensive_rebounds \tab numeric \tab The average defensive rebounds per game. \cr
#'       defensive_avg_blocks \tab numeric \tab The average blocks per game. \cr
#'       defensive_avg_steals \tab numeric \tab The average steals per game. \cr
#'       defensive_avg48defensive_rebounds \tab numeric \tab The average number of defensive rebounds per 48 minutes. \cr
#'       defensive_avg48blocks \tab numeric \tab The average number of blocks per 48 minutes. \cr
#'       defensive_avg48steals \tab numeric \tab The average number of steals per 48 minutes. \cr
#'       defensive_drpm \tab numeric \tab Defensive Real Plus-Minus. \cr
#'       general_disqualifications \tab numeric \tab The number of times a player reached the foul limit. \cr
#'       general_flagrant_fouls \tab numeric \tab The number of fouls that the officials thought were unnecessary or excessive. \cr
#'       general_fouls \tab numeric \tab The number of times a player had illegal contact with the opponent. \cr
#'       general_per \tab numeric \tab A numerical value for each of a player's accomplishments per-minute and is pace-adjusted for the team they play on. The league average in PER to 15.00 every season. \cr
#'       general_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds. Rebound Rate = (Rebounds x Team Minutes) divided by (Player Minutes x (Team Rebounds + Opponent Rebounds)). \cr
#'       general_ejections \tab numeric \tab The number of times a player or coach is removed from the game as a result of a serious offense. \cr
#'       general_technical_fouls \tab numeric \tab The number of times an player or coach was called for a technical foul (unsportsmanlike conduct or violations). \cr
#'       general_rebounds \tab numeric \tab The total number of rebounds (offensive and defensive). \cr
#'       general_vorp \tab numeric \tab Value Over Replacement Player. \cr
#'       general_warp \tab numeric \tab Wins Above Replacement Player. \cr
#'       general_rpm \tab numeric \tab Real Plus-Minus. \cr
#'       general_minutes \tab numeric \tab The total number of minutes played. \cr
#'       general_avg_minutes \tab numeric \tab The average number of minutes per game. \cr
#'       general_nba_rating \tab numeric \tab General nba rating. \cr
#'       general_plus_minus \tab numeric \tab A player's estimated on-court impact on team performance measured in point differential per 100 possessions. \cr
#'       general_avg_rebounds \tab numeric \tab The average rebounds per game. \cr
#'       general_avg_fouls \tab numeric \tab The average fouls committed per game. \cr
#'       general_avg_flagrant_fouls \tab numeric \tab The average number of flagrant fouls per game. \cr
#'       general_avg_technical_fouls \tab numeric \tab The average number of technical fouls per game. \cr
#'       general_avg_ejections \tab numeric \tab The average ejections per game. \cr
#'       general_avg_disqualifications \tab numeric \tab The average number of disqualifications per game. \cr
#'       general_assist_turnover_ratio \tab numeric \tab The average number of assists a player or team records per turnover. \cr
#'       general_steal_foul_ratio \tab numeric \tab The average number of steals a player or team records per foul committed. \cr
#'       general_block_foul_ratio \tab numeric \tab The average number of blocks a player or record per foul committed. \cr
#'       general_avg_team_rebounds \tab numeric \tab The average number of rebounds for a team per game. \cr
#'       general_total_rebounds \tab numeric \tab The total number of rebounds for a team or player. \cr
#'       general_total_technical_fouls \tab numeric \tab The total number of technical fouls for a team or player. \cr
#'       general_team_assist_turnover_ratio \tab numeric \tab The number of assists per turnover for a team. \cr
#'       general_steal_turnover_ratio \tab numeric \tab The number of steals per turnover. \cr
#'       general_avg48rebounds \tab numeric \tab The average number of rebounds per 48 minutes. \cr
#'       general_avg48fouls \tab numeric \tab The average number of fouls committed per 48 minutes. \cr
#'       general_avg48flagrant_fouls \tab numeric \tab The average number of flagrant fouls committed per 48 minutes. \cr
#'       general_avg48technical_fouls \tab numeric \tab The average number of technical fouls committed per 48 minutes. \cr
#'       general_avg48ejections \tab numeric \tab The average number of ejections per 48 minutes. \cr
#'       general_avg48disqualifications \tab numeric \tab The average number of disqualifications per 48 minutes. \cr
#'       general_r40 \tab numeric \tab Rebounds Per 40 Minutes. \cr
#'       general_games_played \tab numeric \tab Games Played. \cr
#'       general_games_started \tab numeric \tab The number of games started by an athlete. \cr
#'       general_double_double \tab numeric \tab The number of times double digit values were accumulated in 2 of the following categories: points, rebounds, assists, steals, and blocked shots. \cr
#'       general_triple_double \tab numeric \tab The number of times double digit values were accumulated in 3 of the following categories: points, rebounds, assists, steals, and blocked shots. \cr
#'       offensive_assists \tab numeric \tab The number of times a player who passes the ball to a teammate in a way that leads to a score by field goal, meaning that he or she was "assisting" in the basket. There is some judgment involved in deciding whether a passer should be credited with an assist. \cr
#'       offensive_effective_fg_pct \tab numeric \tab Offensive effective field goals percentage (0-1 decimal). \cr
#'       offensive_field_goals \tab numeric \tab Field Goal makes and attempts. \cr
#'       offensive_field_goals_attempted \tab numeric \tab The number of times a 2pt field goal was attempted. \cr
#'       offensive_field_goals_made \tab numeric \tab The number of times a 2pt field goal was made. \cr
#'       offensive_field_goal_pct \tab numeric \tab The ratio of field goals made to field goals attempted: FGM / FGA. \cr
#'       offensive_free_throws \tab numeric \tab Free Throw makes and attempts. \cr
#'       offensive_free_throw_pct \tab numeric \tab The ratio of free throws made to free throws attempted: FTM / FTA. \cr
#'       offensive_free_throws_attempted \tab numeric \tab The number of times a free throw was attempted. \cr
#'       offensive_free_throws_made \tab numeric \tab The number of times a free throw was made. \cr
#'       offensive_offensive_rebounds \tab numeric \tab The number of times when the offense obtains the possession of the ball after a missed shot. \cr
#'       offensive_points \tab numeric \tab The number of points scored. \cr
#'       offensive_turnovers \tab numeric \tab The number of times a player loses possession to the other team. \cr
#'       offensive_three_point_pct \tab numeric \tab The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA. \cr
#'       offensive_three_point_field_goals_attempted \tab numeric \tab The number of times a 3pt field goal was attempted. \cr
#'       offensive_three_point_field_goals_made \tab numeric \tab The number of times a 3pt field goal was made. \cr
#'       offensive_true_shooting_pct \tab numeric \tab What a team's shooting percentage would be if we accounted for free throws and 3-pointers. True Shooting Percentage = (Total points x 50) divided by ((FGA + (FTA x 0.44)). \cr
#'       offensive_total_turnovers \tab numeric \tab The number of turnovers plus team turnovers for the team. \cr
#'       offensive_assist_ratio \tab numeric \tab The percentage of a team's possessions that ends in an assist. Assist Ratio = (Assists x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers). \cr
#'       offensive_points_in_paint \tab numeric \tab The amount of points scored in the area known as "the Paint"(the rectangle between the foul line and the baseline). \cr
#'       offensive_off_rebound_rate \tab numeric \tab The percentage of missed shots that a team rebounds offensively. Offensive Rebound Rate = (Offensive Rebounds x Team Minutes) divided by (Player Minutes x (Team Offensive Rebounds + Opponent Defensive Rebounds)). \cr
#'       offensive_turnover_ratio \tab numeric \tab The percentage of a team's possessions that end in a turnover. Turnover Ratio = (Turnover x 100) divided by ((FGA + (FTA x 0.44) + Assists + Turnovers). \cr
#'       offensive_brick_index \tab numeric \tab How many points a player costs his team with his shooting compared with the league average on a per-40-minute basis. ((52.8 - TS\%) x (FGA + (FTA x 0.44))) / (Min/40) . \cr
#'       offensive_usage_rate \tab numeric \tab the number of possessions a player uses per 40 minutes. Usage Rate = ((FGA + (FT Att. x 0.44) + (Ast x 0.33) + TO) x 40 x League Pace) divided by (Minutes x Team Pace). \cr
#'       offensive_avg_field_goals_made \tab numeric \tab The average field goals made per game. \cr
#'       offensive_avg_field_goals_attempted \tab numeric \tab The average field goals attempted per game. \cr
#'       offensive_avg_three_point_field_goals_made \tab numeric \tab The average three point field goals made per game. \cr
#'       offensive_avg_three_point_field_goals_attempted \tab numeric \tab The average three point field goals attempted per game. \cr
#'       offensive_avg_free_throws_made \tab numeric \tab The average free throw shots made per game. \cr
#'       offensive_avg_free_throws_attempted \tab numeric \tab The average free throw shots attempted per game. \cr
#'       offensive_avg_points \tab numeric \tab The average number of points scored per game. \cr
#'       offensive_avg_offensive_rebounds \tab numeric \tab The average offensive rebounds per game. \cr
#'       offensive_avg_assists \tab numeric \tab The average assists per game. \cr
#'       offensive_avg_turnovers \tab numeric \tab The average turnovers committed per game. \cr
#'       offensive_offensive_rebound_pct \tab numeric \tab The percentage of the number of times they obtain the possession of the ball after a missed shot. \cr
#'       offensive_estimated_possessions \tab numeric \tab An estimation of the number of possessions for a team or player. \cr
#'       offensive_avg_estimated_possessions \tab numeric \tab The average number of estimated possessions per game for a team or player. \cr
#'       offensive_points_per_estimated_possessions \tab numeric \tab The number of points per estimated possession for a team or player. \cr
#'       offensive_avg_team_turnovers \tab numeric \tab The average number of turnovers for a team per game. \cr
#'       offensive_avg_total_turnovers \tab numeric \tab The average number of total turnovers for a team per game. \cr
#'       offensive_three_point_field_goal_pct \tab numeric \tab The ratio of 3pt field goals made to 3pt field goals attempted: 3PM / 3PA. \cr
#'       offensive_two_point_field_goals_made \tab numeric \tab The number of 2-point field goals made for a team or player. \cr
#'       offensive_two_point_field_goals_attempted \tab numeric \tab The number of 2-point field goals attempted for a team or player. \cr
#'       offensive_avg_two_point_field_goals_made \tab numeric \tab The number of 2-point field goals made per game for a team or player. \cr
#'       offensive_avg_two_point_field_goals_attempted \tab numeric \tab The number of 2-point field goals attempted per game for a team or player. \cr
#'       offensive_two_point_field_goal_pct \tab numeric \tab The percentage of 2-points fields goals made by a team or player. \cr
#'       offensive_shooting_efficiency \tab numeric \tab The efficiency with which a team or player shoots the basketball. \cr
#'       offensive_scoring_efficiency \tab numeric \tab The efficiency with which a team or player scores the basketball. \cr
#'       offensive_avg48field_goals_made \tab numeric \tab The average number of fieldgoals made per 48 minutes. \cr
#'       offensive_avg48field_goals_attempted \tab numeric \tab The average number of fieldgoals attempted per 48 minutes. \cr
#'       offensive_avg48three_point_field_goals_made \tab numeric \tab The average per number of 3-Pointers made per 48 minutes. \cr
#'       offensive_avg48three_point_field_goals_attempted \tab numeric \tab The average number of 3-pointers attempted per 48 minutes. \cr
#'       offensive_avg48free_throws_made \tab numeric \tab The average number of Free Throws made per 48 minutes. \cr
#'       offensive_avg48free_throws_attempted \tab numeric \tab The average number of free throws attempted per 48 minutes. \cr
#'       offensive_avg48points \tab numeric \tab The average number of points scored per 48 minutes. \cr
#'       offensive_avg48offensive_rebounds \tab numeric \tab The average number of offenseive rebounds per 48 minutes. \cr
#'       offensive_avg48assists \tab numeric \tab The average number of assists per 48 minutes. \cr
#'       offensive_avg48turnovers \tab numeric \tab The average number of turnovers per 48 minutes. \cr
#'       offensive_p40 \tab numeric \tab Points Per 40 Minutes. \cr
#'       offensive_a40 \tab numeric \tab Assists Per 40 Minutes. \cr
#'       offensive_orpm \tab numeric \tab Offensive Real Plus-Minus. \cr
#'       team_id \tab integer \tab Unique team identifier. \cr
#'       team_guid \tab character \tab ESPN team GUID. \cr
#'       team_uid \tab character \tab ESPN universal team identifier (UID format 's:40~l:...~t:...'). \cr
#'       team_slug \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       team_location \tab character \tab Team city or location string. \cr
#'       team_name \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       team_abbreviation \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       team_display_name \tab character \tab Full team display name. \cr
#'       team_short_display_name \tab character \tab Short team display name (e.g. 'Aces'). \cr
#'       team_color \tab character \tab Team primary color (hex without leading '#'). \cr
#'       team_alternate_color \tab character \tab Team alternate color (hex without leading '#'). \cr
#'       team_is_active \tab logical \tab TRUE if the team is currently active. \cr
#'       team_is_all_star \tab logical \tab TRUE if the row represents an All-Star team. \cr
#'       logo_href \tab character \tab Team or league logo URL. \cr
#'       logo_dark_href \tab character \tab Logo URL for dark backgrounds. \cr
#'       logos_href_2 \tab character \tab Logos href 2. \cr
#'       logos_href_3 \tab character \tab Logos href 3. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @keywords NBA Player Stats
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' try(espn_nba_player_stats(athlete_id = 1966, year = 2022))
#' }
espn_nba_player_stats <- function(
    athlete_id,
    year,
    season_type = "regular",
    total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/",
    s_type,
    "/athletes/",
    athlete_id,
    "/statistics/",
    totals
  )
  athlete_url <- paste0(
    base_url,
    year,
    "/athletes/",
    athlete_id
  )
  df <- data.frame()
  tryCatch(
    expr = {
      # Create the GET request and set response as res
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)
      # Create the GET request and set response as res
      athlete_res <- .retry_request(athlete_url)

      # Check the result
      check_status(athlete_res)

      athlete_df <- athlete_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_url <- athlete_df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(
          simplifyDataFrame = FALSE,
          simplifyVector = FALSE,
          simplifyMatrix = FALSE
        )

      team_df[["links"]] <- NULL
      team_df[["injuries"]] <- NULL
      team_df[["record"]] <- NULL
      team_df[["athletes"]] <- NULL
      team_df[["venue"]] <- NULL
      team_df[["groups"]] <- NULL
      team_df[["ranks"]] <- NULL
      team_df[["statistics"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["links"]] <- NULL
      team_df[["notes"]] <- NULL
      team_df[["franchise"]] <- NULL
      team_df[["againstTheSpreadRecords"]] <- NULL
      team_df[["oddsRecords"]] <- NULL
      team_df[["college"]] <- NULL
      team_df[["transactions"]] <- NULL
      team_df[["leaders"]] <- NULL
      team_df[["depthCharts"]] <- NULL
      team_df[["awards"]] <- NULL
      team_df[["events"]] <- NULL

      team_df <- team_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c(
              "logos.width",
              "logos.height",
              "logos.alt",
              "logos.rel..full.",
              "logos.rel..default.",
              "logos.rel..scoreboard.",
              "logos.rel..scoreboard..1",
              "logos.rel..scoreboard.2",
              "logos.lastUpdated",
              "logos.width.1",
              "logos.height.1",
              "logos.alt.1",
              "logos.rel..full..1",
              "logos.rel..dark.",
              "logos.rel..dark..1",
              "logos.lastUpdated.1",
              "logos.width.2",
              "logos.height.2",
              "logos.alt.2",
              "logos.rel..full..2",
              "logos.rel..scoreboard.",
              "logos.lastUpdated.2",
              "logos.width.3",
              "logos.height.3",
              "logos.alt.3",
              "logos.rel..full..3",
              "logos.lastUpdated.3",
              "X.ref",
              "X.ref.1",
              "X.ref.2"
            )
          )
        ) %>%
        janitor::clean_names()
      colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1"
        )

      athlete_df[["links"]] <- NULL
      athlete_df[["injuries"]] <- NULL
      athlete_df[["birthPlace"]] <- NULL

      athlete_df <- athlete_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        tibble::tibble(data = .data$.)
      athlete_df <- athlete_df$data %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(c(
            "X.ref",
            "X.ref.1",
            "X.ref.2",
            "X.ref.3",
            "X.ref.4",
            "X.ref.5",
            "X.ref.6",
            "X.ref.7",
            "X.ref.8",
            "position.X.ref",
            "position.X.ref.1",
            "contract.x.ref",
            "contract.x.ref.1",
            "contract.x.ref.2",
            "draft.x.ref",
            "draft.x.ref.1"
          ))
        ) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "athlete_id" = "id",
          "athlete_uid" = "uid",
          "athlete_guid" = "guid",
          "athlete_type" = "type"
        )

      # Get the content and return result as data.frame
      df <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep = "_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = paste0(.data$name, "_", .data$stats_name)
        ) %>%
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first
        ) %>%
        janitor::clean_names()
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        dplyr::mutate_at(
          c(
            "athlete_id",
            "team_id",
            "position_id",
            "status_id",
            "sdr"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Player Season Stats from ESPN.com",
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player season stats data available!",
      args = .args
    ),
    warning = function(w) {},
    finally = {}
  )
  return(df)
}

#'  **Parse ESPN NBA PBP, helper function**
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_pbp <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  pbp_source <- game_json[["header"]][["competitions"]][["playByPlaySource"]]

  plays <- game_json %>%
    purrr::pluck("plays") %>%
    dplyr::as_tibble()

  if (pbp_source != "none" && nrow(plays) > 10) {
    homeAway1 <- jsonlite::fromJSON(resp)[["header"]][["competitions"]][[
      "competitors"
    ]][[1]][["homeAway"]][1]

    gameId <- as.integer(game_json[["header"]][["id"]])
    season <- game_json[["header"]][["season"]][["year"]]
    season_type <- game_json[["header"]][["season"]][["type"]]
    game_date_time <- substr(
      game_json[["header"]][["competitions"]][["date"]],
      1,
      nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
    ) %>%
      lubridate::ymd_hm() %>%
      lubridate::with_tz(tzone = "America/New_York")

    game_date <- as.Date(substr(game_date_time, 0, 10))

    id_vars <- data.frame()
    if (homeAway1 == "home") {
      homeTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      homeTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(1, .default = NA_character_)
      )
      homeTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      awayTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      awayTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(2, .default = NA_character_)
      id_vars <- data.frame(
        homeTeamId,
        homeTeamMascot,
        homeTeamName,
        homeTeamAbbrev,
        homeTeamLogo,
        homeTeamLogoDark,
        homeTeamFullName,
        homeTeamColor,
        homeTeamAlternateColor,
        homeTeamScore,
        homeTeamWinner,
        homeTeamRecord,
        awayTeamId,
        awayTeamMascot,
        awayTeamName,
        awayTeamAbbrev,
        awayTeamLogo,
        awayTeamLogoDark,
        awayTeamFullName,
        awayTeamColor,
        awayTeamAlternateColor,
        awayTeamScore,
        awayTeamWinner,
        awayTeamRecord
      )
    } else {
      awayTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      awayTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      awayTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamId <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "team"
        ]][["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeTeamMascot <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[
        1
      ]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamScore <- as.integer(
        game_json[["header"]][["competitions"]][["competitors"]][[1]][[
          "score"
        ]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeTeamWinner <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][[
        "competitors"
      ]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(2, .default = NA_character_)
      id_vars <- data.frame(
        homeTeamId,
        homeTeamMascot,
        homeTeamName,
        homeTeamAbbrev,
        homeTeamLogo,
        homeTeamLogoDark,
        homeTeamFullName,
        homeTeamColor,
        homeTeamAlternateColor,
        homeTeamScore,
        homeTeamWinner,
        homeTeamRecord,
        awayTeamId,
        awayTeamMascot,
        awayTeamName,
        awayTeamAbbrev,
        awayTeamLogo,
        awayTeamLogoDark,
        awayTeamFullName,
        awayTeamColor,
        awayTeamAlternateColor,
        awayTeamScore,
        awayTeamWinner,
        awayTeamRecord
      )
    }

    game_json <- game_json %>%
      jsonlite::toJSON() %>%
      jsonlite::fromJSON(flatten = TRUE)

    plays <- game_json %>%
      purrr::pluck("plays")

    if ("coordinate.x" %in% names(plays) & "coordinate.y" %in% names(plays)) {
      plays <- plays %>%
        dplyr::mutate(
          # convert types
          coordinate.x = as.double(.data$coordinate.x),
          coordinate.y = as.double(.data$coordinate.y),
          # Free throws are adjusted automatically to 19' from baseline, which
          # corresponds to 13.75' from the center of the basket (originally
          # the center of the basket is (25, 0))
          coordinate.y = dplyr::case_when(
            stringr::str_detect(.data$type.text, "Free Throw") ~ 13.75,
            TRUE ~ .data$coordinate.y
          ),
          coordinate.x = dplyr::case_when(
            stringr::str_detect(.data$type.text, "Free Throw") ~ 25,
            TRUE ~ .data$coordinate.x
          ),
          coordinate_x_transformed = dplyr::case_when(
            .data$team.id == homeTeamId ~ -1 * (.data$coordinate.y - 41.75),
            TRUE ~ .data$coordinate.y - 41.75
          ),
          coordinate_y_transformed = dplyr::case_when(
            .data$team.id == homeTeamId ~ -1 * (.data$coordinate.x - 25),
            TRUE ~ .data$coordinate.x - 25
          )
        ) %>%
        dplyr::rename(
          "coordinate.x.raw" = "coordinate.x",
          "coordinate.y.raw" = "coordinate.y",
          "coordinate.x" = "coordinate_x_transformed",
          "coordinate.y" = "coordinate_y_transformed"
        )
    }

    ## Written this way for compliance with data repository processing
    if ("participants" %in% names(plays)) {
      plays <- plays %>%
        tidyr::unnest_wider("participants")
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(
            "id",
            "athlete.id"
          ) %>%
          tidyr::unnest_wider("athlete.id", names_sep = "_")
      )
      names(aths) <- c(
        "play.id",
        "athlete.id.1",
        "athlete.id.2",
        "athlete.id.3"
      )
      plays <- plays %>%
        dplyr::bind_cols(aths) %>%
        janitor::clean_names() %>%
        dplyr::mutate(dplyr::across(
          dplyr::any_of(c(
            "athlete_id_1",
            "athlete_id_2",
            "athlete_id_3"
          )),
          ~ as.integer(.x)
        ))
    }
    ## Written this way for compliance with data repository processing
    if (!("homeTeamName" %in% names(plays))) {
      plays <- plays %>%
        dplyr::bind_cols(id_vars)
    }

    plays <- plays %>%
      dplyr::select(-dplyr::any_of(c("athlete.id", "athlete_id"))) %>%
      janitor::clean_names() %>%
      dplyr::mutate(
        game_id = gameId,
        season = season,
        season_type = season_type,
        game_date = game_date,
        game_date_time = game_date_time
      ) %>%
      dplyr::rename(dplyr::any_of(c(
        "athlete_id_1" = "participants_0_athlete_id",
        "athlete_id_2" = "participants_1_athlete_id",
        "athlete_id_3" = "participants_2_athlete_id"
      )))

    plays <- plays %>%
      dplyr::mutate(dplyr::across(
        dplyr::any_of(c(
          "athlete_id_1",
          "athlete_id_2",
          "athlete_id_3",
          "type_id",
          "team_id"
        )),
        ~ as.integer(.x)
      ))

    plays_df <- plays %>%
      make_hoopR_data(
        "ESPN NBA Play-by-Play Information from ESPN.com",
        Sys.time()
      )

    return(plays_df)
  }
}

#'  **Parse ESPN NBA Team Box, helper function**
#' @rdname helper_espn_nba_pbp
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_team_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  gameId <- as.integer(game_json[["header"]][["id"]])
  game_date_time <- substr(
    game_json[["header"]][["competitions"]][["date"]],
    1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))
  # ESPN's header `boxscoreAvailable` flag is unreliable for archival games
  # (pre-2014 WBB payloads carry full stats while the flag says FALSE -- the
  # same latent gate silently dropped a decade of wehoop boxscores), so
  # availability is derived from the payload itself; the statistics-length
  # check below remains the real gate.
  box_score_available <- length(game_json[["boxscore"]][["teams"]]) > 0
  if (box_score_available == TRUE) {
    teams_box_score_df <- game_json[["boxscore"]][["teams"]] %>%
      jsonlite::toJSON() %>%
      jsonlite::fromJSON(flatten = TRUE)
    if (length(teams_box_score_df[["statistics"]][[1]]) > 0) {
      # Teams info columns and values
      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]][1]
      homeAway1_team.id <- as.integer(teams_df[["id"]][1])
      homeAway1_team.score <- as.integer(teams_df[["score"]][1])
      homeAway1_team.winner <- teams_df[["winner"]][1]

      homeAway2 <- teams_df[["homeAway"]][2]
      homeAway2_team.id <- as.integer(teams_df[["id"]][2])
      homeAway2_team.score <- as.integer(teams_df[["score"]][2])
      homeAway2_team.winner <- teams_df[["winner"]][2]

      # Pivoting the table values for each team from long to wide
      statistics_df_1 <- teams_box_score_df[["statistics"]][[1]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      statistics_df_2 <- teams_box_score_df[["statistics"]][[2]] %>%
        tibble::tibble() %>%
        dplyr::select("name", "displayValue") %>%
        tidyr::spread("name", "displayValue")

      # Assigning values to the correct data frame rows - 1
      statistics_df_1$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        homeAway1,
        homeAway2
      )
      statistics_df_1$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      statistics_df_1$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        homeAway1_team.winner,
        homeAway2_team.winner
      )
      statistics_df_1$team.id <- as.integer(teams_box_score_df[["team.id"]][[
        1
      ]])
      statistics_df_1$team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_1$team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_1$team.location <- teams_box_score_df[["team.location"]][[
        1
      ]]
      statistics_df_1$team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_1$team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[1]]
      statistics_df_1$team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[1]]
      statistics_df_1$team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[1]]
      statistics_df_1$team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_1$team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[1]]
      statistics_df_1$team.logo <- teams_box_score_df[["team.logo"]][[1]]
      statistics_df_1$opponent.team.id <- as.integer(teams_box_score_df[[
        "team.id"
      ]][[2]])
      statistics_df_1$opponent.team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_1$opponent.team.slug <- teams_box_score_df[["team.slug"]][[
        2
      ]]
      statistics_df_1$opponent.team.location <- teams_box_score_df[[
        "team.location"
      ]][[2]]
      statistics_df_1$opponent.team.name <- teams_box_score_df[["team.name"]][[
        2
      ]]
      statistics_df_1$opponent.team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[2]]
      statistics_df_1$opponent.team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[2]]
      statistics_df_1$opponent.team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[2]]
      statistics_df_1$opponent.team.color <- teams_box_score_df[[
        "team.color"
      ]][[2]]
      statistics_df_1$opponent.team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[2]]
      statistics_df_1$opponent.team.logo <- teams_box_score_df[["team.logo"]][[
        2
      ]]
      statistics_df_1$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) ==
          as.integer(homeAway1_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      # Assigning values to the correct data frame rows - 2
      statistics_df_2$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        homeAway2,
        homeAway1
      )
      statistics_df_2$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      statistics_df_2$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        homeAway2_team.winner,
        homeAway1_team.winner
      )
      statistics_df_2$team.id <- as.integer(teams_box_score_df[["team.id"]][[
        2
      ]])
      statistics_df_2$team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_2$team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_2$team.location <- teams_box_score_df[["team.location"]][[
        2
      ]]
      statistics_df_2$team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_2$team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[2]]
      statistics_df_2$team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[2]]
      statistics_df_2$team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[2]]
      statistics_df_2$team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_2$team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[2]]
      statistics_df_2$team.logo <- teams_box_score_df[["team.logo"]][[2]]
      statistics_df_2$opponent.team.id <- as.integer(teams_box_score_df[[
        "team.id"
      ]][[1]])
      statistics_df_2$opponent.team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_2$opponent.team.slug <- teams_box_score_df[["team.slug"]][[
        1
      ]]
      statistics_df_2$opponent.team.location <- teams_box_score_df[[
        "team.location"
      ]][[1]]
      statistics_df_2$opponent.team.name <- teams_box_score_df[["team.name"]][[
        1
      ]]
      statistics_df_2$opponent.team.abbreviation <- teams_box_score_df[[
        "team.abbreviation"
      ]][[1]]
      statistics_df_2$opponent.team.displayName <- teams_box_score_df[[
        "team.displayName"
      ]][[1]]
      statistics_df_2$opponent.team.shortDisplayName <- teams_box_score_df[[
        "team.shortDisplayName"
      ]][[1]]
      statistics_df_2$opponent.team.color <- teams_box_score_df[[
        "team.color"
      ]][[1]]
      statistics_df_2$opponent.team.alternateColor <- teams_box_score_df[[
        "team.alternateColor"
      ]][[1]]
      statistics_df_2$opponent.team.logo <- teams_box_score_df[["team.logo"]][[
        1
      ]]
      statistics_df_2$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) ==
          as.integer(homeAway2_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      complete_statistics_df <- statistics_df_1 %>%
        dplyr::bind_rows(statistics_df_2)

      # Assigning game/season level data to team box score and converting types
      complete_statistics_df$season <- game_json[["header"]][["season"]][[
        "year"
      ]]
      complete_statistics_df$season_type <- game_json[["header"]][["season"]][[
        "type"
      ]]
      complete_statistics_df$game_date <- as.Date(substr(
        game_json[["header"]][["competitions"]][["date"]],
        0,
        10
      ))
      complete_statistics_df$game_id <- as.integer(gameId)
      complete_statistics_df$game_date_time <- game_date_time
      complete_statistics_df$game_date <- game_date

      suppressWarnings(
        complete_statistics_df <- complete_statistics_df %>%
          tidyr::separate(
            "fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c(
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted"
            ),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(
            c(
              "fieldGoalPct",
              "freeThrowPct",
              "threePointFieldGoalPct"
            ),
            ~ as.numeric(.x)
          )) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "assists",
              "blocks",
              "defensiveRebounds",
              "fieldGoalsMade",
              "fieldGoalsAttempted",
              "flagrantFouls",
              "fouls",
              "freeThrowsMade",
              "freeThrowsAttempted",
              "offensiveRebounds",
              "steals",
              "teamTurnovers",
              "technicalFouls",
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted",
              "totalRebounds",
              "totalTechnicalFouls",
              "totalTurnovers",
              "turnovers"
            )),
            ~ as.integer(.x)
          ))
      )
      team_box_score <- complete_statistics_df %>%
        janitor::clean_names() %>%
        dplyr::select(
          dplyr::any_of(c(
            "game_id",
            "season",
            "season_type",
            "game_date",
            "game_date_time",
            "team_id",
            "team_uid",
            "team_slug",
            "team_location",
            "team_name",
            "team_abbreviation",
            "team_display_name",
            "team_short_display_name",
            "team_color",
            "team_alternate_color",
            "team_logo",
            "team_home_away",
            "team_score",
            "team_winner"
          )),
          tidyr::everything()
        ) %>%
        make_hoopR_data(
          "ESPN NBA Team Box Information from ESPN.com",
          Sys.time()
        )

      return(team_box_score)
    }
  }
}

#'  **Parse ESPN NBA Player Box, helper function**
#' @rdname helper_espn_nba_pbp
#' @param resp Response object from the ESPN NBA game summary endpoint
#' @return Returns a tibble
#' @importFrom lubridate with_tz ymd_hm
#' @export
helper_espn_nba_player_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON(flatten = TRUE)

  players_box_score_df <- game_json[["boxscore"]][["players"]] %>%
    jsonlite::toJSON() %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as.data.frame()

  gameId <- as.integer(game_json[["header"]][["id"]])
  season <- game_json[["header"]][["season"]][["year"]]
  season_type <- game_json[["header"]][["season"]][["type"]]
  game_date_time <- substr(
    game_json[["header"]][["competitions"]][["date"]],
    1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    lubridate::ymd_hm() %>%
    lubridate::with_tz(tzone = "America/New_York")

  game_date <- as.Date(substr(game_date_time, 0, 10))

  boxScoreAvailable <- game_json[["header"]][["competitions"]][[
    "boxscoreAvailable"
  ]]

  boxScoreSource <- game_json[["header"]][["competitions"]][["boxscoreSource"]]

  # This is checking if  [[athletes]][[1]]'s stat rebounds is able to be converted to a numeric value
  #  without introducing NA's
  suppressWarnings(
    valid_stats <- players_box_score_df[["statistics"]][[1]][["athletes"]][[
      1
    ]][["stats"]][[1]] %>%
      purrr::pluck(7) %>%
      as.numeric()
  )
  if (
    # Payload presence replaces ESPN's unreliable header `boxscoreAvailable`
    # flag; the athlete and stat validity conjuncts below remain the real gate.
    length(game_json[["boxscore"]][["players"]]) > 0 &&
      length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]]) >
        1 &&
      !is.na(valid_stats)
  ) {
    players_df <- players_box_score_df %>%
      tidyr::unnest("statistics") %>%
      tidyr::unnest("athletes")
    if (
      length(players_box_score_df[["statistics"]]) > 1 &&
        length(players_df$stats[[1]]) > 0
    ) {
      players_df <- jsonlite::fromJSON(
        jsonlite::toJSON(game_json[["boxscore"]][["players"]]),
        flatten = TRUE
      ) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")

      stat_cols <- players_df$keys[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind, stats))
      colnames(stats_df) <- stat_cols
      suppressWarnings(
        stats_df <- stats_df %>%
          tidyr::separate(
            "fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate(
            "threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c(
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted"
            ),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "minutes",
              "fieldGoalPct",
              "freeThrowPct",
              "threePointFieldGoalPct"
            )),
            ~ as.numeric(.x)
          )) %>%
          dplyr::mutate(dplyr::across(
            dplyr::any_of(c(
              "assists",
              "blocks",
              "defensiveRebounds",
              "fieldGoalsMade",
              "fieldGoalsAttempted",
              "flagrantFouls",
              "fouls",
              "freeThrowsMade",
              "freeThrowsAttempted",
              "offensiveRebounds",
              "steals",
              "teamTurnovers",
              "technicalFouls",
              "threePointFieldGoalsMade",
              "threePointFieldGoalsAttempted",
              "rebounds",
              "totalTechnicalFouls",
              "totalTurnovers",
              "turnovers",
              "points"
            )),
            ~ as.integer(.x)
          ))
      )
      players_df_did_not_play <- players_df %>%
        dplyr::filter(.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(dplyr::any_of(c(
          "starter",
          "ejected",
          "didNotPlay",
          "reason",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.displayName",
          "team.shortDisplayName",
          "team.location",
          "team.name",
          "team.logo",
          "team.id",
          "team.uid",
          "team.slug",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )))

      players_df <- stats_df %>%
        dplyr::bind_cols(players_df) %>%
        dplyr::bind_rows(players_df_did_not_play)

      players_df <- players_df %>%
        dplyr::select(
          dplyr::any_of(c(
            "athlete.displayName",
            "team.shortDisplayName"
          )),
          tidyr::everything()
        ) %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_id = gameId,
          season = season,
          season_type = season_type,
          game_date = game_date,
          game_date_time = game_date_time
        )

      teams_df <- game_json[["header"]][["competitions"]][["competitors"]][[1]]

      homeAway1 <- teams_df[["homeAway"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.id <- as.integer(
        teams_df[["id"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )
      homeAway1_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.logos <- teams_df[["team.logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway1_team.score <- as.integer(
        teams_df[["score"]] %>%
          purrr::pluck(1, .default = NA_integer_)
      )

      homeAway2 <- teams_df[["homeAway"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.id <- as.integer(
        teams_df[["id"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )
      homeAway2_team.location <- teams_df[["team.location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.name <- teams_df[["team.name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.abbreviation <- teams_df[["team.abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.displayName <- teams_df[["team.displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.logos <- teams_df[["team.logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeAway2_team.color <- teams_df[["team.color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.alternateColor <- teams_df[["team.alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.winner <- teams_df[["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.score <- as.integer(
        teams_df[["score"]] %>%
          purrr::pluck(2, .default = NA_integer_)
      )

      players_df <- players_df %>%
        dplyr::mutate(
          home_away = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1,
            homeAway2
          ),
          team_winner = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1_team.winner,
            homeAway2_team.winner
          ),
          team_score = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway1_team.score,
            homeAway2_team.score
          ),
          opponent_team_id = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.id,
            homeAway1_team.id
          ),
          opponent_team_name = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.name,
            homeAway1_team.name
          ),
          opponent_team_location = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.location,
            homeAway1_team.location
          ),
          opponent_team_display_name = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.displayName,
            homeAway1_team.displayName
          ),
          opponent_team_abbreviation = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.abbreviation,
            homeAway1_team.abbreviation
          ),
          opponent_team_logo = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.logos,
            homeAway1_team.logos
          ),
          opponent_team_color = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.color,
            homeAway1_team.color
          ),
          opponent_team_alternate_color = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.alternateColor,
            homeAway1_team.alternateColor
          ),
          opponent_team_score = ifelse(
            .data$team_id == homeAway1_team.id,
            homeAway2_team.score,
            homeAway1_team.score
          ),
        ) %>%
        dplyr::arrange(.data$home_away)

      player_box_score <- players_df %>%
        dplyr::select(dplyr::any_of(c(
          "game_id",
          "season",
          "season_type",
          "game_date",
          "game_date_time",
          "athlete_id",
          "athlete_display_name",
          "team_id",
          "team_name",
          "team_location",
          "team_short_display_name",
          "minutes",
          "field_goals_made",
          "field_goals_attempted",
          "three_point_field_goals_made",
          "three_point_field_goals_attempted",
          "free_throws_made",
          "free_throws_attempted",
          "offensive_rebounds",
          "defensive_rebounds",
          "rebounds",
          "assists",
          "steals",
          "blocks",
          "turnovers",
          "fouls",
          "plus_minus",
          "points",
          "starter",
          "ejected",
          "did_not_play",
          "reason",
          "active",
          "athlete_jersey",
          "athlete_short_name",
          "athlete_headshot_href",
          "athlete_position_name",
          "athlete_position_abbreviation",
          "team_display_name",
          "team_uid",
          "team_slug",
          "team_logo",
          "team_abbreviation",
          "team_color",
          "team_alternate_color",
          "home_away",
          "team_winner",
          "team_score",
          "opponent_team_id",
          "opponent_team_name",
          "opponent_team_location",
          "opponent_team_display_name",
          "opponent_team_abbreviation",
          "opponent_team_logo",
          "opponent_team_color",
          "opponent_team_alternate_color",
          "opponent_team_score"
        ))) %>%
        dplyr::mutate_at(
          c(
            "athlete_id",
            "team_id",
            "team_score",
            "opponent_team_score"
          ),
          as.integer
        ) %>%
        make_hoopR_data(
          "ESPN NBA Player Box Information from ESPN.com",
          Sys.time()
        )

      return(player_box_score)
    }
  }
}
