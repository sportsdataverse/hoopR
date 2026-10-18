# Offline tests of the KBL family: R/kbl.R, R/kbl_runtime.R, R/kbl_parsers.R, R/kbl_tables.R. Every request is
# mocked through httr2, so the headers, the season mapping, the final-game proof, the scope checks, the retries
# and the error vocabulary run end to end; the throttle is recorded, never slept. Parity:
# tests/testthat/fixtures/kbl/parity/<case>.csv is sdv-py's frame of the same wrapper on the same fixture (see
# fixtures/kbl/README.md).

withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

kbl_fixture <- function(...) test_path("fixtures", "kbl", ...)
kbl_text <- function(rel) paste(readLines(kbl_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
kbl_body <- function(rel) jsonlite::parse_json(kbl_text(rel), simplifyVector = FALSE)
kbl_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

kbl_resp <- function(body, status = 200L, headers = list()) {
  text <- if (is.character(body)) body else kbl_json(body)
  httr2::response(status, headers = c(list("Content-Type" = "application/json"), headers),
                  body = charToRaw(enc2utf8(text)))
}

# Mock the API: `routes` maps a path to a fixture file name, a body (list), an httr2 response, a function(req) or a
# list of those (answered in turn). `seen` records every request and every throttle wait (one per attempt).
local_kbl <- function(routes, today = "20261018", env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$waits <- 0L
  .kbl_clear_cache()
  withr::defer(.kbl_clear_cache(), envir = env)
  local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits <- seen$waits + 1L
      invisible(0)
    },
    .kbl_today_kst = function() today,
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    path <- httr2::url_parse(req$url)$path
    ans <- routes[[path]]
    if (is.null(ans)) return(kbl_resp(list(resultCode = "Fail", message = "x", errorCode = 500L), 500L))
    if (is.list(ans) && !is.null(attr(ans, "turns"))) {
      i <- min(sum(vapply(seen$reqs, function(r) identical(httr2::url_parse(r$url)$path, path), logical(1))),
               length(ans))
      ans <- ans[[i]]
    }
    if (is.function(ans)) return(ans(req))
    if (inherits(ans, "httr2_response")) return(ans)
    if (is.character(ans) && length(ans) == 1L && endsWith(ans, ".json")) return(kbl_resp(kbl_text(ans)))
    kbl_resp(ans)
  }, env = env)
  seen
}
turns <- function(...) structure(list(...), turns = TRUE)
kbl_path <- function(req) httr2::url_parse(req$url)$path

GM <- "S47G01N49"
KBL_GAME <- stats::setNames(
  as.list(paste0(c("game", "text_cast", "player_stat", "team_record", "match_chart"), "_", GM, ".json")),
  paste0("/match/", GM, c("", "/text-cast", "/player-stat", "/team-record", "/match-chart"))
)
game_routes <- function(...) utils::modifyList(KBL_GAME, list(...))

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
KBL_CASES <- c(
  list(
    kbl_seasons = list(list(), list("/season/list" = "seasons.json")),
    kbl_teams = list(list(), list("/common/teamList" = "teams.json")),
    kbl_schedule = list(list(from_date = "20251101", to_date = "20251101"),
                        list("/match/list" = "schedule_20251101.json"))
  ),
  sapply(c("kbl_game", "kbl_period_scores", "kbl_pbp", "kbl_player_box", "kbl_team_box", "kbl_shots",
           "kbl_score_track", "kbl_game_leaders"), function(w) list(list(gmkey = GM), KBL_GAME), simplify = FALSE),
  list(
    kbl_player_totals = list(list(season = 2025), list("/leagues/S45G01/stats/players" = "player_totals_S45G01.json")),
    kbl_standings = list(list(season = 2025), list("/league/rank/S45G01" = "rank_S45G01.json")),
    kbl_team_tracks = list(list(season = 2025), list("/league/rank/S45G01/team-tracks" = "team_tracks_S45G01.json")),
    kbl_rounds = list(list(season = 2025), list("/league/rank/S45G01/team-tracks" = "team_tracks_S45G01.json"))
  ),
  sapply(c("kbl_playoff_seeds", "kbl_playoff_series", "kbl_playoff_games"), function(w) {
    list(list(season = 2025), list("/league/playoff/new/S45G01" = "playoff_new_S45G01.json"))
  }, simplify = FALSE),
  stats::setNames(lapply(1:3, function(i) list(list(season = 2024), list("/league/playoff/S43G01" = "playoff_S43G01.json"))),
                  c("kbl_playoff_seeds__2024", "kbl_playoff_series__2024", "kbl_playoff_games__2024")),
  list(
    kbl_round_mvps = list(list(season = 2025), list("/league/round-mvp/45" = "round_mvp_45.json")),
    kbl_current_standings = list(list(), list("/league/rank/team" = "rank_team.json")),
    kbl_season_leaders = list(list(), list("/league/season-leader" = "season_leader.json")),
    kbl_players = list(list(), list("/players" = "players.json"))
  )
)
KBL_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date")
kbl_type <- function(x) if (inherits(x, "Date")) "Date" else if (is.double(x)) "numeric" else class(x)[[1]]

