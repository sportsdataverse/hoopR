# crosswalk_basketball.R -- internal engine for the NBA/MBB cross-source
# crosswalks. None of these are exported. Each is deterministic so a cached
# loader artifact reproduces the live builder exactly.

#' Normalize a person name for cross-source matching
#' @keywords internal
#' @importFrom stringi stri_trans_general
#' @importFrom stringr str_replace_all str_remove_all str_squish
.bb_normalize_name <- function(x) {
  x <- stringi::stri_trans_general(as.character(x), "Latin-ASCII")
  x <- tolower(x)
  x <- stringr::str_replace_all(x, "['`']", "")
  x <- stringr::str_replace_all(x, "[._\\-]", " ")
  x <- stringr::str_remove_all(x, "\\b(jr|sr|ii|iii|iv)\\b")
  x <- stringr::str_replace_all(x, "[^a-z ]", " ")
  x <- stringr::str_squish(x)
  x[is.na(x)] <- ""
  x
}

#' Normalize a team name for cross-source matching
#' @keywords internal
#' @importFrom stringi stri_trans_general
#' @importFrom stringr str_replace_all str_remove str_squish
.bb_normalize_team <- function(x) {
  x <- stringi::stri_trans_general(as.character(x), "Latin-ASCII")
  x <- tolower(x)
  x <- stringr::str_replace_all(x, "[^a-z ]", " ")
  x <- stringr::str_squish(x)
  x <- stringr::str_remove(x, "^the ")
  x[is.na(x)] <- ""
  x
}

#' Normalize a college team name for cross-source matching (contracting form)
#'
#' Collapses "state"/"saint"/"st." to a single "st" token and "&" to "and" so
#' that terse Torvik/KenPom names ("Missouri St.") and ESPN's spelled-out names
#' ("Missouri State") resolve to the same key. The canonical form is lossy but
#' CONSISTENT across sources, which is what matters for matching.
#' @keywords internal
#' @importFrom stringi stri_trans_general
#' @importFrom stringr str_replace_all str_squish
.bb_normalize_college_team <- function(x) {
  x <- stringi::stri_trans_general(as.character(x), "Latin-ASCII")
  x <- tolower(x)
  x <- stringr::str_replace_all(x, "&", " and ")
  x <- stringr::str_replace_all(x, "[^a-z0-9 ]", " ")
  x <- stringr::str_replace_all(x, "\\b(state|saint)\\b", "st")
  x <- stringr::str_replace_all(x, "\\buniversity\\b", " ")
  x <- stringr::str_squish(x)
  x[is.na(x)] <- ""
  x
}

#' Reduce a timestamp (UTC datetime, ISO string, or Date) to the local ET date
#' @keywords internal
#' @importFrom lubridate as_datetime with_tz date
.bb_to_eastern <- function(x) {
  if (inherits(x, "Date")) return(x)
  t <- lubridate::as_datetime(x, tz = "UTC")
  lubridate::date(lubridate::with_tz(t, tzone = "America/New_York"))
}

