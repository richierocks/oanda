<!-- README.md is generated from README.Rmd. Please edit that file -->
OANDA
=====

This R package provides access to the [OANDA API, version 3](http://developer.oanda.com/rest-live-v20/introduction).

Setup and installation
======================

Installing the R package
------------------------

To install the package, you first need *remotes* installed.

``` r
install.packages("remotes")
```

``` r
remotes::install_github("richierocks/oanda")
```

Getting an OANDA account and API access token
---------------------------------------------

To use the API, you must first register with OANDA. Follow the instructions on the [developer page](http://developer.oanda.com/rest-live-v20/introduction). It takes about 5 to 10 mins of pointing and clicking to register. If you aren't sure what account type you want, then choose the free demo account.

Once you have registered, log in and go to the [trading dashboard](https://trade.oanda.com). Your account number is written in the top left of the screen, and looks like `100-001-1234567-001`. Make a note of this number.

Navigate to the [Manage API Access](https://www.oanda.com/demo-account/tpa/personal_token) page (also avilable via "My Account"). Generate a personal access token, and make a note of it. It takes the form `123456789abcdef0-123456789abcdef0`.

To store the account ID and access token for the current R session, type

``` r
Sys.setenv(
  OANDA_ACCOUNT_ID = "your account id",
  OANDA_ACCESS_TOKEN = "your access token"
)
```

Alternatively, use your operating system tools to set these environment variable to store it permanently.

Usage
-----

Currently only the pricing API, for getting currency exchange prices is supported.

``` r
library(oanda)
(prices <- pricing(c("EUR", "GBP"), "USD"))
#> # A tibble: 2 x 17
#>   type  time                bids   asks   closeout_bid closeout_ask status
#>   <chr> <dttm>              <list> <list> <chr>        <chr>        <chr> 
#> 1 PRICE 2018-04-09 16:26:01 <list… <list… 1.23159      1.23202      trade…
#> 2 PRICE 2018-04-09 16:26:00 <list… <list… 1.41308      1.41377      trade…
#> # ... with 10 more variables: tradeable <lgl>, instrument <chr>,
#> #   units_available_default_long <chr>,
#> #   units_available_default_short <chr>,
#> #   units_available_open_only_long <chr>,
#> #   units_available_open_only_short <chr>,
#> #   units_available_reduce_first_long <chr>,
#> #   units_available_reduce_first_short <chr>,
#> #   units_available_reduce_only_long <chr>,
#> #   units_available_reduce_only_short <chr>
```
