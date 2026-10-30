# vtb_parsers.R -- frames of the VTB United League families, at parity with sportsdataverse-py
# sportsdataverse/basketball/vtb/vtb_frames.py, vtb_infobasket_parsers.py and vtb_league_parsers.py
# (origin/main e3d232ebc9). sportsdataverse-py's parse_vtb_* functions are not exported here: each wrapper parses its body.
#
# A row is a named list of scalars (NA for a JSON null), built the way sportsdataverse-py builds a dict (a later key overwrites
# an earlier one in place). Wire conversions, applied by .vtb_flat():
#   /Date(ms)/   -> ISO 8601 string in Moscow time with its offset ("2025-09-28T14:00:00+03:00"); the year-1 value
#                   /Date(-62135596800000)/ is Infobasket's "unset" and becomes NA.
#   DD.MM.YYYY   -> "YYYY-MM-DD" (a string, as in sportsdataverse-py).
#   ""           -> NA in an id, rank or number column.
#   a non-empty array -> its JSON text (Python json.dumps form).
# .vtb_tidy() renames the awkward columns, drops the made/attempted strings and the broken paint stats, parses the
# comma decimals of *_percent / avg_* and, for the stat frames, turns null counts into 0.

.VTB_UNSET_MS <- -62135596800000

.VTB_JUNK <- c(
  "SysStatus", "SysLastChanged", "SysClientLastChanged", "SysUser", "SysMyUser",
  "PersonGUID", "TeamGUID", "GameGUID", "RegionGUID", "ArenaGUID",
  "PersonContacts", "PersonPhotoes", "PersonOldNames", "GameStartlists", "Referees", "Officials",
  "LicenceNumber", "PersonEmail", "PersonPhone", "Email", "Phone",
  "Age", "PersonBirthday", "PersonBirthYear",
  "CompTeams", "Team", "Person", "CompTeam"
)

.VTB_DROP_COL <- "(^|_)(shots[123]|shots23|avg_shots[0-9]+)$|(^|_)paint_"

.VTB_RENAME <- c(
  comp_i_dparent = "parent_comp_id", team1id = "team1_id", team2id = "team2_id", team_aid = "team_a_id",
  team_bid = "team_b_id", capitan = "is_captain", person_birth = "birth_date",
  nationality_id = "nationality_code", country_id = "country_code"
)

.VTB_COUNTS <- c(
  "points", "shot1", "goal1", "shot2", "goal2", "shot3", "goal3", "shot23", "goal23", "assist", "blocks",
  "def_rebound", "off_rebound", "rebound", "steal", "turnover", "foul", "opponent_foul",
  "team_def_rebound", "team_off_rebound", "team_rebound", "team_steal", "team_turnover",
  "foul_b", "foul_c", "foul_d"
)

# ---------------------------------------------------------------------------
# Values
# ---------------------------------------------------------------------------

#' A value as Python's `json.dumps(value, ensure_ascii=False)` writes it (default separators).
#' @noRd
.vtb_pyjson <- function(x) {
  if (is.null(x)) return("null")
  if (is.list(x)) {
    if (is.null(names(x))) return(paste0("[", paste(vapply(x, .vtb_pyjson, ""), collapse = ", "), "]"))
    keys <- vapply(names(x), .vtb_pyjson, "")
    return(paste0("{", paste0(keys, ": ", vapply(x, .vtb_pyjson, ""), collapse = ", "), "}"))
  }
  if (length(x) != 1L || is.na(x)) return("null")
  if (is.logical(x)) return(if (x) "true" else "false")
  if (is.integer(x)) return(as.character(x))
  if (is.double(x)) {
    if (x == trunc(x) && abs(x) >= 2^31 && abs(x) < 1e16) return(format(x, scientific = FALSE))
    if (x == trunc(x) && abs(x) < 1e16) return(paste0(format(x, scientific = FALSE), ".0"))
    for (d in 15:17) {
      s <- formatC(x, digits = d, format = "g")
      if (as.numeric(s) == x) break
    }
    return(sub("e([+-])0?([0-9])", "e\\1\\2", sub("^ +", "", s)))
  }
  s <- enc2utf8(as.character(x))
  s <- gsub("\\", "\\\\", s, fixed = TRUE)
  s <- gsub("\"", "\\\"", s, fixed = TRUE)
  s <- gsub("\n", "\\n", s, fixed = TRUE)
  s <- gsub("\r", "\\r", s, fixed = TRUE)
  s <- gsub("\t", "\\t", s, fixed = TRUE)
  s <- gsub("\b", "\\b", s, fixed = TRUE)
  s <- gsub("\f", "\\f", s, fixed = TRUE)
  ctrl <- gregexpr("[\x01-\x1f]", s, perl = TRUE)
  regmatches(s, ctrl) <- lapply(regmatches(s, ctrl), function(m) {
    vapply(m, function(ch) sprintf("\\u%04x", utf8ToInt(ch)), "", USE.NAMES = FALSE)
  })
  paste0("\"", s, "\"")
}

#' A JSON value as a row cell: NULL -> NA, an array or object -> its JSON text, a scalar as is.
#' @noRd
.vtb_cell <- function(x) {
  if (is.null(x)) return(NA)
  if (is.list(x)) return(.vtb_pyjson(x))
  x
}

#' `x[[key]]` of an object as a cell (NA when missing or not an object).
#' @noRd
.vtb_g <- function(x, key) .vtb_cell(if (.vtb_is_obj(x)) x[[key]] else NULL)

#' The request the runtime stamped under `_request` (an empty object for a bare body).
#' @noRd
.vtb_req <- function(raw) .vtb_obj(.vtb_obj(raw)[["_request"]])

#' Rows of a list route: `items` of the stamped body, or a bare list.
#' @noRd
.vtb_items <- function(raw) if (.vtb_is_arr(raw)) .vtb_rows(raw) else .vtb_rows(.vtb_obj(raw)[["items"]])

