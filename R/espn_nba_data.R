#' **Get ESPN NBA game data (Pbp, Team and Player Box)**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A named list of data frames: Plays, Team, Player
#' @keywords NBA Game
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_game_all(game_id = 401283399))
#' }
#'

espn_nba_game_all <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  #---- Play-by-Play ------
  tryCatch(
    expr = {

      raw_play_df <- jsonlite::fromJSON(resp)

      homeAway1 <- jsonlite::fromJSON(resp)[['header']][['competitions']][['competitors']][[1]][['homeAway']][1]

      season <- raw_play_df[['header']][['season']][['year']]
      season_type <- raw_play_df[['header']][['season']][['type']]
      game_date <- as.Date(substr(raw_play_df[['header']][['competitions']][['date']], 0, 10))
      id_vars <- data.frame()
      if (homeAway1 == "home") {

        homeTeamId <- as.integer(raw_play_df[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
        homeTeamMascot <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
        homeTeamName <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
        homeTeamAbbrev <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
        homeTeamLogo <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
        homeTeamLogoDark <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
        homeTeamFullName <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
        homeTeamColor <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
        homeTeamAlternateColor <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
        homeTeamScore <- as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][1])
        homeTeamWinner <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][1]
        homeTeamRecord <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
        awayTeamId <- as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
        awayTeamMascot <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
        awayTeamName <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
        awayTeamAbbrev <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
        awayTeamLogo <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
        awayTeamLogoDark <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
        awayTeamFullName <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
        awayTeamColor <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
        awayTeamAlternateColor <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
        awayTeamScore <- as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][2])
        awayTeamWinner <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][2]
        awayTeamRecord <- raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
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

        homeTeamId = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
        homeTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
        homeTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
        homeTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
        homeTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
        homeTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
        homeTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
        homeTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
        homeTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
        homeTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][2])
        homeTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][2]
        homeTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
        awayTeamId = as.integer(raw_play_df[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
        awayTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
        awayTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
        awayTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
        awayTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
        awayTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
        awayTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
        awayTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
        awayTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
        awayTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][1])
        awayTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][1]
        awayTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
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

      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)


      plays <- raw_play_df[["plays"]] %>%
        tidyr::unnest_wider("participants")
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
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(
            "id",
            "athlete.id") %>%
          tidyr::unnest_wider("athlete.id", names_sep = "_")
      )
      names(aths)<-c("play.id","athlete.id.1","athlete.id.2","athlete.id.3")
      plays_df <- dplyr::bind_cols(plays, aths, id_vars) %>%
        select(-"athlete.id") %>%
        dplyr::mutate(
          game_id = game_id,
          season = season,
          season_type = season_type,
          game_date = game_date) %>%
        janitor::clean_names() %>%
        make_hoopR_data("ESPN NBA Play-by-Play Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  #---- Team Box ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)
      season <- raw_play_df[['header']][['season']][['year']]
      season_type <- raw_play_df[['header']][['season']][['type']]
      homeAwayTeam1 = toupper(raw_play_df[['header']][['competitions']][['competitors']][[1]][['homeAway']][1])
      homeAwayTeam2 = toupper(raw_play_df[['header']][['competitions']][['competitors']][[1]][['homeAway']][2])
      homeTeamId = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][1]
      awayTeamId = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2]
      homeTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
      awayTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
      homeTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
      awayTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]

      homeTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
      awayTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
      game_date = as.Date(substr(raw_play_df[['header']][['competitions']][['date']],0,10))
      teams_box_score_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["teams"]]),flatten=TRUE)

      teams_box_score_df_2 <- teams_box_score_df[[1]][[2]] %>%
        dplyr::select(
          "displayValue",
          "name") %>%
        dplyr::rename("Home" = "displayValue")
      teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
        dplyr::select(
          "displayValue",
          "name") %>%
        dplyr::rename("Away" = "displayValue")
      teams2 <- data.frame(t(teams_box_score_df_2$Home))
      colnames(teams2) <- t(teams_box_score_df_2$name)
      teams2$homeAway <- homeAwayTeam2
      teams2$OpponentId <- as.integer(awayTeamId)
      teams2$OpponentName <- awayTeamName
      teams2$OpponentMascot <- awayTeamMascot
      teams2$OpponentAbbrev <- awayTeamAbbrev

      teams1 <- data.frame(t(teams_box_score_df_1$Away))
      colnames(teams1) <- t(teams_box_score_df_1$name)
      teams1$homeAway <- homeAwayTeam1
      teams1$OpponentId <- as.integer(homeTeamId)
      teams1$OpponentName <- homeTeamName
      teams1$OpponentMascot <- homeTeamMascot
      teams1$OpponentAbbrev <- homeTeamAbbrev
      teams <- dplyr::bind_rows(teams1,teams2)

      team_box_score <- teams_box_score_df %>%
        dplyr::select(-"statistics") %>%
        dplyr::bind_cols(teams)

      team_box_score <- team_box_score %>%
        dplyr::mutate(
          game_id = game_id,
          season = season,
          season_type = season_type,
          game_date = game_date
        ) %>%
        janitor::clean_names() %>%
        dplyr::select(
          "game_id",
          "season",
          "season_type",
          "game_date",
          tidyr::everything()) %>%
        make_hoopR_data("ESPN NBA Team Box Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  #---- Player Box ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)
      players_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["players"]]), flatten=TRUE) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")
      stat_cols <- players_df$names[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind,stats))
      colnames(stats_df) <- stat_cols

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(
          "starter",
          "ejected",
          "didNotPlay",
          "active",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.href",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.shortDisplayName",
          "team.name",
          "team.logo",
          "team.id",
          "team.abbreviation",
          "team.color",
          "team.alternateColor"
        )

      player_box <- dplyr::bind_cols(stats_df,players_df) %>%
        dplyr::select(
          "athlete.displayName",
          "team.shortDisplayName",
          tidyr::everything())
      plays_df <- plays_df %>%
        janitor::clean_names()
      team_box_score <- team_box_score %>%
        janitor::clean_names()
      player_box <- player_box %>%
        janitor::clean_names() %>%
        dplyr::rename(
          '+/-' = "x",
          "fg3" = "x3pt") %>%
        make_hoopR_data("ESPN NBA Player Box Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  pbp <- c(list(plays_df), list(team_box_score),list(player_box))
  names(pbp) <- c("Plays","Team","Player")
  return(pbp)
}

