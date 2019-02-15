/// ## Binance
///
/// Binance has excellent documentation on their Websocket and REST APIs. We convert all endpoint
/// JSON objects into Dart classes for easy consumption.
///
/// Websockets
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md
///
/// REST
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md
///

library binance;

export 'data/rest_classes.dart';
export 'data/ws_classes.dart';
export 'data/enums.dart';

import 'src/websocket.dart';
import 'src/rest.dart';

class Binance with BinanceWebsocket, BinanceRest {}
