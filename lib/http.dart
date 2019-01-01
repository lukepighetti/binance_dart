import "package:http/http.dart" as http;
import "dart:convert" as convert;

import "http_classes.dart";

const BASE = 'https://api.binance.com';

class BinanceHttp {
  final String key;

  BinanceHttp([this.key]);

  Future<dynamic> _public(String path, [Map<String, String> params]) async {
    final uri = Uri.https("api.binance.com", "/api/$path", params);
    final response = await http.get(uri);

    return convert.jsonDecode(response.body);
  }

  /// Return true if the server is available
  Future<bool> ping() => _public('/v1/ping').then((r) => true);

  /// Return the current server time
  Future<DateTime> time() => _public('/v1/time')
      .then((r) => DateTime.fromMillisecondsSinceEpoch(r["serverTime"]));

  /// Returns general info about the exchange
  Future<ExchangeInfoResponse> exchangeInfo() =>
      _public('/v1/exchangeInfo').then((r) => ExchangeInfoResponse.fromMap(r));

  /// Order book depth
  Future<DepthResponse> depth(String symbol, [int limit = 100]) =>
      _public('/v1/depth', {"symbol": "$symbol", "limit": "$limit"})
          .then((r) => DepthResponse.fromMap(r));

  /// Recent trades
  Future<List<RecentTrade>> recentTrades(String symbol, [int limit = 500]) =>
      _public('/v1/trades', {"symbol": "$symbol", "limit": "$limit"}).then(
          (r) => List<RecentTrade>.from(r.map((m) => RecentTrade.fromMap(m))));

  /// Historical trades
  /// Authenticated endpoint

  /// Aggregated trades
  Future<List<AggregatedTrade>> aggregatedTrades(
    String symbol, {
    int fromId,
    DateTime startTime,
    DateTime endTime,
    int limit = 500,
  }) async {
    assert(limit <= 1000);

    final params = {"symbol": "$symbol"};

    if (fromId != null) params["fromId"] = "$fromId";
    if (startTime != null)
      params["startTime"] = "${startTime?.millisecondsSinceEpoch}";
    if (endTime != null)
      params["endTime"] = "${endTime?.millisecondsSinceEpoch}";
    if (limit != null) params["limit"] = "$limit";

    final response = await _public('/v1/aggTrades', params);

    return List<AggregatedTrade>.from(
      response.map((t) => AggregatedTrade.fromMap(t)),
    );
  }
}
