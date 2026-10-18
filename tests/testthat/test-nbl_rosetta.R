# NBL Rosetta (nbl_rosetta_*): offline tests on the sdv-py fixtures (provenance in
# fixtures/nbl_rosetta/README.md). The transport is mocked at .intl_perform(), so the
# request the wrapper builds (URL, query, gate headers) is asserted too.

skip_if_no_intl_fixtures("nbl_rosetta")

nbl_fx <- function(...) testthat::test_path("fixtures", "nbl_rosetta", ...)
nbl_text <- function(file) paste(readLines(nbl_fx(file), encoding = "UTF-8", warn = FALSE), collapse = "\n")
nbl_parity <- jsonlite::read_json(nbl_fx("parity", "parity.json"))

# A fake transport: every request answers `status` / `text`; the requests land in `log$reqs`.
nbl_transport <- function(text, status = 200L, env = parent.frame()) {
  log <- new.env()
  log$reqs <- list()
  log$retry_500 <- list()
  testthat::local_mocked_bindings(
    .intl_perform = function(req, retry_500 = FALSE, ...) {
      log$reqs[[length(log$reqs) + 1]] <- req
      log$retry_500[[length(log$retry_500) + 1]] <- retry_500
      httr2::response(
        status_code = status, url = req$url,
        headers = list(`Content-Type` = "application/json"), body = charToRaw(enc2utf8(text))
      )
    },
    .env = env
  )
  log
}

# expect_error() on a cli message, whitespace-insensitive (cli wraps long lines)
nbl_expect_refusal <- function(expr, pattern, class) {
  err <- tryCatch(expr, error = identity)
  testthat::expect_s3_class(err, class)
  testthat::expect_match(gsub("\\s+", " ", conditionMessage(err)), pattern)
}

nbl_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

# The R tibble against sdv-py's frame on the same fixture: names in order, dtypes, every cell.
nbl_expect_parity <- function(df, key) {
  meta <- nbl_parity[[key]]
  want_types <- unlist(meta$dtypes)
  testthat::expect_identical(names(df), names(want_types), label = paste(key, "column names"))
  r_type <- vapply(df, function(x) {
    if (is.character(x)) "s" else if (is.logical(x)) "b" else if (is.integer(x)) "i" else "f"
  }, character(1))
  testthat::expect_identical(r_type, want_types, label = paste(key, "dtypes"))
  want <- intl_read_oracle(nbl_fx("parity", paste0(key, ".csv")))
  testthat::expect_identical(nrow(df), nrow(want), label = paste(key, "rows"))
  bad <- character()
  for (col in intersect(names(df), names(want))) {
    got <- df[[col]]
    exp <- want[[col]]
    exp_v <- switch(want_types[[col]],
      s = exp,
      i = as.numeric(exp),
      f = as.numeric(exp),
      b = exp == "true"
    )
    na_diff <- is.na(got) != is.na(exp)
    both <- !is.na(got) & !is.na(exp)
    val_diff <- if (want_types[[col]] == "f") {
      abs(got[both] - exp_v[both]) > 1e-9 * pmax(1, abs(exp_v[both]))
    } else {
      got[both] != exp_v[both]
    }
    n <- sum(na_diff) + sum(val_diff)
    if (n) bad <- c(bad, paste0(col, " (", n, ")"))
  }
  testthat::expect_identical(bad, character(), label = paste(key, "cell mismatches"))
}