kbl_run_case <- function(case, env = parent.frame()) {
  spec <- KBL_CASES[[case]]
  seen <- local_kbl(spec[[2]], env = env)
  list(out = do.call(sub("__.*$", "", case), spec[[1]]), seen = seen)
}

kbl_read_parity <- function(case) {
  f <- kbl_fixture("parity", paste0(case, ".csv"))
  if (!file.exists(f)) f <- paste0(f, ".gz")
  utils::read.csv(f, colClasses = "character", na.strings = "\\N", check.names = FALSE, encoding = "UTF-8")
}

# cells that differ, NA-vs-value counted as a mismatch
kbl_mismatches <- function(got, want_chr) {
  if (inherits(got, "Date")) got <- format(got, "%Y-%m-%d")
  want <- if (is.logical(got)) {
    ifelse(is.na(want_chr), NA, want_chr == "true")
  } else if (is.numeric(got)) {
    suppressWarnings(as.numeric(want_chr))
  } else {
    want_chr
  }
  na_diff <- is.na(got) != is.na(want)
  both <- !is.na(got) & !is.na(want)
  val_diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 * pmax(1, abs(want[both])) else got[both] != want[both]
  sum(na_diff) + sum(val_diff)
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, requests)", {
  dtypes <- jsonlite::read_json(kbl_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(kbl_fixture("parity", "requests.json"))
  expect_setequal(names(KBL_CASES), names(dtypes))
  exports <- getNamespaceExports("hoopR")
  expect_setequal(unique(sub("__.*$", "", names(KBL_CASES))), exports[startsWith(exports, "kbl_")])
  for (case in names(KBL_CASES)) {
    res <- kbl_run_case(case)
    got <- res$out
    want <- kbl_read_parity(case)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(dtypes[[case]]), label = case)
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(KBL_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(vapply(got, kbl_type, character(1)), want_types, label = case)
    bad <- vapply(names(got), function(n) kbl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same requests sdv-py sent: paths and queries, in order
    flat <- function(q) sort(paste(names(q), vapply(q, as.character, ""), sep = "="))
    got_req <- lapply(res$seen$reqs, function(r) list(kbl_path(r), flat(httr2::url_parse(r$url)$query %||% list())))
    want_req <- lapply(requests[[case]], function(r) list(r$path, flat(r$query)))
    expect_identical(got_req, want_req, label = case)
  }
})

