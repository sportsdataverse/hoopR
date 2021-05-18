#' Get Game Box Score
#'
#' @param game_id Game id of game to pull
#' @param year Year of game to pull
#'
#' @keywords Game Box Score
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table
#' @importFrom xml2 read_html xml_remove xml_attrs
#' @importFrom dplyr select filter mutate arrange bind_rows mutate_at rename
#' @importFrom tidyr everything separate
#' @import stringr
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_box(game_id = 1238, year = 2020)
#' }

kp_box <- function(game_id, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()



  ### Pull Data
  assertthat::assert_that(year>=2013, msg="Data only goes back to 2013")
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
#' @importFrom rlang .data
#' @importFrom assertthat assert_that
#' @importFrom rvest session_jump_to html_elements html_table html_text
#' @importFrom xml2 read_html
#' @importFrom dplyr select filter mutate arrange bind_rows bind_cols rename
#' @importFrom tidyr everything
#' @importFrom stringr str_remove str_extract_all
#' @export
#'
#' @examples
#' \dontrun{
#'   kp_winprob(game_id = 1238, year = 2020)
#' }

kp_winprob <- function(game_id, year){
  if (!has_kp_user_and_pw()) stop("This function requires a KenPom subscription e-mail and password combination,\n      set as the system environment variables KP_USER and KP_PW.", "\n       See ?kp_user_pw for details.", call. = FALSE)
  browser <- login()
  assertthat::assert_that(year >= 2010, msg = "Data only goes back to 2010")
  url <- paste0("https://kenpom.com/winprob.php?",
                "g=", game_id,
                "&y=", year)

  page <- rvest::session_jump_to(browser, url)

  q <- (page %>%
          xml2::read_html() %>%
          rvest::html_elements("#content-header") %>%
          rvest::html_elements("script")) %>%
    rvest::html_text()

  r <-  stringr::str_remove(stringr::str_remove(q, "var dataset="),"\\n")
  #---- wp_dataset --------
  PD <- data.frame(pd = t(stringr::str_extract_all(r,pattern="\'Pd\':\\d",simplify=TRUE)))
  WP <- data.frame(wp = t(stringr::str_extract_all(r,pattern="\'WP\':\\d.\\d{0,4}+",simplify=TRUE)))
  TL <- data.frame(tl = t(stringr::str_extract_all(r,pattern="\'TL\':\\d{0,2}.\\d{0,4}+",simplify=TRUE)))
  VS <- data.frame(vs = t(stringr::str_extract_all(r,pattern="\'VS\':\\d{0,3}",simplify=TRUE)))
  HS <- data.frame(hs = t(stringr::str_extract_all(r,pattern="\'HS\':\\d{0,3}",simplify=TRUE)))
  VSc <- data.frame(vsc = t(stringr::str_extract_all(r,pattern="\'VSc\':\\d{0,1}",simplify=TRUE)))
  HSc <- data.frame(hsc = t(stringr::str_extract_all(r,pattern="\'HSc\':\\d{0,1}",simplify=TRUE)))
  P <- data.frame(p = t(stringr::str_extract_all(r,pattern="\'P\':\'(.{0,1})\',",simplify=TRUE)))
  PN <- data.frame(pn = t(stringr::str_extract_all(r,pattern="\'PN\':\'\\d{0,3}\'",simplify=TRUE)))
  PD <- PD %>% dplyr::mutate(pd = stringr::str_remove(.data$pd,"'Pd':"))
  WP <- WP %>% dplyr::mutate(wp = stringr::str_remove(.data$wp,"'WP':"))
  TL <- TL %>% dplyr::mutate(tl = stringr::str_remove(.data$tl,"'TL':"))
  VS <- VS %>% dplyr::mutate(vs = stringr::str_remove(.data$vs,"'VS':"))
  HS <- HS %>% dplyr::mutate(hs = stringr::str_remove(.data$hs,"'HS':"))
  VSc <- VSc %>% dplyr::mutate(vsc = stringr::str_remove(.data$vsc,"'VSc':"))
  HSc <- HSc %>% dplyr::mutate(hsc = stringr::str_remove(.data$hsc,"'HSc':"))
  P <- P %>% dplyr::mutate(p = as.character(stringr::str_remove(stringr::str_remove(.data$p,"'P':'"),"',")))
  PN <- PN %>% dplyr::mutate(pn = stringr::str_remove(stringr::str_remove(.data$pn,"'PN':'"),"'"))

  wp_dataset <- data.frame()
  wp_dataset <- dplyr::bind_cols(PD, WP, TL, VS, HS, VSc, HSc, P, PN)
  wp_dataset$GameId = game_id
  wp_dataset$Year = year
  wp_dataset <- wp_dataset %>%
    dplyr::rename(Period = .data$pd,
                  TimeLeft = .data$tl,
                  VisitorScore = .data$vs,
                  HomeScore = .data$hs,
                  VisitorScoring = .data$vsc,
                  HomeScoring = .data$hsc,
                  PossessionTeam = .data$p,
                  PossessionNumber = .data$pn) %>%
    janitor::clean_names()
  #---- game_data --------
  tm1 <- data.frame(tm1 = t(stringr::str_extract_all(r,pattern="team1:\'(.+)\'",simplify=TRUE)))
  tm2 <- data.frame(tm2 = t(stringr::str_extract_all(r,pattern="team2:\'(.+)\'",simplify=TRUE)))
  sc1 <- data.frame(sc1 = t(stringr::str_extract_all(r,pattern="score1:\\d{0,3}",simplify=TRUE)))
  sc2 <- data.frame(sc2 = t(stringr::str_extract_all(r,pattern="score2:\\d{0,3}",simplify=TRUE)))
  rk1 <- data.frame(rk1 = t(stringr::str_extract_all(r,pattern="rank1:\'(.+)\'",simplify=TRUE)))
  rk2 <- data.frame(rk2 = t(stringr::str_extract_all(r,pattern="rank2:\'(.+)\'",simplify=TRUE)))
  vn <- data.frame(vn = t(stringr::str_extract_all(r,pattern="venue:\'(.+)\'",simplify=TRUE)))
  cty <- data.frame(cty = t(stringr::str_extract_all(r,pattern="city:\'(.+)\'",simplify=TRUE)))
  gmtm <- data.frame(gmtm = t(stringr::str_extract_all(r,pattern="gameTime:\'(.+)\'", simplify=TRUE)))
  domin <- data.frame(domin = t(stringr::str_extract_all(r,pattern="dominance:\'(.+)\'", simplify=TRUE)))
  tns <- data.frame(tns = t(stringr::str_extract_all(r,pattern="tension:\'(.+)\'", simplify=TRUE)))
  exct <- data.frame(exct = t(stringr::str_extract_all(r,pattern="excitement:\'(.+)\'", simplify=TRUE)))
  favchg <- data.frame(favchg = t(stringr::str_extract_all(r,pattern="favchg:\'(.+)\'", simplify=TRUE)))
  minwp <- data.frame(minwp = t(stringr::str_extract_all(r,pattern="minWP:\'(.+)\'", simplify=TRUE)))
  rank_domin <- data.frame(rank_domin = t(stringr::str_extract_all(r,pattern="rank_dominance:\'(.+)\'", simplify=TRUE)[,1]))
  rank_tns <- data.frame(rank_tns = t(stringr::str_extract_all(r,pattern="rank_tension:\'(.+)\'", simplify=TRUE)[,1]))
  rank_exct <- data.frame(rank_exct = t(stringr::str_extract_all(r,pattern="rank_excitement:\'(.+)\'", simplify=TRUE)[,1]))
  rank_favchg <- data.frame(rank_favchg = t(stringr::str_extract_all(r,pattern="rank_favchg:\'(.+)\'", simplify=TRUE)[,1]))
  rank_minwp <- data.frame(rank_minwp = t(stringr::str_extract_all(r,pattern="rank_minWP:\'(.+)\'", simplify=TRUE)[,1]))
  srank_domin <- data.frame(srank_domin = t(stringr::str_extract_all(r,pattern="srank_dominance:\'(.+)\'", simplify=TRUE)))
  srank_tns <- data.frame(srank_tns = t(stringr::str_extract_all(r,pattern="srank_tension:\'(.+)\'", simplify=TRUE)))
  srank_exct <- data.frame(srank_exct = t(stringr::str_extract_all(r,pattern="srank_excitement:\'(.+)\'", simplify=TRUE)))
  srank_favchg <- data.frame(srank_favchg = t(stringr::str_extract_all(r,pattern="srank_favchg:\'(.+)\'", simplify=TRUE)))
  srank_minwp <- data.frame(srank_minwp = t(stringr::str_extract_all(r,pattern="srank_minWP:\'(.+)\'", simplify=TRUE)))
  gid <- data.frame(gid = t(stringr::str_extract_all(r,pattern="gid:\'(.+)\'", simplify=TRUE)))
  yr <- data.frame(yr = t(stringr::str_extract_all(r,pattern="year:\\d{0,4}",simplify=TRUE)))
  dateofgame <- data.frame(dateofgame = t(stringr::str_extract_all(r,pattern="dateOfGame:\'(.+)\'", simplify=TRUE)))
  ymd <- data.frame(ymd = t(stringr::str_extract_all(r,pattern="ymd:\'(.+)\'", simplify=TRUE)))

  tm1 <- tm1 %>% dplyr::mutate(tm1 = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$tm1,"team1:'"),","),"'"))
  tm2 <- tm2 %>% dplyr::mutate(tm2 = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$tm2,"team2:'"),","),"'"))
  sc1 <- sc1 %>% dplyr::mutate(sc1 = stringr::str_remove(stringr::str_remove(.data$sc1,"score1:"),","))
  sc2 <- sc2 %>% dplyr::mutate(sc2 = stringr::str_remove(stringr::str_remove(.data$sc2,"score2:"),","))
  rk1 <- rk1 %>% dplyr::mutate(rk1 = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rk1,"rank1:'"),","),"'"))
  rk2 <- rk2 %>% dplyr::mutate(rk2 = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rk2,"rank2:'"),","),"'"))
  vn <- vn %>% dplyr::mutate(vn = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$vn,"venue:'"),","),"'"))
  cty <- cty %>% dplyr::mutate(cty = stringr::str_remove(.data$cty,"city:'"),
                               cty = substr(.data$cty,1,nchar(.data$cty)-1))
  gmtm <- gmtm %>% dplyr::mutate(gmtm = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$gmtm,"gameTime:'"),","),"'"))
  domin <- domin %>% dplyr::mutate(domin = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$domin,"dominance:'"),","),"'"))
  tns <- tns %>% dplyr::mutate(tns = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$tns,"tension:'"),","),"'"))
  exct <- exct %>% dplyr::mutate(exct = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$exct,"excitement:'"),","),"'"))
  favchg <- favchg %>% dplyr::mutate(favchg = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$favchg,"favchg:'"),","),"'"))
  minwp <- minwp %>% dplyr::mutate(minwp = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$minwp,"minWP:'"),","),"'"))
  rank_domin <- rank_domin %>% dplyr::mutate(rank_domin = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rank_domin,"rank_dominance:'"),","),"'"))
  rank_tns <- rank_tns %>% dplyr::mutate(rank_tns = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rank_tns,"rank_tension:'"),","),"'"))
  rank_exct <- rank_exct %>% dplyr::mutate(rank_exct = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rank_exct,"rank_excitement:'"),","),"'"))
  rank_favchg <- rank_favchg %>% dplyr::mutate(rank_favchg = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rank_favchg,"rank_favchg:'"),","),"'"))
  rank_minwp <- rank_minwp %>% dplyr::mutate(rank_minwp = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$rank_minwp,"rank_minWP:'"),","),"'"))
  srank_domin <- srank_domin %>% dplyr::mutate(srank_domin = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$srank_domin,"srank_dominance:'"),","),"'"))
  srank_tns <- srank_tns %>% dplyr::mutate(srank_tns = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$srank_tns,"srank_tension:'"),","),"'"))
  srank_exct <- srank_exct %>% dplyr::mutate(srank_exct = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$srank_exct,"srank_excitement:'"),","),"'"))
  srank_favchg <- srank_favchg %>% dplyr::mutate(srank_favchg = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$srank_favchg,"srank_favchg:'"),","),"'"))
  srank_minwp <- srank_minwp %>% dplyr::mutate(srank_minwp = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$srank_minwp,"srank_minWP:'"),","),"'"))
  gid <- gid %>% dplyr::mutate(gid = stringr::str_remove(stringr::str_remove(stringr::str_remove(.data$gid,"gid:'"),","),"'"))
  yr <- yr %>% dplyr::mutate(yr = stringr::str_remove(stringr::str_remove(.data$yr,"year:"),","))
  dateofgame <- dateofgame %>% dplyr::mutate(dateofgame = stringr::str_remove(stringr::str_remove(.data$dateofgame,"dateOfGame:'"),"'"))
  ymd <- ymd %>% dplyr::mutate(ymd = stringr::str_remove(stringr::str_remove(.data$ymd,"ymd:'"),"'"))



  game_data <- data.frame()
  game_data <- dplyr::bind_cols(gid, yr, dateofgame, ymd, gmtm, vn, cty, tm1,sc1, rk1, tm2, sc2, rk2,
                                srank_domin, srank_tns, srank_exct, srank_favchg, srank_minwp,
                                rank_domin, rank_tns, rank_exct, rank_favchg, rank_minwp)

  game_data <- game_data %>%
    dplyr::rename(GameId = .data$gid,
                  Year = .data$yr,
                  Full.Date = .data$dateofgame,
                  Date = .data$ymd,
                  GameTime = .data$gmtm,
                  Venue = .data$vn,
                  City = .data$cty,
                  Team1.Rk = .data$rk1,
                  Team1 = .data$tm1,
                  Team1Score = .data$sc1,
                  Team2.Rk = .data$rk2,
                  Team2 = .data$tm2,
                  Team2Score = .data$sc2,
                  Dominance.Season.Rk = .data$srank_domin,
                  Tension.Season.Rk = .data$srank_tns,
                  Excitement.Season.Rk = .data$srank_exct,
                  LeadChanges.Season.Rk  = .data$srank_favchg,
                  MinimumWP.Season.Rk = .data$srank_minwp,
                  Dominance.Rk = .data$rank_domin,
                  Tension.Rk = .data$rank_tns,
                  Excitement.Rk = .data$rank_exct,
                  LeadChanges.Rk  = .data$rank_favchg,
                  MinimumWP.Rk = .data$rank_minwp) %>%
    janitor::clean_names()
  kenpom <- list(wp_dataset, game_data)

  return(kenpom)
}


