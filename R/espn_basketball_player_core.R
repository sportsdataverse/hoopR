#' **Project an ESPN core-v2 athlete record into a `player_core` row**
#' @name espn_basketball_player_core
NULL
#' @rdname espn_basketball_player_core
#' @aliases espn_basketball_player_core
#' @title **Project an ESPN core-v2 athlete record into a `player_core` row**
#' @description Turns one ESPN core-v2 `/athletes/{id}` payload into the single
#'   tidy row released as the `player_core` dataset.
#'
#'   This is a **pure projection**: it takes an already-fetched payload and
#'   never performs I/O. That is deliberate — the compile stages in
#'   `hoopR-nba-data` / `hoopR-mbb-data` read the payload from the sibling
#'   `-raw` tree, and re-fetching here would both break the one-way
#'   raw -> data boundary and mean the R and Python pipelines read different
#'   bytes, so a value divergence could not be attributed to method.
#'
#'   Ids for college and current team are parsed out of the payload's `$ref`
#'   URLs (`/colleges/{id}`, `/teams/{id}`). The `$ref` is **never** followed.
#'
#' @details **What the row means.** `current_team_id` is the athlete's team
#'   *today*, not their team in any past season — the season a released row is
#'   filed under is *participation* (who appeared that year, taken from
#'   `player_box`), not the vintage of the bio. Height, weight and jersey are
#'   likewise a current snapshot: ESPN overwrites them in place, so era-correct
#'   bio is not obtainable from this endpoint.
#'
#'   **Parity.** This is a port of `sportsdataverse.nba.helper_nba_player_core`
#'   (sdv-py 0.0.75), which produces the released dataset today. The two are
#'   held to byte-parity by `tests/testthat/test-espn_basketball_player_core.R`
#'   against a golden fixture captured from that function; see
#'   `tests/testthat/fixtures/player_core/README.md` for provenance. Neither
#'   implementation is authoritative — a divergence is a review item.
#'
#' @param payload list. One athlete's core-v2 `/athletes/{athlete_id}` payload,
#'   as returned by `jsonlite::fromJSON(..., simplifyVector = FALSE)`. An empty
#'   or non-list value yields a zero-row tibble rather than an error.
#' @param athlete_id numeric or character. The ESPN athlete id. **Required and
#'   never inferred from the payload** — callers pass the id from the file path,
#'   so a payload missing its own `id` still produces a joinable row.
#'
#' @return A one-row tibble carrying the full 35-column set (absent fields are
#'   `NA`), so callers see a stable schema regardless of payload completeness:
#'
#'   |col_name|types|
#'   |---|---|
#'   |athlete_id|integer|
#'   |guid|character|
#'   |uid|character|
#'   |slug|character|
#'   |type|character|
#'   |first_name|character|
#'   |last_name|character|
#'   |full_name|character|
#'   |display_name|character|
#'   |short_name|character|
#'   |height|numeric|
#'   |display_height|character|
#'   |weight|numeric|
#'   |display_weight|character|
#'   |age|integer|
#'   |date_of_birth|character|
#'   |birth_city|character|
#'   |birth_state|character|
#'   |birth_country|character|
#'   |jersey|character|
#'   |position_id|integer|
#'   |position_name|character|
#'   |position_abbreviation|character|
#'   |position_display_name|character|
#'   |college_id|integer|
#'   |current_team_id|integer|
#'   |headshot_href|character|
#'   |experience_years|integer|
#'   |status_id|integer|
#'   |status_name|character|
#'   |status_type|character|
#'   |draft_year|integer|
#'   |draft_round|integer|
#'   |draft_selection|integer|
#'   |active|logical|
#'
#' @examples
#' \donttest{
#'   # Split across lines to keep the Rd under the line-width limit; the
#'   # core-v2 $ref URLs are long enough to be truncated in the PDF manual.
#'   team_ref <- paste0(
#'     "http://sports.core.api.espn.com/v2/sports/basketball/",
#'     "leagues/nba/seasons/2025/teams/22"
#'   )
#'   payload <- list(
#'     guid = "abc", fullName = "Jane Doe", jersey = "23",
#'     position = list(id = "5", abbreviation = "G"),
#'     team = list(`$ref` = team_ref)
#'   )
#'   espn_basketball_player_core(payload, athlete_id = 1966)
#' }
#' @section Twin:
#' `wehoop::espn_basketball_player_core()` is the identical function for the
#' women's leagues. The core-v2 athlete resource is the same payload shape for
#' nba/wnba/mbb/wbb, so the projection is league-agnostic -- sdv-py implements
#' it once and re-exports it per league. hoopR and wehoop are independently
#' published and neither depends on the other, so here it is duplicated:
#' **a change to one must land in the other in the same session, verified.**
#' @author Saiem Gilani
#' @importFrom janitor clean_names
#' @family Basketball Analytics Utilities
#' @export
espn_basketball_player_core <- function(payload, athlete_id) {
  cols <- .player_core_cols()

  if (!is.list(payload) || length(payload) == 0) {
    # Python returns a zero-COLUMN frame here; this returns the typed zero-ROW
    # schema instead, per the R convention that an empty result still carries
    # its column set. The difference is immaterial to parity: both pipelines
    # drop empty results before concatenating, so neither shape reaches a
    # released file.
    return(.player_core_empty(cols))
  }

  position <- .pc_node(payload[["position"]])
  status <- .pc_node(payload[["status"]])
  birth <- .pc_node(payload[["birthPlace"]])
  headshot <- .pc_node(payload[["headshot"]])
  experience <- .pc_node(payload[["experience"]])
  draft <- .pc_node(payload[["draft"]])

  row <- list(
    athlete_id = .pc_int(athlete_id),
    guid = .pc_chr(payload[["guid"]]),
    uid = .pc_chr(payload[["uid"]]),
    slug = .pc_chr(payload[["slug"]]),
    type = .pc_chr(payload[["type"]]),
    first_name = .pc_chr(payload[["firstName"]]),
    last_name = .pc_chr(payload[["lastName"]]),
    full_name = .pc_chr(payload[["fullName"]]),
    # displayName falls back to fullName -- some core records carry only one.
    display_name = .pc_coalesce_chr(payload[["displayName"]], payload[["fullName"]]),
    short_name = .pc_chr(payload[["shortName"]]),
    height = .pc_dbl(payload[["height"]]),
    display_height = .pc_chr(payload[["displayHeight"]]),
    weight = .pc_dbl(payload[["weight"]]),
    display_weight = .pc_chr(payload[["displayWeight"]]),
    age = .pc_int(payload[["age"]]),
    date_of_birth = .pc_chr(payload[["dateOfBirth"]]),
    birth_city = .pc_chr(birth[["city"]]),
    birth_state = .pc_chr(birth[["state"]]),
    # College payloads carry a top-level birthCountry; pro payloads nest it.
    birth_country = .pc_coalesce_chr(birth[["country"]], payload[["birthCountry"]]),
    jersey = .pc_chr(payload[["jersey"]]),
    position_id = .pc_int(position[["id"]]),
    position_name = .pc_chr(position[["name"]]),
    position_abbreviation = .pc_chr(position[["abbreviation"]]),
    position_display_name = .pc_chr(position[["displayName"]]),
    college_id = .pc_ref_id(payload[["college"]]),
    current_team_id = .pc_ref_id(payload[["team"]]),
    headshot_href = .pc_chr(headshot[["href"]]),
    experience_years = .pc_int(experience[["years"]]),
    status_id = .pc_int(status[["id"]]),
    status_name = .pc_chr(status[["name"]]),
    status_type = .pc_chr(status[["type"]]),
    draft_year = .pc_int(draft[["year"]]),
    draft_round = .pc_int(draft[["round"]]),
    draft_selection = .pc_int(draft[["selection"]]),
    active = .pc_lgl(payload[["active"]])
  )

  .player_core_finalize(tibble::as_tibble(row[cols]))
}

