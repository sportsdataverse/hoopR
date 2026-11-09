# **Load provider team id and name aliases (MBB / NBA) from the data repo**

Loads every team id and name another source uses for an ESPN team, with
the seasons the source shows it on that team. Use it to map a Fox,
Yahoo, CBS, 247Sports, On3, KenPom, Torvik, NCAA or NBA Stats team id or
name onto the ESPN `team_id`. A source id means something only within
its source (Fox 25 is not ESPN 25), so always join on `source` as well.
`load_mbb_team_aliases()` reads the `mbb_groups` release tag and
`load_nba_team_aliases()` the `nba_groups` tag.

See
[`load_mbb_player_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_aliases.md)
for player ids and
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md)
for conference and division aliases.

## Usage

``` r
load_mbb_team_aliases(..., dbConnection = NULL, tablename = NULL)

load_nba_team_aliases(..., dbConnection = NULL, tablename = NULL)
```

## Arguments

- ...:

  Additional arguments passed to an underlying function that writes the
  data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per team alias.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| team_id | character | ESPN team id. |
| team_id_source | character | Id system of `team_id`: `espn`. |
| source | character | Source that uses the alias: `fox`, `yahoo`, `torvik`, `kenpom`, `ncaa`, `sports247` (247Sports) or `on3` (MBB); `fox`, `yahoo`, `cbs` or `nba_stats` (NBA). |
| source_id | character | The source's own team id (e.g. `25`, `nba.t.1`); `NA` for a name-only source (KenPom, Torvik). |
| id_kind | character | `team` (the source's id for this sport's team) or `school` (one id for every sport of a school: the stats.ncaa.org org id, 247Sports `institutionKey`, On3 `orgKey`). |
| name_kind | character | `name` or `abbreviation` when the source gives its own spelling, else `NA`. An id with a name and an abbreviation is two rows. |
| value | character | The source's own spelling of the name or abbreviation; `NA` when `name_kind` is `NA`. |
| valid_from | integer | First season (ending year) the source shows this id or name on the team, inclusive. |
| valid_to | integer | Last season (ending year) the source shows this id or name on the team, inclusive; a gap in the source splits the window into two rows. |
| match_method | character | How the row was matched: `deterministic` (a formula or shared key), `crosswalk` (carried from a published crosswalk), `curated` (a cited hand-made map); for a captured team directory, `alias`, `exact_name` (normalized name) or `dict` (curated name dictionary). |
| evidence | character | The asset or file the row came from. |

`NULL` instead, after appending the rows to `tablename`, when
`dbConnection` and `tablename` are both given.

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md),
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md),
[`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md),
[`load_mbb_player_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_aliases.md),
[`load_mbb_team_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_group_seasons.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_team_aliases())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 2,923 × 12
#>    league team_id team_id_source source    source_id  id_kind name_kind value   
#>    <chr>  <chr>   <chr>          <chr>     <chr>      <chr>   <chr>     <chr>   
#>  1 mbb    103     espn           fox       53         team    name      Boston …
#>  2 mbb    103     espn           kenpom    NA         team    name      Boston …
#>  3 mbb    103     espn           ncaa      67         school  NA        NA      
#>  4 mbb    103     espn           on3       20485      school  name      Boston …
#>  5 mbb    103     espn           sports247 24007      school  name      Boston …
#>  6 mbb    103     espn           sports247 2          team    name      Boston …
#>  7 mbb    103     espn           torvik    NA         team    name      Boston …
#>  8 mbb    103     espn           yahoo     ncaab.t.58 team    name      Boston …
#>  9 mbb    104     espn           fox       1          team    name      Boston …
#> 10 mbb    104     espn           kenpom    NA         team    name      Boston …
#> # ℹ 2,913 more rows
#> # ℹ 4 more variables: valid_from <int>, valid_to <int>, match_method <chr>,
#> #   evidence <chr>
# }
# \donttest{
  try(load_nba_team_aliases())
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 152 × 12
#>    league team_id team_id_source source    source_id  id_kind name_kind    value
#>    <chr>  <chr>   <chr>          <chr>     <chr>      <chr>   <chr>        <chr>
#>  1 nba    1       espn           cbs       333        team    abbreviation ATL  
#>  2 nba    1       espn           cbs       333        team    name         Atla…
#>  3 nba    1       espn           fox       8          team    name         Atla…
#>  4 nba    1       espn           nba_stats 1610612737 team    NA           NA   
#>  5 nba    1       espn           yahoo     nba.t.1    team    NA           NA   
#>  6 nba    10      espn           cbs       342        team    abbreviation HOU  
#>  7 nba    10      espn           cbs       342        team    name         Hous…
#>  8 nba    10      espn           fox       17         team    name         Hous…
#>  9 nba    10      espn           nba_stats 1610612745 team    NA           NA   
#> 10 nba    10      espn           yahoo     nba.t.10   team    NA           NA   
#> # ℹ 142 more rows
#> # ℹ 4 more variables: valid_from <int>, valid_to <int>, match_method <chr>,
#> #   evidence <chr>
# }
```
