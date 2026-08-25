# **NBA Player Profile (nested by table)**

A player's full profile collapsed to one self-describing tibble (tactic
**D**).
[`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md)
returns many heterogeneous, `PLAYER_ID`-keyed sets (season totals,
career totals, season/career highs, rankings, next game); this nests
each populated set into a `.data` list-column, one row per
`(set_name, PLAYER_ID)`. Recover a table with
[`tidyr::unnest()`](https://tidyr.tidyverse.org/reference/unnest.html).

## Usage

``` r
nba_tidy_player_profile(player_id, ...)
```

## Arguments

- player_id:

  Player ID (e.g. `201939`).

- ...:

  Additional arguments passed to
  [`nba_playerprofilev2()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md).

## Value

A `hoopR_data` tibble with `set_name`, `PLAYER_ID` and a `.data`
list-column.

## See also

Other NBA Combined Datasets:
[`nba_tidy_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_boxscore.md),
[`nba_tidy_franchise_history()`](https://hoopR.sportsdataverse.org/reference/nba_tidy_franchise_history.md)

## Examples

``` r
# \donttest{
  prof <- try(nba_tidy_player_profile(player_id = 201939))
#> ✖ 2026-08-25 03:07:37.133811: Invalid arguments or no player profile v2 data available for 201939!
#> ✖ Args: league_id = "", per_mode = "Totals", player_id = 201939
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-08-25 03:07:37.145938: No NBA player profile for 201939!
#> ✖ Args: player_id = 201939
#> ✖ Error: No player profile data returned
# }
```
