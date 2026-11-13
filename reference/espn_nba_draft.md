# **Get ESPN NBA Draft Pick Detail**

Returns a single NBA draft pick. Defaults to the most recent NBA
season's \#1 overall pick. For a full draft, use `espn_nba_draft()`.

Returns one row per round of the NBA draft (typically 2 rounds: 1st with
30 picks, 2nd with ~28 picks).

Returns one row per drafted athlete in a given NBA draft year.

Returns the current status of one NBA draft year (round, state,
description). Live during the draft; static afterward.

Returns a single-row tibble with top-level draft-year metadata: year,
number of rounds, display name, plus `$ref`s for the deeper
sub-resources (status, athletes, rounds) already wrapped by
`espn_nba_draft_status()`, `espn_nba_draft_athletes()`, and
`espn_nba_draft_rounds()`.

Returns rich single-row detail for one drafted athlete in one NBA draft
year: name, height, weight, position, pick (overall/round/team), and a
`$ref` to the athlete's core-v2 profile. Use `espn_nba_draft_athletes()`
to enumerate draftees for a year.

## Usage

``` r
espn_nba_draft_pick(
  season = most_recent_nba_season(),
  round = 1L,
  pick = 1L,
  ...
)

espn_nba_draft_rounds(season = most_recent_nba_season(), ...)

espn_nba_draft_athletes(season = most_recent_nba_season(), ...)

espn_nba_draft_status(season = most_recent_nba_season(), ...)

espn_nba_season_draft(season = most_recent_nba_season(), ...)

espn_nba_draft_athlete_detail(
  season = most_recent_nba_season(),
  athlete_id,
  ...
)

espn_nba_draft(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent NBA
  season.

- round:

  Draft round (default 1).

- pick:

  Pick number within the round (default 1).

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)`.

- athlete_id:

  ESPN draftee identifier.

## Value

A `hoopR_data` tibble with one row per draft pick.

|             |           |                              |
|-------------|-----------|------------------------------|
| col_name    | types     | description                  |
| league      | character | League slug.                 |
| season      | integer   | Season year of the draft.    |
| round       | integer   | Round number.                |
| pick        | integer   | Pick within the round.       |
| overall     | integer   | Overall pick number.         |
| traded      | logical   | Whether the pick was traded. |
| trade_note  | character | Trade note (if any).         |
| status      | character | Pick status name.            |
| athlete_id  | character | Drafted athlete's ESPN id.   |
| team_id     | character | Drafting team's ESPN id.     |
| athlete_ref | character | `$ref` to athlete.           |
| team_ref    | character | `$ref` to team.              |

A tibble with one row per round.

A tibble of athlete IDs + `$ref` URLs.

A single-row tibble.

A single-row tibble.

A single-row tibble.

A `hoopR_data` tibble with one row per draft pick.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| round | integer | Tournament / playoff round. |
| pick | integer |  |
| overall | integer | Overall. |
| traded | logical |  |
| trade_note | character |  |
| status | character | Status label. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_ref | character |  |
| team_id | character | Unique team identifier. |
| team_ref | character |  |

## Details

**Get ESPN NBA Draft Pick Detail**

**Get ESPN NBA Draft Rounds Summary**

**Get ESPN NBA Draft Athletes Index**

**Get ESPN NBA Draft Status**

Calls the ESPN core-v2 endpoint
`https://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{year}/draft/rounds`,
which returns each round of the draft with its picks inlined as
`picks: [...]`. For historical seasons with no ESPN draft data the
function returns an empty tibble rather than erroring.

## See also

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_nba_draft_pick(season = 2024, round = 1, pick = 1)
#> ── ESPN NBA Draft Pick Detail ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 1 × 12
#>   league season round  pick overall traded trade_note status  athlete_id team_id
#>   <chr>   <int> <int> <int>   <int> <lgl>  <chr>      <chr>   <chr>      <chr>  
#> 1 nba      2024     1     1       1 FALSE  NA         SELECT… 108206     1      
#> # ℹ 2 more variables: athlete_ref <chr>, team_ref <chr>
# }
# \donttest{
  espn_nba_draft_rounds(season = 2024)
