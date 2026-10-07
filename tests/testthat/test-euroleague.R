# Offline tests for the euroleague_*() family: every fixture is parsed through
# the same parser the live path uses (the HTTP layer `.retry_request()` is
# mocked), and the frame is held to sdv-py's columns / rows / values on the
# same bytes (fixtures/euroleague/README.md).

efx <- testthat::test_path("fixtures", "euroleague")
egold <- jsonlite::fromJSON(file.path(efx, "columns.json"), simplifyVector = FALSE)

# Mock the HTTP layer: answer every request with `status` + the fixture bytes
# (or `body`), recording the url / params / headers the wrapper sent.
local_euroleague_response <- function(file = NULL, status = 200L, body = NULL, env = parent.frame()) {
  seen <- new.env()
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      seen$url <- url
      seen$params <- params
      seen$headers <- headers
      seen$calls <- (if (is.null(seen$calls)) 0L else seen$calls) + 1L
      raw <- if (!is.null(file)) {
        readBin(file.path(efx, file), "raw", n = file.size(file.path(efx, file)))
      } else {
        charToRaw(if (is.null(body)) "" else body)
      }
      httr2::response(
        status_code = status, url = url,
        headers = list(`Content-Type` = "application/json"), body = raw
      )
    },
    .env = env
  )
  seen
}

# The call that reproduces each golden route on its fixture.
euro_calls <- list(
  competitions = quote(euroleague_competitions()),
  seasons = quote(euroleague_seasons("E")),
  rounds = quote(euroleague_rounds("E", "E2025")),
  clubs = quote(euroleague_clubs("E", "E2025")),
  people = quote(euroleague_people("E", "E2025")),
  games = quote(euroleague_games("E", "E2025")),
  game_stats = quote(euroleague_game_stats("E", "E2025", 1)),
  game_report = quote(euroleague_game_report("E", "E2025", 1)),
  standings__basicstandings = quote(euroleague_standings("E", "E2025", 1)),
  standings__calendarstandings = quote(euroleague_standings("E", "E2025", 1, kind = "calendarstandings")),
  standings__streaks = quote(euroleague_standings("E", "E2025", 1, kind = "streaks")),
  standings__aheadbehind = quote(euroleague_standings("E", "E2025", 1, kind = "aheadbehind")),
  player_stats__traditional = quote(euroleague_player_stats("E", season_code = "E2025", limit = 3)),
  player_stats__advanced = quote(euroleague_player_stats("E", mode = "advanced", season_code = "E2025", limit = 3)),
  team_stats__traditional = quote(euroleague_team_stats("E", season_code = "E2025", limit = 3)),
  team_stats__advanced = quote(euroleague_team_stats("E", mode = "advanced", season_code = "E2025", limit = 3)),
  game_points = quote(euroleague_game_points(1, "E2025")),
  game_points__U2025 = quote(euroleague_game_points(1, "U2025")),
  game_pbp = quote(euroleague_game_pbp(1, "E2025")),
  game_pbp__U2025 = quote(euroleague_game_pbp(1, "U2025")),
  game_boxscore = quote(euroleague_game_boxscore(1, "E2025")),
  game_header = quote(euroleague_game_header(1, "E2025"))
)

# Strict cell parity against the sdv-py golden CSV (polars write_csv, null -> "NA"):
# every column is compared with the class sdv-py gave it -- logical / integer /
# numeric read back as that class, character compared verbatim (NA is NA, "" is
# ""). The one documented difference, JSON-encoded list cells (Python's ", " / ": "
# separators and unicode escapes), is compared by parsing both sides, never by
# editing the strings.
.expect_euro_gold <- function(got, key) {
  gold <- utils::read.csv(file.path(efx, paste0("gold__", key, ".csv")), colClasses = "character",
                          na.strings = "NA", check.names = FALSE, encoding = "UTF-8")
  expect_identical(names(got), names(gold))
  expect_equal(nrow(got), nrow(gold))
  for (col in names(gold)) {
    g <- got[[col]]
    e <- gold[[col]]
    if (is.logical(g)) {
      expect_identical(g, as.logical(e), info = paste(key, col))
    } else if (is.integer(g)) {
      expect_identical(g, as.integer(e), info = paste(key, col))
    } else if (is.numeric(g)) {
      expect_identical(g, as.numeric(e), info = paste(key, col))
    } else {
      json <- !is.na(g) & grepl("^[\\[{]", g)
      expect_identical(g[!json], e[!json], info = paste(key, col))
      for (i in which(json)) {
        expect_identical(jsonlite::parse_json(g[i]), jsonlite::parse_json(e[i]), info = paste(key, col, "row", i))
      }
    }
  }
}

