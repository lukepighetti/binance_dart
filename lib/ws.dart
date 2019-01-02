import "dart:convert" as convert;

import 'package:web_socket_channel/io.dart';

import 'ws_classes.dart';

class BinanceWebsocket {
  IOWebSocketChannel _public(String channel) => IOWebSocketChannel.connect(
        "wss://stream.binance.com:9443/ws/${channel}",
        pingInterval: Duration(minutes: 1),
      );

  Map _toMap(json) => convert.jsonDecode(json);

  Future<Stream<WSAggTrade>> aggTrade(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@aggTrade");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSAggTrade>((e) => WSAggTrade.fromMap(e));
  }
}
