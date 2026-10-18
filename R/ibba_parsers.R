# ibba_parsers.R -- the IBBA frames (R mirror of sdv-py ibba_parsers.py and ibba_segev_parsers.py).
#
# ASMX (`ibba_*`): every value on the wire is a STRING; columns are pinned per route by the
# token specs below (ported verbatim): `wire[>out]:kind`, kinds i id / count (integer), n id
# with 0 = none, f double, s text (HTML-unescaped, "" -> NA), b boolean ('True' / '1'), d
# dd/mm/yyyy date. Ids are integers cast once from digit strings (a non-digit string is NA,
# never a float). `out` defaults to the rename table or sdv-py's `underscore()` of the wire name.
#
# Segev (`ibba_segev_*`): ids are strings in the header and box score but integers in the
# actions; all are cast to integer. Text is NOT unescaped there (sdv-py does not).

#' Wire name -> output name for the names the host spells badly or inconsistently.
#' @noRd
.IBBA_RENAME <- c(
  jersy = "jersey", p21 = "fg2m", p22 = "fg2a", p2 = "fg2_pct", p31 = "fg3m", p32 = "fg3a",
  p3 = "fg3_pct", p11 = "ftm", p12 = "fta", p1 = "ft_pct", defensive_reb = "dreb",
  offensive_reb = "oreb", total_reb = "reb", fouls_against = "fouls_drawn", fouls_for = "fouls",
  tournovers = "turnovers", blocks_for = "blocks", block_against = "blocks_against", VAL = "val",
  plusminus = "plus_minus", dunk = "dunks", year_id = "season", team_year_id = "team_id",
  TeamUID = "team_uid", player_year_id = "player_id", BOARD_ID = "board_id", board = "board_id"
)

.IBBA_STAT <- paste(
  "minutes:K pts:K p21:K p22:K p2:f p31:K p32:K p3:f p11:K p12:K p1:f defensive_reb:K offensive_reb:K",
  "total_reb:K fouls_against:K fouls_for:K steals:K tournovers:K assists:K blocks_for:K block_against:K",
  "VAL:K plusminus:K dunk:K"
)

