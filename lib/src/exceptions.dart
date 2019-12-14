class BinanceApiException implements Exception {
  BinanceApiException(this.message, this.code);

  final int code;
  final String message;

  @override
  String toString() {
    var msg = "\n\n-----------------------------------------------\n";
    msg += "Api result error: $message : code $code   \n";
    msg += "-----------------------------------------------\n";
    return msg;
  }
}
