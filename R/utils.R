#' User Login Function
#' Requires a subscription to KenPom.com
#'
#' @param user_email User subscription e-mail
#' @param user_pw  User subscription password
#' @keywords Login
#' @import dplyr
#' @import tidyr
#' @import rvest
#' @import xml2
#' @import stringi
#' @export
#'

login <- function(user_email, user_pw){

  url <- "https://kenpom.com/index.php"
  #create a web session with the desired login address
  my_session <- html_session(url)
  login_form <- html_form(my_session)[[1]]
  #in this case the submit is the 2nd form
  filled_form <- set_values(login_form, email = user_email, password = user_pw)
  submit_form(my_session, filled_form)

  return(my_session)
}

#' Clean KenPom Data Frame Team Names to match NCAA Team Names for easier merging
#' @keywords Util
#' @param df KenPom dataframe
#' @import tidyr
#' @import dplyr
#' @import stringr
#' @import stringi
#' @importFrom rlang :=
#' @importFrom data.table "setDT"
#'
#' @export
#'
#'

clean_team_names_NCAA_merge <- function(df){
  setDT(df)

  ####Clean Team Names so that they can be merged to NCAA data
  # Replacing Southern with Southen Univ forces recorrecting TX Southern & Miss Southern
  df[,.data$TeamName:=gsub("\\.","",.data$Team)]
  df[,.data$TeamName:=gsub("Cal St","CS",.data$TeamName)]
  df[,.data$TeamName:=gsub("Albany","SUNY Albany",.data$TeamName)]
  df[,.data$TeamName:=gsub("Abilene Christian","Abilene Chr",.data$TeamName)]
  df[,.data$TeamName:=gsub("American","American Univ",.data$TeamName)]
  df[,.data$TeamName:=gsub("Arkansas Little Rock","Ark Little Rock",.data$TeamName)]
  df[,.data$TeamName:=gsub("Arkansas Pine Bluff","Ark Pine Bluff",.data$TeamName)]
  df[,.data$TeamName:=gsub("Boston University","Boston Univ",.data$TeamName)]
  df[,.data$TeamName:=gsub("Central Michigan","C Michigan",.data$TeamName)]
  df[,.data$TeamName:=gsub("Central Connecticut","Central Conn",.data$TeamName)]
  df[,.data$TeamName:=gsub("Coastal Carolina","Coastal Car",.data$TeamName)]
  df[,.data$TeamName:=gsub("East Carolina","E Kentucky",.data$TeamName)]
  df[,.data$TeamName:=gsub("Eastern Washington","E Washington",.data$TeamName)]
  df[,.data$TeamName:=gsub("East Tennessee St","ETSU",.data$TeamName)]
  df[,.data$TeamName:=gsub("Fairleigh Dickinson","F Dickinson",.data$TeamName)]
  df[,.data$TeamName:=gsub("Florida Atlantic","FL Atlantic",.data$TeamName)]
  df[,.data$TeamName:=gsub("Florida Gulf Coast","FL Gulf Coast",.data$TeamName)]
  df[,.data$TeamName:=gsub("George Washington","G Washington",.data$TeamName)]
  df[,.data$TeamName:=gsub("Illinois Chicago","IL Chicago",.data$TeamName)]
  df[,.data$TeamName:=gsub("Kent St","Kent",.data$TeamName)]
  df[,.data$TeamName:=gsub("Monmouth","Monmouth NJ",.data$TeamName)]
  df[,.data$TeamName:=gsub("Mississippi Valley St","MS Valley St",.data$TeamName)]
  df[,.data$TeamName:=gsub("Mount St Mary's","Mt St Mary's",.data$TeamName)]
  df[,.data$TeamName:=gsub("Montana St","MTSU",.data$TeamName)]
  df[,.data$TeamName:=gsub("Northern Colorado","N Colorado",.data$TeamName)]
  df[,.data$TeamName:=gsub("North Dakota St","N Dakota St",.data$TeamName)]
  df[,.data$TeamName:=gsub("Northern Kentucky","N Kentucky",.data$TeamName)]
  df[,.data$TeamName:=gsub("North Carolina A&T","NC A&T",.data$TeamName)]
  df[,.data$TeamName:=gsub("North Carolina Central","NC Central",.data$TeamName)]
  df[,.data$TeamName:=gsub("North Carolina St","NC State",.data$TeamName)]
  df[,.data$TeamName:=gsub("Northwestern St","Northwestern LA",.data$TeamName)]
  df[,.data$TeamName:=gsub("Prairie View A&M","Prairie View",.data$TeamName)]
  df[,.data$TeamName:=gsub("South Carolina St","S Carolina St",.data$TeamName)]
  df[,.data$TeamName:=gsub("South Dakota St","S Dakota St",.data$TeamName)]
  df[,.data$TeamName:=gsub("Southern Illinois","S Illinois",.data$TeamName)]
  df[,.data$TeamName:=gsub("Southeastern Louisiana","SE Louisiana",.data$TeamName)]
  df[,.data$TeamName:=gsub("Stephen F Austin","SF Austin",.data$TeamName)]
  df[,.data$TeamName:=gsub("Southern","Southern Univ",.data$TeamName)]
  df[,.data$TeamName:=gsub("Southern Univ Miss","Southern Miss",.data$TeamName)]
  df[,.data$TeamName:=gsub("Saint Joseph's","St Joseph's PA",.data$TeamName)]
  df[,.data$TeamName:=gsub("Saint Louis","St Louis",.data$TeamName)]
  df[,.data$TeamName:=gsub("Saint Mary's","St Mary's CA",.data$TeamName)]
  df[,.data$TeamName:=gsub("Saint Peter's","St Peter's",.data$TeamName)]
  df[,.data$TeamName:=gsub("Texas A&M Corpus Chris","TAM C. Christi",.data$TeamName)]
  df[,.data$TeamName:=gsub("Troy St","Troy",.data$TeamName)]
  df[,.data$TeamName:=gsub("Texas Southern Univ","TX Southern",.data$TeamName)]
  df[,.data$TeamName:=gsub("Louisiana Lafayette","Louisiana",.data$TeamName)]
  df[,.data$TeamName:=gsub("UTSA","UT San Antonio",.data$TeamName)]
  df[,.data$TeamName:=gsub("Western Michigan","W Michigan",.data$TeamName)]
  df[,.data$TeamName:=gsub("Green Bay","WI Green Bay",.data$TeamName)]
  df[,.data$TeamName:=gsub("Milwaukee","WI Milwaukee",.data$TeamName)]
  df[,.data$TeamName:=gsub("Western Kentucky","WKU",.data$TeamName)]
  df[,.data$TeamName:=gsub("College of Charleston","Col Charleston",.data$TeamName)]
  df[,.data$TeamName:=gsub("Loyola Chicago","Loyola-Chicago",.data$TeamName)]

  return(df)
}


#' Utilities and Helpers for package
#' @keywords Internal
#' @importFrom attempt "stop_if_not"
#' @importFrom curl "has_internet"
#'
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' Check Status function
#' @param res Response from API
#' @keywords Internal
#' @importFrom httr "status_code"
#'

check_status <- function(res){
  stop_if_not(.x = status_code(res),
              .p = ~ .x == 200,
              msg = "The API returned an error")
}

