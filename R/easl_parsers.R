# easl_parsers.R -- frames of the EASL wrappers (internal; parse_* is not exported).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/easl/easl_parsers.py (origin/main e3d232ebc9): every
# frame is built from `.easl_specs` (R/easl_schema.R), one type per column, never sampled. Every
# DataCore id is a UUID string; `*_row_id` columns are the sync server's own integers. Times stay
# ISO strings as sent (as in sportsdataverse-py); `dob`, `start_date` and `end_date` are Dates. `received_time`
# (epoch milliseconds, an Int64 in sportsdataverse-py) is a double: it does not fit an R integer. An empty or
# unrecognised input is a zero-row tibble with the documented columns.

#' @noRd
.easl_scalar <- function(v) !is.null(v) && is.atomic(v) && length(v) == 1L && !is.na(v)

#' A string as sent; an integer becomes its decimal text; a float or logical (never an id) is `NA`.
#' @noRd
.easl_s <- function(v) {
  if (!.easl_scalar(v)) return(NA_character_)
  if (is.character(v)) return(v)
  if (is.integer(v)) return(as.character(v))
  # a JSON integer too large for an R integer arrives as a whole double
  if (is.double(v) && is.finite(v) && v == trunc(v) && abs(v) > .Machine$integer.max) {
    return(format(v, scientific = FALSE))
  }
  NA_character_
}

#' An integer from an integer, a whole double or an integer string; never from a logical.
#' @noRd
.easl_i <- function(v) {
  if (!.easl_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) {
    if (!is.finite(v) || v != trunc(v) || abs(v) > .Machine$integer.max) return(NA_integer_)
    return(as.integer(v))
  }
  if (is.character(v) && grepl("^\\s*-?[0-9]+\\s*$", v, perl = TRUE)) return(suppressWarnings(as.integer(v)))
  NA_integer_
}

