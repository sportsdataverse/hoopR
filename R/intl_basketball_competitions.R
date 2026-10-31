# intl_basketball_competitions.R -- the per-competition alias registry.
#
# Copied from sportsdataverse-py tools/codegen/basketball_competitions.yaml (sportsdataverse-py origin/main
# e3d232e), keeping the hoopR genders only (men + both). One entry per competition
# over the three multi-competition engines:
#   fiba    ids$family_id = GDAP competitionMarketingNameId (one edition per season)
#   genius  ids$org = hosted ORG code, ids$live_org = LiveStats ORG of its /u/ shells;
#           label_include / label_exclude = case-insensitive regexes over the
#           competition label that pick THE competition of a season
#   atrium  ids$website_id = the embed site config id
# Every entry carries key, prefix (the alias prefix, `<prefix>_schedule`), label,
# ids, gender and season_rule; extra engine fields follow. The alias functions
# themselves live in each engine's own file (R/fiba*.R, R/genius*.R, R/atrium*.R),
# not here. To add a competition: add it to the sportsdataverse-py YAML first, then copy the
# entry here if its gender is men + both.

#' Competition registry, by engine (internal).
#' @noRd
.intl_basketball_competitions <- list(
  fiba = list(
    list(
      key = "world_cup",
      prefix = "fiba_wc",
      label = "FIBA Basketball World Cup",
      ids = list(family_id = 201L),
      gender = "men",
      season_rule = "event year (World Cup 2023 = 2023)",
      example_season = 2023L
    ),
    list(
      key = "olympics_men",
      prefix = "fiba_oly",
      label = "Men's Olympic Basketball Tournament",
      ids = list(family_id = 320L),
      gender = "men",
      season_rule = "event year (Paris 2024 = 2024)",
      example_season = 2024L
    ),
    list(
      key = "bcl",
      prefix = "fiba_bcl",
      label = "Basketball Champions League (FIBA Men's European Club Competitions Tier 1)",
      ids = list(family_id = 112L),
      gender = "men",
      season_rule = "END year (2024-25 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "afrobasket",
      prefix = "fiba_afrobasket",
      label = "FIBA AfroBasket",
      ids = list(family_id = 179L),
      gender = "men",
      season_rule = "event year (2025 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "eurobasket",
      prefix = "fiba_eurobasket",
      label = "FIBA EuroBasket",
      ids = list(family_id = 208L),
      gender = "men",
      season_rule = "event year (2025 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "americup",
      prefix = "fiba_americup",
      label = "FIBA AmeriCup",
      ids = list(family_id = 184L),
      gender = "men",
      season_rule = "event year (2025 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "asia_cup",
      prefix = "fiba_asiacup",
      label = "FIBA Asia Cup",
      ids = list(family_id = 195L),
      gender = "men",
      season_rule = "event year (2025 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "intercontinental_cup",
      prefix = "fiba_icup",
      label = "FIBA Intercontinental Cup",
      ids = list(family_id = 215L),
      gender = "men",
      season_rule = "event year (Singapore 2025 = 2025)",
      example_season = 2025L
    ),
    list(
      key = "bcl_americas",
      prefix = "fiba_bcla",
      label = "Basketball Champions League Americas",
      ids = list(family_id = 110L),
      gender = "men",
      season_rule = "END year (2024-25 = 2025)",
      example_season = 2025L
    )
  ),
  genius = list(
    list(
      key = "slb",
      prefix = "slb",
      label = "Super League Basketball (UK)",
      ids = list(org = "SLB", live_org = "SLB"),
      gender = "men",
      season_rule = "END year; the label span 2025-26 = 2026",
      label_include = "Championship",
      label_exclude = "^$"
    ),
    list(
      key = "bal",
      prefix = "bal",
      label = "Basketball Africa League",
      ids = list(org = "BAL", live_org = "BAL"),
      gender = "men",
      season_rule = "calendar year (BAL 2025 = 2025); 2023 lists two competitions, so pass comp_id",
      label_include = ".",
      label_exclude = "^$"
    ),
    list(
      key = "nznbl",
      prefix = "nznbl",
      label = "New Zealand National Basketball League",
      ids = list(org = "NZNBL", live_org = "NZN"),
      gender = "men",
      season_rule = "calendar year (2025 = 2025)",
      label_include = "national basketball league|sals nbl",
      label_exclude = "rapid|women"
    ),
    list(
      key = "esake",
      prefix = "esake",
      label = "Greek Basket League (ESAKE)",
      ids = list(org = "ESAKE", live_org = "ESAKE"),
      gender = "men",
      season_rule = "END year; Genius year + 1 (2022-23 = 2023)",
      label_include = "basket league|gbl",
      label_exclude = "super cup|woman"
    ),
    list(
      key = "lnbm",
      prefix = "lnbm",
      label = "Liga Nationala de Baschet Masculin (Romania)",
      ids = list(org = "FRB", live_org = "FRB"),
      gender = "men",
      season_rule = "END year; Genius year + 1 (2016-17 = 2017)",
      label_include = "lnbm|liga nationala de baschet masculin",
      label_exclude = "^$"
    ),
    list(
      key = "lub",
      prefix = "lub",
      label = "Liga Uruguaya de Basquetbol",
      ids = list(org = "FUBB", live_org = "FUBB"),
      gender = "men",
      season_rule = "END year; Genius year + 1 (2025-26 = 2026)",
      label_include = "liga uruguaya|^lub",
      label_exclude = "amistosos|femenina"
    )
  ),
  atrium = list(
    list(
      key = "lnb",
      prefix = "lnb",
      label = "LNB (France)",
      ids = list(website_id = 12L),
      gender = "men",
      season_rule = "END year (2026 = 2025-26; the site's own year is the START year)"
    ),
    list(
      key = "lnbp",
      prefix = "lnbp",
      label = "LNBP (Mexico, with COPA VALUE and LNBP FEMENIL)",
      ids = list(website_id = 14L),
      gender = "both",
      season_rule = "calendar year"
    ),
    list(
      key = "nbl1",
      prefix = "nbl1",
      label = "NBL1 (Australia)",
      ids = list(website_id = 3L),
      gender = "both",
      season_rule = "calendar year, Mar-Aug (END year); conferences are competition_ids"
    ),
    list(
      key = "lmb",
      prefix = "lmb",
      label = "Liga Mayor de Baloncesto (El Salvador)",
      ids = list(website_id = 13L),
      gender = "both",
      season_rule = "calendar year"
    ),
    list(
      key = "lpb",
      prefix = "lpb",
      label = "LPB / LPBF Liga Profesional de Baloncesto (Panama)",
      ids = list(website_id = 22L),
      gender = "both",
      season_rule = "calendar year"
    )
  )
)
