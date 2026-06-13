# **Basketball-Reference NBA Injury Report**

**Get the current NBA injury report from
[Basketball-Reference](https://www.basketball-reference.com).**

One row per injured player with team, the date the status was last
updated and the injury note (status + description). No API key is
required.

**Note on RotoWorld:** RotoWorld was a long-standing NBA injuries
source, but NBC shut it down (it now redirects to
`nbcsports.com/fantasy` and the injuries tool is gone). This function
uses Basketball-Reference's live injury report instead, which is
maintained and carries the same player / team / status / note fields.

## Usage

``` r
bref_injuries()
```

## Value

A `hoopR_data` tibble with one row per injured player:

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| player      | character | Player name.                      |
| team_name   | character | Team name.                        |
| date_update | character | Date the status was last updated. |
| note        | character | Injury status and description.    |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_injuries())
#> ── NBA injury report from basketball-reference.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:22:26 UTC
#> # A tibble: 41 × 4
#>    player             team_name         date_update       note                  
#>    <chr>              <chr>             <chr>             <chr>                 
#>  1 Egor Dёmin         Brooklyn Nets     Mon, Mar 9, 2026  Out For Season (Foot)…
#>  2 Michael Porter Jr. Brooklyn Nets     Fri, Apr 3, 2026  Out For Season (Hamst…
#>  3 Day'Ron Sharpe     Brooklyn Nets     Thu, Mar 12, 2026 Out For Season (Thumb…
#>  4 Danny Wolf         Brooklyn Nets     Fri, Apr 3, 2026  Out For Season (Ankle…
#>  5 PJ Hall            Charlotte Hornets Thu, Apr 9, 2026  Out For Season (Ankle…
#>  6 Zach Collins       Chicago Bulls     Sat, Feb 21, 2026 Out For Season (Toe) …
#>  7 Noa Essengue       Chicago Bulls     Wed, Dec 3, 2025  Out For Season (Shoul…
#>  8 Jalen Smith        Chicago Bulls     Thu, Mar 26, 2026 Out For Season (Calf)…
#>  9 Kyrie Irving       Dallas Mavericks  Wed, Feb 18, 2026 Out For Season (Knee)…
#> 10 Dereck Lively II   Dallas Mavericks  Sun, Dec 21, 2025 Out For Season (Foot)…
#> # ℹ 31 more rows
# }
```
