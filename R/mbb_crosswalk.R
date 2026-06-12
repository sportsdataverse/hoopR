# mbb_crosswalk.R -- exported MBB cross-source crosswalk builder.
# ESPN-anchored: one row per ESPN team per season, joined to Fox Sports
# (by normalized display_name), Bart Torvik (by normalized school location),
# and KenPom (teams_links bundled data, by normalized school name).
# Yahoo columns are NA placeholders.

# ---------------------------------------------------------------------------
# Torvik -> ESPN location alias table
# Maps a Torvik `team` name to the matching ESPN `team` (location/school).
# Applied BEFORE normalizing so the resulting keys align.
# ---------------------------------------------------------------------------
.mbb_bart_alias <- c(
  "Mississippi"            = "Ole Miss",
  "Connecticut"            = "UConn",
  "McNeese St."            = "McNeese",
  "St. Thomas"             = "St. Thomas-Minnesota",
  "N.C. State"             = "NC State",
  "Nebraska Omaha"         = "Omaha",
  "Texas A&M Corpus Chris" = "Texas A&M-Corpus Christi",
  "Seattle"                = "Seattle U",
  "Nicholls St."           = "Nicholls",
  "Sam Houston St."        = "Sam Houston",
  "Cal Baptist"            = "California Baptist",
  "Appalachian St."        = "App State",
  "Miami FL"               = "Miami",
  "Illinois Chicago"       = "UIC",
  "Southeastern Louisiana" = "SE Louisiana",
  "UMKC"                   = "Kansas City",
  "Hawaii"                 = "Hawai'i",
  "FIU"                    = "Florida International",
  "Albany"                 = "UAlbany",
  "LIU"                    = "Long Island University",
  "Tennessee Martin"       = "UT Martin",
  "Penn"                   = "Pennsylvania",
  "IU Indy"                = "IU Indianapolis",
  "Loyola MD"              = "Loyola Maryland",
  "Grambling St."          = "Grambling",
  "USC Upstate"            = "South Carolina Upstate",
  "Louisiana Monroe"       = "UL Monroe"
)

# ---------------------------------------------------------------------------
# KenPom -> ESPN location alias table
# Most Torvik aliases also apply to KenPom (same terse style). Extra entries
# handle KenPom-specific divergences.
# ---------------------------------------------------------------------------
.mbb_kp_alias <- c(
  # shared with Torvik
  "Mississippi"            = "Ole Miss",
  "Connecticut"            = "UConn",
  "McNeese St."            = "McNeese",
  "St. Thomas"             = "St. Thomas-Minnesota",
  "N.C. State"             = "NC State",
  "Nebraska Omaha"         = "Omaha",
  "Texas A&M Corpus Chris" = "Texas A&M-Corpus Christi",
  "Seattle"                = "Seattle U",
  "Nicholls St."           = "Nicholls",
  "Sam Houston St."        = "Sam Houston",
  "Cal Baptist"            = "California Baptist",
  "Appalachian St."        = "App State",
  "Miami FL"               = "Miami",
  "Illinois Chicago"       = "UIC",
  "Southeastern Louisiana" = "SE Louisiana",
  "UMKC"                   = "Kansas City",
  "Hawaii"                 = "Hawai'i",
  "FIU"                    = "Florida International",
  "Albany"                 = "UAlbany",
  "LIU"                    = "Long Island University",
  "Tennessee Martin"       = "UT Martin",
  "Penn"                   = "Pennsylvania",
  "IU Indy"                = "IU Indianapolis",
  "Loyola MD"              = "Loyola Maryland",
  "Grambling St."          = "Grambling",
  "USC Upstate"            = "South Carolina Upstate",
  "Louisiana Monroe"       = "UL Monroe",
  # KenPom-specific
  "CSUN"                   = "Cal State Northridge",
  "SIUE"                   = "SIU Edwardsville",
  "Southeast Missouri"     = "Southeast Missouri State"
)

# ---------------------------------------------------------------------------
# Fox display_name -> ESPN display_name alias table
# The join uses .bb_normalize_team() on both sides; these entries map Fox
# fox_team_name normalized values to ESPN display_name normalized values
# where the strings diverge.
# ---------------------------------------------------------------------------
.mbb_fox_display_alias <- c(
  # Fox drops "University", uses shortened or alternative forms
  "american eagles"                        = "american university eagles",
  "appalachian state mountaineers"         = "app state mountaineers",
  "central connecticut state blue devils"  = "central connecticut blue devils",
  "delaware fightin blue hens"             = "delaware blue hens",
  "fdu knights"                            = "fairleigh dickinson knights",
  "grambling state tigers"                 = "grambling tigers",
  "iu indy jaguars"                        = "iu indianapolis jaguars",
  "liu sharks"                             = "long island university sharks",
  "louisiana monroe warhawks"              = "ul monroe warhawks",
  "miami fl hurricanes"                    = "miami hurricanes",
  "nicholls state colonels"               = "nicholls colonels",
  "penn quakers"                           = "pennsylvania quakers",
  "queens university royals"               = "queens university royals",
  "seattle redhawks"                       = "seattle u redhawks",
  "southeastern louisiana lions"           = "se louisiana lions",
  "southern indiana screaming eagles"      = "southern indiana screaming eagles",
  "southern university jaguars"            = "southern jaguars",
  "st francis pa red flash"               = "saint francis red flash",
  "st thomas tommies"                      = "st thomas minnesota tommies",
  "tennessee martin skyhawks"              = "ut martin skyhawks",
  "uconn huskies"                          = "uconn huskies",
  "uic flames"                             = "uic flames",
  "umass minutemen"                        = "massachusetts minutemen",
  "unlv runnin rebels"                     = "unlv rebels",
  "university at albany great danes"       = "ualbany great danes",
  "usc upstate spartans"                   = "south carolina upstate spartans",
  "utah runnin utes"                       = "utah utes",
  "lindenwood lions"                       = "lindenwood lions"
)

