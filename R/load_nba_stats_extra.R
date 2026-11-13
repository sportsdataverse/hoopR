# -----------------------------------------------------------------------------
# NBA release loaders for the tags that hold several files per season
# (`nba_stats_synergy`, `nba_stats_hustle`, `nba_stats_matchups`,
# `nba_stats_draft_combine`) and the single-file `nba_stats_game_matchups`,
# `nba_stats_injury_report`, `nba_stats_metric_curves` and
# `nba_stats_rolling_windows` tags. Names, arguments and season floors mirror
# sportsdataverse-py's `sportsdataverse/nba/nba_loaders_extra.py` /
# `nba_loaders.py` loaders, so the R and Python calls read the same files.
#
# `seasons` is the season's START year (`2024` = 2024-25), as in every
# `load_nba_stats_*()` loader; the asset is keyed by the END year, so the URL
# uses `seasons + 1` (see the note at the top of R/load_nba_stats.R).
# -----------------------------------------------------------------------------

.sdv_release_base <- "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/"

# Read every `{tag}/{stem}_{season + offset}.{ext}` asset of each season and
# bind them. `assets` is a list of `list(stem = , stamps = list(...))`: a
# stamp (the discriminator the file name carries, e.g. `per_mode`) is added
# as a column only when the file's rows lack it, and `season` (the END year)
# on the same rule, so every row says which file it came from. `offset` is 1
# for START-year `seasons` (the `nba_stats_*` tags) and 0 for END-year ones.
#
# A single absent asset inside a published season (no playoffs file yet) is
# skipped silently; a season with no asset at all is warned about. A failed
# read that is not a 404 still warns, as in rds_from_url().
.load_release_assets <- function(fn, tag, assets, seasons, first, last, default = FALSE,
                                 offset = 1L, ext = "parquet",
                                 dbConnection = NULL, tablename = NULL, ...) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  in_db <- !is.null(dbConnection) && !is.null(tablename)

  url_of <- function(s, stem) paste0(.sdv_release_base, tag, "/", stem, "_", s + offset, ".", ext)
  # A season counts as published when any requested file is (the newest
  # season can have its regular-season files before its playoffs files).
  seasons <- .loader_seasons(seasons, first, last, fn = fn,
                             url_for = function(s) {
                               vapply(assets, function(a) url_of(s, a$stem), "")
                             },
                             default = default)

  reader <- if (ext == "rds") rds_from_url else parquet_from_url
  jobs <- expand.grid(a = seq_along(assets), s = seasons, KEEP.OUT.ATTRS = FALSE)
  read <- function(i) {
    s <- jobs$s[i]
    a <- assets[[jobs$a[i]]]
    df <- withCallingHandlers(
      reader(url_of(s, a$stem)),
      warning = function(w) {
        if (grepl("404", conditionMessage(w), fixed = TRUE)) invokeRestart("muffleWarning")
      }
    )
    if (!nrow(df)) return(NULL)
    # arrow reads an all-null column as vctrs_unspecified, which rbindlist()
    # refuses to bind to the typed column of another season.
    for (k in names(df)[vapply(df, inherits, NA, "vctrs_unspecified")]) {
      data.table::set(df, j = k, value = rep(NA, nrow(df)))
    }
    for (k in setdiff(names(a$stamps), names(df))) data.table::set(df, j = k, value = a$stamps[[k]])
    if (!"season" %in% names(df)) data.table::set(df, j = "season", value = as.integer(s + offset))
    df
  }

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(steps = nrow(jobs))
  chunks <- lapply(seq_len(nrow(jobs)), progressively(read, p))

  found <- unique(jobs$s[!vapply(chunks, is.null, NA)])
  missing <- setdiff(seasons, found)
  if (length(missing)) {
    cli::cli_warn("{.fn {fn}}: no data for season{?s} {missing}; skipped.")
  }

  out <- data.table::rbindlist(chunks, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data", "tbl_df", "tbl", "data.frame")
  }
  out
}