#' route -> (body key, token spec).
#' @noRd
.IBBA_ROUTES <- list(
  configuration = c("settings", paste(
    "Current_Year>season:i Current_Year_Full>season_label:s red_line:i ActiveComp>active_board_id:i",
    "nextGN>next_round:i TotalGN>total_rounds:i"
  )),
  boards = c("boards", "BOARD_ID:i year_id:i h_type>board_name_he:s type>board_title_he:s category_name>category_he:s"),
  boards_ex = c("boards-ex", "ig_board>board_id:i o_comp_name>board_name_he:s"),
  teams = c("teams", paste(
    "TeamUID:i team_year_id:i year_id:i team>team_name_he:s team_shortName>team_short_name_he:s",
    "teamEng>team_name:s team_shortNameEng>team_short_name:s board:i place:i games:i win>wins:i lose>losses:i",
    "team_scores>points_for:i rival_scores>points_against:i points>table_points:i team_icon2>logo_url:s",
    "team_pic>photo_path:s team_address>address_he:s team_sponsers>sponsors_he:s",
    "team_social_link>facebook_url:s team_twitter>twitter_url:s team_insta>instagram_url:s",
    "team_youtube>youtube_url:s ticket_link>ticket_url:s team_subscribe_url>subscribe_url:s COACHES>coaches_he:s"
  )),
  team = c("team", paste(
    "TeamUID:i team_year_id:i year_id:i team>team_name_he:s team_shortName>team_short_name_he:s",
    "teamEng>team_name:s team_shortNameEng>team_short_name:s win>wins:i lose>losses:i",
    "team_scores>points_for:i rival_scores>points_against:i points>table_points:i place:i",
    "team_site>website_url:s team_pic>photo_path:s team_icon>icon_path:s team_icon2>logo_url:s",
    "team_icon3>icon3_path:s team_arena_id>arena_id:i team_address>address_he:s team_addressEng>address:s",
    "team_color>colors_he:s team_colorEng>colors:s team_sponsers>sponsors_he:s team_sponsersEng>sponsors:s",
    "team_About>about_he:s team_AboutEng>about:s team_social_link>facebook_url:s team_twitter>twitter_url:s",
    "team_insta>instagram_url:s team_youtube>youtube_url:s team_subscribe_url>subscribe_url:s",
    "addDiaryCode>diary_url:s"
  )),
  players = c("players", paste(
    "player_id:i jersy:s year_id:i team_id:i name>player_name_he:s name_eng>player_name:s",
    "isReplaced>is_replaced:b isLocal>is_local:b pic>photo_path:s Height>height_m:f position>position_he:s",
    "position_eng>position:s birth_date:d"
  )),
  player = c("player", paste(
    "player_id:i jersy:s year_id:i team_id:i name>player_name_he:s name_eng>player_name:s",
    "isReplaced>is_replaced:b isLocal>is_local:b pic>photo_path:s"
  )),
  coaches = c("coaches", paste(
    "coach_id:i cType>coach_type:i year_id:i team_id:i name>coach_name_he:s name_eng>coach_name:s",
    "isReplaced>is_replaced:b pic>photo_path:s mOrder>sort_order:i"
  )),
  box_score = c("boxscore", paste(
    "player_year_id:n jersy:s team_id:i game_id:i board:i year_id:i round:i starter:b",
    gsub(":K", ":i", .IBBA_STAT, fixed = TRUE)
  )),
  player_stats = c("player", paste("player_id:i jersy:s year_id:i team_id:i games:i",
                                   gsub(":K", ":f", .IBBA_STAT, fixed = TRUE))),
  stats_types = c("statsTypes", "stat_type_field>stat_type:s stat_type_name>stat_name_he:s"),
  leaders = c("leaders", paste(
    "DATA>value:f GP>games:i Year>season:i team_id:i player_number>jersey:s player_year_id>player_id:i",
    "player_name>player_name_he:s pic>photo_path:s"
  )),
  team_stats = c("team-stats", paste("year_id:i team_id:i games:i", gsub(":K", ":f", .IBBA_STAT, fixed = TRUE))),
  games = c("games", paste(
    "game_id:i game_date_txt>game_date:d year_id:i team1>home_team_id:i team2>away_team_id:i",
    "team1_name>home_team_he:s team2_name>away_team_he:s team1_name_eng>home_team:s team2_name_eng>away_team:s",
    "team1_logo>home_logo_url:s team2_logo>away_logo_url:s score_team1>home_score:i score_team2>away_score:i",
    "BOARD_ID:i board_name>board_name_he:s board_name_eng>board_name:s gameNumber>round:i TimeOfGame>tip_off:s",
    "PlaceOfGameHeb>venue_he:s PlaceOfGame>venue:s Ref>referees_he:s total_viewers>attendance:i",
    "overtime:b total_ot>overtimes:i score_by_q_1>home_score_by_period:s score_by_q_2>away_score_by_period:s",
    "tickets_url:s ExternalID>external_id:s"
  )),
  games_ex = c("games_ex", paste(
    "game_id:i ig_date>game_date:d year_id:i ig_team_1>home_team_id:i ig_team_2>away_team_id:i",
    "team1_name>home_team_he:s team2_name>away_team_he:s team1_logo>home_logo_url:s",
    "team2_logo>away_logo_url:s ig_score_team_1>home_score:i ig_score_team_2>away_score:i BOARD_ID:i",
    "board_name>board_name_he:s ig_gn>round:i ig_time>tip_off:s ig_place>venue_he:s"
  ))
)
.IBBA_ROUTES$games_by_team <- c("games", .IBBA_ROUTES$games[[2]])

.IBBA_KIND_TYPE <- c(i = "integer", n = "integer", f = "double", s = "character", b = "logical", d = "Date")

#' Columns a parser derives (after the wire columns).
#' @noRd
.IBBA_DERIVED <- list(
  box_score = c(row_type = "character"),
  games = c(segev_game_id = "integer", is_external = "logical"),
  games_by_team = c(segev_game_id = "integer", is_external = "logical")
)

#' A token spec as a data frame of wire name, output name, kind.
#' @noRd
.ibba_tokens <- function(spec) {
  tok <- strsplit(spec, " +")[[1]]
  kind <- sub("^.*:", "", tok)
  head <- sub(":[^:]*$", "", tok)
  wire <- sub(">.*$", "", head)
  out <- ifelse(grepl(">", head, fixed = TRUE), sub("^[^>]*>", "", head), NA_character_)
  ren <- unname(.IBBA_RENAME[wire])
  out <- ifelse(is.na(out), ifelse(is.na(ren), .intl_clean_names(wire), ren), out)
  data.frame(wire = wire, name = out, kind = kind, stringsAsFactors = FALSE)
}

