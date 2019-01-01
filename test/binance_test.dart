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
}
