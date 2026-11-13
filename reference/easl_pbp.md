# **Get EASL Play-by-Play**

Play-by-play of a finished game in delivered order, with the running
score and the points each event scored.

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/playbyplay`

## Usage

``` r
easl_pbp(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## Event descriptions

- Shot types: Jump shot, Layup, Driving layup, Pull-up jump shot,
  Floating jump shot, Tip-in, Fadeaway, Step-back jump shot, Turnaround
  jump shot, Hook shot, Dunk, Reverse layup, Alley-oop, Alley-oop dunk,
  Euro step (none on 23 rows: '3pt missed').

- Shot modifiers: in the paint, second chance, from turnover, fast
  break, blocked.

- Other events (complete list; N FT = free throws awarded): Assist;
  Block; Steal; Substitution in; Substitution out; Defensive rebound;
  Defensive rebound (team); Offensive rebound; Offensive rebound (team);
  Foul; Foul (N FT); Foul drawn; Foul drawn (N FT); Personal foul;
  Personal foul (N FT); Personal foul (shooting); Personal foul
  (shooting) (N FT); Offensive foul; Offensive foul (charge); Technical
  foul; Technical foul (N FT); Bench technical foul; Bench technical
  foul (N FT); Coach technical foul; Coach technical foul (N FT);
  Unsportsmanlike foul; Unsportsmanlike foul (N FT); Disqualifying foul
  (N FT); Jump ball won; Jump ball won (held ball); Jump ball lost; Full
  timeout; Short timeout; Media timeout; Commercial timeout; Officials
  timeout; Officials timeout (mandatory); Coach's challenge (pending);
  Coach's challenge (complete) - upheld; Coach's challenge (complete) -
  overturned; Instant replay review (complete) - upheld; Instant replay
  review (complete) - overturned; Turnover - Bad pass; Ball handling;
  Traveling; Out of bounds; Offensive; Backcourt violation; Double
  dribble; Carrying; Offensive goaltending; 3 second violation; 5 second
  violation; 5 second violation (team); 8 second violation (team); Shot
  clock violation (team); Other; Other (team).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_pbp(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Play-by-Play from easl.joshricha.com ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:13:50 UTC
#> # A tibble: 495 × 20
#>    fixture_id            event_number sequence period_id period_label event_time
#>    <chr>                        <int>    <int>     <int> <chr>        <chr>     
#>  1 10af8fd4-106e-11f1-9…            1        7         1 Q1           2026-03-2…
#>  2 10af8fd4-106e-11f1-9…            2        9         1 Q1           2026-03-2…
#>  3 10af8fd4-106e-11f1-9…            3       20         1 Q1           2026-03-2…
#>  4 10af8fd4-106e-11f1-9…            4       21         1 Q1           2026-03-2…
#>  5 10af8fd4-106e-11f1-9…            5       31         1 Q1           2026-03-2…
#>  6 10af8fd4-106e-11f1-9…            6       29         1 Q1           2026-03-2…
#>  7 10af8fd4-106e-11f1-9…            7       37         1 Q1           2026-03-2…
#>  8 10af8fd4-106e-11f1-9…            8       53         1 Q1           2026-03-2…
#>  9 10af8fd4-106e-11f1-9…            9       54         1 Q1           2026-03-2…
#> 10 10af8fd4-106e-11f1-9…           10       43         1 Q1           2026-03-2…
#> # ℹ 485 more rows
#> # ℹ 14 more variables: received_time <dbl>, description <chr>, team_id <chr>,
#> #   player_id <chr>, player_name <chr>, player_name_latin <chr>,
#> #   jersey_number <chr>, team_score <int>, opponent_score <int>,
#> #   points_scored <int>, team1_id <chr>, team1_score <int>, team2_id <chr>,
#> #   team2_score <int>
# }
```
