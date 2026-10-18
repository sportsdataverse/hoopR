# Genius per-competition aliases (R/genius_competitions.R, minted by R/zzz_genius_competitions.R). Offline.

gc_path <- function(...) testthat::test_path("fixtures", "genius", ...)
gc_text <- function(rel) {
  p <- gc_path(rel)
  con <- if (grepl("\\.gz$", p)) gzfile(p, "rb") else file(p, "rb")
  on.exit(close(con))
  x <- rawToChar(readBin(con, "raw", 5e7))
  Encoding(x) <- "UTF-8"
  x
}
gc_resp <- function(status = 200L, text = "") {
  httr2::response(status_code = status, url = "https://example.invalid", body = charToRaw(enc2utf8(text)))
}
gc_re <- function(x) gsub(" ", "\\s+", x, fixed = TRUE)

# Answer by URL: `routes` maps a regex to a response, or to a list of responses served in turn.
gc_mock <- function(routes, env = parent.frame()) {
  rm(list = ls(.genius_cache, all.names = TRUE), envir = .genius_cache)
  seen <- new.env()
  seen$urls <- character()
  testthat::local_mocked_bindings(
    .intl_response = function(url, ...) {
      seen$urls <- c(seen$urls, url)
      for (re in names(routes)) {
        if (grepl(re, url)) {
          r <- routes[[re]]
          if (inherits(r, "httr2_response")) return(r)
          n <- sum(grepl(re, seen$urls))
          return(r[[min(n, length(r))]])
        }
      }
      stop("unmocked URL ", url)
    },
    .env = env, .package = "hoopR"
  )
  seen
}

GAME <- "/data/2902690/data\\.json$"
U_ESAKE <- "/u/ESAKE/2902690/$"

test_that("every registry entry mints its six exported aliases with the documented formals", {
  entries <- .intl_basketball_competitions$genius
  expect_true(all(vapply(entries, function(e) e$gender %in% c("men", "both"), logical(1))))
  exports <- getNamespaceExports("hoopR")
  for (e in entries) {
    names6 <- paste0(e$prefix, "_", c("competitions", "schedule", "team_box", "player_box", "pbp", "shots"))
    expect_true(all(names6 %in% exports))
    expect_identical(names(formals(get(names6[1]))), "return_parsed")
    expect_identical(names(formals(get(names6[2]))), c("season", "comp_id", "round_number", "return_parsed"))
    expect_identical(formals(get(names6[2]))$round_number, -1)
    for (g in names6[3:6]) expect_identical(names(formals(get(g))), c("match_id", "return_parsed"))
  }
  expect_setequal(vapply(entries, function(e) e$prefix, ""), c("slb", "bal", "nznbl", "esake", "lnbm", "lub"))
  expect_false(any(c("wbbl_pbp", "lfb_pbp") %in% exports))  # women's entries are wehoop's
  expect_identical(sort(.genius_alias_names()), sort(grep("^(slb|bal|nznbl|esake|lnbm|lub)_", exports, value = TRUE)))
})

test_that("the season maps to the chooser competition by the entry's label rule", {
  seen <- gc_mock(list(
    "/ESAKE/en/schedule$" = gc_resp(200L, gc_text("html/hosted_ESAKE_schedule.html")),
    "/ESAKE/en/competition/34541/schedule$" = gc_resp(200L, gc_text("html/hosted_ESAKE_34541_first3.html"))
  ))
  df <- esake_schedule(season = 2023)  # 'BASKET LEAGUE 2022 - 23' -> END year 2023
  expect_identical(unique(df$comp_id), 34541L)
  df_newest <- esake_schedule()  # the newest season the rule matches (2023 in this capture)
  expect_identical(unique(df_newest$comp_id), 34541L)
  expect_equal(sum(grepl("/ESAKE/en/schedule$", seen$urls)), 1L)  # the chooser is cached per process
  expect_error(esake_schedule(season = 2021), gc_re("several competitions"), class = "hoopR_bad_request")
  expect_error(esake_schedule(season = 1980), gc_re("lists no"), class = "hoopR_no_data")
  comps <- esake_competitions()
  expect_equal(nrow(comps), 47L)
})

test_that("comp_id skips the season lookup", {
  seen <- gc_mock(list("/competition/34541/schedule$" = gc_resp(200L, gc_text("html/hosted_ESAKE_34541_first3.html"))))
  expect_equal(nrow(esake_schedule(comp_id = 34541)), 3L)
  expect_identical(seen$urls, "https://hosted.dcd.shared.geniussports.com/ESAKE/en/competition/34541/schedule")
})

test_that("a game alias returns the base frame once the /u/ shell proves the competition", {
  game <- gc_resp(200L, gc_text("full/data_2902690.json.gz"))
  seen <- gc_mock(list(GAME = game, "/u/ESAKE/2902690/$" = gc_resp(200L, gc_text("html/u_ESAKE_2902690.html"))) |>
                    stats::setNames(c(GAME, U_ESAKE)))
  pbp <- esake_pbp(2902690)
  expect_equal(nrow(pbp), 663L)
  expect_identical(names(pbp), names(.genius_schemas$pbp))
  esake_shots(2902690)
  expect_equal(sum(grepl(U_ESAKE, seen$urls)), 1L)  # the shell check is cached per process
})

test_that("a game of another org or competition is refused", {
  game <- gc_resp(200L, gc_text("full/data_2902690.json.gz"))
  gc_mock(stats::setNames(list(game, gc_resp(403L, "<Error><Code>AccessDenied</Code></Error>")),
                          c(GAME, "/u/FRB/2902690/$")))
  expect_error(lnbm_pbp(2902690), gc_re("is not a Liga Nationala"), class = "hoopR_asset_fetch")
  gc_mock(stats::setNames(list(game, gc_resp(200L, gc_text("html/u_ESAKE_2902690.html"))),
                          c(GAME, "/u/SLB/2902690/$")))
  expect_error(slb_team_box(2902690), gc_re("belongs to 'Stoiximan GBL 2026-2027'"), class = "hoopR_asset_fetch")
})

test_that("a transient shell failure is retried once; a second one or a refusal stops the frame", {
  game <- gc_resp(200L, gc_text("full/data_2902690.json.gz"))
  u <- gc_resp(200L, gc_text("html/u_ESAKE_2902690.html"))
  down <- gc_resp(503L, "down")
  seen <- gc_mock(stats::setNames(list(game, list(down, u)), c(GAME, U_ESAKE)))
  expect_equal(nrow(esake_player_box(2902690)), 24L)
  expect_equal(sum(grepl(U_ESAKE, seen$urls)), 2L)
  gc_mock(stats::setNames(list(game, list(down, down)), c(GAME, U_ESAKE)))
  err <- expect_error(esake_pbp(2902690), gc_re("could not run"), class = "hoopR_asset_fetch")
  expect_match(conditionMessage(err), "twice")
  blocked <- gc_resp(403L, "Request blocked. Generated by cloudfront (CloudFront)")
  seen <- gc_mock(stats::setNames(list(game, blocked), c(GAME, U_ESAKE)))
  expect_error(esake_pbp(2902690), gc_re("could not run"), class = "hoopR_asset_fetch")
  expect_equal(sum(grepl(U_ESAKE, seen$urls)), 1L)  # a refusal is not retried
})

test_that("label rules are case-insensitive include-and-not-exclude", {
  e <- .genius_entry("nznbl")
  expect_identical(.genius_label_ok(e, c("SALS NBL 2025", "NATIONAL BASKETBALL LEAGUE", "National Basketball League Rapid", NA)),
                   c(TRUE, TRUE, FALSE, FALSE))
})