#' Deterministic blocked fuzzy matcher (greedy within block)
#'
#' @param left,right data.frames with columns `.block`, `.id`, `.name_key`
#'   (and optional `.jersey`, `.dob`).
#' @param min_confidence Jaro-Winkler similarity floor for a fuzzy match.
#' @return data.frame: `.block`, `left_id`, `right_id`, `match_method`
#'   (`exact_name` / `fuzzy_jw` / `unmatched`), `match_confidence`.
#' @keywords internal
#' @importFrom stringdist stringsim
#' @importFrom dplyr bind_rows
.bb_fuzzy_match <- function(left, right, min_confidence = 0.92) {
  req <- c(".block", ".id", ".name_key")
  stopifnot(all(req %in% names(left)), all(req %in% names(right)))
  has_jersey <- ".jersey" %in% names(left) && ".jersey" %in% names(right)
  has_dob    <- ".dob"    %in% names(left) && ".dob"    %in% names(right)

  # Guard: return a properly-typed empty frame when left has no rows.
  if (!nrow(left)) {
    return(data.frame(
      .block = character(), left_id = character(), right_id = character(),
      match_method = character(), match_confidence = numeric(),
      stringsAsFactors = FALSE
    ))
  }

  unmatched_row <- function(b, id, conf = NA_real_) {
    data.frame(.block = b, left_id = id, right_id = NA_character_,
               match_method = "unmatched", match_confidence = conf,
               stringsAsFactors = FALSE)
  }

  out <- list()
  for (b in unique(left$.block)) {
    l <- left[left$.block == b, , drop = FALSE]
    r <- right[right$.block == b, , drop = FALSE]
    r_used <- rep(FALSE, nrow(r))
    rows <- vector("list", nrow(l))
    pending <- integer(0)

    for (i in seq_len(nrow(l))) {
      # Skip blank name keys — they must not match anything (exact or fuzzy).
      if (!nzchar(l$.name_key[i])) {
        rows[[i]] <- unmatched_row(b, l$.id[i])
        next
      }
      hit <- if (nrow(r)) which(!r_used & r$.name_key == l$.name_key[i]) else integer(0)
      if (length(hit) >= 1) {
        if (length(hit) > 1 && has_jersey && !is.na(l$.jersey[i])) {
          jt <- hit[!is.na(r$.jersey[hit]) & r$.jersey[hit] == l$.jersey[i]]
          if (length(jt)) hit <- jt
        }
        if (length(hit) > 1 && has_dob && !is.na(l$.dob[i])) {
          dt <- hit[!is.na(r$.dob[hit]) & r$.dob[hit] == l$.dob[i]]
          if (length(dt)) hit <- dt
        }
        j <- hit[1]; r_used[j] <- TRUE
        rows[[i]] <- data.frame(.block = b, left_id = l$.id[i], right_id = r$.id[j],
                                match_method = "exact_name", match_confidence = 1,
                                stringsAsFactors = FALSE)
      } else {
        pending <- c(pending, i)
      }
    }

    for (i in pending) {
      avail <- which(!r_used)
      if (!length(avail)) { rows[[i]] <- unmatched_row(b, l$.id[i]); next }
      sims <- stringdist::stringsim(l$.name_key[i], r$.name_key[avail],
                                    method = "jw", p = 0.1)
      best <- max(sims)
      if (best >= min_confidence) {
        cands <- avail[which(sims >= best - 1e-9)]
        if (length(cands) > 1 && has_jersey) {
          jt <- cands[!is.na(r$.jersey[cands]) & !is.na(l$.jersey[i]) &
                        r$.jersey[cands] == l$.jersey[i]]
          if (length(jt)) cands <- jt
        }
        if (length(cands) > 1 && has_dob) {
          dt <- cands[!is.na(r$.dob[cands]) & !is.na(l$.dob[i]) &
                        r$.dob[cands] == l$.dob[i]]
          if (length(dt)) cands <- dt
        }
        j <- cands[1]; r_used[j] <- TRUE
        rows[[i]] <- data.frame(.block = b, left_id = l$.id[i], right_id = r$.id[j],
                                match_method = "fuzzy_jw", match_confidence = best,
                                stringsAsFactors = FALSE)
      } else {
        rows[[i]] <- unmatched_row(b, l$.id[i], best)
      }
    }
    out[[length(out) + 1]] <- dplyr::bind_rows(rows)
  }
  dplyr::bind_rows(out)
}

# ---------------------------------------------------------------------------
# Season-correct sources for the college team crosswalks. R port of
# sportsdataverse-py's _crosswalk_basketball_sources.py (#604, #605): every
# source is read AS OF the requested season, a source that cannot answer a
# season leaves its columns NA, and a source that fails raises instead of
# shipping a well-formed crosswalk with an all-NA column.
# ---------------------------------------------------------------------------

#' Raise a crosswalk source failure
#' @keywords internal
#' @noRd
.bb_source_error <- function(msg) {
  rlang::abort(msg, class = "crosswalk_source_error")
}

#' Read one sportsdataverse-data release parquet
#'
#' A 404 is an absent asset: `NULL` with `missing_ok = TRUE`, an error
#' otherwise. Any other non-200 is a failed fetch and always raises, so a
#' blocked or rate-limited read is never mistaken for a missing one.
#' @param file Release path, `"{tag}/{name}.parquet"`.
#' @keywords internal
#' @noRd
.bb_release_parquet <- function(file, missing_ok = FALSE) {
  resp <- .retry_request(paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/", file
  ))
  status <- httr2::resp_status(resp)
  if (status == 404L && missing_ok) return(NULL)
  if (status != 200L) .bb_source_error(sprintf("release asset %s answered HTTP %d", file, status))
  as.data.frame(arrow::read_parquet(httr2::resp_body_raw(resp)))
}

