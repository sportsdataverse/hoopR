# Deterministic blocked fuzzy matcher (greedy within block)

Deterministic blocked fuzzy matcher (greedy within block)

## Usage

``` r
.bb_fuzzy_match(left, right, min_confidence = 0.92)
```

## Arguments

- left, right:

  data.frames with columns `.block`, `.id`, `.name_key` (and optional
  `.jersey`, `.dob`).

- min_confidence:

  Jaro-Winkler similarity floor for a fuzzy match.

## Value

data.frame: `.block`, `left_id`, `right_id`, `match_method`
(`exact_name` / `fuzzy_jw` / `unmatched`), `match_confidence`.
