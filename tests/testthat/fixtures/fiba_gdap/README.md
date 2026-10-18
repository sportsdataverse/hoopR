# FIBA fixtures (fiba_gdap/ and ../fiba_gamepage/)

Copied from sdv-py (`sportsdataverse-py`) at e3d232ebc9bf9e9f98225666a67707b8e554f9b7 (origin/main), renamed short (R CMD check warns on
paths over 100 characters). `parity/*.csv` are sdv-py's parser frames on the SAME fixture
(`parse_<route>(raw, columns=_PARSER_COLUMNS[route])`, `write_csv(null_value="NA")`), generated with
sdv-py's own venv and that tree on PYTHONPATH; `fiba_gdap/parity/dtypes.csv` holds their polars dtypes.

`fiba_gamepage/page_wc2023_final.rsc.gz` is the live `RSC: 1` text/x-component payload of
https://www.fiba.basketball/en/history/201-fiba-basketball-world-cup/208182/games/100720-GER-SRB,
captured 2026-10-18; sdv-py's `_extract_page` + `_scrub` turn it into exactly
`tests/fixtures/fiba_gamepage/full/page__wc2023-final.json` (asserted when the CSVs were written).

| route | parity | fixture (sdv-py path -> here) |
|---|---|---|
| fiba_gdap_awards | parity/awards.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionawardsbyid__wc2023.json -> awards_wc2023.json |
| fiba_gdap_competition | parity/competition.csv | tests/fixtures/fiba_gdap/gdap__getGdapCompetitionById__wc2023.json -> competition_wc2023.json |
| fiba_gdap_editions | parity/editions.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionsbyseasonsandcompetitionmarketingname__world-cup-1950-2027.json -> editions_wc.json |
| fiba_gdap_federation_games | parity/federation_games.csv | tests/fixtures/fiba_gdap/gdap__getgdapfederationgamesbyfederationid__ger.json -> federation_games_ger.json |
| fiba_gdap_federation_ranking | parity/federation_ranking.csv | tests/fixtures/fiba_gdap/gdap__getgdapfederationsranking__men-world-2025-09-15.json -> federation_ranking_men.json |
| fiba_gdap_final_standings | parity/final_standings.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionfinalstandingbycompetitionid__wc2023.json -> final_standings_wc2023.json |
| fiba_gdap_game | parity/game.csv | tests/fixtures/fiba_gdap/gdap__getgdapgamebyid__wc2023-final.json -> game_wc2023_final.json |
| fiba_gdap_game_officials | parity/game_officials.csv | tests/fixtures/fiba_gdap/gdap__getgdapgamebyid__wc2023-final.json -> game_wc2023_final.json |
| fiba_gdap_game_periods | parity/game_periods.csv | tests/fixtures/fiba_gdap/gdap__getgdapgamebyid__wc2023-final.json -> game_wc2023_final.json |
| fiba_gdap_games_between | parity/games_between.csv | tests/fixtures/fiba_gdap/gdap__getgdapgamesbetweentwodates__wc2023-final-weekend.json -> games_between_wc2023.json |
| fiba_gdap_gateway_competition_ids | parity/gateway_competition_ids.csv | tests/fixtures/fiba_gdap/gdap__getcustomgateway__competitionIdsBetweenTwoDates-2025-01-14.json -> gateway_competition_ids.json |
| fiba_gdap_gateway_federation_ranking | parity/gateway_federation_ranking.csv | tests/fixtures/fiba_gdap/gdap__getcustomgateway__federationRanking-men-world.json -> gateway_federation_ranking.json |
| fiba_gdap_medal_count | parity/medal_count.csv | tests/fixtures/fiba_gdap/gdap__getgdapmedalcount__world-cup.json -> medal_count_wc.json |
| fiba_gdap_national_teams | parity/national_teams.csv | tests/fixtures/fiba_gdap/gdap__getgdapnationalteams__all.json -> national_teams.json |
| fiba_gdap_nominations | parity/nominations.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionnominationsbyid__wc2023.json -> nominations_wc2023.json |
| fiba_gdap_player_game_stats | parity/player_game_stats.csv | tests/fixtures/fiba_gdap/gdap__getgdapplayergamestatisticsbyplayerid__wc2023-bonga.json -> player_game_stats_bonga.json |
| fiba_gdap_player_info | parity/player_info.csv | tests/fixtures/fiba_gdap/gdap__getgdapplayerinfobycompetitionid__wc2023-bonga.json -> player_info_bonga.json |
| fiba_gdap_player_stats | parity/player_stats.csv | tests/fixtures/fiba_gdap/gdap__getgdapplayercompetitionstatisticsbyplayerid__wc2023-bonga.json -> player_stats_bonga.json |
| fiba_gdap_ranking_zones | parity/ranking_zones.csv | tests/fixtures/fiba_gdap/gdap__getgdaprankingzones__all.json -> ranking_zones.json |
| fiba_gdap_roster | parity/roster.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamrosterbyteamid__wc2023-ger.json -> roster_wc2023_ger.json |
| fiba_gdap_roster_coaches | parity/roster_coaches.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamrosterbyteamid__wc2023-ger.json -> roster_wc2023_ger.json |
| fiba_gdap_roster_latest | parity/roster_latest.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamlatestrosterbyteamid__bcl2025-oostende.json -> roster_latest_bcl2025.json |
| fiba_gdap_round_gamedays | parity/round_gamedays.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionroundgamedaysbyid__wc2023.json -> round_gamedays_wc2023.json |
| fiba_gdap_round_standings | parity/round_standings.csv | tests/fixtures/fiba_gdap/gdap__getgdaproundsbycompetitionid__wc2023.json -> rounds_wc2023.json |
| fiba_gdap_rounds | parity/rounds.csv | tests/fixtures/fiba_gdap/gdap__getgdaproundsbycompetitionid__wc2023.json -> rounds_wc2023.json |
| fiba_gdap_schedule | parity/schedule.csv | tests/fixtures/fiba_gdap/gdap__getgdapgamesbycompetitionid__wc2023.json -> schedule_wc2023.json |
| fiba_gdap_team_games | parity/team_games.csv | tests/fixtures/fiba_gdap/gdap__getgdapgameswithleaderdetailsbyteamid__wc2023-ger.json -> team_games_wc2023_ger.json |
| fiba_gdap_team_player_stats | parity/team_player_stats.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamstatisticsbyteamid__wc2023-ger.json -> team_stats_wc2023_ger.json |
| fiba_gdap_team_stats | parity/team_stats.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamstatisticsbyteamid__wc2023-ger.json -> team_stats_wc2023_ger.json |
| fiba_gdap_team_staff | parity/team_staff.csv | tests/fixtures/fiba_gdap/gdap__getgdapteamstaffbycompetitionid__wc2023.json -> team_staff_wc2023.json |
| fiba_gdap_teams | parity/teams.csv | tests/fixtures/fiba_gdap/gdap__getgdapcompetitionteamsbycompetitionid__wc2023.json -> teams_wc2023.json |
| fiba_gamepage_box_players | parity/box_players.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_box_teams | parity/box_teams.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_lineup | parity/lineup.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_pbp | parity/pbp.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_period_scores | parity/period_scores.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_shots | parity/shots.csv | tests/fixtures/fiba_gamepage/full/page__wc2023-final.json (as extracted from page_wc2023_final.rsc.gz) |
| fiba_gamepage_pbp | parity/pbp_elw2025.csv | tests/fixtures/fiba_gamepage/page__events__elw2025.json -> page_elw2025.json (FLS) |

Extra: `fiba_gdap/game_bcl2025.json` <- `tests/fixtures/fiba_gdap/gdap__getgdapgamebyid__bcl2025.json` (the wrong-edition test).
