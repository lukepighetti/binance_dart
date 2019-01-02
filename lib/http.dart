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

  /// Return true if the server is available with /v1/ping
  Future<bool> ping() => _public('/v1/ping').then((r) => true);

  /// Return the current server time from /v1/time
  Future<DateTime> time() => _public('/v1/time')
      .then((r) => DateTime.fromMillisecondsSinceEpoch(r["serverTime"]));

  /// Returns general info about the exchange from /v1/exchangeInfo
  Future<ExchangeInfoResponse> exchangeInfo() =>
      _public('/v1/exchangeInfo').then((r) => ExchangeInfoResponse.fromMap(r));

  /// Order book depth from /v1/depth
  Future<DepthResponse> depth(String symbol, [int limit = 100]) =>
      _public('/v1/depth', {"symbol": "$symbol", "limit": "$limit"})
          .then((r) => DepthResponse.fromMap(r));

  /// Recent trades from /v1/trades
  Future<List<RecentTrade>> recentTrades(String symbol, [int limit = 500]) =>
      _public('/v1/trades', {"symbol": "$symbol", "limit": "$limit"}).then(
          (r) => List<RecentTrade>.from(r.map((m) => RecentTrade.fromMap(m))));

  /// Historical trades from /v1/aggTrades
  /// Authenticated endpoint

  /// Aggregated trades
  Future<List<AggregatedTrade>> aggregatedTrades(
    String symbol, {
    int fromId,
    DateTime startTime,
    DateTime endTime,
    int limit = 500,
  }) async {
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

  /// Kline/Candlestick data from /v1/klines
  ///
  /// Acceptable intervals are
  /// 1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 1M

  Future<List<Candlestick>> candlesticks(
    String symbol,
    String interval, {
    DateTime startTime,
    DateTime endTime,
    int limit = 500,
  }) async {
    final params = {
      "symbol": "$symbol",
      "interval": "$interval",
      "limit": "$limit",
    };

    if (startTime != null)
      params["startTime"] = startTime.millisecondsSinceEpoch.toString();
    if (endTime != null)
      params["endTime"] = endTime.millisecondsSinceEpoch.toString();

    final response = await _public('/v1/klines', params);

    return List<Candlestick>.from(
      response.map((c) => Candlestick.fromList(c)),
    );
  }

  /// Current average price from /v3/avgPrice
  Future<AveragePrice> averagePrice(String symbol) =>
      _public("/v3/avgPrice", {"symbol": symbol})
          .then((r) => AveragePrice.fromMap(r));

  /// 24 hour ticker price change statistics
  Future<DailyStats> dailyStats(String symbol) async {
    assert(symbol != null);
    final response = await _public("/v1/ticker/24hr", {"symbol": symbol});

    return DailyStats.fromMap(response);
  }

  /// WARNING: this is VERY expensive and may cause rate limiting
  ///
  /// 24 hour ticker price change statistics for all coins
  Future<List<DailyStats>> allDailyStats() async {
    final response = await _public("/v1/ticker/24hr");

    return List<DailyStats>.from(response.map((s) => DailyStats.fromMap(s)));
  }

  /// Price ticker from /v3/ticker/price
  Future<PriceTicker> symbolPriceTicker(String symbol) async {
    assert(symbol != null);

    final response = await _public("/v3/ticker/price", {"symbol": symbol});

    return PriceTicker.fromMap(response);
  }

  Future<List<PriceTicker>> allSymbolPriceTickers() async {
    final response = await _public("/v3/ticker/price");

    return List<PriceTicker>.from(response.map((s) => PriceTicker.fromMap(s)));
  }
}
