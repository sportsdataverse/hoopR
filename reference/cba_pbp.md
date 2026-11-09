# **Get CBA Play-by-Play**

Play-by-play of a finished game, every period merged, oldest first
(Chinese text; no player or team ids).

Endpoint:
`POST https://data-server.cbaleague.com/api/schedule-eventses/filterPage`
(JSON body)

## Usage

``` r
cba_pbp(schedule_id, quarter_num = NULL)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

- quarter_num:

  (optional) Optional period number. Omitted = every period (the API
  serves one period per request; the runtime fetches them all and checks
  the set).

## Value

A `hoopR_data` tibble: One row per play, oldest first, all periods. An
empty valid answer is a zero-row tibble with these columns, in this
order (sportsdataverse-py `cba_pbp`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| bt_textual_format | character | Second copy of the description; equal to textualFormat on every sampled row (unverified difference). |
| color | character | Hex colour of the acting team (homeColor or visitingColor). |
| distance | character | Unobserved: null in every sample (a shot distance slot). The API has NO shot x/y coordinates. |
| home_color | character | Home team colour '#RRGGBB'. |
| home_score | integer | Home team points after the play. NOT monotone row by row: a substitution row can carry a stale score (2017 game, Q1 0:40); the game's final score is the maximum. |
| minutes | integer | Game clock, minutes REMAINING in the period (counts down: 10 or 12 at the start, depending on the era). |
| player_cn_names | character | Names (Chinese surnames/short names) of the players in textualFormat, in order of mention (shooter or fouler first, then assister, rebounder or fouled player). 0-3 names. There are NO player ids in the play-by-play. |
| player_fouls | character | Unobserved: null in every sample (a player's fouls slot). |
| player_score | character | Unobserved: null in every sample (a player's points slot). |
| quarter_num | integer | Period of the row (1-4; 5+ would be overtime). Equals the request's quarterNum on every row. |
| seconds | integer | Game clock, seconds remaining within the minute. |
| team_cn_alias1 | character | Unobserved: null in every sample (a team-name slot). |
| team_cn_alias2 | character | Unobserved: null in every sample (a team-name slot). |
| team_cn_alias3 | character | Unobserved: null in every sample (a team-name slot). |
| textual_format | character | Play description sentence (Chinese) naming the players; the phrase glossary translates every form seen. Team names inside it can be a different era's name than the game header (a 2025-26 text reads (Chinese text)). Sentence forms (`{P}` a player, `{T}` a team): ``` {T}``{T} ``` substitution, `{P}` replaces `{P}`; `{P}` three-point jump shot, misses, `{P}` gets the defensive rebound; `{P}` layup (driving), scores; `{P}` takes two free throws, free throw 2 made; (Chinese text) (Chinese text) = `{P}` shooting foul on the opponent's shot (drawn by an unnamed player); `{P}` receives an assist from `{P}`, jump shot, three-pointer made; the full glossary is in cba_glossary.yaml. |
| type | integer | Team the play belongs to: 1 = home, 2 = visiting (checked on all 667 rows of two games: color equals homeColor when 1 and visitingColor when 2). See the code table. |
| visiting_color | character | Visiting team colour '#RRGGBB'. |
| visitor_score | integer | Visiting team points after the play (same caveat as homeScore). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  # First quarter only; omit quarter_num for the whole game.
  try(cba_pbp(schedule_id = 100105799, quarter_num = 1))
#> ── CBA Play-by-Play from data-server.cbaleague.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:02:48 UTC
#> # A tibble: 74 × 19
#>    schedule_id bt_textual_format    color distance home_color home_score minutes
#>          <int> <chr>                <chr> <chr>    <chr>           <int>   <int>
#>  1   100105799 刘传兴和卡尔顿跳球，山西汾酒队得到球权… #7E0… NA       #E0B71B             0      10
#>  2   100105799 刘传兴勾手投篮不中，卡尔顿获得防守篮板… #7E0… NA       #E0B71B             0       9
#>  3   100105799 布朗三分跳投不中，刘传兴获得防守篮板…… #E0B… NA       #E0B71B             0       9
#>  4   100105799 焦海龙接到迪亚洛的助攻，跳投，三分入网… #7E0… NA       #E0B71B             0       9
#>  5   100105799 卡尔顿接到布朗的助攻，带球上篮得分…… #E0B… NA       #E0B71B             2       9
#>  6   100105799 刘传兴在对方投篮时犯规 (卡尔顿造成了… #7E0… NA       #E0B71B             2       9
#>  7   100105799 卡尔顿罚球不中，刘传兴获得防守篮板…… #E0B… NA       #E0B71B             2       9
#>  8   100105799 黑根斯失误，被卡尔顿断下…… #7E0… NA       #E0B71B             2       8
#>  9   100105799 卡尔顿跳投，被刘传兴盖掉，刘传兴获得防… #E0B… NA       #E0B71B             2       8
#> 10   100105799 迪亚洛失误，被布朗断下…… #7E0… NA       #E0B71B             2       8
#> # ℹ 64 more rows
#> # ℹ 12 more variables: player_cn_names <chr>, player_fouls <chr>,
#> #   player_score <chr>, quarter_num <int>, seconds <int>, team_cn_alias1 <chr>,
#> #   team_cn_alias2 <chr>, team_cn_alias3 <chr>, textual_format <chr>,
#> #   type <int>, visiting_color <chr>, visitor_score <int>
# }
```
