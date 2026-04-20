#' **Add players on court in NBA Stats API play-by-play**
#' @name .players_on_court
NULL
#' @title
#' **Add players on court in NBA Stats API play-by-play**
#' @author Vladislav Shufinskiy
#' @param pbp_data PlayByPlay data frame received `nba_pbp` function
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @noRd
#' @family NBA PBP Functions
.players_on_court <- function(pbp_data) {
  pbp_data <- dplyr::mutate(pbp_data, PCTIMESTRING = ifelse(.data$period < 5, abs((.data$minute_remaining_quarter * 60 + .data$seconds_remaining_quarter) - 720 * .data$period),
    abs((.data$minute_remaining_quarter * 60 + .data$seconds_remaining_quarter) - (2880 + 300 * (.data$period - 4)))
  ))

  l <- lapply(sort(unique(pbp_data$period)), function(x) {
    pbp_data_period <- dplyr::filter(pbp_data, .data$period == x)
    all_id <- unique(c(
      pbp_data_period$player1_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player1_name) & !pbp_data_period$person1type %in% c(6, 7)],
      pbp_data_period$player2_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player2_name) & !pbp_data_period$person2type %in% c(6, 7)],
      pbp_data_period$player3_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player3_name) & !pbp_data_period$person3type %in% c(6, 7)]
    ))
    all_id <- as.numeric(all_id)

    all_id <- all_id[all_id != 0 & all_id < 1610612737]

    sub_off <- as.numeric(unique(pbp_data_period$player1_id[pbp_data_period$event_type == 8]))
    sub_on <- as.numeric(unique(pbp_data_period$player2_id[pbp_data_period$event_type == 8]))

    "%!in%" <- Negate(`%in%`)
    all_id <- all_id[all_id %!in% setdiff(sub_on, sub_off)]

    sub_on_off <- dplyr::intersect(sub_on, sub_off)

    for (i in sub_on_off) {
      on <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
      off <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
      if (off > on) {
        all_id <- all_id[all_id != i]
      } else if (off == on) {
        on_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
        off_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
        if (off_event > on_event) {
          all_id <- all_id[all_id != i]
        }
      }
    }

    if ((length(all_id) == 10)) {
      ord_all_id <- pbp_data_period %>%
        dplyr::select("player1_id", "person1type") %>%
        dplyr::filter(.data$player1_id != 0 & .data$person1type %in% c(4, 5)) %>%
        dplyr::rename("player_id" = "player1_id", "persontype" = "person1type") %>%
        dplyr::bind_rows(pbp_data_period %>%
          dplyr::select("player2_id", "person2type") %>%
          dplyr::filter(.data$player2_id != 0 & .data$person2type %in% c(4, 5)) %>%
          dplyr::rename("player_id" = "player2_id", "persontype" = "person2type")) %>%
        dplyr::bind_rows(pbp_data_period %>%
          dplyr::select("player3_id", "person3type") %>%
          dplyr::filter(.data$player3_id != 0 & .data$person3type %in% c(4, 5)) %>%
          dplyr::rename("player_id" = "player3_id", "persontype" = "person3type")) %>%
        dplyr::distinct() %>%
        dplyr::arrange(dplyr::desc(.data$persontype)) %>%
        dplyr::select("player_id") %>%
        dplyr::mutate(player_id = as.numeric(.data$player_id)) %>%
        dplyr::pull()

      all_id <- ord_all_id[ord_all_id %in% all_id]
    }

    if (length(all_id) != 10) {
      if (inherits(pbp_data$game_id[1], "integer")) {
        tmp_gameid <- paste0("00", as.character(pbp_data$game_id[1]))
      } else {
        tmp_gameid <- pbp_data$game_id[1]
      }

      tmp_data <- nba_boxscoretraditionalv2(game_id = tmp_gameid, start_period = x, end_period = x, range_type = 1)$PlayerStats

      all_id <- as.integer(tmp_data$PLAYER_ID)

      sub_off <- unique(pbp_data_period$player1_id[pbp_data_period$event_type == 8])
      sub_on <- unique(pbp_data_period$player2_id[pbp_data_period$event_type == 8])

      "%!in%" <- Negate(`%in%`)
      all_id <- all_id[all_id %!in% setdiff(sub_on, sub_off)]

      sub_on_off <- dplyr::intersect(sub_on, sub_off)

      for (i in sub_on_off) {
        on <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
        off <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
        if (off > on) {
          all_id <- all_id[all_id != i]
        } else if (off == on) {
          on_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
          off_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
          if (off_event > on_event) {
            all_id <- all_id[all_id != i]
          }
        }
      }
    }

    columns <- paste0("player", seq(1, 10))
    pbp_data_period[columns] <- NA

    for (i in seq(1:10)) {
      pbp_data_period[columns][i] <- all_id[i]
    }

    for (column in paste0("player", seq(1, 10))) {
      i <- 1
      repeat{
        n <- nrow(pbp_data_period)
        if (length(which(pbp_data_period$event_type == 8 & as.numeric(pbp_data_period$player1_id) == pbp_data_period[, column])) == 0) {
          break
        }
        i <- min(which(pbp_data_period$event_type == 8 & pbp_data_period[, column] == as.numeric(pbp_data_period$player1_id)))
        player_on <- as.numeric(pbp_data_period$player2_id[i])
        pbp_data_period[i:n, column] <- player_on
      }
    }
    return(dplyr::select(pbp_data_period, -"PCTIMESTRING"))
  })
  return(dplyr::bind_rows(l) %>% dplyr::rename(
    "away_player1" = "player1",
    "away_player2" = "player2",
    "away_player3" = "player3",
    "away_player4" = "player4",
    "away_player5" = "player5",
    "home_player1" = "player6",
    "home_player2" = "player7",
    "home_player3" = "player8",
    "home_player4" = "player9",
    "home_player5" = "player10"
  ))
}


