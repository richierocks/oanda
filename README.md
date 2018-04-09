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

Navigate to "My Account" -&gt; "Manage API Access" (in the left-hand menu of you account page). Generate a personal access token, and make a note of it. It takes the form `123456789abcdef0-123456789abcdef0`.

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
(prices <- pricing(c("EUR", "GBP"), "USD"))
```
