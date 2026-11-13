# **Get KBL Standings**

Standings of one competition with each team's season totals.

Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}`

## Usage

``` r
kbl_standings(season, division = "kbl", game_code = "01")
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

- division:

  'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League
  reserve league, seasonGrade 2, which has its own season codes; it
  starts with the 2009 summer edition).

- game_code:

  Competition inside the season, two digits: '01' regular season
  (default; the first stage of a D-League edition), '03' playoffs, '04'
  championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
  '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kbl_standings(season = 2025))
#> ── KBL Standings from api.kbl.or.kr ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:16:35 UTC
#> # A tibble: 10 × 64
#>    season season_code game_code  rank team_code team_name         team_name_full
#>     <int>       <int> <chr>     <int> <chr>     <chr>             <chr>         
#>  1   2025          45 01            1 55        서울 SK           서울 SK 나이츠
#>  2   2025          45 01            2 50        창원 LG           창원 LG 세이커스……
#>  3   2025          45 01            3 10        울산 현대모비스   울산 현대모비스 피버스……
#>  4   2025          45 01            4 06        수원 KT           수원 KT 소닉붐
#>  5   2025          45 01            5 64        대구 한국가스공사 대구 한국가스공사 페가수…
#>  6   2025          45 01            6 70        안양 정관장       안양 정관장 레드부스터스…
#>  7   2025          45 01            7 16        원주 DB           원주 DB 프로미
#>  8   2025          45 01            8 66        고양 소노         고양 소노 스카이거너스……
#>  9   2025          45 01            9 60        부산 KCC          부산 KCC 이지스……
#> 10   2025          45 01           10 35        서울 삼성         서울 삼성 썬더스……
#> # ℹ 57 more variables: game_count <int>, wins <int>, losses <int>, draws <int>,
#> #   win_rate <dbl>, win_diff <dbl>, home_wins <int>, home_losses <int>,
#> #   away_wins <int>, away_losses <int>, conti_win <int>, conti_loss <int>,
#> #   conti_date <date>, max_win <int>, max_loss <int>, last_game_date <date>,
#> #   last_five <chr>, last_game_won <lgl>, last_game_lost <lgl>,
#> #   last_game_drawn <lgl>, game_flag <lgl>, updated_at <chr>, score <int>,
#> #   fg <int>, fg_a <int>, threep <int>, threep_a <int>, ft <int>, ft_a <int>, …
# }
```
