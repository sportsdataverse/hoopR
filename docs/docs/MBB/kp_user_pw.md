---
title: kp_user_pw
sidebar_label: kp_user_pw
---
# `kp_user_pw`

KenPom Login and Password credentials


## Description

Save your KenPom login e-mail and password as the system environment variables `KP_USER` and `KP_PW` 
 
 Requires a subscription to KenPom.com


## Usage

```r
login(user_email = Sys.getenv("KP_USER"), user_pw = Sys.getenv("KP_PW"))
kp_user_email()
kp_password()
has_kp_user_and_pw()
```


## Arguments

Argument      |Description
------------- |----------------
`user_email`     |     User subscription e-mail
`user_pw`     |     User subscription password


## Details

list("Using your KenPom subscription with the package:")  list() 
 
 Run [`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html) and THEN paste the following in the new script that pops up (without quotations)
 ```r
 KP_USER = YOUR-EMAIL@DOMAIN.COM
 KP_PW = XXX-YOUR-PASSWORD-XXX
```

 You can save the login information for consistent usage by adding
 ```r
 KP_USER = YOUR-EMAIL@DOMAIN.COM`
 KP_PW = XXX-YOUR-PASSWORD-XXX
 ```
 to your .REnviron file (easily accessed via [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html)).
 For less consistent usage:
 At the beginning of every session or within an R environment, save your login e-mail and password as the environment variables `KP_USER` and `KP_PW` (with quotations) using a command like the following.
 ```{r}
 Sys.setenv(KP_USER = YOUR-EMAIL@DOMAIN.COM)
 Sys.setenv(KP_PW = XXX-YOUR-PASSWORD-XXX)
```