#' Each ASMX route's columns and R types (name -> type).
#' @noRd
.ibba_spec <- function(short) {
  tk <- .ibba_tokens(.IBBA_ROUTES[[short]][[2]])
  c(stats::setNames(unname(.IBBA_KIND_TYPE[tk$kind]), tk$name), .IBBA_DERIVED[[short]])
}

# ---------------------------------------------------------------------------
# Cells
# ---------------------------------------------------------------------------

#' Python `str()` of each JSON scalar; `NA` for null, an object or an array.
#' @noRd
.ibba_pystr <- function(vals) {
  vapply(vals, function(v) {
    if (is.null(v) || is.list(v) || length(v) != 1L || is.na(v)) return(NA_character_)
    if (is.logical(v)) return(if (v) "True" else "False")
    if (is.double(v)) return(if (is.finite(v) && v == trunc(v)) sprintf("%.1f", v) else as.character(v))
    as.character(v)
  }, character(1), USE.NAMES = FALSE)
}

#' Python `str.strip()` (Unicode whitespace, so a no-break space too).
#' @noRd
.ibba_strip <- function(x) gsub("(*UCP)^\\s+|\\s+$", "", x, perl = TRUE)

#' Python `html.unescape()` of each string (libxml2 decodes the entities; a literal `<` is kept).
#' @noRd
.ibba_unescape <- function(x) {
  amp <- !is.na(x) & grepl("&", x, fixed = TRUE)
  if (!any(amp)) return(x)
  ps <- paste0("<p>", gsub("<", "&lt;", x[amp], fixed = TRUE), "</p>", collapse = "")
  doc <- rvest::read_html(paste0("<html><body>", ps, "</body></html>"), encoding = "UTF-8")
  x[amp] <- rvest::html_text(rvest::html_elements(doc, "body > p"))
  x
}

#' ASMX text cells: unescaped, stripped, "" -> NA (sdv-py `_text`).
#' @noRd
.ibba_text <- function(vals) {
  s <- .ibba_strip(.ibba_unescape(.ibba_pystr(vals)))
  s[!is.na(s) & !nzchar(s)] <- NA_character_
  s
}

#' Digit strings -> integer (anything else NA).
#' @noRd
.ibba_int_chr <- function(s) {
  ok <- !is.na(s) & grepl("^-?[0-9]+$", s)
  out <- rep(NA_integer_, length(s))
  out[ok] <- suppressWarnings(as.integer(s[ok]))
  out
}

#' Strings -> double, a decimal comma accepted (anything else NA).
#' @noRd
.ibba_dbl_chr <- function(s) {
  ok <- !is.na(s) & grepl("^[+-]?([0-9]+\\.?[0-9]*|\\.[0-9]+)([eE][+-]?[0-9]+)?$", gsub(",", ".", s, fixed = TRUE))
  out <- rep(NA_real_, length(s))
  out[ok] <- as.numeric(gsub(",", ".", s[ok], fixed = TRUE))
  out
}

#' One ASMX cell kind over a column of text cells.
#' @noRd
.ibba_convert <- function(s, kind) {
  switch(kind,
    i = .ibba_int_chr(s),
    n = {
      v <- .ibba_int_chr(s)
      v[!is.na(v) & v == 0L] <- NA_integer_ # 0 = "no player" on the _TEAM and TOTAL rows
      v
    },
    f = .ibba_dbl_chr(s),
    s = s,
    b = {
      l <- tolower(ifelse(is.na(s), "", s))
      ifelse(l %in% c("true", "1"), TRUE, ifelse(l %in% c("false", "0"), FALSE, NA))
    },
    d = {
      ok <- !is.na(s) & grepl("^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$", s)
      out <- as.Date(rep(NA_character_, length(s)))
      out[ok] <- as.Date(s[ok], format = "%d/%m/%Y")
      out
    }
  )
}

#' A `hoopR_data` tibble from named column vectors.
#' @noRd
.ibba_out <- function(cols, what) {
  make_hoopR_data(dplyr::as_tibble(cols), paste0("IBBA ", what), Sys.time())
}