#' **Get ESPN NBA PBP data**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A play-by-play data frame.
#' @keywords NBA PBP
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_pbp(game_id = 401071880))
#' }
#'
espn_nba_pbp <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")
  #---- Play-by-Play ------
  tryCatch(
    expr = {

      raw_play_df <- jsonlite::fromJSON(resp)

      homeAway1 <- jsonlite::fromJSON(resp)[['header']][['competitions']][['competitors']][[1]][['homeAway']][1]

      season <- raw_play_df[['header']][['season']][['year']]
      season_type <- raw_play_df[['header']][['season']][['type']]
      game_date <- as.Date(substr(raw_play_df[['header']][['competitions']][['date']], 0, 10))
      id_vars <- data.frame()
      if (homeAway1 == "home") {

        homeTeamId = as.integer(raw_play_df[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
        homeTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
        homeTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
        homeTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
        homeTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
        homeTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
        homeTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
        homeTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
        homeTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
        homeTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][1])
        homeTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][1]
        homeTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
        awayTeamId = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
        awayTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
        awayTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
        awayTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
        awayTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
        awayTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
        awayTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
        awayTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
        awayTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
        awayTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][2])
        awayTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][2]
        awayTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
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

        awayTeamId = as.integer(raw_play_df[["header"]][["competitions"]][["competitors"]][[1]][['team']][['id']][1])
        awayTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
        awayTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
        awayTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
        awayTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][1]
        awayTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[1]][['href']][2]
        awayTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][1]
        awayTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][1]
        awayTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][1]
        awayTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][1])
        awayTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][1]
        awayTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][1]
        homeTeamId = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2])
        homeTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
        homeTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]
        homeTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
        homeTeamLogo = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][1]
        homeTeamLogoDark = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['logos']][[2]][['href']][2]
        homeTeamFullName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["displayName"]][2]
        homeTeamColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["color"]][2]
        homeTeamAlternateColor = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][["alternateColor"]][2]
        homeTeamScore = as.integer(raw_play_df[['header']][['competitions']][['competitors']][[1]][['score']][2])
        homeTeamWinner = raw_play_df[['header']][['competitions']][['competitors']][[1]][['winner']][2]
        homeTeamRecord = raw_play_df[['header']][['competitions']][['competitors']][[1]][['record']][[1]][['summary']][2]
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

      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)


      plays <- raw_play_df[["plays"]] %>%
        tidyr::unnest_wider("participants")
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
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(
            "id",
            "athlete.id") %>%
          tidyr::unnest_wider("athlete.id", names_sep = "_")
      )
      names(aths)<-c("play.id","athlete.id.1","athlete.id.2","athlete.id.3")
      plays_df <- dplyr::bind_cols(plays, aths, id_vars) %>%
        select(-"athlete.id") %>%
        dplyr::mutate(
          game_id = game_id,
          season = season,
          season_type = season_type,
          game_date = game_date) %>%
        janitor::clean_names() %>%
        make_hoopR_data("ESPN NBA Play-by-Play Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )


  return(plays_df)
}
#' **Get ESPN NBA team box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A team boxscore data frame
#' @keywords NBA Team Box
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_team_box(game_id = 401071880))
#' }
#'
espn_nba_team_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  #---- Team Box ------
  tryCatch(
    expr = {

      raw_play_df <- jsonlite::fromJSON(resp)
      season <- raw_play_df[['header']][['season']][['year']]
      season_type <- raw_play_df[['header']][['season']][['type']]
      homeAwayTeam1 = toupper(raw_play_df[['header']][['competitions']][['competitors']][[1]][['homeAway']][1])
      homeAwayTeam2 = toupper(raw_play_df[['header']][['competitions']][['competitors']][[1]][['homeAway']][2])
      homeTeamId = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][1]
      awayTeamId = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['id']][2]
      homeTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][1]
      awayTeamMascot = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['name']][2]
      homeTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][1]
      awayTeamName = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['location']][2]

      homeTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][1]
      awayTeamAbbrev = raw_play_df[['header']][['competitions']][['competitors']][[1]][['team']][['abbreviation']][2]
      game_date = as.Date(substr(raw_play_df[['header']][['competitions']][['date']],0,10))

      teams_box_score_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["teams"]]),flatten=TRUE)

      teams_box_score_df_2 <- teams_box_score_df[[1]][[2]] %>%
        dplyr::select(
          "displayValue",
          "name") %>%
        dplyr::rename(
          "Home" = "displayValue")
      teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
        dplyr::select("displayValue", "name") %>%
        dplyr::rename("Away" = "displayValue")
      teams2 <- data.frame(t(teams_box_score_df_2$Home))
      colnames(teams2) <- t(teams_box_score_df_2$name)
      teams2$homeAway <- homeAwayTeam2
      teams2$OpponentId <- as.integer(awayTeamId)
      teams2$OpponentName <- awayTeamName
      teams2$OpponentMascot <- awayTeamMascot
      teams2$OpponentAbbrev <- awayTeamAbbrev

      teams1 <- data.frame(t(teams_box_score_df_1$Away))
      colnames(teams1) <- t(teams_box_score_df_1$name)
      teams1$homeAway <- homeAwayTeam1
      teams1$OpponentId <- as.integer(homeTeamId)
      teams1$OpponentName <- homeTeamName
      teams1$OpponentMascot <- homeTeamMascot
      teams1$OpponentAbbrev <- homeTeamAbbrev
      teams <- dplyr::bind_rows(teams1,teams2)

      team_box_score <- teams_box_score_df %>%
        dplyr::select(-"statistics") %>%
        dplyr::bind_cols(teams)

      team_box_score <- team_box_score %>%
        dplyr::mutate(
          game_id = game_id,
          season = season,
          season_type = season_type,
          game_date = game_date
        ) %>%
        janitor::clean_names() %>%
        dplyr::select(
          "game_id",
          "season",
          "season_type",
          "game_date",
          tidyr::everything()) %>%
        make_hoopR_data("ESPN NBA Team Box Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no team box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(team_box_score)
}
#' **Get ESPN NBA player box scores**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A player boxscore data frame
#' @keywords NBA Player Box
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_player_box(game_id = 401071880))
#' }
#'
espn_nba_player_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")


  #---- Player Box ------
  tryCatch(
    expr = {

      raw_play_df <- jsonlite::fromJSON(resp)
      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)

      players_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["players"]]), flatten=TRUE) %>%
        tidyr::unnest("statistics") %>%
        tidyr::unnest("athletes")
      stat_cols <- players_df$names[[1]]
      # athlete_ids <- players_df %>% dplyr::select("athlete.id")
      # stats <- players_df %>%
      #   purrr::pluck("stats")
      #
      # stat_col_df <-   data.frame(matrix(nrow = 0, ncol = length(stat_cols)))
      # colnames(stat_col_df) <- stat_cols
      # stat_col_df %>% dplyr::bind_rows(stats)
      # purrr::map_dfr(athlete_ids, function(x){
      #   athlete_stats <- players_df $stats
      # })
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind,stats))
      colnames(stats_df) <- stat_cols

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(
          "reason",
          "starter",
          "ejected",
          "didNotPlay",
          "active",
          "athlete.uid",
          "athlete.displayName",
          "athlete.jersey",
          "athlete.guid",
          "athlete.id",
          "athlete.shortName",
          "athlete.headshot.alt",
          "athlete.headshot.href",
          "athlete.position.displayName",
          "athlete.position.name",
          "athlete.position.abbreviation",
          "team.shortDisplayName",
          "team.uid",
          "team.alternateColor",
          "team.color",
          "team.displayName",
          "team.name",
          "team.logo",
          "team.location",
          "team.id",
          "team.abbreviation",
          "team.slug"
        )

      player_box <- dplyr::bind_cols(stats_df,players_df) %>%
        dplyr::select(
          "athlete.displayName",
          "team.shortDisplayName",
          tidyr::everything())
      player_box <- player_box %>%
        janitor::clean_names() %>%
        dplyr::rename(
          '+/-' = "x",
          "fg3" = "x3pt") %>%
        make_hoopR_data("ESPN NBA Player Box Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player box score data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(player_box)
}