#' Convert one wire value (see the file header); anything but a string passes through.
#' @noRd
.vtb_conv <- function(x) {
  if (!(is.character(x) && length(x) == 1L && !is.na(x))) return(x)
  m <- regmatches(x, regexec("^/Date\\((-?[0-9]+)\\)/$", x))[[1]]
  if (length(m)) {
    ms <- as.numeric(m[[2]])
    if (ms <= .VTB_UNSET_MS) return(NA)
    t <- as.POSIXct(floor(ms / 1000) + 3 * 3600, origin = "1970-01-01", tz = "UTC")
    return(format(t, "%Y-%m-%dT%H:%M:%S+03:00"))
  }
  m <- regmatches(x, regexec("^([0-9]{2})\\.([0-9]{2})\\.([0-9]{4})$", x))[[1]]
  if (length(m)) return(paste0(m[[4]], "-", m[[3]], "-", m[[2]]))
  x
}

#' A comma-decimal string ("68,2", "80,3%", "") as a double; numbers pass through; anything else is NA.
#' @noRd
.vtb_decimal <- function(x) {
  if (length(x) != 1L || is.list(x) || is.logical(x) || is.na(x)) return(NA_real_)
  if (is.numeric(x)) return(as.double(x))
  text <- sub("%+$", "", trimws(x))
  text <- gsub(",", ".", text, fixed = TRUE)
  if (!grepl("^[+-]?([0-9]+\\.?[0-9]*|\\.[0-9]+)([eE][+-]?[0-9]+)?$", text)) return(NA_real_)
  as.numeric(text)
}

#' Python's `{**a, **b, ...}`: later keys overwrite earlier ones in place, new keys go last.
#' @noRd
.vtb_merge <- function(...) {
  out <- list()
  for (part in list(...)) for (nm in names(part)) out[[nm]] <- part[[nm]]
  out
}

#' One flat row: nested objects as `<parent>_<child>`, non-empty arrays as JSON text, junk left out (sportsdataverse-py `flat`).
#'
#' @param node A wire object.
#' @param prefix Prepended to every column name.
#' @param skip Wire keys to leave out, bare or qualified by their parent (`"TeamName.TeamID"`).
#' @param parent The wire key of `node` inside its parent.
#' @param birth Keep `PersonBirth` (a player's public birth date).
#' @noRd
.vtb_flat <- function(node, prefix = "", skip = character(), parent = "", birth = FALSE) {
  out <- list()
  for (key in names(node)) {
    if (key == "_request" || key %in% .VTB_JUNK || key %in% skip || paste0(parent, ".", key) %in% skip) next
    if (key == "PersonBirth" && !birth) next
    value <- node[[key]]
    name <- paste0(prefix, .intl_clean_names(key))
    if (.vtb_is_arr(value)) {
      if (length(value)) out[[name]] <- .vtb_pyjson(value)
    } else if (.vtb_is_obj(value)) {
      out <- .vtb_merge(out, .vtb_flat(value, paste0(name, "_"), skip, parent = key, birth = birth))
    } else if (is.character(value) && identical(value, "") && grepl("(^|_)(id|rank|number)$", name)) {
      out[[name]] <- NA
    } else {
      out[[name]] <- .vtb_cell(.vtb_conv(value))
    }
  }
  out
}

#' Rename the awkward columns, drop the unusable ones, parse the comma decimals and (`counts`) null counts to 0.
#' @noRd
.vtb_tidy <- function(row, counts = FALSE) {
  out <- list()
  for (nm in names(row)) {
    value <- row[[nm]]
    name <- if (nm %in% names(.VTB_RENAME)) .VTB_RENAME[[nm]] else nm
    name <- sub("(^|_)team1id$", "\\1team1_id", name)
    name <- sub("(^|_)team2id$", "\\1team2_id", name)
    if (grepl(.VTB_DROP_COL, name)) next
    if (endsWith(name, "_percent") || (startsWith(name, "avg_") && name != "avg_played_time")) {
      value <- .vtb_decimal(value)
    } else if (counts && name %in% .VTB_COUNTS && length(value) == 1L && !is.list(value) && is.na(value)) {
      value <- 0L
    }
    out[[name]] <- value
  }
  if ("is_captain" %in% names(out) && is.numeric(out[["is_captain"]]) && !is.na(out[["is_captain"]])) {
    out[["is_captain"]] <- out[["is_captain"]] != 0
  }
  out
}

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' A column's type without a value to go by: the documented type, else integer for an id, else character.
#' @noRd
.vtb_type_for <- function(col, spec = NULL) {
  if (!is.null(spec) && col %in% names(spec)) return(spec[[col]])
  if (grepl("(^|_)id$", col)) "integer" else "character"
}

#' A typed NA vector of length `n`.
#' @noRd
.vtb_na <- function(type, n) {
  switch(type, integer = rep(NA_integer_, n), double = rep(NA_real_, n), logical = rep(NA, n),
         rep(NA_character_, n))
}

#' One column from its cells, typed as polars infers it (strict = FALSE), with an id column made integer when every
#' value survives the round trip (sportsdataverse-py `_cast_ids_int64`).
#' @noRd
.vtb_column <- function(cells, name) {
  n <- length(cells)
  present <- !vapply(cells, function(v) length(v) == 1L && is.na(v), logical(1))
  if (!any(present)) return(.vtb_na(.vtb_type_for(name), n))
  vals <- cells[present]
  kinds <- vapply(vals, function(v) if (is.character(v)) "c" else if (is.logical(v)) "l" else if (is.integer(v)) "i" else "d", "")
  type <- if (any(kinds == "c")) "character" else if (all(kinds == "l")) "logical" else if (any(kinds == "d")) "double" else "integer"
  if (type == "character") {
    # a string is kept as is: format() escapes non-ASCII to <U+XXXX> in a C locale
    vals <- lapply(vals, function(v) {
      if (is.character(v)) v else if (is.logical(v)) tolower(as.character(v)) else format(v, scientific = FALSE, trim = TRUE)
    })
  }
  out <- .vtb_na(type, n)
  out[present] <- switch(type, character = unlist(vals), logical = as.logical(unlist(vals)),
                         integer = as.integer(unlist(vals)), double = as.double(unlist(vals)))
  if (grepl("(^|_)id$", name) && type %in% c("character", "double")) {
    x <- out[present]
    num <- suppressWarnings(as.numeric(x))
    ok <- !anyNA(num) && all(num == trunc(num)) && all(abs(num) <= .Machine$integer.max)
    if (ok && type == "character") ok <- identical(as.character(as.integer(num)), x)
    if (ok) {
      out <- rep(NA_integer_, n)
      out[present] <- as.integer(num)
    }
  }
  out
}