# Internal helpers --------------------------------------------------------

#' @keywords internal
.mbb_apply_bart_alias <- function(x) {
  hit <- match(x, names(.mbb_bart_alias))
  ifelse(!is.na(hit), unname(.mbb_bart_alias[hit]), x)
}

#' @keywords internal
.mbb_apply_kp_alias <- function(x) {
  hit <- match(x, names(.mbb_kp_alias))
  ifelse(!is.na(hit), unname(.mbb_kp_alias[hit]), x)
}

#' @keywords internal
.mbb_apply_fox_alias <- function(x) {
  hit <- match(x, names(.mbb_fox_display_alias))
  ifelse(!is.na(hit), unname(.mbb_fox_display_alias[hit]), x)
}

# ---------------------------------------------------------------------------
# Internal assembler (takes already-fetched source frames as plain data.frames)
# ---------------------------------------------------------------------------

#' @keywords internal
#' @importFrom dplyr transmute left_join mutate select if_else case_when
.bb_assemble_team_crosswalk_mbb <- function(espn, fox, bart, kp, season) {

  # -- ESPN (dedupe, build keys) -------------------------------------------
  espn2 <- dplyr::transmute(
    espn[!duplicated(espn[["team_id"]]), ],
    espn_team_id      = as.integer(.data$team_id),
    espn_abbreviation = as.character(.data$abbreviation),
    espn_display_name = as.character(.data$display_name),
    espn_short_name   = as.character(.data$short_name),
    espn_location     = as.character(.data$team),
    espn_mascot       = as.character(.data$mascot),
    espn_conference   = as.character(.data$conference_name),
    # Fox match key: full mascot name normalized
    .fox_key  = .bb_normalize_team(.data$display_name),
    # College-team match key: school/location normalized (contracts State/Saint)
    .ct_key   = .bb_normalize_college_team(.data$team)
  )

  # -- Fox (build key with alias bridge) ------------------------------------
  if (is.null(fox) || !nrow(fox)) {
    fox2 <- data.frame(
      fox_team_id   = character(),
      fox_team_name = character(),
      fox_section   = character(),
      .fox_key      = character(),
      stringsAsFactors = FALSE
    )
  } else {
    fox_norm        <- .bb_normalize_team(fox[["fox_team_name"]])
    fox_key_bridged <- .mbb_apply_fox_alias(fox_norm)
    fox2 <- data.frame(
      fox_team_id   = as.character(fox[["fox_team_id"]]),
      fox_team_name = as.character(fox[["fox_team_name"]]),
      fox_section   = as.character(fox[["fox_section"]]),
      .fox_key      = fox_key_bridged,
      stringsAsFactors = FALSE
    )
    fox2 <- fox2[!duplicated(fox2$.fox_key), ]
  }

  # -- Torvik (alias + build key) ------------------------------------------
  if (is.null(bart) || !nrow(bart)) {
    bart2 <- data.frame(
      bart_team = character(),
      bart_conf = character(),
      .ct_key   = character(),
      stringsAsFactors = FALSE
    )
  } else {
    bart_loc_aliased <- .mbb_apply_bart_alias(bart[["team"]])
    bart2 <- data.frame(
      bart_team = as.character(bart[["team"]]),
      bart_conf = as.character(bart[["conf"]]),
      .ct_key   = .bb_normalize_college_team(bart_loc_aliased),
      stringsAsFactors = FALSE
    )
    bart2 <- bart2[!duplicated(bart2$.ct_key), ]
  }

  # -- KenPom (alias + build key) ------------------------------------------
  if (is.null(kp) || !nrow(kp)) {
    kp2 <- data.frame(
      kp_team = character(),
      kp_conf = character(),
      .ct_key  = character(),
      stringsAsFactors = FALSE
    )
  } else {
    kp_loc_aliased <- .mbb_apply_kp_alias(kp[["Team"]])
    kp2 <- data.frame(
      kp_team = as.character(kp[["Team"]]),
      kp_conf = as.character(kp[["Conf"]]),
      .ct_key  = .bb_normalize_college_team(kp_loc_aliased),
      stringsAsFactors = FALSE
    )
    kp2 <- kp2[!duplicated(kp2$.ct_key), ]
  }

  # -- Join (exact on normalized keys) ------------------------------------
  # bart and kp share .ct_key — rename to avoid collision
  names(bart2)[names(bart2) == ".ct_key"] <- ".ct_key_bart"
  names(kp2)[names(kp2)   == ".ct_key"]  <- ".ct_key_kp"
  espn2$.ct_key_bart <- espn2$.ct_key
  espn2$.ct_key_kp   <- espn2$.ct_key

  out <- espn2 |>
    dplyr::left_join(fox2,  by = ".fox_key") |>
    dplyr::left_join(bart2, by = ".ct_key_bart") |>
    dplyr::left_join(kp2,   by = ".ct_key_kp") |>
    dplyr::mutate(
      season                = as.integer(season),
      yahoo_team_id         = NA_character_,
      yahoo_team_name       = NA_character_,
      fox_match_confidence  = dplyr::if_else(
        !is.na(.data$fox_team_id), 1, NA_real_
      ),
      bart_match_confidence = dplyr::if_else(
        !is.na(.data$bart_team), 1, NA_real_
      ),
      kp_match_confidence   = dplyr::if_else(
        !is.na(.data$kp_team), 1, NA_real_
      ),
      match_method = dplyr::case_when(
        !is.na(.data$fox_team_id) & !is.na(.data$bart_team) & !is.na(.data$kp_team) ~ "fox+bart+kp",
        !is.na(.data$fox_team_id) & !is.na(.data$bart_team)                          ~ "fox+bart",
        !is.na(.data$fox_team_id) & !is.na(.data$kp_team)                            ~ "fox+kp",
        !is.na(.data$bart_team)   & !is.na(.data$kp_team)                            ~ "bart+kp",
        !is.na(.data$fox_team_id)                                                    ~ "fox_only",
        !is.na(.data$bart_team)                                                      ~ "bart_only",
        !is.na(.data$kp_team)                                                        ~ "kp_only",
        TRUE                                                                         ~ "espn_only"
      )
    ) |>
    dplyr::select(
      "season",
      "espn_team_id", "espn_abbreviation", "espn_display_name",
      "espn_short_name", "espn_location", "espn_mascot", "espn_conference",
      "fox_team_id", "fox_team_name", "fox_section",
      "bart_team", "bart_conf",
      "kp_team", "kp_conf",
      "yahoo_team_id", "yahoo_team_name",
      "fox_match_confidence", "bart_match_confidence", "kp_match_confidence",
      "match_method"
    )
  out
}

