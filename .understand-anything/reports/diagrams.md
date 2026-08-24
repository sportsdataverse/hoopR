# hoopR — Diagrams

Mermaid diagrams derived from the knowledge graph.

## Layer dependency map

```mermaid
flowchart LR
  L0["ESPN MBB"]
  L1["ESPN NBA"]
  L2["ESPN Shared Helpers"]
  L3["NBA Stats API"]
  L4["College Basketball Data API"]
  L5["Basketball-Reference, RealGM & Aux Sources"]
  L6["Data Loaders"]
  L7["Utilities & Crosswalks"]
  L8["Vignettes & Docs"]
  L9["CI/CD & Config"]
  L8 -->|2| L9
  L0 -->|2| L1
  L3 -->|2| L7
  L5 -->|2| L3
  L8 -->|2| L7
```

## Foundation hub (top keystones and how many files depend on them)

```mermaid
flowchart RL
  K0["cbbd_api_key.R<br/>fan-in 13"]
  DEP0(("13 files")) --> K0
  K1["bref_utils.R<br/>fan-in 7"]
  DEP1(("7 files")) --> K1
  K2["realgm_utils.R<br/>fan-in 7"]
  DEP2(("7 files")) --> K2
  K3["torvik_utils.R<br/>fan-in 6"]
  DEP3(("6 files")) --> K3
  K4["crosswalk_basketball.R<br/>fan-in 2"]
  DEP4(("2 files")) --> K4
  K5["pull_team_page.R<br/>fan-in 1"]
  DEP5(("1 files")) --> K5
  K6["espn_basketball_athlete_helpers.R<br/>fan-in 1"]
  DEP6(("1 files")) --> K6
  K7["espn_mbb_data.R<br/>fan-in 1"]
  DEP7(("1 files")) --> K7
```

## Sport families → shared foundation (one-way fan-in)

```mermaid
flowchart LR
  L0["ESPN MBB"]
  L1["ESPN NBA"]
  L2["ESPN Shared Helpers"]
  L3["NBA Stats API"]
  L4["College Basketball Data API"]
  L5["Basketball-Reference, RealGM & Aux Sources"]
  L6["Data Loaders"]
  L7["Utilities & Crosswalks"]
  L8["Vignettes & Docs"]
  L9["CI/CD & Config"]
  L3 -->|2| L7
  L5 -->|2| L3
  L8 -->|2| L7
```
