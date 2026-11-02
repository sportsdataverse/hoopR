# **ABA League Game**

Header of one finished game: round, date, venue, attendance, both clubs
with their score, commissioner and referees.

Endpoint:
`GET https://www.aba-liga.com/match/{game_no}/{sez}/{lea}/Overview`
`sez = season - 2001`; `league = "aba2"` reads
`https://druga.aba-liga.com` with `lea = 2`.

## Usage

``` r
aba_game(game_no, season, league = "aba")
```

## Arguments

- game_no:

  Required. Game number within the season AND league (it restarts at 1
  for every season and league), e.g. 6; `game_no` in aba_calendar.
  Playoff games that were not needed leave gaps.

- season:

  Required. Season END year (2026 = 2025-26). the wrapper sends the
  site's START-year key `sez = season - 2001` (25). The ABA League's
  first season is 2001-02 (`season=2002`).

- league:

  League: `aba` (ABA League, www.aba-liga.com, site code lea=1) or
  `aba2` (ABA League 2, druga.aba-liga.com, lea=2). Both sites serve one
  database; the runtime asks the league's own host. Default `"aba"`.

## Value

A `hoopR_data` tibble. One row keyed by (`game_no`, `season`,
`league_id`): round and competition labels, the date line split into
`date` / `time` / `time_zone` (`CET` is wall-clock Central European time
including summer time; ABA League 2 prints `local`), attendance, venue
(null before 2017-18), the two clubs with their global `team_id` and
final score, the commissioner and the referees (`"; "`-joined, names
only). Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_no | integer | Game number, per season AND league: it restarts at 1 for every season and league, so a game's key is (game_no, season, league_id). Unplayed playoff games leave gaps. The {gameNo} of the match route. |
| season | integer | Season END year (2026 = 2025-26): the site's START-year key sez (25) plus 2001. |
| league_id | integer | League code, the site's lea: 1 = ABA League, 2 = ABA League 2. |
| league | character | League label: aba (ABA League, lea 1) or aba2 (ABA League 2, lea 2), the wrapper's league argument. |
| season_label | character | Season label as the page prints it ('2025/26' on the match page, 'Season 2025/26' on the calendar and standings pages). |
| round | character | Round / phase label as the page prints it: 'ROUND 1', 'Top8 - R2', 'Quarter-finals, Round 1', 'Finals, Round 4', 'Semifinal'. Same vocabulary as calendar games\[\].round. |
| competition | character | Competition name as printed, sponsor included and applied to every season: 'AdmiralBet ABA League' (2017-18 and 2025-26), 'Regional League' (2008-09), '2. ABA liga' (ABA League 2). |
| group | character | Group letter of a two-group regular season ('A', 'B'). ABSENT when the season has no groups (2008-09, 2017-18 and ABA League 2 samples). |
| when | character | Date-and-time line verbatim (English weekday, dd.mm.yyyy, hh:mm, time-zone label). |
| date | Date | Game date, from the date-and-time line (the first date of a window); null for 'TBA'. |
| date_to | Date | Last date of a 'dd.mm.yyyy - dd.mm.yyyy' window printed before a game is scheduled; null on a game with a single date. |
| time | character | Tip-off time 'hh:mm' in time_zone. |
| time_zone | character | 'CET' = Central European wall-clock time INCLUDING summer time (the label never changes; the Dubai local times prove CEST in October/June, CET in winter); 'local' = the arena's local time (ABA League 2 prints 'Local time'). |
| local_time | character | Arena-local tip-off 'hh:mm' when the arena is outside Central Europe ('(19:00 Dubai local time)'); null otherwise. |
| local_place | character | City of local_time ('Dubai', 'Cluj-Napoca'); null when the arena is in Central Europe. |
| attendance | integer | Spectators (the users icon). The parser sets null when the page prints none (never seen: every banked page prints it; null is part of the record contract). |
| venue | character | Arena name ('Venue: ...'). ABSENT on the 2008-09 sample (the page has no venue line). |
| home_team_id | integer | ABA team id (key space: aba-liga.com clubs, the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26, Krka = 10). The first number of /team/{id}/{sez}/{lea}/0/{slug}/ and of the logo images/club/{size}/{id}.png. Joins match game.\*\_team_id / players / teams / pbp, standings rows and the player page. Not a player id. |
| home_team | character | Home club name as the site prints it NOW: a club's current name is applied to every season (2008-09 shows 'Partizan Mozzart Bet'); a club that no longer plays keeps its last name (2008-09 'Petrol Olimpija'). Join on the team id. |
| home_city | character | Home club city (local spelling: 'Beograd', 'Novo Mesto'). |
| home_score | integer | Home final score. |
| away_team_id | integer | ABA team id (key space: aba-liga.com clubs, the same id in every season and in both leagues, e.g. Partizan = 22 in 2008-09 and 2025-26, Krka = 10). The first number of /team/{id}/{sez}/{lea}/0/{slug}/ and of the logo images/club/{size}/{id}.png. Joins match game.\*\_team_id / players / teams / pbp, standings rows and the player page. Not a player id. |
| away_team | character | Away club name as the site prints it now (see home_team). |
| away_city | character | Away club city (local spelling). |
| away_score | integer | Away final score. |
| commissioner | character | Game commissioner's name ('Commissioner:' line); 2008-09 adds an IOC-style country code in parentheses ('(SRB)'). Null when not printed. |
| referees | character | Referees' names in page order (crew chief first), joined with '; ' (2008-09 adds an IOC-style country code in parentheses). Names only. |

