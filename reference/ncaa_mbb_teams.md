# **Scrape NCAA Men's Baskebtall Teams (Division I, II, and III)**

This function allows the user to obtain NCAA teams by year and division

## Usage

``` r
ncaa_mbb_teams(year = most_recent_mbb_season(), division = 1, ...)
```

## Arguments

- year:

  The season for which data should be returned, in the form of "YYYY".
  Years currently available: 2002 onward.

- division:

  Division - 1, 2, 3

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

A data frame with the following variables

|               |           |
|---------------|-----------|
| col_name      | types     |
| team_id       | character |
| team_name     | character |
| team_url      | character |
| conference_id | character |
| conference    | character |
| division      | numeric   |
| year          | numeric   |
| season_id     | character |

## Details

      ncaa_mbb_teams(year = 2023, division = 1)
