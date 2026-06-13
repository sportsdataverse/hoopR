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
[`load_mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_crosswalk.md),
[`load_mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule_crosswalk.md),
[`load_mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_crosswalk.md),
[`mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_player_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(mbb_schedule_crosswalk(season = 2025))
#> ✖ 2026-06-13 05:59:15.839698: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:16.838407: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:17.18205: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:17.335871: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:17.584163: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:17.811247: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:18.120795: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:18.286391: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:18.62567: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:18.785069: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:18.938609: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:19.236324: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:19.561999: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:19.613101: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:19.932202: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:20.306072: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:20.354992: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:20.405018: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:20.592575: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:20.988024: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:21.038483: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:21.317242: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:21.494005: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:21.656927: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:21.817079: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:22.833807: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:22.884216: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:22.940639: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:22.990345: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-13 05:59:23.047628: Invalid arguments or no schedule available for 2025!
#> ✖ Args: year = 2025
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 05:59:23 UTC
#> # A tibble: 0 × 14
#> # ℹ 14 variables: season <int>, game_date <date>, home_espn_team_id <int>,
#> #   away_espn_team_id <int>, espn_game_id <chr>, bart_muid <chr>,
#> #   bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>, kp_game_id <chr>,
#> #   fox_game_id <chr>, yahoo_game_id <chr>, match_method <chr>,
#> #   match_confidence <dbl>
# }
```
