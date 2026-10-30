# kzs_parsers.R -- frames of the KZS wrappers (internal; parse_* is not exported).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/kzs/kzs_parsers.py (origin/main e3d232ebc9). Each route has its own
# shaper; inside it, nested objects flatten into `<parent>_<child>` columns (names through `.intl_clean_names()`, the
# port of sportsdataverse-py `dl_utils.underscore`) and lists become JSON strings written as Python's `json.dumps` writes them.
# Personal and bulky sub-trees are dropped, not flattened (`.KZS_DROP`): contact details (the API serves officials'
# and coaches' e-mails, phones and home towns publicly), club postal addresses and personnel, the commissioner's
# report, delegation changes, move requests, conclusions and streams. A wire `id` is renamed for what it identifies.
#
# Types follow sportsdataverse-py's frame: a column's type comes from its values (integer, double, logical, character), every
# `*_id` / `id` column is an integer when that is lossless, and the returns schema (`.kzs_dtypes`, R/kzs_schema.R)
# types an all-null column and widens a whole-number rate to double. The documented columns come first, in the
# documented order; a missing one is added as typed NAs; an empty body is a zero-row tibble with those columns.

#' Wire keys never flattened: contact data and bulky free text / lists.
#' @noRd
.KZS_DROP <- c("addressesPostOfficeName", "email", "scoresheetEmail", "phone", "phoneNumber", "mobile", "iban",
               "swiftCode", "bankName", "taxNumber", "birthDate", "dateOfBirth", "coachesIdNumber",
               "commissionerReportHtml", "delegationChanges", "moveRequests", "conclusions", "streams", "liveStreams",
               "personnel", "club", "organiserTeam", "competitions", "scores")
#' @noRd
.KZS_ID_COL <- "(^|_)id$"

# ---------------------------------------------------------------------------
# Scalars and JSON text
# ---------------------------------------------------------------------------

#' sportsdataverse-py `_int`: a JSON integer, else NA (a float, a string or a logical is not one).
#' @noRd
.kzs_int <- function(v) if (is.integer(v) && length(v) == 1L) v else NA_integer_

#' A JSON scalar as a row cell (`NULL` / null -> NA).
#' @noRd
.kzs_cell <- function(v) if (is.null(v)) NA else v

#' Python `repr()` of a float (the shortest round-trip form; exponent below 1e-4 and from 1e16).
#' @noRd
.kzs_py_float <- function(x) {
  if (is.nan(x)) return("NaN")
  if (is.infinite(x)) return(if (x > 0) "Infinity" else "-Infinity")
  if (x == 0) return(if (1 / x < 0) "-0.0" else "0.0")
  for (d in 0:16) {
    s <- formatC(x, digits = d, format = "e")
    if (as.numeric(s) == x) break
  }
  m <- regmatches(s, regexec("^(-?)([0-9])(?:\\.([0-9]+))?e([+-][0-9]+)$", s))[[1]]
  digits <- sub("0+$", "", paste0(m[[3]], m[[4]]))
  if (!nzchar(digits)) digits <- "0"
  n <- nchar(digits)
  ex <- as.integer(m[[5]])
  out <- if (ex >= -4L && ex < 16L) {
    if (ex >= n - 1L) {
      paste0(digits, strrep("0", ex - n + 1L), ".0")
    } else if (ex >= 0L) {
      paste0(substr(digits, 1L, ex + 1L), ".", substr(digits, ex + 2L, n))
    } else {
      paste0("0.", strrep("0", -ex - 1L), digits)
    }
  } else {
    mant <- if (n > 1L) paste0(substr(digits, 1L, 1L), ".", substr(digits, 2L, n)) else digits
    paste0(mant, "e", if (ex < 0L) "-" else "+", sprintf("%02d", abs(ex)))
  }
  paste0(m[[2]], out)
}

