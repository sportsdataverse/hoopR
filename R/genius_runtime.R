# genius_runtime.R -- Genius Sports LiveStats: transport, page records and frame parsers (internal).
#
# R mirror of sdv-py sportsdataverse/basketball/genius/{genius_runtime,genius_parsers}.py
# (sdv-py origin/main e3d232e). Three keyless hosts:
#   fibalivestats.dcd.shared.geniussports.com  /data/{matchId}/data.json, /data/competition/{compId}.json,
#                                               the /u/{ORG}/{matchId}/ HTML shell
#   hosted.dcd.shared.geniussports.com          hosted WebStats pages (chooser, schedules, /embednf/)
#   widget.wh.geniussports.com                  a league site's results widget (JavaScript)
#
# Proxy: CloudFront refuses datacenter IPs on the first two hosts. The runtime reads
# getOption("hoopR.proxy") or env GENIUS_PROXY; the value is never printed.
#
# Two 403s, never read one as the other: CloudFront "Request blocked" (the egress IP is
# refused: hoopR_asset_fetch, definitive) and S3 AccessDenied (no such object: hoopR_no_data).
# HTTP 500 "A website error has occurred" is an intermittent host-side failure that sticks to a
# URL for minutes: hoopR_asset_fetch with transient = TRUE, not retried inline (sdv-py #870).
# A body for another scope than the one asked for, a cut-off page, an error envelope or an
# unfinished game is hoopR_asset_fetch.

.GENIUS_PROXY_ENV <- "GENIUS_PROXY"
.GENIUS_LIVE <- "fibalivestats.dcd.shared.geniussports.com"
.GENIUS_HOSTED <- "hosted.dcd.shared.geniussports.com"
.GENIUS_WIDGET <- "widget.wh.geniussports.com"

# Public site-widget keys (embedded in each league site's page) -> the webcast ORG their games carry.
.GENIUS_WIDGET_KEYS <- c(
  RFJIN037I07QV520B7WEXKV1GYNA31 = "ESAKE",
  TXMFPAVMWV2N5ML0BJYODXOEWWIQKS = "FRB",
  D2PNKMOFTN2CRLP1HIXPX89RH3GUMC = "NZN"
)

# ORG -> season shape: split = two calendar years (Genius year = START year), calendar = one year.
.GENIUS_ORG_SPAN <- c(
  ESAKE = "split", POL = "split", HKS = "split", FRB = "split", CBFFE = "split", BNXT = "split",
  CEBL = "calendar", BSN = "calendar", LNBP = "calendar", NZNBL = "calendar", NZN = "calendar",
  BAL = "calendar", IBBA = "split", FFBB = "split", WBBL = "split", SLB = "split", FUBB = "split",
  NBL = "split", SPB = "calendar"
)

.genius_routes <- list(
  list(.GENIUS_LIVE, "^/data/(\\d+)/data\\.json$", "data"),
  list(.GENIUS_LIVE, "^/data/competition/(\\d+)\\.json$", "competition"),
  list(.GENIUS_LIVE, "^/u/([A-Za-z0-9]+)/(\\d+)/?$", "u"),
  list(.GENIUS_HOSTED, "^/([A-Za-z0-9]+)/en/schedule/?$", "chooser"),
  list(.GENIUS_HOSTED, "^/([A-Za-z0-9]+)/en/competition/(\\d+)/schedule/?$", "schedule"),
  list(.GENIUS_HOSTED, "^/embednf/([A-Za-z0-9]+)/en/competition/(\\d+)/schedule/?$", "embednf"),
  list(.GENIUS_WIDGET, "^/widget/?$", "widget")
)

# ------------------------------------------------------------------------------ schemas

.genius_snake <- function(x) tolower(gsub("([a-z0-9])([A-Z])", "\\1_\\2", x, perl = TRUE))

# (wire key, type) of the per-player stats, tm.<tno>.pl.<pno>.<key>
.genius_player_stats <- c(
  sFieldGoalsMade = "integer", sFieldGoalsAttempted = "integer", sFieldGoalsPercentage = "double",
  sThreePointersMade = "integer", sThreePointersAttempted = "integer", sThreePointersPercentage = "double",
  sTwoPointersMade = "integer", sTwoPointersAttempted = "integer", sTwoPointersPercentage = "double",
  sFreeThrowsMade = "integer", sFreeThrowsAttempted = "integer", sFreeThrowsPercentage = "double",
  sReboundsDefensive = "integer", sReboundsOffensive = "integer", sReboundsTotal = "integer",
  sAssists = "integer", sTurnovers = "integer", sSteals = "integer", sBlocks = "integer",
  sBlocksReceived = "integer", sFoulsPersonal = "integer", sFoulsOn = "integer", sPoints = "integer",
  sPointsFromTurnovers = "integer", sPointsSecondChance = "integer", sPointsFastBreak = "integer",
  sPointsInThePaint = "integer", sPlusMinusPoints = "integer",
  eff_1 = "integer", eff_2 = "integer", eff_3 = "double", eff_4 = "double", eff_5 = "integer",
  eff_6 = "integer", eff_7 = "integer"
)
# team totals tm.<tno>.tot_<key>: the player stats bar plus-minus, then team-only counters
.genius_team_stats <- c(
  .genius_player_stats[names(.genius_player_stats) != "sPlusMinusPoints"],
  sBenchPoints = "integer", sBiggestLead = "integer", sBiggestScoringRun = "integer",
  sLeadChanges = "integer", sTimesScoresLevel = "integer", sTimeLeading = "double",
  sFoulsTeam = "integer", sFoulsTotal = "integer", sReboundsTeam = "integer",
  sReboundsTeamDefensive = "integer", sReboundsTeamOffensive = "integer", sTurnoversTeam = "integer"
)
.genius_stat_col <- function(key) ifelse(startsWith(key, "eff_"), key, .genius_snake(substring(key, 2)))
.genius_stat_schema <- function(stats) stats |> rlang::set_names(.genius_stat_col(names(stats)))

