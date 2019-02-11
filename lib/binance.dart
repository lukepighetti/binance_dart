library binance;

import "ws.dart";
import "http.dart";

class Binance {
  final BinanceWebsocket ws = BinanceWebsocket();
  final BinanceHttp rest = BinanceHttp();
}