## Details

Unofficial use of a public source: these wrappers read the leagues' own
PHP sites (www.aba-liga.com, druga.aba-liga.com), keyless, with no bot
wall. www.aba-liga.com/robots.txt is the single line `User-agent: *`
(nothing disallowed, no Crawl-delay) and druga has no robots.txt; no
terms page was found. The runtime waits at least 1 s per host before
every request.

Coverage: box scores from 2001-02; play-by-play, the starter and
on-court markers, the shot chart and the minute-by-minute score from
2017-18 (earlier games answer an empty pbp and `hoopR_no_data` for the
helpers). A game is keyed by (game_no, season, league_id): game_no
restarts at 1 for every season and league. Team and player ids are
global; the calendar carries club names only. Club names are the club's
CURRENT name on every season: join on team_id.

Only finished games are served: an unplayed game, or one whose period
scores, team totals or play-by-play do not add up to the final score,
raises `hoopR_asset_fetch`, as does a page for another game, season or
league than asked. The three live-match helpers echo nothing about the
game, so the runtime fetches the same game's match page first (one extra
request) and checks the helper against it.

Times: `CET` means Central European wall-clock time including summer
time (the label never changes); ABA League 2 prints `Local time`.
Officials appear by name only; the player bio (birth date and place,
nationality) is the public player profile.

Errors: `hoopR_no_data` when the site has nothing for the request (HTTP
404, an unknown game redirected to /match-not-defined/, a season the
site does not hold or before 2001-02, a live-match helper with no data
before 2017-18); `hoopR_bad_request` for an invalid argument (a
non-integer id or season, a `league` other than `aba` / `aba2`) or HTTP
400 / 422; `hoopR_asset_fetch` when the fetch failed (any other non-200,
a connection failure after three attempts, a redirect off the ABA sites)
or the answer is not the one asked for (a page for another game, season
or league, an unfinished game, a helper that does not belong to the
game, layout drift). All inherit `hoopR_error`.

## See also

Other ABA Functions:
[`aba_box_players()`](https://hoopR.sportsdataverse.org/reference/aba_box_players.md),
[`aba_box_teams()`](https://hoopR.sportsdataverse.org/reference/aba_box_teams.md),
[`aba_calendar()`](https://hoopR.sportsdataverse.org/reference/aba_calendar.md),
[`aba_pbp()`](https://hoopR.sportsdataverse.org/reference/aba_pbp.md),
[`aba_periods()`](https://hoopR.sportsdataverse.org/reference/aba_periods.md),
[`aba_player()`](https://hoopR.sportsdataverse.org/reference/aba_player.md),
[`aba_player_games()`](https://hoopR.sportsdataverse.org/reference/aba_player_games.md),
[`aba_score_difference()`](https://hoopR.sportsdataverse.org/reference/aba_score_difference.md),
[`aba_score_flow()`](https://hoopR.sportsdataverse.org/reference/aba_score_flow.md),
[`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md),
[`aba_standings()`](https://hoopR.sportsdataverse.org/reference/aba_standings.md)

## Examples

``` r
# \donttest{
  try(aba_game(game_no = 6, season = 2026))
#> ── ABA League Game ────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:49:40 UTC
#> # A tibble: 1 × 27
#>   game_no season league_id league season_label round   competition   group when 
#>     <int>  <int>     <int> <chr>  <chr>        <chr>   <chr>         <chr> <chr>
#> 1       6   2026         1 aba    2025/26      ROUND 1 AdmiralBet A… B     Sund…
#> # ℹ 18 more variables: date <date>, date_to <date>, time <chr>,
#> #   time_zone <chr>, local_time <chr>, local_place <chr>, attendance <int>,
#> #   venue <chr>, home_team_id <int>, home_team <chr>, home_city <chr>,
#> #   home_score <int>, away_team_id <int>, away_team <chr>, away_city <chr>,
#> #   away_score <int>, commissioner <chr>, referees <chr>
# }
```
