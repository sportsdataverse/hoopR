# **Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

**Get NBA Stats API Draft Board**

## Usage

``` r
nba_draftboard(season = most_recent_nba_season() - 1, ...)
```

## Arguments

- season:

  season

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: Picks, TeamsWithoutPicks,
LiveDetails

**Picks**

|  |  |  |
|----|----|----|
| col_name | types | description |
| pick_number | integer | Pick number. |
| pick_details | character | Pick details. |
| team_id | integer | Unique team identifier. |
| team_type | character | Team type. |
| team_season | integer | Team season. |
| team_team_id | integer | Unique identifier for team team. |
| team_permalink | character | Team permalink. |
| team_app_url | character | URL for team app. |
| team_trade_details | list | Team trade details. |
| team_team_name | character | Team team name. |
| team_team_abbr | character | Team team abbr. |
| team_picked_first_round | logical | Team picked first round. |
| team_picked_second_round | logical | Team picked second round. |
| team_team_record_season | character | Team team record season. |
| team_team_record_wins_and_losses | character | Team team record wins and losses. |
| team_team_record_season_finish | character | Team team record season finish. |
| team_team_record_playoffs_finish | character | Team team record playoffs finish. |
| prospect_id | integer | Unique identifier for prospect. |
| prospect_type | character | Prospect type. |
| prospect_season | integer | Prospect season. |
| prospect_display_name | character | Prospect display name. |
| prospect_first_name | character | Prospect first name. |
| prospect_last_name | character | Prospect last name. |
| prospect_permalink | character | Prospect permalink. |
| prospect_app_url | character | URL for prospect app. |
| prospect_position | character | Prospect position. |
| prospect_weight_lbs | integer | Prospect weight lbs. |
| prospect_school | character | Prospect school. |
| prospect_status | character | Prospect status. |
| prospect_birthday | character | Prospect birthday. |
| prospect_country | character | Prospect country. |
| prospect_trade_details | list | Prospect trade details. |
| prospect_height_feet_and_inches | character | Prospect height feet and inches. |
| prospect_height_inches_only | integer | Prospect height inches only. |

**TeamsWithoutPicks**

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | integer | Id. |
| type | character | Record type / category. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| team_id | integer | Unique team identifier. |
| team_record | data.frame | Team record string (e.g. '8-3' or '8-3 Overall'). |
| permalink | character | Permalink. |
| app_url | character | URL for app. |
| trade_details | list | Trade details. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbr | character | Team abbr. |
| picked_second_round | logical | Picked second round. |
| picked_first_round | logical | Picked first round. |

**LiveDetails**

|                                |         |                                 |
|--------------------------------|---------|---------------------------------|
| col_name                       | types   | description                     |
| is_draft_live                  | logical | Is draft live.                  |
| live_draft_current_pick_number | numeric | Live draft current pick number. |

## Details

      nba_draftboard(season = most_recent_nba_season() - 1)

## See also

Other NBA Draft Functions:
[`nba_draftcombinedrillresults()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinedrillresults.md),
[`nba_draftcombinenonstationaryshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinenonstationaryshooting.md),
[`nba_draftcombineplayeranthro()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombineplayeranthro.md),
[`nba_draftcombinespotshooting()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinespotshooting.md),
[`nba_draftcombinestats()`](https://hoopR.sportsdataverse.org/reference/nba_draftcombinestats.md),
[`nba_drafthistory()`](https://hoopR.sportsdataverse.org/reference/nba_drafthistory.md)

## Author

Saiem Gilani
