#' @title
#' **KenPom Login and Password credentials**
#' @description Save your KenPom login e-mail and password as the system environment variables `KP_USER` and `KP_PW`
#' @details
#' **Using your KenPom subscription with the package:** \cr
#'
#' Run [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html) and THEN paste the following in the new script that pops up (with**out** quotations)\cr
#' ```r
#' KP_USER = YOUR-EMAIL@DOMAIN.COM
#' KP_PW = XXX-YOUR-PASSWORD-XXX
#' ```
#' You can save the login information for consistent usage by adding \cr
#' ```
#' KP_USER = YOUR-EMAIL@DOMAIN.COM
#' KP_PW = XXX-YOUR-PASSWORD-XXX
#' ``` \cr
#' to your .REnviron file (easily accessed via [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html)).\cr
#' \cr
#'
#' For less consistent usage:\cr
#' At the beginning of every session or within an R environment, save your login e-mail and password as the environment variables `KP_USER` and `KP_PW` (with quotations) using a command like the following.\cr
#' ```{r}
#' Sys.setenv(KP_USER = "YOUR-EMAIL@DOMAIN.COM")
#' Sys.setenv(KP_PW = "XXX-YOUR-PASSWORD-XXX")
#' ```
#' @name kp_user_pw
NULL
#' @rdname kp_user_pw
#' @title **User Login Function**
#' @description Requires a subscription to KenPom.com
#'
#' @param user_email User subscription e-mail
#' @param user_pw  User subscription password
#' @keywords Login
#' @importFrom rvest html_session html_form set_values submit_form
#' @export
login <- function(user_email = Sys.getenv("KP_USER"), user_pw = Sys.getenv("KP_PW")){

  url <- "https://kenpom.com/index.php"
  #create a web session with the desired login address
  my_session <- rvest::session(url,
                               httr::add_headers(.headers = .kp_headers()))
  login_form <- rvest::html_form(my_session)[[1]]
  #in this case the submit is the 2nd form
  filled_form <- rvest::html_form_set(login_form, email = user_email, password = user_pw)
  rvest::session_submit(my_session, filled_form)

  return(my_session)
}
#' @rdname kp_user_pw
#' @export
kp_user_email <- function() {
  Sys.getenv("KP_USER", unset = NA_character_)
}
#' @rdname kp_user_pw
#' @export
kp_password <- function() {
  Sys.getenv("KP_PW", unset = NA_character_)
}

#' @rdname kp_user_pw
#' @export
has_kp_user_and_pw <- function() !is.na(kp_user_email()) && !is.na(kp_password())


#' **Progressively**
#'
#' This function helps add progress-reporting to any function - given function `f()` and progressor `p()`, it will return a new function that calls `f()` and then (on-exiting) will call `p()` after every iteration.
#'
#' This is inspired by purrr's `safely`, `quietly`, and `possibly` function decorators.
#'
#' @param f a function to add progressr functionality to.
#' @param p a progressor function as created by `progressr::progressor()`
#'
#' @return a function that does the same as `f` but it calls `p()` after iteration.
#'
#' @export
progressively <- function(f, p = NULL){
  # no longer using progressr. Using cli progress bars
  if(!is.null(p) && !inherits(p, "progressor")) stop("`p` must be a progressor function!")
  if(is.null(p)) p <- function(...) NULL
  force(f)

  function(...){
    on.exit(p("loading..."))
    f(...)
  }

}


.datatable.aware <- TRUE

#' @title
#' **Load .csv / .csv.gz file from a remote connection**
#' @description
#' This is a thin wrapper around [data.table::fread()]
#' @inheritDotParams data.table::fread -yaml
#' @importFrom data.table fread
#' @return a dataframe as created by [data.table::fread()]
#' @export
csv_from_url <- function(...){
  data.table::fread(...)
}



#' @title
#' **Load .rds file from a remote connection**
#' @param url a character url
#' @return a dataframe as created by [`readRDS()`]
#' @importFrom data.table data.table setDT
#' @import rvest
rds_from_url <- function(url) {
  con <- url(url)
  on.exit(close(con))
  load <- try(readRDS(con), silent = TRUE)

  if (inherits(load, "try-error")) {
    warning(paste0("Failed to readRDS from <", url, ">"), call. = FALSE)
    return(data.table::data.table())
  }

  data.table::setDT(load)
  return(load)
}