test_that("ids keep one type: gmkey / glkey / team_code / pcode character, season codes and game numbers integer", {
  box <- kbl_run_case("kbl_player_box")$out
  expect_type(box$gmkey, "character")
  expect_type(box$team_code, "character")
  expect_type(box$pcode, "character")
  expect_true(all(nchar(box$team_code) == 2L) && all(nchar(box$pcode) == 6L))
  for (col in c("season", "season_code", "game_no")) expect_type(box[[col]], "integer")
  sched <- kbl_run_case("kbl_schedule")$out
  expect_type(sched$home_team_code, "character")
  expect_type(sched$game_code, "character")
  expect_identical(unique(sched$game_code), "01")
  expect_s3_class(sched$game_date, "Date")
  pbp <- kbl_run_case("kbl_pbp")$out
  expect_false("pcode" %in% names(pbp))
  expect_identical(unique(pbp$season), 2026L)
})

test_that("every frame of an empty or malformed body is a zero-row tibble with the documented columns", {
  for (kind in names(.kbl_specs)) {
    for (body in list(NULL, list(), structure(list(), names = character()), "x", 3L, list(items = list()))) {
      out <- .kbl_parse(kind, list(body = body, req = list()))
      expect_identical(nrow(out), 0L, label = kind)
      expect_identical(names(out), names(.kbl_specs[[kind]]), label = kind)
    }
  }
  # a valid body with no rows for the frame: an old-format bracket lists no games, an old game charts no shots
  games <- kbl_run_case("kbl_playoff_games__2024")$out
  expect_identical(nrow(games), 0L)
  expect_type(games$home_score, "integer")
  chart <- kbl_body(KBL_GAME[[5]])
  chart$shootLog <- list()
  local_kbl(game_routes(`/match/S47G01N49/match-chart` = chart))
  shots <- kbl_shots(GM)
  expect_identical(nrow(shots), 0L)
  expect_identical(names(shots), names(.kbl_specs$shots))
  expect_type(shots$x, "integer")
})

test_that("an empty valid answer raises hoopR_no_data", {
  local_kbl(list(`/season/list` = list()))
  expect_error(kbl_seasons(), class = "hoopR_no_data")
  local_kbl(game_routes(`/match/S47G01N49/player-stat` = list()))
  expect_error(kbl_player_box(GM), class = "hoopR_no_data")
  local_kbl(list(`/league/rank/S45G01` = list()))
  expect_error(kbl_standings(2025), class = "hoopR_no_data")
  local_kbl(list(`/league/playoff/new/S45G01` = list(defaultRank = list())))
  expect_error(kbl_playoff_seeds(2025), class = "hoopR_no_data")
  local_kbl(list(`/league/rank/S45G01/team-tracks` = list(rounds = list())))
  expect_error(kbl_rounds(2025), class = "hoopR_no_data")
  local_kbl(list(`/match/list` = list()))
  expect_error(kbl_schedule(from_date = "20250701", to_date = "20250702"), class = "hoopR_no_data")
  local_kbl(list(`/players` = kbl_resp("[]", 404L)))
  expect_error(kbl_players(), class = "hoopR_no_data")
})

test_that("the error envelope, a 400 and a 500 are hoopR_asset_fetch; a 500 is not retried, a 503 is", {
  env <- list(resultCode = "Fail", message = "x", object = -1L, errorCode = 500L)
  for (status in c(200L, 400L, 500L)) {
    seen <- local_kbl(list(`/season/list` = kbl_resp(env, status)))
    expect_error(kbl_seasons(), class = "hoopR_asset_fetch")
    expect_length(seen$reqs, 1L)
  }
  seen <- local_kbl(list(`/season/list` = kbl_resp(env, 400L)))
  err <- tryCatch(kbl_seasons(), error = identity)
  expect_false(inherits(err, "hoopR_bad_request"))
  expect_identical(err$status, 400L)
  seen <- local_kbl(list(`/season/list` = turns(kbl_resp("{}", 503L), "seasons.json")))
  expect_identical(nrow(kbl_seasons()), 3L)
  expect_identical(seen$waits, 2L)
  local_kbl(list(`/season/list` = kbl_resp("<html>")))
  expect_error(kbl_seasons(), class = "hoopR_asset_fetch")
  local_kbl(list(`/season/list` = kbl_resp("")))
  expect_error(kbl_seasons(), class = "hoopR_asset_fetch")
})

