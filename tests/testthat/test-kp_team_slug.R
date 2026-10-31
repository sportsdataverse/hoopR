# Offline: the KenPom team functions build the team page slug from the name, so
# a season that teams_links does not list yet (the current one) still gets a URL.

test_that(".kp_team_slug() reproduces every teams_links slug", {
  tl <- hoopR::teams_links
  slugs <- vapply(tl$Team, hoopR:::.kp_team_slug, character(1), USE.NAMES = FALSE)
  expect_identical(slugs, tl$team.link.ref)
  expect_identical(hoopR:::.kp_team_slug("Texas A&M"), "Texas+A%26M")
})

test_that("KenPom team pages are requested for a season past teams_links", {
  next_year <- max(hoopR::teams_links$Year) + 1L
  urls <- character()
  local_mocked_bindings(
    has_kp_user_and_pw = function() TRUE,
    login = function(...) "jar",
    .kp_get_page = function(jar, url) {
      urls <<- c(urls, url)
      stop("offline test: no request is made")
    }
  )
  suppressMessages(kp_team_schedule(team = "Saint Mary's", year = next_year))
  suppressMessages(kp_team_history(team = "Saint Mary's"))
  expect_identical(urls, c(
    paste0("https://kenpom.com/team.php?team=Saint+Mary%27s&y=", next_year),
    "https://kenpom.com/history.php?t=Saint+Mary%27s"
  ))
})