test_that("every wrapper matches the sdv-py frame on every fixture (parity)", {
  for (key in names(nbl_parity)) {
    meta <- nbl_parity[[key]]
    short <- strsplit(key, "--", fixed = TRUE)[[1]][[1]]
    log <- nbl_transport(nbl_text(meta$fixture))
    df <- do.call(paste0("nbl_rosetta_", short), meta$args)
    expect_s3_class(df, "hoopR_data")
    nbl_expect_parity(df, key)
    # the request is the one sdv-py sends: same path, same query, the gate headers, HTTP 500 retried
    req <- log$reqs[[1]]
    url <- httr2::url_parse(req$url)
    want <- httr2::url_parse(meta$url)
    expect_identical(url$path, want$path, label = paste(key, "path"))
    got_q <- unlist(url$query %||% list())
    want_q <- unlist(lapply(meta$params, as.character))
    expect_identical(got_q[sort(names(got_q))], want_q[sort(names(want_q))], label = paste(key, "query"))
    expect_identical(req$headers$Origin, "https://www.nbl.com.au")
    expect_identical(req$headers$Referer, "https://www.nbl.com.au/")
    expect_true(isTRUE(log$retry_500[[1]]))
  }
})

test_that("ids are character and never a float-origin '123.0'", {
  for (key in names(nbl_parity)) {
    meta <- nbl_parity[[key]]
    short <- strsplit(key, "--", fixed = TRUE)[[1]][[1]]
    nbl_transport(nbl_text(meta$fixture))
    df <- do.call(paste0("nbl_rosetta_", short), meta$args)
    ids <- setdiff(grep("(^id$|_id$)", names(df), value = TRUE), "action_id")
    for (col in ids) {
      expect_type(df[[col]], "character")
      expect_false(any(grepl("^[0-9]+\\.0$", df[[col]])), label = paste(key, col))
    }
    expect_true(all(grepl("^[a-z0-9]+(_[a-z0-9]+)*$", names(df))), label = paste(key, "snake_case"))
    expect_false(any(grepl("blurhash|logo|colou?r|social|ticket|broadcaster|betting|odds|image|override",
                           names(df))), label = paste(key, "dropped fields"))
  }
})

test_that("an empty or malformed body parses to a typed zero-row tibble with the documented columns", {
  type_of <- c(s = "character", i = "integer", f = "double", b = "logical")
  for (short in names(.NBL_ROSETTA_COLUMNS)) {
    schema <- .NBL_ROSETTA_DTYPES[[.NBL_ROSETTA_PARSER[[short]]]]
    cols <- .NBL_ROSETTA_COLUMNS[[short]]
    for (empty in list(list(), NULL, "x", 3, list(data = list()), list(data = NULL), list(data = "oops"))) {
      df <- .nbl_rosetta_parse(empty, short)
      expect_identical(nrow(df), 0L)
      expect_identical(names(df), cols)
      expect_identical(unname(vapply(df, typeof, character(1))), unname(type_of[schema[cols]]),
                       label = paste(short, "types"))
    }
  }
  # a results-only match (1979) has a box score but no play-by-play: zero rows, documented columns
  nbl_transport(nbl_text("live--nbl_1979.json"))
  pbp <- nbl_rosetta_match_pbp(match_id = "07fb189f-4110-11f0-8257-c9f5f3143ea9")
  expect_identical(nrow(pbp), 0L)
  expect_identical(names(pbp), .NBL_ROSETTA_COLUMNS$match_pbp)
})

test_that("the season END year maps to Rosetta's year in the URL", {
  cases <- list(
    list("nbl", 2026, 2025), list("wnbl", 2026, 2025), list("nbl1", 2025, 2025), list("nbl", 1997, 1997),
    list("nbl", 1998, 1998), list("nbl", 1999, 1998), list("nbl", 2000, 1999)
  )
  for (cs in cases) {
    body <- list(type = "matches", data = list(list(
      id = "m", external_id = "m",
      season = list(year = as.character(cs[[3]]), competition = list(league = list(organisation = list(shortcode = cs[[1]]))))
    )))
    log <- nbl_transport(nbl_json(body))
    df <- nbl_rosetta_matches(season = cs[[2]], org = cs[[1]], season_type = "regular")
    expect_identical(httr2::url_parse(log$reqs[[1]]$url)$path,
                     sprintf("/get/%s/matches/in/season/%d/regular", cs[[1]], cs[[3]]))
  }
  log <- nbl_transport(nbl_text("next_match--nbl_2026.json"))
  nbl_rosetta_next_match(season = 2027)
  nbl_rosetta_next_match_team(team_code = "PER", season = 2027)
  expect_identical(httr2::url_parse(log$reqs[[1]]$url)$path, "/get/next/match/for/nbl/2026")
  expect_identical(httr2::url_parse(log$reqs[[2]]$url)$path, "/get/next/match/for/team/PER/nbl/2026")
})

