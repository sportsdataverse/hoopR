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
#' @description Requires a subscription to KenPom.com.
#'   Uses httr2 for HTTP requests and cookie management.
#'
#' @param user_email User subscription e-mail
#' @param user_pw  User subscription password
#' @keywords Login
#' @importFrom httr2 request req_headers req_cookie_preserve req_body_form req_perform resp_body_html resp_status
#' @export
login <- function(user_email = Sys.getenv("KP_USER"), user_pw = Sys.getenv("KP_PW")) {
  jar <- tempfile(fileext = ".txt")

  # GET the login page to establish session cookies
  resp <- .kp_request("https://kenpom.com/index.php", jar) |>
    httr2::req_perform()

  # Parse the login form to find the action URL
  page_html <- httr2::resp_body_html(resp)
  form_node <- xml2::xml_find_first(page_html, "//form[.//input[@name='email']]")
  action <- xml2::xml_attr(form_node, "action")
  if (is.na(action) || !nzchar(action)) action <- "handlers/login_handler.php"
  if (!grepl("^https?://", action)) {
    action <- paste0("https://kenpom.com/", sub("^/", "", action))
  }

  # POST login credentials
  .kp_request(action, jar) |>
    httr2::req_body_form(email = user_email, password = user_pw, submit = "Login") |>
    httr2::req_perform()

  return(jar)
}

#' Fetch a KenPom page as parsed HTML using an authenticated cookie jar
#' @param jar Path to the httr2 cookie jar file (returned by \code{login()})
#' @param url The KenPom URL to fetch
#' @return A parsed HTML document (xml_document)
#' @keywords internal
.kp_get_page <- function(jar, url) {
  resp <- .kp_request(url, jar) |>
    httr2::req_perform()
  httr2::resp_body_html(resp)
}