#' The released column order. Order is part of the contract -- both pipelines
#' feed the same parquet and some consumers select positionally.
#' @noRd
.player_core_cols <- function() {
  c(
    "athlete_id", "guid", "uid", "slug", "type", "first_name", "last_name",
    "full_name", "display_name", "short_name", "height", "display_height",
    "weight", "display_weight", "age", "date_of_birth", "birth_city",
    "birth_state", "birth_country", "jersey", "position_id", "position_name",
    "position_abbreviation", "position_display_name", "college_id",
    "current_team_id", "headshot_href", "experience_years", "status_id",
    "status_name", "status_type", "draft_year", "draft_round",
    "draft_selection", "active"
  )
}

#' @noRd
.player_core_int_cols <- function() {
  c(
    "athlete_id", "age", "position_id", "college_id", "current_team_id",
    "experience_years", "status_id", "draft_year", "draft_round",
    "draft_selection"
  )
}

#' Zero-row tibble carrying the documented schema.
#' @noRd
.player_core_empty <- function(cols) {
  int_cols <- .player_core_int_cols()
  dbl_cols <- c("height", "weight")
  proto <- lapply(cols, function(c) {
    if (c %in% int_cols) integer() else if (c %in% dbl_cols) numeric() else if (c == "active") logical() else character()
  })
  names(proto) <- cols
  # The empty path is finalized identically to the populated one, so a caller
  # that chains on the result sees the same class and attributes whether or not
  # the payload had anything in it.
  .player_core_finalize(tibble::as_tibble(proto))
}

