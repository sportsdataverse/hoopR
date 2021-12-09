#' **Get Current G League Standings from NBA API**
#' @name get_gleague_standings
NULL
#' @title
#' **Get Current G League Standings from NBA API**
#' @description Scrapes the NBA Data API for G League Standings
#' @rdname get_gleague_standings
#' @author Billy Fryer
#' @return Returns a data frame of the G League Season Standings
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr RETRY content
#' @importFrom dplyr %>% pull bind_rows arrange
#' @export
#' @examples
#' get_gleague_season_schedule(season = 2021)

# Libraries used
library(dplyr) # For the %>% and the pull() function
# Also httr, glue, jsonlite

# Example PBP JSON Link:
# https://s.data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/20_standings_05.json

get_gleague_standings <- function() {

  full_url <- glue::glue("https://s.data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/20_standings_05.json"
)
  
  res <- httr::RETRY("GET", full_url)

  resp <- res %>%
    httr::content(as = "text", encoding = "UTF-8")
  # Find Table with the pbp in it
  data <- jsonlite::fromJSON(resp)[["sta"]][["co"]] %>% 
    pull(di) %>% 
    bind_rows() %>% 
    pull(t) %>% 
    bind_rows() %>% 
    arrange(see)
  
  # data2 <- jsonlite::fromJSON(resp)[["sta"]][["co"]]
  
  
  # # West Rankings
  # west_rankings <- data2 %>% 
  #   filter(val == "West") %>% 
  #   pull(di) %>% 
  #   data.frame() %>% 
  #   pull(t) %>% 
  #   bind_rows()
  # 
  # # East Rankings
  # east_rankings <- data2 %>% 
  #   filter(val == "East") %>% 
  #   pull(di) %>% 
  #   data.frame() %>% 
  #   pull(t) %>% 
  #   bind_rows()
  # 
  # # Neutral Rankings
  # other_rankings <- data2 %>% 
  #   filter(val == "") %>% 
  #   pull(di) %>% 
  #   data.frame() %>% 
  #   pull(t) %>% 
  #   bind_rows()

  return(data)
}

### Variable Explanation

#' tid = Team ID
#' see = Ranking
#' cli = ???
#' clid = ???
#' clic = ???
#' elim = ???
#' str = Win Streak. All data comes in format "W/L ##"
#' l10 = Last 10 Games Record
#' dr = ???
#' cr = ???
#' l = Losses
#' w = Wins
#' hr = Home Record
#' ar = Away Record
#' gb = Games Behind
#' gbd = Games Behind Division
#' crnk = Conference Rank? This appears to be the same as see
#' drnk = Division Rank
#' ta = Team Abbreviation
#' tn = Team Nickname
#' tc = Team City