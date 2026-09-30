# NBA officiating data from official.nba.com

Last Two Minute (L2M) reports and referee crew assignments, scraped from
official.nba.com. Port of the scraping logic in
[atlhawksfanatic/L2M](https://github.com/atlhawksfanatic/L2M) (MIT, (c)
2019 atlhawksfanatic). official.nba.com is S3 behind Akamai Bot Manager:
a browser User-Agent is required, and a 403 means two different things –
an S3 XML `AccessDenied` body means "no such report" (signalled as a
`hoopR_no_data` condition) while an Akamai HTML interstitial means the
fetch was blocked (signalled as a `hoopR_fetch_error` condition). Each
of
[`nba_l2m()`](https://hoopR.sportsdataverse.org/reference/nba_l2m.md),
[`nba_l2m_games()`](https://hoopR.sportsdataverse.org/reference/nba_l2m_games.md)
and
[`nba_referee_assignments()`](https://hoopR.sportsdataverse.org/reference/nba_referee_assignments.md)
lists the conditions it can raise in its own Errors section.
