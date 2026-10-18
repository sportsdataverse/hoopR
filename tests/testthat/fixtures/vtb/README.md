# VTB United League fixtures (`api.vtb-league.com/v2` and Infobasket `org.infobasket.su`)

Provenance: sdv-py origin/main `e3d232ebc9`, `tests/fixtures/vtb_league/` and `tests/fixtures/vtb_infobasket/`.
`captures/` are the sdv-internal-refs samples (refs commit `0697dd9`, `vtb/captures/{api,ib}/`, captured 2026-10-12
from the droplet, direct, no proxy) with arrays cut to 3 rows and personal data removed by the capture; `full/` are
untruncated bodies fetched 2026-10-13. Copied byte for byte under shorter names (R CMD check warns on paths over 100
characters); only the files the tests read. Four files are gzipped here to keep the package small (the bytes inside
are the sdv-py files unchanged); the two `full/` bodies were already gzipped in sdv-py. Two routes use the `full/`
body because the runtime refuses the truncated capture: the v2 matches (`meta.count` 273 vs 3 rows) and
`/Comp/GetTeamStats` (`Count` 11 vs 3 teams).

| hoopR file | sdv-py file |
|:---|:---|
| `leagues.json` | `vtb_league/captures/v2__leagues.json` |
| `league_seasons_vtb.json` | `vtb_league/captures/v2__leagues__league__seasons__vtb.json` |
| `matches_vtb_2026.json.gz` | `vtb_league/full/matches_vtb_2026.json.gz` |
| `seasons_vtb.json` | `vtb_infobasket/captures/Comp__GetSeasonsForTag__vtb.json` |
| `calendar_2026.json` | `vtb_infobasket/captures/Comp__GetCalendar__2026.json` |
| `team_stats_2026.json.gz` | `vtb_infobasket/full/team_stats_50714.json.gz` |
| `best_players_2026.json.gz` | `vtb_infobasket/captures/Comp__GetBestPlayers__compId__2026.json` (gzipped) |
| `best_teams_2026.json` | `vtb_infobasket/captures/Comp__GetBestTeams__compId__2026.json` |
| `preview_921391.json.gz` | `vtb_infobasket/captures/Comp__GetTeamStatsForPreview__gameId__2026.json` (gzipped) |
| `online_921391.json.gz` | `vtb_infobasket/captures/Widget__GetOnline__gameId__2026.json` (gzipped) |
| `online_684495.json.gz` | `vtb_infobasket/captures/Widget__GetOnline__gameId__2014.json` (gzipped; 2013-14: box score, no plays) |
| `game_page_921391.json` | `vtb_infobasket/captures/Widget__GamePage__gameId__2026.json` |
| `comp_issue_2026.json` | `vtb_infobasket/captures/Widget__CompIssue__compId__2026.json` |
| `standings_50720.json` | `vtb_infobasket/captures/Widget__CompTeamResults__compId__2026.json` |
| `cross_table_50720.json` | `vtb_infobasket/captures/Widget__CrossTable__compId__2026.json` |
| `playoff_54281.json` | `vtb_infobasket/captures/Widget__PlayOff__compId__2026.json` |
| `best_player_parameters.json` | `vtb_infobasket/captures/Widget__GetBestPlayerParameters.json` |
| `best_team_parameters.json` | `vtb_infobasket/captures/Widget__GetBestTeamParameters.json` |
| `player_423011.json` | `vtb_infobasket/captures/Widget__PlayerPage__personId.json` |
| `player_season_stats_423011.json` | `vtb_infobasket/captures/Widget__PlayerSeasonStats__personId.json` |
| `player_game_log_423011.json` | `vtb_infobasket/captures/Widget__PlayerStats__personId__2026.json` |
| `coach_131047.json` | `vtb_infobasket/captures/Widget__CoachPage__personId.json` |
| `team_2650.json` | `vtb_infobasket/captures/Widget__TeamPage__teamId.json` |
| `team_seasons_2650.json` | `vtb_infobasket/captures/Widget__GetTeamSeasons__teamId.json` |
| `team_comps_2650_2026.json` | `vtb_infobasket/captures/Widget__GetTeamComps__teamId__2026.json` |
| `roster_2650_2026.json` | `vtb_infobasket/captures/Widget__TeamRoster__teamId__2026.json` |
| `team_games_2650_2026.json` | `vtb_infobasket/captures/Widget__TeamGames__teamId__2026.json` |
| `team_stats_2650_2026.json` | `vtb_infobasket/captures/Widget__TeamStats__teamId__2026.json` |

`parity/` is sdv-py's own output on these files: each `<case>.csv` (gzipped when over 50 kB) is the frame of the
sdv-py wrapper (`sportsdataverse.basketball.vtb.<wrapper>`) called with the arguments in `VTB_CASES` of `test-vtb.R`,
its transport (`basketball_runtime._get`) faked to answer the fixture of each path, so the runtime's argument checks,
season mapping, personal-data scrub, final-game proof and scope checks run too. The season table is seeded in both
languages with sdv-py's verified `SEASON_COMP_IDS` (the 3-row seasons capture lacks 2026), so no season-table request
appears. Polars `write_csv`: nulls `\N`, booleans `true` / `false`. `dtypes.json` is each frame's polars schema and
`requests.json` every path and query sdv-py sent, in order. Generated with `/mnt/sdv_repos/sdv-py/.venv/bin/python` on
a detached worktree of sdv-py `e3d232ebc9`. A `__2014` suffix is the same wrapper on game 684495 (2013-14).
