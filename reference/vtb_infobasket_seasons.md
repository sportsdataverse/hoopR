# **Get VTB Infobasket Seasons**

Season END year -\> season-level CompID for a competition tag (the table
every season-keyed wrapper maps with).

Endpoint: `GET https://org.infobasket.su/Comp/GetSeasonsForTag`

## Usage

``` r
vtb_infobasket_seasons(tag = "vtb")
```

## Arguments

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_seasons")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Source: the VTB United League (vtb-league.com) and Infobasket, the
  Russian basketball federation's stats platform (org.infobasket.su). No
  account, key or payment is needed.

- Unofficial and unsupported: both hosts are keyless public JSON
  backends of vtb-league.com. No terms of use are published; robots.txt
  is a 404 on api.vtb-league.com and org.infobasket.su (no rules;
  vtb-league.com disallows only /wp/wp-admin/). The runtime waits at
  least 1 s before every request, retries included, and honours
  Retry-After on 429 / 503. No key, cookie or proxy is used.

- Seasons are END years (2026 = 2025-26) on both backends. Infobasket
  keys everything by competition id: vtb_infobasket_seasons maps the END
  year to the season-level CompID, and the season-keyed wrappers do that
  mapping for you. CompID means three things: a season (50714), a stage
  below it (50720 regular season, 54281 playoff; stage-level wrappers
  take the stage id from vtb_infobasket_comp_issue) and, in the player
  season stats, an END year.

- Ids: the v2 matchId is the Infobasket GameID, the v2 teamId the
  Infobasket TeamID and the v2 venueId the Infobasket ArenaId. team_id
  is the key on every team route; comp_team_id (a registration in one
  stage) and the club-record id of the team page are other key spaces.
  person_id is one person across clubs and seasons.

- Errors are HTTP 200: an unknown id answers {MessageType, Message}, an
  unknown game the string 'BadRequest'; both are `hoopR_asset_fetch` (a
  failed fetch), never an empty frame. A body for another game, person,
  team, competition or season than the one asked for is
  `hoopR_asset_fetch` too, as is a game that is not final (box score,
  plays and header need GameStatus 1) and a partial GetTeamStats page.
  An empty list is `hoopR_no_data`.

- Coverage: calendars and box scores from 2009-10; play-by-play and shot
  x/y from 2022-23 only (earlier games give an empty pbp frame),
  officials in the line-ups from 2022-23. Shot x/y are decimetres from
  the basket centre (orientation unverified). Counting statistics are
  null instead of 0 on the wire (the parsers fill 0), percentages and
  averages are comma-decimal strings (the parsers return floats), the
  paint statistics are broken and dropped, and dates come in three
  encodings (the parsers return ISO strings; .NET instants as Moscow
  time with its +03:00 offset).

- Personal data: the runtime removes licence numbers, contact and
  operator-account fields for everyone and the birth dates, birth years
  and ages of coaches, referees and other officials from every body.
  Players' public bio (birth date, height, weight, nationality) is kept.

- Other tags (vtbyouth, wbc, wpremier, rfb) answer through the tag
  argument; only vtb was captured. The team routes key on the END-year
  season (sportsdataverse-py also lets a caller pass a stage CompID
  through params; the R wrappers do not).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or the host has nothing for the request: an
  empty list, a v2 season with no rows, a season without team totals),
  `hoopR_bad_request` (a malformed id or league slug, a lang other than
  en or ru, or a season the competition tag does not have) and
  `hoopR_asset_fetch` (any other non-2xx, an empty or non-JSON body, an
  error envelope or string, a game that is not final or a stub, a
  partial or possibly truncated page, or a body for another game,
  person, team, competition, league or season). HTTP 500 is retried
  (neither host answers 500 for an unknown id). Wrappers raise; they
  never warn and return empty.

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_seasons())
#> ── VTB Infobasket Seasons from org.infobasket.su ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:03:22 UTC
#> # A tibble: 18 × 6
#>    season comp_id name_ru         name_en          db    tag  
#>     <int>   <int> <chr>           <chr>            <chr> <chr>
#>  1   2010    5052 Сезон 2009/2010 Season 2009/2010 org   vtb  
#>  2   2011    6076 Сезон 2010/2011 Season 2010/2011 org   vtb  
#>  3   2012    7050 Сезон 2011/2012 Season 2011/2012 org   vtb  
#>  4   2013    8187 Сезон 2012/2013 Season 2012/2013 org   vtb  
#>  5   2014    9113 Сезон 2013/2014 Season 2013/2014 org   vtb  
#>  6   2015   10050 Сезон 2014/2015 Season 2014/2015 org   vtb  
#>  7   2016   11046 Сезон 2015/2016 Season 2015/2016 org   vtb  
#>  8   2017   14009 Сезон 2016/2017 Season 2016/2017 org   vtb  
#>  9   2018   17018 Сезон 2017/2018 Season 2017/2018 org   vtb  
#> 10   2019   30051 Сезон 2018/2019 Season 2018/2019 org   vtb  
#> 11   2020   32984 Сезон 2019/2020 Season 2019/2020 org   vtb  
#> 12   2021   34829 Сезон 2020/2021 Season 2020/2021 org   vtb  
#> 13   2022   37492 Сезон 2021/2022 Season 2021/2022 org   vtb  
#> 14   2023   39799 Сезон 2022/2023 Season 2022/2023 org   vtb  
#> 15   2024   42729 Сезон 2023/2024 Season 2023/2024 org   vtb  
#> 16   2025   46399 Сезон 2024/2025 Season 2024/2025 org   vtb  
#> 17   2026   50714 Сезон 2025/2026 Season 2025/2026 org   vtb  
#> 18   2027   55613 Сезон 2026/2027 Season 2026/2027 org   vtb  
# }
```
