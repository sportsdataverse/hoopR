# **Get KZS Player Leaderboard**

Player leaderboard of a competition for one stat category (total,
per-game average and single-game best).

Endpoint:
`GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/playerStats`

## Usage

``` r
kzs_player_leaderboard(
  competition_id,
  stats_category = "PTS",
  order_type = "AVERAGE",
  sort_by = "avg",
  sort = "DESC"
)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

- stats_category:

  Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2
  two-pointers, M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field
  goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D defensive, R_O
  offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls
  committed/received, ASS_TOV and ST_TOV ratios. Competitions without
  live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of
  "PTS", "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG",
  "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D", "R_O", "ASS", "ST",
  "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".

- order_type:

  Figure the leaderboard is built on: AVERAGE (per game), SUM (season
  total) or BEST_PERFORMANCE. One of "AVERAGE", "SUM",
  "BEST_PERFORMANCE".

- sort_by:

  Row column the board is ordered by: avg (average), sum or max. The
  runtime checks the order. One of "avg", "sum", "max".

- sort:

  Sort direction. One of "ASC", "DESC".

## Value

A `hoopR_data` tibble: Player leaderboard of a competition for one stat
category (total, per-game average and single-game best). An empty valid
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `kzs_player_leaderboard`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
| stats_category | character | Stat category of the board (PTS points, R rebounds, ASS assists ...): the request's, the rows do not echo it. |
| club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
| club_fullname | character | Club's full legal name. |
| club_logo_uuid | character | Club logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| club_code | character | Club 3-letter code. |
| team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
| team_name | character | Team name for the season, sponsor included. |
| games_played | integer | Games the player played in the competition. |
| sum | double | Season total of the requested statsCategory. |
| average | double | Per-game average of the statsCategory. |
| max | double | Single-game best of the statsCategory. |
| player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| player_firstname | character | The player's given name as registered with KZS (lower-case n in this route). |
| player_lastname | character | The player's family name as registered with KZS (lower-case n in this route). |
| photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |

## Details

- Unofficial and unsupported: these wrappers read the public read API
  (Java/Spring, built by OnixWeb) that the kzs.si site itself calls. No
  terms of use were located (unverified), api.kzs.si/robots.txt answers
  401 and www.kzs.si/robots.txt 404, so no policy or Crawl-delay is
  published. The runtime waits at least 1 s before every request,
  retries included. Payloads are not redistributed as release assets.

- Personal data: the API serves officials' and coaches' emails, phones
  and home towns, and clubs' bank accounts and addresses, publicly. The
  parsers never output them (officials appear by name only; club
  addresses, personnel and the commissioner report are dropped). Do not
  add them back.

- Seasons are END years (2027 = 2026/2027); KZS' own season ids are
  opaque (27 = 2026/2027) and the runtime maps them. Competition ids are
  per season. Three team keys are never interchangeable: the match-team
  id (per match and side), team_id (one club team in one season) and
  club_id (across seasons). player_id is the registry id, person_id the
  person behind it.

- Errors are HTTP 400 for everything (an unknown id and a bad parameter
  alike), so the runtime raises `hoopR_asset_fetch` for it, never
  `hoopR_bad_request` or an empty frame. List routes default to 150 rows
  with no truncation signal: every list wrapper asks for a large limit
  and refuses a full page. The play-by-play and box-score wrappers, the
  leaderboards, teams, rounds and playing days each make one extra,
  cached request (the match header or the competition) to prove the
  answer is the one asked for and the game is final.

- Coverage: scores from 2007/08; box scores and play-by-play from
  2015/16. Some 2020/21 men's games have a box score but no play-by-play
  (`hoopR_no_data`): the Genius data.json (genius_match_id in
  kzs_matches) is the fallback. Shot x/y are Genius court percent; side
  (LEFT/RIGHT) names the basket end and teams switch ends at half time,
  so normalise with side before stacking shots. Advanced box-score
  fields are 0 in every observed game.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (an empty answer or list, a competition without
  standings, a final game with no play-by-play or box score, HTTP 404),
  `hoopR_asset_fetch` (HTTP 400, the API's only error status for an
  unknown id and a bad parameter alike; any other non-2xx; a non-JSON or
  empty body; an envelope whose status is not OK; a full list page; a
  game that is not final; a body for another competition, match, team,
  player or season than the one asked for) and `hoopR_bad_request` (a
  bad argument, before any request). HTTP 500 is retried. Wrappers
  raise; they never return an empty frame for a failed fetch.

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_player_leaderboard(competition_id = 579))
#> ── KZS Player Leaderboard from api.kzs.si ────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:42:04 UTC
#> # A tibble: 186 × 16
#>    competition_id stats_category club_id club_fullname  club_logo_uuid club_code
#>             <int> <chr>            <int> <chr>          <chr>          <chr>    
#>  1            579 PTS                 46 KOŠARKAŠKO DR… e9a0b578-8c96… HOP      
#>  2            579 PTS                  9 KOŠARKARSKI K… ce68270c-327c… DOM      
#>  3            579 PTS                 26 KOŠARKARSKI K… dbf53462-c87d… KRK      
#>  4            579 PTS                 49 KOŠARKARSKI K… 60e0340d-b00f… ROG      
#>  5            579 PTS                254 KOŠARKARSKI K… 4586ff12-6ac5… COL      
#>  6            579 PTS                254 KOŠARKARSKI K… 4586ff12-6ac5… COL      
#>  7            579 PTS                 44 KOŠARKARSKI K… e2d136a7-5b41… ZLA      
#>  8            579 PTS                254 KOŠARKARSKI K… 4586ff12-6ac5… COL      
#>  9            579 PTS                 46 KOŠARKAŠKO DR… e9a0b578-8c96… HOP      
#> 10            579 PTS                 55 KOŠARKARSKI K… 45b0ac2b-351a… ŠEN      
#> # ℹ 176 more rows
#> # ℹ 10 more variables: team_id <int>, team_name <chr>, games_played <int>,
#> #   sum <dbl>, average <dbl>, max <dbl>, player_id <int>,
#> #   player_firstname <chr>, player_lastname <chr>, photo_uuid <chr>
# }
```