#' **Convert V3 PBP columns to V2-compatible format**
#' @name .v3_to_v2_format
NULL
#' @title
#' **Convert V3 PBP columns to V2-compatible format**
#' @param pbp_data PlayByPlay V3 data frame from `nba_playbyplayv3` function
#' @param player_roster Player roster data frame with person_id, name, team info
#'   (from `.build_player_roster`)
#' @return Returns a data frame with V2-compatible column names and derived fields
#' @noRd
#' @family NBA PBP Functions
.v3_to_v2_format <- function(pbp_data, player_roster = NULL) {
  required_roster_cols <- c(
    "person_id", "first_name", "family_name", "name_i",
    "full_name", "team_id", "team_name", "team_city", "team_tricode"
  )

  if (is.null(player_roster) || !all(required_roster_cols %in% colnames(player_roster))) {
    player_roster <- NULL
  }

  # V3 event_type mapping to V2 EVENTMSGTYPE numeric codes
  event_type_map <- c(
    "period" = "12",
    "Jump Ball" = "10",
    "Made Shot" = "1",
    "Missed Shot" = "2",
    "Free Throw" = "3",
    "Rebound" = "4",
    "Turnover" = "5",
    "Foul" = "6",
    "Violation" = "7",
    "Substitution" = "8",
    "Timeout" = "9",
    "Ejection" = "11",
    "Instant Replay" = "18",
    "Game" = "12",
    "Stoppage" = "18"
  )

  # V3 sub_type -> V2 EVENTMSGACTIONTYPE mapping (from nba_api event types CSV)
  # Shots (used for both Made Shot and Missed Shot event types)
  shot_action_map <- c(
    "Jump Shot" = "1",
    "Hook Shot" = "3",
    "Layup" = "5", "Layup Shot" = "5",
    "Dunk" = "7", "Dunk Shot" = "7",
    "Running Layup" = "41", "Running Layup Shot" = "41",
    "Driving Layup" = "42", "Driving Layup Shot" = "42",
    "Alley Oop Layup" = "43", "Alley Oop Layup Shot" = "43",
    "Alley Oop Dunk Shot" = "43", "Running Alley Oop Dunk Shot" = "43",
    "Running Jump Shot" = "46",
    "Turnaround Jump Shot" = "47",
    "Driving Dunk" = "49", "Driving Dunk Shot" = "49",
    "Running Dunk" = "50", "Running Dunk Shot" = "50",
    "Driving Hook Shot" = "57",
    "Turnaround Hook Shot" = "58",
    "Fadeaway Jumper" = "63", "Fadeaway Jump Shot" = "63",
    "Jump Bank Shot" = "66",
    "Putback Layup" = "72", "Putback Layup Shot" = "72",
    "Driving Reverse Layup" = "73", "Driving Reverse Layup Shot" = "73",
    "Running Finger Roll Layup" = "76", "Running Finger Roll Layup Shot" = "76",
    "Floating Jump Shot" = "78", "Floating Jump shot" = "78",
    "Driving Floating Jump Shot" = "78",
    "Driving Floating Bank Jump Shot" = "78",
    "Pullup Jump Shot" = "79", "Pullup Jump shot" = "79",
    "Running Pull-Up Jump Shot" = "79",
    "Step Back Jump Shot" = "80", "Step Back Jump shot" = "80",
    "Step Back Bank Jump Shot" = "80",
    "Driving Bank Shot" = "82",
    "Turnaround Fadeaway" = "86", "Turnaround Fadeaway shot" = "86",
    "Tip Layup Shot" = "97",
    "Cutting Layup Shot" = "98",
    "Cutting Dunk Shot" = "108",
    "Tip Dunk Shot" = "108",
    "Cutting Finger Roll Layup Shot" = "98",
    "Driving Finger Roll Layup Shot" = "42",
    "Finger Roll Layup Shot" = "76"
  )

  # Free throw sub_type -> EVENTMSGACTIONTYPE
  ft_action_map <- c(
    "Free Throw 1 of 1" = "10",
    "Free Throw 1 of 2" = "11",
    "Free Throw 2 of 2" = "12",
    "Free Throw 1 of 3" = "13",
    "Free Throw 2 of 3" = "14",
    "Free Throw 3 of 3" = "15",
    "Free Throw Technical" = "16",
    "Free Throw Flagrant 1 of 2" = "18",
    "Free Throw Flagrant 2 of 2" = "19",
    "Free Throw Flagrant 1 of 1" = "20",
    "Free Throw Clear Path 1 of 2" = "25",
    "Free Throw Clear Path 2 of 2" = "26",
    "Free Throw Flagrant 1 of 3" = "27",
    "Free Throw Flagrant 2 of 3" = "28",
    "Free Throw Flagrant 3 of 3" = "29"
  )

  # Turnover sub_type -> EVENTMSGACTIONTYPE
  to_action_map <- c(
    "Bad Pass" = "1",
    "Lost Ball" = "2",
    "Traveling" = "4",
    "Offensive Foul Turnover" = "37",
    "Double Dribble" = "6",
    "Discontinue Dribble" = "7",
    "3 Second Violation" = "8",
    "5 Second Violation" = "9",
    "8 Second Violation" = "10",
    "Shot Clock Violation" = "11", "Shot Clock" = "11",
    "Inbound Turnover" = "12",
    "Backcourt Turnover" = "13", "Backcourt" = "13",
    "Offensive Goaltending" = "15",
    "Lane Violation" = "17",
    "Kicked Ball Violation" = "19",
    "Palming" = "21",
    "5 Second Inbound" = "38",
    "Step Out of Bounds" = "39",
    "Out of Bounds Lost Ball Turnover" = "40",
    "Out of Bounds - Bad Pass Turnover" = "45"
  )

  # Foul sub_type -> EVENTMSGACTIONTYPE
  foul_action_map <- c(
    "Personal" = "1",
    "Shooting" = "2",
    "Loose Ball" = "3",
    "Offensive" = "4",
    "Intentional" = "5",
    "Away From Play" = "6",
    "Clear Path" = "9",
    "Double Technical" = "10",
    "Technical" = "11",
    "Flagrant 1" = "14", "Flagrant Type 1" = "14",
    "Flagrant 2" = "15", "Flagrant Type 2" = "15",
    "Defense 3 Second" = "17",
    "Taunting" = "19",
    "Excess Timeout" = "25",
    "Charge" = "26",
    "Block" = "27",
    "Personal Take" = "28",
    "Shooting Block" = "29"
  )

  # Timeout sub_type -> EVENTMSGACTIONTYPE
  timeout_action_map <- c(
    "Regular" = "1",
    "Short" = "2",
    "Official" = "4"
  )

  # Violation sub_type -> EVENTMSGACTIONTYPE
  violation_action_map <- c(
    "Delay Of Game" = "1", "Delay of Game" = "1",
    "Defensive Goaltending" = "2",
    "Lane Violation" = "3",
    "Jump Ball Violation" = "4",
    "Kicked Ball" = "5", "Kicked Ball Violation" = "5",
    "Double Lane Violation" = "6"
  )

  # --- Consolidate blank action_type rows (blocks/steals) into parent actions ---
  # Blank action_type rows are secondary actions (BLOCK, STEAL) that should be

  # merged into the preceding Missed Shot or Turnover row as player2/player3 info
  is_block <- pbp_data$action_type == "" & grepl("BLOCK", pbp_data$description)
  is_steal <- pbp_data$action_type == "" & grepl("STEAL", pbp_data$description)

  # Initialize columns for consolidated secondary player info
  pbp_data$block_person_id <- NA_integer_
  pbp_data$block_player_name <- NA_character_
  pbp_data$steal_person_id <- NA_integer_
  pbp_data$steal_player_name <- NA_character_

  # Merge blocks into the nearest preceding Missed Shot at same clock/period
  block_indices <- which(is_block)
  for (bi in block_indices) {
    # Search backwards for the nearest Missed Shot at same clock+period
    for (j in (bi - 1):max(1, bi - 5)) {
      if (pbp_data$action_type[j] == "Missed Shot" &&
        pbp_data$period[j] == pbp_data$period[bi] &&
        pbp_data$clock[j] == pbp_data$clock[bi]) {
        pbp_data$block_person_id[j] <- pbp_data$person_id[bi]
        pbp_data$block_player_name[j] <- pbp_data$player_name[bi]
        break
      }
    }
  }

  # Merge steals into the nearest Turnover at same clock/period (search backwards then forwards)
  steal_indices <- which(is_steal)
  for (si in steal_indices) {
    found <- FALSE
    # Search backwards first
    for (j in (si - 1):max(1, si - 5)) {
      if (pbp_data$action_type[j] == "Turnover" &&
        pbp_data$period[j] == pbp_data$period[si] &&
        pbp_data$clock[j] == pbp_data$clock[si]) {
        pbp_data$steal_person_id[j] <- pbp_data$person_id[si]
        pbp_data$steal_player_name[j] <- pbp_data$player_name[si]
        found <- TRUE
        break
      }
    }
    if (!found) {
      # Search forwards
      for (j in (si + 1):min(nrow(pbp_data), si + 5)) {
        if (pbp_data$action_type[j] == "Turnover" &&
          pbp_data$period[j] == pbp_data$period[si] &&
          pbp_data$clock[j] == pbp_data$clock[si]) {
          pbp_data$steal_person_id[j] <- pbp_data$person_id[si]
          pbp_data$steal_player_name[j] <- pbp_data$player_name[si]
          break
        }
      }
    }
  }

  # Remove consolidated blank action_type rows
  pbp_data <- pbp_data[!(is_block | is_steal), ]

  # --- Parse assist info from Made Shot descriptions ---
  # Pattern: "(PlayerName N AST)"
  assist_match <- regmatches(
    pbp_data$description,
    regexec("\\(([^)]+?)\\s+[0-9]+\\s+AST\\)", pbp_data$description)
  )
  pbp_data$assist_player_name <- vapply(
    assist_match,
    function(m) if (length(m) >= 2) m[2] else NA_character_,
    character(1)
  )

  # --- Parse substitution incoming player ---
  # Pattern: "SUB: IncomingPlayer FOR OutgoingPlayer"
  # V3: person_id = outgoing player. We need the incoming player name for player2.
  sub_in_match <- regmatches(
    pbp_data$description,
    regexec("SUB:\\s+(.+?)\\s+FOR\\s+.+", pbp_data$description)
  )
  pbp_data$sub_in_player_name <- vapply(
    sub_in_match,
    function(m) if (length(m) >= 2) m[2] else NA_character_,
    character(1)
  )

  # --- Parse jump ball players ---
  # Pattern: "Jump Ball PlayerA vs. PlayerB: Tip to PlayerC"
  jb_match <- regmatches(
    pbp_data$description,
    regexec("Jump Ball\\s+.+?\\s+vs\\.\\s+(.+?)(?::\\s+Tip to\\s+(.+?))?\\s*$", pbp_data$description, perl = TRUE)
  )
  pbp_data$jb_player2_name <- vapply(
    jb_match,
    function(m) if (length(m) >= 2 && nchar(m[2]) > 0) m[2] else NA_character_,
    character(1)
  )
  pbp_data$jb_player3_name <- vapply(
    jb_match,
    function(m) if (length(m) >= 3 && nchar(m[3]) > 0) m[3] else NA_character_,
    character(1)
  )

  # --- Resolve player2/player3 IDs from roster lookup ---
  .lookup_player <- function(name, roster) {
    if (is.null(roster) || is.na(name) || nchar(name) == 0) {
      return(list(
        person_id = NA_character_, team_id = NA_character_,
        team_city = NA_character_, team_name = NA_character_,
        team_tricode = NA_character_, full_name = NA_character_
      ))
    }
    # Try exact match on family_name first, then name_i, then partial
    idx <- which(roster$family_name == name)
    if (length(idx) == 0) idx <- which(roster$name_i == name)
    if (length(idx) == 0) {
      # Try matching "F. LastName" format
      idx <- which(vapply(seq_len(nrow(roster)), function(r) {
        fn <- roster$first_name[r]
        ln <- roster$family_name[r]
        abbr <- paste0(substr(fn, 1, 1), ". ", ln)
        abbr == name
      }, logical(1)))
    }
    if (length(idx) == 0) {
      # Fuzzy: check if name is contained in full_name or vice versa
      idx <- which(vapply(seq_len(nrow(roster)), function(r) {
        grepl(name, roster$full_name[r], fixed = TRUE) ||
          grepl(name, roster$family_name[r], fixed = TRUE)
      }, logical(1)))
    }
    if (length(idx) == 0) {
      return(list(
        person_id = NA_character_, team_id = NA_character_,
        team_city = NA_character_, team_name = NA_character_,
        team_tricode = NA_character_, full_name = name
      ))
    }
    r <- roster[idx[1], ]
    list(
      person_id = as.character(r$person_id),
      team_id = as.character(r$team_id),
      team_city = r$team_city,
      team_name = r$team_name,
      team_tricode = r$team_tricode,
      full_name = r$full_name
    )
  }

  # Build player2/player3 columns
  n <- nrow(pbp_data)
  p2_id <- rep(NA_character_, n)
  p2_name <- rep(NA_character_, n)
  p2_team_id <- rep(NA_character_, n)
  p2_team_city <- rep(NA_character_, n)
  p2_team_nickname <- rep(NA_character_, n)
  p2_team_abbr <- rep(NA_character_, n)
  p2type <- rep(NA_character_, n)

  p3_id <- rep(NA_character_, n)
  p3_name <- rep(NA_character_, n)
  p3_team_id <- rep(NA_character_, n)
  p3_team_city <- rep(NA_character_, n)
  p3_team_nickname <- rep(NA_character_, n)
  p3_team_abbr <- rep(NA_character_, n)
  p3type <- rep(NA_character_, n)

  for (i in seq_len(n)) {
    at <- pbp_data$action_type[i]

    # Assists on Made Shots -> player2
    if (at == "Made Shot" && !is.na(pbp_data$assist_player_name[i])) {
      info <- .lookup_player(pbp_data$assist_player_name[i], player_roster)
      p2_id[i] <- info$person_id
      p2_name[i] <- info$full_name
      p2_team_id[i] <- info$team_id
      p2_team_city[i] <- info$team_city
      p2_team_nickname[i] <- info$team_name
      p2_team_abbr[i] <- info$team_tricode
    }

    # Blocks on Missed Shots -> player3
    if (at == "Missed Shot" && !is.na(pbp_data$block_person_id[i])) {
      p3_id[i] <- as.character(pbp_data$block_person_id[i])
      p3_name[i] <- pbp_data$block_player_name[i]
      if (!is.null(player_roster)) {
        info <- .lookup_player(pbp_data$block_player_name[i], player_roster)
        if (!is.na(info$person_id)) p3_id[i] <- info$person_id
        p3_name[i] <- info$full_name %||% pbp_data$block_player_name[i]
        p3_team_id[i] <- info$team_id
        p3_team_city[i] <- info$team_city
        p3_team_nickname[i] <- info$team_name
        p3_team_abbr[i] <- info$team_tricode
      }
    }

    # Steals on Turnovers -> player2
    if (at == "Turnover" && !is.na(pbp_data$steal_person_id[i])) {
      p2_id[i] <- as.character(pbp_data$steal_person_id[i])
      p2_name[i] <- pbp_data$steal_player_name[i]
      if (!is.null(player_roster)) {
        info <- .lookup_player(pbp_data$steal_player_name[i], player_roster)
        if (!is.na(info$person_id)) p2_id[i] <- info$person_id
        p2_name[i] <- info$full_name %||% pbp_data$steal_player_name[i]
        p2_team_id[i] <- info$team_id
        p2_team_city[i] <- info$team_city
        p2_team_nickname[i] <- info$team_name
        p2_team_abbr[i] <- info$team_tricode
      }
    }

    # Substitutions: V3 person_id = outgoing player (player1 in V2)
    # player2 = incoming player (parsed from "SUB: IncomingPlayer FOR ...")
    if (at == "Substitution" && !is.na(pbp_data$sub_in_player_name[i])) {
      info <- .lookup_player(pbp_data$sub_in_player_name[i], player_roster)
      p2_id[i] <- info$person_id
      p2_name[i] <- info$full_name %||% pbp_data$sub_in_player_name[i]
      p2_team_id[i] <- info$team_id %||% as.character(pbp_data$team_id[i])
      p2_team_city[i] <- info$team_city
      p2_team_nickname[i] <- info$team_name
      p2_team_abbr[i] <- info$team_tricode %||% as.character(pbp_data$team_tricode[i])
    }

    # Jump Balls: player2 = vs player, player3 = tip-to player
    if (at == "Jump Ball") {
      if (!is.na(pbp_data$jb_player2_name[i])) {
        info <- .lookup_player(pbp_data$jb_player2_name[i], player_roster)
        p2_id[i] <- info$person_id
        p2_name[i] <- info$full_name
        p2_team_id[i] <- info$team_id
        p2_team_city[i] <- info$team_city
        p2_team_nickname[i] <- info$team_name
        p2_team_abbr[i] <- info$team_tricode
      }
      if (!is.na(pbp_data$jb_player3_name[i])) {
        info <- .lookup_player(pbp_data$jb_player3_name[i], player_roster)
        p3_id[i] <- info$person_id
        p3_name[i] <- info$full_name
        p3_team_id[i] <- info$team_id
        p3_team_city[i] <- info$team_city
        p3_team_nickname[i] <- info$team_name
        p3_team_abbr[i] <- info$team_tricode
      }
    }
  }

  # Parse V3 clock "PT10M30.00S" -> minutes and seconds remaining
  matches <- regmatches(pbp_data$clock, regexec("PT([0-9]+)M([0-9.]+)S", pbp_data$clock))
  mins <- vapply(matches, function(m) if (length(m) == 3) as.numeric(m[2]) else NA_real_, numeric(1))
  secs <- vapply(matches, function(m) if (length(m) == 3) as.numeric(m[3]) else NA_real_, numeric(1))

  period <- as.numeric(pbp_data$period)

  # Time columns
  minute_remaining_quarter <- as.numeric(floor(mins))
  seconds_remaining_quarter <- as.numeric(floor(secs))
  time_quarter <- sprintf("%02d:%02d", as.integer(minute_remaining_quarter), as.integer(seconds_remaining_quarter))

  # Elapsed game time in minutes
  # Regulation (period 1-4): 12-minute quarters
  # Overtime (period 5+): 5-minute periods
  quarter_len <- ifelse(period <= 4, 12, 5)
  elapsed_in_period <- quarter_len - (minute_remaining_quarter + seconds_remaining_quarter / 60)
  minute_game <- ifelse(
    period <= 4,
    (period - 1) * 12 + elapsed_in_period,
    48 + (period - 5) * 5 + elapsed_in_period
  )
  minute_game <- round(minute_game, 2)

  # Time remaining: for regulation, remaining until end of 4Q;
  # for OT, remaining in current OT period
  time_remaining <- ifelse(
    period <= 4,
    (4 - period) * 12 + minute_remaining_quarter + seconds_remaining_quarter / 60,
    minute_remaining_quarter + seconds_remaining_quarter / 60
  )
  time_remaining <- round(time_remaining, 2)

  # Score columns: parse then forward-fill so every row has the current score
  home_score <- suppressWarnings(as.numeric(pbp_data$score_home))
  away_score <- suppressWarnings(as.numeric(pbp_data$score_away))

  # Forward-fill: carry last known score into rows without score updates
  last_home <- 0
  last_away <- 0
  for (i in seq_along(home_score)) {
    if (!is.na(home_score[i])) {
      last_home <- home_score[i]
      last_away <- away_score[i]
    } else {
      home_score[i] <- last_home
      away_score[i] <- last_away
    }
  }

  score <- paste(away_score, "-", home_score)
  score_margin <- as.character(home_score - away_score)
  team_leading <- dplyr::case_when(
    home_score == away_score ~ "Tie",
    home_score > away_score ~ "Home",
    TRUE ~ "Away"
  )

  # Split description into home/neutral/visitor based on location
  location <- pbp_data$location
  description <- pbp_data$description
  home_description <- ifelse(location == "h", description, NA_character_)
  neutral_description <- ifelse(is.na(location) | location == "", description, NA_character_)
  visitor_description <- ifelse(location == "v", description, NA_character_)

  # Map event types (EVENTMSGTYPE)
  # Handle period start/end: V3 uses "period" action_type with sub_type "start"/"end"
  is_period_end <- pbp_data$action_type == "period" & pbp_data$sub_type == "end"
  event_type <- event_type_map[pbp_data$action_type]
  event_type <- ifelse(is.na(event_type), "0", unname(event_type))
  event_type[is_period_end] <- "13"

  # Map event_action_type (EVENTMSGACTIONTYPE) from sub_type per event category
  action_type_v3 <- pbp_data$action_type
  sub_type_v3 <- pbp_data$sub_type

  event_action_type <- vapply(seq_len(n), function(i) {
    at <- action_type_v3[i]
    st <- sub_type_v3[i]
    if (is.na(st) || nchar(st) == 0) {
      return("0")
    }
    result <- switch(at,
      "Made Shot" = ,
      "Missed Shot" = shot_action_map[st] %||% "0",
      "Free Throw" = ft_action_map[st] %||% "0",
      "Turnover" = to_action_map[st] %||% "0",
      "Foul" = foul_action_map[st] %||% "0",
      "Timeout" = timeout_action_map[st] %||% "0",
      "Violation" = violation_action_map[st] %||% "0",
      "Substitution" = "0",
      "Jump Ball" = "0",
      "Rebound" = "0",
      "0"
    )
    unname(result)
  }, character(1))

  # person1type: 4 = home player, 5 = away player, 0 = neutral/none
  person1type <- dplyr::case_when(
    location == "h" ~ "4",
    location == "v" ~ "5",
    TRUE ~ "0"
  )

  # Build V2-compatible data frame with retained V3 columns
  result <- dplyr::tibble(
    game_id = as.character(pbp_data$game_id),
    event_num = as.character(pbp_data$action_number),
    event_type = event_type,
    event_action_type = event_action_type,
    period = period,
    clock = pbp_data$clock,
    minute_game = minute_game,
    time_remaining = time_remaining,
    wc_time_string = NA_character_,
    time_quarter = time_quarter,
    minute_remaining_quarter = minute_remaining_quarter,
    seconds_remaining_quarter = seconds_remaining_quarter,
    action_type = pbp_data$action_type,
    sub_type = pbp_data$sub_type,
    home_description = home_description,
    neutral_description = neutral_description,
    visitor_description = visitor_description,
    description = pbp_data$description,
    location = pbp_data$location,
    score = score,
    away_score = away_score,
    home_score = home_score,
    score_margin = score_margin,
    person1type = person1type,
    # V3 person_id is already the outgoing player for subs (player1 in V2 convention)
    player1_id = as.character(pbp_data$person_id),
    player1_name = ifelse(!is.na(pbp_data$player_name), pbp_data$player_name, NA_character_),
    player1_team_id = as.character(pbp_data$team_id),
    player1_team_city = NA_character_,
    player1_team_nickname = NA_character_,
    player1_team_abbreviation = as.character(pbp_data$team_tricode),
    person2type = p2type,
    player2_id = p2_id,
    player2_name = p2_name,
    player2_team_id = p2_team_id,
    player2_team_city = p2_team_city,
    player2_team_nickname = p2_team_nickname,
    player2_team_abbreviation = p2_team_abbr,
    person3type = p3type,
    player3_id = p3_id,
    player3_name = p3_name,
    player3_team_id = p3_team_id,
    player3_team_city = p3_team_city,
    player3_team_nickname = p3_team_nickname,
    player3_team_abbreviation = p3_team_abbr,
    video_available_flag = as.character(pbp_data$video_available),
    team_leading = team_leading,
    # Retained V3 columns
    x_legacy = pbp_data$x_legacy,
    y_legacy = pbp_data$y_legacy,
    shot_distance = pbp_data$shot_distance,
    shot_result = pbp_data$shot_result,
    is_field_goal = pbp_data$is_field_goal,
    points_total = pbp_data$points_total,
    shot_value = pbp_data$shot_value,
    # Additional V3 passthrough columns for closer parity with raw/live outputs
    action_number = as.integer(pbp_data$action_number),
    team_id = as.integer(pbp_data$team_id),
    team_tricode = as.character(pbp_data$team_tricode),
    person_id = as.integer(pbp_data$person_id),
    player_name = as.character(pbp_data$player_name),
    player_name_i = as.character(pbp_data$player_name_i),
    score_home = as.character(pbp_data$score_home),
    score_away = as.character(pbp_data$score_away),
    video_available = pbp_data$video_available,
    action_id = as.integer(pbp_data$action_id)
  )

  result <- make_hoopR_data(result, "NBA Game Play-by-Play Information from NBA.com", Sys.time())
  return(result)
}


