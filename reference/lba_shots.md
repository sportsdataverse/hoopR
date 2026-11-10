# **Get LBA Shots**

Shooting by court zone per team for a final game (made / attempted
aggregates; zone 7 includes free throws).

Endpoint:
`GET https://www.legabasket.it/api/matches/get-championship-matches-shots-by-id`
(`info=1&id=<game_id>`)

## Usage

``` r
lba_shots(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per shooting zone. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_shots")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_shots(game_id = 25602))
#> ── LBA Shots from legabasket.it ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:03:03 UTC
#> # A tibble: 20 × 11
#>    game_id season side    team_id  zone  made attempts  perc precision num  
#>      <int>  <int> <chr>     <int> <int> <int>    <int> <dbl>     <int> <chr>
#>  1   25602   2027 home       1764     1     1        2  50           1 1/2  
#>  2   25602   2027 home       1764     2     0        1   0           1 0/1  
#>  3   25602   2027 home       1764     3    17       21  81.0         1 17/21
#>  4   25602   2027 home       1764     4     2        4  50           1 2/4  
#>  5   25602   2027 home       1764     5     1        2  50           1 1/2  
#>  6   25602   2027 home       1764     6     8       13  61.5         1 8/13 
#>  7   25602   2027 home       1764     7    28       42  66.7         1 28/42
#>  8   25602   2027 home       1764     8     5       10  50           1 5/10 
#>  9   25602   2027 home       1764     9     1        6  16.7         1 1/6  
#> 10   25602   2027 home       1764    10     0        3   0           1 0/3  
#> 11   25602   2027 visitor    1761     1     5        8  62.5         1 5/8  
#> 12   25602   2027 visitor    1761     2     1        3  33.3         1 1/3  
#> 13   25602   2027 visitor    1761     3    17       22  77.3         1 17/22
#> 14   25602   2027 visitor    1761     4     0        1   0           1 0/1  
#> 15   25602   2027 visitor    1761     5     1        3  33.3         1 1/3  
#> 16   25602   2027 visitor    1761     6     1        4  25           1 1/4  
#> 17   25602   2027 visitor    1761     7    17       26  65.4         1 17/26
#> 18   25602   2027 visitor    1761     8     4       11  36.4         1 4/11 
#> 19   25602   2027 visitor    1761     9     2        9  22.2         1 2/9  
#> 20   25602   2027 visitor    1761    10     0        5   0           1 0/5  
#> # ℹ 1 more variable: opacity <int>
# }
```
