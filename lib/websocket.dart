import "dart:convert" as convert;

import 'package:web_socket_channel/io.dart';

import 'data/ws_classes.dart';

class BinanceWebsocket {
  IOWebSocketChannel _public(String channel) => IOWebSocketChannel.connect(
        "wss://stream.binance.com:9443/ws/${channel}",
        pingInterval: Duration(minutes: 1),
      );

  Map _toMap(json) => convert.jsonDecode(json);
  List<Map> _toList(json) => List<Map>.from(convert.jsonDecode(json));

  /// Reports aggregated trade events from <symbol>@aggTrade
  Stream<WsAggregatedTrade> aggTrade(String symbol) {
    final channel = _public("${symbol.toLowerCase()}@aggTrade");

    return channel.stream
        .map<Map>(_toMap)
        .map<WsAggregatedTrade>((e) => WsAggregatedTrade.fromMap(e));
  }

  /// Reports 24hr miniTicker events every second from <symbol>@miniTicker
  Stream<MiniTicker> miniTicker(String symbol) {
    final channel = _public("${symbol.toLowerCase()}@miniTicker");

    return channel.stream
        .map<Map>(_toMap)
        .map<MiniTicker>((e) => MiniTicker.fromMap(e));
  }

  /// Reports 24hr miniTicker events every second for every trading pair
  /// that changed in the last second
  Stream<List<MiniTicker>> allMiniTickers() {
    final channel = _public("!miniTicker@arr");

    return channel.stream.map<List<Map>>(_toList).map<List<MiniTicker>>(
        (ev) => ev.map((m) => MiniTicker.fromMap(m)).toList());
  }

  /// Reports 24hr ticker events every second from <symbol>@ticker
  Stream<Ticker> ticker(String symbol) {
    final channel = _public("${symbol.toLowerCase()}@ticker");

    return channel.stream
        .map<Map>(_toMap)
        .map<Ticker>((e) => Ticker.fromMap(e));
  }

  /// Reports 24hr miniTicker events every second for every trading pair
  /// that changed in the last second
  Stream<List<Ticker>> allTickers() {
    final channel = _public("!ticker@arr");

    return channel.stream
        .map<List<Map>>(_toList)
        .map<List<Ticker>>((ev) => ev.map((m) => Ticker.fromMap(m)).toList());
  }

  /// Reports book depth
  ///
  /// Levels can be 5, 10, or 20
  Stream<BookDepth> bookDepth(String symbol, [int levels = 5]) {
    assert(levels == 5 || levels == 10 || levels == 20);

    final channel = _public("${symbol.toLowerCase()}@depth$levels");

    return channel.stream
        .map<Map>(_toMap)
        .map<BookDepth>((m) => BookDepth.fromMap(m));
  }

  /// Difference book depth
  ///
  /// This can be used to update an existing book with incremental changes
  Stream<DiffBookDepth> diffBookDepth(String symbol) {
    final channel = _public("${symbol.toLowerCase()}@depth");

    return channel.stream
        .map<Map>(_toMap)
        .map<DiffBookDepth>((m) => DiffBookDepth.fromMap(m));
  }
}
