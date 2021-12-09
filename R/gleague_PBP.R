#' **Get NBA Data API Play-by-Play for G League Games**
#' @name get_gleague_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play for G League Games**
#' @description Scrapes the NBA Data API for Play By Play for G League games
#' @rdname get_gleague_pbp
#' @author Billy Fryer
#' @param gid Game ID - 10 digits, i.e. 0021900001
#' @param season Season that the game was played in - 4 digit, i.e. 2021
#' @return Returns a data frame of play by play
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr %>% pull bind_rows
#' @importFrom glue glue
#' @importFrom httr RETRY content
#' @export
#' @examples
#' get_gleague_pbp(season = 2021, gid = 2052100003)

# Pipe is also from dplyr but not sure how to do that

# Example PBP JSON Link:
# https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/scores/pbp/2072100013_full_pbp.json

get_gleague_pbp <- function(season, gid) {

  full_url <- glue::glue("https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/{season}/scores/pbp/{gid}_full_pbp.json")
  
  res <- httr::RETRY("GET", full_url)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")
  # Find Table with the pbp in it
  data <- jsonlite::fromJSON(resp)[["g"]][["pd"]][[2]]
  
  # Set Empty DF to bind rows to until I can learn map_df()
  pbp_df <- data.frame()

  for (i in 1:length(data)) {
    pbp_df <- dplyr::bind_rows(pbp_df, data[[i]])
  }
  
  return(pbp_df)
}


### Variables included

#' evt = Event number
#' cl = Time Remaining in Quarter
#' de = description
#' locX = X location of action
#' locY = Y location of action
#' opt1 = ???
#' opt2 = ???
#' mtype = ???
#' etype = ???
#' opid = ???
#' tid = Team ID, 0 for events not relating to a team (such as end of Q)
#' pid = Player ID
#' hs = Home Score
#' vs = Visitor Score
#' epid = Secondary Person ID (such as assister)
#' oftid = Offensive Team ID? This is equal to tid in my test case
#' ord = ???
