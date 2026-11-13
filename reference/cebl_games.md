# **Get CEBL Games**

Schedule and results of one season (regular season and finals), with the
Genius match id that joins play-by-play and shots; optionally one team's
games.

Endpoint: `GET https://api.data.cebl.ca/games/{season}/`

## Usage

``` r
cebl_games(season, team_id = NULL)
```

## Arguments

- season:

  (required) Season: the calendar year it is played in (May to August) =
  the sdv END year (2025 = the 2025 season). The CEBL's first season
  is 2019. A season with no data answers `hoopR_no_data`.

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_games")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

## See also

Other CEBL Functions:
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_games(season = 2025))
#> ── CEBL Games from the CEBL Stats API ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:42 UTC
#> # A tibble: 128 × 27
#>    season  game_id genius_match_id start_time_utc      competition status period
#>     <int>    <int>           <int> <dttm>              <chr>       <chr>   <int>
#>  1   2025 14708701         2600563 2025-05-11 22:00:00 REGULAR     COMPL…     NA
#>  2   2025 14708702         2600564 2025-05-16 01:30:00 REGULAR     COMPL…     NA
#>  3   2025 14708703         2600565 2025-05-16 23:00:00 REGULAR     COMPL…     NA
#>  4   2025 14708704         2600566 2025-05-17 00:30:00 REGULAR     COMPL…     NA
#>  5   2025 14708705         2600567 2025-05-18 19:00:00 REGULAR     COMPL…     NA
#>  6   2025 14708706         2600568 2025-05-18 20:00:00 REGULAR     COMPL…     NA
#>  7   2025 14708707         2600569 2025-05-21 23:30:00 REGULAR     COMPL…     NA
#>  8   2025 14708708         2600570 2025-05-23 01:30:00 REGULAR     COMPL…     NA
#>  9   2025 14708709         2600571 2025-05-23 02:00:00 REGULAR     COMPL…     NA
#> 10   2025 14708711         2600573 2025-05-24 00:30:00 REGULAR     COMPL…     NA
#> # ℹ 118 more rows
#> # ℹ 20 more variables: venue_name <chr>, home_team_id <int>,
#> #   home_team_name <chr>, home_team_score <int>, away_team_id <int>,
#> #   away_team_name <chr>, away_team_score <int>, home_team_logo_url <chr>,
#> #   home_team_stats_url_en <chr>, home_team_stats_url_fr <chr>,
#> #   away_team_logo_url <chr>, away_team_stats_url_en <chr>,
#> #   away_team_stats_url_fr <chr>, stats_url_en <chr>, stats_url_fr <chr>, …
# }
```
