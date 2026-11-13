# **FIBA GAMEPAGE: box players**

Player box score of one FIBA game.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_box_players(game_id, comp, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) FIBA game id (global): gameId of a gdap schedule
  row, e.g. 100720 = the World Cup 2023 final.

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). The
  game must belong to it. Find it with fiba_gdap_editions or
  fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list (the game-page objects `game`, `playByPlay`,
  `gameDetails`, `playersTeamA`, `playersTeamB`).

## Value

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gamepage_box_players")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

FIBA's terms restrict this source. The GDAP developer-portal terms limit
API use to 'Authorized Users' (federations, organisers, FIBA partners)
and say any broader use 'is not authorised'; the fiba.basketball terms
say no portion of the site may be duplicated, redistributed or
manipulated. Users who are not themselves authorised by FIBA should
check the terms before using the wrappers.

The GDAP subscription key is public (fiba.basketball ships it in every
page); the runtime reads it from the live page at run time and never
logs it. Officials' contact details and coaches' and officials' dates of
birth are dropped from every body.

Id key spaces: competition_id is one per edition (2023 World Cup =
208182) and game_id is global across competitions (the `<gameId>` of a
game-page URL). team_id is per team per competition (Germany is 279569
at the 2023 World Cup and 281545 at Paris 2024), while organisation_id
is the stable federation or club (64 = Germany, every year); the game
page's T\_`<id>` and the play-by-play oId are organisation ids, not team
ids.

The wrapper takes the game id and its competition (comp) and builds the
real page URL from GDAP (the competition's marketing name gives the
history slug, its schedule gives the two team codes; a competition with
an event page is tried at its event URL when the archive URL answers the
not-found shell, and the Champions League host last).

Box scores start about 2006; play-by-play with shot x/y about 2012 (OVR
events) and 2017-18 (FLS club competitions). A game with no box score
raises `hoopR_no_data`; a game still live raises `hoopR_asset_fetch`.
The page request sends a browser User-Agent (sportsdataverse-py answers
fiba.basketball's HTTP 403 to plain clients with Chrome TLS; libcurl
with a browser User-Agent was served on 2026-10-18). Shot x/y are image
pixels with an unverified scale.

Errors are classed conditions (all inherit `hoopR_error`):
`hoopR_no_data` when FIBA has nothing (HTTP 404, or GDAP answers
[`{}`](https://rdrr.io/r/base/Paren.html) / `[]` for an unknown id, a
game page with no box score, a listed game whose teams are not drawn
yet); `hoopR_bad_request` for HTTP 400 / 422 or a malformed id, season
or date; `hoopR_asset_fetch` for any other failed fetch or an answer
that is not about the request (an error envelope, HTTP 401 after a key
refresh, HTTP 500, a body for another game, competition, team, player,
federation, family or season, a game of another competition than `comp`,
the HTTP 200 not-found shell of a wrong game page, a live game). Seasons
are FIBA's own key, which equals the sdv key: the END year for club
competitions, the event year for national-team events, the target
tournament year for qualifiers.

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gamepage_box_players(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_box_players from fiba.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:21 UTC
#> # A tibble: 24 × 43
#>    game_id competition_id team_side organisation_id player_id first_name
#>      <int>          <int> <chr>               <int>     <int> <chr>     
#>  1  100720         208182 A                      64    204689 David     
#>  2  100720         208182 A                      64    196287 Andreas   
#>  3  100720         208182 A                      64    198299 Johannes  
#>  4  100720         208182 A                      64    269000 Justus    
#>  5  100720         208182 A                      64    189145 Dennis    
#>  6  100720         208182 A                      64    210175 Moritz    
#>  7  100720         208182 A                      64    181996 Daniel    
#>  8  100720         208182 A                      64    227403 Franz     
#>  9  100720         208182 A                      64    188677 Johannes  
#> 10  100720         208182 A                      64    155956 Niels     
#> # ℹ 14 more rows
#> # ℹ 37 more variables: last_name <chr>, jersey <chr>, position <chr>,
#> #   is_captain <lgl>, is_starter <lgl>, has_played <lgl>, minutes <chr>,
#> #   seconds_played <int>, points <int>, fg_made <int>, fg_attempted <int>,
#> #   fg_pct <dbl>, fg2_made <int>, fg2_attempted <int>, fg2_pct <dbl>,
#> #   fg3_made <int>, fg3_attempted <int>, fg3_pct <dbl>, ft_made <int>,
#> #   ft_attempted <int>, ft_pct <dbl>, reb_offensive <int>, …
# }
```