#' **Build player roster lookup from boxscore data**
#' @name .build_player_roster
NULL
#' @title
#' **Build player roster lookup from boxscore data**
#' @param game_id Game ID - 10-digit zero-padded ID
#' @return Returns a data frame with person_id, first_name, family_name, name_i,
#'   full_name, team_id, team_name, team_city, team_tricode
#' @noRd
#' @family NBA PBP Functions
.build_player_roster <- function(game_id) {
  tryCatch(
    {
      box <- nba_boxscoretraditionalv3(game_id = game_id)
      home <- box$home_team_player_traditional
      away <- box$away_team_player_traditional

      cols <- c(
        "person_id", "first_name", "family_name", "name_i",
        "team_id", "team_name", "team_city", "team_tricode"
      )

      empty_roster <- dplyr::tibble(
        person_id = character(),
        first_name = character(),
        family_name = character(),
        name_i = character(),
        team_id = character(),
        team_name = character(),
        team_city = character(),
        team_tricode = character(),
        full_name = character()
      )

      if (is.null(home) || is.null(away) ||
        !all(cols %in% colnames(home)) || !all(cols %in% colnames(away))) {
        return(empty_roster)
      }

      roster <- dplyr::bind_rows(
        home[, cols, drop = FALSE],
        away[, cols, drop = FALSE]
      )
      roster$full_name <- paste(roster$first_name, roster$family_name)
      roster$person_id <- as.character(roster$person_id)
      roster$team_id <- as.character(roster$team_id)
      roster
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Could not retrieve boxscore for player roster lookup."))
      dplyr::tibble(
        person_id = character(),
        first_name = character(),
        family_name = character(),
        name_i = character(),
        team_id = character(),
        team_name = character(),
        team_city = character(),
        team_tricode = character(),
        full_name = character()
      )
    }
  )
}


