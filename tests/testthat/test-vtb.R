# Offline tests of the VTB United League families: R/vtb.R, R/vtb_runtime.R, R/vtb_parsers.R, R/vtb_tables.R.
# Every request is mocked through httr2, so the season mapping, the personal-data scrub, the final-game proof, the
# scope checks, the retries and the error vocabulary run end to end; the throttle is recorded, never slept.
# Parity: tests/testthat/fixtures/vtb/parity/<case>.csv is sdv-py's frame of the same wrapper on the same fixture
# (see fixtures/vtb/README.md).

withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

vtb_fixture <- function(...) test_path("fixtures", "vtb", ...)
vtb_text <- function(rel) paste(readLines(vtb_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
vtb_body <- function(rel) jsonlite::parse_json(vtb_text(rel), simplifyVector = FALSE)
vtb_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

vtb_resp <- function(body, status = 200L, headers = list()) {
  text <- if (is.character(body)) body else vtb_json(body)
  httr2::response(status, headers = c(list("Content-Type" = "application/json; charset=utf-8"), headers),
                  body = charToRaw(enc2utf8(text)))
}

# Mock both hosts: `routes` maps a path to a fixture file name, a body (list), an httr2 response, a function(req) or
# turns(...) (answered in order). `seen` records every request and every throttle wait (one per attempt). The vtb
# season table is seeded with sdv-py's verified copy unless `seed = FALSE`.
local_vtb <- function(routes, seed = TRUE, env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$waits <- 0L
  .vtb_clear_cache()
  if (seed) assign("vtb", .VTB_SEASON_COMP_IDS, envir = .vtb_cache)
  withr::defer(.vtb_clear_cache(), envir = env)
  local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits <- seen$waits + 1L
      invisible(0)
    },
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    path <- httr2::url_parse(req$url)$path
    ans <- routes[[path]]
    if (is.null(ans)) return(vtb_resp("<html>Not Found</html>", 404L))
    if (is.list(ans) && !is.null(attr(ans, "turns"))) {
      i <- min(sum(vapply(seen$reqs, function(r) identical(httr2::url_parse(r$url)$path, path), logical(1))),
               length(ans))
      ans <- ans[[i]]
    }
    if (is.function(ans)) return(ans(req))
    if (inherits(ans, "httr2_response")) return(ans)
    if (is.character(ans) && length(ans) == 1L && grepl("\\.json(\\.gz)?$", ans)) return(vtb_resp(vtb_text(ans)))
    vtb_resp(ans)
  }, env = env)
  seen
}
turns <- function(...) structure(list(...), turns = TRUE)
vtb_path <- function(req) httr2::url_parse(req$url)$path
vtb_query <- function(req) httr2::url_parse(req$url)$query %||% list()

