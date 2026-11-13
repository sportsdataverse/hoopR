# **EuroLeague Standings**

**Get the standings as of a round: basic (W-L, points, home / away /
last-10 records), calendar (per-round result streaks), streaks (longest
win / loss runs) or aheadbehind (records when ahead / behind / tied
after Q1, the half and Q3), one row per team.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/seasons/{season_code}/rounds/{round}/{kind}`

The standings live under a **round**, not the season: pass the `round`
number the table should be as of (the `round` column of
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md)).
The season winner block of the payload is dropped (it is `null` while
the season is in progress).

## Usage

``` r
euroleague_standings(
  competition_code,
  season_code,
  round,
  kind = c("basicstandings", "calendarstandings", "streaks", "aheadbehind")
)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

- round:

  (*integer* required): Round number within the season; the standings
  are as of this round.

- kind:

  (*character* default `"basicstandings"`): Standings table, one of
  `"basicstandings"`, `"calendarstandings"`, `"streaks"` or
  `"aheadbehind"`, matched exactly (no prefixes, as in
  sportsdataverse-py); the columns depend on it (see Returns).

## Value

A `hoopR_data` tibble with one row per team. Its columns depend on
`kind`: `"basicstandings"`, `"calendarstandings"`, `"streaks"`,
`"aheadbehind"`. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sportsdataverse-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_standings(competition_code = "E", season_code = "E2025", round = 1)
    euroleague_standings(competition_code = "E", season_code = "E2025", round = 1, kind = "streaks")
  })
#> ── EuroLeague standings streaks from api-live.euroleague.net ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:02 UTC
#> # A tibble: 20 × 23
#>    position position_change games_played games_won games_lost qualified
#>       <int> <chr>                  <int>     <int>      <int> <lgl>    
#>  1        1 Equal                      1         1          0 FALSE    
#>  2        2 Equal                      1         1          0 FALSE    
#>  3        3 Equal                      1         1          0 FALSE    
#>  4        4 Equal                      1         1          0 FALSE    
#>  5        5 Equal                      1         1          0 FALSE    
#>  6        6 Equal                      1         1          0 FALSE    
#>  7        7 Equal                      1         1          0 FALSE    
#>  8        8 Equal                      1         1          0 FALSE    
#>  9        9 Equal                      1         1          0 FALSE    
#> 10       10 Equal                      1         1          0 FALSE    
#> 11       11 Equal                      1         0          1 FALSE    
#> 12       12 Equal                      1         0          1 FALSE    
#> 13       13 Equal                      1         0          1 FALSE    
#> 14       14 Equal                      1         0          1 FALSE    
#> 15       15 Equal                      1         0          1 FALSE    
#> 16       16 Equal                      1         0          1 FALSE    
#> 17       17 Equal                      1         0          1 FALSE    
#> 18       18 Equal                      1         0          1 FALSE    
#> 19       19 Equal                      1         0          1 FALSE    
#> 20       20 Equal                      1         0          1 FALSE    
#> # ℹ 17 more variables: home_record <chr>, away_record <chr>, last10 <chr>,
#> #   home_last5 <chr>, away_last5 <chr>,
#> #   longest_wins_streak_current_season <int>,
#> #   longest_loses_streak_current_season <int>,
#> #   longest_wins_streak_any_season <int>,
#> #   longest_loses_streak_any_season <int>, group_name <chr>, club_code <chr>,
#> #   club_name <chr>, club_abbreviated_name <chr>, club_editorial_name <chr>, …
# }
```