#' Parse ASMX rows into the route's frame (sdv-py `_parse`).
#' @noRd
.ibba_parse <- function(short, rows) {
  tk <- .ibba_tokens(.IBBA_ROUTES[[short]][[2]])
  cols <- list()
  for (k in seq_len(nrow(tk))) {
    wire <- tk$wire[[k]]
    cells <- lapply(rows, function(r) r[[wire]])
    cols[[tk$name[[k]]]] <- .ibba_convert(.ibba_text(cells), tk$kind[[k]])
  }
  if (short == "box_score") {
    j <- cols$jersey
    cols$row_type <- rep("player", length(j))
    cols$row_type[j %in% "_TEAM"] <- "team"
    cols$row_type[j %in% "TOTAL"] <- "total"
  } else if (short %in% c("games", "games_by_team")) {
    ext <- cols$external_id
    cols$segev_game_id <- .ibba_int_chr(ifelse(!is.na(ext) & grepl("^[0-9]+$", ext), ext, NA_character_))
    cols$is_external <- cols$board_id >= 1001L
  }
  .ibba_out(cols, gsub("_", " ", short))
}

# ---------------------------------------------------------------------------
# Segev cells (sdv-py ibba_segev_parsers `_s`, `_i`, `_nz`, `_f`, `_b`)
# ---------------------------------------------------------------------------

#' @noRd
.ibba_s1 <- function(v) {
  s <- .ibba_strip(.ibba_pystr(list(v)))
  if (is.na(s) || !nzchar(s)) NA_character_ else s
}

#' @noRd
.ibba_i1 <- function(v) {
  if (is.logical(v) || is.double(v)) return(NA_integer_) # a JSON bool, or a float (never an integer id)
  if (is.integer(v) && length(v) == 1L) return(v)
  .ibba_int_chr(.ibba_s1(v))
}

#' @noRd
.ibba_nz1 <- function(v) {
  i <- .ibba_i1(v)
  if (!is.na(i) && i == 0L) NA_integer_ else i
}

#' @noRd
.ibba_f1 <- function(v) {
  if (is.logical(v)) return(NA_real_)
  if (is.numeric(v) && length(v) == 1L) return(as.double(v))
  .ibba_dbl_chr(.ibba_s1(v))
}

#' @noRd
.ibba_b1 <- function(v) if (is.logical(v) && length(v) == 1L) v else NA

#' Apply a scalar cell reader over a list of objects' `key`.
#' @noRd
.ibba_col <- function(objs, key, f, type) vapply(objs, function(o) f(o[[key]]), type, USE.NAMES = FALSE)

#' `'mm:ss'` -> seconds.
#' @noRd
.ibba_seconds <- function(s) {
  m <- regmatches(s, regexec("^([0-9]+):([0-9]{2})$", s))
  vapply(m, function(x) if (length(x) == 3L) as.integer(x[2]) * 60L + as.integer(x[3]) else NA_integer_,
         integer(1))
}

#' Naive ISO date-times (Israel local time) -> POSIXct in Asia/Jerusalem.
#' @noRd
.ibba_when <- function(s) {
  ok <- !is.na(s) & grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}([T ][0-9]{2}:[0-9]{2}(:[0-9]{2}(\\.[0-9]+)?)?)?$", s)
  x <- sub("T", " ", s, fixed = TRUE)
  x <- ifelse(grepl("^[0-9-]+ [0-9]{2}:[0-9]{2}$", x), paste0(x, ":00"), x)
  x <- ifelse(grepl("^[0-9-]+$", x), paste0(x, " 00:00:00"), x)
  out <- as.POSIXct(rep(NA_character_, length(s)), tz = "Asia/Jerusalem")
  if (any(ok)) out[ok] <- as.POSIXct(x[ok], format = "%Y-%m-%d %H:%M:%OS", tz = "Asia/Jerusalem")
  out
}

#' The `result` block, the box score, its header, and the getGameInfo / getActions header.
#' @noRd
.ibba_result <- function(raw) .ibba_dict(if (.ibba_is_dict(raw)) raw[["result"]])
#' @noRd
.ibba_box <- function(raw) .ibba_dict(.ibba_result(raw)[["boxscore"]])
#' @noRd
.ibba_box_info <- function(raw) .ibba_dict(.ibba_box(raw)[["gameInfo"]])
#' @noRd
.ibba_header <- function(raw) .ibba_dict(.ibba_result(raw)[["gameInfo"]])

#' The header's game id: `id`, else `gameId`.
#' @noRd
.ibba_header_gid <- function(g) {
  i <- .ibba_i1(g[["id"]])
  if (is.na(i)) .ibba_i1(g[["gameId"]]) else i
}