G <- 921391L
P <- 423011L
TID <- 2650L
ONLINE <- stats::setNames(list("online_921391.json.gz"), paste0("/Widget/GetOnline/", G))
TEAM_STATS <- list("/Widget/TeamStats/2650" = "team_stats_2650_2026.json")

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
VTB_CASES <- c(
  list(
    vtb_league_leagues = list(list(), list("/v2/leagues" = "leagues.json")),
    vtb_league_seasons = list(list(league_slug = "vtb"), list("/v2/leagues/vtb/seasons" = "league_seasons_vtb.json")),
    vtb_league_matches = list(list(league_slug = "vtb", season = 2026),
                              list("/v2/leagues/vtb/seasons/2026/matches" = "matches_vtb_2026.json.gz")),
    vtb_infobasket_seasons = list(list(), list("/Comp/GetSeasonsForTag" = "seasons_vtb.json")),
    vtb_infobasket_calendar = list(list(season = 2026), list("/Comp/GetCalendar/" = "calendar_2026.json"))
  ),
  sapply(paste0("vtb_infobasket_", c("team_stats", "team_stats_players", "team_stats_coaches")), function(w) {
    list(list(season = 2026), list("/Comp/GetTeamStats/50714" = "team_stats_2026.json.gz"))
  }, simplify = FALSE),
  list(
    vtb_infobasket_best_players = list(list(season = 2026),
                                       list("/Comp/GetBestPlayers/50714" = "best_players_2026.json.gz")),
    vtb_infobasket_best_teams = list(list(season = 2026), list("/Comp/GetBestTeams/50714" = "best_teams_2026.json")),
    vtb_infobasket_team_preview = list(list(game_id = G, season = 2026),
                                       list("/Comp/GetTeamStatsForPreview/921391" = "preview_921391.json.gz"))
  ),
  sapply(paste0("vtb_infobasket_", c("game", "box_score", "team_box_score", "pbp", "game_staff")),
         function(w) list(list(game_id = G), ONLINE), simplify = FALSE),
  sapply(paste0("vtb_infobasket_", c("game", "box_score", "pbp", "game_staff"), "__2014"), function(w) {
    list(list(game_id = 684495L), list("/Widget/GetOnline/684495" = "online_684495.json.gz"))
  }, simplify = FALSE),
  list(
    vtb_infobasket_game_page = list(list(game_id = G), list("/Widget/GamePage/921391" = "game_page_921391.json")),
    vtb_infobasket_comp_issue = list(list(season = 2026), list("/Widget/CompIssue/50714" = "comp_issue_2026.json")),
    vtb_infobasket_standings = list(list(comp_id = 50720),
                                    list("/Widget/CompTeamResults/50720" = "standings_50720.json")),
    vtb_infobasket_cross_table = list(list(comp_id = 50720),
                                      list("/Widget/CrossTable/50720" = "cross_table_50720.json")),
    vtb_infobasket_playoff = list(list(comp_id = 54281), list("/Widget/PlayOff/54281" = "playoff_54281.json")),
    vtb_infobasket_playoff_games = list(list(comp_id = 54281), list("/Widget/PlayOff/54281" = "playoff_54281.json")),
    vtb_infobasket_best_player_parameters = list(list(), list("/Widget/GetBestPlayerParameters/" =
                                                                "best_player_parameters.json")),
    vtb_infobasket_best_team_parameters = list(list(), list("/Widget/GetBestTeamParameters/" =
                                                              "best_team_parameters.json")),
    vtb_infobasket_player = list(list(person_id = P), list("/Widget/PlayerPage/423011" = "player_423011.json")),
    vtb_infobasket_player_season_stats = list(list(person_id = P), list("/Widget/PlayerSeasonStats/423011" =
                                                                          "player_season_stats_423011.json")),
    vtb_infobasket_player_career_stats = list(list(person_id = P), list("/Widget/PlayerSeasonStats/423011" =
                                                                          "player_season_stats_423011.json")),
    vtb_infobasket_player_game_log = list(list(person_id = P, season = 2026, team = TID),
                                          list("/Widget/PlayerStats/423011" = "player_game_log_423011.json")),
    vtb_infobasket_coach = list(list(person_id = 131047), list("/Widget/CoachPage/131047" = "coach_131047.json")),
    vtb_infobasket_team = list(list(team_id = TID), list("/Widget/TeamPage/2650" = "team_2650.json")),
    vtb_infobasket_team_seasons = list(list(team_id = TID),
                                       list("/Widget/GetTeamSeasons/2650" = "team_seasons_2650.json")),
    vtb_infobasket_team_comps = list(list(team_id = TID, season = 2026),
                                     list("/Widget/GetTeamComps/2650" = "team_comps_2650_2026.json")),
    vtb_infobasket_roster = list(list(team_id = TID, season = 2026),
                                 list("/Widget/TeamRoster/2650" = "roster_2650_2026.json")),
    vtb_infobasket_roster_coaches = list(list(team_id = TID, season = 2026),
                                         list("/Widget/TeamRoster/2650" = "roster_2650_2026.json")),
    vtb_infobasket_team_games = list(list(team_id = TID, season = 2026),
                                     list("/Widget/TeamGames/2650" = "team_games_2650_2026.json"))
  ),
  sapply(paste0("vtb_infobasket_", c("team_season_stats", "team_player_stats", "team_coach_stats")), function(w) {
    list(list(team_id = TID, season = 2026), TEAM_STATS)
  }, simplify = FALSE)
)
VTB_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character")
vtb_type <- function(x) if (is.double(x)) "numeric" else class(x)[[1]]

vtb_run_case <- function(case, env = parent.frame()) {
  spec <- VTB_CASES[[case]]
  seen <- local_vtb(spec[[2]], env = env)
  list(out = do.call(sub("__.*$", "", case), spec[[1]]), seen = seen)
}