#' A JSON string literal as Python `json.dumps(..., ensure_ascii=False)` writes it.
#' @noRd
.kzs_py_string <- function(s) {
  s <- gsub("\\", "\\\\", s, fixed = TRUE)
  s <- gsub("\"", "\\\"", s, fixed = TRUE)
  s <- gsub("\n", "\\n", s, fixed = TRUE)
  s <- gsub("\r", "\\r", s, fixed = TRUE)
  s <- gsub("\t", "\\t", s, fixed = TRUE)
  s <- gsub("\b", "\\b", s, fixed = TRUE)
  s <- gsub("\f", "\\f", s, fixed = TRUE)
  if (grepl("[\001-\037]", s, perl = TRUE)) {
    cps <- utf8ToInt(enc2utf8(s))
    s <- paste(vapply(cps, function(cp) {
      if (cp < 32L) sprintf("\\u%04x", cp) else intToUtf8(cp)
    }, character(1)), collapse = "")
  }
  paste0("\"", s, "\"")
}

#' Python `json.dumps(x, ensure_ascii=False)` of a parsed JSON value (`jsonlite::parse_json(simplifyVector =
#' FALSE)`): ", " and ": " separators, floats in Python's repr, non-ASCII kept.
#' @noRd
.kzs_dumps <- function(x) {
  if (is.null(x)) return("null")
  if (is.list(x)) {
    if (is.null(names(x))) return(paste0("[", paste(vapply(x, .kzs_dumps, character(1)), collapse = ", "), "]"))
    parts <- vapply(seq_along(x), function(i) {
      paste0(.kzs_py_string(names(x)[[i]]), ": ", .kzs_dumps(x[[i]]))
    }, character(1))
    return(paste0("{", paste(parts, collapse = ", "), "}"))
  }
  if (length(x) != 1L || is.na(x)) return("null")
  if (is.logical(x)) return(if (x) "true" else "false")
  if (is.integer(x)) return(as.character(x))
  if (is.double(x)) return(.kzs_py_float(x))
  .kzs_py_string(enc2utf8(as.character(x)))
}

#' sportsdataverse-py `_json`: the JSON text of a value, NA for null / absent.
#' @noRd
.kzs_json <- function(v) if (is.null(v)) NA_character_ else .kzs_dumps(v)

# ---------------------------------------------------------------------------
# Rows
# ---------------------------------------------------------------------------

#' Python `{**a, **b}`: b's keys overwrite a's in place, new keys are appended.
#' @noRd
.kzs_merge <- function(a, b) {
  for (n in names(b)) a[n] <- list(b[[n]])
  a
}

#' One flat row: nested objects as `<parent>_<child>`, lists as JSON text, `drop` keys left out.
#' @noRd
.kzs_flat <- function(obj, prefix = "", drop = .KZS_DROP) {
  out <- list()
  for (i in seq_along(obj)) {
    key <- names(obj)[[i]]
    if (key == .KZS_REQUEST || key %in% drop) next
    name <- paste0(prefix, .intl_clean_names(key))
    value <- obj[[i]]
    if (.kzs_is_array(value)) {
      out[name] <- list(.kzs_dumps(value))
    } else if (.kzs_is_dict(value)) {
      out <- .kzs_merge(out, .kzs_flat(value, paste0(name, "_"), drop))
    } else {
      out[name] <- list(.kzs_cell(value))
    }
  }
  out
}

#' Flatten `obj` and rename its wire `id` to `id_name` (first column).
#' @noRd
.kzs_named <- function(obj, id_name, drop = .KZS_DROP) {
  row <- .kzs_flat(obj, drop = drop)
  id <- if ("id" %in% names(row)) row[["id"]] else NA
  row[["id"]] <- NULL
  c(stats::setNames(list(id), id_name), row)
}

#' The END-year season: the second half of a `START/END` name, else from the opaque season id.
#' @noRd
.kzs_end_year <- function(season_id = NA_integer_, name = NULL) {
  if (is.character(name) && length(name) == 1L && !is.na(name)) {
    m <- regmatches(name, regexec("^\\s*([0-9]{4})\\s*/\\s*([0-9]{4})\\s*$", name, perl = TRUE))[[1]]
    if (length(m)) return(as.integer(m[[3]]))
  }
  if (!is.na(season_id)) {
    if (season_id >= 1L && season_id <= 30L) return(2000L + season_id)
    if (season_id >= 31L && season_id <= 39L) return(1961L + season_id)
  }
  NA_integer_
}

#' A single-object body, or `{}` when it lacks `key` (an empty body, a request stamp alone, a list route).
#' @noRd
.kzs_header_body <- function(raw, key = "id") {
  body <- .kzs_obj(raw)
  if (key %in% names(body)) body else stats::setNames(list(), character())
}