for (key in names(egold)) {
  test_that(paste0("euroleague_* parity with sdv-py on the fixture: ", key), {
    g <- egold[[key]]
    local_euroleague_response(g$fixture)
    df <- eval(euro_calls[[key]])
    expect_s3_class(df, "hoopR_data")
    expect_identical(names(df), unlist(g$columns))
    expect_equal(nrow(df), g$nrow)
    # per-column class parity: sdv-py Utf8 -> character, Int64 -> integer, Float64 -> numeric, Boolean -> logical
    expect_identical(unname(vapply(df, function(v) class(v)[1], character(1))), unlist(g$types))
    .expect_euro_gold(df, key)
  })
}

test_that("api-live gets Accept: application/json; the live API gets no Accept header", {
  seen <- local_euroleague_response("clubs.json")
  euroleague_clubs("E", "E2025")
  expect_equal(seen$url, "https://api-live.euroleague.net/v2/competitions/E/seasons/E2025/clubs")
  expect_equal(seen$headers[["Accept"]], "application/json")

  seen <- local_euroleague_response("standings__streaks.json")
  euroleague_standings("E", "E2025", 1, kind = "streaks")
  expect_equal(seen$url, "https://api-live.euroleague.net/v3/competitions/E/seasons/E2025/rounds/1/streaks")
  expect_equal(seen$headers[["Accept"]], "application/json")

  seen <- local_euroleague_response("game_points.json")
  euroleague_game_points(1, "E2025")
  expect_equal(seen$url, "https://live.euroleague.net/api/Points")
  expect_null(seen$headers)
  expect_equal(seen$params, list(gamecode = 1, seasoncode = "E2025"))
})

test_that("query params use the API's keys and NULL paging is dropped", {
  seen <- local_euroleague_response("player_stats__advanced.json")
  euroleague_player_stats("E", mode = "advanced", season_code = "E2025")
  expect_equal(seen$url, "https://api-live.euroleague.net/v3/competitions/E/statistics/players/advanced")
  expect_equal(seen$params, list(SeasonMode = "Single", SeasonCode = "E2025", statisticMode = "PerGame"))

  seen <- local_euroleague_response("games.json")
  euroleague_games("E", "E2025", limit = 10, offset = 20)
  expect_equal(seen$params, list(limit = 10, offset = 20))
  seen <- local_euroleague_response("games.json")
  euroleague_games("E", "E2025")
  expect_length(seen$params, 0L)
})

test_that("an invalid kind / mode errors before any request", {
  seen <- local_euroleague_response(body = "{}")
  expect_error(euroleague_standings("E", "E2025", 1, kind = "marginsstandings"), "must be one of")
  expect_error(euroleague_player_stats("E", mode = "basic"), "must be one of")
  expect_error(euroleague_team_stats("E", mode = "basic"), "must be one of")
  # exact matching, as in sdv-py: a prefix is not a value
  expect_error(euroleague_standings("E", "E2025", 1, kind = "basic"), "must be one of")
  expect_error(euroleague_standings("E", "E2025", 1, kind = "calendar"), "must be one of")
  expect_error(euroleague_player_stats("E", mode = "trad"), "must be one of")
  expect_null(seen$calls)
})

test_that("the live API's empty 200 body is a zero-row tibble with the documented columns", {
  for (key in c("game_points", "game_pbp", "game_boxscore", "game_header")) {
    local_euroleague_response(body = "")
    df <- eval(euro_calls[[key]])
    expect_s3_class(df, "hoopR_data")
    expect_equal(nrow(df), 0L)
    expect_identical(names(df), unlist(egold[[key]]$columns))
    expect_identical(unname(vapply(df, function(v) class(v)[1], character(1))), unlist(egold[[key]]$types))
  }
})

test_that("HTTP statuses map to the classed error vocabulary", {
  local_euroleague_response(body = "", status = 404L)
  expect_error(euroleague_clubs("E", "E9999"), class = "hoopR_no_data")
  expect_error(euroleague_game_points(1, "E2025"), class = "hoopR_no_data")
  local_euroleague_response(body = "", status = 400L)
  expect_error(euroleague_clubs("E", "E2025"), class = "hoopR_invalid_request")
  local_euroleague_response(body = "", status = 422L)
  expect_error(euroleague_games("E", "E2025"), class = "hoopR_invalid_request")
  local_euroleague_response(body = "", status = 500L)
  expect_error(euroleague_rounds("E", "E2025"), class = "hoopR_fetch_error")
  local_euroleague_response(body = "", status = 403L)
  expect_error(euroleague_game_header(1, "E2025"), class = "hoopR_fetch_error")
  # every class inherits hoopR_error
  local_euroleague_response(body = "", status = 404L)
  expect_error(euroleague_seasons("E"), class = "hoopR_error")
})

