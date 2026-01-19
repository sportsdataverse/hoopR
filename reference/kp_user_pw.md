# **KenPom Login and Password credentials**

Save your KenPom login e-mail and password as the system environment
variables `KP_USER` and `KP_PW`

Requires a subscription to KenPom.com

## Usage

``` r
login(user_email = Sys.getenv("KP_USER"), user_pw = Sys.getenv("KP_PW"))

kp_user_email()

kp_password()

has_kp_user_and_pw()
```

## Arguments

- user_email:

  User subscription e-mail

- user_pw:

  User subscription password

## Details

**Using your KenPom subscription with the package:**  

Run
[**[`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html)**](https://usethis.r-lib.org/reference/edit.html)
and THEN paste the following in the new script that pops up (with**out**
quotations)  

    KP_USER = YOUR-EMAIL@DOMAIN.COM
    KP_PW = XXX-YOUR-PASSWORD-XXX

You can save the login information for consistent usage by adding  

    KP_USER = YOUR-EMAIL@DOMAIN.COM
    KP_PW = XXX-YOUR-PASSWORD-XXX
    ``` \cr
    to your .REnviron file (easily accessed via [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html)).\cr
    \cr

    For less consistent usage:\cr
    At the beginning of every session or within an R environment, save your login e-mail and password as the environment variables `KP_USER` and `KP_PW` (with quotations) using a command like the following.\cr
    ```{r}
    Sys.setenv(KP_USER = "YOUR-EMAIL@DOMAIN.COM")
    Sys.setenv(KP_PW = "XXX-YOUR-PASSWORD-XXX")
