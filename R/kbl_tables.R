# kbl_tables.R -- KBL code tables, the season crosswalk and the frame columns.
#
# Copied from sportsdataverse-py origin/main e3d232ebc9: sportsdataverse/basketball/kbl/kbl_codes.py (SEASONS, ACTIONS,
# ACTION_POINTS, SUBSTITUTIONS, FOULS, LEADER_PARTS) and SPECS of kbl_parsers.py. Korean labels are \u escapes.
# A spec entry is `column = "<wire path>|<type>"`: the path is dotted, empty for a derived column; the type is
# i integer, f double, s character, b logical, d Date. Change them in sportsdataverse-py first, then copy them here.

#' (seasonCode, seasonGrade, first game, last game, sdv END year) of every KBL season and D-League edition.
#' @noRd
.kbl_season_table <- data.frame(
  code = c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 19L, 20L, 21L, 22L, 23L,
    24L, 25L, 26L, 27L, 28L, 29L, 30L, 31L, 32L, 33L, 34L, 35L, 36L, 37L, 38L, 39L, 40L, 41L, 42L, 43L, 44L, 45L, 46L,
    47L, 48L, 49L, 50L),
  grade = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L,
    1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L),
  first = c("19970201", "19971108", "19981108", "19991107", "20001104", "20011103", "20021026", "20031025",
    "20041029", "20051021", "20060927", "20070930", "20080928", "20090713", "20090905", "20091201", "20101015",
    "20101025", "20111013", "20111017", "20121013", "20121022", "20131012", "20131028", "20141011", "20141110",
    "20150902", "20151102", "20161001", "20161107", "20170804", "20171106", "20181003", "20181029", "20191005",
    "20191111", "20200920", "20201104", "20210911", "20211027", "20221001", "20221108", "20231008", "20231031",
    "20241005", "20241121", "20250920", "20251121", "20260924", "20261125"),
  last = c("19970501", "19980411", "19990416", "20000402", "20010406", "20020419", "20030413", "20040410", "20050417",
    "20060425", "20070501", "20080425", "20090501", "20090812", "20100411", "20100305", "20110426", "20110315",
    "20120406", "20120229", "20130417", "20130123", "20140410", "20140224", "20150404", "20150217", "20160329",
    "20160215", "20170502", "20170315", "20180418", "20180226", "20190421", "20190304", "20200229", "20200224",
    "20210509", "20210316", "20220510", "20220126", "20230507", "20230227", "20240505", "20240313", "20250517",
    "20250407", "20260513", "20260401", "20270411", "20270310"),
  end = c(1997L, 1998L, 1999L, 2000L, 2001L, 2002L, 2003L, 2004L, 2005L, 2006L, 2007L, 2008L, 2009L, 2009L, 2010L,
    2010L, 2011L, 2011L, 2012L, 2012L, 2013L, 2013L, 2014L, 2014L, 2015L, 2015L, 2016L, 2016L, 2017L, 2017L, 2018L,
    2018L, 2019L, 2019L, 2020L, 2020L, 2021L, 2021L, 2022L, 2022L, 2023L, 2023L, 2024L, 2024L, 2025L, 2025L, 2026L,
    2026L, 2027L, 2027L),
  stringsAsFactors = FALSE
)

#' Text-cast action code -> English meaning.
#' @noRd
.kbl_action_en <- c(
  `001` = "Game start (a period starts)",
  `002` = "Game suspended (the clock stops)",
  `003` = "Timeout",
  `009` = "Game end (a period ends)",
  `010` = "Time setting (a clock correction)",
  `101` = "Substitution in",
  `102` = "Substitution out",
  `201` = "Two-point field goal made (dunks excepted)",
  `202` = "Two-point field goal missed",
  `203` = "Free throw made",
  `204` = "Free throw missed",
  `205` = "Three-point field goal made",
  `206` = "Three-point field goal missed",
  `207` = "Dunk made",
  `208` = "Dunk missed",
  `209` = "Offensive rebound",
  `210` = "Defensive rebound",
  `211` = "Assist",
  `212` = "Steal",
  `213` = "Blocked shot",
  `214` = "Turnover",
  `215` = "Foul that awards free throws",
  `216` = "Foul without free throws",
  `217` = "Fast break",
  `218` = "Team rebound",
  `219` = "Illegal defense",
  `221` = "Good defense",
  `223` = "Team turnover",
  `224` = "Other foul",
  `225` = "Team foul",
  `226` = "Screen assist",
  `227` = "Deflection",
  `228` = "Video review",
  `229` = "Coach's challenge"
)

