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
}