# `NULL` -> every valid value; otherwise the de-duplicated values, which must
# all be valid.
.pick_choice <- function(name, value, valid) {
  if (is.null(value)) return(valid)
  value <- unique(as.character(value))
  bad <- setdiff(value, valid)
  if (!length(value) || length(bad)) {
    cli::cli_abort(c(
      "x" = "Unknown {.arg {name}} {.val {bad}}.",
      "i" = "Expected one or more of {.val {valid}}."
    ))
  }
  value
}

.nba_stats_season_types <- c("regular-season", "playoffs")
.nba_stats_per_modes <- c("pergame", "totals")

# The Synergy play types published on `nba_stats_synergy`, by type grouping
# (sdv-py's NBA_STATS_SYNERGY_PLAY_TYPES): cut, misc, offensive rebound and
# transition have no defensive split on stats.nba.com.
.nba_stats_synergy_play_types <- list(
  offensive = c("cut", "handoff", "isolation", "misc", "offrebound", "offscreen",
                "postup", "prballhandler", "prrollman", "spotup", "transition"),
  defensive = c("handoff", "isolation", "offscreen", "postup", "prballhandler",
                "prrollman", "spotup")
)

#' **Load hoopR NBA Stats Synergy play-type stats**
#' @name load_nba_stats_synergy
NULL
#' @title
#' **Load NBA Stats API Synergy play-type stats from the data repo**
#' @rdname load_nba_stats_synergy
#' @description Loads the `nba_stats_synergy` release: 72 files per season,
#'   one per season type, play type, offensive/defensive split and per mode
#'   (`{season_type}_{play_type}_{type_grouping}_{per_mode}_{END year}.parquet`).
#'   The requested combinations (all of them by default) are bound into one
#'   frame, one row per player per play type per split. `season_type` and
#'   `per_mode` are added from the file name when a file's rows lack them.
#'   Reading both per modes widens the counting columns (`poss`, `pts`, `fgm`,
#'   `fga`, `fgmx`), which are integer in `totals` files and decimal in
#'   `pergame` files, to double.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season), like every `load_nba_stats_*()`
#'   loader. Published coverage starts at 2015 (2015-16). Pass `seasons = TRUE`
#'   for every published season.
#' @param season_type `"regular-season"` and/or `"playoffs"`; `NULL` (the
#'   default) reads both.
#' @param per_mode `"pergame"` and/or `"totals"`; `NULL` reads both.
#' @param type_grouping `"offensive"` and/or `"defensive"`; `NULL` reads both.
#' @param play_type One or more of `cut`, `handoff`, `isolation`, `misc`,
#'   `offrebound`, `offscreen`, `postup`, `prballhandler`, `prrollman`,
#'   `spotup`, `transition`; `NULL` reads every play type of each requested
#'   type grouping. `cut`, `misc`, `offrebound` and `transition` are published
#'   for the offensive split only.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_synergy", unit = "player per play type per split")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_synergy>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the Python
#'   twin `sportsdataverse.nba.load_nba_stats_synergy()`.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_synergy(seasons = most_recent_nba_stats_season(),
#'                              play_type = "isolation", per_mode = "totals"))
#' }
load_nba_stats_synergy <- function(seasons = most_recent_nba_stats_season(),
                                   season_type = NULL, per_mode = NULL,
                                   type_grouping = NULL, play_type = NULL,
                                   ...,
                                   dbConnection = NULL, tablename = NULL) {
  pt <- .nba_stats_synergy_play_types
  season_types <- .pick_choice("season_type", season_type, .nba_stats_season_types)
  per_modes <- .pick_choice("per_mode", per_mode, .nba_stats_per_modes)
  groupings <- .pick_choice("type_grouping", type_grouping, names(pt))
  play_types <- .pick_choice("play_type", play_type, sort(unique(unlist(pt))))

  assets <- list()
  for (st in season_types) for (tg in groupings) for (p in intersect(play_types, pt[[tg]])) {
    for (pm in per_modes) {
      assets[[length(assets) + 1L]] <- list(
        stem = paste(st, p, tg, pm, sep = "_"),
        stamps = list(season_type = st, per_mode = pm)
      )
    }
  }
  if (!length(assets)) {
    cli::cli_abort("No {.val {groupings}} split is published for play type {.val {play_types}}.")
  }
  # Only when the caller named both: play_type alone means "wherever it is published".
  if (!is.null(play_type) && !is.null(type_grouping)) {
    unpublished <- unlist(lapply(groupings, function(tg) {
      x <- setdiff(play_types, pt[[tg]])
      if (length(x)) paste0(x, "/", tg)
    }))
    if (length(unpublished)) {
      cli::cli_warn("No published split for {.val {unpublished}}; skipped.")
    }
  }
  .load_release_assets("load_nba_stats_synergy", "nba_stats_synergy", assets, seasons,
                       first = 2015, last = most_recent_nba_stats_season(),
                       default = missing(seasons),
                       dbConnection = dbConnection, tablename = tablename, ...)
}


