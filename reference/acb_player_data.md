# **Get ACB Player Data**

Player biography: birth, nationality, height, current team and social
links.

One row. `birth_date` is a date (the API sends DD-MM-YYYY); `height_m`
is metres (the API sends `'2,20'`, a decimal comma); `birth_country` /
`nationality` are Spanish with ISO alpha-2 in `*_iso`; `licensing` is
the licence code as sent (for example `EUR` or `JFL`; meanings
unverified). The current team columns are the player's team entry for
the edition.

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/player-data`

## Usage

``` r
acb_player_data(player_id)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_data")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_player_data(player_id = 20209407))
#> ── ACB Player Data from api2.acb.com ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:32:55 UTC
#> # A tibble: 1 × 28
#>   player_id player_name first_name last_name shirt_number game_role
#>       <int> <chr>       <chr>      <chr>     <chr>        <chr>    
#> 1  20209407 Edy Tavares Walter     Tavares   22           Pívot    
#> # ℹ 22 more variables: is_license_active <lgl>, licensing <chr>,
#> #   birth_date <date>, birth_place <chr>, birth_country <chr>,
#> #   birth_country_iso <chr>, nationality <chr>, nationality_iso <chr>,
#> #   height_m <dbl>, player_number <int>, team_id <int>, club_id <int>,
#> #   team <chr>, team_abbr <chr>, edition_id <int>, season <int>,
#> #   instagram <chr>, twitter <chr>, facebook <chr>, youtube <chr>,
#> #   tiktok <chr>, pronunciation_url <chr>
# }
```
