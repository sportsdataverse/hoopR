# **Genius Player Box Score**

Player box score of a finished game: minutes, shooting, rebounds,
assists and the efficiency formulas.

Endpoint:
`GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`

Rows keyed by (`tno`, `pno`), both in-game numbers; `pno` is not the
shirt number and the feed has no global player id (join across games on
name, team code and `shirt_number`). Percentages are numeric 0-100;
`minutes` is the printed `mm:ss` and `seconds_played` its seconds.

## Usage

``` r
genius_player_box(match_id, return_parsed = TRUE)
```

## Arguments

- match_id:

  Genius match id (`match_id` of
  [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
  [`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md)
  or
  [`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md)),
  e.g. 2902690.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the record parsed from an HTML page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
| name | character | Display name ('T. Nichols') |
| first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
| family_name | character | Family name in the competition's own script |
| international_first_name | character | Given name in Latin script |
| international_family_name | character | Family name in Latin script (often upper case) |
| scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
| shirt_number | character | Shirt number as a string ('0' and '00' differ) |
| playing_position | character | Playing position code (PG, SG, SF, PF, C, G, F, ...); empty string when not entered |
| starter | integer | 1 when the player started the game, else 0 |
| captain | integer | 1 for the team captain, else 0; absent in some orgs |
| active | integer | 1 when the player is on court now (at game end: on court at the final whistle), else 0 |
| minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
| seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes \* 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
| field_goals_made | integer | Field goals the player made in the game (two- and three-pointers together; a count). |
| field_goals_attempted | integer | Field goals the player attempted in the game (two- and three-pointers together; a count). |
| field_goals_percentage | double | Field-goal percentage, 0-100, rounded to an integer by the feed |
| three_pointers_made | integer | Three-pointers made |
| three_pointers_attempted | integer | Three-pointers attempted |
| three_pointers_percentage | double | Three-point percentage, 0-100, rounded to an integer |
| two_pointers_made | integer | Two-pointers made |
| two_pointers_attempted | integer | Two-pointers attempted |
| two_pointers_percentage | double | Two-point percentage, 0-100, rounded to an integer |
| free_throws_made | integer | Free throws the player made in the game (a count). |
| free_throws_attempted | integer | Free throws the player attempted in the game (a count). |
| free_throws_percentage | double | Free-throw percentage, 0-100, rounded to an integer |
| rebounds_defensive | integer | Defensive rebounds |
| rebounds_offensive | integer | Offensive rebounds |
| rebounds_total | integer | Total rebounds (offensive plus defensive) the player collected in the game. |
| assists | integer | Assists credited to the player in the game. |
| turnovers | integer | Turnovers committed by the player in the game. |
| steals | integer | Steals credited to the player in the game. |
| blocks | integer | Shots the player blocked in the game (blocks made, not received). |
| blocks_received | integer | Own shots blocked by an opponent |
| fouls_personal | integer | Personal fouls committed |
| fouls_on | integer | Fouls drawn: personal fouls committed against the player in the game. |
| points | integer | Points the player scored in the game, free throws included. |
| points_from_turnovers | integer | Points off turnovers |
| points_second_chance | integer | Second-chance points |
| points_fast_break | integer | Fast-break points |
| points_in_the_paint | integer | Points the player scored in the paint in the game (the feed's sPointsInThePaint). |
| plus_minus_points | integer | Plus/minus: team point margin while the player was on court |
| eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_3 | double | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_4 | double | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site. Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source.

**Org and season.** Every competition is an ORG code plus a competition
id (`comp_id`):
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)
lists an org's competitions with the sdv END-year `season` (a START-year
org lists 2025-26 as season 2026),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md)
maps a game to its competition, and `data.json` itself names no date,
competition or season. The hosted ORG can differ from the LiveStats ORG
of `/u/` (NZNBL vs NZN). Match ids are one global sequence across every
Genius customer. `data.json` carries no global team or player id: `tno`
(1 or 2) and `pno` are in-game numbers; only finished games are read.

**Errors** (classed conditions, all inheriting `hoopR_error`):
`hoopR_no_data` when Genius has nothing for the request (HTTP 404, the
S3 `AccessDenied` 403, an empty 200 from the hosted host, an empty
recent-games window, a schedule or widget with no matches);
`hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius
route (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is
unknown: the CloudFront "Request blocked" 403, a rate limit or 5xx, the
intermittent HTTP 500 "A website error has occurred" page
(`transient = TRUE`: retry later), a dead connection, an error envelope,
a cut-off page, an unfinished game, or a body for another match,
competition or ORG.

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_player_box(match_id = 2902690))
#> ── Genius LiveStats player box score ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:45:48 UTC
#> # A tibble: 24 × 51
#>    match_id   tno   pno name       first_name family_name international_first_…¹
#>       <int> <int> <int> <chr>      <chr>      <chr>       <chr>                 
#>  1  2902690     1    11 Τ. Νικολσ  Τάι        Νικολσ      Ty                    
#>  2  2902690     1    18 Τ. Φιντσ   Τζέιλεν    Φιντσ       Jalen                 
#>  3  2902690     1    12 Ο. Πεϊν    Ομάρ       Πεϊν        Omar                  
#>  4  2902690     1    10 Τ. Ηττουν… Τζον-Μίλτ… Ηττουνασ    John-Milton           
#>  5  2902690     1     2 Γ. Γκιουζ… Γιώργος    Γκιουζέλης  Giorgos               
#>  6  2902690     1    16 Ν. Φραϊντ… Νόα        Φραϊντελ    Noah                  
#>  7  2902690     1     4 Μ. Χατζηδ… Μανόλης    Χατζηδακησ  Manolis               
#>  8  2902690     1     1 Κ. Παπαδα… Κωνσταντί… Παπαδακησ   Konstantinos          
#>  9  2902690     1    15 Γ. Καριουσ Γουίλιαμ   Καριουσ     William Glen          
#> 10  2902690     1    17 Τ. Αντερσ… Τάιταν     Αντερσον    Tytan                 
#> # ℹ 14 more rows
#> # ℹ abbreviated name: ¹​international_first_name
#> # ℹ 44 more variables: international_family_name <chr>, scoreboard_name <chr>,
#> #   shirt_number <chr>, playing_position <chr>, starter <int>, captain <int>,
#> #   active <int>, minutes <chr>, seconds_played <int>, field_goals_made <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   three_pointers_made <int>, three_pointers_attempted <int>, …
# }
```