.hustle_assets <- function(entity, season_type, per_mode) {
  out <- list()
  for (st in .pick_choice("season_type", season_type, .nba_stats_season_types)) {
    for (pm in .pick_choice("per_mode", per_mode, .nba_stats_per_modes)) {
      out[[length(out) + 1L]] <- list(
        stem = paste0("leaguehustlestats", entity, "_", st, "_", pm),
        stamps = list(season_type = st, per_mode = pm)
      )
    }
  }
  out
}

#' **Load hoopR NBA Stats hustle stats**
#' @name load_nba_stats_hustle
NULL
#' @title
#' **Load NBA Stats API player hustle stats from the data repo**
#' @rdname load_nba_stats_hustle
#' @description `load_nba_stats_hustle_player()` and
#'   `load_nba_stats_hustle_team()` load the `nba_stats_hustle` release:
#'   eight files per season (`leaguehustlestats{player|team}_{season_type}_{per_mode}_{END year}.parquet`),
#'   contested shots, deflections, charges drawn, screen assists, loose balls
#'   and box-outs. The requested season types and per modes (all of them by
#'   default) are bound into one frame, with `season_type` and `per_mode`
#'   columns saying which file a row came from.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 2015
#'   (2015-16). Pass `seasons = TRUE` for every published season.
#' @param season_type `"regular-season"` and/or `"playoffs"`; `NULL` (the
#'   default) reads both.
#' @param per_mode `"pergame"` and/or `"totals"`; `NULL` reads both.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_hustle_player", unit = "player per season type per per mode (`load_nba_stats_hustle_player()`)")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_hustle>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the Python
#'   twins `sportsdataverse.nba.load_nba_stats_hustle_player()` /
#'   `load_nba_stats_hustle_team()`.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_hustle_player(seasons = most_recent_nba_stats_season(),
#'                                    season_type = "regular-season", per_mode = "totals"))
#' }
load_nba_stats_hustle_player <- function(seasons = most_recent_nba_stats_season(),
                                         season_type = NULL, per_mode = NULL,
                                         ...,
                                         dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_hustle_player", "nba_stats_hustle",
                       .hustle_assets("player", season_type, per_mode), seasons,
                       first = 2015, last = most_recent_nba_stats_season(),
                       default = missing(seasons),
                       dbConnection = dbConnection, tablename = tablename, ...)
}

#' @title
#' **Load NBA Stats API team hustle stats from the data repo**
#' @rdname load_nba_stats_hustle
#' @eval .returns_rd("load_nba_stats_hustle_team", unit = "team per season type per per mode (`load_nba_stats_hustle_team()`)")
#' @export
load_nba_stats_hustle_team <- function(seasons = most_recent_nba_stats_season(),
                                       season_type = NULL, per_mode = NULL,
                                       ...,
                                       dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_hustle_team", "nba_stats_hustle",
                       .hustle_assets("team", season_type, per_mode), seasons,
                       first = 2015, last = most_recent_nba_stats_season(),
                       default = missing(seasons),
                       dbConnection = dbConnection, tablename = tablename, ...)
}