#' Text-cast action code -> the site's Korean label.
#' @noRd
.kbl_action_ko <- c(
  `001` = "\uAC8C\uC784\uC2DC\uC791",
  `002` = "\uAC8C\uC784\uC911\uB2E8",
  `003` = "\uC791\uC804\uC2DC\uAC04",
  `009` = "\uAC8C\uC784\uC885\uB8CC",
  `010` = "\uC2DC\uAC04\uC124\uC815",
  `101` = "\uAD50\uCCB4(IN)",
  `102` = "\uAD50\uCCB4(OUT)",
  `201` = "2\uC810\uC29B\uC131\uACF5",
  `202` = "2\uC810\uC29B\uC2DC\uB3C4",
  `203` = "\uC790\uC720\uD22C\uC131\uACF5",
  `204` = "\uC790\uC720\uD22C\uC2DC\uB3C4",
  `205` = "3\uC810\uC29B\uC131\uACF5",
  `206` = "3\uC810\uC29B\uC2DC\uB3C4",
  `207` = "\uB369\uD06C\uC29B\uC131\uACF5",
  `208` = "\uB369\uD06C\uC29B\uC2DC\uB3C4",
  `209` = "\uACF5\uACA9\uB9AC\uBC14\uC6B4\uB4DC",
  `210` = "\uC218\uBE44\uB9AC\uBC14\uC6B4\uB4DC",
  `211` = "\uC5B4\uC2DC\uC2A4\uD2B8",
  `212` = "\uC2A4\uD2F8",
  `213` = "\uBE14\uB85D",
  `214` = "\uD134\uC624\uBC84",
  `215` = "\uD30C\uC6B8\uC790\uC720\uD22C",
  `216` = "\uD30C\uC6B8",
  `217` = "\uD300\uC18D\uACF5",
  `218` = "\uD300\uB9AC\uBC14\uC6B4\uB4DC",
  `219` = "Illegal",
  `221` = "\uAD7F\uB514\uD39C\uC2A4",
  `223` = "\uD300\uD134\uC624\uBC84",
  `224` = "\uAE30\uD0C0\uD30C\uC6B8",
  `225` = "\uD300\uD30C\uC6B8",
  `226` = "\uC2A4\uD06C\uB9B0 \uC5B4\uC2DC\uC2A4\uD2B8",
  `227` = "\uB514\uD50C\uB809\uC158",
  `228` = "\uBE44\uB514\uC624\uD310\uB3C5",
  `229` = "\uCF54\uCE58\uCC4C\uB9B0\uC9C0"
)

#' Points a made-shot action scores.
#' @noRd
.kbl_action_points <- c(
  `201` = 2L,
  `203` = 1L,
  `205` = 3L,
  `207` = 2L
)

#' Substitution sub-type -> English meaning.
#' @noRd
.kbl_substitutions <- c(
  `00_0` = "Ordinary substitution",
  `101_0` = "Ordinary substitution out",
  `104_0` = "Substitution out, sub-type 104 (meaning unverified)",
  `106_0` = "Ejection-type exit, no reason (unverified)",
  `106_1` = "Fouled out (five fouls)",
  `106_2` = "Disqualifying foul",
  `106_3` = "Other ejection"
)

#' Foul type -> English meaning.
#' @noRd
.kbl_fouls <- c(
  `EBF` = "Elbow foul",
  `FRF` = "Unsportsmanlike foul",
  `FTF` = "Fighting foul",
  `PCF` = "Punching foul",
  `PNF` = "Personal foul",
  `TCF` = "Technical foul",
  `XXX` = "No foul type"
)