test_that("start_year and end_year are inverse and split year 1998", {
  expect_identical(.nbl_rosetta_start_year("nbl", 2026), 2025)
  expect_identical(.nbl_rosetta_start_year("nbl1", 2025), 2025)
  expect_identical(.nbl_rosetta_start_year("wnbl", 1997), 1997)
  expect_identical(.nbl_rosetta_start_year("nbl", 1998), .nbl_rosetta_start_year("nbl", 1999))
  expect_identical(.nbl_rosetta_end_year("nbl", 1998, "1998-01-30T00:00:00"), 1998)
  expect_identical(.nbl_rosetta_end_year("wnbl", 1998, "1998-10-09"), 1999)
  expect_null(.nbl_rosetta_end_year("nbl", 1998, NULL))
  expect_identical(.nbl_rosetta_end_year("nbl1", 2025), 2025)
  for (org in c("nbl", "wnbl")) {
    for (end in c(1980:1997, 2000:2027)) {
      expect_equal(.nbl_rosetta_end_year(org, .nbl_rosetta_start_year(org, end)), end)
    }
  }
  # year 1998 holds two seasons: the matches frame keeps the one asked for
  body <- list(type = "matches", data = list(
    list(id = "a", external_id = "a", start_time = "1998-02-01T00:00:00",
         season = list(year = "1998", competition = list(league = list(organisation = list(shortcode = "nbl"))))),
    list(id = "b", external_id = "b", start_time = "1998-11-01T00:00:00",
         season = list(year = "1998", competition = list(league = list(organisation = list(shortcode = "nbl")))))
  ))
  nbl_transport(nbl_json(body))
  expect_identical(nbl_rosetta_matches(season = 1999)$match_id, "b")
  expect_identical(nbl_rosetta_matches(season = 1998)$match_id, "a")
})

test_that("list routes get a large limit the caller can override", {
  log <- nbl_transport(nbl_text("teams--nbl.json"))
  nbl_rosetta_teams()
  nbl_rosetta_teams(limit = 3)
  expect_identical(httr2::url_parse(log$reqs[[1]]$url)$query, list(limit = "5000"))
  expect_identical(httr2::url_parse(log$reqs[[2]]$url)$query, list(limit = "3"))
})

test_that("the gate body is never data", {
  gate <- '{"error": "Access Denied", "code": "MISSING_API_KEY", "timestamp": "t", "request_id": "r"}'
  nbl_transport(gate, status = 403L)
  expect_error(nbl_rosetta_seasons(), class = "hoopR_asset_fetch")
  nbl_transport(gate)
  nbl_expect_refusal(nbl_rosetta_seasons(), "MISSING_API_KEY", "hoopR_asset_fetch")
})

test_that("a stub or non-envelope is a failed fetch, not nothing-here", {
  for (stub in c("[]", "", '{"hello": "x"}', '{"type": "seasons"}', '{"type": "seasons", "data": 3}')) {
    nbl_transport(stub)
    err <- tryCatch(nbl_rosetta_seasons(), error = identity)
    expect_s3_class(err, "hoopR_asset_fetch")
    expect_false(inherits(err, "hoopR_no_data"))
  }
})