#' **Load hoopR NBA Stats player matchups**
#' @name load_nba_stats_matchups
NULL
#' @title
#' **Load NBA Stats API offensive-vs-defensive player matchups from the data repo**
#' @rdname load_nba_stats_matchups
#' @description `load_nba_stats_matchups()` reads the
#'   `leagueseasonmatchups_regular-season_{per_mode}_{END year}.parquet` files
#'   of the `nba_stats_matchups` release: one row per (offensive player,
#'   defensive player) pair. The tag publishes this table for the regular
#'   season only. `load_nba_stats_matchups_rollup()` reads the
#'   `matchupsrollup_{season_type}_{per_mode}_{END year}.parquet` files: one
#'   row per defender per offensive position (`G`/`F`/`C`) plus a `TOTAL` row.
#'
#'   `matchup_min` is `"MM:SS"` text in `totals` files and decimal minutes in
#'   `pergame` files, so reading both per modes makes it character. Pass one
#'   `per_mode` to keep the native types. Per-game matchups are in
#'   [load_nba_stats_game_matchups()].
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 2017
#'   (2017-18). Pass `seasons = TRUE` for every published season.
#' @param per_mode `"pergame"` and/or `"totals"`; `NULL` (the default) reads both.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_matchups", unit = "matchup pair per per mode (`load_nba_stats_matchups()`)")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_matchups>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the Python
#'   twins `sportsdataverse.nba.load_nba_stats_matchups()` /
#'   `load_nba_stats_matchups_rollup()`.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_matchups(seasons = most_recent_nba_stats_season() - 1,
#'                               per_mode = "totals"))
#' }
load_nba_stats_matchups <- function(seasons = most_recent_nba_stats_season(),
                                    per_mode = NULL,
                                    ...,
                                    dbConnection = NULL, tablename = NULL) {
  assets <- lapply(.pick_choice("per_mode", per_mode, .nba_stats_per_modes), function(pm) {
    list(stem = paste0("leagueseasonmatchups_regular-season_", pm),
         stamps = list(season_type = "regular-season", per_mode = pm))
  })
  .load_release_assets("load_nba_stats_matchups", "nba_stats_matchups", assets, seasons,
                       first = 2017, last = most_recent_nba_stats_season(),
                       default = missing(seasons),
                       dbConnection = dbConnection, tablename = tablename, ...)
}

#' @title
#' **Load NBA Stats API defensive matchup roll-ups by position from the data repo**
#' @rdname load_nba_stats_matchups
#' @param season_type `"regular-season"` and/or `"playoffs"`; `NULL` (the
#'   default) reads both.
#' @eval .returns_rd("load_nba_stats_matchups_rollup", unit = "defender per position per season type per per mode (`load_nba_stats_matchups_rollup()`)")
#' @export
load_nba_stats_matchups_rollup <- function(seasons = most_recent_nba_stats_season(),
                                           season_type = NULL, per_mode = NULL,
                                           ...,
                                           dbConnection = NULL, tablename = NULL) {
  assets <- list()
  for (st in .pick_choice("season_type", season_type, .nba_stats_season_types)) {
    for (pm in .pick_choice("per_mode", per_mode, .nba_stats_per_modes)) {
      assets[[length(assets) + 1L]] <- list(
        stem = paste0("matchupsrollup_", st, "_", pm),
        stamps = list(season_type = st, per_mode = pm)
      )
    }
  }
  .load_release_assets("load_nba_stats_matchups_rollup", "nba_stats_matchups", assets, seasons,
                       first = 2017, last = most_recent_nba_stats_season(),
                       default = missing(seasons),
                       dbConnection = dbConnection, tablename = tablename, ...)
}


