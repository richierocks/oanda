format_date <- function(x) {
  #strftime(x, "%Y-%m-%dT%H:%M:%OS6%Z")
  formatC(as.numeric(as.POSIXct(x)), digits = 9, format = "f")
}

parse_time <- function(x) {
  as.POSIXct(as.numeric(x), origin = "1970-01-01", tz = "UTC")
}

create_instrument_name <- function(base_currency, quote_currency) {
  base_currency <- match.arg(base_currency, OANDA_CURRENCIES, several.ok = TRUE)
  quote_currency <- match.arg(quote_currency, OANDA_CURRENCIES, several.ok = TRUE)
  toupper(paste(base_currency, quote_currency, sep = "_", collapse = ","))
}

#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom httr stop_for_status
#' @importFrom httr content
call_oanda_api <- function(endpoint, account_id, access_token, ...) {
  # query <- list(instruments = "EUR_USD", since = format_date(Sys.Date() - 7))
  query <- list(...)
  response <- GET(
    paste0(
      "https://api-fxpractice.oanda.com/v3/accounts/",
      account_id, "/", endpoint
    ),
    config = add_headers(
      Authorization = paste("bearer", access_token),
      "Accept-Datetime-Format" = "UNIX"
    ),
    query = query
  )
  stop_for_status(response)
  content(response, as = "parsed")
}
