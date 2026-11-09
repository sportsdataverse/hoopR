# Return Columns

Each row is one column of a data frame a hoopR function returns: the
function (`fn`), the element of the returned list it belongs to
(`component`, empty for a function that returns a single data frame),
the column name, its type and what it holds. Type a function name into
the `fn` filter to see everything it returns, or a column name into
`col_name` to find every function that returns it. The NBA and men’s
college basketball functions show the same tables in their help pages;
for the other families this table is the column reference.

The same table ships with the package as
[`hoopR::return_columns`](https://hoopR.sportsdataverse.org/reference/return_columns.md),
so in R `subset(return_columns, fn == "nba_boxscoretraditionalv3")`
gives the rows for one function.

    #> Warning in instance$preRenderHook(instance): It seems your data is too big for
    #> client-side DataTables. You may consider server-side processing:
    #> https://rstudio.github.io/DT/server.html

## **Our Authors**

- [Saiem Gilani](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/twitter/follow/saiemgilani?color=blue&label=%40saiemgilani&logo=x&style=for-the-badge)](https://x.com/saiemgilani)
  [![@saiemgilani](https://img.shields.io/github/followers/saiemgilani?color=eee&logo=Github&style=for-the-badge)](https://github.com/saiemgilani)

### **Citation**

To cite the [**`hoopR`**](https://hoopR.sportsdataverse.org/) R package
in publications, use:

BibTeX Citation

``` bibtex
@misc{hoopr,
  author = {Saiem Gilani},
  title = {hoopR: Access Men’s Basketball Play by Play Data.},
  url = {https://hoopR.sportsdataverse.org/},
  year = {2026}
}
```
