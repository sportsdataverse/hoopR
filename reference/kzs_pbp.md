# **Get KZS Play-by-Play**

Play-by-play of a final game (2015/16 on, with gaps), one row per action
with shot x/y.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`

## Usage

``` r
kzs_pbp(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per action with shot x/y. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_pbp(match_id = 101839))
#> ── KZS Play-by-Play from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:16:48 UTC
#> # A tibble: 816 × 27
#>    match_id action_number team_side source clock action_type sub_type qualifiers
#>       <int>         <int> <chr>     <chr>  <chr> <chr>       <chr>    <chr>     
#>  1   101839             1 NA        GENIU… 10:0… game        "start"  ""        
#>  2   101839             2 NA        GENIU… 10:0… period      "start"  ""        
#>  3   101839             3 NA        GENIU… 10:0… clock       "start"  ""        
#>  4   101839             4 NA        GENIU… 10:0… jumpball    "startp… ""        
#>  5   101839             5 away      GENIU… 09:5… jumpball    "won"    ""        
#>  6   101839             6 home      GENIU… 09:5… jumpball    "lost"   ""        
#>  7   101839             7 NA        GENIU… 09:5… clock       "stop"   ""        
#>  8   101839             8 away      GENIU… 09:5… 2pt         "drivin… "pointsin…
#>  9   101839             9 home      GENIU… 09:5… foul        "person… "shooting…
#> 10   101839            10 away      GENIU… 09:5… foulon      ""       ""        
#> # ℹ 806 more rows
#> # ℹ 19 more variables: x <dbl>, y <dbl>, area <chr>, side <chr>, success <lgl>,
#> #   score1 <int>, score2 <int>, period <int>, period_type <chr>, part <chr>,
#> #   match_team_player_id <int>, player_id <int>,
#> #   match_team_player_first_name <chr>, match_team_player_last_name <chr>,
#> #   team_application_id <int>, team_name <chr>, match_team_id <int>,
#> #   player_photo_uuid <chr>, shirt_number <chr>
# }
```
