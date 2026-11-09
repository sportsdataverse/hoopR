# **Get ESPN Women's College Basketball Team Injuries**

**Get ESPN Women's College Basketball Team Injuries**

**Get ESPN Women's College Basketball Team Injuries**

**Get ESPN NBA Team Injuries**

**Get ESPN NBA Team Injuries**

## Usage

``` r
espn_mbb_team_injuries(team_id, ...)

espn_nba_team_injuries(team_id, ...)
```

## Arguments

- team_id:

  ESPN team identifier (character or numeric; passed as-is). Use
  [`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md)
  to look up team IDs. Example: `"2509"` (UConn).

- ...:

  Currently unused; reserved for future argument threading.

## Value

Returns a tibble of injury records for the specified MBB team. Returns
an empty tibble (zero rows) when the team has no reported injuries.

**Injuries**

Columns as documented in the shared
[espn_mbb_team_injuries_injuries_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries_injuries_schema.md)
table.

Returns a tibble of injury records for the specified NBA team. Returns
an empty tibble (zero rows) when the team has no reported injuries.

**Injuries**

Columns as documented in the shared
[espn_mbb_team_injuries_injuries_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_injuries_injuries_schema.md)
table.

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_team_injuries(team_id = "150")
# }
# \donttest{
  espn_nba_team_injuries(team_id = "13")
# }
```