#> ── ESPN NBA Draft Rounds ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 2 × 7
#>   league season round display_name short_display_name n_picks status   
#>   <chr>   <int> <int> <chr>        <chr>                <int> <chr>    
#> 1 nba      2024     1 1st Round    1st                     30 COMPLETED
#> 2 nba      2024     2 2nd Round    2nd                     28 COMPLETED
# }
# \donttest{
  espn_nba_draft_athletes(season = 2024)
#> ── ESPN NBA Draft Athletes ────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 102 × 4
#>    league season athlete_id ref                                                 
#>    <chr>   <int> <chr>      <chr>                                               
#>  1 nba      2024 108206     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  2 nba      2024 108204     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  3 nba      2024 108106     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  4 nba      2024 108231     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  5 nba      2024 108203     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  6 nba      2024 108107     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  7 nba      2024 108228     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  8 nba      2024 108142     http://sports.core.api.espn.com/v2/sports/basketbal…
#>  9 nba      2024 108207     http://sports.core.api.espn.com/v2/sports/basketbal…
#> 10 nba      2024 108210     http://sports.core.api.espn.com/v2/sports/basketbal…
#> # ℹ 92 more rows
# }
# \donttest{
  espn_nba_draft_status(season = 2024)
#> ── ESPN NBA Draft Status ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 1 × 7
#>   league season round type_id type_name type_state description
#>   <chr>   <int> <int> <chr>   <chr>     <chr>      <chr>      
#> 1 nba      2024     2 3       COMPLETED post       Completed  
# }
# \donttest{
  espn_nba_season_draft(season = 2024)
#> ── ESPN NBA Season Draft (top-level) ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 1 × 10
#>   league season  year uid       number_of_rounds display_name short_display_name
#>   <chr>   <int> <int> <chr>                <int> <chr>        <chr>             
#> 1 nba      2024  2024 s:40~l:4…                2 2024 Nation… 2024 NBA Draft    
#> # ℹ 3 more variables: status_ref <chr>, athletes_ref <chr>, rounds_ref <chr>
# }
# \donttest{
  espn_nba_draft_athlete_detail(season = 2024, athlete_id = 1966)
#> ✖ 2026-11-13 18:54:28.768593: Failed to retrieve ESPN nba draft athlete detail for season=2024, athlete_id=1966
#> ✖ Args: league = "nba", season = 2024, athlete_id = 1966
#> ✖ Error: The API returned an error
#> ── ESPN NBA Draft Athlete Detail ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_draft(season = 2024)
#> ── ESPN NBA Draft Picks from ESPN.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:28 UTC
#> # A tibble: 58 × 11
#>    season round  pick overall traded trade_note status    athlete_id athlete_ref
#>     <int> <int> <int>   <int> <lgl>  <chr>      <chr>     <chr>      <chr>      
#>  1   2024     1     1       1 FALSE  NA         SELECTIO… 108206     http://spo…
#>  2   2024     1     2       2 FALSE  NA         SELECTIO… 108204     http://spo…
#>  3   2024     1     3       3 FALSE  From BKN   SELECTIO… 108231     http://spo…
#>  4   2024     1     4       4 FALSE  NA         SELECTIO… 108107     http://spo…
#>  5   2024     1     5       5 FALSE  NA         SELECTIO… 108202     http://spo…
#>  6   2024     1     6       6 FALSE  NA         SELECTIO… 108207     http://spo…
#>  7   2024     1     7       7 FALSE  NA         SELECTIO… 108106     http://spo…
#>  8   2024     1     8       8 TRUE   From TOR   SELECTIO… 108142     http://spo…
#>  9   2024     1     9       9 FALSE  NA         SELECTIO… 108147     http://spo…
#> 10   2024     1    10      10 FALSE  NA         SELECTIO… 108119     http://spo…
#> # ℹ 48 more rows
#> # ℹ 2 more variables: team_id <chr>, team_ref <chr>
# }
```