.genius_schedule_schema <- c(
  match_id = "integer", link_match_id = "integer", comp_id = "integer", org = "character",
  status = "character", date_time = "character", venue_id = "integer", venue_name = "character",
  home_team_id = "integer", home_team_name = "character", home_team_code = "character",
  home_score = "integer", away_team_id = "integer", away_team_name = "character",
  away_team_code = "character", away_score = "integer"
)

# The pinned columns and types of every frame (sdv-py genius_parsers.SCHEMAS).
.genius_schemas <- list(
  game = c(
    match_id = "integer", period = "integer", period_type = "character", in_ot = "integer",
    clock = "character", periods_max = "integer", period_length_regular = "integer",
    period_length_overtime = "integer", attendance = "integer", disable_match = "integer",
    total_time_added = "integer", team1_name = "character", team1_code = "character",
    team1_score = "integer", team2_name = "character", team2_code = "character", team2_score = "integer",
    referee1 = "character", referee2 = "character", referee3 = "character", commissioner = "character"
  ),
  team_box = c(
    match_id = "integer", tno = "integer", name = "character", name_international = "character",
    short_name = "character", code = "character", code_international = "character", coach = "character",
    score = "integer", full_score = "integer", p1_score = "integer", p2_score = "integer",
    p3_score = "integer", p4_score = "integer", ot_score = "integer", fouls = "integer",
    timeouts = "integer", minutes = "character", seconds_played = "integer",
    .genius_stat_schema(.genius_team_stats)
  ),
  player_box = c(
    match_id = "integer", tno = "integer", pno = "integer", name = "character", first_name = "character",
    family_name = "character", international_first_name = "character",
    international_family_name = "character", scoreboard_name = "character", shirt_number = "character",
    playing_position = "character", starter = "integer", captain = "integer", active = "integer",
    minutes = "character", seconds_played = "integer",
    .genius_stat_schema(.genius_player_stats)
  ),
  pbp = c(
    match_id = "integer", row_index = "integer", action_number = "integer", previous_action = "integer",
    period = "integer", period_type = "character", gt = "character", clock = "character", tno = "integer",
    pno = "integer", player = "character", shirt_number = "character", first_name = "character",
    family_name = "character", international_first_name = "character",
    international_family_name = "character", scoreboard_name = "character", action_type = "character",
    sub_type = "character", qualifier = "character", success = "integer", scoring = "integer",
    score_1 = "integer", score_2 = "integer", lead = "integer"
  ),
  shots = c(
    match_id = "integer", tno = "integer", pno = "integer", action_number = "integer", period = "integer",
    period_type = "character", action_type = "character", sub_type = "character", result = "integer",
    x = "double", y = "double", player = "character", shirt_number = "character"
  ),
  competition_games = c(
    league_id = "integer", competition_id = "integer", match_id = "integer", match_status = "character",
    match_time = "character", match_time_utc = "character", live = "integer", period = "integer",
    period_type = "character", clock = "character", home_team_id = "integer", home_name = "character",
    home_name_international = "character", home_code = "character", home_score = "integer",
    away_team_id = "integer", away_name = "character", away_name_international = "character",
    away_code = "character", away_score = "integer"
  ),
  match_competition = c(
    match_id = "integer", comp_id = "integer", competition_name = "character", org_label = "character",
    og_description = "character", org = "character"
  ),
  competitions = c(
    org = "character", comp_id = "integer", label = "character", league_id = "integer", year = "integer",
    season = "integer", season_rule = "character", selected = "logical"
  ),
  schedule = .genius_schedule_schema,
  widget_games = c(
    match_id = "integer", webcast_org = "character", competition_name = "character", status = "character",
    date = "character", home_team_id = "integer", home_team_code = "character", home_score = "integer",
    away_team_id = "integer", away_team_code = "character", away_score = "integer"
  )
)

# ------------------------------------------------------------------------------ scalars
# JSON objects parse to named lists, arrays to unnamed lists (jsonlite, simplifyVector = FALSE).

.genius_is_dict <- function(x) is.list(x) && !is.null(names(x))
.genius_is_array <- function(x) is.list(x) && is.null(names(x))
.genius_scalar <- function(v) !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)

#' An integer from an int, an integral double or a digit string; NA otherwise (logicals too).
#' @noRd
.genius_int <- function(v) {
  if (!.genius_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) return(if (v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_)
  if (is.character(v) && grepl("^\\s*-?\\d+\\s*$", v, perl = TRUE)) return(suppressWarnings(as.integer(v)))
  NA_integer_
}

.genius_num <- function(v) {
  if (!.genius_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v)) return(suppressWarnings(as.double(trimws(v))))
  NA_real_
}

#' Python str() of a scalar: NA for NULL / lists, "True"/"False" for logicals, "5.0" for a whole double.
#' @noRd
.genius_str <- function(v) {
  if (!.genius_scalar(v)) return(NA_character_)
  if (is.logical(v)) return(if (v) "True" else "False")
  if (is.double(v) && v == trunc(v) && abs(v) < 1e16) return(paste0(format(v, scientific = FALSE), ".0"))
  as.character(v)
}

