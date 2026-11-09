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

A named list of `hoopR_data` tibbles: `Injuries`.

**Injuries**

|               |           |                                                   |
|---------------|-----------|---------------------------------------------------|
| col_name      | types     | description                                       |
| team_id       | character | Unique team identifier.                           |
| athlete_id    | character | Unique athlete identifier (ESPN).                 |
| athlete_name  | character | Athlete display name (ESPN).                      |
| position      | character | Listed roster position (G, F, C, etc.).           |
| status        | character | Status label.                                     |
| date          | character | Date in YYYY-MM-DD format.                        |
| type          | character | Record type / category.                           |
| side          | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| returns_at    | character |                                                   |
| short_comment | character |                                                   |
| long_comment  | character | Long-form play / event comment.                   |

An empty tibble (zero rows) when no injuries are reported.

A named list of `hoopR_data` tibbles: `Injuries`.

**Injuries**

|               |           |                                                   |
|---------------|-----------|---------------------------------------------------|
| col_name      | types     | description                                       |
| team_id       | character | Unique team identifier.                           |
| athlete_id    | character | Unique athlete identifier (ESPN).                 |
| athlete_name  | character | Athlete display name (ESPN).                      |
| position      | character | Listed roster position (G, F, C, etc.).           |
| status        | character | Status label.                                     |
| date          | character | Date in YYYY-MM-DD format.                        |
| type          | character | Record type / category.                           |
| side          | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| returns_at    | character |                                                   |
| short_comment | character |                                                   |
| long_comment  | character | Long-form play / event comment.                   |

An empty tibble (zero rows) when no injuries are reported.

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
