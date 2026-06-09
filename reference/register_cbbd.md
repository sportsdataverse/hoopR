# **College Basketball Data API Key Registration**

Save your CollegeBasketballData API key as the system environment
variable `CBBD_API_KEY`.

## Usage

``` r
cbbd_key()

has_cbbd_key()

check_cbbd_key()
```

## Value

`cbbd_key()` - Returns the `CBBD_API_KEY` environment variable, or
`NA_character_` if it is unset.

`has_cbbd_key()` - Returns a logical: `TRUE` if a key is stored, `FALSE`
otherwise.

`check_cbbd_key()` - Called for its side effect; errors if no key is
stored in the environment.

## Details

The `cbbd_*()` functions wrap the [CollegeBasketballData
API](https://api.collegebasketballdata.com), the men's college
basketball sibling of CollegeFootballData. The API requires a free API
key (Bearer token). Request one at
<https://collegebasketballdata.com/key>.  
  
**Using the key:**  
Save the key for consistent usage by adding
`CBBD_API_KEY=XXXX-YOUR-API-KEY-HERE-XXXXX` to your `.Renviron` file
(easily accessed via
[**[`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)**](https://usethis.r-lib.org/reference/edit.html)).
Run
[**[`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)**](https://usethis.r-lib.org/reference/edit.html),
a new script will pop open named `.Renviron`, **THEN** paste the
following in the new script that pops up (with**out** quotations)

    CBBD_API_KEY = XXXX-YOUR-API-KEY-HERE-XXXXX

Save the script and restart your R session. If set correctly, from then
on you should be able to use any of the `cbbd_*()` functions without any
other changes.

**For less consistent usage:**  
At the beginning of every session or within an R environment, save your
API key as the environment variable `CBBD_API_KEY` (**with** quotations)
using a command like the following.

    Sys.setenv(CBBD_API_KEY = "XXXX-YOUR-API-KEY-HERE-XXXXX")
