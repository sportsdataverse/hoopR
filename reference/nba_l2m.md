# Fetch an NBA Last Two Minute (L2M) report

Retrieves and parses the Last Two Minute officiating report for a single
NBA game from official.nba.com. A report is published for any game that
is within 3 points (5 points before 2017-18) at any point in the last
two minutes of the 4th quarter or overtime – not only playoff games.
JSON reports exist only from 2019-01-01 onward. Port of the scraping
logic in [atlhawksfanatic/L2M](https://github.com/atlhawksfanatic/L2M)
(MIT, (c) 2019 atlhawksfanatic).

## Usage

``` r
nba_l2m(game_id, proxy = NULL)
```

## Arguments

- game_id:

  character or numeric. A single all-digit NBA game id of at most 10
  digits; zero-padded to 10 digits automatically (e.g. `42500405`
  becomes `"0042500405"`). Anything else errors before any request is
  made.

- proxy:

  Optional proxy: a URL string (e.g. `"http://host:port"`) or a named
  list of
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  arguments (`url`, `port`, `username`, `password`, `auth`). `NULL` (the
  default) falls back to `getOption("hoopR.proxy")`, then the
  `http_proxy`/`https_proxy` environment variables.

## Value

Named list of `hoopR_data` tibbles:

**calls** – one row per graded play. `decision` is normalized to
`CC`/`CNC`/`IC`/`INC` (`NCC`-\>`CNC`, `NCI`-\>`INC`, trailing `*`
stripped; a real `INC` stays `INC`, while a blank or `"Undetectable"`
grade becomes `NA` and is never counted as `INC`). `game_id` is a
10-char zero-padded string. Player and team names are kept verbatim (no
ASCII folding).

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | 10-digit zero-padded game id; joins to game and stats. |
| period | integer | Period number from period_name (4 = fourth quarter, 5+ = overtime). |
| period_name | character | Raw period label, e.g. Q4, or Q5 for the first overtime. |
| pc_time | character | Raw game clock string, MM:SS or MM:SS.t. |
| seconds_remaining | double | Seconds left in the period, parsed from pc_time. |
| call_type | character | Raw "Call: Type" label, whitespace untouched. |
| call | character | Upper-cased part of call_type before the colon, e.g. FOUL. |
| type | character | Upper-cased part of call_type after the colon, e.g. SHOOTING. |
| committing | character | Player, team or coach committing the graded action. |
| disadvantaged | character | Player or team disadvantaged by the graded action. |
| decision | character | Normalized grade: CC, CNC, IC or INC. |
| decision_raw | character | Raw grading code before normalization. |
| comment | character | Grader's free-text explanation of the ruling. |
| difficulty | character | Grader's difficulty rating, e.g. Observable or Difficult. |
| video_event_id | character | Report video event id (source field VideolLink); not a play-by-play event number. |
| pos_id | integer | Report possession id; rows sharing it belong to one possession. |
| pos_start | character | Game clock at the start of the possession. |
| pos_end | character | Game clock at the end of the possession. |
| pos_team_id | integer | NBA team id of the team in possession. |

**game** – one row of game metadata.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | 10-digit zero-padded game id; joins to calls and stats. |
| game_date | Date | Game date from the report's local tip-off timestamp. |
| season_type | character | Season type from the third digit of game_id, e.g. playoffs. |
| home_team_id | integer | NBA team id of the home team. |
| away_team_id | integer | NBA team id of the away team. |
| home_team_abbr | character | Home team three-letter abbreviation. |
| away_team_abbr | character | Away team three-letter abbreviation. |
| home_team_name | character | Home team nickname as published in the report. |
| away_team_name | character | Away team nickname as published in the report. |
| home_score | integer | Home team final score. |
| away_score | integer | Away team final score. |
| l2m_comments | character | Report-level note from the league; NA for almost every game. |

**stats** – 3 rows of error-count stats (`Calls`, `Errors in Favor`,
`Possessions in Favor`).

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | 10-digit zero-padded game id; joins to calls and game. |
| stat_name | character | Statistic: Calls, Errors in Favor or Possessions in Favor. |
| home | integer | Value of stat_name for the home team. |
| away | integer | Value of stat_name for the away team. |

## Errors

Raises a classed condition instead of returning on failure. Both classes
inherit from `hoopR_error`, so one handler can catch either:

- `hoopR_no_data` – the game has no L2M report (common for
  regular-season games, games that did not reach the final two minutes,
  or very recent games): official.nba.com answers 403 with an S3
  `AccessDenied` body, or 404s the request.

- `hoopR_fetch_error` – the fetch failed (network error, rate limit,
  Akamai WAF block, any other HTTP status), or a 200 response is not a
  report: not valid JSON, JSON that is not an object, a payload without
  a one-row `game` table (an empty object or an error envelope, say), a
  `game`, `l2m` or `stats` table of the wrong shape, or a field the
  parser cannot read.

An invalid argument is an ordinary error, raised before any request.

## See also

Other NBA Officiating Functions:
[`nba_l2m_games()`](https://hoopR.sportsdataverse.org/reference/nba_l2m_games.md),
[`nba_referee_assignments()`](https://hoopR.sportsdataverse.org/reference/nba_referee_assignments.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    l2m <- nba_l2m(game_id = "0042500405")
    head(l2m$calls)
  })
#> ── NBA L2M calls (official.nba.com) ──────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-30 05:44:51 UTC
#> # A tibble: 6 × 19
#>   game_id    period period_name pc_time seconds_remaining call_type  call  type 
#>   <chr>       <int> <chr>       <chr>               <dbl> <chr>      <chr> <chr>
#> 1 0042500405      4 Q4          01:54.0             114   Foul: Sho… FOUL  SHOO…
#> 2 0042500405      4 Q4          01:31.6              91.6 Foul: Sho… FOUL  SHOO…
#> 3 0042500405      4 Q4          01:29.2              89.2 Turnover:… TURN… 24 S…
#> 4 0042500405      4 Q4          01:18.0              78   Foul: Sho… FOUL  SHOO…
#> 5 0042500405      4 Q4          01:07.4              67.4 Foul: Sho… FOUL  SHOO…
#> 6 0042500405      4 Q4          00:55.7              55.7 Foul: Per… FOUL  PERS…
#> # ℹ 11 more variables: committing <chr>, disadvantaged <chr>, decision <chr>,
#> #   decision_raw <chr>, comment <chr>, difficulty <chr>, video_event_id <chr>,
#> #   pos_id <int>, pos_start <chr>, pos_end <chr>, pos_team_id <int>
# }
```
