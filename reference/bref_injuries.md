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
#> ── NBA injury report from basketball-reference.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:10:28 UTC
#> # A tibble: 85 × 4
#>    player         team_name         date_update       note                      
#>    <chr>          <chr>             <chr>             <chr>                     
#>  1 Mouhamed Gueye Atlanta Hawks     Wed, Jul 15, 2026 Out (Foot) - The Hawks sa…
#>  2 Henri Veesaar  Atlanta Hawks     Mon, Sep 21, 2026 Out For Season (ACL) - Th…
#>  3 Devin Carter   Boston Celtics    Sun, Oct 18, 2026 Out (Illness) - Carter ha…
#>  4 Egor Dëmin     Brooklyn Nets     Thu, Oct 29, 2026 Out (Leg) - The Nets said…
#>  5 Kylan Boswell  Charlotte Hornets Tue, Oct 20, 2026 Out (Knee) - Kylan Boswel…
#>  6 Kon Knueppel   Charlotte Hornets Thu, Oct 29, 2026 Out (Hamstring) - Knueppe…
#>  7 Coby White     Charlotte Hornets Mon, Oct 26, 2026 Out (Calf) - The Hornets …
#>  8 Grant Williams Charlotte Hornets Sat, Oct 31, 2026 Day To Day (Hamstring) - …
#>  9 Nic Claxton    Chicago Bulls     Mon, Oct 26, 2026 Out (Hamstring) - The Bul…
#> 10 Dailyn Swain   Chicago Bulls     Sat, Oct 31, 2026 Day To Day (Back) - Swain…
#> # ℹ 75 more rows
# }
```
