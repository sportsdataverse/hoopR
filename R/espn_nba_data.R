#' Get ESPN NBA game data (Pbp, Team and Player Box)
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords NBA Game
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  espn_nba_game_all(game_id = 401283399)
#'

espn_nba_game_all <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)

  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)
  raw_play_df <- jsonlite::fromJSON(full_url)[["gamepackageJSON"]]
  raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)

  #---- Play-by-Play ------
  plays <- raw_play_df[["plays"]] %>%
    tidyr::unnest_wider(unlist(.data$participants))
  suppressWarnings(
    aths <- plays %>%
      dplyr::group_by(.data$id) %>%
      dplyr::select(.data$id, .data$athlete.id) %>%
      tidyr::unnest_wider(unlist(.data$athlete.id, use.names=FALSE),names_sep = "_")
  )
  names(aths)<-c("play.id","athlete1.id","athlete2.id","athlete3.id")
  plays_df <- dplyr::bind_cols(plays, aths) %>%
    select(-.data$athlete.id)
  #---- Team Box ------
  teams_box_score_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["teams"]]),flatten=TRUE)
  teams_box_score_df_2 <- teams_box_score_df[[1]][[2]] %>%
    dplyr::select(.data$displayValue, .data$label) %>%
    dplyr::rename(Home = .data$displayValue)
  teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
    dplyr::select(.data$displayValue) %>%
    dplyr::rename(Away = .data$displayValue)

  team_box_score = dplyr::bind_cols(teams_box_score_df_2, teams_box_score_df_1)
  tm <- c(teams_box_score_df[2,"team.shortDisplayName"], "Team", teams_box_score_df[1,"team.shortDisplayName"])
  names(tm) <- c("Home","label","Away")
  team_box_score = dplyr::bind_rows(tm, team_box_score)
  #---- Player Box ------
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
      fg3 = .data$x3pt
    )
  pbp <- c(list(plays_df), list(team_box_score),list(player_box))
  names(pbp) <- c("Plays","Team","Player")
  return(pbp)
}

#' Get ESPN NBA PBP data
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords NBA PBP
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  espn_nba_pbp(game_id = 401283399)
#'
espn_nba_pbp <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)

  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)
  raw_play_df <- jsonlite::fromJSON(full_url)[["gamepackageJSON"]]
  raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)
  #---- Play-by-Play ------
  plays <- raw_play_df[["plays"]] %>%
    tidyr::unnest_wider(unlist(.data$participants))
  suppressWarnings(
    aths <- plays %>%
      dplyr::group_by(.data$id) %>%
      dplyr::select(.data$id, .data$athlete.id) %>%
      tidyr::unnest_wider(unlist(.data$athlete.id, use.names=FALSE),names_sep = "_")
  )
  names(aths)<-c("play.id","athlete1.id","athlete2.id","athlete3.id")
  plays_df <- dplyr::bind_cols(plays, aths) %>%
    select(-.data$athlete.id)

  plays_df <- plays_df %>%
    janitor::clean_names()

  return(plays_df)
}
#' Get ESPN NBA team box scores
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords NBA Team Box
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  espn_nba_team_box(game_id = 401283399)
#'
espn_nba_team_box <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)
  raw_play_df <- jsonlite::fromJSON(full_url)[["gamepackageJSON"]]
  raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)
  #---- Team Box ------
  teams_box_score_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df[["boxscore"]][["teams"]]),flatten=TRUE)
  teams_box_score_df_2 <- teams_box_score_df[[1]][[2]] %>%
    dplyr::select(.data$displayValue, .data$label) %>%
    dplyr::rename(Home = .data$displayValue)
  teams_box_score_df_1 <- teams_box_score_df[[1]][[1]] %>%
    dplyr::select(.data$displayValue) %>%
    dplyr::rename(Away = .data$displayValue)

  team_box_score = dplyr::bind_cols(teams_box_score_df_2, teams_box_score_df_1)
  tm <- c(teams_box_score_df[2,"team.shortDisplayName"], "Team", teams_box_score_df[1,"team.shortDisplayName"])
  names(tm) <- c("Home","label","Away")
  team_box_score = dplyr::bind_rows(tm, team_box_score)
  team_box_score <- team_box_score %>%
    janitor::clean_names()

  return(team_box_score)
}
#' Get ESPN NBA player box scores
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords NBA Player Box
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  espn_nba_player_box(game_id = 401283399)
#'
espn_nba_player_box <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://cdn.espn.com/core/nba/playbyplay?render=false&userab=1&xhr=1&"

  ## Inputs
  ## game_id
  full_url <- paste0(play_base_url,
                     "gameId=", game_id)
  raw_play_df <- jsonlite::fromJSON(full_url)[["gamepackageJSON"]]
  raw_play_df <- jsonlite::fromJSON(jsonlite::toJSON(raw_play_df),flatten=TRUE)
  #---- Player Box ------
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
      fg3 = .data$x3pt
    )
  return(player_box)
}


