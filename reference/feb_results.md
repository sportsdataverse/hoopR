# **FEB Results**

**Latest round's results and the next round's fixtures of a FEB
competition season.**

Endpoint:
`GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`

`section` is `results` (the LATEST round of the shown phase; for a
finished season the last playoff round) or `next_round` (empty once the
season is over). `comp_id` ties the site group to the API's competition
id (group 1 -\> 115, 2 -\> 118, 4 -\> 210).

## Usage

``` r
feb_results(group, season)
```

## Arguments

- group:

  (*integer* required): The site's menu group: 1 Primera FEB, 2 Segunda
  FEB, 4 Liga Femenina Endesa, 9 and 10 LF-2, 67 LF Challenge, 73 Copa
  de Espana, 74 Liga U. A group is not a competition id (see `comp_id`).

- season:

  (*integer* required): Season END year (`2027` = 2026-27), sent to the
  site as its START-year key `t = season - 1`.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
| season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
| competition | character | Competition name on the page header ('PRIMERA FEB'). |
| comp_id | integer | Competition id (CompID) read from the page; ties the site group to the API (group 1 -\> 115, 2 -\> 118, 4 -\> 210). |
| section | character | Which table the row comes from: results (the latest round) or next_round (the following fixtures). |
| round_title | character | Title of the table as printed ('Resultados Jornada 3(09/10/2026)'). |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| home_team_id | integer | Home team-season id (new every season; joins feb_overview and the game wrappers). |
| home_team | character | Home team name, uppercase. |
| away_team_id | integer | Away team-season id (new every season). |
| away_team | character | Away team name, uppercase. |
| result_text | character | Result cell verbatim: 'home-away' points when played; before the game the calendar shows the Spanish weekday, date and time and the results page shows '*-*'. |
| home_score | integer | Home points; null before the game. |
| away_score | integer | Away points; null before the game. |
| status | character | played when the result cell holds a score, scheduled otherwise. |
| date | Date | Game date; null for played games on the schedule page (use round_date). |
| time | character | Tip-off 'HH:MM', Spanish local time; null for played games on the schedule page. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_results(group = 1, season = 2027))
#> ── FEB results from baloncestoenvivo.feb.es ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:52:49 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id section    round_title  game_id home_team_id
#>    <int>  <int> <chr>         <int> <chr>      <chr>          <int>        <int>
#>  1     1   2027 PRIMERA FEB     115 results    Resultados … 2535772      1008400
#>  2     1   2027 PRIMERA FEB     115 results    Resultados … 2535773      1009109
#>  3     1   2027 PRIMERA FEB     115 results    Resultados … 2535776      1009095
#>  4     1   2027 PRIMERA FEB     115 results    Resultados … 2535777      1009584
#>  5     1   2027 PRIMERA FEB     115 results    Resultados … 2535778      1008900
#>  6     1   2027 PRIMERA FEB     115 results    Resultados … 2535770      1009929
#>  7     1   2027 PRIMERA FEB     115 results    Resultados … 2535771      1009713
#>  8     1   2027 PRIMERA FEB     115 results    Resultados … 2535774      1008378
#>  9     1   2027 PRIMERA FEB     115 results    Resultados … 2535775      1010493
#> 10     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535784      1010207
#> 11     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535782      1010494
#> 12     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535779      1009716
#> 13     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535780      1008687
#> 14     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535786      1009584
#> 15     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535785      1008797
#> 16     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535783      1009837
#> 17     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535787      1010324
#> 18     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535781      1009072
#> # ℹ 9 more variables: home_team <chr>, away_team_id <int>, away_team <chr>,
#> #   result_text <chr>, home_score <int>, away_score <int>, status <chr>,
#> #   date <date>, time <chr>
# }
```
