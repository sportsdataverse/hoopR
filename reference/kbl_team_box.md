# **Get KBL Team Box Score**

Team box score of a final game with advanced rates and team-only counts,
one row per team.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/team-record`

## Usage

``` r
kbl_team_box(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_team_box")`) and in the searchable
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
  try(kbl_team_box(gmkey = "S47G01N49"))
#> ── KBL Team Box Score from api.kbl.or.kr ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:36:45 UTC
#> # A tibble: 2 × 68
#>   gmkey   season_code season game_code game_no team_code score    fg  fg_a   fgt
#>   <chr>         <int>  <int> <chr>       <int> <chr>     <int> <int> <int> <int>
#> 1 S47G01…          47   2026 01             49 50           64    14    35    25
#> 2 S47G01…          47   2026 01             49 66           74    23    43    30
#> # ℹ 58 more variables: fgt_a <int>, threep <int>, threep_a <int>, ft <int>,
#> #   ft_a <int>, dk <int>, dk_a <int>, rb <int>, offr <int>, defr <int>,
#> #   ast <int>, stl <int>, bs <int>, to <int>, foul <int>, wft <int>,
#> #   woft <int>, pp <int>, pp_a <int>, pscore <int>, sast <int>, dfl <int>,
#> #   gd <int>, idf <int>, fb <int>, ef <int>, tf <int>, inout <int>,
#> #   inout1 <int>, play_min <int>, play_sec <int>, bf <int>, foulout <int>,
#> #   team_r <int>, tfb <int>, tto <int>, fb_score_cn <int>, …
# }
```
