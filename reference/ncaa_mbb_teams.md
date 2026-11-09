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

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ncaa_mbb_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

      ncaa_mbb_teams(year = 2023, division = 1)
