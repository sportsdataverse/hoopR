# **IBBA Players**

**The roster of a team-season: jersey, names, position, height and birth
date.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Players`

## Usage

``` r
ibba_players(team_id, team_uid, season)
```

## Arguments

- team_id:

  (*integer* required): Team-season id (new every season; Maccabi = 1109
  in 2025-26): `team_id` in ibba_teams, ibba_games `home_team_id` /
  `away_team_id` or ibba_box_score.

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

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
| height_m | double | Height in metres (1.93). |
| position_he | character | Position in Hebrew. |
| position | character | Position code: PG, G, G-F, F, F-C or C. |
| birth_date | Date | Date of birth (public player bio); null when not published. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
[`ibba_leaders()`](https://hoopR.sportsdataverse.org/reference/ibba_leaders.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)

## Examples

``` r
# \donttest{
  try(ibba_players(season = 2026, team_id = 1109, team_uid = 10))
#> ── IBBA players ───────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:53:37 UTC
#> # A tibble: 20 × 13
#>    player_id jersey season team_id player_name_he        player_name is_replaced
#>        <int> <chr>   <int>   <int> <chr>                 <chr>       <lgl>      
#>  1     24865 00       2026    1109 "גבריאל \"איפה\" לונ… "Gabriel \… FALSE      
#>  2     21912 01       2026    1109 "ג'יילן הורד"         "Jaylen Ho… FALSE      
#>  3     21917 02       2026    1109 "ג'ימי קלארק"         "Jimmy Cla… FALSE      
#>  4     21903 03       2026    1109 "מרסיו סנטוס"         "Marcio Sa… FALSE      
#>  5     21911 04       2026    1109 "גור לביא"            "Gur Lavy"  FALSE      
#>  6     24898 05       2026    1109 "עמית עבו"            "Amit Ebo"  FALSE      
#>  7     25984 06       2026    1109 "דייויד אפיאני"       "David Efi… FALSE      
#>  8     24797 07       2026    1109 "אורן סהר"            "Oren Saha… FALSE      
#>  9     21906 08       2026    1109 "לוני ווקר"           "Lonnie Wa… FALSE      
#> 10     21913 09       2026    1109 "רומן סורקין"         "Roman Sor… FALSE      
#> 11     21901 10       2026    1109 "אושיי בריסט"         "Oshae Bri… FALSE      
#> 12     21919 11       2026    1109 "וויל ריימן"          "Will Raym… FALSE      
#> 13     21915 12       2026    1109 "ג'ון דיברתולומיאו"   "John Diba… FALSE      
#> 14     24798 13       2026    1109 "תמיר גולד"           "Tamir Gol… FALSE      
#> 15     21900 22       2026    1109 "טי.ג'יי ליף"         "T.J Leaf"  FALSE      
#> 16     24874 35       2026    1109 "זאק הנקינס"          "Zach Hank… FALSE      
#> 17     21914 45       2026    1109 "תמיר בלאט"           "Tamir Bla… FALSE      
#> 18     21910 106      2026    1109 "אורוש טריפונוביץ'"   "Uros Trif… TRUE       
#> 19     24779 114      2026    1109 "קליפורד אומורי"      "Clifford … TRUE       
#> 20     21908 121      2026    1109 "ג'ף דאוטין ג'וניור"  "Jeff Dowt… TRUE       
#> # ℹ 6 more variables: is_local <lgl>, photo_path <chr>, height_m <dbl>,
#> #   position_he <chr>, position <chr>, birth_date <date>
# }
```
