#' **Get men's college basketball NET rankings for the current date from the NCAA website**
#'
#' @author Saiem Gilani
#' @return Returns a tibble
#' @importFrom dplyr as_tibble
#' @import rvest
#' @export
#' @examples
#' # Get current NCAA NET rankings
#' \donttest{
#'   try(ncaa_mbb_NET_rankings())
#' }

ncaa_mbb_NET_rankings <- function(){


  NET_url <- "https://www.ncaa.com/rankings/basketball-men/d1/ncaa-mens-basketball-net-rankings"
  x <- (NET_url %>%
          xml2::read_html() %>%
          rvest::html_elements("table"))[[1]] %>%
    rvest::html_table() %>%
    dplyr::as_tibble() %>%
    dplyr::rename(
      Quad_1 = .data$`Quad 1`,
      Quad_2 = .data$`Quad 2`,
      Quad_3 = .data$`Quad 3`,
      Quad_4 = .data$`Quad 4`
    ) %>%
    janitor::clean_names() %>%
    make_hoopR_data("NCAA MBB NET Rankings Information from ESPN.com",Sys.time())

  return(x)
}

