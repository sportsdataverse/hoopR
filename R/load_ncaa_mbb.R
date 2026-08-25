# NCAA MBB release-dataset loaders -- thin wrappers around rds_from_url()
# mirroring wehoop's load_ncaa_wbb.R loader shape. Backed by
# the sdv-py `ncaa_mbb` engine's published output on the `ncaa_mbb_*`
# sportsdataverse-data release tags (see CLAUDE.md's ncaa-hoops-engine-extraction
# note for the engine's origin).

#' @title
#' **Load cleaned NCAA men's college basketball play-by-play from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads season-level NCAA men's college basketball
#'   play-by-play. One row per event, with reconstructed 5-man lineups,
#'   possession numbering, shot context (transition/paint/second-chance), and
#'   an ESPN game-id crosswalk. Produced by the sdv-py `ncaa_mbb` engine
#'   (stats.ncaa.org play-by-play parsed, cleaned, and enriched); backed by
#'   the `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_pbp`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per play-by-play event.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_date \tab character \tab Date the game was played (MM/DD/YYYY). \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       period \tab integer \tab Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). \cr
#'       clock \tab character \tab Game clock remaining in the period (MM:SS). \cr
#'       game_time \tab character \tab Elapsed game time (MM:SS). \cr
#'       game_seconds \tab integer \tab Elapsed game time in seconds from tip-off. \cr
#'       home_score \tab integer \tab Home team score after the event. \cr
#'       away_score \tab integer \tab Away team score after the event. \cr
#'       event_team \tab character \tab Team name credited with the play event. \cr
#'       event_description \tab character \tab Raw play-by-play text description. \cr
#'       player_1 \tab character \tab Primary player name involved in the event (raw, upper-cased). \cr
#'       player_2 \tab character \tab Secondary player name involved in the event (raw, upper-cased). \cr
#'       event_type \tab character \tab Play event type label (e.g. 'made Layup', 'won Jumpball'). \cr
#'       event_result \tab character \tab Event result ('made', 'missed', or NA for non-shot events). \cr
#'       shot_value \tab integer \tab Point value of a shot event (2 or 3). \cr
#'       event_length \tab integer \tab Duration of the event in seconds. \cr
#'       poss_num \tab integer \tab Sequential possession number within the game. \cr
#'       poss_team \tab character \tab Team name on offense for the possession. \cr
#'       poss_length \tab integer \tab Duration of the possession in seconds. \cr
#'       is_transition \tab logical \tab Whether the play occurred in transition. \cr
#'       home_1 \tab character \tab Home lineup slot 1 player name (raw). \cr
#'       home_2 \tab character \tab Home lineup slot 2 player name (raw). \cr
#'       home_3 \tab character \tab Home lineup slot 3 player name (raw). \cr
#'       home_4 \tab character \tab Home lineup slot 4 player name (raw). \cr
#'       home_5 \tab character \tab Home lineup slot 5 player name (raw). \cr
#'       away_1 \tab character \tab Away lineup slot 1 player name (raw). \cr
#'       away_2 \tab character \tab Away lineup slot 2 player name (raw). \cr
#'       away_3 \tab character \tab Away lineup slot 3 player name (raw). \cr
#'       away_4 \tab character \tab Away lineup slot 4 player name (raw). \cr
#'       away_5 \tab character \tab Away lineup slot 5 player name (raw). \cr
#'       status \tab character \tab Row QA status flag ('CLEAN' or a data-quality note). \cr
#'       is_garbage_time \tab logical \tab Whether the event occurred in garbage time. \cr
#'       sub_deviate \tab integer \tab Substitution-inference deviation counter used by the lineup reconstructor. \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       home_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the home team. \cr
#'       home_espn_team_id \tab character \tab ESPN team identifier for the home team. \cr
#'       away_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the away team. \cr
#'       away_espn_team_id \tab character \tab ESPN team identifier for the away team. \cr
#'       event_team_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the event team. \cr
#'       event_team_espn_team_id \tab character \tab ESPN team identifier for the event team. \cr
#'       poss_team_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the possession team. \cr
#'       poss_team_espn_team_id \tab character \tab ESPN team identifier for the possession team. \cr
#'       player_1_id \tab character \tab stats.ncaa.org player identifier for player_1. \cr
#'       player_1_clean_name \tab character \tab Cleaned/title-cased display name for player_1. \cr
#'       player_2_id \tab character \tab stats.ncaa.org player identifier for player_2. \cr
#'       player_2_clean_name \tab character \tab Cleaned/title-cased display name for player_2. \cr
#'       home_1_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 1. \cr
#'       home_1_clean_name \tab character \tab Cleaned display name for home lineup slot 1. \cr
#'       home_2_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 2. \cr
#'       home_2_clean_name \tab character \tab Cleaned display name for home lineup slot 2. \cr
#'       home_3_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 3. \cr
#'       home_3_clean_name \tab character \tab Cleaned display name for home lineup slot 3. \cr
#'       home_4_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 4. \cr
#'       home_4_clean_name \tab character \tab Cleaned display name for home lineup slot 4. \cr
#'       home_5_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 5. \cr
#'       home_5_clean_name \tab character \tab Cleaned display name for home lineup slot 5. \cr
#'       away_1_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 1. \cr
#'       away_1_clean_name \tab character \tab Cleaned display name for away lineup slot 1. \cr
#'       away_2_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 2. \cr
#'       away_2_clean_name \tab character \tab Cleaned display name for away lineup slot 2. \cr
#'       away_3_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 3. \cr
#'       away_3_clean_name \tab character \tab Cleaned display name for away lineup slot 3. \cr
#'       away_4_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 4. \cr
#'       away_4_clean_name \tab character \tab Cleaned display name for away lineup slot 4. \cr
#'       away_5_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 5. \cr
#'       away_5_clean_name \tab character \tab Cleaned display name for away lineup slot 5. \cr
#'       espn_game_id \tab character \tab ESPN game identifier crosswalked to this contest. \cr
#'       is_fastbreak \tab logical \tab Whether the play was a fastbreak possession. \cr
#'       is_from_turnover \tab logical \tab Whether the possession began off a turnover. \cr
#'       is_paint \tab logical \tab Whether the shot was taken in the paint. \cr
#'       is_second_chance \tab logical \tab Whether the possession followed an offensive rebound. \cr
#'       assist_player \tab character \tab Cleaned display name of the player credited with the assist. \cr
#'       ft_number \tab integer \tab Free throw number within the trip to the line (1st, 2nd, ...). \cr
#'       ft_attempts \tab integer \tab Total free throws awarded on the trip to the line. \cr
#'       foul_class \tab character \tab Foul classification ('personal', 'technical', etc.). \cr
#'       is_shooting_foul \tab logical \tab Whether the foul was a shooting foul. \cr
#'       is_looseball_foul \tab logical \tab Whether the foul was a loose-ball foul. \cr
#'       is_one_and_one \tab logical \tab Whether the free throw trip was a one-and-one bonus. \cr
#'       is_flagrant \tab logical \tab Whether the foul was flagrant. \cr
#'       foul_tech_class \tab character \tab Technical foul sub-classification (e.g. 'administrative'). \cr
#'       ft_awarded \tab integer \tab Total free throws awarded for the foul. \cr
#'       turnover_type \tab character \tab Turnover sub-type (e.g. 'shotclock', 'travel'). \cr
#'       is_team_turnover \tab logical \tab Whether the turnover is a team turnover (no individual credited). \cr
#'       timeout_type \tab character \tab Timeout sub-type (e.g. 'short', 'full'). \cr
#'       challenge_outcome \tab character \tab Replay-challenge outcome, when the event was a review. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_pbp(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_pbp <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_pbp/ncaa_mbb_pbp_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball shot events from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads shot-chart events for NCAA men's college basketball --
#'   one row per field goal attempt, with court coordinates, distance, shot
#'   zone, and made/missed result. Coordinates are only available from the
#'   2019 season onward (stats.ncaa.org did not publish shot-location data
#'   before then), so `seasons` has a 2019 floor even though most sibling NCAA
#'   MBB datasets start at 2010. Produced by the sdv-py `ncaa_mbb` engine;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_shots` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per shot attempt.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       team_id \tab character \tab Team name of the shooting team (raw scrape field; despite the column name it holds the team name string, not a numeric id -- see ncaa_team_id / espn_team_id for the crosswalked ids). \cr
#'       shooter_id \tab character \tab Raw scrape key for the shooter (see shooter_player_id for the stats.ncaa.org id). \cr
#'       shot_x \tab numeric \tab Shot chart X coordinate. \cr
#'       shot_y \tab numeric \tab Shot chart Y coordinate. \cr
#'       dist_ft \tab numeric \tab Shot distance from the basket, in feet. \cr
#'       shot_zone \tab character \tab Shot zone label (e.g. 'abovebreak3', 'rim'). \cr
#'       shot_type \tab character \tab Shot type label from the source play description. \cr
#'       made \tab logical \tab Whether the shot was made. \cr
#'       point_value \tab integer \tab Point value of the shot (2 or 3). \cr
#'       period \tab logical \tab Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). \cr
#'       sec_left \tab logical \tab Seconds remaining in the period at the time of the shot. \cr
#'       source \tab character \tab Source system for the shot record (e.g. 'ncaa'). \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the shooting team. \cr
#'       espn_team_id \tab character \tab ESPN team identifier for the shooting team. \cr
#'       shooter_player_id \tab character \tab stats.ncaa.org player identifier for the shooter. \cr
#'       shooter_clean_name \tab character \tab Cleaned display name for the shooter. \cr
#'       espn_game_id \tab character \tab ESPN game identifier crosswalked to this contest. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_shots(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_shots <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2019:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2019),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_shots/ncaa_mbb_shots_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' **Load NCAA men's college basketball 5-man lineup stints from the data repo**
#' @name load_ncaa_mbb_lineups
NULL
#' @title
#' **Load NCAA men's college basketball 5-man lineup stints from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads reconstructed 5-man lineup stints for NCAA men's
#'   college basketball -- one row per contiguous stretch a specific 5-player
#'   lineup was on court for a team, with on/off scoring, shooting, and
#'   rebounding splits plus the matching opponent (`opp_*`) splits. Produced
#'   by the sdv-py `ncaa_mbb` engine's lineup reconstructor; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_lineups`
#'   release tag as csv.gz/parquet/rds.
#' @param seasons A vector of 4-digit season-ending years for NCAA men's
#'   college basketball (e.g. `2024` for the 2023-24 season). Published
#'   coverage runs 2010 through the most recent season, with no gaps. Pass
#'   `seasons = TRUE` for every published season. (Min: 2010)
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per lineup stint.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       lineup_key \tab character \tab Hash key uniquely identifying the 5-player lineup. \cr
#'       date \tab character \tab Game date/time (ISO 8601). \cr
#'       location_type \tab character \tab Home/away designation for \code{team} in this stint ('Home' or 'Away'). \cr
#'       team \tab character \tab Team name. \cr
#'       team_year \tab integer \tab Season-start calendar year for the stint. \cr
#'       opponent \tab character \tab Opponent team name. \cr
#'       lineup_id \tab character \tab Human-readable lineup identifier built from the five player codes. \cr
#'       start_min \tab numeric \tab Game-clock minute the lineup entered. \cr
#'       end_min \tab numeric \tab Game-clock minute the lineup exited. \cr
#'       duration_mins \tab numeric \tab Minutes the lineup was on court together. \cr
#'       player_1 \tab character \tab Lineup slot 1 player display name ('Last, First'). \cr
#'       player_2 \tab character \tab Lineup slot 2 player display name ('Last, First'). \cr
#'       player_3 \tab character \tab Lineup slot 3 player display name ('Last, First'). \cr
#'       player_4 \tab character \tab Lineup slot 4 player display name ('Last, First'). \cr
#'       player_5 \tab character \tab Lineup slot 5 player display name ('Last, First'). \cr
#'       players_in \tab character \tab Player(s) substituted into the lineup at the start of the stint. \cr
#'       players_out \tab character \tab Player(s) substituted out of the lineup at the start of the stint. \cr
#'       start_scored \tab integer \tab Team's points scored at the moment the lineup entered. \cr
#'       start_allowed \tab integer \tab Points allowed at the moment the lineup entered. \cr
#'       end_scored \tab integer \tab Team's points scored at the moment the lineup exited. \cr
#'       end_allowed \tab integer \tab Points allowed at the moment the lineup exited. \cr
#'       start_diff \tab integer \tab Score differential at the moment the lineup entered. \cr
#'       end_diff \tab integer \tab Score differential at the moment the lineup exited. \cr
#'       player_count_error \tab logical \tab Flag set when fewer/more than 5 players were reconstructed for the stint. \cr
#'       poss \tab integer \tab Possessions played by the lineup. \cr
#'       pts \tab integer \tab Points scored. \cr
#'       plus_minus \tab integer \tab Point differential while the lineup was on court. \cr
#'       fga \tab integer \tab Field goal attempts by the lineup. \cr
#'       fgm \tab integer \tab Field goals made by the lineup. \cr
#'       rima \tab integer \tab Rim-area shot attempts. \cr
#'       rimm \tab integer \tab Rim-area shots made. \cr
#'       rim_ast \tab integer \tab Rim-area makes that came off an assist. \cr
#'       mida \tab integer \tab Mid-range shot attempts. \cr
#'       midm \tab integer \tab Mid-range shots made. \cr
#'       mid_ast \tab integer \tab Mid-range makes that came off an assist. \cr
#'       fg2a \tab integer \tab 2-point field goal attempts by the lineup. \cr
#'       fg2m \tab integer \tab 2-point field goals made by the lineup. \cr
#'       tpa \tab integer \tab 3-point field goal attempts. \cr
#'       tpm \tab integer \tab 3-point field goals made. \cr
#'       tp_ast \tab integer \tab 3-pointers made that came off an assist. \cr
#'       fta \tab integer \tab Free throw attempts by the lineup. \cr
#'       ftm \tab integer \tab Free throws made by the lineup. \cr
#'       orb \tab integer \tab Offensive rebounds. \cr
#'       drb \tab integer \tab Defensive rebounds. \cr
#'       to \tab integer \tab Turnovers by the lineup. \cr
#'       stl \tab integer \tab Steals. \cr
#'       blk \tab integer \tab Blocks. \cr
#'       ast \tab integer \tab Assists. \cr
#'       foul \tab integer \tab Personal fouls. \cr
#'       opp_poss \tab integer \tab Opponent possessions while this lineup was on court. \cr
#'       opp_pts \tab integer \tab Opponent points scored while this lineup was on court. \cr
#'       opp_plus_minus \tab integer \tab Opponent point differential while this lineup was on court (negative of \code{plus_minus}). \cr
#'       opp_fga \tab integer \tab Opponent field goal attempts. \cr
#'       opp_fgm \tab integer \tab Opponent field goals made. \cr
#'       opp_rima \tab integer \tab Opponent rim-area shot attempts. \cr
#'       opp_rimm \tab integer \tab Opponent rim-area shots made. \cr
#'       opp_rim_ast \tab integer \tab Opponent rim-area makes that came off an assist. \cr
#'       opp_mida \tab integer \tab Opponent mid-range shot attempts. \cr
#'       opp_midm \tab integer \tab Opponent mid-range shots made. \cr
#'       opp_mid_ast \tab integer \tab Opponent mid-range makes that came off an assist. \cr
#'       opp_fg2a \tab integer \tab Opponent 2-point field goal attempts. \cr
#'       opp_fg2m \tab integer \tab Opponent 2-point field goals made. \cr
#'       opp_tpa \tab integer \tab Opponent 3-point field goal attempts. \cr
#'       opp_tpm \tab integer \tab Opponent 3-point field goals made. \cr
#'       opp_tp_ast \tab integer \tab Opponent 3-pointers made that came off an assist. \cr
#'       opp_fta \tab integer \tab Opponent free throw attempts. \cr
#'       opp_ftm \tab integer \tab Opponent free throws made. \cr
#'       opp_orb \tab integer \tab Opponent offensive rebounds. \cr
#'       opp_drb \tab integer \tab Opponent defensive rebounds. \cr
#'       opp_to \tab integer \tab Opponent turnovers. \cr
#'       opp_stl \tab integer \tab Opponent steals. \cr
#'       opp_blk \tab integer \tab Opponent blocks. \cr
#'       opp_ast \tab integer \tab Opponent assists. \cr
#'       opp_foul \tab integer \tab Opponent personal fouls. \cr
#'       stint_num \tab integer \tab Sequential stint number for this lineup within the game. \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_lineups(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_lineups <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_lineups/ncaa_mbb_lineups_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball 10-man matchup stints from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads reconstructed 10-man matchup stints (the home 5-man
#'   lineup crossed with the away 5-man lineup) for NCAA men's college
#'   basketball -- one row per contiguous stretch both lineups were on court
#'   together, with the score at stint start/end and both team's lineup
#'   rosters. Produced by the sdv-py `ncaa_mbb` engine's lineup reconstructor;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_matchup_stints` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per matchup stint.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       game_date \tab character \tab Date the game was played (MM/DD/YYYY). \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       game_stint_num \tab integer \tab Sequential stint number within the game (all 10-man matchups). \cr
#'       period \tab integer \tab Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). \cr
#'       start_seconds \tab integer \tab Elapsed game seconds at the start of the stint. \cr
#'       end_seconds \tab integer \tab Elapsed game seconds at the end of the stint. \cr
#'       duration_seconds \tab integer \tab Duration of the stint in seconds. \cr
#'       matchup_key \tab character \tab Hash key uniquely identifying the home-lineup/away-lineup matchup. \cr
#'       home_lineup_key \tab character \tab Hash key for the home team's 5-player lineup. \cr
#'       away_lineup_key \tab character \tab Hash key for the away team's 5-player lineup. \cr
#'       home_lineup \tab character \tab Pipe-delimited list of the 5 home players on court. \cr
#'       away_lineup \tab character \tab Pipe-delimited list of the 5 away players on court. \cr
#'       end_home_score \tab integer \tab Home team score at the end of the stint. \cr
#'       end_away_score \tab integer \tab Away team score at the end of the stint. \cr
#'       n_events \tab integer \tab Number of play-by-play events within the stint. \cr
#'       n_possessions \tab integer \tab Number of possessions within the stint. \cr
#'       start_home_score \tab integer \tab Home team score at the start of the stint. \cr
#'       start_away_score \tab integer \tab Away team score at the start of the stint. \cr
#'       home_pts \tab integer \tab Points scored by the home team during the stint. \cr
#'       away_pts \tab integer \tab Points scored by the away team during the stint. \cr
#'       home_1 \tab character \tab Home lineup slot 1 player name (raw). \cr
#'       home_2 \tab character \tab Home lineup slot 2 player name (raw). \cr
#'       home_3 \tab character \tab Home lineup slot 3 player name (raw). \cr
#'       home_4 \tab character \tab Home lineup slot 4 player name (raw). \cr
#'       home_5 \tab character \tab Home lineup slot 5 player name (raw). \cr
#'       away_1 \tab character \tab Away lineup slot 1 player name (raw). \cr
#'       away_2 \tab character \tab Away lineup slot 2 player name (raw). \cr
#'       away_3 \tab character \tab Away lineup slot 3 player name (raw). \cr
#'       away_4 \tab character \tab Away lineup slot 4 player name (raw). \cr
#'       away_5 \tab character \tab Away lineup slot 5 player name (raw). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_matchup_stints(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_matchup_stints <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_matchup_stints/ncaa_mbb_matchup_stints_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball possessions from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads possession-level data for NCAA men's college
#'   basketball -- one row per offensive possession, with the on-court 5-man
#'   lineups for both teams, points scored, assist/transition/garbage-time
#'   flags, and the possession's first and last event types. Produced by the
#'   sdv-py `ncaa_mbb` engine's possession detector; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_possessions`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per possession.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_date \tab character \tab Date the game was played (MM/DD/YYYY). \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       period \tab integer \tab Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). \cr
#'       poss_num \tab integer \tab Sequential possession number within the game. \cr
#'       poss_team \tab character \tab Team name on offense for the possession. \cr
#'       home_1 \tab character \tab Home lineup slot 1 player name (raw). \cr
#'       home_2 \tab character \tab Home lineup slot 2 player name (raw). \cr
#'       home_3 \tab character \tab Home lineup slot 3 player name (raw). \cr
#'       home_4 \tab character \tab Home lineup slot 4 player name (raw). \cr
#'       home_5 \tab character \tab Home lineup slot 5 player name (raw). \cr
#'       away_1 \tab character \tab Away lineup slot 1 player name (raw). \cr
#'       away_2 \tab character \tab Away lineup slot 2 player name (raw). \cr
#'       away_3 \tab character \tab Away lineup slot 3 player name (raw). \cr
#'       away_4 \tab character \tab Away lineup slot 4 player name (raw). \cr
#'       away_5 \tab character \tab Away lineup slot 5 player name (raw). \cr
#'       home_score \tab integer \tab Home team score after the event. \cr
#'       away_score \tab integer \tab Away team score after the event. \cr
#'       pts \tab integer \tab Points scored. \cr
#'       is_assisted \tab integer \tab Whether the possession ended in an assisted make. \cr
#'       is_transition \tab integer \tab Whether the play occurred in transition. \cr
#'       is_garbage_time \tab integer \tab Whether the event occurred in garbage time. \cr
#'       start_event_type \tab character \tab Event type that started the possession. \cr
#'       first_shot_time \tab integer \tab Elapsed game seconds at the possession's first shot attempt. \cr
#'       first_shot_type \tab character \tab Event type of the possession's first shot attempt. \cr
#'       last_event_time \tab integer \tab Elapsed game seconds at the possession's final event. \cr
#'       last_event_type \tab character \tab Event type of the possession's final event. \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       home_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the home team. \cr
#'       home_espn_team_id \tab character \tab ESPN team identifier for the home team. \cr
#'       away_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the away team. \cr
#'       away_espn_team_id \tab character \tab ESPN team identifier for the away team. \cr
#'       poss_team_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the possession team. \cr
#'       poss_team_espn_team_id \tab character \tab ESPN team identifier for the possession team. \cr
#'       home_1_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 1. \cr
#'       home_1_clean_name \tab character \tab Cleaned display name for home lineup slot 1. \cr
#'       home_2_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 2. \cr
#'       home_2_clean_name \tab character \tab Cleaned display name for home lineup slot 2. \cr
#'       home_3_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 3. \cr
#'       home_3_clean_name \tab character \tab Cleaned display name for home lineup slot 3. \cr
#'       home_4_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 4. \cr
#'       home_4_clean_name \tab character \tab Cleaned display name for home lineup slot 4. \cr
#'       home_5_player_id \tab character \tab stats.ncaa.org player identifier for home lineup slot 5. \cr
#'       home_5_clean_name \tab character \tab Cleaned display name for home lineup slot 5. \cr
#'       away_1_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 1. \cr
#'       away_1_clean_name \tab character \tab Cleaned display name for away lineup slot 1. \cr
#'       away_2_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 2. \cr
#'       away_2_clean_name \tab character \tab Cleaned display name for away lineup slot 2. \cr
#'       away_3_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 3. \cr
#'       away_3_clean_name \tab character \tab Cleaned display name for away lineup slot 3. \cr
#'       away_4_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 4. \cr
#'       away_4_clean_name \tab character \tab Cleaned display name for away lineup slot 4. \cr
#'       away_5_player_id \tab character \tab stats.ncaa.org player identifier for away lineup slot 5. \cr
#'       away_5_clean_name \tab character \tab Cleaned display name for away lineup slot 5. \cr
#'       espn_game_id \tab character \tab ESPN game identifier crosswalked to this contest. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_possessions(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_possessions <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_possessions/ncaa_mbb_possessions_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball within-team RAPM ratings from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads within-team regularized adjusted plus-minus (RAPM)
#'   ratings for NCAA men's college basketball -- one row per
#'   player-team-season, fit against teammate lineup variation within that
#'   team's own possessions (not a cross-team national RAPM). Produced by the
#'   sdv-py `ncaa_mbb` engine's RAPM model on top of the reconstructed
#'   lineup/possession data; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rapm_within_team` release tag as
#'   csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team name. \cr
#'       player_code \tab character \tab Player display name as 'Last, First' used as the RAPM join key. \cr
#'       rapm_off \tab numeric \tab Within-team offensive regularized adjusted plus-minus. \cr
#'       rapm_def \tab numeric \tab Within-team defensive regularized adjusted plus-minus. \cr
#'       team_off_poss \tab numeric \tab Team offensive possessions used in the RAPM fit. \cr
#'       num_players \tab integer \tab Number of teammates included in the within-team RAPM fit. \cr
#'       rapm_net \tab numeric \tab Within-team net regularized adjusted plus-minus (rapm_off + rapm_def). \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       player_id \tab character \tab stats.ncaa.org player identifier. \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       person_id \tab character \tab Internal person identifier used to join across seasons/teams. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rapm_within_team(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rapm_within_team <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball league-wide RAPM ratings from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads league-wide regularized adjusted plus-minus (RAPM)
#'   ratings for NCAA men's college basketball -- one row per
#'   player-season, fit against lineup variation across all Division I
#'   stints for that season (not a within-team RAPM). Produced by the
#'   sdv-py `ncaa_mbb` engine's league-wide stint-ridge RAPM solver
#'   (Torvik-gated to Division I teams) on top of the reconstructed
#'   lineup/possession data; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rapm` release tag as csv.gz/parquet/rds.
#' @details League-wide regularized adjusted plus-minus -- a single ridge
#'   fit over all Division I stints per season, distinct from
#'   [load_ncaa_mbb_rapm_within_team()]'s within-team fit. Published
#'   coverage runs seasons 2011 through 2026.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       player_id \tab character \tab stats.ncaa.org player identifier. \cr
#'       person_id \tab character \tab Internal person identifier used to join across seasons/teams. \cr
#'       player \tab character \tab Player display name ('LAST.FIRST' format). \cr
#'       team \tab character \tab Team name. \cr
#'       orapm \tab numeric \tab League-wide offensive regularized adjusted plus-minus. \cr
#'       drapm \tab numeric \tab League-wide defensive regularized adjusted plus-minus. \cr
#'       rapm_net \tab numeric \tab League-wide net regularized adjusted plus-minus (orapm + drapm). \cr
#'       off_poss \tab integer \tab Offensive possessions used in the RAPM fit. \cr
#'       def_poss \tab integer \tab Defensive possessions used in the RAPM fit. \cr
#'       estimand \tab character \tab Estimand tag for the RAPM fit (e.g. 'league' for the Division I stint solve). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rapm(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rapm <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2011:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2011),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rapm/ncaa_mbb_rapm_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball advanced player box scores from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads advanced per-player, per-game box scores for NCAA
#'   men's college basketball -- one row per player-game, with shooting
#'   splits by zone (rim/mid/3), transition and half-court splits,
#'   assisted-vs-unassisted splits, and shot-zone efficiency rates. A superset
#'   of the traditional box score
#'   (points/rebounds/assists/steals/blocks/turnovers/fouls are included
#'   alongside the advanced splits). Produced by the sdv-py `ncaa_mbb` engine;
#'   backed by the `ncaa-mbb-hoops-data` pipeline, published to the
#'   `ncaa_mbb_player_box` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-game.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_date \tab character \tab Date the game was played (MM/DD/YYYY). \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       team \tab character \tab Team name. \cr
#'       player \tab character \tab Player name (raw, upper-cased). \cr
#'       mins \tab numeric \tab Minutes played. \cr
#'       o_poss \tab numeric \tab Offensive possessions played. \cr
#'       pts \tab numeric \tab Points scored. \cr
#'       orb \tab numeric \tab Offensive rebounds. \cr
#'       drb \tab numeric \tab Defensive rebounds. \cr
#'       ast \tab numeric \tab Assists. \cr
#'       stl \tab numeric \tab Steals. \cr
#'       blk \tab numeric \tab Blocks. \cr
#'       tov \tab numeric \tab Turnovers. \cr
#'       pf \tab numeric \tab Personal fouls. \cr
#'       ts_pct \tab numeric \tab True shooting percentage. \cr
#'       efg_pct \tab numeric \tab Effective field goal percentage. \cr
#'       fgm \tab numeric \tab Field goals made by the lineup. \cr
#'       fga \tab numeric \tab Field goal attempts by the lineup. \cr
#'       fg_pct \tab numeric \tab Field goal percentage. \cr
#'       tpm \tab numeric \tab 3-point field goals made. \cr
#'       tpa \tab numeric \tab 3-point field goal attempts. \cr
#'       tp_pct \tab numeric \tab 3-point field goal percentage. \cr
#'       ftm \tab numeric \tab Free throws made by the lineup. \cr
#'       fta \tab numeric \tab Free throw attempts by the lineup. \cr
#'       ft_pct \tab numeric \tab Free throw percentage. \cr
#'       rimm \tab numeric \tab Rim-area shots made. \cr
#'       rima \tab numeric \tab Rim-area shot attempts. \cr
#'       rim_pct \tab numeric \tab Rim-area field goal percentage. \cr
#'       midm \tab numeric \tab Mid-range shots made. \cr
#'       mida \tab numeric \tab Mid-range shot attempts. \cr
#'       mid_pct \tab numeric \tab Mid-range field goal percentage. \cr
#'       pbackm \tab numeric \tab Post/back-to-basket shots made. \cr
#'       pbacka \tab numeric \tab Post/back-to-basket attempts. \cr
#'       pback_pct \tab numeric \tab Post/back-to-basket shooting percentage. \cr
#'       blk_rim \tab numeric \tab Blocked shots at the rim. \cr
#'       blk_mid \tab numeric \tab Blocked mid-range shots. \cr
#'       blk_three \tab numeric \tab Blocked 3-point attempts. \cr
#'       pct_fga_trans \tab numeric \tab Share of field goal attempts taken in transition. \cr
#'       pct_tpa_trans \tab numeric \tab Share of 3-point attempts taken in transition. \cr
#'       pct_rima_trans \tab numeric \tab Share of rim-area attempts taken in transition. \cr
#'       pct_fgm_trans \tab numeric \tab Share of field goals made in transition. \cr
#'       pct_tpm_trans \tab numeric \tab Share of 3-pointers made in transition. \cr
#'       pct_rimm_trans \tab numeric \tab Share of rim-area shots made in transition. \cr
#'       pct_fgm_ast \tab numeric \tab Share of field goals made that were assisted. \cr
#'       pct_tpm_ast \tab numeric \tab Share of 3-pointers made that were assisted. \cr
#'       pct_rimm_ast \tab numeric \tab Share of rim-area shots made that were assisted. \cr
#'       pts_trans \tab numeric \tab Points scored in transition. \cr
#'       orb_trans \tab numeric \tab Offensive rebounds in transition possessions. \cr
#'       drb_trans \tab numeric \tab Defensive rebounds in transition possessions. \cr
#'       ast_trans \tab numeric \tab Assists in transition possessions. \cr
#'       stl_trans \tab numeric \tab Steals in transition possessions. \cr
#'       blk_trans \tab numeric \tab Blocks in transition possessions. \cr
#'       tov_trans \tab numeric \tab Turnovers in transition possessions. \cr
#'       ts_pct_trans \tab numeric \tab True shooting percentage in transition possessions. \cr
#'       efg_pct_trans \tab numeric \tab Effective field goal percentage in transition possessions. \cr
#'       fgm_trans \tab numeric \tab Field goals made in transition possessions. \cr
#'       fga_trans \tab numeric \tab Field goal attempts in transition possessions. \cr
#'       fg_pct_trans \tab numeric \tab Field goal percentage in transition possessions. \cr
#'       tpm_trans \tab numeric \tab 3-point field goals made in transition possessions. \cr
#'       tpa_trans \tab numeric \tab 3-point field goal attempts in transition possessions. \cr
#'       tp_pct_trans \tab numeric \tab 3-point field goal percentage in transition possessions. \cr
#'       ftm_trans \tab numeric \tab Free throws made in transition possessions. \cr
#'       fta_trans \tab numeric \tab Free throw attempts in transition possessions. \cr
#'       ft_pct_trans \tab numeric \tab Free throw percentage in transition possessions. \cr
#'       rimm_trans \tab numeric \tab Rim-area shots made in transition possessions. \cr
#'       rima_trans \tab numeric \tab Rim-area shot attempts in transition possessions. \cr
#'       rim_pct_trans \tab numeric \tab Rim-area field goal percentage in transition possessions. \cr
#'       midm_trans \tab numeric \tab Mid-range shots made in transition possessions. \cr
#'       mida_trans \tab numeric \tab Mid-range shot attempts in transition possessions. \cr
#'       mid_pct_trans \tab numeric \tab Mid-range field goal percentage in transition possessions. \cr
#'       pts_half \tab numeric \tab Points scored in half-court possessions. \cr
#'       orb_half \tab numeric \tab Offensive rebounds in half-court possessions. \cr
#'       drb_half \tab numeric \tab Defensive rebounds in half-court possessions. \cr
#'       ast_half \tab numeric \tab Assists in half-court possessions. \cr
#'       stl_half \tab numeric \tab Steals in half-court possessions. \cr
#'       blk_half \tab numeric \tab Blocks in half-court possessions. \cr
#'       tov_half \tab numeric \tab Turnovers in half-court possessions. \cr
#'       ts_pct_half \tab numeric \tab True shooting percentage in half-court possessions. \cr
#'       efg_pct_half \tab numeric \tab Effective field goal percentage in half-court possessions. \cr
#'       fgm_half \tab numeric \tab Field goals made in half-court possessions. \cr
#'       fga_half \tab numeric \tab Field goal attempts in half-court possessions. \cr
#'       fg_pct_half \tab numeric \tab Field goal percentage in half-court possessions. \cr
#'       tpm_half \tab numeric \tab 3-point field goals made in half-court possessions. \cr
#'       tpa_half \tab numeric \tab 3-point field goal attempts in half-court possessions. \cr
#'       tp_pct_half \tab numeric \tab 3-point field goal percentage in half-court possessions. \cr
#'       ftm_half \tab numeric \tab Free throws made in half-court possessions. \cr
#'       fta_half \tab numeric \tab Free throw attempts in half-court possessions. \cr
#'       ft_pct_half \tab numeric \tab Free throw percentage in half-court possessions. \cr
#'       rimm_half \tab numeric \tab Rim-area shots made in half-court possessions. \cr
#'       rima_half \tab numeric \tab Rim-area shot attempts in half-court possessions. \cr
#'       rim_pct_half \tab numeric \tab Rim-area field goal percentage in half-court possessions. \cr
#'       midm_half \tab numeric \tab Mid-range shots made in half-court possessions. \cr
#'       mida_half \tab numeric \tab Mid-range shot attempts in half-court possessions. \cr
#'       mid_pct_half \tab numeric \tab Mid-range field goal percentage in half-court possessions. \cr
#'       pts_ast \tab numeric \tab Points scored off an assisted make. \cr
#'       fgm_ast \tab numeric \tab Field goals made that came off an assist. \cr
#'       tpm_ast \tab numeric \tab 3-point field goals made that came off an assist. \cr
#'       rimm_ast \tab numeric \tab Rim-area shots made that came off an assist. \cr
#'       midm_ast \tab numeric \tab Mid-range shots made that came off an assist. \cr
#'       pts_unast \tab numeric \tab Points scored off an unassisted make. \cr
#'       efg_pct_unast \tab numeric \tab Effective field goal percentage that were unassisted. \cr
#'       fgm_unast \tab numeric \tab Field goals made that were unassisted. \cr
#'       fga_unast \tab numeric \tab Field goal attempts that were unassisted. \cr
#'       fg_pct_unast \tab numeric \tab Field goal percentage that were unassisted. \cr
#'       tpm_unast \tab numeric \tab 3-point field goals made that were unassisted. \cr
#'       tpa_unast \tab numeric \tab 3-point field goal attempts that were unassisted. \cr
#'       tp_pct_unast \tab numeric \tab 3-point field goal percentage that were unassisted. \cr
#'       rimm_unast \tab numeric \tab Rim-area shots made that were unassisted. \cr
#'       rima_unast \tab numeric \tab Rim-area shot attempts that were unassisted. \cr
#'       rim_pct_unast \tab numeric \tab Rim-area field goal percentage that were unassisted. \cr
#'       midm_unast \tab numeric \tab Mid-range shots made that were unassisted. \cr
#'       mida_unast \tab numeric \tab Mid-range shot attempts that were unassisted. \cr
#'       mid_pct_unast \tab numeric \tab Mid-range field goal percentage that were unassisted. \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       home_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the home team. \cr
#'       home_espn_team_id \tab character \tab ESPN team identifier for the home team. \cr
#'       away_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the away team. \cr
#'       away_espn_team_id \tab character \tab ESPN team identifier for the away team. \cr
#'       team_ncaa_team_id \tab character \tab stats.ncaa.org team identifier. \cr
#'       team_espn_team_id \tab character \tab ESPN team identifier. \cr
#'       player_id \tab character \tab stats.ncaa.org player identifier. \cr
#'       clean_name \tab character \tab Cleaned/title-cased display name. \cr
#'       espn_game_id \tab character \tab ESPN game identifier crosswalked to this contest. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_player_box(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_player_box <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_player_box/ncaa_mbb_player_box_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball advanced team box scores from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads advanced per-team, per-game box scores for NCAA men's
#'   college basketball -- one row per team-game, with offensive/defensive
#'   ratings, shot-zone rates and efficiency (rim/mid/3),
#'   rebounding/assist/turnover rates, and the matching opponent (`d_*`)
#'   splits. Produced by the sdv-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_box`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per team-game.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       team \tab character \tab Team name. \cr
#'       mins \tab numeric \tab Minutes played. \cr
#'       o_mins \tab numeric \tab Minutes with the team on offense. \cr
#'       d_mins \tab numeric \tab Minutes with the team on defense. \cr
#'       o_poss \tab numeric \tab Offensive possessions played. \cr
#'       d_poss \tab numeric \tab Defensive possessions played. \cr
#'       ortg \tab numeric \tab Offensive rating (points per 100 possessions). \cr
#'       drtg \tab numeric \tab Defensive rating (points allowed per 100 possessions). \cr
#'       netrtg \tab numeric \tab Net rating (ortg minus drtg). \cr
#'       pts \tab numeric \tab Points scored. \cr
#'       d_pts \tab numeric \tab Points allowed. \cr
#'       fga \tab numeric \tab Field goal attempts by the lineup. \cr
#'       d_fga \tab numeric \tab Opponent field goal attempts. \cr
#'       fgm \tab numeric \tab Field goals made by the lineup. \cr
#'       d_fgm \tab numeric \tab Opponent field goals made. \cr
#'       tpa \tab numeric \tab 3-point field goal attempts. \cr
#'       d_tpa \tab numeric \tab Opponent 3-point attempts. \cr
#'       tpm \tab numeric \tab 3-point field goals made. \cr
#'       d_tpm \tab numeric \tab Opponent 3-pointers made. \cr
#'       fta \tab numeric \tab Free throw attempts by the lineup. \cr
#'       d_fta \tab numeric \tab Opponent free throw attempts. \cr
#'       ftm \tab numeric \tab Free throws made by the lineup. \cr
#'       d_ftm \tab numeric \tab Opponent free throws made. \cr
#'       rima \tab numeric \tab Rim-area shot attempts. \cr
#'       d_rima \tab numeric \tab Opponent rim-area attempts. \cr
#'       rimm \tab numeric \tab Rim-area shots made. \cr
#'       d_rimm \tab numeric \tab Opponent rim-area shots made. \cr
#'       orb \tab numeric \tab Offensive rebounds. \cr
#'       d_orb \tab numeric \tab Opponent offensive rebounds. \cr
#'       drb \tab numeric \tab Defensive rebounds. \cr
#'       d_drb \tab numeric \tab Opponent defensive rebounds. \cr
#'       blk \tab numeric \tab Blocks. \cr
#'       d_blk \tab numeric \tab Opponent blocks. \cr
#'       to \tab numeric \tab Turnovers by the lineup. \cr
#'       d_to \tab numeric \tab Opponent turnovers. \cr
#'       ast \tab numeric \tab Assists. \cr
#'       d_ast \tab numeric \tab Opponent assists. \cr
#'       e_poss \tab numeric \tab Estimated possessions (alternate possession estimator). \cr
#'       fg_pct \tab numeric \tab Field goal percentage. \cr
#'       d_fg_pct \tab numeric \tab Opponent field goal percentage. \cr
#'       tpp \tab numeric \tab 3-point field goal percentage. \cr
#'       d_tpp \tab numeric \tab Opponent 3-point percentage. \cr
#'       ftp \tab numeric \tab Free throw percentage. \cr
#'       d_ftp \tab numeric \tab Opponent free throw percentage. \cr
#'       efg_pct \tab numeric \tab Effective field goal percentage. \cr
#'       d_efg_pct \tab numeric \tab Opponent effective field goal percentage. \cr
#'       ts_pct \tab numeric \tab True shooting percentage. \cr
#'       d_ts_pct \tab numeric \tab Opponent true shooting percentage. \cr
#'       rim_pct \tab numeric \tab Rim-area field goal percentage. \cr
#'       d_rim_pct \tab numeric \tab Opponent rim-area field goal percentage. \cr
#'       mid_pct \tab numeric \tab Mid-range field goal percentage. \cr
#'       d_mid_pct \tab numeric \tab Opponent mid-range field goal percentage. \cr
#'       tp_rate \tab numeric \tab Share of shot attempts taken from 3-point range. \cr
#'       d_tp_rate \tab numeric \tab Opponent share of shot attempts from 3-point range. \cr
#'       rim_rate \tab numeric \tab Share of shot attempts taken at the rim. \cr
#'       d_rim_rate \tab numeric \tab Opponent share of shot attempts at the rim. \cr
#'       mid_rate \tab numeric \tab Share of shot attempts taken mid-range. \cr
#'       d_mid_rate \tab numeric \tab Opponent share of shot attempts mid-range. \cr
#'       ft_rate \tab numeric \tab Free throw rate (FTA per FGA). \cr
#'       d_ft_rate \tab numeric \tab Opponent free throw rate. \cr
#'       ast_rate \tab numeric \tab Assist rate. \cr
#'       d_ast_rate \tab numeric \tab Opponent assist rate. \cr
#'       to_rate \tab numeric \tab Turnover rate. \cr
#'       d_to_rate \tab numeric \tab Opponent turnover rate. \cr
#'       blk_rate \tab numeric \tab Block rate. \cr
#'       o_blk_rate \tab numeric \tab Offensive possessions ending in a block allowed, as a rate. \cr
#'       orb_pct \tab numeric \tab Offensive rebound percentage. \cr
#'       drb_pct \tab numeric \tab Defensive rebound percentage. \cr
#'       time_per_poss \tab numeric \tab Average seconds per possession. \cr
#'       d_time_per_poss \tab numeric \tab Opponent average seconds per possession. \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       home_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the home team. \cr
#'       home_espn_team_id \tab character \tab ESPN team identifier for the home team. \cr
#'       away_ncaa_team_id \tab character \tab stats.ncaa.org team identifier for the away team. \cr
#'       away_espn_team_id \tab character \tab ESPN team identifier for the away team. \cr
#'       team_ncaa_team_id \tab character \tab stats.ncaa.org team identifier. \cr
#'       team_espn_team_id \tab character \tab ESPN team identifier. \cr
#'       espn_game_id \tab character \tab ESPN game identifier crosswalked to this contest. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_box(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_box <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_box/ncaa_mbb_team_box_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball season rosters from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads a lightweight season roster for NCAA men's college
#'   basketball -- one row per player-team-season with a games-played count.
#'   For the fuller roster (jersey, class, position, height, hometown, high
#'   school), use [load_ncaa_mbb_team_rosters()]. Produced by the sdv-py
#'   `ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_rosters` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       team \tab character \tab Team name. \cr
#'       player \tab character \tab Player name (raw, upper-cased). \cr
#'       games \tab integer \tab Games played (season total). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_rosters(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_rosters <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_rosters/ncaa_mbb_rosters_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load full NCAA men's college basketball team rosters from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads the full season roster for NCAA men's college
#'   basketball -- one row per player-team-season with jersey number, class
#'   year, position, height, hometown, high school, and games played/started.
#'   Produced by the sdv-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_team_rosters`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per player-team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'       team_id \tab character \tab Unique team identifier. \cr
#'       team \tab character \tab Team name. \cr
#'       player_id \tab character \tab stats.ncaa.org player identifier. \cr
#'       player \tab character \tab Player name (raw, upper-cased). \cr
#'       clean_name \tab character \tab Cleaned/title-cased display name. \cr
#'       name \tab character \tab Player full display name. \cr
#'       jersey \tab character \tab Jersey number. \cr
#'       class \tab character \tab Class year (e.g. 'Fr.', 'So.', 'Jr.', 'Sr.'). \cr
#'       position \tab character \tab Position abbreviation. \cr
#'       height \tab character \tab Height as a 'feet-inches' string (e.g. '6-1'). \cr
#'       ht_inches \tab integer \tab Height in total inches. \cr
#'       hometown \tab character \tab Player hometown (city, state). \cr
#'       high_school \tab character \tab Player high school. \cr
#'       gp \tab character \tab Games played. \cr
#'       gs \tab character \tab Games started. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_rosters(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_rosters <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_rosters/ncaa_mbb_team_rosters_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load NCAA men's college basketball schedules from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads season schedules/results for NCAA men's college
#'   basketball -- one row per game with home/away teams and final scores.
#'   Produced by the sdv-py `ncaa_mbb` engine; backed by the
#'   `ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_schedule`
#'   release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per game.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       contest_id \tab character \tab Unique stats.ncaa.org contest identifier. \cr
#'       game_date \tab character \tab Date the game was played (MM/DD/YYYY). \cr
#'       home \tab character \tab Home team name. \cr
#'       away \tab character \tab Away team name. \cr
#'       home_score \tab integer \tab Home team score after the event. \cr
#'       away_score \tab integer \tab Away team score after the event. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_schedule(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_schedule <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_schedule/ncaa_mbb_schedule_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}


