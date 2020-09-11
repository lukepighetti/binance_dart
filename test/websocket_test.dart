import 'package:test/test.dart';

import 'package:binance/binance.dart';

void main() {
  final websocket = Binance();

  test('aggTrade', () async {
    final stream = await websocket.aggTrade('BTCUSDT');

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals('aggTrade'));
      expect(e.eventTime, isNotNull);
      expect(e.id, isNotNull);
    }));
  });

  test('kline', () async {
    final stream = await websocket.kline('BTCUSDT', '5m');

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals('kline'));
      expect(e.eventTime, isNotNull);
      expect(e.open, isNotNull);
    }));
  });

  test('miniTicker', () async {
    final stream = await websocket.miniTicker('BTCUSDT');

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals('24hrMiniTicker'));
      expect(e.eventTime, isNotNull);
      expect(e.close, isNotNull);
    }));
  });

  test('allMiniTickers', () async {
    final stream = await websocket.allMiniTickers();

    stream.first.then(expectAsync1((e) {
      expect(e.first.eventType, equals('24hrMiniTicker'));
      expect(e.first.eventTime, isNotNull);
      expect(e.first.close, isNotNull);
    }));
  });

  test('ticker', () async {
    final stream = await websocket.ticker('BTCUSDT');

    stream.first.then(expectAsync1((e) {
      expect(e.eventType, equals('24hrTicker'));
      expect(e.eventTime, isNotNull);
      expect(e.close, isNotNull);
    }));
  });

  test('allTickers', () async {
    final stream = await websocket.allTickers();

    stream.first.then(expectAsync1((e) {
      expect(e.first.eventType, equals('24hrTicker'));
      expect(e.first.eventTime, isNotNull);
      expect(e.first.close, isNotNull);
    }));
  });

  test('allBookTicker', () async {
    final stream = await websocket.allBookTicker();

    stream.first.then(expectAsync1((e) {
      expect(e.updateID, isNotNull);
      expect(e.askPrice, isNotNull);
      expect(e.bidQty, isNotNull);
    }));
  }, skip: 'Flakey test, works in practice');

  test('bookDepth', () async {
    final stream = await websocket.bookDepth('BTCUSDT', 5);

    stream.first.then(expectAsync1((e) {
      expect(e.lastUpdateId, isNotNull);
      expect(e.bids.length, equals(5));
      expect(e.asks.length, equals(5));

      expect(e.bids.first.price, isNotNull);
      expect(e.bids.first.qty, isNotNull);
    }));
  });

  test('diffBookDepth', () async {
    final stream = await websocket.diffBookDepth('BTCUSDT');

    stream.first.then(expectAsync1((e) {
      expect(e.lastUpdateId, isNotNull);
      expect(e.bids.first.price, isNotNull);
      expect(e.bids.first.qty, isNotNull);
    }));
  });
}
