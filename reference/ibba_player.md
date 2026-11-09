# **IBBA Player**

**One player-season row: jersey, team, names and photo.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerById`

## Usage

``` r
ibba_player(player_id, season)
```

## Arguments

- player_id:

  (*integer* required): Player-season id (new every season; Jaylen Hoard
  = 21912 in 2025-26): `player_id` in ibba_players.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
| jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '\_TEAM' and 'TOTAL' for its two non-player lines. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| player_name_he | character | Player name in Hebrew, HTML-unescaped. |
| player_name | character | Player name in English, HTML-unescaped. |
| is_replaced | logical | True when the person was replaced during the season (left the roster or staff). |
| is_local | logical | True for an Israeli (local) player; the isr\_ leader categories count only these. |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_player(player_id = 21912, season = 2026)

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.
