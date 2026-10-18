# Atrium (Sportradar embed API): every wrapper on the committed fixtures, at parity
# with sdv-py's frame on the SAME fixture (parity/*.csv + parity/dtypes.csv, see the
# fixtures README), plus the zero-row contract, the END-year mapping and the aliases.

atrium_fx <- function(name) {
  paste(readLines(testthat::test_path("fixtures", "atrium", name), warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}
atrium_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
atrium_clear_cache <- function() rm(list = ls(.atrium_seasons_cache), envir = .atrium_seasons_cache)

F12 <- "5423072b-6715-11f0-bd8b-9ffadebc148f"
F14 <- "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"
PERSON <- "4458f165-f865-11f0-8ebf-539c931c1654"
TEAM <- "f43b1b0f-55bc-11f0-84d9-01499d2f0a07"
COMP <- "3f4064bb-51ad-11f0-aaaf-2923c944b404"

# case -> wrapper, fixture, arguments (sdv-py export_parity.py runs the parser on the same fixture)
atrium_cases <- list(
  fixtures_12 = list(atrium_fixtures, "12__fixtures.json", list(website_id = 12)),
  fixtures_14 = list(atrium_fixtures, "14__fixtures__default.json", list(website_id = 14)),
  seasons_12 = list(atrium_seasons, "12__fixtures.json", list(website_id = 12)),
  seasons_14 = list(atrium_seasons, "14__fixtures__default.json", list(website_id = 14)),
  ribbon_14 = list(atrium_fixtures_ribbon, "14__fixtures_ribbon.json", list(website_id = 14)),
  fixture_12 = list(atrium_fixture, "full/12__fixture_detail__statistics.json", list(website_id = 12, fixture_id = F12)),
  fixture_14 = list(atrium_fixture, "full/14__fixture_detail__statistics.json", list(website_id = 14, fixture_id = F14)),
  periods_12 = list(atrium_fixture_periods, "full/12__fixture_detail__statistics.json", list(website_id = 12, fixture_id = F12)),
  periods_14 = list(atrium_fixture_periods, "full/14__fixture_detail__statistics.json", list(website_id = 14, fixture_id = F14)),
  box_12 = list(atrium_box_score, "full/12__fixture_detail__statistics.json", list(website_id = 12, fixture_id = F12)),
  box_14 = list(atrium_box_score, "full/14__fixture_detail__statistics.json", list(website_id = 14, fixture_id = F14)),
  team_box_12 = list(atrium_team_box_score, "full/12__fixture_detail__statistics.json", list(website_id = 12, fixture_id = F12)),
  team_box_14 = list(atrium_team_box_score, "full/14__fixture_detail__statistics.json", list(website_id = 14, fixture_id = F14)),
  pbp_14 = list(atrium_pbp, "14__fixture_detail__pbp.json", list(website_id = 14, fixture_id = F14)),
  pbp_12 = list(atrium_pbp, "12__fixture_detail__pbp.json", list(website_id = 12, fixture_id = F12)),
  pbp_3 = list(atrium_pbp, "3__fixture_detail__pbp.json", list(website_id = 3, fixture_id = "a541adc5-83e7-11f1-9127-15b828f83402")),
  shots_14 = list(atrium_shots, "14__fixture_detail__shot_chart.json", list(website_id = 14, fixture_id = F14)),
  standings_12 = list(atrium_standings, "12__standings.json", list(website_id = 12)),
  standings_14 = list(atrium_standings, "14__standings.json", list(website_id = 14)),
  standings_summary_12 = list(atrium_standings_summary, "12__standings_fragment.json", list(website_id = 12)),
  teams_12 = list(atrium_teams, "12__entities.json", list(website_id = 12)),
  team_12 = list(atrium_team, "12__entity_detail.json", list(website_id = 12, entity_id = TEAM)),
  players_12 = list(atrium_players, "12__persons.json", list(website_id = 12)),
  player_12 = list(atrium_player, "12__person_detail.json", list(website_id = 12, person_id = PERSON)),
  player_seasons_12 = list(atrium_player_seasons, "12__person_detail.json", list(website_id = 12, person_id = PERSON)),
  player_game_log_12 = list(atrium_player_game_log, "12__person_detail__log.json", list(website_id = 12, person_id = PERSON)),
  leaders_12 = list(atrium_leaders, "12__statistics_leaders.json", list(website_id = 12)),
  player_stats_12 = list(atrium_player_stats, "12__statistics_persons.json", list(website_id = 12)),
  team_stats_12 = list(atrium_team_stats, "12__statistics_entities.json", list(website_id = 12)),
  competition_player_stats_12 = list(atrium_competition_player_stats, "12__statistics_competition_persons.json",
                                     list(website_id = 12, competition_id = COMP)),
  competition_team_stats_12 = list(atrium_competition_team_stats, "12__statistics_competition_entities.json",
                                   list(website_id = 12, competition_id = COMP))
)

atrium_dtypes <- utils::read.csv(testthat::test_path("fixtures", "atrium", "parity", "dtypes.csv"), colClasses = "character")

# venue-local wall-clock columns: naive Datetime in sdv-py, the API's string in R (the zone varies per row)
atrium_local_col <- function(col) grepl("start_time_local$", col)

# polars dtype -> the R class that carries it
atrium_r_class <- function(dtype, col = "") {
  if (atrium_local_col(col)) return("character")
  if (startsWith(dtype, "Datetime")) return("POSIXct")
  c(Int64 = "integer", Float64 = "numeric", String = "character", Boolean = "logical", Date = "Date",
    Null = "logical")[[dtype]]
}

# Cells that differ from sdv-py's CSV, NA-vs-value counted as a mismatch.
atrium_mismatches <- function(r, py) {
  out <- integer()
  for (col in names(py)) {
    x <- r[[col]]
    b <- py[[col]]
    if (is.double(x) && !inherits(x, c("POSIXct", "Date"))) {
      bn <- suppressWarnings(as.numeric(b))
      bad <- xor(is.na(x), is.na(bn)) | (!is.na(x) & !is.na(bn) & abs(x - bn) > 1e-9)
    } else {
      a <- if (inherits(x, "POSIXct")) format(x, "%Y-%m-%d %H:%M:%S", tz = "UTC") else if (is.logical(x)) {
        tolower(as.character(x))
      } else as.character(x)
      if (atrium_local_col(col)) a <- sub("T", " ", a, fixed = TRUE) # the API's ISO 'T' vs polars' CSV space
      bad <- xor(is.na(a), is.na(b)) | (!is.na(a) & !is.na(b) & a != b)
    }
    if (any(bad)) out[[col]] <- sum(bad)
  }
  out
}

test_that("venue-local start times stay the API's strings; UTC instants are POSIXct UTC", {
  atrium_clear_cache()
  body <- atrium_fx(atrium_cases$fixtures_12[[2]])
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) body)
  r <- do.call(atrium_cases$fixtures_12[[1]], atrium_cases$fixtures_12[[3]])
  expect_type(r$start_time_local, "character")
  expect_identical(r$start_time_local[[1]], "2026-05-16T19:00:00")
  expect_s3_class(r$start_time_utc, "POSIXct")
  expect_identical(attr(r$start_time_utc, "tzone"), "UTC")
  expect_identical(format(r$start_time_utc[[1]], "%Y-%m-%d %H:%M:%S", tz = "UTC"), "2026-05-16 17:00:00")
})

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, types, cells)", {
  for (case in names(atrium_cases)) {
    spec <- atrium_cases[[case]]
    atrium_clear_cache()
    body <- atrium_fx(spec[[2]])
    local_mocked_bindings(.intl_get = function(url, query = list(), ...) body)
    r <- do.call(spec[[1]], spec[[3]])
    py <- intl_read_oracle(testthat::test_path("fixtures", "atrium", "parity", paste0(case, ".csv")))
    types <- atrium_dtypes[atrium_dtypes$case == case, ]
    expect_s3_class(r, "hoopR_data")
    expect_identical(names(r), types$column, label = paste(case, "columns"))
    expect_identical(nrow(r), nrow(py), label = paste(case, "rows"))
    for (i in seq_len(nrow(types))) {
      expect_true(inherits(r[[types$column[[i]]]], atrium_r_class(types$dtype[[i]], types$column[[i]])),
                  label = paste(case, types$column[[i]], "is", types$dtype[[i]]))
    }
    expect_identical(atrium_mismatches(r, py), integer(), label = paste(case, "mismatched cells"))
  }
})

