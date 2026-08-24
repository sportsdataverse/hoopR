# **Get the MBB cross-source schedule crosswalk**

Build a wide, one-row-per-game crosswalk linking ESPN and Bart Torvik
(barttorvik.com) game identifiers for an MBB season. Fox Sports and
Yahoo game IDs are NA placeholders. KenPom game IDs are optionally
enriched when `include_kenpom = TRUE` and credentials are set (see
below). Dates are reduced to Eastern-Time game dates before joining;
Torvik `team1`/`team2` are unordered (the join uses a sorted team-pair
key, so home/away from the Torvik side is not preserved). Games where
either Torvik team name cannot be resolved to an ESPN id via
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)
are kept as `bart_only` rows.

**KenPom (optional):** KenPom requires a paid subscription. Set the
environment variables `KP_USER` (email) and `KP_PW` (password) and pass
`include_kenpom = TRUE`. When `include_kenpom = FALSE` (the default) or
when credentials are absent, `kp_game_id` is left as `NA` and no network
calls to KenPom are made. Errors from individual team schedule calls are
silently dropped so the function always returns a complete crosswalk
even when partial KenPom data is unavailable.

## Usage

``` r
mbb_schedule_crosswalk(
  season = most_recent_mbb_season(),
  include_kenpom = FALSE
)
```

## Arguments

- season:

  Season year (4-digit, e.g. `2025`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- include_kenpom:

  Logical. When `TRUE` AND `KP_USER` is set, attempts to enrich
  `kp_game_id` via per-team
  [`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md)
  calls. Default `FALSE`.

## Value

A `hoopR_data` tibble, one row per game:

|                   |           |                                             |
|-------------------|-----------|---------------------------------------------|
| col_name          | types     | description                                 |
| season            | integer   | Season year.                                |
| game_date         | Date      | ET game date.                               |
| home_espn_team_id | integer   | ESPN home team id (NA for bart-only rows).  |
| away_espn_team_id | integer   | ESPN away team id (NA for bart-only rows).  |
| espn_game_id      | character | ESPN game id (NA for bart-only rows).       |
| bart_muid         | character | Torvik muid (NA for espn-only rows).        |
| bart_team1        | character | Torvik team1 name (NA for espn-only rows).  |
| bart_team2        | character | Torvik team2 name (NA for espn-only rows).  |
| bart_winner       | character | Torvik winner name (NA for espn-only rows). |
| kp_game_id        | character | KenPom game id (NA unless kenpom enabled).  |
| fox_game_id       | character | Fox game id (NA placeholder).               |
| yahoo_game_id     | character | Yahoo game id (NA placeholder).             |
| match_method      | character | "both"/"espn_only"/"bart_only".             |
| match_confidence  | numeric   | 1 for matched, NA for unmatched.            |

## See also

Other MBB Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(mbb_schedule_crosswalk(season = 2025))
#> ✖ 2026-08-24 20:43:50.829172: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:51.615602: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:52.161508: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:52.356649: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:52.528128: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:52.806337: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:53.100327: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:53.277163: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:53.628573: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:54.006026: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:54.436473: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:54.610535: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:54.980991: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:55.250705: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:55.634153: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:55.81757: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:56.002708: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:56.372812: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:56.780747: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:56.962322: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:57.215034: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:57.547229: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:58.167855: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:58.405241: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:58.864246: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:59.272697: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:59.686888: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:59.889704: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:59.941238: Invalid arguments or no schedule available for 2025!
#> ✖ Args: year = 2025
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:43:59 UTC
#> # A tibble: 0 × 14
#> # ℹ 14 variables: season <int>, game_date <date>, home_espn_team_id <int>,
#> #   away_espn_team_id <int>, espn_game_id <chr>, bart_muid <chr>,
#> #   bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>, kp_game_id <chr>,
#> #   fox_game_id <chr>, yahoo_game_id <chr>, match_method <chr>,
#> #   match_confidence <dbl>
# }
```
