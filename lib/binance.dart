library binance;

export 'data/rest_classes.dart';
export 'data/ws_classes.dart';
export 'data/enums.dart';

import 'src/websocket.dart';
import 'src/rest.dart';

class Binance with BinanceWebsocket, BinanceRest {}