#' @title
#' **Load the NCAA men's college basketball team-id crosswalk from the data repo**
#' @rdname load_ncaa_mbb_lineups
#' @author Saiem Gilani
#' @description Loads the season-level stats.ncaa.org team-id / conference
#'   crosswalk for NCAA men's college basketball -- one row per team-season.
#'   Useful for joining `ncaa_team_id` columns on the other `ncaa_mbb_*`
#'   datasets back to a team name and conference. Produced by the sdv-py
#'   `ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
#'   published to the `ncaa_mbb_team_ids` release tag as csv.gz/parquet/rds.
#' @param ... Additional arguments passed to an underlying function that writes
#'   the season data into a database.
#' @param dbConnection A `DBIConnection` object, as returned by [DBI::dbConnect()]
#' @param tablename The name of the data table within the database
#' @return Returns a `hoopR_data` tibble with one row per team-season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference affiliation. \cr
#'       id \tab character \tab stats.ncaa.org team identifier. \cr
#'       season \tab integer \tab Season identifier (4-digit season-ending year). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @export
#' @family NCAA MBB loader functions
#' @examples
#' \donttest{
#'   try(load_ncaa_mbb_team_ids(seasons = most_recent_mbb_season()))
#' }
load_ncaa_mbb_team_ids <- function(seasons = most_recent_mbb_season(),
                                ...,
                                dbConnection = NULL, tablename = NULL) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))
  dots <- rlang::dots_list(...)

  loader <- rds_from_url
  if (!is.null(dbConnection) && !is.null(tablename)) in_db <- TRUE else in_db <- FALSE

  if (isTRUE(seasons)) seasons <- 2010:most_recent_mbb_season()

  stopifnot(is.numeric(seasons),
            all(seasons >= 2010),
            all(seasons <= most_recent_mbb_season()))

  urls <- paste0(
    "https://github.com/sportsdataverse/sportsdataverse-data/releases/download/",
    "ncaa_mbb_team_ids/ncaa_mbb_team_ids_", seasons, ".rds"
  )

  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = seasons)

  out <- lapply(urls, progressively(loader, p))
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  if (in_db) {
    DBI::dbWriteTable(dbConnection, tablename, out, append = TRUE, ...)
    out <- NULL
  } else {
    class(out) <- c("hoopR_data","tbl_df","tbl","data.table","data.frame")
  }
  out
}