test_that("empty data and a 404 are nothing-here; a 500 is a failed fetch", {
  nbl_transport('{"type": "matches", "count": 1, "data": []}')
  expect_error(nbl_rosetta_match(match_id = "00000000-0000-0000-0000-000000000000"), class = "hoopR_no_data")
  nbl_transport("{}", status = 404L)
  expect_error(nbl_rosetta_seasons(), class = "hoopR_no_data")
  nbl_transport('{"message": "boom"}', status = 500L)
  err <- tryCatch(nbl_rosetta_teams(), error = identity)
  expect_s3_class(err, "hoopR_asset_fetch")
  expect_true(err$transient)
})

test_that("org, season_type, season and ids are checked before sending", {
  log <- nbl_transport(nbl_text("teams--nbl.json"))
  expect_error(nbl_rosetta_teams(org = "nba"), "org must be", class = "hoopR_bad_request")
  expect_error(nbl_rosetta_matches(season = 2026, season_type = "bogus"), "season_type must be",
               class = "hoopR_bad_request")
  expect_error(nbl_rosetta_matches(season = "2026"), class = "hoopR_bad_request")
  expect_error(nbl_rosetta_match(match_id = "a/b"), class = "hoopR_bad_request")
  expect_length(log$reqs, 0)
})

nbl_with <- function(body, ...) {
  edits <- list(...)
  for (i in seq_along(body$data)) {
    for (dotted in names(edits)) {
      path <- strsplit(dotted, "__", fixed = TRUE)[[1]]
      body$data[[i]][[path]] <- edits[[dotted]]
    }
  }
  body
}

