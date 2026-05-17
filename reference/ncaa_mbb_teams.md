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

|               |           |                                                 |
|---------------|-----------|-------------------------------------------------|
| col_name      | types     | description                                     |
| team_id       | character | Unique team identifier.                         |
| team_name     | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_url      | character | URL for team.                                   |
| conference_id | character | Conference identifier.                          |
| conference    | character | Conference.                                     |
| division      | numeric   | Team division.                                  |
| year          | numeric   | 4-digit year.                                   |
| season_id     | character | Unique season identifier.                       |

## Details

      ncaa_mbb_teams(year = 2023, division = 1)