test_that("both headers go with every request; the text-cast asks for every period", {
  seen <- local_kbl(game_routes(`/match/S47G01N49` = local({
    h <- kbl_body(KBL_GAME[[1]])
    h$game$isEnded <- 0L # proven final by its text-cast
    h
  })))
  kbl_team_box(GM)
  expect_identical(vapply(seen$reqs, kbl_path, ""), paste0("/match/", GM, c("", "/text-cast", "/team-record")))
  for (r in seen$reqs) {
    expect_identical(unclass(r$headers$Channel), "WEB")
    expect_identical(unclass(r$headers$TeamCode), "XX")
  }
  expect_identical(httr2::url_parse(seen$reqs[[2]]$url)$query, list(quarterList = .KBL_QUARTERS))
})

test_that("a final game's header is fetched once per session", {
  seen <- local_kbl(KBL_GAME)
  kbl_player_box(GM)
  kbl_team_box(GM)
  kbl_shots(GM)
  expect_identical(vapply(seen$reqs, kbl_path, ""),
                   paste0("/match/", GM, c("", "/player-stat", "/team-record", "/match-chart")))
  expect_identical(nrow(kbl_game(GM)), 1L) # the header route re-reads and re-checks it
  expect_identical(kbl_path(seen$reqs[[5]]), paste0("/match/", GM))
})