test_that("a body for another scope is refused, not emptied", {
  sc <- "season__competition__league__organisation__shortcode"
  m <- "b217a699-4bef-11f0-bc08-933162362355"
  cases <- list(
    list(function() nbl_rosetta_seasons(), "seasons--nbl.json",
         list(competition__league__organisation__shortcode = "wnbl")),
    list(function() nbl_rosetta_matches(season = 2026), "matches--nbl_2025.json", list(season__year = "2024")),
    list(function() nbl_rosetta_matches(season = 2026), "matches--nbl_2025.json", stats::setNames(list("nbl1"), sc)),
    list(function() nbl_rosetta_standings(season = 2026), "standings--nbl_2025.json", list(season__year = "2024")),
    list(function() nbl_rosetta_match(match_id = m), "live--nbl_2025.json",
         list(id = "11111111-1111-1111-1111-111111111111")),
    list(function() nbl_rosetta_match_by_id(match_id = m), "match_by_id--nbl_2025.json",
         list(id = "11111111-1111-1111-1111-111111111111")),
    list(function() nbl_rosetta_team_players(team_id = "befee10a-410c-11f0-b3f4-1b3c55488bbb", season = 2026),
         "team_players--nbl_2025.json",
         list(team__external_id = "11111111-1111-1111-1111-111111111111", team__id = "x")),
    list(function() nbl_rosetta_player_game_log(player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f", season = 2026),
         "player_game_log--nbl_2025.json",
         list(player__external_id = "11111111-1111-1111-1111-111111111111", player__id = "x")),
    list(function() nbl_rosetta_player_stats(player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f"),
         "player_stats--nbl.json",
         list(player__external_id = "11111111-1111-1111-1111-111111111111", player__id = "x")),
    list(function() nbl_rosetta_stats_leaders(season_id = "9a761374-41a9-11f0-a689-c94a032ca4e8"),
         "stats_leaders--nbl_2025.json", list(season__id = "x", season__external_id = "y")),
    list(function() nbl_rosetta_team_stats_leaders(season_id = "9a761374-41a9-11f0-a689-c94a032ca4e8",
                                                   team_code = "PER"),
         "team_stats_leaders--nbl_2025.json", list(team__team_code = "SYD")),
    list(function() nbl_rosetta_team_stats(season = 2026), "team_stats--nbl_2025.json", list(season__year = "2024")),
    list(function() nbl_rosetta_next_match(season = 2027), "next_match--nbl_2026.json", list(season__year = "2025"))
  )
  for (cs in cases) {
    good <- jsonlite::parse_json(nbl_text(cs[[2]]))
    nbl_transport(nbl_json(good))
    expect_gt(nrow(cs[[1]]()), 0)
    nbl_transport(nbl_json(do.call(nbl_with, c(list(good), cs[[3]]))))
    nbl_expect_refusal(cs[[1]](), "out of scope", "hoopR_asset_fetch")
  }
  # a row without the scope field is refused too
  body <- jsonlite::parse_json(nbl_text("standings--nbl_2025.json"))
  body$data[[1]]$season$year <- NULL
  nbl_transport(nbl_json(body))
  nbl_expect_refusal(nbl_rosetta_standings(season = 2026), "out of scope", "hoopR_asset_fetch")
  # either id space proves the scope
  body <- jsonlite::parse_json(nbl_text("team_players--nbl_2025.json"))
  nbl_transport(nbl_json(body))
  expect_gt(nrow(nbl_rosetta_team_players(team_id = body$data[[1]]$team$id, season = 2026)), 0)
})

test_that("a page cut by the path cache is refused unless the caller set the limit", {
  row <- jsonlite::parse_json(nbl_text("matches--nbl_2025.json"))$data[[1]]
  page <- function(n) nbl_json(list(type = "matches", ttlRemaining = 30, data = rep(list(row), n)))
  for (n in c(100, 2000, 500)) {
    nbl_transport(page(n))
    nbl_expect_refusal(nbl_rosetta_matches(season = 2026), "cut by a cached request", "hoopR_asset_fetch")
  }
  nbl_transport(page(100))
  expect_identical(nrow(nbl_rosetta_matches(season = 2026, limit = 100)), 100L)
  nbl_transport(page(179))
  expect_identical(nrow(nbl_rosetta_matches(season = 2026)), 179L)
})

test_that("the match page parses the way sdv-py documents it", {
  m <- "b217a699-4bef-11f0-bc08-933162362355"
  nbl_transport(nbl_text("live_full--nbl_2025.json"))
  pbp <- nbl_rosetta_match_pbp(match_id = m)
  header <- nbl_rosetta_match(match_id = m)
  box <- nbl_rosetta_match_player_box(match_id = m)
  team <- nbl_rosetta_match_team_box(match_id = m)
  expect_identical(nrow(pbp), 96L)
  expect_identical(unique(pbp$feed), "datacore")
  expect_false(is.unsorted(pbp$action_id))
  expect_identical(unique(pbp$sub_type_key[pbp$sub_type %in% "Jump Shot"]), "jump_shot")
  expect_identical(header$home_score, 76L)
  expect_identical(header$season_end_year, 2026L)
  expect_identical(unique(pbp$team_id[pbp$is_home %in% TRUE]), header$home_team_id)
  expect_equal(box$minutes[box$player_id %in% "7619d3ea-410d-11f0-9235-2902fc2f936f"], 30 + 32 / 60)
  expect_identical(sum(box$points), 76L + 77L)
  expect_identical(sort(unique(team$period)), 0:4)
  expect_identical(.nbl_sub_type_key("Driving Layup"), "driving_layup")
  expect_identical(.nbl_sub_type_key("drivingLayup"), "driving_layup")
  expect_identical(.nbl_seconds("09:57"), 597)
  expect_identical(.nbl_seconds("00:00:02"), 2)
  expect_null(.nbl_seconds("x"))
  expect_null(.nbl_seconds(TRUE))
})

test_that("live: NBL Rosetta seasons and a match page", {
  skip_intl_live()
  seasons <- nbl_rosetta_seasons(org = "nbl")
  expect_true(all(.NBL_ROSETTA_COLUMNS$seasons %in% names(seasons)))
  expect_gt(nrow(seasons), 10)
  pbp <- nbl_rosetta_match_pbp(match_id = "b217a699-4bef-11f0-bc08-933162362355")
  expect_true(all(.NBL_ROSETTA_COLUMNS$match_pbp %in% names(pbp)))
  expect_gt(nrow(pbp), 100)
})
