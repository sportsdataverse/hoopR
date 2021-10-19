#' Get Game Box Score
#'
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#'
#' @keywords Game Box Score
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate arrange bind_rows mutate_at rename
#' @importFrom tidyr everything separate
#' @import rvest
#' @import stringr
#' @export
#'
#' @examples
#' \donttest{
#'   kp_box(game_id = 1238, year = 2020)
#' }

kp_box <- function(game_id, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)

  browser <- login()

  if(!(is.numeric(year) && nchar(year) == 4 && year>=2013)) {
    # Check if year is numeric, if not NULL
    cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2013")
  }
  ### Pull Data
  url <- paste0("https://kenpom.com/box.php?",
                "g=",game_id,
                "&y=",year)


  page <- rvest::session_jump_to(browser, url)

  teams <- page %>%
    xml2::read_html() %>%
    rvest::html_elements(".teamnav") %>%
    rvest::html_elements("b > a")
  teams <- dplyr::bind_rows(lapply(rvest::html_text(teams),
                                   function(x){data.frame(Team = x, stringsAsFactors = FALSE)}))

  refs <- (page %>%
             xml2::read_html() %>%
             rvest::html_elements(xpath = "//*[@id='half-column3']//span//div[4]") %>%
             rvest::html_elements("a"))[-1]

  ref_ranks <- page %>%
    xml2::read_html() %>%
    rvest::html_elements(xpath = "//*[@id='half-column3']//span//div[4]") %>%
    rvest::html_elements(".seed")

  ref_ranks <- dplyr::bind_rows(lapply(rvest::html_text(ref_ranks),
                                       function(x){data.frame(Official.Rk=x, stringsAsFactors=FALSE)}))

  ref_ids <- dplyr::bind_rows(lapply(xml2::xml_attrs(refs),
                                     function(x){data.frame(as.list(x), stringsAsFactors=FALSE)}))
  ref_ids <- ref_ids %>%
    dplyr::filter(!stringr::str_detect(.data$href,"official")) %>%
    dplyr::mutate(ref_id = stringr::str_remove(stringr::str_remove(
      stringi::stri_extract_first_regex(.data$href,"=(.+)"),"="),"&(.+)")) %>%
    dplyr::select(.data$ref_id) %>%
    dplyr::rename(OfficialId=.data$ref_id)


  ref_names <- dplyr::bind_rows(lapply(rvest::html_text(refs),
                                       function(x){data.frame(x, stringsAsFactors=FALSE)})) %>%
    dplyr::rename(OfficialName=.data$x)

  ref_table <- data.frame(ref_ids,ref_names,ref_ranks, stringsAsFactors = FALSE)
  ref_table$GameId <- game_id
  ref_table$Year <- year
  ref_table <- ref_table %>%
    janitor::clean_names()
  linescore <- ((page %>%
                   xml2::read_html() %>%
                   rvest::html_elements("#linescore-table2"))[[1]]) %>%
    rvest::html_table()

  names(linescore)[1] <- "Team"
  linescore <- linescore %>%
    janitor::clean_names()
  y <- list()
  for(i in 1:2){
    x <- (page %>%
            xml2::read_html() %>%
            rvest::html_elements(".box-table"))[[i]]


    box_stat <- x %>%
      rvest::html_elements(".box-stat")
    xml2::xml_remove(box_stat)

    x <- x %>%
      rvest::html_table()
    x$Team <- teams[i,]
    x$WP.Note <- NA_character_
    x$WP.Note <- x[nrow(x),1]
    x <- x[1:(nrow(x)-1),]
    header_cols <- c("Hgt-Wgt-Yr", "Number", "Player", "Min",
                     "ORtg", "%Ps", "Pts", "FGM2-A", "FGM3-A",
                     "FTM-A", "OR", "DR", "A",
                     "TO", "Blk", "Stl", "PF", "Team", "WP.Note")

    colnames(x) <- header_cols

    # box <- xml2::xml_text(box_stat)
    suppressWarnings(
      x <- x %>% tidyr::separate(col=.data$"Hgt-Wgt-Yr",
                                 into = c("Hgt","Wgt","Yr"),
                                 sep = "\\s") %>%
        dplyr::mutate_at(c("Wgt","Number","Min","ORtg","%Ps","Pts",
                           "OR","DR","A","TO","Blk","Stl","PF"),as.numeric)
    )
    x <- x %>% dplyr::mutate(GameId = game_id,
                             Year = year) %>%
      janitor::clean_names()
    y <- c(y,list(x))
  }
  ### Store Data
  kenpom <- c(y,list(linescore),list(ref_table))

  return(kenpom)
}

#' Get Win Probability
#'
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#'
#' @keywords Win Probability
#' @importFrom cli cli_abort
#' @importFrom dplyr select filter mutate arrange bind_rows bind_cols rename
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_extract_all
#' @import rvest
#' @export
#'
#' @examples
#' \donttest{
#'   kp_winprob(game_id = 1238, year = 2020)
#' }