#' An sportsdataverse-py Int64 kept as a double (`received_time`, epoch milliseconds).
#' @noRd
.easl_n <- function(v) {
  if (!.easl_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(if (is.finite(v) && v == trunc(v)) as.double(v) else NA_real_)
  if (is.character(v) && grepl("^\\s*-?[0-9]+\\s*$", v, perl = TRUE)) return(as.double(v))
  NA_real_
}

#' A double from a number or a numeric string; never from a logical.
#' @noRd
.easl_f <- function(v) {
  if (!.easl_scalar(v) || is.logical(v)) return(NA_real_)
  out <- if (is.numeric(v)) as.double(v) else if (is.character(v)) suppressWarnings(as.numeric(trimws(v))) else NA_real_
  if (is.nan(out)) NA_real_ else out
}

#' @noRd
.easl_b <- function(v) if (.easl_scalar(v) && is.logical(v)) v else NA

#' A date from the first ten characters of `YYYY-MM-DD...`, as days since the epoch.
#' @noRd
.easl_d <- function(v) {
  if (!.easl_scalar(v) || !is.character(v) || !grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}", v)) return(NA_real_)
  as.double(as.Date(substr(v, 1L, 10L), format = "%Y-%m-%d"))
}

#' One column from its values and type code.
#' @noRd
.easl_column <- function(values, type) {
  switch(type,
    s = vapply(values, .easl_s, character(1), USE.NAMES = FALSE),
    i = vapply(values, .easl_i, integer(1), USE.NAMES = FALSE),
    n = vapply(values, .easl_n, double(1), USE.NAMES = FALSE),
    f = vapply(values, .easl_f, double(1), USE.NAMES = FALSE),
    b = vapply(values, .easl_b, logical(1), USE.NAMES = FALSE),
    d = structure(vapply(values, .easl_d, double(1), USE.NAMES = FALSE), class = "Date")
  )
}

#' The value at a dotted wire path (`venue.address.city`); `NULL` when a step is not an object.
#' @noRd
.easl_path <- function(obj, path) {
  for (part in strsplit(path, ".", fixed = TRUE)[[1]]) {
    if (!.easl_is_obj(obj)) return(NULL)
    obj <- obj[[part]]
  }
  obj
}

#' One row of `kind`: every spec column's raw value (`derived` first, then the wire path).
#' @noRd
.easl_row <- function(kind, obj, derived = list()) {
  spec <- .easl_specs[[kind]]
  wire <- sub("\\|[a-z]$", "", spec)
  out <- vector("list", length(spec))
  names(out) <- names(spec)
  for (j in seq_along(spec)) {
    col <- names(spec)[[j]]
    v <- if (col %in% names(derived)) derived[[col]] else if (nzchar(wire[[j]])) .easl_path(obj, wire[[j]]) else NULL
    if (!is.null(v)) out[[j]] <- v
  }
  out
}

#' The frame of `kind` over rows built by `.easl_row()` (zero rows keep the documented columns).
#' @noRd
.easl_frame <- function(kind, rows) {
  spec <- .easl_specs[[kind]]
  type <- sub("^.*\\|", "", spec)
  cols <- lapply(seq_along(spec), function(j) .easl_column(lapply(rows, `[[`, j), type[[j]]))
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

#' @noRd
.easl_request <- function(raw) .easl_obj(.easl_obj(raw)[[.EASL_REQUEST]])

#' Rows of a list route: a bare list, or `items` of the wrapped body.
#' @noRd
.easl_items <- function(raw) if (.easl_is_arr(raw)) .easl_rows(raw) else .easl_rows(.easl_obj(raw)[["items"]])

#' @noRd
.easl_minutes <- function(value) {
  if (!.easl_scalar(value) || !is.character(value)) return(NA_real_)
  re <- "^PT(?:([0-9]+)H)?(?:([0-9]+)M)?(?:([0-9]+(?:\\.[0-9]+)?)S)?$"
  m <- regmatches(value, regexec(re, value, perl = TRUE))[[1]]
  if (!length(m) || !any(nzchar(m[-1]))) return(NA_real_)
  g <- vapply(m[-1], function(x) if (nzchar(x)) as.double(x) else 0, double(1))
  round(g[[1]] * 60 + g[[2]] + g[[3]] / 60, 4)
}

#' `Q1`-`Q4` for periods 1-4; `OT1`, `OT2` ... for overtimes (the server numbers the first 11).
#' @noRd
.easl_period_label <- function(period) {
  if (is.na(period) || period < 1L) return(NA_character_)
  if (period <= 4L) return(paste0("Q", period))
  paste0("OT", if (period >= 11L) period - 10L else period - 4L)
}

#' @noRd
.easl_fixture_side_cols <- c(team_id = "teamId", name = "nameFullLocal", name_native = "nameFullLatin",
                             code_latin = "codeLatin", code_local = "codeLocal", score = "score",
                             result_place = "resultPlace", draw = "draw")

#' Derived columns of a fixture row: the request's season and the two competitors by `isHome`.
#' @noRd
.easl_fixture_ctx <- function(raw, r) {
  req <- .easl_request(raw)
  comps <- .easl_rows(r[["competitors"]])
  pick <- function(flag) Find(function(c) identical(c[["isHome"]], flag), comps) %||% list()
  out <- list(season = req[["season"]])
  if (!is.character(r[["seasonId"]]) && is.character(req[["season_id"]])) out$season_id <- req[["season_id"]]
  for (side in c("home", "away")) {
    comp <- pick(side == "home")
    for (col in names(.easl_fixture_side_cols)) {
      out[paste0(side, "_", col)] <- list(.easl_path(comp, .easl_fixture_side_cols[[col]]))
    }
  }
  out
}

#' @noRd
.easl_shape_fixtures <- function(kind, raw) {
  rows <- if (.easl_is_obj(raw) && "fixtureId" %in% names(raw)) list(raw) else .easl_items(raw)
  lapply(rows, function(r) .easl_row(kind, r, .easl_fixture_ctx(raw, r)))
}

#' @noRd
.easl_shape_box <- function(raw) {
  body <- .easl_obj(raw)
  teams <- .easl_rows(body[["teams"]])
  tids <- vapply(teams, function(t) .easl_str(t[["teamId"]]), character(1))
  fid <- .easl_request(raw)[["fixture_id"]]
  lapply(.easl_rows(body[["boxScore"]]), function(r) {
    ent <- .easl_str(r[["entityId"]])
    hit <- if (is.na(ent)) integer() else which(tids == ent)
    team <- if (length(hit)) teams[[hit[[length(hit)]]]] else list()
    minutes <- .easl_minutes(.easl_obj(r[["statistics"]])[["minutes"]])
    .easl_row("player_box", r, list(
      fixture_id = if (is.character(r[["fixtureId"]])) r[["fixtureId"]] else fid,
      player_id = r[["personId"]] %||% .easl_path(r, "player.playerId"),
      team_name = team[["nameFullLocal"]],
      team_name_native = team[["nameFullLatin"]],
      played = !is.na(minutes),
      minutes_played = minutes
    ))
  })
}

#' One row per event in DELIVERED order; `points_scored` is the change of the event team's running
#' score since the previous event (the description always says `missed`).
#' @noRd
.easl_shape_pbp <- function(raw) {
  body <- .easl_obj(raw)
  ids <- lapply(.easl_rows(body[["teams"]]), function(t) t[["teamId"]])
  ids <- c(ids, list(NULL, NULL))[1:2]
  t1 <- ids[[1]]
  t2 <- ids[[2]]
  usable <- function(x) is.character(x) && length(x) == 1L && nzchar(x)
  fid <- .easl_request(raw)[["fixture_id"]]
  last <- list()
  events <- .easl_rows(body[["playbyplay"]])
  out <- vector("list", length(events))
  for (n in seq_along(events)) {
    e <- events[[n]]
    sc <- .easl_obj(e[["scores"]])
    scores <- lapply(sc, .easl_i)
    tid <- if (is.character(e[["teamId"]])) e[["teamId"]] else NULL
    mine <- if (usable(tid)) scores[[tid]] else NULL
    if (!is.null(mine) && is.na(mine)) mine <- NULL
    others <- scores[names(scores) != (tid %||% "")]
    if (is.null(tid)) others <- scores
    pts <- if (!is.null(mine)) mine - (last[[tid]] %||% 0L) else NULL
    out[[n]] <- .easl_row("pbp", e, list(
      fixture_id = fid,
      event_number = n,
      period_label = .easl_period_label(.easl_i(e[["periodId"]])),
      team_score = mine,
      opponent_score = if (usable(tid) && length(others) == 1L) others[[1]] else NULL,
      points_scored = pts,
      team1_id = t1,
      team1_score = if (usable(t1)) scores[[t1]] else NULL,
      team2_id = t2,
      team2_score = if (usable(t2)) scores[[t2]] else NULL
    ))
    for (k in names(scores)) if (!is.na(scores[[k]])) last[[k]] <- scores[[k]]
  }
  out
}

#' @noRd
.easl_shape_team_box_by_period <- function(raw) {
  fid <- .easl_request(raw)[["fixture_id"]]
  unlist(lapply(.easl_items(raw), function(r) {
    team <- .easl_obj(r[["team"]])
    lapply(.easl_period_keys(r), function(k) {
      n <- as.integer(substring(k, 8L))
      .easl_row("team_box_by_period", list(stats = .easl_obj(r[[k]])), list(
        fixture_id = fid, team_id = team[["teamId"]], team_name = team[["nameFullLocal"]],
        team_name_native = team[["nameFullLatin"]], period = n, period_label = .easl_period_label(n)
      ))
    })
  }), recursive = FALSE) %||% list()
}

#' @noRd
.easl_shape_standings <- function(raw) {
  req <- .easl_request(raw)
  lapply(.easl_items(raw), function(r) {
    res <- vapply(.easl_rows(r[["lastFiveMatches"]]), function(m) .easl_str(m[["result"]]), character(1))
    last <- paste(res[!is.na(res)], collapse = ",")
    .easl_row("standings", r, list(season = req[["season"]], season_id = req[["season_id"]],
                                   last_five = if (nzchar(last)) last else NULL))
  })
}

#' @noRd
.easl_shape_leaders <- function(kind, raw) {
  body <- .easl_obj(raw)
  req <- .easl_request(raw)
  out <- list()
  for (category in names(body)) {
    rows <- body[[category]]
    if (category == .EASL_REQUEST || !.easl_is_arr(rows)) next
    rows <- .easl_rows(rows)
    for (rank in seq_along(rows)) {
      r <- rows[[rank]]
      out[[length(out) + 1L]] <- .easl_row(kind, r, list(season = req[["season"]], category = category,
                                                         rank = rank, value = r[[category]]))
    }
  }
  out
}

#' A single-object route (team, player, stats): the body minus the request stamp; a body none of
#' whose wire keys is present is no row.
#' @noRd
.easl_shape_one <- function(kind, raw, derived = list()) {
  body <- .easl_obj(raw)
  body <- body[names(body) != .EASL_REQUEST]
  wire <- sub("\\|[a-z]$", "", .easl_specs[[kind]])
  wire <- wire[nzchar(wire)]
  if (!any(vapply(wire, function(w) !is.null(.easl_path(body, w)), logical(1)))) return(list())
  list(.easl_row(kind, body, derived))
}

#' Parse a wrapper's stamped body (or a bare API body) into the `kind` frame.
#' @noRd
.easl_parse <- function(kind, raw) {
  req <- .easl_request(raw)
  rows <- switch(kind,
    health = .easl_shape_one(kind, raw),
    seasons = lapply(.easl_items(raw), function(r) {
      y <- .easl_i(r[["year"]])
      .easl_row(kind, r, list(season = if (is.na(y)) NULL else y + 1L))
    }),
    schedule = , game = , team_schedule = .easl_shape_fixtures(kind, raw),
    player_box = .easl_shape_box(raw),
    pbp = .easl_shape_pbp(raw),
    team_box = lapply(.easl_items(raw), function(r) .easl_row(kind, r)),
    team_box_by_period = .easl_shape_team_box_by_period(raw),
    standings = .easl_shape_standings(raw),
    leaders = , team_leaders = .easl_shape_leaders(kind, raw),
    teams = lapply(.easl_items(raw), function(r) .easl_row(kind, r)),
    team = , player = .easl_shape_one(kind, raw),
    team_stats = .easl_shape_one(kind, raw, list(team_id = req[["team_id"]], season = req[["season"]],
                                                 season_id = req[["season_id"]])),
    players = lapply(.easl_items(raw), function(r) {
      .easl_row(kind, r, list(season = req[["season"]], season_id = req[["season_id"]]))
    }),
    player_stats = .easl_shape_one(kind, raw, list(player_id = req[["player_id"]]))
  )
  .easl_frame(kind, rows)
}

#' @noRd
.easl_out <- function(df, type) make_hoopR_data(df, type, Sys.time())
