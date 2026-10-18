# cebl_parsers.R -- frames of the CEBL wrappers (internal; parse_* is not exported).
#
# R mirror of sdv-py sportsdataverse/basketball/cebl/cebl_parsers.py (origin/main e3d232ebc9): every frame
# is built from `.cebl_specs` (R/cebl_schema.R), one dtype per column, never sampled. The API sends
# aggregates as decimal strings ('2256.0', '12.7'): doubles here. Every id is an integer (CEBL's own key
# space; `genius_match_id` is the Genius LiveStats match id, an integer as in the genius family). Times are
# POSIXct in UTC. An empty or unrecognised input is a zero-row tibble with the documented columns.

#' @noRd
.cebl_scalar <- function(v) !is.null(v) && is.atomic(v) && length(v) == 1L && !is.na(v)

#' An integer from an integer or a whole number / numeric string ('5', '5.0'); never from a logical.
#' @noRd
.cebl_i <- function(v) {
  if (!.cebl_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  f <- if (is.character(v)) suppressWarnings(as.numeric(trimws(v))) else as.double(v)
  if (is.na(f) || !is.finite(f) || f != trunc(f) || abs(f) > .Machine$integer.max) return(NA_integer_)
  as.integer(f)
}

#' A double from a number or a decimal string ('25.9'); never from a logical.
#' @noRd
.cebl_f <- function(v) {
  if (!.cebl_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  t <- trimws(v)
  if (grepl("^[+-]?[0-9]+(\\.[0-9]+)?$", t, perl = TRUE)) as.double(t) else NA_real_
}

#' Python `str()` of a JSON scalar: a whole double keeps its ".0", a logical is "True" / "False".
#' @noRd
.cebl_py_str <- function(v) {
  if (is.null(v)) return("None")
  if (is.list(v)) return(as.character(jsonlite::toJSON(v, auto_unbox = TRUE, null = "null")))
  if (is.logical(v)) return(if (v) "True" else "False")
  # jsonlite reads a JSON integer past 2^31 as a double: Python str() of that int has no ".0"
  if (is.double(v) && is.finite(v) && v == trunc(v) && abs(v) >= 2^31 && abs(v) < 1e16) return(format(v, scientific = FALSE))
  if (is.double(v) && is.finite(v) && v == trunc(v) && abs(v) < 1e16) return(paste0(format(v, scientific = FALSE), ".0"))
  as.character(v)
}

#' A string; a list (the broadcaster logos) is joined with "; ".
#' @noRd
.cebl_s <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (.cebl_is_array(v)) {
    out <- paste(vapply(v, .cebl_py_str, character(1)), collapse = "; ")
    return(if (nzchar(out)) out else NA_character_)
  }
  if (is.list(v)) return(.cebl_py_str(v))
  if (length(v) != 1L || is.na(v)) return(NA_character_)
  if (is.character(v)) v else .cebl_py_str(v)
}

#' @noRd
.cebl_b <- function(v) if (.cebl_scalar(v) && is.logical(v)) v else NA

#' A `YYYY-MM-DD` date as days since the epoch.
#' @noRd
.cebl_d <- function(v) {
  if (!.cebl_scalar(v) || !is.character(v) || !grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", v)) return(NA_real_)
  as.double(as.Date(v, format = "%Y-%m-%d"))
}

#' An ISO-8601 timestamp ('2025-05-11T22:00:00Z', an offset, or none = UTC) as seconds since the epoch.
#' @noRd
.cebl_t <- function(v) {
  if (!.cebl_scalar(v) || !is.character(v)) return(NA_real_)
  re <- "^([0-9]{4}-[0-9]{2}-[0-9]{2})(?:[T ]([0-9]{2}:[0-9]{2}(?::[0-9]{2}(?:\\.[0-9]{1,6})?)?))?(Z|[+-][0-9]{2}:?[0-9]{2})?$"
  m <- regmatches(v, regexec(re, v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  clock <- if (nzchar(m[[3]])) m[[3]] else "00:00"
  if (nchar(clock) == 5L) clock <- paste0(clock, ":00")
  at <- as.double(as.POSIXct(paste(m[[2]], clock), format = "%Y-%m-%d %H:%M:%OS", tz = "UTC"))
  off <- m[[4]]
  if (nzchar(off) && off != "Z") {
    digits <- gsub(":", "", substring(off, 2L), fixed = TRUE)
    secs <- as.integer(substr(digits, 1L, 2L)) * 3600 + as.integer(substr(digits, 3L, 4L)) * 60
    at <- at - if (startsWith(off, "-")) -secs else secs
  }
  at
}

#' The Genius LiveStats match id in the first URL that carries one (`/u/CEBL/{id}/`, `?id={id}`).
#' @noRd
.cebl_genius <- function(...) {
  for (u in list(...)) {
    if (!is.character(u) || length(u) != 1L) next
    m <- regmatches(u, regexec("/u/CEBL/([0-9]+)(?:/|$)|[?&]id=([0-9]+)(?:&|$)", u, perl = TRUE))[[1]]
    if (length(m)) return(as.integer(if (nzchar(m[[2]])) m[[2]] else m[[3]]))
  }
  NA_integer_
}

#' The value of one spec source for one row (see R/cebl_schema.R).
#' @noRd
.cebl_value <- function(src, r, ctx) {
  if (startsWith(src, "@")) return(ctx[[substring(src, 2L)]])
  if (!startsWith(src, "=")) return(r[[src]])
  parts <- strsplit(substring(src, 2L), ":", fixed = TRUE)[[1]]
  switch(parts[[1]],
    league_row = is.null(r[["id"]]),
    career = is.null(r[["season"]]),
    statistic = r[["__statistic"]],
    year = {
      at <- .cebl_t(r[[parts[[2]]]])
      if (is.na(at)) NA_integer_ else as.integer(format(as.POSIXct(at, origin = "1970-01-01", tz = "UTC"), "%Y"))
    },
    genius = do.call(.cebl_genius, lapply(strsplit(parts[[2]], ",", fixed = TRUE)[[1]], function(k) r[[k]]))
  )
}

#' One column from its values and type code.
#' @noRd
.cebl_column <- function(values, type) {
  switch(type,
    i = vapply(values, .cebl_i, integer(1), USE.NAMES = FALSE),
    f = vapply(values, .cebl_f, double(1), USE.NAMES = FALSE),
    s = vapply(values, .cebl_s, character(1), USE.NAMES = FALSE),
    b = vapply(values, .cebl_b, logical(1), USE.NAMES = FALSE),
    d = structure(vapply(values, .cebl_d, double(1), USE.NAMES = FALSE), class = "Date"),
    t = as.POSIXct(vapply(values, .cebl_t, double(1), USE.NAMES = FALSE), origin = "1970-01-01", tz = "UTC")
  )
}

#' The frame of `kind` from row objects and the request stamp.
#' @noRd
.cebl_frame <- function(kind, rows, ctx) {
  spec <- .cebl_specs[[kind]]
  src <- sub("\\|[a-z]$", "", spec)
  type <- sub("^.*\\|", "", spec)
  cols <- lapply(seq_along(spec), function(j) {
    .cebl_column(lapply(rows, function(r) .cebl_value(src[[j]], r, ctx)), type[[j]])
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

#' Parse a wrapper's raw record (`list(rows =, _request =)`) or a bare API body into the `kind` frame.
#' @noRd
.cebl_parse <- function(kind, raw) {
  body <- raw
  ctx <- list()
  if (.cebl_is_dict(raw) && all(c(.CEBL_REQUEST, "rows") %in% names(raw)) && .cebl_is_dict(raw[[.CEBL_REQUEST]])) {
    body <- raw[["rows"]]
    ctx <- raw[[.CEBL_REQUEST]]
  }
  list_rows <- function(x) if (.cebl_is_array(x)) Filter(.cebl_is_dict, x) else list()
  rows <- if (kind == "player") {
    if (.cebl_is_dict(body) && !is.null(body[["id"]])) list(body) else list()
  } else if (kind == "player_leaders") {
    if (.cebl_is_dict(body)) {
      unlist(lapply(names(body), function(stat) {
        lapply(list_rows(body[[stat]]), function(r) c(r, list(`__statistic` = stat)))
      }), recursive = FALSE) %||% list()
    } else {
      list()
    }
  } else {
    list_rows(body)
  }
  .cebl_frame(kind, rows, ctx)
}

#' @noRd
.cebl_out <- function(df, type) make_hoopR_data(df, type, Sys.time())