test_that("ids are character, website_id and scores integer, never a stringified float", {
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) atrium_fx("14__fixture_detail__pbp.json"))
  pbp <- atrium_pbp(14, F14)
  for (col in c("fixture_id", "season_id", "event_id", "entity_id", "person_id")) expect_type(pbp[[col]], "character")
  for (col in c("website_id", "sequence", "period_id", "clock_seconds", "home_score", "away_score")) {
    expect_type(pbp[[col]], "integer")
  }
  expect_false(any(grepl("\\.0$", pbp$event_id)))
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) atrium_fx("12__statistics_persons.json"))
  stats <- atrium_player_stats(12)
  expect_type(stats$person_id, "character")
  expect_true(all(grepl("^[0-9a-f-]{36}$", stats$person_id))) # decoded from the widget links
})

test_that("an empty or malformed body parses to a zero-row tibble with the documented columns", {
  for (key in names(.atrium_schemas)) {
    parser <- switch(key, stat_tables = .atrium_parse_stat_tables, get(paste0(".atrium_parse_", key)))
    for (raw in list(list(), list(data = list()), "not json")) {
      out <- parser(raw)
      expect_identical(nrow(out), 0L)
      expect_identical(names(out), names(.atrium_schemas[[key]]))
    }
  }
  out <- .atrium_parse_box_score(list())
  expect_type(out$person_id, "character")
  expect_type(out$points, "integer")
  expect_type(out$field_goals_percentage, "double")
  expect_s3_class(.atrium_parse_fixtures(list())$start_time_utc, "POSIXct")
})

