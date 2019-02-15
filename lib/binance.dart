library binance;

export "data/rest_classes.dart";
export "data/ws_classes.dart";
export "data/enums.dart";

import "websocket.dart";
import "rest.dart";

class Binance with BinanceWebsocket, BinanceRest {}