# Draft-combine asset Y holds the combine held in May of Y - 1
# (`..._2025` = the 2024 combine): the same START -> END translation as every
# nba_stats loader. The first published asset is 2001 (the 2000 combine).
.load_combine <- function(fn, stem, seasons, default, dbConnection, tablename, ...) {
  .load_release_assets(fn, "nba_stats_draft_combine", list(list(stem = stem, stamps = list())),
                       seasons, first = 2000, last = most_recent_nba_stats_season(),
                       default = default,
                       dbConnection = dbConnection, tablename = tablename, ...)
}

#' **Load hoopR NBA Stats draft combine tables**
#' @name load_nba_stats_draft_combine
NULL
#' @title
#' **Load the NBA Stats API draft-combine summary table from the data repo**
#' @rdname load_nba_stats_draft_combine
#' @description Five loaders for the five tables of the
#'   `nba_stats_draft_combine` release, one file per table per season:
#'   `load_nba_stats_draft_combine_stats()` (`draftcombinestats`, the
#'   one-row-per-prospect summary of every measurement),
#'   `load_nba_stats_draft_combine_anthro()` (`draftcombineplayeranthro`,
#'   body measurements), `load_nba_stats_draft_combine_drills()`
#'   (`draftcombinedrillresults`, vertical leaps, agility and sprint),
#'   `load_nba_stats_draft_combine_spot_shooting()`
#'   (`draftcombinespotshooting`, made/attempted from five floor spots at 15
#'   feet, the college three and the NBA three) and
#'   `load_nba_stats_draft_combine_nonstationary_shooting()`
#'   (`draftcombinenonstationaryshooting`, off-the-dribble and on-the-move
#'   shooting).
#'
#'   The combine is held in May before the draft, so the season's START year
#'   is the combine year: `seasons = 2024` reads the 2024 combine (the
#'   `..._2025` asset). Columns a year's combine did not measure are all `NA`.
#' @param seasons A vector of 4-digit years -- the season's **START** year,
#'   i.e. the year of the combine. Published coverage starts at 2000. Pass
#'   `seasons = TRUE` for every published season.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_draft_combine_stats", unit = "prospect (`load_nba_stats_draft_combine_stats()`)")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_draft_combine>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, the draft
#'   results in [load_nba_stats_draft()], and the Python twins
#'   `sportsdataverse.nba.load_nba_stats_draft_combine_*()`.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_draft_combine_stats(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_draft_combine_stats <- function(seasons = most_recent_nba_stats_season(),
                                               ...,
                                               dbConnection = NULL, tablename = NULL) {
  .load_combine("load_nba_stats_draft_combine_stats", "draftcombinestats", seasons,
                missing(seasons), dbConnection, tablename, ...)
}

#' @title
#' **Load NBA Stats API draft-combine anthropometrics from the data repo**
#' @rdname load_nba_stats_draft_combine
#' @eval .returns_rd("load_nba_stats_draft_combine_anthro", unit = "prospect (`load_nba_stats_draft_combine_anthro()`)")
#' @export
load_nba_stats_draft_combine_anthro <- function(seasons = most_recent_nba_stats_season(),
                                                ...,
                                                dbConnection = NULL, tablename = NULL) {
  .load_combine("load_nba_stats_draft_combine_anthro", "draftcombineplayeranthro", seasons,
                missing(seasons), dbConnection, tablename, ...)
}

#' @title
#' **Load NBA Stats API draft-combine drill results from the data repo**
#' @rdname load_nba_stats_draft_combine
#' @eval .returns_rd("load_nba_stats_draft_combine_drills", unit = "prospect (`load_nba_stats_draft_combine_drills()`)")
#' @export
load_nba_stats_draft_combine_drills <- function(seasons = most_recent_nba_stats_season(),
                                                ...,
                                                dbConnection = NULL, tablename = NULL) {
  .load_combine("load_nba_stats_draft_combine_drills", "draftcombinedrillresults", seasons,
                missing(seasons), dbConnection, tablename, ...)
}