#' @noRd
.ibba_segev_game_info_frame <- function(raw) {
  g <- .ibba_header(raw)
  n <- if (length(g)) 1L else 0L
  one <- function(x) x[seq_len(n)]
  home <- .ibba_dict(g[["homeTeam"]])
  away <- .ibba_dict(g[["awayTeam"]])
  q <- .ibba_dict(g[["currentQuarterTime"]])
  m <- .ibba_i1(q[["m"]])
  sec <- .ibba_i1(q[["s"]])
  comp <- .ibba_dict(g[["competition"]])
  .ibba_out(list(
    game_id = one(.ibba_header_gid(g)),
    start_time = .ibba_when(one(.ibba_s1(g[["time"]]))),
    competition = one(.ibba_s1(comp[["name"]])),
    home_team_id = one(.ibba_i1(home[["id"]])),
    home_team = one(.ibba_s1(home[["name"]])),
    home_team_local = one(.ibba_s1(home[["nameLocal"]])),
    home_short_name = one(.ibba_s1(home[["shortName"]])),
    away_team_id = one(.ibba_i1(away[["id"]])),
    away_team = one(.ibba_s1(away[["name"]])),
    away_team_local = one(.ibba_s1(away[["nameLocal"]])),
    away_short_name = one(.ibba_s1(away[["shortName"]])),
    periods = one(.ibba_i1(g[["numberOfQuarters"]])),
    finished = one(.ibba_b1(g[["gameFinished"]])),
    current_period = one(.ibba_i1(g[["currentQuarter"]])),
    clock = one(if (is.na(m) || is.na(sec)) NA_character_ else sprintf("%02d:%02d", m, sec))
  ), "Segev game info")
}

#' @noRd
.ibba_segev_rosters_frame <- function(raw) {
  g <- .ibba_header(raw)
  gid <- .ibba_header_gid(g)
  parts <- lapply(c("home", "away"), function(side) {
    team <- .ibba_dict(g[[paste0(side, "Team")]])
    ps <- .ibba_dicts(team[["players"]])
    n <- length(ps)
    list(
      game_id = rep(gid, n), team_side = rep(side, n), team_id = rep(.ibba_i1(team[["id"]]), n),
      player_id = .ibba_col(ps, "id", .ibba_i1, integer(1)),
      jersey_number = .ibba_col(ps, "jerseyNumber", .ibba_i1, integer(1)),
      first_name = .ibba_col(ps, "firstName", .ibba_s1, character(1)),
      last_name = .ibba_col(ps, "lastName", .ibba_s1, character(1)),
      first_name_local = .ibba_col(ps, "firstNameLocal", .ibba_s1, character(1)),
      last_name_local = .ibba_col(ps, "lastNameLocal", .ibba_s1, character(1)),
      in_roster = .ibba_col(ps, "inRoster", .ibba_i1, integer(1)),
      api_id = .ibba_col(ps, "apiId", .ibba_i1, integer(1))
    )
  })
  .ibba_out(.ibba_bind(parts), "Segev rosters")
}

#' Concatenate lists of equal-named column vectors.
#' @noRd
.ibba_bind <- function(parts) {
  nm <- names(parts[[1]])
  stats::setNames(lapply(nm, function(n) do.call(c, lapply(parts, `[[`, n))), nm)
}

#' wire key -> output name for the counting stats of player lines, team lines and totals.
#' @noRd
.IBBA_COUNT_KEYS <- c(
  fg_2m = "fg2m", fg_2mis = "fg2_missed", fg_3m = "fg3m", fg_3mis = "fg3_missed", ft_m = "ftm",
  ft_mis = "ft_missed", reb_d = "dreb", reb_o = "oreb", f = "fouls", f_drawn = "fouls_drawn",
  stl = "steals", to = "turnovers", ast = "assists", blk = "blocks", blk_against = "blocks_against",
  fb = "fast_break_pts", sc = "second_chance_pts", points = "pts", rate = "val", dfl = "deflections",
  rec = "recoveries", dunk = "dunks", fd_off = "offensive_fouls_drawn", and_one = "and_ones"
)

#' The counting stats of a list of stat objects, with fg2a / fg3a / fta = made + missed.
#' @noRd
.ibba_counts <- function(objs) {
  out <- lapply(names(.IBBA_COUNT_KEYS), function(k) .ibba_col(objs, k, .ibba_i1, integer(1)))
  names(out) <- unname(.IBBA_COUNT_KEYS)
  out$vps <- .ibba_col(objs, "vps", .ibba_f1, double(1))
  out$fg2a <- out$fg2m + out$fg2_missed
  out$fg3a <- out$fg3m + out$fg3_missed
  out$fta <- out$ftm + out$ft_missed
  out
}