vtb_read_parity <- function(case) {
  f <- vtb_fixture("parity", paste0(case, ".csv"))
  if (!file.exists(f)) f <- paste0(f, ".gz")
  utils::read.csv(f, colClasses = "character", na.strings = "\\N", check.names = FALSE, encoding = "UTF-8")
}

# cells that differ, NA-vs-value counted as a mismatch
vtb_mismatches <- function(got, want_chr) {
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
  dtypes <- jsonlite::read_json(vtb_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(vtb_fixture("parity", "requests.json"))
  expect_setequal(names(VTB_CASES), names(dtypes))
  exports <- getNamespaceExports("hoopR")
  expect_setequal(unique(sub("__.*$", "", names(VTB_CASES))), exports[startsWith(exports, "vtb_")])
  expect_length(exports[startsWith(exports, "vtb_")], 38L)
  for (case in names(VTB_CASES)) {
    res <- vtb_run_case(case)
    got <- res$out
    want <- vtb_read_parity(case)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(dtypes[[case]]), label = case)
    expect_identical(names(got), names(.vtb_specs[[sub("__.*$", "", case)]]), label = case)
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(VTB_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(vapply(got, vtb_type, character(1)), want_types, label = case)
    bad <- vapply(names(got), function(n) vtb_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same requests sdv-py sent: paths and queries, in order
    flat <- function(q) sort(paste(names(q), vapply(q, as.character, ""), sep = "="))
    got_req <- lapply(res$seen$reqs, function(r) list(vtb_path(r), flat(vtb_query(r))))
    want_req <- lapply(requests[[case]], function(r) list(r$path, flat(r$query)))
    expect_identical(got_req, want_req, label = case)
  }
})

test_that("ids keep one integer type and the wire conversions match sdv-py", {
  box <- vtb_run_case("vtb_infobasket_box_score")$out
  for (col in c("game_id", "team_id", "person_id")) expect_type(box[[col]], "integer")
  expect_identical(unique(box$game_id), G)
  expect_type(box$is_home, "logical")
  expect_type(box$shot1_percent, "double")
  expect_false(any(grepl("(^|_)paint_|shots[123]$", names(box))))
  pbp <- vtb_run_case("vtb_infobasket_pbp")$out
  for (col in c("game_id", "play_id", "team_id", "person_id", "start_id")) expect_type(pbp[[col]], "integer")
  cal <- vtb_run_case("vtb_infobasket_calendar")$out
  expect_true(all(grepl("^\\d{4}-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d\\+03:00$", cal$game_date_time)))
  expect_true(all(grepl("^\\d{4}-\\d\\d-\\d\\d$", cal$game_date)))
  expect_identical(unique(cal$season), 2026L)
  expect_identical(unique(cal$comp_id), 50714L)
  m <- vtb_run_case("vtb_league_matches")$out
  for (col in c("match_id", "phase_id", "home_team_id", "away_team_id", "venue_id")) expect_type(m[[col]], "integer")
  expect_match(stats::na.omit(m$points_by_quarters)[[1]], "^\\[\\[\\d+, \\d+\\](, \\[\\d+, \\d+\\])+\\]$")
  expect_identical(.vtb_conv("/Date(-62135596800000)/"), NA)
  expect_identical(.vtb_conv("/Date(1759057200000)/"), "2025-09-28T14:00:00+03:00")
  expect_identical(.vtb_conv("28.09.2025"), "2025-09-28")
  expect_identical(.vtb_decimal("68,2"), 68.2)
  expect_identical(.vtb_decimal("80,3%"), 80.3)
  expect_identical(.vtb_decimal(""), NA_real_)
  expect_identical(.vtb_pyjson(list(list(a = 1L, b = "x\"y"), list(c = NULL, d = TRUE, e = 1.5, f = 2))),
                   "[{\"a\": 1, \"b\": \"x\\\"y\"}, {\"c\": null, \"d\": true, \"e\": 1.5, \"f\": 2.0}]")
})

test_that("pre-2022-23 games have a box score but no plays: the pbp frame is zero-row with the documented columns", {
  out <- vtb_run_case("vtb_infobasket_pbp__2014")$out
  expect_identical(nrow(out), 0L)
  expect_identical(names(out), names(.vtb_specs$vtb_infobasket_pbp))
  expect_gt(nrow(vtb_run_case("vtb_infobasket_box_score__2014")$out), 0L)
})

test_that("every frame of an empty or malformed body is a zero-row tibble with the documented columns", {
  bad_bodies <- list(NULL, list(), structure(list(), names = character()), "x", 5L, list(items = list()),
                     list(data = list()), list(Stats = list()), list(GameTeams = "x"))
  for (kind in names(.vtb_specs)) {
    for (body in bad_bodies) {
      out <- .vtb_out(kind, body, "x")
      expect_identical(nrow(out), 0L, label = kind)
      expect_identical(names(out), names(.vtb_specs[[kind]]), label = kind)
      types <- vapply(out, function(x) if (is.double(x)) "double" else class(x)[[1]], "")
      expect_identical(unname(types), unname(.vtb_specs[[kind]]), label = kind)
    }
  }
})

test_that("seasons are END years: the tag's live table maps them to the season CompID", {
  # the table is fetched once per tag and cached; an END year it lacks is hoopR_bad_request naming the years it has
  seen <- local_vtb(list("/Comp/GetSeasonsForTag" = "seasons_vtb.json",
                         "/Comp/GetCalendar/" = list(list(GameDate = "01.10.2010"))), seed = FALSE)
  out <- vtb_infobasket_calendar(season = 2011)
  expect_identical(unique(out$comp_id), 6076L)
  expect_identical(vapply(seen$reqs, vtb_path, ""), c("/Comp/GetSeasonsForTag", "/Comp/GetCalendar/"))
  q <- vtb_query(seen$reqs[[2]])
  expect_identical(q$comps, "6076")
  expect_null(q$season)
  expect_null(q$tag)
  expect_identical(vtb_query(seen$reqs[[1]])[c("tag", "format")], list(tag = "vtb", format = "json"))
  expect_error(vtb_infobasket_calendar(season = 2026), "2010, 2011, and 2012", class = "hoopR_bad_request")
  expect_length(seen$reqs, 2L)
  # the path season token is mapped into the wire path
  seen <- local_vtb(list("/Widget/CompIssue/39799" = list(ParentCompID = 39799L, Comps = list())))
  expect_identical(nrow(vtb_infobasket_comp_issue(2023)), 0L)
  expect_identical(vtb_path(seen$reqs[[1]]), "/Widget/CompIssue/39799")
  for (bad in list(2009, 2028, 50714, "x", TRUE, NA, 2026.5)) {
    seen <- local_vtb(list())
    expect_error(vtb_infobasket_calendar(season = bad), class = "hoopR_bad_request")
    expect_length(seen$reqs, 0L)
  }
  # an unknown tag answers [] (no seasons); a malformed table is refused
  local_vtb(list("/Comp/GetSeasonsForTag" = list()), seed = FALSE)
  expect_error(vtb_infobasket_calendar(2026, tag = "nosuchtag"), class = "hoopR_no_data")
  local_vtb(list("/Comp/GetSeasonsForTag" = list(list(SeasonYear = "2026", CompID = 50714L))), seed = FALSE)
  expect_error(vtb_infobasket_calendar(2026), "integer SeasonYear", class = "hoopR_asset_fetch")
})

test_that("tag goes on the wire only on the profile routes; the team routes send compId, team comps season", {
  seen <- local_vtb(list("/Widget/TeamRoster/2650" = "roster_2650_2026.json",
                         "/Widget/GetTeamComps/2650" = "team_comps_2650_2026.json",
                         "/Widget/GetBestTeamParameters/" = "best_team_parameters.json"))
  vtb_infobasket_roster(TID, 2026, lang = "ru")
  vtb_infobasket_team_comps(TID, 2026)
  vtb_infobasket_best_team_parameters()
  expect_identical(vtb_query(seen$reqs[[1]])[c("format", "lang", "tag", "compId")],
                   list(format = "json", lang = "ru", tag = "vtb", compId = "50714"))
  expect_identical(vtb_query(seen$reqs[[2]])$season, "50714")
  expect_identical(vtb_query(seen$reqs[[3]]), list(format = "json", lang = "en"))
  expect_error(vtb_infobasket_roster(TID, 2026, lang = "de"), class = "hoopR_bad_request")
})

test_that("an error envelope, a bare string, a scalar, a non-JSON or empty body are hoopR_asset_fetch", {
  for (ans in list(list(MessageType = 2L, Header = "Error", Message = "Not Found"), "\"BadRequest\"", "5", "null",
                   "<html>x</html>", "")) {
    local_vtb(list("/Widget/GamePage/921391" = vtb_resp(ans)))
    expect_error(vtb_infobasket_game_page(G), class = "hoopR_asset_fetch")
  }
  local_vtb(list("/Widget/PlayOff/50714" = list(MessageType = 4L, Message = "not a playoff")))
  expect_error(vtb_infobasket_playoff(50714), "error envelope", class = "hoopR_asset_fetch")
})

test_that("404 is no_data, an empty list is no_data, a non-list answer to a list route is refused", {
  local_vtb(list())
  expect_error(vtb_infobasket_game(G), class = "hoopR_no_data")
  expect_error(vtb_league_leagues(), class = "hoopR_no_data")
  local_vtb(list("/Widget/CrossTable/50720" = list()))
  expect_error(vtb_infobasket_cross_table(50720), "no rows", class = "hoopR_no_data")
  local_vtb(list("/Widget/CrossTable/50720" = list(GameID = 1L)))
  expect_error(vtb_infobasket_cross_table(50720), "expected a list", class = "hoopR_asset_fetch")
  local_vtb(list("/Widget/TeamPage/2650" = list(list(TeamID = 2650L))))
  expect_error(vtb_infobasket_team(TID), "expected an object", class = "hoopR_asset_fetch")
})

test_that("HTTP 500 and 503 are retried (every attempt waits its turn); 400 is asset_fetch on Infobasket", {
  seen <- local_vtb(list("/Widget/GamePage/921391" = turns(vtb_resp("x", 500L), vtb_resp("x", 503L),
                                                            "game_page_921391.json")))
  expect_identical(nrow(vtb_infobasket_game_page(G)), 1L)
  expect_length(seen$reqs, 3L)
  expect_identical(seen$waits, 3L)
  seen <- local_vtb(list("/Widget/GamePage/921391" = vtb_resp("x", 500L)))
  err <- expect_error(vtb_infobasket_game_page(G), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(seen$reqs, 3L)
  local_vtb(list("/Widget/GamePage/921391" = vtb_resp("x", 400L)))
  err <- expect_error(vtb_infobasket_game_page(G), class = "hoopR_asset_fetch")
  expect_identical(err$status, 400L)
  local_vtb(list("/v2/leagues" = vtb_resp("x", 400L)))
  expect_error(vtb_league_leagues(), class = "hoopR_bad_request")
})

test_that("a game must be the one asked for, final and not a stub", {
  online <- vtb_body("online_921391.json.gz")
  mutate <- function(f) {
    b <- online
    f(b)
  }
  cases <- list(
    "another game" = mutate(function(b) { b$Online$GameID <- 1L; b }),
    "another game" = mutate(function(b) { b$Online$GameID <- "921391"; b }),
    "not final" = mutate(function(b) { b$GameStatus <- 0L; b }),
    "not final" = mutate(function(b) { b$GameStatus <- 2L; b$IsOnline <- TRUE; b }),
    "not final" = mutate(function(b) { b$IsOnline <- TRUE; b }),
    "stub" = mutate(function(b) { b$GameTeams <- b$GameTeams[1]; b })
  )
  for (i in seq_along(cases)) {
    local_vtb(stats::setNames(list(cases[[i]]), paste0("/Widget/GetOnline/", G)))
    expect_error(vtb_infobasket_box_score(G), names(cases)[[i]], class = "hoopR_asset_fetch")
  }
  page <- vtb_body("game_page_921391.json")
  page$GameStatus <- 0L
  local_vtb(list("/Widget/GamePage/921391" = page))
  expect_error(vtb_infobasket_game_page(G), "not final", class = "hoopR_asset_fetch")
  page$GameStatus <- 1L
  page$GameID <- 5L
  local_vtb(list("/Widget/GamePage/921391" = page))
  expect_error(vtb_infobasket_game_page(G), "another game", class = "hoopR_asset_fetch")
  prev <- vtb_body("preview_921391.json.gz")
  local_vtb(list("/Comp/GetTeamStatsForPreview/921391" = prev[1]))
  expect_error(vtb_infobasket_team_preview(G), "two teams", class = "hoopR_asset_fetch")
})

test_that("a person or team body must echo the id asked for, and the season-scoped lists stay in scope", {
  echo <- list(
    list("/Widget/PlayerPage/423011", "player_423011.json", "PersonID", function() vtb_infobasket_player(P)),
    list("/Widget/CoachPage/131047", "coach_131047.json", "PersonID", function() vtb_infobasket_coach(131047)),
    list("/Widget/TeamPage/2650", "team_2650.json", "TeamID", function() vtb_infobasket_team(TID)),
    list("/Widget/TeamRoster/2650", "roster_2650_2026.json", "TeamID", function() vtb_infobasket_roster(TID, 2026)),
    list("/Widget/TeamStats/2650", "team_stats_2650_2026.json", "TeamID",
         function() vtb_infobasket_team_season_stats(TID, 2026))
  )
  for (e in echo) {
    b <- vtb_body(e[[2]])
    b[[e[[3]]]] <- 1L
    local_vtb(stats::setNames(list(b), e[[1]]))
    expect_error(e[[4]](), "asked for", class = "hoopR_asset_fetch")
  }
  cal <- vtb_body("calendar_2026.json")
  cal[[1]]$GameDate <- "01.10.2019"
  local_vtb(list("/Comp/GetCalendar/" = cal))
  expect_error(vtb_infobasket_calendar(2026), "another season", class = "hoopR_asset_fetch")
  games <- vtb_body("team_games_2650_2026.json")
  games[[1]]$TeamAid <- 1L
  games[[1]]$TeamBid <- 2L
  local_vtb(list("/Widget/TeamGames/2650" = games))
  expect_error(vtb_infobasket_team_games(TID, 2026), "another team", class = "hoopR_asset_fetch")
  comps <- vtb_body("team_comps_2650_2026.json")
  comps[[1]]$CompID <- 1L
  comps[[1]]$ParentCompID <- 1L
  local_vtb(list("/Widget/GetTeamComps/2650" = comps))
  expect_error(vtb_infobasket_team_comps(TID, 2026), "another season", class = "hoopR_asset_fetch")
  local_vtb(list("/Widget/PlayerStats/423011" = "player_game_log_423011.json"))
  expect_error(vtb_infobasket_player_game_log(P, 2026, team = 1), "another team", class = "hoopR_asset_fetch")
  tree <- vtb_body("comp_issue_2026.json")
  tree$ParentCompID <- 1L
  local_vtb(list("/Widget/CompIssue/50714" = tree))
  expect_error(vtb_infobasket_comp_issue(2026), "stage tree", class = "hoopR_asset_fetch")
  st <- vtb_body("standings_50720.json")
  local_vtb(list("/Widget/CompTeamResults/1" = st))
  expect_error(vtb_infobasket_standings(1), "another stage", class = "hoopR_asset_fetch")
  po <- vtb_body("playoff_54281.json")
  po[[1]]$Scores <- NULL
  local_vtb(list("/Widget/PlayOff/54281" = po))
  expect_error(vtb_infobasket_playoff(54281), "non-series", class = "hoopR_asset_fetch")
})

test_that("a partial GetTeamStats page is refused and an empty one is no_data", {
  ts <- vtb_body("team_stats_2026.json.gz")
  part <- ts
  part$Stats <- part$Stats[1:3]
  local_vtb(list("/Comp/GetTeamStats/50714" = part))
  expect_error(vtb_infobasket_team_stats(2026), "partial page", class = "hoopR_asset_fetch")
  part <- ts
  part$Pages <- 2L
  local_vtb(list("/Comp/GetTeamStats/50714" = part))
  expect_error(vtb_infobasket_team_stats(2026), "partial page", class = "hoopR_asset_fetch")
  local_vtb(list("/Comp/GetTeamStats/50714" = list(Stats = list(), Count = 0L, Page = 0L, Pages = 1L)))
  expect_error(vtb_infobasket_team_stats_players(2026), "no team totals", class = "hoopR_no_data")
})

test_that("the v2 envelope must be a complete success of the league and season asked for", {
  base <- vtb_body("league_seasons_vtb.json")
  muts <- list(
    function(b) { b$meta$status <- "error"; b },
    function(b) { b$meta$code <- 500L; b },
    function(b) { b$meta$count <- 2L; b },
    function(b) { b$meta$limit <- 3L; b },
    function(b) { b$meta <- NULL; b },
    function(b) { b$data[[1]]$league <- "wbc"; b }
  )
  for (f in muts) {
    local_vtb(list("/v2/leagues/vtb/seasons" = f(base)))
    expect_error(vtb_league_seasons("vtb"), class = "hoopR_asset_fetch")
  }
  m <- vtb_body("matches_vtb_2026.json.gz")
  m$data[[1]]$season <- 2025L
  local_vtb(list("/v2/leagues/vtb/seasons/2026/matches" = m))
  expect_error(vtb_league_matches("vtb", 2026), "another season", class = "hoopR_asset_fetch")
  local_vtb(list("/v2/leagues/vtb/seasons/2024/matches" =
                   list(meta = list(status = "success", code = 200L, count = 0L, limit = 1000L), data = list())))
  expect_error(vtb_league_matches("vtb", 2024), "no rows", class = "hoopR_no_data")
  seen <- local_vtb(list())
  expect_error(vtb_league_seasons("v/tb"), class = "hoopR_bad_request")
  expect_error(vtb_league_matches("vtb", "x"), class = "hoopR_bad_request")
  for (bad in list("x", -1, TRUE, 1.5)) expect_error(vtb_infobasket_game(bad), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

test_that("the scrub removes staff birth data, licences, contacts and betting but keeps player bio", {
  body <- list(
    LicenceNumber = "x", bet = list(a = 1L),
    Players = list(list(PersonID = 1L, PersonBirth = "01.01.2000", Email = "e")),
    Coaches = list(list(PersonID = 2L, PersonBirth = "01.01.1970", Age = 55L)),
    OnlineStarts = list(list(StartType = 1L, PersonBirth = "p"), list(StartType = 4L, PersonBirth = "o"))
  )
  out <- .vtb_scrub(body)
  expect_named(out, c("Players", "Coaches", "OnlineStarts"))
  expect_identical(out$Players[[1]], list(PersonID = 1L, PersonBirth = "01.01.2000"))
  expect_identical(out$Coaches[[1]], list(PersonID = 2L))
  expect_identical(out$OnlineStarts[[1]]$PersonBirth, "p")
  expect_null(out$OnlineStarts[[2]]$PersonBirth)
  expect_identical(.vtb_scrub(list(PersonID = 3L, PersonBirth = "x"), whole_body_is_coach = TRUE), list(PersonID = 3L))
  # the wrappers scrub before parsing: the coach page has no birth data whatever the body holds
  coach <- vtb_body("coach_131047.json")
  coach$PersonBirth <- "01.01.1960"
  local_vtb(list("/Widget/CoachPage/131047" = coach))
  expect_false("birth_date" %in% names(vtb_infobasket_coach(131047)))
  staff <- vtb_run_case("vtb_infobasket_game_staff")$out
  expect_false(any(grepl("birth|age$|licence", names(staff))))
})

test_that("every VTB helper is internal and prefixed .vtb_", {
  ns <- asNamespace("hoopR")
  exports <- getNamespaceExports("hoopR")
  expect_false(any(c("clear_cache", "conv", "decimal", "dtype_for", "finish", "flat") %in% exports))
  helpers <- ls(ns, all.names = TRUE, pattern = "^\\.vtb_|^\\.VTB_")
  expect_gt(length(helpers), 20L)
})

test_that("live: the season table and a final game answer as the fixtures do", {
  skip_intl_live()
  .vtb_clear_cache()
  withr::defer(.vtb_clear_cache())
  seasons <- vtb_infobasket_seasons()
  expect_identical(seasons$comp_id[seasons$season == 2026L], 50714L)
  box <- vtb_infobasket_box_score(G)
  expect_identical(unique(box$game_id), G)
  expect_identical(names(box), names(.vtb_specs$vtb_infobasket_box_score))
  m <- vtb_league_seasons("vtb")
  expect_true(2026L %in% m$season)
})
