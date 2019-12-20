class BinanceApiException implements Exception {
  BinanceApiException(this.message, this.code);

  final int code;
  final String message;

  @override
  String toString() =>
      "The Binance api returned an error: $message : code $code";
}
