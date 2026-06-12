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
      kp_all  <- hoopR::teams_links
      kp_yrs  <- sort(unique(kp_all[["Year"]]))
      kp_yr   <- if (season %in% kp_yrs) season else max(kp_yrs)
      kp_raw  <- kp_all[kp_all[["Year"]] == kp_yr, ]

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
