# **NBL Rosetta Matches**

Matches of a season: ids, teams, venue, status, scores and start time
(UTC).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/matches/in/season/{season}/{season_type}`

## Usage

``` r
nbl_rosetta_matches(
  season,
  org = "nbl",
  season_type = "all",
  limit = NULL,
  offset = NULL
)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- season_type:

  (*character* default `"all"`): Season type: all (every type of the
  year), regular (includes finals), preseason, in_season (cups, Blitz,
  NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`,
  `"preseason"`, `"in_season"`, `"test"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

- offset:

  (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer
  one large limit.

## Value

A `hoopR_data` tibble with one row per match. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_matches")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_matches(org = "nbl", season = 2026, season_type = "regular"))
#> ── NBL Rosetta matches from prod.rosetta.nbl.com.au ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:15:54 UTC
#> # A tibble: 179 × 59
#>    org   match_id  external_media_id date_updated start_time start_time_datetime
#>    <chr> <chr>     <chr>             <chr>        <chr>      <chr>              
#>  1 nbl   24d0eebf… 05042026          2026-09-22T… 2026-04-0… 2026-04-05T04:30:00
#>  2 nbl   bd142077… 70344324          2026-09-22T… 2026-04-0… 2026-04-01T08:30:00
#>  3 nbl   9c76716d… 70006744          2026-09-22T… 2026-03-2… 2026-03-29T03:30:00
#>  4 nbl   796d28c2… 70006742          2026-09-22T… 2026-03-2… 2026-03-27T08:30:00
#>  5 nbl   63d262c8… 70006740          2026-09-22T… 2026-03-2… 2026-03-21T08:00:00
#>  6 nbl   0d86ffcb… 69901490          2026-09-22T… 2026-03-1… 2026-03-17T08:30:00
#>  7 nbl   2f781bb9… 69708408          2026-09-22T… 2026-03-1… 2026-03-14T09:00:00
#>  8 nbl   a657ddb1… 69614230          2026-09-22T… 2026-03-1… 2026-03-14T06:30:00
#>  9 nbl   07aa3ed0… 69708256          2026-09-22T… 2026-03-1… 2026-03-11T08:30:00
#> 10 nbl   e63caa04… 69614226          2026-09-22T… 2026-03-1… 2026-03-10T08:30:00
#> # ℹ 169 more rows
#> # ℹ 53 more variables: round <chr>, match_type <chr>, match_status <chr>,
#> #   status <chr>, home_score <int>, away_score <int>, attendance <int>,
#> #   match_slug <chr>, match_title <chr>, venue_id <chr>,
#> #   rosetta_venue_id <chr>, venue_name <chr>, venue_address <chr>,
#> #   venue_suburb <chr>, venue_state <chr>, venue_country <chr>,
#> #   venue_capacity <int>, venue_timezone <chr>, venue_code <chr>, …
# }
```
