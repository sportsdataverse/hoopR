# **NBL Rosetta Seasons**

Every season of an organisation: regular, preseason, in-season cups and
test seasons, with dates.

Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/seasons`

## Usage

``` r
nbl_rosetta_seasons(org = "nbl", limit = NULL)
```

## Arguments

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_seasons")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL
  documents or supports). The terms of use were not reviewed; check them
  before you republish the data.

- Gated by a referer, not a key: every request carries Origin / Referer
  set to nbl.com.au (the runtime sends them); without them the host
  answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.

- Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for
  the 2025-26 NBL season (the stats provider changed from Genius Sports
  to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full
  event log with shot x/y for 2025-26 and, in the same shape, back to
  2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.

- One host serves three organisations; pass org='nbl' (default), 'wnbl'
  or 'nbl1'. NBL1 is the second tier (men's and women's conferences,
  calendar-year seasons).

- Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year
  is the START year for the NBL and WNBL from 1998-99 and a calendar
  year for NBL1 and the 1979-1997 winter seasons; the runtime maps it.
  Year 1998 holds two seasons (calendar 1998 and 1998-99).

- Ids: `<entity>`*id columns are DataCore ids (UUID v1; join on them),
  rosetta*`<entity>`\_id Rosetta's own. match_id is the DataCore fixture
  id every match route is keyed on.

- Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`).
  Rosetta caches a body per path and serves it whatever the query
  string, so a page cut by someone else's limit is refused
  (`hoopR_asset_fetch`); retry after the cache entry expires.

Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown
match, team, player or season id, an org or season type with nothing, or
no season in progress); `hoopR_asset_fetch` for the 403 gate body, a
stub or error envelope, a page cut by Rosetta's path cache, a body for
another org, season or entity than the one asked for, or any other
failed fetch; `hoopR_bad_request` for an unknown `org` / `season_type`,
a malformed id, or HTTP 400 / 422.

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_seasons(org = "nbl"))
#> ── NBL Rosetta seasons from prod.rosetta.nbl.com.au ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:04:27 UTC
#> # A tibble: 75 × 11
#>    org   season_id    rosetta_season_id name  season_year season_type start_date
#>    <chr> <chr>        <chr>             <chr>       <int> <chr>       <chr>     
#>  1 nbl   1b041b7b-3d… 67d4a190-40bc-4b… NBL27        2026 regular     2026-09-1…
#>  2 nbl   75edbf66-fd… 45d43145-9958-42… Test…        2026 test        2026-01-0…
#>  3 nbl   dcd2dfb6-3d… ec19e36d-dcc9-43… NBL2…        2026 preseason   2026-08-0…
#>  4 nbl   a678a0a7-58… 7a6377b7-9610-4e… Code…        2026 in_season   2026-09-0…
#>  5 nbl   31b61cc0-8d… 9554cfd7-a980-48… Pavl…        2025 in_season   2025-09-1…
#>  6 nbl   9a761374-41… 1f8e4a79-e98b-45… NBL26        2025 regular     2025-09-1…
#>  7 nbl   NA           2abf3927-fd9b-43… NBAx…        2025 in_season   2025-10-0…
#>  8 nbl   cf6ef1c7-fb… 4fb9aabf-b247-4c… Igni…        2025 regular     2026-02-2…
#>  9 nbl   b0a15fff-47… 004cb804-31c0-4e… NBL2…        2025 preseason   2025-08-0…
#> 10 nbl   e558c885-47… 09b360cf-23f2-42… CODE…        2025 in_season   2025-08-2…
#> # ℹ 65 more rows
#> # ℹ 4 more variables: end_date <chr>, competition_league_name <chr>,
#> #   competition_division <chr>, season_end_year <int>
# }
```
