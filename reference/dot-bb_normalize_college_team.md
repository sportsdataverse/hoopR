# Normalize a college team name for cross-source matching (contracting form)

Collapses "state"/"saint"/"st." to a single "st" token and "&" to "and"
so that terse Torvik/KenPom names ("Missouri St.") and ESPN's
spelled-out names ("Missouri State") resolve to the same key. The
canonical form is lossy but CONSISTENT across sources, which is what
matters for matching.

## Usage

``` r
.bb_normalize_college_team(x)
```
