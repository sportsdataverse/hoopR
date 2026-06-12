test_that(".bb_normalize_name strips accents, suffixes, and punctuation", {
  expect_equal(.bb_normalize_name("LeBron James"), "lebron james")
  expect_equal(.bb_normalize_name("De'Aaron Fox"), "deaaron fox")
  expect_equal(.bb_normalize_name("Nikola Jokić"), "nikola jokic")
  expect_equal(.bb_normalize_name("Karl-Anthony Towns"), "karl anthony towns")
  expect_equal(.bb_normalize_name("Gary Payton II"), "gary payton")
  expect_equal(.bb_normalize_name("  Luka   Dončić  "), "luka doncic")
  expect_equal(.bb_normalize_name(NA_character_), "")
})

test_that(".bb_normalize_team normalizes city+name strings", {
  expect_equal(.bb_normalize_team("Los Angeles Lakers"), "los angeles lakers")
  expect_equal(.bb_normalize_team("The Thunder"), "thunder")
  expect_equal(.bb_normalize_team("Golden State  Warriors"), "golden state warriors")
})

test_that(".bb_to_eastern returns the correct local ET game date", {
  expect_equal(.bb_to_eastern("2024-12-26T01:30:00Z"), as.Date("2024-12-25"))
  expect_equal(.bb_to_eastern("2024-12-26T16:00:00Z"), as.Date("2024-12-26"))
  expect_equal(.bb_to_eastern(as.Date("2024-12-25")), as.Date("2024-12-25"))
  expect_true(is.na(.bb_to_eastern(NA_character_)))
})

test_that(".bb_fuzzy_match does exact, fuzzy, tiebreak, and unmatched", {
  left <- data.frame(
    .block = c("A", "A", "A", "B"),
    .id = c("L1", "L2", "L3", "L4"),
    .name_key = c("lebron james", "anthony davis", "deaaron fox", "stephen curry"),
    .jersey = c("23", "3", "5", "30"), stringsAsFactors = FALSE)
  right <- data.frame(
    .block = c("A", "A", "A"),
    .id = c("R1", "R2", "R3"),
    .name_key = c("lebron james", "anthony davis", "deaaron foxx"),
    .jersey = c("23", "3", "5"), stringsAsFactors = FALSE)
  m <- .bb_fuzzy_match(left, right, min_confidence = 0.92)
  expect_equal(m$right_id[m$left_id == "L1"], "R1")
  expect_equal(m$match_method[m$left_id == "L1"], "exact_name")
  expect_equal(m$right_id[m$left_id == "L3"], "R3")
  expect_equal(m$match_method[m$left_id == "L3"], "fuzzy_jw")
  expect_true(is.na(m$right_id[m$left_id == "L4"]))
  expect_equal(m$match_method[m$left_id == "L4"], "unmatched")
})