# Identify sessions with sequential future resolving
is_sequential <- function() inherits(future::plan(), "sequential")
# custom mode function from https://stackoverflow.com/questions/2547402/is-there-a-built-in-function-for-finding-the-mode/8189441
custom_mode <- function(x, na.rm = TRUE) {
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  ux <- unique(x)
  return(ux[which.max(tabulate(match(x, ux)))])
}

#' @title
#' **Most Recent Men's College Basketball Season**
#' @export
most_recent_mbb_season <- function() {
  ifelse(
    as.double(substr(Sys.Date(), 6, 7)) > 10,
    as.double(substr(Sys.Date(), 1, 4)) + 1,
    as.double(substr(Sys.Date(), 1, 4))
  )
}

#' @title
#' **Most Recent NBA Season**
#' @export
most_recent_nba_season <- function() {
  ifelse(
    as.double(substr(Sys.Date(), 6, 7)) >= 10,
    as.double(substr(Sys.Date(), 1, 4)) + 1,
    as.double(substr(Sys.Date(), 1, 4))
  )
}

#' @title **year to season (XXXX -> XXXX-YY)**
#' @param year Four digit year (XXXX)
#' @importFrom dplyr mutate filter select left_join
#' @importFrom stringr str_detect
#' @importFrom tidyr everything
#' @export
year_to_season <- function(year) {
  first_year <- substr(year, 3, 4)
  next_year <- as.numeric(first_year) + 1
  next_year <- dplyr::case_when(
    next_year < 10 & first_year > 0 ~ glue::glue("0{next_year}"),
    first_year == 99 ~ "00",
    TRUE ~ as.character(next_year))
  return(glue::glue("{year}-{next_year}"))
}

#' **Clean KenPom Data Frame Team Names to match NCAA Team Names for easier merging**
#' @keywords Util
#' @param df KenPom dataframe
#' @importFrom rlang := .data
#' @importFrom data.table setDT
#'
clean_team_names_NCAA_merge <- function(df){
  data.table::setDT(df)
  #### Clean Team Names so that they can be merged to NCAA data
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


# length 1
# adds time
# resembles usethis::ui_todo
hoop_todo <- function(x, .envir = parent.frame()) {
  x <- paste0(my_time(), " | ", x)
  names(x) = "*"
  cli::cli_bullets(x, .envir = .envir)
}
# similar to usethis::ui_info
hoop_info <- function(x, .envir = parent.frame()) {
  x <- paste0(my_time(), " | ", x)
  names(x) <- "i"
  cli::cli_bullets(x, .envir = .envir)
}

my_time <- function() strftime(Sys.time(), format = "%H:%M:%S")

#' **Check Status function**
#' @param res Response from API
#' @keywords Internal
#' @import rvest
#' @noRd
check_status <- function(res) {

  x = httr::status_code(res)

  if (x != 200) {
    stop("The API returned an error", call. = FALSE)
  }

}

#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' @keywords internal
"_PACKAGE"

#' @importFrom Rcpp getRcppVersion
#' @importFrom RcppParallel defaultNumThreads
NULL

`%c%` <- function(x, y){
  ifelse(!is.na(x), x, y)
}



# Functions for custom class
# turn a data.frame into a tibble/hoopR_data
make_hoopR_data <- function(df, type, timestamp){
  out <- df

  class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  attr(out,"hoopR_timestamp") <- timestamp
  attr(out,"hoopR_type") <- type
  return(out)
}

#' @export
#' @noRd
print.hoopR_data <- function(x,...) {
  cli::cli_rule(left = "{attr(x,'hoopR_type')}", right = "{.emph hoopR {utils::packageVersion('hoopR')}}")

  if (!is.null(attr(x, 'hoopR_timestamp'))) {
    cli::cli_alert_info(
      "Data updated: {.field {format(attr(x,'hoopR_timestamp'), tz = Sys.timezone(), usetz = TRUE)}}"
    )
  }

  NextMethod(print,x)
  invisible(x)
}



# rbindlist but maintain attributes of last file
rbindlist_with_attrs <- function(dflist){

  hoopR_timestamp <- attr(dflist[[length(dflist)]], "hoopR_timestamp")
  hoopR_type <- attr(dflist[[length(dflist)]], "hoopR_type")
  out <- data.table::rbindlist(dflist, use.names = TRUE, fill = TRUE)
  attr(out,"hoopR_timestamp") <- hoopR_timestamp
  attr(out,"hoopR_type") <- hoopR_type
  # class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  out
}

