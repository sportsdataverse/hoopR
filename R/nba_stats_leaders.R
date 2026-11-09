#' **Get NBA Stats API All-time Leaders Grid**
#' @name nba_alltimeleadersgrids
NULL
#' @title
#' **Get NBA Stats API All-time Leaders Grid**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param top_x Top X
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_alltimeleadersgrids", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_alltimeleadersgrids(league_id = '00')
#' ```

nba_alltimeleadersgrids <- function(
    league_id = '00',
    per_mode = 'PerGame',
    season_type = 'Regular Season',
    top_x = 10,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "alltimeleadersgrids"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    SeasonType = season_type,
    TopX = top_x
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no all-time leaders grid data for {league_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Assist Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_assistleaders
NULL
#' @title
#' **Get NBA Stats API Assist Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param player_or_team Player or Team
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_assistleaders", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_assistleaders(league_id = '00', player_or_team = "Player")
#'  nba_assistleaders(league_id = '00', player_or_team = "Team")
#' ```
nba_assistleaders <- function(
    league_id = '00',
    per_mode = 'PerGame',
    player_or_team = 'Team',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ','+',season_type)
  version <- "assistleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    PlayerOrTeam = player_or_team,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no assist leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
#' **Get NBA Stats API Assist Tracker**
#' @rdname nba_alltimeleadersgrids
#' @name nba_assisttracker
NULL
#' @title
#' **Get NBA Stats API Assist Tracker**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AssistTracker
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'   nba_assisttracker(league_id = '00')
#' ```
nba_assisttracker <- function(
    league_id = '00',
    per_mode = 'PerGame',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  version <- "assisttracker"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    Season = season,
    SeasonType = season_type)

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no assist tracker data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Homepage Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_homepageleaders
NULL
#' @title
#' **Get NBA Stats API Homepage Leaders**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead. Note: `stat_category = "Defense"` was
#' never supported upstream by this endpoint even before deprecation (#51).
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat_category Stat Category: Points, Rebounds, Assists, Defense, Clutch, Playmaking, Efficiency, Fast Break, Scoring Breakdown
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_homepageleaders", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_homepageleaders(league_id = '00', player_or_team = "Player")
#'  nba_homepageleaders(league_id = '00', player_or_team = "Team")
#' ```
nba_homepageleaders <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    stat_category = 'Points',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_homepageleaders()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple league/season/player_or_team combinations returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # Intentional
  # season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "homepageleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope =  game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    StatCategory = stat_category
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no homepage leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API HomepageV2 Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_homepagev2
NULL
#' @title
#' **Get NBA Stats API HomepageV2 Leaders**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead.
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat_type Stat Type - Traditional, Advanced, Tracking
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_homepagev2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_homepagev2(league_id = '00', player_or_team = "Player")
#'  nba_homepagev2(league_id = '00', player_or_team = "Team")
#' ```

nba_homepagev2 <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    stat_type = 'Traditional',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_homepagev2()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # Intentional
  # season_type <- gsub(' ','+',season_type)
  stat_type <- gsub(' ','+',stat_type)
  version <- "homepagev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    StatType = stat_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no homepage v2 data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Leaders Tiles**
#' @rdname nba_alltimeleadersgrids
#' @name nba_leaderstiles
NULL
#' @title
#' **Get NBA Stats API Leaders Tiles**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_leagueleaders()` instead.
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param stat Stat - PTS, REB, AST, FG_PCT, FT_PCT, FG3_PCT, STL, BLK
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leaderstiles", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_leaderstiles(league_id = '00', player_or_team = "Player")
#'  nba_leaderstiles(league_id = '00', player_or_team = "Team")
#' ```

nba_leaderstiles <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    stat = 'PTS',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_leaderstiles()",
    with = "nba_leagueleaders()",
    details = "Live re-probe (2026-08-24, residential IP) returned HTTP 200 with consistently empty result sets; not restored."
  )

  player_scope <- gsub(' ','+',player_scope)
  # season_type <- gsub(' ','+',season_type)
  stat <- gsub(' ','+',stat)
  version <- "leaderstiles"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type,
    Stat = stat
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no leaders tiles data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Defense Hub**
#' @rdname nba_alltimeleadersgrids
#' @name nba_defensehub
NULL
#' @title
#' **Get NBA Stats API Defense Hub**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param game_scope Game Scope - Season, Last 10, ,Yesterday, Finals
#' @param player_or_team Player or Team
#' @param player_scope Player Scope - All Players, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DefenseHubStat1, DefenseHubStat10, DefenseHubStat2, DefenseHubStat3, DefenseHubStat4, DefenseHubStat5, DefenseHubStat6,
#' DefenseHubStat7, DefenseHubStat8, DefenseHubStat9
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_defensehub(league_id = '00', player_or_team = "Player")
#'  nba_defensehub(league_id = '00', player_or_team = "Team")
#' ```

nba_defensehub <- function(
    league_id = '00',
    game_scope = 'Season',
    player_or_team = 'Team',
    player_scope = 'All Players',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  player_scope <- gsub(' ','+',player_scope)
  # season_type <- gsub(' ','+',season_type)
  version <- "defensehub"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameScope = game_scope,
    PlayerOrTeam = player_or_team,
    PlayerScope = player_scope,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defense hub data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API League Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_leagueleaders
NULL
#' @title
#' **Get NBA Stats API League Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param active_flag Active Flag
#' @param scope Scope - RS, S, Rookies
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_leagueleaders", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' [League Leaders](https://www.nba.com/stats/leaders)
#' ```r
#'  nba_leagueleaders(league_id = '00')
#' ```

nba_leagueleaders <- function(
    active_flag = '',
    league_id = '00',
    per_mode = 'Totals',
    scope = 'S',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    stat_category = 'PTS',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  scope <- gsub(' ','+',scope)
  # season_type <- gsub(' ','+',season_type)
  stat_category <- gsub(' ','+',stat_category)
  version <- "leagueleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    ActiveFlag = active_flag,
    PerMode = per_mode,
    Scope = scope,
    Season = season,
    SeasonType = season_type,
    StatCategory = stat_category
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no league leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Dunk Score Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_dunkscoreleaders
NULL
#' @title
#' **Get NBA Stats API Dunk Score Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param player_id Player ID filter (optional, leave empty for all players)
#' @param team_id Team ID filter (optional, leave empty for all teams)
#' @param game_id Game ID filter (optional, leave empty for all games)
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_dunkscoreleaders")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_dunkscoreleaders(season = year_to_season(most_recent_nba_season() - 2))
#' ```
nba_dunkscoreleaders <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    player_id = '',
    team_id = '',
    game_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "dunkscoreleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type
  )
  if (nchar(player_id) > 0) params[["PlayerID"]] <- player_id
  if (nchar(team_id) > 0) params[["TeamID"]] <- team_id
  if (nchar(game_id) > 0) params[["GameID"]] <- game_id

  df_list <- list()
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      dunks <- resp %>%
        purrr::pluck("dunks")

      if (length(dunks) > 0) {
        data <- dunks %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("Dunk Score Leaders from NBA.com", Sys.time())
      } else {
        data <- dplyr::tibble()
      }

      df_list <- c(list(data))
      names(df_list) <- c("DunkScoreLeaders")

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no dunk score leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Gravity Leaders**
#' @rdname nba_alltimeleadersgrids
#' @name nba_gravityleaders
NULL
#' @title
#' **Get NBA Stats API Gravity Leaders**
#' @rdname nba_alltimeleadersgrids
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_gravityleaders")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Leaders Functions
#' @details
#' ```r
#'  nba_gravityleaders(season = year_to_season(most_recent_nba_season() - 2))
#' ```
nba_gravityleaders <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "gravityleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      leaders <- resp %>%
        purrr::pluck("leaders")

      if (length(leaders) > 0) {
        data <- leaders %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) %>%
          janitor::clean_names() %>%
          make_hoopR_data("Gravity Leaders from NBA.com", Sys.time())
      } else {
        data <- dplyr::tibble()
      }

      df_list <- c(list(data))
      names(df_list) <- c("GravityLeaders")

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no gravity leaders data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
