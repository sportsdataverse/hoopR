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
