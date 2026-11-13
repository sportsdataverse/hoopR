# **Load hoopR NBA official injury reports**

Loads the `nba_stats_injury_report` release: every entry of the league's
official game-day injury reports (the PDFs the NBA posts several times a
day), one row per player per game per report, with the player's status
(`Out`, `Questionable`, ...), the reason, the status on the previous
report, and the NBA Stats `game_id` / `team_id` / `person_id` the entry
was matched to.

## Usage

``` r
load_nba_stats_injury_report(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Source

The `nba_stats_injury_report` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/nba_stats_injury_report>,
published by <https://github.com/sportsdataverse/hoopR-nba-stats-data>.

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season). Published coverage starts at 2018 (2018-19).
  Pass `seasons = TRUE` for every published season.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

A `hoopR_data` tibble with one row per player per game per report.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season as its ENDING year (2026 = the 2025-26 season), the published asset's stamp. |
| report_datetime | POSIXct | Publish time of the report version the row comes from (US Eastern, naive). The league re-publishes the report through the day, so a listing repeats once per version. |
| game_date | Date | Game date as the report prints it (US Eastern). |
| game_time | character | Tip time as the report prints it ("07:30 (ET)", no AM/PM). |
| report_matchup | character | Game as the report prints it, away@home tricodes ("CLE@ATL"). |
| away_team_abbr | character | Away team tricode as the report prints it. |
| home_team_abbr | character | Home team tricode as the report prints it. |
| team | character | Team the listing belongs to, full name as printed ("Cleveland Cavaliers"). |
| report_player_name | character | Player as the report prints it, "Last, First" ("James, LeBron"); NA on a team's NOT YET SUBMITTED row. |
| current_status | character | Listed status in that version: Available, Probable, Questionable, Doubtful or Out; NA on a NOT YET SUBMITTED row. |
| reason | character | Reason as printed ("Injury/Illness - Left Ankle; Sprain"); "NOT YET SUBMITTED" for a team that had not filed by that version. |
| category | character | Category column of the early report format; last printed 2019-11-14, NA after. |
| previous_status | character | Previous Status column of the early report format; last printed 2019-12-17, NA after. |
| game_id | character | stats.nba.com game id, joined on the game date and tricodes; NA for a game postponed off its printed date, a playoff game that was not needed, or a Summer League game. |
| team_id | integer | stats.nba.com team id of the listing's team, from its printed name. |
| person_id | integer | stats.nba.com person id matched from the printed name (see match_method); NA when unmatched. |
| match_method | character | How person_id was matched: exact (full name on the team's boxscores that season), family (family name and first initial, unique on the team), league (name unique league-wide that season), roster (name on the team's roster, which lists players who have not played), or NA. |

## See also

The publishing pipeline,
<https://github.com/sportsdataverse/hoopR-nba-stats-data>, and the
Python twin `sportsdataverse.nba.load_nba_stats_injury_report()`.

Other NBA Stats loader functions:
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md),
[`load_nba_stats_draft_combine`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_draft_combine.md),
[`load_nba_stats_game_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_game_matchups.md),
[`load_nba_stats_hustle`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_hustle.md),
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md),
[`load_nba_stats_matchups()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_matchups.md),
[`load_nba_stats_metric_curves()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_metric_curves.md),
[`load_nba_stats_rolling_windows()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_rolling_windows.md),
[`load_nba_stats_synergy()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_synergy.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_injury_report(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 44,572 × 17
#>    season report_datetime     game_date  game_time report_matchup away_team_abbr
#>     <int> <dttm>              <date>     <chr>     <chr>          <chr>         
#>  1   2027 2026-10-19 00:00:00 2026-10-20 03:00 (E… BOS@DET        BOS           
#>  2   2027 2026-10-19 00:00:00 2026-10-20 03:00 (E… BOS@DET        BOS           
#>  3   2027 2026-10-19 00:00:00 2026-10-20 09:30 (E… OKC@SAS        OKC           
#>  4   2027 2026-10-19 00:00:00 2026-10-20 09:30 (E… OKC@SAS        OKC           
#>  5   2027 2026-10-19 00:00:00 2026-10-20 07:00 (E… PHI@NYK        PHI           
#>  6   2027 2026-10-19 00:00:00 2026-10-20 07:00 (E… PHI@NYK        PHI           
#>  7   2027 2026-10-19 15:45:00 2026-10-20 03:00 (E… BOS@DET        BOS           
#>  8   2027 2026-10-19 15:45:00 2026-10-20 03:00 (E… BOS@DET        BOS           
#>  9   2027 2026-10-19 15:45:00 2026-10-20 09:30 (E… OKC@SAS        OKC           
#> 10   2027 2026-10-19 15:45:00 2026-10-20 09:30 (E… OKC@SAS        OKC           
#> # ℹ 44,562 more rows
#> # ℹ 11 more variables: home_team_abbr <chr>, team <chr>,
#> #   report_player_name <chr>, current_status <chr>, reason <chr>,
#> #   category <chr>, previous_status <chr>, game_id <chr>, team_id <int>,
#> #   person_id <int>, match_method <chr>
# }
```