#' Build an httr2 request with KenPom headers and cookie jar
#' @param url The URL to request
#' @param jar Path to the httr2 cookie jar file
#' @return An httr2 request object
#' @keywords internal
.kp_request <- function(url, jar) {
  httr2::request(url) |>
    httr2::req_headers(!!!.kp_headers_list()) |>
    httr2::req_cookie_preserve(jar)
}
#' @rdname kp_user_pw
#' @export
kp_user_email <- function() {
  kp_user <- Sys.getenv("KP_USER")

  if (kp_user == "") {
    return(NA_character_)
  } else {
    return(kp_user)
  }
}
#' @rdname kp_user_pw
#' @export
kp_password <- function() {
  kp_pw <- Sys.getenv("KP_PW")

  if (kp_pw == "") {
    return(NA_character_)
  } else {
    return(kp_pw)
  }
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
progressively <- function(f, p = NULL) {
  if (!is.null(p) && !inherits(p, "progressor")) stop("`p` must be a progressor function!")
  if (is.null(p)) p <- function(...) NULL
  force(f)

  function(...) {
    on.exit(p("loading..."))
    f(...)
  }
}


.datatable.aware <- TRUE

#' @title
#' **Load .csv / .csv.gz file from a remote connection**
#' @description
#' This is a thin wrapper on data.table::fread
#' @param ... passed to data.table::fread
#' @inheritDotParams data.table::fread
#' @importFrom data.table fread
#' @return a dataframe as created by [`data.table::fread()`]
#' @export
csv_from_url <- function(...) {
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

# The function `message_completed` to create the green "...completed" message
# only exists to hide the option `in_builder` in dots
message_completed <- function(x, in_builder = FALSE) {
  if (isFALSE(in_builder)) {
    str <- paste0(my_time(), " | ", x)
    cli::cli_alert_success("{{.field {str}}}")
  } else if (in_builder) {
    cli::cli_alert_success("{my_time()} | {x}")
  }
}

user_message <- function(x, type) {
  if (type == "done") {
    cli::cli_alert_success("{my_time()} | {x}")
  } else if (type == "todo") {
    cli::cli_ul("{my_time()} | {x}")
  } else if (type == "info") {
    cli::cli_alert_info("{my_time()} | {x}")
  } else if (type == "oops") {
    cli::cli_alert_danger("{my_time()} | {x}")
  }
}

# check if a package is installed
is_installed <- function(pkg) requireNamespace(pkg, quietly = TRUE)

# custom mode function from https://stackoverflow.com/questions/2547402/is-there-a-built-in-function-for-finding-the-mode/8189441
custom_mode <- function(x, na.rm = TRUE) {
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  ux <- unique(x)
  return(ux[which.max(tabulate(match(x, ux)))])
}

my_time <- function() strftime(Sys.time(), format = "%H:%M:%S")

rule_header <- function(x) {
  rlang::inform(
    cli::rule(
      left = ifelse(is_installed("crayon"), crayon::bold(x), glue::glue("\033[1m{x}\033[22m")),
      right = paste0("hoopR version ", utils::packageVersion("hoopR")),
      width = getOption("width")
    )
  )
}

rule_footer <- function(x) {
  rlang::inform(
    cli::rule(
      left = ifelse(is_installed("crayon"), crayon::bold(x), glue::glue("\033[1m{x}\033[22m")),
      width = getOption("width")
    )
  )
}

#' @title
#' **Most Recent Men's College Basketball Season**
#' @export
most_recent_mbb_season <- function() {
  ifelse(
    as.double(substr(Sys.Date(), 6, 7)) >= 10,
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
    TRUE ~ as.character(next_year)
  )
  return(glue::glue("{year}-{next_year}"))
}

#' **Clean KenPom Data Frame Team Names to match NCAA Team Names for easier merging**
#' @keywords Util
#' @param df KenPom dataframe
#' @importFrom rlang := .data %||%
#' @importFrom data.table setDT
#'
clean_team_names_NCAA_merge <- function(df) {
  data.table::setDT(df)
  #### Clean Team Names so that they can be merged to NCAA data
  # Replacing Southern with Southen Univ forces recorrecting TX Southern & Miss Southern
  df[, .data$TeamName := gsub("\\.", "", .data$Team)]
  df[, .data$TeamName := gsub("Cal St", "CS", .data$TeamName)]
  df[, .data$TeamName := gsub("Albany", "SUNY Albany", .data$TeamName)]
  df[, .data$TeamName := gsub("Abilene Christian", "Abilene Chr", .data$TeamName)]
  df[, .data$TeamName := gsub("American", "American Univ", .data$TeamName)]
  df[, .data$TeamName := gsub("Arkansas Little Rock", "Ark Little Rock", .data$TeamName)]
  df[, .data$TeamName := gsub("Arkansas Pine Bluff", "Ark Pine Bluff", .data$TeamName)]
  df[, .data$TeamName := gsub("Boston University", "Boston Univ", .data$TeamName)]
  df[, .data$TeamName := gsub("Central Michigan", "C Michigan", .data$TeamName)]
  df[, .data$TeamName := gsub("Central Connecticut", "Central Conn", .data$TeamName)]
  df[, .data$TeamName := gsub("Coastal Carolina", "Coastal Car", .data$TeamName)]
  df[, .data$TeamName := gsub("East Carolina", "E Kentucky", .data$TeamName)]
  df[, .data$TeamName := gsub("Eastern Washington", "E Washington", .data$TeamName)]
  df[, .data$TeamName := gsub("East Tennessee St", "ETSU", .data$TeamName)]
  df[, .data$TeamName := gsub("Fairleigh Dickinson", "F Dickinson", .data$TeamName)]
  df[, .data$TeamName := gsub("Florida Atlantic", "FL Atlantic", .data$TeamName)]
  df[, .data$TeamName := gsub("Florida Gulf Coast", "FL Gulf Coast", .data$TeamName)]
  df[, .data$TeamName := gsub("George Washington", "G Washington", .data$TeamName)]
  df[, .data$TeamName := gsub("Illinois Chicago", "IL Chicago", .data$TeamName)]
  df[, .data$TeamName := gsub("Kent St", "Kent", .data$TeamName)]
  df[, .data$TeamName := gsub("Monmouth", "Monmouth NJ", .data$TeamName)]
  df[, .data$TeamName := gsub("Mississippi Valley St", "MS Valley St", .data$TeamName)]
  df[, .data$TeamName := gsub("Mount St Mary's", "Mt St Mary's", .data$TeamName)]
  df[, .data$TeamName := gsub("Montana St", "MTSU", .data$TeamName)]
  df[, .data$TeamName := gsub("Northern Colorado", "N Colorado", .data$TeamName)]
  df[, .data$TeamName := gsub("North Dakota St", "N Dakota St", .data$TeamName)]
  df[, .data$TeamName := gsub("Northern Kentucky", "N Kentucky", .data$TeamName)]
  df[, .data$TeamName := gsub("North Carolina A&T", "NC A&T", .data$TeamName)]
  df[, .data$TeamName := gsub("North Carolina Central", "NC Central", .data$TeamName)]
  df[, .data$TeamName := gsub("North Carolina St", "NC State", .data$TeamName)]
  df[, .data$TeamName := gsub("Northwestern St", "Northwestern LA", .data$TeamName)]
  df[, .data$TeamName := gsub("Prairie View A&M", "Prairie View", .data$TeamName)]
  df[, .data$TeamName := gsub("South Carolina St", "S Carolina St", .data$TeamName)]
  df[, .data$TeamName := gsub("South Dakota St", "S Dakota St", .data$TeamName)]
  df[, .data$TeamName := gsub("Southern Illinois", "S Illinois", .data$TeamName)]
  df[, .data$TeamName := gsub("Southeastern Louisiana", "SE Louisiana", .data$TeamName)]
  df[, .data$TeamName := gsub("Stephen F Austin", "SF Austin", .data$TeamName)]
  df[, .data$TeamName := gsub("Southern", "Southern Univ", .data$TeamName)]
  df[, .data$TeamName := gsub("Southern Univ Miss", "Southern Miss", .data$TeamName)]
  df[, .data$TeamName := gsub("Saint Joseph's", "St Joseph's PA", .data$TeamName)]
  df[, .data$TeamName := gsub("Saint Louis", "St Louis", .data$TeamName)]
  df[, .data$TeamName := gsub("Saint Mary's", "St Mary's CA", .data$TeamName)]
  df[, .data$TeamName := gsub("Saint Peter's", "St Peter's", .data$TeamName)]
  df[, .data$TeamName := gsub("Texas A&M Corpus Chris", "TAM C. Christi", .data$TeamName)]
  df[, .data$TeamName := gsub("Troy St", "Troy", .data$TeamName)]
  df[, .data$TeamName := gsub("Texas Southern Univ", "TX Southern", .data$TeamName)]
  df[, .data$TeamName := gsub("Louisiana Lafayette", "Louisiana", .data$TeamName)]
  df[, .data$TeamName := gsub("UTSA", "UT San Antonio", .data$TeamName)]
  df[, .data$TeamName := gsub("Western Michigan", "W Michigan", .data$TeamName)]
  df[, .data$TeamName := gsub("Green Bay", "WI Green Bay", .data$TeamName)]
  df[, .data$TeamName := gsub("Milwaukee", "WI Milwaukee", .data$TeamName)]
  df[, .data$TeamName := gsub("Western Kentucky", "WKU", .data$TeamName)]
  df[, .data$TeamName := gsub("College of Charleston", "Col Charleston", .data$TeamName)]
  df[, .data$TeamName := gsub("Loyola Chicago", "Loyola-Chicago", .data$TeamName)]

  return(df)
}


#' **Check Status function**
#' @param res Response from API (httr2 response object)
#' @keywords Internal
#'
check_status <- function(res) {
  x <- httr2::resp_status(res)

  if (x != 200) {
    stop("The API returned an error", call. = FALSE)
  }
}

#' Perform an HTTP GET request with retry logic
#'
#' Thin wrapper around httr2 that replaces httr::RETRY("GET", ...).
#' Supports optional query parameters and custom headers.
#' @param url The URL to request
#' @param params Named list of query parameters (default: empty list)
#' @param headers Named character vector of headers (default: NULL)
#' @param timeout Timeout in seconds (default: 60)
#' @return An httr2 response object
#' @keywords internal
.retry_request <- function(url, params = list(), headers = NULL, timeout = 60) {
  req <- httr2::request(url)
  if (length(params) > 0) {
    req <- req |> httr2::req_url_query(!!!params)
  }
  if (!is.null(headers)) {
    req <- req |> httr2::req_headers(!!!as.list(headers))
  }
  req |>
    httr2::req_timeout(timeout) |>
    httr2::req_retry(max_tries = 3) |>
    httr2::req_perform()
}

#' Extract response body as text
#'
#' Replaces the httr::content(as = "text", encoding = "UTF-8") pattern.
#' @param resp An httr2 response object
#' @return Character string of response body
#' @keywords internal
.resp_text <- function(resp) {
  httr2::resp_body_string(resp, encoding = "UTF-8")
}

#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' @import utils
utils::globalVariables(c("where"))

# check if a package is installed
is_installed <- function(pkg) requireNamespace(pkg, quietly = TRUE)



#' @keywords internal
"_PACKAGE"

#' @importFrom Rcpp getRcppVersion
#' @importFrom RcppParallel defaultNumThreads
NULL

`%c%` <- function(x, y) {
  ifelse(!is.na(x), x, y)
}



# Functions for custom class
# turn a data.frame into a tibble/hoopR_data
make_hoopR_data <- function(df, type, timestamp) {
  out <- df

  class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.table", "data.frame")
  attr(out, "hoopR_timestamp") <- timestamp
  attr(out, "hoopR_type") <- type
  return(out)
}

#' @export
#' @noRd
print.hoopR_data <- function(x, ...) {
  cli::cli_rule(left = "{attr(x,'hoopR_type')}", right = "{.emph hoopR {utils::packageVersion('hoopR')}}")

  if (!is.null(attr(x, "hoopR_timestamp"))) {
    cli::cli_alert_info(
      "Data updated: {.field {format(attr(x,'hoopR_timestamp'), tz = Sys.timezone(), usetz = TRUE)}}"
    )
  }

  NextMethod(print, x)
  invisible(x)
}



# rbindlist but maintain attributes of last file
rbindlist_with_attrs <- function(dflist) {
  hoopR_timestamp <- attr(dflist[[length(dflist)]], "hoopR_timestamp")
  hoopR_type <- attr(dflist[[length(dflist)]], "hoopR_type")
  out <- data.table::rbindlist(dflist, use.names = TRUE, fill = TRUE)
  attr(out, "hoopR_timestamp") <- hoopR_timestamp
  attr(out, "hoopR_type") <- hoopR_type
  # class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  out
}