#' **Add players on court in NBA Stats API V3 play-by-play**
#' @name .players_on_court_v3
NULL
#' @title
#' **Add players on court in NBA Stats API V3 play-by-play**
#' @author Saiem Gilani
#' @param pbp_data PlayByPlay data frame (V2-formatted via `.v3_to_v2_format`)
#' @return Returns a data frame: PlayByPlay with on-court player columns
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble mutate
#' @noRd
#' @family NBA PBP Functions
.players_on_court_v3 <- function(pbp_data) {
  game_id <- pbp_data$game_id[1]
  if (inherits(game_id, "integer")) {
    game_id <- paste0("00", as.character(game_id))
  }

  # Single API call to get all player stints with exact in/out times
  rotation <- tryCatch(
    nba_gamerotation(game_id = game_id),
    error = function(e) {
      message(glue::glue("{Sys.time()}: Could not retrieve game rotation for {game_id}. On-court data will be NA."))
      NULL
    }
  )

  # Initialize player columns as NA
  for (i in 1:5) {
    pbp_data[[paste0("away_player", i)]] <- NA_real_
  }
  for (i in 1:5) {
    pbp_data[[paste0("home_player", i)]] <- NA_real_
  }

  if (is.null(rotation) || length(rotation) == 0 ||
    is.null(rotation$AwayTeam) || is.null(rotation$HomeTeam) ||
    nrow(rotation$AwayTeam) == 0 || nrow(rotation$HomeTeam) == 0) {
    return(pbp_data)
  }

  # Compute elapsed game time in tenths of a second from V2-format time columns
  # to match IN_TIME_REAL / OUT_TIME_REAL units from rotation data
  remaining_sec <- pbp_data$minute_remaining_quarter * 60 + pbp_data$seconds_remaining_quarter
  pbp_times <- ifelse(
    pbp_data$period <= 4,
    ((pbp_data$period - 1) * 720 + (720 - remaining_sec)) * 10,
    (2880 + (pbp_data$period - 5) * 300 + (300 - remaining_sec)) * 10
  )

  # Resolve on-court players for a team using rotation stint data
  # Uses interval mapping: find all unique time boundaries from stints,
  # compute the lineup at each interval midpoint, then map PBP times via findInterval
  .resolve_team_oncourt <- function(stints, times) {
    in_times <- as.numeric(stints$IN_TIME_REAL)
    out_times <- as.numeric(stints$OUT_TIME_REAL)
    person_ids <- as.numeric(stints$PERSON_ID)
    n_pbp <- length(times)

    # Get sorted unique time boundaries from all stints
    boundaries <- sort(unique(c(in_times, out_times)))
    n_bounds <- length(boundaries)

    if (n_bounds < 2) {
      active <- unique(person_ids)
      lineup <- rep(NA_real_, 5)
      n_a <- min(length(active), 5)
      if (n_a > 0) lineup[1:n_a] <- active[1:n_a]
      return(matrix(rep(lineup, each = n_pbp), nrow = n_pbp, ncol = 5))
    }

    n_intervals <- n_bounds - 1

    # Compute lineup at midpoint of each interval between boundaries
    midpoints <- (boundaries[-n_bounds] + boundaries[-1]) / 2
    lineup_mat <- matrix(NA_real_, nrow = n_intervals, ncol = 5)
    for (k in seq_len(n_intervals)) {
      mid <- midpoints[k]
      # Player is on court if stint started at or before mid and ends after mid
      active <- unique(person_ids[in_times <= mid & out_times > mid])
      n_a <- min(length(active), 5)
      if (n_a > 0) lineup_mat[k, 1:n_a] <- active[1:n_a]
    }

    # Game-end lineup: at the last boundary, use >= for out_times
    max_t <- boundaries[n_bounds]
    final_active <- unique(person_ids[in_times <= max_t & out_times >= max_t])
    final_lineup <- rep(NA_real_, 5)
    n_f <- min(length(final_active), 5)
    if (n_f > 0) final_lineup[1:n_f] <- final_active[1:n_f]

    # Append final lineup as extra row
    all_lineups <- rbind(lineup_mat, matrix(final_lineup, nrow = 1))

    # Map each PBP time to an interval index via findInterval
    # findInterval returns k where boundaries[k] <= t < boundaries[k+1]
    idx <- findInterval(times, boundaries)
    # Clamp: 0 -> 1 (before first boundary), n_bounds -> n_intervals + 1 (game end)
    idx[idx == 0L] <- 1L
    idx[idx == n_bounds] <- n_intervals + 1L
    idx <- pmin(pmax(idx, 1L), n_intervals + 1L)

    return(all_lineups[idx, , drop = FALSE])
  }

  away_mat <- .resolve_team_oncourt(rotation$AwayTeam, pbp_times)
  home_mat <- .resolve_team_oncourt(rotation$HomeTeam, pbp_times)

  for (i in 1:5) {
    pbp_data[[paste0("away_player", i)]] <- away_mat[, i]
  }
  for (i in 1:5) {
    pbp_data[[paste0("home_player", i)]] <- home_mat[, i]
  }

  # Populate player1 team city/nickname from rotation data
  away_team_id <- rotation$AwayTeam$TEAM_ID[1]
  away_team_city <- rotation$AwayTeam$TEAM_CITY[1]
  away_team_name <- rotation$AwayTeam$TEAM_NAME[1]
  home_team_id <- rotation$HomeTeam$TEAM_ID[1]
  home_team_city <- rotation$HomeTeam$TEAM_CITY[1]
  home_team_name <- rotation$HomeTeam$TEAM_NAME[1]

  is_away <- pbp_data$player1_team_id == away_team_id
  is_home <- pbp_data$player1_team_id == home_team_id
  is_away[is.na(is_away)] <- FALSE
  is_home[is.na(is_home)] <- FALSE
  pbp_data$player1_team_city[is_away] <- away_team_city
  pbp_data$player1_team_city[is_home] <- home_team_city
  pbp_data$player1_team_nickname[is_away] <- away_team_name
  pbp_data$player1_team_nickname[is_home] <- home_team_name

  return(pbp_data)
}