kp_winprob <- function(game_id, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  if(!(is.numeric(year) && nchar(year) == 4 && year>=2010)) {
    # Check if year is numeric, if not NULL
    cli::cli_abort("Enter valid year as a number (YYYY), data only goes back to 2010")
  }
  url <- paste0("https://kenpom.com/winprob.php?",
                "g=", game_id,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  q <- (page %>%
          xml2::read_html() %>%
          rvest::html_elements("#content-header") %>%
          rvest::html_elements("script")) %>%
    rvest::html_text2()

  r <-  stringr::str_extract(stringr::str_remove(q[2], "var dataset="),"(.+?)(?=; var runs=)")
  r <- gsub("'",'"', r)
  wp_dataset <- purrr::map_dfr(c(r), jsonlite::fromJSON)

  wp_dataset$GameId = game_id
  wp_dataset$Year = year
  wp_dataset <- wp_dataset %>%
    janitor::clean_names() %>%
    dplyr::rename(Period = .data$pd,
                  TimeLeft = .data$tl,
                  VisitorScore = .data$vs,
                  HomeScore = .data$hs,
                  VisitorScoring = .data$v_sc,
                  HomeScoring = .data$h_sc,
                  PossessionTeam = .data$p,
                  PossessionNumber = .data$pn) %>%
    janitor::clean_names()
  run_str <- stringr::str_extract(stringr::str_remove(q[2], "(.+)var runs="),"(.+?)(?=; var data=)")
  run_str <- gsub("'",'"', run_str)
  runs <- purrr::map_dfr(c(run_str), jsonlite::fromJSON)
  runs <- runs %>%
    dplyr::rename(
      visitor = .data$V,
      home = .data$H,
      start = .data$Start,
      end = .data$End
    )
  #---- game_data --------
  game_data_str <- stringr::str_remove(stringr::str_remove(q[2], "(.+)var data="),"makeWP\\(data\\);")
  vn <- data.frame(vn = t(gsub(pattern = "'","", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(q[2],pattern="venue:\'(.+)\', city:"),pattern=", city:"),pattern="venue:"))))
  cty <- data.frame(cty = t(gsub(pattern = "'","", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(q[2], pattern="city:\'(.+)\', gameTime:"),pattern=", gameTime:"),pattern="city:"))))
  gmtm <- data.frame(gmtm = t(gsub(pattern = "'","", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(q[2],pattern="gameTime:\'(.+)\', dominance:"),pattern=", dominance:"),pattern="gameTime:"))))
  dateofgame <- data.frame(dateofgame = t(gsub(pattern = "'","", stringr::str_remove(stringr::str_remove(stringr::str_extract_all(q[2],pattern="dateOfGame:\'(.+)\', ymd:"),pattern=", ymd:"),pattern="dateOfGame:"))))
  game_data_str <- stringr::str_remove(game_data_str,pattern="venue:\'(.+)\',(?= city:)")
  game_data_str <- stringr::str_remove(game_data_str,pattern="city:\'(.+)\',(?= gameTime:)")
  game_data_str <- stringr::str_remove(game_data_str,pattern="gameTime:\'(.+)\',(?= dominance:)")
  game_data_str <- stringr::str_remove(game_data_str,pattern="dateOfGame:\'(.+)\',(?= ymd:)")
  game_data_str <- stringr::str_remove(game_data_str,pattern=", input:(.+)(?=\\})")
  game_data_str <- gsub("\\{ ",'\\{ "', game_data_str)
  game_data_str <- gsub(", ",', "', game_data_str)
  game_data_str <- gsub(":",'":', game_data_str)
  game_data_str <- gsub("'",'"', game_data_str)
  game_data_str <- glue::glue('[{game_data_str}]')
  game_data <- purrr::map_dfr(c(game_data_str), jsonlite::fromJSON)
  game_data <- dplyr::bind_cols(game_data, vn, cty, gmtm, dateofgame)
  colnames(game_data) <- gsub(' ','',colnames(game_data))
  game_data <- game_data %>%
    dplyr::rename(GameId = .data$gid,
                  Full.Date = .data$dateofgame,
                  Date = .data$ymd,
                  GameTime = .data$gmtm,
                  Venue = .data$vn,
                  City = .data$cty,
                  Team1.Rk = .data$rank1,
                  Team1 = .data$team1,
                  Team1Score = .data$score1,
                  Team2.Rk = .data$rank2,
                  Team2 = .data$team2,
                  Team2Score = .data$score2,
                  Dominance.Season.Rk = .data$srank_dominance,
                  Tension.Season.Rk = .data$srank_tension,
                  Excitement.Season.Rk = .data$srank_excitement,
                  LeadChanges.Season.Rk  = .data$srank_favchg,
                  MinimumWP.Season.Rk = .data$srank_minWP,
                  Dominance.Rk = .data$rank_dominance,
                  Tension.Rk = .data$rank_tension,
                  Excitement.Rk = .data$rank_excitement,
                  LeadChanges.Rk  = .data$rank_favchg,
                  MinimumWP.Rk = .data$rank_minWP) %>%
    janitor::clean_names()
  game_data <- game_data %>% dplyr::select(
    c(
    'game_id', 'year', 'full_date', 'date',
    'game_time', 'venue', 'city',
    'team1', 'team1score', 'team1_rk',
    'team2', 'team2score', 'team2_rk',
    'dominance_season_rk', 'tension_season_rk',
    'excitement_season_rk',
    'lead_changes_season_rk',
    'minimum_wp_season_rk', 'dominance_rk',
    'tension_rk', 'excitement_rk',
    'lead_changes_rk', 'minimum_wp_rk'),dplyr::everything()
  )
  kenpom <- list(wp_dataset, game_data, runs)

  return(kenpom)
}


