import "package:test/test.dart";

import 'package:binance/ws.dart';

void main() {
  final websocket = BinanceWebsocket();
  test("aggTrade", () async {
    final stream = await websocket.aggTrade("BTCUSDT");

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals("aggTrade"));
      expect(e.eventTime, isNotNull);
      expect(e.id, isNotNull);
    }));
  });

  test("miniTicker", () async {
    final stream = await websocket.miniTicker("BTCUSDT");

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals("24hrMiniTicker"));
      expect(e.eventTime, isNotNull);
      expect(e.close, isNotNull);
    }));
  });

  test("allMiniTickers", () async {
    final stream = await websocket.allMiniTickers();

    stream.first.then(expectAsync1((e) {
      expect(e.first.eventType, equals("24hrMiniTicker"));
      expect(e.first.eventTime, isNotNull);
      expect(e.first.close, isNotNull);
    }));
  });

  test("ticker", () async {
    final stream = await websocket.ticker("BTCUSDT");

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals("24hrTicker"));
      expect(e.eventTime, isNotNull);
      expect(e.close, isNotNull);
    }));
  });

  test("allTickers", () async {
    final stream = await websocket.allTickers();

    stream.first.then(expectAsync1((e) {
      expect(e.first.eventType, equals("24hrTicker"));
      expect(e.first.eventTime, isNotNull);
      expect(e.first.close, isNotNull);
    }));
  });
}
