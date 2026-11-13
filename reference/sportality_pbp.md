# **Get Basketligaen Play-by-Play**

Play-by-play events with shot coordinates and the Genius ids (2023/24
on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/play-by-play/{game_uuid}`

## Usage

``` r
sportality_pbp(game_uuid)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## Sub-type codes

The values of `sub_type`:

- `1of1`: free throw 1 of 1

- `1of2`: free throw 1 of 2

- `1of3`: free throw 1 of 3

- `24sec`: shot-clock violation

- `2of2`: free throw 2 of 2

- `2of3`: free throw 2 of 3

- `3of3`: free throw 3 of 3

- `3sec`: three-second violation

- `5sec`: five-second violation

- `8sec`: eight-second violation

- `adjustment`: clock adjustment

- `alleyoop`: alley-oop shot

- `alleyoopdunk`: alley-oop dunk

- `backcourt`: backcourt violation

- `badpass`: bad pass

- `ballhandling`: ball-handling error

- `benchTechnical`: technical foul on the bench

- `coachTechnical`: technical foul on the coach

- `defensive`: defensive rebound

- `disqualifying`: disqualifying foul

- `disruptive`: disruptive foul (unverified)

- `doubledribble`: double dribble

- `drivinglayup`: driving layup

- `dunk`: dunk

- `end`: end of the period or game

- `eurostep`: euro-step layup

- `fadeaway`: fadeaway jump shot

- `flagrant`: flagrant foul

- `floatingjumpshot`: floating jump shot

- `full`: full timeout

- `heldball`: held ball

- `hookshot`: hook shot

- `in`: player enters

- `jumpshot`: jump shot

- `layup`: layup

- `lodgedball`: lodged ball

- `lost`: lost the jump ball

- `offensive`: offensive rebound or offensive foul

- `offensivegoaltending`: offensive goaltending

- `officials`: official timeout

- `other`: other

- `out`: player leaves

- `outofbounds`: out of bounds

- `outofboundsrebound`: rebound off an out-of-bounds ball (unverified)

- `personal`: personal foul

- `pullupjumpshot`: pull-up jump shot

- `reverselayup`: reverse layup

- `start`: start of the period or game, or clock start

- `startperiod`: start of a period (jump ball line)

- `stepbackjumpshot`: step-back jump shot

- `stop`: clock stop

- `technical`: technical foul

- `throwIn`: throw-in violation (unverified)

- `tipindunk`: tip-in dunk

- `tipinlayup`: tip-in layup

- `travel`: traveling

- `turnaroundjumpshot`: turnaround jump shot

- `unsportsmanlike`: unsportsmanlike foul

- `won`: won the jump ball

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_pbp(game_uuid = "c4hh5nig6t"))
#> ── Basketligaen Play-by-Play from basketligaen.dk ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:19:28 UTC
#> # A tibble: 804 × 49
#>    game_source_id game_id event_id type     event_uuid  period period_type time 
#>             <int>   <int>    <int> <chr>    <chr>        <int> <chr>       <chr>
#>  1        2868126 2868126      800 game     75a1c424-6…      4 REGULAR     00:0…
#>  2        2868126 2868126      799 period   c7995db4-5…      4 REGULAR     00:0…
#>  3        2868126 2868126      798 clock    e67997fb-e…      4 REGULAR     00:0…
#>  4        2868126 2868126      797 clock    0de6a3c7-0…      4 REGULAR     00:0…
#>  5        2868126 2868126      796 2pt      cc616d49-8…      4 REGULAR     00:0…
#>  6        2868126 2868126      795 clock    84f92014-b…      4 REGULAR     00:0…
#>  7        2868126 2868126      794 clock    cf232264-d…      4 REGULAR     00:0…
#>  8        2868126 2868126      793 clock    1b5da16a-4…      4 REGULAR     00:1…
#>  9        2868126 2868126      792 turnover 504e3200-3…      4 REGULAR     00:1…
#> 10        2868126 2868126      791 clock    8a7eacf6-f…      4 REGULAR     00:1…
#> # ℹ 794 more rows
#> # ℹ 41 more variables: real_world_time <chr>, updated_time <chr>,
#> #   home_team_id <int>, home_team_code <chr>, home_team_name <chr>,
#> #   home_abbreviation <chr>, home_team_number <int>, home_place <chr>,
#> #   home_score <int>, away_team_id <int>, away_team_code <chr>,
#> #   away_team_name <chr>, away_abbreviation <chr>, away_team_number <int>,
#> #   away_place <chr>, away_score <int>, revision <int>, game_state <chr>, …
# }
```
