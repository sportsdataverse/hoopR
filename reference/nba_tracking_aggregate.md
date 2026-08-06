# **Aggregate NBA Player-Tracking Stats Across Multiple Seasons**

Fetches `leaguedashptstats` dashboards for each combination of `seasons`
and `season_types`, then aggregates the results by entity (`PLAYER_ID`
for Player, `TEAM_ID` for Team) following the contract ported from
`sportsdataverse-py`'s `aggregate_tracking_frames`:

- **Identity columns** (`*_ID`, `*_NAME`, `*_ABBREVIATION`, and any
  other non-numeric string column such as `TEAM_CITY`) are carried via
  `first()` — never summed.

- **`*_FG_PCT` / `*_FT_PCT`** are recomputed from the summed FGM/FGA and
  FTM/FTA denominators (denom 0 → `NA`); a `*_FG_PCT` / `*_FT_PCT`
  column whose makes/attempts pair is absent is dropped rather than
  recomputed.

- **Other `*_PCT` columns** (e.g., `DRIVE_PTS_PCT` — "% of total" rates)
  are **dropped** from the output because they are not additive.

- **All remaining numeric columns** are summed (numeric-content gate,
  mirroring the `sportsdataverse-py` `dtype.is_numeric()` rule).

## Usage

``` r
nba_tracking_aggregate(
  seasons,
  season_types = "Regular Season",
  per_mode = "Totals",
  pt_measure_type = "Drives",
  player_or_team = "Player",
  league_id = "00",
  ...
)
```

## Arguments

- seasons:

  Character vector of NBA season strings, e.g.
  `c("2022-23", "2023-24")`.

- season_types:

  Character vector of season type(s), e.g. `"Regular Season"` or
  `c("Regular Season", "Playoffs")`. Defaults to `"Regular Season"`.

- per_mode:

  Per-mode string passed to `nba_leaguedashptstats` (default
  `"Totals"`). Use `"Totals"` for aggregation; per-game averages are not
  meaningfully additive.

- pt_measure_type:

  Tracking measure type string, e.g. `"Drives"`, `"SpeedDistance"`,
  `"Passing"`. Passed directly to `nba_leaguedashptstats`. Default
  `"Drives"`.

- player_or_team:

  `"Player"` (default) or `"Team"`. Determines the entity key used to
  group aggregation (`PLAYER_ID` or `TEAM_ID`).

- league_id:

  League identifier string. Default `"00"` (NBA).

- ...:

  Additional arguments forwarded to `nba_leaguedashptstats` (e.g.,
  `date_from`, `date_to`, `conference`).

## Value

A `data.frame` (tibble-compatible) with one row per entity (`PLAYER_ID`
or `TEAM_ID`). Count columns are summed across all requested
seasons/season types; `*_FG_PCT` and `*_FT_PCT` are recomputed from
summed numerators/denominators; `*_PCT` "% of total" columns are
dropped; identity string columns are carried from the first season.
Returns a 0-row frame when no data are available.

## Details

**Aggregate NBA Player-Tracking Stats Across Multiple Seasons**

     nba_tracking_aggregate(seasons = c("2022-23", "2023-24"),
                            pt_measure_type = "Drives",
                            player_or_team  = "Player")

## Note

Designed and validated for COUNT-based tracking measures (e.g.
`"Drives"`). Rate-only columns without a `_pct` suffix in some
`pt_measure_type` values are summed across seasons (a known limitation
shared with the `sportsdataverse` reference engine); verify aggregation
semantics before using rate-heavy measures.

## See also

Other NBA Player Tracking Functions:
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_synergyplaytypes()`](https://hoopR.sportsdataverse.org/reference/nba_synergyplaytypes.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try({
    df <- nba_tracking_aggregate(
      seasons = c("2022-23", "2023-24"),
      pt_measure_type = "Drives",
      player_or_team  = "Player"
    )
    print(df[1:5, c("PLAYER_ID", "PLAYER_NAME", "DRIVES", "DRIVE_FG_PCT")])
  })
#> ✖ 2026-08-06 04:18:23.224556: Invalid arguments or no league dashboard player-tracking stats data for 2022-23 available!
#> ✖ Args: college = "", conference = "", country = "", date_from = "", date_to = "", division = "", draft_pick = "", draft_year = "", game_scope = "", height = "", last_n_games = 0, league_id = "00", location = "", month = 0, opponent_team_id = 0, outcome = "", po_round = "", per_mode = "Totals", period = "", player_experience = "", player_or_team = "Player", player_position = "", pt_measure_type = "Drives", season = "2022-23", season_segment = "", season_type = "Regular Season", starter_bench = "", team_id = "", vs_conference = "", vs_division = "", weight = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60001 milliseconds with 0 bytes received
#> ✖ 2026-08-06 04:19:23.254022: Invalid arguments or no league dashboard player-tracking stats data for 2023-24 available!
#> ✖ Args: college = "", conference = "", country = "", date_from = "", date_to = "", division = "", draft_pick = "", draft_year = "", game_scope = "", height = "", last_n_games = 0, league_id = "00", location = "", month = 0, opponent_team_id = 0, outcome = "", po_round = "", per_mode = "Totals", period = "", player_experience = "", player_or_team = "Player", player_position = "", pt_measure_type = "Drives", season = "2023-24", season_segment = "", season_type = "Regular Season", starter_bench = "", team_id = "", vs_conference = "", vs_division = "", weight = ""
#> ✖ Error: Failed to perform HTTP request. Caused by error in `curl::curl_fetch_memory()`: ! Timeout was reached [stats.nba.com]: Operation timed out after 60002 milliseconds with 0 bytes received
#> Error in df[1:5, c("PLAYER_ID", "PLAYER_NAME", "DRIVES", "DRIVE_FG_PCT")] : 
#>   Can't subset columns that don't exist.
#> ✖ Columns `PLAYER_ID`, `PLAYER_NAME`, `DRIVES`, and `DRIVE_FG_PCT` don't exist.
# }
```
