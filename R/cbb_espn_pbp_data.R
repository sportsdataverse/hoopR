#' Get ESPN Data (Pbp, Team and Player Box)
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords CBB Game
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  cbb_espn_game_all(game_id = 401256760)
#'

cbb_espn_game_all <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)

  play_base_url <- "http://cdn.espn.com/mens-college-basketball/playbyplay?render=false&userab=1&xhr=1&"

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
  names(aths)<-c("play.id","athlete1.id","athlete2.id")
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

  pbp <- c(list(plays_df), list(team_box_score),list(player_box))
  names(pbp) <- c("Plays","Team","Player")
  return(pbp)
}

#' Get ESPN PBP
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords CBB PBP
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  cbb_espn_pbp(game_id = 401256760)
#'
cbb_espn_pbp <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)

  play_base_url <- "http://cdn.espn.com/mens-college-basketball/playbyplay?render=false&userab=1&xhr=1&"

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
  names(aths)<-c("play.id","athlete1.id","athlete2.id")
  plays_df <- dplyr::bind_cols(plays, aths) %>%
    select(-.data$athlete.id)


  return(plays_df)
}
#' Get ESPN Team Box
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords CBB Team Box
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  cbb_espn_team_box(game_id = 401256760)
#'
cbb_espn_team_box <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://cdn.espn.com/mens-college-basketball/playbyplay?render=false&userab=1&xhr=1&"

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
  return(team_box_score)
}
#' Get ESPN Player Box
#' @author Saiem Gilani
#' @param game_id Game ID
#' @keywords CBB Player Box
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  cbb_espn_player_box(game_id = 401256760)
#'
cbb_espn_player_box <- function(game_id){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://cdn.espn.com/mens-college-basketball/playbyplay?render=false&userab=1&xhr=1&"

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
  return(player_box)
}


#' Get ESPN Conference Names and Ids
#' @author Saiem Gilani
#' @keywords CBB Conferences
#' @importFrom rlang .data
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @export
#'
#' @examples
#'
#'  cbb_espn_conferences()
#'
cbb_espn_conferences <- function(){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/scoreboard/conferences"

  ## Inputs
  ## game_id

  conferences <- jsonlite::fromJSON(play_base_url)[["conferences"]] %>% dplyr::select(-.data$subGroups)

  return(conferences)
}

#' Get ESPN Team Names and Ids
#' @author Saiem Gilani
#' @keywords CBB Teams
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
#'  cbb_espn_teams()
#'

cbb_espn_teams <- function(){
  options(stringsAsFactors = FALSE)
  options(scipen = 999)
  play_base_url <- "http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams?groups=50&limit=1000"

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
  leagues <- leagues %>% dplyr::select(-.data$record,-.data$links)
  teams <- dplyr::bind_cols(leagues, records)
  return(teams)
}