#' Rows -> a tibble with the documented columns first, typed like sportsdataverse-py's `frame()` + `finish()`: an all-NA column
#' and a numeric column documented as double take the documented type, a documented column the body lacked is added
#' as NA, an empty or malformed input is a zero-row tibble with the documented columns.
#'
#' @param rows A list of rows (named lists).
#' @param kind The frame (a name of `.vtb_specs`).
#' @noRd
.vtb_finish <- function(rows, kind) {
  spec <- .vtb_specs[[kind]]
  rows <- Filter(length, rows)
  if (!length(rows)) return(.empty_tibble(spec))
  cols <- unique(unlist(lapply(rows, names), use.names = FALSE))
  n <- length(rows)
  out <- stats::setNames(lapply(cols, function(col) {
    x <- .vtb_column(lapply(rows, function(r) .vtb_cell(r[[col]])), col)
    if (col %in% names(spec)) {
      want <- spec[[col]]
      have <- if (is.character(x)) "character" else if (is.logical(x)) "logical" else if (is.integer(x)) "integer" else "double"
      if (have != want && (all(is.na(x)) || (want == "double" && have %in% c("integer", "double")))) {
        x <- if (all(is.na(x))) .vtb_na(want, n) else as.double(x)
      }
    }
    x
  }), cols)
  for (col in setdiff(names(spec), cols)) out[[col]] <- .vtb_na(spec[[col]], n)
  dplyr::as_tibble(out[c(names(spec), setdiff(cols, names(spec)))])
}

# ---------------------------------------------------------------------------
# Infobasket shapers
# ---------------------------------------------------------------------------

.VTB_NAME_SUFFIX <- c(
  CompTeamShortNameRu = "short_name_ru", CompTeamShortNameEn = "short_name_en", CompTeamNameRu = "name_ru",
  CompTeamNameEn = "name_en", CompTeamRegionNameRu = "region_name_ru", CompTeamRegionNameEn = "region_name_en"
)
.VTB_PERSON_NAMES <- c(
  PersonLastNameRu = "last_name_ru", PersonLastNameEn = "last_name_en", PersonFirstNameRu = "first_name_ru",
  PersonFirstNameEn = "first_name_en", PersonFullNameRu = "full_name_ru", PersonFullNameEn = "full_name_en"
)
.VTB_PERSON_SKIP <- c(
  "PersonNickNameRu", "PersonNickNameEn", "PersonSecondNameRu", "PersonSecondNameEn",
  "PersonBornIn", "PersonBornInRegion", "PersonCountry", "PersonRegion", "Coaches", "Players", "Position",
  "PersonRank", "PersonFullNameRu", "PersonFullNameEn", "Country"
)
.VTB_STAT_SKIP <- c("Players", "Coaches", "Staff", "TeamName", "PersonInfo")
.VTB_GAME_SKIP <- c(
  "IsToday", "DaysFromToday", "GameDateInt", "GameLocalDate", "HasVideo", "VideoID", "LiveID", "Periods",
  "TeamLogoA", "TeamLogoB", "RegionId",
  "DisplayDateTimeLocal", "DisplayDateTimeMsk", "DisplayDateTimeLocalEn", "DisplayDateTimeMskEn"
)

#' The six name columns of a CompTeamName record under `prefix`.
#' @noRd
.vtb_names <- function(team_name, prefix) {
  d <- .vtb_obj(team_name)
  stats::setNames(lapply(names(.VTB_NAME_SUFFIX), function(w) .vtb_g(d, w)), paste0(prefix, .VTB_NAME_SUFFIX))
}

#' The person columns of a PersonInfo record: names, gender and (players only) bio and position.
#' @noRd
.vtb_person <- function(info, bio) {
  d <- .vtb_obj(info)
  out <- stats::setNames(lapply(names(.VTB_PERSON_NAMES), function(w) .vtb_g(d, w)),
                         paste0("person_", .VTB_PERSON_NAMES))
  out[["person_gender"]] <- .vtb_g(d, "PersonGender")
  if (bio) {
    out[["birth_date"]] <- .vtb_cell(.vtb_conv(d[["PersonBirth"]]))
    out[["height"]] <- .vtb_g(d, "PersonHeight")
    out[["weight"]] <- .vtb_g(d, "PersonWeight")
    first <- .vtb_rows(d[["Players"]])
    out[["player_position"]] <- .vtb_g(if (length(first)) first[[1]] else NULL, "PlayerPosition")
  }
  out
}

.vtb_game_row <- function(r, ctx) .vtb_tidy(.vtb_merge(ctx, .vtb_flat(r, skip = .VTB_GAME_SKIP)))

.vtb_totals_row <- function(node, ctx) {
  .vtb_tidy(.vtb_merge(ctx, .vtb_flat(node, skip = .VTB_STAT_SKIP), .vtb_names(node[["TeamName"]], "team_")),
            counts = TRUE)
}

.vtb_people_rows <- function(teams, key, ctx, player) {
  out <- list()
  for (t in teams) {
    for (p in .vtb_rows(t[[key]])) {
      row <- .vtb_merge(ctx, list(team_id = .vtb_g(t, "TeamID")),
                        .vtb_flat(p, skip = c(.VTB_STAT_SKIP, .VTB_PERSON_SKIP)))
      row <- .vtb_merge(row, .vtb_person(p[["PersonInfo"]], bio = player))
      out[[length(out) + 1L]] <- .vtb_tidy(row, counts = TRUE)
    }
  }
  out
}