#' **Get ESPN NBA game rosters**
#' @author Saiem Gilani
#' @param game_id Game ID
#' @return A game rosters data frame
#' @keywords NBA Game Roster
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_game_rosters(game_id = 401283399))
#' }
espn_nba_game_rosters <- function(game_id) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  tryCatch(
    expr = {
      play_base_url <- paste0(
        "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/events/",
        game_id, "/competitions/",
        game_id,"/competitors/")
      game_res <- httr::RETRY("GET", play_base_url)
      # Check the result
      check_status(game_res)

      game_resp <- game_res %>%
        httr::content(as = "text", encoding = "UTF-8")
      game_df <- jsonlite::fromJSON(game_resp)[["items"]] %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        dplyr::rename("team_statistics_href" = "statistics.$ref")

      colnames(game_df) <- gsub(".\\$ref","_href", colnames(game_df))

      game_df <- game_df %>%
        dplyr::rename(
          "team_id" = "id",
          "team_uid" = "uid")

      game_df$game_id <- game_id

      teams_df <- purrr::map_dfr(game_df$team_href, function(x){

        res <- httr::RETRY("GET", x)
        # Check the result
        check_status(res)

        team_df <- res %>%
          httr::content(as = "text", encoding = "UTF-8") %>%
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
              c("logos.width",
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
                "X.ref.2"))) %>%
          janitor::clean_names()

        colnames(team_df)[1:13] <- paste0("team_", colnames(team_df)[1:13])

        team_df <- team_df %>%
          dplyr::rename(
            "logo_href" = "logos_href",
            "logo_dark_href" = "logos_href_1") %>%
          dplyr::left_join(
            game_df %>%
              dplyr::select(
                "game_id",
                "team_id",
                "team_uid",
                "order",
                "homeAway",
                "winner",
                "roster_href"),
            by = c("team_id" = "team_id",
                   "team_uid" = "team_uid")
          )

      })

      ## Inputs
      ## game_id
      team_roster_df <- purrr::map_dfr(teams_df$team_id, function(x){

        res <- httr::RETRY("GET", paste0(play_base_url, x, "/roster"))

        # Check the result
        check_status(res)

        resp <- res %>%
          httr::content(as = "text", encoding = "UTF-8")

        raw_play_df <- jsonlite::fromJSON(resp)[["entries"]]

        raw_play_df <- raw_play_df %>%
          jsonlite::toJSON() %>%
          jsonlite::fromJSON(flatten = TRUE) %>%
          dplyr::mutate(team_id = x) %>%
          dplyr::select(-"period", -"forPlayerId", -"active")

        raw_play_df <- raw_play_df %>%
          dplyr::left_join(teams_df, by = c("team_id" = "team_id"))

      })

      colnames(team_roster_df) <- gsub(".\\$ref","_href", colnames(team_roster_df))

      athlete_roster_df <- purrr::map_dfr(team_roster_df$athlete_href, function(x){

        res <- httr::RETRY("GET", x)

        # Check the result
        check_status(res)

        resp <- res %>%
          httr::content(as = "text", encoding = "UTF-8")

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
            "athlete_display_name" = "displayName"
          )

        raw_play_df2 <- raw_play_df2 %>%
          dplyr::left_join(team_roster_df, by = c("athlete_id" = "playerId"))

      })

      colnames(athlete_roster_df) <- gsub(".\\$ref","_href", colnames(athlete_roster_df))

      athlete_roster_df <- athlete_roster_df %>%
        janitor::clean_names() %>%
        dplyr::select(-dplyr::any_of(c(
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
        ))) %>%
        make_hoopR_data("ESPN NBA Game Roster Information from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(
        glue::glue(
          "{Sys.time()}: Invalid arguments or no game roster data for {game_id} available!"
        )
      )
    },
    warning = function(w) {

    },
    finally = {

    }
  )
  return(athlete_roster_df)
}




