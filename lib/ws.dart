import "dart:convert" as convert;

import 'package:web_socket_channel/io.dart';

import 'ws_classes.dart';

class BinanceWebsocket {
  IOWebSocketChannel _public(String channel) => IOWebSocketChannel.connect(
        "wss://stream.binance.com:9443/ws/${channel}",
        pingInterval: Duration(minutes: 1),
      );

  Map _toMap(json) => convert.jsonDecode(json);
  List<Map> _toList(json) => List<Map>.from(convert.jsonDecode(json));

  /// Reports aggregated trade events from <symbol>@aggTrade
  Future<Stream<WSAggTrade>> aggTrade(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@aggTrade");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSAggTrade>((e) => WSAggTrade.fromMap(e));
  }

  /// Reports 24hr ticker events every second from <symbol>@miniTicker
  Future<Stream<WSMiniTicker>> miniTicker(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@miniTicker");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSMiniTicker>((e) => WSMiniTicker.fromMap(e));
  }

  /// Reports 24hr ticker events every second for every trading pair
  /// that changed in the last second
  Future<Stream<List<WSMiniTicker>>> allMiniTickers() async {
    final channel = _public("!miniTicker@arr");

    return channel.stream.map<List<Map>>(_toList).map<List<WSMiniTicker>>(
        (ev) => ev.map((m) => WSMiniTicker.fromMap(m)).toList());
  }
}
