# **IBBA Teams**

**Teams of a board and season with their standings line and club profile
fields.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Teams`

## Usage

``` r
ibba_teams(season, board_id = 5)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `5`): Competition (board) id: 5 league, 10 cup, 16
  / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34
  Supercup. Default 5.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_uid | integer | IBBA CLUB id, stable across seasons (Maccabi Tel Aviv = 10): the team_uid parameter of the roster routes. Not the per-season team_id. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_name_he | character | Team name in Hebrew, HTML-unescaped. |
| team_short_name_he | character | Short team name in Hebrew, HTML-unescaped. |
| team_name | character | Team name in English as registered for the season. |
| team_short_name | character | Short team name in English. |
| board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
| place | integer | Rank in the standings of the board (1 = first). |
| games | integer | Games played (in the standings or in the season stats). |
| wins | integer | Games won in the season so far (standings line). |
| losses | integer | Games lost in the season so far (standings line). |
| points_for | integer | Points scored over the games played. |
| points_against | integer | Points conceded over the games played. |
| table_points | integer | Standings points (2 per win, 1 per loss in the league table). |
| logo_url | character | Absolute URL of the team logo. |
| photo_path | character | Site-relative path of the photo (team or player picture); prefix with https://www.basket.co.il. |
| address_he | character | Club address in Hebrew, HTML-unescaped. |
| sponsors_he | character | Club sponsors in Hebrew, comma-separated. |
| facebook_url | character | Club Facebook page URL; null when none. |
| twitter_url | character | Club Twitter / X profile URL; null when none. |
| instagram_url | character | Club Instagram profile URL; null when none. |
| youtube_url | character | Club YouTube channel URL; null when none. |
| ticket_url | character | Ticket-sales URL; null when none. |
| subscribe_url | character | Season-ticket subscription URL; null when none. |
| coaches_he | character | Coaching staff as one Hebrew text ('head coach: ..., assistant coach: ...', in Hebrew). |

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
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md)

## Examples

``` r
# \donttest{
  try(ibba_teams(season = 2026))
#> ── IBBA teams ─────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:03 UTC
#> # A tibble: 14 × 26
#>    team_uid team_id season team_name_he             team_short_name_he team_name
#>       <int>   <int>  <int> <chr>                    <chr>              <chr>    
#>  1       10    1109   2026 "מכבי Rapyd תל אביב"     "מכבי ת\"א"        Maccabi …
#>  2        9    1110   2026 "הפועל IBI תל אביב"      "הפועל ת\"א"       Hapoel I…
#>  3        8    1112   2026 "הפועל מידטאון י-ם"      "הפועל י-ם"        Hapoel M…
#>  4        3    1118   2026 "בני Penlink הרצליה"     "בני הרצליה"       Bnei Pen…
#>  5        7    1113   2026 "הפועל נתנאל חולון"      "הפועל חולון"      Hapoel N…
#>  6       61    1122   2026 "הפועל גילת טלקום העמק"  "הפועל העמק"       Hapoel G…
#>  7        5    1123   2026 "מכבי תפוזינה ראשון לצי… "ראשון לציון"      Maccabi …
#>  8       60    1120   2026 "הפועל אלטשולר שחם ב\"ש… "הפועל ב\"ש"       Hapoel A…
#>  9       13    1111   2026 "מכבי קבוצת כנען רמת גן" "מכבי רמת גן"      Maccabi …
#> 10       17    1114   2026 "עירוני לאטי קריית אתא"  "קריית אתא"        Ironi La…
#> 11       58    1116   2026 "עירוני חי מוטורס נס צי… "נס ציונה"         Ironi Ha…
#> 12        1    1119   2026 "הפועל Rivulis גליל עלי… "גליל עליון"       Hapoel R…
#> 13       22    2109   2026 "אליצור נתניה"           "אליצור נתניה"     Elitzur …
#> 14       31    1124   2026 "מכבי אב־גד רעננה"       "מכבי רעננה"       Maccabi …
#> # ℹ 20 more variables: team_short_name <chr>, board_id <int>, place <int>,
#> #   games <int>, wins <int>, losses <int>, points_for <int>,
#> #   points_against <int>, table_points <int>, logo_url <chr>, photo_path <chr>,
#> #   address_he <chr>, sponsors_he <chr>, facebook_url <chr>, twitter_url <chr>,
#> #   instagram_url <chr>, youtube_url <chr>, ticket_url <chr>,
#> #   subscribe_url <chr>, coaches_he <chr>
# }
```