# ---------------------------------------------------------------------------
# Exported builder
# ---------------------------------------------------------------------------

#' **Get the MBB cross-source team crosswalk**
#' @name mbb_team_crosswalk
NULL
#' @title
#' **Get the MBB cross-source team crosswalk**
#' @rdname mbb_team_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-team-per-season crosswalk linking ESPN,
#' Fox Sports (Bifrost), Bart Torvik (barttorvik.com), and KenPom
#' (`hoopR::teams_links` bundled data) men's college basketball team
#' identities, keyed on `espn_team_id`. Yahoo columns are NA placeholders.
#' ESPN is deduped by `team_id` (first occurrence kept).
#'
#' Fox is joined on the full normalized mascot name (with a curated alias
#' bridge for cases where Fox and ESPN differ). Torvik and KenPom are each
#' joined on the normalized school/location name after a curated alias pass
#' for common divergences (e.g. "UConn" / "Connecticut", "Ole Miss" /
#' "Mississippi", "LIU" / "Long Island University"). No authentication is
#' required for any source — Fox is the only network call (slow, ~60 s);
#' Torvik is a single CSV; KenPom uses the bundled `teams_links` object.
#'
#' @param season Season year (4-digit, e.g. `2025`). Defaults to
#'   `most_recent_mbb_season()`.
#' @param fox An already-fetched `fox_mbb_teams_all()` frame, or `NULL`
#'   (default) to fetch live. Pass a pre-fetched frame to avoid the
#'   ~60-second Fox enumeration when calling repeatedly.
#' @return A `hoopR_data` tibble, one row per ESPN team:
#'
#'   |col_name               |types     |description                                       |
#'   |:----------------------|:---------|:-------------------------------------------------|
#'   |season                 |integer   |Season year.                                      |
#'   |espn_team_id           |integer   |ESPN team id (canonical key).                     |
#'   |espn_abbreviation      |character |ESPN abbreviation.                                |
#'   |espn_display_name      |character |ESPN display name (school + mascot).              |
#'   |espn_short_name        |character |ESPN short name.                                  |
#'   |espn_location          |character |ESPN school/location only.                        |
#'   |espn_mascot            |character |ESPN mascot/nickname.                             |
#'   |espn_conference        |character |ESPN conference name.                             |
#'   |fox_team_id            |character |Fox Bifrost team id (NA if unmatched).            |
#'   |fox_team_name          |character |Fox team name (NA if unmatched).                  |
#'   |fox_section            |character |Fox conference/section label (NA if unmatched).   |
#'   |bart_team              |character |Torvik team name (NA if unmatched).               |
#'   |bart_conf              |character |Torvik conference abbreviation (NA if unmatched). |
#'   |kp_team                |character |KenPom team name (NA if unmatched).               |
#'   |kp_conf                |character |KenPom conference abbreviation (NA if unmatched). |
#'   |yahoo_team_id          |character |Yahoo team id (NA placeholder).                   |
#'   |yahoo_team_name        |character |Yahoo team name (NA placeholder).                 |
#'   |fox_match_confidence   |numeric   |1 for matched, NA for unmatched.                  |
#'   |bart_match_confidence  |numeric   |1 for matched, NA for unmatched.                  |
#'   |kp_match_confidence    |numeric   |1 for matched, NA for unmatched.                  |
#'   |match_method           |character |Combination of matched sources, e.g.              |
#'   |                       |          |"fox+bart+kp" / "fox+bart" / "bart+kp" /         |
#'   |                       |          |"fox_only" / "bart_only" / "kp_only" /            |
#'   |                       |          |"espn_only".                                      |
#'
#' @importFrom dplyr transmute left_join mutate select if_else case_when
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#'   try(mbb_team_crosswalk(season = 2025))
#' }
mbb_team_crosswalk <- function(season = most_recent_mbb_season(),
                               fox = NULL) {
  .args <- .capture_args()
  out <- data.frame()
  tryCatch(
    expr = {
      espn_raw <- espn_mbb_teams(year = season)
      bart_raw <- tryCatch(torvik_ratings(year = season),
                           error = function(e) NULL)
      # KenPom: use bundled teams_links; fall back to most-recent year
      kp_raw <- tryCatch({
        kp_all  <- hoopR::teams_links
        kp_yrs  <- sort(unique(kp_all[["Year"]]))
        kp_yr   <- if (season %in% kp_yrs) season else max(kp_yrs)
        kp_all[kp_all[["Year"]] == kp_yr, ]
      }, error = function(e) NULL)
      if (is.null(kp_raw) || !nrow(kp_raw)) {
        kp_raw <- data.frame(
          Team = character(), Conf = character(), stringsAsFactors = FALSE
        )
      }

      fox_raw <- if (!is.null(fox)) fox else {
        tryCatch(fox_mbb_teams_all(), error = function(e) NULL)
      }
      out <- .bb_assemble_team_crosswalk_mbb(
        espn   = as.data.frame(espn_raw),
        fox    = if (!is.null(fox_raw)) as.data.frame(fox_raw) else NULL,
        bart   = if (!is.null(bart_raw)) as.data.frame(bart_raw) else NULL,
        kp     = as.data.frame(kp_raw),
        season = season
      ) |>
        make_hoopR_data(
          "MBB team crosswalk (ESPN / Fox / Torvik / KenPom)",
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Could not build MBB team crosswalk for {season}!",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning building MBB team crosswalk for {season}",
      args = .args
    ),
    finally = {}
  )
  out
}

# ===========================================================================
# mbb_schedule_crosswalk
# ===========================================================================

#' @keywords internal
#' @importFrom dplyr transmute full_join mutate select case_when if_else
.bb_assemble_schedule_crosswalk_mbb <- function(espn_games, bart_games,
                                                 team_xwalk, season) {
  # Build a lookup: normalized Torvik team name -> espn_team_id.
  # Reuse the same alias pass that mbb_team_crosswalk uses.
  bart_lookup <- team_xwalk[!is.na(team_xwalk$bart_team), , drop = FALSE]
  bart_lookup$.bart_key <- .bb_normalize_college_team(
    .mbb_apply_bart_alias(as.character(bart_lookup$bart_team))
  )

  # Resolve Torvik team1/team2 names -> espn_team_id
  bart_key1 <- .bb_normalize_college_team(
    .mbb_apply_bart_alias(as.character(bart_games$team1))
  )
  bart_key2 <- .bb_normalize_college_team(
    .mbb_apply_bart_alias(as.character(bart_games$team2))
  )

  t1_espn_id <- bart_lookup$espn_team_id[match(bart_key1, bart_lookup$.bart_key)]
  t2_espn_id <- bart_lookup$espn_team_id[match(bart_key2, bart_lookup$.bart_key)]

  # Pair key: sort espn ids so team1/team2 ordering doesn't matter
  .pair_key <- function(a, b) {
    ids <- matrix(c(as.integer(a), as.integer(b)), ncol = 2)
    apply(ids, 1, function(row) {
      if (any(is.na(row))) NA_character_
      else paste(sort(row), collapse = "_")
    })
  }

  # ESPN side
  espn2 <- dplyr::transmute(
    espn_games,
    game_date         = .data$game_date,
    home_espn_team_id = as.integer(.data$home_espn_team_id),
    away_espn_team_id = as.integer(.data$away_espn_team_id),
    espn_game_id      = as.character(.data$espn_game_id),
    .pair_key         = .pair_key(.data$home_espn_team_id, .data$away_espn_team_id)
  )

  # Torvik side — only keep games where both teams resolved to ESPN ids
  bart2 <- data.frame(
    game_date   = bart_games$game_date,
    bart_muid   = as.character(bart_games$muid),
    bart_team1  = as.character(bart_games$team1),
    bart_team2  = as.character(bart_games$team2),
    bart_winner = as.character(bart_games$winner),
    .t1_id      = t1_espn_id,
    .t2_id      = t2_espn_id,
    stringsAsFactors = FALSE
  )
  bart2 <- bart2[!is.na(bart2$.t1_id) & !is.na(bart2$.t2_id), , drop = FALSE]
  bart2$.pair_key <- .pair_key(bart2$.t1_id, bart2$.t2_id)
  bart2$.t1_id <- NULL
  bart2$.t2_id <- NULL

  key <- c("game_date", ".pair_key")
  out <- dplyr::full_join(espn2, bart2, by = key) |>
    dplyr::mutate(
      season           = as.integer(season),
      kp_game_id       = NA_character_,
      fox_game_id      = NA_character_,
      yahoo_game_id    = NA_character_,
      match_method     = dplyr::case_when(
        !is.na(.data$espn_game_id) & !is.na(.data$bart_muid) ~ "both",
        !is.na(.data$espn_game_id)                           ~ "espn_only",
        TRUE                                                  ~ "bart_only"
      ),
      match_confidence = dplyr::if_else(.data$match_method == "both", 1, NA_real_)
    ) |>
    dplyr::select(
      "season", "game_date",
      "home_espn_team_id", "away_espn_team_id",
      "espn_game_id", "bart_muid", "bart_team1", "bart_team2", "bart_winner",
      "kp_game_id", "fox_game_id", "yahoo_game_id",
      "match_method", "match_confidence"
    )
  out
}

#' **Get the MBB cross-source schedule crosswalk**
#' @name mbb_schedule_crosswalk
NULL
#' @title
#' **Get the MBB cross-source schedule crosswalk**
#' @rdname mbb_schedule_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-game crosswalk linking ESPN and Bart Torvik
#' (barttorvik.com) game identifiers for an MBB season. Fox Sports and Yahoo
#' game IDs are NA placeholders. KenPom game IDs are optionally enriched when
#' `include_kenpom = TRUE` and credentials are set (see below). Dates are
#' reduced to Eastern-Time game dates before joining; Torvik `team1`/`team2`
#' are unordered (the join uses a sorted team-pair key, so home/away from the
#' Torvik side is not preserved). Games where either Torvik team name cannot be
#' resolved to an ESPN id via `mbb_team_crosswalk()` are kept as `bart_only`
#' rows.
#'
#' **KenPom (optional):** KenPom requires a paid subscription. Set the
#' environment variables `KP_USER` (email) and `KP_PW` (password) and pass
#' `include_kenpom = TRUE`. When `include_kenpom = FALSE` (the default) or
#' when credentials are absent, `kp_game_id` is left as `NA` and no network
#' calls to KenPom are made. Errors from individual team schedule calls are
#' silently dropped so the function always returns a complete crosswalk even
#' when partial KenPom data is unavailable.
#'
#' @param season Season year (4-digit, e.g. `2025`). Defaults to
#'   `most_recent_mbb_season()`.
#' @param include_kenpom Logical. When `TRUE` AND `KP_USER` is set,
#'   attempts to enrich `kp_game_id` via per-team `kp_team_schedule()` calls.
#'   Default `FALSE`.
#' @return A `hoopR_data` tibble, one row per game:
#'
#'    |col_name            |types     |description                                       |
#'    |:-------------------|:---------|:-------------------------------------------------|
#'    |season              |integer   |Season year.                                      |
#'    |game_date           |Date      |ET game date.                                     |
#'    |home_espn_team_id   |integer   |ESPN home team id (NA for bart-only rows).        |
#'    |away_espn_team_id   |integer   |ESPN away team id (NA for bart-only rows).        |
#'    |espn_game_id        |character |ESPN game id (NA for bart-only rows).             |
#'    |bart_muid           |character |Torvik muid (NA for espn-only rows).              |
#'    |bart_team1          |character |Torvik team1 name (NA for espn-only rows).        |
#'    |bart_team2          |character |Torvik team2 name (NA for espn-only rows).        |
#'    |bart_winner         |character |Torvik winner name (NA for espn-only rows).       |
#'    |kp_game_id          |character |KenPom game id (NA unless kenpom enabled).        |
#'    |fox_game_id         |character |Fox game id (NA placeholder).                     |
#'    |yahoo_game_id       |character |Yahoo game id (NA placeholder).                   |
#'    |match_method        |character |"both"/"espn_only"/"bart_only".                   |
#'    |match_confidence    |numeric   |1 for matched, NA for unmatched.                  |
#'
#' @importFrom dplyr transmute bind_rows left_join mutate
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#'   try(mbb_schedule_crosswalk(season = 2025))
#' }
mbb_schedule_crosswalk <- function(season = most_recent_mbb_season(),
                                    include_kenpom = FALSE) {
  .args <- .capture_args()
  out <- data.frame()
  tryCatch(
    expr = {
      team_xwalk <- mbb_team_crosswalk(season = season)

      # --- Torvik side -------------------------------------------------------
      bart_raw <- tryCatch(torvik_game_schedule(year = season),
                           error = function(e) NULL)
      if (is.null(bart_raw) || !nrow(bart_raw)) {
        bart_games <- data.frame(
          muid      = character(),
          game_date = as.Date(character()),
          team1     = character(),
          team2     = character(),
          winner    = character(),
          stringsAsFactors = FALSE
        )
      } else {
        bart_games <- dplyr::transmute(
          bart_raw,
          muid      = as.character(.data$muid),
          game_date = as.Date(as.character(.data$date), format = "%m/%d/%y"),
          team1     = as.character(.data$team1),
          team2     = as.character(.data$team2),
          winner    = as.character(.data$winner)
        )
        # Drop rows with unparseable dates
        bart_games <- bart_games[!is.na(bart_games$game_date), , drop = FALSE]
      }

      # --- ESPN side ---------------------------------------------------------
      # Derive unique ET dates from Torvik and call the MBB scoreboard once
      # per date. ~150 calls for a full season.
      dates <- sort(unique(bart_games$game_date))
      espn_list <- lapply(dates, function(d) {
        sb <- tryCatch(
          espn_mbb_scoreboard(season = as.integer(format(d, "%Y%m%d"))),
          error = function(e) NULL
        )
        if (is.null(sb) || !nrow(sb)) return(NULL)
        dplyr::transmute(
          sb,
          espn_game_id      = as.character(.data$game_id),
          game_date         = .bb_to_eastern(.data$game_date_time),
          home_espn_team_id = as.integer(.data$home_team_id),
          away_espn_team_id = as.integer(.data$away_team_id)
        )
      })
      espn_games <- dplyr::bind_rows(espn_list)
      # Guard: if every scoreboard call returned NULL, build a properly-typed
      # empty frame so the assembler's transmute() does not error on missing
      # columns.
      if (!nrow(espn_games)) {
        espn_games <- data.frame(
          espn_game_id      = character(),
          game_date         = as.Date(character()),
          home_espn_team_id = integer(),
          away_espn_team_id = integer(),
          stringsAsFactors  = FALSE
        )
      }

      out <- .bb_assemble_schedule_crosswalk_mbb(
        espn_games  = espn_games,
        bart_games  = bart_games,
        team_xwalk  = as.data.frame(team_xwalk),
        season      = season
      )

      # --- Optional KenPom enrichment ----------------------------------------
      # Requires KP_USER + KP_PW env vars. Degrades gracefully to NA when
      # include_kenpom = FALSE or when credentials are absent.
      if (isTRUE(include_kenpom) &&
          nchar(Sys.getenv("KP_USER")) > 0 &&
          nchar(Sys.getenv("KP_PW"))   > 0) {

        kp_rows <- team_xwalk[!is.na(team_xwalk$kp_team), , drop = FALSE]

        # Helper: pair key for KenPom-resolved game rows
        .pair_key_kp <- function(a, b) {
          ids <- matrix(c(as.integer(a), as.integer(b)), ncol = 2)
          apply(ids, 1, function(row) {
            if (any(is.na(row))) NA_character_
            else paste(sort(row), collapse = "_")
          })
        }

        kp_xwalk_list <- lapply(seq_len(nrow(kp_rows)), function(i) {
          kp_team  <- kp_rows$kp_team[i]
          home_eid <- kp_rows$espn_team_id[i]

          sched <- tryCatch(
            kp_team_schedule(team = kp_team, year = season),
            error = function(e) NULL
          )
          if (is.null(sched) || !nrow(sched)) return(NULL)

          # Resolve the opponent to an espn_team_id via bart_team -> espn_team_id
          kp_alias_fn <- function(x) {
            hit <- match(x, names(.mbb_kp_alias))
            ifelse(!is.na(hit), unname(.mbb_kp_alias[hit]), x)
          }
          opp_norm <- .bb_normalize_college_team(
            kp_alias_fn(as.character(sched$opponent))
          )
          kp_lookup <- team_xwalk[!is.na(team_xwalk$kp_team), , drop = FALSE]
          kp_lookup$.kp_key <- .bb_normalize_college_team(
            kp_alias_fn(as.character(kp_lookup$kp_team))
          )
          opp_eid <- kp_lookup$espn_team_id[match(opp_norm, kp_lookup$.kp_key)]

          # Extract game_id from KenPom schedule
          kp_gid <- if ("game_id" %in% names(sched)) as.character(sched$game_id)
                    else NA_character_

          # Parse game date
          gdate <- if ("game_date" %in% names(sched)) {
            as.Date(as.character(sched$game_date))
          } else if ("date" %in% names(sched)) {
            tryCatch(as.Date(as.character(sched$date)), error = function(e) NA)
          } else {
            rep(NA, nrow(sched))
          }

          data.frame(
            game_date    = gdate,
            kp_game_id   = kp_gid,
            home_eid     = as.integer(home_eid),
            opp_eid      = as.integer(opp_eid),
            stringsAsFactors = FALSE
          )
        })

        kp_all <- dplyr::bind_rows(kp_xwalk_list)

        if (!is.null(kp_all) && nrow(kp_all) > 0) {
          kp_all <- kp_all[!is.na(kp_all$game_date) & !is.na(kp_all$kp_game_id), ]
          kp_all$.pair_key <- .pair_key_kp(kp_all$home_eid, kp_all$opp_eid)
          kp_all <- kp_all[!is.na(kp_all$.pair_key), , drop = FALSE]
          kp_all <- kp_all[!duplicated(paste(kp_all$game_date, kp_all$.pair_key)), , drop = FALSE]

          out$.pair_key <- paste(
            out$game_date,
            apply(matrix(c(as.integer(out$home_espn_team_id),
                           as.integer(out$away_espn_team_id)), ncol = 2),
                  1, function(row) {
                    if (any(is.na(row))) NA_character_
                    else paste(sort(row), collapse = "_")
                  })
          )
          kp_key_map <- data.frame(
            .join_key   = paste(kp_all$game_date, kp_all$.pair_key),
            kp_game_id  = kp_all$kp_game_id,
            stringsAsFactors = FALSE
          )
          kp_key_map <- kp_key_map[!duplicated(kp_key_map$.join_key), ]
          out$kp_game_id <- kp_key_map$kp_game_id[
            match(out$.pair_key, kp_key_map$.join_key)
          ]
          out$.pair_key <- NULL
        }
      }

      out <- make_hoopR_data(
        out,
        "MBB schedule crosswalk (ESPN / Torvik)",
        Sys.time()
      )
    },
    error   = function(e) .report_api_error(
      e, hint = "Could not build MBB schedule crosswalk for {season}!", args = .args
    ),
    warning = function(w) .report_api_warning(
      w, hint = "Warning building MBB schedule crosswalk for {season}", args = .args
    ),
    finally = {}
  )
  out
}

# ===========================================================================
# mbb_player_crosswalk
# ===========================================================================

#' @keywords internal
#' @importFrom dplyr transmute left_join mutate select
.bb_assemble_player_crosswalk_mbb <- function(espn, fox, season,
                                               min_confidence = 0.92) {
  espn2 <- dplyr::mutate(
    espn,
    .block    = as.character(.data$espn_team_id),
    .name_key = .bb_normalize_name(.data$espn_full_name)
  )

  l <- dplyr::transmute(
    espn2,
    .block    = .data$.block,
    .id       = .data$espn_athlete_id,
    .name_key = .data$.name_key,
    .jersey   = as.character(.data$espn_jersey)
  )

  if (!is.null(fox) && nrow(fox) > 0) {
    rf <- dplyr::transmute(
      fox,
      .block    = as.character(.data$espn_team_id),
      .id       = as.character(.data$fox_athlete_id),
      .name_key = .bb_normalize_name(.data$fox_player),
      .jersey   = as.character(.data$fox_jersey)
    )
    lf <- dplyr::transmute(
      espn2,
      .block    = .data$.block,
      .id       = .data$espn_athlete_id,
      .name_key = .data$.name_key,
      .jersey   = as.character(.data$espn_jersey)
    )
    m_fox <- .bb_fuzzy_match(lf, rf, min_confidence = min_confidence)
  } else {
    m_fox <- data.frame(
      left_id          = l$.id,
      right_id         = NA_character_,
      match_method     = "unmatched",
      match_confidence = NA_real_,
      stringsAsFactors = FALSE
    )
  }

  out <- espn2 |>
    dplyr::transmute(
      season            = as.integer(season),
      espn_team_id      = as.integer(.data$espn_team_id),
      team_abbreviation = as.character(.data$team_abbreviation),
      player_name       = .data$.name_key,
      espn_athlete_id   = as.character(.data$espn_athlete_id),
      espn_full_name    = as.character(.data$espn_full_name),
      espn_jersey       = as.character(.data$espn_jersey),
      espn_position     = as.character(.data$espn_position)
    ) |>
    dplyr::left_join(
      dplyr::transmute(
        m_fox,
        espn_athlete_id  = .data$left_id,
        fox_athlete_id   = .data$right_id,
        match_method     = .data$match_method,
        match_confidence = .data$match_confidence
      ),
      by = "espn_athlete_id"
    )

  if (!is.null(fox) && nrow(fox) > 0) {
    out <- dplyr::left_join(
      out,
      dplyr::transmute(
        fox,
        fox_athlete_id     = as.character(.data$fox_athlete_id),
        fox_player         = .data$fox_player,
        fox_jersey         = as.character(.data$fox_jersey),
        fox_position_group = .data$fox_position_group
      ),
      by = "fox_athlete_id"
    )
  } else {
    out$fox_player         <- NA_character_
    out$fox_jersey         <- NA_character_
    out$fox_position_group <- NA_character_
  }

  out |>
    dplyr::mutate(
      yahoo_player_id   = NA_character_,
      yahoo_player_name = NA_character_,
      match_keys        = NA_character_
    ) |>
    dplyr::select(
      "season", "espn_team_id", "team_abbreviation", "player_name",
      "espn_athlete_id", "espn_full_name", "espn_jersey", "espn_position",
      "fox_athlete_id", "fox_player", "fox_jersey", "fox_position_group",
      "yahoo_player_id", "yahoo_player_name",
      "match_method", "match_confidence", "match_keys"
    )
}

#' **Get the MBB cross-source player crosswalk**
#' @name mbb_player_crosswalk
NULL
#' @title
#' **Get the MBB cross-source player crosswalk**
#' @rdname mbb_player_crosswalk
#' @author Saiem Gilani
#' @description
#' Build a wide, one-row-per-player-per-team crosswalk linking ESPN and Fox
#' Sports (Bifrost) MBB player identities for a season. ESPN is the anchor
#' source; Fox is matched by normalized name (exact first, then Jaro-Winkler
#' fuzzy with jersey tiebreaker) within each team block. Yahoo columns are NA
#' placeholders. KenPom and Torvik have no per-player data for MBB, so neither
#' source is joined.
#'
#' @param season Season year (4-digit, e.g. `2025`). Defaults to
#'   `most_recent_mbb_season()`.
#' @param min_confidence Jaro-Winkler similarity floor for fuzzy matches
#'   (default 0.92).
#' @return A `hoopR_data` tibble, one row per player per team (ESPN-anchored):
#'
#'    |col_name            |types     |description                                       |
#'    |:-------------------|:---------|:-------------------------------------------------|
#'    |season              |integer   |Season year.                                      |
#'    |espn_team_id        |integer   |ESPN team id (canonical key).                     |
#'    |team_abbreviation   |character |ESPN team abbreviation.                           |
#'    |player_name         |character |Normalized player name (matching key).            |
#'    |espn_athlete_id     |character |ESPN athlete id.                                  |
#'    |espn_full_name      |character |ESPN full name.                                   |
#'    |espn_jersey         |character |ESPN jersey number.                               |
#'    |espn_position       |character |ESPN position abbreviation.                       |
#'    |fox_athlete_id      |character |Fox athlete id (NA if unmatched).                 |
#'    |fox_player          |character |Fox player name (NA if unmatched).                |
#'    |fox_jersey          |character |Fox jersey number (NA if unmatched).              |
#'    |fox_position_group  |character |Fox position group label (NA if unmatched).       |
#'    |yahoo_player_id     |character |Yahoo player id (NA placeholder).                 |
#'    |yahoo_player_name   |character |Yahoo player name (NA placeholder).               |
#'    |match_method        |character |"exact_name"/"fuzzy_jw"/"unmatched".              |
#'    |match_confidence    |numeric   |Jaro-Winkler score or 1 for exact (NA if none).  |
#'    |match_keys          |character |NA (reserved for future use).                     |
#'
#' @importFrom dplyr transmute bind_rows
#' @importFrom purrr map list_rbind
#' @export
#' @family MBB Crosswalk Functions
#' @examples
#' \donttest{
#'   try(mbb_player_crosswalk(season = 2025))
#' }
mbb_player_crosswalk <- function(season = most_recent_mbb_season(),
                                  min_confidence = 0.92) {
  .args <- .capture_args()
  out <- data.frame()
  tryCatch(
    expr = {
      team_xwalk <- mbb_team_crosswalk(season = season)

      fetch_team <- function(i) {
        espn_id <- team_xwalk$espn_team_id[i]
        fox_id  <- team_xwalk$fox_team_id[i]
        abbr    <- team_xwalk$espn_abbreviation[i]

        er <- tryCatch(
          espn_mbb_team_roster(team_id = espn_id, season = season),
          error = function(e) NULL
        )
        if (is.null(er) || !nrow(er)) return(NULL)
        espn <- dplyr::transmute(
          er,
          espn_team_id      = as.integer(espn_id),
          team_abbreviation = abbr,
          espn_athlete_id   = as.character(.data$athlete_id),
          espn_full_name    = .data$full_name,
          espn_jersey       = .data$jersey,
          espn_position     = .data$position_abbrev
        )

        fr <- if (!is.na(fox_id))
          tryCatch(fox_mbb_team_roster(team_id = fox_id), error = function(e) NULL)
        else
          NULL
        fox <- if (!is.null(fr) && nrow(fr)) dplyr::transmute(
          fr,
          espn_team_id       = as.integer(espn_id),
          fox_athlete_id     = as.character(.data$athlete_id),
          fox_player         = .data$player,
          fox_jersey         = if ("jersey" %in% names(fr)) as.character(.data$jersey)
                               else NA_character_,
          fox_position_group = .data$position_group
        )
        else
          data.frame(
            espn_team_id       = integer(),
            fox_athlete_id     = character(),
            fox_player         = character(),
            fox_jersey         = character(),
            fox_position_group = character(),
            stringsAsFactors   = FALSE
          )

        .bb_assemble_player_crosswalk_mbb(espn, fox, season, min_confidence)
      }

      out <- purrr::map(seq_len(nrow(team_xwalk)), fetch_team) |>
        purrr::list_rbind() |>
        make_hoopR_data("MBB player crosswalk (ESPN / Fox)", Sys.time())
    },
    error   = function(e) .report_api_error(
      e, hint = "Could not build MBB player crosswalk for {season}!", args = .args
    ),
    warning = function(w) .report_api_warning(
      w, hint = "Warning building MBB player crosswalk for {season}", args = .args
    ),
    finally = {}
  )
  out
}