.vtb_leader_rows <- function(raw, team) {
  ctx <- list(season = .vtb_g(.vtb_req(raw), "season"))
  out <- list()
  for (item in .vtb_items(raw)) {
    param <- .vtb_obj(item[["Parameter"]])
    base <- .vtb_merge(ctx, list(
      param_id = .vtb_g(param, "ParamID"), param_name = .vtb_g(param, "ParamName"),
      param_short_name = .vtb_g(param, "ShortName"), param_label = .vtb_g(param, "Name"),
      param_group = .vtb_g(param, "ParamGroup")
    ))
    for (r in .vtb_rows(item[["Results"]])) {
      row <- .vtb_merge(base, list(rank = .vtb_g(r, "Rank")))
      tn <- .vtb_obj(r[["TeamName"]])
      row[["team_id"]] <- .vtb_g(tn, "TeamID")
      row <- .vtb_merge(row, .vtb_names(tn, "team_"))
      if (!team) {
        person <- .vtb_obj(r[["Person"]])
        row[["person_id"]] <- .vtb_g(person, "PersonID")
        row <- .vtb_merge(row, .vtb_person(person, bio = FALSE))
      }
      game <- .vtb_obj(r[["Game"]])
      row <- .vtb_merge(row, list(game_id = .vtb_g(game, "GameID"), game_count = .vtb_g(r, "GameCount"),
                                  res = .vtb_g(r, "Res"), pre_res = .vtb_g(r, "PreRes"),
                                  is_same = .vtb_g(r, "IsSame")))
      out[[length(out) + 1L]] <- .vtb_tidy(row)
    }
  }
  out
}

#' Online.GameID, else the requested game id.
#' @noRd
.vtb_online_game_id <- function(raw) {
  gid <- .vtb_int_or_null(.vtb_obj(.vtb_obj(raw)[["Online"]])[["GameID"]])
  .vtb_cell(gid %||% .vtb_int_or_null(.vtb_req(raw)[["game_id"]]))
}

.vtb_teams <- function(raw) .vtb_rows(.vtb_obj(raw)[["GameTeams"]])

#' `TeamNumber -> TeamID` of OnlineTeams (truthy numbers only), later rows overwriting earlier ones.
#' @noRd
.vtb_team_ids <- function(body) {
  out <- list()
  for (t in .vtb_rows(body[["OnlineTeams"]])) {
    tn <- t[["TeamNumber"]]
    if (.vtb_truthy(tn)) out[[as.character(tn)]] <- .vtb_cell(t[["TeamID"]])
  }
  out
}

#' Python truthiness of a scalar (NULL, NA, 0, FALSE and "" are falsy).
#' @noRd
.vtb_truthy <- function(x) {
  if (is.null(x) || is.list(x) || length(x) != 1L || is.na(x)) return(FALSE)
  if (is.character(x)) return(nzchar(x))
  as.logical(x != 0)
}

#' Python `x == 1` for a scalar (`True == 1` and `1.0 == 1` hold).
#' @noRd
.vtb_is_one <- function(x) {
  length(x) == 1L && !is.list(x) && (is.numeric(x) || is.logical(x)) && isTRUE(x == 1)
}

.vtb_lookup <- function(map, key) {
  v <- map[[as.character(key)]]
  if (is.null(v)) NA else v
}

.vtb_stage_rows <- function(comps, level, base) {
  out <- list()
  for (c in comps) {
    out[[length(out) + 1L]] <- .vtb_tidy(.vtb_merge(base, list(level = level), .vtb_flat(c, skip = "Children")))
    out <- c(out, .vtb_stage_rows(.vtb_rows(c[["Children"]]), level + 1L, base))
  }
  out
}

.vtb_cross_row <- function(r, ctx) {
  row <- .vtb_tidy(.vtb_merge(ctx, .vtb_flat(r)))
  score <- r[["Score"]]
  parts <- if (is.character(score) && length(score) == 1L && !is.na(score)) {
    regmatches(score, gregexpr(":", score, fixed = TRUE), invert = TRUE)[[1]]
  } else {
    character()
  }
  if (length(parts) == 2L && all(grepl("^\\s*[0-9]+\\s*$", parts))) {
    row[["score1"]] <- as.integer(trimws(parts[[1]]))
    row[["score2"]] <- as.integer(trimws(parts[[2]]))
  }
  row
}

.vtb_person_row <- function(body, bio) {
  row <- .vtb_flat(body, skip = c(.VTB_PERSON_SKIP, "SeasonStats", "GameStats"), birth = bio)
  first <- .vtb_rows(body[["Players"]])
  first <- if (length(first)) first[[1]] else structure(list(), names = character())
  pos <- .vtb_obj(first[["Position"]])
  row <- .vtb_merge(row, list(
    player_position = .vtb_g(first, "PlayerPosition"), player_hand = .vtb_g(first, "PlayerHand"),
    is_naturalized = .vtb_g(first, "IsNaturalized"), position_id = .vtb_g(pos, "PosID"),
    position_name_ru = .vtb_g(pos, "PosNameRu"), position_name_en = .vtb_g(pos, "PosNameEn")
  ))
  if (!bio) {
    row <- row[!names(row) %in% c("player_position", "player_hand", "is_naturalized", "position_id",
                                  "position_name_ru", "position_name_en")]
  }
  row
}

#' The English role of a coach or official line-up row (sportsdataverse-py `vtb_codes.staff_role`).
#' @noRd
.vtb_staff_role <- function(start_type, pos_id) {
  pos <- if (.vtb_kind(pos_id) == "int") pos_id else -1
  if (.vtb_same(start_type, 3L)) {
    return(if (pos == 1000) "head coach" else if (pos == 1001) "assistant coach" else "coach")
  }
  if (pos >= 101 && pos <= 103) return("referee")
  if (pos == 104) return("commissioner")
  if (pos >= 111 && pos <= 123) return("table official")
  "official"
}

.vtb_has <- function(body, key) .vtb_is_obj(body) && length(body) > 0L && key %in% names(body)