#' @noRd
.ibba_segev_player_box_frame <- function(raw) {
  box <- .ibba_box(raw)
  info <- .ibba_box_info(raw)
  gid <- .ibba_i1(info[["gameId"]])
  parts <- list()
  for (side in c("home", "away")) {
    team <- box[[paste0(side, "Team")]]
    if (!.ibba_is_dict(team)) next
    tid <- .ibba_i1(info[[paste0(side, "TeamId")]])
    ps <- .ibba_dicts(team[["players"]])
    n <- length(ps)
    parts[[length(parts) + 1L]] <- c(list(
      game_id = rep(gid, n), team_side = rep(side, n), team_id = rep(tid, n), row_type = rep("player", n),
      player_id = .ibba_col(ps, "playerId", .ibba_i1, integer(1)),
      jersey_number = .ibba_col(ps, "jerseyNumber", .ibba_i1, integer(1)),
      starter = .ibba_col(ps, "starter", .ibba_b1, logical(1)),
      on_court = .ibba_col(ps, "onCourt", .ibba_b1, logical(1)),
      minutes = .ibba_col(ps, "minutes", .ibba_s1, character(1)),
      seconds_played = .ibba_seconds(.ibba_col(ps, "minutes", .ibba_s1, character(1))),
      plus_minus = .ibba_col(ps, "plusMinus", .ibba_i1, integer(1))
    ), .ibba_counts(ps))
    ta <- team[["teamActions"]]
    if (.ibba_is_dict(ta)) {
      parts[[length(parts) + 1L]] <- c(list(
        game_id = gid, team_side = side, team_id = tid, row_type = "team", player_id = NA_integer_,
        jersey_number = NA_integer_, starter = NA, on_court = NA, minutes = NA_character_,
        seconds_played = NA_integer_, plus_minus = NA_integer_
      ), .ibba_counts(list(ta)))
    }
  }
  if (!length(parts)) parts <- list(c(list(
    game_id = integer(), team_side = character(), team_id = integer(), row_type = character(),
    player_id = integer(), jersey_number = integer(), starter = logical(), on_court = logical(),
    minutes = character(), seconds_played = integer(), plus_minus = integer()
  ), .ibba_counts(list())))
  .ibba_out(.ibba_bind(parts), "Segev player box")
}

#' gameStats keys by feed era (2025-26 first, 2026-27 second) -> output column.
#' @noRd
.IBBA_GAME_STAT_KEYS <- list(
  pts_from_turnovers = c("Points_from_turnovers", "Pts_From_Turnovers"),
  pts_in_paint = c("Points_in_the_paint", "Pts_In_The_Paint"),
  starting_points = c("starting_points", "starting_points"),
  bench_points = c("bench_points", "bench_points")
)

#' The first of `keys` whose value is not null.
#' @noRd
.ibba_first <- function(d, keys) {
  for (k in keys) if (!is.null(d[[k]])) return(d[[k]])
  NULL
}

#' @noRd
.ibba_segev_team_box_frame <- function(raw) {
  box <- .ibba_box(raw)
  info <- .ibba_box_info(raw)
  gid <- .ibba_i1(info[["gameId"]])
  parts <- list()
  sides <- character()
  for (side in c("home", "away")) {
    team <- box[[paste0(side, "Team")]]
    total <- if (.ibba_is_dict(team)) team[["teamActionsTotal"]] else NULL
    if (!.ibba_is_dict(total)) next
    stats <- .ibba_dict(info[[paste0(side, "GameStats")]])
    fb <- .ibba_s1(.ibba_first(stats, c("Pts_of_total_FBs", "Pts_Of_Total_FB_Possessions")))
    m <- regmatches(fb, regexec("^[0-9]+ of ([0-9]+)$", fb))[[1]]
    row <- c(list(
      game_id = gid, team_side = side, team_id = .ibba_i1(info[[paste0(side, "TeamId")]]),
      score = .ibba_i1(info[[paste0(side, "Score")]]), timeouts = .ibba_i1(info[[paste0(side, "TimeOut")]]),
      time_leading = .ibba_s1(total[["TimeLeading"]]), biggest_lead = .ibba_i1(total[["BLead"]]),
      times_tied = .ibba_i1(total[["TimesTied"]]), lead_changes = .ibba_i1(total[["LeadChange"]])
    ), .ibba_counts(list(total)))
    for (name in names(.IBBA_GAME_STAT_KEYS)) row[[name]] <- .ibba_i1(.ibba_first(stats, .IBBA_GAME_STAT_KEYS[[name]]))
    row$fast_break_possessions <- if (length(m) == 2L) suppressWarnings(as.integer(m[2])) else NA_integer_
    row$defensive_stops <- .ibba_i1(stats[["Defensive_Stops"]])
    row$biggest_scoring_run <- .ibba_s1(stats[["Biggest_Scoring_Run"]])
    parts[[length(parts) + 1L]] <- row
  }
  types <- .IBBA_SEGEV_SPECS$team_box
  if (!length(parts)) return(.ibba_out(as.list(.empty_tibble(types)), "Segev team box"))
  .ibba_out(.ibba_bind(parts)[names(types)], "Segev team box")
}

