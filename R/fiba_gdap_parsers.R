# fiba_gdap_parsers.R -- body -> rows shapers of the fiba_gdap_* wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/fiba_hub/fiba_gdap_parsers.py (not exported: the
# parse_* functions are not ported). A route is parsed by the shaper that fits its body:
#   * a list body is its rows (schedules, teams, awards, national teams, medal table, editions);
#   * an object body is one row (a game header, a competition, a player's season line);
#   * a body that nests rows under a list key is exploded with its parent's ids (a roster is its
#     players, a team's statistics one row per player, a round's group standings one row per team);
#   * nested objects flatten into <parent>_<child> columns and remaining list cells are JSON strings.
# Ids are integer (one type per id): player_id is global, team_id per team PER COMPETITION,
# organisation_id the stable federation or club, game_id global, competition_id one per edition.
# Percentages are 0-100.

#' The object rows of a list body, or of the one list an envelope object holds (sdv-py `_list_rows`).
#' @noRd
.fiba_list_rows <- function(raw) {
  if (.fiba_is_obj(raw)) {
    lists <- names(raw)[vapply(raw, .fiba_is_arr, logical(1))]
    others <- raw[setdiff(names(raw), lists)]
    if (length(lists) != 1L || any(vapply(others, .fiba_is_obj, logical(1)))) return(list())
    raw <- raw[[lists]]
  }
  if (.fiba_is_arr(raw)) Filter(.fiba_is_obj, raw) else list()
}

#' The object rows of a body (sdv-py `fiba_frames._rows`): a list is its objects, an object with
#' one list key (and only scalars beside it) is that list, any other non-empty object is one row.
#' @noRd
.fiba_rows <- function(raw) {
  if (.fiba_is_arr(raw)) return(Filter(.fiba_is_obj, raw))
  if (.fiba_is_obj(raw) && length(raw)) {
    lists <- names(raw)[vapply(raw, .fiba_is_arr, logical(1))]
    others <- raw[setdiff(names(raw), lists)]
    if (length(lists) == 1L && !any(vapply(others, is.list, logical(1)))) {
      return(Filter(.fiba_is_obj, raw[[lists]]))
    }
    return(list(raw))
  }
  list()
}

#' An id as integer: an integer, a digit string or a `P_123` / `T_64` key; otherwise `NULL`
#' (sdv-py `fiba_frames._id`: a float is never an id, a logical is not an integer).
#' @noRd
.fiba_id <- function(value) {
  if (is.null(value) || length(value) != 1L || is.na(value) || is.logical(value)) return(NULL)
  if (is.integer(value)) return(value)
  if (is.character(value)) {
    txt <- trimws(value)
    if (grepl("^[A-Za-z]_[0-9]+$", txt)) txt <- sub("^[A-Za-z]_", "", txt)
    if (grepl("^[0-9]+$", txt)) return(as.integer(txt))
  }
  NULL
}

