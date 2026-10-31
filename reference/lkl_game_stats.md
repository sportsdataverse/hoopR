# **LKL Game Stats**

Statistics tab: the head-to-head comparison of both teams, one row per
statistic.

Endpoint: `GET https://lkl.lt/api/livestream/game-stats/{game_id}`

## Usage

``` r
lkl_game_stats(game_id)
```

## Arguments

- game_id:

  Required. lkl.lt game id (integer), e.g. 11446; `game_id` in
  lkl_results. Not sequential by season before 2018-19. Only a finished
  game is served.

## Value

A `hoopR_data` tibble. One row per line of `comparison.all`, with the
same columns as `lkl_summary`. `group` marks the lines the tab also
shows in its `shooting` (2PT, 3PT, free throws) and `main` (rebounds,
assists, steals) bar groups; it is null for the rest. A 2007-08 game has
only a few lines and a flat lead chart (no event data then). A body
without a comparison gives a zero-row tibble. Every column below is
always present (a zero-row tibble keeps them and their types); an answer
with nothing in it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | lkl.lt game id (key space: LKL games; the `{gameId}` of every route). Not sequential by season before 2018-19; not the Genius matchId. A frame parsed from a bare body has a null game_id when the body does not echo it (the runtime stamps it under `_request`). |
| group | character | Bar group the tab also shows the line in: shooting (2PT, 3PT, free throws) or main (rebounds, assists, steals); null for lines only in the full list. |
| stat | character | English code for the site's Lithuanian label (field_goals, two_pointers, three_pointers, free_throws, rebounds, assists, steals, blocks, turnovers, fouls, points, ...); null for a label this package does not know. |
| label | character | Row label in LITHUANIAN: 'Metimai is zaidimo' = field goals, 'Dvitaskiai metimai' = 2PT, 'Tritaskiai metimai' = 3PT, 'Baudu metimai' = free throws, 'Atkovoti kamuoliai' = rebounds, 'Atkovoti kamuoliai gynyboje' = defensive rebounds, 'Atkovoti kamuoliai puolime' = offensive rebounds, 'Rezultatyvus perdavimai' = assists, 'Perimti kamuoliai' = steals, 'Blokai' = blocks, 'Klaidos' = turnovers, 'Prazangos' = fouls, 'Taskai' = points, 'Taskai po klaidu' = points off turnovers, 'Taskai greitose atakose' = fast-break points, 'Taskai antru bandymu' = second-chance points, 'Atsarginiu zaideju taskai' = bench points. |
| home_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
| home_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
| home_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -\> 53.75). |
| home_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |
| away_value | character | Shooting rows: 'made/attempted' string ('25/35'); counting rows: integer. |
| away_percentage | double | Shooting rows only (absent on counting rows): percentage with ONE decimal and a % sign ('71.4%'). |
| away_graph_length | double | Bar length in percent: shooting rows = the percentage as a string ('71.4'); counting rows = this side's share of the two values, 0-100, a number (43 vs 37 -\> 53.75). |
| away_winning | logical | True when this side's bar is highlighted as the better one (both false on a tie). |

## Details

Unofficial and unsupported: these are the routes lkl.lt's own game page
calls (found in its front-end bundle) and its server-rendered pages. The
site's robots.txt allows everything and sets no crawl-delay; the runtime
still spaces requests at least 1 s apart. The site's terms were not
reviewed; check them before you republish the data.

Coverage: game wrappers serve FINISHED games only (an unfinished game
raises `hoopR_asset_fetch`). The box score, summary, score line,
statistics and leaders answer for every season from 1993-94 (before
2024-25 the scoring splits and lead statistics are 0). Play-by-play and
shots exist from 2024-25 only; an earlier finished game raises
`hoopR_no_data`. From 2016-17 the results season id is also the Genius
LiveStats competition id (see the `genius` family) which holds
play-by-play for older games; lkl.lt game, team and player ids are
lkl.lt's own and do not join Genius ids. The King Mindaugas Cup shares
the routes but is not wrapped. Text fields are Lithuanian.

Errors: `hoopR_no_data` when lkl.lt has nothing for the request (HTTP
404, an unknown game or standings season, a season the site's selects do
not list, a season without played games, a finished game before 2024-25
asked for play-by-play or shots); `hoopR_bad_request` for a game id or
season that is not an integer, or HTTP 400 / 422; `hoopR_asset_fetch`
when the fetch failed or the answer is not the one asked for (an
unfinished game, a body or page for another game or season, an error or
changed body, a truncated results list). All inherit `hoopR_error`.
Dates and times are Lithuanian local (Europe/Vilnius) as the site prints
them.

     lkl_game_stats(game_id = 11446)

## See also

Other LKL Functions:
[`lkl_game_info()`](https://hoopR.sportsdataverse.org/reference/lkl_game_info.md),
[`lkl_game_players()`](https://hoopR.sportsdataverse.org/reference/lkl_game_players.md),
[`lkl_game_score()`](https://hoopR.sportsdataverse.org/reference/lkl_game_score.md),
[`lkl_lead_chart()`](https://hoopR.sportsdataverse.org/reference/lkl_lead_chart.md),
[`lkl_leaders()`](https://hoopR.sportsdataverse.org/reference/lkl_leaders.md),
[`lkl_pbp()`](https://hoopR.sportsdataverse.org/reference/lkl_pbp.md),
[`lkl_period_scores()`](https://hoopR.sportsdataverse.org/reference/lkl_period_scores.md),
[`lkl_player_box()`](https://hoopR.sportsdataverse.org/reference/lkl_player_box.md),
[`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md),
[`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md),
[`lkl_standings()`](https://hoopR.sportsdataverse.org/reference/lkl_standings.md),
[`lkl_summary()`](https://hoopR.sportsdataverse.org/reference/lkl_summary.md),
[`lkl_team_box()`](https://hoopR.sportsdataverse.org/reference/lkl_team_box.md)
