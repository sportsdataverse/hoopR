"""Regenerate the sdv-py goldens behind tests/testthat/test-euroleague.R.

The R `euroleague_*()` family mirrors sdv-py's wrappers column for column, so the
oracle is sdv-py itself: this script runs sdv-py's euroleague parsers on the
fixtures in `tests/testthat/fixtures/euroleague/` (byte copies of the recon
captures) and writes, next to them,

* `columns.json` -- per route (and `kind` / `mode` section): the fixture file, the
  column names in order, the polars dtypes mapped to R classes, and the row count;
* `gold__<key>.csv` -- the parsed frame as CSV (list cells stay JSON-encoded).

It also asserts that the parser's columns equal the returns-schema YAML
(`tools/codegen/schemas/native/euroleague/<route>.yaml`) for every route, so the
goldens, the R `@return` tables and sdv-py's documentation cannot drift apart;
`--roxygen FILE` additionally writes those YAML tables as roxygen `\tabular`
blocks (the source of the `@return` tables in `R/euroleague_*.R`).

Run with sdv-py's own venv python from a checkout at the commit named in the
fixtures README (the goldens were last generated at sdv-py `ba871739af`,
whose euroleague tree is identical to main `f3fa92d45e`):

    <sdv-py>/.venv/Scripts/python.exe data-raw/euroleague_goldens.py --sdv-py <sdv-py>

The hoopR fixtures are named by route key; the sdv-py checkout is only needed for
its parsers (importable from the venv) and its schema YAMLs.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import yaml

from sportsdataverse.euroleague import euroleague_parsers as P

HERE = Path(__file__).resolve().parent
FX = HERE.parent / "tests" / "testthat" / "fixtures" / "euroleague"

# (route, section, parser); the fixture is "<route>[__<section>].json". A section that
# is not a `kind` / `mode` value (U2025) reuses the route's un-sectioned schema.
ROUTES = [
    ("competitions", None, P.parse_euroleague),
    ("seasons", None, P.parse_euroleague),
    ("rounds", None, P.parse_euroleague),
    ("clubs", None, P.parse_euroleague),
    ("people", None, P.parse_euroleague),
    ("games", None, P.parse_euroleague),
    ("game_stats", None, P.parse_euroleague),
    ("game_report", None, P.parse_euroleague),
    ("standings", "basicstandings", P.parse_euroleague),
    ("standings", "calendarstandings", P.parse_euroleague),
    ("standings", "streaks", P.parse_euroleague),
    ("standings", "aheadbehind", P.parse_euroleague),
    ("player_stats", "traditional", P.parse_euroleague),
    ("player_stats", "advanced", P.parse_euroleague),
    ("team_stats", "traditional", P.parse_euroleague),
    ("team_stats", "advanced", P.parse_euroleague),
    ("game_points", None, P.parse_euroleague_points),
    ("game_points", "U2025", P.parse_euroleague_points),
    ("game_pbp", None, P.parse_euroleague_pbp),
    ("game_pbp", "U2025", P.parse_euroleague_pbp),
    ("game_boxscore", None, P.parse_euroleague_boxscore),
    ("game_header", None, P.parse_euroleague_header),
]
NOT_A_SECTION = {"U2025"}
RTYPE = {"String": "character", "Int64": "integer", "Float64": "numeric", "Boolean": "logical", "Null": "logical"}


def rd_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace("%", "\\%").replace("{", "\\{").replace("}", "\\}")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--sdv-py", required=True, type=Path, help="sdv-py checkout (for the schema YAMLs)")
    ap.add_argument("--roxygen", type=Path, help="also write the YAML tables as roxygen \\tabular blocks here")
    args = ap.parse_args()
    schemas_dir = args.sdv_py / "tools" / "codegen" / "schemas" / "native" / "euroleague"

    golden = {}
    for route, section, parser in ROUTES:
        key = route if section is None else f"{route}__{section}"
        fixture = f"{key}.json"
        raw = json.loads((FX / fixture).read_text(encoding="utf-8"))
        df = parser(raw)
        golden[key] = {
            "route": route,
            "section": section,
            "fixture": fixture,
            "columns": df.columns,
            "types": [RTYPE.get(str(t), str(t)) for t in df.dtypes],
            "nrow": df.height,
        }
        df.write_csv(FX / f"gold__{key}.csv")
    (FX / "columns.json").write_text(json.dumps(golden, indent=1) + "\n", encoding="utf-8", newline="\n")

    tables = {}
    for f in sorted(schemas_dir.glob("*.yaml")):
        y = yaml.safe_load(f.read_text(encoding="utf-8"))
        if y.get("kind") == "frames":
            for fr in y["frames"]:
                tables[(y["schema"], fr["section"])] = fr["columns"]
        else:
            tables[(y["schema"], None)] = y["columns"]
    bad = []
    for key, g in golden.items():
        sec = None if g["section"] in NOT_A_SECTION else g["section"]
        ycols = [c["name"] for c in tables[(g["route"], sec)]]
        if ycols != g["columns"]:
            bad.append((key, sorted(set(ycols) ^ set(g["columns"]))))
    if bad:
        raise SystemExit(f"parser columns differ from the schema YAML: {bad}")

    if args.roxygen:
        with args.roxygen.open("w", encoding="utf-8", newline="\n") as fh:
            for (schema, sec), cols in tables.items():
                fh.write(f"#### {schema} / {sec}\n")
                fh.write("#'    \\if{html}{\\tabular{lll}{\n#'       col_name \\tab types \\tab description \\cr\n")
                for c in cols:
                    fh.write(f"#'       {c['name']} \\tab {c['type']} \\tab {rd_escape(c['description'])} \\cr\n")
                fh.write(
                    "#'    }}\n#'    \\if{latex}{See the HTML help or pkgdown reference for the column table.}\n\n"
                )
    print(f"wrote columns.json + {len(golden)} gold CSVs to {FX}; {len(tables)} schema tables agree with the parsers")


if __name__ == "__main__":
    main()