#' Apply the package data contract to a player_core frame.
#'
#' Both return paths go through here so they cannot drift: the type string in
#' particular was previously written out twice, which is one edit away from the
#' two paths disagreeing about what they claim to be.
#' @noRd
.player_core_finalize <- function(df) {
  df %>%
    janitor::clean_names() %>%
    make_hoopR_data("ESPN Basketball Player Core from ESPN.com", Sys.time())
}

#' A nested node, or an empty list when absent. Mirrors Python's
#' `payload.get(k) or {}` so a missing node yields NA fields, never an error.
#' @noRd
.pc_node <- function(x) if (is.list(x)) x else list()

#' R's `as.character()` on the first element; NA for NULL/empty.
#'
#' The Python side hand-emulates this (bool -> "TRUE"/"FALSE", R-style float
#' formatting) precisely because R is the reference behaviour, so here it is
#' simply `as.character()`.
#' @noRd
.pc_chr <- function(x) {
  if (is.null(x) || length(x) == 0) return(NA_character_)
  if (is.list(x)) x <- x[[1]]
  if (is.null(x) || length(x) == 0) return(NA_character_)
  as.character(x[[1]])
}

#' First non-NA of two character candidates.
#' @noRd
.pc_coalesce_chr <- function(a, b) {
  out <- .pc_chr(a)
  if (is.na(out)) .pc_chr(b) else out
}

#' `as.integer()` on the first element, tolerating numeric strings and
#' doubles; NA when absent or unparseable.
#' @noRd
.pc_int <- function(x) {
  if (is.null(x) || length(x) == 0) return(NA_integer_)
  if (is.list(x)) x <- x[[1]]
  if (is.null(x) || length(x) == 0) return(NA_integer_)
  v <- suppressWarnings(as.numeric(x[[1]]))
  if (is.na(v)) NA_integer_ else as.integer(v)
}

#' @noRd
.pc_dbl <- function(x) {
  if (is.null(x) || length(x) == 0) return(NA_real_)
  if (is.list(x)) x <- x[[1]]
  if (is.null(x) || length(x) == 0) return(NA_real_)
  v <- suppressWarnings(as.numeric(x[[1]]))
  if (is.na(v)) NA_real_ else v
}

#' @noRd
.pc_lgl <- function(x) {
  if (is.null(x) || length(x) == 0) return(NA)
  if (is.list(x)) x <- x[[1]]
  if (is.null(x) || length(x) == 0) return(NA)
  as.logical(x[[1]])
}

#' Trailing numeric id from a core-v2 `$ref` URL. Parses, never fetches.
#'
#' Returns NA when the node is absent or the URL carries no `/colleges/{id}`
#' or `/teams/{id}` segment -- an unrecognised ref must not yield a wrong id.
#' @noRd
.pc_ref_id <- function(node) {
  if (!is.list(node)) return(NA_integer_)
  ref <- node[["$ref"]]
  if (is.null(ref) || length(ref) == 0) return(NA_integer_)
  m <- regmatches(
    as.character(ref[[1]]),
    regexpr("/(colleges|teams)/[0-9]+", as.character(ref[[1]]))
  )
  if (length(m) == 0) return(NA_integer_)
  as.integer(sub("^.*/", "", m))
}