.genius_lgl <- function(v) if (.genius_scalar(v) && is.logical(v)) v else NA

.genius_cast <- function(v, type) {
  switch(type, integer = .genius_int(v), double = .genius_num(v), logical = .genius_lgl(v), .genius_str(v))
}

#' "35:08" -> 2108; an integer or other text -> NA.
#' @noRd
.genius_seconds <- function(v) {
  if (!.genius_scalar(v) || !is.character(v)) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*(\\d+):(\\d{1,2})\\s*$", v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_integer_)
  as.integer(m[2]) * 60L + as.integer(m[3])
}

#' Python truthiness of a parsed JSON value.
#' @noRd
.genius_truthy <- function(v) {
  if (is.null(v) || length(v) == 0L) return(FALSE)
  if (is.list(v)) return(TRUE)
  if (is.na(v)) return(FALSE)
  if (is.character(v)) return(nzchar(v))
  as.logical(v)
}

#' `rows` (a list of named lists) as the pinned frame `name`: missing keys are NA, extra keys dropped.
#' @noRd
.genius_frame <- function(rows, name) {
  schema <- .genius_schemas[[name]]
  if (!length(rows)) return(.empty_tibble(schema))
  proto <- list(integer = NA_integer_, double = NA_real_, logical = NA, character = NA_character_)
  cols <- lapply(names(schema), function(col) {
    type <- schema[[col]]
    vapply(rows, function(r) .genius_cast(r[[col]], type), proto[[type]], USE.NAMES = FALSE)
  })
  dplyr::as_tibble(rlang::set_names(cols, names(schema)))
}

.genius_req <- function(raw) {
  r <- if (.genius_is_dict(raw)) raw[["_request"]] else NULL
  if (.genius_is_dict(r)) r else list()
}

.genius_game_ok <- function(raw) .genius_is_dict(raw) && .genius_is_dict(raw[["tm"]]) && .genius_is_array(raw[["pbp"]])

# ------------------------------------------------------------------------------ data.json frames

.genius_parse_game <- function(raw) {
  if (!.genius_game_ok(raw)) return(.genius_frame(list(), "game"))
  tm <- raw[["tm"]]
  off <- if (.genius_is_dict(raw[["officials"]])) raw[["officials"]] else list()
  person <- function(role, flat) {
    node <- off[[role]]
    if (!.genius_is_dict(node)) return(.genius_str(raw[[flat]]))
    first <- node[["internationalFirstName"]]
    if (.genius_truthy(first)) {
      # sdv-py's f-string writes a null family name as "None"; a null part is skipped here
      parts <- vapply(list(first, node[["internationalFamilyName"]]), .genius_str, "")
      return(paste(parts[!is.na(parts)], collapse = " "))
    }
    s <- .genius_str(first)
    if (.genius_truthy(s)) s else .genius_str(node[["name"]])
  }
  row <- list(
    match_id = .genius_req(raw)[["match_id"]], period = raw[["period"]], period_type = raw[["periodType"]],
    in_ot = raw[["inOT"]], clock = raw[["clock"]], periods_max = raw[["periodsMax"]],
    period_length_regular = raw[["periodLengthREGULAR"]], period_length_overtime = raw[["periodLengthOVERTIME"]],
    attendance = raw[["attendance"]], disable_match = raw[["disableMatch"]],
    total_time_added = raw[["totalTimeAdded"]],
    referee1 = person("referee1", "officials_referee1"), referee2 = person("referee2", "officials_referee2"),
    referee3 = person("referee3", "officials_referee3"),
    commissioner = person("commissioner", "officials_commissioner")
  )
  for (tno in c("1", "2")) {
    t <- if (.genius_is_dict(tm[[tno]])) tm[[tno]] else list()
    row[[paste0("team", tno, "_name")]] <- t[["name"]]
    row[[paste0("team", tno, "_code")]] <- t[["code"]]
    row[[paste0("team", tno, "_score")]] <- t[["score"]]
  }
  .genius_frame(list(row), "game")
}

.genius_parse_team_box <- function(raw) {
  if (!.genius_game_ok(raw)) return(.genius_frame(list(), "team_box"))
  tm <- raw[["tm"]]
  keys <- names(tm)
  keys <- keys[order(!grepl("^[0-9]+$", keys), keys, method = "radix")]
  rows <- list()
  for (tno in keys) {
    t <- tm[[tno]]
    if (!.genius_is_dict(t) || is.na(.genius_int(tno))) next
    row <- list(
      match_id = .genius_req(raw)[["match_id"]], tno = .genius_int(tno), name = t[["name"]],
      name_international = t[["nameInternational"]], short_name = t[["shortName"]], code = t[["code"]],
      code_international = t[["codeInternational"]], coach = t[["coach"]], score = t[["score"]],
      full_score = t[["full_score"]], p1_score = t[["p1_score"]], p2_score = t[["p2_score"]],
      p3_score = t[["p3_score"]], p4_score = t[["p4_score"]], ot_score = t[["ot_score"]],
      fouls = t[["fouls"]], timeouts = t[["timeouts"]], minutes = t[["tot_sMinutes"]],
      seconds_played = .genius_seconds(t[["tot_sMinutes"]])
    )
    for (key in names(.genius_team_stats)) row[[.genius_stat_col(key)]] <- t[[paste0("tot_", key)]]
    rows[[length(rows) + 1L]] <- row
  }
  .genius_frame(rows, "team_box")
}