#' @noRd
.ibba_segev_period_scores_frame <- function(raw) {
  info <- .ibba_box_info(raw)
  gid <- .ibba_i1(info[["gameId"]])
  last <- .ibba_i1(info[["currentQuarter"]])
  n <- if (is.na(last) || last < 1L) 0L else last
  at <- function(key) {
    seq <- info[[key]]
    if (!is.list(seq) || !is.null(names(seq))) seq <- list()
    vapply(seq_len(n), function(k) if (k <= length(seq)) .ibba_i1(seq[[k]]) else NA_integer_, integer(1))
  }
  .ibba_out(list(
    game_id = rep(gid, n), period = seq_len(n),
    home_points = at("homeQuarterScores"), away_points = at("awayQuarterScores"),
    home_fouls = at("homeQuarterFouls"), away_fouls = at("awayQuarterFouls")
  ), "Segev period scores")
}

#' @noRd
.ibba_segev_pbp_frame <- function(raw) {
  g <- .ibba_header(raw)
  gid <- .ibba_header_gid(g)
  acts <- .ibba_dicts(.ibba_result(raw)[["actions"]])
  p <- lapply(acts, function(a) .ibba_dict(a[["parameters"]]))
  score <- regmatches(.ibba_col(acts, "score", .ibba_s1, character(1)),
                      regexec("^([0-9]+)-([0-9]+)$", .ibba_col(acts, "score", .ibba_s1, character(1))))
  sc <- function(k) vapply(score, function(x) if (length(x) == 3L) suppressWarnings(as.integer(x[k])) else NA_integer_,
                           integer(1))
  side <- .ibba_col(p, "team", .ibba_i1, integer(1))
  is_foul <- vapply(acts, function(a) identical(a[["type"]], "foul"), logical(1))
  coach <- .ibba_col(p, "isCoachFoul", .ibba_i1, integer(1))
  cols <- list(
    game_id = rep(gid, length(acts)),
    action_id = .ibba_col(acts, "id", .ibba_i1, integer(1)),
    parent_action_id = .ibba_col(acts, "parentActionId", .ibba_nz1, integer(1)),
    period = .ibba_col(acts, "quarter", .ibba_i1, integer(1)),
    clock = .ibba_col(acts, "quarterTime", .ibba_s1, character(1)),
    user_time_utc = .ibba_col(acts, "userTime", .ibba_s1, character(1)),
    type = .ibba_col(acts, "type", .ibba_s1, character(1)),
    subtype = .ibba_col(p, "type", .ibba_s1, character(1)),
    team_id = .ibba_col(acts, "teamId", .ibba_nz1, integer(1)),
    player_id = .ibba_col(acts, "playerId", .ibba_nz1, integer(1)),
    team_side = ifelse(!is.na(side) & side == 1L, "home", ifelse(!is.na(side) & side == 2L, "away", NA_character_)),
    jersey = .ibba_col(p, "player", .ibba_s1, character(1)),
    score_away = sc(2L),
    score_home = sc(3L),
    player_points = .ibba_col(acts, "totalPlayerPoints", .ibba_i1, integer(1)),
    points = .ibba_col(p, "points", .ibba_i1, integer(1)),
    made = .ibba_col(p, "made", .ibba_s1, character(1)),
    x = .ibba_col(p, "coordX", .ibba_f1, double(1)),
    y = .ibba_col(p, "coordY", .ibba_f1, double(1)),
    fast_break = .ibba_col(p, "fastBreak", .ibba_b1, logical(1)),
    second_chance = .ibba_col(p, "secondChancePoints", .ibba_b1, logical(1)),
    points_from_turnover = .ibba_col(p, "pointsFromTurnover", .ibba_b1, logical(1)),
    free_throw_number = .ibba_col(p, "freeThrowNumber", .ibba_i1, integer(1)),
    free_throws_awarded = .ibba_col(p, "freeThrowsAwarded", .ibba_i1, integer(1)),
    foul_kind = .ibba_col(p, "kind", .ibba_s1, character(1)),
    fouled_on_jersey = .ibba_col(p, "fouledOn", .ibba_s1, character(1)),
    foul_free_throws = ifelse(is_foul, .ibba_col(p, "freeThrows", .ibba_i1, integer(1)), NA_integer_),
    is_coach_foul = ifelse(!is.na(coach) & coach == 1L, TRUE, NA),
    player_in_jersey = .ibba_col(p, "playerIn", .ibba_s1, character(1)),
    player_out_jersey = .ibba_col(p, "playerOut", .ibba_s1, character(1))
  )
  ord <- order(is.na(cols$action_id), ifelse(is.na(cols$action_id), 0L, cols$action_id))
  cols <- lapply(cols, function(x) x[ord])
  cols$team_side <- as.character(cols$team_side)
  cols$foul_free_throws <- as.integer(cols$foul_free_throws)
  cols$is_coach_foul <- as.logical(cols$is_coach_foul)
  .ibba_out(cols, "Segev play-by-play")
}