#' **Get NBA Stats API Play-by-Play V3**
#' @name nba_playbyplayv3
NULL
#' @title
#' **Get NBA Stats API Play-by-Play V3**
#' @rdname nba_playbyplayv3
#' @author Saiem Gilani
#' @param game_id Game ID - 10-digit zero-padded ID (e.g., '0022201086')
#' @param start_period Start period filter (default: 0 = all periods). Use 1-4 for regulation quarters, 5+ for overtime.
#' @param end_period End period filter (default: 0 = all periods). Use 1-4 for regulation quarters, 5+ for overtime.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayByPlay, AvailableVideo
#'
#'    **PlayByPlay**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |game_id          |character |
#'    |action_number    |integer   |
#'    |clock            |character |
#'    |period           |integer   |
#'    |team_id          |integer   |
#'    |team_tricode     |character |
#'    |person_id        |integer   |
#'    |player_name      |character |
#'    |player_name_i    |character |
#'    |x_legacy         |integer   |
#'    |y_legacy         |integer   |
#'    |shot_distance    |numeric   |
#'    |shot_result      |character |
#'    |is_field_goal    |integer   |
#'    |score_home       |character |
#'    |score_away       |character |
#'    |points_total     |integer   |
#'    |location         |character |
#'    |description      |character |
#'    |action_type      |character |
#'    |sub_type         |character |
#'    |video_available  |integer   |
#'    |shot_value       |integer   |
#'    |action_id        |integer   |
#'
#'    **AvailableVideo**
#'
#'
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |video_available  |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_playbyplayv3(game_id = "0022201086")
#' ```
nba_playbyplayv3 <- function(
    game_id,
    start_period = 0,
    end_period = 0,
    ...) {
  endpoint <- nba_endpoint("playbyplayv3")
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    GameID = pad_id(game_id),
    StartPeriod = start_period
  )

  data <- list() # Initialize before tryCatch

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params)

      game_data <- resp %>%
        purrr::pluck("game")

      actions <- game_data %>%
        purrr::pluck("actions") %>%
        data.frame(stringsAsFactors = FALSE) %>%
        dplyr::as_tibble()

      # Add game_id column
      actions$gameId <- game_data$gameId

      # Reorder so gameId is first
      actions <- actions %>%
        dplyr::select("gameId", dplyr::everything()) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Play-by-Play V3 Information from NBA.com", Sys.time())

      video_available <- data.frame(
        video_available = game_data$videoAvailable %||% 0L
      ) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data("NBA Game Video Available from NBA.com", Sys.time())

      data <- c(list(PlayByPlay = actions), list(AvailableVideo = video_available))
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no V3 play-by-play data for {pad_id(game_id)} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}