.genius_parse_player_box <- function(raw) {
  if (!.genius_game_ok(raw)) return(.genius_frame(list(), "player_box"))
  rows <- list()
  for (tno in names(raw[["tm"]])) {
    t <- raw[["tm"]][[tno]]
    pls <- if (.genius_is_dict(t)) t[["pl"]] else NULL
    if (!.genius_is_dict(pls) || is.na(.genius_int(tno))) next
    for (pno in names(pls)) {
      p <- pls[[pno]]
      if (!.genius_is_dict(p) || is.na(.genius_int(pno))) next
      row <- list(
        match_id = .genius_req(raw)[["match_id"]], tno = .genius_int(tno), pno = .genius_int(pno),
        name = p[["name"]], first_name = p[["firstName"]], family_name = p[["familyName"]],
        international_first_name = p[["internationalFirstName"]],
        international_family_name = p[["internationalFamilyName"]], scoreboard_name = p[["scoreboardName"]],
        shirt_number = p[["shirtNumber"]], playing_position = p[["playingPosition"]], starter = p[["starter"]],
        captain = p[["captain"]], active = p[["active"]], minutes = p[["sMinutes"]],
        seconds_played = .genius_seconds(p[["sMinutes"]])
      )
      for (key in names(.genius_player_stats)) row[[.genius_stat_col(key)]] <- p[[key]]
      rows[[length(rows) + 1L]] <- row
    }
  }
  .genius_frame(rows, "player_box")
}

.genius_parse_pbp <- function(raw) {
  if (!.genius_game_ok(raw)) return(.genius_frame(list(), "pbp"))
  mid <- .genius_req(raw)[["match_id"]]
  rows <- list()
  for (i in seq_along(raw[["pbp"]])) {
    r <- raw[["pbp"]][[i]]
    if (!.genius_is_dict(r)) next
    q <- r[["qualifier"]]
    qual <- if (.genius_is_array(q)) {
      # a null code is skipped (sdv-py joins it as "None"); an empty list joins to "" as in sdv-py
      codes <- vapply(q, .genius_str, "")
      paste(codes[!is.na(codes)], collapse = ",")
    } else if (.genius_truthy(q)) q else NULL
    rows[[length(rows) + 1L]] <- list(
      match_id = mid, row_index = i - 1L, action_number = r[["actionNumber"]],
      previous_action = r[["previousAction"]], period = r[["period"]], period_type = r[["periodType"]],
      gt = r[["gt"]], clock = r[["clock"]], tno = r[["tno"]], pno = r[["pno"]], player = r[["player"]],
      shirt_number = r[["shirtNumber"]], first_name = r[["firstName"]], family_name = r[["familyName"]],
      international_first_name = r[["internationalFirstName"]],
      international_family_name = r[["internationalFamilyName"]], scoreboard_name = r[["scoreboardName"]],
      action_type = r[["actionType"]], sub_type = r[["subType"]], qualifier = qual, success = r[["success"]],
      scoring = r[["scoring"]], score_1 = r[["s1"]], score_2 = r[["s2"]], lead = r[["lead"]]
    )
  }
  .genius_frame(rows, "pbp")
}

.genius_parse_shots <- function(raw) {
  if (!.genius_game_ok(raw)) return(.genius_frame(list(), "shots"))
  rows <- list()
  for (tno in names(raw[["tm"]])) {
    t <- raw[["tm"]][[tno]]
    shots <- if (.genius_is_dict(t)) t[["shot"]] else NULL
    if (!.genius_is_array(shots)) next  # a dict iterates its keys in Python: no rows either
    for (s in shots) {
      if (!.genius_is_dict(s)) next
      rows[[length(rows) + 1L]] <- list(
        match_id = .genius_req(raw)[["match_id"]],
        tno = if ("tno" %in% names(s)) s[["tno"]] else .genius_int(tno),
        pno = s[["pno"]], action_number = s[["actionNumber"]], period = s[["per"]],
        period_type = s[["perType"]], action_type = s[["actionType"]], sub_type = s[["subType"]],
        result = s[["r"]], x = s[["x"]], y = s[["y"]], player = s[["player"]],
        shirt_number = s[["shirtNumber"]]
      )
    }
  }
  .genius_frame(rows, "shots")
}

.genius_competition_map <- c(
  league_id = "leagueId", competition_id = "competitionId", match_id = "matchId",
  match_status = "matchStatus", match_time = "matchTime", match_time_utc = "matchTimeUTC", live = "live",
  period = "period", period_type = "periodType", clock = "clock", home_team_id = "hometeamId",
  home_name = "homename", home_name_international = "homenameInternational", home_code = "homecode",
  home_score = "homescore", away_team_id = "awayteamId", away_name = "awayname",
  away_name_international = "awaynameInternational", away_code = "awaycode", away_score = "awayscore"
)

.genius_parse_competition_games <- function(raw) {
  rows <- if (.genius_is_array(raw)) Filter(.genius_is_dict, raw) else list()
  rows <- lapply(rows, function(r) lapply(.genius_competition_map, function(w) r[[w]]))
  .genius_frame(rows, "competition_games")
}

# ------------------------------------------------------------------------------ HTML records

.genius_not_parsed <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "genius_not_parsed", empty = empty)
}

#' First match of `pattern` in `x` as a character vector (full match, then groups); character(0) when none.
#' A group that did not take part is "".
#' @noRd
.genius_re1 <- function(pattern, x) regmatches(x, regexec(pattern, x, perl = TRUE))[[1]]

