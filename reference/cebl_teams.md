# **Get CEBL Teams**

Every franchise identity, past and present (15 team ids; a relocated
franchise has a second id).

Endpoint: `GET https://api.data.cebl.ca/teams/`

## Usage

``` r
cebl_teams()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md)

## Examples

``` r
# \donttest{
  try(cebl_teams())
#> ── CEBL Teams from the CEBL Stats API ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:34:00 UTC
#> # A tibble: 15 × 8
#>    team_id name_en        short_name_en name_fr short_name_fr is_active logo_url
#>      <int> <chr>          <chr>         <chr>   <chr>         <lgl>     <chr>   
#>  1      16 Vancouver Ban… Vancouver     Les Ba… Vancouver     TRUE      https:/…
#>  2      22 Scarborough S… Scarborough   Shooti… Scarborough   TRUE      https:/…
#>  3      23 Newfoundland … Newfoundland  Growle… Terre-Neuve   FALSE     https:/…
#>  4      14 Niagara River… Niagara       River … Niagara       TRUE      https:/…
#>  5      54 Fraser Valley… Fraser Valley Les Ba… Fraser Valley FALSE     https:/…
#>  6      18 Edmonton Stin… Edmonton      Stinge… Edmonton      TRUE      https:/…
#>  7      15 Saskatchewan … Saskatchewan  Rattle… Saskatchewan  FALSE     https:/…
#>  8      53 Guelph Nighth… Guelph        Les Ni… Guelph        FALSE     https:/…
#>  9      55 Hamilton Hone… Hamilton      Honey … Hamilton      FALSE     https:/…
#> 10      21 Montreal Alli… Montreal      Allian… Montréal      TRUE      https:/…
#> 11      20 Ottawa BlackJ… Ottawa        BlackJ… Ottawa        TRUE      https:/…
#> 12      17 Calgary Surge  Calgary       Surge … Calgary       TRUE      https:/…
#> 13      19 Brampton Hone… Brampton      Honey … Brampton      TRUE      https:/…
#> 14      56 Saskatoon Mam… Saskatoon     Saskat… Saskatoon     TRUE      https:/…
#> 15      24 Winnipeg Sea … Winnipeg      Sea Be… Winnipeg      TRUE      https:/…
#> # ℹ 1 more variable: icon_url <chr>
# }
```
