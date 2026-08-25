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
#> ✖ 2026-08-25 04:58:25.92954: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:26.463161: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:26.861494: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:27.244322: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:27.386705: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:27.571056: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:27.894631: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:28.213245: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:28.480819: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:28.625007: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:28.969642: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:29.312544: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:29.464945: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:29.897891: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.042711: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.20776: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.350268: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.490935: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.635078: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.783726: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:30.932554: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:31.076146: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:31.222845: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:31.496855: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:31.836925: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:31.855806: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:32.096137: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:32.243684: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-25 04:58:32.287678: Invalid arguments or no schedule available for 2025!
#> ✖ Args: year = 2025
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 04:58:32 UTC
#> # A tibble: 0 × 14
#> # ℹ 14 variables: season <int>, game_date <date>, home_espn_team_id <int>,
#> #   away_espn_team_id <int>, espn_game_id <chr>, bart_muid <chr>,
#> #   bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>, kp_game_id <chr>,
#> #   fox_game_id <chr>, yahoo_game_id <chr>, match_method <chr>,
#> #   match_confidence <dbl>
# }
```
