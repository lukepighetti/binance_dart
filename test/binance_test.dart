import "package:test/test.dart";

import 'package:binance/http.dart';

void main() {
  final http = BinanceHttp();
  test("ping", () async {
    final result = await http.ping();
    expect(result, equals(true));
  });

  test("time", () async {
    final serverTime = await http.time();
    final now = DateTime.now();
    final tolerance = Duration(minutes: 1);

    expect(serverTime.difference(now), lessThan(tolerance));
  });

  test("exchangeInfo", () async {
    final result = await http.exchangeInfo();

    final serverTime = result.serverTime;
    final now = DateTime.now();
    final tolerance = Duration(minutes: 1);

    expect(serverTime.difference(now), lessThan(tolerance));

    expect(result.symbols.length, greaterThan(100));
  });

  test("depth", () async {
    final result = await http.depth("BTCUSDT", 100);

    expect(result.lastUpdateId, isNotNull);
    expect(result.bids.length, equals(100));
    expect(result.asks.length, equals(100));
  });

  test("recentTrades", () async {
    final result = await http.recentTrades("BTCUSDT", 100);

    expect(result.length, equals(100));
    expect(result.first.id, isNotNull);
    expect(result.first.isBestMatch, isNotNull);
    expect(result.first.isBuyerMaker, isNotNull);
    expect(result.first.price, isNotNull);
    expect(result.first.qty, isNotNull);
    expect(result.first.time, isNotNull);
  });

  test("aggregatedTrades", () async {
    final result = await http.aggregatedTrades(
      "BTCUSDT",
      limit: 100,
      startTime: DateTime.now().subtract(Duration(minutes: 10)),
      endTime: DateTime.now(),
    );

    expect(result.length, equals(100));
    expect(result.first.id, isNotNull);
    expect(result.first.isBestMatch, isNotNull);
    expect(result.first.isBuyerMaker, isNotNull);
    expect(result.first.price, isNotNull);
    expect(result.first.qty, isNotNull);
    expect(result.first.time, isNotNull);
  });

  test("candlesticks", () async {
    final result = await http.candlesticks(
      "BTCUSDT",
      "1m",
      limit: 100,
    );

    expect(result.length, equals(100));
    expect(result.first.open, isNotNull);
    expect(result.first.high, isNotNull);
    expect(result.first.low, isNotNull);
    expect(result.first.close, isNotNull);
  });

  test("averagePrice", () async {
    final result = await http.averagePrice("BTCUSDT");

    expect(result.mins, isNotNull);
    expect(result.price, isNotNull);
  });

  test("dailyStats", () async {
    final result = await http.dailyStats("BTCUSDT");

    expect(result.symbol, equals("BTCUSDT"));
    expect(result.lastPrice, isNotNull);
  });

  test("allDailyStats", () async {
    final result = await http.allDailyStats();

    expect(result.length, greaterThan(100));
    expect(result.first.symbol, isNotNull);
    expect(result.first.lastPrice, isNotNull);
  });
}
