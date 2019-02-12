library binance;

export "data/rest_classes.dart";
export "data/ws_classes.dart";

import "ws.dart";
import "rest.dart";

class Binance {
  final BinanceWebsocket ws = BinanceWebsocket();
  final BinanceRest rest = BinanceRest();
}
