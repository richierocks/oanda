#' Get pricing
#'
#' Call the OANDA pricing API to retrieve prices of currency pairs.
#'
#' @param base_currency A 3 letter ISO 4217 currency name.
#' @param quote_currency A 3 letter ISO 4217 currency name.
#' @param since A time in the past, or \code{NULL} for now.
#' @return A \code{data_frame} with one row per currency pair.
#' @references \url{http://developer.oanda.com/rest-live-v20/pricing-ep/#CurrentPrices}
#' @examples
#' \donttest{
#' ## Marked as don't test because an access token is needed
#'   (currencies <- pricing(c("EUR", "GBP"), "USD"))
#' }
#' @importFrom purrr map_df
#' @export
pricing <- function(base_currency, quote_currency, since = Sys.time() - 3600,
  account_id = Sys.getenv("OANDA_ACCOUNT_ID", NA),
  access_token = Sys.getenv("OANDA_ACCESS_TOKEN", NA)) {
  instruments <- create_instrument_name(base_currency, quote_currency)
  since <- format_date(since)
  results <- call_oanda_api(
    "pricing", account_id, access_token,
    instruments = instruments, since = since
  )
  map_df(results$prices, price_to_df_row)
}

#' @importFrom tibble data_frame
#' @importFrom magrittr %$%
#' @importFrom purrr map_chr
price_to_df_row <- function(prc) {
  bids <- data_frame(
    price = map_chr(prc$bids, function(bid) bid$price),
    liquidity = map_chr(prc$bids, function(bid) bid$liquidity)
  )
  asks <- data_frame(
    price = map_chr(prc$asks, function(bid) bid$price),
    liquidity = map_chr(prc$asks, function(bid) bid$liquidity)
  )
  prc %$%
    data_frame(
      type = type,
      time = parse_time(time),
      bids = bids,
      asks = asks,
      closeout_bid = closeoutBid,
      closeout_ask = closeoutAsk,
      status = status,
      tradeable = tradeable,
      instrument = instrument,
      units_available_default_long = unitsAvailable$default$long,
      units_available_default_short = unitsAvailable$default$short,
      units_available_open_only_long = unitsAvailable$openOnly$long,
      units_available_open_only_short = unitsAvailable$openOnly$short,
      units_available_reduce_first_long = unitsAvailable$reduceFirst$long,
      units_available_reduce_first_short = unitsAvailable$reduceFirst$short,
      units_available_reduce_only_long = unitsAvailable$reduceOnly$long,
      units_available_reduce_only_short = unitsAvailable$reduceOnly$short
    )
}