#' **Get NBA Stats API play-by-play**
#' @name nba_pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname nba_pbp
#' @author Jason Lee
#' @param game_id Game ID - 10-digit zero-padded ID (e.g., '0022201086')
#' @param on_court If TRUE (default), on-court player IDs are added for each play event.
#'   V3 uses `nba_gamerotation()` stint data; V2 infers lineups from substitution events.
#' @param version Play-by-play version - `"v3"` (default) or `"v2"`. V3 returns richer data
#'   with shot coordinates, shot values, and V3 action types. V2 is available from 2016-17 onwards.
#' @param p Optional progress object from `progressr` (default: NULL). Used internally by `nba_pbps()`.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |clock                     |character |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |action_type               |character |
#'    |sub_type                  |character |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |description               |character |
#'    |location                  |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |x_legacy                  |integer   |
#'    |y_legacy                  |integer   |
#'    |shot_distance             |numeric   |
#'    |shot_result               |character |
#'    |is_field_goal             |integer   |
#'    |points_total              |integer   |
#'    |shot_value                |integer   |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_pbp(game_id = '0022201086')
#'  nba_pbp(game_id = '0022201086', version = "v2")
#' ```
nba_pbp <- function(
    game_id,
    on_court = TRUE,
    version = "v3",
    p = NULL,
    ...) {
  # V3 path: use the dedicated V3 endpoint and parsing

  if (version == "v3") {
    data <- data.frame() # Initialize before tryCatch
    tryCatch(
      expr = {
        v3_result <- nba_playbyplayv3(game_id = game_id)
        data <- v3_result$PlayByPlay

        # Build player roster for name->ID resolution
        player_roster <- .build_player_roster(game_id = pad_id(game_id))

        data <- .v3_to_v2_format(data, player_roster = player_roster)

        if (on_court) {
          data <- .players_on_court_v3(data)
        }
      },
      error = function(e) {
        message(glue::glue("{Sys.time()}: Invalid arguments or no V3 play-by-play data for {pad_id(game_id)} available!"))
      },
      warning = function(w) {
      },
      finally = {
      }
    )
    return(data)
  }

  # V2/V1 path
  data <- data.frame() # Initialize before tryCatch
  if (version == "v2") {
    endpoint <- nba_endpoint("playbyplayv2")
  } else {
    endpoint <- nba_endpoint("playbyplay")
  }

  full_url <- endpoint

  params <- list(
    EndPeriod = 0,
    GameID = pad_id(game_id),
    StartPeriod = 0
  )

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp$resultSets$rowSet[[1]] %>%
        data.frame() %>%
        dplyr::as_tibble()

      json_names <- resp$resultSets$headers[[1]]
      colnames(data) <- json_names

      # Fix version 2 Dataset
      if (version == "v2") {
        data <- data %>%
          # fix column names
          janitor::clean_names() %>%
          dplyr::rename(dplyr::any_of(c(
            "wc_time_string" = "wctimestring",
            "time_quarter" = "pctimestring",
            "score_margin" = "scoremargin",
            "event_num" = "eventnum",
            "event_type" = "eventmsgtype",
            "event_action_type" = "eventmsgactiontype",
            "home_description" = "homedescription",
            "neutral_description" = "neutraldescription",
            "visitor_description" = "visitordescription"
          ))) %>%
          ## Get Team Scores
          tidyr::separate(
            "score",
            into = c("away_score", "home_score"),
            sep = "\\ - ",
            remove = FALSE
          ) %>%
          dplyr::mutate(
            home_score = as.numeric(.data$home_score),
            away_score = as.numeric(.data$away_score),
            team_leading = dplyr::case_when(
              .data$score_margin == 0 ~ "Tie",
              .data$score_margin < 0 ~ "Away",
              is.na(.data$score_margin) ~ NA_character_,
              TRUE ~ "Home"
            )
          ) %>%
          ## Time Remaining
          tidyr::separate(
            "time_quarter",
            into = c("minute_remaining_quarter", "seconds_remaining_quarter"),
            sep = "\\:",
            remove = F
          ) %>%
          dplyr::mutate(
            minute_remaining_quarter = as.numeric(.data$minute_remaining_quarter),
            seconds_remaining_quarter = as.numeric(.data$seconds_remaining_quarter),
            period = as.numeric(.data$period)
          ) %>%
          dplyr::mutate(
            minute_game = round(((.data$period - 1) * 12) + (12 - .data$minute_remaining_quarter) +
              (((
                60 - .data$seconds_remaining_quarter
              ) / 60) - 1), 2),
            time_remaining = 48 - round(((.data$period - 1) * 12) - (12 - .data$minute_remaining_quarter) -
              ((60 - .data$seconds_remaining_quarter) / 60 - 1), 2)
          ) %>%
          dplyr::select(
            "game_id":"period",
            "minute_game",
            "time_remaining",
            dplyr::everything()
          ) %>%
          make_hoopR_data("NBA Game Play-by-Play Information from NBA.com", Sys.time())

        if (on_court) {
          data <- .players_on_court(data)
        }
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {pad_id(game_id)} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}


#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @name nba_pbps
NULL
#' @title
#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @rdname nba_pbps
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param on_court IF TRUE will be added ID of players on court
#' @param version Play-by-play version ("v3" is the default, "v2" available from 2016-17 onwards)
#' @param nest_data If TRUE returns nested data by game
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |clock                     |character |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |action_type               |character |
#'    |sub_type                  |character |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |description               |character |
#'    |location                  |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |x_legacy                  |integer   |
#'    |y_legacy                  |integer   |
#'    |shot_distance             |numeric   |
#'    |shot_result               |character |
#'    |is_field_goal             |integer   |
#'    |points_total              |integer   |
#'    |shot_value                |integer   |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#' y <- c("0022201086", "0022200021")
#'
#' nba_pbps(game_ids = y)
#' nba_pbps(game_ids = y, version = "v2")
#' ```
nba_pbps <- function(
    game_ids = NULL,
    on_court = TRUE,
    version = "v3",
    nest_data = FALSE,
    ...) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  if (game_ids %>% purrr::is_null()) {
    stop("Please enter game ids")
  }


  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = game_ids)
  get_pbp_safe <- progressively(nba_pbp, p)


  all_data <-
    game_ids %>%
    purrr::map_dfr(function(game_id) {
      get_pbp_safe(game_id = game_id, on_court = on_court, ..., p = p)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(.data$game_id) %>%
      tidyr::nest()
  }

  return(all_data)
}