#' Every match of `pattern` in `x`: a character matrix, one row per match, one column per group.
#' @noRd
.genius_re_all <- function(pattern, x, ngroups) {
  m <- regmatches(x, gregexec(pattern, x, perl = TRUE))[[1]]
  if (!length(m)) return(matrix(character(), 0L, ngroups))
  t(m)[, -1L, drop = FALSE]
}

.genius_strip <- function(x) gsub("(*UCP)^\\s+|\\s+$", "", x, perl = TRUE)

#' Python `html.unescape()` (libxml2 decodes the entities; a literal "<" is kept).
#' @noRd
.genius_unescape <- function(x) {
  if (!grepl("&", x, fixed = TRUE)) return(x)
  doc <- rvest::read_html(paste0("<html><body><p>", gsub("<", "&lt;", x, fixed = TRUE), "</p></body></html>"),
                          encoding = "UTF-8")
  rvest::html_text(rvest::html_element(doc, "p"))
}

#' Tags dropped, entities decoded, whitespace collapsed and stripped.
#' @noRd
.genius_text <- function(fragment) {
  x <- .genius_unescape(gsub("<[^>]+>", " ", fragment %||% "", perl = TRUE))
  .genius_strip(gsub("(*UCP)\\s+", " ", x, perl = TRUE))
}

.genius_int_or_na <- function(x) if (length(x) && nzchar(x)) as.integer(x) else NA_integer_

.genius_parse_u <- function(page) {
  mid <- .genius_re1('id\\s*=\\s*"matchId"\\s+value\\s*=\\s*"(\\d+)"', page)
  cid <- .genius_re1('id\\s*=\\s*"compId"\\s+value\\s*=\\s*"(\\d+)"', page)
  name <- .genius_re1('id="competitionName"[^>]*>([^<]*)<', page)
  desc <- .genius_re1('og:description"\\s+content\\s*=\\s*"([^"]*)"', page)
  d <- if (length(desc)) .genius_unescape(desc[2]) else NULL
  list(
    match_id = if (length(mid)) as.integer(mid[2]) else NA_integer_,
    comp_id = if (length(cid)) as.integer(cid[2]) else NA_integer_,
    competition_name = if (length(name)) .genius_text(name[2]) else NA_character_,
    org_label = if (!is.null(d)) .genius_strip(sub(",.*$", "", d)) else NA_character_,
    og_description = if (!is.null(d)) .genius_strip(d) else NA_character_
  )
}

.genius_compdata <- paste0(
  "compdata\\.push\\(\\['(https://[^']*/competition/(\\d+)/schedule)','((?:[^'\\\\]++|\\\\.)*+)',",
  "\\s*(\\d+),\\s*'(\\d*)',\\s*(\\d+)\\]\\)"
)

.genius_parse_chooser <- function(page) {
  m <- .genius_re_all(.genius_compdata, page, 6L)
  rows <- list()
  seen <- character()
  for (i in seq_len(nrow(m))) {
    cid <- m[i, 2]
    if (cid != m[i, 6] || cid %in% seen) next
    seen <- c(seen, cid)
    rows[[length(rows) + 1L]] <- list(
      comp_id = as.integer(cid),
      label = .genius_strip(.genius_unescape(gsub("\\'", "'", m[i, 3], fixed = TRUE))),
      league_id = as.integer(m[i, 4]),
      year = .genius_int_or_na(m[i, 5]),
      org = sub("^https://[^/]*/([^/]*).*$", "\\1", m[i, 1])
    )
  }
  sel <- .genius_re1('/competition/(\\d+)/schedule"\\s+SELECTED', page)
  list(selected_comp_id = if (length(sel)) as.integer(sel[2]) else NA_integer_, competitions = rows)
}

.genius_team <- function(block, side) {
  part <- .genius_re1(paste0('(?s)<div class="', side, '-team">(.*?)<div class="team-score ', side,
                      'score">\\s*<div class="fake-cell">([^<]*)</div>'), block)
  if (!length(part)) return(list(team_id = NA_integer_, team_name = NA_character_, team_code = NA_character_,
                                 score = NA_integer_))
  body <- part[2]
  tid <- .genius_re1("/team/(\\d+)", body)
  full <- .genius_re1('team-name-full">([^<]*)<', body)
  code <- .genius_re1('team-name-code">([^<]*)<', body)
  list(
    team_id = if (length(tid)) as.integer(tid[2]) else NA_integer_,
    team_name = if (length(full)) .genius_text(full[2]) else NA_character_,
    team_code = if (length(code)) .genius_text(code[2]) else NA_character_,
    score = .genius_int(gsub("\u00a0", " ", .genius_unescape(part[3]), fixed = TRUE))
  )
}

.genius_parse_schedule <- function(page) {
  # Python re.split(r'(?=<div class="match-wrap )', page)[1:]: each block starts at its marker
  marker <- '<div class="match-wrap '
  blocks <- paste0(marker, strsplit(page, marker, fixed = TRUE)[[1]][-1])
  matches <- list()
  for (b in blocks) {
    head <- .genius_re1('^<div class="match-wrap STATUS_(\\w+)"\\s+id\\s*=\\s*"extfix_(\\d+)"', b)
    if (!length(head)) next
    link <- .genius_re1("/([A-Za-z0-9]+)/en/competition/(\\d+)/match/(\\d+)/", b)
    ctx <- if (length(link)) link else .genius_re1("/([A-Za-z0-9]+)/en/competition/(\\d+)/team/\\d+", b)
    when <- .genius_re1('(?s)class="match-time">.*?<span>([^<]*)</span>', b)
    venue <- .genius_re1('(?:/venue/(\\d+)\\?"\\s+class="venuename"|class\\s*=\\s*"venuename")>([^<]*)<', b)
    home <- .genius_team(b, "home")
    away <- .genius_team(b, "away")
    matches[[length(matches) + 1L]] <- c(
      list(
        match_id = as.integer(head[3]),
        link_match_id = if (length(link)) as.integer(link[4]) else NA_integer_,
        comp_id = if (length(ctx)) as.integer(ctx[3]) else NA_integer_,
        org = if (length(ctx)) ctx[2] else NA_character_,
        status = head[2],
        date_time = if (length(when)) .genius_text(when[2]) else NA_character_,
        venue_id = if (length(venue)) .genius_int_or_na(venue[2]) else NA_integer_,
        venue_name = if (length(venue)) .genius_text(venue[3]) else NA_character_
      ),
      rlang::set_names(home, paste0("home_", names(home))),
      rlang::set_names(away, paste0("away_", names(away)))
    )
  }
  list(matches = matches)
}

