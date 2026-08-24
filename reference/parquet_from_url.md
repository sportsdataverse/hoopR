# **Load .parquet file from a remote connection**

Sibling of
[`rds_from_url()`](https://hoopR.sportsdataverse.org/reference/rds_from_url.md)
for release assets published as parquet (e.g. the `mbb_ratings` /
`mbb_player_value` model-dataset tags). 404-safe: an unpublished asset
returns an empty `data.table` + a warning, matching
[`rds_from_url()`](https://hoopR.sportsdataverse.org/reference/rds_from_url.md)'s
contract, instead of raising.

## Usage

``` r
parquet_from_url(url)
```

## Arguments

- url:

  a character url

## Value

a dataframe as created by
[`arrow::read_parquet()`](https://arrow.apache.org/docs/r/reference/read_parquet.html)