#' Get ESPN NBA team names and ids
#' @author Saiem Gilani
#' @keywords NBA Teams
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows row_number group_by mutate as_tibble ungroup
#' @importFrom tidyr unnest unnest_wider everything pivot_wider
#' @importFrom tibble tibble
#' @importFrom purrr map_if
#' @export
#'
#' @examples
#'
#'  espn_nba_teams()
#'

espn_nba_teams <- function(){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams?limit=1000"

  ## Inputs
  ## game_id
  leagues <- jsonlite::fromJSON(play_base_url)[["sports"]][["leagues"]][[1]][['teams']][[1]][['team']] %>%
    dplyr::group_by(.data$id) %>%
    tidyr::unnest_wider(unlist(.data$logos, use.names=FALSE),names_sep = "_") %>%
    tidyr::unnest_wider(.data$logos_href,names_sep = "_") %>%
    dplyr::select(-.data$logos_width,-.data$logos_height,
                  -.data$logos_alt, -.data$logos_rel) %>%
    dplyr::ungroup()

  records <- leagues$record
  records<- records %>% tidyr::unnest_wider(.data$items) %>%
    tidyr::unnest_wider(.data$stats,names_sep = "_") %>%
    dplyr::mutate(row = dplyr::row_number())
  stat <- records %>%
    dplyr::group_by(.data$row) %>%
    purrr::map_if(is.data.frame, list)
  stat <- lapply(stat$stats_1,function(x) x %>%
                   purrr::map_if(is.data.frame,list) %>%
                   dplyr::as_tibble() )

  s <- lapply(stat, function(x) {
    tidyr::pivot_wider(x)
  })

  s <- tibble::tibble(g = s)
  stats <- s %>% unnest_wider(.data$g)

  records <- dplyr::bind_cols(records %>% dplyr::select(.data$summary), stats)
  teams <- dplyr::bind_cols(leagues, records)
  records <- dplyr::bind_cols(records %>% dplyr::select(.data$summary), stats)
  leagues <- leagues %>% dplyr::select(
    -.data$record,
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
    janitor::clean_names()
  return(teams)
}


#' Get ESPN men's NBA schedule for a specific year
#'
#' @param season Either numeric or character (YYYYMMDD)
#' @author Thomas Mock, you a genius for this one.
#' @return Returns a tibble
#' @import utils
#' @importFrom dplyr select rename any_of mutate
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @importFrom tidyr unnest_wider unchop hoist
#' @importFrom glue glue
#' @export
#' @examples
#'
#' # Get schedule from date 2021-02-15 (returns 1000 results, max allowable.)
#' espn_nba_scoreboard (season = "20210215")

espn_nba_scoreboard <- function(season){

  message(glue::glue("Returning data for {season}!"))

  max_year <- substr(Sys.Date(), 1,4)

  if(!(as.integer(substr(season, 1, 4)) %in% c(2001:max_year))){
    message(paste("Error: Season must be between 2001 and", max_year))
  }

  # year > 2000
  season <- as.character(season)

  season_dates <- season

  schedule_api <- glue::glue("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?limit=1000&dates={season_dates}")

  raw_sched <- jsonlite::fromJSON(schedule_api, simplifyDataFrame = FALSE, simplifyVector = FALSE, simplifyMatrix = FALSE)

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
        janitor::clean_names()
    } else {
      schedule_out %>%
        janitor::clean_names()
    }
  } else {
    nba_data %>% dplyr::select(!where(is.list)) %>%
      janitor::clean_names()
  }

}


