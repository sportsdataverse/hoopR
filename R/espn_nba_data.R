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

  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")
  #---- Play-by-Play ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)


      plays <- raw_play_df[["plays"]] %>%
        tidyr::unnest_wider(.data$participants)
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(.data$id, .data$athlete.id) %>%
          tidyr::unnest_wider(.data$athlete.id, names_sep = "_")
      )
      names(aths)<-c("play.id","athlete.id.1","athlete.id.2","athlete.id.3")
      plays_df <- dplyr::bind_cols(plays, aths) %>%
        select(-.data$athlete.id) %>%
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
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
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
        dplyr::select(.data$displayValue, .data$name) %>%
        dplyr::rename(Home = .data$displayValue)
      teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
        dplyr::select(.data$displayValue, .data$name) %>%
        dplyr::rename(Away = .data$displayValue)
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
        dplyr::select(-.data$statistics) %>%
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
          .data$game_id,
          .data$season,
          .data$season_type,
          .data$game_date,
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
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
      players_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["players"]]), flatten=TRUE) %>%
        tidyr::unnest(.data$statistics) %>%
        tidyr::unnest(.data$athletes)
      stat_cols <- players_df$names[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind,stats))
      colnames(stats_df) <- stat_cols

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(.data$starter,.data$ejected, .data$didNotPlay,.data$active,
                      .data$athlete.displayName,.data$athlete.jersey,
                      .data$athlete.id,.data$athlete.shortName,
                      .data$athlete.headshot.href,.data$athlete.position.name,
                      .data$athlete.position.abbreviation,.data$team.shortDisplayName,
                      .data$team.name,.data$team.logo,.data$team.id,.data$team.abbreviation,
                      .data$team.color,.data$team.alternateColor
        )

      player_box <- dplyr::bind_cols(stats_df,players_df) %>%
        dplyr::select(.data$athlete.displayName,.data$team.shortDisplayName, tidyr::everything())
      plays_df <- plays_df %>%
        janitor::clean_names()
      team_box_score <- team_box_score %>%
        janitor::clean_names()
      player_box <- player_box %>%
        janitor::clean_names() %>%
        dplyr::rename(
          '+/-'=.data$x,
          fg3 = .data$x3pt) %>%
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
#'   try(espn_nba_pbp(game_id = 401283399))
#' }
#'
espn_nba_pbp <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)


  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")
  #---- Play-by-Play ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)

      plays <- raw_play_df[["plays"]] %>%
        tidyr::unnest_wider(.data$participants)
      suppressWarnings(
        aths <- plays %>%
          dplyr::group_by(.data$id) %>%
          dplyr::select(.data$id, .data$athlete.id) %>%
          tidyr::unnest_wider(.data$athlete.id, names_sep = "_")
      )
      names(aths)<-c("play.id","athlete.id.1","athlete.id.2","athlete.id.3")
      plays_df <- dplyr::bind_cols(plays, aths) %>%
        select(-.data$athlete.id)

      plays_df <- plays_df %>%
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
#'   try(espn_nba_team_box(game_id = 401283399))
#' }
#'
espn_nba_team_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  #---- Team Box ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
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
        dplyr::select(.data$displayValue, .data$name) %>%
        dplyr::rename(Home = .data$displayValue)
      teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
        dplyr::select(.data$displayValue, .data$name) %>%
        dplyr::rename(Away = .data$displayValue)
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
        dplyr::select(-.data$statistics) %>%
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
          .data$game_id,
          .data$season,
          .data$season_type,
          .data$game_date,
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
#'   try(espn_nba_player_box(game_id = 401283399))
#' }
#'
espn_nba_player_box <- function(game_id){
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")

  #---- Player Box ------
  tryCatch(
    expr = {
      raw_play_df <- jsonlite::fromJSON(resp)[["gamepackageJSON"]]
      raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)

      players_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["players"]]), flatten=TRUE) %>%
        tidyr::unnest(.data$statistics) %>%
        tidyr::unnest(.data$athletes)
      stat_cols <- players_df$names[[1]]
      stats <- players_df$stats

      stats_df <- as.data.frame(do.call(rbind,stats))
      colnames(stats_df) <- stat_cols

      players_df <- players_df %>%
        dplyr::filter(!.data$didNotPlay) %>%
        dplyr::select(.data$starter,.data$ejected, .data$didNotPlay,.data$active,
                      .data$athlete.displayName,.data$athlete.jersey,
                      .data$athlete.id,.data$athlete.shortName,
                      .data$athlete.headshot.href,.data$athlete.position.name,
                      .data$athlete.position.abbreviation,.data$team.shortDisplayName,
                      .data$team.name,.data$team.logo,.data$team.id,.data$team.abbreviation,
                      .data$team.color,.data$team.alternateColor
        )

      player_box <- dplyr::bind_cols(stats_df,players_df) %>%
        dplyr::select(.data$athlete.displayName,.data$team.shortDisplayName, tidyr::everything())
      player_box <- player_box %>%
        janitor::clean_names() %>%
        dplyr::rename(
          '+/-'=.data$x,
          fg3 = .data$x3pt) %>%
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
        tidyr::unnest_wider(.data$logos, names_sep = "_") %>%
        tidyr::unnest_wider(.data$logos_href, names_sep = "_") %>%
        dplyr::select(-.data$logos_width,-.data$logos_height,
                      -.data$logos_alt, -.data$logos_rel) %>%
        dplyr::ungroup()

      if("records" %in% colnames(leagues)){
        records <- leagues$record
        records<- records %>% tidyr::unnest_wider(.data$items) %>%
          tidyr::unnest_wider(.data$stats, names_sep = "_") %>%
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
        stats <- s %>% unnest_wider(.data$g)

        records <- dplyr::bind_cols(records %>% dplyr::select(.data$summary), stats)
        leagues <- leagues %>%
          dplyr::select(-.data$record)
      }
      leagues <- leagues %>% dplyr::select(
        -.data$links,
        -.data$isActive,
        -.data$isAllStar,
        -.data$uid,
        -.data$slug)
      teams <- leagues %>%
        dplyr::rename(
          logo = .data$logos_href_1,
          logo_dark = .data$logos_href_2,
          mascot = .data$name,
          team = .data$location,
          team_id = .data$id,
          short_name = .data$shortDisplayName,
          alternate_color = .data$alternateColor,
          display_name = .data$displayName
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
#' # Get schedule from date 2021-02-15 (returns 1000 results, max allowable.)
#' \donttest{
#'   try(espn_nba_scoreboard (season = "20220215"))
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

  res <- httr::RETRY("GET", schedule_api)

  # Check the result
  check_status(res)

  tryCatch(
    expr = {
      raw_sched <- res %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

      nba_data <- raw_sched[["events"]] %>%
        tibble::tibble(data = .data$.) %>%
        tidyr::unnest_wider(.data$data) %>%
        tidyr::unchop(.data$competitions) %>%
        dplyr::select(-.data$id, -.data$uid, -.data$date, -.data$status) %>%
        tidyr::unnest_wider(.data$competitions) %>%
        dplyr::rename(matchup = .data$name, matchup_short = .data$shortName, game_id = .data$id, game_uid = .data$uid, game_date = .data$date) %>%
        tidyr::hoist(.data$status,
                     status_name = list("type", "name")) %>%
        dplyr::select(!dplyr::any_of(c("timeValid", "neutralSite", "conferenceCompetition","recent", "venue", "type"))) %>%
        tidyr::unnest_wider(.data$season) %>%
        dplyr::rename(season = .data$year) %>%
        dplyr::select(-dplyr::any_of("status")) %>%
        tidyr::hoist(
          .data$competitors,
          home_team_name = list(1, "team", "name"),
          home_team_logo = list(1, "team", "logo"),
          home_team_abb = list(1, "team", "abbreviation"),
          home_team_id = list(1, "team", "id"),
          home_team_location = list(1, "team", "location"),
          home_team_full = list(1, "team", "displayName"),
          home_team_color = list(1, "team", "color"),
          home_score = list(1, "score"),
          home_win = list(1, "winner"),
          home_record = list(1, "records", 1, "summary"),
          # away team
          away_team_name = list(2, "team", "name"),
          away_team_logo = list(2, "team", "logo"),
          away_team_abb = list(2, "team", "abbreviation"),
          away_team_id = list(2, "team", "id"),
          away_team_location = list(2, "team", "location"),
          away_team_full = list(2, "team", "displayName"),
          away_team_color = list(2, "team", "color"),
          away_score = list(2, "score"),
          away_win = list(2, "winner"),
          away_record = list(2, "records", 1, "summary"),
        ) %>%
        dplyr::mutate(home_win = as.integer(.data$home_win),
                      away_win = as.integer(.data$away_win),
                      home_score = as.integer(.data$home_score),
                      away_score = as.integer(.data$away_score))

      if("leaders" %in% names(nba_data)){
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

        if("broadcasts" %in% names(schedule_out)) {
          schedule_out %>%
            tidyr::hoist(
              .data$broadcasts,
              broadcast_market = list(1, "market"),
              broadcast_name = list(1, "names", 1)
            ) %>%
            dplyr::select(!where(is.list)) %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        } else {
          schedule_out %>%
            janitor::clean_names() %>%
            make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
        }
      } else {
        nba_data %>% dplyr::select(!where(is.list)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("ESPN NBA Scoreboard Information from ESPN.com",Sys.time())
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
        dplyr::select(.data$id, .data$displayName) %>%
        dplyr::rename(team_id = .data$id,
                      team = .data$displayName)

      #creating a dataframe of the WNBA raw standings table from ESPN

      standings_df <- raw_standings[["entries"]][["stats"]]

      standings_data <- data.table::rbindlist(standings_df, fill = TRUE, idcol = T)

      #Use the following code to replace NA's in the dataframe with the correct corresponding values and removing all unnecessary columns

      standings_data$value <- ifelse(is.na(standings_data$value) & !is.na(standings_data$summary), standings_data$summary, standings_data$value)

      standings_data <- standings_data %>%
        dplyr::select(.data$.id, .data$type, .data$value)

      #Use pivot_wider to transpose the dataframe so that we now have a standings row for each team

      standings_data <- standings_data %>%
        tidyr::pivot_wider(names_from = .data$type, values_from = .data$value)

      standings_data <- standings_data %>%
        dplyr::select(-.data$.id)

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

  summary_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?"

  ## Inputs
  ## year
  full_url <- paste0(summary_url,
                     "event=", game_id)

  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  pickcenter <- data.frame()
  againstTheSpread <- data.frame()
  predictor_df <- data.frame()
  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")

      raw_summary <- jsonlite::fromJSON(resp)
      if("pickcenter" %in% names(raw_summary)){
        pickcenter <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$pickcenter), flatten=TRUE) %>%
          janitor::clean_names() %>%
          dplyr::select(-.data$links) %>%
          make_hoopR_data("ESPN NBA Pickcenter Information from ESPN.com",Sys.time())
      }
      if("againstTheSpread" %in% names(raw_summary)){
        againstTheSpread <- jsonlite::fromJSON(jsonlite::toJSON(raw_summary$againstTheSpread)) %>%
          janitor::clean_names()
        teams <- againstTheSpread$team %>%
          dplyr::select(-.data$links) %>%
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
