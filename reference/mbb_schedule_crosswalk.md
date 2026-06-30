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
#> ✖ 2026-06-30 19:43:41.948971: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:43.251438: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:43.733422: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:43.810869: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:44.311681: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:44.666184: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:44.97893: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.253689: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.312628: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.500998: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.561008: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.740532: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:45.939454: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:46.107883: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:46.293183: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:46.683015: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:47.081144: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:47.429373: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:47.636024: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:47.923306: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:48.43368: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:48.607749: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:48.780274: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:49.139486: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:49.358348: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:49.454002: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:49.896968: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:50.001241: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:50.193004: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-30 19:43:53.661172: Invalid arguments or no scoreboard data for 20241104 available!
#> ✖ Args: group = "56", season_dates = "20241104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:53.839514: Invalid arguments or no scoreboard data for 20241104 available!
#> ✖ Args: group = "55", season_dates = "20241104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:54.679387: Invalid arguments or no scoreboard data for 20241104 available!
#> ✖ Args: group = "100", season_dates = "20241104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:54.800252: Invalid arguments or no scoreboard data for 20241105 available!
#> ✖ Args: group = "56", season_dates = "20241105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:55.043538: Invalid arguments or no scoreboard data for 20241105 available!
#> ✖ Args: group = "55", season_dates = "20241105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:55.410113: Invalid arguments or no scoreboard data for 20241105 available!
#> ✖ Args: group = "100", season_dates = "20241105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:55.740134: Invalid arguments or no scoreboard data for 20241106 available!
#> ✖ Args: group = "56", season_dates = "20241106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:55.954377: Invalid arguments or no scoreboard data for 20241106 available!
#> ✖ Args: group = "55", season_dates = "20241106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:56.616376: Invalid arguments or no scoreboard data for 20241106 available!
#> ✖ Args: group = "100", season_dates = "20241106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:56.773028: Invalid arguments or no scoreboard data for 20241107 available!
#> ✖ Args: group = "56", season_dates = "20241107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:56.984535: Invalid arguments or no scoreboard data for 20241107 available!
#> ✖ Args: group = "55", season_dates = "20241107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:57.646462: Invalid arguments or no scoreboard data for 20241107 available!
#> ✖ Args: group = "100", season_dates = "20241107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:57.81383: Invalid arguments or no scoreboard data for 20241108 available!
#> ✖ Args: group = "56", season_dates = "20241108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:57.980195: Invalid arguments or no scoreboard data for 20241108 available!
#> ✖ Args: group = "55", season_dates = "20241108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:58.728503: Invalid arguments or no scoreboard data for 20241108 available!
#> ✖ Args: group = "100", season_dates = "20241108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:58.883252: Invalid arguments or no scoreboard data for 20241109 available!
#> ✖ Args: group = "56", season_dates = "20241109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:59.111422: Invalid arguments or no scoreboard data for 20241109 available!
#> ✖ Args: group = "55", season_dates = "20241109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:59.699532: Invalid arguments or no scoreboard data for 20241109 available!
#> ✖ Args: group = "100", season_dates = "20241109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:43:59.890281: Invalid arguments or no scoreboard data for 20241110 available!
#> ✖ Args: group = "56", season_dates = "20241110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:00.073643: Invalid arguments or no scoreboard data for 20241110 available!
#> ✖ Args: group = "55", season_dates = "20241110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:00.732966: Invalid arguments or no scoreboard data for 20241110 available!
#> ✖ Args: group = "100", season_dates = "20241110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:00.958736: Invalid arguments or no scoreboard data for 20241111 available!
#> ✖ Args: group = "56", season_dates = "20241111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:01.114238: Invalid arguments or no scoreboard data for 20241111 available!
#> ✖ Args: group = "55", season_dates = "20241111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:01.706441: Invalid arguments or no scoreboard data for 20241111 available!
#> ✖ Args: group = "100", season_dates = "20241111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:01.914754: Invalid arguments or no scoreboard data for 20241112 available!
#> ✖ Args: group = "56", season_dates = "20241112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:02.128459: Invalid arguments or no scoreboard data for 20241112 available!
#> ✖ Args: group = "55", season_dates = "20241112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:02.918468: Invalid arguments or no scoreboard data for 20241112 available!
#> ✖ Args: group = "100", season_dates = "20241112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:03.115489: Invalid arguments or no scoreboard data for 20241113 available!
#> ✖ Args: group = "56", season_dates = "20241113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:03.361178: Invalid arguments or no scoreboard data for 20241113 available!
#> ✖ Args: group = "55", season_dates = "20241113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:04.039826: Invalid arguments or no scoreboard data for 20241113 available!
#> ✖ Args: group = "100", season_dates = "20241113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:04.2131: Invalid arguments or no scoreboard data for 20241114 available!
#> ✖ Args: group = "56", season_dates = "20241114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:04.425745: Invalid arguments or no scoreboard data for 20241114 available!
#> ✖ Args: group = "55", season_dates = "20241114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:04.939375: Invalid arguments or no scoreboard data for 20241114 available!
#> ✖ Args: group = "100", season_dates = "20241114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:05.135187: Invalid arguments or no scoreboard data for 20241115 available!
#> ✖ Args: group = "56", season_dates = "20241115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:05.339044: Invalid arguments or no scoreboard data for 20241115 available!
#> ✖ Args: group = "55", season_dates = "20241115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:05.951246: Invalid arguments or no scoreboard data for 20241115 available!
#> ✖ Args: group = "100", season_dates = "20241115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:06.134043: Invalid arguments or no scoreboard data for 20241116 available!
#> ✖ Args: group = "56", season_dates = "20241116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:06.331656: Invalid arguments or no scoreboard data for 20241116 available!
#> ✖ Args: group = "55", season_dates = "20241116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:06.962219: Invalid arguments or no scoreboard data for 20241116 available!
#> ✖ Args: group = "100", season_dates = "20241116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:07.109706: Invalid arguments or no scoreboard data for 20241117 available!
#> ✖ Args: group = "56", season_dates = "20241117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:07.304229: Invalid arguments or no scoreboard data for 20241117 available!
#> ✖ Args: group = "55", season_dates = "20241117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:07.81143: Invalid arguments or no scoreboard data for 20241117 available!
#> ✖ Args: group = "100", season_dates = "20241117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:08.009819: Invalid arguments or no scoreboard data for 20241118 available!
#> ✖ Args: group = "56", season_dates = "20241118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:08.151578: Invalid arguments or no scoreboard data for 20241118 available!
#> ✖ Args: group = "55", season_dates = "20241118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:08.637859: Invalid arguments or no scoreboard data for 20241118 available!
#> ✖ Args: group = "100", season_dates = "20241118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:08.816507: Invalid arguments or no scoreboard data for 20241119 available!
#> ✖ Args: group = "56", season_dates = "20241119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:08.989738: Invalid arguments or no scoreboard data for 20241119 available!
#> ✖ Args: group = "55", season_dates = "20241119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:10.009861: Invalid arguments or no scoreboard data for 20241119 available!
#> ✖ Args: group = "100", season_dates = "20241119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:10.092549: Invalid arguments or no scoreboard data for 20241120 available!
#> ✖ Args: group = "56", season_dates = "20241120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:10.166694: Invalid arguments or no scoreboard data for 20241120 available!
#> ✖ Args: group = "55", season_dates = "20241120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:10.649141: Invalid arguments or no scoreboard data for 20241120 available!
#> ✖ Args: group = "100", season_dates = "20241120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:10.847241: Invalid arguments or no scoreboard data for 20241121 available!
#> ✖ Args: group = "56", season_dates = "20241121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:11.019159: Invalid arguments or no scoreboard data for 20241121 available!
#> ✖ Args: group = "55", season_dates = "20241121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:11.552186: Invalid arguments or no scoreboard data for 20241121 available!
#> ✖ Args: group = "100", season_dates = "20241121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:11.728603: Invalid arguments or no scoreboard data for 20241122 available!
#> ✖ Args: group = "56", season_dates = "20241122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:11.874271: Invalid arguments or no scoreboard data for 20241122 available!
#> ✖ Args: group = "55", season_dates = "20241122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:12.573027: Invalid arguments or no scoreboard data for 20241122 available!
#> ✖ Args: group = "100", season_dates = "20241122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:12.759443: Invalid arguments or no scoreboard data for 20241123 available!
#> ✖ Args: group = "56", season_dates = "20241123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:12.909829: Invalid arguments or no scoreboard data for 20241123 available!
#> ✖ Args: group = "55", season_dates = "20241123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:13.547287: Invalid arguments or no scoreboard data for 20241123 available!
#> ✖ Args: group = "100", season_dates = "20241123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:13.725806: Invalid arguments or no scoreboard data for 20241124 available!
#> ✖ Args: group = "56", season_dates = "20241124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:13.92048: Invalid arguments or no scoreboard data for 20241124 available!
#> ✖ Args: group = "55", season_dates = "20241124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:14.467585: Invalid arguments or no scoreboard data for 20241124 available!
#> ✖ Args: group = "100", season_dates = "20241124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:14.642022: Invalid arguments or no scoreboard data for 20241125 available!
#> ✖ Args: group = "56", season_dates = "20241125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:14.821228: Invalid arguments or no scoreboard data for 20241125 available!
#> ✖ Args: group = "55", season_dates = "20241125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:15.390091: Invalid arguments or no scoreboard data for 20241125 available!
#> ✖ Args: group = "100", season_dates = "20241125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:15.567877: Invalid arguments or no scoreboard data for 20241126 available!
#> ✖ Args: group = "56", season_dates = "20241126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:15.744311: Invalid arguments or no scoreboard data for 20241126 available!
#> ✖ Args: group = "55", season_dates = "20241126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:16.309176: Invalid arguments or no scoreboard data for 20241126 available!
#> ✖ Args: group = "100", season_dates = "20241126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:16.552695: Invalid arguments or no scoreboard data for 20241127 available!
#> ✖ Args: group = "56", season_dates = "20241127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:16.706331: Invalid arguments or no scoreboard data for 20241127 available!
#> ✖ Args: group = "55", season_dates = "20241127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:17.450636: Invalid arguments or no scoreboard data for 20241127 available!
#> ✖ Args: group = "100", season_dates = "20241127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:17.654078: Invalid arguments or no scoreboard data for 20241128 available!
#> ✖ Args: group = "56", season_dates = "20241128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:17.867836: Invalid arguments or no scoreboard data for 20241128 available!
#> ✖ Args: group = "55", season_dates = "20241128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:18.286981: Invalid arguments or no scoreboard data for 20241128 available!
#> ✖ Args: group = "100", season_dates = "20241128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:18.476346: Invalid arguments or no scoreboard data for 20241129 available!
#> ✖ Args: group = "56", season_dates = "20241129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:18.7172: Invalid arguments or no scoreboard data for 20241129 available!
#> ✖ Args: group = "55", season_dates = "20241129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:19.575963: Invalid arguments or no scoreboard data for 20241129 available!
#> ✖ Args: group = "100", season_dates = "20241129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:19.759223: Invalid arguments or no scoreboard data for 20241130 available!
#> ✖ Args: group = "56", season_dates = "20241130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:19.939372: Invalid arguments or no scoreboard data for 20241130 available!
#> ✖ Args: group = "55", season_dates = "20241130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:20.790474: Invalid arguments or no scoreboard data for 20241130 available!
#> ✖ Args: group = "100", season_dates = "20241130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:20.999245: Invalid arguments or no scoreboard data for 20241201 available!
#> ✖ Args: group = "56", season_dates = "20241201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:21.299104: Invalid arguments or no scoreboard data for 20241201 available!
#> ✖ Args: group = "55", season_dates = "20241201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:21.936658: Invalid arguments or no scoreboard data for 20241201 available!
#> ✖ Args: group = "100", season_dates = "20241201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:22.11912: Invalid arguments or no scoreboard data for 20241202 available!
#> ✖ Args: group = "56", season_dates = "20241202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:22.278921: Invalid arguments or no scoreboard data for 20241202 available!
#> ✖ Args: group = "55", season_dates = "20241202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:22.831351: Invalid arguments or no scoreboard data for 20241202 available!
#> ✖ Args: group = "100", season_dates = "20241202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:23.007495: Invalid arguments or no scoreboard data for 20241203 available!
#> ✖ Args: group = "56", season_dates = "20241203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:23.151732: Invalid arguments or no scoreboard data for 20241203 available!
#> ✖ Args: group = "55", season_dates = "20241203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:23.754556: Invalid arguments or no scoreboard data for 20241203 available!
#> ✖ Args: group = "100", season_dates = "20241203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:23.928904: Invalid arguments or no scoreboard data for 20241204 available!
#> ✖ Args: group = "56", season_dates = "20241204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:24.108381: Invalid arguments or no scoreboard data for 20241204 available!
#> ✖ Args: group = "55", season_dates = "20241204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:24.835262: Invalid arguments or no scoreboard data for 20241204 available!
#> ✖ Args: group = "100", season_dates = "20241204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:25.00468: Invalid arguments or no scoreboard data for 20241205 available!
#> ✖ Args: group = "56", season_dates = "20241205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:25.198418: Invalid arguments or no scoreboard data for 20241205 available!
#> ✖ Args: group = "55", season_dates = "20241205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:25.717644: Invalid arguments or no scoreboard data for 20241205 available!
#> ✖ Args: group = "100", season_dates = "20241205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:25.913486: Invalid arguments or no scoreboard data for 20241206 available!
#> ✖ Args: group = "56", season_dates = "20241206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:26.083636: Invalid arguments or no scoreboard data for 20241206 available!
#> ✖ Args: group = "55", season_dates = "20241206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:26.793944: Invalid arguments or no scoreboard data for 20241206 available!
#> ✖ Args: group = "100", season_dates = "20241206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:26.96884: Invalid arguments or no scoreboard data for 20241207 available!
#> ✖ Args: group = "56", season_dates = "20241207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:27.162997: Invalid arguments or no scoreboard data for 20241207 available!
#> ✖ Args: group = "55", season_dates = "20241207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:28.008941: Invalid arguments or no scoreboard data for 20241207 available!
#> ✖ Args: group = "100", season_dates = "20241207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:28.200595: Invalid arguments or no scoreboard data for 20241208 available!
#> ✖ Args: group = "56", season_dates = "20241208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:28.360322: Invalid arguments or no scoreboard data for 20241208 available!
#> ✖ Args: group = "55", season_dates = "20241208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:29.162207: Invalid arguments or no scoreboard data for 20241208 available!
#> ✖ Args: group = "100", season_dates = "20241208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:29.376243: Invalid arguments or no scoreboard data for 20241209 available!
#> ✖ Args: group = "56", season_dates = "20241209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:29.54488: Invalid arguments or no scoreboard data for 20241209 available!
#> ✖ Args: group = "55", season_dates = "20241209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:29.976619: Invalid arguments or no scoreboard data for 20241209 available!
#> ✖ Args: group = "100", season_dates = "20241209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:30.172223: Invalid arguments or no scoreboard data for 20241210 available!
#> ✖ Args: group = "56", season_dates = "20241210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:30.341887: Invalid arguments or no scoreboard data for 20241210 available!
#> ✖ Args: group = "55", season_dates = "20241210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:30.966922: Invalid arguments or no scoreboard data for 20241210 available!
#> ✖ Args: group = "100", season_dates = "20241210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:31.151703: Invalid arguments or no scoreboard data for 20241211 available!
#> ✖ Args: group = "56", season_dates = "20241211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:31.498021: Invalid arguments or no scoreboard data for 20241211 available!
#> ✖ Args: group = "55", season_dates = "20241211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:32.237731: Invalid arguments or no scoreboard data for 20241211 available!
#> ✖ Args: group = "100", season_dates = "20241211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:32.402832: Invalid arguments or no scoreboard data for 20241212 available!
#> ✖ Args: group = "56", season_dates = "20241212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:32.603613: Invalid arguments or no scoreboard data for 20241212 available!
#> ✖ Args: group = "55", season_dates = "20241212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:33.072971: Invalid arguments or no scoreboard data for 20241212 available!
#> ✖ Args: group = "100", season_dates = "20241212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:33.215344: Invalid arguments or no scoreboard data for 20241213 available!
#> ✖ Args: group = "56", season_dates = "20241213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:33.407735: Invalid arguments or no scoreboard data for 20241213 available!
#> ✖ Args: group = "55", season_dates = "20241213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:33.909288: Invalid arguments or no scoreboard data for 20241213 available!
#> ✖ Args: group = "100", season_dates = "20241213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:34.086708: Invalid arguments or no scoreboard data for 20241214 available!
#> ✖ Args: group = "56", season_dates = "20241214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:34.274819: Invalid arguments or no scoreboard data for 20241214 available!
#> ✖ Args: group = "55", season_dates = "20241214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:34.863645: Invalid arguments or no scoreboard data for 20241214 available!
#> ✖ Args: group = "100", season_dates = "20241214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:35.037704: Invalid arguments or no scoreboard data for 20241215 available!
#> ✖ Args: group = "56", season_dates = "20241215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:35.215204: Invalid arguments or no scoreboard data for 20241215 available!
#> ✖ Args: group = "55", season_dates = "20241215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:35.757462: Invalid arguments or no scoreboard data for 20241215 available!
#> ✖ Args: group = "100", season_dates = "20241215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:35.926836: Invalid arguments or no scoreboard data for 20241216 available!
#> ✖ Args: group = "56", season_dates = "20241216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:36.099366: Invalid arguments or no scoreboard data for 20241216 available!
#> ✖ Args: group = "55", season_dates = "20241216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:36.608861: Invalid arguments or no scoreboard data for 20241216 available!
#> ✖ Args: group = "100", season_dates = "20241216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:36.782583: Invalid arguments or no scoreboard data for 20241217 available!
#> ✖ Args: group = "56", season_dates = "20241217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:36.953432: Invalid arguments or no scoreboard data for 20241217 available!
#> ✖ Args: group = "55", season_dates = "20241217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:37.595403: Invalid arguments or no scoreboard data for 20241217 available!
#> ✖ Args: group = "100", season_dates = "20241217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:37.926843: Invalid arguments or no scoreboard data for 20241218 available!
#> ✖ Args: group = "56", season_dates = "20241218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:38.097496: Invalid arguments or no scoreboard data for 20241218 available!
#> ✖ Args: group = "55", season_dates = "20241218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:38.745614: Invalid arguments or no scoreboard data for 20241218 available!
#> ✖ Args: group = "100", season_dates = "20241218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:38.934608: Invalid arguments or no scoreboard data for 20241219 available!
#> ✖ Args: group = "56", season_dates = "20241219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:39.110639: Invalid arguments or no scoreboard data for 20241219 available!
#> ✖ Args: group = "55", season_dates = "20241219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:39.59428: Invalid arguments or no scoreboard data for 20241219 available!
#> ✖ Args: group = "100", season_dates = "20241219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:39.750585: Invalid arguments or no scoreboard data for 20241220 available!
#> ✖ Args: group = "56", season_dates = "20241220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:39.894014: Invalid arguments or no scoreboard data for 20241220 available!
#> ✖ Args: group = "55", season_dates = "20241220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:40.385046: Invalid arguments or no scoreboard data for 20241220 available!
#> ✖ Args: group = "100", season_dates = "20241220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:40.596839: Invalid arguments or no scoreboard data for 20241221 available!
#> ✖ Args: group = "56", season_dates = "20241221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:40.828993: Invalid arguments or no scoreboard data for 20241221 available!
#> ✖ Args: group = "55", season_dates = "20241221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:41.511608: Invalid arguments or no scoreboard data for 20241221 available!
#> ✖ Args: group = "100", season_dates = "20241221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:41.683133: Invalid arguments or no scoreboard data for 20241222 available!
#> ✖ Args: group = "56", season_dates = "20241222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:41.876904: Invalid arguments or no scoreboard data for 20241222 available!
#> ✖ Args: group = "55", season_dates = "20241222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:42.415008: Invalid arguments or no scoreboard data for 20241222 available!
#> ✖ Args: group = "100", season_dates = "20241222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:42.59159: Invalid arguments or no scoreboard data for 20241223 available!
#> ✖ Args: group = "56", season_dates = "20241223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:42.806361: Invalid arguments or no scoreboard data for 20241223 available!
#> ✖ Args: group = "55", season_dates = "20241223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:43.388389: Invalid arguments or no scoreboard data for 20241223 available!
#> ✖ Args: group = "100", season_dates = "20241223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:43.489475: Invalid arguments or no scoreboard data for 20241225 available!
#> ✖ Args: group = "56", season_dates = "20241225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:43.699899: Invalid arguments or no scoreboard data for 20241225 available!
#> ✖ Args: group = "55", season_dates = "20241225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:44.062764: Invalid arguments or no scoreboard data for 20241225 available!
#> ✖ Args: group = "100", season_dates = "20241225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:44.242572: Invalid arguments or no scoreboard data for 20241227 available!
#> ✖ Args: group = "56", season_dates = "20241227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:44.404224: Invalid arguments or no scoreboard data for 20241227 available!
#> ✖ Args: group = "55", season_dates = "20241227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:44.804202: Invalid arguments or no scoreboard data for 20241227 available!
#> ✖ Args: group = "100", season_dates = "20241227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:44.947174: Invalid arguments or no scoreboard data for 20241228 available!
#> ✖ Args: group = "56", season_dates = "20241228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:45.138469: Invalid arguments or no scoreboard data for 20241228 available!
#> ✖ Args: group = "55", season_dates = "20241228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:45.759928: Invalid arguments or no scoreboard data for 20241228 available!
#> ✖ Args: group = "100", season_dates = "20241228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:45.947321: Invalid arguments or no scoreboard data for 20241229 available!
#> ✖ Args: group = "56", season_dates = "20241229"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:46.106848: Invalid arguments or no scoreboard data for 20241229 available!
#> ✖ Args: group = "55", season_dates = "20241229"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:46.786292: Invalid arguments or no scoreboard data for 20241229 available!
#> ✖ Args: group = "100", season_dates = "20241229"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:47.030667: Invalid arguments or no scoreboard data for 20241230 available!
#> ✖ Args: group = "56", season_dates = "20241230"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:47.212634: Invalid arguments or no scoreboard data for 20241230 available!
#> ✖ Args: group = "55", season_dates = "20241230"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:47.766237: Invalid arguments or no scoreboard data for 20241230 available!
#> ✖ Args: group = "100", season_dates = "20241230"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:47.953353: Invalid arguments or no scoreboard data for 20241231 available!
#> ✖ Args: group = "56", season_dates = "20241231"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:48.103527: Invalid arguments or no scoreboard data for 20241231 available!
#> ✖ Args: group = "55", season_dates = "20241231"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:48.692122: Invalid arguments or no scoreboard data for 20241231 available!
#> ✖ Args: group = "100", season_dates = "20241231"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:48.915781: Invalid arguments or no scoreboard data for 20250101 available!
#> ✖ Args: group = "56", season_dates = "20250101"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:49.085553: Invalid arguments or no scoreboard data for 20250101 available!
#> ✖ Args: group = "55", season_dates = "20250101"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:49.608631: Invalid arguments or no scoreboard data for 20250101 available!
#> ✖ Args: group = "100", season_dates = "20250101"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:49.802676: Invalid arguments or no scoreboard data for 20250102 available!
#> ✖ Args: group = "56", season_dates = "20250102"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:49.987728: Invalid arguments or no scoreboard data for 20250102 available!
#> ✖ Args: group = "55", season_dates = "20250102"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:50.539989: Invalid arguments or no scoreboard data for 20250102 available!
#> ✖ Args: group = "100", season_dates = "20250102"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:50.723649: Invalid arguments or no scoreboard data for 20250103 available!
#> ✖ Args: group = "56", season_dates = "20250103"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:50.917817: Invalid arguments or no scoreboard data for 20250103 available!
#> ✖ Args: group = "55", season_dates = "20250103"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:51.363228: Invalid arguments or no scoreboard data for 20250103 available!
#> ✖ Args: group = "100", season_dates = "20250103"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:51.579686: Invalid arguments or no scoreboard data for 20250104 available!
#> ✖ Args: group = "56", season_dates = "20250104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:51.764941: Invalid arguments or no scoreboard data for 20250104 available!
#> ✖ Args: group = "55", season_dates = "20250104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:52.560817: Invalid arguments or no scoreboard data for 20250104 available!
#> ✖ Args: group = "100", season_dates = "20250104"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:52.719361: Invalid arguments or no scoreboard data for 20250105 available!
#> ✖ Args: group = "56", season_dates = "20250105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:52.897914: Invalid arguments or no scoreboard data for 20250105 available!
#> ✖ Args: group = "55", season_dates = "20250105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:53.395137: Invalid arguments or no scoreboard data for 20250105 available!
#> ✖ Args: group = "100", season_dates = "20250105"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:53.553001: Invalid arguments or no scoreboard data for 20250106 available!
#> ✖ Args: group = "56", season_dates = "20250106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:53.737589: Invalid arguments or no scoreboard data for 20250106 available!
#> ✖ Args: group = "55", season_dates = "20250106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:54.211208: Invalid arguments or no scoreboard data for 20250106 available!
#> ✖ Args: group = "100", season_dates = "20250106"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:54.366727: Invalid arguments or no scoreboard data for 20250107 available!
#> ✖ Args: group = "56", season_dates = "20250107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:54.536605: Invalid arguments or no scoreboard data for 20250107 available!
#> ✖ Args: group = "55", season_dates = "20250107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:55.035858: Invalid arguments or no scoreboard data for 20250107 available!
#> ✖ Args: group = "100", season_dates = "20250107"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:55.225747: Invalid arguments or no scoreboard data for 20250108 available!
#> ✖ Args: group = "56", season_dates = "20250108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:55.410109: Invalid arguments or no scoreboard data for 20250108 available!
#> ✖ Args: group = "55", season_dates = "20250108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:55.978788: Invalid arguments or no scoreboard data for 20250108 available!
#> ✖ Args: group = "100", season_dates = "20250108"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:56.160848: Invalid arguments or no scoreboard data for 20250109 available!
#> ✖ Args: group = "56", season_dates = "20250109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:56.346554: Invalid arguments or no scoreboard data for 20250109 available!
#> ✖ Args: group = "55", season_dates = "20250109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:56.898154: Invalid arguments or no scoreboard data for 20250109 available!
#> ✖ Args: group = "100", season_dates = "20250109"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:57.156232: Invalid arguments or no scoreboard data for 20250110 available!
#> ✖ Args: group = "56", season_dates = "20250110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:57.327615: Invalid arguments or no scoreboard data for 20250110 available!
#> ✖ Args: group = "55", season_dates = "20250110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:57.743494: Invalid arguments or no scoreboard data for 20250110 available!
#> ✖ Args: group = "100", season_dates = "20250110"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:57.927352: Invalid arguments or no scoreboard data for 20250111 available!
#> ✖ Args: group = "56", season_dates = "20250111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:58.063451: Invalid arguments or no scoreboard data for 20250111 available!
#> ✖ Args: group = "55", season_dates = "20250111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:58.804596: Invalid arguments or no scoreboard data for 20250111 available!
#> ✖ Args: group = "100", season_dates = "20250111"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:58.997887: Invalid arguments or no scoreboard data for 20250112 available!
#> ✖ Args: group = "56", season_dates = "20250112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:59.174015: Invalid arguments or no scoreboard data for 20250112 available!
#> ✖ Args: group = "55", season_dates = "20250112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:59.598786: Invalid arguments or no scoreboard data for 20250112 available!
#> ✖ Args: group = "100", season_dates = "20250112"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:59.740156: Invalid arguments or no scoreboard data for 20250113 available!
#> ✖ Args: group = "56", season_dates = "20250113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:44:59.928323: Invalid arguments or no scoreboard data for 20250113 available!
#> ✖ Args: group = "55", season_dates = "20250113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:00.374832: Invalid arguments or no scoreboard data for 20250113 available!
#> ✖ Args: group = "100", season_dates = "20250113"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:00.581569: Invalid arguments or no scoreboard data for 20250114 available!
#> ✖ Args: group = "56", season_dates = "20250114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:00.68735: Invalid arguments or no scoreboard data for 20250114 available!
#> ✖ Args: group = "55", season_dates = "20250114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:01.118616: Invalid arguments or no scoreboard data for 20250114 available!
#> ✖ Args: group = "100", season_dates = "20250114"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:01.298566: Invalid arguments or no scoreboard data for 20250115 available!
#> ✖ Args: group = "56", season_dates = "20250115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:01.47349: Invalid arguments or no scoreboard data for 20250115 available!
#> ✖ Args: group = "55", season_dates = "20250115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:02.198488: Invalid arguments or no scoreboard data for 20250115 available!
#> ✖ Args: group = "100", season_dates = "20250115"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:02.386163: Invalid arguments or no scoreboard data for 20250116 available!
#> ✖ Args: group = "56", season_dates = "20250116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:02.517359: Invalid arguments or no scoreboard data for 20250116 available!
#> ✖ Args: group = "55", season_dates = "20250116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:03.095237: Invalid arguments or no scoreboard data for 20250116 available!
#> ✖ Args: group = "100", season_dates = "20250116"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:03.377336: Invalid arguments or no scoreboard data for 20250117 available!
#> ✖ Args: group = "56", season_dates = "20250117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:03.528542: Invalid arguments or no scoreboard data for 20250117 available!
#> ✖ Args: group = "55", season_dates = "20250117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:03.938089: Invalid arguments or no scoreboard data for 20250117 available!
#> ✖ Args: group = "100", season_dates = "20250117"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:04.11959: Invalid arguments or no scoreboard data for 20250118 available!
#> ✖ Args: group = "56", season_dates = "20250118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:04.293883: Invalid arguments or no scoreboard data for 20250118 available!
#> ✖ Args: group = "55", season_dates = "20250118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:05.116197: Invalid arguments or no scoreboard data for 20250118 available!
#> ✖ Args: group = "100", season_dates = "20250118"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:05.290069: Invalid arguments or no scoreboard data for 20250119 available!
#> ✖ Args: group = "56", season_dates = "20250119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:05.476443: Invalid arguments or no scoreboard data for 20250119 available!
#> ✖ Args: group = "55", season_dates = "20250119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:05.921307: Invalid arguments or no scoreboard data for 20250119 available!
#> ✖ Args: group = "100", season_dates = "20250119"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:06.08075: Invalid arguments or no scoreboard data for 20250120 available!
#> ✖ Args: group = "56", season_dates = "20250120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:06.247718: Invalid arguments or no scoreboard data for 20250120 available!
#> ✖ Args: group = "55", season_dates = "20250120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:06.854163: Invalid arguments or no scoreboard data for 20250120 available!
#> ✖ Args: group = "100", season_dates = "20250120"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:07.038579: Invalid arguments or no scoreboard data for 20250121 available!
#> ✖ Args: group = "56", season_dates = "20250121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:07.203195: Invalid arguments or no scoreboard data for 20250121 available!
#> ✖ Args: group = "55", season_dates = "20250121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:07.707712: Invalid arguments or no scoreboard data for 20250121 available!
#> ✖ Args: group = "100", season_dates = "20250121"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:07.890605: Invalid arguments or no scoreboard data for 20250122 available!
#> ✖ Args: group = "56", season_dates = "20250122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:08.098124: Invalid arguments or no scoreboard data for 20250122 available!
#> ✖ Args: group = "55", season_dates = "20250122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:08.594214: Invalid arguments or no scoreboard data for 20250122 available!
#> ✖ Args: group = "100", season_dates = "20250122"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:08.776737: Invalid arguments or no scoreboard data for 20250123 available!
#> ✖ Args: group = "56", season_dates = "20250123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:08.950706: Invalid arguments or no scoreboard data for 20250123 available!
#> ✖ Args: group = "55", season_dates = "20250123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:09.560285: Invalid arguments or no scoreboard data for 20250123 available!
#> ✖ Args: group = "100", season_dates = "20250123"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:09.768548: Invalid arguments or no scoreboard data for 20250124 available!
#> ✖ Args: group = "56", season_dates = "20250124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:09.942947: Invalid arguments or no scoreboard data for 20250124 available!
#> ✖ Args: group = "55", season_dates = "20250124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:10.37922: Invalid arguments or no scoreboard data for 20250124 available!
#> ✖ Args: group = "100", season_dates = "20250124"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:10.629792: Invalid arguments or no scoreboard data for 20250125 available!
#> ✖ Args: group = "56", season_dates = "20250125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:10.810227: Invalid arguments or no scoreboard data for 20250125 available!
#> ✖ Args: group = "55", season_dates = "20250125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:11.56252: Invalid arguments or no scoreboard data for 20250125 available!
#> ✖ Args: group = "100", season_dates = "20250125"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:11.73838: Invalid arguments or no scoreboard data for 20250126 available!
#> ✖ Args: group = "56", season_dates = "20250126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:11.925675: Invalid arguments or no scoreboard data for 20250126 available!
#> ✖ Args: group = "55", season_dates = "20250126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:12.347637: Invalid arguments or no scoreboard data for 20250126 available!
#> ✖ Args: group = "100", season_dates = "20250126"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:12.50507: Invalid arguments or no scoreboard data for 20250127 available!
#> ✖ Args: group = "56", season_dates = "20250127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:12.676229: Invalid arguments or no scoreboard data for 20250127 available!
#> ✖ Args: group = "55", season_dates = "20250127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:13.243964: Invalid arguments or no scoreboard data for 20250127 available!
#> ✖ Args: group = "100", season_dates = "20250127"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:13.428682: Invalid arguments or no scoreboard data for 20250128 available!
#> ✖ Args: group = "56", season_dates = "20250128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:13.617896: Invalid arguments or no scoreboard data for 20250128 available!
#> ✖ Args: group = "55", season_dates = "20250128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:14.059149: Invalid arguments or no scoreboard data for 20250128 available!
#> ✖ Args: group = "100", season_dates = "20250128"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:14.232154: Invalid arguments or no scoreboard data for 20250129 available!
#> ✖ Args: group = "56", season_dates = "20250129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:14.409779: Invalid arguments or no scoreboard data for 20250129 available!
#> ✖ Args: group = "55", season_dates = "20250129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:15.14117: Invalid arguments or no scoreboard data for 20250129 available!
#> ✖ Args: group = "100", season_dates = "20250129"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:15.33527: Invalid arguments or no scoreboard data for 20250130 available!
#> ✖ Args: group = "56", season_dates = "20250130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:15.502253: Invalid arguments or no scoreboard data for 20250130 available!
#> ✖ Args: group = "55", season_dates = "20250130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:16.042747: Invalid arguments or no scoreboard data for 20250130 available!
#> ✖ Args: group = "100", season_dates = "20250130"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:16.290834: Invalid arguments or no scoreboard data for 20250131 available!
#> ✖ Args: group = "56", season_dates = "20250131"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:16.469203: Invalid arguments or no scoreboard data for 20250131 available!
#> ✖ Args: group = "55", season_dates = "20250131"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:16.842801: Invalid arguments or no scoreboard data for 20250131 available!
#> ✖ Args: group = "100", season_dates = "20250131"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:17.02354: Invalid arguments or no scoreboard data for 20250201 available!
#> ✖ Args: group = "56", season_dates = "20250201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:17.342613: Invalid arguments or no scoreboard data for 20250201 available!
#> ✖ Args: group = "55", season_dates = "20250201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:18.121815: Invalid arguments or no scoreboard data for 20250201 available!
#> ✖ Args: group = "100", season_dates = "20250201"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:18.297249: Invalid arguments or no scoreboard data for 20250202 available!
#> ✖ Args: group = "56", season_dates = "20250202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:18.488523: Invalid arguments or no scoreboard data for 20250202 available!
#> ✖ Args: group = "55", season_dates = "20250202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:18.917002: Invalid arguments or no scoreboard data for 20250202 available!
#> ✖ Args: group = "100", season_dates = "20250202"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:19.095606: Invalid arguments or no scoreboard data for 20250203 available!
#> ✖ Args: group = "56", season_dates = "20250203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:19.268985: Invalid arguments or no scoreboard data for 20250203 available!
#> ✖ Args: group = "55", season_dates = "20250203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:19.787219: Invalid arguments or no scoreboard data for 20250203 available!
#> ✖ Args: group = "100", season_dates = "20250203"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:19.941674: Invalid arguments or no scoreboard data for 20250204 available!
#> ✖ Args: group = "56", season_dates = "20250204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:20.113231: Invalid arguments or no scoreboard data for 20250204 available!
#> ✖ Args: group = "55", season_dates = "20250204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:20.609541: Invalid arguments or no scoreboard data for 20250204 available!
#> ✖ Args: group = "100", season_dates = "20250204"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:20.835486: Invalid arguments or no scoreboard data for 20250205 available!
#> ✖ Args: group = "56", season_dates = "20250205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:21.064033: Invalid arguments or no scoreboard data for 20250205 available!
#> ✖ Args: group = "55", season_dates = "20250205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:21.576455: Invalid arguments or no scoreboard data for 20250205 available!
#> ✖ Args: group = "100", season_dates = "20250205"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:21.748917: Invalid arguments or no scoreboard data for 20250206 available!
#> ✖ Args: group = "56", season_dates = "20250206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:21.926222: Invalid arguments or no scoreboard data for 20250206 available!
#> ✖ Args: group = "55", season_dates = "20250206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:22.454903: Invalid arguments or no scoreboard data for 20250206 available!
#> ✖ Args: group = "100", season_dates = "20250206"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:22.639122: Invalid arguments or no scoreboard data for 20250207 available!
#> ✖ Args: group = "56", season_dates = "20250207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:22.809031: Invalid arguments or no scoreboard data for 20250207 available!
#> ✖ Args: group = "55", season_dates = "20250207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:23.197845: Invalid arguments or no scoreboard data for 20250207 available!
#> ✖ Args: group = "100", season_dates = "20250207"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:23.347492: Invalid arguments or no scoreboard data for 20250208 available!
#> ✖ Args: group = "56", season_dates = "20250208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:23.628026: Invalid arguments or no scoreboard data for 20250208 available!
#> ✖ Args: group = "55", season_dates = "20250208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:24.302108: Invalid arguments or no scoreboard data for 20250208 available!
#> ✖ Args: group = "100", season_dates = "20250208"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:24.552492: Invalid arguments or no scoreboard data for 20250209 available!
#> ✖ Args: group = "56", season_dates = "20250209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:24.733646: Invalid arguments or no scoreboard data for 20250209 available!
#> ✖ Args: group = "55", season_dates = "20250209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:25.177267: Invalid arguments or no scoreboard data for 20250209 available!
#> ✖ Args: group = "100", season_dates = "20250209"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:25.353519: Invalid arguments or no scoreboard data for 20250210 available!
#> ✖ Args: group = "56", season_dates = "20250210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:25.491491: Invalid arguments or no scoreboard data for 20250210 available!
#> ✖ Args: group = "55", season_dates = "20250210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:25.993011: Invalid arguments or no scoreboard data for 20250210 available!
#> ✖ Args: group = "100", season_dates = "20250210"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:26.142644: Invalid arguments or no scoreboard data for 20250211 available!
#> ✖ Args: group = "56", season_dates = "20250211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:26.285192: Invalid arguments or no scoreboard data for 20250211 available!
#> ✖ Args: group = "55", season_dates = "20250211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:26.822351: Invalid arguments or no scoreboard data for 20250211 available!
#> ✖ Args: group = "100", season_dates = "20250211"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:26.985481: Invalid arguments or no scoreboard data for 20250212 available!
#> ✖ Args: group = "56", season_dates = "20250212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:27.156168: Invalid arguments or no scoreboard data for 20250212 available!
#> ✖ Args: group = "55", season_dates = "20250212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:27.775509: Invalid arguments or no scoreboard data for 20250212 available!
#> ✖ Args: group = "100", season_dates = "20250212"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:27.959197: Invalid arguments or no scoreboard data for 20250213 available!
#> ✖ Args: group = "56", season_dates = "20250213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:28.184968: Invalid arguments or no scoreboard data for 20250213 available!
#> ✖ Args: group = "55", season_dates = "20250213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:28.744834: Invalid arguments or no scoreboard data for 20250213 available!
#> ✖ Args: group = "100", season_dates = "20250213"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:28.906656: Invalid arguments or no scoreboard data for 20250214 available!
#> ✖ Args: group = "56", season_dates = "20250214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:29.092808: Invalid arguments or no scoreboard data for 20250214 available!
#> ✖ Args: group = "55", season_dates = "20250214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:29.59526: Invalid arguments or no scoreboard data for 20250214 available!
#> ✖ Args: group = "100", season_dates = "20250214"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:29.767285: Invalid arguments or no scoreboard data for 20250215 available!
#> ✖ Args: group = "56", season_dates = "20250215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:29.952701: Invalid arguments or no scoreboard data for 20250215 available!
#> ✖ Args: group = "55", season_dates = "20250215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:30.673199: Invalid arguments or no scoreboard data for 20250215 available!
#> ✖ Args: group = "100", season_dates = "20250215"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:30.881052: Invalid arguments or no scoreboard data for 20250216 available!
#> ✖ Args: group = "56", season_dates = "20250216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:31.062814: Invalid arguments or no scoreboard data for 20250216 available!
#> ✖ Args: group = "55", season_dates = "20250216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:31.521565: Invalid arguments or no scoreboard data for 20250216 available!
#> ✖ Args: group = "100", season_dates = "20250216"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:31.738614: Invalid arguments or no scoreboard data for 20250217 available!
#> ✖ Args: group = "56", season_dates = "20250217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:31.920307: Invalid arguments or no scoreboard data for 20250217 available!
#> ✖ Args: group = "55", season_dates = "20250217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:32.33308: Invalid arguments or no scoreboard data for 20250217 available!
#> ✖ Args: group = "100", season_dates = "20250217"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:32.510354: Invalid arguments or no scoreboard data for 20250218 available!
#> ✖ Args: group = "56", season_dates = "20250218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:32.680958: Invalid arguments or no scoreboard data for 20250218 available!
#> ✖ Args: group = "55", season_dates = "20250218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:33.183564: Invalid arguments or no scoreboard data for 20250218 available!
#> ✖ Args: group = "100", season_dates = "20250218"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:33.381778: Invalid arguments or no scoreboard data for 20250219 available!
#> ✖ Args: group = "56", season_dates = "20250219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:33.567334: Invalid arguments or no scoreboard data for 20250219 available!
#> ✖ Args: group = "55", season_dates = "20250219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:34.097484: Invalid arguments or no scoreboard data for 20250219 available!
#> ✖ Args: group = "100", season_dates = "20250219"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:34.278307: Invalid arguments or no scoreboard data for 20250220 available!
#> ✖ Args: group = "56", season_dates = "20250220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:34.451782: Invalid arguments or no scoreboard data for 20250220 available!
#> ✖ Args: group = "55", season_dates = "20250220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:35.213618: Invalid arguments or no scoreboard data for 20250220 available!
#> ✖ Args: group = "100", season_dates = "20250220"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:35.39751: Invalid arguments or no scoreboard data for 20250221 available!
#> ✖ Args: group = "56", season_dates = "20250221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:35.560989: Invalid arguments or no scoreboard data for 20250221 available!
#> ✖ Args: group = "55", season_dates = "20250221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:36.017554: Invalid arguments or no scoreboard data for 20250221 available!
#> ✖ Args: group = "100", season_dates = "20250221"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:36.187974: Invalid arguments or no scoreboard data for 20250222 available!
#> ✖ Args: group = "56", season_dates = "20250222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:36.371615: Invalid arguments or no scoreboard data for 20250222 available!
#> ✖ Args: group = "55", season_dates = "20250222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:37.063263: Invalid arguments or no scoreboard data for 20250222 available!
#> ✖ Args: group = "100", season_dates = "20250222"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:37.248633: Invalid arguments or no scoreboard data for 20250223 available!
#> ✖ Args: group = "56", season_dates = "20250223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:37.423944: Invalid arguments or no scoreboard data for 20250223 available!
#> ✖ Args: group = "55", season_dates = "20250223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:38.101115: Invalid arguments or no scoreboard data for 20250223 available!
#> ✖ Args: group = "100", season_dates = "20250223"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:38.26652: Invalid arguments or no scoreboard data for 20250224 available!
#> ✖ Args: group = "56", season_dates = "20250224"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:38.456345: Invalid arguments or no scoreboard data for 20250224 available!
#> ✖ Args: group = "55", season_dates = "20250224"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:38.945495: Invalid arguments or no scoreboard data for 20250224 available!
#> ✖ Args: group = "100", season_dates = "20250224"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:39.180252: Invalid arguments or no scoreboard data for 20250225 available!
#> ✖ Args: group = "56", season_dates = "20250225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:39.3735: Invalid arguments or no scoreboard data for 20250225 available!
#> ✖ Args: group = "55", season_dates = "20250225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:40.060013: Invalid arguments or no scoreboard data for 20250225 available!
#> ✖ Args: group = "100", season_dates = "20250225"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:40.202098: Invalid arguments or no scoreboard data for 20250226 available!
#> ✖ Args: group = "56", season_dates = "20250226"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:40.37765: Invalid arguments or no scoreboard data for 20250226 available!
#> ✖ Args: group = "55", season_dates = "20250226"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:40.989514: Invalid arguments or no scoreboard data for 20250226 available!
#> ✖ Args: group = "100", season_dates = "20250226"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:41.166618: Invalid arguments or no scoreboard data for 20250227 available!
#> ✖ Args: group = "56", season_dates = "20250227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:41.358473: Invalid arguments or no scoreboard data for 20250227 available!
#> ✖ Args: group = "55", season_dates = "20250227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:41.887372: Invalid arguments or no scoreboard data for 20250227 available!
#> ✖ Args: group = "100", season_dates = "20250227"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:42.070868: Invalid arguments or no scoreboard data for 20250228 available!
#> ✖ Args: group = "56", season_dates = "20250228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:42.249886: Invalid arguments or no scoreboard data for 20250228 available!
#> ✖ Args: group = "55", season_dates = "20250228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:42.83817: Invalid arguments or no scoreboard data for 20250228 available!
#> ✖ Args: group = "100", season_dates = "20250228"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:43.043767: Invalid arguments or no scoreboard data for 20250301 available!
#> ✖ Args: group = "56", season_dates = "20250301"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:43.241622: Invalid arguments or no scoreboard data for 20250301 available!
#> ✖ Args: group = "55", season_dates = "20250301"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:44.041183: Invalid arguments or no scoreboard data for 20250301 available!
#> ✖ Args: group = "100", season_dates = "20250301"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:44.369807: Invalid arguments or no scoreboard data for 20250302 available!
#> ✖ Args: group = "56", season_dates = "20250302"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:44.555366: Invalid arguments or no scoreboard data for 20250302 available!
#> ✖ Args: group = "55", season_dates = "20250302"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:45.050033: Invalid arguments or no scoreboard data for 20250302 available!
#> ✖ Args: group = "100", season_dates = "20250302"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:45.223511: Invalid arguments or no scoreboard data for 20250303 available!
#> ✖ Args: group = "56", season_dates = "20250303"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:45.405935: Invalid arguments or no scoreboard data for 20250303 available!
#> ✖ Args: group = "55", season_dates = "20250303"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:45.857388: Invalid arguments or no scoreboard data for 20250303 available!
#> ✖ Args: group = "100", season_dates = "20250303"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:46.02126: Invalid arguments or no scoreboard data for 20250304 available!
#> ✖ Args: group = "56", season_dates = "20250304"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:46.183892: Invalid arguments or no scoreboard data for 20250304 available!
#> ✖ Args: group = "55", season_dates = "20250304"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:46.71531: Invalid arguments or no scoreboard data for 20250304 available!
#> ✖ Args: group = "100", season_dates = "20250304"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:46.879083: Invalid arguments or no scoreboard data for 20250305 available!
#> ✖ Args: group = "56", season_dates = "20250305"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:47.046142: Invalid arguments or no scoreboard data for 20250305 available!
#> ✖ Args: group = "55", season_dates = "20250305"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:47.53655: Invalid arguments or no scoreboard data for 20250305 available!
#> ✖ Args: group = "100", season_dates = "20250305"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:47.815209: Invalid arguments or no scoreboard data for 20250306 available!
#> ✖ Args: group = "56", season_dates = "20250306"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:47.916649: Invalid arguments or no scoreboard data for 20250306 available!
#> ✖ Args: group = "55", season_dates = "20250306"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:48.441722: Invalid arguments or no scoreboard data for 20250306 available!
#> ✖ Args: group = "100", season_dates = "20250306"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:48.61839: Invalid arguments or no scoreboard data for 20250307 available!
#> ✖ Args: group = "56", season_dates = "20250307"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:48.757445: Invalid arguments or no scoreboard data for 20250307 available!
#> ✖ Args: group = "55", season_dates = "20250307"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:49.370134: Invalid arguments or no scoreboard data for 20250307 available!
#> ✖ Args: group = "100", season_dates = "20250307"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:49.58829: Invalid arguments or no scoreboard data for 20250308 available!
#> ✖ Args: group = "56", season_dates = "20250308"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:49.724255: Invalid arguments or no scoreboard data for 20250308 available!
#> ✖ Args: group = "55", season_dates = "20250308"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:50.458331: Invalid arguments or no scoreboard data for 20250308 available!
#> ✖ Args: group = "100", season_dates = "20250308"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:50.639366: Invalid arguments or no scoreboard data for 20250309 available!
#> ✖ Args: group = "56", season_dates = "20250309"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:50.831516: Invalid arguments or no scoreboard data for 20250309 available!
#> ✖ Args: group = "55", season_dates = "20250309"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:51.37878: Invalid arguments or no scoreboard data for 20250309 available!
#> ✖ Args: group = "100", season_dates = "20250309"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:51.572427: Invalid arguments or no scoreboard data for 20250310 available!
#> ✖ Args: group = "56", season_dates = "20250310"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:51.759406: Invalid arguments or no scoreboard data for 20250310 available!
#> ✖ Args: group = "55", season_dates = "20250310"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:52.258854: Invalid arguments or no scoreboard data for 20250310 available!
#> ✖ Args: group = "100", season_dates = "20250310"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:52.569566: Invalid arguments or no scoreboard data for 20250311 available!
#> ✖ Args: group = "56", season_dates = "20250311"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:52.760395: Invalid arguments or no scoreboard data for 20250311 available!
#> ✖ Args: group = "55", season_dates = "20250311"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:53.358999: Invalid arguments or no scoreboard data for 20250311 available!
#> ✖ Args: group = "100", season_dates = "20250311"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:53.535917: Invalid arguments or no scoreboard data for 20250312 available!
#> ✖ Args: group = "56", season_dates = "20250312"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:53.732882: Invalid arguments or no scoreboard data for 20250312 available!
#> ✖ Args: group = "55", season_dates = "20250312"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:54.286851: Invalid arguments or no scoreboard data for 20250312 available!
#> ✖ Args: group = "100", season_dates = "20250312"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:54.493818: Invalid arguments or no scoreboard data for 20250313 available!
#> ✖ Args: group = "56", season_dates = "20250313"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:54.674027: Invalid arguments or no scoreboard data for 20250313 available!
#> ✖ Args: group = "55", season_dates = "20250313"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:55.383569: Invalid arguments or no scoreboard data for 20250313 available!
#> ✖ Args: group = "100", season_dates = "20250313"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:55.556283: Invalid arguments or no scoreboard data for 20250314 available!
#> ✖ Args: group = "56", season_dates = "20250314"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:55.788682: Invalid arguments or no scoreboard data for 20250314 available!
#> ✖ Args: group = "55", season_dates = "20250314"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:56.201843: Invalid arguments or no scoreboard data for 20250314 available!
#> ✖ Args: group = "100", season_dates = "20250314"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:56.377042: Invalid arguments or no scoreboard data for 20250315 available!
#> ✖ Args: group = "56", season_dates = "20250315"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:56.543459: Invalid arguments or no scoreboard data for 20250315 available!
#> ✖ Args: group = "55", season_dates = "20250315"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:57.146169: Invalid arguments or no scoreboard data for 20250315 available!
#> ✖ Args: group = "100", season_dates = "20250315"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:57.364964: Invalid arguments or no scoreboard data for 20250316 available!
#> ✖ Args: group = "56", season_dates = "20250316"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:57.574197: Invalid arguments or no scoreboard data for 20250316 available!
#> ✖ Args: group = "55", season_dates = "20250316"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:58.066493: Invalid arguments or no scoreboard data for 20250316 available!
#> ✖ Args: group = "100", season_dates = "20250316"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:58.249581: Invalid arguments or no scoreboard data for 20250318 available!
#> ✖ Args: group = "56", season_dates = "20250318"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:58.453829: Invalid arguments or no scoreboard data for 20250318 available!
#> ✖ Args: group = "55", season_dates = "20250318"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:59.099997: Invalid arguments or no scoreboard data for 20250319 available!
#> ✖ Args: group = "56", season_dates = "20250319"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:59.270747: Invalid arguments or no scoreboard data for 20250319 available!
#> ✖ Args: group = "55", season_dates = "20250319"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:45:59.908995: Invalid arguments or no scoreboard data for 20250320 available!
#> ✖ Args: group = "56", season_dates = "20250320"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:00.135715: Invalid arguments or no scoreboard data for 20250320 available!
#> ✖ Args: group = "55", season_dates = "20250320"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:00.80421: Invalid arguments or no scoreboard data for 20250321 available!
#> ✖ Args: group = "56", season_dates = "20250321"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:00.998439: Invalid arguments or no scoreboard data for 20250321 available!
#> ✖ Args: group = "55", season_dates = "20250321"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:01.79526: Invalid arguments or no scoreboard data for 20250322 available!
#> ✖ Args: group = "56", season_dates = "20250322"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:01.96524: Invalid arguments or no scoreboard data for 20250322 available!
#> ✖ Args: group = "55", season_dates = "20250322"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:02.67345: Invalid arguments or no scoreboard data for 20250323 available!
#> ✖ Args: group = "56", season_dates = "20250323"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:03.557399: Invalid arguments or no scoreboard data for 20250324 available!
#> ✖ Args: group = "56", season_dates = "20250324"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:04.191103: Invalid arguments or no scoreboard data for 20250324 available!
#> ✖ Args: group = "100", season_dates = "20250324"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:04.398083: Invalid arguments or no scoreboard data for 20250325 available!
#> ✖ Args: group = "56", season_dates = "20250325"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:05.049557: Invalid arguments or no scoreboard data for 20250325 available!
#> ✖ Args: group = "100", season_dates = "20250325"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:05.240105: Invalid arguments or no scoreboard data for 20250326 available!
#> ✖ Args: group = "56", season_dates = "20250326"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:05.846097: Invalid arguments or no scoreboard data for 20250326 available!
#> ✖ Args: group = "100", season_dates = "20250326"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:06.021048: Invalid arguments or no scoreboard data for 20250327 available!
#> ✖ Args: group = "56", season_dates = "20250327"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:06.186194: Invalid arguments or no scoreboard data for 20250327 available!
#> ✖ Args: group = "55", season_dates = "20250327"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:06.820385: Invalid arguments or no scoreboard data for 20250328 available!
#> ✖ Args: group = "56", season_dates = "20250328"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:07.011193: Invalid arguments or no scoreboard data for 20250328 available!
#> ✖ Args: group = "55", season_dates = "20250328"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:07.610884: Invalid arguments or no scoreboard data for 20250329 available!
#> ✖ Args: group = "56", season_dates = "20250329"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:07.784446: Invalid arguments or no scoreboard data for 20250329 available!
#> ✖ Args: group = "55", season_dates = "20250329"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:08.485026: Invalid arguments or no scoreboard data for 20250330 available!
#> ✖ Args: group = "56", season_dates = "20250330"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:08.653775: Invalid arguments or no scoreboard data for 20250330 available!
#> ✖ Args: group = "55", season_dates = "20250330"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:09.246351: Invalid arguments or no scoreboard data for 20250331 available!
#> ✖ Args: group = "56", season_dates = "20250331"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:09.45441: Invalid arguments or no scoreboard data for 20250331 available!
#> ✖ Args: group = "55", season_dates = "20250331"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:09.840817: Invalid arguments or no scoreboard data for 20250331 available!
#> ✖ Args: group = "100", season_dates = "20250331"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:10.013865: Invalid arguments or no scoreboard data for 20250401 available!
#> ✖ Args: group = "56", season_dates = "20250401"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:10.1859: Invalid arguments or no scoreboard data for 20250401 available!
#> ✖ Args: group = "55", season_dates = "20250401"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:10.529146: Invalid arguments or no scoreboard data for 20250401 available!
#> ✖ Args: group = "100", season_dates = "20250401"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:10.720041: Invalid arguments or no scoreboard data for 20250402 available!
#> ✖ Args: group = "56", season_dates = "20250402"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:10.901646: Invalid arguments or no scoreboard data for 20250402 available!
#> ✖ Args: group = "55", season_dates = "20250402"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:11.26635: Invalid arguments or no scoreboard data for 20250402 available!
#> ✖ Args: group = "100", season_dates = "20250402"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:11.440404: Invalid arguments or no scoreboard data for 20250403 available!
#> ✖ Args: group = "56", season_dates = "20250403"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:11.924484: Invalid arguments or no scoreboard data for 20250403 available!
#> ✖ Args: group = "55", season_dates = "20250403"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:12.298325: Invalid arguments or no scoreboard data for 20250403 available!
#> ✖ Args: group = "100", season_dates = "20250403"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:12.485079: Invalid arguments or no scoreboard data for 20250405 available!
#> ✖ Args: group = "56", season_dates = "20250405"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:12.674223: Invalid arguments or no scoreboard data for 20250405 available!
#> ✖ Args: group = "55", season_dates = "20250405"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:13.330458: Invalid arguments or no scoreboard data for 20250406 available!
#> ✖ Args: group = "56", season_dates = "20250406"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:13.5069: Invalid arguments or no scoreboard data for 20250406 available!
#> ✖ Args: group = "55", season_dates = "20250406"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:13.874415: Invalid arguments or no scoreboard data for 20250406 available!
#> ✖ Args: group = "100", season_dates = "20250406"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:14.110956: Invalid arguments or no scoreboard data for 20250407 available!
#> ✖ Args: group = "56", season_dates = "20250407"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ✖ 2026-06-30 19:46:14.304037: Invalid arguments or no scoreboard data for 20250407 available!
#> ✖ Args: group = "55", season_dates = "20250407"
#> ✖ Error: Can't select columns that don't exist. ✖ Column `competitions` doesn't exist.
#> ── MBB schedule crosswalk (ESPN / Torvik) ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-30 19:46:15 UTC
#> # A tibble: 6,302 × 14
#>    season game_date  home_espn_team_id away_espn_team_id espn_game_id bart_muid 
#>     <int> <date>                 <int>             <int> <chr>        <chr>     
#>  1   2025 2024-11-04              2305                47 401706962    HowardKan…
#>  2   2025 2024-11-04               333              2427 401719228    UNC Ashev…
#>  3   2025 2024-11-04               248              2296 401706926    Jackson S…
#>  4   2025 2024-11-04                66              2400 401706954    Mississip…
#>  5   2025 2024-11-04              2250               239 401727062    BaylorGon…
#>  6   2025 2024-11-04               150               311 401706881    MaineDuke…
#>  7   2025 2024-11-04               153              2210 401700434    ElonNorth…
#>  8   2025 2024-11-04                12              2099 401706149    CanisiusA…
#>  9   2025 2024-11-04              2633              2241 401715335    Gardner W…
#> 10   2025 2024-11-04              2116               245 401715355    Texas A&M…
#> # ℹ 6,292 more rows
#> # ℹ 8 more variables: bart_team1 <chr>, bart_team2 <chr>, bart_winner <chr>,
#> #   kp_game_id <chr>, fox_game_id <chr>, yahoo_game_id <chr>,
#> #   match_method <chr>, match_confidence <dbl>
# }
```
