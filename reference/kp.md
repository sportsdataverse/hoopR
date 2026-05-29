# **KenPom Scraper Overview**

Authenticated scrapers for [kenpom.com](https://kenpom.com) men's
college-basketball pages. Authentication uses an `httr2` cookie jar via
[`login()`](https://hoopR.sportsdataverse.org/reference/kp_user_pw.md);
pages are pulled with `.kp_get_page(jar, url)` and parsed with `rvest`.
CSS selectors for tables are fragile — KenPom changes the HTML
occasionally and selectors may need updating.

Credentials are read from `KP_USER` / `KP_PW` env vars (or function
args). See
[`?login`](https://hoopR.sportsdataverse.org/reference/kp_user_pw.md)
for the auth flow.

## Details

### **Team / season ratings**

|  |  |
|----|----|
| Function | Purpose |
| [`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md) | Pomeroy season ratings |
| [`kp_pomeroy_archive_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_archive_ratings.md) | Historical Pomeroy ratings |
| [`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md) | Program-level ratings |
| [`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md) | Team history page |
| [`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md) | Arena reference |

### **Per-game / per-team detail**

|  |  |
|----|----|
| Function | Purpose |
| [`kp_box()`](https://hoopR.sportsdataverse.org/reference/kp_box.md) | Box-score detail |
| [`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md) | FanMatch daily slate |
| [`kp_gameplan()`](https://hoopR.sportsdataverse.org/reference/kp_gameplan.md) | Game-plan page |
| [`kp_team_lineups()`](https://hoopR.sportsdataverse.org/reference/kp_team_lineups.md) | Team lineup stats |
| [`kp_team_depth_chart()`](https://hoopR.sportsdataverse.org/reference/kp_team_depth_chart.md) | Team depth chart |
| [`kp_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/kp_team_player_stats.md) | Per-team player stats |
| [`kp_team_schedule()`](https://hoopR.sportsdataverse.org/reference/kp_team_schedule.md) | Per-team schedule |
| [`kp_team_players()`](https://hoopR.sportsdataverse.org/reference/kp_team_players.md) | Team roster |

### **Conference / efficiency / four-factor splits**

|  |  |
|----|----|
| Function | Purpose |
| [`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md) | Conference summary |
| [`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md) | Conference history |
| [`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md) | Conference stats |
| [`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md) | Efficiency rankings |
| [`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md) | Four-factor rankings |
| [`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md) | Points distribution |
| [`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md) | Team stats |
| [`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md) | Home-court advantage |

### **Player + coach + officials**

|  |  |
|----|----|
| Function | Purpose |
| [`kp_player_career()`](https://hoopR.sportsdataverse.org/reference/kp_player_career.md) | Player career page |
| [`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md) | Player stats |
| [`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md) | KenPom player of the year |
| [`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md) | Team height/experience |
| [`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md) | Coach history |
| [`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md) | Referee splits |
| [`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md) | Game officials |

### **Trends and miscellany**

[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md),
[`kp_winprob()`](https://hoopR.sportsdataverse.org/reference/kp_winprob.md),
[`kp_minutes_matrix()`](https://hoopR.sportsdataverse.org/reference/kp_minutes_matrix.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_opptracker()`](https://hoopR.sportsdataverse.org/reference/kp_opptracker.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
`kp_user_pw`.