test_that("a site without a season list gives a zero-row season frame, not an error", {
  b <- jsonlite::parse_json(atrium_fx("14__fixtures__default.json"))
  b$data$seasons <- NULL
  b$links$self <- "https://embed-api.eui.connect.sportradar.com/v1/embed/236/fixtures"
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) atrium_json(b))
  out <- atrium_seasons(236)
  expect_identical(nrow(out), 0L)
  expect_identical(names(out), names(.atrium_schemas$seasons))
})

test_that("a statistic key the schema does not list is appended, and a column widens instead of nulling", {
  b <- jsonlite::parse_json(atrium_fx("full/14__fixture_detail__statistics.json"))
  row <- b$data$statistics$data$base$home$persons[[1]]$rows[[1]]
  row$statistics$newCount <- 3L
  row$statistics$points <- 7.5
  b$data$statistics$data$base$home$persons[[1]]$rows[[1]] <- row
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) atrium_json(b))
  out <- atrium_box_score(14, F14)
  expect_identical(utils::tail(names(out), 1), "new_count")
  expect_type(out$new_count, "integer")
  expect_type(out$points, "double") # Int64 that met a fraction -> Float64, as polars does
  expect_identical(out$points[[1]], 7.5)
})

test_that("atrium_end_year maps the site's year to the END year", {
  expect_identical(atrium_end_year(12, 2025), 2026L) # LNB: START year
  expect_identical(atrium_end_year(14, 2026), 2026L) # calendar year
  expect_identical(atrium_end_year(3, c(2024, 2025)), c(2024L, 2025L))
  expect_identical(atrium_end_year(236, 2026), NA_integer_) # no season list
  expect_identical(atrium_end_year(999, 2026), NA_integer_)
  expect_identical(atrium_end_year(12, "2025"), NA_integer_)
  expect_identical(atrium_end_year(12, 2025.5), NA_integer_)
  seasons <- .atrium_parse_seasons(jsonlite::parse_json(atrium_fx("12__fixtures.json")))
  expect_identical(seasons$season_end_year, seasons$year + 1L)
})

test_that("the season argument is the END year, mapped to the seasonId of the site's list", {
  atrium_clear_cache()
  sent <- list()
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) {
    sent[[length(sent) + 1L]] <<- list(url = url, query = query)
    if (is.null(query$seasonId)) atrium_fx("12__fixtures.json") else atrium_fx("12__standings.json")
  })
  out <- atrium_standings(12, season = 2026, competition_id = COMP) # LNB 2025-26 = site year 2025
  expect_identical(unique(out$season_end_year), 2026L)
  expect_length(sent, 2L)
  expect_identical(sent[[2]]$query, list(seasonId = "df310a05-51ad-11f0-bd89-c735508e1e09"))
  expect_error(atrium_standings(12, season = 2025, competition_id = COMP), class = "hoopR_no_data") # the START year
})

test_that("the aliases are minted from the registry, bound to its website_id", {
  reg <- .intl_basketball_competitions$atrium
  expect_true(all(vapply(reg, function(e) e$gender %in% c("men", "both"), logical(1))))
  names <- as.vector(outer(vapply(reg, `[[`, "", "prefix"), names(.atrium_alias_specs), paste, sep = "_"))
  expect_length(names, 40L)
  ns <- asNamespace("hoopR")
  expect_true(all(names %in% getNamespaceExports(ns)))
  expect_identical(names(formals(ns$lnb_schedule)), c("season", "season_id", "competition_id", "locale"))
  expect_identical(names(formals(ns$nbl1_pbp)), c("fixture_id", "locale"))
  urls <- character()
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) {
    urls <<- c(urls, url)
    stop("stop here")
  })
  for (e in reg) try(ns[[paste0(e$prefix, "_seasons")]](), silent = TRUE)
  expect_identical(urls, sprintf("https://embed-api.eui.connect.sportradar.com/v1/embed/%d/fixtures",
                                 vapply(reg, function(e) as.integer(e$ids$website_id), 1L)))
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) atrium_fx("14__fixture_detail__pbp.json"))
  expect_identical(nrow(lnbp_pbp(F14)), nrow(atrium_pbp(14, F14)))
  expect_identical(.atrium_competition_rd("not_a_site"), "@noRd")
})

test_that("live: the LNBP schedule and the LNB season list", {
  skip_intl_live()
  atrium_clear_cache()
  seasons <- atrium_seasons(12)
  expect_true(all(c("season_id", "season_end_year") %in% names(seasons)))
  expect_true(nrow(seasons) > 0)
  games <- lnbp_schedule()
  expect_identical(names(games), names(.atrium_schemas$fixtures))
})