.genius_parse_embednf <- function(text) {
  env <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) NULL)
  if (is.null(env)) .genius_not_parsed("the embed body is not JSON")
  html <- if (.genius_is_dict(env)) env[["html"]] else NULL
  if (!(is.character(html) && length(html) == 1L)) .genius_not_parsed("the embed body is not a {css, js, html} envelope")
  .genius_parse_schedule(html)
}

.genius_parse_widget <- function(js) {
  m <- .genius_re1('(?s)var html = ("(?:[^"\\\\]++|\\\\.)*+")\\s*;', js)
  if (!length(m)) .genius_not_parsed("the widget script has no 'var html' payload")
  page <- tryCatch(jsonlite::parse_json(m[2]), error = function(e) NULL)
  if (!is.character(page)) .genius_not_parsed("the widget 'var html' payload is not a string literal")
  lis <- .genius_re_all('(?s)<li class="spls_lsmatch[^"]*">(.*?)</li>', page, 1L)[, 1]
  rows <- lapply(lis, function(li) {
    link <- .genius_re1("/webcast/(\\w+)/(\\d+)/", li)
    teams <- .genius_re_all(paste0('(?s)<span class="spteam tid(\\d+)">.*?<span class="teamname">([^<]*)</span>',
                            '<span class="score[^"]*">([^<]*)</span>'), li, 3L)
    teams <- rbind(teams, matrix(NA_character_, 2L, 3L))[1:2, , drop = FALSE]
    comp <- .genius_re1('spls_matchcomp">([^<]*)<', li)
    status <- .genius_re1('spls_matchstatus">([^<]*)<', li)
    date <- .genius_re1('spls_datefield">([^<]*)<', li)
    code <- function(x) if (!is.na(x) && nzchar(x)) .genius_text(x) else NA_character_
    list(
      match_id = if (length(link)) as.integer(link[3]) else NA_integer_,
      webcast_org = if (length(link)) link[2] else NA_character_,
      competition_name = if (length(comp)) .genius_text(comp[2]) else NA_character_,
      status = if (length(status)) .genius_text(status[2]) else NA_character_,
      date = if (length(date)) .genius_text(date[2]) else NA_character_,
      home_team_id = .genius_int(teams[1, 1]), home_team_code = code(teams[1, 2]),
      home_score = .genius_int(teams[1, 3]),
      away_team_id = .genius_int(teams[2, 1]), away_team_code = code(teams[2, 2]),
      away_score = .genius_int(teams[2, 3])
    )
  })
  list(matches = rows)
}

#' Reduce a fetched page to its record (the sdv-internal-refs capture shape).
#'
#' Raises a `genius_not_parsed` condition (field `empty`: TRUE for a legitimate
#' "nothing here") for an empty, cut-off or wrong-kind page.
#' @noRd
.genius_page_record <- function(kind, text) {
  if (!nzchar(.genius_strip(text %||% ""))) {
    .genius_not_parsed("empty body (an org without hosted pages answers an empty 200)", empty = TRUE)
  }
  if (kind %in% c("u", "chooser", "schedule") && !endsWith(sub("(*UCP)\\s+$", "", text, perl = TRUE), "</html>")) {
    .genius_not_parsed("the page is cut off (no closing </html>)")
  }
  if (kind == "u") {
    rec <- .genius_parse_u(text)
    if (is.na(rec$match_id) || is.na(rec$comp_id)) .genius_not_parsed("the page has no matchId / compId inputs")
    return(rec)
  }
  if (kind == "chooser") {
    rec <- .genius_parse_chooser(text)
    if (!length(rec$competitions)) {
      .genius_not_parsed("the page lists no competitions", empty = !grepl("competitionChooser", text, fixed = TRUE))
    }
    return(rec)
  }
  rec <- switch(kind,
                schedule = .genius_parse_schedule(text),
                embednf = .genius_parse_embednf(text),
                widget = .genius_parse_widget(text))
  if (!length(rec$matches)) {
    .genius_not_parsed(if (kind == "widget") "the widget lists no matches" else "the page lists no matches",
                       empty = TRUE)
  }
  rec
}

# ------------------------------------------------------------------------------ HTML-record frames

.genius_parse_match_competition <- function(raw) {
  if (!.genius_is_dict(raw) || !.genius_scalar(raw[["match_id"]])) return(.genius_frame(list(), "match_competition"))
  .genius_frame(list(c(raw, list(org = .genius_req(raw)[["org"]]))), "match_competition")
}

