# Build hoopR::teams_links: one row per KenPom team-season, with the team and
# conference page links.
#
# Run from the repo root with a KenPom subscription in KP_USER / KP_PW:
#   Rscript data-raw/pull_team_links.R            # add the seasons the table is missing
#   Rscript data-raw/pull_team_links.R 2002 2027  # rebuild that range of seasons
#
# Seasons are END years (2027 = 2026-27). Existing rows for the scraped seasons are
# replaced; every other season is kept as it is, so a refresh does not re-scrape
# 25 years of pages.

suppressPackageStartupMessages({
  library(dplyr)
  library(rvest)
})
pkgload::load_all(".", quiet = TRUE)

args <- as.integer(commandArgs(trailingOnly = TRUE))
existing <- teams_links
years <- if (length(args) == 2) {
  seq(args[1], args[2])
} else {
  setdiff(2002:most_recent_mbb_season(), unique(existing$Year))
}
if (!length(years)) {
  message("teams_links already covers 2002-", most_recent_mbb_season())
  quit(save = "no")
}

# One season's ratings table: each row links the team (team.php?team=...) and its
# conference (conf.php?c=...).
scrape_year <- function(jar, year) {
  page <- .kp_get_page(jar, paste0("https://kenpom.com/index.php?y=", year))
  links <- rvest::html_elements(page, "table > tbody > tr > td > a")
  href <- sub("&y=.*$", "", rvest::html_attr(links, "href"))
  text <- rvest::html_text(links)
  team <- grepl("^team\\.php", href)
  conf <- grepl("^conf\\.php", href)
  stopifnot(sum(team) == sum(conf), sum(team) > 300)
  data.frame(
    Team = text[team],
    Team.link = href[team],
    team.link.ref = sub("^team\\.php\\?team=", "", href[team]),
    Conf = text[conf],
    Conf.link = href[conf],
    conf.link.ref = sub("^conf\\.php\\?c=", "", href[conf]),
    Year = as.integer(year),
    stringsAsFactors = FALSE
  ) |>
    dplyr::arrange(.data$Team)
}

jar <- login()
scraped <- lapply(years, function(year) {
  out <- scrape_year(jar, year)
  message(year, ": ", nrow(out), " teams")
  Sys.sleep(5)
  out
})

teams_links <- existing |>
  dplyr::filter(!.data$Year %in% years) |>
  dplyr::bind_rows(scraped) |>
  dplyr::distinct() |>
  dplyr::arrange(dplyr::desc(.data$Year), .data$Team)
stopifnot(!anyDuplicated(teams_links[c("Team", "Year")]))

write.csv(teams_links, sprintf("data-raw/kp_team_info_%d.csv", max(teams_links$Year)), row.names = FALSE)
usethis::use_data(teams_links, overwrite = TRUE, compress = "xz")