#' Each Segev frame's columns and R types, in order (sdv-py ibba_segev_parsers.SPECS).
#' @noRd
.IBBA_SEGEV_COUNT_TYPES <- c(stats::setNames(rep("integer", length(.IBBA_COUNT_KEYS)), unname(.IBBA_COUNT_KEYS)),
                             vps = "double", fg2a = "integer", fg3a = "integer", fta = "integer")
#' @noRd
.IBBA_SEGEV_SPECS <- list(
  game_info = c(game_id = "integer", start_time = "POSIXct", competition = "character", home_team_id = "integer",
                home_team = "character", home_team_local = "character", home_short_name = "character",
                away_team_id = "integer", away_team = "character", away_team_local = "character",
                away_short_name = "character", periods = "integer", finished = "logical",
                current_period = "integer", clock = "character"),
  rosters = c(game_id = "integer", team_side = "character", team_id = "integer", player_id = "integer",
              jersey_number = "integer", first_name = "character", last_name = "character",
              first_name_local = "character", last_name_local = "character", in_roster = "integer",
              api_id = "integer"),
  player_box = c(game_id = "integer", team_side = "character", team_id = "integer", row_type = "character",
                 player_id = "integer", jersey_number = "integer", starter = "logical", on_court = "logical",
                 minutes = "character", seconds_played = "integer", plus_minus = "integer",
                 .IBBA_SEGEV_COUNT_TYPES),
  team_box = c(game_id = "integer", team_side = "character", team_id = "integer", score = "integer",
               timeouts = "integer", time_leading = "character", biggest_lead = "integer",
               times_tied = "integer", lead_changes = "integer", .IBBA_SEGEV_COUNT_TYPES,
               pts_from_turnovers = "integer", pts_in_paint = "integer", starting_points = "integer",
               bench_points = "integer", fast_break_possessions = "integer", defensive_stops = "integer",
               biggest_scoring_run = "character"),
  period_scores = c(game_id = "integer", period = "integer", home_points = "integer", away_points = "integer",
                    home_fouls = "integer", away_fouls = "integer"),
  pbp = c(game_id = "integer", action_id = "integer", parent_action_id = "integer", period = "integer",
          clock = "character", user_time_utc = "character", type = "character", subtype = "character",
          team_id = "integer", player_id = "integer", team_side = "character", jersey = "character",
          score_away = "integer", score_home = "integer", player_points = "integer", points = "integer",
          made = "character", x = "double", y = "double", fast_break = "logical", second_chance = "logical",
          points_from_turnover = "logical", free_throw_number = "integer", free_throws_awarded = "integer",
          foul_kind = "character", fouled_on_jersey = "character", foul_free_throws = "integer",
          is_coach_foul = "logical", player_in_jersey = "character", player_out_jersey = "character")
)
