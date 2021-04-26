
#' Get KenPom's single-game records for a team
#'
#' @param browser User login session
#' @param team Team filter to select.
#' @param conference_only Filter records to only conference games, default: FALSE
#' @keywords Single-Game Team Records
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter mutate
#' @examples
#' \dontrun{
#'   kp_records_team(team = 'Florida St.')
#' }

kp_records_team <- function(team, conference_only = FALSE){

  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

  browser <- login()
  # Check teams parameter in teams list names
  assertthat::assert_that(team %in% kenpomR::teams_links$Team,
                          msg = "Incorrect team name as compared to the website, see kenpomR::teams_links for team name parameter specifications.")
  team_name = unique(kenpomR::teams_links$team.link.ref[kenpomR::teams_links$Team == team])


  if(conference_only == TRUE){
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name,
                  "&conf_only")
  }else{
    url <- paste0("https://kenpom.com/records.php?",
                  "team=", team_name)
  }
  page <- rvest::session_jump_to(browser, url)

  y <- list()

  for(i in 1:42){
    Metric <- c('OE','OE','eFG.Pct','eFG.Pct',
                'TO.Pct','TO.Pct','OR.Pct','OR.Pct',
                'FTR','FTR','FG2.Pct','FG2.Pct',
                'FG3.Pct','FG3.Pct','FG3A.Pct','FG3A.Pct','FT.Pct','FT.Pct',
                'OE','OE','eFG.Pct','eFG.Pct',
                'TO.Pct','TO.Pct','OR.Pct','OR.Pct',
                'FTR','FTR','FG2.Pct','FG2.Pct',
                'FG3.Pct','FG3.Pct','FG3A.Pct','FG3A.Pct','FT.Pct','FT.Pct',
                'Pace','Pace','Pts','Pts','Pts','Pts')

    header_cols<- c('Rk','Date','Opponent','Location','Result',
                    'Regulation',
                    Metric[i])

    x <- (page %>%
            xml2::read_html() %>%
            rvest::html_elements(css='#stattable'))[[i]] %>%
      rvest::html_table()

    colnames(x) <- header_cols

    team_name <- gsub("\\+"," ",team)
    x <- x %>%
      dplyr::mutate(Team = team_name,
                    Conference_Only = FALSE)
    if(i %% 2 != 0){
      replace_na_with_last <- function(x, p=is.na, d=0){
        c(d, x)[cummax(seq_along(x)*(!p(x)))+1]
      }
      x$Rk <- replace_na_with_last(x$Rk)
    }else{
      replace_na_with_first <- function(x, p=is.na, d=0){
        c(d, x)[cummax(seq_along(-1*x)*(!p(x)))+1]
      }
      x$Rk <- rev(replace_na_with_first(rev(x$Rk)))
    }
    if(conference_only){
      x <- x %>%
        dplyr::mutate(
          Team = team_name,
          Conference_Only = conference_only
        )
    }
    y <- c(y, list(x))
  }

  ### Store Data
  kenpom <- y

  return(kenpom)
}