test_that("a malformed gmkey, season, division or game_code is hoopR_bad_request before any request", {
  seen <- local_kbl(list())
  for (bad in list("S47G01", "s47g01n49", "S47G1N49", 47L, NA_character_, c(GM, GM))) {
    expect_error(kbl_player_box(bad), class = "hoopR_bad_request")
  }
  expect_error(kbl_standings(1996), class = "hoopR_bad_request")
  expect_error(kbl_standings(2028), class = "hoopR_bad_request")
  expect_error(kbl_standings("2025-26"), class = "hoopR_bad_request")
  expect_error(kbl_standings(TRUE), class = "hoopR_bad_request")
  expect_error(kbl_standings(2008, division = "d_league"), class = "hoopR_bad_request")
  expect_error(kbl_standings(2025, division = "wkbl"), class = "hoopR_bad_request")
  expect_error(kbl_standings(2025, game_code = "1"), class = "hoopR_bad_request")
  expect_error(kbl_round_mvps(1990), class = "hoopR_bad_request")
  expect_error(kbl_schedule(), class = "hoopR_bad_request")
  expect_error(kbl_schedule(from_date = "2025"), class = "hoopR_bad_request")
  expect_error(kbl_schedule(from_date = "20251102", to_date = "20251101"), class = "hoopR_bad_request")
  expect_error(kbl_schedule(season = 2026, from_date = "20251101", to_date = "20251102"), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

test_that("seasons are END years mapped to the API key as sdv-py does", {
  rank <- function(code) {
    rows <- kbl_body("rank_S45G01.json")
    lapply(rows, function(r) utils::modifyList(r, list(seasonCode = code)))
  }
  seen <- local_kbl(list(`/league/rank/S47G01` = rank(47L), `/league/rank/S1G01` = rank(1L),
                         `/leagues/S48G01/stats/players` = "player_totals_S45G01.json",
                         `/leagues/S14G08/stats/players` = "player_totals_S45G01.json",
                         `/league/round-mvp/47` = lapply(kbl_body("round_mvp_45.json"), utils::modifyList,
                                                         list(seasonCode = 47L)),
                         `/league/playoff/S43G01` = "playoff_S43G01.json",
                         `/league/playoff/new/S45G01` = "playoff_new_S45G01.json"))
  expect_identical(kbl_standings(2026)$season, rep(2026L, 3))
  expect_identical(unique(kbl_standings(1997)$season_code), 1L)
  tot <- kbl_player_totals(2026, division = "d_league")
  expect_identical(unique(tot$glkey), "S48G01")
  expect_identical(unique(tot$season), 2026L)
  expect_identical(unique(kbl_player_totals("2009", division = "d_league", game_code = "08")$glkey), "S14G08")
  expect_identical(unique(kbl_round_mvps(2026)$season), 2026L)
  expect_identical(unique(kbl_playoff_series(2024)$bracket_format), "old")
  expect_identical(unique(kbl_playoff_series(2025)$bracket_format), "new")
  paths <- vapply(seen$reqs, kbl_path, "")
  expect_identical(paths, c("/league/rank/S47G01", "/league/rank/S1G01", "/leagues/S48G01/stats/players",
                            "/leagues/S14G08/stats/players", "/league/round-mvp/47", "/league/playoff/S43G01",
                            "/league/playoff/new/S45G01"))
  expect_true(all(vapply(seen$reqs, function(r) is.null(httr2::url_parse(r$url)$query), logical(1))))
  # a season schedule is the END year's first..last game, one request per calendar year
  seen <- local_kbl(list(`/match/list` = function(req) {
    q <- httr2::url_parse(req$url)$query
    rows <- kbl_body("schedule_20251101.json")
    if (q$fromDate == "20260101") rows <- lapply(rows, utils::modifyList, list(gameDate = "20260105"))
    kbl_resp(rows)
  }))
  expect_identical(nrow(kbl_schedule(season = 2026)), 6L)
  expect_identical(lapply(seen$reqs, function(r) httr2::url_parse(r$url)$query),
                   list(list(fromDate = "20250920", toDate = "20251231"), list(fromDate = "20260101", toDate = "20260513")))
})

test_that("a game that is not final, or a body for another game, is hoopR_asset_fetch", {
  hdr <- kbl_body(KBL_GAME[[1]])
  cast <- kbl_body(KBL_GAME[[2]])
  open <- hdr
  open$game$isEnded <- 0L
  local_kbl(game_routes(`/match/S47G01N49` = open), today = "20251101") # the game's own date
  expect_error(kbl_player_box(GM), "not final", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49` = open))
  expect_identical(nrow(kbl_team_box(GM)), 2L) # isEnded 0, but past, both scored and the game-end row is there
  no_end <- Filter(function(r) !(identical(r$a, "009") && identical(r$q, "Q4")), cast)
  local_kbl(game_routes(`/match/S47G01N49` = open, `/match/S47G01N49/text-cast` = no_end))
  expect_error(kbl_pbp(GM), "game-end", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49/text-cast` = Filter(function(r) identical(r$q, "Q4"), cast)))
  expect_error(kbl_pbp(GM), "periods", class = "hoopR_asset_fetch")
  other_team <- cast
  other_team[[3]]$t <- "99"
  local_kbl(game_routes(`/match/S47G01N49/text-cast` = other_team))
  expect_error(kbl_pbp(GM), "text-cast team", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49/text-cast` = list()))
  expect_error(kbl_pbp(GM), "empty", class = "hoopR_asset_fetch")
  wrong <- hdr
  wrong$game$gmkey <- "S47G01N50"
  local_kbl(game_routes(`/match/S47G01N49` = wrong))
  expect_error(kbl_player_box(GM), "gmkey", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49` = list(game = hdr$game)))
  expect_error(kbl_game(GM), "teamrecords", class = "hoopR_asset_fetch")
  box <- kbl_body(KBL_GAME[[3]])
  box[[1]]$records$score <- box[[1]]$records$score + 1L
  local_kbl(game_routes(`/match/S47G01N49/player-stat` = box))
  expect_error(kbl_player_box(GM), "points", class = "hoopR_asset_fetch")
  box <- kbl_body(KBL_GAME[[3]])
  box[[1]]$player$tcode <- "99"
  local_kbl(game_routes(`/match/S47G01N49/player-stat` = box))
  expect_error(kbl_player_box(GM), "player team", class = "hoopR_asset_fetch")
  team <- kbl_body(KBL_GAME[[4]])
  team[[2]]$records$score <- 1L
  local_kbl(game_routes(`/match/S47G01N49/team-record` = team))
  expect_error(kbl_team_box(GM), "team scores", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49/team-record` = list(a = 1L)))
  expect_error(kbl_team_box(GM), "JSON list", class = "hoopR_asset_fetch")
  chart <- kbl_body(KBL_GAME[[5]])
  chart$shootLog[[1]]$tcode <- "99"
  local_kbl(game_routes(`/match/S47G01N49/match-chart` = chart))
  expect_error(kbl_shots(GM), "shot team", class = "hoopR_asset_fetch")
  chart <- kbl_body(KBL_GAME[[5]])
  chart$scoreChart$home$q4[[8]] <- 1L
  local_kbl(game_routes(`/match/S47G01N49/match-chart` = chart))
  expect_error(kbl_score_track(GM), "scoreChart home", class = "hoopR_asset_fetch")
  local_kbl(game_routes(`/match/S47G01N49/match-chart` = list(1L, 2L)))
  expect_error(kbl_game_leaders(GM), "not an object", class = "hoopR_asset_fetch")
})

test_that("a season body for another season or window is hoopR_asset_fetch", {
  local_kbl(list(`/league/rank/S47G01` = "rank_S45G01.json"))
  expect_error(kbl_standings(2026), "asked for S47G01", class = "hoopR_asset_fetch")
  local_kbl(list(`/league/playoff/S43G01` = "playoff_new_S45G01.json"))
  expect_error(kbl_playoff_seeds(2024), "seasonCode", class = "hoopR_asset_fetch")
  local_kbl(list(`/league/rank/S43G01/team-tracks` = "team_tracks_S45G01.json"))
  expect_error(kbl_team_tracks(2024), "outside season", class = "hoopR_asset_fetch")
  local_kbl(list(`/league/round-mvp/43` = "round_mvp_45.json"))
  expect_error(kbl_round_mvps(2024), "seasonCode", class = "hoopR_asset_fetch")
  local_kbl(list(`/match/list` = "schedule_20251101.json"))
  expect_error(kbl_schedule(from_date = "20251201", to_date = "20251202"), "outside", class = "hoopR_asset_fetch")
  rows <- kbl_body("schedule_20251101.json")
  rows[[1]]$gameNo <- 50L
  local_kbl(list(`/match/list` = rows))
  expect_error(kbl_schedule(from_date = "20251101", to_date = "20251101"), "does not match", class = "hoopR_asset_fetch")
  local_kbl(list(`/leagues/S45G01/stats/players` = list(a = 1L)))
  expect_error(kbl_player_totals(2025), "JSON list", class = "hoopR_asset_fetch")
})

test_that("codes decode, overtimes are labelled OT and the season crosswalk is the committed one", {
  pbp <- kbl_run_case("kbl_pbp")$out
  made2 <- pbp[pbp$action_code %in% "201", ]
  expect_true(nrow(made2) > 0 && all(made2$points == 2L) && all(made2$action == "Two-point field goal made (dunks excepted)"))
  expect_identical(unique(made2$action_ko), "2\uC810\uC29B\uC131\uACF5")
  expect_identical(.kbl_period_of("X1"), list(5L, "OT1"))
  expect_identical(.kbl_period_of("eq2"), list(6L, "OT2"))
  expect_identical(.kbl_period_of("Q5"), list(NULL, NULL))
  t <- .kbl_season_table
  expect_identical(nrow(t), 50L)
  expect_identical(t$code[t$end == 2026L], c(47L, 48L))
  expect_identical(.kbl_season_dates(2026L, NULL), c("20250920", "20260513"))
  expect_identical(.kbl_windows(2026, NULL, NULL, NULL), list(c("20250920", "20251231"), c("20260101", "20260513")))
})

test_that("live: the 2025-26 seasons list and a final game", {
  skip_intl_live()
  seasons <- kbl_seasons()
  expect_true(2026L %in% seasons$season)
  box <- kbl_player_box(GM)
  expect_identical(names(box), names(.kbl_specs$player_box))
  expect_true(nrow(box) > 0)
})