#' The frame shapers, one per wrapper (sportsdataverse-py `parse_vtb_*`), each `function(raw)` -> rows.
#' @noRd
.vtb_shapers <- list(
  vtb_infobasket_seasons = function(raw) {
    tag <- .vtb_g(.vtb_req(raw), "tag")
    lapply(.vtb_items(raw), function(r) {
      list(season = .vtb_g(r, "SeasonYear"), comp_id = .vtb_g(r, "CompID"), name_ru = .vtb_g(r, "NameRu"),
           name_en = .vtb_g(r, "NameEn"), db = .vtb_g(r, "Db"), tag = tag)
    })
  },
  vtb_infobasket_calendar = function(raw) {
    req <- .vtb_req(raw)
    ctx <- list(season = .vtb_g(req, "season"), comp_id = .vtb_g(req, "season_comp_id"))
    lapply(.vtb_items(raw), .vtb_game_row, ctx = ctx)
  },
  vtb_infobasket_team_games = function(raw) {
    req <- .vtb_req(raw)
    ctx <- list(team_id = .vtb_g(req, "team_id"), season = .vtb_g(req, "season"),
                comp_id = .vtb_g(req, "season_comp_id"))
    lapply(.vtb_items(raw), .vtb_game_row, ctx = ctx)
  },
  vtb_infobasket_team_stats = function(raw) {
    ctx <- list(season = .vtb_g(.vtb_req(raw), "season"))
    lapply(.vtb_rows(.vtb_obj(raw)[["Stats"]]), .vtb_totals_row, ctx = ctx)
  },
  vtb_infobasket_team_stats_players = function(raw) {
    .vtb_people_rows(.vtb_rows(.vtb_obj(raw)[["Stats"]]), "Players",
                     list(season = .vtb_g(.vtb_req(raw), "season")), player = TRUE)
  },
  vtb_infobasket_team_stats_coaches = function(raw) {
    .vtb_people_rows(.vtb_rows(.vtb_obj(raw)[["Stats"]]), "Coaches",
                     list(season = .vtb_g(.vtb_req(raw), "season")), player = FALSE)
  },
  vtb_infobasket_best_players = function(raw) .vtb_leader_rows(raw, team = FALSE),
  vtb_infobasket_best_teams = function(raw) .vtb_leader_rows(raw, team = TRUE),
  vtb_infobasket_team_preview = function(raw) {
    ctx <- list(game_id = .vtb_g(.vtb_req(raw), "game_id"))
    lapply(.vtb_items(raw), .vtb_totals_row, ctx = ctx)
  },
  vtb_infobasket_game = function(raw) {
    body <- .vtb_obj(raw)
    on <- .vtb_obj(body[["Online"]])
    if (!length(body) || !length(on)) return(list())
    skip <- c("GameTeams", "Online", "OnlineTeams", "OnlineStarts", "OnlinePlays", "OnlinePeriods", "VideoID",
              "LiveID")
    row <- .vtb_flat(body, skip = skip)
    league_id <- if ("league_id" %in% names(row)) row[["league_id"]] else NA
    row <- row[names(row) != "league_id"]
    row[["season_comp_id"]] <- league_id
    row <- .vtb_merge(row, list(
      game_id = .vtb_online_game_id(raw), game_number = .vtb_g(on, "GameNumber"),
      game_date_time = .vtb_cell(.vtb_conv(on[["GameTime"]])), region_id = .vtb_g(on, "RegionID"),
      arena_id = .vtb_g(on, "ArenaID"), venue_en = .vtb_g(on, "Venue1"), venue_ru = .vtb_g(on, "Venue2"),
      attendance = .vtb_g(on, "Attendance"), period_count = .vtb_g(on, "PeriodCount"),
      period_extra_seconds = .vtb_g(on, "PeriodExtraSeconds"), period_minutes = .vtb_g(on, "Periods"),
      intervals_minutes = .vtb_g(on, "Intervals"), personal_fouls = .vtb_g(on, "PersonalFouls"),
      team_fouls = .vtb_g(on, "TeamFouls"), players_on_court = .vtb_g(on, "PlayersOnCourt"),
      free_throw_value = .vtb_g(on, "FreeThrowValue"), field_goal_value = .vtb_g(on, "FieldGoalValue"),
      long_shot_value = .vtb_g(on, "LongShotValue"), left_team_number = .vtb_g(on, "LeftTeamNumber")
    ))
    teams <- utils::head(.vtb_teams(raw), 2L)
    for (i in seq_along(teams)) {
      t <- teams[[i]]
      side <- c("a", "b")[[i]]
      row[[paste0("team_", side, "_id")]] <- .vtb_g(t, "TeamID")
      row[[paste0("score_", side)]] <- .vtb_g(t, "Score")
      row <- .vtb_merge(row, .vtb_names(t[["TeamName"]], paste0("team_", side, "_")))
    }
    list(.vtb_tidy(row))
  },
  vtb_infobasket_box_score = function(raw) {
    gid <- .vtb_online_game_id(raw)
    out <- list()
    for (t in .vtb_teams(raw)) {
      for (p in .vtb_rows(t[["Players"]])) {
        row <- .vtb_merge(list(game_id = gid, team_id = .vtb_g(t, "TeamID"),
                               is_home = .vtb_is_one(t[["TeamNumber"]])), .vtb_flat(p, birth = TRUE))
        out[[length(out) + 1L]] <- .vtb_tidy(row, counts = TRUE)
      }
    }
    out
  },
  vtb_infobasket_team_box_score = function(raw) {
    gid <- .vtb_online_game_id(raw)
    lapply(.vtb_teams(raw), function(t) {
      coach <- .vtb_obj(t[["Coach"]])
      row <- .vtb_merge(
        list(game_id = gid, is_home = .vtb_is_one(t[["TeamNumber"]])),
        .vtb_flat(t, skip = c("Players", "Coaches", "Coach", "TeamName")),
        .vtb_names(t[["TeamName"]], "team_"),
        list(coach_person_id = .vtb_g(coach, "PersonID"), coach_name_en = .vtb_g(coach, "PersonNameEn"),
             coach_name_ru = .vtb_g(coach, "PersonNameRu"), coach_foul_c = .vtb_g(coach, "FoulC"),
             coach_foul_b = .vtb_g(coach, "FoulB"), coach_foul_d = .vtb_g(coach, "FoulD"),
             coach_foul = .vtb_g(coach, "Foul"))
      )
      .vtb_tidy(row, counts = TRUE)
    })
  },
  vtb_infobasket_pbp = function(raw) {
    body <- .vtb_obj(raw)
    gid <- .vtb_online_game_id(raw)
    team_ids <- .vtb_team_ids(body)
    slots <- list()
    for (s in .vtb_rows(body[["OnlineStarts"]])) {
      if (.vtb_truthy(s[["StartID"]])) slots[[as.character(s[["StartID"]])]] <- s
    }
    lapply(.vtb_rows(body[["OnlinePlays"]]), function(p) {
      sid <- p[["StartID"]]
      slot <- if (.vtb_kind(sid) %in% c("int", "float", "str") && !is.null(slots[[as.character(sid)]])) {
        slots[[as.character(sid)]]
      } else {
        structure(list(), names = character())
      }
      st <- slot[["StartType"]]
      tn <- if (.vtb_same(st, 0L) || .vtb_same(st, 1L)) slot[["TeamNumber"]] else NULL
      ptype <- .vtb_int_or_null(p[["PlayTypeID"]])
      label <- if (!is.null(ptype) && as.character(ptype) %in% names(.vtb_play_types)) {
        .vtb_play_types[[as.character(ptype)]]
      } else {
        NA
      }
      list(
        game_id = gid, play_id = .vtb_g(p, "PlayID"), parent_play_id = .vtb_g(p, "ParentPlayID"),
        play_type_id = .vtb_g(p, "PlayTypeID"), play_type = label, play_period = .vtb_g(p, "PlayPeriod"),
        play_second = .vtb_g(p, "PlaySecond"), play_sort_order = .vtb_g(p, "PlaySortOrder"),
        play_flag = .vtb_g(p, "PlayFlag"), start_id = .vtb_g(p, "StartID"),
        team_number = if (.vtb_truthy(tn)) tn else NA,
        team_id = if (.vtb_truthy(tn)) .vtb_lookup(team_ids, tn) else NA,
        person_id = if (.vtb_same(st, 1L) && .vtb_truthy(slot[["PersonID"]])) slot[["PersonID"]] else NA,
        play_zone = .vtb_g(p, "PlayZone"), play_x = .vtb_g(p, "PlayX"), play_y = .vtb_g(p, "PlayY"),
        video_from = .vtb_g(p, "VideoFrom"), video_to = .vtb_g(p, "VideoTo")
      )
    })
  },
  vtb_infobasket_game_staff = function(raw) {
    body <- .vtb_obj(raw)
    gid <- .vtb_online_game_id(raw)
    team_ids <- .vtb_team_ids(body)
    out <- list()
    for (s in .vtb_rows(body[["OnlineStarts"]])) {
      st <- s[["StartType"]]
      if (!(.vtb_same(st, 3L) || .vtb_same(st, 4L))) next
      tn <- .vtb_cell(s[["TeamNumber"]])
      out[[length(out) + 1L]] <- list(
        game_id = gid, team_number = tn, team_id = if (.vtb_truthy(tn)) .vtb_lookup(team_ids, tn) else NA,
        start_id = .vtb_g(s, "StartID"), start_type = .vtb_g(s, "StartType"),
        role = .vtb_staff_role(st, s[["PosID"]]), pos_id = .vtb_g(s, "PosID"), person_id = .vtb_g(s, "PersonID"),
        person_name_en = .vtb_g(s, "PersonName1"), person_name_ru = .vtb_g(s, "PersonName2"),
        country_code_ioc = .vtb_g(s, "CountryCodeIOC")
      )
    }
    out
  },
  vtb_infobasket_game_page = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "GameID")) return(list())
    region <- .vtb_obj(body[["Region"]])
    arena <- .vtb_obj(body[["Arena"]])
    row <- .vtb_flat(body, skip = c("Region", "Arena", "VideoID", "LiveID", "GameIDnew", "GameDateTimeDB",
                                    "CompTeamA", "CompTeamB", "TeamAid", "TeamBid"))
    row <- .vtb_merge(row, list(
      region_name_ru = .vtb_g(region, "RegionNameRu"), region_name_en = .vtb_g(region, "RegionNameEn"),
      arena_name_ru = .vtb_g(arena, "ArenaNameRu"), arena_name_en = .vtb_g(arena, "ArenaNameEn"),
      arena_full_name_ru = .vtb_g(arena, "ArenaFullNameRu"), arena_full_name_en = .vtb_g(arena, "ArenaFullNameEn")
    ))
    list(.vtb_tidy(row))
  },
  vtb_infobasket_comp_issue = function(raw) {
    body <- .vtb_obj(raw)
    base <- list(season = .vtb_g(.vtb_req(raw), "season"),
                 season_comp_id = .vtb_cell(.vtb_int_or_null(body[["ParentCompID"]])))
    .vtb_stage_rows(.vtb_rows(body[["Comps"]]), 1L, base)
  },
  vtb_infobasket_standings = function(raw) {
    lapply(.vtb_items(raw), function(r) {
      .vtb_tidy(.vtb_merge(
        .vtb_flat(r, skip = c("Results", "CompTeamName", "Standings")),
        .vtb_flat(.vtb_obj(r[["Standings"]]), skip = c("CompTeamStandingID", "CompTeamID", "CompTeam")),
        .vtb_names(r[["CompTeamName"]], "team_")
      ))
    })
  },
  vtb_infobasket_cross_table = function(raw) {
    ctx <- list(comp_id = .vtb_g(.vtb_req(raw), "comp_id"))
    lapply(.vtb_items(raw), .vtb_cross_row, ctx = ctx)
  },
  vtb_infobasket_playoff = function(raw) {
    comp <- .vtb_g(.vtb_req(raw), "comp_id")
    lapply(.vtb_items(raw), function(r) {
      .vtb_tidy(.vtb_merge(
        list(comp_id = comp),
        .vtb_flat(r, skip = c("Scores", "TeamName1", "TeamName2", "Score1String", "Score2String")),
        list(team1_id = .vtb_g(r[["TeamName1"]], "TeamID")), .vtb_names(r[["TeamName1"]], "team1_"),
        list(team2_id = .vtb_g(r[["TeamName2"]], "TeamID")), .vtb_names(r[["TeamName2"]], "team2_")
      ))
    })
  },
  vtb_infobasket_playoff_games = function(raw) {
    comp <- .vtb_g(.vtb_req(raw), "comp_id")
    out <- list()
    for (r in .vtb_items(raw)) {
      key <- list(comp_id = comp, tree = .vtb_g(r, "Tree"), round = .vtb_g(r, "Round"), sort = .vtb_g(r, "Sort"))
      out <- c(out, lapply(.vtb_rows(r[["Scores"]]), .vtb_cross_row, ctx = key))
    }
    out
  },
  vtb_infobasket_best_player_parameters = function(raw) {
    lapply(.vtb_items(raw), function(r) list(param = .vtb_g(r, "param"), name = .vtb_g(r, "name")))
  },
  vtb_infobasket_best_team_parameters = function(raw) {
    lapply(.vtb_items(raw), function(r) list(param = .vtb_g(r, "param"), name = .vtb_g(r, "name")))
  },
  vtb_infobasket_player = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "PersonID")) return(list())
    list(.vtb_tidy(.vtb_person_row(body, bio = TRUE)))
  },
  vtb_infobasket_coach = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "PersonID")) return(list())
    list(.vtb_tidy(.vtb_person_row(body, bio = FALSE)))
  },
  vtb_infobasket_player_season_stats = function(raw) {
    body <- .vtb_obj(raw)
    lapply(.vtb_rows(body[["SeasonStats"]]), function(s) {
      season <- .vtb_obj(s[["Season"]])
      .vtb_tidy(.vtb_merge(
        list(person_id = .vtb_g(body, "PersonID"), season = .vtb_g(season, "CompID"),
             season_name_ru = .vtb_g(season, "CompShortNameRu"), season_name_en = .vtb_g(season, "CompShortNameEn")),
        .vtb_names(s[["TeamName"]], "team_"),
        .vtb_flat(s, skip = c("Season", "PersonID", "TeamName"))
      ), counts = TRUE)
    })
  },
  vtb_infobasket_player_career_stats = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "PersonID")) return(list())
    list(.vtb_tidy(.vtb_flat(body, skip = "SeasonStats"), counts = TRUE))
  },
  vtb_infobasket_player_game_log = function(raw) {
    body <- .vtb_obj(raw)
    lapply(.vtb_rows(body[["GameStats"]]), function(g) {
      game <- .vtb_obj(g[["Game"]])
      by_number <- list()
      for (t in .vtb_rows(game[["GameTeams"]])) {
        k <- t[["GameTeamNumber"]]
        by_number[[if (is.null(k)) "NULL" else as.character(k)]] <- t
      }
      tn <- g[["TeamNumber"]]
      mine <- by_number[[if (is.null(tn)) "NULL" else as.character(tn)]]
      a <- .vtb_obj(g[["TeamNameA"]])
      b <- .vtb_obj(g[["TeamNameB"]])
      .vtb_tidy(.vtb_merge(
        list(person_id = .vtb_g(body, "PersonID"), game_id = .vtb_g(game, "GameID"),
             game_number = .vtb_g(game, "GameNumber"), game_status = .vtb_g(game, "GameStatus"),
             team_id = .vtb_g(mine, "TeamID"), team_a_id = .vtb_g(a, "TeamID"), team_b_id = .vtb_g(b, "TeamID"),
             score_a = .vtb_g(by_number[["1"]], "GameTeamScore"), score_b = .vtb_g(by_number[["2"]], "GameTeamScore")),
        .vtb_names(a, "team_a_"), .vtb_names(b, "team_b_"),
        .vtb_flat(g, skip = c("Game", "TeamNameA", "TeamNameB", "PersonID"))
      ), counts = TRUE)
    })
  },
  vtb_infobasket_team = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "TeamID")) return(list())
    skip <- c("CurrentTeamName", "CompTeamNames", "TeamCoaches", "TeamPlayers", "TeamColors", "Organization",
              "TeamTypeIcon", "TeamArena", "TeamOrg", "TeamPlayersBirthYear", "TeamType1")
    list(.vtb_tidy(.vtb_merge(.vtb_flat(body, skip = skip),
                              list(team_record_id = .vtb_g(body[["CurrentTeamName"]], "TeamID")))))
  },
  vtb_infobasket_team_seasons = function(raw) {
    team <- .vtb_g(.vtb_req(raw), "team_id")
    lapply(.vtb_items(raw), function(r) {
      list(team_id = team, season = .vtb_g(r, "Year"), comp_id = .vtb_g(r, "CompID"),
           season_name = .vtb_g(r, "SeasonName"))
    })
  },
  vtb_infobasket_team_comps = function(raw) {
    req <- .vtb_req(raw)
    ctx <- list(team_id = .vtb_g(req, "team_id"), season = .vtb_g(req, "season"))
    lapply(.vtb_items(raw), function(r) .vtb_tidy(.vtb_merge(ctx, .vtb_flat(r))))
  },
  vtb_infobasket_roster = function(raw) {
    body <- .vtb_obj(raw)
    ctx <- list(team_id = .vtb_g(body, "TeamID"), season = .vtb_g(.vtb_req(raw), "season"))
    lapply(.vtb_rows(body[["Players"]]), function(p) {
      .vtb_tidy(.vtb_merge(ctx, .vtb_flat(p, skip = c("PersonInfo", "PhotoUrl"), birth = TRUE),
                           .vtb_person(p[["PersonInfo"]], bio = FALSE)))
    })
  },
  vtb_infobasket_roster_coaches = function(raw) {
    body <- .vtb_obj(raw)
    ctx <- list(team_id = .vtb_g(body, "TeamID"), season = .vtb_g(.vtb_req(raw), "season"))
    lapply(.vtb_rows(body[["Coaches"]]), function(c) {
      .vtb_tidy(.vtb_merge(ctx, .vtb_flat(c, skip = c("PersonInfo", "PhotoUrl")),
                           .vtb_person(c[["PersonInfo"]], bio = FALSE)))
    })
  },
  vtb_infobasket_team_season_stats = function(raw) {
    body <- .vtb_obj(raw)
    if (!.vtb_has(body, "TeamID")) return(list())
    list(.vtb_totals_row(body, list(season = .vtb_g(.vtb_req(raw), "season"))))
  },
  vtb_infobasket_team_player_stats = function(raw) {
    body <- .vtb_obj(raw)
    .vtb_people_rows(if (length(body)) list(body) else list(), "Players",
                     list(season = .vtb_g(.vtb_req(raw), "season")), player = TRUE)
  },
  vtb_infobasket_team_coach_stats = function(raw) {
    body <- .vtb_obj(raw)
    .vtb_people_rows(if (length(body)) list(body) else list(), "Coaches",
                     list(season = .vtb_g(.vtb_req(raw), "season")), player = FALSE)
  },
  # --- v2 schedule API ---
  vtb_league_leagues = function(raw) {
    lapply(.vtb_league_data(raw), function(r) {
      .vtb_merge(list(league_id = .vtb_g(r, "leagueId"), league = .vtb_g(r, "league")),
                 .vtb_pair(r[["leagueName"]], "league_name"), .vtb_pair(r[["leagueAbbrev"]], "league_abbrev"))
    })
  },
  vtb_league_seasons = function(raw) {
    lapply(.vtb_league_data(raw), function(r) {
      list(season = .vtb_g(r, "season"), league = .vtb_g(r, "league"), is_current = .vtb_g(r, "isCurrent"),
           season_name = .vtb_g(r, "seasonName"), season_abbrev = .vtb_g(r, "seasonAbbrev"))
    })
  },
  vtb_league_matches = function(raw) lapply(.vtb_league_data(raw), .vtb_match_row)
)

