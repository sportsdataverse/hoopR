# **Get ESPN MBB Event Competitor Roster Entry (Per-Athlete Game-Day Row)**

Returns a single-row tibble describing one athlete's game-day roster
entry for one MBB event. Carries the **starter** flag, **didNotPlay**
flag with reason, ejection flag, and the substitution slot if the
athlete came in for another player. Pair with
[`espn_mbb_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md)
to enumerate the roster.

Returns a single-row tibble describing one athlete's game-day roster
entry for one NBA event. Carries the **starter** flag, **didNotPlay**
flag with reason, ejection flag, and the substitution slot if the
athlete came in for another player. Pair with
[`espn_nba_game_team_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md)
to enumerate the roster.

## Usage

``` r
espn_mbb_game_team_roster_entry(event_id, team_id, athlete_id, ...)

espn_nba_game_team_roster_entry(event_id, team_id, athlete_id, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- team_id:

  ESPN team identifier.

- athlete_id:

  ESPN athlete identifier.

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

A single-row tibble.

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_game_team_roster_entry(event_id = 401256760,
                                            team_id = 150,
                                            athlete_id = 4593919)
#> ✖ 2026-11-09 19:52:51.459848: Failed to retrieve ESPN mens-college-basketball event roster entry for event_id=401256760, team_id=150, athlete_id=4593919
#> ✖ Args: league = "mens-college-basketball", event_id = 401256760, team_id = 150, athlete_id = 4593919
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Competitor Roster Entry ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:51 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_game_team_roster_entry(event_id = 401283399,
                                            team_id = 13,
                                            athlete_id = 1966)
#> ✖ 2026-11-09 19:52:51.532998: Failed to retrieve ESPN nba event roster entry for event_id=401283399, team_id=13, athlete_id=1966
#> ✖ Args: league = "nba", event_id = 401283399, team_id = 13, athlete_id = 1966
#> ✖ Error: The API returned an error
#> ── ESPN NBA Event Competitor Roster Entry ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:51 UTC
#> # A tibble: 0 × 0
# }
```
