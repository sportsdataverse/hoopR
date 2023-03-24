% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nba_stats_league_dash.R
\name{nba_leaguedashptstats}
\alias{nba_leaguedashptstats}
\title{\strong{Get NBA Stats API League Dashboard Player Tracking - Stats}}
\usage{
nba_leaguedashptstats(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  game_scope = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "PerGame",
  period = "",
  player_experience = "",
  player_or_team = "Player",
  player_position = "",
  pt_measure_type = "Drives",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)
}
\arguments{
\item{college}{college}

\item{conference}{conference}

\item{country}{country}

\item{date_from}{date_from}

\item{date_to}{date_to}

\item{division}{division}

\item{draft_pick}{draft_pick}

\item{draft_year}{draft_year}

\item{game_scope}{game_scope}

\item{height}{height}

\item{last_n_games}{last_n_games}

\item{league_id}{league_id}

\item{location}{location}

\item{month}{month}

\item{opponent_team_id}{opponent_team_id}

\item{outcome}{outcome}

\item{po_round}{po_round}

\item{per_mode}{per_mode}

\item{period}{period}

\item{player_experience}{player_experience}

\item{player_or_team}{player_or_team}

\item{player_position}{player_position}

\item{pt_measure_type}{pt_measure_type}

\item{season}{season}

\item{season_segment}{season_segment}

\item{season_type}{season_type}

\item{starter_bench}{starter_bench}

\item{team_id}{team_id}

\item{vs_conference}{vs_conference}

\item{vs_division}{vs_division}

\item{weight}{weight}

\item{...}{Additional arguments passed to an underlying function like httr.}
}
\description{
\strong{Get NBA Stats API League Dashboard Player Tracking - Stats}

\strong{Get NBA Stats API League Dashboard Player Tracking - Stats}
}
\details{
\href{https://www.nba.com/stats/players/drives}{Players Tracking (Second Spectrum) Stats}

\if{html}{\out{<div class="sourceCode r">}}\preformatted{ nba_leaguedashptstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
}\if{html}{\out{</div>}}
}
\author{
Saiem Gilani
}