#' The sdv END-year season of a competition, and the rule that produced it.
#'
#' 1. A two-year span in the label ("2019 - 20", "2023-2024", "26-27") gives its second year.
#' 2. Else the Genius year: START year + 1 for a split org, the year itself for a calendar org.
#' 3. Else a lone four-digit year in the label of a calendar org.
#' @return `list(season, rule)`; `list(NA, "unknown")` when no rule applies.
#' @noRd
.genius_season_end <- function(label, year, span) {
  label <- if (.genius_scalar(label)) as.character(label) else ""
  m <- .genius_re1("(?<!\\d)((?:19|20)\\d{2}|\\d{2})\\s*[-/\u2013]\\s*((?:19|20)\\d{2}|\\d{2})(?!\\d)", label)
  if (length(m)) {
    a <- m[2]
    b <- m[3]
    start <- if (nchar(a) == 4L) as.integer(a) else 2000L + as.integer(a)
    end <- if (nchar(b) == 4L) as.integer(b) else (start %/% 100L) * 100L + as.integer(b)
    if (end < start) end <- end + 100L
    if (end == start + 1L) return(list(season = end, rule = "label span"))
  }
  if (.genius_truthy(year) && .genius_truthy(span)) {
    year <- as.integer(year)
    return(if (span == "split") list(season = year + 1L, rule = "genius year + 1 (split)")
           else list(season = year, rule = "genius year (calendar)"))
  }
  m <- .genius_re1("(?<!\\d)((?:19|20)\\d{2})(?!\\d)", label)
  if (length(m) && identical(span, "calendar")) return(list(season = as.integer(m[2]), rule = "label year (calendar)"))
  list(season = NA_integer_, rule = "unknown")
}

.genius_parse_competitions <- function(raw) {
  comps <- if (.genius_is_dict(raw)) raw[["competitions"]] else NULL
  org <- .genius_req(raw)[["org"]]
  sel <- if (.genius_is_dict(raw)) raw[["selected_comp_id"]] else NULL
  rows <- list()
  for (cmp in comps %||% list()) {
    if (!.genius_is_dict(cmp)) next
    c_org <- if (.genius_truthy(cmp[["org"]])) cmp[["org"]] else org
    span <- unname(.GENIUS_ORG_SPAN[toupper(if (.genius_truthy(c_org)) as.character(c_org) else "")])
    if (length(span) != 1L || is.na(span)) span <- NULL
    se <- .genius_season_end(cmp[["label"]], cmp[["year"]], span)
    a <- cmp[["comp_id"]]
    # Python ==: None == None is True, None == 5 is False
    a_na <- !.genius_scalar(a)
    b_na <- !.genius_scalar(sel)
    rows[[length(rows) + 1L]] <- list(
      org = c_org, comp_id = a, label = cmp[["label"]], league_id = cmp[["league_id"]], year = cmp[["year"]],
      season = se$season, season_rule = se$rule,
      selected = if (a_na || b_na) a_na && b_na else isTRUE(a == sel)
    )
  }
  .genius_frame(rows, "competitions")
}

.genius_parse_matches <- function(raw, name) {
  rows <- if (.genius_is_dict(raw)) raw[["matches"]] else NULL
  .genius_frame(Filter(.genius_is_dict, rows %||% list()), name)
}

# ------------------------------------------------------------------------------ the getter

.genius_route <- function(url, call = rlang::caller_env()) {
  parts <- httr2::url_parse(url)
  for (r in .genius_routes) {
    m <- .genius_re1(r[[2]], parts$path %||% "")
    if (identical(parts$hostname, r[[1]]) && length(m)) return(list(kind = r[[3]], ids = m[-1]))
  }
  where <- .intl_where(url)
  .abort_bad_request("not a Genius route: {where}", call = call)
}

#' The body text of a 200 answer, or the classed error the answer calls for.
#' @noRd
.genius_fetch <- function(url, query = list(), call = rlang::caller_env()) {
  where <- .intl_where(url)
  px <- .intl_proxy(NULL, .GENIUS_PROXY_ENV)
  resp <- .intl_response(url, query = query, proxy_env = .GENIUS_PROXY_ENV, retry_500 = FALSE, call = call)
  status <- httr2::resp_status(resp)
  text <- .intl_body_text(resp)
  if (status == 200L) return(text)
  low <- tolower(text)
  if (status == 403L && grepl("request blocked", low, fixed = TRUE) && grepl("cloudfront", low, fixed = TRUE)) {
    via <- if (!is.null(px)) paste0("the proxy from ", px$source)
           else paste0("this egress IP; set ", .GENIUS_PROXY_ENV, " to an http(s) proxy URL")
    .abort_asset_fetch("{where}: CloudFront refused {via} (HTTP 403 'Request blocked').", status = status,
                       call = call)
  }
  if (status == 403L && grepl("accessdenied", low, fixed = TRUE)) {
    .abort_no_data(paste0("{where}: no such object (S3 AccessDenied: a wrong id or ORG, or a game from before ",
                          "data.json)."), status = status, call = call)
  }
  if (status == 500L && grepl("website error", low, fixed = TRUE)) {
    .abort_asset_fetch(paste0("{where} answered HTTP 500 'A website error has occurred': an intermittent Genius ",
                              "host-side failure (it sticks to a URL for minutes; retry later)."),
                       status = status, transient = TRUE, call = call)
  }
  .intl_check_status(resp, where = where, call = call)
  .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status, call = call)
}

.genius_repr <- function(x) {
  if (is.null(x) || (length(x) == 1L && is.na(x))) return("None")
  if (is.character(x)) return(paste0("'", x, "'", collapse = ", "))
  paste(format(x), collapse = ", ")
}

