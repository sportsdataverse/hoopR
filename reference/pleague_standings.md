# **Get P. LEAGUE+ Standings**

Regular-season standings of one season: record, scoring averages, home /
away and recent form.

Endpoint: `GET https://pleagueofficial.com/standings/{season slug}`

## Usage

``` r
pleague_standings(season)
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

## Value

A `hoopR_data` tibble: Regular-season standings of one season: record,
scoring averages, home / away and recent form. An empty valid answer is
a zero-row tibble with these columns, in this order (sportsdataverse-py
`pleague_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
| season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
| rank | integer | Rank on the page (1 = best); ties are not shared. |
| team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
| team_zh | character | Team short name in Traditional Chinese. |
| team_uuid | character | Preciser team uuid cut from the logo url (photonew.preciser.io/plg/teams/{uuid}.png): the join between the site team_id and the vendor's home_id / away_id / team_id. Clubs: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
| team_logo | character | Team logo url (photonew.preciser.io/plg/teams/{team uuid}.png). |
| games_played | integer | Games played ((Chinese text) GP). |
| wins | integer | Games won so far this season ((Chinese text) W). |
| losses | integer | Games lost so far this season ((Chinese text) L). |
| win_pct | double | Win percentage 0-100 as a whole percent ('68 percent' -\> 68.0; (Chinese text) PCT). |
| games_behind | double | Games behind the leader ((Chinese text)). |
| points_for_avg | double | Points scored per game ((Chinese text)). |
| points_against_avg | double | Points allowed per game ((Chinese text)). |
| point_diff_avg | double | Average point margin ((Chinese text)). |
| home_record | character | Home record 'W-L' ((Chinese text)). |
| away_record | character | Away record 'W-L' ((Chinese text)). |
| streak | character | Current streak: W{n} wins or L{n} losses ((Chinese text)). |
| last_n | integer | Games in the 'last games' column ((Chinese text)10(Chinese text) = the last 10), read from the header. |
| last_n_record | character | Record 'W-L' over the last last_n games ((Chinese text)N(Chinese text)). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_standings(season = 2025))
#> Error in pleague_standings(season = 2025) : 
#>   pleagueofficial.com/standings/2024-25: not the page asked for: layout
#> drift: standings table not found
# }
```
