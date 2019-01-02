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

  /// Reports 24hr miniTicker events every second from <symbol>@miniTicker
  Future<Stream<WSMiniTicker>> miniTicker(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@miniTicker");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSMiniTicker>((e) => WSMiniTicker.fromMap(e));
  }

  /// Reports 24hr miniTicker events every second for every trading pair
  /// that changed in the last second
  Future<Stream<List<WSMiniTicker>>> allMiniTickers() async {
    final channel = _public("!miniTicker@arr");

    return channel.stream.map<List<Map>>(_toList).map<List<WSMiniTicker>>(
        (ev) => ev.map((m) => WSMiniTicker.fromMap(m)).toList());
  }

  /// Reports 24hr ticker events every second from <symbol>@ticker
  Future<Stream<WSTicker>> ticker(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@ticker");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSTicker>((e) => WSTicker.fromMap(e));
  }

  /// Reports 24hr miniTicker events every second for every trading pair
  /// that changed in the last second
  Future<Stream<List<WSTicker>>> allTickers() async {
    final channel = _public("!ticker@arr");

    return channel.stream.map<List<Map>>(_toList).map<List<WSTicker>>(
        (ev) => ev.map((m) => WSTicker.fromMap(m)).toList());
  }

  /// Reports book depth
  ///
  /// Levels can be 5, 10, or 20
  Future<Stream<BookDepth>> bookDepth(String symbol, [int levels = 5]) async {
    assert(levels == 5 || levels == 10 || levels == 20);

    final channel = _public("${symbol.toLowerCase()}@depth$levels");

    return channel.stream
        .map<Map>(_toMap)
        .map<BookDepth>((m) => BookDepth.fromMap(m));
  }

  /// Difference book depth
  ///
  /// This can be used to update an existing book with incremental changes
  Future<Stream<WSDiffBookDepth>> diffBookDepth(String symbol) async {
    final channel = _public("${symbol.toLowerCase()}@depth");

    return channel.stream
        .map<Map>(_toMap)
        .map<WSDiffBookDepth>((m) => WSDiffBookDepth.fromMap(m));
  }
}
