# hoopR: Access Men's Basketball Play by Play Data

A utility to quickly obtain clean and tidy men's basketball play by
play, box score, schedule and player data. More than 1,300 functions
cover the 'ESPN' API (NBA and men's college basketball, with shot
locations when available), the 'NBA Stats' API
<https://www.nba.com/stats/>, the 'NBA G League', Ken Pomeroy's men's
college basketball statistics website <https://kenpom.com> (for users
with an active subscription), the 'CollegeBasketballData' API, 'Bart
Torvik', 'RealGM', 'Basketball-Reference', 'Fox Sports', the 'NCAA',
'EuroLeague' and about two dozen international leagues and competitions
(among them 'FIBA' events, 'ACB', 'Lega Basket', 'VTB United League',
'B.LEAGUE', 'NBL', 'KBL' and 'CBA'). Loaders read the pre-built play by
play, box score and schedule data sets published by the
'SportsDataverse'.

## Details

**`stats.nba.com` / `stats.wnba.com` blocking (#142):** the NBA Stats
API family (`nba_*` wrappers targeting `stats.nba.com`) blocks requests
from datacenter/cloud IP ranges outright – calls that work from a
residential connection will fail (timeout, empty body, or an HTML error
page instead of JSON) from CI runners, most VPS/cloud hosts, and many
corporate networks. If you're hitting this from a blocked network, route
requests through a proxy on a residential/unblocked IP via
`options(hoopR.proxy = "http://host:port")` (or the `http_proxy` /
`https_proxy` environment variables, or a per-call `proxy = ` argument
where the wrapper threads `...` through to the request layer).

## See also

Useful links:

- <https://github.com/sportsdataverse/hoopR>

- <https://hoopR.sportsdataverse.org/>

- Report bugs at <https://github.com/sportsdataverse/hoopR/issues>

## Author

**Maintainer**: Saiem Gilani <saiem.gilani@gmail.com>
([ORCID](https://orcid.org/0000-0002-7194-9067)) \[copyright holder\]

Authors:

- Saiem Gilani <saiem.gilani@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-7194-9067)) \[copyright holder\]

Other contributors:

- Jason Lee <Jason@aisportsfirm.com> \[contributor\]

- Billy Fryer <billyfryer@att.net> \[contributor\]

- Ross Drucker <ross.a.drucker@gmail.com> \[contributor\]

- Vladislav Shufinskiy <hollywood.90210@mail.ru> \[contributor\]
