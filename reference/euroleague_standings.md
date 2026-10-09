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
  `"aheadbehind"`, matched exactly (no prefixes, as in sdv-py); the
  columns depend on it (see Returns).

## Value

A `hoopR_data` tibble with one row per team. The columns depend on
`kind`:

**`kind = "basicstandings"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| position | integer | Position code of the player (engine integer). |
| position_change | character | Movement since the previous round (Up, Down, Equal). |
| games_played | integer | Games played. |
| games_won | integer | Games won. |
| games_lost | integer | Games lost. |
| qualified | logical | Whether the team has clinched qualification for the next phase. |
| win_percentage | character | Win percentage, formatted (e.g. 100%). |
| points_difference | character | Points for minus points against, signed and formatted (e.g. +19). |
| points_for | integer | Points scored. |
| points_against | integer | Points conceded. |
| home_record | character | Home win-loss record (W-L). |
| away_record | character | Away win-loss record (W-L). |
| neutral_record | character | Neutral-venue win-loss record (W-L). |
| overtime_record | character | Overtime win-loss record (W-L). |
| last_ten_record | character | Win-loss record over the last ten games (W-L). |
| group_name | character | Group: display name. |
| last5_form | character | Results of the last five games, oldest first (W / L), JSON-encoded. |
| club_code | character | Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| club_name | character | Club: display name. |
| club_abbreviated_name | character | Club: abbreviated display name. |
| club_editorial_name | character | Club: editorial (long-form) display name. |
| club_tv_code | character | Club: three-letter broadcast abbreviation of the club. |
| club_is_virtual | logical | Club: whether the club is a placeholder rather than a real club. |
| club_images_crest | character | Club: URL of the club crest image. |

**`kind = "calendarstandings"`** (the `streaks` cell is JSON text:
semantically equal to sdv-py's, not byte-equal – separators and unicode
escaping differ)

|  |  |  |
|----|----|----|
| col_name | types | description |
| position | integer | Position code of the player (engine integer). |
| position_change | character | Movement since the previous round (Up, Down, Equal). |
| games_played | integer | Games played. |
| games_won | integer | Games won. |
| games_lost | integer | Games lost. |
| qualified | logical | Whether the team has clinched qualification for the next phase. |
| group_name | character | Group: display name. |
| streaks | character | Per-round result streaks: start date, end date and W-L record of each run, JSON-encoded. |
| club_code | character | Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| club_name | character | Club: display name. |
| club_abbreviated_name | character | Club: abbreviated display name. |
| club_editorial_name | character | Club: editorial (long-form) display name. |
| club_tv_code | character | Club: three-letter broadcast abbreviation of the club. |
| club_is_virtual | logical | Club: whether the club is a placeholder rather than a real club. |
| club_images_crest | character | Club: URL of the club crest image. |

**`kind = "streaks"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| position | integer | Position code of the player (engine integer). |
| position_change | character | Movement since the previous round (Up, Down, Equal). |
| games_played | integer | Games played. |
| games_won | integer | Games won. |
| games_lost | integer | Games lost. |
| qualified | logical | Whether the team has clinched qualification for the next phase. |
| home_record | character | Home win-loss record (W-L). |
| away_record | character | Away win-loss record (W-L). |
| last10 | character | Win-loss record over the last ten games (W-L). |
| home_last5 | character | Win-loss record over the last five home games (W-L). |
| away_last5 | character | Win-loss record over the last five away games (W-L). |
| longest_wins_streak_current_season | integer | Longest winning streak this season. |
| longest_loses_streak_current_season | integer | Longest losing streak this season. |
| longest_wins_streak_any_season | integer | Longest winning streak in any season. |
| longest_loses_streak_any_season | integer | Longest losing streak in any season. |
| group_name | character | Group: display name. |
| club_code | character | Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| club_name | character | Club: display name. |
| club_abbreviated_name | character | Club: abbreviated display name. |
| club_editorial_name | character | Club: editorial (long-form) display name. |
| club_tv_code | character | Club: three-letter broadcast abbreviation of the club. |
| club_is_virtual | logical | Club: whether the club is a placeholder rather than a real club. |
| club_images_crest | character | Club: URL of the club crest image. |

**`kind = "aheadbehind"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| position | integer | Position code of the player (engine integer). |
| position_change | character | Movement since the previous round (Up, Down, Equal). |
| games_played | integer | Games played. |
| games_won | integer | Games won. |
| games_lost | integer | Games lost. |
| qualified | logical | Whether the team has clinched qualification for the next phase. |
| wins_percentage | character | Win percentage, formatted (e.g. 100%). |
| quater1_ahead | character | Win-loss record when ahead after the 1st quarter (W-L; sic: the API spells quarter this way). |
| quater1_behind | character | Win-loss record when behind after the 1st quarter (W-L; sic: the API spells quarter this way). |
| quater1_tied | character | Win-loss record when tied after the 1st quarter (W-L; sic: the API spells quarter this way). |
| half1_ahead | character | Win-loss record when ahead at the half (W-L; sic: the API spells quarter this way). |
| half1_behind | character | Win-loss record when behind at the half (W-L; sic: the API spells quarter this way). |
| half1_tied | character | Win-loss record when tied at the half (W-L; sic: the API spells quarter this way). |
| quater3_ahead | character | Win-loss record when ahead after the 3rd quarter (W-L; sic: the API spells quarter this way). |
| quater3_behind | character | Win-loss record when behind after the 3rd quarter (W-L; sic: the API spells quarter this way). |
| quater3_tied | character | Win-loss record when tied after the 3rd quarter (W-L; sic: the API spells quarter this way). |
| group_name | character | Group: display name. |
| club_code | character | Club: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| club_name | character | Club: display name. |
| club_abbreviated_name | character | Club: abbreviated display name. |
| club_editorial_name | character | Club: editorial (long-form) display name. |
| club_tv_code | character | Club: three-letter broadcast abbreviation of the club. |
| club_is_virtual | logical | Club: whether the club is a placeholder rather than a real club. |
| club_images_crest | character | Club: URL of the club crest image. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sdv-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

Other Euroleague:
[`euroleague_clubs()`](https://hoopR.sportsdataverse.org/reference/euroleague_clubs.md),
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md),
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_standings(competition_code = "E", season_code = "E2025", round = 1)
    euroleague_standings(competition_code = "E", season_code = "E2025", round = 1, kind = "streaks")
  })
#> ── EuroLeague standings streaks from api-live.euroleague.net ───────────────────
#> ℹ Data updated: 2026-10-09 03:49:00 UTC
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
