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

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "genius_player_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
#> ℹ Data updated: 2026-11-13 13:59:08 UTC
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
