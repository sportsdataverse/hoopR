# httr2::req_url_query() percent-encodes every query value, so a wrapper that
# swaps spaces for "+" first sends a literal plus ("All%2BPlayers"), which
# stats.nba.com answers with HTTP 400. Values go to the request as they are.

test_that("spaces in stats.nba.com query values are sent as %20, never as an encoded '+'", {
  skip_on_cran()
  urls <- character()
  httr2::local_mocked_responses(function(req) {
    urls <<- c(urls, req$url)
    httr2::response(status_code = 400L, url = req$url)
  })
  suppressMessages({
    nba_defensehub(league_id = "00", season = "2024-25", player_scope = "All Players")
    nba_boxscoresimilarityscore(person_1_id = "202691", person_1_season = 2023,
                                person_2_id = "1626164", person_2_season = 2023)
    nba_glalumboxscoresimilarityscore(
      person_1_id = "202681", person_1_league_id = "00", person_1_season = 2019,
      person_1_season_type = "Regular Season", person_2_id = "203078",
      person_2_league_id = "00", person_2_season = 2019, person_2_season_type = "Regular Season"
    )
  })
  expect_length(urls, 3)
  expect_false(any(grepl("%2B", urls, fixed = TRUE)))
  expect_match(urls[[1]], "PlayerScope=All%20Players&", fixed = TRUE)
  expect_match(urls[[1]], "SeasonType=Regular%20Season", fixed = TRUE)
  for (u in urls[2:3]) {
    expect_match(u, "Person1SeasonType=Regular%20Season&", fixed = TRUE)
    expect_match(u, "Person2SeasonType=Regular%20Season", fixed = TRUE)
  }
})

# stats.nba.com answered the three requests above with HTTP 500 (defensehub,
# glalumboxscoresimilarityscore) and 400 (boxscoresimilarityscore) on
# 2026-11-24 once the queries were encoded correctly, so there is no recorded
# 200 to replay. These parse the endpoints' documented result-set shapes.
test_that("nba_defensehub() and the similarity-score wrappers parse a result-set 200", {
  skip_on_cran()
  body <- '{"resource":"x","parameters":{},
    "resultSets":[{"name":"%s","headers":["PERSON_2_ID","PERSON_2","TEAM_ID","SIMILARITY_SCORE"],
    "rowSet":[[203078,"Bradley Beal",1610612764,0.91],[1626164,"Devin Booker",1610612756,0.88]]}]}'
  httr2::local_mocked_responses(function(req) {
    nm <- if (grepl("defensehub", req$url, fixed = TRUE)) "DefenseHubStat1" else "SimilarityScores"
    httr2::response(status_code = 200L, url = req$url,
                    headers = list(`Content-Type` = "application/json"),
                    body = charToRaw(sprintf(body, nm)))
  })
  hub <- nba_defensehub(league_id = "00", season = "2024-25")
  expect_named(hub, "DefenseHubStat1")
  expect_equal(nrow(hub$DefenseHubStat1), 2L)
  gl <- nba_glalumboxscoresimilarityscore(
    person_1_id = "202681", person_1_league_id = "00", person_1_season = 2019,
    person_1_season_type = "Regular Season", person_2_id = "203078",
    person_2_league_id = "00", person_2_season = 2019, person_2_season_type = "Regular Season"
  )
  expect_named(gl, "SimilarityScores")
  expect_equal(gl$SimilarityScores$PERSON_2, c("Bradley Beal", "Devin Booker"))
})
