# **Men's College Basketball KenPom Teams Dictionary** KenPom team and conference names with their KenPom page links, one row per team-season. The KenPom team functions validate `team` against `Team`; they build the page link from the name itself, so they also work for seasons this table does not list yet.

**Men's College Basketball KenPom Teams Dictionary** KenPom team and
conference names with their KenPom page links, one row per team-season.
The KenPom team functions validate `team` against `Team`; they build the
page link from the name itself, so they also work for seasons this table
does not list yet.

## Usage

``` r
teams_links
```

## Format

A data frame with 9,044 rows (one per team-season, 2002-2027) and 7
variables:

|  |  |
|----|----|
| col_name | description |
| `Team` | character. Team name as KenPom prints it (the `team` argument of the KenPom team functions). |
| `Team.link` | character. Relative KenPom team page link, `team.php?team=<team.link.ref>`. |
| `team.link.ref` | character. URL-encoded team name used in the link (`+` for spaces). |
| `Conf` | character. Conference abbreviation that season (the `conf` argument of the KenPom conference functions). |
| `Conf.link` | character. Relative KenPom conference page link, `conf.php?c=<conf.link.ref>`. |
| `conf.link.ref` | character. Conference code used in the link. |
| `Year` | integer. KenPom season (END year: 2026 = 2025-26). |