#' The request stamp of a runtime answer.
#' @noRd
.kzs_ctx <- function(raw) .kzs_obj(.kzs_obj(raw)[[.KZS_REQUEST]])

#' Rows of a list route: `items` of the data object, or a bare list.
#' @noRd
.kzs_items <- function(raw) if (.kzs_is_array(raw)) .kzs_rows(raw) else .kzs_rows(.kzs_obj(raw)[["items"]])

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' @noRd
.KZS_PROTO <- list(i = NA_integer_, f = NA_real_, b = NA, s = NA_character_)

#' Type code of a column's non-null values, as polars infers it (strict = FALSE).
#' @noRd
.kzs_infer <- function(vals) {
  kinds <- unique(vapply(vals, typeof, character(1)))
  if ("character" %in% kinds) return("s")
  if ("double" %in% kinds) return("f")
  if ("integer" %in% kinds) return("i")
  "b"
}

#' One column vector of type `code` from row cells.
#' @noRd
.kzs_vector <- function(cells, code) {
  if (code == "s") {
    return(vapply(cells, function(v) if (is.na(v)) NA_character_ else if (is.character(v)) v else .kzs_str(v),
                  character(1), USE.NAMES = FALSE))
  }
  if (code == "b") return(vapply(cells, function(v) as.logical(v), logical(1), USE.NAMES = FALSE))
  x <- vapply(cells, function(v) as.double(v), double(1), USE.NAMES = FALSE)
  if (code == "i" && all(is.na(x) | abs(x) <= .Machine$integer.max)) as.integer(x) else x
}

#' The frame of `parser` from flat rows: values typed as sportsdataverse-py's frame, the documented columns first.
#' @noRd
.kzs_frame <- function(rows, parser) {
  schema <- .kzs_dtypes[[parser]]
  rows <- Filter(length, rows)
  cols <- unique(unlist(lapply(rows, names), use.names = FALSE))
  out <- list()
  for (col in cols) {
    cells <- lapply(rows, function(r) if (col %in% names(r)) r[[col]] else NA)
    present <- Filter(function(v) !is.na(v), cells)
    is_id <- grepl(.KZS_ID_COL, col)
    if (!length(present)) {
      code <- if (col %in% names(schema)) schema[[col]] else if (is_id) "i" else "s"
    } else {
      code <- .kzs_infer(present)
      if (is_id && code == "f" && all(vapply(present, function(v) v == trunc(v), logical(1)))) code <- "i"
      if (is_id && code == "s" && all(vapply(present, function(v) {
        is.character(v) && grepl("^-?[0-9]+$", v) && identical(as.character(as.numeric(v)), v)
      }, logical(1)))) code <- "i"
      if (col %in% names(schema) && schema[[col]] == "f" && code == "i") code <- "f"
    }
    out[[col]] <- .kzs_vector(cells, code)
  }
  for (col in setdiff(names(schema), cols)) out[[col]] <- rep(.KZS_PROTO[[schema[[col]]]], length(rows))
  out <- out[c(names(schema), setdiff(names(out), names(schema)))]
  dplyr::as_tibble(out)
}

# ---------------------------------------------------------------------------
# Shapers, one per route (sportsdataverse-py parse_kzs_*)
# ---------------------------------------------------------------------------

#' @noRd
.kzs_competition_row <- function(c) {
  row <- .kzs_named(c, "competition_id", c(.KZS_DROP, "phases", "socialMedias"))
  season <- .kzs_obj(c[["season"]])
  row[["season"]] <- .kzs_end_year(.kzs_int(season[["id"]]), season[["name"]])
  row
}

#' @noRd
.kzs_competition_entry <- function(match, cid) {
  entries <- .kzs_rows(match[["competitions"]])
  hit <- if (!is.na(cid)) Filter(function(e) .kzs_key(e[["competitionId"]]) == .kzs_key(cid), entries) else list()
  entry <- if (length(hit)) hit[[1]] else if (length(entries)) entries[[1]] else list()
  phase <- .kzs_obj(entry[["competitionPhase"]])
  pick <- function(key, fallback) if (key %in% names(entry)) entry[[key]] else fallback
  out <- list(
    competition_id = .kzs_int(entry[["competitionId"]]),
    competition_name = .kzs_cell(entry[["competitionName"]]),
    competition_type = .kzs_cell(entry[["competitionType"]]),
    competition_phase_id = .kzs_int(pick("competitionPhaseId", phase[["id"]])),
    competition_phase_name = .kzs_cell(pick("competitionPhaseName", phase[["name"]])),
    transferred = .kzs_cell(entry[["transferred"]]),
    season_id = .kzs_int(entry[["seasonId"]])
  )
  out[["season"]] <- .kzs_end_year(out[["season_id"]])
  out
}

