library binance;

export "http_classes.dart";
export "ws_classes.dart";

import "ws.dart";
import "http.dart";

class Binance {
  final BinanceWebsocket ws = BinanceWebsocket();
  final BinanceHttp rest = BinanceHttp();
}
