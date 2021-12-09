#' **Get G League Schedule from NBA API**
#' @name get_gleague_season_schedule
NULL
#' @title
#' **Get G League Schedule from NBA API**
#' @description Scrapes the NBA Data API for G League Schedule for a Given Season
#' @rdname get_gleague_season_schedule
#' @author Billy Fryer
#' @param season Season - 4 digit, i.e. 2021
#' @return Returns a data frame of the G League Season Schedule
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr RETRY content
#' @importFrom dplyr %>% pull bind_rows arrange
#' @export
#' @examples
#' get_gleague_season_schedule(season = 2021)

# Example JSON Link:
# https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/league/20_full_schedule.json

get_gleague_season_schedule <- function(season = 2021) {
  # From This Line to My next comment, basically everything is 
  # Copied from hoopR except the url and the table name
  full_url <- glue::glue("https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/{season}/league/20_full_schedule.json")
  res <- httr::RETRY("GET", full_url)
  
  resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")
  
  data <- jsonlite::fromJSON(resp)[["lscd"]]
  
  # I did this for loop because I am incompetent at using the map_df()
  # function. Right now it's not too bad but help would be appreciated
  schedule_df <- data.frame()
  
  for (i in 1:nrow(data)) {
    month_df <- data.frame(data$mscd[i,]) %>% 
      pull(g) %>% 
      data.frame()
    
    schedule_df <- bind_rows(schedule_df,month_df)
  }
  
  # Get Dates in Chronological order rather than by month
  schedule_df <- schedule_df %>% arrange(gdte)
  
  return(schedule_df)
}

# 2015 and Older does not work

### Variable Explanation

#' gid = Game Id
#' gcode = GameDate/VisitorAbbreveationHomeAbbreviation
#' seri = Always returns ""
#' is = Always returns 1
#' gdte = Game Date
#' htm = Game Date and time for Home Team
#' vtm = Game Date and time for Visiting Team
#' etm = Game Date and time in Eastern
#' an = Arena where game was played
#' ac = City where game was played
#' as = Atate where game was played
#' st = Always "1"
#' stt = Game Start time in eastern for "12:00 pm EST"
#' bd.b = Data Frame with 6 variables about television broadcast
#' v.tid = Visitor Team Id
#' v.re = Visitor Record (?)
#' v.ta = Visitor Abbreviation
#' v.tn = Visitor Team Nickname
#' v.tc = Visitor Team City
#' v.s = NULL
#' h.tid = Home Team Id
#' h.re =  Home Record (?)
#' h.ta =  Home Abbreviation
#' h.tn =  Home Team Nickname
#' h.tc =  Home Team City
#' h.s = NULL
#' gdctm = Game Date but somehow different than gdte
#' utctm = ???
#' ppdst = ???
#' seq = Game Order By Day (1st game on 1-1-2022, 2nd game on 1-1-2022, 1st game on 1-2-2022, etc.)