#' Rows of each route's body, keyed by route (sdv-py `_sh_*`).
#' @noRd
.fiba_gdap_shapers <- list(
  flat = function(raw) lapply(.fiba_list_rows(.fiba_scrub(raw)), .fiba_row),
  obj = function(key) function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    if (!is.null(body[[key]])) list(.fiba_row(body)) else list()
  },
  nominations = function(raw) lapply(.fiba_list_rows(.fiba_scrub(raw, root_staff = TRUE)), .fiba_row),
  game_header = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    if (!is.null(body[["gameId"]])) list(.fiba_row(.fiba_without(body, "nominations", "periods"))) else list()
  },
  game_child = function(key) function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(game_id = body[["gameId"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[[key]])), .fiba_row, head = head)
  },
  rounds = function(raw) lapply(.fiba_rows(.fiba_scrub(raw)), function(r) .fiba_row(.fiba_without(r, "groupStandings"))),
  round_standings = function(raw) {
    out <- list()
    for (rnd in .fiba_rows(.fiba_scrub(raw))) {
      head <- list(round_id = rnd[["roundId"]], round_name = rnd[["roundName"]], round_code = rnd[["roundCode"]])
      for (grp in .fiba_list(.fiba_dict(rnd[["groupStandings"]])[["groups"]])) {
        grp <- .fiba_dict(grp)
        ghead <- c(head, list(group_name = grp[["groupName"]], group_status_code = grp[["statusCode"]]))
        for (team in Filter(.fiba_is_obj, .fiba_list(grp[["teams"]]))) out[[length(out) + 1L]] <- .fiba_row(team, ghead)
      }
    }
    out
  },
  final_standings = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(competition_id = .fiba_dict(body[["competition"]])[["competitionId"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[["standings"]])), .fiba_row, head = head)
  },
  round_gamedays = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(competition_id = .fiba_dict(body[["competition"]])[["competitionId"]])
    lapply(.fiba_list(body[["rounds"]]), function(item) {
      item <- .fiba_dict(item)
      .fiba_row(list(round = .fiba_without(item[["round"]], "groupStandings"), gamedays = item[["gamedays"]]), head)
    })
  },
  team_staff = function(raw) {
    out <- list()
    for (team in .fiba_rows(.fiba_scrub(raw))) {
      head <- list(team_id = team[["teamId"]], team_name = team[["teamName"]], team_code = team[["teamCode"]])
      out <- c(out, lapply(Filter(.fiba_is_obj, .fiba_list(team[["coaches"]])), .fiba_row, head = head))
    }
    out
  },
  roster = function(key) function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(team_id = body[["teamId"]], team_code = body[["code"]], team_name = body[["name"]],
                 organisation_id = body[["teamOrganisationId"]], competition_id = body[["competitionId"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[[key]])), .fiba_row, head = head)
  },
  team_stats = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    if (is.null(body[["teamId"]])) return(list())
    obj <- .fiba_without(body, "playerInCompetitionTeamStatistics", "benchStatistics")
    obj["bench"] <- list(body[["benchStatistics"]])
    list(.fiba_row(obj))
  },
  team_player_stats = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(competition_id = body[["competitionId"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[["playerInCompetitionTeamStatistics"]])), .fiba_row, head = head)
  },
  player_game_stats = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(player_id = body[["playerId"]], competition_id = body[["competitionId"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[["gameStatistics"]])), .fiba_row, head = head)
  },
  ranking = function(raw) {
    body <- .fiba_dict(.fiba_scrub(raw))
    head <- list(as_of_date = body[["asOfDate"]], zone_ranking_code = body[["zoneRankingCode"]],
                 zone_ranking_official_name = body[["zoneRankingOfficialName"]])
    lapply(Filter(.fiba_is_obj, .fiba_list(body[["items"]])), .fiba_row, head = head)
  },
  competition_ids = function(raw) {
    ids <- lapply(.fiba_list(.fiba_dict(.fiba_scrub(raw))[["competitionIds"]]), .fiba_id) # numeric strings
    lapply(Filter(Negate(is.null), ids), function(i) list(competition_id = i))
  }
)

#' Route -> its shaper.
#' @noRd
.fiba_gdap_shaper <- function(route) {
  s <- .fiba_gdap_shapers
  switch(route,
    schedule = , games_between = , editions = , teams = , awards = , team_games = , federation_games = ,
    national_teams = , medal_count = , ranking_zones = s[["flat"]],
    game = s[["game_header"]],
    game_periods = s[["game_child"]]("periods"),
    game_officials = s[["game_child"]]("nominations"),
    competition = s[["obj"]]("competitionId"),
    player_info = , player_stats = s[["obj"]]("playerId"),
    rounds = s[["rounds"]],
    round_standings = s[["round_standings"]],
    final_standings = s[["final_standings"]],
    round_gamedays = s[["round_gamedays"]],
    nominations = s[["nominations"]],
    team_staff = s[["team_staff"]],
    roster = , roster_latest = s[["roster"]]("players"),
    roster_coaches = s[["roster"]]("coaches"),
    team_stats = s[["team_stats"]],
    team_player_stats = s[["team_player_stats"]],
    player_game_stats = s[["player_game_stats"]],
    federation_ranking = , gateway_federation_ranking = s[["ranking"]],
    gateway_competition_ids = s[["competition_ids"]],
    stop("unknown fiba_gdap route: ", route)
  )
}

#' A GDAP body as the route's typed tibble (a zero-row tibble with the documented columns for an
#' empty or malformed body).
#' @noRd
.fiba_gdap_parse <- function(route, raw) {
  rows <- tryCatch(.fiba_gdap_shaper(route)(raw), error = function(e) list())
  .fiba_finish(.fiba_frame(rows), paste0("fiba_gdap_", route))
}

#' The body of a fiba_gdap_* wrapper: fetch, check, parse.
#' @noRd
.fiba_gdap_route <- function(route, method, params, return_parsed = TRUE, call = rlang::caller_env()) {
  raw <- .fiba_gdap(method, params, call = call)
  if (!isTRUE(return_parsed)) return(raw)
  .fiba_data(.fiba_gdap_parse(route, raw), paste0("fiba_gdap_", route))
}
