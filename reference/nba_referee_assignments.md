# Fetch NBA/G-League/WNBA referee crew assignments for a date

Retrieves referee crew assignments and replay-center officials for every
game on a date, from official.nba.com's `get-game-officials` endpoint
(covers NBA, G-League, and WNBA in one payload). Port of the scraping
logic in [atlhawksfanatic/L2M](https://github.com/atlhawksfanatic/L2M)
(MIT, (c) 2019 atlhawksfanatic).

## Usage

``` r
nba_referee_assignments(date, league = "nba", proxy = NULL)
```

## Arguments

- date:

  character or Date/POSIXct, length 1. Date to fetch. A Date/POSIXct is
  formatted directly (never routed through
  [`as.Date()`](https://rdrr.io/r/base/as.Date.html), which can shift a
  POSIXct's calendar day across a timezone boundary); a character must
  match `"YYYY-MM-DD"`.

- league:

  character(1). One of `"nba"` (default), `"gl"`, `"wnba"`.

- proxy:

  Optional proxy: a URL string (e.g. `"http://host:port"`) or a named
  list of
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  arguments. `NULL` (the default) falls back to
  `getOption("hoopR.proxy")`, then the `http_proxy`/`https_proxy`
  environment variables.

## Value

Named list of `hoopR_data` tibbles:

**officials** – one row per game x filled crew slot. A slot whose
official's name is absent, null or empty is skipped. A field sent as
null, an array or an object reads as NA, never as a dropped or
duplicated row: an array or object name keeps its row, and the
official's id, with an NA `official_name`.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League: nba, gl (G League) or wnba. |
| game_id | character | 10-digit zero-padded game id. |
| game_date | Date | Game date, parsed from the feed's MM/DD/YYYY. |
| season | integer | Season end year (start year + 1 for nba/gl, unchanged for wnba). |
| season_type | character | Season type from the first digit of the feed's season code. |
| game_code | character | League game code, YYYYMMDD/AWYHOM. |
| home_team_id | integer | Team id of the home team. |
| home_team_abbr | character | Home team three-letter abbreviation. |
| away_team_id | integer | Team id of the away team. |
| away_team_abbr | character | Away team three-letter abbreviation. |
| crew_position | integer | Feed slot order (1-4); slot 1 is the inferred crew chief. |
| official_id | integer | Official's person id from the feed. |
| official_name | character | Official's display name. |
| jersey_num | character | Official's jersey number, as a string. |

**replay_center** – the replay-center officials on duty that date, one
row per official. The rows are per date, not tied to a game or a league:
the feed can repeat the same rows in every league block (`league` only
records which block was read), and they can be present when the league
has no games.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League block the row was read from (nba, gl or wnba); not league-specific. |
| game_date | Date | Date the replay-center official worked (not tied to one game). |
| official_id | integer | Replay-center official's person id from the feed. |
| official_name | character | Replay-center official's display name. |

A date with no games for the league is not an error: `officials` comes
back zero-row rather than raising, while `replay_center` can still hold
that date's replay-center officials.

## Details

`crew_position` is the feed's slot order (1-4); slot 1 is *inferred* to
be the crew chief from that ordering – the API does not label roles
directly. `season` converts the feed's `<type digit><START year>` code
to an END year: START+1 for `"nba"`/`"gl"` (two-calendar-year seasons),
START unchanged for `"wnba"` (single-year seasons).

## Errors

Raises a classed condition instead of returning on failure. Both classes
inherit from `hoopR_error`, so one handler can catch either:

- `hoopR_no_data` – official.nba.com 404s the endpoint, or answers 403
  with an S3 `AccessDenied` body.

- `hoopR_fetch_error` – the fetch failed (network error, rate limit,
  Akamai WAF block, any other HTTP status), or a 200 response is not
  valid JSON, is JSON that is not an object, or has the league's
  `Table`/`Table1` `rows` missing or malformed (a `Table` row without a
  10-digit `game_id`, or a `Table1` row without a
  `replaycenter_official` name, included). The feed carries every
  league's block on every date, with zero rows on a day without games,
  so a missing block is never an empty day.

An invalid argument, including an impossible date such as
`"2026-02-31"`, is an ordinary error, raised before any request.

## See also

Other NBA Officiating Functions:
[`nba_l2m()`](https://hoopR.sportsdataverse.org/reference/nba_l2m.md),
[`nba_l2m_games()`](https://hoopR.sportsdataverse.org/reference/nba_l2m_games.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    refs <- nba_referee_assignments(date = "2026-06-13")
    head(refs$officials)
  })
#> ── NBA referee assignments -- officials (official.nba.com) ─────────────────────
#> ℹ Data updated: 2026-09-30 15:08:53 UTC
#> # A tibble: 4 × 14
#>   league game_id    game_date  season season_type game_code       home_team_id
#>   <chr>  <chr>      <date>      <int> <chr>       <chr>                  <int>
#> 1 nba    0042500405 2026-06-13   2026 playoffs    20260613/NYKSAS   1610612759
#> 2 nba    0042500405 2026-06-13   2026 playoffs    20260613/NYKSAS   1610612759
#> 3 nba    0042500405 2026-06-13   2026 playoffs    20260613/NYKSAS   1610612759
#> 4 nba    0042500405 2026-06-13   2026 playoffs    20260613/NYKSAS   1610612759
#> # ℹ 7 more variables: home_team_abbr <chr>, away_team_id <int>,
#> #   away_team_abbr <chr>, crew_position <int>, official_id <int>,
#> #   official_name <chr>, jersey_num <chr>
# }
```