#' @noRd
.kzs_match_row <- function(m, cid) {
  row <- .kzs_named(m, "match_id")
  url <- row[["fiba_live_stats_url"]]
  genius <- NA_integer_
  if (is.character(url) && length(url) == 1L && !is.na(url)) {
    hit <- regmatches(url, regexec("/u/[A-Za-z0-9_-]+/([0-9]+)/?", url, perl = TRUE))[[1]]
    if (length(hit)) genius <- as.integer(hit[[2]])
  }
  head <- c(list(match_id = row[["match_id"]]), .kzs_competition_entry(m, cid))
  row[["match_id"]] <- NULL
  out <- .kzs_merge(head, list(genius_match_id = genius,
                               organiser_team_id = .kzs_int(.kzs_obj(m[["organiserTeam"]])[["id"]])))
  .kzs_merge(out, row)
}

#' `{match_team_id: home|away}` from the players the feed lists for each side.
#' @noRd
.kzs_pbp_sides <- function(body) {
  ids <- function(key) .kzs_keys(lapply(.kzs_rows(body[[key]]), function(p) p[["id"]]))
  first <- ids("firstTeamPlayers")
  second <- ids("secondTeamPlayers")
  sides <- list()
  for (a in .kzs_rows(body[["actions"]])) {
    team <- .kzs_int(a[["matchTeamId"]])
    if (is.na(team) || as.character(team) %in% names(sides)) next
    player <- .kzs_key(a[["playerId"]])
    if (player %in% first) {
      sides[[as.character(team)]] <- "home"
    } else if (player %in% second) {
      sides[[as.character(team)]] <- "away"
    }
  }
  sides
}

#' @noRd
.kzs_box_ctx <- function(body, side, block) {
  list(match_id = .kzs_int(body[["matchId"]]), team_side = side, team_id = .kzs_int(block[["teamId"]]),
       team_name = .kzs_cell(block[["teamName"]]))
}

#' @noRd
.kzs_team_row <- function(t) {
  app <- .kzs_obj(t[["teamApplication"]])
  club <- .kzs_obj(app[["club"]])
  row <- list(team_id = .kzs_int(t[["id"]]), team_application_id = .kzs_int(app[["id"]]),
              club_id = .kzs_int(club[["id"]]), club_member = .kzs_cell(club[["member"]]))
  row <- .kzs_merge(row, .kzs_flat(app[setdiff(names(app), c("id", "club"))]))
  .kzs_merge(row, .kzs_flat(t[setdiff(names(t), c("id", "teamApplication"))]))
}

#' @noRd
.kzs_player_row <- function(p) {
  person <- .kzs_obj(p[["person"]])
  nat <- .kzs_obj(p[["nationality"]])
  list(
    player_id = .kzs_int(p[["id"]]), identification_number = .kzs_int(p[["identificationNumber"]]),
    person_id = .kzs_int(person[["id"]]), first_name = .kzs_cell(person[["firstName"]]),
    last_name = .kzs_cell(person[["lastName"]]), year_of_birth = .kzs_int(person[["yearOfBirth"]]),
    nationality_id = .kzs_int(nat[["id"]]), nationality_alpha2_code = .kzs_cell(nat[["alpha2Code"]]),
    nationality_alpha3_code = .kzs_cell(nat[["alpha3Code"]]), nationality_name = .kzs_cell(nat[["name"]]),
    nationality_eng_name = .kzs_cell(nat[["engName"]]), homegrown = .kzs_cell(p[["homegrown"]]),
    photo_uuid = .kzs_cell(p[["photoUuid"]]), positions = .kzs_json(p[["positions"]])
  )
}