# ---------------------------------------------------------------------------
# v2 shapers
# ---------------------------------------------------------------------------

#' The `data` rows of the envelope (or of a bare `items` list / list).
#' @noRd
.vtb_league_data <- function(raw) {
  if (.vtb_is_arr(raw)) return(.vtb_rows(raw))
  body <- .vtb_obj(raw)
  rows <- .vtb_rows(body[["data"]])
  if (length(rows)) rows else .vtb_rows(body[["items"]])
}

#' `{"en": a, "ru": b}` -> `name_en`, `name_ru`.
#' @noRd
.vtb_pair <- function(value, name) {
  d <- .vtb_obj(value)
  stats::setNames(list(.vtb_g(d, "en"), .vtb_g(d, "ru")), paste0(name, c("_en", "_ru")))
}

.vtb_side <- function(competitor, side) {
  .vtb_merge(
    stats::setNames(list(.vtb_g(competitor, "teamId"), .vtb_g(competitor, "scoreString")),
                    paste0(side, c("_team_id", "_score"))),
    .vtb_pair(competitor[["teamName"]], paste0(side, "_team_name")),
    .vtb_pair(competitor[["teamCode"]], paste0(side, "_team_code")),
    .vtb_pair(competitor[["regionName"]], paste0(side, "_region_name"))
  )
}

