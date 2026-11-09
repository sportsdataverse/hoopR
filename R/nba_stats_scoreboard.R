#' **Get NBA Stats API Season Schedule**
#' @name nba_schedule
NULL
#' @title
#' **Get NBA Stats API Season Schedule**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @eval .returns_rd("nba_schedule", unit = "game", class = "tibble")
#' @export
#' @family NBA Schedule Functions
#' @details
#' `nba_schedule()` reads the current season's schedule for each league from
#' its own CDN host: `'00'` (NBA) from cdn.nba.com, `'10'` (WNBA) from
#' cdn.wnba.com and `'20'` (G League) from cdn-gleague.nba.com. Any other
#' `league_id` is an error. `season_type_description` labels the id's third
#' digit; `'5'` is `"Play-In Game"` only for the NBA and `NA` for the other
#' leagues, which use it for other events. The WNBA's `season` is a single
#' year (e.g. `"2026"`). The CDN serves the current season alone, so a `season`
#' you pass that differs from it prints a message; the default is not compared.
#'
#' ```r
#'  nba_schedule(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#'  nba_schedule(league_id = '20', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_schedule <- function(
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Only a season the caller asked for is compared with the CDN's: the default
  # is NBA-style "YYYY-YY", which never matches the WNBA's "YYYY".
  season_supplied <- !missing(season)
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # The stats.nba.com/stats/scheduleleaguev2 endpoint was retired upstream in
  # March 2026 (returns Connection Reset across multiple client environments;
  # see issue #184 and #187). The same payload — identical
  # leagueSchedule.gameDates[].games[] schema — is served unauthenticated from
  # the public CDN, but only for the current season. Each league has its own
  # CDN host; `scheduleLeagueV2_2.json` on cdn.nba.com is a second copy of the
  # NBA schedule (leagueId "00"), not the G League's.
  hosts <- c(
    "00" = "https://cdn.nba.com",
    "10" = "https://cdn.wnba.com",
    "20" = "https://cdn-gleague.nba.com"
  )
  league_id <- as.character(league_id)
  if (length(league_id) != 1 || !league_id %in% names(hosts)) {
    cli::cli_abort(
      "{.arg league_id} must be one of {.val {names(hosts)}} (NBA, WNBA, G League), not {.val {league_id}}."
    )
  }
  cdn_host <- paste0(hosts[[league_id]], "/static/json/staticData/scheduleLeagueV2.json")

  games <- NULL

  tryCatch(
    expr = {
      resp <- .retry_request(cdn_host, headers = .nba_cdn_headers()) %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      league_sched <- resp %>% purrr::pluck("leagueSchedule")
      cdn_season   <- league_sched$seasonYear
      # The schedule must be the requested league's: a CDN variant serving
      # another league's games is an error, never that league's schedule.
      if (!identical(as.character(league_sched$leagueId), league_id)) {
        stop(glue::glue("{cdn_host} returned leagueId {league_sched$leagueId %||% 'NULL'}, not {league_id}"))
      }

      if (season_supplied && !is.null(cdn_season) &&
          !identical(as.character(season), as.character(cdn_season))) {
        older <- c(
          "00" = "For historical seasons use `load_nba_schedule(seasons = ...)`.",
          "10" = "For historical seasons use `wehoop::load_wnba_schedule(seasons = ...)`.",
          "20" = "Only the current season is published."
        )[[league_id]]
        message(glue::glue(
          "The {c('00' = 'NBA', '10' = 'WNBA', '20' = 'G League')[[league_id]]} CDN ",
          "schedule is for season {cdn_season}, not {season}. {older}"))
      }

      games <- league_sched %>%
        purrr::pluck("gameDates") %>%
        tidyr::unnest("games") %>%
        dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
        dplyr::bind_cols(
          league_sched %>%
            purrr::pluck("gameDates") %>%
            tidyr::unnest("games") %>%
            purrr::pluck("homeTeam") %>%
            dplyr::rename_with(~ paste0("home_team_", .x))
        ) %>%
        dplyr::bind_cols(
          league_sched %>%
            purrr::pluck("gameDates") %>%
            tidyr::unnest("games") %>%
            purrr::pluck("awayTeam") %>%
            dplyr::rename_with(~ paste0("away_team_", .x))
        ) %>%
        dplyr::select(-dplyr::any_of(c("homeTeam", "awayTeam"))) %>%
        janitor::clean_names()
      colnames(games) <- gsub("team_team", "team", colnames(games))
      games$game_id <- unlist(purrr::map(games$game_id, function(x) {
        pad_id(x)
      }))
      games$season <- league_sched$seasonYear
      games$league_id <- league_sched$leagueId
      games <- games %>%
        dplyr::mutate(
          season_type_id = substr(.data$game_id, 3, 3),
          season_type_description = dplyr::case_when(
            .data$season_type_id == 1 ~ "Pre-Season",
            .data$season_type_id == 2 ~ "Regular Season",
            .data$season_type_id == 3 ~ "All-Star",
            .data$season_type_id == 4 ~ "Playoffs",
            # "5" is the NBA's Play-In only: the WNBA uses it for the
            # Commissioner's Cup final and the G League for its November-December
            # block before the regular season, so it stays NA there.
            .data$season_type_id == 5 & .data$league_id == "00" ~ "Play-In Game"
          ),
          game_date = .parse_mdy(substring(.data$game_date, 1, 10))
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league schedule data for {season} available!",
      args = .args
    ),
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Scoreboard**
#' @rdname nba_schedule
#' @name nba_scoreboard
NULL
#' @title
#' **Get NBA Stats API Scoreboard**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use `nba_scoreboardv3()` instead.
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_scoreboard", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboard(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboard <- function(
    league_id = "00",
    game_date = "2021-07-20",
    day_offset = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_scoreboard()",
    with = "nba_scoreboardv3()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple dates returned an HTML error page instead of JSON; confirmed defunct upstream. For real-time scores, prefer nba_todays_scoreboard() (see #129)."
  )

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scoreboard"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Scoreboard V2**
#' @rdname nba_schedule
#' @name nba_scoreboardv2
NULL
#' @title
#' **Get NBA Stats API Scoreboard V2**
#' @description
#' Restored in `hoopR` 3.1.0 -- a residential-IP live re-probe (2026-08-24)
#' confirmed this endpoint still serves real rows for NBA. For real-time
#' scores, prefer [nba_todays_scoreboard()] instead (see #129).
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param day_offset Day Offset (integer 0,-1)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_scoreboardv2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv2(league_id = '00', game_date = '2021-07-20')
#' ```
nba_scoreboardv2 <- function(
    league_id = "00",
    game_date = "2021-07-20",
    day_offset = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "scoreboardv2"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date,
    DayOffset = day_offset
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboardv2 data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Scoreboard V3**
#' @rdname nba_schedule
#' @name nba_scoreboardv3
NULL
#' @title
#' **Get NBA Stats API Scoreboard V3**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param game_date Game Date
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_scoreboardv3", unit = "game")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scoreboardv3(league_id = '00', game_date = '2023-03-26')
#' ```
nba_scoreboardv3 <- function(
    league_id = "00",
    game_date = "2023-03-26",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "scoreboardv3"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    GameDate = game_date
  )

  games <- .empty_hoopR_data("NBA Scoreboard V3 Information from NBA.com")

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      games <- scoreboard %>%
        purrr::pluck("games") %>%
        tidyr::unnest("homeTeam", names_sep = "_") %>%
        tidyr::unnest("awayTeam", names_sep = "_") %>%
        tidyr::unnest("gameLeaders", names_sep = "_") %>%
        tidyr::unnest("gameLeaders_homeLeaders", names_sep = "_") %>%
        tidyr::unnest("gameLeaders_awayLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders_homeLeaders", names_sep = "_") %>%
        tidyr::unnest("teamLeaders_awayLeaders", names_sep = "_")


      colnames(games) <- gsub("gameLeaders", "game", colnames(games))
      colnames(games) <- gsub("teamLeaders", "team", colnames(games))
      colnames(games) <- gsub("homeTeam", "home", colnames(games))
      colnames(games) <- gsub("awayTeam", "away", colnames(games))



      games <- games %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          game_date = game_date,
          league_id = league_id,
          league = dplyr::case_when(
            league_id == "00" ~ "NBA",
            league_id == "10" ~ "WNBA",
            league_id == "20" ~ "G-League",
            TRUE ~ "NBA"
          )
        ) %>%
        dplyr::select(
          "game_id",
          "game_code",
          "game_status",
          "game_status_text",
          "game_date",
          "game_time_utc",
          "game_et",
          dplyr::starts_with("home_team"),
          dplyr::starts_with("away_team"),
          tidyr::everything()
        ) %>%
        dplyr::relocate("broadcasters", .after = dplyr::last_col()) %>%
        make_hoopR_data("NBA Scoreboard V3 Information from NBA.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoreboard v3 data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(games)
}


#' **Get NBA Stats API Today's Scoreboard**
#' @rdname nba_schedule
#' @name nba_todays_scoreboard
NULL
#' @title
#' **Get NBA Stats API Today's Scoreboard**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_todays_scoreboard", unit = "game")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_todays_scoreboard()
#' ```
nba_todays_scoreboard <- function(
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  games <- .empty_hoopR_data("NBA Today's Scoreboard Information from NBA.com")

  tryCatch(
    expr = {
      full_url <- "https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json"
      res <- .retry_request(full_url, headers = .nba_cdn_headers())

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      scoreboard <- resp %>%
        purrr::pluck("scoreboard")

      raw_games <- scoreboard %>%
        purrr::pluck("games")

      # A day without games ships `games: []`, which fromJSON reads as an empty
      # list: that is an empty scoreboard, not an error. A payload without a
      # games list at all is a changed feed, never an empty day.
      if (!is.list(raw_games) || (!is.data.frame(raw_games) && length(raw_games) > 0)) {
        stop("the scoreboard payload has no games list")
      }
      if (is.data.frame(raw_games) && nrow(raw_games) > 0) {
        games <- raw_games %>%
          tidyr::unnest("homeTeam", names_sep = "_") %>%
          tidyr::unnest("awayTeam", names_sep = "_") %>%
          tidyr::unnest("gameLeaders") %>%
          tidyr::unnest("homeLeaders", names_sep = "_") %>%
          tidyr::unnest("awayLeaders", names_sep = "_") %>%
          tidyr::unnest("pbOdds", names_sep = "_")

        colnames(games) <- gsub("homeTeam", "home", colnames(games))
        colnames(games) <- gsub("awayTeam", "away", colnames(games))

        games <- games %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Today's Scoreboard Information from NBA.com", Sys.time())
      }
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no today's scoreboard data available!",
      args = .args
    ),
    finally = {
    }
  )
  return(games)
}



#' **Get NBA Stats API Win Probability PBP**
#' @rdname nba_schedule
#' @name nba_winprobabilitypbp
NULL
#' @title
#' **Get NBA Stats API Win Probability PBP**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_playbyplayv3()` instead.
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param run_type Run Type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_winprobabilitypbp", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')
#' ```
nba_winprobabilitypbp <- function(
    game_id = "0021700807",
    run_type = "each second",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_winprobabilitypbp()",
    with = "nba_playbyplayv3()",
    details = "Live re-probe (2026-08-24, residential IP) returned an empty response body; confirmed defunct upstream."
  )

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  # run_type <- gsub(' ', '+', run_type)
  version <- "winprobabilitypbp"
  full_url <- nba_endpoint(version)

  params <- list(
    GameID = game_id,
    RunType = run_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no win probability pbp data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API International Schedule**
#' @rdname nba_schedule
#' @name nba_scheduleleaguev2int
NULL
#' @title
#' **Get NBA Stats API International Schedule**
#' @rdname nba_schedule
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_scheduleleaguev2int", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Schedule Functions
#' @details
#' ```r
#'  nba_scheduleleaguev2int(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_scheduleleaguev2int <- function(
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 1),
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  version <- "scheduleleaguev2int"
  full_url <- nba_endpoint(version)

  params <- list(
    LeagueID = league_id,
    Season = season
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      league_sched <- resp %>%
        purrr::pluck("leagueSchedule")

      # SeasonGames
      game_dates <- league_sched %>%
        purrr::pluck("gameDates")

      if (length(game_dates) > 0) {
        games <- game_dates %>%
          tidyr::unnest("games") %>%
          dplyr::select(-dplyr::any_of(c("broadcasters", "pointsLeaders"))) %>%
          dplyr::bind_cols(
            game_dates %>%
              tidyr::unnest("games") %>%
              purrr::pluck("homeTeam") %>%
              dplyr::rename_with(~ paste0("home_team_", .x))
          ) %>%
          dplyr::bind_cols(
            game_dates %>%
              tidyr::unnest("games") %>%
              purrr::pluck("awayTeam") %>%
              dplyr::rename_with(~ paste0("away_team_", .x))
          ) %>%
          dplyr::select(-"homeTeam", -"awayTeam") %>%
          janitor::clean_names()
        colnames(games) <- gsub("team_team", "team", colnames(games))
        games$game_id <- unlist(purrr::map(games$game_id, function(x) {
          pad_id(x)
        }))
        games$season <- league_sched$seasonYear
        games$league_id <- league_sched$leagueId
      } else {
        games <- dplyr::tibble()
      }

      # SeasonWeeks
      weeks <- league_sched %>%
        purrr::pluck("weeks")
      if (!is.null(weeks) && length(weeks) > 0) {
        weeks_df <- weeks %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names()
        weeks_df$league_id <- league_sched$leagueId
        weeks_df$season_year <- league_sched$seasonYear
      } else {
        weeks_df <- dplyr::tibble()
      }

      # BroadcasterList
      broadcasters <- league_sched %>%
        purrr::pluck("broadcasters")
      if (!is.null(broadcasters) && length(broadcasters) > 0) {
        broadcast_df <- broadcasters %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names()
        broadcast_df$league_id <- league_sched$leagueId
        broadcast_df$season_year <- league_sched$seasonYear
      } else {
        broadcast_df <- dplyr::tibble()
      }

      df_list <- c(list(games), list(weeks_df), list(broadcast_df))
      names(df_list) <- c("SeasonGames", "SeasonWeeks", "BroadcasterList")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no international schedule data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
