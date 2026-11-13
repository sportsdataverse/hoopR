# **Get CEBL Standings**

Standings of one season, one row per team: record, home/away splits,
games behind, streak.

Endpoint: `GET https://api.data.cebl.ca/teams/{season}/`

## Usage

``` r
cebl_standings(season)
```

## Arguments

- season:

  (required) Season: the calendar year it is played in (May to August) =
  the sdv END year (2025 = the 2025 season). The CEBL's first season
  is 2019. A season with no data answers `hoopR_no_data`.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_standings")`) and in the searchable
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
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_standings(season = 2025))
#> ── CEBL Standings from the CEBL Stats API ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:46 UTC
#> # A tibble: 10 × 30
#>    season team_id name_en         short_name_en name_fr short_name_fr conference
#>     <int>   <int> <chr>           <chr>         <chr>   <chr>         <chr>     
#>  1   2025      14 Niagara River … Niagara       River … Niagara       EAST      
#>  2   2025      16 Vancouver Band… Vancouver     Les Ba… Vancouver     WEST      
#>  3   2025      17 Calgary Surge   Calgary       Surge … Calgary       WEST      
#>  4   2025      20 Ottawa BlackJa… Ottawa        BlackJ… Ottawa        EAST      
#>  5   2025      18 Edmonton Sting… Edmonton      Stinge… Edmonton      WEST      
#>  6   2025      22 Scarborough Sh… Scarborough   Shooti… Scarborough   EAST      
#>  7   2025      21 Montreal Allia… Montreal      Allian… Montréal      EAST      
#>  8   2025      24 Winnipeg Sea B… Winnipeg      Sea Be… Winnipeg      WEST      
#>  9   2025      19 Brampton Honey… Brampton      Honey … Brampton      EAST      
#> 10   2025      15 Saskatchewan R… Saskatchewan  Rattle… Saskatchewan  WEST      
#> # ℹ 23 more variables: position <int>, played <int>, wins <int>,
#> #   win_percentage <dbl>, home_wins <int>, away_wins <int>, losses <int>,
#> #   home_losses <int>, away_losses <int>, games_behind <dbl>,
#> #   points_difference <int>, last_five <chr>, streak <chr>, logo_url <chr>,
#> #   icon_url <chr>, tickets_url_en <chr>, tickets_url_fr <chr>,
#> #   website_url_en <chr>, website_url_fr <chr>, shop_url_en <chr>,
#> #   shop_url_fr <chr>, stats_url_en <chr>, stats_url_fr <chr>
# }
```
