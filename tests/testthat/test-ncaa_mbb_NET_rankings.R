test_that("NCAA - Get MBB NET rankings", {
  skip()
  skip_on_cran()
  skip_ncaa_mbb_test()

  x <- ncaa_mbb_NET_rankings()

  cols <- c(
    'rank', 'previous', 'school', 'conference',
    'record', 'road', 'neutral', 'home',
    'quad_1', 'quad_2', 'quad_3', 'quad_4'
  )
  expect_in(cols, colnames(x))
  expect_s3_class(x, 'data.frame')

})

test_that("NCAA - NET rankings parser runs offline", {
  # the NCAA page's table header as of April 2026, two rows
  page <- xml2::read_html(paste0(
    "<table><thead><tr><th>Rank</th><th>School</th><th>Record</th><th>Conf</th>",
    "<th>Road</th><th>Neutral</th><th>Home</th><th>Non-Div I</th><th>Prev</th>",
    "<th>Quad 1</th><th>Quad 2</th><th>Quad 3</th><th>Quad 4</th></tr></thead><tbody>",
    "<tr><td>1</td><td>Michigan</td><td>37-3</td><td>Big Ten</td><td>11-0</td><td>12-2</td>",
    "<td>14-1</td><td>0-0</td><td>2</td><td>21-3</td><td>7-0</td><td>6-0</td><td>3-0</td></tr>",
    "<tr><td>2</td><td>Duke</td><td>35-3</td><td>ACC</td><td>10-1</td><td>10-2</td>",
    "<td>15-0</td><td>0-0</td><td>1</td><td>19-3</td><td>6-0</td><td>3-0</td><td>7-0</td></tr>",
    "</tbody></table>"
  ))
  local_mocked_bindings(read_html = function(...) page, .package = "xml2")

  x <- ncaa_mbb_NET_rankings()

  cols <- c(
    'rank', 'previous', 'school', 'conference',
    'record', 'road', 'neutral', 'home',
    'quad_1', 'quad_2', 'quad_3', 'quad_4'
  )
  expect_in(cols, colnames(x))
  expect_equal(nrow(x), 2L)
  expect_equal(x$school, c("Michigan", "Duke"))
})