.vtb_match_row <- function(m) {
  comps <- .vtb_rows(m[["competitors"]])
  pick <- function(flag) {
    hit <- Filter(function(c) identical(c[["isHomeCompetitor"]], flag), comps)
    if (length(hit)) hit[[1]] else structure(list(), names = character())
  }
  home <- pick(TRUE)
  away <- pick(FALSE)
  venue <- .vtb_obj(m[["venue"]])
  custom <- .vtb_obj(m[["customValues"]])
  pbq <- m[["pointsByQuarters"]]
  quarters <- if (.vtb_is_arr(pbq)) Filter(function(q) .vtb_is_arr(q) && length(q) == 2L, pbq) else list()
  row <- .vtb_merge(
    list(match_id = .vtb_g(m, "matchId"), league = .vtb_g(m, "league"), season = .vtb_g(m, "season"),
         competition = .vtb_g(m, "competition"), phase_id = .vtb_g(m, "phaseId")),
    .vtb_pair(m[["phaseName"]], "phase_name"),
    list(match_number = .vtb_g(m, "matchNumber"), match_type = .vtb_g(m, "matchType"),
         match_status = .vtb_g(m, "matchStatus"), match_time = .vtb_g(m, "matchTime"),
         match_time_msk = .vtb_g(m, "matchTimeMSK"), match_time_utc = .vtb_g(m, "matchTimeUTC"),
         is_time_set = .vtb_g(m, "isTimeSet"), time_actual = .vtb_g(m, "timeActual"),
         time_end_actual = .vtb_g(m, "timeEndActual"), duration = .vtb_g(m, "duration"),
         periods = .vtb_g(m, "periods"), extra_periods_used = .vtb_g(m, "extraPeriodsUsed"),
         attendance = .vtb_g(m, "attendance"), hosting_team_id = .vtb_g(m, "hostingTeamId"),
         venue_id = .vtb_g(m, "venueId")),
    .vtb_pair(venue[["venueName"]], "venue_name"), .vtb_pair(venue[["regionName"]], "venue_region_name"),
    .vtb_side(home, "home"), .vtb_side(away, "away"),
    .vtb_pair(custom[["subtitle"]], "subtitle"), .vtb_pair(custom[["necessaryLabel"]], "necessary_label"),
    list(points_by_quarters = if (length(quarters)) .vtb_pyjson(pbq) else NA)
  )
  for (i in 1:4) {
    row[[paste0("home_q", i)]] <- if (i <= length(quarters)) .vtb_cell(quarters[[i]][[1]]) else NA
    row[[paste0("away_q", i)]] <- if (i <= length(quarters)) .vtb_cell(quarters[[i]][[2]]) else NA
  }
  extra <- quarters[-(1:4)]
  ot <- function(j) {
    if (!length(extra)) return(NA)
    v <- unlist(lapply(extra, function(q) if (.vtb_kind(q[[j]]) == "int" || .vtb_kind(q[[j]]) == "bool") q[[j]]))
    as.integer(sum(v))
  }
  row[["home_ot"]] <- ot(1L)
  row[["away_ot"]] <- ot(2L)
  row
}

#' Parse a stamped body into the documented tibble of `kind` (a wrapper name), tagged as `hoopR_data`.
#' @noRd
.vtb_out <- function(kind, raw, type) {
  make_hoopR_data(.vtb_finish(.vtb_shapers[[kind]](raw), kind), type, Sys.time())
}