.genius_wrong <- function(url, what, got, want, call) {
  where <- .intl_where(url)
  msg <- paste0(where, ": not the ", what, " asked for (answered ", .genius_repr(got), ", asked ",
                .genius_repr(want), ")")
  .abort_asset_fetch("{msg}", call = call)
}

#' Type-strict equality (sdv-py `_same`): an integer id equals an integer only.
#' @noRd
.genius_same <- function(got, want) .genius_scalar(got) && is.integer(got) && identical(got, want)

#' GET a Genius route, refuse every wrong answer and return its body (or page record).
#'
#' @param url The URL a wrapper built.
#' @param query Query parameters; `NULL` values are dropped (the widget key rides in the URL).
#' @return `data.json`: the parsed body plus `_request = list(match_id)`. The competition window:
#'   the parsed JSON array. `/u/`, the chooser, schedules and the widget: the page record; the
#'   chooser and `/u/` carry `_request = list(org)`, schedules `list(org, comp_id)`.
#' @noRd
.genius_get <- function(url, query = list(), call = rlang::caller_env()) {
  route <- .genius_route(url, call = call)
  kind <- route$kind
  ids <- route$ids
  where <- .intl_where(url)
  text <- .genius_fetch(url, query = query, call = call)
  if (kind == "data") {
    body <- .intl_json(text, where, call = call)
    tm <- if (.genius_is_dict(body)) body[["tm"]] else NULL
    if (!(.genius_is_dict(tm) && all(c("1", "2") %in% names(tm)) && .genius_is_array(body[["pbp"]]))) {
      .abort_asset_fetch("{where}: data.json without tm.1, tm.2 and pbp[] (an error envelope or stub).", call = call)
    }
    done <- any(vapply(body[["pbp"]], function(r) {
      .genius_is_dict(r) && identical(r[["actionType"]], "game") && identical(r[["subType"]], "end")
    }, logical(1)))
    if (!done) {
      .abort_asset_fetch("{where}: the game is not finished (no pbp game/end row); only final games are read.",
                         call = call)
    }
    body[["_request"]] <- list(match_id = as.integer(ids[1]))
    return(body)
  }
  if (kind == "competition") {
    rows <- .intl_json(text, where, call = call)
    if (!.genius_is_array(rows)) .abort_asset_fetch("{where}: expected a JSON list of games.", call = call)
    if (!length(rows)) .abort_no_data("{where}: the recent-games window is empty.", call = call)
    want <- as.integer(ids[1])
    for (r in rows) {
      got <- if (.genius_is_dict(r)) r[["competitionId"]] else r
      if (!.genius_is_dict(r) || !.genius_same(got, want)) .genius_wrong(url, "competition", got, want, call)
    }
    return(rows)
  }
  rec <- tryCatch(.genius_page_record(kind, text), genius_not_parsed = function(e) e)
  if (inherits(rec, "genius_not_parsed")) {
    msg <- conditionMessage(rec)
    if (isTRUE(rec$empty)) .abort_no_data("{where}: {msg}", call = call)
    .abort_asset_fetch("{where}: not the page asked for: {msg}", call = call)
  }
  if (kind == "widget") {
    orgs <- unique(vapply(rec$matches, function(m) m$webcast_org, ""))
    key <- sub("#.*$", "", sub("^[^?]*\\?", "", url))
    want <- if (grepl("?", url, fixed = TRUE) && key %in% names(.GENIUS_WIDGET_KEYS)) {
      unname(.GENIUS_WIDGET_KEYS[key])
    }
    if (length(orgs) != 1L || (!is.null(want) && !identical(orgs, want))) {
      .genius_wrong(url, "widget", sort(ifelse(is.na(orgs), "None", orgs)), want, call)
    }
    return(rec)
  }
  if (kind == "u") {
    want <- as.integer(ids[2])
    if (!.genius_same(rec$match_id, want)) .genius_wrong(url, "match", rec$match_id, want, call)
    rec[["_request"]] <- list(org = ids[1])
  } else if (kind == "chooser") {
    for (cmp in rec$competitions) {
      if (!identical(cmp$org, ids[1])) .genius_wrong(url, "org", cmp$org, ids[1], call)
    }
    rec[["_request"]] <- list(org = ids[1])
  } else {  # schedule / embednf
    org <- ids[1]
    comp_id <- as.integer(ids[2])
    # A "To be determined" slot (an unfilled play-off game: FFBB 21849) has no team or match link, so it names
    # no scope. It takes the one the page's other blocks prove; a page of nothing but such slots is refused.
    empty <- vapply(rec$matches, function(m) is.na(m$comp_id) && is.na(m$org), logical(1))
    if (all(empty)) {
      .abort_asset_fetch("{where}: no block names a competition, so the page cannot be checked.", call = call)
    }
    for (i in which(empty)) {
      rec$matches[[i]]$comp_id <- comp_id
      rec$matches[[i]]$org <- org
    }
    for (m in rec$matches) {
      if (!.genius_same(m$comp_id, comp_id)) .genius_wrong(url, "competition", m$comp_id, comp_id, call)
      if (!identical(m$org, org)) .genius_wrong(url, "org", m$org, org, call)
      if (!is.na(m$link_match_id) && m$link_match_id != m$match_id) {
        msg <- paste0(where, ": match ", m$match_id, " links to ", m$link_match_id)
        .abort_asset_fetch("{msg}", call = call)
      }
    }
    rec[["_request"]] <- list(org = org, comp_id = comp_id)
  }
  rec
}
