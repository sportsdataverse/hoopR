#' **Get ESPN men's college basketball data (Pbp, Team and Player Box)**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @eval .returns_rd("espn_mbb_game_all")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Game
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examples
#' \donttest{
#' try(espn_mbb_game_all(game_id = 401479672))
#' }
espn_mbb_game_all <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=", game_id
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
    warning = function(w) {

    },
    finally = {

    }
  )

  if (is.null(resp)) {
    return(pbp)
  }

  #---- Play-by-Play ------
  tryCatch(
    expr = {
      plays_df <- helper_espn_mbb_pbp(resp)

      if (is.null(plays_df)) {
        message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  #---- Team Box ------
  tryCatch(
    expr = {
      team_box_score <- helper_espn_mbb_team_box(resp)

      if (is.null(team_box_score)) {
        message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  #---- Player Box ------
  tryCatch(
    expr = {
      player_box_score <- helper_espn_mbb_player_box(resp)

      if (is.null(player_box_score)) {
        message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  pbp <- c(list(plays_df), list(team_box_score), list(player_box_score))
  names(pbp) <- c("Plays", "Team", "Player")
  return(pbp)
}



#' **Get ESPN men's college basketball PBP data**
#' @rdname espn_mbb_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @eval .returns_rd("espn_mbb_pbp")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB PBP
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examplesIf interactive()
#' \donttest{
#' # Same summary request as espn_mbb_game_all() above.
#' try(espn_mbb_pbp(game_id = 401479672))
#' }
#'
espn_mbb_pbp <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=", game_id
  )

  plays_df <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      plays_df <- helper_espn_mbb_pbp(resp)

      if (is.null(plays_df)) {
        return(message(sprintf("%s: No play-by-play data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no play-by-play data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )

  return(plays_df)
}
#' **Get ESPN men's college basketball team box scores**
#' @rdname espn_mbb_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @eval .returns_rd("espn_mbb_team_box")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Team Box
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examplesIf interactive()
#' \donttest{
#' # Same summary request as espn_mbb_game_all() above.
#' try(espn_mbb_team_box(game_id = 401479672))
#' }
espn_mbb_team_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=", game_id
  )

  team_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      team_box_score <- helper_espn_mbb_team_box(resp)

      if (is.null(team_box_score)) {
        return(message(sprintf("%s: No team box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(team_box_score)
}
#' **Get ESPN men's college basketball player box scores**
#' @rdname espn_mbb_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @eval .returns_rd("espn_mbb_player_box")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Player Box
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examplesIf interactive()
#' \donttest{
#' # Same summary request as espn_mbb_game_all() above.
#' try(espn_mbb_player_box(game_id = 401479672))
#' }
espn_mbb_player_box <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=", game_id
  )

  player_box_score <- NULL

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      player_box_score <- helper_espn_mbb_player_box(resp)

      if (is.null(player_box_score)) {
        return(message(sprintf("%s: No player box score data for %s available!", Sys.time(), game_id)))
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player box score data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(player_box_score)
}



#' **Get ESPN men's college basketball game rosters**
#' @rdname espn_mbb_game_all
#' @author Saiem Gilani
#' @param game_id Game ID
#' @eval .returns_rd("espn_mbb_game_rosters", unit = "athlete on a game roster")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Game Roster
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examplesIf interactive()
#' \donttest{
#' # One request per athlete on both rosters.
#' try(espn_mbb_game_rosters(game_id = 401256760))
#' }
espn_mbb_game_rosters <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  athlete_roster_df <- .empty_hoopR_data("ESPN MBB Game Roster Information from ESPN.com")

  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/events/",
        game_id, "/competitions/",
        game_id, "/competitors/"
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
          jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

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
      team_ids <- teams_df$team_id
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

      colnames(team_roster_df) <- gsub(".\\$ref", "_href", colnames(team_roster_df))

      athlete_roster_df <- purrr::map_dfr(team_roster_df$athlete_href, function(x) {
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
      })

      colnames(athlete_roster_df) <- gsub(".\\$ref", "_href", colnames(athlete_roster_df))
      athlete_roster_df <- athlete_roster_df %>%
        janitor::clean_names() %>%
        dplyr::select(-dplyr::any_of(c(
          "athlete_href",
          "position_href",
          "statistics_href"
        ))) %>%
        dplyr::mutate_at(c(
          "game_id",
          "athlete_id",
          "team_id",
          "position_id",
          "status_id",
          "sdr",
          "team_sdr"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Game Roster Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game roster data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(athlete_roster_df)
}



#' **Get ESPN conference names and IDs**
#' @author Saiem Gilani
#' @eval .returns_rd("espn_mbb_conferences", unit = "conference")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#' @keywords MBB Conferences
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examples
#' \donttest{
#' try(espn_mbb_conferences())
#' }
espn_mbb_conferences <- function() {
  .args <- .capture_args()
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  conferences <- .empty_hoopR_data(
    "ESPN MBB Conferences Information from ESPN.com",
    cols = c(
      "group_id", "conference_short_name", "conference_uid",
      "conference_name", "conference_logo", "parent_group_id",
      "conference_id"
    )
  )

  tryCatch(
    expr = {
      play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard/conferences?seasontype=2"

      res <- .retry_request(play_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      conferences <- jsonlite::fromJSON(resp)[["conferences"]] %>%
        dplyr::select(-dplyr::any_of(c("subGroups"))) %>%
        janitor::clean_names() %>%
        dplyr::filter(!(.data$group_id %in% c(0, 50))) %>%
        dplyr::mutate(
          group_id = as.integer(.data$group_id),
          conference_id = .data$group_id,
          parent_group_id = as.integer(.data$parent_group_id)
        ) %>%
        dplyr::rename(dplyr::any_of(c(
          "conference_short_name" = "short_name",
          "conference_uid" = "uid",
          "conference_name" = "name",
          "conference_logo" = "logo"
        ))) %>%
        make_hoopR_data("ESPN MBB Conferences Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no conferences info available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(conferences)
}

#' **Get ESPN men's college basketball team names and IDs**
#' @author Saiem Gilani
#' @param year Either numeric or character (YYYY)
#' @eval .returns_rd("espn_mbb_teams", unit = "team")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#'
#' @import rvest
#' @export
#' @keywords MBB Teams
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#' try(espn_mbb_teams())
#' }
espn_mbb_teams <- function(year = most_recent_mbb_season()) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  teams <- .empty_hoopR_data("ESPN MBB Teams Information from ESPN.com")

  tryCatch(
    expr = {
      teams_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams?limit=1000"

      res <- .retry_request(teams_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      leagues <-
        jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][["teams"]][[1]][["team"]] %>%
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

        records <-
          dplyr::bind_cols(records %>% dplyr::select("summary"), stats)
        leagues <- leagues %>%
          dplyr::select(-dplyr::any_of("record"))
      }
      league_drop_cols <- c("links", "isActive", "isAllStar", "uid", "slug")
      leagues <- leagues %>%
        dplyr::select(-dplyr::any_of(league_drop_cols))
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
        dplyr::mutate(team_id = as.integer(.data$team_id))

      conferences <- espn_mbb_conferences()

      # ---- Figuring out which teams are in which conference (32 calls)
      base_url <- "http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons"
      conferences_base_url <- sprintf(
        "%s/%s/types/2/groups/50/children?limit=1000&lang=en&region=us",
        base_url, year
      )

      res <- .retry_request(conferences_base_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      conf_items <- resp %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("items") %>%
        data.frame() %>%
        dplyr::rename("href" = "X.ref") %>%
        dplyr::mutate(
          group_id = as.integer(stringr::str_extract(.data$href, "(?<=groups\\/)\\d+")),
          teams_url = paste0(
            base_url, "/",
            year,
            "/types/2/groups/",
            .data$group_id,
            "/teams?lang=en&region=us"
          )
        )

      conference_teams <- purrr::map_dfr(conf_items$teams_url, function(x) {
        res <- .retry_request(x)

        # Check the result
        check_status(res)

        resp <- res %>%
          .resp_text()

        conf_items <- resp %>%
          jsonlite::fromJSON() %>%
          purrr::pluck("items") %>%
          data.frame() %>%
          dplyr::rename("href" = "X.ref") %>%
          dplyr::mutate(
            conference_url = x,
            group_id = as.integer(stringr::str_extract(x, "(?<=groups\\/)\\d+")),
            team_id = as.integer(stringr::str_extract(.data$href, "(?<=teams\\/)\\d+"))
          )
        return(conf_items)
      })

      # ESPN's flat teams?limit=1000 list silently drops some current D1
      # teams (#144, e.g. Queens/Lindenwood/Southern Indiana) that the
      # conference-group listing above still carries. Backfill any team_id
      # present in conference_teams but missing from the flat fetch by
      # querying it individually before joining conference info back on.
      missing_team_ids <- setdiff(unique(conference_teams$team_id), teams$team_id)
      if (length(missing_team_ids) > 0) {
        missing_teams <- purrr::map_dfr(missing_team_ids, function(tid) {
          t_res <- tryCatch(
            .retry_request(paste0(
              "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams/",
              tid
            )),
            error = function(e) NULL
          )
          if (is.null(t_res) || httr2::resp_status(t_res) != 200L) {
            return(NULL)
          }
          # Named `team_json` (not `team`) -- tibble() argument evaluation is
          # data-masked, so a `team = ` output column would otherwise shadow
          # this list for every later argument in the same tibble() call.
          team_json <- t_res %>% .resp_text() %>% jsonlite::fromJSON() %>% purrr::pluck("team")
          if (is.null(team_json) || is.null(team_json[["id"]])) {
            return(NULL)
          }
          logos <- team_json[["logos"]]
          tibble::tibble(
            team_id = as.integer(team_json[["id"]]),
            abbreviation = team_json[["abbreviation"]] %||% NA_character_,
            display_name = team_json[["displayName"]] %||% NA_character_,
            short_name = team_json[["shortDisplayName"]] %||% NA_character_,
            mascot = team_json[["name"]] %||% NA_character_,
            nickname = team_json[["nickname"]] %||% NA_character_,
            team = team_json[["location"]] %||% NA_character_,
            color = team_json[["color"]] %||% NA_character_,
            alternate_color = team_json[["alternateColor"]] %||% NA_character_,
            logo = if (is.data.frame(logos) && nrow(logos) > 0) logos[["href"]][1] else NA_character_,
            logo_dark = if (is.data.frame(logos) && nrow(logos) > 1) logos[["href"]][2] else NA_character_
          )
        })
        if (!is.null(missing_teams) && nrow(missing_teams) > 0) {
          teams <- dplyr::bind_rows(teams, missing_teams)
        }
      }

      teams <- teams %>%
        dplyr::left_join(conference_teams, by = c("team_id" = "team_id")) %>%
        dplyr::left_join(conferences, by = c("group_id" = "group_id")) %>%
        dplyr::mutate(
          team_id = as.integer(.data$team_id),
          parent_group_id = as.integer(.data$parent_group_id)
        ) %>%
        make_hoopR_data("ESPN MBB Teams Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no teams data available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(teams)
}

#' **Get ESPN men's college basketball current team roster**
#'
#' @author Saiem Gilani
#' @param team_id Either numeric or character (YYYY)
#' @return A teams data frame
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#'
#' @import rvest
#' @export
#' @keywords MBB Team Roster
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#' try(espn_mbb_team_current_roster(team_id = 150))
#' }
espn_mbb_team_current_roster <- function(team_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  team_roster_full <- .empty_hoopR_data("ESPN MBB Team Current Roster Information from ESPN.com")

  tryCatch(
    expr = {
      teams_base_url <- sprintf(
        "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams/%s?enable=roster",
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
        dplyr::select(-dplyr::any_of(c(
          "headshot.width",
          "headshot.height",
          "headshot.alt",
          "headshot.rel",
          "teams",
          "flag.alt",
          "flag.rel",
          "flag.width",
          "flag.height"
        )))

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
        dplyr::select(-dplyr::any_of(c(
          "logos.href",
          "logos.width",
          "logos.height",
          "logos.alt",
          "logos.rel",
          "logos.lastUpdated"
        ))) %>%
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
        make_hoopR_data("ESPN MBB Team Current Roster Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team current roster data available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(team_roster_full)
}


#' **Parse ESPN schedule, helper function**
#'
#' @param group The ESPN conference group. Most helpful ones:
#' * 50 - Regular season/NIT
#' * 55 - CBI
#' * 56 - CIT
#' * 100 - NCAA Tournament
#' @param season_dates Either numeric or character
#' @return Returns a tibble
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @import rvest
#' @noRd
parse_espn_mbb_scoreboard <- function(group, season_dates) {
  .args <- mget(setdiff(names(formals()), "..."))
  schedule_api <- sprintf(
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard?groups=%s&limit=1000&dates=%s",
    group, season_dates
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

      mbb_data <- raw_sched[["events"]] %>%
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
        tidyr::hoist("status",
          status_name = list("type", "name")
        ) %>%
        dplyr::select(!dplyr::any_of(
          c(
            "timeValid",
            "neutralSite",
            "conferenceCompetition",
            "recent",
            "venue",
            "type"
          )
        )) %>%
        tidyr::unnest_wider("season", names_sep = "_") %>%
        dplyr::rename("season" = "season_year") %>%
        dplyr::select(-dplyr::any_of("status"))

      mbb_data <- mbb_data %>%
        dplyr::mutate(
          game_date_time = .espn_utc_to_et(substr(.data$game_date, 1, nchar(.data$game_date) - 1)),
          game_date = as.Date(substr(.data$game_date_time, 1, 10))
        )

      mbb_data <- mbb_data %>%
        tidyr::hoist(
          "competitors",
          homeAway = list(1, "homeAway")
        )

      mbb_data <- mbb_data %>%
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


      mbb_data <- mbb_data %>%
        dplyr::mutate(
          home_team_name = ifelse(.data$homeAway == "home", .data$team1_team_name, .data$team2_team_name),
          home_team_logo = ifelse(.data$homeAway == "home", .data$team1_team_logo, .data$team2_team_logo),
          home_team_abb = ifelse(.data$homeAway == "home", .data$team1_team_abb, .data$team2_team_abb),
          home_team_id = ifelse(.data$homeAway == "home", .data$team1_team_id, .data$team2_team_id),
          home_team_location = ifelse(.data$homeAway == "home", .data$team1_team_location, .data$team2_team_location),
          home_team_full_name = ifelse(.data$homeAway == "home", .data$team1_team_full, .data$team2_team_full),
          home_team_color = ifelse(.data$homeAway == "home", .data$team1_team_color, .data$team2_team_color),
          home_score = ifelse(.data$homeAway == "home", .data$team1_score, .data$team2_score),
          home_win = ifelse(.data$homeAway == "home", .data$team1_win, .data$team2_win),
          home_record = ifelse(.data$homeAway == "home", .data$team1_record, .data$team2_record),
          away_team_name = ifelse(.data$homeAway == "away", .data$team1_team_name, .data$team2_team_name),
          away_team_logo = ifelse(.data$homeAway == "away", .data$team1_team_logo, .data$team2_team_logo),
          away_team_abb = ifelse(.data$homeAway == "away", .data$team1_team_abb, .data$team2_team_abb),
          away_team_id = ifelse(.data$homeAway == "away", .data$team1_team_id, .data$team2_team_id),
          away_team_location = ifelse(.data$homeAway == "away", .data$team1_team_location, .data$team2_team_location),
          away_team_full_name = ifelse(.data$homeAway == "away", .data$team1_team_full, .data$team2_team_full),
          away_team_color = ifelse(.data$homeAway == "away", .data$team1_team_color, .data$team2_team_color),
          away_score = ifelse(.data$homeAway == "away", .data$team1_score, .data$team2_score),
          away_win = ifelse(.data$homeAway == "away", .data$team1_win, .data$team2_win),
          away_record = ifelse(.data$homeAway == "away", .data$team1_record, .data$team2_record)
        )

      mbb_data <- mbb_data %>%
        dplyr::mutate_at(c(
          "game_id",
          "home_team_id",
          "home_win",
          "away_team_id",
          "away_win",
          "home_score",
          "away_score"
        ), as.integer)
      mbb_data <- mbb_data %>%
        dplyr::select(
          -dplyr::any_of(dplyr::starts_with("team1")),
          -dplyr::any_of(dplyr::starts_with("team2")),
          -dplyr::any_of(c("homeAway"))
        )

      if ("leaders" %in% names(mbb_data)) {
        schedule_out <- mbb_data %>%
          tidyr::hoist(
            "leaders",
            # points
            points_leader_points = list(1, "leaders", 1, "value"),
            points_leader_stat = list(1, "leaders", 1, "displayValue"),
            points_leader_name = list(1, "leaders", 1, "athlete", "displayName"),
            points_leader_shortname = list(1, "leaders", 1, "athlete", "shortName"),
            points_leader_headshot = list(1, "leaders", 1, "athlete", "headshot"),
            points_leader_team_id = list(1, "leaders", 1, "team", "id"),
            points_leader_pos = list(1, "leaders", 1, "athlete", "position", "abbreviation"),
            # rebounds
            rebounds_leader_rebounds = list(2, "leaders", 1, "value"),
            rebounds_leader_stat = list(2, "leaders", 1, "displayValue"),
            rebounds_leader_name = list(2, "leaders", 1, "athlete", "displayName"),
            rebounds_leader_shortname = list(2, "leaders", 1, "athlete", "shortName"),
            rebounds_leader_headshot = list(2, "leaders", 1, "athlete", "headshot"),
            rebounds_leader_team_id = list(2, "leaders", 1, "team", "id"),
            rebounds_leader_pos = list(2, "leaders", 1, "athlete", "position", "abbreviation"),
            # assists
            assists_leader_assists = list(3, "leaders", 1, "value"),
            assists_leader_stat = list(3, "leaders", 1, "displayValue"),
            assists_leader_name = list(3, "leaders", 1, "athlete", "displayName"),
            assists_leader_shortname = list(3, "leaders", 1, "athlete", "shortName"),
            assists_leader_headshot = list(3, "leaders", 1, "athlete", "headshot"),
            assists_leader_team_id = list(3, "leaders", 1, "team", "id"),
            assists_leader_pos = list(3, "leaders", 1, "athlete", "position", "abbreviation"),
          )

        if ("broadcasts" %in% names(schedule_out) && !any(is.na(schedule_out[["broadcasts"]]))) {
          schedule_out %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com", Sys.time())
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com", Sys.time())
        }
      } else {
        if ("broadcasts" %in% names(mbb_data) && !any(is.na(mbb_data[["broadcasts"]]))) {
          mbb_data %>%
            tidyr::hoist(
              "broadcasts",
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com", Sys.time())
        } else {
          mbb_data %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN MBB Scoreboard Information from ESPN.com", Sys.time())
        }
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard data for {season_dates} available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
}

#' **Get ESPN men's college basketball schedule for a specific year**
#'
#' @param season Either numeric or character
#' @eval .returns_rd("espn_mbb_scoreboard", unit = "game")
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom purrr map2_dfr possibly quietly
#' @importFrom rlang .env
#' @import rvest
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#'
#' # Get schedule from date 2022-11-17
#' \donttest{
#' try(espn_mbb_scoreboard(season = "20221117"))
#' }
espn_mbb_scoreboard <- function(season) {
  max_year <- as.integer(substr(Sys.Date(), 1, 4))

  if (!(as.integer(substr(season, 1, 4)) > 2001)) {
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  # A bare 4-digit season (e.g. "2024") is a season YEAR, not a calendar
  # year -- the MBB season runs November of {season - 1} through April of
  # {season}. ESPN's `dates=` param treats a bare year as calendar-year-only
  # (Jan 1 onward), silently dropping the season's November/December games
  # (#150). Query both the season year and the prior calendar year and
  # filter down to the games ESPN itself assigns to this season; ESPN
  # rejects date-RANGE syntax for MBB, so this has to be two separate
  # `dates=` requests per group rather than one `dates=Y0101-Y1231` call.
  # A specific date (e.g. "20231108", the documented single-day usage) is
  # left untouched -- it already resolves to the right games.
  is_season_year <- nchar(season) == 4L
  season_dates <- if (is_season_year) {
    c(as.character(as.integer(season) - 1L), season)
  } else {
    season
  }

  # check for regular and postseason games

  scoreboard_df <-
    purrr::map2_dfr(
      rep(c("56", "55", "50", "100"), each = length(season_dates)),
      rep(season_dates, times = 4),
      parse_espn_mbb_scoreboard
    )

  if (is_season_year) {
    # The regular-season group ("50") runs thousands of games/year, so a
    # single `dates={season - 1}` whole-year request above hits ESPN's
    # `limit=1000` cap in mid-January and never reaches November/December
    # -- the exact months this fix needs. Backfill them with one request
    # per day (postseason groups 56/55/100 never play in Nov/Dec, so only
    # "50" needs this).
    fall_dates <- format(
      seq(
        as.Date(paste0(as.integer(season) - 1L, "-11-01")),
        as.Date(paste0(as.integer(season) - 1L, "-12-31")),
        by = "day"
      ),
      "%Y%m%d"
    )
    fall_df <- purrr::map_dfr(
      fall_dates,
      function(d) parse_espn_mbb_scoreboard(group = "50", season_dates = d)
    )
    scoreboard_df <- dplyr::bind_rows(scoreboard_df, fall_df)
  }

  if (is_season_year && nrow(scoreboard_df)) {
    # `.env$season` disambiguates the function argument from the identically
    # named `season` data column -- dplyr's data mask otherwise resolves the
    # bare name to the column on both sides, making this filter a silent
    # no-op.
    scoreboard_df <- scoreboard_df %>%
      dplyr::filter(as.integer(.data$season) == as.integer(.env$season))
  }

  # A game can be returned under more than one ESPN group ID (e.g. a
  # Division I conference tournament game also carries a national group
  # tag), and the per-day fall backfill re-returns games the whole-year
  # request already captured, so keep one row per game (#160).
  if (nrow(scoreboard_df) && "game_id" %in% names(scoreboard_df)) {
    scoreboard_df <- scoreboard_df %>%
      dplyr::distinct(.data$game_id, .keep_all = TRUE)
  }

  if (!nrow(scoreboard_df)) {
    message(sprintf("%s: Invalid arguments or no scoreboard data available!", Sys.time()))
  }
  return(scoreboard_df)
}

#' **Get men's college basketball AP and Coaches Poll rankings from ESPN**
#'
#' @author Saiem Gilani
#' @eval .returns_rd("espn_mbb_rankings", unit = "ranked team")
#' @importFrom dplyr %>%  bind_rows arrange
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' # Get current AP and Coaches Poll rankings
#' \donttest{
#' try(espn_mbb_rankings())
#' }
espn_mbb_rankings <- function() {
  .args <- .capture_args()
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  ranks_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/rankings?groups=50"


  ranks <- .empty_hoopR_data("ESPN MBB Rankings Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(ranks_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()
      ranks_df <- jsonlite::fromJSON(resp, flatten = TRUE)[["rankings"]]
      ranks_top25 <- ranks_df %>%
        tidyr::unnest("ranks", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated"
        )
      ranks_others <- ranks_df %>%
        tidyr::unnest("others", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated"
        )
      ranks_dropped_out <- ranks_df %>%
        tidyr::unnest("droppedOut", names_repair = "minimal") %>%
        dplyr::select(
          -"date",
          -"lastUpdated"
        )

      ranks <-
        dplyr::bind_rows(ranks_top25, ranks_others, ranks_dropped_out)
      drop_cols <- c(
        "$ref",
        "team.links",
        "season.powerIndexes.$ref",
        "season.powerIndexLeaders.$ref",
        "season.athletes.$ref",
        "season.leaders.$ref",
        "season.powerIndexLeaders.$ref",
        "others",
        "droppedOut",
        "ranks"
      )
      ranks <- ranks %>%
        dplyr::select(-dplyr::any_of(drop_cols))
      ranks <-
        ranks %>%
        dplyr::arrange(.data$name, -.data$points) %>%
        janitor::clean_names() %>%
        dplyr::mutate_at(c(
          "id",
          "team_id"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Rankings Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no rankings data available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )

  return(ranks)
}


#' **Get ESPN men's college basketball standings**
#'
#' @param year Either numeric or character (YYYY)
#' @eval .returns_rd("espn_mbb_standings", unit = "team in the standings")
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @export
#' @keywords MBB Standings
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#' try(espn_mbb_standings(2021))
#' }
espn_mbb_standings <- function(year = most_recent_mbb_season()) {
  .args <- mget(setdiff(names(formals()), "..."))
  standings_url <-
    "https://site.web.api.espn.com/apis/v2/sports/basketball/mens-college-basketball/standings?region=us&lang=en&contentorigin=espn&type=0&level=3&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

  ## Inputs
  ## year
  full_url <- paste0(
    standings_url,
    "season=", year
  )

  standings <- .empty_hoopR_data("ESPN MBB Standings Information from ESPN.com")

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        .resp_text()

      raw_resp <- resp %>%
        jsonlite::fromJSON()

      # level=3 groups standings by conference under "children"; ESPN's flat
      # level=1 list silently omits some current D1 teams (#144), so
      # row-bind each conference group's entries instead.
      raw_children <- raw_resp %>%
        purrr::pluck("children")

      conference_entries <- raw_children[["standings"]][["entries"]]
      conference_names <- raw_children[["name"]]

      # Conferences with no season played yet come back with a NULL entries
      # list -- drop them instead of binding a bogus row.
      has_entries <- !vapply(conference_entries, is.null, logical(1))

      entries_list <- Map(
        function(entries, conference) {
          entries$conference <- conference
          entries
        },
        conference_entries[has_entries],
        conference_names[has_entries]
      )

      raw_standings <- list(entries = dplyr::bind_rows(entries_list))
      # Create a dataframe of all MBB teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]
      teams$conference <- raw_standings[["entries"]][["conference"]]

      teams <- teams %>%
        dplyr::select(
          "id",
          "displayName",
          "conference"
        ) %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName"
        )

      # creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <-
        data.table::rbindlist(standings_df, fill = TRUE, idcol = T)

      # Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <-
        ifelse(
          is.na(standings_data$value) &
            !is.na(standings_data$summary),
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
        tidyr::pivot_wider(
          names_from = "type",
          values_from = "value"
        )


      standings_data <- standings_data %>%
        dplyr::select(-".id")

      # joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data) %>%
        dplyr::mutate(team_id = as.integer(.data$team_id))

      standings <- standings %>%
        dplyr::mutate_at(c(
          "avgpointsagainst",
          "avgpointsfor",
          "gamesbehind",
          "leaguewinpercent",
          "losses",
          "playoffseed",
          "pointsagainst",
          "pointsfor",
          "streak",
          "winpercent",
          "wins",
          "home_avgpointsagainst",
          "home_avgpointsfor",
          "home_gamesbehind",
          "home_leaguewinpercent",
          "home_losses",
          "home_playoffseed",
          "home_pointsagainst",
          "home_pointsfor",
          "home_streak",
          "home_winpercent",
          "home_wins",
          "road_avgpointsagainst",
          "road_avgpointsfor",
          "road_gamesbehind",
          "road_leaguewinpercent",
          "road_losses",
          "road_playoffseed",
          "road_pointsagainst",
          "road_pointsfor",
          "road_streak",
          "road_winpercent",
          "road_wins",
          "vsaprankedteams_avgpointsagainst",
          "vsaprankedteams_avgpointsfor",
          "vsaprankedteams_gamesbehind",
          "vsaprankedteams_leaguewinpercent",
          "vsaprankedteams_losses",
          "vsaprankedteams_playoffseed",
          "vsaprankedteams_pointsagainst",
          "vsaprankedteams_pointsfor",
          "vsaprankedteams_streak",
          "vsaprankedteams_winpercent",
          "vsaprankedteams_wins",
          "vsusarankedteams_avgpointsagainst",
          "vsusarankedteams_avgpointsfor",
          "vsusarankedteams_gamesbehind",
          "vsusarankedteams_leaguewinpercent",
          "vsusarankedteams_losses",
          "vsusarankedteams_playoffseed",
          "vsusarankedteams_pointsagainst",
          "vsusarankedteams_pointsfor",
          "vsusarankedteams_streak",
          "vsusarankedteams_winpercent",
          "vsusarankedteams_wins",
          "vsconf_avgpointsagainst",
          "vsconf_avgpointsfor",
          "vsconf_gamesbehind",
          "vsconf_leaguewinpercent",
          "vsconf_losses",
          "vsconf_playoffseed",
          "vsconf_pointsagainst",
          "vsconf_pointsfor",
          "vsconf_streak",
          "vsconf_winpercent",
          "vsconf_wins"
        ), as.numeric) %>%
        make_hoopR_data("ESPN MBB Standings Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no standings data available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  return(standings)
}


#' **Get ESPN MBB's Betting information**
#'
#' @rdname espn_mbb_game_all
#' @param game_id  Game ID
#' @eval .returns_rd("espn_mbb_betting")
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @keywords MBB Betting
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#' try(espn_mbb_betting(game_id = 401256760))
#' }
espn_mbb_betting <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(
    summary_url,
    "event=", game_id
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
        pickcenter <-
          jsonlite::fromJSON(jsonlite::toJSON(raw_summary$pickcenter),
            flatten =
              TRUE
          ) %>%
          janitor::clean_names() %>%
          dplyr::select(-dplyr::any_of("links")) %>%
          dplyr::mutate(game_id = as.integer(game_id)) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "provider_id",
            "away_team_odds_team_id",
            "home_team_odds_team_id"
          )), as.integer)) %>%
          make_hoopR_data("ESPN MBB Pickcenter Information from ESPN.com", Sys.time())
      }
      if ("againstTheSpread" %in% names(raw_summary)) {
        againstTheSpread <-
          jsonlite::fromJSON(jsonlite::toJSON(raw_summary$againstTheSpread)) %>%
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
          make_hoopR_data("ESPN MBB Against the Spread Information from ESPN.com", Sys.time())
      }
      if ("predictor" %in% names(raw_summary)) {
        predictor_df <- data.frame(
          game_id = as.integer(game_id),
          home_team_id = as.integer(raw_summary$predictor$homeTeam$id),
          away_team_id = as.integer(raw_summary$predictor$awayTeam$id),
          away_team_game_projection = as.numeric(raw_summary$predictor$awayTeam$gameProjection),
          away_team_chance_loss = as.numeric(raw_summary$predictor$awayTeam$teamChanceLoss)
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data("ESPN MBB Predictor Information from ESPN.com", Sys.time())
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no betting data available!",
      args = .args
    ),
    warning = function(w) {

    },
    finally = {

    }
  )
  if (nrow(pickcenter) == 0) {
    pickcenter <- .espn_basketball_pickcenter_fallback("mens-college-basketball", game_id)
  }
  betting <-
    c(
      list(pickcenter),
      list(againstTheSpread),
      list(predictor_df)
    )
  names(betting) <-
    c("pickcenter", "againstTheSpread", "predictor")
  return(betting)
}


#' @title
#' **Get ESPN men's college basketball team stats data**
#' @author Saiem Gilani
#' @param team_id Team ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @eval .returns_rd("espn_mbb_team_stats", unit = "team")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @keywords MBB Team Stats
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#'
#' @examples
#' \donttest{
#' try(espn_mbb_team_stats(team_id = 150, year = 2020))
#' }
espn_mbb_team_stats <- function(team_id, year, season_type = "regular", total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/", s_type,
    "/teams/", team_id,
    "/statistics/", totals
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
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

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
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(
          names_from = "stats_category_name",
          values_from = "stats_value",
          values_fn = dplyr::first
        ) %>%
        janitor::clean_names()
      df <- team_df %>%
        dplyr::bind_cols(df)
      df <- df %>%
        dplyr::mutate_at(c(
          "team_id",
          "team_sdr"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Team Season Stats from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no team season stats data available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df)
}


#' @title
#' **Get ESPN men's college basketball player stats data**
#' @author Saiem Gilani
#' @param athlete_id Athlete ID
#' @param year Year
#' @param season_type (character, default: regular): Season type - regular or postseason
#' @param total (boolean, default: FALSE): Totals
#' @eval .returns_rd("espn_mbb_player_stats", unit = "player")
#' @export
#' @keywords MBB Player Stats
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#' try(espn_mbb_player_stats(athlete_id = 4593919, year = 2021))
#' }
espn_mbb_player_stats <- function(athlete_id, year, season_type = "regular", total = FALSE) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!(tolower(season_type) %in% c("regular", "postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    "/types/", s_type,
    "/athletes/", athlete_id,
    "/statistics/", totals
  )
  athlete_url <- paste0(
    base_url,
    year,
    "/athletes/", athlete_id
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
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- athlete_df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- .retry_request(team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        .resp_text() %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

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

      athlete_df <- athlete_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        tibble::tibble(data = .data$.)

      athlete_df <- athlete_df$data %>%
        as.data.frame() %>%
        dplyr::select(-dplyr::any_of(c(
          "X.ref", "X.ref.1", "X.ref.2", "X.ref.3", "X.ref.4", "X.ref.5", "X.ref.6", "X.ref.7", "X.ref.8",
          "position.X.ref", "position.X.ref.1",
          "contract.x.ref", "contract.x.ref.1", "contract.x.ref.2",
          "draft.x.ref", "draft.x.ref.1"
        ))) %>%
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
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        dplyr::mutate_at(c(
          "athlete_id",
          "team_id",
          "position_id",
          "status_id",
          "sdr",
          "team_sdr"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Player Season Stats from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player season stats data available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df)
}

#'  **Parse ESPN MBB PBP, helper function**
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @eval .returns_rd("helper_espn_mbb_pbp", unit = "play-by-play event")
#' @return These are the columns of `helper_espn_mbb_pbp()`, which returns `NULL`
#'   when the game has no play-by-play. `home_score` / `away_score` are rebuilt from the
#'   scoring plays when that reproduces the header's official final, otherwise they are
#'   ESPN's per-play values; the last column, `score_source` (`"rebuilt"` / `"espn"`), says which.
#' @export
helper_espn_mbb_pbp <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON(bigint_as_char = TRUE)

  pbp_source <- game_json[["header"]][["competitions"]][["playByPlaySource"]]

  plays <- game_json %>%
    purrr::pluck("plays") %>%
    dplyr::as_tibble()

  if (pbp_source != "none" && nrow(plays) > 10) {
    homeAway1 <- jsonlite::fromJSON(resp)[["header"]][["competitions"]][["competitors"]][[1]][["homeAway"]][1]

    gameId <- as.integer(game_json[["header"]][["id"]])
    season <- game_json[["header"]][["season"]][["year"]]
    season_type <- game_json[["header"]][["season"]][["type"]]
    game_date_time <- substr(
      game_json[["header"]][["competitions"]][["date"]], 1,
      nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
    ) %>%
      .espn_utc_to_et()

    game_date <- as.Date(substr(game_date_time, 0, 10))
    id_vars <- data.frame()
    if (homeAway1 == "home") {
      homeTeamId <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["id"]] %>%
        purrr::pluck(1, .default = NA_integer_))
      homeTeamMascot <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamScore <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["score"]] %>%
        purrr::pluck(1, .default = NA_character_))
      homeTeamWinner <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamId <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["id"]] %>%
        purrr::pluck(2, .default = NA_integer_))
      awayTeamMascot <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamScore <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["score"]] %>%
        purrr::pluck(2, .default = NA_integer_))
      awayTeamWinner <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["record"]][[1]][["summary"]] %>%
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
      awayTeamId <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["id"]] %>%
        purrr::pluck(1, .default = NA_integer_))
      awayTeamMascot <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["name"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["location"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAbbrev <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamLogoDark <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[1]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      awayTeamFullName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["color"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamAlternateColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamScore <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["score"]] %>%
        purrr::pluck(1, .default = NA_integer_))
      awayTeamWinner <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["winner"]] %>%
        purrr::pluck(1, .default = NA_character_)
      awayTeamRecord <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["record"]][[1]][["summary"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamId <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["id"]] %>%
        purrr::pluck(2, .default = NA_integer_))
      homeTeamMascot <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["name"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["location"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAbbrev <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["abbreviation"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamLogo <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(1, .default = NA_character_)
      homeTeamLogoDark <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["logos"]][[2]][["href"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamFullName <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["displayName"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["color"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamAlternateColor <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["team"]][["alternateColor"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamScore <- as.integer(game_json[["header"]][["competitions"]][["competitors"]][[1]][["score"]] %>%
        purrr::pluck(2, .default = NA_integer_))
      homeTeamWinner <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["winner"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeTeamRecord <- game_json[["header"]][["competitions"]][["competitors"]][[1]][["record"]][[1]][["summary"]] %>%
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
      if (all(c("coordinate.x.raw", "coordinate.y.raw") %in% names(plays))) {
        # A payload processed by sportsdataverse-py (since its PR #844)
        # already carries this block's output: the transformed pair in
        # coordinate.x / coordinate.y and ESPN's pair in coordinate.x.raw /
        # coordinate.y.raw. Keep both; transforming again would shift every
        # shot a second time and the rename would duplicate the raw names.
        plays <- plays %>%
          dplyr::mutate(dplyr::across(
            dplyr::all_of(c("coordinate.x", "coordinate.y", "coordinate.x.raw", "coordinate.y.raw")),
            as.double
          ))
      } else {
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
            # The transformed pair puts every free throw on the line. The match
            # above is case-sensitive and misses the college "MadeFreeThrow"
            # type, whose raw pair keeps ESPN's (25, 0); a missing type.text
            # is not a free throw.
            is_ft = stringr::str_detect(
              .data$type.text,
              stringr::regex("free ?throw", ignore_case = TRUE)
            ) %in% TRUE,
            ft_x = dplyr::if_else(.data$is_ft, 25, .data$coordinate.x),
            ft_y = dplyr::if_else(.data$is_ft, 13.75, .data$coordinate.y),
            coordinate_x_transformed = dplyr::case_when(
              .data$team.id == homeTeamId ~ -1 * (.data$ft_y - 41.75),
              TRUE ~ .data$ft_y - 41.75
            ),
            coordinate_y_transformed = dplyr::case_when(
              .data$team.id == homeTeamId ~ -1 * (.data$ft_x - 25),
              TRUE ~ .data$ft_x - 25
            )
          ) %>%
          dplyr::select(-"is_ft", -"ft_x", -"ft_y") %>%
          dplyr::rename(
            "coordinate.x.raw" = "coordinate.x",
            "coordinate.y.raw" = "coordinate.y",
            "coordinate.x" = "coordinate_x_transformed",
            "coordinate.y" = "coordinate_y_transformed"
          )
      }
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
      names(aths) <- c("play.id", "athlete.id.1", "athlete.id.2")
      plays <- plays %>%
        dplyr::bind_cols(aths) %>%
        janitor::clean_names() %>%
        dplyr::mutate(dplyr::across(dplyr::any_of(c(
          "athlete_id_1",
          "athlete_id_2",
          "athlete_id_3"
        )), ~ as.integer(.x)))
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
      dplyr::mutate(dplyr::across(dplyr::any_of(c(
        "athlete_id_1",
        "athlete_id_2",
        "athlete_id_3",
        "type_id",
        "team_id"
      )), ~ as.integer(.x)))

    plays <- .espn_pbp_features(
      plays, "mbb", homeTeamId, awayTeamId,
      c(homeTeamAbbrev, homeTeamName, homeTeamMascot, sub("Stat(.+)", "St", homeTeamName)),
      c(awayTeamAbbrev, awayTeamName, awayTeamMascot, sub("Stat(.+)", "St", awayTeamName))
    )

    plays$id <- .play_id_chr(plays$id)

    plays <- .repair_running_score(plays, homeTeamId, awayTeamId, homeTeamScore, awayTeamScore)

    plays_df <- plays %>%
      make_hoopR_data("ESPN MBB Play-by-Play Information from ESPN.com", Sys.time())

    return(plays_df)
  }
}

#'  **Parse ESPN MBB Team Box, helper function**
#' @rdname helper_espn_mbb_pbp
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @return Returns a tibble
#' @export
helper_espn_mbb_team_box <- function(resp) {
  game_json <- resp %>%
    jsonlite::fromJSON()

  gameId <- as.integer(game_json[["header"]][["id"]])
  game_date_time <- substr(
    game_json[["header"]][["competitions"]][["date"]], 1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    .espn_utc_to_et()

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
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        homeAway1,
        homeAway2
      )
      statistics_df_1$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )
      statistics_df_1$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        homeAway1_team.winner,
        homeAway2_team.winner
      )
      statistics_df_1$team.id <- as.integer(teams_box_score_df[["team.id"]][[1]])
      statistics_df_1$team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_1$team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_1$team.location <- teams_box_score_df[["team.location"]][[1]]
      statistics_df_1$team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_1$team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[1]]
      statistics_df_1$team.displayName <- teams_box_score_df[["team.displayName"]][[1]]
      statistics_df_1$team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[1]]
      statistics_df_1$team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_1$team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[1]]
      statistics_df_1$team.logo <- teams_box_score_df[["team.logo"]][[1]]
      statistics_df_1$opponent.team.id <- as.integer(teams_box_score_df[["team.id"]][[2]])
      statistics_df_1$opponent.team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_1$opponent.team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_1$opponent.team.location <- teams_box_score_df[["team.location"]][[2]]
      statistics_df_1$opponent.team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_1$opponent.team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[2]]
      statistics_df_1$opponent.team.displayName <- teams_box_score_df[["team.displayName"]][[2]]
      statistics_df_1$opponent.team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[2]]
      statistics_df_1$opponent.team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_1$opponent.team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[2]]
      statistics_df_1$opponent.team.logo <- teams_box_score_df[["team.logo"]][[2]]
      statistics_df_1$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][1]) == as.integer(homeAway1_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )

      # Assigning values to the correct data frame rows - 2
      statistics_df_2$team.homeAway <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        homeAway2,
        homeAway1
      )
      statistics_df_2$team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        as.integer(homeAway2_team.score),
        as.integer(homeAway1_team.score)
      )
      statistics_df_2$team.winner <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        homeAway2_team.winner,
        homeAway1_team.winner
      )
      statistics_df_2$team.id <- as.integer(teams_box_score_df[["team.id"]][[2]])
      statistics_df_2$team.uid <- teams_box_score_df[["team.uid"]][[2]]
      statistics_df_2$team.slug <- teams_box_score_df[["team.slug"]][[2]]
      statistics_df_2$team.location <- teams_box_score_df[["team.location"]][[2]]
      statistics_df_2$team.name <- teams_box_score_df[["team.name"]][[2]]
      statistics_df_2$team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[2]]
      statistics_df_2$team.displayName <- teams_box_score_df[["team.displayName"]][[2]]
      statistics_df_2$team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[2]]
      statistics_df_2$team.color <- teams_box_score_df[["team.color"]][[2]]
      statistics_df_2$team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[2]]
      statistics_df_2$team.logo <- teams_box_score_df[["team.logo"]][[2]]
      statistics_df_2$opponent.team.id <- as.integer(teams_box_score_df[["team.id"]][[1]])
      statistics_df_2$opponent.team.uid <- teams_box_score_df[["team.uid"]][[1]]
      statistics_df_2$opponent.team.slug <- teams_box_score_df[["team.slug"]][[1]]
      statistics_df_2$opponent.team.location <- teams_box_score_df[["team.location"]][[1]]
      statistics_df_2$opponent.team.name <- teams_box_score_df[["team.name"]][[1]]
      statistics_df_2$opponent.team.abbreviation <- teams_box_score_df[["team.abbreviation"]][[1]]
      statistics_df_2$opponent.team.displayName <- teams_box_score_df[["team.displayName"]][[1]]
      statistics_df_2$opponent.team.shortDisplayName <- teams_box_score_df[["team.shortDisplayName"]][[1]]
      statistics_df_2$opponent.team.color <- teams_box_score_df[["team.color"]][[1]]
      statistics_df_2$opponent.team.alternateColor <- teams_box_score_df[["team.alternateColor"]][[1]]
      statistics_df_2$opponent.team.logo <- teams_box_score_df[["team.logo"]][[1]]
      statistics_df_2$opponent.team.score <- ifelse(
        as.integer(teams_box_score_df[["team.id"]][2]) == as.integer(homeAway2_team.id),
        as.integer(homeAway1_team.score),
        as.integer(homeAway2_team.score)
      )

      complete_statistics_df <- statistics_df_1 %>%
        dplyr::bind_rows(statistics_df_2)

      # Assigning game/season level data to team box score and converting types
      complete_statistics_df$season <- game_json[["header"]][["season"]][["year"]]
      complete_statistics_df$season_type <- game_json[["header"]][["season"]][["type"]]
      complete_statistics_df$game_date <- game_date
      complete_statistics_df$game_date_time <- game_date_time
      complete_statistics_df$game_id <- as.integer(gameId)

      suppressWarnings(
        complete_statistics_df <- complete_statistics_df %>%
          tidyr::separate("fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate("freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate("threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c("threePointFieldGoalsMade", "threePointFieldGoalsAttempted"),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(c(
            "fieldGoalPct",
            "freeThrowPct",
            "threePointFieldGoalPct"
          ), ~ as.numeric(.x))) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
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
          )), ~ as.integer(.x)))
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
        make_hoopR_data("ESPN MBB Team Box Information from ESPN.com", Sys.time())

      return(team_box_score)
    }
  }
}

#'  **Parse ESPN MBB Player Box, helper function**
#' @rdname helper_espn_mbb_pbp
#' @param resp Response object from the ESPN MBB game summary endpoint
#' @return Returns a tibble
#' @export
helper_espn_mbb_player_box <- function(resp) {
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
    game_json[["header"]][["competitions"]][["date"]], 1,
    nchar(game_json[["header"]][["competitions"]][["date"]]) - 1
  ) %>%
    .espn_utc_to_et()

  game_date <- as.Date(substr(game_date_time, 0, 10))

  boxScoreAvailable <- game_json[["header"]][["competitions"]][["boxscoreAvailable"]]

  boxScoreSource <- game_json[["header"]][["competitions"]][["boxscoreSource"]]

  valid_stats <- players_box_score_df %>%
    tidyr::unnest("statistics")

  valid_athletes <- is.data.frame(valid_stats[["athletes"]][[1]]) && is.data.frame(valid_stats[["athletes"]][[2]])
  # This is checking if  [[athletes]][[1]]'s stat rebounds is able to be converted to a numeric value
  #  without introducing NA's
  suppressWarnings(
    valid_stats <- players_box_score_df[["statistics"]][[1]][["athletes"]][[1]][["stats"]][[1]] %>%
      purrr::pluck(7) %>%
      as.numeric()
  )
  # Payload presence replaces ESPN's unreliable header `boxscoreAvailable`
  # flag; the athlete and stat validity conjuncts below remain the real gate.
  if (length(game_json[["boxscore"]][["players"]]) > 0 &&
    length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]]) > 1 &&
    length(players_box_score_df[["statistics"]][[1]][["athletes"]][[1]][["stats"]][[1]]) > 1 &&
    valid_athletes &&
    !is.na(valid_stats)) {
    players_df <- players_box_score_df %>%
      tidyr::unnest("statistics") %>%
      tidyr::unnest("athletes")

    if (length(players_box_score_df[["statistics"]]) > 1 &&
      length(players_df$stats[[1]] > 0)) {
      players_df <- jsonlite::fromJSON(jsonlite::toJSON(game_json[["boxscore"]][["players"]]), flatten = TRUE) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")

      stat_cols <- players_df$keys[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind, stats))
      colnames(stats_df) <- stat_cols
      suppressWarnings(
        stats_df <- stats_df %>%
          tidyr::separate("fieldGoalsMade-fieldGoalsAttempted",
            into = c("fieldGoalsMade", "fieldGoalsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate("freeThrowsMade-freeThrowsAttempted",
            into = c("freeThrowsMade", "freeThrowsAttempted"),
            sep = "-"
          ) %>%
          tidyr::separate("threePointFieldGoalsMade-threePointFieldGoalsAttempted",
            into = c("threePointFieldGoalsMade", "threePointFieldGoalsAttempted"),
            sep = "-"
          ) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
            "minutes",
            "fieldGoalPct",
            "freeThrowPct",
            "threePointFieldGoalPct"
          )), ~ as.numeric(.x))) %>%
          dplyr::mutate(dplyr::across(dplyr::any_of(c(
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
          )), ~ as.integer(.x)))
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
      homeAway1_team.id <- as.integer(teams_df[["id"]] %>%
        purrr::pluck(1, .default = NA_integer_))
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
      homeAway1_team.score <- as.integer(teams_df[["score"]] %>%
        purrr::pluck(1, .default = NA_integer_))

      homeAway2 <- teams_df[["homeAway"]] %>%
        purrr::pluck(2, .default = NA_character_)
      homeAway2_team.id <- as.integer(teams_df[["id"]] %>%
        purrr::pluck(2, .default = NA_integer_))
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
      homeAway2_team.score <- as.integer(teams_df[["score"]] %>%
        purrr::pluck(2, .default = NA_integer_))

      players_df <- players_df %>%
        dplyr::mutate(
          home_away = ifelse(.data$team_id == homeAway1_team.id, homeAway1, homeAway2),
          team_winner = ifelse(.data$team_id == homeAway1_team.id, homeAway1_team.winner, homeAway2_team.winner),
          team_score = ifelse(.data$team_id == homeAway1_team.id, homeAway1_team.score, homeAway2_team.score),
          opponent_team_id = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.id, homeAway1_team.id),
          opponent_team_name = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.name, homeAway1_team.name),
          opponent_team_location = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.location, homeAway1_team.location),
          opponent_team_display_name = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.displayName, homeAway1_team.displayName),
          opponent_team_abbreviation = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.abbreviation, homeAway1_team.abbreviation),
          opponent_team_logo = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.logos, homeAway1_team.logos),
          opponent_team_color = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.color, homeAway1_team.color),
          opponent_team_alternate_color = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.alternateColor, homeAway1_team.alternateColor),
          opponent_team_score = ifelse(.data$team_id == homeAway1_team.id, homeAway2_team.score, homeAway1_team.score),
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
        dplyr::mutate_at(c(
          "athlete_id",
          "team_id",
          "team_score",
          "opponent_team_score"
        ), as.integer) %>%
        make_hoopR_data("ESPN MBB Player Box Information from ESPN.com", Sys.time())

      return(player_box_score)
    }
  }
}
