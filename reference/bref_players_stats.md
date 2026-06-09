# **Basketball-Reference Player Season Stats**

**Get player season statistics from
[Basketball-Reference](https://www.basketball-reference.com).**

Scrapes the league-wide player stat table for a season. No API key is
required. Choose the stat table with `table`. Data is available back to
the 1947 (BAA) season for most tables.

Basketball-Reference rate-limits aggressive scraping (~20
requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_players_stats(season = most_recent_nba_season(), table = "per_game")
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024` for the 2023-24 season). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- table:

  (*character* optional): Which stat table to return. One of `per_game`
  (default), `totals`, `advanced`, `per_minute` (per 36 minutes), or
  `per_poss` (per 100 possessions).

## Value

A `hoopR_data` tibble with one row per player (columns vary by `table`;
common identifying columns shown – column names are Basketball-Reference
`data-stat` keys):

|           |           |                                                       |
|-----------|-----------|-------------------------------------------------------|
| col_name  | types     | description                                           |
| ranker    | integer   | Row rank.                                             |
| player    | character | Player name.                                          |
| age       | integer   | Player age on Feb 1 of the season.                    |
| team_id   | character | Team abbreviation (`TOT` for players on \>1 team).    |
| pos       | character | Position.                                             |
| g         | integer   | Games played.                                         |
| gs        | integer   | Games started.                                        |
| mp_per_g  | numeric   | Minutes (per_game table) / `mp` total (totals table). |
| pts_per_g | numeric   | Points (scaled to the chosen `table`).                |
| season    | integer   | Season (echoes the `season` argument).                |

The `advanced` table adds `per`, `ts_pct`, `usg_pct`, `ws`, `bpm`,
`vorp`, etc.; `totals`/`per_minute`/`per_poss` return the same box
categories scaled accordingly.

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_players_stats(season = 2024, table = "per_game"))
#> ── Player season stats from basketball-reference.com ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 19:58:24 UTC
#> # A tibble: 736 × 32
#>    ranker player         age team  pos       g    gs mp_per_g fg_per_g fga_per_g
#>     <dbl> <chr>        <dbl> <chr> <chr> <dbl> <dbl>    <dbl>    <dbl>     <dbl>
#>  1      1 Joel Embiid     29 PHI   C        39    39     33.6     11.5      21.8
#>  2      2 Luka Dončić     24 DAL   PG       70    70     37.5     11.5      23.6
#>  3      3 Giannis Ant…    29 MIL   PF       73    73     35.2     11.5      18.8
#>  4      4 Shai Gilgeo…    25 OKC   PG       75    75     34       10.6      19.8
#>  5      5 Jalen Bruns…    27 NYK   PG       77    77     35.4     10.3      21.4
#>  6      6 Devin Booker    27 PHO   PG       68    68     36        9.4      19.2
#>  7      7 Kevin Durant    35 PHO   PF       75    75     37.2     10        19.1
#>  8      8 Jayson Tatum    25 BOS   PF       74    74     35.7      9.1      19.3
#>  9      9 De'Aaron Fox    26 SAC   PG       74    74     35.9      9.7      20.9
#> 10     10 Donovan Mit…    27 CLE   SG       55    55     35.3      9.1      19.8
#> # ℹ 726 more rows
#> # ℹ 22 more variables: fg_pct <dbl>, fg3_per_g <dbl>, fg3a_per_g <dbl>,
#> #   fg3_pct <dbl>, fg2_per_g <dbl>, fg2a_per_g <dbl>, fg2_pct <dbl>,
#> #   efg_pct <dbl>, ft_per_g <dbl>, fta_per_g <dbl>, ft_pct <dbl>,
#> #   orb_per_g <dbl>, drb_per_g <dbl>, trb_per_g <dbl>, ast_per_g <dbl>,
#> #   stl_per_g <dbl>, blk_per_g <dbl>, tov_per_g <dbl>, pf_per_g <dbl>,
#> #   pts_per_g <dbl>, awards <chr>, season <int>
# }
```