#' **Get NBA Stats API Live play-by-play**
#' @name nba_live_pbp
NULL
#' @title
#' **Get NBA Stats API Live play-by-play**
#' @rdname nba_live_pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |event_num                    |integer   |
#'    |clock                        |character |
#'    |time_actual                  |character |
#'    |period                       |integer   |
#'    |period_type                  |character |
#'    |action_type                  |character |
#'    |sub_type                     |character |
#'    |qualifiers                   |list      |
#'    |player1_id                   |integer   |
#'    |x                            |numeric   |
#'    |y                            |numeric   |
#'    |offense_team_id              |integer   |
#'    |home_score                   |character |
#'    |away_score                   |character |
#'    |edited                       |character |
#'    |order                        |integer   |
#'    |is_target_score_last_period  |logical   |
#'    |x_legacy                     |integer   |
#'    |y_legacy                     |integer   |
#'    |is_field_goal                |integer   |
#'    |side                         |character |
#'    |description                  |character |
#'    |person_ids_filter            |list      |
#'    |team_id                      |integer   |
#'    |team_tricode                 |character |
#'    |descriptor                   |character |
#'    |jump_ball_recovered_name     |character |
#'    |jump_ball_recoverd_person_id |integer   |
#'    |player_name                  |character |
#'    |player_name_i                |character |
#'    |jump_ball_won_player_name    |character |
#'    |jump_ball_won_person_id      |integer   |
#'    |jump_ball_lost_player_name   |character |
#'    |jump_ball_lost_person_id     |integer   |
#'    |area                         |character |
#'    |area_detail                  |character |
#'    |shot_distance                |numeric   |
#'    |shot_result                  |character |
#'    |points_total                 |integer   |
#'    |assist_player_name_initial   |character |
#'    |assist_person_id             |integer   |
#'    |assist_total                 |integer   |
#'    |shot_action_number           |integer   |
#'    |rebound_total                |integer   |
#'    |rebound_defensive_total      |integer   |
#'    |rebound_offensive_total      |integer   |
#'    |official_id                  |integer   |
#'    |foul_personal_total          |integer   |
#'    |foul_technical_total         |integer   |
#'    |foul_drawn_player_name       |character |
#'    |foul_drawn_person_id         |integer   |
#'    |block_player_name            |character |
#'    |block_person_id              |integer   |
#'    |turnover_total               |integer   |
#'    |steal_player_name            |character |
#'    |steal_person_id              |integer   |
#'    |player2_id                   |integer   |
#'    |player3_id                   |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_live_pbp(game_id = '0022201086')
#' ```
nba_live_pbp <- function(
    game_id,
    ...) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nba_live_endpoint("playbyplay")

  full_url <- paste0(
    endpoint,
    "/playbyplay_",
    pad_id(game_id),
    ".json"
  )

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game") %>%
        purrr::pluck("actions") %>%
        janitor::clean_names()

      data <- data %>%
        dplyr::rename(dplyr::any_of(c(
          "period" = "period",
          "event_num" = "action_number",
          "clock" = "clock",
          "description" = "description",
          "locX" = "xLegacy",
          "locY" = "yLegacy",
          "action_type" = "action_type",
          "sub_type" = "sub_type",
          "descriptor" = "descriptor",
          "shot_result" = "shot_result",
          "shot_action_number" = "shot_action_number",
          "qualifiers" = "qualifiers",
          "team_id" = "team_id",
          "player1_id" = "person_id",
          "home_score" = "score_home",
          "away_score" = "score_away",
          "offense_team_id" = "possession",
          "order" = "order_number"
        ))) %>%
        dplyr::mutate(
          player2_id = dplyr::case_when(
            !is.na(.data$assist_person_id) ~ .data$assist_person_id,
            TRUE ~ NA_integer_
          ),
          player3_id = dplyr::case_when(
            !is.na(.data$block_person_id) ~ .data$block_person_id,
            !is.na(.data$steal_person_id) ~ .data$steal_person_id,
            !is.na(.data$foul_drawn_person_id) ~ .data$foul_drawn_person_id,
            TRUE ~ NA_integer_
          )
        ) %>%
        make_hoopR_data("NBA Game Play-by-Play Information from NBA.com", Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}



