import 'rest_classes.dart';
export 'rest_classes.dart' show BookDepth;

abstract class WebsocketBase {
  String get eventType;
  DateTime get eventTime;
  String get symbol;
}

/// Represents data provided by <symbol>@aggTrade
class WebsocketAggregatedTrade implements AggregatedTrade, WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final int id;
  final double price;
  final double qty;

  final int firstTradeId;
  final int lastTradeId;

  final DateTime time;
  final bool isBuyerMaker;
  final bool isBestMatch;

  WebsocketAggregatedTrade.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.id = m['a'],
        this.price = double.parse(m['p']),
        this.qty = double.parse(m['q']),
        this.firstTradeId = m['f'],
        this.lastTradeId = m['l'],
        this.time = DateTime.fromMillisecondsSinceEpoch(m['T']),
        this.isBuyerMaker = m['m'],
        this.isBestMatch = m['M'];
}

/// Represents data provided by <symbol>@miniTicker and !miniTicker@arr
class WebsocketMiniTicker implements WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final double close;
  final double open;
  final double high;
  final double low;
  final double volume;
  final double quoteVolume;

  WebsocketMiniTicker.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.close = double.parse(m['c']),
        this.open = double.parse(m['o']),
        this.high = double.parse(m['h']),
        this.low = double.parse(m['l']),
        this.volume = double.parse(m['v']),
        this.quoteVolume = double.parse(m['q']);
}

/// Represents data provided by <symbol>@ticker and !ticker@arr
class WebsocketTicker implements WebsocketMiniTicker {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final double priceChange;
  final double percentChange;
  final double averagePrice;
  final double initialPrice;
  final double lastPrice;
  final double lastQty;
  final double bestBid;
  final double bestBidQty;
  final double bestAsk;
  final double bestAskQty;

  final double open;
  final double high;
  final double low;
  final double volume;
  final double quoteVolume;

  final DateTime openTime;
  final DateTime closeTime;

  final int firstTradeId;
  final int lastTradeId;
  final int tradesCount;

  double get close => lastPrice; // extra from WSMiniTicker

  WebsocketTicker.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.priceChange = double.parse(m['p']),
        this.percentChange = double.parse(m['P']),
        this.averagePrice = double.parse(m['w']),
        this.initialPrice = double.parse(m['x']),
        this.lastPrice = double.parse(m['c']),
        this.lastQty = double.parse(m['Q']),
        this.bestBid = double.parse(m['b']),
        this.bestBidQty = double.parse(m['B']),
        this.bestAsk = double.parse(m['a']),
        this.bestAskQty = double.parse(m['A']),
        this.open = double.parse(m['o']),
        this.high = double.parse(m['h']),
        this.low = double.parse(m['l']),
        this.volume = double.parse(m['v']),
        this.quoteVolume = double.parse(m['q']),
        this.openTime = DateTime.fromMillisecondsSinceEpoch(m['O']),
        this.closeTime = DateTime.fromMillisecondsSinceEpoch(m['C']),
        this.firstTradeId = m['F'],
        this.lastTradeId = m['L'],
        this.tradesCount = m['n'];
}

class DiffBookDepth implements BookDepth, WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final int firstUpdateId;
  final int lastUpdateId;

  final List<BookDepthPoint> bids;
  final List<BookDepthPoint> asks;

  DiffBookDepth.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.firstUpdateId = m["U"],
        this.lastUpdateId = m["u"],
        this.bids = List<BookDepthPoint>.from(
            m["b"].map((b) => BookDepthPoint.fromList(b))),
        this.asks = List<BookDepthPoint>.from(
            m["a"].map((b) => BookDepthPoint.fromList(b)));
}