test_that("a non-JSON or empty api-live 200 body is a fetch error (XML without the Accept header)", {
  local_euroleague_response(body = "<?xml version=\"1.0\"?><competitions/>")
  expect_error(euroleague_competitions(), class = "hoopR_fetch_error")
  local_euroleague_response(body = "")
  expect_error(euroleague_competitions(), class = "hoopR_fetch_error")
})

test_that("a transport error is a fetch error", {
  local_mocked_bindings(.retry_request = function(...) stop("Could not resolve host"))
  expect_error(euroleague_competitions(), class = "hoopR_fetch_error")
})

test_that("all-null api-live columns are character, not logical", {
  local_euroleague_response("seasons.json")
  seasons <- euroleague_seasons("E")
  expect_type(seasons$winner, "character")
  local_euroleague_response("games.json")
  games <- euroleague_games("E", "E2025")
  expect_type(games$referee4, "character")
  expect_type(games$venue_images_medium, "character")
  local_euroleague_response("people.json")
  expect_type(euroleague_people("E", "E2025")$position_name, "character")
})

test_that("a parsed box score and the empty-200 frame agree on every column class", {
  local_euroleague_response("game_boxscore.json")
  box <- euroleague_game_boxscore(1, "E2025")
  expect_type(box$plusminus, "integer")
  expect_identical(unname(vapply(box, function(v) class(v)[1], character(1))),
                   unname(.euroleague_live_schemas$game_boxscore))
})

test_that("ids and codes are character join keys, never a float suffix", {
  local_euroleague_response("games.json")
  games <- euroleague_games("E", "E2025")
  expect_type(games$game_code, "character")
  expect_identical(games$game_code[1], "406")
  expect_identical(.euroleague_pin_character(data.frame(x_id = c(406, NA, 12345678901)), "_id$")$x_id,
                   c("406", NA, "12345678901"))
  expect_type(games$local_club_code, "character")
  expect_type(games$played, "logical")
  expect_type(games$round, "integer")
})

test_that("live API strings are stripped of their space padding", {
  local_euroleague_response("game_points.json")
  shots <- euroleague_game_points(1, "E2025")
  expect_identical(shots$team[1], "IST")
  expect_identical(shots$id_player[1], "P014102")
  expect_type(shots$coord_x, "integer")
  local_euroleague_response("game_header.json")
  header <- euroleague_game_header(1, "E2025")
  expect_identical(header$hour, "19:45")
  expect_identical(header$im_a, "IST")
})

test_that("play-by-play unrolls the quarters in game order with the header repeated", {
  local_euroleague_response("game_pbp.json")
  pbp <- euroleague_game_pbp(1, "E2025")
  expect_identical(pbp$quarter, rep(1:4, each = 3L))
  expect_identical(unique(pbp$code_team_a), "IST")
  expect_identical(unique(pbp$code_team_b), "TEL")
  expect_type(pbp$points_a, "integer")
})

test_that("box score rows are players then the team and totals rows per side", {
  local_euroleague_response("game_boxscore.json")
  box <- euroleague_game_boxscore(1, "E2025")
  expect_identical(box$row_type, rep(c("player", "player", "player", "team", "total"), 2L))
  expect_identical(unique(box$attendance), "2110")
  expect_identical(box$by_quarter_q1[1], 21L)
  expect_identical(box$end_of_quarter_q4[box$row_type == "total"], c(85L, 78L))
  expect_type(box$is_starter, "integer")
})

test_that("the parsers never raise on a malformed body", {
  for (raw in list(NULL, list(), list(total = 0L, data = list()), "x", list(Rows = list()))) {
    expect_equal(nrow(.euroleague_frame(raw)), 0L)
    expect_equal(nrow(.euroleague_points(raw)), 0L)
    expect_equal(nrow(.euroleague_pbp(raw)), 0L)
    expect_equal(nrow(.euroleague_boxscore(raw)), 0L)
    expect_equal(nrow(.euroleague_header(raw)), 0L)
  }
})
