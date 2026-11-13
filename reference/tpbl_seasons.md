# **Get TPBL Seasons**

Every TPBL season with its TPBL and GoHoops ids, label, status and date
window.

Endpoint: `GET https://api.tpbl.basketball/api/seasons`

## Usage

``` r
tpbl_seasons()
```

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_seasons")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Unofficial and unsupported: these are the routes the tpbl.basketball
  site's own front end calls on api.tpbl.basketball (read from its
  JavaScript bundle). The API is keyless and needs no headers;
  tpbl.basketball/robots.txt answers 200 with an empty body. The runtime
  waits at least 1 s before every request, retries included.

- Coverage: three seasons so far (2024-25 = season 2025 to 2026-27 =
  season 2027). There is NO play-by-play route; the two shot lists carry
  court coordinates only, with no shooter, game, quarter or time. Names
  (teams with their sponsor, venues, players, referees) are Traditional
  Chinese; the column descriptions translate the codes.

- Seasons are END years (2026 = 2025-26). The API keys a season by its
  own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27); the runtime
  reads tpbl_seasons once per session and sends that id. A year the list
  lacks is `hoopR_no_data`.

- Ids: every route takes TPBL's own ids (season, division, team, game,
  player); the `gohoops_*` ids belong to GoHoops, the stats platform
  behind the league, and are echoed beside them. The box score keys its
  players by gohoops_roster_id (a person registered with one squad in
  one season), not by the TPBL player id: join tpbl_box_players to
  tpbl_roster on gohoops_roster_id. Every id is an integer. tipoff is a
  POSIXct in Asia/Taipei (the API sends naive Taiwan-local times).

- Finished games only: the game wrappers first read the game detail
  (cached per session) and refuse (`hoopR_asset_fetch`) a game that is
  not COMPLETED or still live; the box-score wrappers also refuse a
  stats body whose teams (in home / away order), final scores, quarter
  count or player points disagree with it. The season game list, the
  roster and the player game log are checked against the object asked
  for; the two shot lists name no team, player or division in the body,
  so only their shape and court bounds are checked. tpbl_games(verify =
  TRUE) also checks every division's completed games against its
  standings (falling back to the team-filtered lists for a division
  whose standings answer empty, as the 2024-25 playoffs do).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a season the API does not list, an empty
  list such as the standings of a playoff division), `hoopR_bad_request`
  (a non-integer id or season, HTTP 400 / 422, an invalid verify or
  rounds, raised before the request where it can be) and
  `hoopR_asset_fetch` (any other failure: a non-2xx after retries, a
  non-JSON body, an error envelope, an unfinished game, a body that
  disagrees with the object asked for). HTTP 500 is retried on every
  route except the player game log, where an unknown division_id answers
  500 deterministically: it fails after one request. Wrappers raise;
  they never warn and return an empty frame.

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tpbl_seasons())
#> ── TPBL Seasons from api.tpbl.basketball ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:40:12 UTC
#> # A tibble: 3 × 7
#>   season season_id gohoops_season_id name           status   started_at ended_at
#>    <int>     <int>             <int> <chr>          <chr>    <chr>      <chr>   
#> 1   2025         1               101 2024-2025 賽季 COMPLET… 2024-10-0… 2025-07…
#> 2   2026         2               213 2025-2026 賽季 COMPLET… 2025-10-0… 2026-05…
#> 3   2027         3               275 2026-2027 賽季 IN_PROG… 2026-10-1… 2027-05…
# }
```