#' @title
#' **Load NBA Stats API draft-combine spot shooting from the data repo**
#' @rdname load_nba_stats_draft_combine
#' @eval .returns_rd("load_nba_stats_draft_combine_spot_shooting", unit = "prospect (`load_nba_stats_draft_combine_spot_shooting()`)")
#' @export
load_nba_stats_draft_combine_spot_shooting <- function(seasons = most_recent_nba_stats_season(),
                                                       ...,
                                                       dbConnection = NULL, tablename = NULL) {
  .load_combine("load_nba_stats_draft_combine_spot_shooting", "draftcombinespotshooting", seasons,
                missing(seasons), dbConnection, tablename, ...)
}

#' @title
#' **Load NBA Stats API draft-combine non-stationary shooting from the data repo**
#' @rdname load_nba_stats_draft_combine
#' @eval .returns_rd("load_nba_stats_draft_combine_nonstationary_shooting", unit = "prospect (`load_nba_stats_draft_combine_nonstationary_shooting()`)")
#' @export
load_nba_stats_draft_combine_nonstationary_shooting <- function(seasons = most_recent_nba_stats_season(),
                                                                ...,
                                                                dbConnection = NULL, tablename = NULL) {
  .load_combine("load_nba_stats_draft_combine_nonstationary_shooting",
                "draftcombinenonstationaryshooting", seasons,
                missing(seasons), dbConnection, tablename, ...)
}


#' **Load hoopR NBA Stats game matchups**
#' @name load_nba_stats_game_matchups
NULL
#' @title
#' **Load NBA Stats API per-game player matchups from the data repo**
#' @rdname load_nba_stats_game_matchups
#' @description Loads the `nba_stats_game_matchups` release: the
#'   `boxscorematchupsv3` matchups of every game of a season, one row per
#'   (offensive player, defensive player) pair per game, with matchup time,
#'   partial possessions, switches and the points, assists, turnovers, blocks
#'   and shooting the defender allowed. Season-long matchup totals are in
#'   [load_nba_stats_matchups()].
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 2017
#'   (2017-18). Pass `seasons = TRUE` for every published season.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_game_matchups", unit = "matchup pair per game")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_game_matchups>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the Python
#'   twin `sportsdataverse.nba.load_nba_stats_game_matchups()`.
#' @export
#' @family NBA Stats loader functions
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: a 5.6 MB file of about 260,000 rows per season.
#'   try(load_nba_stats_game_matchups(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_game_matchups <- function(seasons = most_recent_nba_stats_season(),
                                         ...,
                                         dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_game_matchups", "nba_stats_game_matchups",
                       list(list(stem = "game_matchups", stamps = list())), seasons,
                       first = 2017, last = most_recent_nba_stats_season(),
                       default = missing(seasons), ext = "rds",
                       dbConnection = dbConnection, tablename = tablename, ...)
}


#' **Load hoopR NBA official injury reports**
#' @name load_nba_stats_injury_report
NULL
#' @title
#' **Load the NBA's official injury reports from the data repo**
#' @rdname load_nba_stats_injury_report
#' @description Loads the `nba_stats_injury_report` release: every entry of
#'   the league's official game-day injury reports (the PDFs the NBA posts
#'   several times a day), one row per player per game per report, with the
#'   player's status (`Out`, `Questionable`, ...), the reason, the status on
#'   the previous report, and the NBA Stats `game_id` / `team_id` /
#'   `person_id` the entry was matched to.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 2018
#'   (2018-19). Pass `seasons = TRUE` for every published season.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_injury_report", unit = "player per game per report")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_injury_report>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the Python
#'   twin `sportsdataverse.nba.load_nba_stats_injury_report()`.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_injury_report(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_injury_report <- function(seasons = most_recent_nba_stats_season(),
                                         ...,
                                         dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_injury_report", "nba_stats_injury_report",
                       list(list(stem = "injury_report", stamps = list())), seasons,
                       first = 2018, last = most_recent_nba_stats_season(),
                       default = missing(seasons), ext = "rds",
                       dbConnection = dbConnection, tablename = tablename, ...)
}