#' ESPN team id -> conference name AS OF one season
#'
#' Reads `{lg}_team_group_seasons_{season}` (which conference each team was in
#' that season) and `{lg}_group_seasons` (each conference's name that season)
#' from the `{lg}_groups` release. Only ESPN-id rows are used. ESPN's own
#' group tree names every season's conference by its CURRENT name (the 2025
#' WAC reads "United Athletic Conference"), so it is not used.
#' @param league `"mbb"` or `"wbb"`.
#' @param season Season, ending year.
#' @return data.frame: `team_id`, `conference_name` (character), one row per
#'   Division I team; NA `conference_name` for a team in no conference.
#' @keywords internal
#' @noRd
.bb_conference_map <- function(league, season) {
  members <- .bb_release_parquet(sprintf("%s_groups/%s_team_group_seasons_%d.parquet", league, league, season))
  groups <- .bb_release_parquet(sprintf("%s_groups/%s_group_seasons.parquet", league, league))
  members <- members[members$team_id_source %in% "espn", , drop = FALSE]
  groups <- groups[groups$season %in% season, , drop = FALSE]
  out <- data.frame(
    team_id = as.character(members$team_id),
    conference_name = as.character(groups$name)[
      match(as.character(members$conference_id), as.character(groups$group_id))
    ],
    stringsAsFactors = FALSE
  )
  if (all(is.na(out$conference_name))) {
    .bb_source_error(sprintf("%s_groups: no team resolved to a named conference for season %d", league, season))
  }
  out[!duplicated(out$team_id), , drop = FALSE]
}

#' ESPN team ids whose conference in `season + 1` is not their `season` one
#'
#' A team that leaves Division I counts as a mover. With no `season + 1`
#' asset on the release yet, nobody has moved.
#' @keywords internal
#' @noRd
.bb_next_season_movers <- function(league, season) {
  path <- "%s_groups/%s_team_group_seasons_%d.parquet"
  later <- .bb_release_parquet(sprintf(path, league, league, season + 1L), missing_ok = TRUE)
  if (is.null(later) || !nrow(later)) return(character())
  now <- .bb_release_parquet(sprintf(path, league, league, season))
  now <- now[now$team_id_source %in% "espn", , drop = FALSE]
  later <- later[later$team_id_source %in% "espn", , drop = FALSE]
  ids <- as.character(now$team_id)
  cur <- as.character(now$conference_id)
  nxt <- as.character(later$conference_id)[match(ids, as.character(later$team_id))]
  same <- (is.na(cur) & is.na(nxt)) | (!is.na(cur) & !is.na(nxt) & cur == nxt)
  ids[!same]
}

#' Fox team directory AS OF one season
#'
#' One `league/standings?groupId=&season=` call per conference in
#' `{sport}/league/conferences` (Fox keys seasons by START year). Only
#' standings labelled with the requested season count: Fox answers a season it
#' does not have with the current one. Empty before `first_season`, which Fox
#' cannot answer.
#' @param sport Fox slug, `"cbk"` or `"wcbk"`.
#' @return data.frame: `fox_team_id`, `fox_team_name`, `fox_section`.
#' @keywords internal
#' @noRd
.bb_fox_season_teams <- function(sport, season, first_season) {
  out <- data.frame(fox_team_id = character(), fox_team_name = character(),
                    fox_section = character(), stringsAsFactors = FALSE)
  if (season < first_season) return(out)
  label <- sprintf("%d-%02d", season - 1L, season %% 100L)
  confs <- .fox_bb_get(paste0(sport, "/league/conferences"))
  items <- c(confs[["navItems"]], unlist(lapply(confs[["groups"]], `[[`, "items"), recursive = FALSE))
  uris <- vapply(items, function(it) it[["entityLink"]][["contentUri"]] %||% NA_character_, character(1))
  gids <- vapply(uris[grepl("/groups/", uris)], .fox_uri_id, character(1), USE.NAMES = FALSE)
  gids <- gids[!is.na(gids)]
  rows <- list(out)
  for (gid in gids) {
    raw <- .fox_bb_get(paste0(sport, "/league/standings"),
                       list(groupId = gid, season = season - 1L), missing_ok = TRUE)
    secs <- Filter(function(s) identical(s[["metadata"]][["parameters"]][["season"]], label),
                   raw[["standingsSections"]] %||% list())
    if (length(secs)) rows[[length(rows) + 1L]] <- .fox_bb_teams(list(standingsSections = secs))
  }
  out <- dplyr::bind_rows(rows)
  if (!nrow(out)) {
    .bb_source_error(sprintf("Fox %s: no %s standings in any of %d conferences", sport, label, length(gids)))
  }
  out <- out[!duplicated(out$fox_team_id), c("fox_team_id", "fox_team_name", "fox_section"), drop = FALSE]
  rownames(out) <- NULL
  out
}

