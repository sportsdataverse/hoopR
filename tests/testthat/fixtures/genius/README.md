# genius fixtures

Copied from sdv-py `tests/fixtures/genius/` at origin/main `e3d232ebc9bf9e9f98225666a67707b8e554f9b7` (`captures/`, `full/`, `html/`, byte for byte; the
sdv-py README below gives each file's source URL and capture date).

`parity/*.csv` are sdv-py's frames on the SAME fixtures: each sdv-py public wrapper (`genius_game`, `genius_pbp`, ...) run
with its transport stubbed to answer the fixture body, written with `DataFrame.write_csv(null_value="<NA>")` (an
empty string is `""`, a null is `<NA>`). `test-genius.R` compares the R tibble to them cell by cell, counting
NA-vs-value as a mismatch. Regenerate by running the same wrappers on these files from a sdv-py checkout; never edit
them by hand.

---

Genius Sports / FIBA LiveStats (`fibalivestats.dcd.shared.geniussports.com`, `hosted.dcd.shared.geniussports.com`,
`widget.wh.geniussports.com`), fetched 2026-10-12 through the proxy pool (the droplet IP is refused by CloudFront).
The tests read only these files, never the private `sdv-internal-refs` checkout.

| Path | What | Source |
|---|---|---|
| `full/data_2902690.json.gz` | FULL, untruncated `data.json` of ESAKE match 2902690 (Peristeri - Iraklis, overtime). Gzipped because the raw body is 516 KB (33 KB gzipped); every numeric dtype of the five game frames comes from it | `GET /data/2902690/data.json` |
| `full/data_12248.json` | FULL `data.json` of WBBL match 12248, the 2014-15 era (string scores, no `actionNumber`, no `clock`) | `GET /data/12248/data.json` |
| `captures/*.json` | the sdv-internal-refs 3-row captures (commit of `genius-livestats/captures`, 2026-10-12) used as per-route fixtures: recent-games window, `/u/` record, chooser records, a schedule record, the embed record, the widget record, and BSN 2080988 (integer `s1`/`s2`) | `sdv-internal-refs/genius-livestats/captures` |
| `html/u_ESAKE_2902690.html` | the real `/u/ESAKE/2902690/` shell | `GET /u/ESAKE/2902690/` |
| `html/hosted_ESAKE_schedule.html` | the real hosted competition chooser of ESAKE (47 competitions) | `GET /ESAKE/en/schedule` |
| `html/hosted_ESAKE_28567_schedule.html` | a real hosted competition page that lists no matches (the "nothing here" case) | `GET /ESAKE/en/competition/28567/schedule?roundNumber=-1` |
| `html/hosted_ESAKE_34541_first3.html` | the first 3 real `match-wrap` blocks of ESAKE competition 34541 (the full page is 944 KB), wrapped in a minimal page | `GET /ESAKE/en/competition/34541/schedule?roundNumber=-1` |
| `html/hosted_FFBB_21849_first3.html` | the first 3 real `match-wrap` blocks of FFBB competition 21849 (LFB 2018-19), fetched 2026-10-18, wrapped in a minimal page: block 1 is an unfilled play-off slot (`To be determined`, match 1145701) with no team or match link | `GET /FFBB/en/competition/21849/schedule?roundNumber=-1` |
| `html/embednf_HKS_49946_first3.json` | the first 3 real match blocks of the HKS embed envelope (the full body is 2.5 MB) | `GET /embednf/HKS/en/competition/49946/schedule?roundNumber=-1` |
| `html/widget_ESAKE.js` | the real ESAKE results-widget script | `GET /widget/?RFJIN037I07QV520B7WEXKV1GYNA31` |

`GENIUS_PROXY` (an http(s) proxy URL) is only needed to re-capture; the tests need no network.
