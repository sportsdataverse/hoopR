library(dplyr)
library(rvest)
library(stringi)
library(tidyr)
library(data.table)
#
# browser<-login('saiem.gilani@gmail.com','Actuary2018')
# get_kpoy(browser,year=2020)[[2]]

#' Get KPoY Leaders Tables
#'
#' @param year Year of data to pull (earliest year of data available: 2011)
#' @param browser User_login session
#'
#' @importFrom assertthat "assert_that"
#' @import RCurl
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import stringi
#' @return
#' @export
#'
#' @examples
#'
#' get_kpoy(browser, year)
#'
#'
get_kpoy <- function(browser, year){

  assert_that(year >= 2011, msg="Data only goes back to 2011")

  cat("Getting", year)
  year<- 2020
  ### Pull Data
  url <- paste0("https://kenpom.com/kpoy.php?",
                "y=", year)

  page <- jump_to(browser, url)


  y <- list()
  for(i in 1:2){

    groups <- c("kPoY Rating", "Game MVP Leaders")

    x <- page %>%
      read_html() %>%
      html_nodes("table") %>%
      .[[i]] %>%
      html_table(fill=TRUE) %>%
      as.data.frame()

    if(i == 1){
      header_cols <- c("Rk","Player","kpoyRating")}
    else{
      header_cols <- c("Rk","Player","GameMVPs")
    }


    colnames(x) <- header_cols

    x <- x %>%
      tidyr::separate(Player,
                      into = c("Player","col"),
                      sep = ",",
                      extra = "merge")

    x <- x %>%
      mutate(
        Team = stringr::str_extract(
          stringr::str_extract(col,'[^\\d-\\d{1,}]+'),".+"),
        Hgt = stringr::str_extract(
          stringi::stri_extract_first_regex(col, '[^,]+'),"\\d{1,}-\\d{1,}+"),
        Wgt =
          stringr::str_extract(col,'\\d{3}'),
        Exp = stringr::str_extract(col, "Fr|So|Jr|Sr|r-Fr|r-So|r-Jr|r-Sr"),
        HomeTown = stringr::str_extract(
          stringi::stri_extract_last_regex(col, '[^·]+'),".*")
      )

    x <- mutate(x,
                "Year" = year,
                "group" = groups[i])
    x <- x %>%
      select(-col)
    if(i == 2) {
      replace_na_with_last<-function(x,p=is.na,d=0){c(d,x)[cummax(seq_along(x)*(!p(x)))+1]}
      x$Rk <- replace_na_with_last(x$Rk)
    }
    y <- c(y,list(x))
  }
  ### Store Data

  kenpom <- y

  return(kenpom)
}


browser <- login("saiem.gilani@gmail.com","Actuary2018")

is.session(browser)
df <- get_kp_eff_and_tempo(browser, min_year = 2020, max_year = 2020)




browser <- login("saiem.gilani@gmail.com","Actuary2018")


df <- get_kp_four_factors(browser, min_year = 2020, max_year = 2020)