#' Torvik `team` / `conf` for one season, refusing a response with no teams
#'
#' barttorvik.com answers a blocked request with an HTML page or an empty
#' body, which the ratings wrapper reads as a frame with no team rows. A
#' season Torvik covers must yield team rows or raise; before `first_season`
#' Torvik is not called and the `bart_*` columns stay NA.
#' @param fetch The ratings wrapper, called as `fetch(year = season)`.
#' @keywords internal
#' @noRd
.bb_torvik_teams <- function(fetch, season, first_season) {
  if (season < first_season) {
    return(data.frame(team = character(), conf = character(), stringsAsFactors = FALSE))
  }
  raw <- fetch(year = season)
  if (!all(c("team", "conf") %in% names(raw)) || all(is.na(raw[["team"]]))) {
    .bb_source_error(sprintf(
      "Torvik %d: no team rows (%d rows, columns %s); a blocked or empty response must not ship as NA bart_* columns",
      season, NROW(raw), paste(names(raw)[seq_len(min(5L, length(names(raw))))], collapse = ", ")
    ))
  }
  data.frame(team = as.character(raw[["team"]]), conf = as.character(raw[["conf"]]),
             stringsAsFactors = FALSE)
}

#' ESPN Division I team directory with each team's conference AS OF `season`
#'
#' The team list is ESPN's current one (every season gets today's teams); the
#' conference comes from [.bb_conference_map()], so a team that was not in a
#' Division I conference that season gets an NA `conference_name`.
#' @param sport ESPN slug, `"mens-college-basketball"` or
#'   `"womens-college-basketball"`.
#' @keywords internal
#' @noRd
.bb_espn_team_directory <- function(sport, league, season) {
  res <- .retry_request(
    paste0("http://site.api.espn.com/apis/site/v2/sports/basketball/", sport, "/teams"),
    params = list(groups = 50, limit = 1000)
  )
  check_status(res)
  teams <- jsonlite::fromJSON(.resp_text(res), simplifyVector = FALSE)[["sports"]][[1]][["leagues"]][[1]][["teams"]]
  pick <- function(k) vapply(teams, function(t) as.character(t[["team"]][[k]] %||% NA_character_), character(1))
  out <- data.frame(
    team_id = pick("id"), abbreviation = pick("abbreviation"),
    display_name = pick("displayName"), short_name = pick("shortDisplayName"),
    team = pick("location"), mascot = pick("name"),
    stringsAsFactors = FALSE
  )
  conf <- .bb_conference_map(league, season)
  # Join on character ids both sides -- never through a numeric cast.
  stopifnot(is.character(out$team_id), is.character(conf$team_id))
  out$conference_name <- conf$conference_name[match(out$team_id, conf$team_id)]
  out
}

#' Null `fox_section` where Fox files a team under a conference it was not in
#'
#' Fox's past-season standings usually pair that season's records with the
#' NEXT season's membership (the 2022-23 Big 12 table carries BYU, Cincinnati,
#' Houston and UCF; the 2025-26 Pac-12 table is the whole 2026-27 Pac-12). So
#' each Fox conference is identified by the `espn_conference` most of its
#' non-mover teams had that season (ties to the first in C-locale order); a
#' team whose `espn_conference` disagrees is nulled, as is every team of a
#' Fox conference with fewer than two agreeing non-movers. Teams with no
#' `espn_conference` do not vote. `fox_team_id` is kept.
#' @param xwalk Assembled team crosswalk (`espn_team_id`, `espn_conference`,
#'   `fox_section`).
#' @param movers ESPN team ids whose conference changes the next season.
#' @keywords internal
#' @noRd
.bb_drop_unconfirmed_fox_sections <- function(xwalk, movers = character()) {
  sec <- xwalk$fox_section
  conf <- xwalk$espn_conference
  stayed <- !is.na(sec) & !is.na(conf) & !(as.character(xwalk$espn_team_id) %in% movers)
  votes <- split(conf[stayed], sec[stayed])
  modal <- vapply(votes, function(v) {
    n <- table(v)
    sort(names(n)[n == max(n)], method = "radix")[1]
  }, character(1))
  fox_conf <- unname(modal[sec])
  agree <- !is.na(sec) &
    ((is.na(conf) & is.na(fox_conf)) | (!is.na(conf) & !is.na(fox_conf) & conf == fox_conf))
  n_ok <- table(sec[agree & stayed])
  keep <- agree & sec %in% names(n_ok)[n_ok >= 2]
  xwalk$fox_section[!keep] <- NA_character_
  xwalk
}