#' Season-leader / game-leader `part` -> the statistic.
#' @noRd
.kbl_leader_parts <- c(
  `score` = "Points per game",
  `rb` = "Rebounds per game",
  `ast` = "Assists per game",
  `bs` = "Blocks per game",
  `stl` = "Steals per game",
  `fgt` = "Field goals made per game",
  `threep` = "Three-pointers made per game",
  `ftR` = "Free-throw percentage",
  `fgtR` = "Field-goal percentage",
  `threepR` = "Three-point percentage",
  `dk` = "Dunks per game"
)

#' Frame columns: `column = "<wire path>|<type>"` (sportsdataverse-py SPECS, in order).
#' @noRd
.kbl_specs <- list(
  seasons = c(season = "|i", season_code = "seasonCode|i", glkey = "glkey|s", season_name = "seasonName|s",
    season_name_full = "seasonNameFull|s", season_grade = "seasonGrade|i", season_category = "seasonCategory|s",
    game_code = "gameCode|s", start_date = "gamedateStart|d", end_date = "gamedateEnd|d"),
  teams = c(team_code = "teamCode|s", team_code_d = "teamCodeD|s", team_name = "teamName|s", team_name_full =
    "teamNameFull|s", team_name_en = "teamNameEn|s", team_name_full_en = "teamNameFullEn|s"),
  schedule = c(gmkey = "gmkey|s", glkey = "glkey|s", season = "|i", season_code = "seasonCode|i", season_name =
    "seasonName1|s", season_grade = "seasonGrade|i", game_code = "gameCode|s", game_no = "gameNo|i", season_category =
    "seasonCategory|s", season_category_name = "seasonCategoryName|s", game_date = "gameDate|d", week_day =
    "weekDay|s", game_start = "gameStart|s", game_end = "gameEnd|s", game_time = "gameTime|i", home_team_code =
    "tcodeH|s", away_team_code = "tcodeA|s", home_team_name = "tnameH|s", away_team_name = "tnameA|s",
    home_team_name_full = "tnameFH|s", away_team_name_full = "tnameFA|s", home_score = "scoreH|i", away_score =
    "scoreA|i", is_started = "isStarted|i", is_ended = "isEnded|i", playing_quarter = "playingQuarter|s", stadium_name
    = "stadiumname|s", stadium_name_full = "stadiumnameF|s", stadium_name_en = "stadiumnameEn|s", tv = "tv|s", tv_code
    = "tvCode|s", article_id = "artcSq|i", challenge_id = "challengeSq|i"),
  game = c(gmkey = "game.gmkey|s", glkey = "game.glkey|s", season = "|i", season_code = "game.seasonCode|i",
    season_name = "game.seasonName|s", season_grade = "game.seasonGrade|i", game_code = "game.gameCode|s", game_no =
    "game.gameNo|i", season_category_name = "game.seasonCategoryName|s", game_date = "game.gameDate|d", week_day =
    "game.weekDay|s", game_start = "game.gameStart|s", game_end = "game.gameEnd|s", game_time = "game.gameTime|i",
    home_team_code = "game.tcodeH|s", away_team_code = "game.tcodeA|s", home_team_name = "game.tnameH|s",
    away_team_name = "game.tnameA|s", home_team_name_full = "game.tnameFH|s", away_team_name_full = "game.tnameFA|s",
    home_score = "|i", away_score = "|i", overtimes = "|i", is_started = "game.isStarted|i", is_ended =
    "game.isEnded|i", playing_quarter = "game.playingQuarter|s", stadium_name = "game.stadiumname|s",
    stadium_name_full = "game.stadiumnameF|s", stadium_name_en = "game.stadiumnameEn|s", crowds = "game.crowds|i", tv
    = "game.tv|s", tv_code = "game.tvCode|s", detail_url = "game.detailUrl|s", highlight_url = "game.highlightUrl|s",
    referee_main = "game.judges.main.name|s", referees_sub = "|s", home_manager = "teams.home.staffs.manager.name|s",
    away_manager = "teams.away.staffs.manager.name|s", home_coaches = "|s", away_coaches = "|s"),
  period_scores = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", side = "|s",
    team_code = "|s", period = "|i", period_label = "|s", score = "|i"),
  pbp = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", action_number = "|i",
    event_number = "n|i", period = "|i", period_label = "|s", minutes_left = "m|i", seconds_left = "s|i",
    clock_seconds_left = "|i", team_code = "t|s", player_name = "p|s", player_name_en = "e|s", action_code = "a|s",
    action = "|s", action_ko = "|s", points = "|i", substitution_code = "c|s", substitution = "|s", foul_code = "f|s",
    foul = "|s"),
  player_box = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", team_code =
    "player.tcode|s", home_away = "homeAway|s", started = "startFlag|i", pcode = "player.pcode|s", player_name =
    "player.pname|s", player_name_en = "player.ename|s", team_name = "player.tname|s", back_num = "player.backNum|s",
    pos = "player.pos|s", player_flag = "player.playerFlag|s", score = "records.score|i", fg = "records.fg|i", fg_a =
    "records.fgA|i", fgt = "records.fgt|i", fgt_a = "records.fgtA|i", threep = "records.threep|i", threep_a =
    "records.threepA|i", ft = "records.ft|i", ft_a = "records.ftA|i", dk = "records.dk|i", dk_a = "records.dkA|i", rb
    = "records.rb|i", offr = "records.offr|i", defr = "records.defr|i", ast = "records.ast|i", stl = "records.stl|i",
    bs = "records.bs|i", to = "records.to|i", foul = "records.foul|i", wft = "records.wft|i", woft = "records.woft|i",
    pp = "records.pp|i", pp_a = "records.ppA|i", pscore = "records.pscore|i", sast = "records.sast|i", dfl =
    "records.dfl|i", gd = "records.gd|i", idf = "records.idf|i", fb = "records.fb|i", ef = "records.ef|i", tf =
    "records.tf|i", inout = "records.inout|i", inout1 = "records.inout1|i", play_min = "records.playMin|i", play_sec =
    "records.playSec|i", fo = "records.fo|i", margin_cn = "records.marginCn|i", offrtg = "records.offrtg|f", defrtg =
    "records.defrtg|f", netrtg = "records.netrtg|f", efg_rt = "records.efgRt|f", ts_rt = "records.tsRt|f", ast_rt =
    "records.astRt|f", ast_to = "records.astTo|f", ast_ratio = "records.astRatio|f", oreb_rt = "records.orebRt|f",
    dreb_rt = "records.drebRt|f", reb_rt = "records.rebRt|f", pace = "records.pace|f", tov_rt = "records.tovRt|f",
    poss = "records.poss|f", per = "records.per|f", pie = "records.pie|f", usg_rt = "records.usgRt|f", to_ratio =
    "records.toRatio|f", minutes_played = "|f"),
  team_box = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", team_code =
    "tcode|s", score = "records.score|i", fg = "records.fg|i", fg_a = "records.fgA|i", fgt = "records.fgt|i", fgt_a =
    "records.fgtA|i", threep = "records.threep|i", threep_a = "records.threepA|i", ft = "records.ft|i", ft_a =
    "records.ftA|i", dk = "records.dk|i", dk_a = "records.dkA|i", rb = "records.rb|i", offr = "records.offr|i", defr =
    "records.defr|i", ast = "records.ast|i", stl = "records.stl|i", bs = "records.bs|i", to = "records.to|i", foul =
    "records.foul|i", wft = "records.wft|i", woft = "records.woft|i", pp = "records.pp|i", pp_a = "records.ppA|i",
    pscore = "records.pscore|i", sast = "records.sast|i", dfl = "records.dfl|i", gd = "records.gd|i", idf =
    "records.idf|i", fb = "records.fb|i", ef = "records.ef|i", tf = "records.tf|i", inout = "records.inout|i", inout1
    = "records.inout1|i", play_min = "records.playMin|i", play_sec = "records.playSec|i", bf = "records.bf|i", foulout
    = "records.foulout|i", team_r = "records.teamR|i", tfb = "records.tfb|i", tto = "records.tto|i", fb_score_cn =
    "records.fbScoreCn|i", turnover_score_cn = "records.turnoverScoreCn|i", sec_chance_score_cn =
    "records.secChanceScoreCn|i", bench_score_cn = "records.benchScoreCn|i", max_conti_score_cn =
    "records.maxContiScoreCn|i", max_lead_score_cn = "records.maxLeadScoreCn|i", score_high_time_cn =
    "records.scoreHighTimeCn|i", offrtg = "records.offrtg|f", defrtg = "records.defrtg|f", netrtg =
    "records.netrtg|f", efg_rt = "records.efgRt|f", ts_rt = "records.tsRt|f", ast_rt = "records.astRt|f", ast_to =
    "records.astTo|f", ast_ratio = "records.astRatio|f", oreb_rt = "records.orebRt|f", dreb_rt = "records.drebRt|f",
    reb_rt = "records.rebRt|f", pace = "records.pace|f", tov_rt = "records.tovRt|f", poss = "records.poss|f",
    minutes_played = "|f"),
  shots = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", pcode = "pcode|s",
    player_name = "pname|s", player_name_en = "ename|s", team_code = "tcode|s", period = "|i", period_label = "|s", x
    = "logs.x|i", y = "logs.y|i", made = "|b", basket = "logs.d|s"),
  score_track = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", period = "|i",
    period_label = "|s", checkpoint = "|i", home_margin = "|i", home_score = "|i", away_score = "|i"),
  game_leaders = c(gmkey = "|s", season_code = "|i", season = "|i", game_code = "|s", game_no = "|i", part =
    "bestPlayer.part|s", side = "|s", pcode = "bestPlayer.home.pcode|s", player_name = "bestPlayer.home.pname|s",
    player_name_en = "bestPlayer.home.pnameEn|s", team_name = "bestPlayer.home.tname|s", value =
    "bestPlayer.home.value|f", play_min = "bestPlayer.home.playMin|i", play_sec = "bestPlayer.home.playSec|i"),
  player_totals = c(season = "|i", season_code = "|i", game_code = "|s", glkey = "|s", pcode = "player.pcode|s",
    player_name = "player.pname|s", player_name_en = "player.ename|s", team_code = "player.tcode|s", team_name =
    "player.tname|s", back_num = "player.backNum|s", pos = "player.pos|s", player_flag = "player.playerFlag|s",
    game_count = "gameCount|i", start_count = "startCount|i", score = "records.score|i", fg = "records.fg|i", fg_a =
    "records.fgA|i", fgt = "records.fgt|i", fgt_a = "records.fgtA|i", threep = "records.threep|i", threep_a =
    "records.threepA|i", ft = "records.ft|i", ft_a = "records.ftA|i", dk = "records.dk|i", dk_a = "records.dkA|i", rb
    = "records.rb|i", offr = "records.offr|i", defr = "records.defr|i", ast = "records.ast|i", stl = "records.stl|i",
    bs = "records.bs|i", to = "records.to|i", foul = "records.foul|i", wft = "records.wft|i", woft = "records.woft|i",
    pp = "records.pp|i", pp_a = "records.ppA|i", pscore = "records.pscore|i", sast = "records.sast|i", dfl =
    "records.dfl|i", gd = "records.gd|i", idf = "records.idf|i", fb = "records.fb|i", ef = "records.ef|i", tf =
    "records.tf|i", inout = "records.inout|i", inout1 = "records.inout1|i", play_min = "records.playMin|i", play_sec =
    "records.playSec|i", foulout = "records.foulout|i", minutes_played = "|f"),
  standings = c(season = "|i", season_code = "|i", game_code = "gameCode|s", rank = "rank|i", team_code =
    "teamCode|s", team_name = "teamName1|s", team_name_full = "teamName2|s", game_count = "gameCount|i", wins =
    "TWin|i", losses = "TLoss|i", draws = "TDraw|i", win_rate = "winRate|f", win_diff = "winDiff|f", home_wins =
    "hwin|i", home_losses = "hloss|i", away_wins = "awin|i", away_losses = "aloss|i", conti_win = "contiWin|i",
    conti_loss = "contiLoss|i", conti_date = "contiDate|d", max_win = "maxWin|i", max_loss = "maxLoss|i",
    last_game_date = "gameDate|d", last_five = "lastRecor|s", last_game_won = "win|b", last_game_lost = "loss|b",
    last_game_drawn = "draw|b", game_flag = "gameFlag|b", updated_at = "inputtime|s", score = "score|i", fg = "fg|i",
    fg_a = "fgA|i", threep = "threep|i", threep_a = "threepA|i", ft = "ft|i", ft_a = "ftA|i", dk = "dk|i", dk_a =
    "dkA|i", ast = "AS|i", bs = "BS|i", defr = "DR|i", offr = "OR|i", stl = "ST|i", to = "TO|i", team_r = "TR|i", pp =
    "pp|i", pp_a = "ppA|i", pscore = "PScore|i", wft = "wft|i", woft = "woft|i", foul_total = "foulTot|i", tfb =
    "tfb|i", tto = "tto|i", tf = "tf|i", fb = "fb|i", ef = "ef|i", bf = "bf|i", gd = "gd|i", idf = "idf|i", inout =
    "inout|i", inout1 = "inout1|i", foulout = "foulout|i", play_min = "playMin|i", play_sec = "playSec|i"),
  team_tracks = c(season = "|i", season_code = "|i", game_code = "|s", glkey = "|s", team_code = "tcode|s", team_name
    = "tname|s", game_number = "|i", rank = "|i"),
  rounds = c(season = "|i", season_code = "|i", game_code = "|s", glkey = "|s", round = "gameRound|i", from_date =
    "fromDate|d", to_date = "toDate|d"),
  playoff_seeds = c(season = "|i", season_code = "defaultRank.seasonCode|i", game_code = "defaultRank.gameCode|s",
    seed = "defaultRank.rank|i", team_code = "defaultRank.teamCode|s", team_name = "defaultRank.teamName1|s",
    team_name_full = "defaultRank.teamName2|s"),
  playoff_series = c(season = "|i", season_code = "|i", bracket_format = "|s", round = "|s", series_no = "gameHoi|i",
    team_code = "teamCode|s", opponent_code = "|s", seed = "|i", wins = "win|i", losses = "loss|i", game_date =
    "gameDate|d"),
  playoff_games = c(season = "|i", season_code = "result.game1.gmkey.seasonCode|i", gmkey = "|s", game_code =
    "result.game1.gmkey.gameCode|s", game_no = "result.game1.gmkey.gameNo|i", round = "|s", series_no = "|i",
    game_date = "result.game1.gameDate|d", home_team_code = "result.game1.tcodeH|s", away_team_code =
    "result.game1.tcodeA|s", home_team_name = "result.game1.tnameH|s", away_team_name = "result.game1.tnameA|s",
    home_score = "result.game1.scoreH|i", away_score = "result.game1.scoreA|i", home_win = "result.game1.homeWin|b"),
  round_mvps = c(season = "|i", season_code = "seasonCode|i", round = "gameRound|i", pcode = "playerNo|s", team_code =
    "teamCode|s", player_name = "kname|s", player_name_en = "ename|s", game_count = "gameCount|i", total_seconds =
    "|i", total_score = "totalScore|i", total_rebound = "totalRebound|i", total_assist = "totalAssist|i"),
  current_standings = c(rank = "rank|i", team_code = "tcode|s", team_name = "tname|s", team_name_full = "tnameF|s",
    wins = "win|i", losses = "loss|i", draws = "draw|i", win_diff = "winDiff|f", home_wins = "hwin|i", home_losses =
    "hloss|i", away_wins = "awin|i", away_losses = "aloss|i", conti_win = "contiWin|i", conti_loss = "contiLoss|i",
    max_win = "maxWin|i", max_loss = "maxLoss|i", last_five = "|s"),
  season_leaders = c(part = "part|s", part_label = "|s", rank = "list.rank|i", value = "list.value|f", game_count =
    "list.gameCount|i", pcode = "list.player.pcode|s", player_name = "list.player.pname|s", player_name_en =
    "list.player.ename|s", team_code = "list.player.tcode|s", team_name = "list.player.tname|s", back_num =
    "list.player.backNum|s", pos = "list.player.pos|s", player_flag = "list.player.playerFlag|s"),
  players = c(pcode = "pcode|s", player_name = "pname|s", player_name_en = "ename|s", team_code = "tcode|s", team_name
    = "tname|s", team_name_en = "tnameEn|s", back_num = "backNum|s", pos = "pos|s", player_flag = "playerFlag|s",
    last_career = "playerLastCareerIf|s")
)