#' **Get NBA Stats API Live Boxscore**
#' @name nba_live_boxscore
NULL
#' @title
#' **Get NBA Stats API Live Boxscore**
#' @rdname nba_live_boxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: game_details, arena, officials, home_team_boxscore,
#' away_team_boxscore, home_team_player_boxscore, away_team_player_boxscore, home_team_linescores,
#' away_team_linescores
#'
#'    **game_details**
#'
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |game_id                      |character |
#'    |game_time_local              |character |
#'    |game_time_utc                |character |
#'    |game_time_home               |character |
#'    |game_time_away               |character |
#'    |game_et                      |character |
#'    |duration                     |integer   |
#'    |game_code                    |character |
#'    |game_status_text             |character |
#'    |game_status                  |integer   |
#'    |regulation_periods           |integer   |
#'    |period                       |integer   |
#'    |game_clock                   |character |
#'    |attendance                   |integer   |
#'    |sellout                      |character |
#'    |home_team_id                 |integer   |
#'    |home_team_name               |character |
#'    |home_team_city               |character |
#'    |home_team_tricode            |character |
#'    |home_team_score              |integer   |
#'    |home_team_in_bonus           |character |
#'    |home_team_timeouts_remaining |integer   |
#'    |away_team_id                 |integer   |
#'    |away_team_name               |character |
#'    |away_team_city               |character |
#'    |away_team_tricode            |character |
#'    |away_team_score              |integer   |
#'    |away_team_in_bonus           |character |
#'    |away_team_timeouts_remaining |integer   |
#'
#'    **arena**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |arena_id       |integer   |
#'    |arena_name     |character |
#'    |arena_city     |character |
#'    |arena_state    |character |
#'    |arena_country  |character |
#'    |arena_timezone |character |
#'
#'    **officials**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |person_id   |integer   |
#'    |name        |character |
#'    |name_i      |character |
#'    |first_name  |character |
#'    |family_name |character |
#'    |jersey_num  |character |
#'    |assignment  |character |
#'
#'    **home_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **away_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **home_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **away_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **home_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
#'
#'    **away_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_live_boxscore(game_id = "0022201086")
#' ```
nba_live_boxscore <- function(
    game_id,
    ...) {
  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nba_live_endpoint("boxscore")

  full_url <- paste0(
    endpoint,
    "/boxscore_",
    pad_id(game_id),
    ".json"
  )

  df_list <- list()

  tryCatch(
    expr = {
      res <- .retry_request(full_url)

      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game")

      game_details <- data.frame(
        game_id = data %>% purrr::pluck("gameId"),
        game_time_local = data %>% purrr::pluck("gameTimeLocal"),
        game_time_utc = data %>% purrr::pluck("gameTimeUTC"),
        game_time_home = data %>% purrr::pluck("gameTimeHome"),
        game_time_away = data %>% purrr::pluck("gameTimeAway"),
        game_et = data %>% purrr::pluck("gameEt"),
        duration = data %>% purrr::pluck("duration"),
        game_code = data %>% purrr::pluck("gameCode"),
        game_status_text = data %>% purrr::pluck("gameStatusText"),
        game_status = data %>% purrr::pluck("gameStatus"),
        regulation_periods = data %>% purrr::pluck("regulationPeriods"),
        period = data %>% purrr::pluck("period"),
        game_clock = data %>% purrr::pluck("gameClock"),
        attendance = data %>% purrr::pluck("attendance"),
        sellout = data %>% purrr::pluck("sellout")
      )

      arena <- data %>%
        purrr::pluck("arena") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Arena Information from NBA.com", Sys.time())

      officials <- data %>%
        purrr::pluck("officials") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Officials Information from NBA.com", Sys.time())

      if ("homeTeam" %in% names(data)) {
        home_team <- data %>%
          purrr::pluck("homeTeam")

        home_team_info <- data.frame(
          team_id = home_team %>% purrr::pluck("teamId"),
          team_name = home_team %>% purrr::pluck("teamName"),
          team_city = home_team %>% purrr::pluck("teamCity"),
          team_tricode = home_team %>% purrr::pluck("teamTricode"),
          team_score = home_team %>% purrr::pluck("score"),
          team_in_bonus = home_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = home_team %>% purrr::pluck("timeoutsRemaining")
        )

        home_team_box <- home_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        home_team_linescores <- home_team$periods %>%
          janitor::clean_names()

        home_team_players <- home_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        home_team_player_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Player Boxscore Information from NBA.com", Sys.time())

        home_team_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())
      }

      if ("awayTeam" %in% names(data)) {
        away_team <- data %>%
          purrr::pluck("awayTeam")

        away_team_info <- data.frame(
          team_id = away_team %>% purrr::pluck("teamId"),
          team_name = away_team %>% purrr::pluck("teamName"),
          team_city = away_team %>% purrr::pluck("teamCity"),
          team_tricode = away_team %>% purrr::pluck("teamTricode"),
          team_score = away_team %>% purrr::pluck("score"),
          team_in_bonus = away_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = away_team %>% purrr::pluck("timeoutsRemaining")
        )

        away_team_box <- away_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        away_team_linescores <- away_team$periods %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Linescore Information from NBA.com", Sys.time())

        away_team_players <- away_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        away_team_player_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Player Boxscore Information from NBA.com", Sys.time())

        away_team_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())
      }

      colnames(home_team_info) <- paste0("home_", colnames(home_team_info))
      colnames(away_team_info) <- paste0("away_", colnames(away_team_info))

      game_details <- game_details %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(away_team_info) %>%
        make_hoopR_data("NBA Game Linescore Information from NBA.com", Sys.time())

      df_list <- c(
        list(game_details),
        list(arena),
        list(officials),
        list(home_team_boxscore),
        list(away_team_boxscore),
        list(home_team_player_boxscore),
        list(away_team_player_boxscore),
        list(home_team_linescores),
        list(away_team_linescores)
      )

      names(df_list) <- c(
        "game_details",
        "arena",
        "officials",
        "home_team_boxscore",
        "away_team_boxscore",
        "home_team_player_boxscore",
        "away_team_player_boxscore",
        "home_team_linescores",
        "away_team_linescores"
      )
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no boxscore data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