#' **Load hoopR NBA Stats metric curves**
#' @name load_nba_stats_metric_curves
NULL
#' @title
#' **Load NBA Stats API metric curves from the data repo**
#' @rdname load_nba_stats_metric_curves
#' @description Loads the `nba_stats_metric_curves` release: field-goal
#'   percentage by shot distance for the league, every team and every player
#'   of a season, computed from [load_nba_stats_shots()]. One row per entity
#'   per distance bucket (1-ft bins from 0 to 35 ft, then 35-50 and 50-95 ft;
#'   `x_lo` inclusive, `x_hi` exclusive) with its `attempts`, `successes`
#'   (makes) and `rate`; an empty bucket has no row. Regular-season and
#'   playoff shots only. `entity_id` / `team_id` are stats.nba.com ids as
#'   text; `down` and `epa_per_att` are always `NA` (the football columns of
#'   the cross-league contract).
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 1996
#'   (1996-97). Pass `seasons = TRUE` for every published season.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_metric_curves", unit = "entity per metric per bin")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_metric_curves>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_metric_curves(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_metric_curves <- function(seasons = most_recent_nba_stats_season(),
                                         ...,
                                         dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_metric_curves", "nba_stats_metric_curves",
                       list(list(stem = "metric_curves", stamps = list())), seasons,
                       first = 1996, last = most_recent_nba_stats_season(),
                       default = missing(seasons), ext = "rds",
                       dbConnection = dbConnection, tablename = tablename, ...)
}


#' **Load hoopR NBA Stats rolling windows**
#' @name load_nba_stats_rolling_windows
NULL
#' @title
#' **Load NBA Stats API rolling-window form from the data repo**
#' @rdname load_nba_stats_rolling_windows
#' @description Loads the `nba_stats_rolling_windows` release: every
#'   shooter's rolling form over his last `window_n` field-goal attempts
#'   (`metric = "fg_pct"`) and three-point attempts (`"fg3_pct"`), for
#'   `window_n` 50 and 200, computed from [load_nba_stats_shots()]. One row
#'   per player per window unit per window size. Windows count attempts, not
#'   games, and cross season boundaries: `cur` is the make rate over the last
#'   `n` attempts through the season, `prev` the window before it,
#'   `season_start` the window entering the season and `career_baseline`
#'   every attempt before `cur`'s window (each `NA` rather than partial
#'   without a full window of history). `delta_prev_rank` is 1 for the
#'   biggest riser among qualified rows.
#' @param seasons A vector of 4-digit years -- the season's **START** year
#'   (e.g. `2024` for the 2024-25 season). Published coverage starts at 1996
#'   (1996-97). Pass `seasons = TRUE` for every published season.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @eval .returns_rd("load_nba_stats_rolling_windows", unit = "entity per metric per window")
#' @source <https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_rolling_windows>
#' @seealso The publishing pipeline,
#'   <https://github.com/sportsdataverse/hoopR-nba-stats-data>.
#' @export
#' @family NBA Stats loader functions
#' @examples
#' \donttest{
#'   try(load_nba_stats_rolling_windows(seasons = most_recent_nba_stats_season()))
#' }
load_nba_stats_rolling_windows <- function(seasons = most_recent_nba_stats_season(),
                                           ...,
                                           dbConnection = NULL, tablename = NULL) {
  .load_release_assets("load_nba_stats_rolling_windows", "nba_stats_rolling_windows",
                       list(list(stem = "rolling_windows", stamps = list())), seasons,
                       first = 1996, last = most_recent_nba_stats_season(),
                       default = missing(seasons), ext = "rds",
                       dbConnection = dbConnection, tablename = tablename, ...)
}
