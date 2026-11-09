# **Get P. LEAGUE+ Preciser Shots**

Every field-goal attempt of one finished game with court x / y (vendor
frame), zone, style and result.

Endpoint: `GET https://api.preciser.io/v1/chart-data/id/{uuid}`

## Usage

``` r
pleague_preciser_shots(uuid, gid = NULL)
```

## Arguments

- uuid:

  Required. The Preciser game uuid the site's game page embeds (`uuid`
  of pleague_game; empty before 2022-23, which have no vendor data),
  e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).

- gid:

  Optional. The site's game id for this uuid. When given the runtime
  also fetches the site's game page and box (cached) and checks the
  vendor body against them (uuid, final score, made shots, roster and
  minutes); the uuid must be the game page's. Without it only the checks
  the body allows by itself run.

## Value

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_preciser_shots")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Unofficial use of a THIRD-PARTY host: api.preciser.io is the analytics
  vendor behind the P. LEAGUE+ game page, not the league's own API. It
  is keyless, CORS-open, has no robots.txt (404) and no terms were
  found; it serves the data the league's own game page displays. The
  league's /user-policy reserves its content, so check it before you
  republish the data. Requests are spaced at least 1 s apart per host,
  retries included.

- Wrappers take the Preciser game uuid (the `uuid` column of
  [`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md);
  empty before 2022-23, which have no vendor data). Pass the optional
  `gid` to verify the body against the site's game page and box: the
  shot list and the rotation echo nothing about the game, so only then
  are the uuid, the final score, the made-shot counts, the roster and
  the court time (rotation minutes within 30 s of the box) checked. An
  unknown uuid answers 200 `[]` (`hoopR_no_data`) or HTTP 500
  (`hoopR_asset_fetch`, not retried).

- Id key spaces: the vendor names teams by uuid (`team_uuid` /
  `home_team_uuid` / `away_team_uuid`) and persons by `person_id` (the
  same value as the site box row's `person_id`); the site's `team_id`
  (1-8) joins to a team uuid through
  [`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
  (the standings logo file name).

- Shot x / y are in the VENDOR frame (percent of the court, the home
  team always attacks x = 95) while the site's play-by-play x / y are in
  the physical court frame (teams swap ends at half-time): x_vendor =
  100 - x_pbp and y_vendor = 100 - y_pbp in the halves where the home
  team attacks x \< 50. The court is 28.75 x 15.25 m. Clip urls carry a
  vendor access key (?key=): it is scrubbed from every body, a body that
  still holds one is refused, and no frame keeps a url.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a body of `[]`, empty rotation lists),
  `hoopR_bad_request` (a uuid that is not a uuid, a `gid` that is not an
  integer, HTTP 400 / 422) and `hoopR_asset_fetch` (any other failed or
  wrong answer, including a `gid` whose game has another uuid and a
  redirect off the vendor host). HTTP 429 / 502 / 503 / 504 are retried,
  up to three attempts.

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_preciser_shots(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#> ── P. LEAGUE+ Shots from api.preciser.io ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:56:54 UTC
#> # A tibble: 168 × 20
#>    game_uuid      shot_no period period_label clock seconds_left side  team_uuid
#>    <chr>            <int>  <int> <chr>        <chr>        <int> <chr> <chr>    
#>  1 e6f98675-3e5b…       1      4 Q4           03:42          222 away  e8674343…
#>  2 e6f98675-3e5b…       2      2 Q2           00:17           17 home  e86394aa…
#>  3 e6f98675-3e5b…       3      2 Q2           05:57          357 home  e86394aa…
#>  4 e6f98675-3e5b…       4      1 Q1           11:41          701 away  e8674343…
#>  5 e6f98675-3e5b…       5      3 Q3           03:33          213 home  e86394aa…
#>  6 e6f98675-3e5b…       6      1 Q1           06:19          379 home  e86394aa…
#>  7 e6f98675-3e5b…       7      4 Q4           07:12          432 away  e8674343…
#>  8 e6f98675-3e5b…       8      1 Q1           11:20          680 home  e86394aa…
#>  9 e6f98675-3e5b…       9      4 Q4           10:45          645 away  e8674343…
#> 10 e6f98675-3e5b…      10      3 Q3           09:34          574 home  e86394aa…
#> # ℹ 158 more rows
#> # ℹ 12 more variables: person_id <chr>, player_name <chr>, type <chr>,
#> #   subtype <chr>, area <chr>, success <lgl>, x <dbl>, y <dbl>,
#> #   message_zh <chr>, has_video <lgl>, home_team_uuid <chr>,
#> #   away_team_uuid <chr>
# }
```