#' The flat rows of `kind` from a runtime answer (or a bare `data` object).
#' @noRd
.kzs_shape <- function(kind, raw) {
  body <- .kzs_obj(raw)
  ctx <- .kzs_ctx(raw)
  sides <- list(home = "firstTeam", away = "secondTeam")
  switch(kind,
    seasons = lapply(.kzs_items(raw), function(s) {
      c(.kzs_named(s, "season_id"), list(season = .kzs_end_year(.kzs_int(s[["id"]]), s[["name"]])))
    }),
    competitions = lapply(.kzs_items(raw), .kzs_competition_row),
    competition = {
      b <- .kzs_header_body(raw)
      if (!length(b)) list() else {
        row <- .kzs_competition_row(b)
        row[["social_medias"]] <- .kzs_json(b[["socialMedias"]])
        list(row)
      }
    },
    phases = {
      season <- .kzs_obj(body[["season"]])
      end <- .kzs_end_year(.kzs_int(season[["id"]]), season[["name"]])
      lapply(.kzs_rows(body[["phases"]]), function(p) {
        .kzs_merge(list(competition_id = .kzs_int(body[["id"]]), season = end), .kzs_named(p, "phase_id"))
      })
    },
    rounds = lapply(.kzs_rows(body[["phases"]]), function(p) {
      .kzs_merge(list(competition_id = .kzs_int(ctx[["competition_id"]])), .kzs_named(p, "phase_id"))
    }),
    player_leaderboard = ,
    team_leaderboard = lapply(.kzs_items(raw), function(r) {
      .kzs_merge(list(competition_id = .kzs_int(ctx[["competition_id"]]),
                      stats_category = .kzs_cell(ctx[["stats_category"]])), .kzs_flat(r))
    }),
    matches = {
      cid <- .kzs_int(ctx[["competition_id"]])
      lapply(.kzs_items(raw), .kzs_match_row, cid = cid)
    },
    match = {
      b <- .kzs_header_body(raw)
      if (!length(b)) list() else list(.kzs_match_row(b, NA_integer_))
    },
    period_scores = {
      b <- .kzs_header_body(raw)
      lapply(.kzs_rows(b[["scores"]]), function(s) {
        .kzs_merge(list(match_id = .kzs_int(b[["id"]])), .kzs_named(s, "score_id"))
      })
    },
    pbp = {
      mid <- .kzs_int(ctx[["match_id"]])
      team_sides <- .kzs_pbp_sides(body)
      acts <- .kzs_rows(body[["actions"]])
      lapply(seq_along(acts), function(n) {
        a <- acts[[n]]
        row <- .kzs_flat(a)
        for (key in c("score1", "score2")) {
          val <- if (key %in% names(row)) row[[key]] else NA
          row[[key]] <- if (is.character(val) && !is.na(val) && grepl("^[0-9]+$", trimws(val))) {
            as.integer(trimws(val))
          } else {
            .kzs_int(val)
          }
        }
        team <- .kzs_int(a[["matchTeamId"]])
        side <- if (is.na(team) || team == 0L) NA else team_sides[[as.character(team)]] %||% NA
        .kzs_merge(list(match_id = mid, action_number = n, team_side = side), row)
      })
    },
    pbp_players = {
      mid <- .kzs_int(ctx[["match_id"]])
      unlist(lapply(c(home = "firstTeamPlayers", away = "secondTeamPlayers"), function(key) {
        side <- if (key == "firstTeamPlayers") "home" else "away"
        lapply(.kzs_rows(body[[key]]), function(p) {
          .kzs_merge(list(match_id = mid, team_side = side), .kzs_named(p, "player_id"))
        })
      }), recursive = FALSE, use.names = FALSE)
    },
    box_score = unlist(lapply(names(sides), function(side) {
      block <- .kzs_obj(body[[sides[[side]]]])
      lapply(.kzs_rows(block[["playerStats"]]), function(p) .kzs_merge(.kzs_box_ctx(body, side, block), .kzs_flat(p)))
    }), recursive = FALSE, use.names = FALSE),
    team_box_score = unlist(lapply(names(sides), function(side) {
      block <- .kzs_obj(body[[sides[[side]]]])
      if (.kzs_is_dict(block[["teamStats"]])) {
        list(.kzs_merge(.kzs_box_ctx(body, side, block), .kzs_flat(block[["teamStats"]])))
      }
    }), recursive = FALSE, use.names = FALSE),
    score_changes = lapply(.kzs_rows(body[["scoreChanges"]]), function(s) {
      row <- .kzs_merge(list(match_id = .kzs_int(body[["matchId"]])), .kzs_flat(s))
      .kzs_merge(row, list(total_minutes = .kzs_int(body[["totalMinutes"]])))
    }),
    standings = {
      comp <- .kzs_obj(body[["competition"]])
      unlist(lapply(.kzs_rows(body[["phases"]]), function(ph) {
        phase <- .kzs_obj(ph[["competitionPhase"]])
        head <- list(competition_id = .kzs_int(comp[["id"]]), phase_id = .kzs_int(phase[["id"]]),
                     phase_name = .kzs_cell(phase[["name"]]), phase_type = .kzs_cell(phase[["type"]]))
        top <- list(group = list(group_id = NA_integer_, group_name = NA), table = .kzs_rows(ph[["standings"]]))
        blocks <- c(list(top),
                    lapply(.kzs_rows(ph[["groups"]]), function(g) {
                      grp <- .kzs_obj(g[["competitionPhaseGroup"]])
                      list(group = list(group_id = .kzs_int(grp[["id"]]), group_name = .kzs_cell(grp[["name"]])),
                           table = .kzs_rows(g[["standings"]]))
                    }))
        unlist(lapply(blocks, function(b) {
          lapply(seq_along(b$table), function(n) {
            row <- .kzs_merge(.kzs_merge(head, b$group), list(position = n))
            .kzs_merge(row, .kzs_flat(b$table[[n]], drop = c(.KZS_DROP, "team")))
          })
        }), recursive = FALSE, use.names = FALSE)
      }), recursive = FALSE, use.names = FALSE)
    },
    playing_days = lapply(.kzs_items(raw), function(d) {
      .kzs_merge(list(competition_id = .kzs_int(ctx[["competition_id"]])), .kzs_flat(d))
    }),
    teams = lapply(.kzs_items(raw), function(t) {
      .kzs_merge(list(competition_id = .kzs_int(ctx[["competition_id"]])), .kzs_team_row(t))
    }),
    team = {
      b <- .kzs_header_body(raw)
      if (!length(b)) list() else {
        season <- .kzs_obj(.kzs_obj(b[["teamApplication"]])[["season"]])
        row <- .kzs_merge(.kzs_team_row(b), list(
          season = .kzs_end_year(.kzs_int(season[["id"]]), season[["name"]]),
          competitions = .kzs_json(b[["competitions"]])
        ))
        list(row)
      }
    },
    team_general = {
      b <- .kzs_header_body(raw, "won")
      if (!length(b)) list() else {
        list(.kzs_merge(list(team_id = .kzs_int(ctx[["team_id"]]), competition_id = .kzs_int(ctx[["competition_id"]])),
                        .kzs_flat(b)))
      }
    },
    roster = lapply(.kzs_items(raw), function(r) {
      row <- list(team_id = .kzs_int(ctx[["team_id"]]), competition_id = .kzs_int(ctx[["competition_id"]]),
                  roster_entry_id = .kzs_int(r[["id"]]))
      row <- .kzs_merge(row, .kzs_player_row(.kzs_obj(r[["player"]])))
      .kzs_merge(row, list(jersey_number = .kzs_cell(r[["jerseyNumber"]])))
    }),
    player = {
      b <- .kzs_header_body(raw)
      if (!length(b)) list() else list(.kzs_player_row(b))
    },
    player_stats = {
      sid <- .kzs_int(ctx[["season_id"]])
      season <- .kzs_int(ctx[["season"]])
      if (is.na(season) || season == 0L) season <- .kzs_end_year(sid)
      lapply(.kzs_rows(body[["competitionStats"]]), function(c) {
        .kzs_merge(list(player_id = .kzs_int(ctx[["player_id"]]), season_id = sid, season = season), .kzs_flat(c))
      })
    }
  )
}

#' Parse a runtime answer (or a bare `data` object) into the `kind` frame; never raises on a malformed body.
#' @noRd
.kzs_parse <- function(kind, raw) .kzs_frame(.kzs_shape(kind, raw), kind)

#' @noRd
.kzs_out <- function(df, type) make_hoopR_data(df, type, Sys.time())