#' **Get ESPN NBA team names and IDs**
#' @author Saiem Gilani
#' @return A teams data frame
#' @keywords NBA Teams
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @import furrr
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   try(espn_nba_teams())
#' }
#'

espn_nba_teams <- function(){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams?limit=1000"


  res <- httr::RETRY("GET", play_base_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  tryCatch(
    expr = {

      leagues <- jsonlite::fromJSON(resp)[["sports"]][["leagues"]][[1]][['teams']][[1]][['team']] %>%
        dplyr::group_by(.data$id) %>%
        tidyr::unnest_wider("logos", names_sep = "_") %>%
        tidyr::unnest_wider("logos_href", names_sep = "_") %>%
        dplyr::select(
          -"logos_width",
          -"logos_height",
          -"logos_alt",
          -"logos_rel") %>%
        dplyr::ungroup()

      if("records" %in% colnames(leagues)){
        records <- leagues$record
        records<- records %>%
          tidyr::unnest_wider("items") %>%
          tidyr::unnest_wider("stats", names_sep = "_") %>%
          dplyr::mutate(row = dplyr::row_number())
        stat <- records %>%
          dplyr::group_by(.data$row) %>%
          purrr::map_if(is.data.frame, list)
        stat <- lapply(stat$stats_1,function(x) x %>%
                         purrr::map_if(is.data.frame,list) %>%
                         dplyr::as_tibble())

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
      leagues <- leagues %>% dplyr::select(
        -"links",
        -"isActive",
        -"isAllStar",
        -"uid",
        -"slug")
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
        make_hoopR_data("ESPN NBA Teams Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no teams data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(teams)
}


#' **Get ESPN men's NBA schedule for a specific year**
#'
#' @param season Either numeric or character (YYYYMMDD)
#' @return Returns a tibble
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom glue glue
#' @import rvest
#' @export
#' @examples
#'
#' # Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
#' \donttest{
#'   try(espn_nba_scoreboard (season = "20221117"))
#' }

espn_nba_scoreboard <- function(season){

  max_year <- substr(Sys.Date(), 1,4)

  if(!(as.integer(substr(season, 1, 4)) > 2001)){
    message(paste("Error: Season must be between 2001 and", max_year + 1))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  schedule_api <- glue::glue("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?limit=1000&dates={season_dates}")

  tryCatch(
    expr = {

      res <- httr::RETRY("GET", schedule_api)

      # Check the result
      check_status(res)

      raw_sched <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
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
          -"status") %>%
        tidyr::unnest_wider("competitions") %>%
        dplyr::rename(
          "matchup" = "name",
          "matchup_short" = "shortName",
          "game_id" = "id",
          "game_uid" = "uid",
          "game_date" = "date"
        ) %>%
        tidyr::hoist(.data$status,
                     status_name = list("type", "name")) %>%
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
        tidyr::unnest_wider("season",names_sep="_") %>%
        dplyr::rename("season" = "season_year") %>%
        dplyr::select(-dplyr::any_of("status"))
      nba_data <- nba_data %>%
        tidyr::hoist(
          .data$competitors,
          homeAway = list(1,"homeAway")
        )
      nba_data <- nba_data %>%
        tidyr::hoist(
          .data$competitors,
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
          team2_record = list(2, "records", 1, "summary"))


      nba_data <- nba_data %>%
        dplyr::mutate(
          home_team_name = ifelse(.data$homeAway=="home",.data$team1_team_name, .data$team2_team_name),
          home_team_logo = ifelse(.data$homeAway=="home",.data$team1_team_logo, .data$team2_team_logo),
          home_team_abb = ifelse(.data$homeAway=="home",.data$team1_team_abb, .data$team2_team_abb),
          home_team_id = ifelse(.data$homeAway=="home",.data$team1_team_id, .data$team2_team_id),
          home_team_location = ifelse(.data$homeAway=="home",.data$team1_team_location, .data$team2_team_location),
          home_team_full_name = ifelse(.data$homeAway=="home",.data$team1_team_full, .data$team2_team_full),
          home_team_color = ifelse(.data$homeAway=="home",.data$team1_team_color, .data$team2_team_color),
          home_score = ifelse(.data$homeAway=="home",.data$team1_score, .data$team2_score),
          home_win = ifelse(.data$homeAway=="home",.data$team1_win, .data$team2_win),
          home_record = ifelse(.data$homeAway=="home",.data$team1_record, .data$team2_record),
          away_team_name = ifelse(.data$homeAway=="away",.data$team1_team_name, .data$team2_team_name),
          away_team_logo = ifelse(.data$homeAway=="away",.data$team1_team_logo, .data$team2_team_logo),
          away_team_abb = ifelse(.data$homeAway=="away",.data$team1_team_abb, .data$team2_team_abb),
          away_team_id = ifelse(.data$homeAway=="away",.data$team1_team_id, .data$team2_team_id),
          away_team_location = ifelse(.data$homeAway=="away",.data$team1_team_location, .data$team2_team_location),
          away_team_full_name = ifelse(.data$homeAway=="away",.data$team1_team_full, .data$team2_team_full),
          away_team_color = ifelse(.data$homeAway=="away",.data$team1_team_color, .data$team2_team_color),
          away_score = ifelse(.data$homeAway=="away",.data$team1_score, .data$team2_score),
          away_win = ifelse(.data$homeAway=="away",.data$team1_win, .data$team2_win),
          away_record = ifelse(.data$homeAway=="away",.data$team1_record, .data$team2_record)
        )

      nba_data <- nba_data %>%
        dplyr::mutate(
          home_win = as.integer(.data$home_win),
          away_win = as.integer(.data$away_win),
          home_score = as.integer(.data$home_score),
          away_score = as.integer(.data$away_score))
      nba_data <- nba_data %>%
        dplyr::select(-dplyr::any_of(dplyr::starts_with("team1")),
                      -dplyr::any_of(dplyr::starts_with("team2")),
                      -dplyr::any_of(c("homeAway")))

      if ("leaders" %in% names(nba_data)) {
        schedule_out <- nba_data %>%
          tidyr::hoist(
            .data$leaders,
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

        if ("broadcasts" %in% names(schedule_out) && !any(is.na(schedule_out[['broadcasts']]))) {
          schedule_out %>%
            tidyr::hoist(
              .data$broadcasts,
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        }
      } else {

        if ("broadcasts" %in% names(nba_data) && !any(is.na(nba_data[['broadcasts']]))) {
          nba_data %>%
            tidyr::hoist(
              .data$broadcasts,
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        } else {
          nba_data %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        }
      }

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no scoreboard data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
}

#' **Get ESPN NBA's Standings**
#'
#' @param year Either numeric or character (YYYY)
#' @return A standings data frame
#' @keywords NBA Standings
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export
#' @examples
#' \donttest{
#' try(espn_nba_standings(year = 2021))
#' }
espn_nba_standings <- function(year){

  standings_url <- "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings?region=us&lang=en&contentorigin=espn&type=0&level=1&sort=winpercent%3Adesc%2Cwins%3Adesc%2Cgamesbehind%3Aasc&"

  ## Inputs
  ## year
  full_url <- paste0(standings_url,
                     "season=", year)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      raw_standings <- jsonlite::fromJSON(resp)[["standings"]]

      #Create a dataframe of all NBA teams by extracting from the raw_standings file

      teams <- raw_standings[["entries"]][["team"]]

      teams <- teams %>%
        dplyr::select("id", "displayName") %>%
        dplyr::rename(
          "team_id" = "id",
          "team" = "displayName")

      #creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <- data.table::rbindlist(standings_df, fill = TRUE, idcol = T)

      #Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <- ifelse(is.na(standings_data$value) & !is.na(standings_data$summary), standings_data$summary, standings_data$value)

      standings_data <- standings_data %>%
        dplyr::select(
          ".id",
          "type",
          "value")

      #Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(names_from = "type", values_from = "value")

      standings_data <- standings_data %>%
        dplyr::select(-".id")

      #joining the 2 dataframes together to create a standings table

      standings <- cbind(teams, standings_data)
      standings <- standings %>%
        make_hoopR_data("ESPN NBA Standings Information from ESPN.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no standings data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }

  )
  return(standings)
}


#' **Get ESPN NBA's Betting information**
#'
#' @param game_id  Game ID
#' @returns Returns a named list of data frames: pickcenter, againstTheSpread, predictor
#' @keywords NBA Betting
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select rename
#' @export
#' @examples
#' \donttest{
#' try(espn_nba_betting(game_id = 401283399))
#' }
espn_nba_betting <- function(game_id){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  summary_url <-
    "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## game_id
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()
  tryCatch(
    expr = {

      raw_summary <- jsonlite::fromJSON(resp)
      if("pickcenter" %in% names(raw_summary)){
        pickcenter <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$pickcenter), flatten=TRUE) %>%
          janitor::clean_names() %>%
          dplyr::select(-"links") %>%
          make_hoopR_data("ESPN NBA Pickcenter Information from ESPN.com",Sys.time())
      }
      if("againstTheSpread" %in% names(raw_summary)){
        againstTheSpread <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$againstTheSpread)) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-"links") %>%
          janitor::clean_names()
        records <- againstTheSpread$records

        teams$records <- records
        againstTheSpread <- teams %>%
          make_hoopR_data("ESPN NBA Against the Spread Information from ESPN.com",Sys.time())
      }
      if("predictor" %in% names(raw_summary)){
        predictor_df <- data.frame(
          home_team_id =  raw_summary$predictor$homeTeam$id,
          away_team_id =  raw_summary$predictor$awayTeam$id,
          away_team_game_projection = raw_summary$predictor$awayTeam$gameProjection,
          away_team_chance_loss = raw_summary$predictor$awayTeam$teamChanceLoss
        )
        predictor_df <- predictor_df %>%
          make_hoopR_data("ESPN NBA Predictor Information from ESPN.com",Sys.time())
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no betting data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }

  )
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
#' @keywords NBA Team Stats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#' @return Returns a tibble with the team stats data
#'
#' @examples
#' \donttest{
#'   try(espn_nba_team_stats(team_id = 18, year = 2020))
#' }

espn_nba_team_stats <- function(team_id, year, season_type='regular', total=FALSE){
  if (!(tolower(season_type) %in% c("regular","postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    '/types/',s_type,
    '/teams/',team_id,
    '/statistics/', totals
  )

  df <- data.frame()
  tryCatch(
    expr = {

      # Create the GET request and set response as res
      res <- httr::RETRY("GET", full_url)

      # Check the result
      check_status(res)

      # Get the content and return result as data.frame
      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8")  %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- httr::RETRY("GET", team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
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
        purrr::map_if(is.list,as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c("logos.width",
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
              "X.ref.2"))) %>%
        janitor::clean_names()

      colnames(team_df)[1:13] <- paste0("team_",colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1")

      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep="_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = glue::glue("{.data$name}_{.data$stats_name}")) %>%
        dplyr::select(
          "stats_category_name",
          "stats_value") %>%
        tidyr::pivot_wider(names_from = "stats_category_name",
                           values_from = "stats_value",
                           values_fn = dplyr::first) %>%
        janitor::clean_names()

      df <- team_df %>%
        dplyr::bind_cols(df)


      df <- df %>%
        make_hoopR_data("ESPN NBA Team Season Stats from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}:Invalid arguments or no team season stats data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
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
#' @keywords NBA Player Stats
#' @export
#' @return Returns a tibble with the player stats data
#'
#' @examples
#' \donttest{
#'   try(espn_nba_player_stats(athlete_id = 4433134, year = 2022))
#' }

espn_nba_player_stats <- function(athlete_id, year, season_type='regular', total=FALSE){
  if (!(tolower(season_type) %in% c("regular","postseason"))) {
    # Check if season_type is appropriate, if not regular
    cli::cli_abort("Enter valid season_type: regular or postseason")
  }
  s_type <- ifelse(season_type == "postseason", 3, 2)

  base_url <- "https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/"

  totals <- ifelse(total == TRUE, 0, "")
  full_url <- paste0(
    base_url,
    year,
    '/types/',s_type,
    '/athletes/', athlete_id,
    '/statistics/', totals
  )
  athlete_url <- paste0(
    base_url,
    year,
    '/athletes/', athlete_id
  )
  df <- data.frame()
  tryCatch(
    expr = {

      # Create the GET request and set response as res
      res <- httr::RETRY("GET", full_url)

      # Check the result
      check_status(res)
      # Create the GET request and set response as res
      athlete_res <- httr::RETRY("GET", athlete_url)

      # Check the result
      check_status(athlete_res)

      athlete_df <- athlete_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      team_url <- athlete_df[["team"]][["$ref"]]

      # Create the GET request and set response as res
      team_res <- httr::RETRY("GET", team_url)

      # Check the result
      check_status(team_res)

      team_df <- team_res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
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
        purrr::map_if(is.list,as.data.frame) %>%
        as.data.frame() %>%
        dplyr::select(
          -dplyr::any_of(
            c("logos.width",
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
              "X.ref.2"))) %>%
        janitor::clean_names()
      colnames(team_df)[1:13] <- paste0("team_",colnames(team_df)[1:13])

      team_df <- team_df %>%
        dplyr::rename(
          "logo_href" = "logos_href",
          "logo_dark_href" = "logos_href_1")


      athlete_df[["links"]] <- NULL
      athlete_df[["injuries"]] <- NULL
      athlete_df[["birthPlace"]] <- NULL

      athlete_df <- athlete_df %>%
        purrr::map_if(is.list, as.data.frame) %>%
        tibble::tibble(data=.data$.)
      athlete_df <- athlete_df$data %>%
        as.data.frame() %>%
        dplyr::select(-dplyr::any_of(c("X.ref","X.ref.1","X.ref.2","X.ref.3","X.ref.4","X.ref.5","X.ref.6","X.ref.7","X.ref.8",
                                       "position.X.ref","position.X.ref.1",
                                       "contract.x.ref","contract.x.ref.1","contract.x.ref.2",
                                       "draft.x.ref","draft.x.ref.1"))) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "athlete_id" = "id",
          "athlete_uid" = "uid",
          "athlete_guid" = "guid",
          "athlete_type" = "type")


      # Get the content and return result as data.frame
      df <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("splits") %>%
        purrr::pluck("categories") %>%
        tidyr::unnest("stats", names_sep="_")
      df <- df %>%
        dplyr::mutate(
          stats_category_name = glue::glue("{.data$name}_{.data$stats_name}")) %>%
        dplyr::select("stats_category_name", "stats_value") %>%
        tidyr::pivot_wider(names_from = "stats_category_name",
                           values_from = "stats_value",
                           values_fn = dplyr::first) %>%
        janitor::clean_names()
      df <- athlete_df %>%
        dplyr::bind_cols(df) %>%
        dplyr::bind_cols(team_df)
      df <- df %>%
        make_hoopR_data("ESPN NBA Player Season Stats from ESPN.com",Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}:Invalid arguments or no player season stats data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df)
}
