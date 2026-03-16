# **Load .csv / .csv.gz file from a remote connection**

This is a thin wrapper on data.table::fread

## Usage

``` r
csv_from_url(...)
```

## Arguments

- ...:

  Arguments passed on to
  [`data.table::fread`](https://rdrr.io/pkg/data.table/man/fread.html)

  `input`

  :   A single character string. The value is inspected and deferred to
      either `file=` (if no \n present), `text=` (if at least one \n is
      present) or `cmd=` (if no \n is present, at least one space is
      present, and it isn't a file name). Exactly one of `input=`,
      `file=`, `text=`, or `cmd=` should be used in the same call.

  `file`

  :   File name in working directory, path to file (passed through
      [`path.expand`](https://rdrr.io/r/base/path.expand.html) for
      convenience), or a URL starting http://, file://, etc. Compressed
      files with extension `.gz` and `.bz2` are supported if the
      `R.utils` package is installed.

  `text`

  :   The input data itself as a character vector of one or more lines,
      for example as returned by
      [`readLines()`](https://rdrr.io/r/base/readLines.html).

  `cmd`

  :   A shell command that pre-processes the file; e.g.
      `fread(cmd=paste("grep",word,"filename"))`. See Details.

  `sep`

  :   The separator between columns. Defaults to the character in the
      set `[,\t |;:]` that separates the sample of rows into the most
      number of lines with the same number of fields. Use `NULL` or `""`
      to specify no separator; i.e. each line a single character column
      like [`base::readLines`](https://rdrr.io/r/base/readLines.html)
      does.

  `sep2`

  :   The separator *within* columns. A `list` column will be returned
      where each cell is a vector of values. This is much faster using
      less working memory than `strsplit` afterwards or similar
      techniques. For each column `sep2` can be different and is the
      first character in the same set above \[`,\t |;`\], other than
      `sep`, that exists inside each field outside quoted regions in the
      sample. NB: `sep2` is not yet implemented.

  `nrows`

  :   The maximum number of rows to read. Unlike `read.table`, you do
      not need to set this to an estimate of the number of rows in the
      file for better speed because that is already automatically
      determined by `fread` almost instantly using the large sample of
      lines. `nrows=0` returns the column names and typed empty columns
      determined by the large sample; useful for a dry run of a large
      file or to quickly check format consistency of a set of files
      before starting to read any of them.

  `header`

  :   Does the first data line contain column names? Defaults according
      to whether every non-empty field on the first data line is type
      character. If so, or TRUE is supplied, any empty column names are
      given a default name.

  `na.strings`

  :   A character vector of strings which are to be interpreted as `NA`
      values. By default, `",,"` for columns of all types, including
      type `character` is read as `NA` for consistency. `,"",` is
      unambiguous and read as an empty string. To read `,NA,` as `NA`,
      set `na.strings="NA"`. To read `,,` as blank string `""`, set
      `na.strings=NULL`. When they occur in the file, the strings in
      `na.strings` should not appear quoted since that is how the string
      literal `,"NA",` is distinguished from `,NA,`, for example, when
      `na.strings="NA"`.

  `stringsAsFactors`

  :   Convert all or some character columns to factors? Acceptable
      inputs are `TRUE`, `FALSE`, or a decimal value between 0.0 and
      1.0. For `stringsAsFactors = FALSE`, all string columns are stored
      as `character` vs. all stored as `factor` when `TRUE`. When
      `stringsAsFactors = p` for `0 <= p <= 1`, string columns `col` are
      stored as `factor` if `uniqueN(col)/nrow < p`.

  `verbose`

  :   Be chatty and report timings?

  `skip`

  :   If 0 (default) start on the first line and from there finds the
      first row with a consistent number of columns. This automatically
      avoids irregular header information before the column names row.
      `skip>0` means ignore the first `skip` rows manually.
      `skip="string"` searches for `"string"` in the file (e.g. a
      substring of the column names row) and starts on that line
      (inspired by read.xls in package gdata).

  `select`

  :   A vector of column names or numbers to keep, drop the rest.
      `select` may specify types too in the same way as `colClasses`;
      i.e., a vector of `colname=type` pairs, or a `list` of
      `type=col(s)` pairs. In all forms of `select`, the order that the
      columns are specified determines the order of the columns in the
      result.

  `drop`

  :   Vector of column names or numbers to drop, keep the rest.

  `colClasses`

  :   As in
      [`utils::read.csv`](https://rdrr.io/r/utils/read.table.html);
      i.e., an unnamed vector of types corresponding to the columns in
      the file, or a named vector specifying types for a subset of the
      columns by name. The default, `NULL` means types are inferred from
      the data in the file. Further, `data.table` supports a named
      `list` of vectors of column names *or numbers* where the `list`
      names are the class names; see examples. The `list` form makes it
      easier to set a batch of columns to be a particular class. When
      column numbers are used in the `list` form, they refer to the
      column number in the file not the column number after `select` or
      `drop` has been applied. If type coercion results in an error,
      introduces `NA`s, or would result in loss of accuracy, the
      coercion attempt is aborted for that column with warning and the
      column's type is left unchanged. If you really desire data loss
      (e.g. reading `3.14` as `integer`) you have to truncate such
      columns afterwards yourself explicitly so that this is clear to
      future readers of your code.

  `integer64`

  :   "integer64" (default) reads columns detected as containing
      integers larger than 2^31 as type
      [`bit64::integer64`](https://rdrr.io/pkg/bit64/man/bit64-package.html).
      Alternatively, `"double"|"numeric"` reads as
      [`utils::read.csv`](https://rdrr.io/r/utils/read.table.html) does;
      i.e., possibly with loss of precision and if so silently. Or,
      "character".

  `dec`

  :   The decimal separator as in
      [`utils::read.csv`](https://rdrr.io/r/utils/read.table.html). When
      `"auto"` (the default), an attempt is made to decide whether `"."`
      or `","` is more suitable for this input. See details.

  `col.names`

  :   A vector of optional names for the variables (columns). The
      default is to use the header column if present or detected, or if
      not "V" followed by the column number. This is applied after
      `check.names` and before `key` and `index`.

  `check.names`

  :   default is `FALSE`. If `TRUE` then the names of the variables in
      the `data.table` are checked to ensure that they are syntactically
      valid variable names. If necessary they are adjusted (by
      [`make.names`](https://rdrr.io/r/base/make.names.html)) so that
      they are, and also to ensure that there are no duplicates.

  `encoding`

  :   default is `"unknown"`. Other possible options are `"UTF-8"` and
      `"Latin-1"`. Note: it is not used to re-encode the input, rather
      enables handling of encoded strings in their native encoding.

  `quote`

  :   By default (`"\""`), if a field starts with a double quote,
      `fread` handles embedded quotes robustly as explained under
      `Details`. If it fails, then another attempt is made to read the
      field *as is*, i.e., as if quotes are disabled. By setting
      `quote=""`, the field is always read as if quotes are disabled. It
      is not expected to ever need to pass anything other than \\\\ to
      quote; i.e., to turn it off.

  `strip.white`

  :   Logical, default `TRUE`, in which case leading and trailing
      whitespace is stripped from unquoted `"character"` fields.
      `"numeric"` fields are always stripped of leading and trailing
      whitespace.

  `fill`

  :   logical or integer (default is `FALSE`). If `TRUE` then in case
      the rows have unequal length, number of columns is estimated and
      blank fields are implicitly filled. If an integer is provided it
      is used as an upper bound for the number of columns. If `fill=Inf`
      then the whole file is read for detecting the number of columns.

  `blank.lines.skip`

  :   `logical`, default is `FALSE`. If `TRUE` blank lines in the input
      are ignored.

  `comment.char`

  :   Character vector of length one containing a single character of an
      empty string. Any text after the comment character in a line is
      ignored, including skipping comment-only lines. Use `""` to turn
      off the interpretation of comments altogether.

  `key`

  :   Character vector of one or more column names which is passed to
      [`setkey`](https://rdrr.io/pkg/data.table/man/setkey.html). Only
      valid when argument `data.table=TRUE`. Where applicable, this
      should refer to column names given in `col.names`.

  `index`

  :   Character vector or list of character vectors of one or more
      column names which is passed to
      [`setindexv`](https://rdrr.io/pkg/data.table/man/setkey.html). As
      with `key`, comma-separated notation like `index="x,y,z"` is
      accepted for convenience. Only valid when argument
      `data.table=TRUE`. Where applicable, this should refer to column
      names given in `col.names`.

  `showProgress`

  :   `TRUE` displays progress on the console if the ETA is greater than
      3 seconds. It is produced in fread's C code where the very nice
      (but R level) txtProgressBar and tkProgressBar are not easily
      available.

  `data.table`

  :   TRUE returns a `data.table`. FALSE returns a `data.frame`. The
      default for this argument can be changed with
      `options(datatable.fread.datatable=FALSE)`.

  `nThread`

  :   The number of threads to use. Experiment to see what works best
      for your data on your hardware.

  `logical01`

  :   If TRUE a column containing only 0s and 1s will be read as
      logical, otherwise as integer.

  `logicalYN`

  :   If TRUE a column containing only Ys and Ns will be read as
      logical, otherwise as character.

  `keepLeadingZeros`

  :   If TRUE a column containing numeric data with leading zeros will
      be read as character, otherwise leading zeros will be removed and
      converted to numeric.

  `yaml`

  :   If `TRUE`, `fread` will attempt to parse (using
      [`yaml.load`](https://yaml.r-lib.org/reference/yaml.load.html))
      the top of the input as YAML, and further to glean parameters
      relevant to improving the performance of `fread` on the data
      itself. The entire YAML section is returned as parsed into a
      `list` in the `yaml_metadata` attribute. See `Details`.

  `tmpdir`

  :   Directory to use as the `tmpdir` argument for any `tempfile`
      calls, e.g. when the input is a URL or a shell command. The
      default is [`tempdir()`](https://rdrr.io/r/base/tempfile.html)
      which can be controlled by setting `TMPDIR` before starting the R
      session; see
      [`base::tempdir`](https://rdrr.io/r/base/tempfile.html).

  `tz`

  :   Relevant to datetime values which have no Z or UTC-offset at the
      end, i.e. *unmarked* datetime, as written by
      [`utils::write.csv`](https://rdrr.io/r/utils/write.table.html).
      The default `tz="UTC"` reads unmarked datetime as UTC POSIXct
      efficiently. `tz=""` reads unmarked datetime as type character
      (slowly) so that `as.POSIXct` can interpret (slowly) the character
      datetimes in local timezone; e.g. by using `"POSIXct"` in
      `colClasses=`. Note that `fwrite()` by default writes datetime in
      UTC including the final Z and therefore `fwrite`'s output will be
      read by `fread` consistently and quickly without needing to use
      `tz=` or `colClasses=`. If the `TZ` environment variable is set to
      `"UTC"` (or `""` on non-Windows where unset vs `""` is
      significant) then the R session's timezone is already UTC and
      `tz=""` will result in unmarked datetimes being read as UTC
      POSIXct. For more information, please see the news items from
      v1.13.0 and v1.14.0.

## Value

a dataframe as created by
[`data.table::fread()`](https://rdrr.io/pkg/data.table/man/fread.html)
